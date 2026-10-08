# CAT Spreadsheets lesson 6: More functions and error values - videos

Lesson: `AIPascalCourse/content/catexcel/more.php` (Grade 10). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 8 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Mr Botha's loaves (sheet Loaves) and his nephew's
mistakes (sheet Mistakes) - `tools/sim-screens/catexcel-more.ps1` builds both.
Board scenes in the CAT marker style with Clicky (brand/cat-art-style.md);
yellow highlighter on any words being talked about.

## catexcel-06.1 Reading Excel's error values (about 7 min)

**Goes:** after the prose block "The error values" (section `#errors`),
before the match `m6Errors`.
**The pupil can afterwards:** say what each of #####, #NAME?, #DIV/0!,
#VALUE!, #REF! and #NUM! means, find the cause on a sheet, and fix it.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "What *#DIV/0!* is telling you"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha's nephew
   made a sheet of sums, and every answer starts with a hash. Excel is not
   broken - it is telling him exactly what is wrong.
   > Board: Clicky holding a magnifying glass over a cell that says #DIV/0!.
   > Screen: the Mistakes sheet, column D full of errors.
2. **#####  (0:40-1:30).** Not an error at all: the column is too narrow.
   Double-click the line to the right of the D heading - the date appears.
   > Screen: the double-click on the D/E border, highlighter on the date.
3. **#NAME? (1:30-2:30).** =AVRAGE(B4:C4): a name Excel does not know. Click
   the cell, type =AVERAGE(B4:C4) over it, Enter: 92. Some books print
   #NAME! - Excel shows a question mark.
   > Screen: Show Formulas on (Ctrl+`), highlighter on AVRAGE; then the fix.
4. **#DIV/0! (2:30-3:30).** 120 loaves over 0 days. Nobody can divide by
   zero; an empty cell counts as 0 too. The fix is the number in C2.
   > Board: the pizza and zero friends.
5. **#VALUE! (3:30-4:20).** =B3*C3 and C3 says sixteen - text in a sum. Type
   16.
6. **#REF! (4:20-5:20).** The formula used a row that was deleted: =B5+#REF!.
   Undo (Ctrl+Z) at once, or fix the reference.
   > Screen: (a fresh example) type =B5+B20, delete row 20, watch #REF! appear; Ctrl+Z.
7. **#NUM! (5:20-6:10).** =RANDBETWEEN(B6,C6) with 100 at the bottom and 1
   at the top - a number Excel cannot work out. Put the smaller first.
8. **Sign-off (6:10-6:40).** Read the # - it says where to look.

### In the text

| Video point | Lesson anchor |
|---|---|
| each error value, its meaning, the nephew's mistake and the fix (the table) | `#errors` |
| #NAME? against #NAME! | `#errors` |
| double-click the column border; typing over a cell replaces it | `#fix` |
| #DIV/0! with 0 in C2 | `#fix` (the reveal `r6DivZero`) |
| #VALUE! with the word sixteen | `#fix` (the written question `w6Value`) |

One video only: TODAY, MEDIAN, MODE, the comparisons and the CAPS counts are
short typed formulas the simulations already show step by step.
