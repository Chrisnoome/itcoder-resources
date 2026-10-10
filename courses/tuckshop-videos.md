# Grade 7 Tuck-shop tycoon - video plans for the video chat

Chris, 10 October 2026: "vide requirements to the video queue". The course is `tuckshop`
(`AIPascalCourse/content/tuckshop/`; plan [tuckshop-course.md](tuckshop-course.md)).

There are **8 videos, one per lesson, about 45 minutes in all.** Each **Goes** line gives the
place in the lesson. Add a `// VIDEO tuckshop-NN.n` comment there when you start the video.

## Rules

- **Method and voice:** follow [tutorial-videos.md](tutorial-videos.md).
- **Thumbnails** come from a new `thumbs-tuckshop.json`:
  - background `#10301d`, accent `#ffd84d`, second colour `#e8483b`;
  - tag `SPREADSHEETS · SQUARE N`.
- **The look** is [../brand/tuckshop-art-style.md](../brand/tuckshop-art-style.md):
  - the board game, with the pawn on the lesson's square (`doodles/tuckshop-board-NN.svg`);
  - **Till** (the cash register) and **Calc** (the calculator) in speech bubbles, with their
    running joke: Calc types answers in, and Till only rings for formulas.
- **Real Excel on screen.** Record the formulas in **Excel** in the CAT VM, so the pupils see
  the program they will use in the lab: the ribbon, the fill handle, AutoSum, formats and the
  chart tools.
  - Show each formula in the Formula Bar as well as its answer.
  - Zoom so the cells are readable.
  - Once per course, in video 1, show that the lesson's own spreadsheet block works the same
    way.
- **Never show a marked step's answer.**
  - Use the lesson's worked examples and different numbers. For example, a sports-day snack
    stall with its own items and prices, not the tuck shop's sheets.
  - Video 8 shows how to build a budget, not the big sale's sheet.
- **Calc's mistake on purpose**, in videos 1 and 2:
  - type an answer in;
  - change a price;
  - show the typed answer go wrong while the formula follows.
- Nothing goes in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| tuckshop-01.1 | Cells, rows, columns and your first formula | 6 | `formula` after `s1Numbers` |
| tuckshop-02.1 | Formulas that do the work, and the fill handle | 6 | `fill` after `q2Order` |
| tuckshop-03.1 | SUM, AutoSum and AutoFill | 5 | `auto` after `q3Range` |
| tuckshop-04.1 | Profit, and why brackets matter | 5 | `week` after `q4Loss` |
| tuckshop-05.1 | AVERAGE, MAX and MIN | 5 | `hide` after `q5Average` |
| tuckshop-06.1 | Make it readable: formats and widths | 6 | `neat` after `q6Hashes` |
| tuckshop-07.1 | Charts: choose, make and label | 7 | `excel` after `s7BadChart` |
| tuckshop-08.1 | Budgets and "what if" | 5 | `whatif` before `w8Advice` |

## What each video covers

Each video:
1. **Hook:** the board, the pawn on its square, and Till and Calc.
2. **The idea:** shown on the grid.
3. **Build:** in Excel.
4. **Recap.**
5. **Sign-off.**

What each one must show:
- **01.1:**
  - columns, rows and addresses;
  - the Name Box and the Formula Bar;
  - text on the left, numbers on the right, and why you never type R;
  - `=B2+B3` by clicking the cells.
- **02.1:** `+ - * /`, brackets first, and the fill handle (watch the row numbers change).
  Then the same thing done with Ctrl+D.
- **03.1:** ranges with a colon, `=SUM(...)`, the Σ button (check its range), and AutoFill
  for Mon to Fri.
- **04.1:** selling price minus cost price, a loss shown as a negative number, and `(B-C)*D`
  with and without the brackets.
- **05.1:** MAX and MIN give a number, and you read along the row to find the item. Also an
  average that hides a broken machine.
- **06.1:**
  - Currency format and two decimals;
  - #####, and double-clicking the column line;
  - bold headings;
  - formatting doesn't change the value: compare the cell with the Formula Bar.
- **07.1:**
  - column, line and pie charts, and when each fits;
  - Insert, then Chart Elements for the title and axis titles;
  - an axis that doesn't start at 0, and how it misleads.
- **08.1:** money in against money out, the target, and changing one number to watch every
  total move.
