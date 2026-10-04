# AI course - yearly update checklist

**Why this exists** (Chris, 26 September 2026): the AI course is built on
facts that date fast - product names, prices, exchange rates, data-centre
sizes, company losses, "September 2026". **Check this list once a year**
(January), and whenever a lesson is touched. The theory courses have their
own ([theory-yearly-update.md](theory-yearly-update.md)).

**The rule:** a new dated fact in an AI lesson gets a line here in the same
session. When one changes, fix the lesson, its **glossary** entry, the
**study notes** and the **activity code** that repeats it (below), then
update "Last checked" and note it in [../history.md](../history.md).

First compiled 26 September 2026 by scanning `content/ai/` (91 items, 26
YouTube links). Lessons 7, 4, 5 and 6 date fastest. Last checked: never.

## Things that must change together

- **`public/assets/app.js`** keeps its own copies: `costModels` (the
  Haiku/Sonnet/Opus prices), `randsPerDollar = 16`, `vramCards` (8, 16, 32,
  96 GB), `wattsPerCard = 700`, `homeKwhPerMonth = 900`, `eskomCapacityMw =
  52000`, `teracoHallMw = 40`. **Mismatch found:** `coolingOverhead` is 1.3,
  but lesson 5 says "a third" on top (1.33).
- **`content/ai/glossary.php`** repeats: ChatGPT and Chatbot (the product
  list, "most people use it"); Terabyte (largest models about 1 TB); Ollama,
  Pinokio, ComfyUI, Llama, Mistral, Qwen, DeepSeek, Unsloth; Watt (700 W a
  card); Teraco (and its URL); Pretraining and Fine-tuning (card counts,
  timescales); Anthropic (Haiku, Sonnet, Opus); OpenAI, Loss, Profit (losses
  into the 2030s, $1.35 per dollar); Nvidia; Browser extension (Claude for
  Chrome); Robot and Training data.
- Lesson 8 `whatYouKnow` and lesson 5's start repeat figures from lessons
  4-7.

## Flags to look at first

- **Lesson 7 `tokenPrice`:** Sonnet is given as $2/$10; it has been listed
  at $3/$15 - verify all three model prices.
- **Lesson 7 `q2WhoPays`:** marks "advertisers" wrong; free chatbots may now
  carry adverts (ChatGPT reportedly began tests in 2026).
- **Lesson 8 `browserSmarts`:** tells 14-year-olds they can use Claude for
  Chrome "today" - check availability, price and the age rules (consumer
  terms are 18+).

## By lesson

### Lesson 1 - What AI actually is
- Start here popups: ChatGPT is the one most people use; Claude, Gemini, Copilot and their makers - names, makers, the leader.
- Start here: the TikTok feed as everyday AI - still relevant in South Africa.
- `tokens`, `countTokens`, `q2Tokens`: English words about one token, Afrikaans needs more - re-test with current tokenisers.
- `tokens`: AI companies charge by the token - still the pricing model.
- Video `PeMlggyqz0Y`.

### Lesson 2 - Inside a model file
- Start here popup: ChatGPT, Claude, Gemini as chatbots.
- `numberSize` margin: 86 billion neurons close to a "mid-sized model" - what counts as mid-sized now.
- `numberSize`: parameters "normally" 16 bits - the standard precision now.
- `numberSize` aside: Call of Duty Mobile about 8 GB - size, and still a good example.
- `numberSize`, Terabyte popup: 7B is small; big models about 100 times larger; the largest about 1 TB.
- `quantisation`: a 7B download about 4 GB; almost every home-run model is quantised.
- Video `rh7wjcacIX8`.

### Lesson 3 - What makes it run
- Harness popup: Ollama, Pinokio, ComfyUI still exist.
- `runItYourself`: models and software "free, and will always be free" - licences; consider softening "always".
- Ollama popup: free, no account, offline.
- Pinokio, ComfyUI popups: free and open source.
- Llama (Meta still releases open weights), Mistral, Qwen ("among the most-used, South Africa included"), DeepSeek (matched closed models cheaply) popups.
- Enrichment: Qwen 3 TTS, a video model through Pinokio, a "local AI breakthrough".
- Videos `OjrGu0L5K7M`, `W9BX0jyzd2k`, `tRkQl-z3p5s`, `8amsyT4NUrM`, `hl7kwMwkLJU`, `tSuy8bLvo18`, `4BjmZ9Vut6k`, `AS42UINNzR8`, `AbvDURTEGPE`, `d4EWA6yd5cE`.

### Lesson 4 - The hardware bill
- Contents and `cardsCost` (twice): "checked September 2026" / "as it stood in September 2026".
- `notJustMemory`: a normal CPU has 8 or 16 cores.
- `cardsCost`: 16 GB VRAM is an ordinary gaming laptop (many have 8 GB).
- `cardsCost`: RTX 5090 (32 GB) fastest card in shops, about R60 000 - successor, price.
- `cardsCost`: RTX PRO 6000 (96 GB) about US$16 000 / R256 000; no consumer card has 96 GB; launched March 2025 at about $8 500 and nearly doubled "eighteen months later" (memory-chip shortage).
- `q2WhatYouPayFor`: 96 GB card about four times a 32 GB card - recompute.
- `w1FreeToUse`: "tens of thousands of rands", "as much as a car".
- Video `77Sw9MbcjH4`.

