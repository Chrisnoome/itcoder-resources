# Numbered blocks: design (agreed with Chris, 15 Oct 2026)

Status: Phases 1+2 built 15 Oct 2026 (AIPascalCourse 8de1065..306163f, not published; 37 lessons whose return is not a list still unnumbered). Next: Phase 3. Code lives in `Projects/AIPascalCourse`.
open-items.md bullet "Block sections" (area content, p1); works with
"Per-teacher gated courses setting" (area teacher).

## Why

Reviewing or correcting a lesson today means Claude reads and rewrites a whole
lesson file: about 36 KB median, 90-250 KB for the old `lessonNN.php` files
(10-60k tokens per read). Most corrections touch one paragraph or one question.
If every block has a number Chris can see on the site, a correction names
course + lesson + block and Claude reads and rewrites only that block (about
0.3-1k tokens). Gating also becomes "gate at block N" instead of an edit to the
file.

## What exists (survey, 15 Oct 2026)

- A lesson is already a list of typed blocks: `content/<course>/<lesson>.php`
  returns `[ ['type'=>'prose', ...], ['type'=>'quiz','id'=>'q1Exactly', ...] ]`.
  683 files in 28 course folders, about 614 of them lessons. Prose `html` is PHP
  code: heredocs joined with helpers (`Gloss()`, `DesignFigure()`, course scene
  helpers), so a block is a piece of PHP source, not plain data.
- Questions, try-its and activities have a stable `id`, and pupil data is keyed
  on it (quizResponses, writtenAnswers, codeSubmissions, activityState,
  sqlSteps, markQueries). **These ids never change.**
- Prose, important, goodtoknow, contents, video and figure-type blocks have no
  id. Some prose has an optional `anchor` (named links such as
  `plagiarism#referencing`).
- `public/lesson.php` (the `foreach ($blocks as $blockIndex => $block)` loop,
  ~l.483) puts an invisible `<span class="block-anchor" id="b<index>">` before
  each block. The index shifts when a block is inserted, so it cannot be the
  block number. `lessonPositions.blockIndex` (carry on) uses it too.
- Gating: `GateRule()` / `GateHolds()` in lib/sequence.php hold every block
  after an unsolved gate in `[data-held-by]`; app.js `BestLessonsGates` opens
  them. Only blocks with an `id` can gate today. Admins and teachers skip gates
  (`SequenceExempt()`).
- No admin edit view exists. The page root has `data-staff="1"` for staff.

## Decisions (Chris, 15 Oct 2026)

1. **Stable block numbers, never reused.** Every block gets `'n' => 12` once
   and keeps it. A new block takes the lesson's next free number, so the page
   may read 1, 2, 3, 14, 4. A deleted block's number is never given out again.
   A pending request can therefore never point at the wrong block.
2. **Granularity: today's blocks.** One block = one array element. During
   migration a prose block over ~3 KB of source is split at its sub-headings
   (separate pass, below).
3. **Edit view: admins only, a toggle in the top bar**, remembered per browser,
   off by default. With it off the page is exactly as now.
4. **Corrections: a form on the page goes to a server queue.** In edit view
   each block shows its number and a pencil. The note is saved with course,
   lesson and block in a server table. The control centre pulls open requests
   and lists them; Run starts a session that edits only that block.
5. **Gates: author default + admin override.** The lesson file sets default
   gates. In edit view "Gate here" on any block saves an override in the
   database (no file edit, no Claude tokens).
6. **Prose may gate, with a Continue button.** A reading block set as a gate
   shows "I've read this - Continue"; the blocks after it stay held until it
   is clicked.
7. **Per-teacher setting: Course default / Always gate / Never gate**
   (teacher settings). Pupils with no teacher get the course default. Nothing
   changes for current pupils until a teacher picks otherwise.
8. **Pilot course: pascal9.** Then the other 27 courses at once by script.
9. **Migration check: script plus a rendered-page diff.** Every lesson is
   rendered before and after with edit view off; the HTML must match apart
   from the new invisible attributes. Chris spot-checks pascal9 in edit view.

## Data model

- **In the lesson file:** every block gets `'n' => <int>`, unique within the
  lesson, written as the first key so a tool can find it by text. Questions
  keep their `id`; `n` is an extra handle, not a replacement.
- **Helper-built blocks** (Chris, 15 Oct 2026): a helper call in the list
  gets one number through a wrapper, `...Numbered(7, Scenario(...))` for a
  call that builds several blocks, `NumberedBlock(7, Helper(...))` for one
  (lib/content.php). Every part it builds carries n 7; a correction to #7
  edits that one call. In the source each n still appears once.
- **Next free number:** the highest `n` ever used, kept as a comment line at
  the top of the lesson file (`// blocks-next: 27`), so a number freed by a
  deletion is never reused. `bin/check-blocks.php` fails if `n` is missing,
  repeated, or not below `blocks-next`.
- **Rendered page:** the existing `block-anchor` span gains `data-n="<n>"` and
  `id="n<n>"`. The `b<index>` id stays for carry-on links; carry-on moves to
  `n` later (it only stores a position, so the harm of a shift is low).
