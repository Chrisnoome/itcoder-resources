# Content voice, pedagogy and lesson rules

For every lesson written or revised on itcoder (the AI course's v1 lessons stand
until touched). Builds on [writing-style.md](writing-style.md). Voice source:
Chris's textbook in `word documents/` (`bc_*`, `hw_*`, `im_*`, `dc_*`, `sw_*`,
`si_*`). The checklist is §8.

## 1. The voice

- **Everything a pupil reads** - prose, prompt, explain, visible rubric,
  feedback - speaks to a 15-year-old who has never programmed. No marking
  jargon ("holistic", "criterion", "band", "checklist"); never "house style" or
  "convention" (say: how you format and lay out code must match what you have
  been taught and shown - to build good habits, not because Pascal demands it).
- **Vivid everyday analogies, pushed further than feels natural** - physical,
  bodily, domestic before abstract. The voice's strongest fingerprint.
- **Rhetorical questions left open for a beat.**
- **Real-world worked examples narrated step by step** - a system the pupil has
  used (till, ATM, cellphone bill) taken apart input -> processing -> output,
  with numbers.
- **Bold, flat verdicts** ("YES, RAM is expensive!").
- **Personal asides without ceremony** ("My Mac Pro has...").
- **Serious topics in the same register as fun ones.**
- Leave behind the corpus's artifacts: meta-commentary about the page, "back to
  top" cruft, raw widget config, typos.
- **Prompts are broken up:** separate items (expressions, steps, options) go in
  a `<ul>`; instruction + code sample + instruction get paragraph breaks.
  Applies to every prompt of every type.

## 2. Popups

`Gloss()` and `Aside()` (`lib/content.php`), one `.popup` component (click,
tap, Tab+Enter; click away or Escape closes).

    'stored in ' . Gloss ('RAM', 'Random Access Memory - ...') . '.'
    'Every ' . Aside ('End.', 'Forget the full stop and...') . ' needs its full stop.'

- **`Gloss()`**: every acronym on first use in a lesson, any reserved word or
  command being named, any glossary-worthy term.
- **`Aside()`**: jokes, puns, anecdotes, "did you know" tangents. On a wide
  screen an aside in a paragraph or list sits in the margin (§5b).
- **Nothing load-bearing in a popup.** Run `php bin/check-popup-spacing.php`.

## 3. Pedagogy: do this, observe, explain

**CAPS and IEB name one idea differently? Teach it once, both names side by
side** (Chris, 25 September 2026): one figure or table with a CAPS lane and an
IEB lane, one worked example carrying both names, a question that pairs the
names. Never two sections (two methods to learn) or tabs (one set hidden).
Model: Pascal lesson 1, `#polya` - Polya's four steps and computational
thinking.

Ask more, tell less. Wherever a paragraph is about to explain what code, a
calculation or a tool does, use a **`reveal`** block instead: the prompt says
what to try, the pupil guesses, the button shows the answer and why. Not only
for code ("look up two RAM prices, work out cost per GB, then reveal").

    ['type' => 'reveal', 'prompt' => '<p>Run this ... What does it print?</p>', 'explain' => '<p>It prints ...</p>'],

Quizzes test recall and judgement; `reveal` teaches through doing.

The button reads **"What happens next? Show me"**: big, orange, full width,
pulsing until pressed, with "Make your guess first..." above it (Chris, 25
September 2026: many pupils skipped it). An opened reveal stays open on that
browser (`localStorage`, nothing marked), and a pupil who scrolls past a closed
one gets a bar at the bottom: "You scrolled past a ... button" with **Take me
back** / **Not now** (`app.js`, `SetUpReveal`/`DrawRevealBar`).
**A question may never test a word or fact that isn't in always-visible prose**
- not only in a popup or a reveal's hidden `explain`.

## 4. Question types and scoring

**`typed`** (`kind`: `scramble`, `blank`, `complete`, `exact` - only picks the
label; add new kinds freely). Use it when recalling an exact word matters more
than recognising it.

    ['type' => 'typed', 'kind' => 'scramble', 'id' => 't1BooleanScramble', 'marks' => 1,
     'prompt' => '...', 'display' => 'O B N A E L O',
     'answer' => 'Boolean' /* or an array of fair wordings */, 'explain' => '...'],

- **`blank`**: underscores in `display` become per-letter boxes; blank
  **about half** the letters. Only `_` makes a box.
