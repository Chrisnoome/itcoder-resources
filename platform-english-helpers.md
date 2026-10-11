# English helpers: source texts, the text window, exam-specific facts, example answers, scene cards, the guided analysis panel

Written 11 October 2026 for the eng10 rework (Chris's review, `AIResources/English/eng10-review-1.md`, and his follow-up messages).

This file documents the new helpers in `AIPascalCourse/lib/englishtext.php`. It also holds two paste-ready sections, one for `AIResources/platform.md` and one for the header comment of `AIPascalCourse/lib/content.php`. Both of those files are too big to rewrite safely through the Dropbox connector, which can only write whole files, so the text is here to paste in by hand.

## Files

| File | What it is |
|---|---|
| `lib/englishtext.php` | The PHP helpers (below). A lesson loads it with `require_once dirname (__DIR__, 2) . '/lib/englishtext.php';`, the same way lessons load `lib/flowchart.php`. |
| `public/assets/english-text.css` | Styles: source-text boxes (prose, poem, play, essay), quotations, scene timeline, text window, word counts, exam tags, example answers, the analysis panel. Accent per grade: `body.course-eng10 { --source-accent: #2747d6 }`. |
| `public/assets/english-text.js` | The text window (TextDock), plus a live word count under every `written` answer box. |
| `public/assets/analysis-panel.js` | The guided analysis panel. |

**How the assets load.** Each helper prints `EnglishTextAssetsHtml()`, a `<link>` and a `<script defer>` in the body. This was done so that `public/lesson.php` did not need editing. Browsers fetch each file once, and each script guards against running twice. When lesson.php is next opened for other work:

- move the three files into its `<head>`;
- make `EnglishTextAssetsHtml()` return `''`.

The word counts would then work in every course, not just in lessons that use a helper.

## The helpers

### SourceText ($title, $html, $attribution = '', $kind = 'prose', $label = '', $key = '')

Use it for any text that is not the lesson's own words: Text A and Text B, a poem, a play extract, a speech script, a pupil's essay.

- **Look.** The text sits in its own box on a paper background, set in a serif face, with a label strip at the top and the attribution at the foot. It should never read as the lesson talking.
- **`$kind`:**
  - `prose`: an `<ol class="st-paras">` numbers the paragraphs in the margin;
  - `poem`: build the lines with `PoemHtml ($text, $numbered = true)`, which keeps every line break and indent and numbers every fifth line;
  - `play`: build it with `PlayHtml ([[speaker, line], ...])`;
  - `essay`: paragraphs plus a `<p class="st-essay-title">`, no numbers.
- **`$label`** is the strip text (for example 'Text A' or 'Poem').
- **`$key`** (for example 'texta') lets TextDock open this text in the text window.

### TextDock ($keys)

From this point in the lesson, the named source texts (space-separated keys) sit in a console-style text window, so a question about a text never means scrolling back up.

- **Where it sits:** fixed at the right on wide screens, a panel at the foot on a phone.
- **When it shows:** only while the original box is out of view.
- **Several keys** become tabs.
- **"Keep beside me"** pins the window.
- **On a phone** it starts folded; the fold state is kept in sessionStorage under `bl.textdock.folded`.
- **`TextDock ('')`** hides it again, for example before the lesson's own essay task.

### ForExam ($caps, $ieb) and ForExamText ($caps, $ieb)

A fact that differs between the exams (a length, a time limit, a mark) shows only in the viewer's version. The text never says "CAPS says / the IEB says". Chris: "this should just be correct for the selected board - not mentioned in the text. apply across the subject".

- **How it decides:** it reads `ExamBoard ($pupil)` (lib/syllabus.php). lesson.php sets `$pupil` before it loads the blocks.
- **Teachers, the checkers, the marker, and pupils who have not chosen an exam** see both versions, each tagged.
- **`ForExam`** takes trusted HTML (it goes inside prose).
- **`ForExamText`** is for plain-text places such as study points, quiz options and prompts. With the exam unknown it gives `x (CAPS) / y (IEB)`.
- **Never use it inside a question's id, answer key or marking.** Those must be the same for everyone. Put exam-specific questions in `BoardSection()` instead.

### AnswerExamples ($examples, $question = '')

Worked example answers (strong, middling, weak), each with a verdict chip and the reasons under it. They sit side by side where there is room. Chris: "always provide examples - eg good literary analysis, bad literary analysis - with explanations. you have space no textbook has."

```php
AnswerExamples ([
    ['verdict' => 'weak',     'label' => 'Answer A', 'html' => '<p>...</p>', 'notes' => ['No quotation.', '...']],
    ['verdict' => 'middling', 'label' => 'Answer B', 'html' => '<p>...</p>', 'notes' => ['...']],
    ['verdict' => 'strong',   'label' => 'Answer C', 'html' => '<p>...</p>', 'notes' => ['**Say**: ...', '...']],
], '<p>Comment on the images in lines 13 and 14. (2)</p>')
```

- `label` and `notes` are plain text; `notes` allow `**bold**`.
- `html` and `$question` are trusted HTML.

### SourceQuote ($words, $who = '')

A short quotation in the source-text face, for use inside a summary, a scene card or a callout. Write " / " for a line break in verse, as exams do.

### SceneTimeline ($scenes, $prefix = 'Scene')

A play's scenes as cards down a time line: number, title, where, what happens (bullets) and the key quotations.

```php
SceneTimeline ([
    ['title' => 'A brawl in the street', 'where' => 'A public place', 'events' => ['...', '...'], 'quotes' => [['Peace? I hate the word', 'Tybalt']]],
], 'Scene')
```

- Everything is plain text and gets escaped.
- The number comes from the order.
- To make it something pupils must learn, put it inside a `.learn-memorise` box.

### AnalysisPanel ($spec)

A guided analysis that builds a written answer step by step. Spread it into the block list with `...AnalysisPanel ([...])`. It returns two blocks:

1. **A `prose` block** holding the panel: step pills and questions on the left, and a console window on the right (below on a phone) where each answer is added as it is given.
2. **A `written` block** with the panel's `id`, where the finished analysis is handed in.

```php
...AnalysisPanel ([
    'id'     => 'w42EssayAnalysis',          // the written question's id
    'anchor' => 'analyse',                   // optional
    'title'  => 'Guided analysis: ...',
    'file'   => 'essay-analysis.txt',        // the console's title
    'intro'  => MarginNote (...) . '<p>...</p>',
    'steps'  => [
        ['label' => 'Thesis', 'ask' => '<p>...</p>', 'hint' => '...', 'starter' => 'Essay 2 states ...'],
        ['label' => 'PEEL',   'ask' => '<p>...</p>', 'hint' => '...', 'starter' => '...', 'newParagraph' => true],
    ],
    'written' => ['markMax' => 12, 'showRubric' => true, 'prompt' => '...', 'rubric' => '...', 'markerRubric' => '...', 'jevChecks' => [...]],
]),
```

How it behaves for the pupil:

- **Typing.** The pupil answers one step at a time. A hint can be opened, and the starter is a placeholder, not pre-filled text.
- **Editing.** Clicking a line in the console reopens that step.
- **Pasting.** It is refused, as in a `written` answer.
- **Saving.** Steps are kept on the device in localStorage (`bl.analysis.<course>.<lesson>.<id>`) until the answer is handed in.
- **Handing in.** "Put it in the answer box" copies the whole analysis into the `written` box using `setRangeText` and the same assist input event that the Speak button uses. The typing record therefore counts it as typed, not pasted.
- **Marking.** Nothing in the panel itself is marked. The `written` question is marked as usual, with `points` or `jevChecks`.

Used in `argumentative-essay` (`w42EssayAnalysis`, 6 steps, out of 12) and `unseen-method` (`w52Paragraph`, 5 steps, out of 4).

### Word counts

`english-text.js` puts a live count under every `[data-block="written"]` textarea. It reads the target from the prompt: "N to M words" or "about N words".

- **Inside the target:** the count turns green.
- **Over the target:** it turns amber and says "a little long".
- **No target in the prompt:** the bare count.

Nothing is enforced; the count only informs.

## Paste-ready text for `AIResources/platform.md`

Paste this under the section that lists the block helpers:

> **English helpers (`lib/englishtext.php`, October 2026).** English lessons that quote texts start with `require_once dirname (__DIR__, 2) . '/lib/englishtext.php';`.
>
> - `SourceText()` puts any quoted material (Text A/B, poems, play extracts, scripts, pupils' essays) in a source box with its own face, label and attribution. `PoemHtml()` and `PlayHtml()` build the inside of poem and play boxes.
> - `TextDock()` keeps the named texts in a side window (a bottom panel on phones) while the questions about them are on screen.
> - `ForExam()` and `ForExamText()` show an exam-specific fact (length, time, marks) in the viewer's exam only. Never mention CAPS or IEB in pupil-facing text for such facts.
> - `AnswerExamples()` shows strong, middling and weak example answers with reasons.
> - `SourceQuote()` and `SceneTimeline()` make visual summaries.
> - `...AnalysisPanel([...])` is a guided, step-by-step analysis that builds a `written` answer in a console window. It returns a prose block and the written block, and the hand-in counts as typed.
> - Every `written` box shows a live word count, with its target taken from "N to M words" or "about N words" in the prompt.
>
> Assets: `public/assets/english-text.css`, `english-text.js` and `analysis-panel.js`, loaded from the body by the helpers until lesson.php's `<head>` takes them. Full notes: `AIResources/platform-english-helpers.md`.

## Paste-ready text for the header comment of `lib/content.php`

Add this to the list of block helpers in the header:

```
 *   English helpers live in lib/englishtext.php (require it from the lesson):
 *   SourceText() / PoemHtml() / PlayHtml() - quoted texts in a source box;
 *   TextDock() - the texts beside the questions; ForExam() / ForExamText() -
 *   a fact shown in the viewer's exam only; AnswerExamples() - strong /
 *   middling / weak answers with reasons; SourceQuote(), SceneTimeline();
 *   ...AnalysisPanel([...]) - a guided analysis that builds a 'written'
 *   answer (returns [prose, written]). See AIResources/platform-english-helpers.md.
```
