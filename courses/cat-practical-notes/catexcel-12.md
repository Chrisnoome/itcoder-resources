# catexcel Grade 12 - notes

9 October 2026. The Grade 12 chapter of `catexcel` (Spreadsheets), written to
[../cat-practical-writing.md](../cat-practical-writing.md) ("Grades 11 and
12"). Nine lessons, numbers 19-27 (Grade 11, [catexcel-11.md](catexcel-11.md),
is 10-18). Videos `catexcel-19.1` to `catexcel-27.1` (16 plans, indexed in
[../cat-videos/README.md](../cat-videos/README.md)).

## 1. Lessons written

| # | id | Title | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|---|---|
| 19 | `nestedif` | Nested IF, AND and OR | 58 / 64 | 3 + 1 IEB (CHOOSE) | `upPrelims12B`, 6 checks (5 exact on edge values, 1 Jev on AND/OR) |
| 20 | `countifs` | COUNTIFS, SUMIFS and rounding up or down | 46 / 50 | 3 + 1 IEB (INT) | `upFarewell`, 6 checks |
| 21 | `lookups` | VLOOKUP, HLOOKUP and XLOOKUP | 48 / 54 | 4 + 1 IEB (MATCH/INDEX) | `upBothaOrders`, 6 checks |
| 22 | `text` | Text functions | 68 / 72 | 4 + 1 IEB (SUBSTITUTE) | `upYearbook`, 6 checks |
| 23 | `dates` | Dates and times | 44 / 48 | 2 + 1 IEB (EDATE) | `upStaffTimes`, 7 checks |
| 24 | `summaries` | Subtotals, outlines and pivot tables | 40 / 60 | 1 + 1 IEB (pivot table) | `upMarketDay`, 4 checks; IEB `upMarketPivot`, 2 (1 Jev) |
| 25 | `datatools` | Data validation and the data tools | 44 / 62 | 2 (simCircleInvalid, 9 Oct) + 2 IEB (Remove Duplicates, Record Macro) | `upSportsDay`, 5 checks (1 Jev) |
| 26 | `charts12` | Charts for a scenario | 46 / 56 | 4 (+ simAxisTitle12, simSelectData, 9 Oct) + 2 IEB (sparklines, simComboType) | `upRecycling`, 4 checks (2 Jev on titles) |
| 27 | `scenario` | An exam-style task | 58 / 58 | 3 (+ simEvaluate, 9 Oct) | `upFunDay`, 9 checks (a nine-task exam question) |
| | | **Total** | **444 / 514** | 22 + 9 IEB | 10 |

Board sections: CHOOSE, INT/TRUNC, MATCH/INDEX, SUBSTITUTE, the five IEB
date functions, Consolidate, pivot tables (with their own upload), Remove
Duplicates/Text to Columns/queries, protecting a workbook and macros, combo
charts/the pulled-out slice/sparklines - all IEB; the trendline - CAPS. The
scenario lesson has a prose-only section per board on how its paper asks.
COUNTIFS/SUMIFS go to both boards (the SAGs do not list them but the IEB's
2023 memo used SUMIFS); DATE and XLOOKUP likewise (CAPS memos used them).

Every upload was proved: the starter scores 0 on every exact check, the
done-right copy (made by real Excel in the same screen script) full marks
(scratch runner `upc.php`: UploadMarkFile with no Jev; the Jev checks were
read with the values they get). Most checks read the *values Excel saved*
on the first, last and edge rows plus `hasFormula` on the range, so any
correct formulation earns the mark, a formula left relative fails on the
last row, and > for >= fails on the edge row.

## 2. Index entries (NOT yet added - see 7)

After Grade 11's last entry (`importing`, 18):

