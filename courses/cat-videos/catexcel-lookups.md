# CAT Spreadsheets lesson 21: VLOOKUP, HLOOKUP and XLOOKUP - videos

Lesson: `AIPascalCourse/content/catexcel/lookups.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Botha's Bakery's orders (sheets Orders, Prices and
Zones) - `tools/sim-screens/catexcel-lookups.ps1` builds it. Board scenes in
the CAT marker style with Clicky (brand/cat-art-style.md); yellow highlighter
on any words being talked about.

## catexcel-21.1 VLOOKUP and HLOOKUP (about 9 min)

**Goes:** after the prose block "VLOOKUP" (section `#vlookup`), before the
simulation `simVlookup`.
**The pupil can afterwards:** write a VLOOKUP and an HLOOKUP with an exact
match and a locked table, read #N/A, and choose between FALSE and TRUE.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Look it *up*, don't type it"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha raised the
   price of cupcakes - and had to change forty orders by hand. A lookup
   would have changed them all at once.
   > Board: Clicky at a till scanning a code, a price popping up.
2. **The lookup table (0:40-1:30).** The Prices sheet: codes in the first
   column, each price typed once.
   > Screen: the Prices sheet (v-p); highlighter on column A.
3. **VLOOKUP's four parts (1:30-3:30).** =VLOOKUP(C4,Prices!$A$2:$C$11,3,FALSE):
   what to find, the table, the column (counted inside the table), FALSE.
   Down the first column to CK03, across to column 3: 120.
   > Board: the four parts in four highlighter colours. Screen: G4 typed, filled down (v-1 to v-4).
4. **Lock the table (3:30-4:40).** Without $: right at the top, #N/A at the
   bottom. F4 after typing the range. Check the last row.
   > Screen: the relative version (v-5), highlighter on Prices!A12:C21 in the Formula Bar.
5. **#N/A (4:40-5:50).** CK04 is not on the list. Fix the data, not the
   formula: type CK03 in C9.
   > Screen: n-1 to n-3.
6. **HLOOKUP (5:50-7:00).** The Zones table runs across. =HLOOKUP(F4,Zones!$B$1:$E$2,2,FALSE).
   Down a column or along a row?
   > Screen: the Zones sheet (h-z), then I4 (h-1, h-2).
7. **TRUE for bands (7:00-8:30).** The discount table from 0, 500, 1000,
   2000: the biggest "from" not bigger than the amount. Sorted, starting at 0.
   > Board: a number line with the bands; R1 200 dropping into the 1000 band. Screen: a-2.
8. **Sign-off (8:30-9:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| a lookup table, codes in the first column | `#table` |
| VLOOKUP's four parts, the column counted in the table | `#vlookup` |
| $ signs, F4, a range name, check the last row | `#dollars` |
| #N/A and its causes, fix the data | `#na` |
| HLOOKUP | `#hlookup` |
| TRUE, bands, sorted first column | `#bands` |

## catexcel-21.2 XLOOKUP (about 4 min)

**Goes:** after the prose block "XLOOKUP" (section `#xlookup`).
**The pupil can afterwards:** write an XLOOKUP with three parts and say how
it differs from VLOOKUP.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "*XLOOKUP*: three parts"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. VLOOKUP counts
   columns and only looks right. XLOOKUP does neither.
2. **Three parts (0:30-2:00).** =XLOOKUP(C4,Prices!$A$2:$A$11,Prices!$B$2:$B$11)
   in D4: what, where, what to bring back. Exact by default.
   > Screen: x-1, x-2.
3. **What it can do (2:00-3:20).** Look left; work across a row; a fourth
   part for "not found". Both boards accept it - but learn VLOOKUP too.
   > Board: VLOOKUP and XLOOKUP side by side.
4. **Sign-off (3:20-3:50).**

### In the text

| Video point | Lesson anchor |
|---|---|
| three parts, exact match, looks left, if-not-found | `#xlookup` |

MATCH and INDEX (IEB) are shown step by step in their simulation; no video.
