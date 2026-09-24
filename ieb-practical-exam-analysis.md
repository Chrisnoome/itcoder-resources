# IEB IT practical exam - analysis for lesson 24

Built 24 September 2026 from every IEB practical paper, memo, analysis grid
and teacher instruction in `IEB/` (2009-2025 November, May/supplementary
2021-2026). **Detailed analysis covers the ten papers in the current
format:** November 2021-2025 and May 2022-2026. Source of truth for the
syllabus stays [sags-2025.md](sags-2025.md) and
[sags-topic4-syllabus.md](sags-topic4-syllabus.md); the exam's own marking
conventions are also in [marking-house-style.md](marking-house-style.md).

**Which paper is the practical:** up to **2020 the practical was Paper II**
(3 hours, **120 marks**: SQL 40 + OOP 80) and Paper I was theory (180
marks). **From 2021 the practical is Paper I** (3 hours, **150 marks**:
SQL 50 + OOP 100). The May 2021 supplementary still used the old
numbering. The shape itself has not changed since at least 2010.

---

**Scope of lesson 24 (Chris, 24 September 2026): SQL is a separate
course, so the Pascal practical guide covers Section B (OOP, 100 marks)
only**, plus the paper-wide rules and technique that apply to it. Section
2 below (SQL) stays here as the reference for the SQL course's own exam
lesson; lesson 24 mentions Section A only as "the other half of the
paper, taught in the SQL course".

## 1. The paper at a glance

| | Section A - SQL | Section B - OOP |
|---|---|---|
| Marks | 50 (one Question 1, 8-11 sub-questions of 3-9 marks) | 100 (Questions 2-7, 12-32 marks each) |
| Given | A database (Access, JavaDB or MySQL - same data), `SQLAnswerSheet.rtf`, `SQLBrowser.exe` | Text files (`#`-delimited), class diagrams in the paper |
| Output | SQL pasted into the answer sheet, with the correct output shown in the paper for almost every query | A program: classes + a **text-based** UI class, with the correct output shown |
| Cognitive levels | 30 / 40 / 30 (L1 / L2 / L3), per section and overall | same |

- One scenario per section (Section A's database and Section B's program
  are unrelated). Language-neutral wording ("Java/Delphi"); the memo has a
  Java and a Delphi solution.
- **Printing:** half an hour after the exam; a code listing of every
  class; exam number as a comment in every file; font 12, indented, not
  truncated. Only the printout is marked (no disk goes to the IEB) - so
  **code that is not printed earns nothing**.
- The school keeps a backup of every candidate's work until the end of
  February (re-marks).

### The standing instructions (on the cover of every paper)

These are the rules pupils lose marks on. Lesson 24 should teach each one.

1. Answer with OOP principles: sensible methods and parameters.
2. Language- and database-neutral wording.
3. **Marks follow the specification** - names, parameter order, types and
   formats exactly as the question and class diagram give them.
4. **Only answer what is asked.** No validation unless it is asked for.
5. **Code that doesn't work: comment it out** so the rest runs, and write
   a note saying what was intended.
6. **Code must work for any data**, not just the sample - no hard-coding
   (the paper often says "You may NOT hardcode a specific year").
7. **Searches and sorts from first principles** - no built-in sort/search.
8. **You declare every data structure** - never store data in interface
   components.
9. **Read the whole paper before choosing a data structure.**
10. Save regularly; **back up the original files first** (Section A's
    UPDATE/INSERT/DELETE change the database; a second run of an INSERT
    duplicates rows).
11. A power failure gives only the time left - unsaved work is lost.
12. Exam number in every program; check every printed page.
13. SQL: **do not rename columns or use an alias unless told to** - and
    use exactly the alias given when one is asked for.

---

## 2. Section A - SQL: what comes up

*(For the SQL course - not lesson 24.)*

Counted over the ten current-format papers.