```php
    'nestedif'   => ['number' => 19, 'grade' => 12, 'chapter' => 'Nested IF and conditions', 'title' => 'Nested IF, AND and OR', 'summary' => 'IF inside IF for three or more answers, the order of the tests, AND and OR inside IF, planning a nested IF from a rule, and CHOOSE (IEB).'],
    'countifs'   => ['number' => 20, 'grade' => 12, 'chapter' => 'Nested IF and conditions', 'title' => 'COUNTIFS, SUMIFS and rounding up or down', 'summary' => 'Counting and adding with two or more conditions, the Function Arguments box, ROUNDUP and ROUNDDOWN for planning, and (IEB) INT and TRUNC.'],
    'lookups'    => ['number' => 21, 'grade' => 12, 'chapter' => 'Lookups', 'title' => 'VLOOKUP, HLOOKUP and XLOOKUP', 'summary' => 'A lookup table, VLOOKUP and HLOOKUP with an exact match and a locked table, #N/A, bands with TRUE, XLOOKUP, and (IEB) MATCH and INDEX.'],
    'text'       => ['number' => 22, 'grade' => 12, 'chapter' => 'Text functions', 'title' => 'Text functions', 'summary' => 'Joining text with & and CONCATENATE, cutting it with LEFT, RIGHT and MID, VALUE, FIND and LEN for e-mail addresses, and SUBSTITUTE (IEB).'],
    'dates'      => ['number' => 23, 'grade' => 12, 'chapter' => 'Dates and times', 'title' => 'Dates and times', 'summary' => 'Dates as numbers, YEAR, MONTH, DAY, DAYS, DATE, TODAY and NOW, hours worked, HOUR, MINUTE and TIME, and (IEB) EDATE, WORKDAY, NETWORKDAYS, WEEKNUM and YEARFRAC.'],
    'summaries'  => ['number' => 24, 'grade' => 12, 'chapter' => 'Subtotals and pivot tables', 'title' => 'Subtotals, outlines and pivot tables', 'summary' => 'Data > Subtotal on a sorted list, the outline levels, the SUBTOTAL function, Group and Ungroup, and (IEB) Consolidate and pivot tables.'],
    'datatools'  => ['number' => 25, 'grade' => 12, 'chapter' => 'Data tools', 'title' => 'Data validation and the data tools', 'summary' => 'Drop-down lists and other validation rules, input messages and error alerts, Circle Invalid Data, and (IEB) Remove Duplicates, Text to Columns, queries, protecting a workbook and recording a macro.'],
    'charts12'   => ['number' => 26, 'grade' => 12, 'chapter' => 'Charts for a scenario', 'title' => 'Charts for a scenario', 'summary' => 'Choosing a chart for a scenario, stacked columns, the axis scale, axis titles and labels, pictographs, a trendline (CAPS), and combo charts, a pulled-out slice and sparklines (IEB).'],
    'scenario'   => ['number' => 27, 'grade' => 12, 'chapter' => 'The practical exam', 'title' => 'An exam-style task', 'summary' => 'How the practical exam asks and marks spreadsheet questions, choosing a function from a task\'s words, building blocks, finding a broken formula with the Formula Auditing tools, and a full nine-task question.'],
```

## 3. Glossary rows (NOT yet added - see 7)

For `content/cattheory10/glossary.php`, a new block before
`// ---- catpowerpoint - PowerPoint, Grade 10`. `macro` is left out: the Word
course's `Macro` row (catword `macros`) exists; my Gloss() in `datatools`
shows its own Excel wording. `outline` (catpowerpoint) exists too, so Excel's
term is **outline levels**.