### Lesson 5 - Scaling up
- Start here: the R256 000 card holds a 70B model (keep in step with lesson 4); ChatGPT used by millions at once; Claude, Gemini, Copilot.
- `shedFull`: a phone charger about 20 W; the "Don't tell Eskom" doodle.
- `electricityCost`: about 700 W a card, a third extra for cooling, 100 000 cards for a big company's cluster.
- `turnsToHeat`: the newest machines need liquid cooling; evaporative sites use millions of litres a day; Teraco is South Africa's biggest data-centre company, building in Johannesburg "right now" (and the teraco.co.za link).
- `downTheRoad`: JB7 71 000 m², 40 MW, liquid-cooled, about R8 billion, "being built"; Isando heading for 110 MW, Teraco for 500 MW nationally; Eskom about 52 000 MW installed; one company about 1% of the grid; "no power to spare", "at the moment"; note "Figures from September 2026".
- `q3LocalGrid`: the grid situation.
- Videos `vnE5WMwebnE`, `cJZDhfT99yU` (its figure differs from R8 billion - still true?).

### Lesson 6 - How it got made
- Contents: "checked September 2026".
- `pretraining` margin: English Wikipedia over 6 million articles.
- `pretraining`: the arguments (lawsuits, laws) over whose writing was taken.
- `fineTuning`: pretraining months on thousands of cards, fine-tuning hours on one; aside names Unsloth.
- `trainingCost`: GPT-4 about $100M, Gemini Ultra about $190M, Meta's biggest Llama about $170M; "frontier runs of 2026" $200-500M; costs grow about 2.5 times a year and pass $1B "within a couple of years"; callout: hardware half to two-thirds, electricity a few percent.
- `q2` explanations and `q3TrainingCost` ("in 2026") - keep in step.
- `missingData`: robots cannot reliably fold washing; data collection "right now"; the "current bet".
- `w1WhySoFew`: "only a handful of companies" build from scratch.
- Videos `kYkPDaQun4g`, `7ZoIhsKQZFA`.

### Lesson 7 - Who pays
- Start here and `q2WhoPays`: "you are the product" does not fit AI (see Flags).
- `tokenPrice`: Haiku $1/$5, Sonnet $2/$10, Opus $5/$25 "at time of writing" (see Flags); output five times input, big model five times the small one; about R16 to the dollar.
- `whyFree`: a question costs a fraction of a cent to a few tens of cents; free tier runs the cheap model, with limits; ChatGPT paid about $20 (R320) a month, top tier $200.
- `s1WhoReallyPays`: "the government subsidises AI companies" is marked false.
- `nobodyProfits`: OpenAI about $25B revenue, about $14B loss, $1.35 spent per dollar earned; answering questions cost about $8B in 2025, heading for $14B in 2026; about $115B of losses before profit in the 2030s; cost per question down about 95% since launch.
- `bubbleQuestion`: the five big spenders plan $660-690B in 2026 (about double), over $1T a year within five years; no measurable effect on world output since 2022; $662B of leases on unbuilt data centres; they pay from profits, not borrowing; Google about $90B; note "All of this is September 2026".
- `circularDeals`: Nvidia about $100B into OpenAI; the $300B OpenAI-Oracle deal; over $800B of circular deals - did they go ahead?
- `haveArgument`: "660 billion dollars" - keep in step.
- Videos `zhZTpLQj3i0`, `YBQ8l0xd-s8`, `jCIeCzNSq5M`, `9yy_Wz0BbyU`.

### Lesson 8 - Where it goes
- `agents`: "where a lot of the money is going".
- `browserSmarts`: Claude for Chrome "today", asks permission before steps that cannot be undone (see Flags); video `LG1BeuftkgA` - does the product still look like that?
- `robotsMissing`: robot data being built "right now, at enormous expense".
- `agiArgument`: four definitions "in active use"; "AGI by 2030" still sounds like the future?
- `whatYouKnow`: summary figures from lessons 4-7 - keep in step.
- Videos `PbepTelNFwk`, `l_Zg237msTg`, `Q161VLqYbk4`.

### Lesson 9 - Using AI well

- Chatbot age rules: "most chatbots say you must be 13 or older, and under 18
  only with a parent's permission" (checked 1 October 2026; some, like Claude,
  are 18+).
- "Some newer chatbots search the web first and show where they found things."
- The History facts in `mw9CheckThese` (16 June 1976, about 20 000 marchers,
  Hector Pieterson aged 12, Youth Day) - stable, but they are the right ones
  to keep right.
