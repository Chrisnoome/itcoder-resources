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
2. **Every box needs a label** - variables and data types (SAGs 10.4.3). Wirth
   quote, a type-mismatch compile error, `Div` vs `/`, Y2K aside, the
   ID-number-as-a-string written question.

**Built, not yet numbered: "Proof of life"** (`content/pascal/proofoflife.php`,
title confirmed by Chris). Meant to sit before lesson 2, which would then be
renumbered - final numbering is still Chris's call and not yet given, so it's
registered in `content/pascal/index.php` as a placeholder lesson 0 rather than
actually renumbered. Built out fully, in local XAMPP, across several sessions
in September 2026 - not a stub. Don't treat anything below as still "to be
decided"; it's a description of what the file actually contains.

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

## Resolved

- **House-style scope** (was an open question, resolved 11 September 2026):
  [../marking-house-style.md](../marking-house-style.md) (formal IEB practical
  exam marking, summative) and this course's own 1-mark deduction (formative
  in-course practice) cover different things on purpose - each file now says so
  in its own scope note.
