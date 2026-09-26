# Course: SQL and databases (`sql`) - PLAN

**Status: plan, drafted 25 September 2026 from Chris's brief ("start
planning databases and sql - can caps and sags share?").** The course is
listed as `soon` in `CourseIndex()` (`lib/course.php`). Answer the
questions marked **Q** at the end and this file becomes the spec. Nothing
is built yet.

Already decided elsewhere (Chris, 24 September 2026): SQL is its own
course, not part of Pascal or Java. The IEB practical's Section A (SQL, 50
marks) and the CAPS Paper 1 Question 2 (database, 40 marks) belong here.
Exam references: [../ieb-practical-exam-analysis.md](../ieb-practical-exam-analysis.md)
§2 and [../caps-practical-exam-analysis.md](../caps-practical-exam-analysis.md)
(Question 2 section). Syllabus: [../sags-topic4-syllabus.md](../sags-topic4-syllabus.md)
§4.9-4.11 and [../caps-2024.md](../caps-2024.md) (Data and Information
Management; Grade 12 Term 1 SQL list).

## Can CAPS and the SAGs share? Yes - one course

The SQL language and the database theory are the same for both boards.
CAPS is **Access** only; the IEB gives **Access, Java DB or MySQL** (the
school chooses) and its memos accept each. The core SQL is identical in
all three; functions, dates, text joining and TOP differ
([../sql-dialects.md](../sql-dialects.md), tested 25 September 2026). So one course, with
the lesson badges and CAPS stream the Pascal course already uses
(`'badge'`, `'stream' => 'caps'`, platform.md "Stream-only lessons").
About three quarters of it is shared.

| | Shared (everyone) | IEB goes further | CAPS only |
|---|---|---|---|
| Concepts | data vs information, quality data, validation; field, record, table, keys (primary, alternate, foreign, composite); relationships, referential integrity, ERDs; DBMS; warehousing, mining, big data | NoSQL | - |
| Design | anomalies, redundancy, derived data, splitting tables (CAPS: "the concept of normalisation") | **formal 1NF-3NF**, partial and transitive dependencies (the SBA Normalisation test) | - |
| SQL | SELECT/WHERE/ORDER BY, LIKE, BETWEEN, IN, IS NULL, DISTINCT, TOP; calculated fields, string and date functions; aggregates, GROUP BY, HAVING; a join; INSERT, UPDATE, DELETE | subqueries, `NOT IN` / `LEFT JOIN ... IS NULL` for unmatched rows, LEFT/RIGHT JOIN, 3-table joins, `INSERT ... SELECT`, `RND` | `FORMAT(x, "Currency")`; user input glued into the SQL string (`"' + s + '"` or QuotedStr) |
| Code | - | none - SQL is typed into an answer sheet, no program | **SQL inside Delphi** (the SQL string in a given click event - pupils never write the TADOQuery code) and **data-aware code** (First/`while not Eof`/Next, `tbl['Field']`, Edit/Post, Insert, Delete, two tables linked by PK = FK) - taught in the Pascal course, linked from here |
| Exam | - | Section A guide (SQLBrowser, answer sheet, no alias unless told) | Question 2 guide (the Delphi project given, GUI provided) |

**Grades differ, content order doesn't.** The IEB starts SQL in Grade 10
(single table, INSERT/UPDATE/DELETE) and adds functions and GROUP BY in
Grade 11, multi-table in Grade 12. CAPS teaches database concepts and a
single table through code in Grade 11 Term 3 and all its SQL in Grade 12
Term 1. One lesson order (topic by topic) serves both; each lesson's SAGs
and CAPS syllabus boxes say which grade it is for on that board.

