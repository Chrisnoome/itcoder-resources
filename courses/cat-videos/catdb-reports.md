# CAT Databases lesson 9: Reports - videos

Lesson: `AIPascalCourse/content/catdb/reports.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on the tour's database with
qryNotPaid (`tools/sim-screens/catdb-reports.ps1` builds it). CAT marker style
with Clicky; yellow highlighter; no title bar.

## catdb-09.1 A report on a query, with totals (about 9 min)

**Goes:** after the study block.
**The pupil can afterwards:** base a report on a query; make one with Report,
the Report Wizard (with Summary Options) and Report Design; use the four views;
place things in the five sections; add =Count(*) and =Sum() with labels; add
page numbers, the date and a title; use Landscape; print, save as PDF and export
to Excel; follow the order of work for a whole job; fix #Error and wide reports.
**Thumbnail:** tag `CAT · DATABASES`, title "From query to *report*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The principal wants the
   unpaid pupils on paper: heading, date, pages, totals.
2. **What a report is for (0:40-1:30).** For reading and printing; the record
   source; build the query first.
3. **Making one (1:30-3:40).** Create > Report on qryNotPaid; the Report Wizard
   with Summary Options (Sum of Deposit), Tabular, Portrait, the title.
   > Screen: both, start to finish.
4. **Views and sections (3:40-5:00).** Report View, Print Preview, Layout,
   Design; Report Header, Page Header, Detail, Page Footer, Report Footer.
   > Board: a page stack, each band highlighted in turn.
5. **Totals (5:00-6:30).** A text box in the Report Footer: =Count(*),
   =Sum([Deposit]); a label; Format Currency; Totals in Layout View.
6. **Finishing (6:30-7:20).** Page Numbers (Page N of M); Date and Time; Landscape.
7. **Out of Access (7:20-8:10).** Print Preview > PDF or XPS; External Data >
   Export > Excel.
8. **The whole job (8:10-8:50).** Plan, build, form, queries, reports, test;
   #Error and wide reports.
9. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what a report is for, record source | `#what` |
| Report, Report Wizard, Report Design | `#make` |
| views and sections | `#sections` |
| totals | `#calc` |
| page numbers, date, landscape | `#finish` |
| PDF, Excel | `#export` |
| the whole job, troubleshooting | `#scenario` |
