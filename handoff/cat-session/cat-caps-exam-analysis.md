# CAPS (DBE) CAT exams - analysis of Paper 1 and Paper 2

Built from every DBE NSC Computer Applications Technology paper and memo in
`sources/cat/caps/`: **November 2023, 2024 and 2025**, Paper 1 (practical)
and Paper 2 (theory) - **six papers**. Read with `pdftotext -layout`, with
pages rendered as images where a table or a mark allocation mattered, and
the Paper 1 data files opened with `openpyxl`, `python-docx` and `mdbtools`.
Official format in [caps.md](caps.md) §4.3-4.4 and §4.7; twin of
[ieb-exam-analysis.md](ieb-exam-analysis.md).

**One memo is missing.** `NSC_CAT_2023_Nov_P2_Memo.pdf` is **not** the
Paper 2 memo: it is a second copy of the November 2023 **Paper 1** marking
guidelines. The two 2023 memo PDFs are different files byte for byte, but
`pdftotext` gives identical text - both open "COMPUTER APPLICATIONS
TECHNOLOGY **P1** / NOVEMBER 2023 / MARKING GUIDELINES" and both carry the
P1 question totals 24-21-17-23-35-15-15. `sources/cat/SOURCES.md` noticed
the identical file sizes without spotting why. So **every marking claim
below about Paper 2 rests on the 2024 and 2025 memos only**, and the 2023 P2
memo must be re-downloaded before anyone relies on this file for that year
([course-plan.md](course-plan.md) §5, question 11).