- **Code answers** (`TypedAnswerIsCode()`: an assignment, call, comparison,
  heading...): compared with compiler-ignored spacing removed, capitals
  ignored, final `;` optional; quoted text must still match. An unmatched code
  answer goes to the AI checker (`CheckCodeAnswer()`); if that fails the exact
  verdict stands. Still list likely wordings in `answer`. For a short Pascal
  snippet where many wordings are right, `checkedcode` (always AI-checked) fits.
- **Hint under the box:** "Only one word needed!" only when the main answer is
  one plain word; code gets "Type the Pascal code - spacing and a missing ; do
  not matter."; other answers get none. Don't write "one word" in a prompt
  whose answer isn't one.
- **A `code` block's `'hint'`** (Chris, 25 September 2026: "too difficult to
  read and follow. if hinting, be more concise and don't use code. explain
  ways of thinking"): two or three short sentences in plain words, **no code
  and no Pascal keywords to copy**. Say how to think about the problem - what
  to work out first, what to keep track of, what to check at the end - never
  the lines to type. Good: "You need to remember the biggest one seen so far.
  Start with the first mark, then compare each next one and swap if it is
  bigger."

**Scoring (quiz, typed, order, select; match per line):** `marks` is the base
(min 1, declare it deliberately); right first time earns `marks x 2`, second
time `marks`, else 0.

**Written questions:**
- The **prompt says what a good answer covers** (2-4 bullets naming ideas, not
  wording) and **what to avoid** when relevant ("without using the words X, Y").
  Prompt and rubric must never disagree; no pupil loses marks for an unstated
  constraint.
- **`markMax` is even** (no half marks). Worth more than the default -> the
  rubric names a mark per idea; a harder criterion may weigh 2 (say why).
  Model: `w1LanguagePurpose` (Pascal lesson 1).
- **`markMax` under 10:** per-idea checklist, `showRubric` unset (the rubric
  still drives the marker).
- **`markMax` 10 or more:** `showRubric => true`, written as IEB SAGs-style
  bands - a few broad criteria (4-8 marks each), each with 3-4 bands
  (`- 5-6: ...`, `- 0: ...`) describing quality of thinking, marked
  holistically. Model: `w1FinalAssessment` (AI lesson 8). A block where every
  bullet matches `/^\d+(-\d+)?\s*:\s*/` renders as a table (`RubricListHtml()`);
  keep marker notes as plain bullets outside it.
- **A rubric shown to pupils never spells out the expected answer.** Exact
  marking detail goes in **`markerRubric`** (sent to the marker instead of
  `rubric`, never shown).

**Code-writing questions** are marked for correctness plus layout (the house
style), from the very first. Layout costs a **flat 1 mark once per question**,
whatever the number of slips, stated as a deduction in the rubric; the
feedback always names the slip. Only grade what has been taught by that lesson
(proof of life: indentation and structure; variables add naming; comments,
routines etc. join when taught). This is formative - the IEB exam policy in
marking-house-style.md (style never marked) is deliberately different.

## 4a. AI marking: flexibility and feedback shape

- **When a rubric offers a choice** ("any two of X/Y/Z"), any qualifying option
  correctly present earns full credit. **Working code that produces the right
  result earns full marks** even by a different route, as long as it meets
  what the rubric checks. Strict = mark only what is there, never penalise a
  correct alternative. `bin/markqueue.php`'s prompts say both.
- **Feedback shape** (all AI feedback and analysis): a short general comment in
  paragraphs of one or two sentences; a blank line; **Where you lost marks:**
  (analysis: **Things to check:** / **Ways to improve it:**) on its own line;
  one `- ` bullet per line. Nothing lost -> say so plainly, no heading. Hyphens,
  no banned words. Enforced by `NormaliseFeedback()` (`lib/feedback.php`) on
  store (`markqueue.php`, `lib/analyse.php`) and on display;
  `bin/reformat-feedback.php --apply` fixes stored text;
  `php bin/check-feedback-format.php` checks. Keep the example in the prompt.

## 5. Videos, animations, try-its and diagrams

- **A short video per subtopic that has a good one**, not one per lesson.
  `video` block with a vetted `youtubeId`; never invent one.
- **Pascal course: no video placeholders** (empty `youtubeId`) at all - Chris
  names videos (`php bin/check-videos.php`). The AI course may still use them.
