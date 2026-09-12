# The itcoder platform

What itcoder is, how it is built, and the decisions that must not be quietly
undone. Consolidated on 11 September 2026 from itcoder v1's CLAUDE.md and the
Pascal chat's notes on v2. Facts about the code were checked against
`AIPascalCourse` that day.

## What it is

**itcoder.co.za** - short, self-marking online courses written by Chris Noome,
IT teacher at De La Salle Holy Cross College, Johannesburg. Built first for his
own classes, and open to outside subscribers too.

| Course id | Course | Status (11 Sep 2026, post-cutover) |
|---|---|---|
| `ai` | How AI really works - Grade 9, eight lessons | `draft` on the live site (teacher preview only) - content not yet ported/restyled, see [courses/ai-course.md](courses/ai-course.md) |
| `pascal` | Programming in Pascal - IEB IT, Grades 10-12 | `open` and live, two lessons - see [courses/pascal-course.md](courses/pascal-course.md) |
| - | Theory, SQL, Java | Planned. `Projects/AITheory` exists, empty |

**Cutover happened 11 September 2026.** v2 now runs at `/var/www/itcoder`,
live at https://itcoder.co.za - v1's code and database were replaced in
place (see `open-items.md`, "Cutover", for exactly how). Two codebases still
exist on disk, but only one is live:

- **v1** - `Projects/AIWebCourse/itcoder`. No longer deployed anywhere. Its
  content (especially the AI course's 8 lessons and 6 activities) is still
  the source material for porting into v2 - read from here, don't deploy it.
- **v2** - `Projects/AIPascalCourse`. The live platform. All new work happens
  here, including the AI course port when it's ready.

## Who it's for

- **Pupils** - use that word, not "learner", in all new copy and code (Chris,
  11 September 2026). v1 says "learner" throughout; leave it, v1 is going.
- **Pupils are minors.** That shapes every privacy decision below.
- The Grade 9 AI class: 90 pupils in three classes, at most 30 online at once.
  Every pupil has a machine, fast internet and searchable YouTube.
- **All work happens in class. No homework.** 40-minute periods, which is really
  about 30 minutes of working time. Scope every lesson to that.
- Pupils cannot run local AI on their own machines. Demos happen on Chris's
  laptop (i9, 64 GB RAM, RTX 3080 Ti with 16 GB VRAM) through the projector.

## The stack, and why it is so plain

PHP 8.3 + SQLite. **No framework, no build step, no package manager.** Deliberate:
one small VPS, deployed by uploading a folder, readable by anyone who opens a
file. Don't add a framework or a build step to "modernise" it.

v2 layout:

    /var/www/itcoder/            (= the AIPascalCourse folder)
      public/                    <- nginx web root
        index.php courses.php course.php lesson.php
        auth.php scores.php teacher.php privacy.php terms.php
        api/                     answer, submit-written, feedback, activity
        assets/                  style.css, app.js
      config/config.php          keys and secrets - outside the web root
      content/<courseId>/        index.php + lessonNN.php per course
      lib/                       db, auth, course, content
      bin/                       setup.php, markqueue.php, backup.php, tune-fpm.sh,
                                 check-popup-spacing.php
      data/course.sqlite         the whole database

## v2 architecture (Pascal chat, 10-11 September 2026)

- **One SQLite database.** `pupils` (not `learners`), `enrolments (pupilId,
  courseId, enrolledAt)`, and a `courseId` on `quizResponses`,
  `writtenAnswers` and `activityState`, inside their UNIQUE keys. `apiUsage`,
  the daily marking cap, stays platform-wide.
- **Courses are code, not data**: a row in `CourseIndex()` in `lib/course.php`,
  a `content/<courseId>/` folder with an `index.php` lesson map, and a per-course
  marking voice in `CourseMarkStyle()` / `MarkSystemPrompt()` in
  `bin/markqueue.php`. Each course is `open` (in the catalogue) or `draft`
  (teacher preview only).
- **Pages:** `/` public landing -> `/courses.php` catalogue -> `/course.php?c=ID`
  -> `/lesson.php?c=ID&id=LESSON`; `/scores.php?c=ID`; `/teacher.php?c=ID`
  with course, class and year filters.
- **Open self-enrolment:** any signed-in pupil can join any open course.
- **Content blocks:** `prose`, `video`, `activity`, `quiz`, `written`,
  `reveal` (a "do this" prompt with a hidden explanation), plus `typed`,
  `order`, `select` (select-multiple - tick every correct box, no more, no
  fewer), `match` (match two columns via a dropdown per row) and
  `enrichment` (2026-09-13 - a boxed, warm-cream group of optional extra
  videos/links at the bottom of a lesson, visually distinct from the
  required material above it). `quiz`, `typed`, `order`,
  `select` and `match` all share one table (`quizResponses`), but not one
  scoring rule: `quiz`/`typed`/`order`/`select` are all-or-nothing
  (`QuizMarkEarned()`), while `match` scores **per line** (Chris, 2026-09-12 -
  "1 mark per line", not one mark for the whole question) via
  `MatchCorrectLines()`/`MatchMarkEarned()`/`AutoMarkedEarned()` in
  `lib/content.php` - a pupil who gets 3 of 4 pairs right keeps 3 lines'
  worth of credit, at `marks` each, doubled if that line was right on the
  first attempt. `AutoMarkedEarned()` is the one function every totalling
  page (`course.php`, `scores.php`, `teacher.php` via
  `PupilAutoMarkedTotal()`/`CourseAutoMarkedWeights()`) must go through now -
  none of them may call `QuizMarkEarned()` on a `match` row directly, since
  that would silently mark it all-or-nothing again. Inside prose, `Gloss($term, $def)` and `Aside($marker, $text)` make
  tap-to-open popups (glossary vs joke or anecdote). A `code` block that
  compiles and runs real Pascal is planned - see
  [courses/pascal-course.md](courses/pascal-course.md).

## Decisions that must not be undone

Each of these was made for a reason that still holds. Changing one needs Chris,
not a tidy-up.

**1. Written answers are queued, never marked in the web request.**
`api/submit-written.php` writes to the queue and returns at once; `bin/markqueue.php`
runs from cron every minute and calls the Claude API one answer at a time. On the
original 1-core server that was survival. Since the upgrade it still stands:
holding a web worker idle through seconds of network wait is waste; one-at-a-time
keeps spend and rate limits predictable; and the daily cap is enforced around the
queue. Don't "simplify" it into a synchronous call.

**2. SQLite settings in `lib/db.php`.** WAL mode and a 5-second busy timeout -
without them, 30 pupils saving at once hit `SQLITE_BUSY`. Plus
`synchronous = NORMAL` (with WAL on, no fsync per commit; a power cut could lose
the last commit or two, an application crash cannot), `mmap_size` 64 MB and
`temp_store = MEMORY`. Don't remove them.

**3. One `config/config.php` for both machines.** It works out whether it is on
Windows or the server (`$isLocal`) and picks its own database path, base URL
and sign-in rules, so the whole folder uploads as-is. The name-only dev login is
on locally and forced off on the server. The Google and Anthropic secrets travel
inside the file - uploading it with them blank stops sign-in and marking.

**4. Quizzes give two attempts.** A wrong first answer says so and nothing more.
The right option and the explanation are withheld by `api/answer.php` itself,
not merely hidden by the page, so they cannot be read out of the response. The
second attempt reveals and locks; a third is refused server-side. Right on the
second go still counts - it is a tutorial - and `quizResponses.attempts` records
that it took two. `MaxQuizAttempts()` in `lib/content.php` is the only place the
number lives.

**5. Written answers ask for an essay, and look like it.** The box is large, and
bigger again (essay mode) when `markMax` is 5 or more - a question becomes an
essay by being worth more, not by special markup.

**6. Pasting is refused in written answers** - paste and drag-and-drop both,
with a line saying why. Not in activity boxes, which exist to have text pasted
into them. A deterrent, not a lock: it removes the thoughtless route, which is
the one that gets used.

**7. Rubrics are written for the marker.** Every rubric says: award marks for
correct ideas, never deduct for spelling, grammar or informal language - how
Chris marks practicals. Every rubric also justifies its mark allocation
(content-voice-and-pedagogy.md §4).

**8. No question totals an odd number of marks** - an odd total means half marks
(Chris, 11 September 2026). Quiz, typed and order marks are doubled by the
engine, so they are safe; `written`'s `markMax` is the one to check. If the
natural rubric has an odd number of 1-mark criteria, weight the hardest one at 2
and say why - don't pad.

**9. Asset URLs carry a cache-buster.** `AssetUrl()` in `lib/db.php` stamps the
file's modification time onto `/assets/app.js` and `/assets/style.css`. nginx
tells browsers to keep `/assets/` for a week; without the stamp, a mid-course fix
would not reach pupils who had already loaded the page. Always link assets
through `AssetUrl()`, never as a bare path.

**10. YouTube IDs are never invented.** A blank `youtubeId` renders an amber box
with a search link; Chris fills it in after vetting the video.

**11. The video iframe's `referrerpolicy="strict-origin-when-cross-origin"`
attribute is required, not decorative** (found and fixed 12 September 2026,
right after cutover). The site's own `Referrer-Policy: same-origin` header
(nginx, both `sites-available/itcoder` and `nginx.conf.sample`) sends no
referrer at all on a cross-origin request - and YouTube's embed player
treats a missing referrer as fatal, failing **every** video with "Video
player configuration error, Error 153," not just some. This has nothing to
do with any individual video's embed settings - confirmed by the error
reproducing even for `youtube.com/embed/` (not just the `-nocookie` domain)
and for a universally-embeddable video, in a real Chrome browser, not just
an automated one. The element-level `referrerpolicy` attribute on the
`<iframe>` in `public/lesson.php` overrides the page's stricter header for
just that element - removing it as "redundant" would silently break every
video on the site again.

**12. A displayed mark count must always be what the scoring engine can
actually award, never a question's raw declared value** (found broken across
every quiz/typed/order question in both courses, 12 September 2026). Quiz,
typed and order questions are scored by `QuizMarkEarned()` in
`lib/content.php` at `marks x 2` for a right first attempt or `marks` for a
right second attempt - but `lesson.php`'s eyebrow was printing the raw
`marks` field (e.g. "1 marks") on all three block types, while the
`marks-note` sitting right beneath it promised "the full mark" for a number
the pupil was never actually shown. Fixed by displaying `marks x 2` in the
eyebrow, matching what "the full mark" refers to. **Whenever a mark count is
shown anywhere in the UI, check it against what the relevant scoring path
(`QuizMarkEarned()`, or `markMax` for `written`) can actually award before
shipping - never surface a question's raw declared field to a pupil without
checking it first.** This applies to any future marks-carrying UI too (the
teacher dashboard, `scores.php`), not just the block eyebrows found broken
here.