**Counts.** Every numbered sub-question that carries a mark was counted from
its right-aligned mark annotation: **149 parts in each Paper 1** (the
150th mark is Question 6's unnumbered "closing tags and nesting" mark) and
**87, 93 and 88 parts in the three Paper 2s**, of which Section A's
matching question is annotated "(10 x 1)" rather than per item. Close, not
exact.

---

# PART ONE: PAPER 1 - PRACTICAL

## 1. The paper at a glance

**3 hours, 150 marks, seven questions, all compulsory.** The structure has
not moved in three years:

| Question | Content | 2023 | 2024 | 2025 | CAPS target |
|---|---|---|---|---|---|
| 1 | Word processing | 24 | 25 | 22 | - |
| 2 | Word processing | 21 | 20 | 23 | - |
| | **word processing total** | **45** | **45** | **45** | ~45 |
| 3 | Spreadsheet | 17 | 21 | 22 | - |
| 4 | Spreadsheet | 23 | 19 | 18 | - |
| | **spreadsheet total** | **40** | **40** | **40** | ~40 |
| 5 | Database | 35 | 35 | 35 | ~35 |
| 6 | Web design (HTML) | 15 | 15 | 15 | ~15 |
| 7 | General (integration) | 15 | 15 | 15 | ~15 |

**Every year hits the CAPS target exactly.** The split inside the two word
processing questions and inside the two spreadsheet questions moves by a few
marks; the four subtotals do not.

**One scenario for the whole paper**, set out on its own page: car brands and
a shuttle company (2023), the solar system and a space shop (2024), a
tertiary institution called TechnoGeek (2025). Each question then names its
own data file - `1Courses`, `2Brochure`, `3Lecturers` - and the file names
start with the question number.

**Parts per paper: 49-50**, sizes 1 to 7 marks. Across the three papers:

| Part size | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
|---|---|---|---|---|---|---|---|
| Parts | 29 | 38 | 26 | 26 | 21 | 8 | 1 |

So **43% of parts are worth 1 or 2 marks** and only 6% are worth 6 or more.
The biggest single part in three years is 2024 Q4.6, a nested IF worth 7.

### The standing instructions (on every cover)

1. You may **not leave the room early**, even if you finish.
2. Follow the invigilator's instructions if you work on the network or the
   files were preloaded.
3. Make sure **every answer file is saved** where you were told.
4. Make sure all files can be read; do not save unnecessary or duplicate
   files; **do not delete original files you did not work on**.
5. The **information sheet is completed after the three-hour session** and
   handed to the invigilator.
6. A copy of the master files is available from the invigilator.
7. Seven questions; answer all of them.
8. **Read each question before answering, and do NOT do more than it asks.**
9. Save each document under the file name given; save regularly.
10. No resource material.
11. **Accuracy will be taken into account.**
12. Regional settings South Africa; date, time, number and currency settings
    correct.
13. Language English (South Africa); A4 portrait unless told otherwise;
    centimetres.
14. **The Developer tab and the Ruler must be activated.**
15. Decimal symbol a full stop, list separator a comma.
16. **Formulae and/or functions for ALL spreadsheet calculations**, absolute
    references only where needed, and **the answer must stay correct if the
    data changes**.
17. **You may NOT use a word processor for the HTML question.**
18. Borders around images in the paper are for clarity only - do not add
    them.
19. Use the correct setting or feature for the question.
20. The data files come as a **password-protected `.exe`**: double-click,
    Extract, Show Password, type the password (2023 `1234cars`, 2024
    `N#24@`, 2025 `TG25#`), verify the contents, **delete the `.exe`**, and
    rename the folder with your examination number.

**Attached to the paper:** an **HTML tag sheet** (the same ~45 tags each
year: basic, text, links, formatting, image and table tags), an **input mask
character sheet** (the standard Access list), two blank planning pages, and
an **information sheet** the candidate fills in afterwards - centre number,
examination number, work station, **which Office suite** (2016 / 2019 / 2021
/ 365) and **which browser** (Firefox / Chrome / Internet Explorer / Edge)
were used, the folder name, and the file name, saved tick and attempted tick
per question.

## 2. The data files

Every paper ships 14-19 files (2023: 15, 2024: 19, 2025: 14), named with the
question number they belong to.

| Kind | What it holds | Notes |
|---|---|---|
| **Word processing** `.docx` | 2-3 files, 3-12 pages each | The big one (1.3-1.5 MB in 2024 and 2025) is Question 1's, full of images, styles, a cover page, a citation source list and a bookmark |
| **Spreadsheet** `.xlsx` | 3-6 files | Usually 1-3 worksheets. The data sheet runs 25-65 rows and 5-18 columns; a second, small worksheet holds the lookup table (2024 `Session` 4x2, 2025 `Courses` 3x10) and a third holds the chart |
| **Database** `.accdb` | exactly one | Two or three tables, **never a relationship** (see §5) |
| **HTML** `.html` | exactly two, 37-56 lines | Deliberately incomplete or broken |
| **Images** | 3-7 `.jpg`/`.png` | To insert into a document, a form, or a web page |

**Three Access files, three shapes:**

| Year | File | Tables | Fields |
|---|---|---|---|
| 2023 | `5Shuttle.accdb` | `tbl5_1` (7 fields), `Pre-bookings` (7) | Name, Surname, StartDate (**stored as Text**), Car, LicenceNo, Rating (Byte), Amount (Currency); and Name, Surname, ContactNo, IDNo, DepartDate, Reason, KMTravel |
| 2024 | `5Inventory.accdb` | `tbl5_1` (7), `tblStock` (7), `tblMembers` (4) | Employees; Code, Product, Category, Cost, InStock, InventoryValue, SellingPrice; StartDate, Surname, Name, CellNo |
| 2025 | `5Records.accdb` | `tbl5_1` (5), `tblStudents` (11) | LeaveDate, Name, Surname, ContactNo, Qualification; StudentNo (the only NOT NULL), Name, Surname, ID, DOB, ContactNo, E-mail, EnrolmentDate, EnrolmentType, FeesOutstanding, Progress |

**No paper has a relationship, a join, or a second table inside one query.**
`tbl5_1` is always the table whose *design* is edited; the named table
(`Pre-bookings`, `tblStock`, `tblStudents`) is always the one the forms,
queries and reports run off. Nothing is password-protected, so pupils can
see the data.

**The HTML starters are broken on purpose.** 2025's `6_2Popular.html` opens
its table with `< border="1">` - the tag name is simply missing; 2024's
`6_2Mars.html` has a stray `<width="200" align="left" size="6" color="Red">`
where an `<hr/>` should be; 2023's `6_1Win.html` has a `</th>` with no
opening tag and an `<img src="6_2Father.gif">` pointing at a `.jpg`.
Question numbers appear as HTML comments (`<!--6.1.1-->`) marking where the
answer goes, and the paper says not to delete them.

## 3. Questions 1 and 2 - word processing (45 marks)

8-10 parts across the two questions, **1-5 marks each**. The first
instruction of both questions is always "insert your examination number in
the header".

**What comes up** (papers of 3 in which the model answer needs it):

| Feature | 2023 | 2024 | 2025 |
|---|---|---|---|
| **A built-in cover page**, inserted or modified, with content controls removed or edited | Retrospect | Slice (Dark) | modify the existing one |
| **Find and replace with formatting** - character spacing, small caps, raised text, a symbol from Webdings by character code | yes (expanded 1 pt, scale 150%) | yes (small caps + raised 3 pt) | yes (symbol, code 209, double underline, Match Case) |
| **Styles** - create, modify, name a new one, or change a list style | list style 'Planets' *(2024)* | shadow on style 'Solar' | create style 'Tech' with a 3 pt border |
| **Page numbering** - format, restart, different odd and even, X of Y | - | Page X of Y, odd left / even right | 'i, ii, iii' starting at i on the last page, Bracket 2 format |
| **Headers, footers and the file path** | file path, last page only | file path in footer | - |
| **A section-only change** (a border, orientation or watermark on one page) | border, first page only | orientation of last page; watermark on last page only | page border, first page, measured from edge |
| **Images** - insert, size exactly, wrap, border thickness, picture style, remove a background | Soft-Edge Rectangle style | 3 pt border | remove black background; size to 6 x 9 cm, square wrap |
| **A table** - build it, merge, rotate text, autofit, sort, **a `=SUM(LEFT)`-type formula** | modify to match a picture, move data in | convert text to table + a List Tables style | merge, rotate, autofit, delete a row, formula for a 10% fee |
| **SmartArt** - add a bullet, change layout, 3-D style, shape | Continuous block process, 3-D Cartoon, right to left | - | add a bullet and sub-bullet, change shape to Right arrow, add a border |
| **Drop cap / decorated first letter** | yes (shading) | - | yes (Corbel Light, 6 lines, 0.2 cm) |
| **References** - citation, bibliography, endnote, index, caption, cross-reference, bookmark | caption; bookmark + link | cross-reference; endnote with 'a, b, c'; bibliography in APA | edit a citation (year, page); mark index entries; insert a Modern index |
| **Keep with next / keep lines together** | yes | yes | - |
| **Legacy form fields** (the Developer tab) - text format, maximum length, date format | 4 parts, Q2.5.1-2.5.4 | - | - |
| **Line spacing, indents, tabs, columns** | narrow margins | exactly 20 pt + 1 cm hanging | multiple 1.4; first line 1 cm + justify; line between columns |
| **Proofing language, document properties** | - | author property | proofing language English (South Africa) |

**The pattern:** roughly half the marks are for finding a named piece of text
and applying an exact, named setting; the other half are for **matching a
picture**. A part that shows "display as shown in the example below" carries
3-6 marks and the memo lists one tick per visible difference.

## 4. Questions 3 and 4 - spreadsheet (40 marks)

5-7 parts per question, **1-7 marks each**, with the biggest part always a
nested IF or a lookup.

**The memo's standing rules, printed above every spreadsheet question:**

- **Mark from the formulae, not from the value in the cell.**
- Check against the candidate's own work - **cell references may differ**.
- **Multiple formulae, helper cells or "building blocks" are allowed** (the
  data file sets aside a space for them).
- **Named ranges** may replace cell references.
- The answer must still be correct if the data changes.

**Functions the memos' model answers use** (counted over the three P1
memos; a function may be asked for by name in the question):

