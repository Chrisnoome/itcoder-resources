# SQL dialects - the exams' three, SQLite, and what runs where

**Rules (Chris, 25 September 2026):**
- **Each dialect's SQL runs on its own engine** - never one dialect
  imitated on another. Chris: "any significant variation in syntax for
  sqlite means we can't use it - check that first." The check below
  found significant variation, including wrong answers with no error, so
  SQLite never stands in for Access, MySQL or Java DB. It runs only its
  own SQL, in the SQLite lessons.
- **Access has no live console** - "the lesson can demonstrate and
  simulate". The output shown is what real Access printed (run on
  Chris's machine by `tools/sql-dialects/`).
- The course's dialect lessons and marks: courses/sql-course.md.

(Platform data stays in SQLite; this is about the SQL pupils write.)

Which dialect: **CAPS - Access only** (Delphi, ADO, Jet 4.0 `.mdb`;
caps-practical-exam-analysis.md §9). **IEB - Access, Java DB or MySQL**,
the school's choice; the data comes in all three (`X_Access.mdb`,
`X_JavaDB.sql`, `X_MySQL.sql`). The memo writes Access and, where they
differ, gives the MySQL and Java DB forms too (November 2025, 1.8).
The IEB's `SQLBrowser.exe` is a Delphi program using **ADO with Jet 4.0**
(its connection string is in the file) - the same engine as CAPS, where
`*` matches nothing; IEB Access pupils should use `%` too (the memo
accepts it). Java DB and MySQL pupils load the `.sql` script into their
own tool.

**The IEB's three files do not always agree** (checked 25 September 2026
by loading them): May 2025 - both `.sql` scripts insert into a column
`StageSize` that their `CREATE TABLE` lacks, so `tblTheatres` loads
**empty** in Java DB and MySQL (the `.mdb` has 7 rows). May 2024 -
`tblSignUps` has **38 rows in the `.mdb` and 44 in both scripts**, so
answers differ by dialect. The exam guide must teach: load the script,
check every table's row count, report a failure at once.

## How it was checked (25 September 2026)

40 exam-style queries (the IEB and CAPS memos' features) in each
dialect's form, on fresh copies of one small database, on real engines on
Chris's machine: **Access** - Jet 4.0 OLEDB (the CAPS projects' engine),
ACE 12 OLEDB and ACE ODBC; **MySQL** - MariaDB 10.4 in its own mode and in
MySQL 8's default `sql_mode`; **Java DB** - Apache Derby 10.17.1.0;
**SQLite** 3.39.2 running the Access, the MySQL and the Java DB forms;
and **UCanAccess** 5.1.8 (a Java driver that imitates Access) running the
Access form. Harness and full results: `tools/sql-dialects/` -
`tests.php` writes `tests.json` and `tests-flat.tsv`; `run-access.ps1
-Mode jet|ace|odbc` (`jet` needs the 32-bit PowerShell in
`C:\Windows\SysWOW64`); `run-php.php` (needs a MariaDB on port 3399);
`RunJdbc.java derby|ucan <dir>` and `LoadSql.java file.sql` (JDK 21 at
`D:\xampp\jdk-21`; jars from Maven Central, not kept here:
`org.apache.derby:derby`, `derbyshared`, `derbytools` 10.17.1.0,
`io.github.spannm:ucanaccess` 5.1.8, `io.github.spannm:jackcess` 5.1.7,
`org.hsqldb:hsqldb` 2.7.4); `inspect-mdb.ps1` lists an `.mdb`'s tables;
`compare.php` prints the table.

