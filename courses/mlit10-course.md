# Course: Grade 10 Mathematical Literacy - a year of scenarios (`mlit10`) - PLAN

**Status (10 October 2026):** batch 1, Kota Kitchen, is written: 8 lessons in
`AIPascalCourse/content/mlit10/` (the whole year's 71 lessons are in `index.php`; the rest
show as "coming soon"), with its art from `tools/mlit10/make_art.py`, `caps.php`,
`sags.php` and `glossary.php`. Every numeric answer was tried on the testbed with lenient
typings (R 33, 2.5m, 3¾, R135 per kg, 2h30). The numeric answer type is built
(platform.md, "Typed answers"). Next: the graph-and-grid engine, which batch 2 (Car Wash)
needs. The course row is `open`, so it shows on the site once published.

Chris, 10 October 2026: "maths lit lends itself to different scenarios and graphical
themes. plan out a course for grade 10 that covers caps and sags grade 10 over a normal
school year. each batch of lessons can follow a scenario - like the games for the grade
7-9 courses as long as all academic objectives are met".

- **Plan page:** https://claude.ai/artifact/QYeWgaWmdXgKfRYmPVGotC. It holds the full
  coverage table and the assessment map.
- **Art:** [../brand/mlit10-art-style.md](../brand/mlit10-art-style.md) (board
  https://claude.ai/artifact/3f3FzFohjv3KPcuB759Nxy).
- **Research behind it:** `itcoder-coursedev`, branch `subjects-research`,
  `subjects/mathematical-literacy/course-plan.md`, with the sources in
  `sources/mathematical-literacy/` (CAPS, the Grade 10 ATP 2023/24, the IEB SAGs 2026 and
  the 2023-2025 papers).

## Chris's decisions (10 October 2026)

- **12 scenario batches, about 71 lessons of about 30 minutes**, in the order of the DBE
  Grade 10 ATP (2023/24, kept for 2026 by Circular S19 of 2025). That is about 2 lessons a
  week over 34 teaching weeks.
- **One course for both boards.** The IEB examines the CAPS content (SAGs p. 26/3) and
  sets no Grade 10 syllabus, so CAPS order and wording lead. IEB notes appear only where
  the assessment differs.
- **Art:** F2 sign-painter streets as the course frame, with **theme A** for each batch.
- **Mascot:** **Hadi** the hadeda, drawn the riso way in F2's colours.
- **Level names:** SA money, 10c up to R200 (below).
- **Graphs:** the **graph-and-grid engine is built first**. Batch 2 (Term 1 week 5) and
  the graph parts of batches 5, 10 and 11 wait for it. There is no paper-only fallback.
- **New-course musts** apply: `'sequential' => true`; guided try-its and the Job are
  gates; the course's own RankFamily; margin extras (Hadi doodles, asides, factoids, jokes)
  in every lesson. Status `open` from the start (or `soon`), never draft.
- **Jev first** in marking (below).

## The story frame

The pupil becomes the "numbers person" for an extended family and a group of friends.
Each batch drops them into a different job, and Grade 10 keeps contexts personal and
household (CAPS pp. 11-12). The cast comes back together in the final Road Trip. Names are
placeholders until the first lessons are written:
- **Gogo Nomsa** runs the house and keeps the shoebox of bills;
- **Aunt Thandi** owns the kota food truck;
- **Lwazi**, a cousin in Grade 10, is class treasurer;
- **Priya** runs the school radio station;
- **Jaco** organises the car wash and is mad about football;
- **Hadi** the hadeda squawks at rounding errors and missing units.

## How a batch runs

1. **The brief.** A message from a cast member, the scene picture (batch theme) and the
   problem.
2. **The documents.** Real-looking South African documents in the document panel, which
   stays beside the questions.
3. **Learn it.** Short explanations, worked examples and try-its. Guided steps are gates.
4. **Quick checks.** Paper-style Level 1-4 items: reading values, matching terms,
   calculations, "give a reason".
5. **The Job.** The batch's last lesson ends in a multi-part task in the integrated Q4-5
   style. It is step-marked like a memo (MA, CA, RT, R) and gated.
6. **Job done.** The batch's stop lights up on the minibus route (the year map), and the
   next batch is teased.

## The batches

Week numbers are ATP weeks. Page numbers are printed CAPS pages.

### Term 1

**1. Kota Kitchen** - Numbers and calculations, weeks 1-4, 8 lessons, CAPS pp. 25-35.
Aunt Thandi's kota truck at the Saturday market.
1. The price board: decimal comma, separators, numbers in words, negatives, dozen and gross.
2. Cash-up: operations, BODMAS, the calculator (squares, cubes, roots).
3. Half a loaf: fractions.
4. Round it how?: rounding up, down and off; decimal places.
5. The secret sauce: ratio, sharing in a ratio.
6. Feeding a crowd: direct and inverse proportion.
7. Rand per kilogram: rates, the best buy, km per litre.
8. Specials and mark-ups: percentages, % increase and decrease.

Job: Market Saturday (stock order for 120 customers, packs, cost, price board with a 10%
special).

**2. Car Wash Saturday** - Patterns, relationships and representations, weeks 5-6, 5 lessons,
CAPS pp. 38-42. One relationship at a time, no estimating (CAPS p. 22). **Needs the graph
engine.**
1. Three kinds of relationship: constant, direct and inverse.
2. Tables of values: dependent and independent variables, missing values.
3. Formula to graph: plotting, discrete vs continuous.
4. Reading the graph: values, zero values, minimum and maximum, trends.
5. The graph tells a story, and a story becomes a graph.

Job: the day's report (tally, table, formula, graph, story).

**3. Radio 10 Listener Survey** - Data handling part 1, weeks 7-9, 5 lessons, CAPS pp. 81-85.
1. Ask a good question: wording, population and sample.
2. Collecting it: questionnaires, observation, tallies, fair samples.
3. Sorting it: categorical/numerical, discrete/continuous, frequency tables, intervals.
4. The middle and the spread: mean, median, mode, range.
5. Which average tells the truth?: extreme values, choosing a measure.

Job: What does Grade 10 listen to? (a mini-investigation, which rehearses the Term 1 task).

**Term 1 assessment lessons** (weeks 10-11):
- A1, Investigation workshop: how an investigation is built and marked, with a model
  write-up to critique.
- A2, Term 1 test: a checkpoint in paper format, Levels 30/30/20/20.

### Term 2

**4. Gogo's Shoebox** - Financial documents, weeks 1-2, 4 lessons, CAPS p. 49.
1. The municipal bill.
2. Till slips and store accounts (first meeting with the VAT line).
3. The bank statement.
4. Where does the money go? (reading and completing a household budget).

Job: month-end for Gogo.

**5. Plan Wars** - Tariff systems, weeks 3-4, 4 lessons, CAPS p. 50.
1. Prepaid electricity: block tariffs.
2. Phone and data: cost from a formula, cost per GB.
3. Taxi, bus or e-hailing: base fee plus per-km rate.
4. Tariffs as graphs (one at a time); bank fees from tables and formulae. **Graph engine.**

Job: the family cost sheet (rehearses the Term 2 assignment, CAPS "Represent electricity
costs graphically").

**6. The Great Bake-Off** - Measurement, weeks 5-6, 6 lessons, CAPS pp. 63-67, 70-71.
1. Metric moves: conversions with factors and tables.
2. Spoons and cups: kitchen measures, scaling a recipe.
3. Read the instrument: ruler, tape, scale, jug; accuracy; cost of a measured amount.
4. Oven heat: temperature (Fahrenheit waits for Grade 11).
5. Clock watching: time formats, elapsed time, unit conversions up to decades.
6. The broadcast schedule: TV and study timetables, calendars.

Job: Showstopper (CAPS Grade 10 assignments "Baking a cake" and "Measuring accurately").

**7. Matchday** - Scale and maps, weeks 7-8, 4 lessons, CAPS pp. 73-75.
1. What scale means: number and bar scales.
2. The precinct map: layout maps, positions relative to buildings.
3. Find your seat: seating plans, block, row and seat numbering, house numbering.
4. Giving directions: following and writing directions, with distances from the scale.

Job: get the squad to Block K.

**8. Games Night** - Probability, week 9, 3 lessons, CAPS pp. 90-93.
1. How likely?: the probability scale, fraction, decimal and %, weather forecasts.
2. Fair or not?: events, outcomes, relative frequency vs theoretical (simulator).
3. All the outcomes: tree diagrams and two-way tables, listing outcomes only.

Job: is the spinner rigged?

**Term 2 assessment lessons** (weeks 10-11):
- A3, Assignment workshop: the Plan Wars or Bake-Off Job as an assignment, with Jev
  pre-checking the write-up as a guide.
- A4, June exam practice: a P1 section and a P2 section covering Terms 1-2.

### Term 3

**9. The Trip Fund** - Finance, weeks 1-5, 8 lessons, CAPS pp. 51-52, 54-55, 58.
1. Money in: income types.
2. Money out: fixed, variable and occasional expenditure.
3. The income-and-expenditure statement; profit and loss.
4. Make a budget: plan vs actual.
5. VAT on the receipts: inclusive and exclusive prices, 15%, zero-rated items.
6. Interest rate vs interest; simple interest by hand.
7. Interest on interest: compound interest by hand, compared with simple.
8. Which account?: banking terms, charges from tables and formulae, a bank-charges graph.

Job: the treasurer's report (rehearses the Term 3 assignment, CAPS "Developing a household
budget").

**10. Room Rescue** - Perimeter and area plus plans, assembly and models, weeks 6-9, 8 lessons,
CAPS pp. 68-69, 76-80. 2D only, formulae given, π = 3,142, prices supplied.
1. Around the edge: perimeter.
2. Covering the floor: area of rectangles and triangles, whole tiles, paint estimates.
3. Round bits: circles, semicircles, quarter and three-quarter circles.
4. Reading a floor plan: symbols and notation.
5. Measuring on the plan: real lengths, quantities, cost (on-screen ruler).
6. Draw your own plan; suggest another layout. **Graph engine (rectangles to scale).**
7. Flat-pack: assembly diagrams.
8. Pack the truck: packing tins and boxes, the cheapest packaging.

Job: the Reveal (an alternative Term 3 assignment: CAPS "Designing and costing a small
vegetable garden" or "Which box should you use?").

**Term 3 assessment lessons** (weeks 10-11):
- A5, Assignment workshop.
- A6, Term 3 test: covers batches 9-10.

### Term 4

**11. Weather Watch** - Representing data, weeks 1-2, 5 lessons, CAPS pp. 86-88.
**Graph engine.**
1. Bar graphs.
2. Line and broken-line graphs.
3. Histograms.
4. Pie charts (interpret only).
5. What the graph really says: analysis, misleading axes, choosing a graph.

Job: the season report.

**12. The Road Trip** - Revision and exam technique, weeks 3-6, 5 lessons.
1. How the papers work: P1 (Finance, Data, Probability) and P2 (Maps, Measurement,
   Probability); levels; working, units and rounding; DBE answer book vs IEB
   answer-on-the-paper.
2. Question 1 drills (Level 1).
3. Paper 1 stops (integrated questions, "verify ... valid").
4. Paper 2 stops (integrated questions).
5. Practice papers: P1 and P2, 75 marks and 1 h 30 each, in the ATP Grade 10 layout (Q1
   20% Level 1; Q2-3 one topic each; Q4-5 integrated).

## Formal assessment (SBA) map

| Slot | CAPS Table 2a (Gr 10) | DBE ATP 2023/24 | IEB (Gr 10 follows the Gr 12 format, SAGs p. 26/5) | Here |
|---|---|---|---|---|
| T1 task | Assignment/Investigation 10% | Investigation | Alternate task 1 | A1, Radio 10 Job |
| T1 test | Control test 15% | Controlled test | Standardised test 1 | A2 |
| T2 task | Assignment/Investigation 10% | Assignment | (optional) | A3, Plan Wars / Bake-Off Job |
| T2 exam | Examination 30% | Mid-year exam | June exam | A4 |
| T3 task | Assignment/Investigation 10% | Assignment | Alternate task 2 (another type) | A5, Trip Fund / Room Rescue Job |
| T3 test | Control test 15% | Controlled test | Standardised test 2 | A6 |
| T4 task | Assignment/Investigation 10% | **none** | - | optional: Weather Watch Job |
| Final | 75% of the year | P1 + P2, 75 marks, 1 h 30 | P1 + P2 | batch 12 |

Not confirmed: Circular S33 of 2022, which sets today's weights, is not on the DBE site, so
the percentages are CAPS's. The platform rehearses the tasks; schools set and mark the real
ones.

## Level names (RankFamily `mlit10`)

Add `mlit10` to the per-course list in `RankFamily()` (`lib/practice.php`) and give
`PracticeRanks()` these nine:

| Rank | Meaning |
|---|---|
| 10c | Small change. Everyone starts here. |
| 50c | You can read a till slip without panicking. |
| R1 | Rounding up, down and off, and you know which. |
| R5 | Ratios and rates come naturally. |
| R10 | Bills and tariffs hold no secrets. |
| R20 | You measure twice and convert once. |
| R50 | Maps, plans and scale make sense. |
| R100 | You show every step, with units. |
| R200 | The top rank. |

## Marking: Jev first

- **Code:** numeric answers (decimal comma or point, separators, R and units, ranges,
  rounding rules, fractions, times) and reading values from documents.
- **Jev:** each creditable point in "give a reason" and "explain" answers (code counts
  them); whether a typed calculation step shows the method (MA) or follows through (CA);
  near-miss terms; writing checks on the Job and task write-ups.
- **Claude:** only when Jev is unsure, or the answer talks to the marker.
- **Rough cost:** 1 000 pupils x 71 lessons x ~15 judgments = ~1.07 M Jev calls at ~600
  tokens = ~640 M tokens = **about US$27 a year** (US$0.042 per million input tokens;
  1 200 requests a minute, 250 000 tokens a second). The Claude escalations get priced once
  the escalation rate is measured.

## Platform work, in build order

1. **Graph-and-grid engine.** It comes first, because batch 2 is Term 1 week 5. Modes:
   points, line through points, step graph, bars and histograms, rectangles to scale.
   Heading and axis-label boxes (the memos give marks for them). Per-element marking with a
   tolerance. Shares ideas with the Mathematics plan.
2. **Numeric answer type.** Needed from batch 1, week 1. Shared with the Maths and
   Geography plans.
3. **Document panel.** Zoomable SA documents beside the questions; one tap away on a phone.
4. **Job block.** A multi-part, step-marked task in the style of pascal9's `mission`, with
   memo codes and Jev per step.
5. **On-screen ruler** (batch 7) and **label-the-figure answers** (batches 7 and 8).
6. **Try-its:** recipe scaler, tariff slider, dice simulator, interest table, room
   planner.
7. **Year-dated figure checker:** VAT, tariffs and fees, refreshed each March.

## Still open

- The cast's final names and Hadi's model sheet (to be drawn by `tools/mlit10/make_art.py`).
- Whether De La Salle teaches Maths Lit, which decides who the first audience is.
- A Maths Lit teacher to review each batch (the research plan's recommendation).
- Lesson length: 71 x ~30 min was accepted. Recheck it after the first batch is written.