| Function | 2023 | 2024 | 2025 |
|---|---|---|---|
| `IF` (usually **nested**, or with `AND`) | yes | **7 uses** | **7 uses** |
| `SUMIF` / `SUMIFS` | SUMIFS | SUMIF | both |
| `COUNT` / `COUNTA` / `COUNTIF` / `COUNTIFS` | COUNTIF, COUNT | COUNTIFS | COUNTA, COUNT |
| `MAX` / `MIN` / `LARGE` / `SMALL` | all four | MIN, LARGE | MAX, LARGE |
| A lookup - `HLOOKUP`, `VLOOKUP`, `XLOOKUP` | HLOOKUP, XLOOKUP | VLOOKUP, XLOOKUP | HLOOKUP |
| Text - `LEFT`, `RIGHT`, `MID`, `LEN`, `FIND`, `CONCATENATE` | FIND, LEN, MID, RIGHT | LEFT, MID, CONCATENATE/CONCAT/`&` | FIND, LEN, MID, RIGHT |
| Date and time - `TIME`, `HOUR`, `MINUTE`, `SECOND`, `TODAY`, `NOW`, `DAY`, `DATE` | TIME, HOUR, MINUTE, SECOND | TODAY, DAY | NOW, DATE, TIME |
| `RANDBETWEEN` | - | - | yes |
| `SUM` and the basic operators | yes | yes | yes |

**A spreadsheet *feature*, not a function, is asked for in every paper**
(3-5 marks): conditional formatting with a two-colour scale (2023 Q3.4),
conditional formatting from a cell's value (2024 Q3.7), an icon set with
edited rules (2025 Q4.4), freeze panes (2025 Q4.2), a data-validation
drop-down list (2025 Q7.2), subtotal with a page break per group (2024
Q7.4), moving a worksheet to a new workbook (2024 Q3.1), tab colour, a
comment, sheet rename, decimal places, print options.

**A chart is modified in every paper** (4-6 marks): change the type,
add a series, switch row/column, smooth a line, vary colours by point,
change a gridline's dash type, re-label.

## 5. Question 5 - database (35 marks)

**Ten parts every year**, and the same five blocks every year:

| Block | Marks | What it asks |
|---|---|---|
| **5.1 Table design** (4-5 sub-parts) | 9-13 | field properties, in Design View |
| **5.2 A form** | 3-6 | modify `frm5_2` to match a picture |
| **5.3-5.6 Queries** (3-4 of them) | 12-15 | criteria, calculated fields, sorting |
| **The last query or one of them** | 4-5 | a **calculated field** |
| **5.6/5.7 A report** | 4-6 | grouping, a function in the group footer |

