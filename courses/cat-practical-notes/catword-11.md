# catword Grade 11 (lessons 12-20) - writer's notes

Course `catword`, Grade 11 chapter, written 9 October 2026 to
[../cat-practical-writing.md](../cat-practical-writing.md) ("Grades 11 and
12"). Nine lessons, numbered 12-20 after Grade 10's eleven (`references` is
lesson 11); the Grade 12 writer numbered theirs from 21 on the same guess
([catword-12.md](catword-12.md)), so the numbers agree.

Planned from the Grade 11 Word lines of `cat-caps.md` (section 3, Grade 11,
terms 1-4) and `cat-sags.md` (8.2, Grade 11); cat-course.md 3.3's chapters
(Styles; Sections and page numbering; References; Mail merge; Forms and
templates) are kept, with "Styles and lists" for the first and one more,
"Working with other files", for the input, paste special and editing lines
no chapter named. Mail merge has two lessons (letters; labels, e-mail and
rules), as the IEB line is long.

## 1. Lessons written

| # | Lesson | Marks CAPS / IEB | Simulations (steps) | Upload (checks, marks) |
|---|---|---|---|---|
| 12 | `styles` - Changing and creating styles | 56 / 56 | simModify 3 (right-click, typed), simUpdate 2, simNewStyle 3 (typed), simFonts 3 | upHandbook 4 checks, 6 (School handbook.docx) |
| 13 | `multilevel` - Custom lists, numbered headings and drop caps | 54 / 54 | simBullet 3, simNumberValue 3 (right-click, typed), simMultilevel 2, simDropCap 3 | upExpo 4 checks, 6 (Science expo.docx) |
| 14 | `sections` - Sections, columns and cover pages | 54 / 54 | simSectionBreak 3, simLandscape 2, simColumns 4 (keys), simCover 3 | upCamp 3 checks, 6 (Camp report.docx) |
| 15 | `headers` - Headers, footers and page numbering | 50 / 52 | simFileName 2, simFirstPage 2 (double-click), simStartAt 3 (typed), simLink 2 | upHistory 5 checks (2 by Jev), 6 (History project.docx) |
| 16 | `footnotes` - Footnotes, captions and an index | 48 / 50 | simFootnote 3 (typed), simCaption 2 (typed), simFigures 2, simIndex 2 (keys) | upWater 3 checks (1 by Jev), 6 (Saving water report.docx) |
| 17 | `mailmerge` - Mail merge: letters | 52 / 52 | simStart 3, simRecipients 2, simField 2, simFinish 4 | upParents 4 checks, 6 (Parents evening letter.docx + Grade 11 parents.xlsx) |
| 18 | `labels` - Labels, e-mails and rules | 40 / 44 | simLabels 2, simUpdateLabels 1, simRule 2 (IEB) | upLabels 4 checks, 6 (Grade 11 parents.xlsx; Grade 11 parents table.docx for CAPS) |
| 19 | `importing` - Text and data from other files | 54 / 50 | simTextFromFile 3, simConvert 3, simPasteSpecial 2 (keys), simReplace 2 (keys) | upPrices 3 checks, 6 (Price list heading.rtf + Bakery prices.csv; a new document) |
| 20 | `templates` - Templates, forms and sharing | 54 / 52 | simTemplate 2 (keys), simRestrict 4 | upForm 4 checks, 6 (Camp form.docx) |
| | **Total** | **462 / 464** | 32 simulations | 9 uploads |