- **Try-its and diagrams wherever they help - no limit per lesson.** Look at
  every explanation: would the pupil understand it better by seeing it happen
  (a try-it) or seeing it drawn (a diagram)? Add it; Chris removes what he
  doesn't want. Typical spots: a value stored or changed, a condition worked
  out, a loop or decision running, a function or conversion, a format or screen
  position. Every output or error a try-it shows must come from a real run.
- **Try-its:** `<div class="tryit" data-tryit="NAME" ...></div>` in a prose
  block titled "Try this: ...", right after its section. No server, no marks.
  Builders: `public/assets/pascal-tryit.js` (lesson 14: `callStepper`,
  `parameterMachine`, `functionMachine`; `writeOrWriteln`, `crtColours`,
  `swapBoxes`, `readlnTester`, `divModSweets`, `roundTrunc`, `asciiExplorer`,
  `gradeBand`, `busPlanner`, `forCounter`, `shapeDrawer`, `whileVsRepeat`,
  `stringBoxes`, `caesarWheel`, `objectFactory`), `pascal-tryit-files.js`
  (`fileModes`), `pascal-tryit-errors.js` (lesson 18: `exceptionJump`,
  `validationLab`, `checkDigitLab`, `guiForm`), `pascal-tryit-dates.js` (lesson 19: `dateNumber`, `dateFormatLab`, `ageLab`, `leapYearLab`, `idDateLab`; checked against fpc output by `pascal-tryit-dates.test.js`), `pascal-tryit-manager.js` (lesson 20: `managerLab`, TPupilManager's model checked by `pascal-tryit-manager.test.js`), `pascal-tryit-inherit.js` (lesson 21: `bindingLab`, Virtual/static binding checked against 8 fpc runs by `pascal-tryit-inherit.test.js`), `pascal-tryit-ui.js` (lessons 22-23: `readKeyLab`, `colourWheel`, `maskEditLab` - the mask checked against 23 Lazarus TMaskEdit runs by `pascal-tryit-ui.test.js`) and `pascal-tryit-more.js`. **New builders register with
  `PascalTryit.register (name, fn)` in their own file**, loaded after
  `pascal-tryit.js`. In `pascal-tryit-more.js`:
  - `flowStepper` - a flowchart lit shape by shape with variables, output and a
    note: `<div class="tryit" data-tryit="flowStepper" data-trace="JSON">` +
    `Figure (Flowchart (...))` + `</div>`. Shapes get `'id' => 'name'` in
    `Flowchart ()` (Start/End are `start`/`end`). JSON `{vars, steps: [{node,
    vars, out, note}]}` or `{vars, inputLabel, scenarios: {label: [steps]}}`;
    **scenario labels must not be bare numbers** (JS sorts them - `n = 17`).
  - `memoryBox` - statements run one at a time, old value struck through:
    `data-config` `{vars, actions, start?}`.
  - `mathsLab`, `conversionLab`, `charPicker`, `comparisonLab` (`data-mode`
    text/number), `logicLab`, `formatLab` (`:width:decimals`, half up like
    fpc), `gotoGrid` (80 x 25), `array2d` (a 2-D array: pick a row and a
    column, see the element and both totals; `data-config` `{name, rows,
    columns, values, row, column}`).
- **Screens and screenshots** (24 September 2026): a Crt screen is a real server run saved as `content/pascal/screens/<lesson>-*.ans` and drawn with TerminalScreen() inside `Figure ()` (`.figure-box .terminal` is left-aligned and the box is 80 JetBrains Mono columns - Chris, 24 Sep 2026: centred rows broke the columns); a window is a real Lazarus screenshot in `public/assets/lessons/pascal/` (`.shot` + numbered `.shot-badge`s for callouts). How: `tools/ui-screens/README.md`.
- **Diagrams:** inline SVG in `Figure ()` using colour tokens (`var(--ink)`,
  `var(--card)`, `var(--heat)`) so dark mode works. Adjacent flowchart shapes
  keep a ~20px gap; never `textLength`/`lengthAdjust` (warps glyphs) - widen,
  shrink or split text instead. Check renders visually (headless Chrome:
  `chrome --headless=new --screenshot=out.png file.html`).

## 5a. Every illustration is boxed and captioned

Every diagram, flowchart, picture or photo goes through `Figure (html,
caption)` -> `<figure class="figure"><div class="figure-box">...</div>
<figcaption>...</figcaption></figure>` (write that markup by hand inside a
heredoc). Caption in plain words under the box, never inside the SVG; an
algorithm's is "Flowchart: " + what it does. Not boxed: quote portraits, block
icons, a question's own diagram, interactive widgets. Check:
`php bin/check-figures.php`.

## 5b. The margin (Chris, 25 September 2026)

Every lesson page in every course (Pascal, AI, Java and any later one) has a right-hand margin (`lib/design.php`,
`public/assets/design-e.css`). It is for **fun, extras and related facts** -
what makes a lesson worth reading, never what a pupil needs.

- **What goes there:**
  - `Doodle ('name', 'caption')` - a blue-pen drawing with a one-line joke or
    pun about the topic (someone deciding about an umbrella, a crocodile eating
    the bigger number). Drawings live in `public/assets/doodles/<name>.svg`:
    line art, `stroke="currentColor"`, round caps and joins, words in Kalam,
    no bigger than about 240 x 170.
  - `MarginNote ('text')` - "Did you know?" (the default label) for a true,
    interesting related fact; `MarginNote ('text', 'Extra')` for a little more
    depth.
  - `Aside()` jokes and anecdotes written into a paragraph or list move to the
    margin by themselves; a `code` block's hint sits there too.
- **Never in the margin:** the glossary (a `Gloss()` word keeps its popup),
  anything tested, anything needed to answer a question.
- **Nothing in the margin pushes the text apart.** Notes float beside the text;
  a crowded margin pushes the next note down, never a paragraph. Keep notes to
  two or three sentences and spread them out. **Anything tall goes in the
  text:** `Doodle (..., 'text')` floats in the text column and the paragraphs
  wrap round it.
- **Where:** between paragraphs, never inside one - usually straight after a
  section's `block-anchor` span, so it sits beside the section's opening
  lines. Break the heredoc: `HTML . Doodle (...) . <<<HTML` (reopen a nowdoc as
  `<<<'HTML'`).
- **A drawing that gives the answer away goes inside the answer** (Chris, 25
  September 2026): put the `Doodle()` or `MarginNote()` at the start of a
  `reveal` block's `explain` (`'explain' => Doodle (...) . <<<HTML`). It stays
  hidden with the answer and appears in the margin beside it when the pupil
  presses the button (`.reveal-body` rule in design-e.css). Model: the jam jar
  in Pascal lesson 1.
- **How many:** about one item for every two or three sections - at least three
  in a full lesson, one or two in the exam guides and task lessons. Never two
  sections in a row without text between them. Mostly **drawings** (Chris:
  "sidebars still lack illustrations ... search could have a stick figure with
  binoculars asking 'where is it???'"): a stick figure, an object or a small
  scene that makes the concept's joke visible, with a pun or one-liner as its
  caption. Look for jokes and puns on the section's words; make up your own.
  Check new drawings on a contact sheet before inserting them.
- **Facts must be true:** well-known, stable facts; dates rather than prices
  (numbers go stale); no invented statistics. Unsure? Leave it out.
- **Jokes** in the lesson's voice: short, kind, local where it fits (Joburg,
  Eskom, taxis, braais), never at a pupil's expense or about a group of people.
- With no room for a margin (a phone, or the console open) doodles hide and
  notes sit in the text as small grey boxes - so a note must read well between
  two paragraphs.
- `DesignFigure ('name', 'caption')` is a drawing from `doodles/` in a proper
  `Figure()` box - an illustration (§5a), not a margin item.

## 6. Quotes with portraits

A quote at the top of the lesson. With a portrait:

```html
<div class="quote-card">
    <img class="quote-portrait" src="/assets/quotes/feynman.png" alt="Richard Feynman" width="64" height="64">
    <blockquote class="quote">...<cite>- Richard Feynman &middot; portrait: Wikipedia</cite></blockquote>
</div>
```

**Every quote has an image** (Chris, 23 September 2026). With no portrait
(an unknown author, a proverb), use a picture that fits the quote - a drawing
made for the course (lesson 17's `floppy_disk.png`), artwork, or
`anonymous.svg` - and say what it is in the `<cite>`. Short credit in the `<cite>`.
Source: `word documents/_ALL_QUOTES.docx` (331 quotes, portraits in
`word/media/`); save portraits to `public/assets/quotes/<person>.png` and a
source copy in `Quote images/`. **Trap:** de-duplication left some rows with
another card's image (Doug Linder's quote shows Neil Gaiman) - trust the quote
text, drop a mismatched image. Portraits from elsewhere must be free for
commercial use (Wikimedia Commons, checked) - record the source in the lesson's
doc comment.

## 7. Every lesson has one `contents` block

Right after the opening quote/notice:

    ['type' => 'contents', 'intro' => '...' /* optional */, 'items' => [
        ['anchor' => 'crtClrScr', 'label' => 'ClrScr', 'note' => 'wipe the screen'],
    ]],

It renders as a boxed jump list (cobalt `#274690`/`#5C7CC4`/`#E6ECF8`,
`contents.png`) and feeds the masthead's **Lesson contents** dropdown - one
list, two uses. Leave `title` off (defaults to "Lesson Contents"). Anchors:
- **`'anchor' => 'name'` on any block** (renders the span for you) - use for
  anything that isn't plain prose;
- or `<span class="block-anchor" id="name"></span>` at the top of a prose
  block's html - **the class is required** (it carries the scroll offset below
  the sticky masthead).

