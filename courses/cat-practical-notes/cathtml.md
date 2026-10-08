# cathtml lessons 1-5 (Grade 10) - writer's notes

Course `cathtml` (Web Design (HTML)), lessons `whatis`, `structure`, `text`,
`formatting`, `design` (content/cathtml/), written 8 October 2026 to
courses/cat-practical-writing.md ("HTML lessons").

## 1. Lessons written

| Lesson | Title | Marks CAPS / IEB | html blocks (checks) | Other questions |
|---|---|---|---|---|
| `whatis` | What HTML is | 44 / 44 | htmlTryIt 1 (the "Try this first", 2 marks), htmlWhatisFix 4, htmlWhatisBuild 3 | quiz x2, typed x2, match, select, dragwords, order, written (2), own-words reveal |
| `structure` | The shape of a page | 44 / 44 | htmlStructureFix 4, htmlStructureHeadings 3 | match x2 (one groups), order, markwords (lines), typed, select, quiz, written (2), own-words reveal |
| `text` | Paragraphs, line breaks and lines | 40 / 40 | htmlTextFindUs 4 (one with Jev), htmlTextPoem 4 | quiz, match, select, markwords (lines), dragwords, written (2), own-words reveal |
| `formatting` | Bold, italic and underline | 40 / 40 | htmlFormattingFix 4, htmlFormattingBuild 4 (two with Jev) | match, quiz, dragwords, markwords (words), typed, written (2), own-words reveal |
| `design` | Planning and building a page | 40 / 40 | htmlDesignFix 4, htmlDesignBuild 7 (one with Jev) | order, select, labelcode, typed, quiz, written (4), Good to Know (CSS) |

No BoardSection (the brief: Grade 10 HTML is CAPS-only, IEB Grade 11
revision). Each lesson opens with the one-line note "CAPS pupils learn this
chapter in Grade 10, IEB pupils in Grade 11. It is a good start either way."
Nothing says "exam".

Unusual:
- `whatis` opens with "Try this first: the HTML box" (prose: the two panes,
  the tab strip, Check my answer, hints, Check again, two tries, double /
  single marks, Start again, the same HTML twice refused, the model answer,
  marks come from the code) and a 1-check html block (change Hello to
  Howzit, 2 marks).
