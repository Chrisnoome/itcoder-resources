# Writing the CAT Theory lessons - the brief

Chris, 6 October 2026: "do the whole set of cat theory lessons. be interesting
and creative - and more simple than the it course, more step by step
explanations for CAT level. plan videos for the lessons that the video chat
can create. aim for videos of - 10 minutes if possible. all video content must
be available in the text as well." Then: "new full courses named by grade as
for it", Grade 10 first.

This file is the brief every lesson is written to. Read it all before writing.
The plan is [cat-course.md](cat-course.md) (section 3.2 for the lesson list).

## Where things go

| What | Where |
|---|---|
| The course | `cattheory10` in `lib/course.php` (draft), later `cattheory11`, `cattheory12` |
| Lesson map | `AIPascalCourse/content/cattheory10/index.php` - ids, titles, summaries are set; do not change ids |
| A lesson | `AIPascalCourse/content/cattheory10/<lessonId>.php` |
| Video plans | `AIResources/courses/cat-videos/<lessonId>.md`, one file per lesson |
| Everything else a chapter produces | one notes file per writer (see "Your notes file") - merged into glossary.php, caps.php and sags.php afterwards |

**The model lesson is `content/catpilot/computer.php`** (the pilot, approved
standard). Copy its shape exactly: the doc comment, the `$img` helper, the
quote card, `contents`, sections each opening with a `block-anchor`, Gloss()
for every new term, a question after every section, `why` lines, a
Learn / Memorise table, callouts, a BoardSection, a Scenario, the study block.

**The source** for each lesson is the IT Theory Grade 10 lesson on the same
topic (`content/theory10/<id>.php`; the mapping is in
[../cat-it-theory-reuse.md](../cat-it-theory-reuse.md) section 2.1). Read it
first. Trust its facts. Reuse its drawings, pictures, examples and good
explanations - but **rewrite it at CAT depth**, never copy it whole.

**The syllabus** is the Grade 10 lines of [../cat-caps.md](../cat-caps.md)
(section 3, Grade 10, terms 1-4) and [../cat-sags.md](../cat-sags.md)
(section 7, Appendix L - the Grade 10 lines of 7.1-7.4, and 8.1 for file
management). Every line that belongs to your lessons must be taught. Use
[../cat-caps-exam-analysis.md](../cat-caps-exam-analysis.md) and
[../cat-ieb-exam-analysis.md](../cat-ieb-exam-analysis.md) for how it is asked.

## Simpler and step by step - what that means

A CAT pupil is not an IT pupil. CAPS says to "deal with hardware and software
at a non-technical level". So:

- **One idea at a time.** Say what a thing is, then what it is for, then one
  everyday example - in that order, every time.
- **Explain every term the moment it appears**, in plain words, then use it.
  No term is used before it is explained.
- **Walk through processes as numbered steps.** How a card payment works, how
  to rename a file, what happens when you press the power button - `<ol>`,
  one action per step, the way you would show a friend.
- **Worked examples before questions.** Show one done, then ask the pupil to
  do one like it.
- **Cut IT depth.** No binary, ALU, registers, buses, packets, DNS lookups,
  protocols by layer. If the IT lesson has it and the CAT syllabus does not,
  it goes (or one sentence of Good to Know, at most).
- **Short paragraphs** - often one sentence. Lists for anything enumerable.
- **Check often.** A small question after every section, not a pile at the
  end. Most should be easy: the pupil should feel they are getting it.

## Interesting and creative

- **Open with something real**, not a definition: a situation the pupil
  knows (the robot that will not change, the till at Checkers, the data
  bundle that ran out).
- **Recurring people** (the same person is the same person in every lesson):
  - **Thabo** - a Grade 10 CAT pupil in Pretoria, phone always in hand.
  - **Lerato** - his older sister, first-year student, the family's tech
    support.
  - **Gogo Dlamini** - their grandmother, new to her smartphone, sharp as a
    tack.
  - **Mr Botha** - runs Botha's Bakery in Centurion: one till, a laptop,
    an old printer, a WhatsApp business number.
  - **Ms Naidoo** - the CAT teacher at **Phumlani Secondary** (Soweto), the
    school with the absentee SMS system in lesson 1.
  Use them where they fit; do not force them into every lesson.