Never a second visible heading. Not every heading needs an entry.
Check: `php bin/check-lesson-contents.php`.

## 7a. "Lesson N" is a link (Chris, 24 September 2026)

Wherever a Pascal lesson mentions another lesson, the words are a link to
the exact section meant, not just the lesson:
`<a class="lesson-link" href="/lesson.php?c=pascal&amp;id=lesson07#convIntStr">lesson 7</a>`.
Use the **lessonId** (lesson 4 is `lesson02`) and one of the target's
contents anchors; no `#` when the whole lesson is meant. Same tab - Back
returns to the place. Left as plain text, because a link can't work there:
study blocks (bold/code markup and a PDF), written questions (sent to the
marker), titles, contents notes, `Gloss()`/`Aside()` text and the prompts
of quiz/typed/checkedcode/order/select/match/gridtyped (escaped). Check:
`php bin/check-lesson-links.php` (dead links fail; unlinked mentions are
listed as notes).

## 7b. Every code listing can be run

`console.js` adds **Copy to console** to any `<pre>` holding a whole program
(`Program ...;` or `Begin ... End.`).
1. **Write whole programs**, even for one line or a deliberately broken
   example.
2. Otherwise mark `<pre class="no-console">` on purpose (a statement's shape
   with placeholders, pseudocode, a fragment of the program above). Sparingly.
