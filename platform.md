# The itcoder platform

What itcoder is, how it is built, and the decisions that must not be undone
without Chris. Current state only - history is in git.

## What it is

**itcoder.co.za** - short, self-marking online courses by Chris Noome, IT
teacher at De La Salle Holy Cross College, Johannesburg. Built for his classes,
open to outside subscribers.

- Site shape: **subject -> course -> lesson.** `SubjectIndex()` in
  `lib/course.php` (General Computing, Information Technology, Computer
  Applications Technology, Mathematics, Maths Literacy, Physical Science).
- Courses (`CourseIndex()`): `ai` (Grade 9 AI, 8 lessons, open -
  [courses/ai-course.md](courses/ai-course.md)); `pascal` (IEB IT Grades
  10-12, open, live compiling - [courses/pascal-course.md](courses/pascal-course.md));
  others listed as `soon`.
- Course status: `open` (catalogue), `draft` (teacher preview), `soon` (listed,
  no content, no Join, `RequireEnrolment()` refuses). `ActiveCourses()` = all
  but `soon`; class results, admin and checkers use it.
- One codebase: `Projects/AIPascalCourse`, live at `/var/www/itcoder`. v1
  (`Projects/AIWebCourse/itcoder`) is not deployed; it is only source material
  for the AI course.

## Who it's for

- Say **pupils**, never "learners". Pupils are minors - it shapes every privacy
  rule below.
- All work happens in class, no homework: 40-minute periods, ~30 minutes of
  work. Scope every lesson to that.
- Grade 9 AI: 90 pupils in three classes, at most 30 online at once; every pupil
  has a machine and YouTube. No local AI on pupil machines - demos run on
  Chris's laptop (i9, 64 GB, RTX 3080 Ti 16 GB) through the projector.

## Stack

PHP 8.3 + SQLite. **No framework, no build step, no package manager** - one
small VPS, deployed by uploading folders, readable by anyone. Don't "modernise".

    public/         nginx web root: pages, api/, assets/
    config/         config.php (secrets) - outside the web root, never uploaded
    content/<id>/   index.php lesson map + one file per lesson
    lib/            db, auth, course, content, compile, codestyle, routines, ...
    bin/            setup, markqueue, compilequeue, backup, check-*.php
    data/           course.sqlite

## Architecture

- **One SQLite database.** `pupils`, `enrolments (pupilId, courseId,
  enrolledAt)`, and `courseId` on `quizResponses`, `writtenAnswers`,
  `activityState` inside their UNIQUE keys. `apiUsage` (daily cap) is
  platform-wide. New columns are added through the `$wanted` array in
  `bin/setup.php`.
- **Courses are code:** a `CourseIndex()` row, a `content/<id>/` folder, and a
  marking voice in `CourseMarkStyle()` / `MarkSystemPrompt()` in
  `bin/markqueue.php`.
- **Pages:** `/` landing; after sign-in `subjects.php` (the first page);
  `courses.php` (grouped by subject, `?s=` for one); `course.php?c=` (lesson titles only; each summary + SAGs lines opens with its chevron, Expand all / Collapse all - Chris, 23 Sep 2026);
  `lesson.php?c=&id=`; `scores.php?c=` (My marks - lesson and course totals as
  "got / out of (NN%)", `MarksPercent()`); `teacher.php?c=` (class, year
  filters); `pupil-work.php?c=&p=` (teachers only: every marked question, the
  answer, right answer, mark and feedback; same totals as `teacher.php`);
  `admin.php`, `admin-users.php`.
- **Class results and pupil-work list pupils only** - `IsPupilAccount()`: a
  `students.dlshcch.co.za` address that is not a teacher.
- **Everything a pupil finished is shown again on return** - every question
  type, written answers and feedback, code boxes, the review, activity scores.
  A reloaded self-marked verdict shows the same "X out of Y marks." line
  (`ReloadedVerdictExtras()`). Any new block type must do the same.