Where the boards name one idea differently (CAPS "the concept of
normalisation" vs IEB 1NF-3NF; CAPS "data-aware" vs IEB "no programmatic
connection"), teach it once with both names side by side
(content-voice-and-pedagogy.md §3).

## Decided (Chris, 25 September 2026)

- **Separate SQL lessons per dialect** - Access, MySQL, Java DB and
  SQLite. "They only have to work in one but can access and use the other
  lessons as well."
- **Marks:** CAPS pupils earn marks **only in the Access lessons**. IEB
  pupils **choose Java DB, MySQL or Access** (the IEB allows all three and
  supplies the data in all three) and earn marks in that set. **SQLite
  questions count for no one** - practice.
- **SQLite gets the same lessons**, and says plainly that SQLite is what
  they should probably use in their **PAT**: one file, no server, the
  most portable, and what real standalone programs use.
- **Access: demonstrate and simulate, no live console.** The output shown
  is what real Access printed; screenshots come from the real Access on
  Chris's machine (Access 2016/365, `MSACCESS.EXE` 16.0). UCanAccess was
  tested and rejected ([../sql-dialects.md](../sql-dialects.md)).
- **Access answers are marked by the AI marker**, per clause, the way the
  memos mark.
- **Access's query builder is taught** - "many CAPS and IEB Access pupils
  might use its SQL builder tools rather than write the SQL themselves".
- **Delphi database code stays in the Pascal course**, linked from here
  ("stay in pascal with links"; courses/pascal-course.md, Course
  decisions).
- **MySQL 8 and Derby are installed on the server** (vps-access.md), and
  the SQL runner is built before the lessons.
- **Each dialect runs on its own engine**, never imitated on another
  ([../sql-dialects.md](../sql-dialects.md)).

## Lessons (draft)

**A - database theory, one set for everyone** (no SQL dialect in it).
Badges as in the Pascal course: an **IEB** badge is visible to everyone.

| # | Lesson | Board |
|---|---|---|
| A1 | Data, information and knowledge - quality data, validation vs verification | both |
| A2 | What a database is - tables, records, fields, types, keys; DBMS and its jobs; desktop, server and distributed databases; careers | both |
| A3 | Relationships and keys - foreign, composite, alternate; 1:1, 1:M, M:N; referential integrity; ERDs | both |
| A4 | A good design - anomalies, redundancy, derived data, splitting a table | both |
| A5 | Normalisation step by step - 1NF, 2NF, 3NF | IEB |
| A6 | Looking after data - access control, SQL injection, backup and recovery, logging changes, parallel data sets | both |
| A7 | Big data - collection, warehousing, mining, NoSQL (IEB), privacy and POPIA | both |

**B - SQL, four parallel sets: Access, MySQL, Java DB, SQLite.** Same
titles, same questions, same sample data; each set in its own dialect,
with its own traps (sql-dialects.md, "Where the four differ"). Built from
**one source per lesson with per-dialect parts**, so the four sets can't
drift apart.

| # | Lesson |
|---|---|
| B0 | Getting started - the tool (Access; MySQL Workbench or XAMPP; NetBeans or `ij` for Java DB; DB Browser for SQLite), opening or loading a database, **checking every table's row count** (the IEB's own scripts have loaded empty - sql-dialects.md) |
| B1 | Building one table - field types and sizes, autonumber, required fields, defaults; CREATE TABLE and the design view |
| B2 | Asking questions - SELECT, FROM, WHERE, ORDER BY; AND, OR, NOT and brackets |
| B3 | Finding patterns - LIKE and `%`, BETWEEN, IN, IS NULL, DISTINCT, the first n rows |
| B4 | Calculated fields and text - arithmetic, AS, rounding, whole numbers, joining text, parts of text, formatting |
| B5 | Dates - date literals, today, year/month/day, days between, accurate age, never a typed "this year" |
| B6 | Counting and totals - COUNT, SUM, AVG, MIN, MAX; GROUP BY; HAVING vs WHERE |
| B7 | Changing data - INSERT, UPDATE, DELETE; back up first; an INSERT run twice |
| B8 | Joining tables - WHERE-join and INNER JOIN (both earn the marks), two and three tables |
| B9 | Questions inside questions - subqueries, unmatched rows, outer joins, INSERT ... SELECT, random numbers (IEB badge) |
| B10 | Practical exam guide - IEB Section A in this dialect - not in the SQLite set |

**The Access set also teaches the query builder** (Query Design). Each
Access lesson builds its query both ways - typed, and in Query Design with
its SQL view - with real screenshots. What the builder does that costs
marks:

- **Wildcards are a mirror image** (tested 25 Sep 2026): in Access's own
  window `*` works and `%` finds nothing; through ADO - the CAPS Delphi
  projects and the IEB's SQLBrowser - `%` works and `*` finds nothing. A
  builder query pasted into Delphi or SQLBrowser can silently return
  nothing.
- **It names columns itself** (`Expr1` for a calculated field,
  `CountOfX` from the Totals row) - and the IEB says no alias unless told,
  and exactly the alias given. To confirm with screenshots when building.
- **Its SQL is wordier** (table names on every field, brackets) - valid,
  and the memos accept any correct SQL.
- **CAPS: no builder in the exam** - the database is password-protected
  and pupils test their SQL only through the Delphi program, so the SQL
  must be typed. The builder is for learning and checking during the year.
  **IEB: allowed** - "open the files with the packages you will use"; the
  SQL view is pasted into the answer sheet.

**C - extras.**

