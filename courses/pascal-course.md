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
| 18 | lesson18 | Catching errors - Defensive programming | Syntax/runtime/logic errors, defensive programming (check first vs Try), exception classes, `On problem : Exception Do` + Message (particular handlers first), read a String then convert, **ReadInt / ReadIntInRange / ReadFloat / ReadBoolean** (I/O is their one job - allowed, see the I/O rule below), guards, validation vs verification, GIGO, the checks (presence...check sum), good error messages, Luhn check digit on lesson 13's ID, `Raise` in a setter, exceptions travel up, Try ... Finally (Good to Know), standard/extreme/abnormal test data, trace tables, generated test data, the debugger (Good to Know, Lazarus keys F5/F9/F7/F8/Ctrl+F5), GUI components and tricks (compiled with lazbuild, no-console). Babbage, Dijkstra quotes |
| 19 | lesson19 | It's a date - Dates and times | TDateTime (days since 30/12/1899), Now/Date/Time (the console's server is UTC; its DateToStr gives 23-9-26), FormatDateTime codes (**nn** minutes, words in double quotes, `/` = the machine's separator -> TFormatSettings), Encode/Decode (Word), StrToDate/TryStrToDate/IsValidDate, ReadDate, DaysBetween/IncDay/IncMonth, SameDate trap, days to the next birthday and school days to the end of term (While loop over dates - a For gives "Ordinal expression expected"), IncMinute/MinutesBetween (never Trunc: 07:20->08:00 gave 39), timing with Now + MilliSecondsBetween (Int64 introduced; loop to 100 million 254 ms vs formula 0 ms on the server), DayOfWeek (Sunday = 1), leap-year algorithm, **accurate age** (YearsBetween wrong ON the birthday), ID date + century rule + Y2K, yyyy-mm-dd in files, 2038 (Good to Know). Try-its in `pascal-tryit-dates.js`. Adams quote |
| 20 | lesson20 | Managing a list - the array manager class | **Part 1, exam-style `TPupilList`**: private array + count, named array types (`TPupilArray`, `TMarkArray` - a result type must be a name), constructor sets every place Nil so the destructor can free Low..High; Nil, `= Nil`, `Assigned`, Free on Nil safe, Assigned still TRUE after Free, FreeAndNil; objects as parameters (the same object, not a copy); GetPupil/FindBySurname/GetBest give back an object or Nil, IndexOf -1; **ownership** (the list owns what it is given - AddPupil frees one it has no room for; what it gives back is borrowed); GetMarks/PupilsInClass (first Nil ends the array), an array sent to a function; DeletePupil, SortByMark, RemoveDuplicates (While loops); LoadFromFile (gives back False, no message) / SaveToFile; TSchoolClass (object field that may be Nil, two arrays of different object types, does not own its teacher - has-a); comparing structures. **Part 2, working `TPupilManager`**: `current`, GetCurrent, GetPupil, First/Last/Next/Previous, FindPupil, AddPupil/InsertPupil/UpdatePupil (replace)/DeletePupil, SortByMark/SortBySurname, IsFull - every one gives back the current object; CRUD; menu program PupilApp (ReadPupil gives back a new object); buttons as a Good to Know. Try-it `managerLab` (`pascal-tryit-manager.js`, node test against fpc). Hoare "billion-dollar mistake" quote |
| 21 | lesson21 | Family trees - Inheritance and polymorphism | Running club: `TMember` (ancestor) and `TJunior = Class (TMember)` (guardian, age, pays half). Ancestor/descendant = superclass/subclass = parent/child = base/derived; TObject at the top; advantages; **`Inherited Create (...)`** first line; **protected** in use (helper `GetField (aLine, n)` used by the descendant; plain private/protected not enforced in one file - `strict private` shown); UML hollow triangle at the ancestor; **Virtual/Override** (without them juniors paid R250 - static binding); `Inherited GetMonthlyFee Div 2`, `Inherited ToString + ...`; lesson 16's ToString warning explained and gone (**`{$H+}`** in every listing, TMember.ToString Override); polymorphism, dynamic vs static binding, overriding vs overloading; **Is / As** (Is before As, EInvalidCast; `identifier idents no member`); **file with two kinds of line** - class chosen by number of fields (club) or a code letter (library exercise), descendant's `Create (aLine)` calls `Inherited Create (aLine)` then reads its extra fields, StringForFile Virtual; one array of the ancestor type; two errors blocks; is-a vs has-a (TCar = Class (TEngine) as the mistake); Abstract as a Good to Know. Try-it `bindingLab` (`pascal-tryit-inherit.js`, node test against 8 fpc runs). Exercises: TBook/TTextbook. Joe Armstrong banana/gorilla quote |
| 22 | lesson22 | Talking to people - Text user interfaces | Tested part small (important block): the six principles (structure, simplicity, visibility, feedback, tolerance, reuse), prompts (what, format, range, unit; Write + ": "), language/capitals/spelling, error messages (what, why, how to fix; from caught exceptions), columns (text left `Format ('%-22s')`, numbers right, same decimals), de facto keys, colour with meaning, desktop vs mobile, **interface separate from the class**. Tools: screen plan (title row 1, message row 22, keys row 24), **ClrEol** (title bar in a background colour; message line; wipes a box edge), DrawBox reused unchanged, ReadKey menus (#0 then #59 = F1; Esc #27), tolerance (ReadYesNo). Running example **TBooking** (school play) - the class lesson 23 puts behind a form. **Every Crt screen is a real server run** (`content/pascal/screens/lesson22-*.ans`, drawn by TerminalScreen(); tools in `tools/ui-screens/crt`). Try-its readKeyLab (new), formatLab, gotoGrid. Jef Raskin quote |
| 23 | lesson23 | Windows, buttons and boxes - GUI design | Mostly for the PAT (important block lists the tested theory: separation, validating components, metaphors, standards, clutter and colour). Forms/components/properties/events, event-driven; TBooking moved to unit **uBooking**, form unit uBookingForm (handler's three jobs; ShowTotal asks the class - no prices in the form); naming prefixes (Learn box - **Chris to confirm the list**); every important component with **real Lazarus screenshots** (`public/assets/lessons/pascal/lesson23-*.png`, captured at 125%, shown at 80%; tools in `tools/ui-screens/lazarus`); choosing components; **TMaskEdit in depth** (mask;save;blank, Learn table, SA masks, Text vs EditText, EDBEditError on leaving an incomplete mask - check it yourself); alignment/spacing/grouping/tab order; Align/Anchors/BorderSpacing/TSplitter (small vs big screenshots); metaphors + TBitBtn kinds; standards (Default, Cancel, KeyPreview + VK_F1, &); colour wheel, schemes, 60-30-10, contrast 4.5:1, `$00BBGGRR` trap, palette tool links; fonts, and a **missing font silently replaced** (Agency FB vs not installed, real screenshots); a bad form with 12 numbered badges vs the good one; **first step: the main form is frmMain** (Caption, Position poScreenCenter - Chris 24 Sep); prefix table with a real picture of each component; collapsible list of every Windows 11 font drawn from its file; Google Fonts and installing; **loading a font privately** (AddFontResourceEx + FR_PRIVATE, real FreeSerif demo) and a Good to Know InstallFontForUser (asks first; compiled, not run). Try-its colourWheel, maskEditLab (checked against 23 real TMaskEdit runs by `pascal-tryit-ui.test.js`). Steve Jobs "Design is how it works" quote |

Lesson 13 also teaches the ID number **check digit** (Luhn: odd positions as
they are, even positions doubled minus 9 if over 9, check digit =
`(10 - total Mod 10) Mod 10`), with an algorithm block, `t24bIdCheckDigit` and
exercise `c34bIdCheckDigit` (23 Sep 2026).

## Lessons still to come (plan, Chris 23 September 2026)

Don't build a lesson until Chris asks; these are the notes for whoever does.
Each needs everything in content-voice-and-pedagogy.md §8 and a `sags.php`
entry. Items marked (SAGs) close gaps found in the 23 September SAGs check.

- **18 - testing, debugging and exceptions** - BUILT 23 Sep 2026 as lesson18 (see the table); everything below is covered.
  Should cover (SAGs 4.13, 4.14, 4.12 Gr 11): standard, extreme and abnormal
  test data; trace tables as a skill; syntax vs runtime vs logic errors,
  compared; the Lazarus debugger (breakpoints, watches, stepping) - a Good to
  Know, since the site can't do it; generated test data; exception handling
  (`Try ... Except`, `On E : Exception Do`, `E.Message`); validation checks -
  presence, range, length, type, uniqueness, check digit (lesson 13 has one),
  checksum - in conditional loops; descriptive error messages that say how to
  fix the problem, and messages built from caught exceptions.
- **19 - It's a date: working with dates and times** - BUILT 23 Sep 2026 as lesson19 (see the table). (SAGs 4.3 Gr 11): `TDateTime`
  (a Real: days since 30 Dec 1899), `Now`, `Date`, `Time`, `DateToStr`,
  `StrToDate`, `TryStrToDate`/`IsValidDate` for checking input, `EncodeDate`/
  `DecodeDate`, `FormatDateTime` (`'dd/mm/yyyy'`, `'hh:nn'` - `nn` for
  minutes), `DayOfWeek`, `DaysBetween`, `IncDay`, `YearsBetween`; an **accurate
  age** (birthday not yet reached this year); the date part of an ID number
  (lesson 13) and the 1900/2000 problem; `TFormatSettings` for date formats
  (lesson 7 set this up); leap years as an algorithm. Verify every output with
  fpc - date formats follow the locale.
- **20 - Array manager class** - BUILT 24 Sep 2026 as lesson20 (see the table), one lesson with both the exam-style and the working-program manager (Chris). (SAGs 4.3 Gr 12, 4.5 Gr 12, 4.6 Gr 11-12, 4.8
  Gr 11): a class whose field is an array of objects plus a count (`TPupilList`
  / `TClassList`) with Add, Find (returns an index or the object), Delete,
  Sort, Remove duplicates of objects, load/save through lesson 17's file
  methods, ToString; **objects as parameters** (passing an object to a method)
  and **returning an object** from a function, returning `Nil` when not found,
  `Nil` objects and fields, `Assigned`; returning an array and an array of
  objects; an object as a field of another; an object whose fields are arrays
  of two different object types; comparing data structures (parallel arrays vs
  array of objects vs manager class).
- **21 - Inheritance and polymorphism** - BUILT 24 Sep 2026 as lesson21 (see the table). (SAGs 4.1 Gr 12, 4.3 Gr 12, 4.5 Gr
  11-12): superclass/subclass (`Class (TPerson)`), `protected` in use,
  `Inherited` in constructors and methods, `Virtual`/`Override`, polymorphism
  and dynamic binding, `Abstract`, an array of inherited objects, type checks
  with `is` (and `as`), object-as-field vs inheritance (has-a vs is-a),
  advantages of inheritance, inheritance in class diagrams. Revisit lesson 16's
  ToString warning (hiding the inherited one) once `Override` is taught.
- **22 - Designing a text user interface** - BUILT 24 Sep 2026 as lesson22 (see the table). (SAGs 4.12 Gr 10-11): good-UI
  principles - structure, simplicity, visibility, feedback, tolerance, reuse;
  menus, prompts, error messages that suggest a fix, consistency and de facto
  standards (F1 help, Esc cancel), uncluttered screens and colour (lesson 3's
  Crt, lesson 5's ReadKey); desktop vs mobile interfaces; the object as a
  backend separate from the interface (lesson 16).
- **23 - Designing a GUI user interface** - BUILT 24 Sep 2026 as lesson23 (see the table). (SAGs 4.12 Gr 11): forms and
  components in Lazarus/Delphi (the site can't run a GUI - screenshots and
  steps); events; metaphors and icons; validation components (drop-downs,
  calendars); keeping logic out of event handlers so the same class works in a
  text program.
- **24 - Practical exam guide - IEB** - BUILT and live 25 Sep 2026 as lesson24: the paper (text-based, SQL + algorithms +
  OOP, 150 -> 100 marks, cognitive levels 30/40/30), how it is marked
  (marking-house-style.md: marks per step, carry-forward, style not marked),
  reading a question, planning, testing, saving, common mark losses.
  Built from [../ieb-practical-exam-analysis.md](../ieb-practical-exam-analysis.md)
  (24 Sep 2026). **Section B (OOP, 100 marks) only - SQL (Section A, 50
  marks) is a separate course (Chris, 24 Sep 2026)**; lesson 24 names it
  as the other half of the paper and no more.
- **25 - Practical exam guide - CAPS** - BUILT and live 25 Sep 2026 as lesson25 (Chris, 24 Sep 2026): the DBE
  Paper 1 - Delphi GUI, Questions 1 (general, 40), 3 (OOP, 40) and 4
  (problem solving, 30); Question 2 (database, 40) belongs to the SQL
  course. **Stands alone** - a CAPS pupil need not have done lesson 24 - so
  it may repeat lesson 24's general technique (only answer what is asked,
  any data, first-principles sorts, comment out broken code, match the
  output). Built from
  [../caps-practical-exam-analysis.md](../caps-practical-exam-analysis.md);
  it must teach reading from and writing to components in click events,
  which the console course otherwise does not.
- **26 - The data validation task - IEB** (title with IEB, Chris 25 Sep 2026) - BUILT and live 25 Sep 2026 as lesson26 (Chris:
  "extract and discuss the rubric, show how to plan and structure the task -
  add an ability to upload the task for a pre-evaluation ... stress that the
  final say is the teacher's"). The IEB mark sheet (SAGs Appendix A, 50) line
  by line, the component table, the eight checks, messages, testing, the
  document; a `taskreview` block for a PDF pre-check.
- **27 - The PAT - IEB** (title with IEB, Chris 25 Sep 2026) - BUILT and live 25 Sep 2026 as lesson27: the IEB 2026 rubric -
  specifications 15, design 30, code 40, technical and testing 15 - borrowed
  code and AI (20%), the interview; a `taskreview` block per part (documents
  as PDF, the code as source files or a PDF).
- **28 onwards - the CAPS tasks** (Chris, 25 Sep 2026: "they will need to be
  the lessons that come after the IEB data validation and the IEB PAT").
  Researched in [../caps-tasks.md](../caps-tasks.md): CAPS has no data
  validation task; the DBE Grade 12 PAT (two phases, 48 + 86 + 16 = 150,
  Delphi with a database and SQL) and the yearly alternative task. Proposal
  there - Chris to decide before building.

Not in this course: data representation (binary, hex, bits, signed/unsigned,
overflow, how a Real is stored - SAGs 4.2) goes in the theory course.

## Glossary and index (Chris, 24 September 2026 - built)

**Glossary** - `content/pascal/glossary.php` (one row per term: term,
grade, examined, lessonId, anchor, definition, extras `also`/`image`/`url`;
the format is described at the top of the file), read by `lib/glossary.php`.
- **One definition per term:** `Gloss()` shows the glossary's definition
  whenever its term, or one of its `also` names (plural "s" ignored), is in
  the glossary; the definition written in the lesson is only a fallback for
  a term the glossary lacks (only "hubris" today). Definitions are plain
  text - no HTML, bold or code (popups escape them, the PDF can't show it).
- **Every term is in** (276, drafted from every popup and study key term);
  not examined = **plum** (`is-not-examined`, "not examined" in the PDF).
  **Grades and plum marks are a first draft for Chris to check.**
- **Grade per term** (10/11/12, from the SAGs line it belongs to - a lesson
  spans grades), with grade checkboxes, a search box and an A-Z bar on
  `glossary.php?c=pascal`. Table: Term | Definition | Illustration | Taught
  in (link to the lesson section).
- **Illustrations mostly blank**; the 19 GUI components use lesson 23's real
  Lazarus pictures. They matter when the glossary is reused in theory.
- **Place:** an unnumbered "A-Z Glossary" row after the last lesson on the
  course page, shown when the course has a glossary file.
- **PDF:** `glossary-pdf.php?c=&g=10,11` (the grades ticked), `lib/pdf.php`.
- Check: `php bin/check-glossary.php` (taught-in place real, grade, plain
  text, no name used twice, pictures exist; notes popups not in it).

**Index** - every course has its own (`lib/courseindex.php`), from **Index**
in the top bar of the course, lesson and glossary pages: a `<dialog>` popup
with a search box and a Cancel button (`assets/course-index.js`); Enter or a
click goes straight to the place. Built from the lessons, so new lessons are
indexed automatically: lesson titles, contents sections, algorithm blocks,
`errors` block titles and their messages (file position and memory address
removed), glossary terms (where taught), and popup terms the glossary lacks.
No grades, **no PDF**. Fetched from `api/course-index.php` when first
opened; cached in the temp folder until any content file changes.

## Course decisions

- **Lessons 22-23 (Chris, 24 Sep 2026):** "test is simple for exams - whole lesson is good to know"; lesson 23 "is mainly for PAT". Each has an `important` block naming the tested part; the study notes follow it. Pictures of Crt screens and windows must come from real runs (see `tools/ui-screens/README.md`), never drawings.

- **Exceptions for school = a plain `Try ... Except`** (Chris, 23 Sep 2026):
  lesson code uses it; `On problem : Exception Do` + `Message` only where the
  message is needed (a class's own `Raise`). Exception classes (`EConvertError`
  etc.), per-class handlers and their order are a Good to Know.
- **Chris's `>` tip** (23 Sep 2026): for whole numbers he always uses `>` and
  moves the number (`>= 15` -> `> 14`) - a Good to Know in lesson 18, with the
  Real caveat. Not a house-style rule; `>=` stays correct.
- **The validation-check table is Learn / Memorise** (lesson 18); so are the
  three kinds of test data.
- **Planned order:** procedures and functions go **above the main program's
  `Var`**, so they can't see its variables - everything comes through
  parameters.
- **Every lesson opens with the "programming is a practical subject" notice**
  (`PracticalSubjectNotice()` in `lib/content.php`; lesson 1 full, others
  `(true)` short). Change the wording only there.
- **Every lesson has:** one `contents` block, a `study` block (PDF too), SAGs
  coverage in `content/pascal/sags.php` (lessonId => [grade, subtopic, what];
  lesson 3 `'enrichment' => true`), CAPS coverage in `content/pascal/caps.php`
  (lessonId => [grade, term, what], from the 2024 CAPS amendment's Section 3;
  `bin/check-sags.php` checks both), and the checks in
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
- **`{$H+}` and ToString Override (Chris, 24 Sep 2026):** from lesson 16 on, every program with a class starts with `{$H+}` under the Program line (a compiler switch, not a comment - Lazarus puts it in every new project) and declares `Function ToString : String; Override;` - no warning. Without `{$H+}`, Override on ToString is an error. Lesson 16 teaches both as "learn the line as it is" (like `Destructor Destroy; Override;`); lesson 21 explains them. Programs without a class are unchanged. Marker rubrics accept ToString with or without Override and never deduct for `{$H+}`. With `{$H+}` the 255-character String limit is gone (lesson 20's warning about it was removed), and ToString on a freed object stopped with an Access violation instead of printing half a pupil (lesson 20's error item re-run).
- **Files inside a manager (lesson 20, 24 Sep 2026 - Chris to confirm):** LoadFromFile/SaveToFile live in the manager class; they never talk to the user (LoadFromFile gives back False and the caller writes the message). The "methods never read or write" rule is taken to mean keyboard and screen.
- **Method names never reuse a Pascal built-in** (Chris, 24 Sep 2026): `Insert`/`Delete` are built in, so a class has `AddPupil`, `InsertPupil`, `UpdatePupil`, `DeletePupil`, `FindPupil` (`AddSong`, `AddProduct`...).
- **I/O in routines (settled, Chris 23 Sep 2026):** a procedure or function
  may read or write when that is its very specific purpose (`DrawBox`,
  `ReadInt`); otherwise never. Class methods never. See pascal-house-style.md §5.
- Known layout-check gap: a nested `Else If` without `Begin ... End` trips the
  indent rule (lessons wrap the inner If).

## Verified fpc facts used in lessons

- Crt on the server's xterm (lesson 22): ReadKey Enter #13, Backspace #8, Tab #9, Esc #27; F1-F10 #0 then #59-#68; Up/Down/Left/Right #0 then #72/#80/#75/#77; Home #71, Insert #82; End and Delete come through as rubbish. ClrEol fills to the line end in the current TextBackground. TextBackground (White) shows light grey. Crt sends ESC[6n and waits for the reply.
- Lazarus 4.2 TMaskEdit (lesson 23, keys typed with WM_CHAR): literals typed for you; a key the place won't take is ignored; `>`/`<` change case as typed; `;0;` Text = typed characters only, `;1;` keeps literals, blanks -> spaces; leaving with a required place empty raises `EDBEditError: The current text does not match the specified mask.`; setting Text in code skips the rules. lazbuild: `lblTotal.Caption := GetTotal` -> `Got "LongInt", expected "TTranslateString"`; `Key = F1` -> `Identifier not found "F1"` (VK_F1 from LCLType); `edtName.Caption := ''` compiles.

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
- Classes: `Function ToString : String;` without Override warns about hiding
  the inherited one (`"ToString:AnsiString;"` with `{$H+}`, `ShortString`
  without); Override errors without `{$H+}`; `private` doesn't protect within the same
  file (`strict private` does); a field below `Class Var` is shared too;
  `Destructor Destroy;` without Override only warns and Free never calls it;
  using an object never created -> 216.
- Inheritance (lesson 21, `{$H+}`): Override with no Virtual in the ancestor, or a different heading -> `There is no method in an ancestor class to be overridden: "GetMonthlyFee:LongInt;"`; forgotten Override -> `An inherited method is hidden by "GetMonthlyFee:LongInt;"` and the ancestor's method runs; without `{$H+}` ToString Override -> the same error for `"ToString:ShortString;"`. A descendant method through an ancestor variable -> `identifier idents no member "GetGuardian"`; ancestor into descendant variable -> `Incompatible types: got "TMember" expected "TJunior"`; As on the wrong object -> `EInvalidCast: Invalid type cast` (a hard cast `TJunior (member)` printed rubbish endlessly - never taught); Nil Is X -> FALSE; `strict private` used by a descendant -> `Identifier not found "name"`; `Result := ToString + ...` without Inherited -> a managed-result warning and another member's text; Abstract -> `Constructing a class "TShape" with abstract method "GetArea"` then `EAbstractError: Abstract method called`. A Virtual method called from the ancestor's own code runs the descendant's version.
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
- Dates (both machines): the server's DefaultFormatSettings are `d/m/y` with `-` (DateToStr 23-9-26; `'dd/mm/yyyy'` prints 23-09-2026), the Windows testbed `yyyy/MM/dd`; server clock UTC. `mmm` is Sep (server) / Sept (Windows). `'hh mm'` gives the month, `'Born dd'` -> BOR5 23, `'Today is dddd'` -> EConvertError: Illegal character in format string. YearsBetween = Trunc (days / 365.25): 23/09/2012 -> 23/09/2026 gives 13. StrToDate two-digit years: window 50 (75 -> 2075 in 2026). `date := Date` with a variable called date compiles and gives day 0.
- `Double` is a type name - a function called `Double` becomes a conversion.
- Repeat counting down from 0 prints 0 and leaves -1.

## Quotes and portraits

Every quote is verified (Wikiquote or a primary source) and portraits are free
for commercial use (Wikimedia Commons, byte size matched), cropped to 256px, in
`public/assets/quotes/` and `Quote images/`; sources in each lesson's doc
comment. Weakly sourced (swap if a primary source appears): Adams's ASCII
line (lesson 7), Gates's "artistry" line (lesson 3), Adams's terminal line
(lesson 5). Gates's "640 KB" is labelled disputed in the lesson.
