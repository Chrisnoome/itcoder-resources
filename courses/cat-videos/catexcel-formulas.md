# CAT Spreadsheets lesson 3: Formulas and cell references - videos

Lesson: `AIPascalCourse/content/catexcel/formulas.php` (Grade 10). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 8 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on Botha's
Bakery's market day order for Phumlani Secondary (the screen script
`tools/sim-screens/catexcel-formulas.ps1` builds it). Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words being talked about. Crop the title bar (account initials).

## catexcel-03.1 Your first formulas (about 7 min)

**Goes:** after the study block (the comment sits there with 03.2).
**The pupil can afterwards:** write a formula with =, cell references and
the four operators; click cells instead of typing their addresses; work out
a formula in the right order and use brackets; tell a cell's value from its
contents.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Start with *=*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The market day
   order: five items, a total, a discount, two classes paying half each.
   Six sums. Or six formulas that do their own sums for ever.
   > Board: Clicky behind a stall of cupcakes and koeksisters, an order slip with blank amounts.
2. **The first formula (0:40-2:00).** Click D2. Type =B2*C2 (or =, click B2,
   *, click C2). Enter: 288. Click D2 again: the cell shows the value, the
   Formula Bar the contents.
   > Screen: typing and clicking; highlighter on the coloured references and then on the Formula Bar.
3. **The operators (2:00-3:00).** + - * /. No x and no division sign on a
   keyboard. =D2+D3, =D7/2.
   > Board: x and division sign crossed out, * and / circled.
4. **The order (3:00-5:00).** Brackets, then * and /, then + and -. =2+3*4 is
   14, =(2+3)*4 is 20. Each class pays =(D7-D8)/2 = 955; without brackets
   =D7-D8/2 takes off R25 and halves nothing: 1 935.
   > Board: BODMAS steps drawn as a staircase.
   > Screen: type both versions in D9 and compare.
5. **Sign-off.**

## catexcel-03.2 Why a formula points at cells (about 6 min)

**Goes:** after the study block, with 03.1.
**The pupil can afterwards:** explain why a formula uses cell references and
not the numbers; copy a formula with the fill handle and say how its
relative references change; check a sheet with Show Formulas.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Point at the *cell*, not the number"

### Scenes

1. **Cupcakes go up (0:00-1:40).** =6*48 and =B2*C2 both show 288. Change
   B2 to 7: one changes to 336, the total to 2 008, each class to 979; the
   other stays 288 - wrong. A typed answer earns nothing in a test.
   > Screen: two cells side by side; change B2; highlighter on everything that changed.
   > Board: Clicky pointing at a cell with a long finger: "point, don't copy".
2. **Copying a formula (1:40-3:40).** Click D2, double-click the fill handle.
   Click D3, D4, D6: =B3*C3, =B4*C4, =B6*C6. Down changes the row numbers;
   right changes the letters. (Grade 11: the $ sign.)
   > Screen: the fill; each cell's Formula Bar highlighted in turn.
3. **Checking (3:40-5:00).** Formulas > Formula Auditing > Show Formulas
   (Ctrl+`): every formula shows; a typed number stands out. Click again to
   go back.
   > Screen: Show Formulas on, a typed 432 planted in D6 spotted, fixed, Show Formulas off.
4. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| =, cell references, value and contents | `#formula` |
| + - * / | `#operators` |
| brackets and the order; =(D7-D8)/2 | `#order` |
| references, not numbers; the price change | `#references` |
| the fill handle; relative references | `#copying` |
| Show Formulas | `#checking` |
