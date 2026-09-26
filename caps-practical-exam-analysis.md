# CAPS (DBE) IT practical exam - analysis, Pascal only

Built 24 September 2026 from every DBE NSC Information Technology Paper 1
and memo in `CAPS/past papers` (2016-2026, November and
Feb/March and May/June). The twin of
[ieb-practical-exam-analysis.md](ieb-practical-exam-analysis.md).
**Pascal only (Chris, 24 September 2026): Question 2 (database and SQL,
40 marks) is left out of §1-8** - SQL is a separate course; §9 analyses
Question 2 for that course (25 September 2026). Syllabus reference:
[caps-2024.md](caps-2024.md) (§4.5 gives the official Paper 1 format).
Detailed counts cover the **15 papers in the current format**, November
2018 to May/June 2026.

## 1. The paper at a glance

- **Paper 1, 3 hours, 150 marks, Delphi only** ("set with programming
  terms that are specific to the Delphi programming language").
- **Four sections, fixed since November 2018:**

| Section | Question | Marks | In this guide? |
|---|---|---|---|
| A | 1 General programming skills | 40 | yes |
| B | 2 Database programming (SQL and data-aware Delphi) | 40 | **no - SQL course** |
| C | 3 Object-oriented programming | 40 (object class ~20-25, form ~15-20) | yes |
| D | 4 Problem-solving programming | 30 | yes |

  So **110 of the 150 marks** are Pascal. (2016 to May 2018 had three
  sections - general ~50, OOP ~60, problem solving ~40 - with no
  database question.)
- **Everything starts from an incomplete Delphi project** per question
  (`Question1_P.dpr`, `Question1_U.pas`, a form with named components),
  extracted from a password-protected file at the start. **The GUI is
  always provided**; pupils write the code inside button click events
  (and a given object class unit). Output goes to components: panels,
  labels, edit boxes, spin edits, memos, rich edits, `ShowMessage`.
- **The object class is also supplied incomplete** (`Beehive_U.pas`,
  `TBeehive`): attributes already declared, some methods (often
  `toString`) given; pupils add the constructor and methods.
- Disk or network space is handed in (the work is marked from the files);
  printing only "if required". Examination number as a comment in the
  first line of every unit.
- A candidate information sheet records the Delphi version and which
  files were saved and attempted.

### The standing instructions (cover of every paper)

1. Answer every question in all four sections.
2. Delphi only.
3. **Marks follow the specification** - answer according to what each
   question sets.
4. **Only answer what is asked** - no marks for validation nobody asked for.
5. **Code must work for any data**, not just the sample.
6. **Search, sort and selection from first principles** - no built-in
   routines.
7. You define all data structures unless they are supplied.
8. Save regularly; exam number as a comment in every unit and event.
9. Hand in the disk/space with every file readable.

## 2. Question 1 - general programming skills (40 marks)

4-5 buttons, **3-17 marks each**, each one self-contained.

**What comes up** (all 15 papers):
- **Read a component, convert, calculate, display formatted** - every
  paper, usually 1.1-1.2 (4-9 marks): `StrToInt(edt.Text)`,
  `spn.Value`, `FloatToStrF(x, ffFixed, 8, 2)`, `IntToStr`, panel/label
  captions.
- **A formula with pre-defined maths functions** - volume, surface area,
  Pythagoras, fractions, area (10 of 15): `Sqrt`, `Sqr`, `Power`, `Pi`,
  `Round`, `Trunc`, `Ceil`; often "use at least TWO DIFFERENT pre-defined
  mathematical functions".
- **Random numbers** (11 of 15): `Random(n) + 1` / `RandomRange`, fill
  an array or pick a value; output "may differ".
- **String handling** (every paper, usually the biggest, 10-17 marks):
  separate a code at a delimiter (`12#F`), reverse words, decrypt a
  string, count a letter, longest word, anagram, title case, replace,
  extract a word, hidden security code, word game.
- **Selection** - `if` chains and a **case** statement on a character
  (letter codes -> descriptions).
- **A classic algorithm, often from a given flowchart:** factors and
  primes, factorial, HCF, multiples, binary or hexadecimal conversion,
  lowest number, change calculation.
- **Loops with output built as a string** - patterns, dash-separated
  lists ("mechanism to deal with the extra dash" is a mark).
- **Dates** occasionally (leave months, age).
- **A text file** occasionally since 2023 (read a file into a
  component, 9 marks in November 2024).

## 3. Question 3 - OOP (40 marks)

**Always the same two parts, and always ONE class** - no inheritance, no
array of objects, no manager class in any of the 15 papers.

**3.1 The object class (~20-25 marks):**
- Constructor receiving some parameters and **setting the rest to given
  defaults** (every paper, 3-5 marks).
- **Accessor** `getX` (every paper, 2 marks), sometimes a **mutator**
  `setX` (2-3).
- A method that **updates** an attribute from a parameter (increase,
  add, `updateScore`, `updatePoints`) - 3-6 marks.
- **One decision/calculation method worth 6-11 marks** - a band table
  (`determinePopularity`, `determineTruckType`, rating, level) or a
  formula (cost, BMI, capacity, pace, average).
- A Boolean method from criteria (`checkHealthStatus`, `isSufficient`,
  `qualifiesForBonus`).
- `toString` - complete a given one or write one in an exact multi-line
  format (2-7 marks).
- Sometimes a **private helper** (build an ID code from the attributes:
  `compileCode`, `generateTurtleID`, `compileTripNum`) and **the system
  date** (`Date`, `FormatDateTime`).

**3.2 The form (~15-20 marks):**
- **Instantiate the object from components** (every paper, 5-9 marks):
  read a combo box, spin edit, check box, edit; `objX :=
  TX.Create(...)`; display with `toString` in a rich edit/memo.
- Call each method from its own button and display the result (2-9
  marks each), enabling/disabling buttons, `ShowMessage`, formatting to
  2 decimals.
- Occasionally write the object's data to a text file (May 2023) or
  process a text file line by line (May 2019).

## 4. Question 4 - problem solving (30 marks)

2-3 buttons; one is usually **13-23 marks**. The data is almost always
in **arrays already declared and populated in the code** (sometimes a
text file).

| Theme | Papers |
|---|---|
| 1-D arrays, **parallel arrays** - populate, search, count, total | every paper |
| **2-D arrays** - fill from strings, rows/columns, grids and charts (maze, distance chart, soil table, Pascal's triangle) | 7 of 15 |
| String splitting into arrays (`'20:50:10'` -> three values) | frequent |
| **Sort** from first principles (alphabetical, by a value) | 3 of 15 |
| Remove duplicates / distinct values | 2 of 15 |
| A number puzzle (nutrient markers = sum of digit factorials, pangram) | 3 of 15 |
| Text file reading into arrays | 5 of 15 |
| Validation of data against a rule, adjusting values in ratio | occasional |

The typical task: **loop through the array(s), test each element,
accumulate or build the output, display in a memo/rich edit** - often
with a given `Display` procedure to call.

## 5. How it is marked (memos)

- A **marking grid per question**: one tick per step - extract from the
  component, convert, each condition, the loop, the calculation, the
  display, the format. Partial code earns most marks.
- **Alternative correct solutions get full credit** unless an
  instruction was ignored (e.g. a built-in sort, hard-coding, the
  required case statement not used).
- "Penalise once only for a logical mistake"; accept alternative maths
  functions, `Repeat` instead of `While`, the length of the array instead
  of a typed size.
- Formatting to two decimals, the separator mechanism, and the exact
  output text each carry their own tick.

## 6. What always appears (the CAPS checklist, Pascal part)

1. Component in -> convert -> calculate with maths functions -> formatted
   out.
2. A string task: split at a delimiter, loop over characters, build a
   result.
3. A case statement or if-chain on a code.
4. Random numbers into an array or a variable.
5. A classic algorithm from a flowchart (factors, primes, HCF, factorial,
   number bases).
6. One object class: constructor with defaults, accessor, mutator,
   update method, a band/formula method, a Boolean method, `toString`.
7. The form: instantiate from components, call each method, display.
8. Arrays - parallel and 2-D - searched, counted, totalled, sometimes
   sorted, with output built line by line.

## 7. Exam technique (CAPS)

- **Open and compile each project first**, and put the exam number in
  the first line of every unit before anything else.
- The questions are independent - **do the ones you are sure of first**;
  Question 1's small buttons are quick marks.
- **Use exactly the component and method names given** (`edtQ1_3`,
  `getNoOfHarvests`).
- **Match the example output**: text, spacing, two decimals, the dash
  separators.
- **Use the provided code and procedures** (the given `Display`
  procedure, the given `toString`) - don't rewrite them.
- **Follow a given flowchart step by step** - its structure is what the
  grid marks.
- Stuck: comment out code that stops compilation - an uncompilable
  project costs everything after it.
- Save after every button.

## 8. For the Pascal course

- **The skills match the course**; the setting doesn't. CAPS is a Delphi
  **GUI** exam: input comes from edits, spin edits, combo boxes and check
  boxes, output goes to panels, labels, memos and rich edits, inside
  click events of a form someone else built. The course is console
  Pascal (text UI), which is the IEB's setting. Lesson 23 (GUI design)
  introduces the components; a CAPS exam guide needs **reading from and
  writing to components in event handlers** (`StrToInt(edtX.Text)`,
  `spnX.Value`, `cmbX.Text`, `chbX.Checked`,
  `redX.Lines.Add`, `FloatToStrF`, `ShowMessage`).
- **CAPS OOP is simpler than IEB OOP:** one class, no inheritance, no
  array of objects, no file-reading manager. Lesson 16 (classes) covers
  all of it.
- **CAPS leans on 2-D arrays and flowchart algorithms** more than the IEB
  does. Course gaps against CAPS are in open-items.md (2-D arrays, LCM
  and GCD/HCF, Polya).
- **This file is the source for lesson 25, the CAPS practical guide**
  (Chris, 24 September 2026). Lesson 24 is the IEB guide. Lesson 25
  stands alone and may repeat lesson 24's general technique.

## 9. Question 2 - database programming (40 marks) - for the SQL course

Analysed 25 September 2026 from all 15 current-format papers and memos
(November 2018 - May/June 2026). Not for lessons 24-25; for the SQL
course ([courses/sql-course.md](courses/sql-course.md)). Dialect facts:
[sql-dialects.md](sql-dialects.md).

**Shape (fixed):** two tab sheets. **2.1 SQL - always five buttons, 19-25
marks** (mean 22); **2.2 Delphi - 15-21 marks** (mean 18), "NO marks will
be awarded for SQL statements in QUESTION 2.2". Always **one Access `.mdb`
(Jet 4.0) with exactly two tables, one-to-many** with referential
integrity, a relationship diagram on the data pages, `tbl` prefix,
PascalCase fields, the foreign key named like the primary key, 10-40
rows, blanks planted for IS NULL questions. The database is
password-protected - pupils see the data only through the program's
grids. A Restore button copies the backup over it.

**How the SQL is delivered:** the pupil only completes a string
(`sSQL1`..`sSQL5`, a global `sSQL` in 2026) inside a given click event;
given code runs it through a TADOQuery (Open or ExecSQL) into a DBGrid
and reports "the database has changed". Pupils never write TADOQuery
code. The paper names no functions - the wording does: "formatted as
currency" -> `FORMAT(x, "Currency")`; "rounded to two decimal places" ->
`ROUND`; "formatted to two decimal places" -> `FORMAT(x, "0.00")`; "in a
new field called X" -> `AS X`.

**2.1 - what comes up** (papers of 15 whose model answer needs it):

| Feature | Papers | Notes |
|---|---|---|
| SELECT fields + WHERE, one comparison | 15 | 2.1.1, 3 marks, always the easiest |
| Aggregate + AS; GROUP BY | 15; 15 | SUM 7, AVG 5, COUNT 5, MIN/MAX 0; GROUP BY on an expression 2, on two columns 2 |
| Two-table join | 13 | model answer always `FROM A, B WHERE A.PK = B.FK`, often with table aliases; INNER JOIN accepted |
| Any UPDATE/DELETE/INSERT | 13 | UPDATE 7, DELETE 5, INSERT ... VALUES 2 (2024); none in 25N, 26 |
| ORDER BY | 11 | DESC 5; two keys once |
| Calculated field | 10 | e.g. `(HoursWorked - 8) * HourlyWage * 2` |
| SELECT * | 9 | "all the details" |
| Compound AND | 9 | |
| User input glued into the SQL | 9 | InputBox, combo box, edit box; `"' + sVar + '"` with the SQL literal in double quotes; QuotedStr accepted; numbers bare |
| `FORMAT(x, "Currency")` | 9 | `FORMAT(x, "0.00")` once |
| LIKE | 8 | **always `%`** - `*` in no memo; contains 5, ends 2, starts 1 |
| Yes/No = True/False | 6 | `= Yes`, `= -1`, bare field accepted |
| HAVING | 6 | |
| Date functions | 6 | Month 3, Year 2, Date()/Now 2; `#yyyy/mm/dd#` required twice |
| LEFT / RIGHT | 4 / 1 | MID accepted; LEN never |
| Bracketed alias with spaces | 3 | `[Total Amount]` |
| ROUND; IS NULL; OR (with brackets) | 2 each | |
| INT, DISTINCT, TOP, BETWEEN, `&` | 1 each | `&` or `+` accepted |
| Subqueries, outer joins, MIN/MAX, IIF, LIMIT | 0 | |

**Order:** 2.1.1 easiest (3) -> 2.1.2-2.1.3 one idea each (LIKE, a date
function, the user-input item, IS NULL, TOP, a string function) -> 2.1.4
usually the heavy aggregate (GROUP BY + join + FORMAT + HAVING, 5-9) ->
2.1.5 usually the change (UPDATE/DELETE/INSERT).

**2.2 - what comes up.** Two global TADOTables, open and on grids. Model
answers always use `tblX['Field']`; FieldByName only as an alternative.

| Feature | Papers |
|---|---|
| `First` / `while not Eof` / `Next` | 15 (from 24N: one mark only if First and Next are both right, per table) |
| An If inside the loop, output to a RichEdit with `#9` tabs | 13 |
| Linking the two tables in code (PK = FK) - nested master/detail loops, or find then look up | 10 |
| Search for a user's value with a flag | 8 (a not-found message twice) |
| Insert/Append + fields + Post | 7 (none since 23N - INSERT moved to SQL) |
| Count in a loop | 6 |
| Copy/Pos/YearOf on field values | 6 |
| Edit + Post on the record selected in the grid | 5 |
| Edit/Post inside a loop (bulk change) | 3 - the recent trend (25MJ, 25N, 26) |
| Delete in a loop ("if match then Delete else Next") | 2 |
| Sum/average/percentage in a loop; validation; a text file with the database | 2-3 each |
| Locate, Filter, Lookup, RecordCount, master-detail components | 0 |

**Marking:** one mark per clause (fields, table, join condition, each
condition, ORDER BY, DESC; for aggregates the function, calculation, AS,
FORMAT, GROUP BY, HAVING). "Alternate correct solution ... full credit
unless instructions not followed." Accepted: INNER/LEFT JOIN, QuotedStr,
`+` for `&`, MID for LEFT, date ranges or Year()/Month() combinations,
`Year(Now)` or `Date()`, string tests on dates, `= Yes`/`-1`, COUNT(*) or
COUNT(field), IN for an OR chain, `ISNULL(x)`, DISTINCT or GROUP BY,
`DELETE * FROM`, ORDER BY a column number. Delphi per construct; Append
for Insert; any navigation for Post; repeat..until for while.

**Traps:** conditions only in the story (a venue, "more than 8 hours");
boundary words ("100 or more", "since 2019"); a combo value that is part
of the field ("TV" in "Smart TV"); OR with AND needs brackets; IS NULL,
not `= ""`; HAVING vs WHERE; every non-aggregated column in GROUP BY; an
alias can't be used in WHERE (repeat the expression); `[ ]` round an
alias with spaces; quotes round text input, none round numbers; missing
spaces between `'...' + '...'` lines. Delphi: Delete without Next;
children before the parent; resetting a counter inside the outer loop;
the not-found message after the loop, from a flag.

**The memos are sloppy** - treat them as concept lists, not runnable SQL
(20N drops a condition the grid needs; 21N's 2.1.2 has no WHERE; 22MJ has
`Year = 2002` for 2022).