- **Open self-enrolment** in any open course.
- **Block types:** `prose`, `video`, `activity`, `quiz`, `written`, `reveal`,
  `typed`, `checkedcode`, `order`, `select` (tick all correct, no more), `match`
  (dropdown per row), `gridtyped`, `code`, `algorithm`, `errors`, `important`,
  `goodtoknow`, `enrichment`, `contents`, `study`. Colours mean things: amber =
  must know (`important` `#FFE8A3`/`#FFB300`/`#8A5200`; `study` reuses
  `.learn-memorise`'s amber), teal = watch/try, green = question, cream =
  optional (`enrichment`), blue = quote, **plum = not examined but useful**
  (`goodtoknow`: `#EFE9F5`, `#8A6BB0`, `#5B4380`). Keep plum for that only.
- **Scoring:** quiz/typed/checkedcode/order/select/match share `quizResponses`.
  All-or-nothing via `QuizMarkEarned()`, except `match`, scored **per line**
  (`MatchCorrectLines()`, `MatchMarkEarned()`). Every totalling page goes
  through `AutoMarkedEarned()` (`PupilAutoMarkedTotal()`,
  `CourseAutoMarkedWeights()`) - never `QuizMarkEarned()` on a match row.
- **Popups:** `Gloss($term, $def)` (glossary) and `Aside($marker, $text)` (joke,
  anecdote) in `lib/content.php`.
- **`code` blocks:** an editable Pascal box with Run; real fpc in the sandbox
  (decision 15), genuine errors and output. Layout is checked first
  (`lib/codestyle.php`), only for things fpc accepts and only against what the
  lesson has taught. **No marks** - excluded from `LessonAutoMarkedQuestions()`.
  Open to every enrolled pupil (server CPU, not API tokens). See
  [compile-subsystem-design.md](compile-subsystem-design.md) and
  [live-console-design.md](live-console-design.md).
- **Typed answers:** trimmed, case-folded (`caseSensitive` to override); a code
  answer is also compared with compiler-ignored spacing removed and the final
  `;` optional, and an unmatched code answer gets an AI second opinion
  (`CheckCodeAnswer()`). Details: content-voice-and-pedagogy.md §4.

## Decisions that must not be undone

**1. Written answers are queued, never marked in the web request.**
`api/submit-written.php` queues and returns; `bin/markqueue.php` (cron, every
minute) marks one answer at a time and enforces the daily cap. The worker loops
through the minute (checks every 250ms until 45s, `flock`), so pick-up is
~0.3s. Its body is behind `RunMarkQueue()` and a run-directly guard, so
requiring the file for `MarkOneAnswer()` never starts the loop. Marking is
serial: a whole class at once is minutes of queue; `PollForFeedback` waits
~12 minutes before saying "taking longer". Parallel marking is on the backlog.

**2. SQLite settings in `lib/db.php`:** WAL, 5s busy timeout, `synchronous =
NORMAL`, `mmap_size` 64 MB, `temp_store = MEMORY`. Without them 30 pupils
saving at once hit `SQLITE_BUSY`.

**3. One `config/config.php` for both machines.** `$isLocal` picks database
path, base URL and sign-in rules. Dev (name-only) login is on locally and
forced off on live (on for the test site). Secrets travel inside it.

**4. Two attempts per auto-marked question.** A wrong first answer says only
that. The right answer and explanation are withheld by the API itself, not
hidden by the page. The second attempt reveals and locks; a third is refused.
Right second time earns half. `MaxQuizAttempts()` is the only place the number
lives.

**5. Written answers look like essays.** Big box; essay mode when `markMax >= 5`.

**6. Pasting is refused in written answers** (paste and drop), with a line
saying why - and, from 24 September 2026, in typed, checked-code and grid
answers too (`app.js`). Not in activity boxes.

**6b. A paste that gets round it is caught.** The page records typed
characters, typing time, non-typed characters and refused pastes, sent with
every save (and on `pagehide`, with keepalive, so closing the tab loses
nothing; the textarea has `autocomplete="off"`). `TypingVerdict()`
(`lib/typing.php`) flags: answer much longer than typed (a question's
`starterText` is not counted against the pupil); >60 characters not typed (one
event may carry 30); **>15 typing EVENTS/s over 100+ events** (events, not
characters, since 24 September 2026 - predictive and swipe typing insert a word
per event and were flagged at 22 and 37 "chars/s"; records from before events
were counted are never judged on speed); or a 60+ character answer with no
record. Generous on purpose. A
flagged answer is marked, then stores a third (`FlaggedMark()`), keeping the
real mark in `markBeforeFlag`; the pupil sees `FlagNotice()` in red; the NB
list warns. Teachers see a red flag (filter "Show only flagged work"), the
typing record on `pupil-work.php`, **Clear the flag** (`flagCleared`) and
**Flag as pasted**. `teacherMark` overrides all. Check: `bin/check-typing.php`.

**6d. When and how long** (Chris, 24 September 2026). `quizResponses.firstAnsweredAt`
(set by the trigger `quizResponsesFirstAnswered`, so every answer API gets it)
and `updatedAt` (last attempt); written answers keep `submittedAt`/`markedAt`,
plus `workMs` (each gap between inputs counted as at most a minute, summed over
every sitting) and `workSessions` (page loads that saved). `pupil-work.php`
shows them under each question, percentages on every total, and **Show all /
Only flagged / Only 50% or below** filters.

**6c. Security headers** (`SendSecurityHeaders()` in `lib/db.php`): CSP (this
site, Google Fonts, YouTube and YouTube no-cookie, and `https://www.google.com`
in `frame-src` - the YouTube player frames it and every video is blocked
without it; `script-src` allows `'unsafe-inline'`), `Permissions-Policy`, HSTS
over https (no includeSubDomains/preload). nginx sends the other three.
`'cspReportOnly' => true` in config makes the CSP log instead of block.

**7. Rubrics are written for the marker:** award marks for correct ideas, never
deduct for spelling, grammar or informal language; justify the allocation.

**8. No question totals an odd number of marks.** Auto-marked marks are
doubled; check `written`'s `markMax`. If the natural count is odd, weight the
hardest criterion 2 and say why.

**9. Assets go through `AssetUrl()`** (mtime cache-buster); nginx caches
`/assets/` for a week.

**10. YouTube IDs are never invented.** Pascal course: no blank video blocks at
all (`bin/check-videos.php`). Elsewhere a blank id renders an amber search box.

**11. The video iframe's `referrerpolicy="strict-origin-when-cross-origin"` is
required.** The site sends `Referrer-Policy: same-origin`; without the
attribute YouTube fails every video with Error 153.

**12. A mark count shown anywhere is what the engine can award** - `marks x 2`
for quiz/typed/order/select, per line for match, `markMax` for written. Never
show a raw declared field.

**13. Written answers autosave as a draft; a draft is not a submission.**
`api/save-draft.php` upserts `status = 'draft'` (debounced 2s, and on blur).
Drafts are excluded everywhere: markqueue takes only `queued`, `teacher.php`
sums only `done`, `scores.php` filters `<> 'draft'`. `lesson.php` treats a row
as handed in only when not a draft. The blur-before-click race is guarded
twice: `SaveDraft()` re-checks `submitBtn.disabled` when its response lands,
and `save-draft.php` refuses to write over anything not already a draft.

**14. Band-rubric written answers show a band and a reason per criterion.**
`RubricCriteria()` (on `ParseRubricBlocks()`) extracts criteria; when present,
`MarkOneAnswer()` asks for `{mark, criteria:[{name, band, why}], feedback}`
with `max_tokens` 1100 (**not lower** - truncated JSON broke it). Stored in
`writtenAnswers.markBreakdown`, rendered as a table in three places kept in
step: `lesson.php`, `scores.php` ("What the marker said" shows when feedback OR
a breakdown exists) and `app.js` `PollForFeedback()` (built with
`textContent`, never `innerHTML` - model text is untrusted).

**15. Pupils' Pascal only runs in the sandbox** (`bin/compile-sandbox.sh`:
transient `systemd-run`, `DynamicUser`, no network, read-only filesystem, hard
limits). Load-bearing: **`InaccessiblePaths=/var/www`** (plus `/var/backups`,
`/var/log`) - read-only is not unreadable, and a pupil program once read every
lesson's answers; **source arrives on stdin**, never a path (`PrivateTmp`);
**the sandbox exists only on the server** - locally `$isLocal` compiles with no
isolation and `'compileInRequest' => $isLocal` bypasses the queue, so local
testing proves neither. Keep both tied to `$isLocal`, never settings. Any guard
that depends on a background worker has a timeout (one compile in flight per
pupil, bounded to 30s).

