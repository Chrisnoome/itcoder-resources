# catexcel lessons 5-8 (writer B) - notes

Written 8 October 2026 to [../cat-practical-writing.md](../cat-practical-writing.md).
Lessons in `AIPascalCourse/content/catexcel/`: `functions`, `more`, `charts`,
`printing`. Lessons 1-4 (`start`, `entering`, `formulas`, `formatting`) are the
other writer's; mine link to them by id only (no anchors - theirs were not
written yet).

## 1. Lessons written

| Lesson | Marks CAPS / IEB | Simulations | Upload | Notes |
|---|---|---|---|---|
| `functions` (5) | 54 / 54 | 4 (11 steps) | `upMarks10B`, 6 checks | AutoSum by Alt+=, Ctrl+R, COUNT against ABS, range names, Show Formulas |
| `more` (6) | 68 / 58 | 4 (13 steps; 1 in the CAPS section) | `upLoaves`, 6 checks | title/summary sharpened in index.php: "More functions and error values" |
| `charts` (7) | 52 / 48 | 3 (13 steps) | `upTuckShop`, 4 checks (2 exact, 2 Jev on the chart titles) | line chart in a CAPS section (IEB: Grade 11); data labels asked for but not checked (the xlsx reader does not read them) |
| `printing` (8) | 46 / 49 (file header) | 5 (+ simLandscape, simHeader - 9 Oct; Print Titles in the IEB section) | `upOrders`, 4 checks | Print Titles/Area/breaks/views in an IEB section (CAPS Grade 11); headers and footers in a CAPS section; the upload is the troubleshooting task, because page setup cannot be read from an uploaded workbook |

- **'more' = ** TODAY, MEDIAN, MODE, the relational operators (both boards,
  Grade 10); COUNTIF, COUNTA, COUNTBLANK, RANDBETWEEN (CAPS Grade 10 Term 3;
  IEB Grade 11 - so in a CAPS BoardSection); the six error values (both).
- **#NAME?**: both syllabuses print `#NAME!`; Excel shows `#NAME?`. The lesson
  teaches Excel's and says some books write #NAME!.
- Upload checks are all marked from the formula (`xlsx.cell` `formula`), with
  `any` for the usual equivalent wordings (SUM(B2,C2,D2), MODE.SNGL, 100<B2).
- Every upload checked with a scratch script (UploadMarkFile on the starter
  and on the done-right copy): starter 0, done-right full marks, for each.

## 2. Glossary rows

Row format of content/cattheory10/glossary.php; `'course' => 'catexcel'`.
Already in the CAT glossary, so **not** added: `COUNTIF` (cattheory11,
processingdata - my Gloss() shows that definition).

```php
['function', 10, true, 'functions', 'what', 'A calculation built into Excel, with a name, such as SUM or AVERAGE. You give it the cells to work on, in brackets.', ['course' => 'catexcel']],
['AutoSum', 10, true, 'functions', 'autosum', 'A button (on the Home and Formulas tabs, or Alt and =) that writes a SUM function for the cells above or to the left of the active cell.', ['course' => 'catexcel']],
['range', 10, true, 'functions', 'ranges', 'A block of cells, written as the first cell, a colon and the last cell - B2:B8 is B2, B3, B4, B5, B6, B7 and B8.', ['course' => 'catexcel']],
['range name', 10, true, 'functions', 'ranges', 'A name you give a range (in the Name Box), so a formula can say =AVERAGE(Test1) instead of =AVERAGE(B2:B8).', ['course' => 'catexcel']],
['relational operators', 10, true, 'more', 'compare', 'The signs that compare two values: > (more than), < (less than), >= (at least), <= (at most), = (equal to) and <> (not equal to). A comparison gives TRUE or FALSE.', ['course' => 'catexcel']],
['error value', 10, true, 'more', 'errors', 'What Excel shows in a cell when it cannot work out the formula - such as #DIV/0! or #NAME?. Each one names a different problem.', ['course' => 'catexcel']],
['chart', 10, true, 'charts', 'kinds', 'A picture of numbers from a spreadsheet - bars, slices or a line - so you can compare them at a glance. Also called a graph.', ['course' => 'catexcel']],
['legend', 10, true, 'charts', 'parts', 'The key of a chart: it shows which colour stands for which set of data, or which slice of a pie is which.', ['course' => 'catexcel']],
['data labels', 10, true, 'charts', 'parts', 'The numbers (or percentages) written on or next to the bars or slices of a chart, so the reader does not have to guess them from the scale.', ['course' => 'catexcel']],
['Print Preview', 10, true, 'printing', 'preview', 'A picture of the printed pages, before anything is printed - in Excel on the right of File > Print. It shows where each page ends.', ['course' => 'catexcel']],
['header', 10, true, 'printing', 'header', 'Text printed at the top of every page - a title, a name or a date. A footer is the same at the bottom of every page.', ['course' => 'catexcel']],
```

