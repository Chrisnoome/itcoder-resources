# CAT Databases lesson 5: Input masks and validation - videos

Lesson: `AIPascalCourse/content/catdb/validation.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Phumlani's bursary
applications (`tools/sim-screens/catdb-validation.ps1` builds them). CAT marker
style with Clicky; yellow highlighter; no title bar.

## catdb-05.1 Input masks and validation rules (about 9 min)

**Goes:** after the study block.
**The pupil can afterwards:** match each validation check to its Access tool;
set Required and Indexed (No Duplicates); read and write input masks with the
mask characters; write validation rules with signs, And, Or, Between, In and
Date(), and good validation text; test rules; tell validation from verification.
**Thumbnail:** tag `CAT · DATABASES`, title "Stop bad data at the *door*"

### Scenes

1. **Hook (0:00-0:50).** Hi, and welcome to BestLessons. Day one of the bursary
   applications: a 12-digit ID number, Grade 13, an average of 745, a date next
   year. Garbage in, garbage out.
   > Board: the bouncer at the door of the table.
2. **The checks and their tools (0:50-2:00).** Presence - Required; type - data
   type; length - Field Size; format - input mask; range - validation rule;
   uniqueness - Indexed (No Duplicates). Allowed is not right: verification.
3. **Required and Indexed (2:00-3:00).** IDNumber unique without being the key.
4. **Input masks (3:00-5:30).** 0, 9, #, L, ?, A, a, &, C, >, <, \, "", !; the
   examples - ID number, cell number, postal code, 11A; the three parts; the
   Input Mask Wizard's American phone shape.
   > Screen: the mask typed; a new record showing ___ ___ ____.
5. **Validation rules and text (5:30-7:40).** Between 8 And 12; >=0 And <=100;
   <=Date(); In ("Food", "Crafts"); dates in #; text in quotes; kind validation
   text.
   > Screen: 13 typed in Grade - the message; OK; Esc.
6. **Testing and old data (7:40-8:30).** Just inside, just outside; "test the
   existing data"; an empty field passes - add Required.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the checks and their tools; verification | `#recap` |
| Required, Indexed | `#unique` |
| input mask characters and examples | `#mask` |
| validation rules and text | `#rule` |
| testing, old data, mask vs rule | `#testing` |
