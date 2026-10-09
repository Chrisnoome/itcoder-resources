# CAT Spreadsheets lesson 18: Importing, exporting, and advanced sorting and filtering - videos

Lesson: `AIPascalCourse/content/catexcel/importing.php` (Grade 11). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own files: BakeryBook.xlsx (sheets Summary and Orders) and
TillSales.csv - `tools/sim-screens/catexcel-importing.ps1` makes both (the
pupils' starter files are the same, in G:\My Drive\CAT\Excel\). Board scenes
in the CAT marker style with Clicky (brand/cat-art-style.md); yellow
highlighter on any words being talked about. The file dialogs show the VM's
OneDrive account in their navigation pane: keep it out of the frame (or
blur it).

## catexcel-18.1 Bringing a CSV file into Excel (about 8 min)

**Goes:** after the prose block "Importing with Get & Transform" (section
`#import`), before the simulation `simImportCsv`.
**The pupil can afterwards:** say what a CSV file is, import one with From
Text/CSV, fix the usual import troubles, and export a sheet as CSV and PDF.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Never *type* it twice"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha's new till
   saves every day's sales as a file. Last year he typed them from a paper
   roll every evening. Tonight he types nothing.
   > Board: Clicky tearing up a till roll; a file icon TillSales.csv.
2. **What a CSV is (0:40-1:50).** Open TillSales.csv in Notepad: one line per
   sale, headings first, commas between the values - the delimiter. No
   formatting, no formulas, one sheet.
   > Screen: Notepad; highlighter on the commas of one line.
3. **From Text/CSV (1:50-3:40).** Data > From Text/CSV, TillSales.csv, Import.
   The preview: File Origin, Delimiter Comma, the columns. Load: a new sheet
   called TillSales, a table, the Queries & Connections pane.
   > Screen: each step; highlighter on Delimiter.
4. **Transform Data and Refresh All (3:40-4:40).** Transform Data opens the
   Power Query Editor - set a phone-number column to Text so the 0 stays.
   Tomorrow's file: Data > Refresh All.
5. **Opening a CSV, and its troubles (4:40-6:00).** File > Open: one sheet,
   still a CSV - Save As .xlsx first. Everything in column A (Text to
   Columns), lost zeros, numbers as text, dates the wrong way round.
   > Board: the troubleshooting table, one row at a time.
6. **Exporting (6:00-7:20).** Save As > CSV UTF-8: the active sheet, values
   only - the Possible Data Loss bar. File > Export > Create PDF/XPS >
   Options (entire workbook) > Publish.
7. **Sign-off (7:20-7:45).**

### In the text

| Video point | Lesson anchor |
|---|---|
| a CSV in Notepad; the delimiter; what a CSV cannot hold | `#csv` |
| From Text/CSV, the preview, Load; Transform Data; Refresh All; Get Data > From File | `#import` |
| File > Open a CSV; Save As .xlsx; the troubleshooting table | `#open` |
| Save As CSV UTF-8 (one sheet, values); File > Export > PDF | `#export` |

## catexcel-18.2 Sorting by your own order, filtering by your own rules (about 7 min)

**Goes:** after the prose block "Advanced filtering" (section `#advfilter`,
IEB), before the simulation `simAdvFilter`.
**The pupil can afterwards:** sort by a custom list and by colour, sort left
to right, filter with And/Or and Top 10, and use an advanced filter with a
criteria range.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Monday comes *before* Friday"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Sort the week's
   orders A to Z by day, and Friday comes first. A baker needs Monday first.
2. **A custom list (0:40-2:00).** Data > Sort: Sort by Day, Order > Custom
   List... > Sun, Mon, Tue ... > OK. NEW LIST for any other order.
   > Screen: the Order list and the Custom Lists box.
3. **Colours on top (2:00-3:00).** Sort On: Cell Color, yellow On Top; Add
   Level, Then by Day. Options: Sort left to right.
4. **Number Filters (3:00-4:20).** The Qty arrow > Number Filters > Between:
   And. Then Or on the Item column. Top 10 > Top 3 Items.
   > Board: AND as two gates in a row; OR as two doors side by side.
5. **Advanced filter (4:20-6:20).** The criteria range F1:G2 (headings copied
   exactly; White bread, >=50). Data > Advanced: Copy to another location,
   Criteria range, Copy to I1, OK. Then row 3 with Pies: different rows are OR.
   > Screen: highlighter on the criteria range, then on the copied rows.
6. **Sign-off (6:20-6:45).**

### In the text

| Video point | Lesson anchor |
|---|---|
| A to Z puts Friday first; Custom List; NEW LIST | `#advsort` |
| Sort On Cell Color, On Top; Options - left to right | `#advsort` |
| Number Filters And/Or; Top 10 | `#advfilter` |
| the criteria range: same row AND, next row OR; Copy to another location | `#advfilter` |

The closing scenario (`#together`) is planning and troubleshooting in words
- no video.
