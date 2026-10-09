# CAT Databases lesson 4: Field properties - videos

Lesson: `AIPascalCourse/content/catdb/properties.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM** (Access 365) on Botha's Bakery's cake orders
(`tools/sim-screens/catdb-properties.ps1` builds them). CAT marker style with
Clicky; yellow highlighter; no title bar.

## catdb-04.1 Field properties (about 8 min)

**Goes:** after the study block.
**The pupil can afterwards:** use the Field Properties pane; set Field Size,
Caption, Required, Default Value, Format, Decimal Places and Text Align; make a
lookup field with the Lookup Wizard and Limit To List; (IEB) Rich Text and
Append Only.
**Thumbnail:** tag `CAT · DATABASES`, title "Every field has *rules*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. tblOrders takes
   anything: a 300-letter name, no name, 1 000 candles. Properties fix that.
   > Board: Clicky stuffing a giant name into a small box.
2. **The pane (0:40-1:30).** Click a row, the properties change; General and
   Lookup tabs; F6; the blue help text.
3. **Field Size (1:30-2:40).** Short Text 40; Number sizes Byte, Integer, Long
   Integer, Double.
   > Screen: CustomerName 255 to 40; Candles to Byte.
4. **Caption and Required (2:40-3:50).** Customer name as the heading; the field
   name stays; Required Yes and the Null message.
5. **Default Value (3:50-4:40).** Date(); "Centurion"; only new records.
6. **Format, Decimal Places, Text Align (4:40-6:20).** dd mmm yyyy, dd-mmm-yy,
   Currency, >; display only, never the stored value (R19.50 shown as R20).
   > Screen: the datasheet before and after.
7. **A lookup list (6:20-7:30).** Lookup Wizard: type the values, Limit To List;
   the Lookup tab; the drop-down in the datasheet.
8. **IEB: Rich Text and Append Only (7:30-7:55).**
9. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the Field Properties pane | `#pane` |
| Field Size | `#size` |
| Caption, Required | `#caption` |
| Default Value | `#default` |
| Format, Decimal Places, Text Align | `#format` |
| the Lookup Wizard | `#lookup` |
| Rich Text, Append Only (IEB) | `#richtext` |
