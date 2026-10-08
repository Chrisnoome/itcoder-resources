# catword lessons 6-10 (Grade 10) - writer B's notes

Course `catword`, lessons `pagelayout`, `tables`, `illustrations`,
`proofing`, `integration` (content/catword/), written 8 October 2026 to
courses/cat-practical-writing.md.

## 1. Lessons written

| Lesson | Title | Marks CAPS / IEB | Simulations (steps) | Upload (checks) |
|---|---|---|---|---|
| `pagelayout` | Page layout | 66 / 66 | simLandscape 3, simMargins 2 (Page Setup dialog box), simColumns 5 (Columns dialog box), simHeader 3 (double-click, type, close) | upNewsletter 4 (Newsletter.docx) |
| `tables` | Tables | 58 / 58 | simInsertTable 2 (the grid), simAddRow 2 (Tab key), simMergeTitle 3, simTotal 3 (Formula dialog box) | upSalesTable 4 (SaturdaySales.docx; 2 checks by Jev) |
| `illustrations` | Pictures, shapes and WordArt | 54 / 58 | simPicture 3 (Insert Picture file dialog, double-click), simWrap 3, simWordArt 3 (typed), simSmartArt 4 (SmartArt dialog box) | none - the reader cannot see pictures or shapes |
| `proofing` | Proofing and printing | 50 / 50 | simRightClick 2 (right-click menu), simEditor 3 (Editor pane), simThesaurus 2 (double-click, Shift+F7), simPrint 2 | upEssay 4 (ThaboEssay.docx) |
| `integration` | Hyperlinks, help and fixing problems | 52 / 52 | simHyperlink 3 (Insert Hyperlink dialog, typed), simPaste 3 (Excel then Word, Ctrl+C / Ctrl+V), simHelp 2, simFixIt 2 (double-click a tab, Show/Hide) | upReport 4 (SalesReport.docx + SaturdaySales.xlsx) |

Board sections: `pagelayout` - a cover page (CAPS), line numbers (IEB);
`illustrations` - arranging objects and a chart in Word (both IEB). Every
lesson has a Scenario (4 parts), a study block, 2 video plans, an own-words
reveal, and every written question has Jev `points`. All step kinds are used:
click, double-click, right-click, type, keys. Each lesson's doc comment gives
its sources and mark breakdown.

Lesson text follows what the VM's Word 365 shows: the table tabs are
**Table Design** and **Table Layout**, the Rows & Columns buttons are
**Insert Row Above / Below** and **Insert Column Left / Right**, the Proofing
button is **Spelling and Grammar**, and the table grid is 7 x 6 squares.

## 2. Glossary rows

New terms only. Already in content/cattheory10/glossary.php, so Gloss()
uses that row's text: `screenshot`, `PDF`, `hyperlink`. Already in writer
A's rows (catword-a.md): `Dialog box launcher` (same text), `AutoCorrect`
(taught in `editing`; `proofing` recaps it without a Gloss). `page break`
has the catpilot/word.php text.

