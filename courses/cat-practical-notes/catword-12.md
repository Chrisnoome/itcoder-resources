# catword Grade 12 lessons - writer's notes

Course `catword`, the Grade 12 chapter: lessons `tracking`, `pagination`,
`crossrefs`, `mergesources`, `linking`, `macros` (content/catword/), written
9 October 2026 to courses/cat-practical-writing.md ("Grades 11 and 12").
Numbered 21-26 on the guess that Grade 10 has 11 lessons and Grade 11 nine
(styles, multilevel, sections, headers, footnotes, mailmerge, labels,
importing, templates - the Grade 11 writer's kit lists them); the video
numbers (catword-21.1 ...) follow. Renumber both if Grade 11 ends with a
different count.

**Status (9 October 2026, about 03:00):** all six lessons written, screened
in the CAT VM, checked and in `content/catword/index.php` (numbers 21-26),
with their glossary rows (`content/cattheory10/glossary.php`, a "catword -
Word, Grade 12" block), CAPS and SAGs lines (`content/catword/caps.php`,
`sags.php`) and video rows (`cat-videos/README.md`). The shared-file hold
was lifted while I wrote; nothing was committed or published.

## 1. Lessons written

| # | Lesson | Title | Marks CAPS / IEB | Simulations (steps) | Upload (checks) |
|---|---|---|---|---|---|
| 21 | `tracking` | Tracking changes | 50 / 64 | simTrackOn 2, simAllMarkup 2, simDecide 2; IEB simCompare 2 | upFarewell 4 (Farewell letter.docx) |
| 22 | `pagination` | Line and page breaks | 42 / 50 | simKeepNext 5, simBreakBefore 2; IEB simAccess 2 | upWater 4 (Water report.docx) |
| 23 | `crossrefs` | Bookmarks and cross-references | 42 / 42 | simBookmark 3 (one typed), simCrossRef 2, simUpdate 2 (keys) | upCrossRefs 4 (Water report final.docx) |
| 24 | `mergesources` | Mail merge from any source | 50 / 52 | simUseList 3, simFilter 2 | upMergeCsv 4 (Farewell invitation.docx + Farewell guests.csv; the MERGED document is uploaded) |
| 25 | `linking` | Linking and embedding | 42 / 42 | simObject 2 | upLinkReport 4 (Botha report.docx + Botha sales.xlsx) |
| 26 | `macros` | Macros (IEB) | 0 / 40 | simRecord 3 (one typed) | upSignOff 4 (Committee letter.docx; one check by Jev) |
| | | **Total** | **226 / 290** | 16 + 3 IEB, 39 steps | 6 uploads, 24 checks |

Every lesson: quote card (no portraits - none of the six people has one in
public/assets/quotes), contents, a Scenario (4 parts), a study block, one
own-words reveal (all but `crossrefs` and `macros`, whose explanations sit
in written questions), Jev `points` on every written question, `why` on
every option, `// VIDEO` comments, and an exam-style upload (a starter file
and a numbered task list). Each lesson's doc comment gives its sources, its
screens, what its upload can and cannot mark, and its mark breakdown.

Every starter file scores 0 and every done-right copy full marks on the
exact checks (scratch runner `UploadMarkFile`, Jev off); `macros`' Jev check
("the sign-off once only") waits for Jev/Claude.

### The plan, and why

Planned from the Grade 12 Word lines of cat-caps.md (Term 1: links,
reviewing - tracking changes, line breaks / pagination; Term 2: mail merge
from different sources, objects - linking and embedding; Term 3: reinforce,
page layout, integration with linking) and cat-sags.md 8.2 Grade 12 (line and
page breaks; bookmark and cross reference; review - thesaurus, word counts,
accessibility, translate and language, track changes, show mark-up,
reviewing pane, accept or reject, compare versions, protect; mail merge from
different sources and from electronic forms; macros). cat-course.md 3.3's
chapters (Tracking changes; Mail merge from any source; Pagination and
finishing; Macros) are kept, with one more, "Linking and macros", for
linking and embedding (CAPS Term 2 and 3), which no chapter named.

- **Board sections.** Compare versions and protect (restrict editing, block
  authors) - IEB, in `tracking`. Accessibility checker and translate - IEB,
  in `pagination`; the proofing language counts for both (the CAPS 2025
  paper set English (South Africa)). Online forms as a merge source - IEB,
  in `mergesources`. Macros - IEB only: `macros` is one 'ieb' section (CAPS
  0 marks, as cattheory12's per-board exam guides), with a one-line note to
  CAPS pupils before it.
- **Thesaurus and word count** (IEB Grade 12, CAPS Grade 12 Term 1
  "reinforce") are Grade 10's (`proofing`): not taught again; `tracking`
  links Grade 10's comments, `pagination` links the heading styles.
- **Grade 11 is not taught again**: `mergesources` recaps mail merge in one
  section and names Grade 11's `mailmerge` and `labels` (plain text until
  Grade 11 is indexed - see 6); captions
  (References > Insert Caption) are only named as a cross-reference target.
- **Exam-style tasks**: every upload is a starter file with a numbered task
  list, marked from the uploaded file.

## 2. Glossary rows

Added to `content/cattheory10/glossary.php` (grade 12, `'course' =>
'catword'`). Not added, because the Grade 11 writer Glosses them and their
rows (grade 11) should be the ones: **data source** and **Word field** -
my lessons Gloss() them, so they show whichever row exists. Existing rows
used as they are: `accessible`, `alt text` (cattheory11), `CSV`, `filter`,
`record`, `field`.

```php
    ['Track Changes', 12, true, 'tracking', 'why', 'A Word setting that records every change made to a document - text added, text deleted, formatting changed - with who made it and when, so that each change can be accepted or rejected later.', ['course' => 'catword', 'also' => ['tracked changes', 'track changes']]],
    ['Markup', 12, true, 'tracking', 'markup', 'The marks Word shows for tracked changes and comments: coloured, underlined text for what was added, crossed-out text for what was deleted, a line in the margin beside every changed line, and notes for formatting changes and comments.', ['course' => 'catword', 'also' => ['mark-up']]],
    ['Pagination', 12, true, 'pagination', 'problem', 'How a document is divided into pages - where each page ends. Word works it out again every time the text, the margins or the font change.', ['course' => 'catword']],
    ['Keep with next', 12, true, 'pagination', 'keepnext', 'A paragraph setting (Paragraph box, Line and Page Breaks tab) that keeps the paragraph on the same page as the paragraph after it - so a heading is never left alone at the bottom of a page.', ['course' => 'catword']],
    ['Keep lines together', 12, true, 'pagination', 'keeplines', 'A paragraph setting (Paragraph box, Line and Page Breaks tab) that stops Word from splitting the paragraph over two pages: if it does not fit, the whole paragraph moves to the next page.', ['course' => 'catword']],
    ['Page break before', 12, true, 'pagination', 'before', 'A paragraph setting (Paragraph box, Line and Page Breaks tab) that always starts the paragraph at the top of a new page - like a page break, but it belongs to the paragraph and moves with it.', ['course' => 'catword']],
    ['Widow', 12, true, 'pagination', 'widow', 'The last line of a paragraph printed alone at the top of a new page.', ['course' => 'catword', 'also' => ['widows', 'widow/orphan control']]],
    ['Orphan', 12, true, 'pagination', 'widow', 'The first line of a paragraph printed alone at the bottom of a page.', ['course' => 'catword', 'also' => ['orphans']]],
    ['Proofing language', 12, true, 'pagination', 'language', 'The language Word uses to check the spelling and grammar of some text - for South African documents, English (South Africa). It is stored with the text itself, so a document can mix languages.', ['course' => 'catword']],
    ['Accessibility Checker', 12, true, 'pagination', 'access', 'A Word tool (Review > Check Accessibility) that lists what makes a document hard to use for people with a disability - such as a picture without alt text - and how to fix each problem.', ['course' => 'catword', 'also' => ['Check Accessibility']]],
    ['Word bookmark', 12, true, 'crossrefs', 'bookmark', 'A name given to a place or a piece of text in a Word document (Insert > Bookmark), so that you can jump to it, link to it, or refer to it in a cross-reference.', ['course' => 'catword']],
    ['Cross-reference', 12, true, 'crossrefs', 'crossref', 'Text in a document that refers to another part of the same document - "see Table 1 on page 4" - inserted by Word (Insert > Cross-reference) as a field, so that it can be updated when that part moves or changes.', ['course' => 'catword', 'also' => ['cross-references', 'cross reference']]],
    ['Embedded object', 12, true, 'linking', 'three', 'Data from another program (an Excel table, a chart, a slide) stored inside a document as a copy. Double-click it to edit it with that program\'s tools; it does not change when the original file changes.', ['course' => 'catword', 'also' => ['embed', 'embedding', 'embedded']]],
    ['Linked object', 12, true, 'linking', 'three', 'Data from another file shown in a document but kept in its source file: the document stores only where the file is. When the source file changes, the linked object can be updated to match.', ['course' => 'catword', 'also' => ['paste link']]],
    ['OLE', 12, true, 'linking', 'three', 'Object Linking and Embedding - the Windows way of putting data from one program into a file of another, either as an embedded copy or as a link to the source file.', ['course' => 'catword', 'also' => ['Object Linking and Embedding', 'OLE object']]],
    ['Macro', 12, true, 'macros', 'what', 'A recorded set of steps (keys pressed and commands chosen) that Word saves under a name and can play back with one command, a shortcut key or a button - to do a job that is often repeated.', ['course' => 'catword', 'also' => ['macros']]],
    ['VBA', 12, true, 'macros', 'what', 'Visual Basic for Applications - the programming language in which Office programs store macros. Recording a macro writes the VBA for you.', ['course' => 'catword', 'also' => ['Visual Basic for Applications']]],
    ['Macro-enabled document', 12, true, 'macros', 'save', 'A Word document saved as .docm, which can hold macros. An ordinary .docx cannot: Word removes the macros when it is saved as .docx.', ['course' => 'catword', 'also' => ['docm', '.docm']]],
```

## 3. CAPS lines

In `content/catword/caps.php` (`macros` is `['enrichment' => true]`, IEB
only):

```php
        'tracking' => [
            [12, 1, 'Word Processing: reviewing - proofing (spelling and grammar, comments, word count); tracking changes, including accepting and rejecting'],
        ],
        'pagination' => [
            [12, 1, 'Word Processing: line breaks - pagination issues such as widow/orphan control'],
            [12, 3, 'Word Processing: page layout with advanced techniques'],
        ],
        'crossrefs' => [
            [12, 1, 'Word Processing: links - bookmark, hyperlink, cross-reference'],
        ],
        'mergesources' => [
            [12, 2, 'Word Processing: mail merge from different data sources - word processing table, spreadsheet, database, csv file, e-mail list'],
        ],
        'linking' => [
            [12, 2, 'Word Processing: objects - reinforce manipulation (tables, graphics); linking and embedding'],
            [12, 3, 'Word Processing: integration with other software including linking objects'],
        ],
        'macros' => ['enrichment' => true],
```

## 4. SAGs lines

In `content/catword/sags.php`:

```php
        'tracking' => [
            [12, 'P2', 'review - track changes, show mark-up, reviewing pane, accept or reject changes'],
            [12, 'P2', 'review - compare versions, protect (block authors, restrict editing)'],
        ],
        'pagination' => [
            [12, 'P2', 'line and page breaks - widow/orphan control, keep with next, keep lines together, page break before'],
            [12, 'P2', 'review - accessibility, translate and select language'],
        ],
        'crossrefs' => [
            [12, 'P2', 'links - bookmark and cross reference'],
        ],
        'mergesources' => [
            [12, 'P2', 'mail merge from different data sources - word processing table, database, csv file, e-mail list; data collected via electronic forms (Microsoft or Google Forms) through a spreadsheet'],
        ],
        'linking' => [
            [12, 'P2', 'integration - linking and embedding objects (paste link, insert object, update and break links)'],
        ],
        'macros' => [
            [12, 'P2', 'macros - record and view'],
        ],
```

## 5. Drawings

Used (margin doodles, existing names): cat-who-changed-it, red-pen,
cat-final-final, cat-keys-padlock-honest (tracking); cat-report-page-stack,
scroll-lock-lonely (pagination); treasure-map, cat-path-signpost
(crossrefs); cat-email-to-cc-bcc, cat-spreadsheet-or-database,
cat-forms-pile (mergesources); cat-copy-vs-move, cat-adapter-chain
(linking); robot-homework, cat-compcrime-trojan (macros). Not yet CAT-drawn:
red-pen (has cat-), treasure-map, scroll-lock-lonely, robot-homework.

Wished for:
- tracking: Clicky as a judge with two stamps, ACCEPT and REJECT, over a letter covered in coloured marks.
- tracking: a pair of sunglasses labelled "No Markup" over a page still covered in red underneath.
- pagination: a heading waving goodbye from the foot of one page to its paragraph on the next.
- pagination: a train - a carriage coupled to its engine (Keep with next) beside one that always starts a new train (Page break before).
- crossrefs: a signpost "Table 1 ->" that walks along with the table when it moves.
- mergesources: a Venn diagram - And is the overlap, Or is both circles - with matric names in it.
- linking: a photocopy, a parcel and a telephone line from an Excel sheet to a Word page (paste, embed, link).
- macros: a little robot typing the same sign-off on a pile of letters.

## 6. Anything I was unsure of

- **Numbering**: 21-26 assume Grade 11 is lessons 12-20 (their files say so:
  styles 12 ... templates 20). The Grade 11 entries are **not in
  index.php yet**, so my seven links to their lessons are plain text for now
  (`check-lesson-links` would fail otherwise). Once they are indexed, put
  the links back - the exact text is in the table below.
- **Overlap with Grade 11, settled by reading their files**: their
  `importing` teaches Paste Special and Paste link (with a simulation), so
  `linking` recaps it and teaches the forms of Paste link, Insert > Object,
  the Links box and choosing; their `mailmerge` / `labels` teach connecting a
  spreadsheet, insert merge field, finish and merging to e-mail, so
  `mergesources` dropped its Insert Merge Field and Finish simulations and
  recaps them; their `templates` teaches Restrict Editing for forms, so
  `tracking`'s IEB section builds on it (Tracked changes, Block Authors).
- **Word 365 in the VM** has no "Changes" group on the Review tab: Accept,
  Reject, Previous and Next are in the **Tracking** group (with Track
  Changes), and the Comments group has its own Next/Previous. The Reviewing
  Pane is titled **Revisions**; the accessibility pane is the
  **Accessibility Assistant**; the filter box is **Query Options** (Filter
  Records / Sort Records), not "Filter and Sort". The lessons use these
  names; older Word versions differ.
- `pagination`: the "Language" menu (Set Proofing Language) and the Translate
  menu could not be pictured; the language is taught with a status-bar
  figure, Translate in prose.
- `crossrefs` upload: in the starter the table stays on page 1 either way, so
  the page check reads "on page 1" - it cannot tell a cross-reference from
  typed text (see 9).
- `macros`: the VBA shown in the lesson is what the recorder writes for
  those steps (TypeText / TypeParagraph) - written, not pictured.
- Quotes: Fitzgerald, Brian Clark, "Author unknown" (a journey of a thousand
  sites), Regis McKenna, Esther Dyson, Gretchen Rubin - none used by another
  CAT lesson (checked against content/cat*/). Esther Dyson's is the long
  version as in the bank.
- The **account name** "Chris Noome" is in the core properties (creator /
  last modified by) of other writers' starter and test files in
  public/assets/practical/catword/ and tests/uploads/catword/ (Lab rules,
  Scones, Specials, Trip letter, Phones in class, Camp report, School
  handbook, Science expo and their done copies). Mine are scrubbed
  (BestLessons) and checked. Worth a pass before publishing.
- In the VM, Word's tracked changes and comments take the **signed-in
  account's name** unless `Options.UseLocalUserInfo` is set - my scripts set
  it and put it back. Anyone screening Track Changes or comments must do the
  same.

Grade 11 links made plain (restore these when Grade 11 is in index.php; in `mergesources` the first two now read "Grade 11's lessons <em>Mail merge: letters</em> and <em>Labels, e-mails and rules</em>"):

| Lesson | Now | Link |
|---|---|---|
| `tracking` | `Grade 11 (<em>Templates, forms and sharing</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=templates#protect">Grade 11</a>` |
| `crossrefs` | `Grade 11 (<em>Footnotes, captions and an index</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=footnotes#captions">Grade 11</a>` |
| `mergesources` | `Grade 11 (<em>Mail merge: letters</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=mailmerge">Grade 11</a>` |
| `mergesources` | `Grade 11 (<em>Labels, e-mails and rules</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=labels">Grade 11</a>` |
| `mergesources` | `Grade 11 (<em>Mail merge: letters</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=mailmerge#finish">Grade 11</a>` |
| `mergesources` | `Grade 11 (<em>Labels, e-mails and rules</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=labels#email">Grade 11</a>` |
| `linking` | `Grade 11 (<em>Text and data from other files</em>)` | `<a class="lesson-link" href="/lesson.php?c=catword&amp;id=importing#paste">Grade 11</a>` |

## 7. Screen scripts written and run

In AIResources/tools/sim-screens/, run in the CAT VM with
`pwsh -File vm-shots.ps1 <name>`:

- `work/catword12-kit.ps1` - my helpers, after office-kit and
  work/catword-kit: a 1910 px wide window for the Review tab (`Wide`),
  `LocalUser` (reviewers' names, not the Office account), `SaveDoc12` (the
  flat OPC packed into a .docx, as catword11-kit's SaveDoc, with the core
  properties set to BestLessons and a refusal if the account name is still
  in it), `Pic` (the guard started afresh for each picture, as catword11-kit's
  P, and the Add-ins/Claude ribbon groups painted out), `MenuPic`,
  `FindAny`, `DumpMenu`, `Retry`, `C12` (characters, Alt+letter, close).
- `catword-tracking.ps1`, `catword-pagination.ps1`, `catword-crossrefs.ps1`,
  `catword-mergesources.ps1`, `catword-linking.ps1`, `catword-macros.ps1` -
  all ran to the end; pictures in public/assets/sims/catword/catword-<lesson>-*.png
  (only those the lessons use).

Lessons learnt (for the shared kit):
- **The input guard**: in this VM a UI Automation press, Word's start-up and
  posted keys move the input clock, so `Guard` fails at the first picture
  after a ribbon tab is pressed. Start it afresh before each picture.
- **PowerShell**: in an array literal `@( 'a' + $x + 'b', ... )` the comma
  binds before `+` - the string is split into several elements. Bracket it:
  `('a' + $x + 'b')`. (It cost two crossrefs runs.)
- `$f` and `$F` are the same variable: a `$f = ...` in a script overwrites
  catword-kit's crop `$F`.
- Dialog boxes (Bookmark, Cross-reference, Record Macro, Query Options,
  Mail Merge Recipients) ignore characters posted to them; Alt+letter worked
  in the Paragraph box only. The Macros split button's menu, Language,
  Translate, Paste and Object menus did not open through UI Automation.
- Word's Dialogs(214) (Record Macro) can be shown from another process, but
  recording driven by posted keys kept no macro.
- The queue: about 18 scripts waited for the lock at once; a run could wait
  over an hour.

## 8. Starter files made

Made by real Word (and Excel) in the VM, packed by `SaveDoc12`, in
C:\sims\files\<script>\ and G:\My Drive\CAT\Word\; copied to
public/assets/practical/catword/: Farewell letter.docx, Water report.docx,
Water report final.docx, Farewell invitation.docx, Farewell guests.csv,
Botha report.docx, Botha sales.xlsx, Committee letter.docx. Done-right
copies in tests/uploads/catword/: Farewell letter done.docx (the ", the
drinks" insertion taken out of its XML after the task changed - the script
now rejects it), Water report done.docx, Water report final done.docx,
Farewell letters done.docx (Word merged all eight; the three unpaid letters
were cut from its XML - see the note in catword-mergesources.ps1), Botha
report done.docx, Committee letter done.docx. Botha sales.xlsx's "last
modified by" (the account) was scrubbed on the host; **the copy in
G:\My Drive\CAT\Word\ in the VM still has it** - replace it with the
site's copy.

## 9. What the platform lacked

- **Tracked changes**: lib/officexml.php reads inserted text as in and
  deleted text as out, so an accepted change and an undecided one look the
  same - only rejections and new text can be marked. Suggested: count
  `w:ins` / `w:del` / `w:moveFrom` (and comments.xml) in `docx.document` -
  a `docx.revisions` test (count / none).
- **Line and Page Breaks**: `keepNext`, `keepLines`, `widowControl` are not
  read (only `pageBreakBefore`), and `docx.pageBreaks` counts typed breaks
  and Page break before together. Suggested: the four flags on
  `docx.paragraph`, and typed breaks counted apart.
- **Language** (`w:lang`), **alt text** (`wp:docPr/@descr`), **bookmarks**
  (`w:bookmarkStart`) and **fields** in the body (REF, PAGEREF, HYPERLINK \l,
  LINK, MERGEFIELD) are not read: a cross-reference cannot be told from
  typed text, nor a linked table from a pasted one. Suggested: `docx.field`
  (type, the text it shows) and `docx.bookmark` (exists, name).
- **Macros**: the site takes .docx only. A .docm is a .docx with
  word/vbaProject.bin; its word/vbaData.xml names each macro and its key
  (`wne:mcd wne:macroName`, `wne:keymaps`) - readable without running
  anything. Suggested: accept .docm, and a `docm.macro` test (name, key)
  that never executes it.
- **OLE objects** (embedded or linked, icons) are not read.
- **Simulations**: no step for "choose from a drop-down list" - the
  cross-reference simulation's last three choices are described in its
  'done' text.
- `bin/check-*.php` need an index entry to see a lesson; I checked before
  indexing with a scratch mirror of the repo (lib, bin and content/catword
  copied, the rest junctions).
