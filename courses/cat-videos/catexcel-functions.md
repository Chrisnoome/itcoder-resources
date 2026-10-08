# CAT Spreadsheets lesson 5: SUM, AVERAGE, MIN, MAX and COUNT - videos

Lesson: `AIPascalCourse/content/catexcel/functions.php` (Grade 10). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 8 October
2026. Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
same sheet as the lesson: Ms Naidoo's Grade 10A marks (the screen script
`tools/sim-screens/catexcel-functions.ps1` builds it - names, Test 1-3, ABS
in C3). Board scenes in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words being talked about.

## catexcel-05.1 The five basic functions (about 8 min)

**Goes:** after the prose block "Totals with AutoSum" (section `#autosum`),
before the simulation `simAutoSumTotal`.
**The pupil can afterwards:** say what a function is and how it differs from
a formula; use SUM (with AutoSum or Alt+=), MAX, MIN, AVERAGE and COUNT on a
range; copy a function across with Ctrl+R; say what the five do with text
such as ABS.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Five *functions* you use every day"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Ms Naidoo has marked
   three tests for seven pupils. She wants the highest, the lowest, the
   average and how many wrote - for every test. With a calculator, twelve
   sums. In Excel, four formulas.
   > Board: Clicky buried under a pile of test scripts and a calculator; a sticky note "12 sums x 6 classes".
2. **Formula or function (0:40-1:50).** A formula starts with =. A function
   is a ready-made calculation inside it: = , the name, the range in
   brackets. =B2+C2+D2 against =SUM(B2:D2).
   > Board: the shape =NAME(range) drawn in three coloured parts, highlighter on each in turn.
3. **AutoSum and Alt+= (1:50-3:10).** Click E2, press Alt+= - the dashed
   border round B2:D2, check it, Enter: 113. Double-click the fill handle:
   every total. Then Bongani's 59: SUM skips the text ABS.
   > Screen: click E2; Alt+= (key overlay); highlighter on the dashed border and on =SUM(B2:D2); Enter; double-click the fill handle; zoom on E3.
4. **MAX and MIN (3:10-4:30).** Click B10, type =MAX(B2:B8), Enter: 45.
   Select B10 to D10, Ctrl+R. Click C10: =MAX(C2:C8). Then =MIN in row 11 the
   same way.
   > Screen: typing in B10; the selection B10:D10; Ctrl+R (key overlay); the Formula Bar for C10 highlighted.
5. **AVERAGE and COUNT (4:30-6:00).** =AVERAGE adds and divides by how many
   numbers - 33.4 for Test 1. =COUNT counts cells that hold numbers: 6 for
   Test 2, because ABS is not a number. The status bar shows Average, Count
   and Sum of a selection. Warning: never let the range run into the Highest
   row.
   > Screen: select B2:B8, highlighter on the status bar; type =COUNT(C2:C8); show =AVERAGE(B2:B10) giving a wrong answer, then fix it.
   > Board: Clicky crossing out the 45 being counted as an "eighth pupil".
6. **Values and formulas (6:00-7:20).** What you see is the value; the
   Formula Bar shows the contents. Formulas tab > Show Formulas (Ctrl+`).
   A typed 45 earns nothing in a test - and stays 45 when a mark changes.
   > Screen: Show Formulas on and off; change Chloe's 45 to 42 and watch B10 change.
7. **Sign-off.**

## catexcel-05.2 Ranges and range names (about 4 min)

**Goes:** after the prose block "Ranges and range names" (section
`#ranges`), before the simulation `simRangeName`.
**The pupil can afterwards:** write a range for a column, a row and a block;
join two ranges with a comma; name a range in the Name Box and use the name
in a formula; say the naming rules.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Give your *range* a name"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. =AVERAGE(B2:B8) -
   what is in B2:B8? =AVERAGE(Test1) says it.
   > Board: two sticky notes side by side, "B2:B8" and "Test1"; Clicky pointing at the second.
2. **Ranges (0:30-1:40).** B2:B8 a column, B2:D2 a row, B2:D8 a block of 21
   cells; B2:B8,D2:D8 two ranges - =SUM adds Test 1 and Test 3.
   > Screen: each range selected in turn, highlighter on its address.
3. **Naming it (1:40-3:00).** Select B2:B8, click in the Name Box, type
   Test1, Enter. Click B12, type =AVERAGE(Test1), Enter: 33.4. The rules: a
   letter first, no spaces, not like a cell address.
   > Screen: the Name Box highlighted; typing Test1; B12.
   > Board: three name tags - "Test 1" crossed out (space), "B2" crossed out (a cell), "Test1" ticked.
4. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| formula against function; the shape =NAME(range) | `#what` |
| AutoSum, Alt+=, checking the range; SUM skips ABS | `#autosum` (and the reveal `r5Bongani`) |
| MAX, MIN, Ctrl+R, the copied references | `#maxmin` |
| AVERAGE and COUNT skip text; the status bar; the range warning | `#average` |
| values and contents; Show Formulas; typed answers earn nothing | `#values` |
| ranges, the comma, range names and their rules | `#ranges` |
