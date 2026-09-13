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
  tap-to-open popups (glossary vs joke or anecdote). `code` (2026-09-12) is
  an editable Pascal box with a Run button: the source is queued, real `fpc`
  compiles and runs it inside a systemd sandbox on the server, and the pupil
  gets back genuine compiler errors or their program's genuine output. **How
  the code is laid out is checked first** (`lib/codestyle.php`) and a program
  that fails is refused before it reaches the compiler - but only ever for
  things `fpc` itself would accept, and only against what that lesson has
  already taught. It
  carries **no marks** and is deliberately excluded from
  `LessonAutoMarkedQuestions()` - it is a practice box, not an assessment, and
  putting it in that pool without a scoring rule would make a lesson report a
  larger "out of" than any pupil could reach. Compiling is open to everyone
  signed in and enrolled, unlike AI marking, because it spends this server's
  CPU rather than Anthropic tokens. See
  [compile-subsystem-design.md](compile-subsystem-design.md).

## Decisions that must not be undone

Each of these was made for a reason that still holds. Changing one needs Chris,
not a tidy-up.

**1. Written answers are queued, never marked in the web request.**
`api/submit-written.php` writes to the queue and returns at once; `bin/markqueue.php`
is started from cron every minute and calls the Claude API one answer at a time. On the
original 1-core server that was survival. Since the upgrade it still stands:
holding a web worker idle through seconds of network wait is waste; one-at-a-time
keeps spend and rate limits predictable; and the daily cap is enforced around the
queue. Don't "simplify" it into a synchronous call.

**The worker loops through the minute rather than doing one pass per tick**
(12 September 2026). Cron can only start something once a minute, so a
one-pass worker left every answer waiting an average of thirty seconds before
anything looked at it - far more than the API call itself (measured at 3-14
seconds) and by far the largest part of what a pupil experienced as slow
marking. Chris went looking for that delay in the browser's polling; it was
never there. `markqueue.php` now behaves like `bin/compilequeue.php`: same
cron line, same `flock`, but it checks for work every 250ms until 45 seconds
in, then exits. Measured after: **picked up in 0.32s, marked in 2.9s total.**
None of the above changes - still queued, still off the web request, still one
answer at a time, still capped per pupil per day.

Two things that follow from it, worth keeping straight:

- **The worker body is behind `RunMarkQueue()` and a "run directly" guard**, so
  requiring the file for `MarkOneAnswer()` (the marking tests do) cannot start
  a three-quarter-minute loop as a side effect of an include.
- **A whole class handing in at once is still slow, and no poll setting fixes
  it.** Marking is serial: thirty answers at ~10s each is ~5 minutes of queue
  however promptly it starts. What that needed was the client's give-up cap
  raising (`PollForFeedback`, now ~12 minutes) so the pupils at the back stop
  being told "taking longer than usual" when nothing is wrong. The real lever
  is parallel marking, on the backlog in [open-items.md](open-items.md) - not
  worth reaching for until a real class has been watched doing it.

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

**15. Pupils' Pascal only ever runs inside the sandbox, and "read-only" is not
the same as "secret" (12 September 2026).** `bin/compile-sandbox.sh` runs every
compile and every resulting program in a transient `systemd-run` unit with
`DynamicUser`, no network, no writable filesystem, hard memory, time and
process limits. Three things about it are load-bearing and must not be trimmed
as belt-and-braces:

- **`InaccessiblePaths=/var/www`** (plus `/var/backups` and `/var/log`).
  `ProtectSystem=strict` makes the filesystem read-only, **not unreadable**,
  and the sandbox's dynamic uid counts as "other" for Unix permissions.
  `config/` and `data/` were already safe at chmod 750, but everything else
  under `/var/www` is 644 - and a pupil's Pascal program was confirmed reading
  `content/pascal/lesson02.php`, which is every quiz answer, every rubric and
  every explanation in the course. Tested on the live server; closed at the
  mount level rather than by trusting file permissions to stay right forever.
- **The source arrives on stdin, never as a file path.** `DynamicUser` implies
  `PrivateTmp`, so a file staged anywhere by the caller simply is not there
  inside the unit. Two other approaches were tried and failed - see
  [compile-subsystem-design.md](compile-subsystem-design.md).
- **The sandbox is only exercised on the server.** Windows has no systemd, so
  the testbed compiles with no isolation at all, chosen by `$isLocal` in
  `config.php`. That switch must stay `$isLocal` and never become a setting:
  running untrusted Pascal unsandboxed is safe for exactly one person, on his
  own laptop, running code he typed himself. It also means local testing can
  never prove the isolation - every change to the sandbox has to be re-checked
  against the server. The same goes for `'compileInRequest' => $isLocal`: the
  testbed has no cron, so it compiles in the request instead of through the
  queue, which means the cron worker is a second thing local testing cannot
  prove.

Related, and general enough to apply beyond compiling: **a guard that depends
on a background worker being alive must have a timeout.** The "one compile in
flight per pupil" check started as an unbounded "does this pupil have anything
queued?", which turned any worker outage into a permanent lock-out - every
retry refused, including the one that would have recovered. It is bounded to 30
seconds now. `markqueue.php`'s equivalent recovery sweep has the same shape and
the same reason.

