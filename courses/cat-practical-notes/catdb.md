# catdb - Databases (Access), Grades 11 and 12: writer's notes

9 October 2026. The 16 lessons of `catdb`, written to
[../cat-practical-writing.md](../cat-practical-writing.md) ("Grades 11 and 12")
and [../cat-theory-writing.md](../cat-theory-writing.md). Model: the pilot's
`content/catpilot/access.php` (upChess). Concepts recapped and linked from CAT
Theory: cattheory11 `processingdata` (#totable, #database), `whenwrong`
(#validation, #verification), `usability` (#forms); cattheory12 `normalising`
(#keys); cattheory10 `apps` (#office).

## 1. Lessons written

| # | Lesson | Gr | Marks CAPS / IEB | Simulations | Upload (checks, marks) | Boards |
|---|---|---|---|---|---|---|
| 1 | `whatfor` - What a database is for | 11 | 52 / 52 | practice + 4 | upLibrary (6, 6) |  |
| 2 | `tables` - Tables, fields and data types | 11 | 42 / 44 | 3 | upBakery (8, 8) | IEB: Large Number and Calculated fields |
| 3 | `records` - Working with records | 11 | 44 / 46 | 5 | upMarket (6, 6) | IEB: The datasheet's look |
| 4 | `properties` - Field properties | 11 | 40 / 42 | 4 | upCakeOrders (8, 8) | IEB: Rich Text and Append Only |
| 5 | `validation` - Input masks and validation | 11 | 40 / 40 | 3 | upBursary (8, 8) |  |
| 6 | `forms` - Forms | 11 | 40 / 42 | 3 | upStokvel (4, 4) | IEB: The tab order |
| 7 | `queries` - Queries | 11 | 40 / 42 | 2 | upTour (5, 8) | IEB: SQL View |
| 8 | `criteria` - Criteria that do more | 11 | 42 / 40 | 2 | upAthletics (4, 8) | CAPS: A calculated field |
| 9 | `reports` - Reports | 11 | 40 / 40 | 2 | upTourReport (4, 6) |  |
| 10 | `advqueries` - Advanced queries | 12 | 46 / 46 | 3 | upCollege (4, 8) |  |
| 11 | `calculated` - Calculated fields | 12 | 40 / 40 | 1 | upShuttle (4, 8) |  |
| 12 | `totals` - Totals queries | 12 | 42 / 46 | 1 | upSales (4, 8) | IEB: A crosstab query |
| 13 | `groupreports` - Grouped reports | 12 | 40 / 40 | 1 | upSalesReport (2, 4) |  |
| 14 | `answers` - Reports that answer a question | 12 | 46 / 40 | 1 | upCollegeReport (3, 6) | CAPS: Changing a report's source |
| 15 | `mainform` - Related tables, subforms and a main form | 12 | 40 / 52 | 1 | upLeague (4, 6) | IEB: Referential integrity, subforms and a main form |
| 16 | `scenario` - Designing for a scenario | 12 | 44 / 44 | 1 | upFunRun (11, 16) |  |
| | **Total** | | **678 / 696** | 37 + practice | | |

## 2. Glossary rows - merged

Merged into `content/cattheory10/glossary.php` (9 October 2026) as the section
`// ---- catdb - Databases (Access), Grades 11 and 12 (practical course) ----`;
`caption` went in as **field caption** (catword already has "caption").
Each definition is identical to its Gloss() text. Terms that already exist were
Gloss()ed and show the existing row: database (database, 10), data type (data type, 11), primary key (Primary key, 12), filter (filter, 11), CSV (CSV, 10), importing (importing, 11), Validation (Validation, 11), Verification (Verification, 11), control (controls, 10), query (query, 11), criterion (criterion, 11), Wildcard (Wildcard, 10), foreign key (Foreign key, 12), Relationship (Relationship, 12), Referential integrity (Referential integrity, 12).
Two notes: **primary key**, **foreign key**, **Relationship** and
**Referential integrity** are Grade 12 rows (cattheory12 normalising) but catdb
teaches the primary key in Grade 11 (lessons 2 and 15) - consider making
"Primary key" a Grade 11 row. **control** matches the Grade 10 GUI row
"controls" (the parts of a GUI) - fine for a form's controls, but a
database-specific row could be added.

```php
    ['database object', 11, true, 'whatfor', 'objects', 'One of the parts saved in an Access database: a table, a query, a form or a report. Each has its own name and its own icon in the Navigation Pane.', ['course' => 'catdb']],
    ['form', 11, true, 'whatfor', 'objects', 'In a database, a screen for entering, changing and viewing data - usually one record at a time, with a label and a box for each field.', ['course' => 'catdb']],
    ['database report', 11, true, 'whatfor', 'objects', 'An Access object that lays the data out for printing or for a PDF, with headings, groups and totals such as a count or a sum.', ['course' => 'catdb']],
    ['Datasheet View', 11, true, 'whatfor', 'window', 'The view of a table or query that shows its data in rows and columns, like a spreadsheet - one record in each row.', ['course' => 'catdb']],
    ['table', 11, true, 'tables', 'plan', 'In a database, the object that stores the data: one row for each record and one column for each field. Every query, form and report gets its data from a table.', ['course' => 'catdb']],
    ['Design View', 11, true, 'tables', 'design', 'The view in which an object is built or changed. A table\'s Design View lists its fields with their data types, and shows the selected field\'s properties below.', ['course' => 'catdb']],
    ['expression', 11, true, 'tables', 'calc', 'A calculation or test Access works out - for example [Price]*12, or >=8 And <=12. Field names in it go in square brackets.', ['course' => 'catdb']],
    ['field property', 11, true, 'properties', 'pane', 'A setting of one field in Design View - such as Field Size, Format, Default Value, Required or Caption - that decides what may be stored in it and how it is shown.', ['course' => 'catdb']],
    ['field caption', 11, true, 'properties', 'caption', 'A field property: the friendly name shown as the field\'s column heading in Datasheet View and as its label on a new form or report. The field\'s real name does not change.', ['course' => 'catdb']],
    ['lookup field', 11, true, 'properties', 'lookup', 'A field filled in by picking a value from a drop-down list - a list typed in, or the values of a field in another table - instead of typing it.', ['course' => 'catdb']],
    ['input mask', 11, true, 'validation', 'mask', 'A pattern that controls what may be typed in a field, character by character - for example 0000000000000 for exactly 13 digits. It shows the empty places while you type.', ['course' => 'catdb']],
    ['validation rule', 11, true, 'validation', 'rule', 'A rule a field\'s value must pass before Access accepts it, such as >=8 And <=12.', ['course' => 'catdb']],
    ['validation text', 11, true, 'validation', 'rule', 'The message Access shows when a value breaks a field\'s validation rule - it should say what is allowed.', ['course' => 'catdb']],
    ['form section', 11, true, 'forms', 'views', 'One band of a form in Design View: the Form Header at the top (the title), the Detail in the middle (the fields of each record), and the Form Footer at the bottom.', ['course' => 'catdb']],
    ['Command Button Wizard', 11, true, 'forms', 'controls', 'The wizard that starts when you draw a button on a form: you choose what it does - go to the next record, add a new record, close the form - and what it shows.', ['course' => 'catdb']],
    ['tab order', 11, true, 'forms', 'taborder', 'The order in which the cursor moves from box to box on a form when Tab is pressed. Set it in Design View with Tab Order.', ['course' => 'catdb']],
    ['select query', 11, true, 'queries', 'what', 'The usual kind of query: it selects fields and records from tables and shows them, without changing any data.', ['course' => 'catdb']],
    ['design grid', 11, true, 'queries', 'design', 'The bottom half of a query in Design View: one column for each field, with the rows Field, Table, Sort, Show, Criteria and or.', ['course' => 'catdb']],
    ['SQL', 11, true, 'queries', 'sql', 'Structured Query Language: the language databases use for queries. Access writes it for every query you design; SQL View shows it.', ['course' => 'catdb']],
    ['AND', 11, true, 'criteria', 'and', 'In a query, joins criteria so that a record must pass every one of them. Criteria on the same row of the design grid are joined with AND.', ['course' => 'catdb']],
    ['OR', 11, true, 'criteria', 'or', 'In a query, joins criteria so that a record passes if it meets any one of them. Criteria on different rows of the design grid (Criteria, or) are joined with OR.', ['course' => 'catdb']],
    ['calculated field', 11, true, 'criteria', 'calc', 'A column a query works out for every record from other fields, typed in the Field row as a name, a colon and an expression - such as Balance: 2500-[Deposit].', ['course' => 'catdb']],
    ['report section', 11, true, 'reports', 'sections', 'One band of a report in Design View: Report Header and Report Footer (once, at the start and the end), Page Header and Page Footer (on every page), and the Detail (once for each record).', ['course' => 'catdb']],
    ['Like', 12, true, 'advqueries', 'wild', 'The query operator that compares text with a pattern containing wildcards, such as Like "M*" (starts with M) or Like "*son" (ends with son).', ['course' => 'catdb']],
    ['Null', 12, true, 'advqueries', 'null', 'In a database, an empty field: no value at all - not 0, not a space. Found with the criterion Is Null.', ['course' => 'catdb']],
    ['totals query', 12, true, 'totals', 'idea', 'A query that puts records into groups (Group By) and works out a total for each group - Sum, Avg, Count, Min or Max - giving one row per group.', ['course' => 'catdb']],
    ['crosstab query', 12, true, 'totals', 'crosstab', 'A totals query that groups on two fields at once - one down the side as rows, one across the top as columns - with a total in every cell where they meet, like a spreadsheet table.', ['course' => 'catdb']],
    ['grouped report', 12, true, 'groupreports', 'what', 'A report whose records are printed in groups - all the records of one branch, then the next - each group with its own header and a footer that can hold its totals.', ['course' => 'catdb']],
    ['group header', 12, true, 'groupreports', 'what', 'The section of a grouped report that prints once at the start of each group - usually the group\'s name, such as the branch.', ['course' => 'catdb']],
    ['group footer', 12, true, 'groupreports', 'what', 'The section of a grouped report that prints once at the end of each group - where the group\'s totals go, such as =Sum([Amount]).', ['course' => 'catdb']],
    ['record source', 12, true, 'answers', 'source', 'The table or query a form or report gets its records from - set in its Property Sheet, on the Data tab.', ['course' => 'catdb']],
    ['join', 12, true, 'mainform', 'join', 'In a query, the link between two tables on their matching fields, so that each record of one is shown with its matching record of the other.', ['course' => 'catdb']],
    ['subform', 12, true, 'mainform', 'subform', 'A form inside another form: the main form shows one record (a team) and the subform shows its related records from another table (the team\'s players).', ['course' => 'catdb']],
    ['main form', 12, true, 'mainform', 'mainform', 'A form used as a menu (a switchboard): a title and buttons that open the database\'s other forms and reports, so that users never need the Navigation Pane.', ['course' => 'catdb']],
```

## 3. CAPS lines

In `content/catdb/caps.php` (written; `[grade, term, what]`).

## 4. SAGs lines

In `content/catdb/sags.php` (written; topic `P4` = Appendix M 8.4).

## 5. Drawings

**Used** (existing drawings; the CAT versions where they exist are used by the
site automatically): access-blueprint (whatfor, tables, scenario), access-shield
(whatfor), access-copy (whatfor), access-phone-zero (tables), access-sieve
(records, queries, criteria, advqueries), access-too-long and access-required
(properties), validation-bouncer (validation), gui-good-form (forms),
access-parameter (queries, calculated), access-count (reports, scenario),
cat-joker-wildcard and access-null and access-us-date (advqueries),
access-round-half and access-glue (calculated), access-buckets and
access-where-having (totals, groupreports), cat-sorted-vs-grouped
(groupreports), access-related (mainform). Need CAT redraws (no cat- version
yet): access-shield, access-copy, access-too-long, access-required,
access-parameter, access-null, access-us-date, access-round-half, access-glue,
access-where-having, access-related.

**Wished for** (up to 3 a lesson, one line each):
- whatfor: Ms Naidoo's shoebox of index cards overflowing, Clicky pulling one out; the four objects as four characters - a filing cabinet (table), a question mark with a sieve (query), a clipboard (form), a printed page (report).
- tables: Clicky with a ruler drawing a grid over a crossed-out price list; a phone number "082" losing its 0 as it falls into a Number box.
- records: a pencil hovering at a row's edge ("not saved yet"); Clicky with scissors trimming "Craftss" back to "Crafts".
- properties: Clicky stuffing a 300-letter name into a box labelled Field Size 40; a calendar page that fills itself in (Default Value Date()).
- validation: a mask with holes shaped 000 000 0000 laid over a phone number; the bouncer reading a validation rule off a clipboard.
- forms: Gogo squinting at a seven-column datasheet, then smiling at one big, clear form.
- queries: three questions (which fields? which records? which order?) as three sieves stacked.
- criteria: a two-row design grid with "AND across, OR down" arrows; Red and Blue house shirts with "And" crossed out and "Or" written in.
- reports: a page stack with its five bands highlighted (Report Header, Page Header, Detail, Page Footer, Report Footer).
- advqueries: Clicky holding a joker card over a list of surnames starting with M; an empty box labelled "Null - not 0, not a space".
- calculated: a calculator wearing a query-grid hat ("Cost: [KM]*6.25").
- totals: records dropping into three buckets (Bread, Cakes, Savoury), each with a total tag.
- groupreports: a report as bundles tied with string, each with a heading strip and a totals strip.
- answers: a question split into four sticky notes - records, fields, order, totals.
- mainform: a team card with strings to its player cards (one-to-many); a menu board with three big buttons.
- scenario: a numbered task list with a tick per instruction; Clicky with a magnifying glass over the record counter.

## 6. Unsure, gaps and platform notes

- **Forms and reports cannot be marked** - mdbtools cannot read
  MSysAccessStorage. Lessons 6 (forms), 9 (reports), 13 (grouped reports), 14
  (answers), 15 (subform, main form) and 16 teach and simulate them, and the
  uploads mark only what can be read: records entered through the form, the
  queries a report is built on (13: a totals query that checks the report's group
  totals), the relationship and join. Each prompt says so. Suggested: an
  `accdb.object` subject (form/report names and kinds from MSysObjects, Type
  -32768 / -32764), which mdbtools CAN read - the reader skips them today.
- **Not markable either:** a lookup's Row Source / Limit To List, Text Align,
  Rich Text / Append Only (they are in mdb-prop's `props` but no rule reads them),
  datasheet display settings (gridlines, alternate rows), sort/filter saved on a
  table, exports (PDF, Excel), Word Merge.
- **Validation rules as exact rules:** `UploadRuleProblems()` reads a
  `validationRule` with `AccdbExprKey($rule)` and no field, so a field-level rule
  such as `>=8 And <=12` or `Between 8 And 12` is flagged "the marker cannot read"
  (bin/check-uploads would fail the block), although `UploadAccdbFieldMet()`
  compares it fine by text. Passing the check's own `field` to AccdbExprKey()
  there would fix it (lib/uploadmark.php ~line 204). Until then the rule checks
  in lessons 5 and 16 are Jev checks with an `extract`.
- **Jev on the rule checks (proved locally, Jev live):** Bursary-done 8/8
  (p 0.97-0.98 on the three rules). On the starter, Grade p 0.08 and Average p 0.11
  (no), but Applied (a date rule) p 0.17 - just above JEV_NO (0.15), so a pupil
  who left it empty waits for Claude, who will say no. Several phrasings tried;
  Jev stays unsure about an empty date rule.
- **Ties in sorted query results:** `accdb.queryResult` compares rows in order when
  the model sorts. Pupil and model are both re-run in SQLite on the same data, so
  ties come out in the same order; Access's own order for ties can differ (my
  answers check accepts "same rows, ties in another order"). qryBigDeposits (sort
  on Deposit, many equal deposits) relies on this.
- **Avg of a Currency field:** Access returns it as Currency, rounded to 4
  decimals (271.6667); the marker's SQLite re-run keeps every decimal
  (271.666666...). Pupil and model are both re-run, so marking is not affected,
  but a check against Access's own numbers differs in the 5th decimal. A crosstab
  query is refused by the marker ("only re-runs select queries") - the IEB's
  crosstab is taught but not in an upload.
- **mdbtools vs Access, proved:** every model query of the done copies re-run by
  the marker returns what real Access returned (Like, Is Null, Year(), date
  ranges, Round(), &, totals with HAVING, a join) - see the checks.
- **Grade placement:** AND/OR/NOT are taught to both boards in Grade 11 lesson 8
  (CAPS Grade 11; the SAGs name them in Grade 12 but "selection criteria" is Grade
  11) and recapped in lesson 10. The calculated field is a CAPS section in lesson 8
  (CAPS Grade 11 "calculations in queries") and taught to both in lesson 11.
  Relationships are taught to both in lesson 15 (only the IEB's papers relate
  tables; CAPS's PAT can need them); referential integrity, subforms and the main
  form are an IEB section. Changing a report's source is a CAPS section (14).
  Tab order, SQL View, Large Number/Calculated type, Rich Text/Append Only, the
  datasheet's look and crosstab queries are IEB sections.
- **Glossary:** Primary key / Foreign key / Relationship / Referential integrity
  exist as Grade 12 rows (cattheory12); catdb uses "Primary key" from Grade 11.
  `control` resolves to the Grade 10 GUI row "controls".
- **Quotes:** the quote bank's database-flavoured quotes are all used by other
  CAT lessons; the ones chosen are unused but only loosely on topic (Denning,
  Susan Ward, Rushkoff, Steve Jobs x2, Wilensky, Mossberg, Carmack, "ASCII stupid
  question", Ryan Holiday x2, Christina Baker Kline, "Unknown" (big data), Tae Yoo,
  Adam Osborne, Torvalds). Portraits exist only for Rushkoff, Jobs, Carmack and
  Torvalds; the rest use the stand-in.
- **VM learnt (for the next writer):** see section 7.

## 7. Screen scripts written and run (the CAT VM, real Access 365)

`tools/sim-screens/catdb-<lesson>.ps1`, one per lesson, run with
`pwsh -File vm-shots.ps1 catdb-<lesson>`; shared helpers in
`work/catdb-kit.ps1` (SnapDb, MakeForm, MakeReportFull, MakeGroupedReport,
AddSubform, MakeMenuForm, GridType, QueryAnswers, Publish, CloseDb, NoFieldList,
NoPropertySheet, NoGroupPane ...) and the data builders `work/catdb-data.ps1`
(lessons 1-3), `catdb-data11.ps1` (4-9), `catdb-data12.ps1` (10-16). Pictures
are cropped to 1262 x 831 (below the title bar) by `work/catdb-crop.py`, which
also prints every marked place in per cent for the simulations.

Learnt in the VM (for the next writer):
- **Access remembers its panes** from one run to the next (Field List, Property
  Sheet, Group, Sort and Total): close them before a picture (NoFieldList,
  NoPropertySheet). RunCommand 205 is not Sorting and Grouping in Access 365, so
  the Group, Sort and Total pane stays in some report pictures.
- **A modal box hangs the job** until the 10-minute timeout, with no pictures
  back: a report whose text box has no field in its new record source asks for a
  parameter in Print Preview (fixed: qryOwing has Course).
- **CreateForm crashed Access** (RPC_E_SERVERFAULT) when a DAO object was still
  held, and when called in the visible Access after the Relationships window:
  read field types first and let go (GC), and build forms while Access is hidden.
- **Pressing Create > Report through UI Automation crashed Access**; the report
  is opened in Layout View instead.
- **Posted characters do not change a data type** in the table design grid (it
  stays Short Text), and the Data Type list does not open: the finished table
  made by DDL is shown instead (tblBakers, t-8), and the key is shown on
  tblProducts (k-1, k-2).
- **SQL View draws nothing** in PrintWindow: the SQL is shown as text in the
  lesson, not as a picture.
- **The validation message box** did not appear for a posted Tab or Enter: the
  simulation now has the pupil press Tab, and the next step says what Access
  showed.
- Buttons whose names end in "..." (Tab Order..., Replace...) must be found by
  that full name.
- A text box for a Long Date needs about 3400 twips, or it shows ####.

## 8. Starter files made (real Access, in the VM; Google Drive copies in G:\My Drive\CAT\Access)

In `public/assets/practical/catdb/`: Library, Bakery, SpringMarket (+ LateStalls.csv),
CakeOrders, Bursary, Stokvel, Tour, Athletics, TourReport, College, Shuttle,
Sales, SalesReport, CollegeReport, League, FunRun (.accdb). Done-right copies in
`tests/uploads/catdb/*-done.accdb`, with Access's own query answers merged in
`tests/uploads/catdb/answers.json`. Never Enable Content on a database from
elsewhere - the lessons say so too.

## 9. Shared files edited (no hold was in place)

- `content/catdb/index.php` - the 16 lessons, grades 11 and 12, chapters.
- `content/cattheory10/glossary.php` - 34 rows in a catdb section.
- `lib/simulation.php` - `case 'access':` in SimulationPractice (3 steps,
  catdb-whatfor-p-1 / p-2).
- `courses/cat-videos/README.md` - 18 catdb video rows.
- Still for the lead: `lib/course.php` catdb row to `'status' => 'draft'`,
  `'glossaryFrom' => 'cattheory10'`, and `'grades' => 'Grades 11-12'` (it says
  10-12; neither board teaches databases in Grade 10).

## 10. Checks run (9 October 2026)

In a scratch copy of the repo with catdb as a draft course:
- `php -l` on all 18 files: clean. All 16 lessons render (no warnings).
- check-simulations: OK - 38 simulations, 70 steps. check-why: 109 of 109,
  none gives the answer away. check-lesson-contents, check-popup-spacing,
  check-lesson-links, check-figures (1557 figures), check-pictures (3 picture
  questions): OK. check-sags: every lesson has its SAGs and CAPS coverage.
  check-glossary: no catdb problems (its FAILs are other writers' rows whose
  lessons are not written yet).
- check-jev (all lessons, flags read): accepted - tables g2Types (caption),
  criteria s8NotRelay (options), totals t12Alias, scenario s16Notice c, forms
  q6TabOrder (the Tab Order caption just above; a recall question). Fixed:
  mainform g15Kinds why for books/publishers.
- **Uploads on the server** (`/tmp/catdbw`, removed after each run; lib/ and the
  marker copied there, nothing in /var/www): every starter 0, every done-right
  copy full marks - whatfor 6/6, tables 8/8, records 6/6, properties 8/8,
  validation 8/8 (3 Jev rule checks: done p 0.97-0.98; starter 0, 0 and Applied
  p 0.17 = pending for Claude), forms 4/4, queries 8/8, criteria 8/8, reports
  6/6, advqueries 8/8, calculated 8/8, totals 8/8, groupreports 4/4, answers
  6/6, mainform 6/6, scenario 16/16 (Age rule by Jev p 0.97; starter p 0.05).
- **Every model query re-run by the marker equals real Access** (row for row;
  ties in another order noted for qryBigDeposits and qryJuniors), except the
  two known: qryBranchByCategory (crosstab, refused by the marker - not in an
  upload) and qryCakesAvg (Access rounds Avg of Currency to 4 decimals).

## 11. Unfinished / for Chris

- Some report pictures show Access's Group, Sort and Total pane (it stays open
  between runs; RunCommand 205 does not close it in Access 365).
- Pictures opened from a reopened database show the yellow SECURITY WARNING bar
  (scenario queries, mainform): real, and the lessons say never to Enable
  Content on a database from elsewhere.
- A few cropped pictures in public/assets/sims/catdb are not used by any lesson
  (spares from the runs); they can be deleted.
- Forms, reports, the subform and the main form are taught and simulated but not
  marked (MSysAccessStorage) - see section 6.