```php
    // ---- catexcel - Excel, Grade 12 (practical course) ------------------
    ['nested IF', 12, true, 'nestedif', 'nested', 'An IF function inside another IF function - usually in its "value if FALSE" part - so that a formula can choose between three or more answers.', ['course' => 'catexcel']],
    ['AND function', 12, true, 'nestedif', 'and', 'A function that checks two or more conditions and gives TRUE only when every one of them is TRUE - such as =AND(B3>=70,C3>=70).', ['course' => 'catexcel']],
    ['OR function', 12, true, 'nestedif', 'or', 'A function that checks two or more conditions and gives TRUE when at least one of them is TRUE - such as =OR(B3<40,C3<40). It is FALSE only when every condition is FALSE.', ['course' => 'catexcel']],
    ['CHOOSE', 12, true, 'nestedif', 'choose', 'A function that uses a number (1, 2, 3 ...) to pick one item from a list of values: =CHOOSE(2,"Morning","Midday","Afternoon") gives Midday.', ['course' => 'catexcel']],
    ['COUNTIFS', 12, true, 'countifs', 'countifs', 'A function that counts the rows that meet every one of several conditions, each in its own range: =COUNTIFS(B4:B27,"12A",D4:D27,"Yes").', ['course' => 'catexcel']],
    ['SUMIFS', 12, true, 'countifs', 'sumifs', 'A function that adds the numbers in one range for the rows that meet every one of several conditions: =SUMIFS(E4:E27,B4:B27,"12B",D4:D27,"Yes"). The range to add comes first.', ['course' => 'catexcel']],
    ['INT', 12, true, 'countifs', 'int', 'A function that rounds a number down to the whole number below it: =INT(3.9) gives 3, and =INT(-3.2) gives -4.', ['course' => 'catexcel']],
    ['TRUNC', 12, true, 'countifs', 'int', 'A function that cuts off the decimals without rounding: =TRUNC(3.97) gives 3, =TRUNC(-3.97) gives -3, and =TRUNC(3.978,2) gives 3.97.', ['course' => 'catexcel']],
    ['lookup table', 12, true, 'lookups', 'table', 'A small table that other formulas search - such as a price list with a code in the first column. Each value is typed once, so a change in the table changes every answer that uses it.', ['course' => 'catexcel']],
    ['VLOOKUP', 12, true, 'lookups', 'vlookup', 'A function that looks for a value in the first column of a table and gives the value from another column of the same row: =VLOOKUP(C4,Prices!$A$2:$C$11,3,FALSE). V for vertical - the table goes down.', ['course' => 'catexcel']],
    ['#N/A', 12, true, 'lookups', 'na', 'The error value a lookup shows when it cannot find what it looks for - "not available". The value is missing from the table, or typed differently.', ['course' => 'catexcel']],
    ['HLOOKUP', 12, true, 'lookups', 'hlookup', 'A function that looks for a value in the first row of a table and gives the value from another row of the same column: =HLOOKUP(F4,Zones!$B$1:$E$2,2,FALSE). H for horizontal - the table goes across.', ['course' => 'catexcel']],
    ['approximate match', 12, true, 'lookups', 'bands', 'A lookup with TRUE as its last part: it finds the biggest value in the first column that is not bigger than the lookup value - the band the value falls in. The first column must be sorted smallest to largest.', ['course' => 'catexcel']],
    ['XLOOKUP', 12, true, 'lookups', 'xlookup', 'A newer lookup function: =XLOOKUP(what to find, where to look, what to bring back). It searches any column or row, matches exactly unless told otherwise, and can say what to show when nothing is found.', ['course' => 'catexcel']],
    ['MATCH', 12, true, 'lookups', 'indexmatch', 'A function that gives the position of a value in a row or column: =MATCH("Pie",B2:B11,0) gives 8 - Pie is the 8th item. 0 means an exact match.', ['course' => 'catexcel']],
    ['INDEX', 12, true, 'lookups', 'indexmatch', 'A function that gives the value at a position in a range: =INDEX(C2:C11,8) gives the 8th value in C2:C11.', ['course' => 'catexcel']],
    ['CONCATENATE', 12, true, 'text', 'join', 'A function that joins pieces of text into one: =CONCATENATE(B2," ",A2) gives the same as =B2&" "&A2. Newer Excel calls it CONCAT.', ['course' => 'catexcel']],
    ['VALUE', 12, true, 'text', 'value', 'A function that turns text made of digits, such as "0417", into a number (417) that Excel can calculate with.', ['course' => 'catexcel']],
    ['FIND', 12, true, 'text', 'find', 'A function that gives the position of one piece of text inside another: =FIND("@",B2) gives the position of the @ in B2. It tells capitals from small letters, and gives #VALUE! when the piece is not there.', ['course' => 'catexcel']],
    ['LEN', 12, true, 'text', 'find', 'A function that counts the characters in a piece of text, spaces included: =LEN("Thabo Dube") gives 10.', ['course' => 'catexcel']],
    ['SUBSTITUTE', 12, true, 'text', 'substitute', 'A function that replaces one piece of text with another wherever it appears in a cell: =SUBSTITUTE(C2," ","") takes out every space.', ['course' => 'catexcel']],
    ['date serial number', 12, true, 'dates', 'numbers', 'The number Excel stores for a date: the count of days from 1 January 1900 (day 1). 14 March 1971 is 26006. The date format only changes how it is shown.', ['course' => 'catexcel']],
    ['DAYS', 12, true, 'dates', 'between', 'A function that gives the number of days between two dates: =DAYS(end date, start date). The later date comes first.', ['course' => 'catexcel']],
    ['DATE', 12, true, 'dates', 'date', 'A function that builds a date from a year, a month and a day: =DATE(2026,3,14) is 14 March 2026. The parts can be other functions, such as YEAR(TODAY()).', ['course' => 'catexcel']],
    ['Subtotal', 12, true, 'summaries', 'subtotal', 'An Excel feature (Data > Outline > Subtotal) that inserts a total row under each group of a sorted list, and a grand total at the end, using the SUBTOTAL function. It also builds an outline to hide the detail.', ['course' => 'catexcel']],
    ['outline levels', 12, true, 'summaries', 'outline', 'Levels of detail Excel can hide and show: the outline bar left of the row numbers, with level buttons 1, 2, 3 and + and - buttons for each group.', ['course' => 'catexcel']],
    ['SUBTOTAL function', 12, true, 'summaries', 'function', 'A function that totals, counts or averages a range in the way its first number says (9 SUM, 1 AVERAGE, 2 COUNT, 4 MAX, 5 MIN) and leaves out any other SUBTOTAL inside that range: =SUBTOTAL(9,D3:D6).', ['course' => 'catexcel']],
    ['pivot table', 12, true, 'summaries', 'pivot', 'A summary table Excel builds from a list: you choose a field for the rows (and columns) and a field to add up, count or average, and Excel does the grouping. It does not change the list.', ['course' => 'catexcel']],
    ['data validation', 12, true, 'datatools', 'why', 'A rule on a cell or range (Data > Data Tools > Data Validation) that limits what may be typed - a list, a whole number between two values, a date, a text length - and shows a message when the rule is broken.', ['course' => 'catexcel']],
    ['stacked column chart', 12, true, 'charts12', 'stacked', 'A column chart that piles each item\'s parts on top of one another, so one column shows the parts and the total together. A stacked bar chart does the same sideways.', ['course' => 'catexcel']],
    ['pictograph', 12, true, 'charts12', 'pictograph', 'A chart whose bars or columns are filled with a picture, stacked so that each picture stands for an amount - one bottle for 100 kg.', ['course' => 'catexcel']],
    ['trendline', 12, true, 'charts12', 'trendline', 'A straight (or curved) line Excel draws through a chart\'s data to show its general direction; it can be extended forward to suggest the next values.', ['course' => 'catexcel']],
    ['combo chart', 12, true, 'charts12', 'combo', 'A chart that shows two kinds of chart at once - such as columns for one series and a line for another - often with a second value axis on the right for the line.', ['course' => 'catexcel']],
    ['sparkline', 12, true, 'charts12', 'sparklines', 'A tiny chart inside one cell that shows the pattern of a row (or column) of numbers - a line, columns, or win/loss - with no axes or labels.', ['course' => 'catexcel']],
```