**16. A question answered correctly on the FIRST attempt is congratulated, in
varying words (Chris, 12 September 2026).** Platform-wide and course-neutral:
`CelebrationForAnswer()` in `lib/content.php` is called by all five auto-marked
endpoints (`answer`, `typed-answer`, `order-answer`, `select-answer`,
`match-answer`), so nothing has to be added per lesson or per course, and
`app.js` renders it through one shared `FillVerdict()` that all five types now
use rather than each building its own verdict HTML.

- **First attempt only, and that is the point.** Right on the second go still
  earns half marks and still says so - it is not the same achievement, and
  cheering both equally would flatten the distinction the marks already draw.
  `MaxQuizAttempts()` gives two goes because this is a tutorial, not because
  both are equal.
- **For the four single-answer types the celebration replaces the plain
  "Correct."**, which it says more warmly. `match` keeps its own headline on
  top of it, because that one carries how many lines were right and what they
  earned - information, not decoration.
- **Live only, not on a reload.** `lesson.php` renders a prior verdict with the
  plain headline. A lesson with fifteen right answers would otherwise reopen as
  fifteen stacked banners, which turns a celebration into wallpaper. (The
  `code` block is the exception and does show its celebration on reload -
  there are only ever one or two of those on a page.)
- **Not used for `written`.** There is no first attempt there - a pupil hands
  in once - and the mark is a judgement out of `markMax` rather than right or
  wrong, so there is no moment this would be true of.
- The wording lives in `AnswerCelebrations()`, separate from
  `CodeCelebrations()` in `lib/compile.php`, because "it ran, and it printed"
  means nothing about a multiple-choice answer. Both lists are about half South
  African, split roughly evenly between Afrikaans-rooted ("lekker", "mooi",
  "klaar", "kwaai") and township English ("sharp sharp", "aweh", "yoh",
  "hundreds"): a De La Salle class is not one language group, and leaning
  entirely on either would quietly speak to half the room. Replace any phrase
  that starts sounding dated - stale slang reads worse than plain English.

**17. Code answers are marked strictly, at `temperature` 0, and the marker is
shown the original broken code (Chris, 12 September 2026).** Found when a pupil
handed in a fix-the-code answer **completely unchanged** and was given 2 out of
4 - with both marks explained in confident, specific detail. Neither fix
existed. Three separate causes, all now fixed in `bin/markqueue.php`:

- **No `temperature` was ever sent**, so the API's default of 1.0 applied.
  Marking is not creative writing: the same answer must earn the same mark
  every time, or two pupils who hand in identical work get different results
  and neither can be told why. Now `0`, for every question - verified by
  marking one borderline answer four times and getting the same mark each time.
- **The marker was never shown the code the pupil started from.** It saw the
  question, the rubric and the answer, and nothing to compare against - so on
  "fix the mistakes" it guessed which had been fixed. `MarkOneAnswer()` now
  sends `starterText` as "THE BROKEN CODE THE PUPIL WAS GIVEN TO FIX", with the
  instruction that anything still identical to it earns nothing.
- **The shared prompt said "never deduct marks for punctuation"** - correct for
  an essay, actively wrong for Pascal, where a missing semicolon, bracket or
  full stop *is* the mistake being marked. Code marking now says the opposite
  in as many words, plus: award a mark only for characters you can point at,
  never assume a fix because the question asked for one, and name the exact
  thing in the answer that earned each mark.

`IsCodeMarking()` decides which prompt a question gets: anything with
`starterText` (a pupil handed a program to change) is code by definition, and
anything else wanting strict marking sets `'codeAnswer' => true`. Questions
that ask a pupil to *explain* an error message in prose deliberately stay on
the prose path - the strictness is about marking characters, not about the
subject being code.

**18. A lesson's "what to study" summary is authored ONCE and rendered twice
(Chris, 13 September 2026).** The `study` block at the foot of a lesson holds
structured data - sections, points, key terms - not html. `StudyNotesHtml()`
renders it for the page and `StudyNotesPdfBlocks()` renders the same block for
the downloadable PDF, both in `lib/content.php`. Authoring html would render on
screen and be useless to the PDF writer, and the two would drift apart the
first time a lesson was edited between periods - leaving the pupil revising
from paper studying something different to the pupil revising from the screen.
Point text carries exactly two pieces of markup, `**bold**` and `` `code` ``,
because every piece of markup has to work in both renderings.