**16. A right first attempt is congratulated in varying words.**
`CelebrationForAnswer()`, called by every auto-marked endpoint, rendered by one
`FillVerdict()` in `app.js`. First attempt only; replaces "Correct." (match
keeps its headline too); live only, not on reload (except `code`); never for
`written`. Wording: `AnswerCelebrations()` (and `CodeCelebrations()` in
`lib/compile.php`) - about half South African, split between Afrikaans-rooted
and township English. Replace phrases that date.

**17. Code answers are marked strictly, at `temperature` 0, with the original
code shown.** Every marking call uses temperature 0. `MarkOneAnswer()` sends
`starterText` as the broken code given, and anything unchanged earns nothing.
The code prompt says punctuation IS marked, award only for characters you can
point at, name what earned each mark. `IsCodeMarking()`: anything with
`starterText`, or `'codeAnswer' => true`. Explain-the-error questions stay on
the prose path.

**18. A lesson's study summary is authored once, rendered twice.** The `study`
block holds data (sections, points, key terms); `StudyNotesHtml()` and
`StudyNotesPdfBlocks()` render page and PDF. Point markup: `**bold**` and
`` `code` `` only. `lib/pdf.php` is hand-written and must stay small - no PDF
library. **Every Pascal lesson has a study block**; other courses opt in.

