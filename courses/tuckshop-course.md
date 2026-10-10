# Grade 7 Tuck-shop tycoon (`tuckshop`) - spreadsheets

Chris, 10 October 2026, chose this course from the Grade 7/8 plan
([grade7-8-courses.md](grade7-8-courses.md)), and from the style board picked:
- **the board-game tycoon look**;
- **Till and Calc** as the mascots.

The art is set out in [../brand/tuckshop-art-style.md](../brand/tuckshop-art-style.md).

| Part | Where |
|---|---|
| Lessons | `AIPascalCourse/content/tuckshop/` |
| Art | `tools/tuckshop/make_art.py`, which draws `doodles/tuckshop-*.svg` |
| Videos | [tuckshop-videos.md](tuckshop-videos.md) |

The course is **sequential**, and **every build step is a gated spreadsheet block** (`sheet`,
`'gate' => true`). Each block is marked from the formulas themselves, on the data shown and on
hidden variations, so a typed answer fails.

The course must show:
- level names (`lib/practice.php`, Shop Helper to Tuck-shop Tycoon);
- margin extras in every lesson: doodles, "Did you know?" facts and a joke;
- its own home page colours.

## The story

The Grade 7 class runs the Ridgeview Primary tuck shop for a term, while Mrs Khumalo is away.
The principal, Mr Naidoo, gives them the shop, and the profit goes to the **Grade 7 farewell**.

- **Till**, the old cash register, only rings for real formulas.
- **Calc**, the calculator, types answers in. Calc's answers go wrong whenever a price changes.

## The shop's numbers

These are the same in every lesson.

| Item | Sells for | Costs us | Box (price / items) |
|---|---|---|---|
| Mince pie | R18 | R11 | R132 / 12 |
| Fruit juice | R12 | R7 | R168 / 24 |
| Muffin | R10 | R6 | R72 / 12 |
| Koeksister | R6 | R3.50 | R70 / 20 |
| Popcorn | R5 | R2 | R60 / 30 |
| Lollipop | R2.50 | R1.20 | R60 / 50 |

**One week of sales**, Monday to Friday:

| Item | Mon | Tue | Wed | Thu | Fri | Week |
|---|---|---|---|---|---|---|
| Mince pie | 24 | 22 | 26 | 20 | 30 | 122 |
| Fruit juice | 31 | 28 | 35 | 25 | 40 | 159 |
| Muffin | 19 | 17 | 21 | 15 | 24 | 96 |
| Koeksister | 40 | 36 | 44 | 32 | 50 | 202 |
| Popcorn | 35 | 30 | 38 | 33 | 45 | 181 |
| Lollipop | 58 | 50 | 64 | 47 | 70 | 289 |

The week's sales come to **1 049** items, and the week's profit to **R3 456.70**.

**The term's takings**, weeks 1 to 8: 2 400, 2 650, 2 550, 2 900, 3 100, 3 050, 3 400 and
3 700.

## The lessons

| # | Id | Title | Gated steps |
|---|---|---|---|
| 1 | `prices` | Cells, rows and columns | `sh1Combo` `=B2+B3`; `sh1Breakfast` |
| 2 | `takings` | Formulas that do the work | `sh2Takings` `=B2*C2` copied down; `sh2Stock` `=B2/C2` |
| 3 | `totals` | SUM: adding it all up | `sh3Week` (across); `sh3Days` (down and the grand total) |
| 4 | `profit` | Profit | `sh4Profit` `=B2-C2`; `sh4Week` `=(B2-C2)*D2` and SUM |
| 5 | `bestsellers` | Best and worst sellers | `sh5Average`; `sh5Best` MAX and MIN |
| 6 | `looks` | Make it readable | `sh6Count` (the cash-up); `sh6ShortOver` |
| 7 | `charts` | Charts | `sh7Weeks`: change, SUM and MAX |
| 8 | `fundraiser` | The big sale (final) | `sh8Budget` (9 marks) and the written `w8Advice` (4 marks) |

**Formatting and charts can't be marked by the spreadsheet block.** In lessons 6 and 7 they
are taught with:
- before and after pictures;
- quizzes, and spot-the-problem questions on drawn charts.

The formulas in those lessons are still in gated sheets: the cash-up in lesson 6, and the
term's takings in lesson 7.

## Checks

These were run on 10 October 2026:
- `check-sheets tuckshop`: 14 blocks sound;
- figures, popup spacing, lesson contents, titles, lesson links, glossary, why and Jev.
  Jev flagged one doodle caption that gave away a quiz answer; it has been reworded.

## Still to do

- The **ComfyUI art** is queued and waiting for the GPU:
  - course icon: `2026-10-10-tuckshop-icon`;
  - badges: `2026-10-10-tuckshop-badges`;
  - level emblems: `tuckshop-0` to `tuckshop-8` in `2026-10-10-gc-rank-emblems`.
- **Publish:** the test site, then live.
