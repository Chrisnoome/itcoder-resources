# CAT Spreadsheets lesson 15: Working with sheets and windows - videos

Lesson: `AIPascalCourse/content/catexcel/sheets.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026
(writer B of the Grade 11 chapter). Screen recordings in the **CAT VM
`itcoder-cat`** (Excel 365), on the lesson's own workbook: Ms Naidoo's
Grade 11C mark book "11C marks.xlsx" (sheets Term 1, Term 2, Year) -
`tools/sim-screens/catexcel-sheets.ps1` builds it. Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words being talked about.

## catexcel-15.1 Sheets: copy, link and freeze (about 8 min)

**Goes:** after the prose block "Insert, delete, move and copy sheets"
(section `#sheets`), before the simulation `simCopySheet`.
**The pupil can afterwards:** insert, delete, move and copy a sheet (also
to a new workbook), link cells and formulas between sheets, and freeze
headings and names on the screen.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "One workbook, *many sheets*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Ms Naidoo's mark
   book has a sheet for every term and one for the year. Typing every mark
   twice is slow - and the second copy goes wrong the day a mark changes.
   > Board: Clicky carrying a mark from one sheet tab to another, then a chain between them.
2. **Insert, delete, move (0:40-1:40).** + or Shift+F11; right-click >
   Delete - and Ctrl+Z will not bring it back; drag a tab to move it.
   > Screen: the tab bar; highlighter on the black triangle while dragging.
3. **Move or Copy (1:40-3:00).** Home > Format > Move or Copy Sheet; Before
   sheet; tick Create a copy; OK: Term 2 (2). Rename it Term 3. (new book)
   sends a sheet to a new workbook - without the tick it leaves this one.
   Ctrl+drag does the same copy.
   > Screen: the menu and the dialog box; highlighter on Create a copy.
4. **A link (3:00-4:50).** On Year, click B4, type =, click the Term 1 tab,
   click B4, Enter: ='Term 1'!B4. The sheet's name, !, the cell; single
   quotes because of the space. Fill it down. Then C4: ='Term 2'!B4, and
   =AVERAGE(B4:C4).
   > Screen: the pointing, slowly; highlighter on the quotes and the !.
5. **A link updates (4:50-5:40).** Change Thabo's Term 1 mark from 64 to 70
   on Term 1. Back on Year: 70, and the average moved. A pasted number
   would still say 64. Delete a linked sheet and you get #REF!.
6. **Freeze Panes (5:40-7:20).** Scroll to row 33 - the headings are gone.
   Click B4, View > Freeze Panes > Freeze Panes: rows 1-3 and column A stay.
   Freeze Top Row and Freeze First Column for the simple cases; Unfreeze
   Panes. It never prints - that is Print Titles, next lesson.
   > Screen: the scroll before and after; highlighter on the freeze line.
7. **Sign-off (7:20-7:40).**

### In the text

| Video point | Lesson anchor |
|---|---|
| insert, delete (no undo), move, Ctrl+drag, Move or Copy, Create a copy, (new book) | `#sheets` |
| ='Term 1'!B4, pointing, quotes, filling down, AVERAGE across terms, #REF! | `#linking` |
| a link updates (the before-and-after) | `#linking` |
| Freeze Top Row, First Column, Freeze Panes at B4, Unfreeze | `#freeze` |

## catexcel-15.2 Protect a sheet, and two windows at once (about 6 min)

**Goes:** after the prose block "Protecting a sheet" (section `#protect`,
CAPS), before the simulation `simProtect`. The second half belongs to the
IEB section `#windows` - say at its start that IEB pupils need it and CAPS
pupils may watch it for interest.
**The pupil can afterwards:** (CAPS) unlock input cells and protect a sheet
with a password; (IEB) open a new window, arrange windows, split a window
and save a custom view.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Lock it, *split* it"

### Scenes

1. **Hook (0:00-0:30).** Thabo types a mark over Ms Naidoo's average formula.
   Gone. How do you stop that?
   > Board: a padlock on a cell, Clicky bouncing off it.
2. **Unlock, then protect - CAPS (0:30-2:40).** Every cell starts locked,
   but it only counts once the sheet is protected. Select B4:B33, Ctrl+1 >
   Protection > untick Locked. Review > Protect Sheet, a password, OK, the
   password again. Type a mark: fine. Type over a formula: Excel refuses.
   Unprotect Sheet. Not security - the file still opens; Protect Workbook
   guards the sheets themselves.
   > Screen: the dialog boxes; highlighter on Locked and on Confirm Password.
3. **New Window and Arrange All - IEB (2:40-4:10).** View > New Window
   (11C marks.xlsx:2), Arrange All > Vertical > OK. Term 1 on the left, Year
   on the right - change a mark and watch the link update across. Switch
   Windows lists them; close the extra one with its own X.
   > Screen: the two windows side by side.
4. **Split, Hide, Custom Views - IEB (4:10-5:30).** Split: two panes that
   both scroll (row 4 and row 33 at once) - not together with Freeze. Hide
   and Unhide a window. Custom Views > Add: "Parents" with the term columns
   hidden; Show to bring it back.
   > Screen: the split bar; the Custom Views dialog.
5. **Sign-off (5:30-6:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| locked cells, unlocking input cells, Protect Sheet, Confirm Password, Unprotect, Protect Workbook, not security | `#protect` (CAPS) |
| New Window, Arrange All, Switch Windows, Split, Hide/Unhide, Custom Views | `#windows` (IEB) |
| Split or Freeze, not both | `#windows` (quiz `q15Split`) |
