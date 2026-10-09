# CAT Spreadsheets lesson 11: ROUND, POWER, LARGE and SMALL - videos

Lesson: `AIPascalCourse/content/catexcel/rounding.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Lerato's flat (sheet Shares), Gogo Dlamini's fixed
deposit (Savings) and Ms Naidoo's test marks (Marks) -
`tools/sim-screens/catexcel-rounding.ps1` builds them. Board scenes in the
CAT marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words being talked about.

## catexcel-11.1 Rounding is not formatting: the ROUND function (about 7 min)

**Goes:** after the prose block "The ROUND function" (section `#round`),
before the simulation `simRound`.
**The pupil can afterwards:** explain the difference between formatting a
number and rounding it, and use ROUND with 2, 1, 0 and negative digits.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Your spreadsheet is *out by 1c*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Naledi adds up the
   shares on her phone: R1 089.66. Lerato's sheet says R1 089.67. Who is
   wrong?
   > Board: Naledi's phone calculator and the sheet side by side, highlighter on the two totals.
2. **What the cell really holds (0:40-2:20).** 1000 / 3 = 333.333...; two
   decimals only show 333.33. Switch the column to General: 333.3333333.
   SUM adds the full numbers. Formatting changes the look, not the number.
   > Screen: the Shares sheet, then the General format.
   > Board: the iceberg - "333.33" above the water, "...3333" below.
3. **ROUND (2:20-4:30).** =ROUND(B5/$B$2,2): ROUND around the calculation,
   a comma, the digits. Fill down: the total is now 1089.66.
   > Screen: the typing in C5 and the fill; highlighter on the new total.
4. **The digits (4:30-6:00).** 2 cents, 1 one decimal, 0 whole rands, -1
   tens, -2 hundreds. Mr Botha's round market prices with =ROUND(B5,-1).
   > Board: 1089.6667 on a number line with arrows to 1089.67, 1090, 1100.
5. **Exam words (6:00-6:40).** "The difference between rounding and
   formatting": formatting - only how it is shown; ROUND - the value itself,
   which other formulas use.
6. **Sign-off.**

## catexcel-11.2 Circular references and Excel's help (about 6 min)

**Goes:** after the prose block "Getting help on a function" (section
`#help`), before the simulation `simHelp`.
**The pupil can afterwards:** recognise a circular reference (the warning,
0, the status bar), find it with Formulas > Error Checking > Circular
References, fix it, and get help on a function with fx.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "The total that *adds itself*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Lerato types
   =SUM(B5:B10) in B10 - and Excel complains.
2. **The warning (0:30-1:50).** The box: one or more circular references.
   OK. B10 shows 0.00; the status bar says Circular References: B10.
   > Screen: the typing, the warning, the status bar (highlighter on it).
   > Board: Clicky chasing its own tail round a cell labelled B10.
3. **Finding and fixing it (1:50-3:20).** Formulas > Error Checking (arrow)
   > Circular References > $B$10. Change the range: =SUM(B5:B8). An indirect
   circle: A1 =B1+1, B1 =A1*2.
   > Screen: the menu, the fix, the status bar clean.
4. **Help while typing (3:20-4:00).** The yellow tip ROUND(number, num_digits).
5. **fx and the Function Arguments box (4:00-5:20).** fx on C5: a box for
   Number and Num_digits, the result, Help on this function. fx on an empty
   cell: Insert Function, Search for a function "round a number", Go.
   > Screen: both dialogs.
6. **The Search box and F1 (5:20-5:50).** Alt+Q: type "circular"; F1 for the
   Help pane.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| shown 333.33, held 333.333...; the total out by 1c; the table | `#formatting` |
| =ROUND(number, num_digits); the digits table; round the calculation | `#round` |
| the warning, 0, the status bar; Error Checking > Circular References; the fix; an indirect circle | `#circular` |
| the typing tip; fx; Insert Function; the Function Arguments box; Help on this function; Alt+Q; F1 | `#help` |

POWER, LARGE and SMALL are short typed formulas the simulations show step
by step, and RAND (IEB) is three lines of text - none needs a video.
