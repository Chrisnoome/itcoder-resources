# CAT practical courses, Grade 10 - summary

8 October 2026. The 29 Grade 10 lessons of `catword` (10), `catexcel` (8),
`catpowerpoint` (6) and `cathtml` (5), written to
[../cat-practical-writing.md](../cat-practical-writing.md) by six writers.
Their notes: [catword-a](catword-a.md), [catword-b](catword-b.md),
[catexcel-a](catexcel-a.md), [catexcel-b](catexcel-b.md),
[catpowerpoint](catpowerpoint.md), [cathtml](cathtml.md). This file
collects them, after the finishing pass.

**Finishing pass (8 October 2026):**

- Glossary: 96 rows merged into `content/cattheory10/glossary.php`, one
  section per course, `'course' => '<courseId>'`. Clashes settled: one row
  each for Template, Header, Print preview, SmartArt and List level (taught
  in Word, shared with Excel or PowerPoint); Word's table cell is
  **Table cell**, Excel's is **Cell**; PowerPoint's layout is **Slide
  layout** (cattheory11 has Layout in the page-design sense) and its icons
  are **Office icons** (cattheory10 has icon in the GUI sense); HTML's tag
  and attribute are **HTML tag** and **HTML attribute**. Existing rows kept
  for typography, comment, data type (its definition now says "a field (or a
  spreadsheet cell)"), integration, PAT, word processor, dialog box, cloud,
  spreadsheet, cloud storage, COUNTIF, hyperlink, PDF. The HTML rows name
  tags without angle brackets (the glossary is plain text).
- `caps.php` and `sags.php` for all four courses, from the notes.
- Portraits from the quote bank: eno, barker, starlin, ive, newmark,
  goldsmith (`public/assets/quotes/`, 80 px, and `AIResources/Quote images/`).
- Popup spacing fixed in catexcel formulas and formatting and catpowerpoint
  start; the two cathtml quote cards with no picture given the stand-in; two
  missing `// VIDEO` comments added (catpowerpoint-02.2, -06.2).
- Video plans indexed in [../cat-videos/README.md](../cat-videos/README.md)
  (50 videos, about 341 minutes).

## catword - Word (10 lessons)

| # | Lesson | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|---|
| 1 | `start` - The Word window and your first document | 56 / 56 | practice + 4, hotspot | yes (no starter) |
| 2 | `editing` - Moving around, selecting and editing | 46 / 46 | 4 | yes |
| 3 | `fonts` - Formatting characters | 46 / 46 | 4 | yes |
| 4 | `paragraphs` - Formatting paragraphs | 42 / 42 | 4 | yes |
| 5 | `lists` - Bullets, numbering and tabs | 40 / 40 | 4 | yes |
| 6 | `pagelayout` - Page layout | 66 / 66 | 4 | yes |
| 7 | `tables` - Tables | 58 / 58 | 4 | yes |
| 8 | `illustrations` - Pictures, shapes and WordArt | 54 / 58 | 4 | **none** |
| 9 | `proofing` - Proofing and printing | 50 / 50 | 4 | yes |
| 10 | `integration` - Hyperlinks, help and fixing problems | 52 / 52 | 4 | yes |
| | **Total** | **510 / 514** | 40 + practice | 9 |

Board sections: pagelayout (cover page CAPS, line numbers IEB),
illustrations (arrange and chart in Word, IEB).

**The upload reader cannot mark** (lib/officexml.php): highlight,
strikethrough, sub/superscript, small caps, line and paragraph spacing,
indents, borders, shading, tab stops, list type and level; empty paragraphs
(dropped); the file's name; text columns, watermark, page colour, page
borders, hyphenation, line numbers, paper size; hyperlinks; pictures,
shapes, text boxes, WordArt, SmartArt and their wrapping; comments; table
styles, borders, shading and merged cells; a formula field versus a typed
number. So those are taught and simulated but not marked in an upload, and
`illustrations` has no upload.

