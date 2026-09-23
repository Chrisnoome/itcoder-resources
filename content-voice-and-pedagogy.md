# itcoder platform — content voice & pedagogy guidelines

**Scope:** every lesson written for the itcoder platform from 2026-09-11
onward — Pascal first, and any future revision of the AI course. It does not
retroactively rewrite itcoder's live AI-course lessons; those stand as they
are unless a lesson is actually being touched.

**Source:** the voice is distilled from `word documents/` in this folder —
Chris's *learningopportunities.co.za* IT textbook (2018-2019, exported from
RapidWeaver: `bc_*`, `hw_*`, `im_*`, `dc_*`, `sw_*`, `si_*`). That corpus and
itcoder's already-calibrated style (see [writing-style.md](writing-style.md)
in this folder - moved there from itcoder's `CLAUDE.md` on 2026-09-11) are not in conflict — this document merges them and adds
three things that are new: popups, question-first pedagogy, and heavier use
of video/animation.

## 1. The voice

Everything [writing-style.md](writing-style.md) already says still holds: plain conversational
English, direct address ("you"), short sentences, bulleted lists for anything
enumerable, hyphens not em dashes, local examples, no unexplained jargon,
never talk down. Read that section before writing a line.

**Reminder (Chris, 2026-09-13, caught after a rubric line read "a
mechanical, syntax-level checklist, not a holistic judgement"): every piece
of text a pupil reads - prose, a prompt, an explain, a pupil-visible
rubric, feedback - has to sound like it's talking to an actual 15-year-old
who has never programmed before, not to a teacher or another developer.**
That applies even to marking/assessment language, which is where jargon
creeps in easiest ("holistic", "criterion", "band", "checklist") - say the
plain-English version instead, or don't mention the marking mechanics to
the pupil at all if they don't need to know. If a sentence would need
explaining to a first-year Grade 10 pupil before they could use it, rewrite
it rather than footnote it.

What the old corpus adds on top of the base rules:

- **Vivid, everyday analogies, pushed further than feels natural at first.**
  *"It's like if your head is the chip and the CPU is the brain - with 2 cores
  you could fit two brains inside your head!"* This is the single strongest
  fingerprint of the voice. Reach for a physical, bodily, or domestic
  comparison before an abstract one.
- **Rhetorical questions as a teaching device, not decoration.** *"Why? ...
  Isn't that the point of questions? You don't know the answers immediately
  and need to do a bit of work to find out what you need to know!"* Questions
  are asked and then genuinely left unanswered for a beat, to make the reader
  sit with them.
- **Real-world worked examples, narrated step by step, in first person plural
  or direct address.** The POS-till, ATM, and cellphone-billing walkthroughs
  in `bc_define_ict.docx` are the model: a system the learner has personally
  used, taken apart input → processing → output, told as a small story with
  concrete numbers.
- **Bold, flat verdicts.** *"YES, RAM is expensive!"* *"The answer is NO."*
  State the conclusion plainly before or after the reasoning - don't bury it.
- **A personal aside, dropped in without ceremony.** *"My Mac Pro has two
  built in AMD graphics cards..."* Chris's own hardware, own experience, own
  opinion, stated as itself, not flagged as an anecdote.
- **Serious topics get the same treatment as fun ones - no change in
  register.** *"The Digital Divide is a human tragedy on a very large
  scale... putting yourself on the right side of an invisible line that can be
  as difficult to cross as the Grand Canyon."* Plain declarative sentences,
  a strong physical image, no hedging, no lecture tone.

### What to leave behind

The old corpus is raw manuscript, not finished copy, and carries artifacts of
its old platform that are not part of the voice:

- Meta-commentary about the page itself - *"A short description for this
  section to get the users attention. Something catchy that makes them want to
  look!"*, *"Comment on the definition of a computer…."* / *"About the
  definition of a computer.."* headers. These are authoring notes, not text
  for a learner. Cut them; say the thing directly.
- Navigation cruft - *"Back to the top of this Panel"*, *"Return to the top of
  the Dropdown List"*. Artifacts of the old page mechanics; the platform's own
  nav replaces these.
- Raw widget config (the embedded YouTube-playlist JSON blocks). Video
  selection now works the way itcoder already does it - see §4.
- Typos and half-finished sentences (*"yo understand"*, *"Returm"*, *"the
  the"*). This was unedited working manuscript.

### A question's own prompt must be broken up, not one dense paragraph

Made a rule 13 September 2026 (Chris, caught on a Pascal `code` prompt that
crammed three separate expressions and an instruction into one run-on
sentence, `2 + 3 * 4`, `(2 + 3) * 4` and `10 / 2 * 5` all inline with the
prose around them - hard to actually read, even though every word in it was
correct). This applies to any `prompt` field of any length, not just
`code` blocks:

- **A list of separate things - separate expressions, separate steps,
  separate items to tick or match - goes in an actual `<ul>`/`<li>` list,
  never run together inline in one sentence.** Compare "Fill in the gaps to
  print the answers to these three expressions, one per line, each with a
  label: `2 + 3 * 4`, `(2 + 3) * 4`, and `10 / 2 * 5`..." (hard to parse)
  against the same three items as three `<li>`s (obvious at a glance).
- **A prompt that mixes an instruction with a code sample and then more
  instruction** gets a paragraph break (`</p><p>`) between them, not all
  three squeezed onto one line - the code needs room to be read as code, not
  skimmed past as part of a sentence.
- This is exactly the same instinct §7's `contents` block and the rest of
  this file already apply to lesson prose - a wall of text is a symptom, and
  the fix is almost always a `<ul>` or a paragraph break, not shorter words.
  Applies equally to `quiz`/`typed`/`select`/`match` prompts, which are
  allowed the same HTML as anything else even though most of them are short
  enough not to need it.

## 2. Popups: acronyms, commands, glossary terms, humour and anecdotes

**The old site's instinct was already right** - it had click-to-toggle
sections and a "guess, then reveal" RAM-cost exercise. It just didn't have a
lightweight way to gloss a single word inline, so asides ended up as full
paragraphs breaking the flow (*"About the definition of a computer.."*,
personal digressions mid-explanation). Popups fix that: the joke, the
acronym expansion, the command reference, the anecdote all live one click
away, and the sentence around them stays clean.

**Two kinds, one mechanism** - `Gloss()` and `Aside()` in `lib/content.php`,
both rendering the same `.popup` component (click, tap, or Tab+Enter to open;
click elsewhere or Escape to close):

```php
// Glossary / acronym / command - a fact, explained on demand.
'A variable is stored in ' . Gloss ('RAM', 'Random Access Memory - the working
memory the CPU reads and writes to while a program runs.') . '.'

// Aside - a joke, a pun, an anecdote. Popup instead of paragraph.
'Every ' . Aside ('End.', 'Forget the full stop after the last End and Free
Pascal will stare back at you like you just asked it a trick question.') .
' needs its full stop.'
```

**Use `Gloss()` for:** any acronym on first use in a lesson (`IDE`, `IPO`,
`ASCII`), any reserved word or command being named rather than used
(`Writeln`, `Div`), any term that would appear in a glossary at the back of a
textbook.

**Use `Aside()` for:** the joke that would otherwise derail a paragraph, the
personal anecdote, the pun, the "did you know" tangent. If a sentence would
make Chris smile writing it but doesn't carry information the lesson needs,
it's an `Aside()`, not inline prose.

**Don't** put anything load-bearing inside a popup - a fact the learner needs
to answer a quiz question must be in the visible text. Popups are seasoning,
and a safety valve for keeping paragraphs on-topic, not a place to hide the
lesson.

## 3. Pedagogy: do this, observe, explain

The instruction is to ask more, and tell less. The old corpus already had the
right shape in places - the RAM-vs-storage cost exercise (*"Visit EveTech /
Loot... find a RAM product... divide the cost by the capacity... what do you
get?... [reveal]"*) and the Digital Divide *"click the icon to find out the
answer"* blocks are both this pattern, just built by hand each time. The
`reveal` block type makes it a first-class thing to reach for:

```php
[
    'type'   => 'reveal',
    'prompt' => '<p>Run this: <pre>Writeln (5 / 2);</pre> What does it print? Try it before you look.</p>',
    'explain' => '<p>It prints <code>2.5000000000000E+0000</code>, not <code>2</code> or <code>2.5</code>.
                   <code>/</code> is always real division in Pascal, even on two integers, and Writeln shows
                   a real number in scientific notation unless you tell it not to.</p>',
],
```

**Reach for `reveal` instead of prose whenever a lesson is about to explain
what a piece of code, a calculation, or a tool does.** The instinct to fix is:
paragraph explains → learner reads passively. The pattern to replace it with:
prompt says what to try → learner does it and forms a guess → button uncovers
whether they were right and why. This is true to how the corpus already
teaches the IPO model, Boolean logic, and file handling in Appendix G - "try
it, then see" beats "here is what happens" every time it's possible.

This is not limited to code. "Look up the price of two different RAM sticks
and work out cost per gigabyte, then reveal what everyone finds" is exactly
as valid a `reveal` block as a Pascal snippet - the old RAM exercise proves
it. Anywhere a lesson currently reads like exposition, ask first: *could this
be something the learner tries and checks instead of something I tell them?*

Quizzes (and their typed-answer siblings - see §4) stay for testing recall and
judgement, two attempts, answer withheld until spent. `reveal` is for teaching
a new idea through doing, before there is anything to test.

**A question may never test a word or fact the pupil could not already have
read in plain, always-visible prose** (Chris, 2026-09-12, caught in the AI
course's lesson 1: a `typed` fill-in-the-blank asked for "machine ______"
right after a `reveal` whose hidden `explain` was the only place the phrase
"machine learning" had appeared - a pupil who skipped clicking the button
had no way to have seen the word at all). A `reveal`'s hidden `explain` can
still carry the lesson's real teaching moment (the Pascal course's jam-
sandwich reveal does exactly this, with `THE COMPUTER IS STUPID` inside the
hidden explain and a typed question testing it soon after) - but only when
the fact stays available regardless of whether the button was pressed, e.g.
because normal prose states it too, or because the quiz/typed prompt itself
supplies enough to work the answer out. If a question's *only* route to the
answer is a specific word or fact sitting inside a popup or a hidden
`explain`, put that word or fact into ordinary prose as well, before writing
the question.

## 4. Mixed question types, and how they're scored

Multiple choice is not the only self-marking shape available, and shouldn't
be the only one reached for. The `typed` block type (2026-09-11) covers word
scramble, fill-in-the-missing-letters, complete-the-sentence, and
name-the-exact-term - anything where the pupil types free text that gets
checked against an answer, rather than picking from a fixed list. `kind` only
picks the label shown above the prompt; add a new `kind` value freely, the
mechanics (two attempts, server-side check, answer withheld until spent) are
the same for all of them:

```php
[
    'type'    => 'typed',
    'kind'    => 'scramble',        // or 'blank', 'complete', 'exact', ...
    'id'      => 't1BooleanScramble',
    'marks'   => 1,
    'prompt'  => 'Unscramble these letters to find the type that holds exactly True or False.',
    'display' => 'O B N A E L O',   // the stimulus shown - scrambled letters, a blanked word, ...
    'answer'  => 'Boolean',         // or an array, e.g. ['Integer', 'whole number'], if more than one wording is fair
    'explain' => 'Boolean - named after George Boole, holding exactly True or False and nothing in between.',
],
```

Reach for one instead of another multiple-choice question whenever recall of
an exact word matters more than recognising it in a list - a keyword, a
reserved word, a term just introduced. `blank`/`scramble` in particular test
whether a word actually stuck, not just whether it looked familiar next to
three wrong options.

**A `blank` question renders as real per-letter boxes** (2026-09-13) when its
`display` uses underscores for the missing letters - `h _ r _ e _ s`, not a
single text box below a hint. **Roughly half the letters should be blanked,
not just one or two** (Chris, 2026-09-13, caught on a `harness` question that
blanked only 2 of 7 letters - too easy to read off the shape of the given
letters rather than actually recall the word). Too few blanks and the pupil
is pattern-matching a shape, not recalling a spelling; too many and there is
nothing left to anchor a guess. About half - rounding however you like - is
the rule of thumb for every new `blank` question. `_` is the only marker that
creates a box; spaces in `display` are stripped for spacing only and never
create a box of their own, so `h _ r _ e _ s` and `h_r_e_s` behave
identically - use whichever is easier for you to read while writing it.

**A typed answer that is code is marked like code (Chris, 23 September
2026, after `Writeln('You have ',5,' apples');` was marked wrong).** When an
accepted answer is Pascal code (`TypedAnswerIsCode()` in `lib/content.php`:
an assignment, a call, a comparison, a heading...), the pupil's answer is
compared with the spacing the compiler ignores taken out, capitals ignored and
the final `;` optional - text inside quotes still has to match. A code answer
that matches no listed wording then goes to the AI checker
(`CheckCodeAnswer()`, as `checkedcode` does), so a correct but differently
written line is not marked wrong; if that check fails, the exact-match verdict
stands. Still list the likely wordings in `answer` - the AI is the fallback.
The hint under the box follows the answer: "Only one word needed!" only when
the main answer is one plain word; code gets "Type the Pascal code - spacing
and a missing ; do not matter."; anything else (a phrase, a line of output)
gets no hint.

**Scoring, for both `quiz` and `typed` (2026-09-11):** every question declares
`marks` - its base value, minimum 1. The engine doubles it so a second attempt
can earn exactly half without ever using a fraction: right first attempt earns
`marks x 2`, right second attempt earns `marks` (half the doubled total),
wrong twice earns nothing. A question left at the default (`marks` omitted,
treated as 1) is worth 2 on the first attempt, 1 on the second. A question
declared `marks => 3` is worth 6 on the first attempt, 3 on the second. Set
`marks` above 1 deliberately, for a question that's doing more work than a
one-line recall check - not as a rule of thumb, a considered choice per
question.

**Every written question's `prompt` must be unambiguous about what a good
answer covers (Chris, 17 September 2026 - applies to every course, every
lesson, going forward).** Found from a real pupil answer: AI lesson 1's
`w1ExplainToGogo` ("explain ChatGPT to your gogo") was marked down for
using technical language, but nothing in the pupil-facing prompt actually
told them to avoid it - the constraint only lived in the rubric, which the
pupil never sees. That's not a fair test; it's a test of guessing what the
rubric wants. From now on, every written `prompt` needs both of these,
where they're genuinely relevant to that question (not padding a
one-line factual-recall prompt that doesn't need either):

- **Explicit guidance on what to avoid**, stated plainly, when the
  question is testing something a pupil could easily miss by defaulting
  to the "safe" technical answer - e.g. "Explain this without using the
  words X, Y or Z" for a plain-language/audience-appropriate question, or
  "you don't need to mention every detail, just the ones that matter
  here" for a question that's really testing judgement about what's
  important, not exhaustive recall.
- **A short bulleted list of what the answer should cover**, inside the
  prompt itself, not buried in the rubric alone - 2-4 bullets is normal,
  naming the ideas without spelling out the exact wording (the same
  "never hand over the literal expected answer" rule the rubric-format
  guidance below already applies to `rubric`/`showRubric` applies here
  too - bullets name what to address, not what to say about it).

This doesn't replace `rubric`/`markerRubric` - those still carry the exact
marking detail for the AI marker. It means the pupil-facing `prompt` and
the marker-facing rubric should never disagree about what's actually being
asked for, and a pupil should never lose marks for a constraint they were
never told about.

**Written questions are unaffected by the doubling mechanic above** -
`markMax` and quality-judged partial credit (0..markMax, by the AI marker or a
teacher override) already worked this way and still does - **but they are not
exempt from the even-totals rule (2026-09-11): no question of any type may
carry an odd total mark allocation.** The doubling rule already makes every
quiz/typed/order total even automatically; for `written`, `markMax` itself
must be chosen even, since nothing else enforces it. A lesson's final written
question is allowed to be worth more than the default - lesson01 and
lesson02's both sit at `markMax => 4` rather than 1 - but whenever one does,
the rubric must break the marks down per idea, not just state a total, and any
single criterion may be weighted at 2 (or more) marks rather than 1 when it is
doing more work than the others - state why in the rubric when you do.
`w1LanguagePurpose` in lesson01 is the model to match: one mark per correctly-
identified language purpose, two marks for the reasoning that connects them
(explicitly the harder, synthesising part) - four marks, three named criteria
a marker (human or AI) can check off, never a bare "award up to N marks for a
good answer."

**Rubric format is set by `markMax`, at a threshold of 10 (Chris, 12
September 2026):**

- **`markMax` under 10** - the per-idea checklist rule above applies as
  written: one mark per named criterion, `w1LanguagePurpose` in lesson01 is
  the model. `showRubric` is left unset - the rubric still drives the AI
  marker (`bin/markqueue.php` sends it on every written answer regardless of
  `showRubric`), it is just not shown to the pupil before they write.

- **`markMax` of 10 or more gets `showRubric => true`, and must be written
  as IEB SAGS-style level bands, not a per-idea checklist.** Every written
  question at or past this size shows its pupils the rubric before they
  write, and the rubric itself changes shape to suit: broad criteria
  (roughly 4-8 marks each, few enough that a pupil can hold them in mind
  while writing), each broken into 3-4 mark-range bands describing the
  *quality of thinking shown*, not individual facts to tick off - e.g. "5-6:
  gives a clear, accurate account... 3-4: gets the general shape right but
  one part is thin... 1-2: shows some awareness without a workable
  explanation... 0: no credit-worthy understanding." Marked holistically,
  after reading the whole answer, not line by line.

  This exists because the AI course's end-of-lesson-8 final assessment
  (`w1FinalAssessment`, `markMax => 30`, a full-page essay) was originally
  written as a per-idea checklist, itemised into ~2-mark micro-facts ("2
  marks - says it is a file of numbers", "2 marks - explains next-token
  prediction", and so on) - Chris judged that too specific for a rubric
  shown to pupils at that scale: it reads as a box-ticking exercise rather
  than a mark of understanding, the wrong signal for a capstone essay.
  `w1FinalAssessment` in lesson08 is the model to match for a question at
  or above this threshold.

  **A rubric shown to the pupil must never spell out the literal expected
  answer (Chris, 2026-09-13).** Whether it's per-idea checklist or banded,
  `rubric` (and anything else `showRubric` displays) should describe what's
  being checked in terms a pupil can use to guide their effort, never hand
  over the exact shape of a correct response - e.g. "1 mark for formatting
  that matches what you've been taught, 13 marks for working code, losing 1
  for each mistake" is fine to show; a line-by-line breakdown of the exact
  keywords and punctuation expected is not, because it stops being a test
  once the pupil can just copy the checklist. When the real marking
  genuinely needs that precision (checking for specific tokens, syntax, or
  wording), set **`markerRubric`** to the exact, detailed version instead -
  `bin/markqueue.php` sends `markerRubric` to the AI marker when present,
  falling back to `rubric` when it isn't. `markerRubric` is never displayed
  to a pupil under any circumstance, so it can be as technical and exact as
  the marking actually requires.

  **Format each band as its own bullet, `mark` or `low-high` then a colon**
  (`- 5-6: description`, `- 0: description`) - `RubricListHtml()` in
  `lib/content.php` detects a block where every bullet matches
  `/^\d+(-\d+)?\s*:\s*/` and renders it as a two-column table (mark left,
  explanation right; `.rubric-table` in `style.css`) instead of a plain
  list. A block that mixes in one bullet without that prefix - "General
  marking notes", for instance - falls back to a plain list automatically,
  so notes and instructions to the marker still belong as ordinary bullets
  outside the banded criteria, never squeezed into the `mark:` shape just to
  join the table.

**Code-writing questions and house style (2026-09-11):** any question that
asks the pupil to write actual Pascal - not just explain something in prose -
is marked against `AIResources/pascal-house-style.md` as well as
correctness, from the very first such question in the course ("Proof of
life") onward. Even simple code must meet these standards - this starts on
day one, not once the code gets complicated enough to need it.

**Never say "house style" or "convention" to a pupil (Chris, 2026-09-13).**
Those are our internal terms - this file, `pascal-house-style.md`, and
rubrics written for the marker can keep using them freely. But any text a
pupil actually reads - prose, a prompt, a pupil-visible rubric, feedback -
must instead say something to this effect: "on how you format and lay out
your code - it must match what you have been taught and shown. This is not
because it is Pascal rules but because we are trying to teach you good
programming habits." Adapt the wording to fit the sentence, but keep both
halves: what's being checked (formatting/layout matching what's been
taught), and why (a habit being built, not an arbitrary Pascal rule).

The house-style penalty is a single **flat 1-mark deduction**, applied once
per question if the code breaks house style in any way - never cumulative,
never per-violation, never per line. Three separate style problems in one
answer still cost exactly 1 mark, not 3; this keeps the penalty proportionate
for a beginner making several small slips at once, while still making the
point that style is graded, not optional. State this in the rubric as a
deduction against the correctness marks above it, e.g. "Deduct 1 mark
(applied once, regardless of how many separate style issues are found) if
the code does not follow house style - indentation, comment format, program
structure, etc." **Always name the specific violation in the written
feedback even though the numeric penalty is small** - the mark is a nudge,
the feedback is the actual teaching.

What counts as "house style" for this deduction grows as the course teaches
more Pascal - only grade a question against material already taught by that
point, never retroactively. "Proof of life" can only reasonably grade
indentation and program structure (a meaningful program name, one
`Begin … End.` block) - it doesn't teach comments or variables at all, so
neither belongs in that question's marking yet. "Every box needs a label"
introduces variables next, so meaningful variable naming
(`pascal-house-style.md` §2 - never a single letter) joins the graded set
from there; `//` comments join whichever later lesson actually teaches
them - not before. Procedure/function naming and
structure join once those are taught, and so on - the checklist accumulates,
lesson by lesson, matching `pascal-house-style.md`'s own "Quick checklist".

**This is not the same policy as `marking-house-style.md`**, which says style
is never a criterion - that document governs formal, summative IEB practical
exam marking against an official memo. This one governs itcoder's own
formative in-course practice questions. Deliberately different, not in
conflict: the course-work builds the habit of clean code before a candidate
ever sits the real exam, where style rightly isn't examined at all.

## 4a. AI marking: flexibility and feedback format (Chris, 17 September 2026)

Found via a real pupil answer: lesson 7's conversion capstone asks for "at
least two different conversions from this lesson (`IntToStr`, `StrToInt`,
`Ord`, `Chr`, or a Real/Integer conversion)" - a pupil used `Chr` correctly
(converting an Integer to a Char, then concatenating that Char onto a
String, which is genuinely free per that lesson's own conversion table) and
the AI marker docked marks for "not using `IntToStr`." `Chr` was one of the
explicitly listed acceptable conversions; the marker just didn't treat the
list as a genuine choice.

**The rule going forward: when a rubric offers a choice - "either A or B",
"any two of X/Y/Z" - award full credit for ANY qualifying option actually,
correctly present in the pupil's code, never only the specific example used
to illustrate the rubric.** `bin/markqueue.php`'s system prompt (both the
shared strict-marking block and each course's own intro) must say this
explicitly, not leave it implied by the rubric text alone.

**More broadly: if the pupil's code would genuinely work and produce the
right result, it earns full marks - even when it isn't the exact approach
the rubric-writer had in mind**, provided it still satisfies whatever the
rubric is actually checking for (which conversions were used, whether a
branch was taken, etc.). Strict marking means *marking only what is
actually there, not giving credit for a near-miss* - it does not mean
*penalising a correct answer for taking a different, equally valid, correct
route to it.* Both halves matter and are not in tension once stated this
way; the marking prompt should say both, together, not just the stricter
half.

**Feedback format (Chris, 17 September 2026):** AI-marked feedback (written
and code questions alike) must now be structured, not one plain paragraph:

1. A short general comment first - one or two sentences, what the answer
   got right and the overall impression.
2. A blank line.
3. **Where you lost marks:** (bold heading) followed by a bulleted list,
   one bullet per thing that cost marks - concise, one line each where
   possible.
4. If nothing was lost, say so plainly instead of forcing an empty list -
   "Full marks - nothing to flag here" or similar, no heading needed.

This replaces the previous "plain text only, no markdown, no bullet points"
instruction in `bin/markqueue.php` - that instruction is now wrong and
should be removed, not just relaxed, everywhere it appears in the marking
prompt. Feedback stays warm, plain South African English otherwise - short,
concrete bullets, not a wall of prose repeating the rubric back at the
pupil.

**The shape is not optional, and is enforced (Chris, 19 September 2026).** Real
feedback came back as one wall of text, and with the heading inline in the middle
of a sentence ("...explain why. **Where you lost marks:** - You did not... - You
did not..."). The rule, for every AI-written feedback and analysis:

- The general comment is **paragraphs of one or two sentences**, never one
  dense block.
- The bold heading (**Where you lost marks:**, and for an analysis **Things to
  check:** / **Ways to improve it:**) is **always on a line of its own**, with a
  blank line above it.
- **Every bullet is on its own line**, starting `- `. Never run together.
- Hyphens with a space each side, never em dashes; no "genuine/genuinely",
  "for real", "lean on", "reach for".

It is enforced in code, not left to the model: `lib/feedback.php`
`NormaliseFeedback()` puts any feedback into that shape (it changes shape only,
never a fact, and is idempotent). It runs when feedback is stored
(`bin/markqueue.php`, `lib/analyse.php`), and whenever it is shown - the lesson
page, the polling APIs and the teacher's `pupil-work.php` - so old text is
tidied as it is read. `bin/reformat-feedback.php --apply` rewrites what is already
stored. Checks: `php bin/check-feedback-format.php`. The marking prompt states the
shape with an example; if you change the prompt, keep the example.

## 5. Video links and animated explanations

The old site put a curated video section under *every* major subtopic, not
just once per lesson - `bc_define_ict` alone has seven ("Supercomputers",
"Mainframes", "Data Centres"...). Match that density rather than itcoder's
one-video-per-lesson norm: **a short video per subtopic that has one to
show**, not a single video bolted onto the top of the lesson.

The mechanics are unchanged from itcoder: a `video` block per spot, with a
vetted `youtubeId`. Never invent an id.

**Pascal course: no video placeholders - a rule for the Pascal course only
(Chris, 23 September 2026).** In the Pascal course, never write a `video`
block with an empty `youtubeId` (the amber search-link box). Chris names any
video worth adding; until then there is no block at all. Every blank one was
removed from lessons 1-17, and `php bin/check-videos.php` fails if one comes
back. Other courses (the AI course) may still use placeholders.

**Animated explanations** are new: a short, looping visual for a mechanism
that is genuinely hard to picture from text alone - a sort dragging elements
past each other, a variable's value changing frame by frame through a trace
table, parameters being passed into a method. Options, cheapest first:

- An inline SVG built for the lesson (see `artifact-diagramming` for how to
  keep these legible and theme-aware) - best when the platform needs to
  control exact colours/labels and there's no natural video for it.
- A short GIF or silently-looping `<video>` sourced or made for the specific
  mechanism, embedded like an image.
- A `video` block pointed at a short, vetted animation someone else made
  (many exist for sorting algorithms and CPU cycles) - cheapest, but still
  needs vetting like any other video link.

**"Try this" interactives (22 September 2026, Chris asked for them):**
`public/assets/pascal-tryit.js`. Put `<div class="tryit" data-tryit="NAME"></div>`
in a prose block (title it "Try this: ...") and the script builds it - no
server, nothing saved, no marks. Built so far, all in lesson 14:
`callStepper` (step through calls, with the line running, where Pascal is,
local variables appearing and vanishing, and the screen so far),
`parameterMachine` (DrawLine's values landing in its parameter slots, plus the
real errors for swapped or missing values) and `functionMachine` (a value in,
one typed answer out). Added the same day for the earlier lessons, one or
two per lesson: `writeOrWriteln` (lesson 2), `crtColours` (3), `swapBoxes`
(4, memory boxes through a swap), `readlnTester` (5 - every type x input
result copied from a real run, including the surprise that `12 apples` into
an Integer stores 12), `divModSweets` and `roundTrunc` (6), `asciiExplorer`
(7), `gradeBand` (8), `busPlanner` (9), `forCounter` (10), `shapeDrawer`
(11), `whileVsRepeat` (12), `stringBoxes` and `caesarWheel` (13), and
`objectFactory` (16, 23 September 2026 - create TPupil objects, call their
methods, free them, watch the static count), and `fileModes` (17, 23 September 2026 -
Reset/Rewrite/Append/Readln/Writeln/Flush/CloseFile on one file, showing the
disk, the buffer and Eof; in `pascal-tryit-files.js`). Each sits
in a "Try this: ..." prose block right after the section it belongs to. Add a
new one as another builder in that file. Every
output or error it shows must be one compiled for real first.

**Try-its and diagrams wherever they add value - a rule for every lesson
(Chris, 23 September 2026).** There is no limit per lesson: when writing or
revising a lesson, look at every explanation and ask whether a try-it would
let the pupil see it happen, or a diagram would make it clearer - and add it.
Chris checks them and asks for any to be removed or changed. Typical spots:
a value being stored or changed (memory boxes), a condition being worked out,
a loop or decision running (a step-through flowchart), a function or
conversion (a machine: value in, answer or real error out), a format or
screen position.

More builders live in `public/assets/pascal-tryit-more.js`, which registers
them with `PascalTryit.register (name, fn)` (loaded after `pascal-tryit.js`) -
new ones go there:
- `flowStepper` - a flowchart that lights up shape by shape, with the
  variables, the output and a note for each step. The prose block holds
  `<div class="tryit" data-tryit="flowStepper" data-trace="JSON">` +
  `Figure (Flowchart (...))` + `</div>`. Give each shape the step visits an
  `'id' => 'name'` in `Flowchart ()` (Start and End are always `start` and
  `end`). The JSON is `{vars, steps: [{node, vars, out, note}]}`, or
  `{vars, inputLabel, scenarios: {label: [steps]}}` for a choice of runs.
  Scenario labels must not be bare numbers - JavaScript sorts those keys,
  so write `n = 17`, not `17`. Every trace is checked against a real run.
- `memoryBox` - statements run one at a time, boxes showing the old value
  struck through and the new one: `data-config` `{vars, actions, start?}`.
- `mathsLab`, `conversionLab`, `charPicker`, `comparisonLab` (`data-mode`
  text or number), `logicLab`, `formatLab` (`:width:decimals`, rounding
  half up like fpc) and `gotoGrid` (the 80 x 25 screen).

Diagrams are inline SVGs in `Figure ()` using the colour tokens
(`var(--ink)`, `var(--card)`, `var(--heat)`), so they follow dark mode.

None of this is built yet as a distinct block type - for now, drop an SVG or
`<video>`/`<img>` straight into a `prose` block's HTML. A dedicated
`animation` block type is worth adding once there's a real pattern to
generalise from, not before.

**Flowchart SVGs (Chris, 17 September 2026, site-wide rule): adjacent boxes
always need a visible gap between them.** Two shapes sharing an edge (e.g. a
decision's Yes-branch and No-branch output boxes sitting side by side) must
never touch - leave at least ~20px of background between them, with the
connecting lines/arrowheads adjusted to match, not just the boxes shifted
until they overlap the diamond or run off the canvas. Checked visually
(screenshot or browser render) after any resize, not just eyeballed in the
SVG source.

**Never use `textLength`/`lengthAdjust` to force text into a shape.**
Tried once in lesson08's flowcharts to stop text overflowing a diamond/box,
and it non-uniformly stretches the glyphs the moment the natural text width
doesn't match the forced value - visibly warped, wide-looking letters. If
text doesn't fit, widen the shape, shrink `font-size`, or split across two
`<tspan>` lines instead - never force-fit by stretching.

## 5a. Every illustration is in a box, with a caption under it - a rule (Chris, 23 September 2026)

"Put all illustrations in a box with a caption underneath the box. This makes
the text look and flow better - all lessons and a rule." Every diagram,
flowchart, picture or photo in lesson prose goes through `Figure ()` in
`lib/content.php`:

```php
. Figure ($loopFlowchart (...), 'Flowchart: reversing text')
. Figure ('<img src="..." alt="...">', 'A graphics card with the cooler lifted off.')
```

It renders `<figure class="figure"><div class="figure-box">` (the picture, in a
white bordered box) `</div><figcaption>` (the caption, under the box, outside
it) `</figcaption></figure>`. Inside a heredoc, where no function can be
called, write that same markup by hand. The caption is plain words for a
pupil: an algorithm's flowchart is captioned "Flowchart: " and what it does;
any other picture says in one or two short sentences what to notice. Never put
the caption inside the SVG itself.

Not illustrations, so not boxed: quote portraits, block icons, the diagram
inside a question (the question is its caption), and interactive widgets
(lesson 8's circuits, the flowchart-shape legend in its Learn / Memorise box,
the array demos). **Check:** `php bin/check-figures.php` - fails on any
`<svg>`/`<img>` outside a boxed, captioned figure. Applied to every lesson on
23 September 2026 (51 figures, all courses).

## 6. Quotes, with the speaker's portrait

itcoder's existing convention stands: a quote at the top of a lesson,
`<blockquote class="quote">...<cite>- Name</cite></blockquote>`. Where the old
corpus has a portrait for that speaker, pair them - it's how every quote on
the old site was actually presented, and a face makes a name stick.

`_ALL_QUOTES.docx` is the source: 331 quotes, de-duplicated across all 58 old
pages, each row carrying its quote, author, an embedded portrait thumbnail,
and its credit/licence. Pull a quote's image out with a short script over the
docx's `word/media/` (an example lives in this session's history; ask if it
needs re-doing) and save it under `public/assets/quotes/<person>.png` in the
platform. Markup:

```html
<div class="quote-card">
    <img class="quote-portrait" src="/assets/quotes/feynman.png" alt="Richard Feynman" width="64" height="64">
    <blockquote class="quote">The inside of a computer is as dumb as hell but it goes like mad!<cite>- Richard Feynman &middot; portrait: Wikipedia</cite></blockquote>
</div>
```

Carry the credit into the `<cite>` line, matching the brevity the old site
itself used (it never printed a full licence string next to a quote, just a
short "Photo by X" / "Photo from Wikipedia"). No portrait available or
suitable - use a plain `<blockquote class="quote">` with no `.quote-card`
wrapper, exactly as itcoder already does.

**One real trap:** the master index was built by de-duplicating 433 quote
cards down to 331, and a handful of rows now carry an image borrowed from a
*different* card that happened to share one. Cross-check the `Author` column
against the quote's own text before trusting the pairing - "A good programmer
always looks both ways before crossing a one-way street" is credited to Doug
Linder in the quote text itself, but the row's `Author`/`Image` columns point
at Neil Gaiman. When they disagree, trust the text and drop the image rather
than publish a face next to the wrong name.

## 7. Every lesson has a `contents` block - this is a rule, not a convention

Started 13 September 2026 as a per-lesson convention (lesson 3's `Crt`
commands, lesson 4's variable types); **made a firm rule the same day**
(Chris: "we need to make a rule that all lessons have the same"), after the
masthead's "Lesson contents" menu (below) started depending on it. Every
lesson - not just ones with an obvious run of parallel sub-topics - opens
with exactly one `contents` block, right after its opening quote/notice:

```php
[
    'type'  => 'contents',
    'intro' => 'Getting there takes a few steps, each one building on the last:', // optional
    'items' => [
        ['anchor' => 'crtClrScr', 'label' => 'ClrScr', 'note' => 'wipe the whole screen blank'],
        ['anchor' => 'crtColour', 'label' => 'TextColor and TextBackground', 'note' => 'choose the colour...'],
        // one entry per major stop in the lesson
    ],
],
```

`lib/content.php`'s `LessonContentsBlock()` finds it (the first block of
type `contents`); `public/lesson.php`'s `case 'contents':` renders it as the
same bulleted jump-list this section always described; and
`LessonContentsMenuItems()` turns the same `items` array into the masthead's
"Lesson contents" dropdown (§ below) - **one list, authored once, powering
both**. `title` defaults to "Lesson Contents" if omitted (leave it off - it
was "What's in this lesson" until 2026-09-19).

**It renders as its own boxed block** (Chris, 2026-09-19): a **cobalt** header
(`#274690`, border `#5C7CC4`, wash `#E6ECF8`) and its own `contents.png`
icon, so it reads as navigation, not lesson prose. Cobalt because every other
hue already means something - amber "must know", teal watch/try, green
question, cream optional, plum "good to know", pale blue quote. The class is
in the `position: relative` list in `style.css` (platform.md decision 21).
Because it is the block type that carries the look, every lesson in every
course got it at once - no lesson file changed.

Two ways to place the `<span id="...">` a `contents` item's anchor points
to, both valid, both checked by `bin/check-lesson-contents.php`:

1. **A generic `'anchor' => '...'` field on the block itself** (added 13
   September 2026, retrofitting the AI course, which leans heavily on
   `video` and `activity` blocks that have no `html` field to hand-write a
   span into). `public/lesson.php` renders it automatically, right before
   the block, for **any** block type:
   ```php
   ['type' => 'activity', 'anchor' => 'beatTheModel', 'title' => 'Beat the model', ...],
   ```
   **Prefer this for anything that isn't a plain `prose` block** - it's the
   only option for `video`/`activity`/`quiz`/etc., and works identically
   for `prose` too if you'd rather not hand-write a span.
2. **A hand-written `<span class="block-anchor" id="...">`** at the very top
   of a `prose` block's own `html` (or a `reveal`'s `prompt`/`explain`) - the
   original form, still fine for `prose`:
   ```html
   <span class="block-anchor" id="crtClrScr"></span>

   <p>ClrScr wipes the entire screen blank...</p>
   ```
   **The `class="block-anchor"` is required, not decorative** - found live,
   13 September 2026, after "Readln" in the masthead dropdown jumped to a
   spot where the heading itself was invisible, hidden behind the sticky
   masthead. A bare `<span id>` has no `scroll-margin-top`, so the browser
   scrolls it flush to the very top of the viewport - exactly where the bar
   sits. `.block-anchor` already carries the correct offset (platform.md
   decision 22), tuned for this exact bar; reusing it is what keeps the
   jump landing below the bar instead of behind it. The generic `'anchor'`
   field above adds this class automatically - only a hand-written span
   needs it typed out.

Either way, **never** a second visible heading - the block's own `title`
already renders one. Both piggyback on `public/lesson.php`'s existing
`.block-anchor` / `data-block-index` spans (the same mechanism "carry on
where you left off" already uses) rather than inventing a second addressing
scheme - a named `id` and the auto-generated `id="bN"` on the block wrapper
coexist without conflict (two elements may share a class; only the `id`
itself has to stay unique), so both a same-page jump link and a
lesson-progress bookmark can land in the same place.

Not every heading in a lesson needs an `items` entry - a short transitional
example or aside can carry its own anchor (or none at all) without being
promoted to a "major stop" in the list. The rule is that the block itself
must exist on every lesson, not that every single heading is listed in it.

**Why it's worth the extra markup**: these are exactly the stretches of a
lesson a pupil is most likely to skim past looking for one specific thing
("wait, which one was `GotoXY` again?") rather than read start to finish -
`course.php` navigation gets you to the right *lesson*; this gets you to the
right *paragraph* inside it, both from the top of the lesson and now from
anywhere on the page via the masthead.

Retrofitted 13 September 2026 to every lesson that existed by then
(`lesson01.php`, `proofoflife.php`, `lesson02.php`, `lesson03.php`) - a
lesson actively being written by another chat at the time (`lesson05.php`)
was deliberately left alone to avoid a real collision, and should get one
before or shortly after it ships.

## 7a. The masthead's "Lesson contents" menu

Added 13 September 2026, the same day the masthead itself became a shared
function (`RenderMasthead()` in `lib/masthead.php` - see platform.md,
"Decisions that must not be undone"). On any lesson page, the item right
after "All lessons" is a dropdown built from that lesson's own `contents`
block via `LessonContentsMenuItems()`. A lesson with no `contents` block
(shouldn't happen once § 7 above is followed everywhere, but the code does
not assume it) simply doesn't get the dropdown item - `RenderMasthead()`
skips any nav item whose `items` list is empty, rather than showing an
empty menu.

## 7b. Every code listing can be run - this is a rule (Chris, 19 September 2026)

Every code listing in a lesson gets a **Copy to console** button, so a pupil can
run what they are reading. The button is added by `console.js` to any `<pre>`
that holds a **whole program**: a `Program ...;` line, or `Begin ... End.`. A
piece of one - `score := score + 1;`, a loop with no `Var` above it - gets
no button, and to the pupil that looks like a listing somebody forgot. (Found
on lesson 12, where the two loops in "what does each print?" were fragments.)

So when you write a listing:

1. **Write a whole program.** Program name, `Var` if it needs one, `Begin`, the
   lines, `End.`. A one-line idea is still a whole program: `Program Apostrophe;
   Begin Writeln ('It''s alive!'); End.` If the listing shows a program broken on
   purpose, it is still a whole program - the compiler's error is the lesson.
2. **Or mark it `<pre class="no-console">`**, on purpose, when it cannot be a
   program on its own: the *shape* of a statement with placeholders
   (`While condition Do`), pseudocode, another language, a fragment that only
   makes sense inside the program just above it. Use it sparingly. If it can be a
   whole program, make it one.
3. **Sample output and compiler messages are not code** and need nothing.

What the pupil copies must then *run*, so the console's layout check applies to it
(the everyday rules plus **no single-letter names**), and a code exercise's
`starter` is held to that block's own rules plus single letters from lesson 4 on.
Use full names in every listing - `number`, not `n`; `firstNumber`, not `a`.
Add `Uses SysUtils;` (or `Crt`, `Math`) whenever the program needs it, and never
name the program the same as a variable (`Program IsOldEnough;` with a variable
`isOldEnough` does not compile).

**Check it:** `php bin/check-code-blocks.php` lists every listing that is neither a
whole program nor marked, every copied program the console would refuse, and every
starter it would refuse. Add `--compile` to also compile each whole program with
the local Free Pascal (a few fail on purpose; read the list, do not chase it to
zero). Run it after writing or editing any listing.

## 7c. Every Pascal listing is coloured like the console's editor - a rule (Chris, 22 September 2026)

Every Pascal code listing on a lesson page is drawn in exactly the colours of
the console's editor: the same tokenizer (`public/assets/pascal-syntax.js`,
now loaded on every lesson page), the same `.hl-*` classes, and the same
palette. It follows the console's **Light / Dark** button (dark until a pupil
picks light), so a listing and the code a pupil copies from it into the
console always look the same. This is automatic - `app.js`'s
`LooksLikePascal()` / `ColourPascal()` do it when they number the lines - so
**never hand-colour a listing** and never put `<span>`s in a `<pre>`. What
stays plain: sample output, compiler messages (a first line like
`name.pas(3,3) Error:`), `algorithm-pseudocode`, `code-output`,
`terminal-plain`, and every course but Pascal. A listing is treated as code
when it starts with a `Program`/`Unit`/routine heading, a section word on its
own (`Var`, `Begin`...), or a `//` comment, or when any line has `:=` or ends
in `;` - so sample output never needs a class, but check the page if a
listing of output ever contains a semicolon.

The palette lives twice - `console.css` (`.console-panel`, and
`[data-theme="light"]`) and `style.css` (`pre.pascal-code`). **Change both
together.** Copying from a listing now keeps its line breaks (the numbered
lines are grid cells, and the browser used to join them into one line).

## 7d. Every list of error messages is a Common errors block - a rule (Chris, 22 September 2026)

Wherever a lesson shows more than one error message together - a table of
compiler errors, a list of crashes, "three mistakes" - it goes in an
`errors` block: light red, its own icon (`block-icons/errors.svg`), header
"Common errors - ..." (the `title`). One card per error:

```php
[
    'type'  => 'errors',
    'title' => 'Common errors - a call that does not match',
    'intro' => '<p>optional HTML before the cards</p>',
    'items' => [
        [
            'title'   => 'Too few values',          // optional, short
            'code'    => 'DrawLine (10);',            // what was written - plain text, one line or a whole program
            'message' => 'Error: Wrong number of ...', // EXACTLY what Free Pascal printed - compiled, never invented
            'why'     => '<p>What is wrong</p>',     // HTML
            'fix'     => '<p>How to fix it</p>',     // HTML, optional
        ],
    ],
    'html'  => '<p>optional HTML after the cards</p>',
],
```

`code` is coloured like every listing; a one-line piece gets no line numbers
(a whole program keeps them, so a message's line number can be found). The
listing check compiles each card's `code` but does not style-check it -
error examples are wrong on purpose. A single error in the middle of an
explanation can stay in the prose; two or more together become a block.
**A message on a card must be copied from a real compile or run** - found on
22 September 2026: lesson 13 claimed three Format mistakes all print `"%d"`,
but each message quotes its own pattern.

## 7e. Every algorithm is an algorithm block, with a flowchart and pseudocode - a rule (Chris, 22 September 2026)

When a lesson teaches an algorithm - a method for solving a problem that the
pupil is meant to reuse (buses, factors, Fibonacci, a shape, a password check,
run-length squashing...) - it gets an `algorithm` block: the problem in one
sentence, a flowchart, and pseudocode in the course's style (`START` ...
`END`, `GET`, `PRINT`, `FOR x FROM a TO b` ... `END FOR`, `WHILE` ... `END
WHILE`, `REPEAT` ... `UNTIL`, `IF ... THEN` ... `ELSE` ... `END IF`; lesson 14
adds `PROCEDURE`/`FUNCTION ... RETURNS`). The Pascal program can stay in the
prose around it. **The flowchart, the pseudocode and the code must be the same
method** - write both from the lesson's own code, step for step.

Draw flowcharts with `Flowchart ()` from `lib/flowchart.php` (the lesson file
does `require_once dirname (__DIR__, 2) . '/lib/flowchart.php';`): a list of
`['step', lines]`, `['if', condition, yes, no]`, `['while', condition, body]`
(a For is a While with the counter set before it and increased at the end of
the body) and `['repeat', body, condition]`, nested as deep as needed. It
lays everything out and keeps the 20px gap rule. The older per-lesson
closures (`$whileFlowchart`, `$loopFlowchart`) still work; use `Flowchart ()`
for anything new. Look at every new chart before shipping it: render it with
headless Chrome (`chrome --headless=new --screenshot=out.png file.html`) when
the browser pane cannot screenshot.

Audit, 22 September 2026: 12 blocks already had both; 19 were added (lessons
9-13: buses, running total, counting, factors, Fibonacci, factorial, square,
hollow box, right-angled and centred triangles, guess the number, title case,
palindrome, cracking Caesar, replace-all, password check, ID number,
initials, run-length squashing) - 31 in all.

## 8. Quick checklist

- [ ] Short sentences, direct address, hyphens not em dashes, local (SA)
      examples - itcoder's existing rules, unchanged
- [ ] Every block title is a label, not a sentence: 55 visible characters at
      most (`php bin/check-titles.php`; Chris, 19 September 2026). A "Good to
      Know - " prefix counts toward the 55.
- [ ] Every code listing is a whole program (or marked no-console on purpose),
      with full variable names: `php bin/check-code-blocks.php` (section 7b)
- [ ] Every algorithm taught is an `algorithm` block with a flowchart
      (`Flowchart ()`) and pseudocode that match the code (section 7e)
- [ ] Two or more error messages together are a Common errors block
      (section 7d), each message copied from a real compile
- [ ] Every illustration is in `Figure ()` - a box, with a caption under
      it: `php bin/check-figures.php` (section 5a; Chris, 23 September 2026)
- [ ] Listings are coloured automatically like the console (section 7c) -
      look at the page and check code is coloured and output is not
- [ ] The lesson has its SAGs coverage in `content/<course>/sags.php` (or
      `'enrichment' => true`): `php bin/check-sags.php` (Chris, 22 September
      2026 - a requirement for every lesson)
- [ ] At least one vivid physical/everyday analogy per new concept
- [ ] A real-world worked example where one exists (a system the learner has
      actually used), narrated step by step
- [ ] Acronyms, commands and glossary terms wrapped in `Gloss()`, not
      parenthesised inline
- [ ] Jokes, puns, anecdotes wrapped in `Aside()`, not inline paragraphs
- [ ] Every place a paragraph is about to explain what code/a tool/a
      calculation does - checked whether a `reveal` block would teach it
      better
- [ ] Every quiz/typed/written/order question checked against the prose
      above it - the word or fact it tests is readable in plain text, not
      only inside a popup or a `reveal`'s hidden `explain`
- [ ] Every question/code `prompt` that names more than one separate item
      (expressions, steps, options) uses a real `<ul>`/`<li>` list, and a
      prompt mixing instruction with a code sample gets a paragraph break -
      never one dense run-on sentence
- [ ] A video per subtopic that has one worth showing, not just one per
      lesson - and, in the Pascal course, no video placeholders:
      `php bin/check-videos.php` (§5; Chris, 23 September 2026)
- [ ] Every explanation checked for a try-it or a diagram that would make it
      clearer - no limit per lesson; each algorithm that loops or decides
      considered for a `flowStepper` (§5; Chris, 23 September 2026)
- [ ] Every variable given a starting value before it is used, in every
      listing - and the lesson says so where it matters (Chris, 23 September
      2026: "must always be done")
- [ ] The lesson has exactly one `contents` block (§7 - a rule for every
      lesson, not just one with an obvious run of parallel sub-topics) - its
      anchors are bare `<span id>`s, never a second visible heading
- [ ] Before another multiple-choice question - checked whether a `typed`
      one (scramble, blank, complete, exact) would test the recall better
- [ ] Every `quiz`/`typed` question declares `marks` deliberately, not left to
      the silent default
- [ ] A written question worth more than the default has a rubric that names
      a mark per idea, not a bare total
- [ ] A written question with `markMax >= 10` has `showRubric => true`, and
      its rubric is written as IEB SAGS-style bands (`- 5-6: ...`), not a
      per-idea checklist
- [ ] A rubric shown to the pupil never spells out the literal expected
      answer - exact/technical marking detail goes in `markerRubric` instead
- [ ] Every question's total mark allocation (`marks` doubled, or `markMax`)
      is an even number - no question anywhere should be able to resolve to a
      half mark
- [ ] Every pupil-facing sentence (prose, prompt, explain, visible rubric,
      feedback) reads like it's talking to a 15-year-old who has never
      programmed before - no marking jargon ("holistic", "criterion"), no
      "house style" or "convention" (say what it actually means instead)
- [ ] No meta-commentary about the page itself, no "back to top" nav text, no
      raw widget config left in
- [ ] Serious topics stated as plainly and vividly as fun ones - no change in
      register for social-implications content