Also run: the MySQL tests on the server's **MySQL 8.0.46** (all 34 the
same as MariaDB in MySQL 8's mode), and the wildcard test through **DAO**
(Access's own engine mode, what Query Design uses).

**UCanAccess is not Access:** 12 of 39 results differed from real Jet -
the exams' `#yyyy/mm/dd#` dates fail ("unknown token"), `120 / 100`
gives 1, `+` joining text fails, and `*` works where ADO's Jet matches
nothing. Not used.

**Java DB behaved exactly as its manual says:** every Java DB form ran;
it differs from Access and MySQL only where the table below says (no
`ROUND`, `120 / 100` = 1, `=` and LIKE match capitals exactly, strict
GROUP BY and HAVING).

## Result: SQLite can't stand in for any of the three

The Access form of 35 queries on SQLite: **14 the same, 13 errors, 8
wrong answers with no error**. The MySQL and Java DB forms fare no better
(missing `YEAR`, `MONTH`, `LEFT`, `FLOOR`, `CONCAT`, `IF`, `DATEDIFF`,
`FETCH FIRST`, date formats). The silent ones are the worst - a pupil
would learn a wrong answer as right:

| Query | Access / MySQL | SQLite |
|---|---|---|
| `Name & ' (' & Province & ')'` | Thandi Nkosi (Gauteng) | **0** (`&` is bitwise AND) |
| `Name + ' (' + ...` (Access accepts `+`) | Thandi Nkosi (Gauteng) | **0** |
| `120 / 100` | 1.2 | **1** |
| `WHERE Province = 'gauteng'` | 2 rows | **none** |
| `FORMAT(Fee, "Currency")` | R450,00 | **450** |
| `'2026-09-25' - SaleDate` (days) | - | **9** (years, from the digits) |
| A selected column missing from GROUP BY | error | **runs** |
| An alias used in HAVING | error in Access | **runs** |

## What is the same everywhere (the shared core)

Tested identical in Access, MySQL, Java DB and SQLite:
SELECT/FROM/WHERE/ORDER BY (ASC, DESC), AND/OR/NOT, `<>`, BETWEEN,
IN (list), IS NULL, DISTINCT, COUNT(*)/SUM/AVG/MIN/MAX with AS, GROUP BY,
HAVING, joins in WHERE, INNER JOIN, LEFT JOIN, subqueries, NOT IN,
UPDATE, DELETE FROM, INSERT ... VALUES, INSERT ... SELECT, `= True` on a
yes/no field, LIKE with `%`.

## Where the four differ

All tested on the real engines (Access through Jet 4.0 ADO, as both
exams run it).

| Job | Access | MySQL | Java DB | SQLite |
|---|---|---|---|---|
| Wildcard | **A mirror image:** through ADO (Delphi, SQLBrowser) `%` works and `*` matches **nothing**; in Access's own window (Query Design, DAO) `*` works and `%` matches **nothing**. The IEB memo writes `*` and accepts `%` | `%` | `%` | `%` |
| Text in double quotes | yes (ODBC reads it as a parameter) | yes | no - a name (manual) | only if no column has that name |
| Join text | `&` or `+` | `CONCAT()` | `\|\|` | `\|\|` (`&` and `+` give 0) |
| Length | `LEN` | `LENGTH` | `LENGTH` | `length` |
| Part of text | `LEFT`, `RIGHT`, `MID` | `LEFT`, `RIGHT`, `MID`, `SUBSTRING` | `SUBSTR` | `substr` (a negative start counts from the end) |
| First n rows | `TOP n` | `LIMIT n` | `FETCH FIRST n ROWS ONLY` | `LIMIT n` |
| Today | `Date()`, `Now()` | `CURDATE()`, `NOW()` | `CURRENT_DATE` | `date('now')` |
| Year, month | `YEAR()`, `MONTH()`, `DAY()` | same | same | `strftime('%Y', d)` gives **text**: `= 2025` finds nothing; use `= '2025'` or `CAST(... AS INTEGER)` |
| A date | `#2025/03/25#` | `'2025-03-25'` | `'2025-03-25'`, `DATE('2025-03-25')` | `'2025-03-25'` (stored as text) |
| Days between | `date - date` | `DATEDIFF(a, b)` | `{fn TIMESTAMPDIFF(SQL_TSI_DAY, b, a)}` | `julianday(a) - julianday(b)` |
| Whole number part | `INT()` | `FLOOR()` | `FLOOR()`, `CAST` | `CAST(x AS INTEGER)` |
| Round | `ROUND(x, 2)` | `ROUND(x, 2)` | **none** | `round(x, 2)` |
| Random | `RND()` | `RAND()` | `RANDOM()` | `random()` (a huge integer) |
| Formatting | `FORMAT(x, "Currency")` (R450,00 on a South African machine) | `FORMAT(x, 2)` (450.00) | none | `printf('R%.2f', x)` |
| If | `IIF()` | `IF()`, `CASE` | `CASE` | `IIF()`, `CASE` |
| `120 / 100` | 1.2 | 1.2 | 1 | 1 |
| `= 'gauteng'` finds Gauteng | yes | yes | no | no |
| LIKE ignores capitals | yes | yes | no | yes |
| Column missing from GROUP BY | error | error (MySQL 8; MariaDB allows unless `ONLY_FULL_GROUP_BY`) | error | **allowed** |
| Alias in HAVING | error | allowed | error | allowed |
| Three tables with INNER JOIN | brackets required | brackets optional | brackets optional | brackets optional |
| `DELETE * FROM` | yes | no | no | no |
| `AS Level` | error - `Level` is reserved in Access | fine | not tested | fine |
| NULL in `ORDER BY` / `GROUP BY` order (runner, 26 Sep 2026) | not tested | first | **last** | first |
| `AVG(Price)` on a 2-decimal column (runner) | not tested | `12.500000` | `12.5000` | `12.5` |
| Column names in the result | as written; through ADO an unnamed sum gets `Expr100n` - `Expr1002` as the third column (recorder, 26 Sep 2026) | as written in the query | **CAPITALS** unless quoted | as written |
| Table names and capitals | ignored | ignored on Windows; **matter on Linux** unless `lower_case_table_names=1` (set on our server) | ignored unless quoted | ignored |
