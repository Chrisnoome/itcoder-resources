# Course: How AI really works (`ai`)

Grade 9, eight lessons. Written, restyled and deployed on itcoder v1 in
September 2026. Moved here from itcoder v1's CLAUDE.md on 11 September 2026.

**Where it lives now:** the 8 lesson files and a new `content/ai/index.php`
lesson map (v1 had no such file - its map was hardcoded in `lib/content.php`)
were mechanically copied into `Projects/AIPascalCourse/content/ai/` on 11
September 2026, right after cutover. `tests/tokeniser.test.js` was copied too.
**OPEN, AND OPEN ON LIVE, since 13 September 2026 (Chris).** It was `draft` for the two reasons
below. The first is done - all six activities are ported and wired up in
`public/assets/app.js`. The second is not, and Chris opened it anyway: the
lessons work, they just still look like v1. **The restyle is still on the
backlog - it is no longer a gate on pupils seeing the course.** All eight
lessons were re-checked through v2's current `lesson.php` on the day it
opened (every one renders clean, and each now carries the system-wide
"evaluate my performance" panel and the lesson bookmark).

Opening it on live was done as a **single-file change** - `lib/course.php`,
diffed against the live copy first to confirm the status line was the only
difference, with the old file kept aside as a `.bak-`. It needed nothing else:
live already had all eight lessons in `content/ai/` and the code to render
them (checked before flipping - all 8 load). So the AI course being open on
live is INDEPENDENT of the big pending deploy in `open-items.md`, which is
still waiting to be run.

The two things that were the reasons:

1. **Port the six activities** - v1's original source stays at
   `Projects/AIWebCourse/itcoder/` (`public/assets/app.js`, `public/lesson.php`'s
   `case 'activity':`) as the reference; v2's `lesson.php` still only has the
   original stub. Scoped 11 September 2026: ~500-600 lines of vanilla JS to
   adapt (mostly straightforward calculators - `modelSize`, `vramFit`,
   `dataCentrePower`, `costPerQuery` - plus one small stateful game,
   `nextToken`, and one genuinely nontrivial piece, the shared subword
   tokeniser engine behind `tokenCounter`/`costPerQuery` and
   `SplitIntoTokens`), and six bespoke markup branches (`lesson.php`'s
   `activity` case is one dispatcher with hard-coded HTML per activity id, not
   a content-driven template - each needs hand-transcribing, not copying).
   **The API/DB side is already done and course-aware** -
   `public/api/activity.php` in v2 is already a more evolved rewrite
   (`courseId`, enrolment check, `pupilId`) backed by `schema.sql`'s
   `activityState` table - nothing to build there.
2. **Restyle to match the Pascal course's conventions** - `Gloss()`/`Aside()`
   popups, `reveal` blocks, mixed question types, the house-style deduction,
   even-marks rule (see "Quizzes and written answers" below - this predates
   that rule and needs re-weighting). Chris's explicit instruction, 11
   September 2026: not a mechanical copy. Being done lesson by lesson in local
   XAMPP (both courses side by side), the same careful way the two Pascal
   lessons were built - not attempted in one pass.

## What it is for

Teach fourteen-year-olds what AI actually is: what it runs on, what it costs to
build and run, and who pays. The question every pupil should be able to answer
with real numbers by lesson 8:

**When you type a question into a chatbot for free, who pays, and how much?**

## Lesson order

Each lesson earns the next. Don't reorder without good reason.

1. **What AI actually is** - rules vs learned patterns; it predicts the next
   token. Tokens are introduced here as *mechanism*.
2. **Inside a model file** - weights, parameters, quantisation, why 7B is about
   4 GB.
3. **What makes it run** - the harness (tokeniser, chat template, context window,
   sampling), plus a "run one yourself" section (GPU, open source, Ollama /
   Pinokio / ComfyUI, a few open-weight models to try) and "Making pictures" -
   image/audio/video generation as the same guess-check-adjust idea aimed at
   pixels, sound or frames instead of tokens. **Changed 2026-09-12 (Chris):**
   the Ollama-then-Pinokio-and-ComfyUI demo moved from live-in-class to three
   video slots (blank `youtubeId`s, still need vetting) - the "Demos" section
   below is now stale for this lesson, kept only for Chris's own record of how
   it used to run.
4. **The hardware bill** - VRAM, the 3080 Ti vs a 96 GB Blackwell, in rands.
   Includes a short explanation and picture of what a video card is.
5. **Scaling up** - one card to a data centre. Power, water, cooling. Local angle:
   the SA grid, nearby facilities.