| Feature | Papers | Typical wording |
|---|---|---|
| `SELECT *` / chosen fields, `WHERE` with `AND`/`OR`/`NOT`, `ORDER BY` | 10/10 (always 1.1-1.2) | "Display all the details of ... in alphabetical order of ..." |
| `LIKE` with wildcards (starts/ends/contains) | 10/10 | "names ending in 'Premium' or 'Deluxe'", "the word Fire anywhere in their name" |
| Aggregate with an alias (`COUNT`, `SUM`, `AVG`, `MAX`) | 10/10 | "Name this field NumSales" |
| `GROUP BY` ... `HAVING` | 10/10 | "Only display provinces where the total ... is greater than 1000" |
| Join of 2-3 tables (WHERE-join or INNER JOIN, both accepted) | 10/10 | "Display the client's name and the license ..." |
| Date functions (`YEAR()`, `NOW()`/`DATE()`, date difference, month) | 9/10 | "currently receive free support", "turning 13 this year", "subscribed in the current month" |
| **UPDATE** (often with string functions) | 10/10 (always near the end) | "change the names of all products that end in 'Deluxe' to end in 'Premium'" |
| **INSERT** | 8/10 - of which **INSERT ... SELECT** 6/10 | "insert a matching record for each ...", "add sign-ups for the same activities ... with a date of ..." |
| Calculated field (`*`, `ROUND`, `INT`, `+`) | 8/10 | "Calculate the income by multiplying ...", "Round ... to two decimal places" |
| String functions (`LEFT`, `RIGHT`, `MID`, `LEN`, concatenation `&`) | 8/10 | hashtags, reformatting cell numbers, first 3 characters |
| Rows with **no match** (`NOT IN (subquery)` or `LEFT JOIN ... IS NULL`) | 6/10 | "cars that have not been rented", "items not linked to a supplier" |
| Subquery against an aggregate (above/below average, the highest) | 5/10 | "a fee greater than the average fee" |
| Random numbers (`RND()`, `INT(RND()*n)+a`) | 4/10 | "a random number from 1000000 to 2000000", "a different random number for each record" |
| `DELETE` | 2/10 | "remove all the parking bays added before 2018" |
| `TOP n`, `DISTINCT`, `BETWEEN`, `IN (list)`, `IS NULL` | occasional | "the top 3 most expensive activities" |

**The order is stable:** simple selects (3-6 marks) -> an aggregate ->
a date or calculated field -> a join -> GROUP BY/HAVING (7) -> a
subquery or unmatched rows -> **UPDATE (7-9) -> INSERT (7-9)** last.

**Marking (memos):** one mark per correct clause/part (fields, table,
each condition, the join condition, grouping, having, order, alias).
Alternatives are listed and accepted - `WHERE`-join or `INNER JOIN`;
`*`/`%` wildcards; `RIGHT(x, n) = '...'` instead of `LIKE`; `LEFT` or
`SUBSTR`; `NOW()`, `DATE()` or `CURRENT_DATE`. Hard-coding a year that
should come from `NOW()` loses the date marks.

**Traps seen in the questions:**
- "the current year / this year / currently" -> `YEAR(NOW())`, never a typed year.
- "from 2 to 5 (inclusive)" -> `BETWEEN` or `>=`/`<=`.
- Names with a space or an ampersand, and `'Premium'` vs `' Premium'` (the space) in string rebuilding.
- GROUP BY must list every non-aggregated field (`GROUP BY FestName, FestDate`).
- An UPDATE that rebuilds text needs `LEFT(x, LEN(x) - n) & 'new'`.
- INSERT ... SELECT: the SELECT supplies the columns in the table's order; a constant date or a random value goes straight into the SELECT list.

---

## 3. Section B - OOP: what comes up

**The skeleton is the same in every paper:**

| Q | What | Marks | Always has |
|---|---|---|---|
| 2 | **Class 1** from a class diagram | 12-25 | private fields; parameterised constructor; accessors (1 mark each, "completely correct"); sometimes a mutator; one calculation/decision method (3-8); `toString` in a given format |
| 3 | **Class 2** - a child class (inheritance) *or* a class holding objects (composition) | 12-25 | inheritance: `extends`/`class(TParent)`, `super`/`inherited Create` first, an **overridden** method (fee, cost, `authorise`), `toString` that calls the parent's and adds to it |
| 4 | **The manager class** | 21-33 | a private array of objects + a counter; a **constructor that reads a `#`-delimited text file**, decides which class each line is, instantiates it and adds it (9-11 marks - the biggest single item); `toString` over the array; usually a **sort** (5-8) |
| 5 | **Text-based UI** | 4-7 | a UI class; instantiate the manager; call methods; display (1 mark each) |
| 6-7 | **Problem solving** | 12-32 | a search, a second text file, a report string, counting, dates - 17-30 marks on one method in half the papers |

Counted over the ten current papers:

| Feature | Papers |
|---|---|
| Constructor reads a `#`-delimited text file into an array of objects | 10/10 |
| Private fields, accessors, `toString` with an exact format | 10/10 |
| Constants and/or static (class) fields - often ints standing for categories (`ROCK = 1`, `DAYS30`, `ACCESS = 0`) | 10/10 |
| Dates or times in a field (parse a string, compare, add months, years between, days between, "now") | 9/10 |
| **Inheritance** with an overridden method and `toString` calling the parent's | 6/10 (Nov 2022, 2023, 2025; May 2023, 2024, 2026) |
| **Composition** - an object holding another object or an array of objects | 4/10 (2021, 2024, May 2022, May 2025) |
| A sort in the manager (by name, date, time, year) | 6/10 |
| Deciding the class from the line (number of fields, or a code at the front) | every inheritance paper |
| A second text file processed later (requests, results, orders) | 5/10 |
| Search the array for a matching field (find by ID/name/MAC) | 8/10 |
| An integer code shown as text (`getGenre`, `getTermsString`, `getLicense`) | 4/10 |
| A report string built line by line, with headings, blank lines and "none" cases | 8/10 |
| Remove duplicates / a unique list | 2/10 (2023, May 2023 delete) |
| Writing a text file | 1/10 (2021 map) |
| A 2-D grid printed as characters | 1/10 (2021 map) |
| Check-digit / character-code calculation (sum of `Ord`, `mod 100`) | 1/10 (2025) |

