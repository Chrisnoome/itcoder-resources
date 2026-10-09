# catexcel Grade 11 - notes

9 October 2026. The Grade 11 chapter of `catexcel` (Spreadsheets), written to
[../cat-practical-writing.md](../cat-practical-writing.md) ("Grades 11 and
12"). Nine lessons, numbers 10-18, by three writers (A, B, C) to one plan.
Grade 10 is 1-9 (`sorting` is 9) and Grade 12 is 19-27
([catexcel-12.md](catexcel-12.md)). Lessons are in
`AIPascalCourse/content/catexcel/`.

| # | id | Title | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|---|---|
| 10 | `absolute` | Absolute references and range names | 58 / 68 | 3 | `upFarewellBudget` (FarewellBudget.xlsx), 6 exact |
| 11 | `rounding` | ROUND, POWER, LARGE and SMALL | 64 / 68 | 5 | `upStokvel` (Stokvel.xlsx), 6 exact |
| 12 | `condformat` | Conditional formatting | 64 / 64 | 3 | `upTerm3Marks` (Term3Marks11B.xlsx), 5 exact + 1 Jev |
| 13 | `if` | The IF function | 64 / 64 | 4 | `upCakeOrders` (CakeOrders.xlsx), 6 |
| 14 | `sumif` | COUNTIF and SUMIF | 42 / 50 | 4 (1 IEB) | `upMarketDay11` (MarketDay11.xlsx), 6 |
| 15 | `sheets` | Working with sheets and windows | 66 / 74 | 5 (1 CAPS, 1 IEB) | `upMarkBook11B` (MarkBook11B.xlsx), 6 |
| 16 | `printoptions` | Print options | 54 / 60 | 5 (1 CAPS, 1 IEB) | none marked: page setup cannot be read; an unmarked "Do it in Excel" with MarkBook11.xlsx |
| 17 | `graphs` | More charts, and linking them | 72 / 72 | 5 (1 CAPS) | `upBakerySales` (BakerySales.xlsx), 4 exact + 2 Jev |
| 18 | `importing` | Importing, exporting, and advanced sorting and filtering | 40 / 68 | 4 (2 IEB) | `upBakeryBook` (BakeryBook.xlsx + TillSales.csv), 6 exact |
| | **Total** | | **524 / 588** | 38 | 8 |

Board sections: absolute (AutoFill Options, IEB), rounding (RAND, IEB), sumif
(COUNTA and COUNTBLANK, IEB), sheets (Protect Sheet, CAPS; windows, splits
and custom views, IEB), printoptions (print area and titles, CAPS; Arrange,
IEB), graphs (line, area and doughnut, IEB; a linked chart in Word, CAPS),
importing (advanced sorting and filtering, IEB). Every Grade 11 spreadsheet
line of cat-caps.md and cat-sags.md 8.3 is placed (the CAPS and SAGs sections
below). The IEB's "BETWEEN" is read as the Between rule of conditional
formatting plus RANDBETWEEN (recapped from Grade 10). Subtotals are Grade 12.

**Lead's finishing pass (9 October 2026):** the index entries for 10-18 (and
Grade 12's 19-27), the glossary rows (29 Grade 11 and 34 Grade 12, no clash
with existing terms), and the CAPS, SAGs and README lines are merged.
`scrub-office.py --fix` took the VM account's name out of MarkBook11.xlsx
(and a catword fixture). Two check-jev flags were reworded: graphs m17Elements
(a why line that named the legend) and printoptions w16ScenarioPlan (a print
area idea the scenario did not need). On the real tree: every Grade 11
upload's starter marks 0. The done-right copies get full marks on the exact
checks. The Jev checks (condformat 1, graphs 2) were read with the values Jev
sees.

## Lessons written - by writer

### Writer A (absolute, rounding, condformat)

| # | Lesson | Marks CAPS / IEB | Simulations (steps) | Upload |
|---|---|---|---|---|
| 10 | `absolute` - Absolute references and range names | 58 / 68 | `simVatDollar` (4: click C5, F4, Enter, double-click the fill handle), `simNameVat` (4: Name Box, type VAT, click C5, type =B5*VAT), `simShare` (4: click, type =B5/$B$12, fill handle, Percent Style) | `upFarewellBudget`, 6 exact checks, starter `FarewellBudget.xlsx` |
| 11 | `rounding` - ROUND, POWER, LARGE and SMALL | 64 / 68 | `simRound` (3), `simPower` (2), `simLargeSmall` (3), `simCircular` (2: click the cell the status bar names, type =SUM(B5:B8)), `simHelp` (2: fx, Help on this function) | `upStokvel`, 6 exact checks, starter `Stokvel.xlsx` (a circular total typed in by real Excel) |
| 12 | `condformat` - Conditional formatting | 64 / 64 | `simLessThan` (4: Conditional Formatting, Highlight Cells Rules, Less Than..., type 50), `simDataBars` (3), `simManageRules` (4: CF, Manage Rules..., Delete Rule, OK) | `upTerm3Marks`, 6 checks (5 exact, 1 Jev), starter `Term3Marks11B.xlsx` (a wrong green rule in it) |

Breakdown: absolute - simulations 24, questions 22, written 6 (w10OneCell 2, w10Plan 4), upload 6; IEB section (AutoFill Options: q10FillWeekdays, m10FillOptions) 10. rounding - simulations 24, questions 30, written 4 (w11RoundFormat, w11Circle), upload 6; IEB section (RAND: q11Rand, q11Dice) 4. condformat - simulations 22, questions 32, written 4 (w12Plan), upload 6. Own-words reveal: absolute `r10Zero`. Titles as the plan.

Unusual:
- **Typing in the simulations' pictures is real typing.** The kit posts characters to Excel's grid (WM_CHAR, after F2 - a first posted character on its own was swallowed), so the type steps' pictures show the formula in the cell in Excel's reference colours, and F4 posted the same way really turned B2 into $B$2 (absolute run 3, picture x-f4).
- **The circular-reference warning** only shows with DisplayAlerts on: catexcel-rounding.ps1 turns it on just for that Enter and closes the box through its own OK button. The starter Stokvel.xlsx got its circular total the same way (typed, alerts off), so no warning could block COM.
- **Upload marking**: absolute D16 is marked by the formula =D14/Tickets AND a value that is not #NAME? (the reader cannot see defined names; a missing name leaves #NAME?). rounding C6 / C15 are marked "has a formula and the value real Excel gives" (5880.21, 4802.17): ROUND with POWER or ^ has too many right wordings to list, and the value is right only when the result is rounded and $B$2/$B$3 are absolute. condformat check 3 (the rule compares with B2) is Jev on the extracted rule formulas; its check 1 is a `not` (the starter's green rule must be gone), whose generic "does what this check says it should not" message reads oddly - the fix line carries the meaning.
- Quote portraits: none of the three people has one in public/assets/quotes, so `anonymous.svg`, as Grade 10 did. Quotes logged in quotes-taken.txt (K.J. McCory, the binary joke, Ryan Holiday); none is used by another CAT lesson.

### Writer B (if, sumif, sheets)

