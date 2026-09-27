# IEB CAT exams - analysis of Paper I and Paper II

Built from every IEB paper, memo, insert and teacher instruction in
`sources/cat/ieb/`: **November 2023, 2024 and 2025**, Paper I (practical)
and Paper II (theory) - **six papers**, with the three practical inserts,
the three "Instructions to Teachers" and the three data-file zips.
Read with `pdftotext -layout`; the data files were extracted to a temporary
folder and opened with `openpyxl` and `mdbtools`. Syllabus source of truth
stays [sags.md](sags.md); twin of
[caps-exam-analysis.md](caps-exam-analysis.md).

**Everything is here.** Unlike the DBE set, no memo is missing and no file
is a duplicate of another. All six memos match their papers.

**Counts.** For Paper I, every numbered sub-question carrying a mark was
counted from its right-aligned annotation: **113, 98 and 101 parts**
(summing 175 each; the missing 5 belong to Question 7, whose mark sits on
an unnumbered line). For Paper II, **every mark slot on the page** was
counted, numbered or not, because the paper is an answer booklet with
labelled boxes: **134, 123 and 127 slots**, summing **exactly 150 each**.

---

# PART ONE: PAPER I - PRACTICAL

## 1. The paper at a glance

**3 hours, 180 marks (scaled to 100), five sections, nine questions**, all
compulsory. The shape has not moved in three years and matches the SAGs'
weighting table:

| Section | Question | Content | 2023 | 2024 | 2025 | SAGs target |
|---|---|---|---|---|---|---|
| **A** | 1 | File and folder management | 20 | 16 | 16 | 20 ±5 |
| **B** | 2 | Word processing | 15 | 15 | 15 | |
| | 3 | Word processing | 15 | 15 | 21 | |
| | 4 | Word processing | 20 | 20 | 14 | |
| | | **Section B** | **50** | **50** | **50** | 50 ±5 |
| **C** | 5 | Spreadsheet | 15 | 22 | 25 | |
| | 6 | Spreadsheet | 30 | 23 | 20 | |
| | 7 | Spreadsheet - **one feature** | 5 | 5 | 5 | |
| | | **Section C** | **50** | **50** | **50** | 50 ±5 |
| **D** | 8 | Database | 40 | 40 | 40 | 40 ±5 |
| **E** | 9 | HTML | 20 | 24 | 24 | 20 ±5 |

Each section's total is fixed; the split inside Sections B and C moves.
**Question 7 is always exactly 5 marks for a single advanced spreadsheet
feature** - a pivot table (2024 note: in 2023 the candidate *chose* between
a pivot table and a macro), a subtotal with page breaks (2024), a pivot
table (2025).

**One scenario for the whole paper**, set out on its own page with a
picture: the Dakar Rally (2023), an animal shelter called The Ranch (2024),
a school's Outreach Fun Day (2025). Every question's files live in a folder
named `Q1` to `Q9`, and the candidate is told to **"open and work only in the
folder named Qn"**.

**Parts per paper: 98-113**, sizes 1 to 6 marks:

| Part size | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| Parts (3 papers) | 170 | 96 | 29 | 11 | 4 | 2 |

**54% of parts are worth one mark** and 85% are worth 1 or 2. The exam
breaks its work into far smaller pieces than the DBE's does (the DBE Paper 1
has about 50 parts for 150 marks; the IEB has about 100 for 180).

### The standing instructions (on every cover)

1. Check the paper is complete: 16-19 pages plus a **2-page appendix** (HTML
   tag list and input mask characters).
2. **Rename your Data Files folder to your examination number before you
   begin.**
3. Five sections, nine questions; answer all of them.
4. **A text editor for the HTML section** - Notepad, Notepad++ or WordPad
   (2025 adds Komodo in the teacher's copy). **Microsoft Word may NOT be
   used for HTML coding.**
5. **Use functions and/or formulas to calculate answers**, unless told
   otherwise.
6. **"Take note of the mark allocation to ascertain the complexity of the
   solution required and the amount of time that you should spend on each
   question."**
7. Save your work regularly.
8. **The Developer tab must be enabled in Word and Excel.**
9. **The `Student_Screenshots` document is for when something will not
   work**: give the question number, paste a screenshot of the problem and
   a brief explanation - *"that could give you partial marks"*.
10. Crop screenshots to show only the relevant information.
11. Word processing defaults: centimetres, English (South Africa), A4,
    2.54 cm margins.
12. Figures in the paper have a border; do not add one unless told to.
13-15. **Do not rename, create, delete, move or duplicate any file or
    folder unless instructed to.**
16. Backup data files are available from the teacher if needed.

### How the exam is run and marked (Instructions to Teachers)

- The data files reach the school through the **IEB Electronic Postbox:
  Assessment Material, two days before the exam**, and are checked against
  Annexure A before being copied to each candidate's own disk space.
- The full package - word processor, spreadsheet, database, **including
  wizards and help** - must be installed, with a text editor for HTML and an
  Afrikaans spell check for Afrikaans-medium candidates. **Minimum:
  Microsoft Office 365 (desktop).**
- Afterwards the teacher puts every candidate's folder (named with their
  examination number) on **the IEB's flash drive**, seals it in the padded
  envelope with a signed declaration, and locks it in the electronic
  examinations bag the same day. A backup stays at the school **until 28
  February**, for re-marks.