**Table design - what comes up:** `Required: Yes` (2023, 2025); an **input
mask** (2023 `000000>LLL9`, 2025 `000\ 000\ 0000`); a **validation rule plus
validation text** (2023 rating 1-5, 2024 a date range with `Date()`, 2025
`Between #2025/09/01# AND #2026/01/31#`); a **format** (`dd-mmm-yy`, `>` for
capitals); **field size** (a South African ID number); **unique / primary
key / indexed no duplicates**; **lookup properties**; a **new field of type
OLE Object or Attachment** for a picture; and, in 2024 only, **importing a
spreadsheet as a new table**.

**Queries - what comes up:** criteria with `AND` and `OR` together and the
**brackets or row layout that makes the logic right** (2023 Q5.3, 2024 Q5.4,
2025 Q5.5 - 5 marks each, and the hardest query of the paper every year);
`Is Null` (2025); a wildcard or date-part criterion for a month (2023
`Like "2023/12/*"`); **sorting descending**; **unticking Show**; a **new
calculated field** (2023 `Total` at R6,25/km, 2024 `Profit`, 2025 `Age` from
`(NOW()-[DOB])/365.25`); and a **Totals / Group By with SUM and a sort**
(2024 Q5.5). Number of expected records is printed in the memo.

**Reports:** always a **function in the group footer**, always `=Count(*)`
or `=Count(` any field, plus landscape orientation, a header change, a
label, moving a field to the group header, exporting to PDF (2023), or
making a field visible (2025).

## 6. Question 6 - web design, HTML (15 marks)

**Two files, always.** 6.1 is the bigger one (9-11 marks over 4-6 parts);
6.2 is a single 3-5 mark part - "complete the web page to resemble the
example". **One mark, printed separately, is for closing tags and correct
nesting across both files**, every year.

**The memo's rules:** *"This question should be marked from the HTML code"*
and *"numerical attribute values and single words do not need to be in
inverted commas."*

**What comes up** (all three papers):

| Task | 2023 | 2024 | 2025 |
|---|---|---|---|
| `<title>` text | - | - | yes |
| `bgcolor` or `background` on `<body>` | light blue | - | `#ADB9CA` |
| Centre a heading and image | - | - | `<center>` or `align="center"` |
| `<img>` attributes - `width`, `height`, `align`, `alt`, `border` | yes | insert an image | `alt="Icons"` |
| `<hr/>` with `size`, `width`, `color` | - | - | width 75%, size 5 |
| A hyperlink `<a href>` - to a URL, to a page, on an image, to a bookmark | link a table heading to a page | image link to a URL | 3-mark link: anchor tags + `href` + link text |
| Table tags - `<table>`, `<tr>`, `<td>`, `<th>`, `colspan`, `cellpadding`, `border` | `<th>` for 'Home' | **6-mark part**: `cellpadding`, columns, a list | fix a broken `<table>`, `<th colspan="4">`, `<td>` |
| Lists - `<ol>`, `<ul>`, `type`, `<li>` | yes | yes | - |
| `<br/>` | - | - | yes |
| A comment | - | examination number as a comment | - |

**Everything is from the tag sheet.** No CSS, no `<div>`, no JavaScript, no
form tags, no `<span>`, no external stylesheet - and the tag sheet itself has
not changed in three years except for 2024 and 2025 closing the void tags
(`<img ... />`, `<hr/>`) where 2023 left some of them open.

## 7. Question 7 - general / integration (15 marks)

3-4 parts, **2-5 marks each**, and this is where the applications meet.

| Task | 2023 | 2024 | 2025 |
|---|---|---|---|
| **Mail merge** - link a document to a spreadsheet source, filter recipients, insert merge fields, merge to a new document | - | envelopes, filter to new members, merge and save as `7Merged` (5) | link, filter on **two courses with OR**, insert one field, **do NOT complete the merge** (5) |
| **A chart in a word processing document** | - | modify to match a picture (4) | - |
| **A linked object that updates automatically** | - | linked icon to a spreadsheet (2) | - |
| **A spreadsheet feature across sheets** | print settings: columns A-G on page 1, row and column headings (2) | subtotal by category with a page break per category (4) | data-validation list from another sheet + a `SUMIF`-based percentage (5) |
| **A spreadsheet function** | time arithmetic (notify 90 minutes before, 5); `DAYS`-type subtraction (3) | - | `TIME(RANDBETWEEN(...))` for a 15-minute slot between 07:00 and 10:00, filled down (5) |
| **Build an image** in a word processor from WordArt and pictures, grouped and **saved as an image file** | 5 | - | - |

## 8. How Paper 1 is marked (the memos)