**19. "Evaluate my performance" counts in PHP; the model only writes it up.**
Appended to every lesson with questions; unlocks when every question is
settled and every written answer marked. `LessonPerformanceFacts()` and
`ReviewSignals()` in `lib/review.php`. Rules: more than half settled only on
the second attempt -> pace, not ability; written under 60% on at least half of
at least two marked -> more detail, complete, precise, quoting the marker (one
weak answer is not this). Gated by `CanUseMarking()` and the daily cap; queued
after written answers; temperature 0.

**20. A lesson remembers where a pupil got to, server-side.** A `.block-anchor`
before every block; `app.js` writes the top visible one to `lessonPositions`;
next visit offers "carry on where you left off?" as a plain link. Nothing is
written until the pupil really scrolls; "No, start at the top" clears it; an
index past the end is ignored.

**21. Every block that can carry a `.block-icon` is in the `position:
relative` list in `style.css`** - otherwise the icon flies to the page's
top-left.

**22. The masthead is pinned** (`position: sticky`, same `z-index` as
`.lesson-toolbar`, above the 96px block icons). `.block-anchor`
`scroll-margin-top` = bar height + 10 + 52 icon overhang - 20 = 100px wide,
123px narrow; the narrow override sits in its own media query right after the
base rule (in the 620px block it loses). Re-measure when the bar changes.

**23. One masthead function.** `RenderMasthead()` in `lib/masthead.php`; each
page passes its nav items. `lesson.php` adds a **Lesson contents** dropdown
from `LessonContentsMenuItems()`, reading the same `contents` block as the
in-page list (one list, authored once). It is a `<details>`; it closes when a
topic is picked, on a click elsewhere, or Escape. Empty item lists are skipped.

**24. fpc runs as `-Mobjfpc`** in both `lib/compile.php` and
`bin/compile-sandbox.sh`, matching Lazarus/Delphi: `Integer` is 32-bit
(-2147483648..2147483647) and mismatch errors say `LongInt`. A literal too big
still warns; a computed overflow never does (`50000 * 50000` wraps to
-1794967296). **Verify any Integer range, SmallInt/LongInt message or overflow
example with `-Mobjfpc`** - plain `fpc` gives 16-bit Integer.

**25. The hamburger menu** (`SiteMenuHtml()` in `lib/sitemenu.php`, before the
wordmark) holds: All subjects, this subject's courses, this course's lessons;
**Teacher options > Class results** for teachers; **Admin > Admin, Users** for
`IsAdmin()`. Those left the masthead bar (admin pages and pupil-work keep their
own links). The panel is a `<div>`, not `<nav>` (`.masthead nav` is a flex
row); the summary needs `display: block` plus `::marker` rules to lose
Chrome's triangle.

**26. Marking replies use structured outputs; failures are handed back.**
`output_config.format` with a JSON schema (`MarkReplySchema()`, the review's in
`lib/review.php`); the API call lives once in `CallClaude()` (`lib/claude.php`).
Failure reasons go in `writtenAnswers.failReason`; a failed answer reopens for
resubmission ("Failed - resubmit."), not charged to the cap;
`submit-written.php` refuses to re-hand-in anything queued or marked.
`/admin.php` (only `AdminEmails()`, default `cnoome@dlshcch.co.za`, config
`adminEmails`) lists failed/stuck answers, re-marks, retries reviews, shows the
log. **The admin check reads `$_SESSION['signedInWith']`**, not `googleSub`,
so a dev login as Chris on test gets 403. The worker survives "database is
locked". `tools/marking-check.php` makes one real marking call through a
site's code - run after publishing a marking change.

## Sign-in, marking and privacy (load-bearing)

- **Sign-in is open to any Google account** (Chris has no Workspace admin; the
  consent screen is External).
