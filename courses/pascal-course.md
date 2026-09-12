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

## Lessons (11 September 2026)

1. **What you learn when you learn programming** - programming is computational
   thinking (SAGs 10.4.1), not syntax. "The computer is stupid and must be told
   everything" (jam-sandwich reveal). Selection is the same idea in Pascal,
   Python and JavaScript, just different syntax. Languages are built for a
   purpose - Pascal was built purely to teach. Feynman quote.
2. **Every box needs a label** - variables and data types (SAGs 10.4.3). Wirth
   quote, a type-mismatch compile error, `Div` vs `/`, Y2K aside, the
   ID-number-as-a-string written question.

**Being designed, not built: "Proof of life"** (title confirmed by Chris) - to
sit before lesson 2, which gets renumbered (final numbering is his call, not
yet given). **Don't build it until Chris confirms the plan** - he has said
"still discussing" more than once.

Content agreed so far:
- **Core thesis, meant to recur across later lessons, not just this one:**
  your program must produce output or you have no way of knowing it did
  anything - this is *why* Hello World is the traditional first program.
  Watch for natural callbacks to this in lessons 3+.
- Planning order (Input → Processing → Output) vs. learning order (Output →
  Input → Processing), taught as a deliberate reversal.
- Hello World; `Write` vs `Writeln` (newline vs none), reinforced with
  predict-the-output practice.
- Reading real compiler errors as an explicit, taught skill - several
  deliberately-broken snippets, each paired with genuine `fpc` output.
- `Readln` for input, paired into a first interactive program; a light first
  taste of Processing (e.g. sum two numbers) - kept minimal, since
  variables/types are lesson 3's whole job, not this one's.
- Formal program structure, taught here for the first time: `Program Name;`
  (name matches the source file - convention, not a compiler rule; FPC names
  the executable after the file, not the declared program name) and one
  `Begin … End.` block (`../pascal-house-style.md` §1).
- This is also the first lesson where the house-style mark deduction applies
  (§4 of `../content-voice-and-pedagogy.md`) - but only against what it
  actually teaches: indentation, `//` comments, program structure. No
  variables yet, so no naming check here.

## Decisions

- **Code compiles and runs on the server, with real `fpc`** (settled 11 September
  2026). The lessons teach reading genuine compiler errors, so the text must be
  real `fpc` output - which rules out a browser-side compiler. It means a `code`
  block type, a compile queue shaped like `bin/markqueue.php`, a sandboxed worker
  and an API endpoint. Chris chose to build it now rather than later.
  **Sandbox design tested and validated against the live server, 11 September
  2026 - see [../compile-subsystem-design.md](../compile-subsystem-design.md).**
  Nothing else built yet - no `code` block, no queue table, no worker, no API
  endpoint. That file is the handoff for whoever builds them.
- **FPC 3.2.2 everywhere.** Locally with Lazarus; on the server apt installs
  exactly 3.2.2 (`fp-compiler`, not `fpc`). Every worked example and every
  deliberately broken one is compiled for real, so the output in the lesson is
  genuine.
- **Code questions are marked against house style as well as correctness**, from
  the first lesson. The house-style penalty is **a flat 1 mark, once per
  question**, never per violation - and the feedback always names the violation.
  What counts as house style grows with what has been taught.
- **No question totals an odd number of marks** (see platform.md, decision 8).
- **Run `php bin/check-popup-spacing.php`** after touching any `Gloss()` or
  `Aside()`.

## Resolved

- **House-style scope** (was an open question, resolved 11 September 2026):
  [../marking-house-style.md](../marking-house-style.md) (formal IEB practical
  exam marking, summative) and this course's own 1-mark deduction (formative
  in-course practice) cover different things on purpose - each file now says so
  in its own scope note.
