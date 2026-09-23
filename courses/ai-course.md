# Course: How AI really works (`ai`)

Grade 9, eight lessons, `content/ai/` in `AIPascalCourse`, **open and live**.
All six activities are ported (`public/assets/app.js`, `lesson.php`'s
`activity` case; `api/activity.php`, `activityState`). The **restyle** to
the current lesson rules (popups, reveals, mixed question types) is not
finished - the lessons still largely read as v1. Do it lesson by lesson, not
mechanically. v1's source is `Projects/AIWebCourse/itcoder/` (reference only).

## Purpose

What AI runs on, what it costs to build and run, and who pays. By lesson 8
every pupil can answer with real numbers: **when you type a question into a
chatbot for free, who pays, and how much?**

## Lessons (each earns the next - don't reorder)

1. **What AI actually is** - rules vs learned patterns; next-token prediction;
   tokens as mechanism.
2. **Inside a model file** - weights, parameters, quantisation, why 7B is ~4 GB.
3. **What makes it run** - the harness (tokeniser, chat template, context
   window, sampling); "run one yourself" (GPU, open source, Ollama / Pinokio /
   ComfyUI - now video slots, not a live demo); "Making pictures" (image,
   audio, video generation as the same guess-check-adjust idea).
4. **The hardware bill** - VRAM, the 3080 Ti vs a 96 GB Blackwell, in rands;
   what a video card is.
5. **Scaling up** - card to data centre: power, water, cooling; the SA grid and
   local facilities.
6. **How it got made** - training data, pretraining vs fine-tuning (Unsloth,
   conceptual), cost of a run, robot spatial-data capture.
7. **Who pays** - cost per query, loss-making, investment, circular financing,
   the bubble; structured debate; four videos split between pupils.
8. **Where it goes** - agents, robots, AGI (definitions and disagreement), and
   the final assessment (`w1FinalAssessment`, markMax 30, banded rubric -
   the model for big rubrics). **The tightest lesson for time.**

Shape: cost of running -> cost of building -> cost to you -> who pays.

## Scope decisions

- Unsloth stays conceptual (a live fine-tune won't finish in a period).
- AGI is definitions and disagreement, not philosophy.
- Videos are vetted by Chris; the AI course may use blank-id placeholders.
- Written questions: lessons 1-7 markMax 4, lesson 8 capstone 30 (even; essay
  mode from 5).

## Activities - what each must never break

- **`nextToken`** (1) - pick the next word, see the model's illustrative
  prediction and confidence.
- **`tokenCounter`** (1) - approximate live token splitting (the page says so).
  `SplitIntoTokens`: known English words are one token, anything else ~3-char
  pieces (English ~4.2 chars/token, Afrikaans ~3.0). **Must never break:**
  tokens rejoin to exactly the typed text; "unbelievable" -> un/believ/able.
  `node tests/tokeniser.test.js` reads the function from the real `app.js`.
- **`modelSize`** (2) - parameters x bits -> file size, vs a 128 GB phone; stops
  at file size (fitting a card is lesson 4).
- **`vramFit`** (4) - same sum plus a card, a fifth held back for context. The
  moment: 70B at 4 bits fails on the 16 GB laptop, fits the 96 GB card
  (~R256 000). Shares `BuildChoiceRow`, `TidyNumber`.
- **`dataCentrePower`** (5) - cards -> MW -> Johannesburg homes -> share of
  Eskom. Constants (700 W/card, 1.3x cooling, 900 kWh/month/house, 52 000 MW)
  are also in the prose. 50 000 cards ~ Teraco's 40 MW at Isando.
- **`costPerQuery`** (7) - `SplitIntoTokens` counts the question, priced per
  million tokens in rands; a longer question barely moves the cost (output
  dominates) - the answer to the quiz below it.

## Not written yet

Worksheets, a teacher pack (demo run sheet, answer key, fallback),
assessment weight, lesson 8 timing - see [../open-items.md](../open-items.md).