3. Sample output and compiler messages need nothing.
4. **Output always has its main program right above it** (Chris, 25 September
   2026). A class or a method alone never produces output - so wherever a
   lesson shows what a program prints, the listing above it must include the
   main program (a whole program, or a `no-console` fragment ending in
   `Begin ... End.`, saying which classes go above it). When the whole
   program is long, show the main program again on its own just above the
   output. A "what if" variant (a line left out) shows the changed code AND a
   main program. A `<pre>` that is not output of a program (a file's contents,
   a data format) is marked `class="no-program"`. Check:
   `php bin/check-output-programs.php` (a reveal counts the last program with a
   main in the blocks above it).
5. **Code that fails says so next to it**: a fragment shown to produce an
   error carries a comment on the line (`// ERROR - will not compile`,
   `// ERROR when it runs - ...`) and the prose says which of the two it is
   before the message is shown.

What is copied must pass the console's layout check (no single-letter names,
full names like `firstNumber`), with `Uses SysUtils;`/`Crt`/`Math` when needed,
and a program never named like a variable. A code exercise's `starter` is held
to that block's rules. Check: `php bin/check-code-blocks.php` (`--compile`
also compiles; a few fail on purpose).

**Long listings start folded** (Chris, 24 September 2026): a Pascal listing
over 15 lines shows its first lines under a fade, with a "Show the whole
program (N lines)" bar (`app.js` `FoldLongListing`). When the part that
matters is at the end of a long program (a main program), show that part on
its own first, then the whole program.

## 7c. Listings are coloured like the console

Automatic (`pascal-syntax.js`, `app.js` `LooksLikePascal()`/`ColourPascal()`),
following the console's Light/Dark choice. **Never hand-colour; no `<span>`s
in a `<pre>`.** Plain: output, compiler messages, `algorithm-pseudocode`,
`code-output`, `terminal-plain`, non-Pascal courses. A listing counts as code
if it starts with a heading, a section word, `//`, or any line has `:=` or
ends in `;` - check output that contains a semicolon. The palette lives in
`console.css` and `style.css` (`.pascal-code`) - change both.

