# CAT Databases lesson 12: Totals queries - videos

Lesson: `AIPascalCourse/content/catdb/totals.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Botha's Bakery's week of
sales (`tools/sim-screens/catdb-totals.ps1` builds it). CAT marker style with
Clicky; yellow highlighter; no title bar.

## catdb-12.1 Totals queries: Group By and Sum (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** turn on the Total row; Group By with Sum, Avg,
Count, Min, Max; name and sort a total; use Where before grouping and a
criterion on a total after; (IEB) make a crosstab with the wizard.
**Thumbnail:** tag `CAT · DATABASES`, title "Thirty rows, three *answers*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Thirty sales; Mr Botha
   wants three answers.
2. **Group, then add up (0:40-1:40).**
   > Board: records dropping into Bread, Cakes and Savoury buckets; a total on each.
3. **The Total row (1:40-3:30).** Totals; Group By; Sum; one row per group;
   every extra Group By splits the groups.
   > Screen: qryByCategory from empty.
4. **Names and sorting (3:30-4:30).** TotalSales: Amount; Count the key; Descending.
5. **Criteria (4:30-6:20).** Where "Cakes" (before); >=50 under the Sum (after).
   > Board: the sieve before the buckets, and whole buckets thrown out after.
6. **IEB: crosstab (6:20-7:40).** The Crosstab Query Wizard: rows Branch,
   columns Category, value Sum of Amount.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| group, then add up | `#idea` |
| the Total row and functions | `#totalrow` |
| naming and sorting | `#name` |
| Where and criteria on totals | `#criteria` |
| crosstab (IEB) | `#crosstab` |