- **A marking grid per question**, with the file name at the top and
  "Total Q*n*" beside it. Each part has a short criteria heading, then a
  bullet per mark with a tick, then the part's maximum in one column and a
  blank "Candidate Mark" column.
- The first line of every question's grid: *"Check the accuracy and skill
  required before awarding a mark throughout."*
- **One tick, one step.** A 5-mark `SUMIFS` scores separately for the sum
  range, each criteria range and each criterion. A 4-mark image question
  scores separately for the insert, the wrapping, the height and the width.
  **Partial answers earn most of their marks.**
- **Alternatives are listed with `OR`** and all of them are accepted:
  `MAX(...)` or `LARGE(...,1)`; `CONCATENATE` or `CONCAT` or `&`; `LEFT` or
  `MID`; `Date()` or `Now()`; `>=1 And <=5` or `1 or 2 or 3 or 4 or 5`;
  `Like "2023/12/*"` or `>=#2023/12/01#`; `Count(*)` or `Count(` any field;
  `OLE Object` or `Attachment`; `000\ 000\ 0000` or `000" "000" "0000`.
  Tolerances are given where a picture is matched (2025 Q6.1.5: *"Width
  75% (accept between 65% and 85%)"*).
- **`Alt+F9` is printed** for every field code the marker must check
  (`{ INDEX \e " · " \h "A" \c "2" }`, `{ FILENAME \p \* MERGEFORMAT }`,
  `{ HYPERLINK \l "Contact" }`, `{ =D4*10% }`).
- **Some ticks say "mark by inspection"** - autofit, a colour, a picture
  match.
- Database queries print the **number of expected records**, so a marker can
  check the result rather than the design grid.
- **Concepts are listed before the ticks** for the hardest parts (2025 Q3.6
  spells the three conditions of the nested IF out in words before giving
  the six ticks).

## 9. Exam technique to teach (Paper 1)

- **Extract the data files first and delete the `.exe`**; rename the folder
  with the examination number. Open every file once to check it reads.
- **Put the examination number in the header before anything else** -
  Questions 1 and 2 both say so, and it is a mark in some papers.
- **Do exactly what is asked and no more** (instruction 8). Extra
  formatting earns nothing and can lose the "as shown in the example" mark.
- **Use formulae, never typed answers**, and make them survive a data change
  (instruction 16). The memo marks the formula, not the number.
- **Helper cells are legal** - the data file sets aside space for building
  blocks, and the memo accepts them. Break a hard function into two cells.
- **Match the example picture detail by detail**; each difference is a
  separate tick. Read the NOTES under a picture - they give the exact size,
  font, thickness or style.
- **Database: type the criteria in the right row.** `AND` across a row, `OR`
  down the rows - this one skill is worth 5 marks a year.
- **HTML from the tag sheet only**, in a text editor, never Word; keep the
  question-number comments; check that every tag closes and nests - that is
  a mark on its own.
- **Save each file under the name the question gives, and save often.**
- **Time:** 150 marks in 180 minutes - about 1.2 minutes a mark. Question 5
  (database, 35 marks) needs about 40 minutes.

---

# PART TWO: PAPER 2 - THEORY

## 10. The paper at a glance

**3 hours, 150 marks, ten questions in three sections.** All three papers
are identical in shape, and match the CAPS §4.4 table exactly:

| Section | Question | Topic | 2023 | 2024 | 2025 |
|---|---|---|---|---|---|
| **A** | 1 | Multiple choice (10 items) | 10 | 10 | 10 |
| | 2 | Matching columns (10 rows, options A-T) | 10 | 10 | 10 |
| | 3 | True/false with correction (5 items) | 5 | 5 | 5 |
| | | **Section A** | **25** | **25** | **25** |
| **B** | 4 | Systems Technologies | 25 | 25 | 25 |
| | 5 | Internet and Network Technologies | 15 | 15 | 15 |
| | 6 | Information Management | 10 | 10 | 10 |
| | 7 | Social Implications | 10 | 10 | 10 |
| | 8 | Solution Development | 15 | 15 | 15 |
| | | **Section B** | **75** | **75** | **75** |
| **C** | 9 | Integrated scenario | 25 | 25 | 25 |
| | 10 | Integrated scenario | 25 | 25 | 25 |
| | | **Section C** | **50** | **50** | **50** |

**Section C's two scenarios are always school-sized and South African:** a
community hall's gaming room and a school racing-car competition (2023); a
school's 50th-birthday e-magazine and a school triathlon (2024); a school
coding and robotics club and a Grade 8 orientation week (2025). The scenario
is 2-4 lines, and **each part adds a fact of its own** ("the club needs
laptops", "drones will be used to capture videos") rather than referring
back.

### The standing instructions (on every cover, and worth teaching)

1. Section A (25), Section B (75), Section C (50).
2. Answer all the questions; number them as the paper does; **start each
   question on a new page**; leave a line after each sub-question; do not
   write in the right-hand margin.
3. **"Generally, one mark is allocated per fact; therefore, a 2-mark question
   would require TWO facts."**
4. **"Do NOT give more answers than the question requires as it will NOT be
   marked."**
5. **"All answers MUST be related to Computer Applications Technology."**
6. **"Unless otherwise specified, answers such as 'cheaper', 'slower'/
   'faster', etc. will NOT be accepted."**
7. **"Do NOT use brand names in your answers, unless specifically
   required."**

## 11. Question formats

### 11a. Section A - auto-markable (25 marks, 17% of the paper)

| Format | Items | How it looks and is marked |
|---|---|---|
| **Multiple choice** (Q1) | 10 per paper, 30 in all | Four options A-D, letter only. Stems: "Which ONE of the following ...", a description ending in a definition, a **bold negative** ("which statement is FALSE", "which is NOT netiquette"), a sentence with a gap ("the ... setting can be adjusted"), **a screenshot of a dialog** (2025 Q1.8, a paragraph-settings box), or **a database criterion to evaluate** (2025 Q1.10, four `Sport =`/`Grade` expressions). Near-miss distractors throughout (CPU/GPU/NIC/RAM; brightness/contrast ratio/resolution/aspect ratio). |
| **Matching columns** (Q2) | 10 rows against **20 lettered options A-T**, 30 rows in all | One mark a line, letter only. **Always twice as many options as rows**, and the spares are near misses (RAM against ROM, zombie against botnet, patch against service pack, style against theme, NFC against RFID, IF against COUNTIFS). |
| **True/false with correction** (Q3) | 5 per paper, 15 in all | *"Correct the statement if it is FALSE by changing the underlined word(s). Do NOT simply use the word 'NOT'. **NO mark will be awarded if only FALSE is written.**"* Two worked examples are printed above it. The memos add: **award the mark if the correct term is given without the word FALSE**, but never for FALSE alone. In 2025, 3 of the 5 were false. |

### 11b. Sections B and C - written answers (125 marks, 83%)

223 parts over the three papers. Sizes:

| Marks per part | 1 | 2 | 3 |
|---|---|---|---|
| 2023 | 23 | 45 | 4 |
| 2024 | 33 | 43 | 2 |
| 2025 | 21 | 52 | 0 |

**There is nothing bigger than 3 marks in any of the three papers, and 2025
has nothing bigger than 2.** Two marks is the standard part (140 of the 223,
63%); one mark is the rest. This is the single biggest difference from IT's
Paper 2, which runs algorithms and class diagrams at 6-10 marks.

**"TWO" appears in 96 of the 223 parts; "ONE" in 25; "THREE" in 3** (2023
Q10.1.1, 2024 Q4.4 and one other). A 2-mark part almost always means "give
TWO of something".

### 11c. Command verbs

Counted on the instruction sentence of each of the 223 parts in Sections B
and C:

| Verb | Parts | Size | What the memo wants |
|---|---|---|---|
| **Give** | 37 | 1-2 | "Give TWO reasons/advantages/disadvantages/examples"; any N from a longer memo list |
| **State** | 31 | 1-2 | the same, slightly more clipped; bare nouns or short phrases score |
| **Name** | 28 | 1-2 | the exact term, one per mark |
| **Explain** (+ "briefly explain" 10) | 35 | 1-2 | two concepts: what it is + what it does, or cause + effect |
| **What** (+ "what is" 8, "what does" 5) | 26 | 1-2 | the implied verb - a name or a definition |
| **Which** | 13 | 1 | a name: which feature, which function, which network type |
| **Suggest** | 9 | 1-2 | a measure that would actually work |
| **Describe** (+ "briefly describe" 2) | 10 | 2 | as "explain" |
| **Discuss** | 6 | 2 | a point with its elaboration; never more than 2 marks |
| **Why** | 7 | 1-2 | a reason |
| **Motivate** | 5 | 1-2 | a reason tied to the choice just made |
| **Recommend** | 4 | 1-3 | a workable option per mark |
| **How** | 3 | 1-2 | a mechanism |
| **Define** | 2 | 2 | what it is + its distinguishing feature |
| **Differentiate**, **identify**, **list**, **name and briefly describe** | 1 each | 1-2 | one fact per side; one item per mark |

**Combined parts** appear a few times a year and are worth 2-3: "Explain what
biometric security is **AND** give ONE example" (2024 Q4.2), "Briefly
describe what data protection is **AND** give ONE method" (2023 Q7.3),
"Suggest a network communication medium. **Motivate your answer**" (2025
Q9.2.2 - choice 1 + reason 1).

### 11d. Stimulus material

Sparse compared with the IEB. **Three or four visual stimuli per paper**:

- **A spec comparison** for Section C's buying decision - two quotations side
  by side in 2025 Q9.1 (display, RAM and storage, CPU with cores and clock
  range, 802.11 b/g/n, warranty, antivirus, OS, Office version, coding
  software); a single specification list in 2023 Q9.1.
- **A screenshot of an application** - a spreadsheet with a LOOKUP-style
  level column (2025 Q8.3), a conditional-formatting rule dialog (2025 Q8.6),
  a defragmenter (2024 Q4.11), a database report extract (2024 Q6.6), a chart
  that is hard to read (2025 Q6.5), a database field list (2025 Q8.5), an
  e-mail with a bad subject line (2024 Q5.8).
- **A few lines of HTML to read** - 2025 Q8.7 (`<img src="Well done" alt=...>`
  and `<a href="#Stars">`, three parts, 4 marks), 2023 Q8.7, 2024 Q8.4.
- **An entry form to critique** (2023 Q10.1, 5 marks over two parts) - the
  one place a picture carries real weight.

**"Name what is pictured" is almost never asked.** 2023 Q5.8 ("analyse the
picture below and give the term and description for the process") is the
only clear instance in three papers.

## 12. What the theory paper actually asks about

Read across the 223 parts, the same ground comes up every year.

| Question | In all three papers | Also seen |
|---|---|---|
| **4 Systems (25)** | storage and backup; a **troubleshooting part** (a monitor with no display 2025, a projector's "No Signal" 2024, a resolution error 2023); an **accessibility feature**; a **utility or file-management feature**; an **operating-system concept** | UPS, plug-and-play, drivers, file attributes, GUI customisation, defragmenting, spooling, convergence, 3D printing, ergonomics, Creative Commons licensing, multi-user systems, flawed software, biometric security |
| **5 Internet and networks (15)** | a **network device or medium**; a **connection or speed** idea; a **cloud or 4IR** idea; an **online-service benefit or risk** | ISP services, AUP, wireless access points, intranet, NIC, PAN, VoIP, video conferencing, tabbed browsing, incognito browsing, upload/download speed, accessibility of a website, podcast, mobile remote access |
| **6 Information Management (10)** | **the PAT by name** (report elements, folder structure, task definition, report writing); **evaluating a source**; **questionnaire design**; **reading a chart or report** | URL shorteners, spreadsheet vs database for research data, ways to present findings, acknowledging an image source |
| **7 Social Implications (10)** | **malware or an e-mail threat**; **protecting yourself**; **a legal or ethical issue** | click-jacking, online harassment, big data and privacy, software piracy, green computing, social engineering, internet attacks, data protection, network administrator's duties, ICT's global impact |
| **8 Solution Development (15)** | a **word processing feature named** (styles, tab stops with a leader, a table of figures, an index, a column break); a **spreadsheet feature or error** (`#NAME?`, a zero total, conditional formatting, autofill, a function to name); a **database concept** (a data type, a field size, a validation rule, a query criterion to read); an **HTML tag to explain** | embedded vs linked object, `<th>` vs `<td>`, OLE object, protected cells, reading `Like "??an*"`, reading `<0 or >=5` |
| **9 and 10 Integrated (25 each)** | **a buying decision from a spec**; **a network for the situation**; **a data-gathering method**; **an application to choose**; **an emerging technology** (VR/AR, drones, RFID, autonomous cars, NFC, crowdfunding, QR codes); **a word processing or spreadsheet feature for the job** | BYOD, plagiarism, POPI Act metadata, cybersecurity, mail merge, online forms, cloud storage, OCR, card readers |

**The PAT is examined in the theory paper.** Question 6 names it directly -
"name TWO elements of a report that must be included in your final practical
assessment task (PAT) report" (2025 Q6.2), "state TWO factors ... when
creating your folder structure" (2025 Q6.4), "what is the importance of
report writing in the PAT?" (2023 Q6.1).

## 13. How Paper 2 is marked (the 2024 and 2025 memos)

**The marker's standing notes, printed in both memos:**

- Re-read the question with the candidate's answer **so you are not misled by
  a keyword**; read the whole answer, not the keywords.
- **Accept correct answers expressed differently** - the example given is that
  the memo says "slow" and the candidate writes "not fast".
- **Beware of overlapping answers. In general, ONE mark is awarded per fact.**
- **Do not choose answers on the candidate's behalf**: where the question says
  LIST or NAME, **mark the first N facts** - so if five are given and two were
  asked for, mark the first two, even inside a paragraph.
- **Longer answers are a single unit**: a correct statement anywhere in the
  paragraph earns its mark.

**In the body of the memo:**

- Each part opens with a one-line restatement of what was asked, then a
  numbered list of acceptable facts, then **"✓✓ (Any two)"** or **"✓ (Any
  one)"** and the mark. The list is always longer than the marks: a 2-mark
  part typically lists 3-5 acceptable facts, sometimes 8.
- 2025's memo uses "(Any two)" 34 times and "(Any one)" 6 times; 2024's uses
  them 28 and 15 times.
- **Notes to the marker** are frequent in 2024 (about 16 of them) and rare in
  2025: *"Do not accept a repetition of the question"*; *"Accept any valid
  example"*; *"Accept any TWO answers"*; *"Do not accept only examples
  without an explanation"*; *"Do not allocate marks for layout
  explanations"*.
- **No half marks anywhere.**
- The cover's rejections are enforced: **"cheaper", "faster", "slower" alone
  score nothing**, brand names score nothing unless asked for, and an answer
  that is not about CAT scores nothing.

## 14. Exam technique to teach (Paper 2)

- **Marks = facts.** Two marks, two different facts. Extras are not marked -
  and the memo takes **the first two**, so putting the best answer first
  matters.
- **Never write "faster", "cheaper" or "easier" on its own.** Give the
  mechanism or the comparison. The cover says so, and the memos enforce it.
- **No brand names** unless the question asks for an example of a product.
- **A definition has two parts**: what it is, and what it does or how it
  differs. Rewording the question earns nothing (2024's memo says so twice).
- **True/false: write the replacement word.** "False" alone scores nothing;
  the right term without the word "False" still scores.
- **Matching: there are twice as many options as rows**, and the spares are
  near misses - read all twenty before starting.
- **Multiple choice: watch the bold NOT and FALSE.**
- **Use the stimulus when there is one** - read both quotations before
  answering "why is Quotation 2 better", and quote the figure.
- **Answer in CAT terms**, and keep it to the subject.
- **Time:** 150 marks in 180 minutes - about 1.2 minutes a mark. Section A's
  25 marks should take 15 minutes, leaving about 80 minutes for Section B and
  55 for Section C.

## 15. Cognitive levels

CAPS sets the theory paper at **40% lower order, 40% middle, 20% higher**
([caps.md](caps.md) §4.7) and the practical at **30 / 40 / 30**. **No
analysis grid is published with any of these six papers**, so the actual
split cannot be checked from the sources collected - the DBE does not put
one in the paper or the memo. What can be said from the papers themselves:

- Paper 2's **Section A (25 marks, 17%) is entirely recall**, and so is a
  large share of Section B's 1-mark parts (77 of the 223 B and C parts are
  1 mark). That is broadly consistent with a 40% lower-order target.
- Paper 2's **higher-order work sits in Section C**: choose between two
  quotations and justify; recommend a medium and motivate; suggest what to
  do about a problem. That is 50 marks, not all of it higher order - so 20%
  is plausible.
- Paper 1's higher order is the nested IF, the two-condition query, the
  6-mark table-matching parts and Question 7's integration - by inspection
  about a third of the paper, matching the 30% target.

## 16. Implications for the course's question types

Measured against `kit/platform.md`'s block types and
`kit/content-voice-and-pedagogy.md` §4:

**Paper 2 is unusually kind to an auto-marking platform.** Section A is 25 of
150 (17%) and is three auto-markable formats. On top of that, **77 of the
223 parts in Sections B and C are single-mark recall** - "name ONE", "which
feature", "give the term" - which a `typed` or `quiz` block marks exactly. So
**roughly 45% of Paper 2's marks are machine-markable without an AI marker**,
against 16% for IT's CAPS theory paper. The rest is 2-mark written answers,
which the `written` block with a per-idea `markerRubric` already handles, and
none of it is longer than 3 marks - so **no band rubrics are needed anywhere
in this subject's theory**.

| Exam format | Platform type |
|---|---|
| Multiple choice, including NOT/FALSE stems and a screenshot stem | `quiz` |
| Matching columns (10 rows, 20 options) | `match` - it already allows more options than rows, and scores per line as the exam does |
| True/false with correction | `typed`: "type TRUE, or the word that should replace the underlined one" |
| Name / which / give the term (1 mark) | `typed`, with every accepted wording listed |
| Give TWO / state TWO / explain / describe / discuss / suggest / motivate (2 marks) | `written`, `markMax` 2, per-idea rubric listing more facts than marks |
| Name a spreadsheet function or feature; read a query criterion; read an HTML tag | `typed` (`codeAnswer`) or `checkedcode` |
| Section C's scenario questions | `multipart` (`Scenario()`) - see below |
| A spec sheet, screenshot, chart or form to read | `identify` (`Identify()`) or a `multipart` stimulus |

**Even marks (platform.md decision 8)** fall out nicely here: the paper's own
2-mark part is already even, and a 1-mark recall part becomes an auto-marked
part which the engine doubles to 2. The handful of 3-mark parts split into
2 + 1 or are weighted 2 + 2.

**Paper 1 is the hard part.** Almost every one of its 149 marks is for
*doing something in Word, Excel, Access or a text editor* - and the platform
has no engine for that. See [course-plan.md](course-plan.md) for what would
have to be built, and for which of those marks can be reached with the
question types that exist.
