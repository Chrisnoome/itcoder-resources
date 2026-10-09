# CAT Spreadsheets lesson 10: Absolute references and range names - videos

Lesson: `AIPascalCourse/content/catexcel/absolute.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Botha's Bakery's prices (sheet Prices) and Saturday's
takings (sheet Takings) - `tools/sim-screens/catexcel-absolute.ps1` builds
both. Board scenes in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words being talked about.

## catexcel-10.1 Absolute references and F4 (about 7 min)

**Goes:** after the prose block "The $ sign: absolute references" (section
`#dollar`), before the simulation `simVatDollar`.
**The pupil can afterwards:** say why a copied formula goes wrong when one of
its cells must stay fixed, make that reference absolute with F4, and read
$B$2, B$2 and $B2.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Why your copied formula says *0*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Thabo works out the
   VAT on a loaf of bread, copies the formula down - and the brown bread pays
   no VAT, the koeksisters say #VALUE! and a R6 vetkoek pays R96 VAT.
   > Screen: the Prices sheet, Thabo's column C after the copy.
   > Board: Clicky scratching its head next to "R96 VAT on a vetkoek?".
2. **What went wrong (0:40-2:00).** Show Formulas (Ctrl+`): =B5*B2, =B6*B3,
   =B7*B4 ... The price reference should move; the rate should not. Copying
   moves both. B3 is empty (0), B4 is a heading (#VALUE!), B5 is a price (96).
   > Screen: Show Formulas on; highlighter on B2, B3, B4, B5 in turn.
3. **The $ sign (2:00-3:20).** $ in front of the letter and the number locks
   both: =B5*$B$2. The $ has nothing to do with money. Draw the treasure map:
   X stays on the map.
   > Board: a treasure map, X at "B2", a padlock on the B and on the 2.
4. **F4 (3:20-4:40).** Click C5, type =B5*B2, press F4 straight after B2 -
   $B$2. Enter, double-click the fill handle. Click C7: =B7*$B$2. Fn+F4 on
   some laptops.
   > Screen: the typing in C5, the F4 press shown as a key caption.
5. **Mixed references (4:40-6:00).** Press F4 again: B$2, $B2, B2. The $
   locks the part right after it. Mr Botha's quantities table: =$B5*C$4
   copied across and down.
   > Board: the F4 cycle as a ring of four cards; highlighter on each $.
6. **Check your copies (6:00-6:40).** Always click a copied cell or two and
   read the Formula Bar - a wrong number that looks right is the dangerous one.
7. **Sign-off.**

## catexcel-10.2 Range names and a percentage of a total (about 6 min)

**Goes:** after the prose block "A percentage of a total" (section
`#percent`), before the simulation `simShare`.
**The pupil can afterwards:** name one cell in the Name Box and use the name
in a formula, find names in the Name Manager, and work out each row's share
of a total with an absolute reference and Percent Style.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "=B5**VAT* - a name for one cell"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. $B$2 works - but
   =B5*VAT says what it means.
2. **Naming B2 (0:30-1:50).** Click B2, click in the Name Box, type VAT,
   Enter. In C5 type =B5*VAT, copy it down: every copy still says VAT. The
   rules: a letter first, no spaces, nothing like a cell address.
   > Screen: the Name Box being used; highlighter on VAT in the Formula Bar.
3. **The Name Manager (1:50-3:00).** Formulas > Name Manager (Ctrl+F3): VAT,
   15%, =Prices!$B$2. New, Edit, Delete - and a deleted name gives #NAME?.
   > Screen: the Name Manager open; then (a fresh example) a name deleted and #NAME? appearing, Ctrl+Z.
4. **A share of a total (3:00-5:00).** The Takings sheet: =B5/B12 copied
   down gives #DIV/0! (B13 is empty). =B5/$B$12, fill down, Percent Style:
   29%, 13% ... =SUM(C5:C10) gives 100%. Never also times 100.
   > Screen: the typing, the fill, the Percent Style button; Show Formulas at the end.
   > Board: a pie cut into slices labelled "part / whole".
5. **Sign-off (5:00-5:30).** One fixed cell, many formulas.

### In the text

| Video point | Lesson anchor |
|---|---|
| the copied formula's wrong answers, and Show Formulas | `#problem` |
| $B$2, F4, Fn+F4 | `#dollar` |
| B$2, $B2 and the F4 cycle; the quantities table | `#mixed` |
| naming one cell; the rules for names; the Name Manager; #NAME? | `#names` |
| =B5/$B$12, Percent Style, the 100% check, never times 100 | `#percent` |

The IEB section (`#autofill`, the AutoFill Options button) is not in a video:
it is a list of options, taught by its table and questions.