```php
['Margins', 10, true, 'pagelayout', 'pagesetup', 'The empty space between the text and the edges of the paper - top, bottom, left and right.', ['course' => 'catword', 'also' => ['margin', 'page margins']]],
['Orientation', 10, true, 'pagelayout', 'pagesetup', 'Which way round the page is: portrait (taller than it is wide) or landscape (wider than it is tall).', ['course' => 'catword', 'also' => ['portrait', 'landscape']]],
['Page break', 10, true, 'pagelayout', 'breaks', 'A mark that makes the text after it start on a new page, wherever the page would have ended.', ['course' => 'catword', 'also' => ['page breaks']]],
['Section break', 10, true, 'pagelayout', 'breaks', 'A mark that divides a document into sections. Each section can have its own margins, orientation, columns, headers and footers.', ['course' => 'catword', 'also' => ['section breaks', 'section']]],
['Columns', 10, true, 'pagelayout', 'columns', 'Text set in narrow strips side by side, like a newspaper: it fills the first column from top to bottom, then carries on at the top of the next.', ['course' => 'catword', 'also' => ['newspaper columns']]],
['Hyphenation', 10, true, 'pagelayout', 'columns', 'Splitting a long word at the end of a line with a hyphen, so that part of it fits on the line and the rest goes to the next.', ['course' => 'catword']],
['Header', 10, true, 'pagelayout', 'headers', 'Text in the top margin of a page that shows on every page of the section, such as the document\'s name.', ['course' => 'catword', 'also' => ['headers']]],
['Footer', 10, true, 'pagelayout', 'headers', 'Text in the bottom margin of a page that shows on every page of the section, such as the page number.', ['course' => 'catword', 'also' => ['footers']]],
['Watermark', 10, true, 'pagelayout', 'background', 'Pale text or a pale picture behind the text on every page, such as DRAFT or CONFIDENTIAL.', ['course' => 'catword']],
['Cell', 10, true, 'tables', 'insert', 'One box in a table, where a row and a column meet. It holds text, a number or even a picture.', ['course' => 'catword', 'also' => ['cells', 'table cell']]],
['Merging cells', 10, true, 'tables', 'merge', 'Joining two or more cells next to each other into one bigger cell.', ['course' => 'catword', 'also' => ['merge cells', 'merge']]],
['Text wrapping', 10, true, 'illustrations', 'wrap', 'How the text flows round a picture or shape: in line with it, round its square, round its outline, above and below it, or behind or in front of it.', ['course' => 'catword', 'also' => ['wrap text', 'wrapping']]],
['Text box', 10, true, 'illustrations', 'wordart', 'A box of text that floats on the page, apart from the main text, so it can go anywhere - a quote or a fact beside an article.', ['course' => 'catword', 'also' => ['text boxes']]],
['WordArt', 10, true, 'illustrations', 'wordart', 'Decorative text - with a fill, outline, shadow or glow - in a box of its own, for a title or a poster.', ['course' => 'catword']],
['SmartArt', 10, true, 'illustrations', 'smartart', 'A diagram Word draws from a list of points - a process, a cycle, a hierarchy - that changes when the words change.', ['course' => 'catword']],
['Thesaurus', 10, true, 'proofing', 'thesaurus', 'A list of words with the same or nearly the same meaning (synonyms) - and the opposite meaning (antonyms).', ['course' => 'catword', 'also' => ['synonyms']]],
['Comment', 10, true, 'proofing', 'comments', 'A note added to a document in the margin, beside the words it is about. It does not change the text and is not part of it.', ['course' => 'catword', 'also' => ['comments']]],
['Print preview', 10, true, 'proofing', 'print', 'A picture of each page exactly as it will come out of the printer, shown before you print.', ['course' => 'catword']],
```

## 3. CAPS lines

```php
'pagelayout' => [
    [10, 1, 'Word Processing: page layout - page setup, margins, orientation, size, page border; document layout - page numbers, page breaks'],
    [10, 2, 'Word Processing: document and page layout - customising margins; headers and footers (simple edit and remove, automatic page numbers, alignment, own text); insert cover page'],
    [10, 3, 'Word Processing: document layout - page setup - columns (line between), hyphenation; watermark, page colour'],
],
'tables' => [
    [10, 2, 'Word Processing: tables - insert, table tools, table design, table properties; design - table styles, borders, shading; layout - rows and columns, header rows; cells - size, distribution, merging, splitting; text alignment and direction; split, autofit, gridlines; working with data - sorting, convert to text; working with formulae (sum and average)'],
],
'illustrations' => [
    [10, 1, 'Word Processing: insert and manipulate illustrations and text - pictures, shapes, WordArt, basic SmartArt, screenshot/snipping, text box (illustration objects can include icons and 3D models)'],
],
'proofing' => [
    [10, 1, 'Word Processing: reviewing - proofing, spelling and grammar'],
    [10, 1, 'Word Processing: view options - print layout and preview; file management - print'],
    [10, 2, 'Word Processing: view options - more than one document/window, zoom; draft and full-screen reading views'],
    [10, 3, 'Word Processing: reviewing - comments'],
],
'integration' => [
    [10, 3, 'Word Processing: integration - hyperlinks'],
    [10, 4, 'Word Processing: accessing online help including FAQs; integration techniques (hyperlink files, copy and paste between applications); solve problems; troubleshoot basic word processing problems'],
    [10, 4, 'Working with Documents: reproduce and create documents incorporating text, graphics and data'],
],
```

## 4. SAGs lines (topic 'P2' = 8.2 Word processing, as catpilot/sags.php)

```php
'pagelayout' => [
    [10, 'P2', 'layout and page setup - margins, orientation, size, columns, breaks, line numbers, hyphenation'],
    [10, 'P2', 'simple header and footer with page numbers; page breaks'],
    [10, 'P2', 'design page background - watermark, page colour, page borders'],
],
'tables' => [
    [10, 'P2', 'tables - insert, table tools, design, properties; styles, borders and shading; rows and columns, header rows; cell size, distribution, merging and splitting; text alignment and direction; split, autofit, gridlines; sorting, convert to text, working with formulae'],
],
'illustrations' => [
    [10, 'P2', 'illustrations - pictures, shapes, icons, SmartArt, charts, screenshots; text box and WordArt'],
    [10, 'P2', 'arrange - position, wrap text, bring forward, send backward, selection pane, align, group, rotate'],
],
'proofing' => [
    [10, 'P2', 'review - spelling and grammar; comments'],
    [10, 'P2', 'document management - basic printing; view options'],
],
'integration' => [
    [10, 'P2', 'links - hyperlink'],
    [10, 'P2', 'view options and help'],
    [10, 'P2', 'plan, design and solve problems using word processing for specific scenarios'],
],
```

