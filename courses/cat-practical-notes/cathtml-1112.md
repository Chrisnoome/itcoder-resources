# cathtml Grades 11 and 12 - writer's notes

Course `cathtml` (Web Design (HTML)), lessons 6-15 (content/cathtml/), written
9 October 2026 to courses/cat-practical-writing.md ("HTML lessons" and
"Grades 11 and 12"). The story goes on from Grade 10: Thabo (Grade 11, then
matric) grows Mr Botha's website (Botha's Bakery, Centurion) - lists,
pictures, a cakes page, links, a menu, opening hours, catering platters and a
function menu - then builds Phumlani Secondary's matric farewell page for Ms
Naidoo and Gogo Dlamini's stokvel braai page. Side tasks: Lerato's
residence cake sale, Ms Naidoo's revision timetable.

## 1. Lessons written

| # | Lesson | Grade | Title | Marks CAPS / IEB | html blocks (checks) |
|---|---|---|---|---|---|
| 6 | `quickstart` | 11 | A quick start, alignment and comments | 54 / 52 | htmlQuickTry 1, htmlQuickRecap 5, htmlQuickAlign 4 (2 with Jev) |
| 7 | `lists` | 11 | Lists | 40 / 40 | htmlListsFix 4, htmlListsBuild 4 |
| 8 | `images` | 11 | Pictures | 42 / 46 | htmlImagesFix 4 (1 Jev), htmlImagesBuild 5 (2 Jev) |
| 9 | `links` | 11 | Links | 46 / 44 | htmlLinksCaps 3 (CAPS), htmlLinksIeb 2 (IEB), htmlLinksFix 4, htmlLinksBuild 4 |
| 10 | `tables` | 11 | Tables | 40 / 0 | htmlTablesFix 4, htmlTablesBuild 5 (1 Jev) - all CAPS |
| 11 | `goodpage` | 11 | Good page design | 44 / 46 | htmlGoodFix 6 (2 Jev), htmlGoodBuild 6 (1 Jev) |
| 12 | `tableformat` | 12 | Formatting tables | 40 / 48 | htmlFormatStart 3 (IEB), htmlFormatFix 5, htmlFormatBuild 6 (1 Jev) |
| 13 | `spanning` | 12 | Spanning rows and columns | 44 / 44 | htmlSpanFix 3, htmlSpanBuild 5, htmlSpanTimetable 4 |
| 14 | `fixing` | 12 | Finding and fixing mistakes | 40 / 40 | htmlFixingTest 6 (2 Jev), htmlFixingCakeSale 5 |
| 15 | `scenario` | 12 | Building a page for a scenario | 48 / 48 | htmlScenarioFarewell 10 (3 Jev), htmlScenarioBraai 6 (2 Jev) |
| | **Total** | | | **438 / 408** | 25 blocks, 103 checks |

Index entries added (numbers 6-15, chapters "Lists, pictures and links",
"Tables", "Good page design" for Grade 11; "Spanning and formatting",
"Building a page for a scenario" for Grade 12). **Six Grade 11 lessons, not
five**: cat-course.md 3.3's Grade 11 chapters are Lists; Tables; Good page
design, but the CAPS and SAGs Grade 11 lines also need pictures and links (a
week of teaching each) and the IEB quick start - so pictures and links have a
lesson each. The course is 15 lessons, not 14.

Every lesson: quote card, contents, prose sections each with a block-anchor,
a question after each section, why lines, written questions with 'points',
one own-words reveal in most, html blocks (a fix-it and a build in each; the
Grade 12 ones exam-style with numbered parts and comment markers), the study
block, one `// VIDEO` comment.

### Where each topic sits (the board-by-grade rule)

Read from cat-caps.md section 3 and cat-sags.md 8.5:

- **CAPS Grade 11** has nearly everything: Term 2 - comments, align on
  paragraphs and headings, `<center>`, cite (PAT only), **basic tables (table,
  th, tr, td) and troubleshooting**; Term 3 - good design and colour, lists
  (ul types), images (src, alt, border), links (bookmarks with **id**,
  websites, files, **target**). (The brief to me listed lists, images and
  links as CAPS Grade 12; cat-caps.md has them under "#### Grade 11, Term 3"
  and in the 2.1 Grade 11 overview, so they are Grade 11 here.)