- The **declaration** the head of school and CAT teacher sign certifies:
  nothing was modified in copying; every folder is that candidate's own
  work; **no candidate had access to the Internet during the examination**;
  no help beyond the technical was given; any malfunction or power failure
  was reported.
- **The candidate's files are marked, not a printout** - so unlike IEB
  Information Technology, nothing is lost by not printing.

### The insert

Two pages. **The HTML tag list** gives 18 tags in six groups - document
outline, document structure, text formatting and font, link, image, lists,
tables - each with its opening and closing tag and **its allowed
attributes** (`<BODY>`: BACKGROUND, BGCOLOR, TEXT; `<IMG />`: ALIGN, ALT,
BORDER, HEIGHT, SRC, **TITLE**, WIDTH; `<TABLE>`: BGCOLOR, BORDER, HEIGHT,
WIDTH, CELLPADDING, CELLSPACING; `<TD>`/`<TH>`: ALIGN, BGCOLOR, BORDER,
COLSPAN, ROWSPAN, VALIGN, WIDTH). It includes `<CAPTION>`, which the DBE's
sheet does not. **The MS Access input mask character sheet** is the standard
14-character list.

## 2. The data files

A `Data Files` folder with a subfolder per question, plus
`Student_Screenshots.docx` at the top. 2023's zip has 15 files in Q1 alone;
2025's has 12.

| Question | What is supplied |
|---|---|
| **Q1** | A deliberately messy folder: 12-15 files of many types (`.docx`, `.rtf`, `.txt`, `.xlsx`, `.pptx`/`.ppsx`, `.csv`, `.accdb`, `.mp3`, `.mp4`, `.png`, `.jpg`, `.jpeg`, `.svg`, `.webp`, a `.zip`), sometimes with **subfolders** (`Backup`, `Entries/Section_A`, `Miscellaneous`, `Racers`, `Archive`, `Docs`), and an `_Q1_Answers.docx` to type and paste screenshots into |
| **Q2-Q4** | One word processing document each, plus the images, `.txt` sources and `.pdf` or `.pptx` files they need. 2025's Q4 file is a **`.docm`** (macro-enabled) |
| **Q5-Q7** | One workbook each. Q5 and Q6 have 2-3 worksheets of 25-240 rows; Q7's is the smallest (2025: `Data` 19x6 plus an empty `PivotTable` sheet) |
| **Q8** | One `.accdb` with **two to four related tables**, plus an image for a form and sometimes an import file (`TeamsImport.csv`, `AnimalsImport.txt`) |
| **Q9** | One or two `.html` files plus an `img` (and sometimes `doc`) subfolder holding the images and PDF the page must link to |

**Three Access files, three shapes:**

| Year | File | Tables |
|---|---|---|
| 2023 | `Rally2024.accdb` | `tbl_Racers` (9 fields: id, dob, country, experience, class, classVIN, first_name, last_name, email), `tbl_Countries` (1) |
| 2024 | `8_RanchInfo.accdb` | `tbl_Animals` (8), `tbl_Types` (1), `tbl_Volunteers` (8), `tbl_Donors` (5) |
| 2025 | `8Participants.accdb` | `tbl_Participants` (8), `tbl_Items` (3) |

**Unlike the DBE's, these databases have more than one table that matters**,
and the paper uses that: 2025 Q8.5 asks for a form with a **subform** drawing
fields from both tables, and 2023 and 2024 supply a one-column lookup table
(`tbl_Countries`, `tbl_Types`).

**The HTML starters are broken on purpose**, the same way: 2025's
`Outreach.html` opens with `<titel>` instead of `<title>`, and its comments
mark where each answer goes (`<!--Add image here-->`, `<!--List starts
here-->`); 2024's `home.html` has an image that will not display; 2023's has
a bulleted list that renders wrongly and a footer cell that does not span.
2023 also supplies a second page, `signup.html`, only so that a link can
point at it.

