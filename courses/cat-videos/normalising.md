# CAT 12 lesson 24: Normalising a table - videos

Lesson: `content/cattheory12/normalising.php`. Two videos: one big table and
what goes wrong (for everyone), and normalising step by step (inside the IEB
section, taught to all). Board in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words on screen being
talked about. Use the lesson's own data (orders 501-503, Sipho Dlamini,
Anika Botha, mince pie R28.50, water R10.00) so it matches the norm-1nf,
norm-2nf and norm-3nf drawings. One optional screen recording in Access in
the VM. Everything below is in the lesson text.

## cat12-24.1 One big table, and what goes wrong (about 6 min)

**Goes:** after section `#keys` - the comment after `t24ForeignKey`.
**The pupil can afterwards:** explain data redundancy and the update, insert and delete anomalies, and how primary and foreign keys let a table be split.
**Thumbnail:** tag `CAT · DATABASES`, title "One table to *ruin* them all"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mrs Khumalo's tuck shop spreadsheet: the pie price changed in 131 rows out of 140; Sipho spelt three ways; the samoosa price deleted.
   > Board: a long table, three trouble spots circled; Clicky holding its head.
2. **Words first (0:40-1:30).** Record, field, primary key - a number, not a name.
   > Board: the four-row table; highlighter on the OrderID column.
3. **Redundancy (1:30-2:30).** The same fact typed again and again: PupilName, ProductName, Price. Space, typing mistakes, copies that disagree.
   > Board: the photocopier doodle; the repeated cells highlighted.
4. **Three anomalies (2:30-4:00).** Update (two prices for one pie), insert (no vetkoek until someone orders one), delete (the samoosas vanish).
   > Board: three panels, one per anomaly.
5. **Splitting with keys (4:00-5:40).** Pupils, products, orders, order items. P17 in the orders table points to Sipho: a foreign key. One-to-many relationship. Change the price once. Nothing lost - keys join it back.
   > Board: four small tables with a line from PupilID to PupilID; highlighter on "foreign key".
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| record, field, primary key; the big table | `#oneTable` |
| redundancy; the three anomalies | `#problems` |
| four tables, foreign key, relationship, normalisation | `#keys` |

## cat12-24.2 Normalising the tuck shop orders, step by step (about 8 min)

**Goes:** after the 3NF material - the comment after `g24WhichForm`, inside the IEB section.
**The pupil can afterwards:** take a table from unnormalised to 3NF, write each table in one line with keys marked, and set up the tables in Access with referential integrity.
**Thumbnail:** tag `CAT · DATABASES`, title "The key, the *whole* key..."

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Three rules, always in the same order - and the table is right without guessing.
   > Board: three steps of a staircase labelled 1NF, 2NF, 3NF; Clicky at the bottom.
2. **Writing a table in one line (0:30-1:10).** tblPupils (PupilID, PupilName, Grade): key underlined, foreign keys with *.
   > Board: the line written out, PupilID underlined.
3. **1NF (1:10-2:50).** The paper form with a list of products: a repeating group. One value per field, no repeating groups, a primary key. Order 501 becomes two rows; OrderID plus ProductID is the composite key.
   > Board: the norm-1nf-order drawing; then the composite-key-pair drawing.
4. **2NF (2:50-4:30).** Whole key or part? The three-row table: OrderID only, ProductID only, both. Three tables; tblOrderItems links them.
   > Board: the norm-2nf-order drawing, fields sliding to their tables.
5. **3NF (4:30-5:50).** The order decides the pupil, the pupil decides the name. tblPupils moves out; PupilID stays as a foreign key. "The key, the whole key, and nothing but the key."
   > Board: the norm-3nf-order drawing; the saying in marker, one phrase highlighted per step.
6. **In Access (5:50-7:40).** Normalise on paper; create tables and data types; primary keys; Relationships; drag PupilID; Enforce Referential Integrity; capture pupils and products first. What referential integrity refuses.
   > Screen (optional): Access in the VM - Database Tools, Relationships, drag, the Edit Relationships box with the tick. Otherwise board: the ref-integrity-orphans drawing.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| one-line table design; repeating group; 1NF; composite key | `#norm1` |
| whole key or part; 2NF; the link table | `#norm2` |
| non-key decides non-key; 3NF; the saying | `#norm3` |
| Access steps; referential integrity | `#pat` |