- **Analogies from home**: a fridge for RAM vs the freezer for storage, a
  post office for e-mail, a key ring for passwords.
- **Activities that make the pupil do something**: sort into groups
  (`match` with `'display' => 'groups'`), put steps in order (`order`),
  `reveal` ("decide first, then open"), spot-the-mistake (`markwords`),
  fill-the-gaps (`dragwords`), picture questions (`Identify()` with the
  pictures in `public/assets/match/theory10/`), a `dilemma` where it fits.
  Look at how the IT lessons use them and copy the array shapes exactly.
- **Margin**: 3-6 doodles per lesson (existing drawings only, see "Drawings"),
  2-4 `MarginNote()` "Did you know?" facts, each true and checkable.

## Voice and rules

[../writing-style.md](../writing-style.md) and
[../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md) apply in
full. The ones most often broken:

- South African English (colour, centre, organise, licence, programme / but
  program for software). Rand prices including VAT, round and plausible.
- Short sentences. Hyphens, never em dashes. "Pupil", never "learner".
- No writerly lines ("here is the part people forget", "that word does a lot
  of work"), no meta pointers ("as the next section shows" - link the anchor
  instead), no banned words (genuine, for real, binds, reach for, lean on,
  promise as a metaphor).
- **Never name the SAGs, CAPS documents or "Paper 2" in anything a pupil
  sees**, and never "the exam expects" with a citation. Doc comments may cite.
  Saying "the IEB calls it X, CAPS calls it Y" is fine (the pilot does).