## 5. Drawings

Used (margin doodles, existing names; a CAT redraw `cat-<name>` is used
where one exists): typewriter, carbon-paper, cat-report-page-stack
(pagelayout); arr2d-timetable (tables); old-photo (illustrations); red-pen,
printer-three-parts (proofing); anyone-link, photocopier, lost-file
(integration).

Not yet CAT-drawn and worth redrawing in the marker style: typewriter,
arr2d-timetable, old-photo (check each in public/assets/doodles - the ones
without a cat- file).

Wished for (one line each):
- pagelayout: Clicky pushing a tall page over onto its side ("landscape").
- pagelayout: a page with its four margins shaded and a ruler measuring 2.54 cm.
- pagelayout: a newspaper page with two columns and Clicky drawing the line between them.
- tables: Mr Botha's zigzag price list with Clicky drawing a grid over it.
- tables: a calculator wearing a table as a hat ("=SUM(ABOVE)"), with a sticky note "press F9".
- illustrations: a squashed face beside a happy one (corner handle vs side handle).
- illustrations: text flowing round a photo like water round a rock (wrap text).
- proofing: three signposts - their, there, they're - with Clicky confused.
- proofing: the same PDF opening identically on a laptop and a phone.
- integration: a chain link joining a Word page to a globe (hyperlink).
- integration: Clicky with a magnifying glass over a row of ¶ marks.

## 6. Anything I was unsure of

- **Quotes** (other writers took several of my first choices while I wrote -
  the Douglas Adams lines are in catexcel and catword `lists`, Bill Gates's
  "artistry and engineering" in catpowerpoint `start`): Jim Starlin
  (pagelayout), Jonathan Ive (tables) and Craig Newmark (proofing) have
  portraits in the quote bank (sw_applications_files general_image-5387.png, Kim
  Scarborough, CC BY-SA 2.5; Ive in sw_applications_files; dc_e-comms_files
  general_image-3620.png, Pete Forsyth, CC BY 4.0) - I may not add files to
  public/assets/quotes, so all three use anonymous.svg; the lead may add
  starlin.png / ive.png / newmark.png. Robert Wilson
  (illustrations) and "Hooked on Internet? Help is a just a click away"
  (integration; "a just" corrected) have none.
- The South African banknote watermark (pagelayout margin): Mandela's
  portrait as the watermark on the current notes - SARB.
- "A4 is exactly half of A3": ISO 216, true.
- "A Word table can hold up to 63 columns": Word's documented limit.
- "A photo from a phone is about 4 000 pixels wide": typical 12 MP (4 000 x
  3 000); a rough figure.
- Page colour not printed by default: File > Options > Display > "Print
  background colors and images" is off by default - checked in Word 365.
- Thesaurus and word count are IEB Grade 12 and PDF IEB Grade 11; taught to
  everyone in `proofing` as everyday skills, not in a board section.