- The five lessons follow one story: Thabo builds Mr Botha's website
  (Botha's Bakery, Centurion) for koeksisters - first page, price list,
  headings, Find us, specials, and the whole home page from a plan in
  `design`'s final build (7 checks). Side tasks: Lerato's recipe page,
  Thabo's poem (written for the lesson), Ms Naidoo's market day page.
- Every html block's prose says the same task can be done in Notepad++ with
  the downloadable starter file (a plain `<a ... download>` link); the box is
  what is marked.
- Code-like questions use `'language' => 'text'` (markwords, dragwords,
  labelcode): there is no `html` language in lib/codeq.php (see 9).

## 2. Glossary rows

New terms only - `web page`, `website` and `web browser` are already in
content/cattheory10/glossary.php (Gloss() shows those rows; the definitions in
whatis.php are copied from them). **`tag` and `attribute` are taken**:
cattheory10's glossary has `Tags` (Grade 12 metadata, `also` => `tag`) and
`Attribute` (a file attribute), so these lessons Gloss() `HTML tag` and
`HTML attribute` instead. `paragraph` is not Gloss()ed (catword's notes add a
Word `Paragraph` row). `HTML` is in theory10's glossary (IT) but not
cattheory10's.

```php
['HTML', 10, true, 'whatis', 'html', 'HyperText Markup Language - the language web pages are written in. Tags mark what each part of the page is: a heading, a paragraph, bold text.', ['course' => 'cathtml']],
['HTML tag', 10, true, 'whatis', 'tags', 'A word in angle brackets, such as <h1> or </p>, that tells the browser what a part of the page is or how to show it. Also just called a tag.', ['course' => 'cathtml', 'also' => ['HTML tags']]],
['Opening tag', 10, true, 'whatis', 'tags', 'The tag that starts a part of a web page, such as <h1>. What follows it gets its effect.', ['course' => 'cathtml', 'also' => ['opening tags']]],
['Closing tag', 10, true, 'whatis', 'tags', 'The tag that ends a part of a web page: the same name as the opening tag, with a slash after the <, such as </h1>.', ['course' => 'cathtml', 'also' => ['closing tags']]],
['HTML editor', 10, true, 'whatis', 'editor', 'A program for typing and changing the HTML of a web page, such as Notepad++. A plain text editor such as Notepad also works.', ['course' => 'cathtml', 'also' => ['HTML editors']]],
['Document tags', 10, true, 'structure', 'skeleton', 'The four pairs of tags every web page is built on: html, head, title and body.', ['course' => 'cathtml']],
['Nested', 10, true, 'structure', 'order', 'Inside another tag: opened after it, and closed before it. <title> is nested in <head>.', ['course' => 'cathtml', 'also' => ['nesting']]],
['Indenting', 10, true, 'structure', 'order', 'Starting a line further in from the left, with spaces or a Tab, to show that it is inside the tags above it.', ['course' => 'cathtml', 'also' => ['indent', 'indented']]],
['Heading', 10, true, 'structure', 'headings', 'Words that introduce a page or a part of it. HTML has six levels, <h1> (the biggest) to <h6> (the smallest).', ['course' => 'cathtml', 'also' => ['headings']]],
['Line break', 10, true, 'text', 'br', 'The <br> tag: the text after it starts on the next line, with no extra space. It has no closing tag.', ['course' => 'cathtml', 'also' => ['line breaks']]],
['Horizontal rule', 10, true, 'text', 'hr', 'The <hr> tag: a line across the page that separates two parts of it. It has no closing tag.', ['course' => 'cathtml', 'also' => ['horizontal rules']]],
['HTML attribute', 10, true, 'design', 'attributes', 'Extra information in an opening tag, written as name="value" - such as bgcolor="lightyellow" in the body tag.', ['course' => 'cathtml', 'also' => ['HTML attributes']]],
```

Merge warnings: `Indenting` has `also` => `indent`, and catword's notes add
`Indent` (a Word paragraph indent) - drop my `indent` alias if they clash.
`Heading` may clash with a Word heading row if one is added later.

## 3. CAPS lines (cat-caps.md, Grade 10 Term 3, Solution Development: HTML / Web design)

```php
'whatis' => [
    [10, 3, 'HTML / Web design: reinforce websites, web pages, hyperlinks and URLs'],
    [10, 3, 'HTML / Web design: what is HTML? what is an HTML editor? HTML syntax; basic HTML tags, opening and closing'],
    [10, 3, 'HTML / Web design: do the web design section in an HTML or text editor such as Notepad++'],
],
'structure' => [
    [10, 3, 'HTML / Web design: HTML syntax and order of tags; document tags <html>, <head>, <title>, <body>'],
    [10, 3, 'HTML / Web design: headings <h1>-<h6>; structure of a simple HTML page'],
],
'text' => [
    [10, 3, 'HTML / Web design: text <p>, <br>, <hr>; plain text'],
    [10, 3, 'HTML / Web design: closing tags are not needed for some tags (<br>, <hr>)'],
],
'formatting' => [
    [10, 3, 'HTML / Web design: text formatting <b>, <i>, <u>; underline tag; basic troubleshooting'],
],
'design' => [
    [10, 3, 'HTML / Web design: structure and design of a simple HTML page'],
    [10, 3, 'HTML / Web design: attributes as a concept; font tag with face, colour and size attributes; width and size on <hr>; body background colour'],
],
```

Every Grade 10 HTML line of cat-caps.md is taught. "Basic troubleshooting"
(the term overview, line 138) is taught in `formatting` (#bugs) and used in
every fix-it block.

## 4. SAGs lines (IEB Grade 11, 8.5 HTML - topic 'P5' as catpilot/sags.php)

```php
'whatis' => [
    [11, 'P5', 'HTML editors; use an HTML editor to create web pages'],
],
'structure' => [
    [11, 'P5', 'structure and design of a simple HTML page: <html></html>, <head></head>, <title></title>, <body></body>; <h1></h1> to <h6></h6>'],
],
'text' => [
    [11, 'P5', '<p></p>, <br/>, <hr/>'],
],
'formatting' => [
    [11, 'P5', '<b></b>, <i></i>'],
],
'design' => [
    [11, 'P5', 'structure and design of a simple HTML page; <body bgcolor="pink">; <font size="3"> (1 to 7), <font color="green">, <font face="Times New Roman">; <hr/> with size and width'],
],
```

Not taught here (IEB Grade 11 / CAPS Grade 11, later lessons of this
course): `<body text>`, comments `<!-- -->`, `<p align>`, lists, images,
links, `<hr color>`.

## 5. Drawings

Used (existing names; the CAT redraw `cat-<name>` is used where one exists):
page-site-server (whatis, cat- version exists), html-render (whatis,
DesignFigure - IT blue pen, no CAT version), name-tag (structure - IT
drawing from the Java/Pascal courses, no CAT version), typewriter-qwerty
(text, cat- version exists), cobweb-page (formatting, cat- version exists),
kitchen-recipe (design, cat- version only).

Worth redrawing in the CAT style: html-render (the browser reading tags and
drawing the page - number 4 and 5, picture and link, are Grade 11; a Grade
10 version with title, h1, p, hr would fit better), name-tag.

Wished for (one line each):
- whatis: Ms Naidoo's red pen marking "heading" and "bold" on a page of text - and the browser drawing it.
- whatis: Clicky running between two windows, Notepad++ and a browser, with "Ctrl+S" and "F5" signs.
- structure: a parcel with a label (head, title) and contents (body), each labelled with its tag.
- structure: a lunchbox going into a school bag and coming out first (last opened, first closed).
- text: Clicky squashing a stack of spaces and Enters into one space.
- formatting: two pairs of brackets nested, and a crossed pair with a red cross - ( [ ] ) vs ( [ ) ].
- design: a paper sketch of Mr Botha's page with h1, p, hr, h2 written in its margin.
- design: Gogo's red-on-dark-blue page next to the fixed black-on-cream one.

## 6. Anything I was unsure of

- **Attributes in Grade 10.** The lead's list for these lessons was the
  document tags, h1-h6, p, br, hr, b, i, u, syntax and order, structure and
  design, the editor and which tags need no closing tag. cat-caps.md's Grade
  10 Term 3 line also has "attributes as a concept; font tag with face,
  colour and size attributes; width and size on <hr>; body background
  colour" (and the term overview "attributes"), and the brief says every
  Grade 10 line in range must be taught - so `design` teaches them
  (#attributes) and its fix-it and final build use bgcolor, font and hr
  width. Cut that section if the lead meant otherwise.
- **Portraits**: Clifford Stoll (text) and Mike Davidson (formatting) have
  no portrait in public/assets/quotes; their quote cards have none (as
  other CAT lessons do). Zeldman, Berners-Lee and Douglas Adams have
  portraits there; credits are from the quote bank's CSV.
- "The first web page ... 1991 ... still online at info.cern.ch" (whatis
  margin) - CERN restored it there in 2013. "Notepad++ was first released in
  2003 by the programmer Don Ho" - from the Notepad++ site.
  "About one man in twelve is colour-blind" (design margin) - the usual
  figure for men of European descent; lower in some African populations
  (catword's writer used it too). "About 140 colour names" - CSS has 140-148
  named colours. Remove any of these if in doubt.
- A `<title>` typed inside the body: Chrome and Edge still show it on the
  tab (structure's reveal and fix-it say "this browser guessed"). The check
  marks it wrong (inside head).
- `<b><p>..</p></b>` (formatting's reveal): the parser gives an empty b
  before the p, so any check on bold text marks it wrong; the reveal says
  "some browsers show it in bold anyway".

## 7. Screen scripts written and run

In AIResources/tools/sim-screens/, run in the CAT VM with
`pwsh -File vm-shots.ps1 <name>`. **Notepad++ is installed in the VM**
(C:\Program Files\Notepad++); the scripts fall back to Notepad if not.

- `cathtml-whatis.ps1` - Thabo's first page (botha.html) written to
  C:\sims\files\cathtml-whatis\ and G:\My Drive\CAT\HTML\; (1) the page in
  Notepad++; (3) Notepad++'s File > Save As (menu command 41008 posted to
  its window), the dialog pictured by its own handle; (2) the file opened in
  Edge with a fresh profile (--user-data-dir, no account, no welcome pages).
  Run 4 times (Edge's file URL needed %20 for "My Drive"; the dialog search
  needed its name). Cropped with a few lines of Pillow (not cat-crop.py):
  title bars off; in the Save As picture the folders pane is painted over
  (it shows the VM account's name, "Chris - De La Sal..."; the dialog's Hide
  Folders button has no UI Automation name). Pictures:
  public/assets/sims/cathtml/cathtml-whatis-1.png (Notepad++), -2 (Edge),
  -3 (Save As).
- `cathtml-formatting.ps1` - Notepad++ with a page full of mistakes
  (specials-mistakes.html). **Not run**: twice "The VM is busy
  (vm-shots.lock held for 30 minutes)". The lesson does not need it - the
  same page is a code listing in formatting.php #bugs (no placeholder, no
  missing picture). Run it when the VM is free; the picture can then go
  beside the listing.
- `cathtml-files.ps1` - the eight starter files, written to
  C:\sims\files\cathtml-files\ and G:\My Drive\CAT\HTML\. **Not run**:
  twice "The VM is busy" (lock held 30 minutes); it parses clean in
  PowerShell. **To do:** `pwsh -File vm-shots.ps1 cathtml-files` once the VM
  is free - until then only botha.html (from cathtml-whatis) is in the cloud
  folder. The site's copies in public/assets/practical/cathtml/ are made and
  linked.

## 8. Starter files made

Each is the starter of one html block, made from the lesson file itself (so
the two match), in public/assets/practical/cathtml/ and (cathtml-files.ps1)
in G:\My Drive\CAT\HTML\ in the VM: first-page.html (whatis fix),
prices.html and botha-headings.html (structure), find-us.html and poem.html
(text), specials.html and market-day.html (formatting), botha-colours.html
(design fix). The design build starts from an almost empty page - no file.
G:\My Drive\CAT\HTML\ also holds botha.html, the finished first page from
the screen script. If a block's starter changes, change its file too.

## 9. What the platform lacked

- **No `html` language for the code activities** (lib/codeq.php: pascal,
  java, sql, text). The HTML in markwords, dragwords and labelcode uses
  'text', so it shows in the lesson font, not the code font. An 'html'
  language (monospace, `<!-- -->` as a quiet range, tag names as words)
  would suit this course.
- **bin/check-jev.php strips tags from options** (CjText() runs strip_tags),
  so options that ARE tags ('<h1>', '</p>', '<br>') reach Jev empty, and it
  flags them as "may not be right" (sWhatisClosing, sStructureHeadings,
  qStructureSections, qTextAddress, sTextNoClose, qDesignHrWidth). The
  page itself escapes them correctly. Those flags were read and left.
- **No "not" in the html block's rule format**: "the opening times are not
  in the address paragraph" cannot be an 'exact' rule, so that check
  (htmlTextFindUs 4) uses Jev after a rule that the paragraph exists.
- **Rules cannot test order in the source** (head before body, a tag between
  </head> and <body>): the parser moves things back, and 'closed' only tests
  pairing. The fix-its use mistakes the rules can see (unclosed, crossed,
  in the wrong parent, misspelt attributes).

## 10. Checks run

- `php -l` on all five lessons: clean.
- `bin/check-html.php cathtml`: all 11 blocks sound (42 checks; model
  answers full marks, starters not).
- `bin/check-html.php cathtml --live`: all sound. Jev gave "no answer after
  three tries" for the three blocks with 'jev' checks (htmlTextFindUs,
  htmlFormattingBuild, htmlDesignBuild); Claude marked those model answers
  full marks. Worth a second --live run when Jev is up.
- `bin/check-jev.php cathtml <lesson>` on all five: flags worked through -
  why lines that gave answers (mFormattingTags) rewritten, doubtful typed
  answers removed (tFormattingItalic, tDesignBgcolor), one written idea
  reworded. Left: the tag-option flags (section 9) and two "caption gives
  the answer away" flags in whatis (the figures teach Notepad++ and .html
  before the questions on them, on purpose).
- check-lesson-contents, check-figures, check-titles (one Good to Know title
  shortened), check-why, check-code-questions, check-pictures,
  check-more-questions, check-popup-spacing: nothing for cathtml. (For a
  while every global check died on catexcel/charts.php's undefined T_TABLE -
  another writer's file.)
- renderone.php on all five lessons: no WARN lines (whatis 79 818 bytes,
  structure 60 539, text 51 577, formatting 52 045, design 52 715).
