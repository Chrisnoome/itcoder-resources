# CAT Spreadsheets lesson 24: Subtotals, outlines and pivot tables - videos

Lesson: `AIPascalCourse/content/catexcel/summaries.php` (Grade 12). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365, a window 1860
wide so the Data tab's Outline group shows its names), on the lesson's own
workbook: Phumlani's Market Day sales (sheet Sales; Day1-Day3 and Total for
Consolidate) - `tools/sim-screens/catexcel-summaries.ps1` builds it. Board
scenes in the CAT marker style with Clicky (brand/cat-art-style.md); yellow
highlighter on any words being talked about.

## catexcel-24.1 Subtotals and the outline (about 7 min)

**Goes:** after the prose block "Data > Subtotal" (section `#subtotal`),
before the simulation `simSubtotal`.
**The pupil can afterwards:** add subtotals to a sorted list, read and use
the outline levels, explain why the totals are SUBTOTAL and not SUM, and take
the subtotals away.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "A total for *every* stall"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Fifteen sales on
   Market Day; the principal wants four numbers and a total.
   > Board: a long receipt shrinking to four lines and a total.
2. **Sort first (0:40-1:30).** A total goes wherever the stall changes - so
   the stalls must be together. Data > Sort A to Z on the Stall column.
   > Board: a jumbled list with three "Cakes Total" lines crossed out.
3. **Data > Subtotal (1:30-3:20).** At each change in Stall, Sum, Amount (R);
   Page break between groups; Summary below data. OK.
   > Screen: s-1, the Subtotal box (s-2), the result (s-3).
4. **The outline (3:20-4:40).** Buttons 1, 2, 3; - and + per group. Level 2
   is the principal's summary.
   > Screen: s-4 (level 2), s-5 (level 1); highlighter on the 2 button.
5. **SUBTOTAL, not SUM (4:40-6:00).** =SUBTOTAL(9,D3:D6); 9 is SUM, 1
   AVERAGE, 2 COUNT, 4 MAX, 5 MIN. The grand total skips the stall totals -
   SUM would double it.
   > Screen: Show Formulas (s-6). Board: R3 420 against R6 840.
6. **Remove All, Group (6:00-6:40).** Remove All in the Subtotal box; Group
   and Ungroup by hand.
   > Screen: s-7, g-2.
7. **Sign-off (6:40-7:10).**

### In the text

| Video point | Lesson anchor |
|---|---|
| sort by the group first | `#sortfirst` |
| the Subtotal box and its settings, Remove All | `#subtotal` |
| levels 1, 2, 3, - and + | `#outline` |
| SUBTOTAL's function numbers; why not SUM | `#function` |
| Group and Ungroup | `#group` |

## catexcel-24.2 A pivot table in five clicks (about 6 min) - IEB

**Goes:** after the prose block "Pivot tables" (section `#pivot`), before the
simulation `simPivot`.
**The pupil can afterwards:** make a pivot table from a list, place fields in
Rows, Values and Filters, change Sum to Count, refresh it, and make a pivot
chart.
**Thumbnail:** tag `CAT · SPREADSHEETS · IEB`, title "*Pivot* tables"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. The same summary as
   subtotals - without sorting, and without touching the list.
2. **Insert > PivotTable (0:30-1:40).** Click in the list; the box; New
   Worksheet; OK. An empty pivot table and the Fields pane.
   > Screen: p-0, p-1, p-2.
3. **Tick Stall, tick Amount (1:40-2:50).** Text to Rows, numbers to
   Values: Sum of Amount per stall and a Grand Total.
   > Screen: p-3, p-4; highlighter on the four areas.
4. **The four areas (2:50-4:00).** Rows, Columns, Values, Filters: Grade to
   Filters, 12 only. Value Field Settings for Count.
   > Screen: p-5.
5. **Refresh and a pivot chart (4:00-5:20).** A pivot table works from a copy:
   Refresh after the list changes. PivotChart follows the table.
   > Screen: p-6.
6. **Sign-off (5:20-5:50).**

### In the text

| Video point | Lesson anchor |
|---|---|
| Insert > PivotTable, the Fields pane, Rows and Values | `#pivot` |
| the four areas, Filters, Value Field Settings | `#pivot` |
| Refresh, PivotChart | `#pivot` |

Consolidate (IEB) is one dialog box, pictured in the lesson; no video.
