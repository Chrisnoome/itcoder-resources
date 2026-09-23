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
- **`Aside()`**: jokes, puns, anecdotes, "did you know" tangents.
- **Nothing load-bearing in a popup.** Run `php bin/check-popup-spacing.php`.

## 3. Pedagogy: do this, observe, explain

Ask more, tell less. Wherever a paragraph is about to explain what code, a
calculation or a tool does, use a **`reveal`** block instead: the prompt says
what to try, the pupil guesses, the button shows the answer and why. Not only
for code ("look up two RAM prices, work out cost per GB, then reveal").

    ['type' => 'reveal', 'prompt' => '<p>Run this ... What does it print?</p>', 'explain' => '<p>It prints ...</p>'],

Quizzes test recall and judgement; `reveal` teaches through doing.
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
  `validationLab`, `checkDigitLab`, `guiForm`) and `pascal-tryit-more.js`. **New builders register with
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
    fpc), `gotoGrid` (80 x 25).
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

## 6. Quotes with portraits

A quote at the top of the lesson. With a portrait:

```html
<div class="quote-card">
    <img class="quote-portrait" src="/assets/quotes/feynman.png" alt="Richard Feynman" width="64" height="64">
    <blockquote class="quote">...<cite>- Richard Feynman &middot; portrait: Wikipedia</cite></blockquote>
</div>
```

Without one, a plain `<blockquote class="quote">`. Short credit in the `<cite>`.
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

## 7b. Every code listing can be run

`console.js` adds **Copy to console** to any `<pre>` holding a whole program
(`Program ...;` or `Begin ... End.`).
1. **Write whole programs**, even for one line or a deliberately broken
   example.
2. Otherwise mark `<pre class="no-console">` on purpose (a statement's shape
   with placeholders, pseudocode, a fragment of the program above). Sparingly.
3. Sample output and compiler messages need nothing.

What is copied must pass the console's layout check (no single-letter names,
full names like `firstNumber`), with `Uses SysUtils;`/`Crt`/`Math` when needed,
and a program never named like a variable. A code exercise's `starter` is held
to that block's rules. Check: `php bin/check-code-blocks.php` (`--compile`
also compiles; a few fail on purpose).

## 7c. Listings are coloured like the console

Automatic (`pascal-syntax.js`, `app.js` `LooksLikePascal()`/`ColourPascal()`),
following the console's Light/Dark choice. **Never hand-colour; no `<span>`s
in a `<pre>`.** Plain: output, compiler messages, `algorithm-pseudocode`,
`code-output`, `terminal-plain`, non-Pascal courses. A listing counts as code
if it starts with a heading, a section word, `//`, or any line has `:=` or
ends in `;` - check output that contains a semicolon. The palette lives in
`console.css` and `style.css` (`.pascal-code`) - change both.

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

- [ ] Voice: short sentences, "you", hyphens, SA examples, banned words
      (writing-style.md), no SAGs named, pitched at a 15-year-old beginner
- [ ] One `contents` block (§7); titles <= 55 characters (Good to Know <= 36)
- [ ] An analogy per new concept; real-world worked examples where they exist
- [ ] Acronyms/commands in `Gloss()`, jokes in `Aside()`, nothing load-bearing
      in a popup
- [ ] Explanations of what code does checked for a `reveal` (§3)
- [ ] **Try-its and diagrams wherever they help** (§5); illustrations in
      `Figure ()` (§5a)
- [ ] Every algorithm an `algorithm` block with matching flowchart and
      pseudocode (§7e); loops/decisions considered for a `flowStepper`
- [ ] Every listing a whole program or `no-console`, full names, runnable
      (§7b); every error message from a real compile; 2+ together in an
      `errors` block (§7d)
- [ ] **Every variable given a starting value before use**, and the lesson says
      so where it matters (Chris: "must always be done")
- [ ] Every tested fact is in visible prose; prompts broken into lists
- [ ] Mixed question types (typed before another MCQ); `marks` declared; every
      total even; written prompts say what to cover and avoid; rubrics per
      idea, or bands from `markMax` 10 with `showRubric`; exact detail in
      `markerRubric`
- [ ] Videos only where vetted - no Pascal placeholders
- [ ] A `study` block (Pascal); SAGs coverage in `content/<course>/sags.php` or
      `'enrichment' => true` (`php bin/check-sags.php`)
- [ ] Run the checks in platform.md, "Checks to run"