**13. Written answers autosave as a draft, and a draft is not a submission.**
`api/save-draft.php` upserts `writtenAnswers` with `status = 'draft'` on a
debounced `input` (2s) and on `blur`, from `SetUpWritten()` in `app.js` -
"don't worry, what you type is saved" is stated to the pupil directly (the
NB list in `lesson.php`'s `written` case). A draft is deliberately excluded
from everywhere a real submission is counted: `bin/markqueue.php` only ever
picks up `status = 'queued'`, `teacher.php`'s totals only ever sum
`status = 'done'`, and `scores.php`'s own query filters `status <> 'draft'`
so an unfinished draft never shows as "being marked" on a pupil's own marks
page. `lesson.php` treats a row as handed in (`$handedIn`, textarea
`readonly`, submit button hidden) only when `status !== 'draft'` - a draft
row still renders an editable, prefilled textarea and a live submit button.
**The submit click's own `blur` on the textarea races the click handler**:
blur fires first and calls `SaveDraft()` while `submitBtn.disabled` is still
false, so its response can land *after* `submit-written.php`'s has already
disabled the button and shown "Handed in...". `SaveDraft()`'s `.then` guards
against this by re-checking `submitBtn.disabled` at response time, not call
time, before touching the status line - removing that check re-opens a race
where a stray "Saved." overwrites the hand-in confirmation the pupil actually
needs to see. `save-draft.php` has its own DB-side guard against the same
race: it reads the existing row's status before writing, and refuses to
write if it is already anything other than `draft` (i.e. already queued or
further along) - so a slow draft-save request can never resurrect a
`queued`/`done` row back to `draft` after the real submission has landed.

**14. A written question marked against a band rubric shows its working: a
band chosen per criterion, and why - not just a total (Chris, 12 September
2026).** `RubricCriteria()` in `lib/content.php` (built on the same
`ParseRubricBlocks()` that drives `RubricListHtml()`) extracts a rubric's
band-table criteria - the IEB SAGS-style shape required for `markMax >= 10`,
content-voice-and-pedagogy.md §4. When a question has any, `MarkOneAnswer()`
in `bin/markqueue.php` switches to a different marking prompt and JSON
reply shape: instead of `{"mark", "feedback"}`, it asks for `{"mark",
"criteria": [{"name", "band", "why"}, ...], "feedback"}` - one named band
and a one-sentence reason per criterion, `feedback` reduced to an optional
closing note so it does not just repeat the per-criterion reasoning. This
needs more room than a plain mark: `max_tokens` is raised from 400 to 1100
whenever `RubricCriteria()` finds any criteria, found by a real failure
(`json_decode()` failing on truncated JSON) while building this - **do not
drop it back down**. The result is stored as JSON in
`writtenAnswers.markBreakdown` (nullable - only band-marked answers use it;
migrated via the `$wanted` array in `bin/setup.php`, the pattern for every
column added after the schema first shipped) and rendered as a two-column
table (`.verdict-breakdown` in `style.css`) in three independent places that
must be kept in sync: `lesson.php`'s server-rendered verdict, `scores.php`'s
"What the marker said" section, and `app.js`'s `PollForFeedback()` for a
mark that arrives while the pupil is still on the page - the last of these
built with `createElement`/`textContent` throughout, never `innerHTML`,
because the criteria "why" text comes from a model prompted with the
pupil's own answer and is no more trustworthy as markup than `feedback`
always was. `scores.php`'s "is there feedback to show" check was also
widened from "`feedback` is non-empty" to "`feedback` is non-empty OR
`markBreakdown` is set" - a band-marked answer can legitimately have an
empty closing `feedback` string, and the old check hid the answer's
breakdown entirely in that case. A rubric with no band criteria (every
small, per-idea-checklist rubric under `markMax => 10`) is untouched by any
of this - `RubricCriteria()` returns an empty array, `$hasCriteria` is
false, and marking falls back to the original plain-mark-and-feedback shape
exactly as before.

## Sign-in, marking and privacy (v2, 11 September 2026 - load-bearing)

- **Sign-in is open to any Google account.** Chris has no Workspace admin rights
  over `dlshcch.co.za`, so the OAuth consent screen cannot be Internal, and an
  External app cannot be domain-restricted by Google. v2 stopped trying.
  (v1 did restrict sign-in to school domains.)
- **AI marking is what is restricted.** `CanUseMarking()` = `IsSchoolPupil()`
  (email domain in `config['schoolEmailDomains']`: `students.dlshcch.co.za`,
  `dlshcch.co.za`) or `HasActiveSubscription()` (`subscriptionExpiresAt` today or
  later, set by hand - there is no purchase flow yet). It is enforced
  server-side in `api/submit-written.php`; the notice in `lesson.php` is only a
  courtesy.
- **A subscriber's marks are visible to nobody but the subscriber** - not Chris,
  not the teacher dashboard, ever. `teacher.php` drops every non-school pupil
  after the query. `privacy.php` and `terms.php` promise this. Don't loosen it
  without Chris revisiting that promise first.
- **Teachers** are the addresses in `config['teacherEmails']` - Chris's school
  and personal addresses (11 September 2026). Only they reach `teacher.php`.
- **A pupil's marks page (`scores.php`) never takes a pupil id from the URL** -
  only the course. Whose marks it shows comes from the signed-in session, so
  there is no way to ask it about anybody else. Keep every such page that way.
- **Data kept:** name, email, class, the courses joined, answers, marks. Nothing
  else. Resist the temptation to log more.
- **The marking API call sends only the question, rubric and answer text.** No
  pupil name or email leaves the server - `bin/markqueue.php` reads the answers
  table only. Keep it that way.
- **Daily per-pupil marking cap**, `maxApiCallsPerPupilPerDay` (30), so nobody
  can run up the bill.
- **Class and year.** Pupils pick a class at sign-in - `9C 9J 9R 9L Gr 10 Gr 11
  Gr 12 Staff Other` (`ClassList()` in `lib/auth.php`) - stored with the year it
  was picked. In January the year stops matching and everyone is asked again, so
  last year's 9C does not stay 9C forever. Old rows keep their year, so earlier
  years stay readable on the teacher page.
- **Backups leave the server**, to Chris's machine and Dropbox - outside South
  Africa. `privacy.php` says so. See [backups.md](backups.md).

## Keys and accounts

Secrets live in `config/config.php` in each project (never in this folder). On
11 September 2026 v1 and v2 held identical values.

- **Anthropic:** model `claude-haiku-4-5-20251001`. Use a workspace-scoped key,
  or an organisation key plus `anthropicWorkspaceId` - an organisation key
  without it is refused, and the failure shows only in the marking log. Set a
  spend limit on the workspace (open item).
- **Google OAuth:** redirect URI exactly
  `https://itcoder.co.za/auth.php?action=callback` (same in v1 and v2). Consent
  screen is External and still needs publishing (open item).
- **The server:** see [vps-access.md](vps-access.md).

## Local testbeds (Chris's Windows machine)

- XAMPP at `D:\xampp`. PHP 8.2 locally against 8.3 on the server - the safe
  direction: 8.3-only syntax fails here first.
- Apache runs as a Windows service (`Apache2.4`, Automatic) as **LocalSystem**.
  Vhosts in `D:\xampp\apache\conf\extra\httpd-vhosts.conf`, each with
  `Require local`, because the local configs hold live API keys and the laptop
  goes to school.
  - v1: http://localhost:8080, database `D:/xampp/itcoder-data/course.sqlite`
  - v2: http://localhost:8081, database `D:/xampp/itcoder-platform-data/course.sqlite`
- **Local databases live outside Dropbox** (WAL plus a syncing folder risks
  corruption) **and outside any user profile** - LocalSystem cannot open files
  under `C:\Users\...`, which broke the v1 testbed once with "unable to open
  database file". Don't move them.
- Python 3.14 with paramiko at `C:\Python314`; a clean venv with paramiko at
  `D:\xampp\itcoder-tools-venv` (used by the backup pull).
- Free Pascal 3.2.2 (with Lazarus) at `C:\lazarus\fpc\3.2.2\bin\x86_64-win64\fpc.exe` -
  the same version apt installs on the server.

## Checks to run

- `php -l` on every PHP file you touch.
- `php bin/check-popup-spacing.php` after touching any content that calls
  `Gloss()` or `Aside()` - a popup glued to the next word has recurred many times.
- `node tests/tokeniser.test.js` (v1 today; it must move with the token counter
  when the AI course is ported) after touching `SplitIntoTokens`.
- Every `written` question's `markMax` is even.
- Any mark count shown in the UI matches what the scoring engine actually
  awards, not a question's raw declared field (decision 12) - check a new or
  changed marks-carrying element against `QuizMarkEarned()`
  (quiz/typed/order/select), `MatchMarkEarned()` (match - scored per line,
  not all-or-nothing), or `markMax` (written) before shipping it.
- After any upload to the server: the ownership and permission lines in
  [vps-access.md](vps-access.md).

## Before a demo lesson

Pre-install and pre-pull everything. Pinokio downloads gigabytes on first run and
the school line will not cooperate at 09:20. Record a three-minute screen capture
of each demo working as a fallback - with a class of fourteen-year-olds, dead air
is fatal.
