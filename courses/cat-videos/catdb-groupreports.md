# CAT Databases lesson 13: Grouped reports - videos

Lesson: `AIPascalCourse/content/catdb/groupreports.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Botha's Bakery's sales
(`tools/sim-screens/catdb-groupreports.ps1` builds the report). CAT marker style
with Clicky; yellow highlighter; no title bar.

## catdb-13.1 A grouped report with group totals (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** make a grouped report with the Report Wizard
(grouping level, sort, Summary Options, Summary Only); place things in the group
header and footer; add =Count(*), =Sum(), =Avg(), =Min(), =Max() with labels; use
the Group, Sort and Total pane; check a report's totals with a totals query.
**Thumbnail:** tag `CAT · DATABASES`, title "Every branch, its own *total*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The accountant wants the
   week branch by branch, each with its total.
2. **Seven sections (0:40-1:50).** Group Header, Detail, Group Footer inside the five.
   > Board: a page in bundles, each bundle with a heading strip and a totals strip.
3. **The wizard (1:50-4:00).** A grouping level; sort within groups; Summary
   Options (Sum; Detail and Summary vs Summary Only); Stepped; Finish.
   > Screen: the Report Wizard on tblSales, all the way.
4. **Group footer totals (4:00-5:40).** Text Box in the Branch Footer; =Count(*)
   with Sales:; =Sum([Amount]) with Branch total:; Currency; a field into the header.
5. **Group, Sort and Total (5:40-6:40).** Add a group; Add a sort; More - footer,
   keep together.
6. **Check it (6:40-7:30).** qryBranchTotals against the footers; #Error;
   the same total everywhere.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what a grouped report is | `#what` |
| grouping with the wizard | `#wizard` |
| totals in the group footer | `#footer` |
| Group, Sort and Total | `#pane` |
| checking the totals | `#check` |