Note: the CAT pilot's Excel lesson glosses `function` and `range` with
slightly different words (catpilot has its own glossary); `function` here is
word for word the pilot's.

## 3. CAPS lines

```php
'functions' => [
    [10, 2, 'Spreadsheets: cell reference - the importance of using cell references rather than constant values in cells and formulae; cell ranges and range names'],
    [10, 2, 'Spreadsheets: formulae vs functions; basic functions - SUM, AVERAGE, COUNT, MIN, MAX'],
],
'more' => [
    [10, 3, 'Spreadsheets: extend basic functions - TODAY, RANDBETWEEN, MODE, MEDIAN, COUNTA, COUNTBLANK, COUNTIF'],
    [10, 3, 'Spreadsheets: relational operators (>, <, <=, >=, <>, =)'],
    [10, 2, 'Spreadsheets: error indicators - #######, #NAME!, #DIV/0!, #REF!, #VALUE!, #NUM!'],
],
'charts' => [
    [10, 4, 'Spreadsheets: charts/graphs - pie, line, column, bar: the purpose of each and when to use it; create, format and edit; interpret the information a graph presents'],
],
'printing' => [
    [10, 2, 'Spreadsheets: file options - print; reinforce common concepts from the word processor - page layout'],
    [10, 3, 'Spreadsheets: sheets - headers and footers; basic printing'],
    [10, 4, 'Spreadsheets: basic integration techniques; solve problems using spreadsheets; troubleshoot basic spreadsheet problems'],
],
```

## 4. SAGs lines

```php
'functions' => [
    [10, 'P3', 'cell reference - the importance of references rather than constants; cell ranges and range names; values and contents'],
    [10, 'P3', 'formulas: SUM, AVERAGE, COUNT, MIN, MAX; selecting'],
],
'more' => [
    [10, 'P3', 'formulas: TODAY, MODE, MEDIAN; relational operators > < <= >= <> ='],
    [10, 'P3', 'error indicators #######, #NAME!, #DIV/0!, #REF!, #VALUE!, #NUM!'],
],
'charts' => [
    [10, 'P3', 'charts: pie, column/bar - purpose of each, when to use, create, format, edit, interpret'],
],
'printing' => [
    [10, 'P3', 'basic printing; clipboard'],
    [10, 'P3', 'page layout: margins, orientation, size, print area, breaks, background, print titles'],
    [10, 'P3', 'view: normal, page break preview, page layout; gridlines, formula bar, headings'],
],
```

## 5. Drawings