- **New tables** (added through `$wanted` in bin/setup.php):
  - `blockRequests (id, courseId, lessonId, n, note, status open|running|done|dropped, createdBy, createdAt, doneAt, doneCommit)`.
  - `blockGates (courseId, lessonId, n, gate 0|1, setBy, setAt)`: admin
    overrides of the file's gate. 1 adds a gate at n, 0 removes the file's gate.
  - `teacherSettings` (or the existing settings table) gets
    `gateMode default|always|never`.
  - Continue-button gates record a solved row through `GateStepSolved()` into
    `sqlSteps` under `read:<n>`, as code-run gates already do.

## Edit view

- Toggle "Edit view" in the admin part of the top bar; state in localStorage;
  the page gets `body.edit-view`. CSS under `body.design-e.edit-view` (one look
  for every course): a small number tab in the left margin of each block
  (`#12`, plus the question id if any), a thin outline on hover, a pencil and a
  gate icon. No layout shift when off.
- Gates show in edit view as a bar under the gate block (file gate, admin
  gate, or removed), so Chris sees where pupils stop.
- Open requests show a dot on their block, so a block is not reported twice.
- Edit view also shows held blocks (admins skip gates already).

## Correction flow

1. Chris clicks the pencil on block 12, types the note, and saves.
   `api/block-request.php` (admin only, CSRF) stores it, status `open`.
2. The control centre fetches open requests from test and live
   (`/admin/block-requests.json.php`, header key like the status endpoint,
   key in config, never in the repo) and lists them in a **Corrections** area
   by course and lesson.
3. Run starts a session with a short brief: course, lesson file, `n`, the note.
   The session uses `tools/block.py get <course> <lesson> <n>` to print just
   that block's source (plus the title of the block before and after for
   context), edits it, and writes it back with `tools/block.py put`. It runs
   the lesson checks for that file only, commits, and marks the request
   `done` with the commit (status set through the same endpoint).
4. Chris publishes as usual (publishing.md); the dot disappears.
   Several requests on one lesson can be batched in one session.

## Gating

- `GateRule()` gains: a block whose `n` has an admin override wins over the
  file; a prose (or other id-less) block that is a gate uses rule `read`.
- `GateHolds()` is unchanged in idea: everything after the nearest unsolved
  gate is held. Held blocks are keyed by `n` from now on.
- The teacher's `gateMode`: `never` drops all gates for that teacher's pupils
  (the lesson-order lock of sequential courses stays: that is a separate
  setting), `always` turns on the file and admin gates even in a
  non-sequential course, `default` uses the course.
- `ApiRequireUngated()` uses the same rule, so the server still refuses
  answers behind a gate.
- `tests/sequence.test.php` gets cases for admin override, read gates and the
  three teacher modes.

## Generation

- Lesson-writing briefs and the content checklist say: every block starts with
  `'n' =>`, numbered 1.. in page order, and the file starts with
  `// blocks-next:`. A prose block stays under ~3 KB of source; longer goes
  into two blocks at a sub-heading.
- `bin/check-blocks.php` joins the checks a new course must pass
  (content-voice-and-pedagogy.md lesson checklist; platform.md "Checks to run").
- Reviews read by block: a review session lists block numbers and titles first
  (`tools/block.py list`), then reads only the blocks it needs.

## Migration plan

- **Phase 1: numbering and edit view, pilot pascal9.**
  `tools/block-number.py` adds `'n'` to every top-level block and the
  `blocks-next` line, by parsing the PHP array's top level (no Claude).
  Render-diff script: render each lesson as a pupil before and after (PHP on
  the local testbed), compare. Edit view (read-only: numbers only) and
  `bin/check-blocks.php`. Chris spot-checks pascal9.
- **Phase 2: all courses numbered.** Same script over the other 27 courses,
  one commit, render diff must be clean.
- **Phase 3: correction flow.** `blockRequests`, the pencil form, the
  endpoint, the control centre's Corrections area, `tools/block.py get/put/list`.
- **Phase 4: gating.** `blockGates`, "Gate here" in edit view, read gates with
  Continue, the teacher's gateMode (closes the per-teacher open item), tests.
- **Phase 5: split long prose.** Course by course, Claude splits blocks over
  ~3 KB at sub-headings (new numbers from `blocks-next`), render checked by
  eye. Biggest files first (java, pascal, sql lessonNN).
- **Phase 6: generation rules** written into the lesson briefs and checklist
  (can go with phase 1).

## Risks

- **PHP-as-content:** prose is code with helper calls and heredocs, so the
  numbering script must work on the PHP source's top-level array, not on
  rendered HTML. Mitigation: the render diff; a file the script cannot parse
  is skipped and listed, not guessed.
- **Question ids:** the script and `block.py put` must never touch an `id`.
  check-blocks compares ids before and after.
- **Other chats editing lessons** during the bulk run: run phase 2 when no
  course chat is open, and fail if a file changed since it was read.
- **Read gates are easy to click past.** Accepted by Chris; questions remain
  the real gates.
- **Stale requests** after a block is deleted: the request keeps its number;
  the control centre shows "block gone" and it is dropped by hand.
- **Teacher `never` mode** must not open marked work early on the server:
  the API rule follows the same function.