## 3. Section A, Question 1 - file and folder management (16-20 marks)

**The DBE has nothing like this.** It is a whole section, worth 9-11% of the
paper, on the Windows File Explorer, and it is answered partly by **pasting
screenshots into `_Q1_Answers.docx`**.

**What comes up** (all three papers):

| Task | 2023 | 2024 | 2025 |
|---|---|---|---|
| Set File Explorer to **Details layout** | yes | yes | yes |
| **Sort** the folder and screenshot it | descending by Name (2) | yes | ascending by Date modified (2) |
| **Read a file property** and type the answer | MP3 file size in MB; PNG bit depth; a modified date | | MP3 **album artist**; PPTX **title** |
| **Compare two file types** in writing | `.txt` vs `.rtf`, two differences, "do not refer to file size" (2) | | `.mp3` vs `.mp4` (2); the purpose of the Recycle Bin (2) |
| **Add a column** to File Explorer and screenshot it | the Slides column (1 + 2) | | |
| **Edit a file property** | | | exam number as the **Author** of an `.xlsx` |
| **Change the default program** for a file type | find it without opening the file | | open `.png` with Paint |
| **Rename / move / copy** by file type | rename a folder; move all Office files; copy all images | | move **all Word documents except one** to a subfolder (2) |
| **Compress / zip** a file | yes | yes | yes |
| **Save as PDF and rename** | | | `.pptx` -> PDF -> `PosterPrint` (2) |
| **Create a shortcut** | yes | | |
| **Search** the folder and screenshot the search bar | all Excel files (2) | | |
| **Show where to enable a setting** | | | hidden files (1) |

**The memo is generous here** and says so: for the hidden-files screenshot,
*"does not have to be enabled to receive the mark, just the screenshot of
where to go to enable"*; for the move, *"award mark for files moved even if
.rtf is there ... do not penalise if `_Q1_Answers` are also moved"*; and a
typed answer or a screenshot is accepted interchangeably (*"Accept
screenshot"*).

## 4. Section B, Questions 2-4 - word processing (50 marks)

Three documents, 9-15 parts each, **1-2 marks a part**. The paper walks the
candidate through the document **page by page** ("Page 1", "Page 2", ...),
which the DBE never does.

**What comes up** (papers of 3 whose model answer needs it):

| Feature | 2023 | 2024 | 2025 |
|---|---|---|---|
| Line spacing, alignment, indents, **drop cap** | yes | yes | 1.5 lines; centre; drop cap **in margin**, 4 lines |
| **Images** - insert, resize to exact cm, wrap, group with WordArt | yes | yes | insert; 10 x 12 cm with aspect ratio unlocked; group; Top and Bottom wrap |
| **WordArt** transform effect | yes | yes | arched |
| **Keep with next / keep lines together** | yes | | yes |
| **Bookmark**, caption, cross-reference | yes | yes | bookmark `Info`; caption 'Figure 1 - ...' |
| **Citations and bibliography from a `.txt` source** | yes | yes | modify a source, update the bibliography |
| **Table of figures**, **index** (mark entries and update) | yes | yes | Formal table of figures; mark 'growth', update the index |
| **Page numbering** - format, position | yes | yes | centred footer, **Dots format**, automatic |
| **Page break before a heading**, section breaks | yes | yes | yes |
| **Find and replace with formatting** | yes | yes | replace 'outreach' with italic 'outreach' (5 instances) |
| **Columns with a line between** | yes | yes | yes |
| **Insert a `.txt` file's contents keeping its format** | yes | | yes (2) |
| **Paragraph border and shading** | yes | yes | solid border; red **shading, not highlight** |
| **A date field in an exact format** | yes | | field + `ddd, dd MMM yyyy` |
| **Tables** - sort, cell width, formulas | yes | yes | sort by a column ascending; preferred width 5 cm |
| **Custom bullets from an image file** | yes | yes | `Bullet.jpg` |
| **Linked object** (a `.pptx` as a linked icon) | | yes | yes (2) |
| **A macro** - name it, bind a shortcut, record an action | | | `Sign`, Ctrl+J, inserts a **signature line** with a suggested signer (4) |
| **Correct a spelling error** | | | yes |
| **Mail merge** | | yes (Q4, a thank-you letter from `Donors.xlsx`) | |
| **Small caps, font formatting** | yes | yes | yes |

## 5. Section C, Questions 5-7 - spreadsheet (50 marks)

Question 5 is mostly **formatting and features** (1 mark each); Question 6 is
mostly **functions** (2-6 marks each); Question 7 is one advanced feature
worth 5.

**Formatting and features asked for** (Question 5): row height, merge and
centre, **freeze panes**, tab colour, a data type that keeps a leading zero,
**data validation with an input message**, today's date, **a chart** (create
from a range, retitle, percentage data labels, gradient fill), **print
area**, hide a column, a footer, conditional formatting, sorting and
filtering.