- **One account, one session.** `pupils.sessionId` / `sessionSeenAt`.
  `SignIn()` refuses a second sign-in while the session is live (`'busy'`,
  shown by `auth.php`); `CurrentPupil()` ends a session the row no longer
  names; `SignOut()` releases. Idle longer than `SessionIdleMinutes()` (config
  `sessionIdleMinutes`, default 20) = finished; `app.js` pings
  `api/heartbeat.php` every 4 minutes on lesson pages. Admin > Users has **Free
  session**. **Closing the last page frees the seat in ~90 s**
  (`assets/session-release.js`, loaded by `RenderMasthead()` on signed-in pages:
  a `localStorage` list of open tabs, a beacon to `heartbeat.php?leaving=1` when
  the last closes; the next page reclaims the seat 3 s after loading). Browsers
  allow no custom pop-up on close, so a **"Leaving?" pop-up with Sign out**
  shows when the mouse leaves through the top of the window (24 September 2026).
- **Access is decided by `Entitlements()` in `lib/billing.php` and nothing
  else** (24 September 2026). `CanUseMarking (pupil, courseId)` asks it. Sources:
  a `schoolEmailDomains` address in config (De La Salle, until step 2 turns its
  classes into groups); the old `pupils.subscriptionExpiresAt`; the person's own
  active subscription (a pupil plan covers `scope` = all or one course; a
  teacher plan adds teacher tools); a school licence whose `domains` include the
  email's domain. The AI daily cap is the plan's `aiDailyCap`, else config
  `maxApiCallsPerPupilPerDay` (`AiDailyCap()`). Every AI API passes the course.
- **Billing (step 1, no gateway yet):** tables `plans`, `subscriptions`,
  `invoices`, `payments`, `accessCodes`, `codeRedemptions`, `aiUsage` (end of
  `schema.sql`). Money in cents, rand; VAT stored as 0 (not registered).
  **Admin > Billing** (`admin-billing.php`): plans, give a subscription (by
  email, or a school licence by domains), invoices (numbered `ITC-YYYY-NNNN`,
  never reused, cancelled not deleted; PDF at `invoice.php`; Paid with EFT
  reference; refunds as negative payments), bursary codes, AI costs per kind and
  per person, and a monthly CSV. **My account** (`account.php`, in the menu):
  what the person may use and why, and a code box (10 tries an hour). Invoice
  seller details come from config `invoiceSeller` (name, address, email, phone,
  bank) - **not set yet**.
- **Teacher groups (step 2, 24 September 2026)** - `lib/groups.php`, tables
  `teachingGroups`, `groupTeachers`, `groupMembers`, `groupInvites`,
  `teacherDomains`, `schools` (for later). **A teacher sees a pupil's work only
  after the pupil ACCEPTS an invitation to one of the teacher's groups, and only
  in that group's course** (`TeacherCanSee()`); admins still see every school
  pupil. Teachers: **My groups** (`groups.php`, `group.php`) - make a group,
  paste addresses (on itcoder -> invited at once; not yet -> the invitation
  waits and is matched when they open Subjects or My account), tick to invite
  again or remove, invite pupils from an approved school domain, archive.
  Pupils: an invitations box on Subjects and My account (Join / No thanks;
  joining enrols them), and Leave under Your groups (`invitation.php`). Admin >
  **Teachers and groups** (`admin-teachers.php`): make a teacher
  (`pupils.teacherGrantedAt` - sign-in no longer resets it; config
  `teacherEmails` still works), approve school domains (they only help find
  pupils), turn a year's classes into groups (pupils accepted, Staff/Other
  left out, safe to re-run), put teachers on groups. Class results: a
  non-admin teacher sees only a group's accepted members; an admin can pick a
  group or keep the class/year view. A **teacher plan covers AI marking** for
  its groups' accepted members, first-accepted first up to its seats
  (`GroupCoverage()` in `Entitlements()`). No emails yet (Brevo, step 5).
  Check: `php bin/check-groups.php` (local database, rolled back).
- **Every AI call is costed:** `CallClaude()` records tokens and cost in
  `aiUsage` against `SetAiUsageContext()` (marking, analysis, review,
  codecheck, style). Prices `AiPriceTable()` (Haiku 4.5 $1/$5 per M tokens;
  cache reads counted at the full input price - an overestimate), rand via
  `ExchangeRate()`: the ECB daily rate from api.frankfurter.dev (free, no key),
  saved in `exchange-rate.json` beside the database and refreshed when over 12
  hours old; config `usdToZar` fixes it instead (24 September 2026).
