# catexcel writer A - Grade 10 lessons 1-4 (start, entering, formulas, formatting)

8 October 2026, written to [../cat-practical-writing.md](../cat-practical-writing.md).
Lessons 5-8 (functions, more, charts, printing) are writer B's (catexcel-b.md).

## 1. Lessons written

| Lesson | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|
| `start` - The spreadsheet window | 56 / 56 | practice `simPracticeExcel` (no marks) + 4: `simSelectCells` (2 steps), `simNameBox` (2), `simGridlines` (3), `simSaveCloud` (3: F12, double-click, type) | `upBothaPrices` - 4 checks (exact) |
| `entering` - Entering and changing data | 50 / 50 | 4: `simFixName` (2), `simInsertRow` (3: row heading, Home > Cells > Insert, type), `simNumberPupils` (2, double-click), `simCopySheet` (5: Ctrl+C, click, Ctrl+V, double-click, type) | `upClassList` - 6 checks (exact) |
| `formulas` - Formulas and cell references | 42 / 42 | 4: `simAmount` (2), `simShare` (2), `simFillAmounts` (2, double-click), `simShowFormulas` (2) | `upMarketDay` - 6 checks (5 exact, 1 Jev) |
| `formatting` - Formatting cells and numbers | 48 / 50 | 4: `simTitle` (3), `simHeadings` (2), `simNumbers` (3), `simLongDate` (4: Ctrl+1, the dialog, OK, double-click) | `upPriceList` - 4 checks (2 exact, 2 Jev) |

Unusual:

- **start** opens with the "Try this first" prose block (the Word pilot's,
  in Excel's words), `// VIDEO catprac-00.1`, and `SimulationPractice
  ('excel')` - the new `'excel'` case in `lib/simulation.php` (3 steps on
  `catexcel-practice-1..3`: click the milk tart's empty price cell, type 15,
  press Ctrl+S; the third screen shows the takings 270 the typing made). The
  lesson has a `hotspot` (`hs1ExcelWindow`, "where would you click to...")
  on the whole Excel window.
- **formatting** has one IEB BoardSection, "Currency or Accounting?" (the
  SAGs name Accounting; CAPS names only Currency) with `q4Accounting`.
  Everyone uses the Accounting button in `simNumbers`.
- **formulas** has a `beforeafter` slider of the price change (unmarked) and
  an own-words reveal `r3NoBrackets`.
- Each upload's starter scores 0 and its done-right copy full marks
  (exact checks; the Jev checks were shown the values they would see -
  `check-uploads --no-jev` style; scratch runner, see section 7).

## 2. Glossary rows

Terms already in content/cattheory10/glossary.php (spreadsheet, Cloud
storage) are Gloss()ed but not added again. `data type` is there as a Grade
11 row (processingdata) - the Grade 10 row below points at entering#types;
keep one of the two.

```php
    // ---- catexcel Grade 10 (writer A) -----------------------------------
    ['Name Box', 10, true, 'start', 'window', 'The box at the left, above the column letters, that shows the address of the active cell. You can also type an address in it to jump to that cell.', ['course' => 'catexcel']],
    ['Formula Bar', 10, true, 'start', 'window', 'The long box above the grid, next to fx, that shows what is really in the active cell - the number, the words or the formula.', ['course' => 'catexcel']],
    ['cell', 10, true, 'start', 'cells', 'One box in a spreadsheet, where a column and a row meet. It holds a number, text, a date or a formula.', ['course' => 'catexcel', 'also' => ['cells']]],
    ['active cell', 10, true, 'start', 'cells', 'The cell you are working in, with a thick green border. Its address shows in the Name Box, and whatever you type goes into it.', ['course' => 'catexcel']],
    ['workbook', 10, true, 'start', 'sheets', 'An Excel file. It holds one or more worksheets, and is saved with the extension .xlsx.', ['course' => 'catexcel', 'also' => ['workbooks']]],
    ['worksheet', 10, true, 'start', 'sheets', 'One sheet - one grid of cells - in a workbook. Each worksheet has a tab with its name at the bottom of the window.', ['course' => 'catexcel', 'also' => ['worksheets', 'sheet']]],
    ['data type', 10, true, 'entering', 'types', 'What kind of data a cell holds - text, a number, a date or a time. It decides what Excel can do with it, such as calculating.', ['course' => 'catexcel', 'also' => ['data types']]],
    ['AutoFill', 10, true, 'entering', 'autofill', 'Dragging (or double-clicking) the fill handle to carry on a list or pattern - 1, 2, 3...; Mon, Tue, Wed...; Term 1, Term 2... - or to copy a cell into the cells next to it.', ['course' => 'catexcel']],
    ['fill handle', 10, true, 'entering', 'autofill', 'The small square at the bottom right of the selected cell or cells. Drag it, or double-click it, to AutoFill.', ['course' => 'catexcel']],
    ['formula', 10, true, 'formulas', 'formula', 'A calculation in a cell. It always starts with an equals sign (=), and uses cell references and operators, such as =B2*C2.', ['course' => 'catexcel', 'also' => ['formulas']]],
    ['cell reference', 10, true, 'formulas', 'formula', 'A cell\'s address used in a formula, such as B2. The formula uses whatever is in that cell at the moment.', ['course' => 'catexcel', 'also' => ['cell references']]],
    ['operator', 10, true, 'formulas', 'operators', 'A sign in a formula that says what to work out: + add, - subtract, * multiply, / divide.', ['course' => 'catexcel', 'also' => ['operators']]],
    ['relative reference', 10, true, 'formulas', 'copying', 'A cell reference that changes when the formula is copied: one row down and every row number goes up by one; one column right and every letter moves one on.', ['course' => 'catexcel', 'also' => ['relative references']]],
    ['border', 10, true, 'formatting', 'borders', 'A line along one or more edges of a cell that you add yourself. Unlike the gridlines, borders print.', ['course' => 'catexcel', 'also' => ['borders']]],
    ['number format', 10, true, 'formatting', 'numbers', 'How a number is shown in a cell - as currency, a percentage, a date, with so many decimals - without changing the number itself.', ['course' => 'catexcel', 'also' => ['number formats']]],
    ['######', 10, true, 'formatting', 'dates', 'What Excel shows when a number or a date is too wide for its column. The value is fine: make the column wider.', ['course' => 'catexcel']],
    ['cell style', 10, true, 'formatting', 'styles', 'A named set of cell formatting - font, fill, border, number format - applied in one click from Home > Styles > Cell Styles, such as Title, Heading 1 or Total.', ['course' => 'catexcel', 'also' => ['cell styles']]],
```

(The `'course'` extra follows the Grade 11/12 rows' pattern; drop it if the
practical courses' rows are kept apart some other way. The pilot's `cell`,
`formula` and `fill handle` wordings in content/catpilot/excel.php differ
slightly - these are the course's.)

## 3. CAPS lines

```php
        'start' => [
            [10, 2, 'Spreadsheets: overview of basic skills and core concepts; uses of a spreadsheet'],
            [10, 2, 'Spreadsheets: first looks - rows, columns, cells, sheets, workbook'],
            [10, 2, 'Spreadsheets: file options - open, save, save as, new'],
            [10, 2, 'Spreadsheets: reinforce common concepts from the word processor (view options)'],
        ],
        'entering' => [
            [10, 2, 'Spreadsheets: data types - General, Number, Currency, Text, Date, Time; values and cell references'],
            [10, 2, 'Spreadsheets: format cells - Autofill'],
            [10, 2, 'Spreadsheets: formatting rows, columns and sheets - insert, delete, hide, unhide'],
            [10, 2, 'Spreadsheets: reinforce common concepts from the word processor - formatting and editing, find and select, proofing'],
            [10, 3, 'Spreadsheets: sheets - rename, tab colour, hide/unhide'],
        ],
        'formulas' => [
            [10, 2, 'Spreadsheets: cell reference - the importance of using cell references rather than constant values in cells and formulae'],
            [10, 2, 'Spreadsheets: basic calculations with +, -, *, /, order of precedence, brackets'],
            [10, 2, 'Spreadsheets: formulae (vs functions); values and cell references'],
        ],
        'formatting' => [
            [10, 2, 'Spreadsheets: format cells - data type, borders, shading, alignment, wrapping, merge, text direction, split'],
            [10, 2, 'Spreadsheets: formatting rows, columns and sheets - size, borders, styles'],
            [10, 2, 'Spreadsheets: data types - General, Number, Currency, Text, Date, Time (number formats)'],
            [10, 2, 'Spreadsheets: error indicators - #######'],
            [10, 3, 'Spreadsheets: reduce decimal places with cell formatting'],
        ],
```

## 4. SAGs lines

```php
        'start' => [
            [10, 'P3', 'standard features; workspace; rows, columns and cells; selecting'],
            [10, 'P3', 'open, close, save, save as'],
            [10, 'P3', 'view - normal, page break preview, page layout; gridlines, formula bar, headings; zoom; help'],
        ],
        'entering' => [
            [10, 'P3', 'formatting rows, columns and sheets - insert, delete, hide; cells - insert, delete'],
            [10, 'P3', 'worksheets - rename, tab colour, hide/unhide'],
            [10, 'P3', 'AutoFill; clipboard; editing; values and contents'],
            [10, 'P3', 'review - spelling'],
        ],
        'formulas' => [
            [10, 'P3', 'cell reference - the importance of references rather than constants; values and contents'],
            [10, 'P3', 'formulas - basic operators + - * /, order of precedence and brackets'],
        ],
        'formatting' => [
            [10, 'P3', 'font formatting; format cells - borders, shading, alignment, wrapping, merge, text orientation, split'],
            [10, 'P3', 'number formatting - General, Number, Currency, Accounting, Date, Time, Percentage; increase and decrease decimals'],
            [10, 'P3', 'formatting rows, columns - size; styles - format as table, cell styles'],
            [10, 'P3', 'error indicator #######'],
        ],
```

Grade 10 Spreadsheet lines in this range that are **not** in lessons 1-4 (and
belong to writer B's lessons 5-8, as the lesson map has it): cell ranges and
range names (lesson 5 - writer B teaches range names there, so lesson 3 does
not), SUM/AVERAGE/COUNT/MIN/MAX (5), TODAY, MODE, MEDIAN, relational
operators and the other error indicators (6), charts (7), page layout,
printing, sort and filter, pictures/shapes/icons, review (thesaurus,
translate, comments) and integration (8, or none - check B's notes).
Lesson 2 mentions Review > Spelling and Find/Replace in one list; the
thesaurus, translate and comments are not taught here.

## 5. Drawings

Used (IT names; the site uses `cat-<name>.svg` once drawn): `spreadsheet-window`
(start #what), `zoom-with-feet` (start #sheets), `load-shedding-ram` (start
#save), `aligned` (entering #types), `copy-vs-move` (entering #copy),
`watch-calculator` (formulas #formula), `bodmas` (formulas #order),
`spreadsheet-sum` (formulas #references), `colour-wheel` (formatting #why),
`price-tag` (formatting #numbers).

Wished for (one line each):

- start: Clicky as a postman reading a street sign "Column B" and a house number "3" - "B3: street first, then the house".
- start: a padlocked laptop going dark in load shedding, the file floating safe up to a cloud labelled My Drive.
- entering: "R18" sitting sulking on the left of a cell while 18 sits on the right - "Text sits left. Numbers sit right."
- entering: Clicky dragging the fill handle like a paint roller, 1 2 3 4 5 rolling out behind it.
- formulas: a formula =B2*C2 with two long arms pointing at two cells; beside it a stubborn "=6*48" with its arms folded.
- formulas: a staircase "( ) then * / then + -".
- formatting: an iceberg, "8.3%" above the water and "0.0833333..." below.
- formatting: a cell bursting with ###### and Clicky pulling the column wider like a concertina.

## 6. Anything I was unsure of

- **Quotes:** the bank has few spreadsheet quotes with portraits. Used:
  Marshall Goldsmith (start), Verite (entering), Douglas Adams' calculator
  quote (formulas; portrait douglas_adams.png - not used by another CAT
  lesson), Mike Davidson (formatting). Goldsmith, Verite and Davidson have no
  portrait in public/assets/quotes, so `anonymous.svg` (saving a portrait
  from the quote bank's docx was outside the files I may touch).
- **No right-click step** in lessons 1-4. Excel's context menu is its own
  window, and nothing posted to the grid opened it (the menu key VK_APPS,
  WM_CONTEXTMENU, a posted right button - all three tried in
  catexcel-entering.ps1, which still has the attempt). `simInsertRow` uses
  Home > Cells > Insert instead; the prose teaches both ways. Writer B or a
  later pass could add a right-click step if office-kit gets a way to open
  context menus.
- **Cell Styles gallery figure** dropped: the gallery popup did not open from
  UI Automation either (the screen script still tries); the section is prose
  and a quiz.
- The bottom border in `catexcel-formatting-h-3` is Excel's thin default
  line - it is there but faint next to the gridlines.
- Merge, bold, fills and borders cannot be checked in an uploaded .xlsx (the
  reader has values, formulas and number formats only), so `upPriceList`
  marks the number formats and the values; the title and headings are in the
  task but unmarked (see 8).
- The `'not'` join's message for a pupil ("your file does what this check
  says it should not") reads oddly when the 'not' is one part of an 'all'
  (`upPriceList` check 4: B4 must not be General) - the check's `fix` line
  carries the meaning.
- The VM shows the Office account's initials in the title bar (cropped off)
  and an "Add-ins" and a "Claude" group at the right of the Home ribbon
  (painted out where a crop reaches them - work/catexcel-crop.py).

## 7. Screen scripts, starter files, checks

Scripts (AIResources/tools/sim-screens/), all run in the CAT VM with
vm-shots.ps1:

- `catexcel-practice.ps1` - the practice simulation's 3 screens.
- `catexcel-start.ps1` - the whole window at 1150 px (tour and hotspot),
  selecting, the Name Box, sheets and the View tab, and Save As (F12) into
  `G:\My Drive\CAT` (the dialog opens in My Drive: Excel's default folder is
  set to it for the run and put back; the author shows as Mr Botha). The
  Quick access list in the dialog (other writers' folders) is painted out.
- `catexcel-entering.ps1` - the kinds of data (Types), fixing a name,
  inserting a row (the right-click menu), numbering with AutoFill, copying
  headings to Sheet2 and renaming it (rename mode through
  `ExecuteMso('SheetRename')`).
- `catexcel-formulas.ps1` - the market day order: first formula, fill down,
  brackets, the price change, Show Formulas.
- `catexcel-formatting.ps1` - Merge & Center, Increase Font Size, Accounting,
  Percent Style, Increase Decimal pressed as the ribbon's own buttons (UI
  Automation); Format Cells (the dialog launcher pressed on another thread;
  the Type list clicked by a message posted to the list box); AutoFit; the
  Cell Styles gallery.
- `catexcel-files.ps1` - the four starter files and their -done copies.
- Shared by these: `work/catexcel-kit.ps1` (PowerShell helpers and a small
  C# class: posting messages to one window, WM_SETTEXT, BM_CLICK, pasting a
  popup's picture onto the window's) and `work/catexcel-crop.py` (crops,
  paints out, copies to public/assets/sims/catexcel/, prints targets in per
  cent). cat-crop.py has an entry for catexcel-practice only; the other
  scripts mix window widths and dialogs, which its one-box-per-script table
  cannot do.

Starter files (made in real Excel in the VM; in `public/assets/practical/
catexcel/` and in `G:\My Drive\CAT\Excel\`): BothaPrices.xlsx, Class10A.xlsx,
MarketDayOrder.xlsx, PriceList.xlsx. Done-right copies as fixtures in
`tests/uploads/catexcel/` (*-done.xlsx).

Checks (8 October 2026, after the screens were in): `php -l` on every file
touched; `bin/check-simulations.php catexcel` OK (31 simulations);
`check-pictures`, `check-more-questions`, `check-lesson-contents`,
`check-figures`, `check-titles`, `check-why`, `check-code-questions` OK;
`check-uploads --no-jev` - all four catexcel A blocks well formed, all
upload checks passed; `check-lesson-links` - mine fine (the two failures are
catpowerpoint/pat's); `check-jev catexcel <lesson>` - 0 flags in all four;
`renderone.php catexcel <lesson>` - start 85 680, entering 61 543, formulas
66 272, formatting 67 908 bytes, no WARN. Starter scores 0 and -done full
marks on every exact check (scratch runner using UploadMarkFile); the Jev
checks were read with the values they get (format codes such as
`_-R* # ##0.00_-...` and `[$-1C09]dd mmmm yyyy;@` from the VM).

While screens were pending, lessons 2 and 4 showed a simulation only once
its pictures existed (coordinator's note) - that guard is gone again now
that every picture is in.

## 8. What the platform lacked

*(9 October 2026, phase B: the reader now reads formatting, names, page setup, validation, filters, charts and pivots, and the uploads mark them; bin/check-uploads.php (3b) marks every catexcel done copy and starter on each run - start's upBothaPrices left out, as one check reads the uploaded file's name.)*

- **xlsx formatting** - lib/officexml.php reads values, formulas and number
  formats only. Bold, font size, fill, borders, merged cells, alignment,
  wrap, column widths and cell styles are invisible to an upload check, so
  lesson 4's upload cannot mark half of what the lesson teaches.
- **Defined names** (range names) are not read either - writer B's lesson 5
  may want them.
- **Built-in number format 44** (Accounting) is not in
  OfficeBuiltInFormats(): if Excel ever writes it without a formatCode, the
  reader says General. Excel 365 in the VM wrote the code out, so it works
  for now.
- **A right-click menu screen** has no helper in office-kit.ps1 (a context
  menu is its own window). work/catexcel-kit.ps1 has `SnapWithPopup` for it.
- check-uploads.php proves only the pilot's Notice; the catexcel uploads were
  proved with a scratch runner (UploadMarkFile on the starter and the -done
  copy). A fixture-driven section for every course's uploads would help.