## 4. CAPS and SAGs lines (added)

Added to `content/catexcel/caps.php` and `sags.php` (9 October 2026, no hold):
```php
// caps.php
        'nestedif' => [
            [12, 1, 'Spreadsheets: more complex functions - nested IF; AND, OR'],
        ],
        'countifs' => [
            [12, 1, 'Spreadsheets: variations of known functions - ROUNDUP, ROUNDDOWN, COUNTIFS, SUMIFS'],
        ],
        'lookups' => [
            [12, 1, 'Spreadsheets: LOOKUP functions, including the #N/A error indicator'],
        ],
        'text' => [
            [12, 2, 'Spreadsheets: text functions LEFT, RIGHT, MID, CONCATENATE, LEN, VALUE, FIND'],
        ],
        'dates' => [
            [12, 1, 'Spreadsheets: basic date and time calculations - YEAR, MONTH, DAY, DAYS, HOUR, MINUTE, SECOND, TIME, TODAY, NOW'],
        ],
        'summaries' => [
            [12, 1, 'Spreadsheets: subtotal outline feature (AVERAGE, COUNT, SUM, MIN, MAX)'],
        ],
        'datatools' => [
            [12, 1, 'Spreadsheets: validation of data (Grade 12 scope)'],
        ],
        'charts12' => [
            [12, 3, 'Spreadsheets: edit, format and change charts - working with the axes, minimum and maximum values, re-labelling axes, stacked bar and column graphs using a graphic, trendline; appropriate graphs for a given scenario'],
        ],
        'scenario' => [
            [12, 3, 'Spreadsheets: identify the appropriate functions for a scenario and solve problems; more advanced combinations of functions and formulas'],
            [12, 4, 'Consolidation of documents: spreadsheet - integration, problem solving, troubleshooting'],
        ],
// sags.php
        'nestedif' => [
            [12, 'P3', 'formulas: nested IF; CHOOSE, AND, OR'],
        ],
        'countifs' => [
            [12, 'P3', 'formulas: ROUNDUP, ROUNDDOWN, INT, TRUNC'],
        ],
        'lookups' => [
            [12, 'P3', 'formulas: VLOOKUP, HLOOKUP, XLOOKUP including the #N/A error indicator; MATCH, INDEX'],
        ],
        'text' => [
            [12, 'P3', 'text functions LEFT, RIGHT, MID, CONCATENATE, LEN, VALUE, FIND, SUBSTITUTE'],
        ],
        'dates' => [
            [12, 'P3', 'date and time - DATE, YEAR, MONTH, DAY, DAYS, HOUR, MINUTE, SECOND, TIME, NOW; WEEKNUM, WORKDAY, NETWORKDAYS, YEARFRAC, EDATE'],
        ],
        'summaries' => [
            [12, 'P3', 'SUBTOTAL (AVERAGE, COUNT, SUM); outline - group, ungroup, subtotal'],
            [12, 'P3', 'pivot charts and pivot tables; data tools - consolidate'],
        ],
        'datatools' => [
            [12, 'P3', 'data: get & transform - queries and connections; data tools - text to columns, remove duplicates, data validation'],
            [12, 'P3', 'review - protect sheet, workbook, allow edit ranges; view - macros'],
        ],
        'charts12' => [
            [12, 'P3', 'charts: changing the scale on the axes, minimum and maximum values, re-labelling axes, stacked bar and column graphs using a graphic, combo charts, emphasising parts of a chart; the appropriate chart for a scenario; sparklines; filters; pictographs'],
        ],
        'scenario' => [
            [12, 'P3', 'plan, design and solve problems using spreadsheets for specific scenarios; links'],
        ],
```

