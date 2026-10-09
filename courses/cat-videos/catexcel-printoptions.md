# CAT Spreadsheets lesson 16: Print options - videos

Lesson: `AIPascalCourse/content/catexcel/printoptions.php` (Grade 11). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Ms Naidoo's Grade 11 mark book (sheets 11A, 11B, 11C
and Averages) - `tools/sim-screens/catexcel-printoptions.ps1` builds it, and
the pupils' MarkBook11.xlsx is the same book. Board scenes in the CAT marker
style with Clicky (brand/cat-art-style.md); yellow highlighter on any words
being talked about. Never print to paper in the recording: use Microsoft
Print to PDF, or stop at the preview.

## catexcel-16.1 Making a sheet fit the page (about 8 min)

**Goes:** after the prose block "Scale to Fit" (section `#scale`), before the
simulation `simFitWidth`.
**The pupil can afterwards:** read a Page Break Preview, fit a wide sheet to
one page's width with Scale to Fit, choose the right scaling in File > Print,
print gridlines and headings, and choose what prints.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "One page *wide*, please"

### Scenes

1. **Hook (0:00-0:45).** Hi, and welcome to BestLessons. Thabo printed Ms
   Naidoo's mark book for the principal - and got a pile of pages, the last
   columns alone with no names next to them. Excel did what it was told.
   > Board: Clicky buried under a pile of pages, one holding a single column.
2. **Look first (0:45-1:45).** View > Page Break Preview on 11A: Page 1 and
   Page 2 side by side, the blue line running down between the columns. Page
   2 is the last columns for every pupil, without the names. Back to Normal.
   > Screen: the View tab, Page Break Preview; highlighter on "Page 2".
3. **Scale to Fit (1:45-3:30).** Page Layout tab > Scale to Fit: Width, Height,
   Scale. Width > 1 page; Height stays Automatic; Scale now shows the size
   Excel chose. The dashed lines show the new pages. The sheet itself has not
   changed size.
   > Screen: the Width list open, 1 page; highlighter on the Scale box.
4. **The same in File > Print (3:30-4:45).** The scaling list: Fit Sheet on
   One Page, Fit All Columns on One Page, Fit All Rows on One Page, Custom
   Scaling Options. Why Fit Sheet on One Page on a long list gives tiny text -
   zoom the preview to show it.
   > Board: a magnifying glass over a page of tiny marks.
5. **Gridlines and headings on paper (4:45-6:00).** Page Layout > Sheet
   Options: View is the screen, Print is the paper. Tick Gridlines Print and
   Headings Print; the preview shows lines and A, B, C / 1, 2, 3. Headings
   help someone check a formula on paper.
   > Screen: the two tick boxes; then the preview.
6. **What to print (6:00-7:15).** File > Print > the first Settings list:
   Print Active Sheets, Print Entire Workbook, Print Selection. Every sheet
   has its own setup.
   > Screen: the list open; choose Print Entire Workbook; the page count changes.
7. **Sign-off (7:15-7:45).** Look, fit, choose - then look again before you print.

### In the text

| Video point | Lesson anchor |
|---|---|
| Page Break Preview of the wide sheet | `#recap` (figure, quiz `q16Pages`) |
| Width, Height, Scale; Width 1 page | `#scale` |
| the File > Print scaling list; tiny text | `#scale` (callout, `w16TinyText`) |
| Gridlines and Headings: View and Print | `#sheetoptions` |
| Active Sheets, Entire Workbook, Selection; each sheet's own setup | `#workbook` |

## catexcel-16.2 Breaks, print areas and a print plan (about 7 min)

**Goes:** after the prose block "A print plan, and fixing printouts"
(section `#plan`), before the reveal `r16CtrlEnd`.
**The pupil can afterwards:** put a page break in the right place, set a
print area and print titles, and follow a print plan to fix a bad printout.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Why did it print *six* pages?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. One note typed far
   down a sheet, and the printout grows two empty pages. Today: where pages
   end, and why.
2. **A page break (0:40-2:00).** 11A: click A39 (column A!), Page Layout >
   Breaks > Insert Page Break. Page Break Preview: the summary on page 2; a
   solid line (ours) and a dashed line (Excel's). Then the mistake: D39 gives
   two breaks - Reset All Page Breaks.
   > Screen: the Breaks menu; Page Break Preview; highlighter on the solid line.
3. **Print Area (2:00-3:30).** (CAPS in the lesson; show it to everyone.)
   11B's note in P48 makes extra pages. Ctrl+End finds it. Select A1:M42,
   Print Area > Set Print Area; Page Break Preview shows only the area.
   Clear Print Area; Ignore Print Area in File > Print.
4. **Print Titles (3:30-4:30).** Page Layout > Print Titles: Rows to repeat
   at top $2:$2; Columns to repeat at left for wide sheets. The Sheet tab
   gathers print area, titles, gridlines and headings.
   > Screen: the Page Setup dialog box, Sheet tab; highlighter on each box.
5. **Arrange, briefly (4:30-5:30).** (IEB in the lesson.) The Averages sheet:
   the speech bubble behind the chart - Bring Forward; the Selection Pane and
   its eyes (a hidden object does not print); Align, Group, Rotate.
   > Screen: Shape Format > Arrange; the Selection Pane.
6. **The print plan (5:30-6:40).** The nine steps in order: look, cut, orient,
   fit, titles, breaks, gridlines and headers, what to print, look again -
   and print to PDF first.
   > Board: a checklist ticked off by Clicky, a PDF before the printer.
7. **Sign-off (6:40-7:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| Insert Page Break above (and left of) the selected cell; solid and dashed lines; Reset All | `#breaks` (quiz `q16BreakCell`) |
| Print Area, Clear, Ignore Print Area; a stray note; Ctrl+End | `#area`, `#plan` |
| Print Titles $2:$2, Columns to repeat at left; the Sheet tab | `#area` |
| Bring Forward, Selection Pane, Align, Group, Rotate | `#arrange` |
| the print plan and the troubleshooting table | `#plan` |
