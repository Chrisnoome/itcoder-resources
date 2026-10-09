# CAT Spreadsheets lesson 14: COUNTIF and SUMIF - videos

Lesson: `AIPascalCourse/content/catexcel/sumif.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026
(writer B of the Grade 11 chapter). Screen recordings in the **CAT VM
`itcoder-cat`** (Excel 365), on the lesson's own workbook: Botha's Bakery's
orders for 5 to 10 October (sheet Orders) - `tools/sim-screens/catexcel-sumif.ps1`
builds it. Board scenes in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words being talked about.

## catexcel-14.1 COUNTIF and SUMIF: a summary table (about 8 min)

**Goes:** after the prose block "The condition in a cell" (section
`#criteria`), before the simulation `simCountArea`.
**The pupil can afterwards:** count and add up the rows that match a
criterion (a word, a cell, an operator), build a summary table filled down
with absolute ranges, work out a share as a percentage, and check the
summary against the list.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "20 rows into *3 answers*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha's bank
   manager asks which area brings in the most money. The answer is in 20
   rows - somewhere.
   > Board: Clicky sorting order slips into three buckets: Centurion, Pretoria, Midrand.
2. **COUNTIF with a word (0:40-1:40).** =COUNTIF(B4:B23,"Centurion"): 8.
   Quotes round the word; capitals do not matter; the spelling does.
   > Screen: the Orders sheet; highlighter on the eight Centurion cells.
3. **The criterion in a cell (1:40-3:10).** =COUNTIF($B$4:$B$23,G4) in H4,
   F4 for the $ signs, double-click the fill handle: 8, 7, 5. G4 moves, the
   list does not.
   > Screen: H4 typed and filled; Show Formulas to see G5 and G6 in the copies.
4. **SUMIF (3:10-4:50).** Range, criteria, sum_range: test the areas, add
   the amounts. =SUMIF($B$4:$B$23,G4,$D$4:$D$23): R3 395, R3 090, R1 695.
   > Board: the three arguments as three labelled arrows - test here, match this, add there.
   > Screen: I4 typed and filled.
5. **With an operator (4:50-5:50).** =SUMIF(D4:D23,">=500"): R5 260. Sign
   and number together in quotes; no sum_range when the same cells are
   tested and added; the R500 order counts because of the =.
6. **A share (5:50-6:50).** =H4/COUNTA($B$4:$B$23), Percent Style: 40%.
   COUNTA, not 20 - the list will grow.
7. **Check it (6:50-7:40).** The parts add up to the whole: 8 + 7 + 5 = 20;
   R3 395 + R3 090 + R1 695 = R8 180. The nephew's version without $ signs
   gives Midrand R1 515 - and the check catches it.
   > Screen: I6 with =SUMIF(B6:B25,G6,D6:D25); highlighter on B6.
8. **Sign-off (7:40-8:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| COUNTIF with a word; quotes, capitals, spelling | `#countif` |
| the criterion in a cell, the absolute range, filling a summary down | `#criteria` |
| SUMIF's three arguments; =SUMIF(C4:C23,"Cakes",D4:D23) | `#sumif` |
| ">=500", leaving out the sum_range | `#operator` |
| =H4/COUNTA($B$4:$B$23) and Percent Style | `#percent` |
| the parts add up to the whole; the slid range | `#check` |

One video only: COUNTA and COUNTBLANK (the IEB section) are one-line
formulas the simulation `simUnpaid` shows step by step.