## 5. Drawings

Used (plain names; the site uses `cat-<name>.svg` once the Art chat has
drawn it): `fork-road` (nestedif #nested), `boolean-venn` (#and),
`fence-posts` (countifs #roundup), `barcode-lookup` (lookups #table),
`id-number-parts`, `name-tag`, `email-address-parts` (text),
`calendar-1899`, `leap-cake`, `clock-hands` (dates),
`sql-group-by-totals` (summaries #subtotal), `validation-bouncer`
(datatools #why), `toolbox` (scenario #plan). Redraw in the CAT style: all
thirteen.

Wished for (one line each):
- nestedif: Clicky on a staircase of yes/no doors - "80 or more?" at the top, "50 or more?" below, Support at the bottom.
- countifs: two sieves, "12A" over "Yes", one ticket falling through both.
- countifs: 34 guests and three full tables, four people standing - "ROUNDUP".
- lookups: Clicky running down column A of a price list with a finger, then across to column 3.
- lookups: a price list sliding down a page, a VLOOKUP looking at empty rows ("no $ signs").
- text: a pair of scissors cutting PS12-0417 into PS / 12 / 0417.
- dates: a calendar page with "26006" written on it - "to Excel, a date is a number".
- summaries: a long till slip folding up like an accordion into four totals (outline level 2).
- datatools: Clicky as a bouncer with a clipboard turning away "Grade 21".
- charts12: two bar charts of the same numbers, one starting at 0, one at 150 - "which one is lying?".
- charts12: a column of stacked plastic bottles - "1 bottle = 100 kg".
- scenario: a magnifying glass over a column that is right at the top and #N/A at the bottom.

## 6. What the platform could not mark, and other doubts

*(9 October 2026, phase B: validation, pivots, outlines, page breaks, chart details and sparklines are read and marked now. SportsDay-done (input message, Stop alert) remade in real Excel by `catexcel-done-fixes.ps1`; it gets full marks in bin/check-uploads.php (3b). The screens below that could not be made are still missing.)*

**Not readable by lib/officexml.php** (as it was - taught, simulated and set in the
uploads, but not marked):
- **data validation** rules (lists, whole-number rules, messages) -
  `datatools` marks what the rules lead to (the circled grades fixed) and
  the formulas that use the drop-down cell. Suggested: an `xlsx.validation`
  subject (range, type, formula1/2, alert style), from `<dataValidations>`.
- **pivot tables** themselves - only their output cells; the IEB upload
  `upMarketPivot` has Jev read the cells of a sheet named Pivot.
  Suggested: `xlsx.pivot` (sheet, row fields, data fields, function) from
  `xl/pivotTables/*.xml`.
- **outline/grouping** (row `outlineLevel`) and **page breaks** between
  groups (`<rowBreaks>`) - the Subtotal upload asks for page breaks but
  marks only the SUBTOTAL rows.
- **chart details**: stacked against clustered (`c:grouping`), axis
  min/max/major unit (`c:scaling`, `c:majorUnit`), axis titles, trendlines,
  picture fill, exploded slices and the secondary axis; **sparklines**
  (`x14:sparklineGroups`) not at all. `charts12`'s upload marks only the two
  charts' types and titles (4 marks). Suggested: `xlsx.chart` tests
  `grouping`, `axisMax`, `axisMin`, `majorUnit`, `axisTitles`, `trendline`;
  an `xlsx.sparklines` subject.
- **protection** (sheet, workbook, allow edit ranges) and **macros** (.xlsm
  is not accepted by the upload; no macro reader) - IEB, taught only.

**Screens that could not be made** (all in the CAT VM through vm-shots):
- The Data Validation box (an old bosa_sdm dialog) takes no posted keys: the
  rule was set through COM and the box reopened. The simulation's "type the
  Source" picture (`datatools-v-3b`) is that reopened box with the Source
  text painted white - what the box shows after choosing List, before typing.
- The Data Validation button's menu (Circle Invalid Data), and the Add Chart
  Element menu, Select Data and Change Chart Type (the Chart Design tab's
  buttons were not found by UI Automation once the chart was selected) were
  not captured: prose, and the Circle Invalid Data result picture.
- Evaluate Formula's Evaluate button is not in UI Automation, so only the
  box's first state is pictured; the steps after it are in the text.
- The stacked chart in `charts12` runs below the window's bottom edge (the
  axis's 0 is cut off in s-3, a-1, a-2). A re-run with a shorter chart
  (AddChart2 height 250) would be tidier.

**9 October 2026, the last gaps** (the real-input runs' pictures had been
taken but not used; cropped by `work/catexcel-real-crop.py ... 9 58 1851 992`,
`--nopaint` on tabs with orange icons of their own - the add-in painter took
the Formulas tab's Trace arrows and the Page Layout tab's Arrange icons for
Claude's mark):
- **Data Validation menu:** datatools simCircleInvalid - the arrow, Circle
  Invalid Data, the red circles (catexcel-datatools2.ps1, k-0..k-2).
- **Add Chart Element, Select Data, Change Chart Type:** charts12
  simAxisTitle12 (e-0..e-3), simSelectData (d-1) - catexcel-charts122.ps1 -
  and (IEB) simComboType (c-0..c-2, catexcel-charts12x.ps1: charts122's
  Change Chart Type click had landed on Home's Format after an Esc).
- **Evaluate Formula's later steps:** scenario simEvaluate - Evaluate twice,
  C12 -> "BW" -> #N/A (catexcel-scenario2.ps1, e-2..e-4).
- **The stacked chart re-shot:** simStacked now uses charts122 s-0..s-3 (the
  whole chart, 0 on the axis), and simAxisMax's first step its s-3.
  **Still open:** simAxisMax's a-1 and a-2 (the Format Axis pane, Maximum
  1000) are the first run's, cut off at the bottom. Two re-runs
  (catexcel-charts12x.ps1, a real double-click on the axis's numbers, the
  second after clicking the chart) opened Format Shape instead of Format
  Axis; given up after two tries. Next idea: select the axis through COM
  (`$chart.Axes(2).Select()`), then Ctrl+1 for its pane, and take the
  Maximum box's place from a picture.
- Text to Columns: the wizard's step 1 is pictured, the split done through
  COM; Remove Duplicates' result message did not appear.

**The VM lock**: four runs waited the full 90 minutes and failed ("VM is
busy"); a scratch retry loop ran them again. Runs took 9 October
00:10-03:10.

**Office account name**: the nine starters and ten done-right fixtures were
scrubbed with `scrub-office.py --fix` (6 still carried the name; 0 now).
The copies the scripts put in `G:\My Drive\CAT\Excel\` in the VM were not
scrubbed (the scripts copy straight after SaveAs) - they carry the name
until the VM's files are scrubbed or the scripts re-run.

**Other doubts**:
- Quotes: Gleick (nestedif, portrait gleick.png) and Carmack (lookups,
  carmack.png) have portraits; Barber, @Lord_Voldemort7 (a parody account),
  the anonymous Halloween joke, Paul Gil, Don Rittner, Camille Paglia and
  Maria Montessori use anonymous.svg. Paglia's and Montessori's portraits
  are in the quote bank if wanted.
- The margin fact in `charts12` (a TV channel's tax-rate bar chart with the
  axis at 34%) is the well-known Fox News chart of 2012; not named.
- IFS is named (the IEB 2025 memo accepted it); the lesson teaches nested IF.
- `datatools`'s IEB section recaps Protect Sheet and links Grade 11
  `sheets#protect` (a CAPS section there).
- The sports-day upload's Jev check depends on the drop-down cell B2's value
  at save time - Jev is given the event in `event`.
- `check-jev` flags read and left: nestedif s19Works option b (it is right:
  the smallest-first order); text t22Domain's MID answer (right: MID past
  the end is fine); charts12 q26Secondary (the combo caption just before the
  question teaches the answer - a check after teaching).

## 7. Shared files: what was done, what waits

- **Done** (no hold after about 00:35): `content/catexcel/caps.php` and
  `sags.php` lines (section 4); `cat-videos/README.md` rows for
  catexcel-19.1 to 27.1 (after catexcel-09.2; Grade 11's 10-18 rows go
  between).
- **Waiting - index entries (section 2) and glossary rows (section 3).** My
  lessons link to Grade 11 lessons (`if`, `sumif`, `absolute`, `rounding`,
  `sheets`, `condformat`, `importing`, `graphs`) that are not in
  `index.php` yet, and check-glossary fails for rows whose lesson is not in
  the index. So both wait until Grade 11's entries are in. Checked in a
  mirror with Grade 11's planned entries added: every link resolves except
  `graphs#link` (graphs.php not written yet). Add the index entries first,
  then the glossary block, then run check-lesson-links, check-glossary,
  check-sags.

## 8. Screen scripts, starter files, checks

Scripts (AIResources/tools/sim-screens/): `catexcel-nestedif`, `-countifs`,
`-lookups`, `-text`, `-dates`, `-summaries`, `-datatools`, `-charts12`,
`-scenario` (.ps1), sharing `work/catexcel12-kit.ps1` (Comp12 - draws
Excel's other windows over the main one - SnapAll, FindAny, ShowExcel,
Fill12, CellAt, SaveStarter) and cropped by `work/catexcel12-crop.py`
(paints out the Add-ins and Claude groups, only on Home-tab pictures).
Windows 1600 wide (formulas) or 1860 (the Data, View and Chart tabs).

Starters (`public/assets/practical/catexcel/`, and `G:\My Drive\CAT\Excel\`):
Prelims12B, FarewellTickets, BothaOrders, Yearbook, StaffTimes, MarketDay12,
SportsDay, Recycling12, FunDay (.xlsx). Fixtures (`tests/uploads/catexcel/`):
each `-done.xlsx`, plus MarketDay12-pivot-done.xlsx.

Checks (9 October 2026, in a scratch mirror with my index entries, because
the real index waits - see 7): `php -l` on every file; check-simulations
(97 simulations, 287 steps, OK), check-lesson-contents, check-figures,
check-titles, check-why (0 giving the answer away), check-typed-rules,
check-code-questions, check-pictures, check-more-questions,
check-popup-spacing - all OK; check-uploads --no-jev - all ten blocks well
formed, all passed; check-jev on each lesson - flags read (section 6);
renderone (mirror copy): nestedif 86 573, countifs 61 915, lookups 75 788,
text 82 945, dates 61 038, summaries 89 017, datatools 86 596, charts12
80 945, scenario 65 763 bytes, no WARN. check-sags on the real tree OK.