| Set | Lesson |
|---|---|
| Access, CAPS stream | C1 Practical exam guide - CAPS Question 2: 2.1 (SQL in the given Delphi project) here; 2.2 (the Delphi code) links to the Pascal course |
| Access, CAPS stream | Links to the Pascal course's Delphi database lessons (SQL in a click event; a TADOTable walked in code) |
| SQLite | C2 SQLite in your PAT - why (one file beside the program, no server, free, in phones and browsers); Delphi (FireDAC), Lazarus (SQLdb), Java (JDBC); links to the Pascal course's `capssqlitedelphi` / `capssqlitelazarus` and the Java course's lessons 25-26 |

## The platform: running SQL

**The runner is built** (26 September 2026) and running on the test site:
[../sql-runner-design.md](../sql-runner-design.md) - the `sql` block
(Run, result table, no marks), MySQL/Java DB/SQLite, sample databases
written once for all four dialects, `/sql-check.php` for teachers. **The
marked SQL question (`sqlquery`) is built** (26 September 2026, same
file). **The dialect choice is built** (26 September 2026 - below). The
course is `draft` with four check pages (`runnercheck`, `checkjavadb`,
`checksqlite`, `checkaccess`). **Access answers are AI-marked clause by clause**
(26 September 2026 - Chris: "Instant, per clause"; checked in a browser on test;
../sql-runner-design.md).
**The Access recorder is built** (26 September 2026, `bin/sql/record-access.php`;
../sql-runner-design.md, "Access, recorded on real Access").

**The first real lesson is written: Access B0, `access00` "Getting started in
Access"** (26 September 2026, Chris: "build the first access lesson next";
on test). What it set up for the rest:

- **Ids and numbers:** the Access set is `access00`, `access01` ...; the
  theory lessons A1-A7 will be numbers 1-7 and each set's B0-B10 numbers
  8-18 - the four dialects' versions of a lesson share a number. Chapter
  "SQL in Access"; the check pages sit under "Checks for teachers - not
  lessons" and go before the course opens.
- **Written for Access only.** B0 is mostly about the tool, so it is one
  file, not one source with per-dialect parts; build that when the first
  lesson with shared SQL (B2) is written in a second dialect.
- **Screenshots** from real Access by `../tools/access-screens/` (hands off
  the keyboard and mouse while it runs); **TuckShop.mdb** is a download on
  the page (`public/assets/lessons/sql/`), made from the site's own
  statements.
- **Every Access box names its engine** - "In Access's own window" or
  "Through Delphi and SQLBrowser" (the recorder) - and the lesson says both
  exams run SQL the second way.
- **The course has its own glossary** (`content/sql/glossary.php`, 22 terms;
  terms a theory lesson will own are taught in `access00` until it exists),
  `sags.php` (strands 4.9-4.11) and `caps.php`.
- The Pascal link for CAPS Question 2's Delphi side:
  `capssqlitedelphi#ado`.

**Access B1, `access01` "Building a table in Access"** (26 September 2026,
Chris: "build the next access lesson"; on test): plan a table, the data
types, Design View with the key, Field Size / Required / Default Value /
Indexed, what Access does with records (defaults; Required and Field Size
refusals; a phone number losing its 0 in a Number field), and CREATE TABLE -
with DEFAULT failing in Access's own window. The example is a new table,
tblSuppliers, made in the lesson (`'before'`), not added to the sample.
Neither exam has asked for CREATE TABLE; the lesson says so and teaches it
for reading the IEB's scripts and for the PAT. Its CREATE TABLE question is
AI-marked (COUNTER/AUTOINCREMENT, TEXT/VARCHAR/CHAR - all checked on real
Access).

**Access B2, `access02` "Asking questions: WHERE and ORDER BY"** (26
September 2026, on test): fields, WHERE and the comparisons, text / numbers /
Yes-No, AND-OR-NOT with brackets, ORDER BY - and the first Query Design
lesson: the grid, the SQL it writes (table names, three pairs of brackets),
an OR in one Criteria cell, and the builder repeating a condition on both
criteria rows. Traps found on real Access and taught: capitals ignored in
text; `Category = 'Drinks' OR 'Snacks'` returns every record with no error;
AND before OR (4 records instead of 2); a missing comma or a decimal comma is
a syntax error; an empty category sorts first. Five AI-marked questions; the
brackets question needed marker guidance so a missing bracket costs one
clause, not two.