The PDF itself is built by `lib/pdf.php`, which is **written out by hand and
must stay small**. This platform has no package manager (see "The stack, and
why it is so plain"), so pulling in FPDF or Dompdf for one sheet of A4 would
be the project's first dependency, complete with a vendor folder to deploy and
keep updated. What is there covers A4, page breaks, three of the fourteen
fonts every reader has built in, headings, bullets, rules and a footer. If a
study sheet ever genuinely needs images, tables or links, that is the moment
to reconsider a library - not the moment to grow that file.

**Every lesson in the Pascal course gets a study block** (Chris, 13 September
2026, revising the same day's "only where I ask for one" - he asked for
lessons 1 and 2 first, then for all of them). So a new Pascal lesson is not
finished until it has one. Other courses stay opt-in: `LessonStudyNotes()`
returns null where there is no block, which the page and the PDF endpoint both
handle.

The "evaluate my performance" panel below it is the opposite of opt-in in
every course - `lesson.php` appends it automatically wherever a lesson has
questions, and nothing is authored for it.

**19. "Evaluate my performance" does its arithmetic in PHP and hands the model
the conclusion, never the counting (Chris, 13 September 2026).** System wide:
`public/lesson.php` appends the panel to every lesson with questions in it, in
every course. It unlocks only when every question is settled AND every written
answer has come back from marking - a review written while two answers are
still in the queue is a review of a smaller lesson, and the pupil has no way
of knowing that.

`LessonPerformanceFacts()` in `lib/review.php` counts what happened;
`ReviewSignals()` turns those counts into the points the review MUST make; the
model only writes them up in the course's voice, naming the actual topics.
This is decision 17's lesson applied again: give the model the evidence and
the rule, not the judgement. A pupil can check the counts against the marks on
their own screen in four seconds, so a model that counted for itself would be
caught being wrong by the person least able to argue with it.

Chris's two rules, both thresholds rather than impressions so that two pupils
with the same marks are told the same thing:

- **more than half the settled questions right only on the second attempt** ->
  talk about slowing down, reading the whole question and every option, and
  checking the answer before committing it. Say plainly that it is a pace
  problem, not an ability problem.
- **written answers under 60%, on at least half of those marked, with at least
  two marked** -> talk about the writing: more detail, complete (every part of
  the question answered), and precise (the lesson's own terms, not vague
  ones), quoting what the marker actually said. One weak answer among good
  ones is explicitly NOT this, and the review is told to say so.

Gated exactly like written marking - `CanUseMarking()`, the per-pupil daily API
cap - because it is the same thing: a paid API call on a pupil's behalf.
Queued the same way too, and written by `bin/markqueue.php`, which claims
written answers first and only looks for a review when the marking queue is
empty. `temperature` is 0, for decision 17's reason: asking twice must not
produce a different verdict.

**20. A lesson remembers where a pupil got to, on the server, and offers to
take them back (Chris, 13 September 2026).** `public/lesson.php` renders a
zero-height `.block-anchor` span before every block; `app.js` writes the
topmost visible one to `lessonPositions` as they scroll, and on the next visit
the page offers "carry on where you left off?" with a plain `<a href="#bN">`,
so taking the offer works with scripting off.

Three things it must keep doing:

- **Nothing is written until the pupil has genuinely scrolled.** Opening a
  lesson, glancing at it and closing it must never overwrite a real bookmark
  with 0.
- **"No, start at the top" clears the bookmark**, or the same jump is offered
  again next time, which is the opposite of what was just asked for.
- **Server-side, not `localStorage`.** The case this is for is starting a
  lesson in the computer lab and finishing it at home.

A lesson edited since a pupil was last in it shifts their bookmark by however
many blocks were inserted above it. That is tolerated deliberately - the offer
is a convenience, a block or two out costs nothing, and anchoring to question
ids would only work for the minority of blocks that have one. `lesson.php`
ignores an index past the end of the lesson, which is the only way it can
actually go wrong.

**21. Every block that can carry a `.block-icon` must be in the
`position: relative` list in `style.css` (found 13 September 2026).** Miss one
and the icon does not sit slightly wrong - it escapes to the top-left of the
PAGE, because an absolutely positioned element with no positioned ancestor
falls back to the initial containing block. Both new icons piled up in the
masthead until `.important-block` and `.study-block` were added to that rule.

The `important` block's three colours are Chris's, to the hex: background
`#FFE8A3`, border `#FFB300`, header `#8A5200`. The `study` block deliberately
reuses `.learn-memorise`'s amber and its icon, because it makes the same
promise - this is the part you are expected to know.

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
- **GitHub (Chris's account, `Chrisnoome`):** both project folders are private
  repos, pushed 12 September 2026 for off-machine backup - see README.md,
  "What lives elsewhere, and why". This machine's `~/.ssh/id_ed25519` (public
  key already added under github.com/settings/keys) authenticates pushes;
  there is no `gh` CLI installed here, so a new repo is created on
  github.com/new first, then added as a remote and pushed to, not created
  from the command line.

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
- Any new block type that shows a `.block-icon`: its class is in the
  `position: relative` list in `style.css` (decision 21) - check the icon
  actually sits on its own block's header bar, not in the masthead.
- After any upload to the server: the ownership and permission lines in
  [vps-access.md](vps-access.md).

## Before a demo lesson

Pre-install and pre-pull everything. Pinokio downloads gigabytes on first run and
the school line will not cooperate at 09:20. Record a three-minute screen capture
of each demo working as a fallback - with a class of fourteen-year-olds, dead air
is fatal.
