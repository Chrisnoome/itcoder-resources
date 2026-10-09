# CAT Databases lesson 11: Calculated fields - videos

Lesson: `AIPascalCourse/content/catdb/calculated.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on the Durban shuttle's bookings
(`tools/sim-screens/catdb-calculated.ps1` builds them). CAT marker style with
Clicky; yellow highlighter; no title bar.

## catdb-11.1 Calculated fields in a query (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** write Name: expression with fields in [ ]; use the
order of the signs and brackets; build on another calculated field; Round();
join text with &; take a discount; format as Currency; use the Expression
Builder; work out an age; recognise Enter Parameter Value and #Error.
**Thumbnail:** tag `CAT · DATABASES`, title "Let the *query* do the sums"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. R6.25 a kilometre - and
   no price in the table, on purpose.
2. **Name: expression (0:40-2:20).** Cost: [KM]*6.25; the colon; brackets; nothing stored.
   > Screen: type it in an empty Field box; Run.
3. **One on another, Round (2:20-3:40).** PerPerson; Round(...,2); halves to even.
4. **Text with & (3:40-4:30).** FullName; the space in quotes; & not +.
   > Board: glue between two word-blocks.
5. **Format and the Builder (4:30-5:50).** Property Sheet > Format Currency; the
   Expression Builder.
6. **Dates and ages (5:50-6:50).** [DepartDate]-Date(); Int((Date()-[DOB])/365.25).
7. **When it goes wrong (6:50-7:40).** Enter Parameter Value; #Error; invalid syntax.
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Name: expression | `#make` |
| using one in the next, Round, discount | `#more` |
| joining text with & | `#text` |
| Format, the Builder | `#format` |
| dates and ages | `#dates` |
| errors | `#wrong` |