**The big problem-solving questions (last one or two in each paper):**
2021 print a map of servers (17); 2022 process test results and promote
(21+); 2023 unique registration list + billing invoices (25); 2024 list
"easy listener" songs per musician with "none" cases (17); 2025
process ACCESS/AUTHORISE requests from a file (30 over three methods);
May 2022 accept/reject research papers (11) and doctoral list; May 2023
change award thresholds, delete and list (16); May 2024 club clashes by
meeting time with venue cost (30); May 2025 allocate plays to theatres
without date clashes (30); May 2026 read orders and total them (20+).
Common core: **loop through the array, test each object (often with a
method from Q2/Q3), accumulate counts or a string, handle the "none
found" case, return one string that the UI prints.** Helper methods are
often specified ("use the helper methods processFree and processPremium").

**Marking (memos):** a mark per element - class header, all fields
private, correct types and names, each assignment, the parent call as the
first line, the loop with correct limits, the comparison, the swap, the
increment, the return. So:
- **Partial code earns most of the marks.** A method that is half right
  still gets its header, loop and assignments.
- **Follow-through:** an error is penalised once; later code that uses it
  correctly still earns ("follow through if accSize decremented in
  constructor").
- **Penalised once only:** a missing `private`; using `0`/`1` instead of
  the named constants.
- Accessors and mutators are all-or-nothing (1 mark).
- Any correct method is accepted (Scanner or split; `Pos`/`Copy` or a
  split function; any date routine) - but **not a built-in sort**.
- Efficiency counts: every cover says to pick the most efficient data
  structure, and older papers (2018) award marks for it outright ("marks
  will be awarded for efficiency. For example, re-reading from the file
  ...").

**Delphi idioms the memo uses** (all taught in lessons 14-21): `Copy` +
`Pos` + `Delete` to split at `#`; `StrToInt`/`StrToFloat`; `EncodeDate`
from a `dd MM yyyy` string; `DateUtils` (`MonthsBetween`, `YearsBetween`,
`DaysBetween`, `IncMonth`); `array of string` with `SetLength`;
`inherited Create(...)`; `function toString: string; override;`;
`AssignFile`/`Reset`/`Readln`/`Eof`/`CloseFile` inside `try ... except`;
`Ord` for character codes; `#13#10` for new lines in a returned string.

---

## 4. What always appears (the lesson 24 checklist)

Section B (lesson 24); the SQL list is in section 2 for the SQL course.

1. **A class from a diagram:** private fields, parameterised constructor
   (with a date parsed from a string), accessors, a calculation method,
   `toString` in an exact format.
2. **A second class:** a child class with an overridden method and a
   `toString` that extends the parent's - or a class holding objects.
3. **A manager:** array of objects + counter; constructor reading a
   `#`-delimited file and choosing the class per line; `toString`; a
   first-principles sort.
4. **A text UI:** instantiate, call, display.
5. **Constants/static fields**, and using them instead of literal values.
6. **A problem-solving method** that loops over the objects, uses
   earlier methods, accumulates a report string and handles "none".

## 5. Exam technique to teach (from the instructions and memos)

- **Read the whole paper first** (5 minutes). Q6/Q7 decide what the
  classes need.
- **Time:** Section B's 100 marks get ~110 minutes (Section A, the SQL
  half, ~60; 10 minutes to check) - roughly a mark a minute.
- **Back up the original text files first.**
- **Copy names exactly** from the diagram: class, field, method,
  parameter names and order, return types.
- **Match the sample output character for character** (spaces, `#`, new
  lines, headings) - `toString` marks depend on the format.
- **Never hard-code** what the data or the date should decide.
- **Get the file-reading constructor working early** - everything after
  it depends on the array being full. Print the array (Q5) to prove it.
- **Stuck? Comment it out, say what it should do, move on.** Partial code
  earns marks; code that stops the program compiling costs the rest.
- **Use the constants** the paper tells you to create.
- **Sorts and searches by hand** (selection or bubble; linear search).
- **Print everything**, check every page, exam number in every file.

## 6. For the Pascal course

- **SQL is not in the Pascal course** - it is a separate course (Chris, 24
  September 2026). Lesson 24 covers Section B only.
- The rest of Section B is covered: classes (16), text files (17),
  validation (18), dates (19), the array manager and sorting (20),
  inheritance (21), a text UI (22). A **past-paper walkthrough** (one full
  Section B, e.g. November 2025, solved in console Pascal) would tie them
  together.
- The course's console programs match the exam's "text-based user
  interface" exactly - worth saying in lesson 24.