**Functions in the three memos' model answers:**

| Function | 2023 | 2024 | 2025 |
|---|---|---|---|
| `IF` / **`IFS`** / nested IF | yes | yes | **the 6-mark banding question, with `IFS` and both nested-IF orders accepted** |
| `SUMIF` / `SUMIFS` | both | SUMIF | SUMIF |
| `COUNTIF` / `COUNTA` / `COUNTBLANK` | all three | COUNTIF | COUNTIF, COUNTA |
| `VLOOKUP` / `XLOOKUP` | both accepted | both accepted | - |
| `LARGE` | - | - | yes (second highest) |
| Text - `LEFT`, `MID`, `FIND`, `CONCAT`/`CONCATENATE`/`&` | MID, CONCAT | LEFT, CONCAT | LEFT, FIND, CONCAT, CONCATENATE, `&` |
| `TODAY` / `YEAR` | - | TODAY, YEAR | TODAY |
| `ROUND` | - | yes | - |
| `RANDBETWEEN` | yes | yes | - |
| **Absolute cell referencing**, as a mark in its own right | yes | yes | yes (2025 Q6.1) |

**A pattern worth noticing:** the IEB asks for a **percentage of a whole**
almost every year (2025 Q6.5 `COUNTIF(...)/COUNTA(...)`), and for a **code
built by joining fields** (2025 Q5.7, `=A3&LEFT(F3,FIND("@",F3,1)-1)`, 5
marks). Both are also DBE favourites.

## 6. Section D, Question 8 - database (40 marks)

21-27 parts, **1-4 marks each**, in four blocks in this order every year:
**tables, forms, reports, queries**.

**Tables** (7-12 marks): alternate row colour and gridlines (a *display*
setting, which the DBE never asks for); **field size**; a **validation rule
with validation text** (2025: age `Between 7 And 18`); a **combo box with a
value list and Limit to List**; an **input mask** (2025: `0000000000` for ten
compulsory digits); a **primary key**; **importing a `.csv` or `.txt` as a
new table** (2023, 2024).

**Forms** (5-9 marks): move a control between Form Header and Detail; delete
a heading; **a background image**; **tab order**; a label in the footer; and,
in 2025, **create a form with a subform in datasheet format drawing from two
tables** (4 marks).

**Reports** (4-7 marks): create from named fields; **group** on a field;
**sort**; a **calculated field in the group footer with a descriptive label**
(3 marks).

**Queries** (12-16 marks, 3-5 of them): display named fields; sort ascending;
a **wildcard** criterion ("any singing items"); a **range with AND** ("males
aged 14 to 18"); and a **calculated field** with a **currency format** (2025:
a 10% discount on the fee).

## 7. Section E, Question 9 - HTML (20-24 marks)

11-12 parts, **1-3 marks each**, all from the insert's tag list.

**What comes up** (all three papers): the `<title>` or tab text; a body-wide
setting (`bgcolor`, `text`, `font face`); an **image** inserted from a
subfolder without moving it, resized in px, with `alt` text or a `title`
tooltip; an `<hr/>` with `size`, `color` and a percentage `width`; a
**hyperlink** - to a file, to a PDF in a subfolder, from an image, or **to a
named anchor back to the top of the page**; a **list** corrected or converted
(`<ol type="I">`, `<ul type="square">`); **table attributes** - `border`,
`cellspacing`, and `colspan` so a row spans the table; bold and centring;
and, in 2023, typing the examination number into the page.

**About a third of the marks are for finding and fixing something broken**:
`<titel>`, an image that will not display, a list that renders as plain text,
a footer cell that does not span.

**No CSS, no `<div>`, no JavaScript, no forms** - exactly as with the DBE.

## 8. How Paper I is marked (the memos)

- **A single running grid** for the whole paper: question number, a one-line
  description of what earns the mark, a "1" in the mark column, and a wide
  **Comments** column. No per-question totals page, just "Q*n* Total" at the
  end of each question and "TOTAL 180" at the top.
- **Almost every line is worth exactly one mark**, so a 5-mark formula
  appears as **the same formula written out five times, once per mark
  line**, with the accepted alternatives listed in the Comments column
  beside it. That means the marker decides how much of a partly-right
  formula to credit, where the DBE's memo would name the five components.
