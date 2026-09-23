# Course: Programming in Pascal (`pascal`)

`Projects/AIPascalCourse/content/pascal/`, status `open`, live. IEB IT Grades
10-12. Syllabus [../sags-topic4-syllabus.md](../sags-topic4-syllabus.md);
code [../pascal-house-style.md](../pascal-house-style.md); voice and lesson
rules [../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md).
Other chats may be writing lessons at the same time - edit exactly, never
overwrite unread work.

## Lesson ids are not lesson numbers - never rename

The key in `content/pascal/index.php` is the lessonId, a database key in six
tables (`quizResponses`, `writtenAnswers`, `codeSubmissions`,
`activityState`, `lessonPositions`, `performanceReviews`). Renaming a file
silently orphans every answer. `proofoflife.php` is lesson 2, `lesson02.php` is
lesson 4.

## Lessons

| # | File | Title | Notes |
|---|---|---|---|
| 1 | lesson01 | What you learn when you learn programming | Computational thinking, not syntax; "the computer is stupid" (jam-sandwich reveal); selection in Pascal/Python/JS; Pascal built to teach; fetch-decode-execute. Feynman, Jobs quotes |
| 2 | proofoflife | Proof of Life / Output - WriteLn and Write | **Core thesis, to recur:** a program must produce output or you can't know it did anything. IPO planning order vs learning order (Output -> Input -> Processing); Program/Begin/End.; naming rules; Write vs Writeln; commas; `:width:decimals`; `''`; `#9`; reading real compiler errors; fix-the-code written questions (`starterText`). No Readln (no variables yet). Pratchett quote |
| 3 | lesson03 | Making it pretty | **Enrichment, no marks at all.** Units as an idea (`Uses`); Crt: ClrScr, TextColor/TextBackground, GotoXY, WhereX/WhereY, Delay, Sound. Newton, Gates quotes |
| 4 | lesson02 | How to remember - Variables and constants | Memory, names, types, Integer range (32-bit), `Div` vs `/`, type mismatch errors, assignment, Inc/Dec, **NB: always give a variable a starting value** (proved: an uninitialised local printed 1240 instead of 6), Random, **constants** (`Const` above `Var`, `=`, no type; errors `Variable identifier expected`, `"=" expected but ":=" found`). Wirth, Gates "640 KB" (labelled disputed) quotes |
| 5 | lesson05 | Getting input - Readln, Read, ReadKey and KeyPressed | **Only Readln is exam content** (an `important` block says so; study notes mirror it). Read vs Readln = Write vs Writeln. Readln crash table (Integer + letters/decimal -> 106; empty -> 0; String never crashes; `12 apples` -> 12). Band-rubric capstone (markMax 10). Treasure, Adams quotes |
| 6 | lesson06 | Processing - basic maths | BODMAS, `/` vs Div/Mod (truncate toward zero), Round (half to even) / Trunc, Abs/Sqr/Sqrt/Power/Max/Min (Math unit), RoundTo |
| 7 | lesson07 | Type conversion | IntToStr/StrToInt (EConvertError, not 106), Chr/Ord, Char<->String (`word1[1]`), Real<->Integer; FloatToStr/StrToFloat/Format are locale-dependent -> `TFormatSettings` with `DecimalSeparator`. Never say "widening"/"narrowing". Adams quote |
| 8 | lesson08 | Decisions / Branching | Comparisons as Booleans, If/Then/Else, Else If, And/Or/Not (logic-gate circuits; brackets round each comparison), Case, choosing If vs Case. Gleick quote |
| 9 | lesson09 | Division - Div, Mod, Trunc and Round | Div/Mod with If (buses), odd/even and factor algorithms. 50 marks. Knuth quote |
| 10 | lesson10 | For loops | For/DownTo, inclusive ends, zero-run ranges, **never change the counter inside; never single letters**, accumulators, nested loops, checkerboard, prime check to `Trunc (Sqrt (number))` (1 wrongly reports prime - disclosed). "Repetition", never "lap". 100 marks. Larry Wall quote |
| 11 | lesson11 | Looped algorithms | A loop as a problem-solving tool (intro says so); total/average with input, typewriter, times table (multiples), factors, Fibonacci, factorial (<= 12; 13! wraps), largest/smallest, nested loops, square, hollow box, triangles. `Length` only new Pascal. Whitehead quote |
| 12 | lesson12 | Flexible loops - While and Repeat | Pre/post check, three things a While needs, infinite loops (Apple's 1 Infinite Loop callout), user-controlled loops, stop values, input checking, For/While/Repeat rule. Repeat from 0 prints 0 and leaves -1. Frost, anonymous "insanity" (**never Einstein's face**), Adams quotes |
| 13 | lesson13 | Working with text - String handling | Strings as Char rows, loop patterns, underlining, reversing, palindromes, case, Caesar, Copy/Pos/Delete/Insert/Trim, replace, split at a delimiter, Format, columns, password strength, SA ID number, initials, run-length. Wittgenstein, Twain, Suetonius, Schneier quotes |
| 14 | lesson14 | Procedures, functions, parameters and units | DRY (TillSlip), decomposition, procedures, parameters, functions (`Result`), rules, MarkSlip, units (Interface = menu of headings; Implementation = kitchen, with the comments), MyUtils, Var parameters as Good to Know only. Descartes, Hunt & Thomas, Fowler, Dijkstra quotes |
| 15 | lesson15 | Arrays | Definition, storage, noOfElements, `Const maxElements`, For over arrays, sum/average/biggest/smallest, parallel ("linked") arrays, sequential and binary search (index or -1), swap, selection and bubble sort (with flag), sorting text with UpperCase, insert/delete, duplicates; Good to Know: arrays to functions via `Type`, dynamic arrays, any index range. Array demos (`array-demo.js`). Wirth, Torvalds, Knuth, Obama quotes |
| 16 | lesson16 | Classes and objects | Class vs object, fields/methods, encapsulation, access modifiers, constructors (setters), getters/setters, ToString, **no I/O in methods**, overloading, static members, destructors, UML class diagrams, array of objects, theory boxes. **No inheritance/polymorphism.** Jobs, Kay quotes |
| 17 | lesson17 | Persistence - Text files | Persistence, text files, AssignFile/Reset/Rewrite/Append/CloseFile, `While Not Eof`, CSV/delimiters, parsing in `Create (aLine)`, loading an array of objects, `StringForFile`, buffers and Flush, FileExists, Try...Except, messy data, JSON (Gr 12 theory) |
| 18 | lesson18 | Catching errors - Defensive programming | Syntax/runtime/logic errors, defensive programming (check first vs Try), exception classes, `On problem : Exception Do` + Message (particular handlers first), read a String then convert, **ReadInt / ReadIntInRange / ReadFloat / ReadBoolean** (frontend routines that Writeln/Readln - lesson 14's one-job exception, Chris to confirm), guards, validation vs verification, GIGO, the checks (presence...check sum), good error messages, Luhn check digit on lesson 13's ID, `Raise` in a setter, exceptions travel up, Try ... Finally (Good to Know), standard/extreme/abnormal test data, GUI components and tricks (compiled with lazbuild, no-console). Babbage, Dijkstra quotes |

Lesson 13 also teaches the ID number **check digit** (Luhn: odd positions as
they are, even positions doubled minus 9 if over 9, check digit =
`(10 - total Mod 10) Mod 10`), with an algorithm block, `t24bIdCheckDigit` and
exercise `c34bIdCheckDigit` (23 Sep 2026).

## Lessons still to come (plan, Chris 23 September 2026)

Don't build a lesson until Chris asks; these are the notes for whoever does.
Each needs everything in content-voice-and-pedagogy.md §8 and a `sags.php`
entry. Items marked (SAGs) close gaps found in the 23 September SAGs check.

- **18 - testing, debugging and exceptions** (another chat is building it).
  Should cover (SAGs 4.13, 4.14, 4.12 Gr 11): standard, extreme and abnormal
  test data; trace tables as a skill; syntax vs runtime vs logic errors,
  compared; the Lazarus debugger (breakpoints, watches, stepping) - a Good to
  Know, since the site can't do it; generated test data; exception handling
  (`Try ... Except`, `On E : Exception Do`, `E.Message`); validation checks -
  presence, range, length, type, uniqueness, check digit (lesson 13 has one),
  checksum - in conditional loops; descriptive error messages that say how to
  fix the problem, and messages built from caught exceptions.
- **19 - It's a date: working with dates and times** (SAGs 4.3 Gr 11): `TDateTime`
  (a Real: days since 30 Dec 1899), `Now`, `Date`, `Time`, `DateToStr`,
  `StrToDate`, `TryStrToDate`/`IsValidDate` for checking input, `EncodeDate`/
  `DecodeDate`, `FormatDateTime` (`'dd/mm/yyyy'`, `'hh:nn'` - `nn` for
  minutes), `DayOfWeek`, `DaysBetween`, `IncDay`, `YearsBetween`; an **accurate
  age** (birthday not yet reached this year); the date part of an ID number
  (lesson 13) and the 1900/2000 problem; `TFormatSettings` for date formats
  (lesson 7 set this up); leap years as an algorithm. Verify every output with
  fpc - date formats follow the locale.
- **20 - Array manager class** (SAGs 4.3 Gr 12, 4.5 Gr 12, 4.6 Gr 11-12, 4.8
  Gr 11): a class whose field is an array of objects plus a count (`TPupilList`
  / `TClassList`) with Add, Find (returns an index or the object), Delete,
  Sort, Remove duplicates of objects, load/save through lesson 17's file
  methods, ToString; **objects as parameters** (passing an object to a method)
  and **returning an object** from a function, returning `Nil` when not found,
  `Nil` objects and fields, `Assigned`; returning an array and an array of
  objects; an object as a field of another; an object whose fields are arrays
  of two different object types; comparing data structures (parallel arrays vs
  array of objects vs manager class).
- **21 - Inheritance and polymorphism** (SAGs 4.1 Gr 12, 4.3 Gr 12, 4.5 Gr
  11-12): superclass/subclass (`Class (TPerson)`), `protected` in use,
  `Inherited` in constructors and methods, `Virtual`/`Override`, polymorphism
  and dynamic binding, `Abstract`, an array of inherited objects, type checks
  with `is` (and `as`), object-as-field vs inheritance (has-a vs is-a),
  advantages of inheritance, inheritance in class diagrams. Revisit lesson 16's
  ToString warning (hiding the inherited one) once `Override` is taught.
- **22 - Designing a text user interface** (SAGs 4.12 Gr 10-11): good-UI
  principles - structure, simplicity, visibility, feedback, tolerance, reuse;
  menus, prompts, error messages that suggest a fix, consistency and de facto
  standards (F1 help, Esc cancel), uncluttered screens and colour (lesson 3's
  Crt, lesson 5's ReadKey); desktop vs mobile interfaces; the object as a
  backend separate from the interface (lesson 16).
- **23 - Designing a GUI user interface** (SAGs 4.12 Gr 11): forms and
  components in Lazarus/Delphi (the site can't run a GUI - screenshots and
  steps); events; metaphors and icons; validation components (drop-downs,
  calendars); keeping logic out of event handlers so the same class works in a
  text program.
- **24 - Practical exam guidelines**: the paper (text-based, SQL + algorithms +
  OOP, 150 -> 100 marks, cognitive levels 30/40/30), how it is marked
  (marking-house-style.md: marks per step, carry-forward, style not marked),
  reading a question, planning, testing, saving, common mark losses.
- **25 - PAT guidelines**: the 100-mark Grade 12 PAT (may start in Grade 11) -
  phases, documentation (specification, design, technical, testing), help
  systems, a multi-table database from code, GUI, what moderators look for.

Not in this course: data representation (binary, hex, bits, signed/unsigned,
overflow, how a Real is stored - SAGs 4.2) goes in the theory course.

## Course decisions

- **Planned order:** procedures and functions go **above the main program's
  `Var`**, so they can't see its variables - everything comes through
  parameters.
- **Every lesson opens with the "programming is a practical subject" notice**
  (`PracticalSubjectNotice()` in `lib/content.php`; lesson 1 full, others
  `(true)` short). Change the wording only there.
- **Every lesson has:** one `contents` block, a `study` block (PDF too), SAGs
  coverage in `content/pascal/sags.php` (lessonId => [grade, subtopic, what];
  lesson 3 `'enrichment' => true`; `bin/check-sags.php`), and the checks in
  content-voice-and-pedagogy.md §8.
- **Study notes follow what's examined**, not everything mentioned (lesson 5's
  split between Readln and the rest is the model for any syllabus/enrichment
  mix).
- **Learn / Memorise boxes show every instruction in full**, with parameters
  and what it gives back (`Round (x)` gives an Integer; `choice := ReadKey;`),
  including Gloss terms inside them.
- **A question about code shows a whole, formatted program** in the question's
  `'code'` field (compiled first); `'prompt'` holds only the question.
- **Code-writing questions** set `'codeAnswer' => true` (fix-the-code gets it
  from `starterText`); marked strictly (platform.md decision 17) with the flat
  1-mark layout deduction; pupils never see "house style". `starterText`
  pre-fills a written box; a saved answer wins over it.
- **`markerRubric`** carries exact detail; the shown `rubric` stays vague
  (model: `w2FirstProgram` in proofoflife).
- **Every example and error is compiled with fpc 3.2.2 `-Mobjfpc`**; nothing is
  invented. Crt output can only be checked on the test site.
- **I/O in routines (settled, Chris 23 Sep 2026):** a procedure or function
  may read or write when that is its very specific purpose (`DrawBox`,
  `ReadInt`); otherwise never. Class methods never. See pascal-house-style.md §5.
- Known layout-check gap: a nested `Else If` without `Begin ... End` trips the
  indent rule (lessons wrap the inner If).

## Verified fpc facts used in lessons

- `Integer` 32-bit under `-Mobjfpc`; a computed overflow wraps silently
  (`50000 * 50000` -> -1794967296; 13! -> 1932053504).
- Uninitialised: main-program globals start at 0 (warning); a routine's local
  holds whatever was in memory. An unset function `Result` came back as
  Integer 21418212 / 4394040, Boolean TRUE, Char random.
- Readln: Integer + letters/decimal -> Runtime error 106; empty -> 0; `12
  apples` -> 12; `'  7'` -> 7. StrToInt: leading spaces only;
  `'15 '`, `'3.5'`, `'1e3'`, `''` -> `EConvertError: "x" is an invalid
  integer`; `'007'` -> 7. StrToFloat allows spaces both sides and `1e3`.
- Div/Mod by 0 -> Runtime error 200; `/` by 0 -> 208; Sqrt of a negative ->
  207. Div/Mod truncate toward zero (`-7 Mod 2` = -1). Round is half to even;
  `RoundTo (2.675, -2)` = 2.67.
- Output `:w:d` rounds half up (2.5:0:0 -> 3; 2.675:0:2 -> 2.68); a too-small
  width never truncates; `'Hi':5` -> `'   Hi'`; a Real with only a width prints
  scientific.
- Format: `%05d` pads with spaces (`%.5d` zero-pads); a wrong specifier or too
  few values -> `EConvertError` quoting its own pattern; `%f` follows the
  locale. Pos is case-sensitive, 0 = not found; Copy past the end is forgiven;
  in-place replace-all loops for ever when the replacement contains the
  search text.
- Arrays: a fixed out-of-range index only warns; a variable one is silent
  (`marks[6]` of 5), far out crashes 216; with `-Cr`/`{$R+}` -> 201.
  `Writeln (marks)` -> "Can't read or write variables of this type". A program
  can't share its name with a variable.
- Classes: `Function ToString : String;` warns about hiding the inherited one
  (Override errors without `{$H+}`); `private` doesn't protect within the same
  file (`strict private` does); a field below `Class Var` is shared too;
  `Destructor Destroy;` without Override only warns and Free never calls it;
  using an object never created -> 216.
- Text files: no CloseFile after Rewrite + Writelns leaves an empty file;
  1000 Writelns without CloseFile kept 987 lines; Append onto a file with no
  final end-of-line joins lines; a blank last line crashes a parse
  (`"" is an invalid integer`); Reset/Rewrite/Append on an open file closes it
  first; Readln past the end gives ''. Runtime errors 2/102-105 become
  `EInOutError` with SysUtils. (Windows testbed only - run NoClose/BigWrite on
  the server once.)
- Exceptions (with SysUtils): Div/Mod 0 -> `EDivByZero: Division by zero`;
  `10 / 0` -> `EZeroDivide`; `0 / 0`, `Sqrt (-10.0)` -> `EInvalidOp: Invalid
  floating point operation` (207 without SysUtils); Readln Integer given abc ->
  `EInOutError: Invalid input`; `{$R+}` -> `ERangeError: Range check error`;
  Nil object -> `EAccessViolation: Access violation`. `On Exception` above
  `On EConvertError` swallows it, no warning. StrToInt also reads `$1F`, `x12`,
  `0x1F` (hex), `%101`, `&17`, skips leading tabs; `'2147483648'` wraps to
  -2147483648 with no error. `StrToBool ('yes')` -> EConvertError. A Writeln
  with a failing Div inside prints half a line first.
- `Double` is a type name - a function called `Double` becomes a conversion.
- Repeat counting down from 0 prints 0 and leaves -1.

## Quotes and portraits

Every quote is verified (Wikiquote or a primary source) and portraits are free
for commercial use (Wikimedia Commons, byte size matched), cropped to 256px, in
`public/assets/quotes/` and `Quote images/`; sources in each lesson's doc
comment. Weakly sourced (swap if a primary source appears): Adams's ASCII
line (lesson 7), Gates's "artistry" line (lesson 3), Adams's terminal line
(lesson 5). Gates's "640 KB" is labelled disputed in the lesson.