- **A subscriber's marks are visible only to the subscriber** - `teacher.php`
  drops non-school pupils; `privacy.php`/`terms.php` promise it.
- **Teachers** = `config['teacherEmails']` (Chris's school and personal).
- **`scores.php` never takes a pupil id from the URL** - keep every such page
  session-based.
- **Data kept:** name, email, class, courses, answers, marks. Nothing more.
- **Marking calls send only question, rubric and answer** - never name or email.
- **Daily cap** `maxApiCallsPerPupilPerDay` = 30.
- **Class and year:** `ClassList()` (`9C 9J 9R 9L Gr 10 Gr 11 Gr 12 Staff
  Other`), stored with the year; asked again each January.
- **Backups leave South Africa** (Chris's machine, Dropbox); `privacy.php` says
  so. See [backups.md](backups.md).

## Keys and accounts

Secrets live in `config/config.php` per project, never here.

- **Anthropic:** model `claude-haiku-4-5-20251001`; workspace-scoped key, or an
  org key plus `anthropicWorkspaceId`. Workspace spend limit still to set.
- **Google OAuth:** redirect `https://itcoder.co.za/auth.php?action=callback`;
  consent screen External, still to publish.
- **Server:** [vps-access.md](vps-access.md).
- **GitHub (`Chrisnoome`):** private repos `itcoder-platform` (AIPascalCourse)
  and `itcoder-resources` (this folder, deliberately including vps-access.md).
  `config/config.php` is gitignored. This machine pushes with
  `~/.ssh/id_ed25519`; no `gh` CLI - create repos on github.com/new.

## Local testbed (Chris's Windows machine)

- XAMPP `D:\xampp`, PHP 8.2 (`D:\xampp\php\php.exe`) vs 8.3 on the server.
  Apache service as LocalSystem; vhosts `Require local` (configs hold live
  keys). v2: http://localhost:8081, database
  `D:/xampp/itcoder-platform-data/course.sqlite` - **outside Dropbox and
  outside any user profile** (LocalSystem can't open `C:\Users\...`).
- Free Pascal 3.2.2: `C:\lazarus\fpc\3.2.2\bin\x86_64-win64\fpc.exe` (not on
  PATH in bash; call the full path). `pdftotext` at
  `C:\Program Files\Git\mingw64\bin\pdftotext.exe` (`-raw` for the SAGs'
  multi-column Appendix G).
- Python 3.14 with paramiko: `C:\Python314\python.exe` (always the full path);
  venv `D:\xampp\itcoder-tools-venv` for the backup pull.
- **Scheduled task `itcoder-markqueue`** (every minute) stands in for cron. It
  must launch `D:\xampp\itcoder-platform-data\run-markqueue-hidden.vbs` via
  `wscript.exe //B //Nologo`, never the `.cmd` (a console window steals focus
  every minute). `IgnoreNew` stops overlaps.

## Checks to run

- `php -l` on every PHP file touched.
- `php bin/check-popup-spacing.php` - after any `Gloss()`/`Aside()` change.
- `php bin/check-lesson-contents.php` - one `contents` block per lesson, every
  anchor real and under a heading.
- `php bin/check-titles.php` - titles <= 55 visible characters (Good to Know
  <= 36; video titles exempt).
- `php bin/check-figures.php` - every illustration in `Figure ()`.
- `php bin/check-code-blocks.php [--compile]` - every listing runnable or
  marked no-console.
- `php bin/check-groups.php` - groups, invitations, who a teacher sees, seats (local only).
- `php bin/check-output-programs.php` - every output has its main program
  shown above it (content-voice-and-pedagogy.md §7b).
- `php bin/check-codestyle.php`, `php bin/check-typing.php`,
  `php bin/check-sags.php`, `php bin/check-videos.php`.
- `node tests/tokeniser.test.js`; `node public/assets/*.test.js`.
- Every `written` `markMax` even; every shown mark count matches the engine
  (decision 12); a new block with `.block-icon` is in the `position: relative`
  list (decision 21).
- After any server upload: permissions per [vps-access.md](vps-access.md) -
  but publish only through the scripts in [publishing.md](publishing.md).

## Before a demo lesson

Pre-install and pre-pull everything (Pinokio downloads gigabytes on first
run). Record a three-minute screen capture of each demo as a fallback.