- **The Comments column is where the tolerance lives**, and it is used
  heavily:
  - *"Accept building blocks"*
  - *"Also accept `=IF(E2>=10000,"High",IF(E2>=5000,"Medium","Low"))`"* -
    four alternative formulations listed for one 6-mark part
  - *"Accept `=Now()`"*, *"Accept named range for cell I1"*, *"Also accept
    ranges `COUNTA(B2:B26)` OR `COUNTA(C2:C26)`"*
  - *"Do not penalise if only paragraphs' line spacing was changed"*
  - *"Accept any arched text effect"*, *"Award mark for any border applied"*
  - *"Do not accept highlight, must be shading"*
  - *"Accept any format or typed date"* / *"Accept even if typed in"*
  - *"Do not award mark if automatic page numbering was not used"*
  - *"Run macro to see if it works"*, *"Alt+F9"*, *"Turn on Show/Hide to
    check"*
  - Database: *"Also accept `>=7 And <=18`, `>6 And <19`"*
- **Where a picture has to be matched**, the memo reproduces the picture
  beside the ticks.
- **No half marks**, and no negative marking anywhere.

## 9. Exam technique to teach (Paper I)

- **Rename the Data Files folder to your examination number first.** Then
  check every folder opens.
- **Work only in the question's own folder**, and do not rename, move,
  delete or create anything else - three separate instructions say so.
- **Mark allocation tells you the size of the job** (instruction 6). A
  1-mark part is one setting; a 5-mark part is one function with five
  moving pieces.
- **Use the `Student_Screenshots` document when something will not work**:
  question number, a cropped screenshot, and a sentence saying what you
  meant to do. It is explicitly there to earn partial marks.
- **Screenshots are answers in Question 1** - crop them so the relevant
  columns, the address bar and the search term are all visible.
- **Formulas, never typed values**, and use **absolute references** where a
  formula will be copied - it is a mark on its own.
- **Helper cells ("building blocks") are accepted.**
- **HTML in a text editor**, from the insert's tag list; keep the comments
  that mark where the answer goes.
- **Database: read the whole question before designing a query** - the range
  criteria and the wildcard criteria carry 3 marks each.
- **Time:** 180 marks in 180 minutes - a mark a minute. Section A ~16
  minutes, Section B ~50, Section C ~50, Section D ~40, Section E ~24.

---

# PART TWO: PAPER II - THEORY

## 10. The paper at a glance

**3 hours, 150 marks (scaled to 100), three sections, nine questions**,
answered **in the question paper**, which is 32 pages and handed in.

| Section | Question | Topic | 2023 | 2024 | 2025 | SAGs target |
|---|---|---|---|---|---|---|
| **A** | 1 | Short questions | 12 | 13 | 13 | |
| | 2 | Short questions | 13 | 12 | 12 | |
| | | **Section A** | **25** | **25** | **25** | ~25 |
| **B** | 3 | System Technologies | 24 | 23 | 24 | ~25 |
| | 4 | Internet and Network Technologies | 16 | 18 | 15 | ~15 |
| | 5 | Information Management | 10 | 10 | 10 | ~10 |
| | 6 | Social Implications | 14 | 16 | 13 | ~10 |
| | 7 | Solution Development | 11 | 8 | 13 | ~15 |
| | | **Section B** | **75** | **75** | **75** | ~75 |
| **C** | 8 | Integrated scenario | 26 | 25 | 24 | |
| | 9 | Integrated scenario **(continued)** | 24 | 25 | 26 | |
| | | **Section C** | **50** | **50** | **50** | ~50 |

The per-question marks are printed in a **"FOR OFFICIAL USE ONLY: MARKER TO
ENTER MARKS BELOW"** grid on the cover, so the candidate sees the whole
weighting before starting. Social Implications runs 3-6 marks above the SAGs'
target every year and Solution Development mostly below it.

### The standing instructions (on every cover)

1. Check the paper is complete (32 pages); **answer on the question paper and
   hand it in**; write your examination number in the blocks.
2. Non-programmable calculators may be used.
3. **"Read the questions carefully. Take note of the verbs of the questions,
   such as explain, name, select, discuss, and identify; and answer
   accordingly."**
4. **"Give your answers in general terms, e.g. use 'word processor' rather
   than 'Microsoft Word' or 'WordPerfect'. Use brand names only when
   asked."**
5. **"In general, a mark is allocated per fact. Therefore, a two-mark question
   would require two facts... One-word answers will not necessarily give you
   the mark. Write in full sentences."**
6. Do not use correction fluid; one blank page at the back for overflow.

**Instruction 5 is the one that matters most** and it is the opposite of the
DBE's: the DBE says bare nouns score; the IEB says **write full sentences and
a one-word answer may not earn the mark**.

## 11. The answer booklet - the single biggest structural fact