- Content rules from IT Theory lesson 1 (theory-course.md, "Content rules
  from the lesson 1 review"): South African and current, prices with VAT,
  "power cut" with load shedding as one example, decimals with a full stop,
  KB = 1 000 bytes, size examples starting at SA budget devices,
  `bestlessons.co.za` as the example web address.
- **Brand names**: fine as examples in the text; never the answer to a
  question unless it asks for one.
- **A quote at the top** from the quote bank (`word documents/_ALL_QUOTES.docx`
  - unzip it and read `word/document.xml`), with a portrait from
  `public/assets/quotes/` when the person has one there (`quote-card` as in the
  pilot). Not a quote another CAT lesson already uses. Credit as the pilot does.

## Board sections

`...BoardSection ('ieb', 'Title', [blocks], 'note')` or `'caps'`. Content one
board alone examines goes inside one. Taught to everyone; the questions count
only for that board. The note is a short reason to read it anyway, never a
citation. Grade 10 examples: algorithms (IEB), POPI (CAPS), cryptocurrency
(IEB), digital divide naming (IEB). Check the two syllabus files for your
lessons.

## Questions and marks

- **CAT question shapes**: give TWO; ONE advantage and ONE disadvantage; the
  difference between X and Y; name the term; which device/feature for this
  job. Written parts are 1-2 marks, now and then 3-4 in a Scenario. Nothing
  bigger.
- Every `quiz`, `select` and `match` has `why` lines for each wrong choice.
  Every question has an `explain`.
- `written`: `prompt` with `prompt-setup` / `prompt-ask` and a `<ul>` of
  hints; a pupil-facing `rubric`; a detailed `markerRubric` (what earns each
  mark, accepted alternatives, what earns nothing - bare "faster", brand
  names, devices given as input).
- Question ids: a letter for the type and the lesson in camelCase, unique in
  the lesson (`q1Processing`, `t1Embedded`, `w1Gigo`, `m1Cycle`, `s1Costs`,
  `g1Microwave`, `o1Steps`). Use the lesson's own short tag instead of `1`
  where it helps (`qPrinterInk`).
- Marks: auto-marked questions count double (marks x 2). Work out each
  board's total (questions inside a BoardSection count for that board only)
  and write both in the doc comment. **Both totals must be even.** Aim for
  40-70.
- One `Scenario()` near the end, 3-5 parts, an SA situation, as the pilot.
- One `study` block last, with `keyTerms`.

## Drawings and pictures

- `Doodle()` and `DesignFigure()` take a name in `public/assets/doodles/`.
  **Use only names that exist there** (`ls` it; check the exact file). A
  missing name draws nothing. The IT lessons' drawings are the first place to
  look.
- CAT has its own art style (marker and highlighter, Clicky the mouse pointer -
  [../brand/cat-art-style.md](../brand/cat-art-style.md)). Name the IT drawing
  (`'ram-fridge'`, not `'cat-ram-fridge'`): in a CAT course the site uses
  `cat-<name>.svg` automatically once the Art chat has drawn it.
- Pictures: `public/assets/match/theory10/` and others the IT lessons use,
  through the `$img` helper inside `Figure()`. Every picture and figure has a
  caption.
- In your notes file, list every drawing you used (for the Art chat to
  redraw), and up to 3 new drawings per lesson you wish existed, one line each
  describing the joke or the diagram.

## Videos

Plan **1-3 videos per lesson**, one per main idea or skill, **each under 10
minutes** (5-8 is the sweet spot). The video chat makes them (method:
[tutorial-videos.md](tutorial-videos.md) - Chris's cloned voice, narration
first, board scenes cued to lines, screen recordings in the VM, "Hi, and
welcome to BestLessons." and the BestLessons sign-off). For CAT the board is
drawn in **the CAT marker style with Clicky** (cat-art-style.md), not the IT
blue pen, and the yellow highlighter rule applies: any words on screen being
talked about get a yellow highlighter band.

**Everything in a video must also be in the lesson text** - every fact,
example, step and tip. A pupil who cannot watch loses nothing. The video
explains it differently (moving, drawn, shown on a real screen), never
teaches more.

In the lesson file, put a comment where each video will go:
`// VIDEO cat10-05.1: Inside the box - goes here once on YouTube`. Never add a
`video` block (no YouTube id exists yet, and ids are never invented).

### A video plan file (`cat-videos/<lessonId>.md`)

```markdown
# CAT 10 lesson 5: Inside the box - videos

## cat10-05.1 What's inside the system unit (about 7 min)

**Goes:** after section `#motherboard` (lesson anchor).
**The pupil can afterwards:** name the main parts inside the case and say what each does.
**Thumbnail:** tag `CAT · HARDWARE`, title "What's *inside* the box?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Thabo's laptop
   won't switch on ... (2-4 sentences of draft narration, Chris's voice)
   > Board: a closed laptop, Clicky knocking on the lid.
2. **The motherboard (0:40-2:10).** ...
   > Board: the motherboard drawn piece by piece; yellow highlighter on "CPU".
   > Screen: (only if a real screen recording in the VM is needed - say exactly what is clicked)
...
N. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the motherboard joins every part | `#motherboard` |
```

Draft narration is welcome but short: the video chat writes the final script.
Directions as labelled `>` lines (Board, Screen, Note). Number videos
`cat10-<two-digit lesson>.<n>`.

## Your notes file

One file per writer at the path you are given, with these sections:

1. **Lessons written** - id, marks CAPS / IEB, one line on anything unusual.
2. **Glossary rows** - PHP, the row format of `content/theory10/glossary.php`
   (`[term, 10, true, lessonId, anchor, definition, extras]`), one per Gloss()
   term, anchor = the `block-anchor` where it is taught. Plain-text
   definitions; keep each identical to the Gloss() text.
3. **CAPS lines** - PHP, `'lessonId' => [[10, term, 'what'], ...]`, the
   wording taken from cat-caps.md (as `content/catpilot/caps.php`).
4. **SAGs lines** - PHP, `'lessonId' => [[10, 'topic', 'what'], ...]`, topic
   `'1'`-`'4'` for 7.1-7.4, `'P1'` for 8.1 (as `content/catpilot/sags.php`).
5. **Drawings** - used, and wished for.
6. **Anything you were unsure of** - a fact you could not check, a syllabus
   line you could not place.

## Checks you cannot run

There is no PHP on this machine; the lead lints and runs `bin/check-*.php` on
the server afterwards. So be careful:

- Nowdoc (`<<<'HTML'`) for HTML, joined with `.` to Gloss()/Doodle() calls
  exactly as the pilot does. The closing `HTML` sits at the start of its line.
- Single-quoted PHP strings: escape every apostrophe (`it\'s`), or use double
  quotes.
- Every array element ends with a comma; every block is `[ ... ],`.
- `match` pairs: left keys unique; for groups, `groups` lists every value.
- Don't commit, publish or touch any file outside your own lessons, video
  plans and notes file.