- **CAPS Grade 12**: table attributes (border, cellpadding, cellspacing),
  horizontal and vertical alignment of cells, merging rows and columns, a page
  for a scenario "according to the tag sheet", good design reinforced.
- **IEB Grade 11**: the whole basic tag list (IEB pupils start HTML here) plus
  `<body text>`, `<!-- -->`, `<p align>`, ol/ul with types, img with
  align/border/width/height/alt, hr color, a href, an image as a link,
  `<a name>` bookmarks. **IEB Grade 12**: tables, including th, width,
  border, cellspacing, cellpadding, tr align/valign, colspan, rowspan; a page
  for a scenario.

So the one real grade difference is **basic tables**: CAPS Grade 11, IEB
Grade 12. `tables` (Grade 11) is therefore one CAPS BoardSection after its
opening ("IEB pupils meet tables in Grade 12 - Grade 12's first table lesson
starts with a quick start that links back here"), and **its IEB total is 0**
(the brief's 40-80 range cannot hold for IEB there). `tableformat` (Grade 12)
opens with an IEB BoardSection "Tables from the start" (prose linking each
part of `tables`, plus a 3-check html block). Everything else in Grade 12 is
the same grade for both boards.

Smaller board sections (one board names it, the other does not):
- CAPS: `<center>` (quickstart), target="_blank" and bookmarks with id
  (links), cite (goodpage).
- IEB: the img title tooltip (images), `<a name>` bookmarks (links), body
  text and hr color (goodpage), caption (tableformat), the tables quick start
  (tableformat).

Taught to everyone though only one board's syllabus line names it, because
both papers' tag sheets have it and both papers ask it (exam analyses):
ol type (A, a, I, i, 1); img width, height and align; a picture as a link
(CAPS 2024 asked one); table width and bgcolor on tables and cells (the same
attributes pupils know from hr, img and body).

## 2. Glossary rows - merged

Added to content/cattheory10/glossary.php (the hold had lifted), in a new
"cathtml - Web design (HTML), Grades 11 and 12" section: HTML comment,
Unordered list, List item, Ordered list, src attribute, Tooltip, Anchor tag,
Link text, HTML bookmark, Table row, Table header cell (grade 11); Cell
padding, Cell spacing, Tag sheet (grade 12). `'course' => 'cathtml'`.
check-glossary: OK. Existing rows used through Gloss() and not added again:
HTML, HTML tag, HTML editor, document tags, nested, indenting, HTML attribute
(Grade 10 HTML), alignment (catword), alt text, screen reader, accessibility,
consistency, navigation (cattheory11), hyperlink, URL (cattheory10), table
cell (catword - its definition fits). "bookmark" and "comment" already mean a
browser favourite and a document comment, hence **HTML bookmark** and **HTML
comment**. The HTML comment row's definition has `<!--` and `-->` in it
(check-glossary passed it); change to words if the plain-text rule wants.

## 3. CAPS lines - merged

Added to content/cathtml/caps.php (Grade 11 Terms 2 and 3, Grade 12 Terms 2
and 3), one or two per lesson, wording from cat-caps.md. Every Grade 11 and
12 HTML line of cat-caps.md is placed.

## 4. SAGs lines - merged

Added to content/cathtml/sags.php (topic P5): Grade 11 lines on quickstart,
lists, images, links, goodpage; Grade 12 on tables (as the CAPS section),
tableformat, spanning, fixing, scenario. check-sags: no cathtml problems.
Every 8.5 Grade 11 and 12 HTML tag is placed.

## 5. Drawings

Used (existing names): html-render (quickstart, DesignFigure), aligned
(quickstart), recipe, detective (lists), detective (images, tables, fixing),
treasure-map (links), arr2d-timetable (tables), menu, hex-colour (goodpage),
arrays-egg-box (tableformat), arr2d-grid (spanning). cat- versions exist for
detective only (and the others fall back to the IT drawing).

Worth redrawing in the CAT style: treasure-map (bookmarks), arrays-egg-box
(padding and spacing), arr2d-grid (a cell two rows tall), menu, hex-colour.

Wished for (one line each):
- quickstart: Clicky reading a crumpled to-do list - lists, pictures, cakes page, links.
- lists: a wall of text with Clicky lost in it, beside the same words as a neat list.
- images: a broken-picture icon with a speech bubble "koeksisters.jpg? never heard of it".
- links: two web pages as rooms with no door, then a door labelled a href.
- tables: Mr Botha's opening-hours paragraph with a grid drawn over it.
- goodpage: four pages of one website, each in a different bakery's colours.
- tableformat: an egg box: the cups (padding) and the gaps between them (spacing), labelled.
- spanning: two table cells melting into one, Clicky with a tape measure.
- fixing: Clicky as a detective with a magnifying glass over a tag sheet.
- scenario: a numbered task list with underlines and circles in highlighter.

Pictures for the html blocks (public/assets/practical/html/botha/, drawn with
Pillow in the style of catpilot's bread.png, 600 x 400; logo 300 x 300):
koeksisters.png, rolls.png, cake.png, shop.png, logo.png, pie.png, bread.png
(copied from catpilot's bakery folder); img/ holds cake, logo, bread, pie for
the subfolder tasks. Simple drawings - the koeksisters look more like stacked
doughnuts than plaits; redraw if wanted (keep the names and sizes).

## 6. Anything I was unsure of

- **IEB total 0 for `tables`** (see 1). An IEB Grade 12 pupil who opens it
  can read it; its questions count for CAPS only.
- **Six Grade 11 lessons** (see 1).
- **Quotes**: Feng Zhang, Andrew Holdsworth, Michelle Dean, Dan Millman,
  Jaron Lanier, Camille Paglia, Mike Davidson (his second quote), Dick
  Costolo use the stand-in (no portrait in public/assets/quotes; the quote
  bank has CC portraits for Paglia, Lanier, Costolo, Zhang if Chris wants
  them cut to 80 px). Tim Berners-Lee (tableformat) and Jeffrey Zeldman
  (fixing) have portraits; both are their second CAT quotes, different
  words. None of these words is used by another CAT lesson.
- Facts to check: "Roman numerals in a list run as far as you like: item 2026
  is MMXXVI" (true for Chrome/Edge's list-style upper-roman up to 3999);
  `border` on img still draws a frame in Edge (it does - the presentational
  attribute is mapped); "some browsers draw a blue frame round a picture that
  is a link" (older browsers; Edge does not) - worded "some".
- `<a name>` is obsolete in HTML5 but works in every browser; the IEB tag
  list has it, so it is taught in the IEB section with id for CAPS.
- Alignment: valign="middle" is the default for td; the lesson says words
  "sit in the middle from top to bottom" - correct for td in Edge.
- The `#colour` section says Word's More Colors box "shows the code of any
  colour you pick": Word's Custom tab shows RGB and Hex (Microsoft 365) -
  check in the VM if a screen is ever added.

## 7. Screen scripts written and run

In AIResources/tools/sim-screens/, run in the CAT VM:

- `cathtml-images.ps1` - Mr Botha's page with koeksisters.png (carried as
  base64), opened in Edge with a fresh profile: (1) the picture showing, (2)
  src="koeksisters.jpg" - Edge's broken-picture icon and the alt text. Ran
  first time (exit 0). Pictures (no title bar; the tab strip shows only the
  page title, the profile icon is generic): public/assets/sims/cathtml/
  cathtml-images-1.png and -2.png, used in images.php #img and #broken. It
  also left the site folder in G:\My Drive\CAT\HTML\botha.
- `cathtml-files1112.ps1` - the twelve starter files and the eleven
  pictures (base64) into C:\sims\files\cathtml-files1112\botha\ and
  G:\My Drive\CAT\HTML\botha\ (with its img folder). Written by the scratch
  script from the lessons' starters. Ran first time (exit 0): all twelve
  pages and eleven pictures written and copied to G:\My Drive\CAT\HTMLotha.

Notepad++ screens were not needed: the html blocks' previews are the
screens, and Grade 10 has the Notepad++ pictures.

## 8. Starter files made

public/assets/practical/cathtml/ (each the starter of one html block, made
from the lesson file, so the two match - if a starter changes, change its
file and cathtml-files1112.ps1): botha-old.html, botha-top.html
(quickstart), botha-lists.html (lists), botha-pictures.html (images),
botha-links.html (links), botha-hours.html (tables), botha-pies-old.html
(goodpage), botha-platters.html (tableformat), botha-specials.html
(spanning), test-bakery.html, res-cakesale.html (fixing), farewell.html
(scenario). The builds that start from an empty skeleton have no file.
Pages that use pictures expect them next to the page or in img/ - the cloud
folder G:\My Drive\CAT\HTML\botha has them; on the site, images.php and
scenario.php link the pictures to download.

## 9. What the platform lacked

- **No "or" in an html rule**: "centred with align or with the center tag"
  (quickstart htmlQuickAlign 1, images htmlImagesBuild 3, scenario
  htmlScenarioFarewell 3) and "bgcolor on the tr or on every th"
  (tableformat htmlFormatBuild 4) are 'jev' checks after a rule that the
  element exists. htmlFormatBuild 5 accepts valign only on the rows (the
  task says rows).
- **A comment is not an element**, so "a comment that names Thabo"
  (htmlQuickAlign 3) and "every comment kept" (htmlFixingTest 6,
  htmlScenarioFarewell 10) are 'jev' checks.
- **No "not"** (as Grade 10 found): "the link text is not click here" is
  done by asking for words that name the cakes (textContains 'cake').
- **Rules cannot test order** (head before body; the caption first in the
  table) - the caption has no html check.
- check-jev strips tags from options and prompts, so questions whose options
  are tags (sQuickVoid, qQuickAlign, sQuickAlign, qImagesSrc, sImagesAlt,
  qImagesCentre, sImagesBroken, qLinksFile, qLinksPicture, qLinksAName,
  qGoodCite, tTablesTr, qSpanCount) are flagged "may not be right" - read
  and left (the pages escape them correctly).
- `html` is still not a code-question language: markwords, dragwords and
  labelcode use 'text'.
- The preview opens no links except #bookmarks (said in links.php #a).

## 10. Checks run

- `php -l` on all ten lessons, index.php, caps.php, sags.php and
  cattheory10/glossary.php: clean.
- `bin/check-html.php cathtml`: "All 36 HTML block(s) are sound (156
  checks; the model answers full marks, the starters not)" - the 11 Grade 10
  blocks and my 25.
- `bin/check-html.php cathtml --live`: "All 36 HTML block(s) are sound (156
  checks ...)"; Jev decided every 'jev' check on the model answers itself
  (Jev asked once per block that has one, Claude 0).
- `bin/check-jev.php cathtml <lesson>` on all ten. Worked through: why lines
  that gave the answer (mListsTypes `<ul>`, mSpanWhich, mScenarioSee), a
  caption next to a question (goodpage's menu doodle), a written idea the
  prompt did not support (wFixingComments "the task says to keep them" -
  removed), a weak idea reworded (wImagesAlt search engines), two Jev
  questions made clearer (htmlFixingTest 6, htmlScenarioFarewell 10). Left:
  the tag-stripping flags in 9, tFixingTitel's "<title>" answer, and
  htmlFixingTest check 6's Jev question (check-jev strips the <!--1--> ...
  comments out of the question it shows Jev; the live marking keeps them,
  and the live run marked the model met). qSpanCount's prompt was reworded
  to carry no tag.
- check-lesson-contents, check-figures (two study-block img mentions
  reworded), check-titles, check-why (78/78 done), check-code-questions,
  check-pictures, check-more-questions, check-popup-spacing (one fixed in
  quickstart), check-lesson-links, check-glossary, check-ordering,
  check-typed-rules, check-sags, check-dilemmas, check-feedback-format:
  nothing for cathtml.
- renderone.php on all ten: no WARN lines (quickstart 77 953 bytes, lists
  56 464, images 70 804, links 67 078, tables 56 435, goodpage 64 259,
  tableformat 58 279, spanning 63 155, fixing 57 335, scenario 46 961).
- Video plans: cat-videos/cathtml-<lesson>.md for all ten (cathtml-06.1 to
  15.1, one each, 78 minutes), indexed in cat-videos/README.md.