Every answer has a **ruled box of its own with its marks printed beside it**,
and where a question wants more than one thing the boxes are **labelled**:

> Method 1: ... (1) Method 2: ... (1)
> Advantage 1: ... (1) Advantage 2: ... (1)
> Definition: ... Example: ... (2)
> Wired connection ... (1) Wireless connection ... (1)
> WAN: ... Explanation: ... (2)

**29-40 labelled slots per paper.** The effect on the mark distribution is
dramatic:

| Slot size | 1 | 2 | 3 | 4 | 5 |
|---|---|---|---|---|---|
| 2023 (134 slots) | 120 | 12 | 2 | - | - |
| 2024 (123 slots) | 103 | 16 | 2 | 1 | 1 |
| 2025 (127 slots) | 108 | 16 | 2 | 1 | - |

**86% of all mark slots are worth exactly one mark**, and nothing in three
papers is worth more than 5. The paper is, in effect, **384 one-idea
questions**, not 150 marks of essay. Compare the DBE, where the 2-mark
written part is the norm and there are no labelled slots at all.

## 12. Section A - the short questions (25 marks)

Four blocks over two questions, in a stable rotation:

| Block | 2023 | 2024 | 2025 |
|---|---|---|---|
| **Multiple choice** (Q1.1) | 7 items | 8 items | 8 items |
| **Give the missing term** (a gapped statement) or **choose the term** | Q1.2: choose the most appropriate underlined term given in brackets (5) | Q2.2: complete the statement with the missing term (5) | Q1.2: complete the statement (5) |
| **Matching columns** | Q2.1: 8 rows, **16 options A-P** | Q2.1: 7 rows, **16 options A-P** | Q2.1: 7 rows, **14 options A-N** |
| **Explain the term or acronym** (a written definition worth 1 mark) | Q2.2: choose the right acronym from a printed list of 14 (5) | Q1.2: "provide explanations for the following acronyms" (5) | Q2.2: "provide explanations for the following terms" - BIOS, Icon, Hyperlink, Line Break, Wizard (5) |

**Multiple choice stems** are four options A-D, letter only, with **bold
negative stems** ("which is FALSE", "which does NOT help", "which CANNOT be
generated") in every paper, and a **combination stem** in 2025 ("which
combination of functions will display the last three letters in uppercase" -
options are pairs of (i)-(iv)). Distractors are near misses throughout: SSD
/ DIMM / CMOS / PCI; fps / Hz / rpm / m/s; register / cache / storage / ROM.

**Matching always has about twice as many options as rows**, and the spares
are the near misses (Phishing against Pharming, Design view against Datasheet
view, Em-dash against En-dash, ROM against RAM, Opening tag against Empty
tag).

**Explaining a term for one mark is the IEB's own format** and does not exist
in the DBE paper. The memo gives a full-sentence model answer, often with an
`OR` alternative.

## 13. Sections B and C - what is asked

### Question 3, System Technologies (23-24 marks)

The biggest question in the paper. It always runs off **an advertisement or
spec sheet** (2023 and 2025 print one; 2024 uses a printer scenario) and asks
about the CPU, its measurement unit, cores, RAM, storage and ports. Around
it: **utilities** (Snipping Tool vs Print Screen, the disk defragmenter -
"why does it not create additional space?"), **troubleshooting** (a flash
drive with a virus, a computer that will not boot), **peripherals**
(define + example), **accessibility and health**, and **mobile technology**
("Always on - Always connected", intelligent virtual assistants, voice
recognition).

**2025 Q3.1 is the paper's most distinctive question type**: four items,
each showing **two photographs labelled Option A and Option B** with a
one-line scenario, and the candidate must **choose the option and name the
device** - two separate one-mark boxes ("Indicate Option A or Option B" /
"Name of device"). A sound card, a Wi-Fi network card, the Cc icon (with
"expand the acronym on the icon you chose") and an Outlook icon. **8 of the
paper's 150 marks.** 2023 has one such item; 2024 has none.

### Question 4, Internet and Network Technologies (15-18 marks)

Opens with its own small scenario (a school hosting an esports Indaba, 2025).
Network types and the devices that join them; **wired vs wireless in two
labelled boxes, then "which is better? give a reason"**; client vs server;
hotspots; streaming and **buffering**; online vs LAN gaming. The
"difference between X and Y" with **one box per side** is the house pattern.

### Question 5, Information Management (10 marks, every year)

The SAGs promises "in particular, using Input, Processing and Output
(Algorithms) to solve a problem", and the paper delivers: **2025 Q5.4 asks
for the input, the processing and the output of a named digital system, in
three one-mark boxes, "you must refer to the scenario"**. Around it:
advantages of digital information; **evaluating and improving a questionnaire
question** (why is this closed? what data type? suggest two changes for
better quality); and the PAT's own methods.

