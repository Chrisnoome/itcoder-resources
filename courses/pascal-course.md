# Course: Programming in Pascal (`pascal`)

**Kept by the Pascal chat (AIPascalCourse).** Seeded on 11 September 2026 from
that chat's own notes, so other chats - marking in particular - can see its
decisions. That chat keeps this current; when a decision here changes, change it
here, not only in chat memory.

**Where it lives:** `Projects/AIPascalCourse/content/pascal/`. Status `open`.

**For:** IEB Information Technology, Grades 10-12. Syllabus:
[../sags-topic4-syllabus.md](../sags-topic4-syllabus.md). Code conventions:
[../pascal-house-style.md](../pascal-house-style.md). Voice:
[../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md), built on
[../writing-style.md](../writing-style.md).

## Lessons

1. **What you learn when you learn programming** - programming is computational
   thinking (SAGs 10.4.1), not syntax. "The computer is stupid and must be told
   everything" (jam-sandwich reveal). Selection is the same idea in Pascal,
   Python and JavaScript, just different syntax. Languages are built for a
   purpose - Pascal was built purely to teach. Feynman quote.
2. **Proof of Life / Output - WriteLn and Write** - output as proof a program
   ran (SAGs 10.4.1, IPO's "O"), the Program/Begin/End. shell, naming rules,
   Write vs Writeln, reading real compiler errors, the `:width:decimals`
   trick, the doubled apostrophe and `#9`. Two live `code` blocks compiled by
   real `fpc`.
3. **Making it pretty** - enrichment, not SAGs content, will never be tested,
   and carries no marks anywhere in it (Chris, 13 September 2026 - every
   `quiz`/`typed`/`reveal` question was removed on request, so it is pure
   prose, examples and runnable `code` blocks). Units/libraries as an idea
   every language has, under a different name each time, taught via Pascal's
   `Uses` clause; then the `Crt` unit's `ClrScr`, `TextColor`/
   `TextBackground`, `GotoXY`, `WhereX`/`WhereY` and `Delay`. Newton
   "shoulders of giants" portrait quote, plus an anonymous "first
   impressions" quote before the Crt section framing text-mode UI (greet the
   pupil, clear prompts, a goodbye message, make it beautiful). Three
   runnable `code` playgrounds (colour, GotoXY, and a closing one combining
   all five commands) - real `fpc` compiling into the virtual-terminal
   display (platform.md decision 15, the Crt auto-detection). `Delay`
   carries an explicit note that its pause never shows on this site, since a
   `code` block only ever displays a finished run, not a live one - it only
   shows in Lazarus, locally.
4. **Every box needs a label** - variables and data types (SAGs 10.4.3). Wirth
   quote, a type-mismatch compile error, `Div` vs `/`, Y2K aside, the
   ID-number-as-a-string written question.
