# CAT Databases lesson 15: Related tables, subforms and a main form - videos

Lesson: `AIPascalCourse/content/catdb/mainform.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on the Kasi Netball League's
database (`tools/sim-screens/catdb-mainform.ps1` builds it). CAT marker style
with Clicky; yellow highlighter; no title bar.

## catdb-15.1 Related tables and a join (about 7 min)

**Goes:** after the study block (first of two comments).
**The pupil can afterwards:** name the primary and foreign key of a one-to-many
relationship; create it in the Relationships window; query two tables through
the join; use a lookup to another table.
**Thumbnail:** tag `CAT · DATABASES`, title "One team, *many* players"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. A coach typed 14 times.
2. **Keys (0:40-2:00).** TeamID in both tables; one-to-many; same data type.
   > Board: a team card with strings to its player cards.
3. **The Relationships window (2:00-4:00).** Database Tools > Relationships; add
   tables; drag TeamID onto TeamID; Edit Relationships; 1 and ∞.
4. **A join query (4:00-5:40).** Both tables; TeamName and Goals; >=10; no join -
   56 rows.
5. **A lookup to a table (5:40-6:30).** The Lookup Wizard's other choice.
6. **Sign-off.**

## catdb-15.2 A subform and a main form (IEB) (about 6 min)

**Goes:** after catdb-15.1.
**The pupil can afterwards:** set referential integrity and the cascade options;
make a form with a subform; make a main form with Command Button Wizard buttons
and set it as the Display Form.
**Thumbnail:** tag `CAT · DATABASES`, title "A *menu* for your database"

### Scenes

1. **Referential integrity (0:00-1:30).** No team 7; no deleting a team with
   players; Cascade Update; Cascade Delete - careful.
2. **Form with subform (1:30-3:30).** Form Wizard, both tables, by tblTeams,
   Form with subform(s), Datasheet.
3. **Main form (3:30-5:30).** Form Design, title, buttons (Form Operations >
   Open Form); File > Options > Current Database > Display Form.
4. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| keys, one-to-many | `#keys` |
| the Relationships window | `#window` |
| a join query; a lookup to a table | `#join` |
| referential integrity (IEB) | `#integrity` |
| subform (IEB) | `#subform` |
| main form (IEB) | `#mainform` |