### Question 6, Social Implications (13-16 marks)

Identity theft, DDoS attacks and the role of a bot, hacktivism, saving
electricity, social media's effect on interaction, using social media to
study or find a job. **Stance-and-motivate appears here** ("Is engaging
online reducing social interaction between people? Motivate your answer",
1 mark; the memo: *"Accept Yes or No with correct/appropriate reason"*).

### Question 7, Solution Development (8-13 marks)

The theory behind the practical: word processing features for collaborative
editing (track changes, comments); **document accessibility**; reading an
indent from a screenshot; spreadsheet features for analysing data; autofill;
HTML attributes (`cellpadding` vs `cellspacing`, `colspan`); and - the
hardest item in the paper - **"identify the functions that have been used in
the following cells: write out the entire function in full"** from a
spreadsheet screenshot (2025 Q7.5, 3 + 2 marks). Writing a whole Excel
formula on paper is something the DBE never asks.

### Questions 8 and 9, Section C (50 marks, one continuous scenario)

**Question 9 is headed "INTEGRATED SCENARIO (continued)"** - unlike the DBE,
which sets two unrelated scenarios.

The scenario is **a news-article extract with its source URLs printed**
(3D-printed avocados with microsensors, University of Pretoria, 2023;
AI humanoid robots in South African hotels, 2024) or **a business
description with a logo** (SwiftMart, an online grocery store, 2025).

Then, every year: **two full computer advertisements side by side** to
compare; a **network** decision for a multi-site business; **an Internet
package table** (three packages with data, speed and price) where the
candidate fills in a **two-column table - Package and Motivation - for two
given scenarios** (4 marks); cloud and web-based applications; **malware**
(a named Trojan attachment, quarantine, signs of infection); **big data**;
**accessibility** (two hardware and two software technologies for disabled
users); **a database field list to read** (data types, what a field is, what
a form is for); **website evaluation and HTML attributes**; and mobile
devices.

## 14. Command verbs and the shapes they take

The cover tells candidates to watch the verbs, and the paper uses a narrow
set. From the three papers:

| Verb | How it is used | The answer frame |
|---|---|---|
| **Give / Name / List / State** | the commonest, 1 mark each | one labelled box per item ("Reason 1:", "Way 1:") |
| **Explain / Briefly explain** | 1-2 marks | a full sentence; 2 marks = two ideas |
| **Describe** | 1-2 | as explain |
| **Define ... and provide an example** | 2 | two labelled boxes: "Definition:" and "Example:" |
| **What is the difference between X and Y** | 2 | **one box per side**, labelled with the two things |
| **Discuss** | 1-2 per item | the same as explain; never an essay |
| **Suggest / Recommend** | 1-2 | a workable measure per box |
| **Motivate your answer** | 1 | attached to a choice; the memo accepts either side with a fitting reason |
| **Identify / Indicate / Select** | 1 | from given options or a picture |
| **Complete the table** | 4 | a grid with a choice column and a motivation column |
| **Write out the function in full** | 2-3 | a whole spreadsheet formula |

## 15. How Paper II is marked (the memos)

**The standing note on every memo's first page:**

> *"These marking guidelines are prepared for use by examiners and
> sub-examiners, all of whom are required to attend a standardisation
> meeting to ensure that the guidelines are consistently interpreted and
> applied... The IEB will not enter into any discussions or correspondence
> about any marking guidelines. It is acknowledged that there may be
> different views about some matters of emphasis or detail."*

In the body:

- **Model answers are written as full sentences**, matching the cover's
  demand that candidates write in full sentences - *"Icon is a small,
  graphical representation or symbol that is used to represent an
  application, file, function, or tool"*.
- **`OR` alternatives are printed in full** rather than as a keyword list:
  7 standalone `OR` blocks in 2023, 18 in 2024, 10 in 2025.
- **"(Any TWO of the above)"** / **"(Any ONE of the above)"** / **"(Any
  THREE of the above)"** under a bulleted list longer than the marks -
  19 such notes in the 2025 memo.
- **Notes to the marker** steer the tolerance: *"Any suitable answer that
  mentions a keyboard..."*; *"There should be different reasons under each
  bullet"*; *"Marks are not allocated for the applications but for the use
  of the application"*; *"In no particular order"*; *"Accept specific
  examples"*; *"Accept Yes or No with correct/appropriate reason"*; *"Any
  number less than zero or greater than 12 can be entered"*.