Used (margin doodles; plain names, so the CAT redraw is used once it exists):
`spreadsheet-sum` (functions #what), `line-up` (functions #average),
`countdown-cal` (more #today), `dice` (more #random, CAPS section),
`pizza-zero` (more #errors). `rows-vs-chart` (charts #kinds), `locking-tills-pie` (charts #pie). `printer-paperless` (printing #preview), `photocopier` (printing #share), `moth-bug` (printing #problems).

Wished for:
- functions: Clicky holding a sign "=NAME(range)" with the three parts in three highlighter colours.
- more: three Clickys on a podium for average, median and mode - the median one standing exactly in the middle of a queue of loaves.
- more: a cell with "#####" bursting at the seams, Clicky pulling the column border wider.
- charts: Clicky judging a talent show of four charts (column, bar, pie, line), each holding up the job it is good at.
- printing: a printer spitting out four pages, the last one holding a single lonely column, Clicky holding up a sign "landscape?".
- printing: a cell holding "'36" dressed up as a number, the SUM bouncer at the door turning it away ("text - not on the list").

## 6. Anything unsure, and what the platform lacked

*(9 October 2026, phase B: data labels and page setup are read and marked now. Orders-done remade in real Excel (`catexcel-done-fixes.ps1`: Landscape, Narrow margins), so it gets full marks. The Landscape simulation exists: simLandscape, the Orientation menu opened and Landscape chosen with real clicks (`catexcel-landscape.ps1`, land-3 and land-5). Still not captured: the Text menu for Header & Footer and File > Print with 2 copies typed.)* *(9 October 2026, the last gaps: both done from catexcel-printing2.ps1's real-input pictures, which had been taken but not used - simHeader (CAPS section: head-1 the Text group button, head-2 the Text menu, head-3 the header, done head-4) and simPrintCopies' last step (printing2 print-2 with 2 typed into Copies, done print-3); cropped by work/catexcel-real-crop.py (9, 58, 1590, 1000). printing2's print-1 and the first run's print-1 showed Excel's Recent list (other workbooks, OneDrive - the school): printing2's is not used, and the list is painted out of catexcel-printing-print-1.png.)*

- **Name Box after naming a range:** a name made through COM never showed in
  the Name Box on a PrintWindow picture (three runs: re-select, Goto, a
  redraw). The simulation's step after typing the name therefore uses the
  picture from before it (Name Box shows B2). Real Excel would show Test1.
- **Formula vs Formula2:** a misspelt function written with `Range.Formula`
  comes out as `=@AVRAGE(...)`; `Formula2` writes it as typed.
- **"R16" is a number in a South African Excel** (R is the currency symbol),
  so the #VALUE! example uses the word sixteen.
- **Sort and filter** (CAPS Term 3 "basic sorting"; IEB "Data - basic sort
  and filter") is in none of lessons 5-8's summaries - check that lessons 1-4
  teach it, or it needs a home.
- **Data labels** are asked for in the charts upload but not checked: lib/officexml.php's chart reader gives the type and the title only.
- **Page setup in an uploaded workbook** (orientation, print titles, print area, headers) cannot be checked: lib/uploadmark.php has no xlsx page-setup subject. An `xlsx.pageSetup` subject (orientation, printTitleRows, printArea, header text) would let lesson 8 mark the printing skills themselves.
- **IEB Grade 10 lines with no home in lessons 5-8**: themes, review (spelling, thesaurus, translate, comments), help, pictures/shapes/icons, zoom - check lessons 1-4. Background is one sentence in printing (IEB section).
- **The VM lock** is first-come-any-order: a run can wait more than 30 minutes and then fail ("VM is busy"). My retries looped vm-shots up to eight times.

## 7. Screen scripts, starter files

Scripts (AIResources/tools/sim-screens/), each run through vm-shots.ps1 in
the CAT VM; entries added to cat-crop.py (`catexcel-functions`,
`catexcel-more`, ...):

- `catexcel-functions.ps1` - 4 runs. Starter `Marks10B.xlsx` (+ done-right
  copy, fixture `tests/uploads/catexcel/Marks10B-done.xlsx`).
- `catexcel-more.ps1` - 3 runs. Starter `Loaves.xlsx` (+ `Loaves-done.xlsx`).
  `all-2` / `e-2` (Show Formulas views) are cropped wider by hand (960 / 900).
- `catexcel-cleanup.ps1` - stops an Excel or Word left open by a failed run
  (used once: one was left with a dialog open).
- `catexcel-charts.ps1` - 5 runs. Drop-down galleries and menus are separate windows: the script's `Comp` class draws Excel's window, then each of its other windows over it (PrintWindow, cut to the DWM frame). Starter `TuckShop.xlsx` (+ done-right copy). Change Chart Type sits at the far right of the Chart Design tab, beyond the crop - the pie is made from the Insert tab instead. The chart's side buttons (+, brush, filter) show only on the pictures with a menu open (they are windows of their own too).
- `catexcel-printing.ps1` - 6 runs (two lost to a 30-minute lock wait, one left Excel open with the Page Setup dialog - `catexcel-cleanup.ps1` stopped it). The Page Setup dialog's boxes are not in UI Automation, so it is drawn empty, closed (WM_CLOSE), the rows set through COM, and drawn again. Starter `Orders.xlsx` (+ done-right copy). Pictures cropped by hand from the run's backup: 1180 wide, the fix pictures 1320 (Show Formulas sits at the right of the Formulas tab).
- **Not captured** (two more runs tried Invoke and Expand on the menu buttons: "can't be pressed", and Expand opens nothing): the Orientation menu (land-3), the Text menu holding Header & Footer at this window width, and File > Print with 2 typed in Copies (its box takes no UI Automation value). So the Landscape and Header simulations were left out (taught in prose with the land-4 and head-2 figures) and the print simulation ends on print-2. The Word figure (word-1) came in on the sixth run (it shows the order pasted before its mistakes were fixed - the caption makes that the point). Crops: 1180 x 702 from y 58; fix-1/fix-2 1320 wide; word-1 the document only (360, 232, 1370, 722).

Starter files are on the site in `public/assets/practical/catexcel/` and in
`G:\My Drive\CAT\Excel\` in the VM.
