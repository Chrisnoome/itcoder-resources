# CAT Databases lesson 10: Advanced queries - videos

Lesson: `AIPascalCourse/content/catdb/advqueries.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Ekasi Skills College's
database (`tools/sim-screens/catdb-advqueries.ps1` builds it). CAT marker style
with Clicky; yellow highlighter; no title bar.

## catdb-10.1 Wildcards, Is Null and dates (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** use Like with *, ?, # and [ ]; Not Like; Is Null and
Is Not Null; date ranges with Between and # signs (year first); Date(); Year(),
Month() and Day() in a Field box with a criterion; recall the row rule.
**Thumbnail:** tag `CAT · DATABASES`, title "Find what you *can't* spell out"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. "Every surname starting
   with M"; "no e-mail yet"; "born in 2007" - questions an exact match cannot ask.
2. **Recap (0:40-1:20).** AND across, OR down, NOT.
   > Board: the row-rule grid.
3. **Wildcards (1:20-3:30).** Like "M*", "*la", "*admin*", "C?le", "ES10##",
   "[A-C]*"; Access adds Like and quotes; Not Like; text dates with Like.
   > Screen: Like "M*" under Surname; Run - six students.
4. **Is Null (3:30-4:40).** Null is not 0 or a space; Is Null, Is Not Null; why ="" fails.
   > Board: an empty box with "nothing at all" written beside it.
5. **Dates (4:40-6:00).** #2026/03/04#; Between; Date(), Date()-30, >Date().
6. **Year() (6:00-7:20).** Year([DOB]) in a Field box, 2007 below, Show off;
   Month(); Year(Date()).
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| AND, OR, NOT | `#recap` |
| wildcards, Like | `#wild` |
| Is Null | `#null` |
| date ranges, Date() | `#dates` |
| Year(), Month(), Day() | `#year` |