- The multiple-choice and matching answers are printed as a bare letter
  list; the fill-in-the-term answers list the accepted spellings
  (*"VGA/DVI"*, *"USB C / Type C"*).
- **No half marks**, and no marks deducted for spelling or grammar.

## 16. Exam technique to teach (Paper II)

- **One box, one idea.** Every labelled box is a separate mark; putting two
  ideas in "Reason 1:" and nothing in "Reason 2:" loses a mark. The memo
  says explicitly that the bullets under each slot must be **different
  reasons**.
- **Write full sentences.** The cover warns that a one-word answer *"will
  not necessarily give you the mark"* - the opposite of the DBE's paper.
- **Generic terms, not brand names** ("word processor", not "Microsoft
  Word"), unless the question asks for an example.
- **Read the verb** - the cover says so. "Define ... and give an example"
  needs both boxes filled; "how does X differ from Y" needs a fact about
  each side, in its own box.
- **Never leave a choice bare** - "which is better? give a reason" scores
  the reason, and either side is usually accepted if the reason fits.
- **Use the advertisement, the table and the article.** Section C runs on
  them, and the Internet-package table wants the package *and* the
  motivation.
- **Expand an acronym only when asked**, and then explain it too - "Define
  WAN by expanding the acronym **and** explaining its meaning" is two marks
  in two boxes.
- **Time:** 150 marks in 180 minutes - about 70 seconds a mark, but most
  slots are 1 mark and one sentence, so the real constraint is reading the
  32 pages. Section A should take 20 minutes.

## 17. Cognitive levels

The SAGs sets **30 / 40 / 30** for both papers, and requires an **analysis
grid** with every SBA test and prelim ([sags.md](sags.md) §5). **No analysis
grid was published with any of these six papers**, so the actual split cannot
be checked from the sources collected. By inspection:

- **Paper II's Section A (25 marks, 17%) is all lower order**, and so are the
  many one-mark "name / give / state" boxes in Section B - comfortably
  reaching 30%.
- **Higher order sits in Section C**: comparing two advertisements, choosing
  an Internet package with a motivation, recommending security methods, and
  the stance-and-motivate items. Plus Question 5's IPO analysis and Question
  7's "write out the function in full".
- **Paper I's higher order** is the 5-6 mark items: the banding function, the
  code-building formula, the percentage-of-whole, the two-table form with a
  subform, the range-and-wildcard queries, the macro, and the pivot table -
  roughly 30-35 of 180 by inspection, a little under the 30% target unless
  the multi-step formatting parts count as middle order, which they do.

## 18. Implications for the course's question types

Against `kit/platform.md`'s block types and
`kit/content-voice-and-pedagogy.md` §4:

**The IEB theory paper suits an auto-marking platform even better than the
DBE's.** Section A's 25 marks are four machine-markable formats, and because
**86% of the rest is one mark for one idea in a labelled box**, a per-idea
`written` rubric maps onto it almost exactly - every box is one rubric line.
Roughly **40-45% of Paper II's marks are markable without an AI marker** (the
multiple choice, matching, missing-term and picture-choice items, plus the
many "name the device / name the technology / which data type" boxes).

| Exam format | Platform type |
|---|---|
| Multiple choice, including NOT/FALSE and combination stems | `quiz` |
| Matching columns (7-8 rows, 14-16 options) | `match` - it already takes more options than rows and scores per line |
| Complete the statement with the missing term; choose the acronym from a list | `typed` (every accepted spelling listed) or `select` |
| **Two photographs, Option A or B, then name the device** | `identify` - the IEB does this itself, so it is not the course inventing a type. A `quiz` for the choice plus a `typed` for the name |
| Explain the term / acronym (1 mark, a full sentence) | `written` with `markMax` 2 (the engine's even-marks rule, platform.md decision 8) and a one-idea rubric |
| "Reason 1 / Reason 2", "Advantage 1 / Advantage 2" | a `multipart` with one `written` part per labelled box - **the answer frame the platform already builds is exactly this paper's layout** |
| "How does X differ from Y", one box per side | `multipart` with two `written` parts, or a `gridtyped` two-row table |
| Complete a table - a choice column and a motivation column | `gridtyped`, or a `multipart` with a `quiz` part and a `written` part |
| Write out a spreadsheet function in full | `typed` with `codeAnswer`, or `checkedcode` |
| Read a screenshot / advertisement / field list | the stimulus of a `multipart` or `identify` |
| Section C's article-driven scenario | `multipart` (`Scenario()`) with the article summary as the stem |

**Paper I** is, as with the DBE, almost entirely *doing something in an
application* - and one whole section of it (file and folder management) is
about Windows itself. What can and cannot be reached is in
[course-plan.md](course-plan.md).