5. **Getting input - Readln, Read, ReadKey and KeyPressed** (SAGs 10.4.1,
   IPO's "I") - new 13 September 2026. Four commands, same underlying shape
   pair-wise: `Readln`/`Read` are ordinary Pascal I/O and the exact same
   relationship as `Write`/`Writeln` on the way out (`Read` leaves the rest of
   the line for whatever reads next; `Readln` throws it away) - a deliberate
   callback, not a new idea dressed up as one. `ReadKey`/`KeyPressed` are
   Crt's single-keypress pair from lesson 3: `ReadKey` waits for one key and
   never echoes it, `KeyPressed` only checks whether one is waiting, without
   blocking or consuming it - so one is for "stop and ask", the other for
   "keep going unless interrupted". Julian Treasure quote ("we will just talk
   to our computers... why would we not?") framing the keyboard as one input
   method among others, not the only one there will ever be.

   **Only `Readln` is exam content (Chris, 13 September 2026).** An `important`
   block says so explicitly, early in the lesson, before any of the four are
   taught in depth: for tests, exams and almost everything a pupil writes in
   this course, `Readln` is the one to actually know - `Read`/`ReadKey`/
   `KeyPressed` are real, useful commands for later projects, not syllabus
   content, and the lesson's own depth follows that split (Readln gets the
   crash-examples table and the bulk of the questions; the other three get a
   lighter, "know it exists" treatment). The **"What to study" summary
   mirrors this on purpose** - it does not re-teach Read/ReadKey/KeyPressed at
   revision depth, only names them as tools that exist for tasks and projects,
   because a revision sheet should reflect what is actually examined, not
   everything a lesson happened to mention. Apply the same split to any later
   lesson that teaches both syllabus and enrichment material side by side.

   **A `Readln`'s variable does two jobs, and typing the wrong type crashes it
   - taught with a genuine crash-examples table**, every row copied from an
   actual run against real fpc 3.2.2 (not invented): `Integer` + letters or a
   decimal both crash with `Runtime error 106`; `Integer` + an empty line does
   NOT crash, it silently leaves the variable at 0; `String` never crashes,
   whatever is typed. This is the same discipline as the compile subsystem's
   own rule (compile-subsystem-design.md) applied to a runtime result instead
   of a compiler one - verify a genuine behaviour before teaching it as fact.
   Ends with a
   `markMax => 10`, band-rubric written question asking when each of the four
   is the right choice - the capstone Chris asked for.

6. **Processing - basic maths.** File `lesson06.php`. BODMAS, real division
   vs `Div`/`Mod`, `Round`/`Trunc`, and `Abs`/`Sqr`/`Sqrt`/`Power`/`Min`/`Max`
   (the `Math` unit). Built 13 September 2026 - see the file's own docblock
   for the genuine `fpc` gotchas found while writing it (`Div`/`Mod`
   truncate toward zero on negatives; `Round` is round-half-to-even).
7. **Type conversion.** File `lesson07.php`. New 13 September 2026, first
   content for "lesson 6 onward" (open-items.md); rewritten the same day
   after Chris's own voice/pedagogy edit pass. Covers all four SAGs 4.3
   conversion pairs: `IntToStr`/`StrToInt` (String<->Integer, new),
   `Chr`/`Ord` (Char<->Integer, new), Char->String (free, new) vs
   String->Char (taught directly via `word1[1]` indexing, not deferred),
   and Real<->Integer (a refresher of lesson 6's `Round`/`Trunc` and lesson
   4's free Integer-into-Real, not re-taught from scratch). The throughline:
   Pascal never silently converts a value's type except a genuinely free
   assignment; everything else needs an explicit, named function - which is
   also why `Round`/`Trunc` exist, tying back to lesson 6.
   **"Widening"/"narrowing" and "crossing" are deliberately not used as
   terms anywhere in the pupil-facing text** (Chris, 13 September 2026 -
   too technical for a 15-year-old newbie, and lesson 4 never used the word
   "widening" either); the lesson says "fits in with no fuss" / "needs a
   function" / "conversion" instead. Every paragraph was also split down to
   one idea each after Chris flagged the first draft as too dense.
   **`FloatToStr`/`StrToFloat`/`Format` are taught as genuinely
   locale-dependent** (confirmed comma-decimal on the Windows testbed; the
   server's locale is still unverified), paired with the actual fix Chris
   asked for: copying `DefaultFormatSettings` into a `TFormatSettings`
   variable, overriding `DecimalSeparator`, and passing it to those three
   functions - verified genuinely forcing a point on the same comma-locale
   machine. Flagged as relevant again once a dates lesson exists, since
   `TFormatSettings` controls date formatting too. Every other
   genuine-output claim was compiled for real against `fpc` 3.2.2 first,
   including the `StrToInt` crash (`EConvertError`, not `Runtime error 106`
   - a different failure mode worth knowing about) and the
   `String`-into-`Char` compile error.

**Numbering settled 13 September 2026 (Chris, definite): "Proof of life" is
lesson 2, "Making it pretty" is a new lesson 3, "Every box needs a label"
moved from 3 to 4, and "Getting input" is the new lesson 5.** None of these
are drafts.

**The file names deliberately do not match the numbers.** `proofoflife.php` is
lesson 2, `lesson03.php` is lesson 3, `lesson02.php` is lesson 4, and the new
`lesson05.php` is lesson 5 - none of them should be renamed to match. The
array key in
`content/pascal/index.php` is the lessonId, and that id is a database key in
six tables - `quizResponses`, `writtenAnswers`, `codeSubmissions`,
`activityState`, `lessonPositions` and `performanceReviews`. Renaming the
files would orphan every answer, mark and bookmark stored against the old
ids, and it would do it silently: nothing errors, pupils just find their work
gone. The number is a label, the id is an identity, and they are allowed to
disagree.

Content, as built:
- **Core thesis, meant to recur across later lessons, not just this one:**
  your program must produce output or you have no way of knowing it did
  anything - this is *why* Hello World is the traditional first program.
  Watch for natural callbacks to this in lessons 3+.
- Terry Pratchett quote ("It doesn't stop being magic..."), portrait extracted
  from `_ALL_QUOTES.docx` itself.
- Planning order (Input → Processing → Output) vs. learning order (Output →
  ... → Input), taught as a deliberate reversal - see decisions below for why
  Input moved later than first planned.
- Hello World; `Write` vs `Writeln` (newline vs none); a full "Naming things
  in Pascal" section (can't start with a number, no spaces, no special
  characters, PascalCase explained, can't reuse a taught keyword - stated as a
  rule that applies to naming anything, not just a program); a "you're
  responsible for every space and mark in your own output" callout, right
  where commas first combine multiple items in one `Writeln`.
- A full set of `Writeln` tricks beyond one bare string: comma-separated
  arguments mixing text/numbers/calculations, the `:width:decimals` trick for
  real numbers, escaping an apostrophe with a doubled quote (`''`), and `#9`/
  the Tab character - each backed by genuine compiled FPC 3.2.2 output, never
  invented.
- Reading real compiler errors as an explicit, taught skill - several
  deliberately-broken snippets (missing semicolon, missing `End.`, an
  unknown identifier), each paired with genuine `fpc` output, plus a
  `match`-type question pairing error messages to causes.
- Two `code` blocks (`c1HelloWorld`, `c2FixTheErrors`) - the first real use of
  the compile subsystem, genuinely compiling and running pupil Pascal on the
  server; see the compile-subsystem decision below.
- Roughly a dozen short one-line-answer `typed` questions ("what does this
  print?" / "write the instruction that prints this"), one pair per `Writeln`
  trick, each compiled for real before being written.
- Three AI-marked "fix the code" `written` questions (pre-filled with broken
  code via the new `starterText` field, 2-4 planted errors each, 1 mark per
  error) and two "explain the error message" `written` questions (fresh
  genuine errors, testing transfer rather than the ones already covered
  above) - see the rubric-wording decisions below.
- `Readln`/Input is **not** taught in this lesson - see decisions below for
  why it moved later.
- Formal program structure, taught here for the first time: `Program Name;`
  and one `Begin … End.` block (`../pascal-house-style.md` §1).
- This is also the first lesson where a formatting/layout mark applies (see
  the rubric-wording decision below) - but only against what it actually
  teaches: indentation, program structure. No variables yet, so no variable-
  naming check here, and comments aren't taught here either.

## Decisions

- **Every lesson has exactly one `contents` block - this is a rule, not a
  convention** (Chris, 13 September 2026). It renders the in-page jump-list
  AND feeds the masthead's "Lesson contents" dropdown, from the same
  `items` array - see content-voice-and-pedagogy.md §7 for the full shape
  (`anchor`/`label`/`note` per item, plus the generic `'anchor' => '...'`
  field any block can carry for the ones with no `html` field to hand-write
  a span into). Run `php bin/check-lesson-contents.php` after touching any
  lesson's `contents` block or its anchors - it fails loudly if a lesson has
  none, has more than one, or a bookmark points at a dead anchor or a block
  with no heading. Every Pascal lesson through lesson 6 has one and passes;
  keep it that way for every lesson after.
- **Code compiles and runs on the server, with real `fpc`** (settled 11 September
  2026). The lessons teach reading genuine compiler errors, so the text must be
  real `fpc` output - which rules out a browser-side compiler. It means a `code`
  block type, a compile queue shaped like `bin/markqueue.php`, a sandboxed worker
  and an API endpoint. Chris chose to build it now rather than later.
  **Built 12 September 2026 and not yet deployed** - see
  [../compile-subsystem-design.md](../compile-subsystem-design.md) for what
  exists, what was found while building it, and the commands to put it up. The
  first two `code` blocks are in `proofoflife.php` (`c1HelloWorld`,
  `c2FixTheErrors`).
- **Code answers are marked strictly, and the marker sees the broken original**
  (Chris, 12 September 2026, after a fix-the-code answer that changed nothing
  came back 2 out of 4 with both marks confidently explained). `temperature` is
  now 0 for all marking, `starterText` is sent to the marker as the original to
  compare against, and code questions get a prompt that says punctuation is the
  answer rather than the "never deduct for punctuation" line written for
  essays. Any new "write a program" question must set `'codeAnswer' => true`;
  fix-the-code questions get it automatically from `starterText`. Full account
  in [../platform.md](../platform.md), decision 17.
- **A `code` block shows its output in a virtual DOS terminal** when the
  program uses Crt's screen routines (`GotoXY`, `WhereX`, `WhereY`,
  `TextColor`, `TextBackground`, `Delay`, `ClrScr`), prints more than a
  screenful, or the block sets `'terminal' => true` (Chris, 12 September 2026).
  80x25, scrollable, real DOS colours. Everything else keeps the plain output
  panel, which suits the one-line answers most exercises produce. Colour only
  works because the program is run under a pseudo-terminal - down a plain pipe
  Free Pascal's Crt silently ignores every visual call. Detail in
  [../compile-subsystem-design.md](../compile-subsystem-design.md).
- **A `code` block checks layout before it will compile anything** (Chris, 12
  September 2026). Wrong indentation, a tab, two instructions on one line or a
  missing `Program` header are listed in plain words and the program is
  refused - it never reaches the compiler. Two constraints keep this from
  fighting the lesson it serves: it only ever flags things `fpc` would happily
  compile (a missing `End.` stays the compiler's to report, because reading
  real compiler errors is the point), and it only checks what the course has
  already taught, per block. Capitalising reserved words is implemented but
  off until a lesson actually teaches it. Detail in
  [../compile-subsystem-design.md](../compile-subsystem-design.md).
- **A `code` block carries no marks** (12 September 2026). It is a practice box
  for reading real compiler output, not an assessment, and it is deliberately
  kept out of `LessonAutoMarkedQuestions()` so no lesson reports an "out of" a
  pupil cannot actually reach. Marked code questions are a later, separate
  layer, and there are two different shapes of them - see the design file.
- **Compiling is open to everyone signed in and enrolled** (Chris, 12 September
  2026) - not gated like AI marking, because it spends this server's own CPU
  rather than Anthropic tokens. A pupil may have only one compile in flight at
  a time, which is what keeps the Run button from being leaned on.
- **The testbed compiles without a sandbox; the server compiles inside one**,
  chosen by `$isLocal` in `config.php` (Chris, 12 September 2026). Windows has
  no systemd. So local testing proves the block, the endpoints and the UI, but
  **cannot** prove the isolation - every change to `bin/compile-sandbox.sh` has
  to be checked on the server.
- **The testbed also compiles in the request, not through the queue**
  (`'compileInRequest' => $isLocal`). Windows has no cron either, so a queued
  row would sit there forever - which is exactly what happened the first time
  Chris tried it. Both machines run the same `ProcessCodeSubmission()`, so the
  result is identical; only who calls it differs. The cron worker itself is
  therefore another thing local testing cannot prove.
- **FPC 3.2.2 everywhere.** Locally with Lazarus; on the server apt installs
  exactly 3.2.2 (`fp-compiler`, not `fpc`). Every worked example and every
  deliberately broken one is compiled for real, so the output in the lesson is
  genuine.
- **Code questions are marked against house style as well as correctness**, from
  the first lesson. The house-style penalty is **a flat 1 mark, once per
  question**, never per violation - and the feedback always names the violation.
  What counts as house style grows with what has been taught. **Never say
  "house style" or "convention" to a pupil** (Chris, 13 September 2026) -
  `content-voice-and-pedagogy.md` §1 has the required replacement wording.
  These internal docs, and rubrics meant for the marker only, can keep using
  the real terms.
- **`Readln`/Input moved out of "Proof of life" entirely** (Chris, 13
  September 2026): `Readln` needs a variable to store what's typed into, and
  this lesson comes before variables are taught at all (lesson 2, "Every box
  needs a label") - an example here would ask pupils to use a box that
  doesn't exist yet. Input now waits until after lesson 2. In its place,
  "Proof of life" goes deeper on Output itself (see the content list above).
- **A rubric shown to a pupil must never spell out the literal expected
  answer** (Chris, 13 September 2026, `content-voice-and-pedagogy.md` §4) -
  use the new **`markerRubric`** field for exact/technical marking detail
  instead; `bin/markqueue.php` sends it to the AI marker when present,
  falling back to `rubric` otherwise. `rubric` (what `showRubric` displays)
  stays a short, vague, pupil-safe summary. `proofoflife.php`'s
  `w2FirstProgram` is the model: pupils see "1 mark for formatting, 13 for
  correct code, -1 per error"; the AI marker gets the full 14-item checklist.
- **`written` questions can pre-fill the answer box** with `starterText`
  (`lib/content.php`, `public/lesson.php`, added 13 September 2026) - used
  for "fix the broken code" questions, where the pupil edits what's already
  there rather than starting from nothing. A prior saved answer always wins
  over `starterText`, so a pupil's own edits are never overwritten.
- **All pupil-facing text must read as newbie-friendly** - written for an
  actual 15-year-old who has never programmed before, not a teacher or
  developer (Chris, 13 September 2026, caught after a rubric line read "a
  mechanical, syntax-level checklist, not a holistic judgement") - see
  `content-voice-and-pedagogy.md` §1. Applies to marking language too
  ("holistic", "criterion", "band") as much as to the lesson prose itself.
- **Every programming lesson opens with the "programming is not a study
  subject" notice** (Chris, 13 September 2026) - the amber `important` block,
  first thing, before the quote card. Lesson 1 carries the full argument
  (sport, baking, singing; type it out yourself; sit with the error); lessons
  after it carry the two-line reminder, `PracticalSubjectNotice (true)`. The
  wording lives in `lib/content.php`, not in the lesson files, so a change to
  it lands in every lesson at once. It is the whole pedagogy of the course in
  one box: change it thoughtfully, and only there.
- **Every lesson in this course ends with a "what to study" block** and a
  downloadable PDF of the same summary (Chris, 13 September 2026 - asked for
  lessons 1 and 2 first, then for all of them; platform.md decision 18).
  All three written lessons have one. **A new Pascal lesson is not finished
  until it has one** - it is not optional here the way it is in other courses.
  The "evaluate my performance" panel below it needs nothing authored: it
  appears on every lesson with questions, automatically.
- **No question totals an odd number of marks** (see platform.md, decision 8).
- **Run `php bin/check-popup-spacing.php`** after touching any `Gloss()` or
  `Aside()`.
- **A `code` block can now simulate keyboard input** (13 September 2026, built
  for lesson 5): `'takesInput' => true` adds a second box - "What will you
  type when this runs?" - fed to the compiled program's own stdin, so a real
  `Readln`/`Read` reads back exactly what the pupil typed there. Proven
  against real fpc locally; the sandboxed (server) path's framing is written
  but **not yet re-tested on the actual server** - see
  [../compile-subsystem-design.md](../compile-subsystem-design.md), "Simulated
  input for Readln/Read", before trusting it live. `ReadKey`/`KeyPressed`
  deliberately do NOT get a live `takesInput` demo yet - whether a simulated
  keypress can reach a Crt call expecting a real terminal is still an open
  question there, so lesson 5 teaches those two through quiz/typed/reveal
  instead, the way lesson 3 taught `Delay`/`Sound` honestly as "compiles and
  runs here, but you cannot observe the real effect on this site."

## Resolved

- **House-style scope** (was an open question, resolved 11 September 2026):
  [../marking-house-style.md](../marking-house-style.md) (formal IEB practical
  exam marking, summative) and this course's own 1-mark deduction (formative
  in-course practice) cover different things on purpose - each file now says so
  in its own scope note.