**Starter files:** lessons 6-10's are **stand-ins** made by python-docx
(`catword-b-files.py`) because Word's SaveAs2 hung in the CAT VM from about
17:30 on 8 October. `catword-b-files.ps1` makes them in real Word: run it
once Word saves again (the VM probably needs Word restarted or a reboot).
ThaboEssay's word count (66) needs checking against Word's status bar.

**Syllabus lines placed nowhere:** CAPS Term 3 "basic styles linked to a
table of contents; basic referencing". `paragraphs` mentions in one
sentence that a table of contents is built from headings; nothing teaches
it, and nothing teaches referencing. Needs a home (a Grade 10 lesson 11, or
Grade 11's references chapter, as the IEB has it).

**Drawings wished for:** start - Clicky reading a 400-page manual while a
pupil clicks Blank document; a laptop with an umbrella, its files floating
up into a cloud. editing - Clicky with scissors and glue stick; the
clipboard as a waiting tray. fonts - serif "A" with feet beside a sans
serif "A" in sneakers; Clicky painting a word with a roller (Format
Painter). paragraphs - margins dashed, one paragraph stepping in; empty ¶
boxes sliding down a page. lists - "iiiii" and "mmmmm" with the same spaces
ending in different places. pagelayout - Clicky pushing a page onto its
side; four margins shaded with a ruler at 2.54 cm; a two-column newspaper
with Clicky drawing the line. tables - Mr Botha's zigzag price list with a
grid drawn over it; a calculator wearing a table as a hat ("=SUM(ABOVE)",
"press F9"). illustrations - squashed face versus happy face (side versus
corner handle); text flowing round a photo like water round a rock.
proofing - their/there/they're signposts; one PDF the same on laptop and
phone. integration - a chain link from a Word page to a globe; Clicky with
a magnifying glass over ¶ marks. Redraw in the CAT style: comic-sans,
find-replace, enter-key, ghost-mouse, gran-recipe, aligned, typewriter,
arr2d-timetable, old-photo.

**Open doubts:** "about one man in twelve is colour-blind" (fonts margin;
lower in some African populations); the Save As pictures in `start` show a
`catword-probe` folder and probe.docx from a test (a retake after clearing
Word's recent list would be tidier); Thesaurus, word count and PDF (IEB
Grade 11/12) taught to everyone in `proofing`; no triple-click or drag step
kind in simulations; Word's menus and dialog controls cannot be driven by UI
Automation, so dialog targets were read off the pictures by eye; Gail
Collins (paragraphs), Robert Wilson (illustrations) and the unknown author
(integration) have no portrait.

## catexcel - Excel (8 lessons)

| # | Lesson | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|---|
| 1 | `start` - The spreadsheet window | 56 / 56 | practice + 4, hotspot | 4 checks |
| 2 | `entering` - Entering and changing data | 50 / 50 | 4 | 6 checks |
| 3 | `formulas` - Formulas and cell references | 42 / 42 | 4 | 6 checks |
| 4 | `formatting` - Formatting cells and numbers | 48 / 50 | 4 | 4 checks |
| 5 | `functions` - Functions | 54 / 54 | 4 | 6 checks |
| 6 | `more` - More functions and error values | 68 / 58 | 4 | 6 checks |
| 7 | `charts` - Charts | 52 / 48 | 3 | 4 checks |
| 8 | `printing` - Printing | 40 / 46 | 3 | 4 checks |
| | **Total** | **410 / 404** | 30 + practice | 8 |

Board sections: formatting (Currency or Accounting, IEB), more (COUNTIF,
COUNTA, COUNTBLANK, RANDBETWEEN, CAPS), charts (line charts, CAPS),
printing (Print Titles, Print Area, breaks and views IEB; headers and
footers CAPS). The `'excel'` case of SimulationPractice() was added by
writer A.

**The upload reader cannot mark:** bold, font size, fill, borders, merged
cells, alignment, wrap, column widths, cell styles (values, formulas and
number formats only - so half of `formatting` is unmarked); defined names
(range names); a chart's data labels (type and title only); page setup -
orientation, print titles, print area, headers (so `printing`'s upload is a
troubleshooting task instead). Built-in number format 44 (Accounting) is not
in OfficeBuiltInFormats(). Suggested: an `xlsx.pageSetup` subject.

**Syllabus lines placed nowhere** (checked against all eight lessons):
- **Sort and filter** (CAPS Term 3 basic sorting; IEB "Data - basic sort and
  filter"): not taught. `formatting` mentions the filter buttons of Format
  as Table, nothing more.
- IEB **themes**: not taught (named only in printing's doc comment).
- IEB **review - thesaurus, translate, comments**: not taught (spelling is
  one item in a list in `entering`).
- IEB **pictures, shapes, icons** in a sheet: not taught.
- IEB **help** and **zoom**: touched only - the Search box, F1 and the zoom
  slider are named in `start`, not practised.
- IEB **background**: one sentence in printing's IEB section.
These need a home: a Grade 10 lesson 9 ("Sorting, filtering and finishing
a sheet"), or `entering` / `formatting` extended.

**Drawings wished for:** start - Clicky as a postman ("B3: street first,
then the house"); a laptop going dark in load shedding, the file safe in a
cloud. entering - "R18" sulking left while 18 sits right; Clicky rolling the
fill handle like a paint roller. formulas - =B2*C2 with arms pointing at two
cells beside a stubborn =6*48; a staircase "( ) then * / then + -".
formatting - an iceberg, 8.3% above and 0.0833333 below; Clicky pulling a
###### column wider like a concertina. functions - a sign "=NAME(range)" in
three highlighter colours. more - average, median and mode on a podium, the
median in the middle of a queue of loaves; a cell bursting with #####.
charts - Clicky judging a talent show of four charts. printing - a printer
with one lonely column on the last page ("landscape?"); a cell holding '36
turned away by the SUM bouncer.

**Open doubts:** the syllabuses print `#NAME!`, Excel shows `#NAME?` (the
lesson teaches Excel's and mentions the other); after naming a range the
simulation's Name Box still shows B2 (PrintWindow never showed the name);
no right-click step (Excel's context menu could not be pictured);
Landscape, Header & Footer and the Copies box were not captured, so those
are prose with figures; the Cell Styles gallery figure was dropped; the
`'not'` join's pupil message reads oddly inside an `'all'` (formatting
check 4). **The same Marshall Goldsmith quote opens `start` and `more`**
(shortened in `more`) - one should change. Verite (entering, printing - the
same person twice), Mike Davidson (formatting) and Robert Wilson (charts)
have no portrait; Robert Wilson's quote also opens catword `illustrations`.

## catpowerpoint - PowerPoint (6 lessons)

| # | Lesson | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|---|
| 1 | `start` - Slides, layouts and designs | 42 / 44 | practice + 4 | 4 checks |
| 2 | `text` - Text and lists on slides | 42 / 42 | 4 | 6 checks |
| 3 | `objects` - Tables, charts and pictures | 48 / 46 | 4 | 4 checks |
| 4 | `animation` - Transitions and animation | 36 / 36 | 3 | 4 checks |
| 5 | `slideshow` - Running a slide show | 40 / 38 | 4 | **none** |
| 6 | `pat` - Presenting your PAT | 36 / 36 | 2 | 5 checks |
| | **Total** | **244 / 242** | 21 + practice | 5 |

Board sections: start (templates, IEB), objects (video and sound, CAPS),
slideshow (.ppsx and .mp4, CAPS), pat (each board's PAT, prose). The
`'powerpoint'` case of SimulationPractice() was added by the writer. Every
Grade 10 Presentations line of CAPS and SAGs 8.5 is placed.

**The upload reader cannot mark** (`OfficePptx()` reads layout,
transition and text only): the theme; pictures, charts, SmartArt, shapes,
tables as tables; animations (so `animation` marks transitions only);
speaker notes and Set Up Slide Show (so `slideshow` has no upload);
headers, footers, slide numbers and hyperlinks. Suggested `pptx.slide`
tests: pictures, charts, tables, smartart, animations, notes, slideNumber;
`pptx.show` (loop, kiosk); `pptx.theme` (name).

**Drawings wished for:** start - a wall-of-text slide, the back row
squinting, Clicky asleep on the projector; a "one idea per slide" stack of
cards. text - Clicky pressing Tab, pushing two bullets in like furniture.
objects - the bakery queue looking up at a TV pie chart; Excel and
PowerPoint holding a chart with a chain (link) versus scissors (picture).
animation - every word spinning in, the audience dizzy; the animation
colours as traffic lights. slideshow - Mr Botha's TV with a loop arrow; the
speaker's view versus the audience's. pat - a 15-page report on a see-saw
against seven slides; a storyboard of sticky notes.

**Open doubts:** the 2023+ themes (Archway) may be missing from a school's
older Office; Design Suggestions and Designer are both named; printing
notes and handouts is prose only; no right-click step (thumbnail menu and
Paste Options could not be pictured); Find and Replace is a pane in
PowerPoint 365, a dialog in older versions; Turkle and Larson's portraits
are in the quote bank if wanted.

## cathtml - Web design (HTML) (5 lessons)

| # | Lesson | Marks CAPS / IEB | html blocks |
|---|---|---|---|
| 1 | `whatis` - What HTML is | 44 / 44 | 3 (incl. the "Try this first") |
| 2 | `structure` - The shape of a page | 44 / 44 | 2 |
| 3 | `text` - Paragraphs, line breaks and lines | 40 / 40 | 2 |
| 4 | `formatting` - Bold, italic and underline | 40 / 40 | 2 |
| 5 | `design` - Planning and building a page | 40 / 40 | 2 |
| | **Total** | **208 / 208** | 11 |

CAPS Grade 10, IEB Grade 11 revision (no BoardSection; each lesson opens
with the one-line note). `sags.php` lines carry grade 11. Every Grade 10
HTML line of cat-caps.md is placed.

**The html block cannot mark:** "not" (so one check uses Jev), the order of
tags in the source (the parser moves things back; `closed` tests pairing
only). No `html` language for code activities (they use `'text'`, so no
code font). check-jev strips tags from options, so tag options reach Jev
empty and are flagged - read and left.

**VM work not done:** `cathtml-files.ps1` (the eight starter files into
G:\My Drive\CAT\HTML\) and `cathtml-formatting.ps1` (a Notepad++ picture)
never ran - the VM was busy. The site's copies in
`public/assets/practical/cathtml/` exist and are linked.

**Drawings wished for:** whatis - Ms Naidoo's red pen marking "heading" and
"bold", and the browser drawing it; Clicky running between Notepad++ and a
browser with Ctrl+S and F5 signs. structure - a parcel with a label (head,
title) and contents (body); a lunchbox in a school bag (last in, first
out). text - Clicky squashing spaces and Enters into one space.
formatting - nested brackets versus crossed ones. design - a paper sketch
of Mr Botha's page with tags in the margin; Gogo's red-on-blue page beside
the fixed black-on-cream one. Redraw in the CAT style: html-render (a Grade
10 version with title, h1, p, hr), name-tag.

**Open doubts:** attributes (font, bgcolor, hr width) taught in `design`
because CAPS Grade 10 lists them - cut that section if they were meant for
Grade 11; the margin facts (info.cern.ch, Notepad++ 2003, colour-blindness,
about 140 colour names); `<title>` in the body still shows in Chrome and
Edge (the check marks it wrong); Clifford Stoll (text) and Mike Davidson
(formatting) have no portrait. A second `check-html --live` run is worth
doing when Jev answers (the three Jev checks were marked by Claude).

## Across the four courses

- **The CAT VM:** Word's SaveAs2 hangs (from about 17:30 on 8 October);
  hung jobs block every later run; the vm-shots lock is not first come,
  first served. Restart Word or reboot the VM before the next Word run.
- **Simulations lack** a triple-click step, a drag step, and a type step
  that does not end with Enter.
- **The VM's Office is signed in with Chris's school account**: Backstage
  and file dialogs show it; every writer cropped or painted it out - worth
  checking each new screen.
- **Uploads**: bin/check-uploads.php proves only the pilot's notice; each
  writer proved their blocks with a scratch runner. Fixtures exist in
  `tests/uploads/<course>/` - a fixture-driven section in check-uploads
  would prove them all every time.