**Access B3, `access03` "Finding patterns: LIKE, BETWEEN, IN and more"** (26
September 2026, on test): LIKE with % and _, **the wildcard mirror** (the
window's * ? # against ADO's % _, each finding nothing on the other side;
Query Design's own `Like "*chips"` SQL finds nothing through ADO; NOT LIKE
with the wrong wildcard returns everything), BETWEEN (both ends; Access
takes it backwards too), IN / NOT IN (a Null is in neither), IS NULL (= NULL
finds nothing), DISTINCT (the Null counts), TOP (ties: TOP 2 gave three;
PERCENT). Six AI-marked questions; the pattern clauses accept LEFT/InStr
as the memos do, and the marker's code-computed wildcard facts fail * for
CAPS and pass it for the IEB.

**Access B4, `access04` "Calculated fields and text"** (26 September 2026,
on test): arithmetic (\ and MOD), AS (brackets for spaces; **Access's
reserved words refuse as names - Value, Date, Money, Level; Action through
ADO only**; never in WHERE), ROUND (**banker's rounding: ROUND(2.5, 0) = 2**),
INT and -INT(-x) (no FLOOR or CEILING in Access; no LENGTH or SUBSTRING),
& against + (+ makes the whole label Null when a piece is Null), LEFT /
RIGHT / MID / LEN / INSTR / UCASE, FORMAT (text: sorts R10 before R3), IIF.
Query Design writes a calculated field as NewPrice: [Price]*1,1 - the grid
uses the Windows decimal comma, SQL View a point - and names an unnamed one
Expr1 by itself. Six AI-marked questions.

**Access B5, `access05` "Dates in Access"** (26 September 2026, on test):
#year/month/day# (quotes: Data type mismatch; **#03/04/2026# is 4 March -
Access reads a slashed date month first when it can**, #13/04/2026# is 13
April), YEAR / MONTH / DAY / WEEKDAY (Sunday = 1), MONTH = 2 against
BETWEEN, FORMAT for names; DATE() / NOW() / TIME() (a sale date is never =
NOW(); TIME() alone sits on 30 December 1899); **"this year" is
YEAR(DATE()), never a typed 2026**; date arithmetic, DATEDIFF / DATEADD (a
month after 31 January is 28 February); **age: DATEDIFF('yyyy') and a year
minus a year both overcount before the birthday - the IIF formula is
exact, INT((DATE() - Birthday) / 365.25) is one short on some birthdays**.
Query Design turns a typed 2026/02/01 into #2/1/2026# in its SQL (checked
with BuildCriteria, no screenshots - they wait for a quiet machine); it
runs correctly through ADO. Boxes that use today's date say the day they
were recorded. Five AI-marked questions.

**Access B6, `access06` "Counting and totals"** (26 September 2026, on
test): COUNT / SUM / AVG / MIN / MAX with AS (MIN and MAX on dates);
COUNT(*) 14 against COUNT(Category) 13; "how many sales" (COUNT) against
"how many items" (SUM(Quantity)); **no COUNT(DISTINCT) in Access** (syntax
error); **AVG skips Nulls** (a priceless sweet added with `'before'`: AVG
divides by 3, SUM / COUNT(*) by 4); an average of a Currency field stays
Currency; GROUP BY (the Null is its own group, first), two fields, an
expression; **every non-total field in GROUP BY** (Access's "does not
include the specified expression" message, also for ProductName with
MAX(Price)); **a name (alias) can't be used in GROUP BY, ORDER BY or
HAVING** - ORDER BY and HAVING give "No value given for one or more
required parameters"; a total in WHERE is refused; WHERE and HAVING
together. Query Design's Total row (Group By / totals / Where, CountOfX
names, a criterion under Group By goes into HAVING) is described, not yet
pictured - **its screenshots wait for a quiet machine**. Six AI-marked
questions; the stock question needed guidance so a price test in the
wrong place costs one clause, not two.

