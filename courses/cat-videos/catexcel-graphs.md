# CAT Spreadsheets lesson 17: More charts, and linking them - videos

Lesson: `AIPascalCourse/content/catexcel/graphs.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365 and Word 365),
on the lesson's own workbook: Botha's Bakery's sales per month, January to
June 2026 (sheets Sales and Report) - `tools/sim-screens/catexcel-graphs.ps1`
builds it (BakeryCharts.xlsx). Board scenes in the CAT marker style with
Clicky (brand/cat-art-style.md); yellow highlighter on any words being
talked about. In Word, never save during the recording (Word's save has hung
in the VM): close the report without saving.

## catexcel-17.1 A chart that says what it means (about 8 min)

**Goes:** after the prose block "Titles, labels, gridlines and the legend"
(section `#elements`), before the simulation `simAxisTitle`.
**The pupil can afterwards:** give a chart a meaningful title and axis
titles, choose data labels, gridlines and the legend's place, swap rows and
columns, add a series with Select Data, change the chart type and move the
chart to another sheet.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Chart Title is *not* a title"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha needs a loan
   for a second oven, and the bank wants his sales on one page. Excel's
   first try says "Chart Title" - and the bank manager has no idea what the
   numbers count.
   > Board: a bank manager squinting at a chart labelled "Chart Title".
2. **Every element has a job (0:40-2:30).** Title: what, who, when. Axis
   titles: the unit up the side, the months along the bottom. Data labels:
   when there are few bars. Gridlines: major and minor. Legend: Right, Top,
   Bottom - or none.
   > Screen: Chart Design > Add Chart Element > Axis Titles > Primary
   > Vertical; type Number sold, Enter. Then the + button beside the chart.
3. **Switch Row/Column (2:30-3:40).** Same numbers, a different question:
   months along the bottom (how each item grew) or items along the bottom
   (which sold most each month). Switch it back.
4. **Select Data (3:40-5:00).** The Select Data Source box: Chart data range
   =Sales!$A$1:$C$7 becomes $A$1:$D$7 - Muffins arrive. Add, Edit, Remove;
   the axis labels. The quick way: drag the blue outline on the sheet.
   > Screen: highlighter on the Chart data range box.
5. **Change Chart Type (5:00-6:00).** Growth over time is a line's job:
   Change Chart Type > Line > OK. The titles stay.
6. **Options for the type (6:00-6:50).** Line with Markers; a column's Gap
   Width in the Format pane; a pie's Percentage labels.
7. **Move Chart (6:50-7:40).** New sheet makes a chart sheet (no cells);
   Object in > Report puts it among the cells of the Report sheet. It still
   draws from Sales.
8. **Sign-off (7:40-8:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| Excel's first try and what it lacks | `#recap` (`s17Missing`) |
| each element's job; Add Chart Element and the + button | `#elements` |
| Switch Row/Column; Select Data and the chart data range | `#data` |
| Change Chart Type to Line | `#type` |
| markers, gap width, percentages | `#options` |
| Move Chart: New sheet or Object in | `#move` |

## catexcel-17.2 A chart in Word that keeps up (about 6 min)

**Goes:** after the prose block "A chart in Word: pasted or linked" (section
`#link`, CAPS), before the simulation `simLinkChart`.
**The pupil can afterwards:** paste a chart into Word embedded, linked or as
a picture, keep a linked chart up to date, and paste-link cells.
**Thumbnail:** tag `CAT · INTEGRATION`, title "Change it in Excel - *watch Word*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. June's numbers were
   estimates. When the real ones come in, does Mr Botha make the chart all
   over again?
   > Board: Excel and Word holding the ends of a chain.
2. **Copy and the Paste Options (0:30-2:00).** Click the chart's edge, Ctrl+C.
   In Word, Home > the arrow under Paste: the five pictures - Use Destination
   Theme / Keep Source Formatting, each with Embed Workbook or Link Data; and
   Picture. Point at each to show its name.
   > Screen: Word's Paste menu open; highlighter on Keep Source Formatting & Link Data.
3. **Linked (2:00-3:30).** Choose Keep Source Formatting & Link Data. Change
   June's bread to 3 000 on the Sales sheet: the chart in Word follows (Chart
   Design > Refresh Data if it does not). Embedded would not; a picture never.
4. **Keep the link alive (3:30-4:40).** The link is to the saved file: save
   before linking; rename or move the file and it breaks (File > Info > Edit
   Links to Files). An e-mailed report cannot update on someone else's
   computer.
   > Board: Clicky cutting the chain with scissors marked "rename".
5. **Paste Link for cells (4:40-5:30).** Copy A1:D8; Word's Paste menu > Link
   & Keep Source Formatting (or Paste Special > Paste link).
6. **Sign-off (5:30-6:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| the five Paste Options and what each gives | `#link` (the table) |
| a linked chart updates; Refresh Data | `#link` (figure `wd-3`) |
| save first; renaming breaks the link; Edit Links to Files | `#link` (`q17BrokenLink`) |
| linked or embedded for an e-mailed report | `#link` (`w17LinkOrEmbed`) |
| Paste Link for cells | `#link` |

Line, area and doughnut charts (IEB, `#kinds`) are short and shown by their
figures; no video of their own.