- CAPS Term 3 "basic styles linked to a table of contents; basic
  referencing" and IEB "use inbuilt templates", "Info - protect / inspect /
  version history" are not in lessons 6-10. Writer A covers templates and
  Info in `start`; **the table of contents and basic referencing are in no
  Grade 10 catword lesson** - the lead should place them (a lesson 11, or
  Grade 11's references chapter, as the IEB has them).
- IEB "symbols", "sorting" (paragraphs) and "formatting symbols" are writer
  A's; "view options" sits in `proofing` (#views).

## 7. Screen scripts written and run

In AIResources/tools/sim-screens/, run in the CAT VM with
`pwsh -File vm-shots.ps1 <name>`, then
`python catword-b-crop.py <name>` (my own crop script: it lays each menu or
dialog box, saved by the script as its own picture `<n>~k.png` with its
place in the json, back on the main picture, trims PrintWindow's black
frame, paints over the OneDrive account label in the file dialog, crops off
the title bar, copies to public/assets/sims/catword/ and prints the marks in
per cent). No cat-crop.py entry was needed.

- `catword-pagelayout.ps1`, `catword-tables.ps1`,
  `catword-illustrations.ps1`, `catword-proofing.ps1`,
  `catword-integration.ps1` - each carries the same helper block (dialogs
  pressed from a background runspace, every Word window of the process saved
  by its own handle, WM_CLOSE to cancel a dialog, WM_CONTEXTMENU for a
  right-click menu).
- `catword-b-files.ps1` (the starter files in real Office, in a job of its
  own) and `catword-b-files.py` (today's stand-ins, see 8).
- work/catword-ewaste.jpg - the course's own e-waste picture
  (match/theory10/e-waste-g1.webp as a JPEG) for the Insert Picture
  simulation.

Runs (8 October 2026, many - the VM queue was long and each failure cost a
wait for the lock):
- `catword-illustrations` - complete (the figure menus at the end failed:
  the ribbon was on SmartArt Design; the script now opens Insert first, not
  re-run - the Shapes and chart figures were left out of the lesson).
- `catword-proofing` - complete screens; the run then hung in the starter
  part (the json was rebuilt from the log by a scratch script).
- `catword-tables`, `catword-integration` - complete.
- `catword-pagelayout` - complete on the last run (one document all the way:
  a second document's window was never active, so its ribbon menus would not
  open; the columns end with a continuous section break so they balance; the
  watermark gallery's DRAFT 1 found from the desktop's UI tree).
- Lessons learnt for the shared kit: a ribbon MenuItem must be Expanded, not
  Invoked; Office menus and some dialogs (Columns, Page Setup, Insert
  Hyperlink, Formula, Word Count) expose no named controls - read places off
  the picture; Word's dialogs and the file dialog are drawn with a black
  frame by PrintWindow (catword-b-crop.py trims it); the VM's file dialog
  names the school OneDrive account (catword-b-crop.py paints the label over
  as "OneDrive"); and a script that hangs in the VM keeps the agent busy, so
  every later run - anyone's - times out until it is stopped. I stopped my own
  hung Word/powershell processes by id each time.

## 8. Starter files made

**Word's SaveAs2 hung in the CAT VM from about 17:30 on 8 October 2026 -
for every script, and for a plain new document in a WinRM job too (Excel
and PowerPoint still saved).** So the starter files are **stand-ins** made
on the host by `tools/sim-screens/catword-b-files.py` (python-docx and
openpyxl - the same documents, fields included: PAGE in the footer,
=SUM(ABOVE) with its result 215). `catword-b-files.ps1` makes the same files
in real Word and Excel (in a job of its own) - run it once Word saves again,
and copy its files over these:

- public/assets/practical/catword/: Newsletter.docx, SaturdaySales.docx,
  ThaboEssay.docx, SalesReport.docx, SaturdaySales.xlsx - also copied into
  the VM's G:\My Drive\CAT\Word\.
- tests/uploads/catword/ (done-right copies): Newsletter-done.docx,
  SaturdaySales-done.docx, ThaboEssay-done.docx, SalesReport-done.docx.
- Each upload block was marked on its starter (0 on every check) and its
  done copy (full marks) with UploadMarkFile(); the tables block's two Jev
  checks too (Jev sure on all but the starter's merged-row check, which
  would wait for Claude). ThaboEssay's word count (66) is a word split of the
  three corrected paragraphs - check it against Word's status bar when the
  real file is made.

**For the lead:** the VM probably needs Word restarted cleanly or a reboot
(and its ~WRA*.asd / AutoRecovery files cleared - I did not delete anything).
Other writers' scripts that save Word files will hang too.

## 9. What the platform lacked

- **lib/officexml.php does not read** text columns (w:cols), the watermark
  (a shape in the header), page colour (w:background), page borders
  (w:pgBorders), hyphenation (w:autoHyphenation), line numbers
  (w:lnNumType), paper size as a test (the section has widthCm/heightCm but
  docx.section cannot test them), hyperlinks (w:hyperlink and its
  relationship target), pictures, shapes, text boxes, WordArt, SmartArt and
  their wrapping, comments, table styles, borders, shading or merged cells
  (gridSpan - a Jev check reads the row's cell count instead), or whether a
  table cell holds a formula field or a typed number. So: pagelayout's
  upload leaves out columns and the watermark (asked for, unmarked);
  `illustrations` has **no upload**; `integration` leaves the hyperlink
  unmarked; `tables` cannot tell a SUM field from a typed 215.
- No **triple-click** step and no **drag** step in simulations: the table
  grid is a click on a square, not a drag.
- A **type** step always ends with Enter. In a dialog box that is OK (fine
  for one box), but it rules out typing in two boxes of one dialog, or in a
  table cell (Enter makes a new line there) - the table lesson uses a keys
  step (Tab) instead.
- Pasting with COM shows no Paste Options button, so the paste simulation's
  last picture has none (the text says where it appears).