**Access B7, `access07` "Changing data: INSERT, UPDATE and DELETE"** (26
September 2026, on test): back up first (no Undo; the window warns, ADO
doesn't; try the WHERE as a SELECT; CAPS's Restore button); INSERT with a
field list (AutoNumber left out; left-out fields Null, but **a Yes/No field
is False**), without one ("Number of query values and destination fields
are not the same"), with a taken key, and **run twice - two samoosas, no
error**; UPDATE (SET from the old value, **no WHERE changes all 14**, run
twice compounds to 21%, two fields); rebuilding text the IEB way (LEFT, LEN,
& with LIKE) - **REPLACE also runs through ADO** (tested), but changes the
text anywhere in the name; DELETE and DELETE * FROM, no WHERE empties the
table; **the sample's relationship is enforced** - a product with sales
can't be deleted, a sale for product 99 can't be added (Access's words);
action queries in Query Design (described, pictures wait for a quiet
machine). Change boxes show a short query afterwards (`'check'`,
../sql-runner-design.md). Five AI-marked change questions; `Yes` for a
Yes/No value needed the clause reworded before the marker accepted it.

The course needs:

- **A dialect per pupil** - Access, MySQL or Java DB, chosen once; CAPS
  pupils are Access. Every set is open to everyone; **only the chosen
  set's questions count** (marks pages, class results, pupil work);
  SQLite's count for no one.
- **An `sql` block** (the twin of the `code` block): an editable SQL box,
  Run, the result as a table or the error. **Every Run starts from a
  fresh copy** of the lesson's sample database. Engines: **MySQL 8.0** and
  **Java DB** (Derby 10.17, in-memory, on Java 21) on the server;
  **SQLite** - PHP's own.
- **Java DB runs in one warm, sandboxed service, never a Java process per
  Run** - measured: 1.1 s and ~95 MB per process, and 30 at once took
  17.6 s and nearly all free memory (vps-access.md, Capacity). The service
  must also stop pupils' SQL reaching Java: Derby can call Java code from
  SQL (`CREATE FUNCTION`/`PROCEDURE`, the `SYSCS_UTIL` export and import
  procedures), so it runs in the compile sandbox (no network, no site
  files) and refuses those statements. MySQL is cheap (30 Runs at once:
  0.85 s).
- **Access: a simulated block** - the query and the table real Access
  printed, recorded on Chris's machine (Jet 4.0 through ADO, as both
  exams use it) by the recorder, plus Query Design screenshots. No Run
  button. Built: blocks can also be recorded in Access's own window.
- **An `sqlquery` question** marked by result, the way the exams print the
  correct output: run the pupil's SQL and the model answer on fresh copies
  and compare the rows (order only when the question asks for an order;
  column names only when it asks for an alias). For INSERT/UPDATE/DELETE,
  compare the table afterwards. Server-side, so a mark can't be forged.
- **Access questions go to the AI marker** (the `written` queue): the
  pupil's SQL, the question, the model answer, the table real Access
  printed and a per-clause mark scheme (fields, table, join, each
  condition, grouping, having, order, alias) - the memos' way.
- **A checker** runs every model answer in every set on its engine and
  records the Access outputs - the Access half is built
  (`bin/sql/record-access.php`); the live dialects work their answers out
  when first asked (`SqlQuestionExpected()`).
- **Safety:** read-only sample databases, a time limit per statement, one
  statement per Run, a database user that can touch only its throwaway
  database.
- **Our own sample databases**, South African and school-sized (a tuck
  shop, a sports day, a library), each in all four dialects - not the
  exam papers' data.

## The dialect choice (built 26 September 2026)

- **Stored** in `pupils.sqlDialect` (`access`, `mysql`, `javadb`); rules in
  lib/sql.php (`PupilSqlDialect()`, `SetPupilSqlDialect()`).
- **CAPS is always Access** - the choice is a sentence, not a form. **IEB**
  (and anyone else) picks Access, MySQL or Java DB; **not chosen = Access**
  (what CAPS and most IEB Delphi schools use). A teacher who has not chosen
  counts every dialect but SQLite. **SQLite is never a choice and never
  counts** - practice, and what the PAT should probably use.
- **Where:** the course page's "Your database" box (always shown, `#dialect`)
  and My account ("SQL database", `#sql`); saved by `public/sql-dialect.php`.
- **Lessons:** `'dialect' => ...` in content/sql/index.php. The course page
  lists the pupil's own dialect's lessons (and the dialect-free theory ones)
  as usual, with a dialect tag; the other dialects' lessons and SQLite's go
  in one folded group at the end: "Practice - the other databases and
  SQLite, no marks". A practice lesson says so at the top and its answers
  stay out of every total; a practice question in a mixed page says
  "(practice)".
- **Counting** goes through the count key (platform.md, "SQL dialects and
  the count key").
- **Checked on test** (26 September 2026, the throwaway dev-login account;
  it is left enrolled in `sql` on test, on CAPS, not a teacher): a teacher
  with no choice counted everything but SQLite (runner check 7/10); an IEB
  pupil defaulted to Access (0/0 - no Access questions yet) and, after
  choosing MySQL on the course page, counted only the MySQL questions (5/6);
  the Java DB page then showed the practice notice, its question said
  "(practice)", marked normally, and stayed out of My marks; a CAPS pupil
  saw one sentence and no form.

## Questions for Chris

- **Q1.** The IEB-badged lessons (A5, B9): visible to everyone
  (recommended, as with the exam guides), or IEB pupils only?
- **Q2.** Does the CAT `catdb` course (Access, design view, forms and
  reports) borrow lessons A1-A4 and the Access query-builder material, or
  stay separate?
