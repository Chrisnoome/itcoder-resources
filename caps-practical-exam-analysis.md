# CAPS (DBE) IT practical exam - analysis, Pascal only

Built 24 September 2026 from every DBE NSC Information Technology Paper 1
and memo in `CAPS/Caps prac exams` (2016-2026, November and
Feb/March and May/June). The twin of
[ieb-practical-exam-analysis.md](ieb-practical-exam-analysis.md).
**Pascal only (Chris, 24 September 2026): Question 2 (database and SQL,
40 marks) is left out** - SQL is a separate course. Syllabus reference:
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
