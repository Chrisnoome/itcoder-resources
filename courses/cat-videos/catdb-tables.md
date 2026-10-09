# CAT Databases lesson 2: Tables, fields and data types - videos

Lesson: `AIPascalCourse/content/catdb/tables.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Botha's Bakery's database
(`tools/sim-screens/catdb-tables.ps1` builds it). CAT marker style with Clicky;
yellow highlighter on words being talked about; no title bar.

## catdb-02.1 Building a table in Design View (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** plan a table with good field names; make it with
Create > Table Design; choose every data type the lesson lists; set the primary
key; save it; switch views; add, insert and delete fields; (IEB) make a
Calculated field.
**Thumbnail:** tag `CAT · DATABASES`, title "Build a *table* the right way"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha's prices are
   crossed out on the back of an order book. Before data goes in, someone
   builds the table - field by field.
   > Board: a crossed-out price list; Clicky with a ruler drawing a grid.
2. **Plan on paper (0:40-1:50).** One kind of thing per table; one fact per
   field; plain names, no spaces; an example for each field; never store what
   can be worked out.
   > Board: the plan table from the lesson, written in marker.
3. **Design View (1:50-3:20).** Create > Table Design; type BakerID; Tab; the
   Data Type; Description; Field Properties below.
   > Screen: exactly the simulation's steps: Create, Table Design, BakerID, AutoNumber.
4. **Data types (3:20-5:10).** Short Text vs Number (the phone number's 0),
   Long Text, Currency, Date/Time, AutoNumber, Yes/No, Hyperlink, Attachment,
   OLE Object; the Data Type list.
   > Screen: open the Data Type list on Price. Board: 082 losing its 0.
5. **The primary key (5:10-6:10).** Different in every record, never empty;
   AutoNumber; Primary Key button; a pupil number, not a name.
   > Screen: click Primary Key on BakerID; the key appears.
6. **Save, view, change (6:10-7:20).** Ctrl+S, the name tblBakers, the "no
   primary key" question; View to Datasheet View; Insert Rows, Delete Rows -
   deleting a field deletes its data.
7. **IEB: Large Number and Calculated (7:20-7:50).** DozenPrice = [Price]*12.
   > Screen: DozenPrice's Expression in Field Properties.
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| planning, field names | `#plan` |
| Create > Table Design, the grid | `#design` |
| data types | `#types` |
| the primary key | `#key` |
| saving, Datasheet View | `#save` |
| adding and deleting fields | `#change` |
| Large Number, Calculated (IEB) | `#calc` |