6. **How it got made** - training data, pretraining vs fine-tuning (Unsloth,
   conceptual only), the cost of a run, robot spatial-data capture.
7. **Who pays** - tokens return *with a price*. Cost per query, loss-making,
   investment levels, circular financing, the bubble question. Structured
   debate. Four videos, framed as "split them between you, one each, then report
   back" - all four plus the debate will not fit in one period.
8. **Where it goes** - agents, robots, AGI, plus the end assessment. Four videos,
   one per topic (the two on agents overlap - the second one's `watchFor` says to
   pick one). With the 5-mark capstone as well, **this is the tightest lesson for
   time** - an open concern.

Shape: cost-of-running -> cost-of-building -> cost-to-you -> who-pays.

## Scope decisions already taken

- Pinokio and ComfyUI are a ten-minute demo inside lesson 3, not a lesson. The
  hook, not the content.
- Unsloth stays conceptual. A live fine-tune won't finish in a period and will
  fail in front of the class. Show a before/after instead.
- AGI is folded into lesson 8 as definitions-and-disagreement, not philosophy.
- Every video slot in all eight lessons is filled (Chris vetted each one).

## Interactive activities, and what each must never break

- **`nextToken`** (lesson 1) - pick the next word, then see what a model
  predicted and how sure it was. The probabilities are illustrative, not live API
  output.
- **`tokenCounter`** (lesson 1) - live token splitting, approximate, and the page
  says so. The moment to aim for: the same sentence in English, then Afrikaans,
  and the count jumps. `SplitIntoTokens` fakes a byte-pair tokeniser with a
  vocabulary of ordinary English words: a known word is one token, anything else
  is chopped into roughly three-character pieces. That gives English about 4.2
  characters a token and Afrikaans about 3.0 - a gap of about 1.4x, close to what
  a real tokeniser does. **It must never break two things:** the tokens join back
  into exactly the text typed, and "unbelievable" comes out as un/believ/able,
  because the lesson says so. Both are covered by `tests/tokeniser.test.js`,
  which reads the function out of the real `app.js` - run it with node after
  touching any of this, and move it with the activity at the port.
- **`modelSize`** (lesson 2) - parameters x bits per parameter -> file size, with
  a 128 GB phone as the yardstick. It stops at file size on purpose: whether it
  fits a card is lesson 4's job.
- **`vramFit`** (lesson 4) - the same sum with a card added and a fifth held back
  for context and workings. The moment: a 70B model at 4 bits falls over on the
  16 GB laptop in the room and fits the 96 GB card at about R256 000. Shares
  `BuildChoiceRow` and `TidyNumber` with `modelSize`.
- **`dataCentrePower`** (lesson 5) - cards -> megawatts -> Johannesburg homes ->
  share of Eskom's grid. Every constant (700 W a card, 1.3x for cooling, 900 kWh a
  month a house, 52 000 MW of grid) is also in the lesson prose, so a pupil can
  check the sum by hand. The moment: 50 000 cards comes out at almost exactly the
  40 MW Teraco is building at Isando.
- **`costPerQuery`** (lesson 7) - the payoff for the lesson 1 tokeniser: the same
  `SplitIntoTokens` counts the question, then it is priced per million tokens and
  converted to rands. The moment: a much longer question barely moves the cost -
  output dominates, which is the answer to the quiz right below it.
- Never built: a GPU shopping trip (R500 000 budget). Not needed; lesson 4 carries
  its weight without it.

## Quizzes and written answers

- 23 quiz questions, two attempts each (platform.md, decision 4).
- 8 written questions, marked by Claude Haiku against a rubric. Lesson 8's last
  is the capstone, worth 5 - which also puts it in essay mode.
- **All eight written questions break v2's even-marks rule** (platform.md,
  decision 8), which v1 predates: lessons 1-7 are worth 3, lesson 8's capstone 5
  (checked 11 September 2026). Re-weight all eight when porting - weight the
  hardest criterion at 2 and say why in the rubric. **Take the capstone up to 6,
  not down to 4:** essay mode switches on at `markMax >= 5`, so at 4 it would lose
  its big answer box.

## Demos (Chris's laptop, through the projector)

- Lesson 3: **stale as of 2026-09-12** - the live Ollama / Pinokio / ComfyUI
  demo below was replaced with three video slots in the lesson content itself
  (see lesson order above). Kept here as a record of the original plan in
  case a live demo ever comes back.
- Lesson 3 (original plan): Ollama, then Pinokio + ComfyUI. Pre-install and
  pre-pull everything; record a three-minute fallback capture of each.
- A teacher pack - demo run sheet with exact commands, answer key, fallback plan -
  is not written yet (open-items.md).