**Long lines wrap, never scroll sideways** (Chris, 25 September 2026). Every
listing, output box, errors card, try-it panel and array demo wraps a line
too long for the box with a **hanging indent**: the wrapped part lines up one
place after the line's first `(` - the way a long heading is written by hand -
or 4 places in from the line's own indent when there is no bracket (2 for
output). `app.js` `LineHang()`/`HangLine()` (shared as `window.PascalLineHang`
with `pascal-tryit.js` and `array-demo.js`); CSS `pre-wrap` on
`.pre-line-text`. Nothing to write in a lesson - it is automatic. Only the DOS
terminal keeps its fixed 80 columns.

## 7d. Two or more error messages together -> an `errors` block

    ['type' => 'errors', 'title' => 'Common errors - ...', 'intro' => '<p>...</p>', 'items' => [
        ['title' => 'Too few values', 'code' => 'DrawLine (10);',
         'message' => 'EXACTLY what fpc printed', 'why' => '<p>...</p>', 'fix' => '<p>...</p>'],
    ], 'html' => '<p>optional after</p>'],

Light red, `errors.svg`. `code` is coloured; the listing check compiles it but
doesn't style-check it. **Every message is copied from a real compile or run.**

## 7e. Every algorithm is an `algorithm` block

The problem in one sentence, a flowchart, and pseudocode (`START`...`END`,
`GET`, `PRINT`, `FOR x FROM a TO b`...`END FOR`, `WHILE`...`END WHILE`,
`REPEAT`...`UNTIL`, `IF ... THEN`...`ELSE`...`END IF`, `PROCEDURE`/`FUNCTION
... RETURNS`). **Flowchart, pseudocode and code are the same method, step for
step.** Draw with `Flowchart ()` (`require_once dirname (__DIR__, 2) .
'/lib/flowchart.php';`): `['step', lines]`, `['if', cond, yes, no]`, `['while',
cond, body]` (a For = While with the counter set before and increased at the
end), `['repeat', body, cond]`, nestable, optional `'id'`. Look at every new
chart rendered.

## 8. Lesson checklist

- [ ] Voice: short sentences, "you", hyphens, SA examples, SA English spelling, banned words
      (writing-style.md), no SAGs named, pitched at a 15-year-old beginner
- [ ] One `contents` block (§7); titles <= 55 characters (Good to Know <= 36)
- [ ] An analogy per new concept; real-world worked examples where they exist
- [ ] Acronyms/commands in `Gloss()`, jokes in `Aside()`, nothing load-bearing
      in a popup
- [ ] The margin (§5b): doodles, "Did you know?" notes and asides spread
      through the lesson; never the glossary; every fact true
- [ ] Code hints (§4): short, plain words, a way of thinking - no code
- [ ] **Whitespace:** look at the rendered page - text never touches the edge
      of its box (array cells, badges, buttons, table cells); a box grows to
      fit its longest word rather than squeezing it (Chris, 25 September 2026:
      "always check for space and whitespace to make text readable")
- [ ] Explanations of what code does checked for a `reveal` (§3)
- [ ] **Try-its and diagrams wherever they help** (§5); illustrations in
      `Figure ()` (§5a)
- [ ] Every algorithm an `algorithm` block with matching flowchart and
      pseudocode (§7e); loops/decisions considered for a `flowStepper`
- [ ] Every listing a whole program or `no-console`, full names, runnable
      (§7b); every error message from a real compile; 2+ together in an
      `errors` block (§7d)
- [ ] **Every output has its main program shown right above it**; failing
      code says "will not compile" / "error when it runs" (§7b,
      `check-output-programs.php`)
- [ ] **Every variable given a starting value before use**, and the lesson says
      so where it matters (Chris: "must always be done")
- [ ] Every tested fact is in visible prose; prompts broken into lists
- [ ] Mixed question types (typed before another MCQ); `marks` declared; every
      total even; written prompts say what to cover and avoid; rubrics per
      idea, or bands from `markMax` 10 with `showRubric`; exact detail in
      `markerRubric`
- [ ] Videos only where vetted - no Pascal placeholders
- [ ] A `study` block (Pascal); SAGs coverage in `content/<course>/sags.php` and
      CAPS coverage in `caps.php`, or `'enrichment' => true` (`php bin/check-sags.php`)
- [ ] Run the checks in platform.md, "Checks to run"