| # | Lesson | Marks CAPS / IEB | Simulations (steps) | Upload |
|---|---|---|---|---|
| 13 | `if` - The IF function | 64 / 64 | `simPassFail` (4: click, type, click, double-click the fill handle), `simDiscount` (2), `simArguments` (4: Logical, IF, type in Logical_test, OK - the Function Arguments box), `simFixQuotes` (2: troubleshooting "50" in quotes) | `upCakeOrders`, 6 checks, starter `CakeOrders.xlsx` |
| 14 | `sumif` - COUNTIF and SUMIF | 42 / 50 | `simCountArea` (2), `simSumArea` (3: type, click, double-click), `simBigOrders` (2), IEB `simUnpaid` (2) | `upMarketDay11`, 6 checks, starter `MarketDay11.xlsx` |
| 15 | `sheets` - Working with sheets and windows | 66 / 74 | `simCopySheet` (5: Format, Move or Copy Sheet, before Year, Create a copy, OK), `simLink` (4: two typed sheet references), `simFreeze` (4: B4, View, Freeze Panes, Freeze Panes), CAPS `simProtect` (5: Protect Sheet, password, OK, password again, OK), IEB `simArrange` (5: New Window, the new window's View tab, Arrange All, Vertical, OK) | `upMarkBook11B`, 6 checks, starter `MarkBook11B.xlsx` |

Unusual:

- **No board section in `if`** - simple IF and the relational operators in IF
  are Grade 11 for both boards.
- **`sumif`**: COUNTA/COUNTBLANK practice in an IEB section (CAPS taught them
  in Grade 10's `more` CAPS section; IEB meets them now). Extra anchors
  `#operator` and `#check` (troubleshooting a summary: parts add up to the
  whole; a relative range filled down - the real m-1 screen shows Midrand
  R1 515 instead of R1 695).
- **`sheets`**: CAPS section `#protect` (IEB Grade 12), IEB section
  `#windows` (New Window, Arrange All, Switch Windows, Split, Hide/Unhide,
  Custom Views). Extra anchors `#show` (gridlines/headings on screen, recap
  of start#sheets) and `#plan` (planning a workbook for Mr Botha's months -
  CAPS Term 4 "plan and design for scenarios"). The `q15Split` answer
  (Split while frozen unfreezes and splits) was checked in the VM: after
  pressing Split with panes frozen, FreezePanes False, Split True.
- **Uploads are exam-style** (a starter, a numbered task list, "the marker
  reads your formulas"). Each formula check is an `any` of the usual
  wordings, built by small PHP helpers at the top of the lesson
  (`$ifForms`, `$countForms`, `$sumForms` ...): `if` accepts the decision
  turned round (IF(D4<$J$3,$J$4,0)), $J$3 or J$3, "Big"/"BIG"/"big"; `sumif`
  accepts $B$4:$B$27 or B$4:B$27 and F4 or $F4. Value checks where any
  formula should do: `if` G15 (hasFormula + 38), `sumif` G9 (hasFormula +
  0.375 + a % format: 0%, 0.0% or 0.00%).
- **`sheets` upload**: sheets deleted/inserted/placed (xlsx.sheet by index and
  'not'), links and the average. Freeze panes and protection are in the task
  ("not marked here - an exam marks it by looking") because the reader
  cannot see them.
- Starter scores 0 and done-right copy (made by real Excel) full marks for all
  three (section 9).

### Writer C (printoptions, graphs, importing)

| # | id | Title | Marks CAPS / IEB | Simulations (steps) | Upload |
|---|---|---|---|---|---|
| 16 | `printoptions` | Print options | 54 / 60 | `simFitColumns` (4: File, Print, scaling list, Fit All Columns on One Page), `simSheetOptions` (2: Gridlines Print, Headings Print), `simPrintWhole` (2: Print What list, Print Entire Workbook), CAPS `simPrintArea` (2), IEB `simArrange` (2: Bring Forward, Selection Pane) | **none** - an unmarked "Do it in Excel" with MarkBook11.xlsx and a reveal of what the PDF should show |
| 17 | `graphs` | More charts, and linking them | 72 / 72 | `simAxisTitle` (4: Add Chart Element, Axis Titles, Primary Vertical, type Number sold), `simAddSeries` (3: Select Data, type =Sales!$A$1:$D$7, OK), `simChangeType` (3), `simMoveChart` (4: Move Chart, Object in list, Report, OK), CAPS `simLinkChart` (2 keys: Ctrl+C in Excel, Ctrl+V in Word) | `upBakerySales`, 6 checks (4 exact, 2 Jev on chart titles), BakerySales.xlsx |
| 18 | `importing` | Importing, exporting, and advanced sorting and filtering | 40 / 68 | `simImportCsv` (3: From Text/CSV, double-click TillSales.csv, Load), `simExportPdf` (3: File, Export, Create PDF/XPS), IEB `simCustomSort` (5: Sort, Order list, Custom List..., Sun-Sat list, OK), IEB `simAdvFilter` (5: Advanced, Copy to another location, type $F$1:$G$2, type $I$1, OK) | `upBakeryBook`, 6 checks (exact), BakeryBook.xlsx + TillSales.csv |

Board sections: printoptions - CAPS "Print Area and Print Titles" (taught to all in Grade 10 inside printing's IEB section; recap, link and CAPS-counted practice), IEB "Arranging pictures, shapes and charts"; graphs - IEB "Line, area and doughnut charts", CAPS "A chart in Word: pasted or linked" (Paste Link for cells there too); importing - IEB "Advanced sorting", IEB "Advanced filtering". Each lesson has one `Scenario` (printoptions: the prize-giving list; importing: the fun-run sign-up from Google Forms, the closing "putting it together"), 1-2 written questions with Jev points, an own-words reveal (r16CtrlEnd, r18ColumnA).

Anchors (as the plan): printoptions `#recap #scale #sheetoptions #workbook #breaks #area #arrange #plan #practice` (no `#upload`); graphs `#recap #elements #data #type #options #move #kinds #link #upload`; importing `#csv #import #open #export #advsort #advfilter #together #upload`.

Unusual:

- **printoptions has no marked upload** (as the plan allowed): every skill it teaches lives in the sheet's pageSetup / printOptions / rowBreaks, the workbook's defined names (_xlnm.Print_Area, _xlnm.Print_Titles) or drawing objects - none read by lib/officexml.php. A marked upload could only mark what the lesson does not teach. Instead: a prose "Do it in Excel" with a download link to MarkBook11.xlsx (real Excel; in G:\My Drive\CAT\Excel\) and a reveal describing the PDF it should give. No done-right fixture.
- **graphs upload** marks B8, C8:D8 (SUM formulas), a line chart on the Report sheet (exact: sheet + type - so Move Chart > Object in, not a chart sheet), its title (Jev), a pie chart on Sales (exact) and its title (Jev). Axis titles and percentage labels are asked for but not marked (the prompt says so).
- **importing upload**: sheet name TillSales; the imported values (B1 Item, B2/B21 White bread, E2 36, E21 72 - numbers as numbers); Summary B3:B6 each `hasFormula` + its value (20, 72, 842, 234) - by value, not formula text, because the import is a table, so a pupil's formula may be =SUM(TillSales!E2:E21) or =SUM(TillSales[Amount]) or whole columns. A pupil could pass with a formula like =842 - accepted risk, noted.
- importing CAPS total is exactly 40 (the floor): most of the lesson's weight is the IEB's advanced sort and filter.
- Word in graphs: **nothing was saved in Word** (SaveAs2 has hung before) - the document was closed unsaved. Word's default when a chart is pasted with Ctrl+V/Paste in this VM was **linked** (IsLinked true, Use Destination Theme & Link Data); the lesson says so and the simulation uses Ctrl+C / Ctrl+V.

## Drawings - by writer

### Writer A (absolute, rounding, condformat)

Used (plain IT names; the site uses `cat-<name>.svg` once drawn):
`treasure-map` (absolute #dollar), `name-tag` (absolute #names - its
"Mickey Mouse / Valid? Yes." text is IT's; a CAT redraw could say "VAT"),
`pi-slice` (rounding #formatting - its ":0:2" is Pascal's; redraw as
"333.333... shown as 333.33"), `ten-types` (rounding #power, with the
quote), `podium` (rounding #largesmall), `dice` (rounding #rand - already
`cat-dice`), `red-pen` (condformat #what - already `cat-red-pen`),
`two-thabos` (condformat #duplicates), `traffic-light` (condformat #bars).

Wished for:
- absolute: a formula =B5*$B$2 copied down a staircase of cells - the B5 part walking down a step each time, the $B$2 part chained to one spot with a padlock.
- absolute: Clicky pressing F4 four times, a padlock jumping $B$2 -> B$2 -> $B2 -> B2.
- rounding: an iceberg: "333.33" above the water, "333.3333333..." under it; Naledi's phone calculator saying 1089.66 beside the sheet's 1089.67.
- rounding: Clicky chasing its own tail round a cell labelled B10 ("=SUM(B5:B10)").
- condformat: a class list as a newspaper front page - the red cells as the headlines, a small "good news" box in green at the bottom ("colour the improvement too").
- condformat: two rules fighting over one cell, the green one on top of the pile winning ("the top rule wins").

### Writer B (if, sumif, sheets)

Used (plain IT names; the CAT redraw is used once it exists): `fork-road`
(if #decisions), `quotes` (if #text - its IT caption is about Pascal
apostrophes; mine is about Excel's double quotes), `access-buckets` (sumif
#countif), `copy-vs-move` (sheets #sheets), `arr2d-spreadsheet` (sheets
#linking), `password-note` (sheets #protect, CAPS).

Wished for:
- if: Clicky at a fork in the road, a signpost "B4>=50?" with YES pointing to a "Pass" flag and NO to "Fail".
- if: a formula with "50" in quotes wearing a disguise - text pretending to be a number - while every pupil in the queue gets "Fail".
- if: a mark of exactly 50 balancing on a fence between > and >= ("test the edge").
- sumif: Clicky sorting order slips into three buckets (Centurion, Pretoria, Midrand) and adding up only one bucket's slips on a calculator.
- sumif: a range sliding down a staircase when filled down, the top step (row 4) left behind; a $ padlock that would have held it.
- sheets: the Year sheet with a chain to each term sheet tab - a mark changes on Term 1 and the chain carries it across.
- sheets: Clicky holding the top rows of a long list still like a window blind (Freeze Panes) while the rest scrolls past.
- sheets: a padlocked formula cell and an open cell for typing marks (locked vs unlocked).

### Writer C (printoptions, graphs, importing)

Used (plain IT names; CAT redraws used once they exist): `printer-three-parts` (printoptions #recap), `carbon-paper` (printoptions #plan), `rows-vs-chart` (graphs #recap), `locking-tills-pie` (graphs #kinds), `adapter-chain` (graphs #link), `data-swap-csv-xml-json` (importing #csv), `messy-data` (importing #open).

Wished for:
- printoptions: Clicky squeezing a wide sheet into a page like a concertina, a magnifying glass beside the tiny text ("Fit Sheet on One Page?").
- printoptions: a stack of see-through layers - chart, speech bubble, badge - with Clicky pulling the bubble to the top (Bring Forward).
- graphs: a bank manager squinting at a chart titled "Chart Title", Clicky holding up a sign "what? who? when?".
- graphs: Excel and Word holding the two ends of a chain; a pair of scissors marked "rename the file" about to cut it.
- importing: a till printing a long paper roll that turns into a CSV file with commas, Clicky catching it with a funnel into a spreadsheet.
- importing: the days of the week queueing alphabetically (Fri first) and Clicky re-ordering them Mon to Sat with a custom-list sign.

## Screens - by writer

### Writer A (absolute, rounding, condformat)

Scripts (AIResources/tools/sim-screens/), each run in the CAT VM with vm-shots.ps1; shared helpers in `work/catexcel11a-kit.ps1` (CompA - the sorting script's Comp class -, SnapAll, FindAny, DumpOthers; FitDialogs moves a dialog Excel put half off its window back inside it; Chars/Key post characters and keys to the grid; TypeAndSnap). Crops: `work/catexcel-absolute-crop.py`, `work/catexcel-rounding-crop.py` (1180 wide; the c-w picture's Formula Bar, which showed Excel's half-finished edit behind the warning, painted white), `work/catexcel-condformat-crop.py` (1380 wide - the menus' galleries reach x 1370 - with the Add-ins/Claude groups painted out). Every crop starts at y 56 (no title bar, no account initials). Every picture used was looked at.

- `catexcel-absolute.ps1` - 3 runs (run 1: the first posted character was lost, so the typing pictures showed "B5*$B$2"; fixed with F2 first; run 2 lost to the 90-minute lock). Pictures from run 3. The Name Box is not in UI Automation: VAT was named through COM; the Name Box picture is real (B2 selected) and the simulation's typing happens on it.
- `catexcel-rounding.ps1` - 4 runs (run 1: my `$marks` array overwrote office-kit's marks table; run 2: no warning box - DisplayAlerts was off; run 3 good). Not captured: the Formulas > Error Checking drop-down (the split button's Expand opens nothing) - taught in prose, and simCircular uses the status bar instead. fx beside the Formula Bar is not in UI Automation, so the Function Arguments and Insert Function boxes were opened from Formulas > Insert Function... (the simulation's fx target and "Help on this function" were read off the pictures).
- `catexcel-condformat.ps1` - 4 runs. Runs 1 and 2: at the FIRST opening of the Conditional Formatting menu, office-kit's input guard saw the input clock move (both runs, same place, nobody at the VM) and deleted the pictures taken so far. The script now opens and closes that menu once before any picture of that part and reads the clock again (commented in the script). Run 2 (backup in scratchpad xl11/shotsA/cf2) gave every picture except the Less Than part; run 4 gave w-1 and l-1..l-4 (the Less Than box's value cannot be set by UI Automation - "takes no text" - so the simulation types on the real box with Excel's suggested 61.5 selected; the later menus in run 4 failed after that box, so only those five pictures come from run 4; both runs build the same sheet). The Rules Manager opened half off the window: moved inside it (FitDialogs) before its pictures.
- Starter files made in real Excel, saved in the VM to `C:\sims\files\catexcel-<id>\` and `G:\My Drive\CAT\Excel\`, copied to `public/assets/practical/catexcel/` (FarewellBudget.xlsx, Stokvel.xlsx, Term3Marks11B.xlsx); done-right copies by real Excel in `tests/uploads/catexcel/` (*-done.xlsx).
- Pictures on the site: catexcel-absolute-* (18), catexcel-rounding-* (20), catexcel-condformat-* (28).

### Writer B (if, sumif, sheets)

All in `AIResources/tools/sim-screens/`, run in the CAT VM with vm-shots.ps1;
helpers in `work/catexcel11b-kit.ps1` (a copy of the Grade 12 writer's
catexcel12-kit.ps1 with the class renamed Comp11B, plus `Key`/`Chars` -
keys and characters posted to ONE dialog window - and `SaveArea`, a picture
of a screen area holding several of Excel's windows). Crops: one file per
lesson in `work/` (catexcel-if-crop.py, catexcel-sumif-crop.py,
catexcel-sheets-crop.py), title bar always off, Add-ins/Claude groups outside
the crop or painted out.

- `catexcel-if.ps1` - 3 runs (the 2nd lost to the 90-minute lock: "VM is
  busy"). Makes CakeOrders.xlsx + -done. The Function Arguments box
  (bosa_sdm_XL9) DOES take characters and Tab posted to its window: f-4t is
  the box with B4<40, "See me" and "" really typed into it. The fallback
  (fx on a filled cell, f-4) also works but is not used.
- `catexcel-sumif.ps1` - 2 runs (the 2nd for m-1, scrolled back to column A).
  Makes MarketDay11.xlsx + -done. Its Show Formulas shot (s-1) doubles the
  column widths and is not used.
- `catexcel-sheets.ps1` - 1 run: links, freeze, split, custom views, the
  arranged windows (w-5) and w-2a are from it. Makes MarkBook11B.xlsx + -done
  (first saved as MarkBook11C.xlsx - the class is 11B, so the file was
  renamed on the site, in tests/ and, by sheets2, in G:\My Drive\CAT\Excel\).
  Its Move or Copy part tripped the input guard ("keyboard or mouse used while
  the program was in front" - nobody was using the VM; it deletes the run's
  earlier pictures, so h-1..h-3 were lost) and its protect part failed after
  it closed the wrong window. It also confirmed a fact for q15Split: Split
  pressed with panes frozen gives FreezePanes False, Split True.
- `catexcel-sheets2.ps1` - 1 run: w-1..w-4 (New Window, its View tab, Arrange
  All, Alt+V picks Vertical in the bosa_sdm dialog). Its posted keys did
  nothing in Protect Sheet and Move or Copy: those are NUIDialogs.
- `catexcel-sheets3.ps1` - 1 run: NUIDialog boxes ARE in UI Automation -
  ValuePattern for the password (both boxes), SelectionItem for "Year",
  Toggle for Create a copy, Invoke for OK: p-1..p-5 and h-1..h-5.
- Not captured: nothing the lessons need. Typing into the Name Box, the
  right-click tab menu (prose only, as in Grade 10), the Format Cells >
  Protection tab (prose only) and the protected-cell message (prose only).
- Starter files in `C:\sims\files\catexcel-<id>\` and `G:\My Drive\CAT\Excel\`
  (CakeOrders.xlsx, MarketDay11.xlsx, MarkBook11B.xlsx); on the site in
  public/assets/practical/catexcel/; done-right copies in
  tests/uploads/catexcel/ (CakeOrders-done, MarketDay11-done, MarkBook11B-done).

### Writer C (printoptions, graphs, importing)

Scripts in `AIResources/tools/sim-screens/`, each run through `vm-shots.ps1`
in the CAT VM (Excel 365, culture en-ZA with "." decimal and "," list
separator - checked in each run):

- `work/catexcel11c-kit.ps1` - my copy of `work/catexcel12-kit.ps1` (class
  renamed `Comp11c`) plus `OtherByClass`, `Send`/`FindItem` (Win32 combo
  boxes), `ChildByTextAny` and `DeepestAt` (the deepest child window under a
  point, for posting a click to one window).
- `catexcel-printoptions.ps1` (4 runs; run 1 timed out waiting 90 min for
  the lock) + `work/catexcel-printoptions-crop.py`. Also makes MarkBook11.xlsx
  (C:\sims\files\catexcel-printoptions\ and G:\My Drive\CAT\Excel\).
- `catexcel-graphs.ps1` (7 runs: one lock time-out, one Excel crash - RPC
  unavailable - during Change Chart Type) + `work/catexcel-graphs-crop.py`.
  Also makes BakerySales.xlsx and BakerySales-done.xlsx (real Excel: SUMs,
  a line chart moved with Chart.Location to Report, a pie of the totals).
  The lesson's own workbook BakeryCharts.xlsx is saved in files\ too (for
  the Word link) - not a pupil file.
- `catexcel-importing.ps1` (6 runs) + `work/catexcel-importing-crop.py`.
  Also makes TillSales.csv (ASCII, CRLF), BakeryBook.xlsx and
  BakeryBook-done.xlsx (the CSV imported with Power Query through COM:
  Queries.Add + ListObjects.Add with the Mashup OLE DB source).
- Starter files copied to `AIPascalCourse/public/assets/practical/catexcel/`
  (MarkBook11.xlsx, BakerySales.xlsx, BakeryBook.xlsx, TillSales.csv); done
  copies to `tests/uploads/catexcel/` (BakerySales-done.xlsx,
  BakeryBook-done.xlsx).

Learnt / worked around:
- **Dialogs that draw their own controls** (bosa_sdm: Advanced Filter, Move
  Chart; the Power Query preview; Word's Paste arrow) take **clicks and
  characters posted to the window under the point** (WM_LBUTTONDOWN/UP,
  WM_CHAR) - that is how af-1b..d (radio, criteria range, copy-to typed),
  mv-2 (the Object in list), the real **Load** in the CSV preview (im-4 with
  Queries & Connections "20 rows loaded") and Word's Paste menu were made.
  The classic file dialog (#32770) took WM_SETTEXT on its File name edit +
  BM_CLICK on Open; the Save As type combo CB_SHOWDROPDOWN / CB_SETCURSEL.
- The CSV preview window is taller than Excel's window: moved up with
  SetWindowPos so Load shows.
- **Chart Design tab**: in this VM the chart tabs appear only after a chart
  element (an axis title) has been selected; ChartObjects.Activate,
  Shape.Select and ChartArea.Select at the start never brought them. So the
  Add Chart Element pictures (el-1b, el-2, el-3, el-4b, el-5b) were taken
  later in the run, from the same chart with its vertical axis title taken
  away again.
- A file saved in Documents makes Excel show a "BACK UP THIS DOCUMENT"
  (OneDrive) bar: the lesson workbook is saved in C:\Users\pupil\Bakery.
- The Queries & Connections pane would not close by "Close pane" after the
  import; the advanced filter pictures (af-*) come from run 4 (a COM import,
  no pane), the rest of importing from run 6 - each simulation's pictures
  come from one run.
- Excel's title bar (account initials) is cut off everywhere; where a dialog
  reaches into it (importing's file dialogs and preview) the pictures are cut
  from the top and the title bar painted out around the dialog. The Save As
  box's OneDrive entry and Authors ("Chris Noome") are painted out. The VM's
  Add-ins/Claude ribbon groups are painted out automatically (the crop
  scripts detect the Home tab and the orange Claude icon).

**Not captured:**
- Page Layout > Scale to Fit's **Width list** (Expand and its own Open button
  opened nothing): Width 1 page is taught with the sc-3 figure; the
  simulation uses File > Print's scaling list instead (Fit All Columns on One
  Page = Width 1 page).
- **Word's Paste Options for a chart**: with the chart copied by COM
  (ChartObject.Copy or ChartArea.Copy) Word's Paste menu offered one icon
  only. The five options are a table in the text; the menu pictured is the
  one for copied **cells** (wd-4, six icons, Link & Keep Source Formatting
  etc.); simLinkChart uses Ctrl+C / Ctrl+V (Word pasted it linked).
- The **Insert Line or Area Chart** gallery (only a tooltip came up): the
  Pie or Doughnut gallery is pictured instead (kd-4).
- The Sort Options box (as-9) and Custom Lists box were captured; the Sort
  dialog's combo boxes were in UI Automation in one run only - later runs
  posted a click on the Order arrow.

## Checks (in the check mirror, by each writer) - by writer

### Writer A (absolute, rounding, condformat)

- `php -l` absolute, rounding, condformat: No syntax errors detected.
- `bin/check-simulations.php catexcel`: 0 problems in my 11 simulations (the run reports 44 problems in 66 simulations, all in other writers' lessons whose pictures are still to come).
- `bin/check-jev.php catexcel absolute`: 12 question(s) read by Jev; 0 flag(s). `rounding`: 13; 0 flags. `condformat`: 10; 0 flags (run before and after the last edits).
- `check-lesson-contents`: every lesson's bookmarks check out. `check-figures`: every illustration in a box with a caption (1414 figures). `check-titles`: every block title within 55 characters. `check-why catexcel`: 109 of 109 done; 0 giveaways. `check-code-questions`: OK, 465. `check-pictures`: OK, 117. `check-lesson-links`: no failure in my lessons (one FAIL: catexcel/importing links to printoptions, which has no file yet - writer C). `check-popup-spacing`: no problems (it caught one in rounding's SMALL line; fixed). `check-typed-rules`: OK, 90 typed questions add up.
- `tools/totals.php`: absolute CAPS 58 IEB 68; rounding CAPS 64 IEB 68; condformat CAPS 64 IEB 64 (all even, 40-80).
- `tools/upcheck.php`: FarewellBudget.xlsx exact 0 of 6, -done 6 of 6; Stokvel.xlsx 0 of 6, -done 6 of 6; Term3Marks11B.xlsx 0 of 5 exact (Jev sees `{"less_rules":[]}`), -done 5 of 5 exact (Jev sees the lessThan rule with formulas `["$B$2"]`); problems [] for all three blocks.
- `renderone-mirror.php catexcel <id>`: absolute 80 733 bytes, rounding 89 585, condformat 82 932; no WARN lines.

### Writer B (if, sumif, sheets)

- `php -l` if.php, sumif.php, sheets.php: no syntax errors.
- `bin/check-simulations.php catexcel`: OK - 66 simulations, 205 steps (none
  of mine flagged; the other writers' lessons were mid-way when I ran it
  earlier).
- `bin/check-jev.php catexcel if`: 12 read, 0 flags (first run: 1 flag -
  t13Delivery's explain "may not agree" p=0.48 - explain reworded).
- `bin/check-jev.php catexcel sumif`: 11 read, 0 flags (earlier flags worked
  through: q14Quotes options with "<" reached Jev cut short - check-jev strips
  "<..." as a tag - so the question asks for "more than R200"; q14Share's
  figure caption gave the formula away - caption rewritten; m14Args why lines
  named the answers - rewritten).
- `bin/check-jev.php catexcel sheets`: 11 read, 0 flags.
- check-lesson-contents: every anchor real. check-figures: OK (1415).
  check-titles: OK. check-why: catexcel 109/109 done, 0 giving the answer
  away. check-code-questions: OK (465). check-pictures: OK (117).
  check-popup-spacing: no problems. check-typed-rules: OK (90).
  check-lesson-links: none of mine (my links to absolute#dollar pass once
  writer A's absolute.php is synced; the only FAIL is importing ->
  printoptions, writer C's).
- `bin/check-uploads.php --no-jev`: upCakeOrders, upMarketDay11,
  upMarkBook11B well formed; all upload checks passed.
- totals.php: if CAPS 64 / IEB 64; sumif CAPS 42 / IEB 50; sheets CAPS 66 /
  IEB 74 - all even, 40-80.
- upcheck.php: CakeOrders.xlsx 0/6, CakeOrders-done.xlsx 6/6;
  MarketDay11.xlsx 0/6, -done 6/6; MarkBook11B.xlsx 0/6, -done 6/6.
- renderone-mirror.php: if 81 867 bytes, sumif 71 006, sheets 88 276 - no
  WARN lines.

### Writer C (printoptions, graphs, importing)

All run in the mirror after `sync.sh printoptions graphs importing`
(9 October 2026, after the last edits):

- `php -l` on the three lessons: no syntax errors.
- `bin/check-simulations.php catexcel`: **OK - 76 simulations, 233 steps
  checked** (no problem lines for my lessons; earlier runs listed only
  another writer's missing `sheets` pictures, since fixed by them).
- `check-lesson-contents`: every bookmark checks out. `check-figures`: every
  illustration has a caption (1435 figures). `check-titles`: all within 55
  characters. `check-why`: catexcel 131/131 done, 0 hints giving the answer
  away. `check-code-questions`: OK (465). `check-pictures`: OK (117).
  `check-lesson-links`: OK - every lesson link lands (my lessons link to
  absolute#dollar, sumif#sumif, if#if, condformat#what, sheets#sheets,
  printoptions#scale, cattheory10 filetypes#text/#others, cattheory11
  filesproper#import, catpowerpoint objects#excel). `check-popup-spacing`: no
  problems (one fixed in importing and graphs: `' ' . Gloss`).
  `check-typed-rules`: OK (90) - t16RowsRepeat's single rule removed.
- `bin/check-uploads.php --no-jev`: `catexcel/graphs/upBakerySales is well
  formed`, `catexcel/importing/upBakeryBook is well formed`.
- `bin/check-jev.php catexcel <id>`: printoptions **16 read, 0 flags**;
  graphs 12 read, 1 flag (m17Options: "a nearby caption gives the answer
  away", p=0.74 - three figure captions named Percentage, Gap Width and Line
  with Markers; captions reworded) then **0 flags**; importing **12 read, 0
  flags**.
- `tools/totals.php`: printoptions **CAPS 54 IEB 60**; graphs **CAPS 72 IEB
  72** (was 71/71 - the upload's totals check split in two to make it even);
  importing **CAPS 40 IEB 68**. printoptions was 55/61 until its scenario
  written part went from 3 marks to 2 (Scenario parts are 2 or 4).
- `tools/upcheck.php`: graphs - BakerySales.xlsx exact 0 of 6 (both Jev
  checks see no charts), BakerySales-done.xlsx exact 4 of 4 + Jev sees
  "Botha's Bakery: items sold per month, January to June 2026" (line, Report)
  and "Share of the items sold, January to June" (pie, Sales) = 6/6;
  importing - BakeryBook.xlsx 0 of 6, BakeryBook-done.xlsx 6 of 6.
- `renderone-mirror.php catexcel <id>`: printoptions 99 312 bytes, graphs
  102 083 bytes, importing 94 202 bytes, no WARN lines.
- Every picture looked at; unused crops removed from the site.

## Unsure, and what the platform lacked - by writer

### Writer A (absolute, rounding, condformat)

- **The input-guard work-around** in catexcel-condformat.ps1 (section 8): narrow and commented, but it changes how a safety rule behaves in one script - the lead or Chris should agree to it.
- **Index entries** are not added (the real index is the lead's); the mirror's PLACEHOLDER summaries should become section 5's.
- **CAPS term numbers**: Term 1 for the Spreadsheet lines and Term 4 for planning/troubleshooting, as cat-caps.md has them.
- **IEB "BETWEEN"** is read as the Between rule (condformat), plus RANDBETWEEN (Grade 10's more#random, recapped in rounding#rand).
- **The reader cannot see**: defined names (the Tickets check leans on the formula and #NAME?), the colours of conditional formats (the upload checks rule types, not colours), a Top/Bottom rule's rank (Top 3 and Top 10 are both `top10`), icon-set thresholds (so the exam's "edit the icon set's rules" is taught in prose, not marked). Useful additions: `xlsx.name` (name => refersTo), and conditionalFormat tests `rank`, `formula` (exact, `$` kept), `iconSet`.
- **No right-click, drag or "type without Enter" step**: the Name Box step types and presses Enter (real behaviour); the Less Than box's typing ends with Enter, which is OK in that box.
- **fx and the Name Box** are invisible to UI Automation in this Excel build; their targets were read off the pictures.
- The `name-tag` and `pi-slice` doodles carry IT wording ("Mickey Mouse", Pascal's ":0:2"); section 7 says what the CAT redraws should show.
- The rounding Savings/Marks pictures show the Formulas tab (left open by the help part) - harmless, but the ribbon differs from the Home-tab pictures before them.
- Subtotals did not come up.

### Writer B (if, sumif, sheets)

- **The `any` join's detail** repeats one line per alternative ("G4's formula
  is =IF(D4>="500",...)" 70 times for upCakeOrders' discount check). Pupils
  see the `fix`, teachers see the detail. An array_unique() in
  UploadRuleMet's 'any' branch (lib/uploadmark.php) would tidy it.
- **Not readable from an upload** (so in the task but unmarked): freeze
  panes, sheet protection, locked cells, custom views, window arrangement.
  An `xlsx.sheet` test for `frozen` (sheetView/pane state="frozen",
  topLeftCell) and `protected` (sheetProtection) would let `sheets` mark
  them - both are plain XML in the sheet part.
- **Quotes**: Barber (if, reserved), Caleb Carr (sumif - the bank files it
  under Neil Gaiman's image; credited to Carr), Susan Ward (sheets). None has
  a portrait in public/assets/quotes: `/assets/quotes/anonymous.svg`, as
  Grade 10 did. All three recorded in quotes-taken.txt.
- **Glossary overlap**: `absolute reference` is writer A's term; I did not
  Gloss it. `criterion`/`COUNTIF` are cattheory11's rows.
- **Shift+F11 / +**: the lesson says + inserts after the sheet you are on and
  Shift+F11 / Insert Sheet before it (Excel 365's behaviour as I know it; not
  captured in the VM). entering#sheets (Grade 10) says "+ after the last tab
  (or Shift+F11)" - slightly different; worth one look.
- **The CAPS overview line** ("basic computational thinking (building
  blocks)") has no term number - section 3 uses 'overview'; change to what
  caps.php expects.
- **Copied kit**: catexcel11b-kit.ps1 duplicates catexcel12-kit.ps1 (renamed
  class). If the lead prefers one kit, mine can dot-source theirs once theirs
  is final - I copied rather than depend on a file another writer was still
  changing.
- Linking graphs (CAPS T3) and paste-link are writer C's `graphs`; printing
  the sheets is C's `printoptions` - linked as "the next lesson" in prose,
  not by anchor.

### Writer C (printoptions, graphs, importing)

- **xlsx.pageSetup** subject wanted (orientation, fitToWidth/fitToHeight,
  scale, printGridlines, printHeadings, rowBreaks, print area and print
  titles from the defined names) - with it printoptions could have a marked
  upload. Also **defined names** in general.
- **Chart elements**: xlsx.chart reads type and title only - axis titles,
  data labels (and showPercent), legend position, gridlines and the series
  count would let graphs mark everything it asks for. A chart sheet
  (xl/chartsheets) is not read at all.
- **Tables / structured references**: an imported table makes pupils'
  formulas take many forms (TillSales[Amount]); a "formula refers to the
  same cells" test (Jev, or a reference resolver) would beat value +
  hasFormula.
- No **docx chart** reading: a linked chart in Word cannot be uploaded and
  marked.
- Simulations lack a drag step (dragging a page break, the chart range
  outline) - taught in prose.
- Facts I am reasonably but not fully sure of: Word pasting an Excel chart
  **linked** by default (seen in this VM; the PowerPoint lesson does not say
  which is default); Excel's Advanced Filter re-filling its boxes from the
  sheet's Criteria/Extract names (seen in af-2); that a hidden object (Selection
  Pane eye) does not print.
- The starter files' document properties show the VM account's name as
  creator / last modified by (as the Grade 10 files do) - setting
  Application.UserName did not change it.
- Quotes: Brian Clark (printoptions), Aaron Koblin (graphs, reserved), Matt
  Mullenweg (importing) - recorded in quotes-taken.txt; none has a portrait
  in public/assets/quotes, so `anonymous.svg`.
- Subtotals were not touched (Grade 12).

## Glossary rows (merged into content/cattheory10/glossary.php, 9 October 2026)

### Writer A

For `content/cattheory10/glossary.php`, the catexcel section, grade 11. None
of these is in the glossary yet (checked: no absolute, mixed, Name Manager,
AutoFill Options, ROUND, POWER, LARGE, SMALL, RAND, circular reference,
Function Arguments, conditional formatting, data bars, colour scale, icon
set). Each definition is word for word the Gloss() text. Already in the
glossary and only linked, not Gloss()ed: range name, relative reference,
fill handle, AutoFill (Grade 10 rows).

```php
    // ---- catexcel Grade 11 (writer A: absolute, rounding, condformat) ----
    ['absolute reference', 11, true, 'absolute', 'dollar', 'A cell reference with a $ in front of the column letter and the row number, such as $B$2. It stays exactly the same when the formula is copied anywhere.', ['course' => 'catexcel', 'also' => ['absolute references', 'absolute cell reference', 'absolute cell referencing']]],
    ['mixed reference', 11, true, 'absolute', 'mixed', 'A cell reference with a $ in front of only the column letter ($B2) or only the row number (B$2), so that only that part stays fixed when the formula is copied.', ['course' => 'catexcel', 'also' => ['mixed references']]],
    ['Name Manager', 11, true, 'absolute', 'names', 'The dialog box (Formulas > Defined Names > Name Manager, or Ctrl+F3) that lists every name in a workbook, with the cell or range each one refers to, and lets you make, edit and delete names.', ['course' => 'catexcel']],
    ['AutoFill Options', 11, true, 'absolute', 'autofill', 'The small button that appears after you fill cells with the fill handle. Its list lets you change what was filled - Copy Cells, Fill Series, Fill Formatting Only or Fill Without Formatting.', ['course' => 'catexcel', 'also' => ['AutoFill Options button']]],
    ['ROUND', 11, true, 'rounding', 'round', 'A function that rounds a number to a number of decimal places and keeps the rounded value: =ROUND(number, num_digits). =ROUND(333.333,2) gives 333.33.', ['course' => 'catexcel', 'also' => ['ROUND function']]],
    ['POWER', 11, true, 'rounding', 'power', 'A function that raises a number to a power: =POWER(number, power). =POWER(2,3) is 2 x 2 x 2 = 8, the same as =2^3.', ['course' => 'catexcel', 'also' => ['POWER function']]],
    ['LARGE', 11, true, 'rounding', 'largesmall', 'A function that gives the k-th largest value in a range: =LARGE(B4:B15,2) is the second highest. LARGE(range,1) is the same as MAX.', ['course' => 'catexcel', 'also' => ['LARGE function']]],
    ['SMALL', 11, true, 'rounding', 'largesmall', 'A function that gives the k-th smallest value in a range: =SMALL(B4:B15,2) is the second lowest. SMALL(range,1) is the same as MIN.', ['course' => 'catexcel', 'also' => ['SMALL function']]],
    ['RAND', 11, true, 'rounding', 'rand', 'A function that gives a random decimal number from 0 up to (but not including) 1: =RAND(). It picks a new one every time the sheet recalculates.', ['course' => 'catexcel', 'also' => ['RAND function']]],
    ['circular reference', 11, true, 'rounding', 'circular', 'A formula that refers to its own cell, directly or through other cells - such as =SUM(B5:B10) typed in B10. Excel cannot work it out, warns you, and shows 0.', ['course' => 'catexcel', 'also' => ['circular references']]],
    ['Function Arguments', 11, true, 'rounding', 'help', 'The dialog box (from fx, Insert Function) with one box for each part of a function, what each part means, and the answer so far.', ['course' => 'catexcel', 'also' => ['Function Arguments box', 'Function Arguments dialog box']]],
    ['conditional formatting', 11, true, 'condformat', 'what', 'Formatting (a fill, a font colour, data bars, colours or icons) that Excel applies to a cell only when the cell meets a rule - such as "less than 50" - and changes by itself when the value changes.', ['course' => 'catexcel']],
    ['data bars', 11, true, 'condformat', 'bars', 'Conditional formatting that draws a coloured bar inside each cell, as long as the value is big compared with the others - like a small bar chart in the cells.', ['course' => 'catexcel', 'also' => ['data bar']]],
    ['colour scale', 11, true, 'condformat', 'bars', 'Conditional formatting that fills each cell with a colour from a range of two or three colours, by its value - such as green for the highest, yellow in the middle, red for the lowest.', ['course' => 'catexcel', 'also' => ['colour scales', 'color scale', 'color scales']]],
    ['icon set', 11, true, 'condformat', 'bars', 'Conditional formatting that puts a small icon in each cell - arrows, traffic lights, ratings - chosen by where the value falls compared with the others.', ['course' => 'catexcel', 'also' => ['icon sets']]],
```

### Writer B

Already in content/cattheory10/glossary.php, Gloss()ed with that row's
definition and not added: `COUNTIF` (cattheory11), `criterion`
(cattheory11). `absolute reference` is writer A's (lesson `absolute`) - I
link to absolute#dollar instead of Gloss()ing it.

```php
    // ---- catexcel Grade 11 (writer B: if, sumif, sheets) -----------------
    ['condition', 11, true, 'if', 'decisions', 'A question in a formula that is either TRUE or FALSE, made with a relational operator - such as B4>=50 (is the mark 50 or more?).', ['course' => 'catexcel', 'also' => ['conditions']]],
    ['IF function', 11, true, 'if', 'if', 'A function that tests a condition and shows one answer when it is TRUE and another when it is FALSE: =IF(condition, value_if_true, value_if_false).', ['course' => 'catexcel', 'also' => ['IF']]],
    ['arguments', 11, true, 'if', 'if', 'The values a function works with, typed inside its brackets and separated by commas. IF has three: the condition, the value if true and the value if false.', ['course' => 'catexcel', 'also' => ['argument']]],
    ['SUMIF', 11, true, 'sumif', 'sumif', 'A function that adds up only the values whose row meets a condition: =SUMIF(range, criteria, sum_range) checks the range and adds the matching cells of the sum_range.', ['course' => 'catexcel']],
    ['sheet reference', 11, true, 'sheets', 'linking', 'A cell reference to a cell on another sheet: the sheet\'s name, an exclamation mark and the cell, such as =\'Term 1\'!B4. The quotes are needed when the name has a space.', ['course' => 'catexcel', 'also' => ['sheet references']]],
    ['locked cell', 11, true, 'sheets', 'protect', 'A cell that cannot be changed once its sheet is protected. Every cell is locked until you untick Locked (Format Cells > Protection) - so unlock the input cells before protecting.', ['course' => 'catexcel', 'also' => ['locked cells']]],
    ['custom view', 11, true, 'sheets', 'windows', 'A saved set of view and print settings for a workbook - which columns and rows are hidden, the zoom, the filter and the print settings - that you can show again from View > Custom Views.', ['course' => 'catexcel', 'also' => ['custom views']]],
```

### Writer C

Already in content/cattheory10/glossary.php, so Gloss()ed but NOT added:
`CSV`, `delimiter`, `importing`, `Exporting`, `Page break` (catword).

```php
    // ---- catexcel - Excel, Grade 11 (writer C) -------------------------
    ['Scale to Fit', 11, true, 'printoptions', 'scale', 'The Page Layout tab\'s settings that shrink (or grow) the printed sheet: Width and Height set how many pages across and down it may use, and Scale sets the size as a percentage. The sheet itself does not change.', ['course' => 'catexcel']],
    ['Print Area', 11, true, 'printoptions', 'area', 'The cells you choose to print (Page Layout > Print Area > Set Print Area). Only they print, until the print area is cleared.', ['course' => 'catexcel', 'also' => ['print areas']]],
    ['Selection Pane', 11, true, 'printoptions', 'arrange', 'A list of every picture, shape and chart on the sheet, top layer first. Click a name to select it, drag it to change its layer, or click the eye to hide or show it.', ['course' => 'catexcel']],
    ['data series', 11, true, 'graphs', 'elements', 'One set of numbers drawn on a chart, all in the same colour - such as the bread sold in each month. Its name, from its heading, appears in the legend.', ['course' => 'catexcel', 'also' => ['series']]],
    ['chart sheet', 11, true, 'graphs', 'move', 'A sheet that holds only one chart, filling the whole sheet, with no cells. Move Chart > New sheet makes one; its tab has the name you give it.', ['course' => 'catexcel', 'also' => ['chart sheets']]],
    ['custom list', 11, true, 'importing', 'advsort', 'A list that sets an order of its own for sorting (and AutoFill) - such as Mon, Tue, Wed or Jan, Feb, Mar - instead of A to Z.', ['course' => 'catexcel', 'also' => ['custom lists']]],
    ['criteria range', 11, true, 'importing', 'advfilter', 'Cells that hold the conditions for an advanced filter: the column headings, copied exactly, with the conditions under them. Conditions on the same row must all be met (AND); conditions on different rows are alternatives (OR).', ['course' => 'catexcel']],
```

## CAPS lines (merged into content/catexcel/caps.php; B's "overview" term made 2)

### Writer A

Wording from cat-caps.md section 3, Grade 11 Term 1, Solution Development:
Spreadsheet (and Term 4's planning and troubleshooting where the lesson
leans on it).

```php
        'absolute' => [
            [11, 1, 'Spreadsheets: absolute cell referencing'],
            [11, 1, 'Spreadsheets: reinforce Grade 10 - cell ranges and range names'],
            [11, 4, 'Spreadsheets: plan and design for scenarios; problem solving; troubleshooting'],
        ],
        'rounding' => [
            [11, 1, 'Spreadsheets: functions - ROUND, SMALL, LARGE, POWER'],
            [11, 1, 'Spreadsheets: rounding off numbers, and the difference between rounding and formatting'],
            [11, 1, 'Spreadsheets: interpret error indicators - circular reference'],
            [11, 1, 'Spreadsheets: using help features'],
        ],
        'condformat' => [
            [11, 1, 'Spreadsheets: conditional formatting'],
            [11, 4, 'Spreadsheets: troubleshooting'],
        ],
```

(The term numbers follow cat-caps.md: all four of these Spreadsheet lines
are Grade 11 Term 1; "plan and design for scenarios ... troubleshooting" is
the Term 4 line. If the lead keeps one Term 4 line per course, keep it on
`importing`, writer C's closing scenario, and drop it here.)

### Writer B

```php
        'if' => [
            [11, 2, 'Spreadsheets: relational operators including their use in simple IF functions; simple IF'],
            [11, 'overview', 'Spreadsheets: basic computational thinking (building blocks)'],
            [11, 4, 'Spreadsheets: plan and design your own documents for specific scenarios; problem solving; troubleshooting'],
        ],
        'sumif' => [
            [11, 2, 'Spreadsheets: COUNTIF, SUMIF'],
            [11, 4, 'Spreadsheets: problem solving; troubleshooting'],
        ],
        'sheets' => [
            [11, 3, 'Spreadsheets: work with sheets (move, copy, delete, insert, headings, protect, gridlines, freeze panes)'],
            [11, 3, 'Spreadsheets: linking cells, formulas between sheets'],
            [11, 4, 'Spreadsheets: plan and design your own documents for specific scenarios and inquiries'],
        ],
```

(The overview line has no term; use whatever the lead uses for Grade 11's
"basic computational thinking" - I put 'overview'. "Linking ... graphs" from
the same Term 3 line is writer C's `graphs`.)

### Writer C

```php
'printoptions' => [
    [11, 3, 'Spreadsheets: print options (page breaks, titles, scale to fit, print gridlines, print area)'],
    [11, 4, 'Spreadsheets: plan and design your own documents for specific scenarios and inquiries; problem solving; troubleshooting'],
],
'graphs' => [
    [11, 2, 'Spreadsheets: charts/graphs - create, format, edit: meaningful titles and labels, gridlines, legends, options appropriate to the type; integration with Word (adding or linking a chart to a word processing or presentation document)'],
    [11, 3, 'Spreadsheets: linking cells, formulas between sheets, and graphs (linking graphs)'],
    [11, 4, 'Word processing: integration with spreadsheet (paste options, linking)'],
],
'importing' => [
    [11, 3, 'Spreadsheets: import/export data'],
    [11, 4, 'Spreadsheets: reinforce Grades 10-11; plan and design your own documents for specific scenarios and inquiries; integration; problem solving; troubleshooting'],
],
```

## SAGs lines (merged into content/catexcel/sags.php)

### Writer A

```php
        'absolute' => [
            [11, 'P3', 'absolute cell referencing'],
            [11, 'P3', 'AutoFill options'],
        ],
        'rounding' => [
            [11, 'P3', 'rounding off vs formatting'],
            [11, 'P3', 'formulas: ROUND, SMALL, LARGE, POWER, RAND'],
            [11, 'P3', 'error indicator: circular reference'],
        ],
        'condformat' => [
            [11, 'P3', 'conditional formatting (the Between rule for BETWEEN)'],
        ],
```

### Writer B

```php
        'if' => [
            [11, 'P3', 'formulas: simple IF; relational operators inside IF'],
        ],
        'sumif' => [
            [11, 'P3', 'formulas: COUNTIF, COUNTA, COUNTBLANK, SUMIF'],
        ],
        'sheets' => [
            [11, 'P3', 'worksheets: move, copy, delete, linking cells and formulas'],
            [11, 'P3', 'view: custom views; new window, arrange all, freeze panes, split, hide, switch windows'],
        ],
```

### Writer C

```php
'printoptions' => [
    [11, 'P3', 'printing with print area, scaling, entire workbook'],
    [11, 'P3', 'page layout - scale to fit, sheet options, arrange'],
],
'graphs' => [
    [11, 'P3', 'charts: doughnut, line, area; meaningful titles and labels, gridlines, legends; options appropriate to the chart type'],
],
'importing' => [
    [11, 'P3', 'data - get & transform (import/export), advanced sort and filter'],
],
```

## Index entries (merged into content/catexcel/index.php)

### Writer A

```php
    'absolute'     => ['number' => 10, 'grade' => 11, 'chapter' => 'Absolute references and named ranges', 'title' => 'Absolute references and range names', 'summary' => 'Why a copied formula goes wrong, absolute and mixed references with $ and F4, a name for one cell and the Name Manager, a percentage of a total, and the AutoFill Options button (IEB).'],
    'rounding'     => ['number' => 11, 'grade' => 11, 'chapter' => 'Rounding and more functions', 'title' => 'ROUND, POWER, LARGE and SMALL', 'summary' => 'Rounding against formatting, ROUND, POWER, LARGE and SMALL, RAND (IEB), finding and fixing a circular reference, and getting help on a function.'],
    'condformat'   => ['number' => 12, 'grade' => 11, 'chapter' => 'Conditional formatting', 'title' => 'Conditional formatting', 'summary' => 'Highlight rules, a rule from a cell, duplicates, the top and bottom, data bars, colour scales and icon sets, and managing and clearing rules.'],
```

### Writer B

```php
    'if'           => ['number' => 13, 'grade' => 11, 'chapter' => 'IF', 'title' => 'The IF function', 'summary' => 'Planning a decision, IF with words, numbers, "" and calculations, comparing with a cell, the Function Arguments box, and finding and fixing IF mistakes.'],
    'sumif'        => ['number' => 14, 'grade' => 11, 'chapter' => 'COUNTIF and SUMIF', 'title' => 'COUNTIF and SUMIF', 'summary' => 'Counting and adding up only the rows that match, in a summary table filled down with absolute ranges, a percentage of the whole, checking a summary, and COUNTA and COUNTBLANK (IEB).'],
    'sheets'       => ['number' => 15, 'grade' => 11, 'chapter' => 'Sheets, windows and printing', 'title' => 'Working with sheets and windows', 'summary' => 'Inserting, deleting, moving and copying sheets, linking cells between sheets, Freeze Panes, protecting a sheet (CAPS), and windows, splits and custom views (IEB).'],
```

### Writer C

```php
    'printoptions' => ['number' => 16, 'grade' => 11, 'chapter' => 'Sheets, windows and printing', 'title' => 'Print options', 'summary' => 'Fitting a sheet onto paper with Scale to Fit, printing gridlines and headings, choosing what prints, page breaks, print areas and titles (CAPS), arranging pictures and charts (IEB), and a print plan for fixing printouts.'],
    'graphs'       => ['number' => 17, 'grade' => 11, 'chapter' => 'Charts and linking', 'title' => 'More charts, and linking them', 'summary' => 'Meaningful titles, axis titles, labels, gridlines and legends, Switch Row/Column, Select Data, Change Chart Type and Move Chart, line, area and doughnut charts (IEB), and a chart linked into Word (CAPS).'],
    'importing'    => ['number' => 18, 'grade' => 11, 'chapter' => 'Sorting, filtering and importing', 'title' => 'Importing, exporting, and advanced sorting and filtering', 'summary' => 'CSV files, importing with Get & Transform, exporting as CSV and PDF, advanced sorting and filtering (IEB), and planning and troubleshooting a sheet for a scenario.'],
```

## Video rows (merged into cat-videos/README.md)

### Writer A

```
| catexcel-10.1 | Absolute references and F4 | 7 | [catexcel-absolute.md](catexcel-absolute.md) |
| catexcel-10.2 | Range names and a percentage of a total | 6 | [catexcel-absolute.md](catexcel-absolute.md) |
| catexcel-11.1 | Rounding is not formatting: the ROUND function | 7 | [catexcel-rounding.md](catexcel-rounding.md) |
| catexcel-11.2 | Circular references and Excel's help | 6 | [catexcel-rounding.md](catexcel-rounding.md) |
| catexcel-12.1 | Highlight Cells Rules and a pass mark in a cell | 7 | [catexcel-condformat.md](catexcel-condformat.md) |
| catexcel-12.2 | Data bars, colour scales, icon sets and the Rules Manager | 7 | [catexcel-condformat.md](catexcel-condformat.md) |
```

Six videos, about 40 minutes.

### Writer B

```
| catexcel-13.1 | The IF function: one question, two answers | 8 | [catexcel-if.md](catexcel-if.md) |
| catexcel-13.2 | When IF goes wrong | 6 | [catexcel-if.md](catexcel-if.md) |
| catexcel-14.1 | COUNTIF and SUMIF: a summary table | 8 | [catexcel-sumif.md](catexcel-sumif.md) |
| catexcel-15.1 | Sheets: copy, link and freeze | 8 | [catexcel-sheets.md](catexcel-sheets.md) |
| catexcel-15.2 | Protect a sheet, and two windows at once | 6 | [catexcel-sheets.md](catexcel-sheets.md) |
```

`// VIDEO` comments are in the lessons (13.1 before simPassFail, 13.2 after
the mistakes figures, 14.1 before simCountArea, 15.1 before simCopySheet,
15.2 before simProtect).

### Writer C

```
| catexcel-16.1 | Making a sheet fit the page | 8 | [catexcel-printoptions.md](catexcel-printoptions.md) |
| catexcel-16.2 | Breaks, print areas and a print plan | 7 | [catexcel-printoptions.md](catexcel-printoptions.md) |
| catexcel-17.1 | A chart that says what it means | 8 | [catexcel-graphs.md](catexcel-graphs.md) |
| catexcel-17.2 | A chart in Word that keeps up | 6 | [catexcel-graphs.md](catexcel-graphs.md) |
| catexcel-18.1 | Bringing a CSV file into Excel | 8 | [catexcel-importing.md](catexcel-importing.md) |
| catexcel-18.2 | Sorting by your own order, filtering by your own rules | 7 | [catexcel-importing.md](catexcel-importing.md) |
```