Every lesson: quote card, contents, `block-anchor` sections, simulations
after each skill, quizzes with why lines, a match, a written question with
Jev points, a Scenario (4 parts), a study block, an upload ("Do it in
Word"), two `// VIDEO` comments and a video plan. Every upload block marks
its starter 0 and its done-right copy full marks (exact checks run with
`UploadMarkFile`, Jev off; the four Jev checks were read by hand on the
done copies' extracted values).

Board sections:
- `headers` - Quick Parts (IEB Grade 11; CAPS reaches the same fields from
  Document Info).
- `footnotes` - equations, Search (Smart Lookup / Researcher) and a table of
  authorities (IEB Grade 11).
- `labels` - a Word table as the data source (CAPS Grade 11; the IEB meets it
  in Grade 12, `mergesources`); e-mail merges and rules (IEB Grade 11).
- `importing` - table formulas COUNT, MAX, MIN and combinations (CAPS Grade 11).
- `templates` - legacy form fields (CAPS Grade 11, "Forms (legacy tools
  only)").

Everything else is both boards' Grade 11. Built on Grade 10 by links, never
re-taught: quick styles (paragraphs#styles), heading levels and the table of
contents (references#headings, #toc), bullets/numbering/tabs (lists#...),
breaks/columns/headers/cover page (pagelayout#...), table SUM/AVERAGE
(tables#data), find and replace (editing#replace), AutoCorrect, printing and
PDF (proofing#...), copying between programs and help (integration#paste,
#help), templates (start#open).

## 2. Index entries (add last - all nine files pass the checks)

```php
    'styles'        => ['number' => 12, 'grade' => 11, 'chapter' => 'Styles and lists', 'title' => 'Changing and creating styles', 'summary' => 'Modify a style, update it to match, direct formatting, a style of your own, and the Design tab: themes, colours, fonts and Set as Default.'],
    'multilevel'    => ['number' => 13, 'grade' => 11, 'chapter' => 'Styles and lists', 'title' => 'Custom lists, numbered headings and drop caps', 'summary' => 'Your own bullets and number formats, Set Numbering Value, multilevel lists linked to the headings, exact spacing, the Tabs box and a drop cap.'],
    'sections'      => ['number' => 14, 'grade' => 11, 'chapter' => 'Sections and page numbering', 'title' => 'Sections, columns and cover pages', 'summary' => 'The four section breaks, one landscape section, columns with a column break, and a cover page with its content controls.'],
    'headers'       => ['number' => 15, 'grade' => 11, 'chapter' => 'Sections and page numbering', 'title' => 'Headers, footers and page numbering', 'summary' => 'Fields in headers and footers (date, file name, author), Different First Page, odd and even pages, Format Page Numbers and Link to Previous.'],
    'footnotes'     => ['number' => 16, 'grade' => 11, 'chapter' => 'References', 'title' => 'Footnotes, captions and an index', 'summary' => 'Footnotes and endnotes, captions and a table of figures, marking index entries and inserting an index - and, for the IEB, equations, Search and a table of authorities.'],
    'mailmerge'     => ['number' => 17, 'grade' => 11, 'chapter' => 'Mail merge', 'title' => 'Mail merge: letters', 'summary' => 'A main document and a data source, choosing and filtering recipients, merge fields, previewing, and finishing the merge.'],
    'labels'        => ['number' => 18, 'grade' => 11, 'chapter' => 'Mail merge', 'title' => 'Labels, e-mails and rules', 'summary' => 'Mail merge labels, a Word table as the data source, checking for errors - and, for the IEB, e-mail merges and rules.'],
    'importing'     => ['number' => 19, 'grade' => 11, 'chapter' => 'Working with other files', 'title' => 'Text and data from other files', 'summary' => 'Opening and inserting .txt, .csv and .rtf files, converting text to a table, Paste Special and linking to Excel, table formulas, and Find and Replace with more options.'],
    'templates'     => ['number' => 20, 'grade' => 11, 'chapter' => 'Forms and templates', 'title' => 'Templates, forms and sharing', 'summary' => 'Templates and saving your own, forms with content controls and legacy form fields, protecting a form, advanced printing, PDF and sharing.'],
```

## 3. Glossary rows

New terms only. Already in content/cattheory10/glossary.php and Gloss()ed
with its text: Template (templates), Plain text file, RTF, CSV (importing).
`field` is cattheory11's database field, so the Word sense is **Word field**.

```php
    // ---- catword - Word, Grade 11 (practical course) --------------------
    ['Direct formatting', 11, true, 'styles', 'update', 'Formatting added to text by hand - bold, a colour, a font - on top of its style. It stays when the style changes, until it is cleared.', ['course' => 'catword']],
    ['Styles pane', 11, true, 'styles', 'create', 'A pane that lists the styles, with buttons to make a new style and to manage them. Ctrl+Alt+Shift+S, or the small arrow at the bottom right of the Styles group.', ['course' => 'catword']],
    ['Document theme', 11, true, 'styles', 'themes', 'The set of colours, fonts and effects a document\'s styles use. Changing the theme on the Design tab changes the look of every style at once.', ['course' => 'catword', 'also' => ['Word theme']]],
    ['Multilevel list', 11, true, 'multilevel', 'multilevel', 'A list with levels inside levels, each numbered in its own way - 1, then 1.1, then 1.1.1 - from the Multilevel List button. Linked to the heading styles, it numbers a document\'s headings (outline numbering).', ['course' => 'catword', 'also' => ['multi-level list', 'outline numbering']]],
    ['Drop cap', 11, true, 'multilevel', 'dropcap', 'A large first letter of a paragraph that drops down beside the first few lines, as in magazines. Insert tab > Drop Cap.', ['course' => 'catword', 'also' => ['drop capital']]],
    ['Column break', 11, true, 'sections', 'columns', 'A mark that makes the text after it start at the top of the next column. Layout > Breaks > Column, or Ctrl+Shift+Enter.', ['course' => 'catword']],
    ['Content controls', 11, true, 'sections', 'cover', 'Boxes in a document that hold one kind of content - text, a date picked from a calendar, a choice from a list, a tick box. Cover pages, forms and templates use them.', ['course' => 'catword', 'also' => ['content control']]],
    ['Word field', 11, true, 'headers', 'fields', 'A code in a Word document that Word fills in and keeps up to date - a page number, the date, the file name, the author. F9 updates it; Alt+F9 shows the code itself.', ['course' => 'catword', 'also' => ['field code']]],
    ['Footnote', 11, true, 'footnotes', 'footnotes', 'A note at the bottom of a page, linked by a small number in the text - for an explanation or a source that would break the sentence.', ['course' => 'catword', 'also' => ['footnotes']]],
    ['Endnote', 11, true, 'footnotes', 'footnotes', 'A note like a footnote, but collected with the other endnotes at the end of the document (or of a section).', ['course' => 'catword', 'also' => ['endnotes']]],
    ['Caption', 11, true, 'footnotes', 'captions', 'A numbered label for a table, picture or chart - Table 1: Water used per day. Word numbers captions by itself and can list them in a table of figures.', ['course' => 'catword', 'also' => ['captions']]],
    ['Table of figures', 11, true, 'footnotes', 'figures', 'A list of a document\'s captions - every Table, or every Figure - with the page each is on, built by Word from the captions.', ['course' => 'catword']],
    ['Word index', 11, true, 'footnotes', 'index', 'A list at the end of a document of its important words, in alphabetical order, each with the pages it is on. Word builds it from words marked with Mark Entry.', ['course' => 'catword', 'also' => ['index entries', 'document index']]],
    ['Mail merge', 11, true, 'mailmerge', 'what', 'Joining one document (a letter, a label) with a list of people, to make a personal copy for each person on the list.', ['course' => 'catword']],
    ['Main document', 11, true, 'mailmerge', 'what', 'The document in a mail merge that has the text that is the same for everyone, with merge fields where each person\'s details go.', ['course' => 'catword']],
    ['Data source', 11, true, 'mailmerge', 'what', 'The list a mail merge takes its details from - a spreadsheet, a Word table or a database - with one row (record) for each person and a heading for each column.', ['course' => 'catword', 'also' => ['recipient list']]],
    ['Merge fields', 11, true, 'mailmerge', 'what', 'Places in the main document, shown as «FirstName», where a mail merge puts each person\'s details from a column of the data source.', ['course' => 'catword', 'also' => ['merge field']]],
    ['Linked', 11, true, 'importing', 'paste', 'Connected to the file it came from: a linked Excel table or chart in Word changes when the Excel file changes and the link is updated.', ['course' => 'catword']],
```

## 4. CAPS lines (`content/catword/caps.php`, `[11, term, 'what']`, wording from cat-caps.md)

```php
        'styles' => [
            [11, 2, 'Word Processing: styles (heading/paragraph) - quick style gallery (reinforce); change/edit a style; create a new style'],
            [11, 1, 'Word Processing: page layout/design - themes and background'],
        ],
        'multilevel' => [
            [11, 1, 'Word Processing: paragraph - customise bullets and numbering; outline numbering/multi-level lists; customise spacing; drop cap'],
        ],
        'sections' => [
            [11, 1, 'Word Processing: page layout/design - cover page and content controls'],
            [11, 1, 'Word Processing: document layout - section breaks and sections; columns (column break, spacing, size)'],
        ],
        'headers' => [
            [11, 1, 'Word Processing: document layout - sections, including linking and delinking; headers and footers (fields - date, author, path and filename, document title); page numbers (different first page, odd, even, starting from a specific number, numbering formats)'],
        ],
        'footnotes' => [
            [11, 3, 'Word Processing: references - table of contents/figures; footnotes and endnotes; captions; index (citations and bibliography: lesson 11, references)'],
        ],
        'mailmerge' => [
            [11, 3, 'Word Processing: mail merge (source: spreadsheet) - letters'],
        ],
        'labels' => [
            [11, 3, 'Word Processing: mail merge (source: spreadsheet and word processing table) - labels'],
        ],
        'importing' => [
            [11, 1, 'Word Processing: input data from different file formats - text files, csv, rtf; import/export data'],
            [11, 1, 'Word Processing: editing - paste special; find and replace (more options)'],
            [11, 1, 'Word Processing: tables - revise Grade 10; formulae - revise sum and average, add count, max, min and combinations'],
            [11, 3, 'Word Processing: options in the Editing group on the Home tab'],
            [11, 4, 'Word Processing: integration with spreadsheet (paste options, linking)'],
            [11, 2, 'Spreadsheets: integration with Word - adding or linking a chart to a word processing document'],
        ],
        'templates' => [
            [11, 1, 'Word Processing: file management - printing (range of pages, odd or even, number of copies, print quality, pages per sheet); export/print to file (print to PDF); send to/share (e-mail, cloud)'],
            [11, 1, 'Word Processing: templates - purpose; create documents from templates; save documents as templates'],
            [11, 1, 'Word Processing: forms (legacy tools only); using help features'],
            [11, 4, 'Documents: create documents by customising templates'],
        ],
```

"Reinforce Grade 10 skills in activities" (Term 1) is the uploads and
scenarios of every lesson - not one line of its own.

## 5. SAGs lines (`content/catword/sags.php`, topic 'P2' = 8.2)

```php
        'styles' => [
            [11, 'P2', 'styles - change, edit and create'],
            [11, 'P2', 'document formatting - themes, colours, fonts, paragraph spacing, effects, defaults'],
        ],
        'multilevel' => [
            [11, 'P2', 'customise bullets, numbering, outline numbering/multi-level lists, customise spacing, tabs'],
            [11, 'P2', 'drop cap'],
        ],
        'sections' => [
            [11, 'P2', 'section breaks and sections'],
            [11, 'P2', 'cover pages and blank pages'],
        ],
        'headers' => [
            [11, 'P2', 'headers and footers with fields (date, author, path and filename, document title); page numbers (different first page, odd, even, starting from a number, numbering formats)'],
            [11, 'P2', 'sections - linking and delinking'],
            [11, 'P2', 'quick parts; date and time'],
        ],
        'footnotes' => [
            [11, 'P2', 'references - table of figures, footnotes and endnotes, smart lookup and researcher, captions, index, table of authorities (table of contents, citations and bibliography: lesson 11)'],
            [11, 'P2', 'equations'],
        ],
        'mailmerge' => [
            [11, 'P2', 'mail merge from a spreadsheet - letters; select and edit recipients; insert merge fields; preview results, find recipients; finish and merge to print or document'],
        ],
        'labels' => [
            [11, 'P2', 'mail merge - labels and e-mails; rules, update; check errors; finish and merge to e-mail'],
        ],
        'importing' => [
            [11, 'P2', 'input data from .txt, .csv, .rtf'],
            [11, 'P2', 'paste special; find and replace with more options'],
            [11, 'P2', 'review - AutoCorrect'],
        ],
        'templates' => [
            [11, 'P2', 'save documents as templates'],
            [11, 'P2', 'advanced printing options (range of pages, odd or even, copies, print quality, pages per sheet); share (with people, e-mail, present online); export to PDF'],
        ],
```

Every Grade 11 Word line of both files is placed. The IEB's Grade 11 table of
contents and citations/bibliography are in Grade 10's `references` (its CAPS
sections say "IEB pupils in Grade 11"); its sags.php lines may want `[11,
'P2', ...]` rows for those - the lead's call.

## 6. Video plans (`cat-videos/README.md` rows)

```
| catword-12.1 | Changing and updating a style | 8 | [catword-styles.md](catword-styles.md) |
| catword-12.2 | New styles and the Design tab | 8 | [catword-styles.md](catword-styles.md) |
| catword-13.1 | Your own bullets and numbers | 7 | [catword-multilevel.md](catword-multilevel.md) |
| catword-13.2 | Numbered headings, spacing and drop caps | 8 | [catword-multilevel.md](catword-multilevel.md) |
| catword-14.1 | Section breaks and a landscape page | 7 | [catword-sections.md](catword-sections.md) |
| catword-14.2 | Columns and a cover page | 7 | [catword-sections.md](catword-sections.md) |
| catword-15.1 | Fields and a different first page | 7 | [catword-headers.md](catword-headers.md) |
| catword-15.2 | Page numbers and sections with their own headers | 8 | [catword-headers.md](catword-headers.md) |
| catword-16.1 | Footnotes and captions | 7 | [catword-footnotes.md](catword-footnotes.md) |
| catword-16.2 | A table of figures and an index | 8 | [catword-footnotes.md](catword-footnotes.md) |
| catword-17.1 | The main document and the data source | 8 | [catword-mailmerge.md](catword-mailmerge.md) |
| catword-17.2 | Merge fields, preview and finish | 7 | [catword-mailmerge.md](catword-mailmerge.md) |
| catword-18.1 | Labels and fixing a merge | 8 | [catword-labels.md](catword-labels.md) |
| catword-18.2 | E-mail merges and rules | 6 | [catword-labels.md](catword-labels.md) |
| catword-19.1 | Text, csv and rtf files into Word | 7 | [catword-importing.md](catword-importing.md) |
| catword-19.2 | Paste Special, links and Find and Replace | 8 | [catword-importing.md](catword-importing.md) |
| catword-20.1 | Templates and a form | 8 | [catword-templates.md](catword-templates.md) |
| catword-20.2 | Printing, PDF and sharing | 6 | [catword-templates.md](catword-templates.md) |

18 videos, about 133 minutes. The README's header counts need the lead's
update when these rows go in.
```

## 7. Drawings

Used (existing names; the site uses `cat-<name>` where the Art chat has
drawn one): css-one-page-two-layouts, cookie-cutter (styles); gran-recipe,
number-wheel (multilevel); cat-report-page-stack (sections);
metadata-envelope (headers); seo-crawl-index (footnotes); methods-photocopy
(mailmerge); cat-naidoo-address (labels); cat-csv-fence, find-replace
(importing); cookie-cutter, gui-good-form (templates).

Not yet CAT-drawn and worth redrawing: css-one-page-two-layouts,
cookie-cutter, number-wheel, metadata-envelope, seo-crawl-index,
methods-photocopy, gui-good-form (gran-recipe, find-replace are on Grade
10's list already).

Wished for:
- styles: Clicky with one big paint roller labelled Heading 1, 40 headings changing at once.
- styles: a layer cake - the style at the bottom, "by hand" icing on top, Clicky scraping it off.
- multilevel: a ladder 1, 1.1, 1.1.1 with Clicky stepping down with Tab.
- sections: a train of carriages, the luggage (layout) kept in the coupling at the back of each.
- sections: four pages in a row, one lying on its side, Clicky with scissors between them.
- headers: a printout with a luggage tag showing its file path.
- headers: two carriages joined by a chain "Link to Previous", Clicky unhooking it.
- footnotes: an old book open, Clicky lifting a footnote with tweezers.
- footnotes: four machines - headings, captions, citations, marked words in; contents, figures, bibliography, index out.
- mailmerge: one letter into a machine, 64 personal envelopes out, Clicky turning the handle.
- labels: a symptom - cause - fix chart, Clicky in a doctor's coat.
- labels: a fork in the road "Paid = No / Paid = Yes" (rules).
- importing: .txt, .rtf and .csv envelopes sliding into one Word page.
- importing: a Word page and an Excel sheet joined by a chain (linked) beside a photocopy (embedded).
- templates: a form covered in scribbles beside a clean one with grey boxes and a padlock.

## 8. Anything I was unsure of

- **The Developer tab would not appear in the VM's Word** - neither by
  writing Word.officeUI (%LOCALAPPDATA%\Microsoft\Office; the VM had none)
  nor by ticking it in Word Options through UI Automation (the tick took, the
  tab did not show after OK). So `templates` teaches content controls,
  Properties, Design Mode and the legacy tools in the text with no Developer
  pictures; the controls were put in by COM and the form pictured on the Home
  tab, and Restrict Editing is simulated from the Review tab (Protect >
  Restrict Editing). The run turned the Word Options tick off again at the
  end. Worth a screen retake once the tab shows (the Grade 12 macros lesson
  needs it too).
- **Researcher / Smart Lookup** (IEB Grade 11): Word 365's References tab
  has neither (checked in the VM); the lesson says right-click > Search
  replaced them. Present Online is called retired. Both worth a check by Chris.
- **A Word table as a data source** must be the first thing in the document
  - the usual guidance; the quiz `q18Table` is worded "most likely reason".
- **Mail merge in the VM**: the Select Data Source box would not take a path
  through UI Automation (no File name box found), so the data source was
  opened with MailMerge.OpenDataSource from a second process; the
  simulation `simRecipients` stops at Use an Existing List (no pictures of the
  file and Select Table boxes) and its done line says the rest.
- **Labels**: the Label Options box (Start Mail Merge > Labels...) was not
  pictured - the run opened Mailings > Labels (Envelopes and Labels) instead;
  that box is the figure, and the label document was made by COM
  (MailingLabel.CreateNewDocument("L7160"): 7 rows x 5 columns, so the upload
  checks `rows => 7`). A pupil who picks another product loses that 1 mark.
- **Cover pages**: the cover's title box sits in a text box the reader does
  not see, so `sections` marks only that the report starts on a new page
  after the cover; the done copy's cover had "Chris Noome" as its author (the
  VM's Word user) - painted out of the picture; the file is a test fixture.
  All starter files carry the VM's Word user as the document's Author
  property (docProps) - worth blanking before publishing if that matters.
- **Heading 1 is 20 pt in Word 365**, so the styles task makes it 24 pt.
- **Merged letters**: Word made 5 sections for 4 letters; the check allows
  4 or 5 (sections 0-3 there, no section 5).
- Quotes: Zeldman (styles, portrait), an anonymous joke (multilevel),
  Hodgkinson (sections), K.J. McCory (headers), Christina Baker Kline
  (footnotes), Regis McKenna (mailmerge), Bill Gates (labels, portrait),
  Stewart Butterfield (importing), Niklas Zennstrom (templates) - checked
  against every cat* lesson on 9 October; the Grade 12 writer was choosing at
  the same time, so a clash is possible.

## 9. Screen scripts and starter files

In AIResources/tools/sim-screens/, run with `pwsh -File vm-shots.ps1 <name>`:
`catword-styles`, `catword-multilevel`, `catword-sections`, `catword-headers`,
`catword-footnotes`, `catword-mailmerge`, `catword-labels`,
`catword-importing`, `catword-templates` (and `catword-g11probe`, a probe of
the ribbon tabs and menus). Shared helpers: `work/catword11-kit.ps1` (with
`work/catword-kit.ps1`):
- **SaveDoc** - no Word save at all: the document's WordOpenXML is packed into
  a .docx by System.IO.Compression in the VM (Save As > Recent had lost the
  CAT folder, SaveAs2 hangs), written to C:\sims\files\<name>\ and the
  cloud (G:\My Drive\CAT\Word).
- **P** - Pic, then the Add-ins group painted out; the guard is started
  afresh just before each picture (Word's start-up and posted clicks moved
  the input clock and wiped whole runs).
- **RightClickEl / ClickEl** - a right or left click on a ribbon control,
  posted to the window that draws it (gallery right-click menus; menus UIA
  will not open); **DocMenu** - the document's own right-click menu at the
  cursor; **ClickPic** - a click at a place read off a dialog's picture,
  scaled for DPI-unaware boxes (it opened More >> in Find and Replace);
  **PaintOut** - paint over an account name in a file box; **UseList** -
  Use an Existing List (see doubts).
- PowerShell variables ignore case: a loop variable `$f` or `$t` overwrites
  the kit's `$F` (crop) and `$T` (ControlType) - it cost two runs.

Starter files (public/assets/practical/catword/): School handbook.docx,
Science expo.docx, Camp report.docx, History project.docx, Saving water report.docx,
Parents evening letter.docx, Grade 11 parents.xlsx (real Excel), Grade 11
parents table.docx, Price list heading.rtf (Word's own RTF, from the
clipboard), Bakery prices.csv (real Excel), Camp form.docx - all also in the
VM's G:\My Drive\CAT\Word. Done-right copies in tests/uploads/catword/:
School handbook done, Science expo done, Camp report done, History project
done, Saving water report done, Parents evening letters done, Parent labels done,
Price list done, Camp form done (.docx).

## 10. What the platform lacked

- **lib/officexml.php does not read**: footnotes and endnotes (footnotes.xml),
  numbering formats and start values (numbering.xml: a list is only "a list"),
  w:pgNumType (page number format, Start at), w:titlePg (Different First Page
  is seen only through a 'first' footer part - Jev decides), w:cols (columns),
  column breaks (a w:br type column reads as a line break), text in text boxes
  (cover page titles), legacy form fields and content controls' types (only
  their placeholder text), document protection (settings.xml), the mail-merge
  settings of a main document, linked/embedded objects (Paste link), the
  document theme's name. So those are taught and simulated but not marked, or
  marked through the text they leave. Suggested reads: docx.footnotes,
  docx.section pageNumbers/titlePage/columns, docx.paragraph listFormat/
  numberText, docx.settings protection.
- `docx.paragraph` selects only the **first** paragraph that contains its
  words, so a table of figures and a caption with the same words cannot both
  be checked exactly (the caption is a Jev check). A `style` selector
  ("the first paragraph in the Caption style") would help.
- No triple-click or drag step in simulations (Grade 10's note still holds).
- vm-shots' lock is not first come, first served: one run waited 90 minutes
  and failed, others waited over an hour.
