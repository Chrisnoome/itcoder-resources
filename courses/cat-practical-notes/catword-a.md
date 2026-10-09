# catword lessons 1-5 (Grade 10) - writer A's notes

Course `catword`, lessons `start`, `editing`, `fonts`, `paragraphs`, `lists`
(content/catword/), written 8 October 2026 to courses/cat-practical-writing.md.

## 1. Lessons written

| Lesson | Title | Marks CAPS / IEB | Simulations (steps) | Upload (checks) |
|---|---|---|---|---|
| `start` | The Word window and your first document | 56 / 56 | practice (unmarked); simNewDoc 2, simRuler 2, simTypeTitle 1, simSaveCloud 5; hotspot hsWordParts 5 | upBothaNotice 4 (no starter: a new document) |
| `editing` | Moving around, selecting and editing | 46 / 46 | simDeleteRepeat 3, simUndo 1, simMoveSlip 4, simReplace 4 | upTripLetter 4 (Trip letter.docx) |
| `fonts` | Formatting characters | 46 / 46 | simTitleFont 4, simColour 2, simSmallCaps 3, simPainter 2 | upSpecials 6 (Specials.docx) |
| `paragraphs` | Formatting paragraphs | 42 / 42 | simShowHide 1, simAlign 2, simParaDialog 4, simBorder 2 | upLabRules 6 (Lab rules.docx) |
| `lists` | Bullets, numbering and tabs | 40 / 40 | simBullets 1, simSort 2, simNumbering 2, simTabs 5 | upScones 4 (Scones.docx) |

No BoardSection: every Grade 10 Word line in these lessons is in both
syllabuses (the IEB names customised lists and tabs again in Grade 11; they
are taught here at a basic level, as CAPS Term 2 asks).

Unusual:
- `start` opens with "Try this first" + `SimulationPractice ('word')` and the
  `// VIDEO catprac-00.1` comment, copied from catpilot/word.php. It teaches
  saving to the cloud (Google Drive G:\My Drive\CAT\Word, OneDrive), Save vs
  Save As, good file names (linking cattheory10 `files#naming`), and File >
  Info (Protect, Inspect, Version History).
- Dialog boxes (Find and Replace, Font, Paragraph, Sort Text, Tabs) are
  pictured as their own windows. Word's dialogs show almost nothing to UI
  Automation, so each state of a box (Small caps ticked, Saturday typed,
  1 cm and 6 pt, a right tab with dots) was set through COM and the box
  opened again - real screens of each moment; targets read off the pictures
  (marked `// read off <picture>` in the lessons).
- Menus mostly did not come out: only the Borders menu was pictured (drawn
  onto the window where it opened). So choosing a bullet from the Bullet
  Library, Shading colours, Line Spacing and Change Case are taught in the
  text (with a picture of the button or the result), not simulated, and the
  Symbol menu has no picture.
- The VM's Save As > Recent list shows a folder `catword-probe` (C:\simsiles)
  in the picture `catword-start-sa-1` and a probe.docx in `catword-start-saved`
  - from my test of SaveAs2. Harmless, but a retake after clearing Word's
  recent list would be tidier.

## 2. Glossary rows

New terms only - `word processor`, `dialog box` and `cloud` are already in
content/cattheory10/glossary.php, so Gloss() shows those rows. `style` and
`Alignment` are Gloss()ed in catpilot/word.php with the same text.

```php
['Template', 10, true, 'start', 'open', 'Ready-made documents - a CV, a flyer, minutes of a meeting - with the layout and formatting done. You replace the sample text with your own.', ['course' => 'catword', 'also' => ['templates']]],
['Ribbon', 10, true, 'start', 'window', 'The wide strip of buttons at the top of Office programs. Its tabs (Home, Insert, Layout...) each show a different set of buttons, arranged in groups.', ['course' => 'catword']],
['Insertion point', 10, true, 'start', 'window', 'The flashing line in a document that shows where the next letter you type will appear. Also called the cursor.', ['course' => 'catword', 'also' => ['cursor']]],
['Status bar', 10, true, 'start', 'window', 'The thin bar along the bottom of the window that shows facts about the document, such as the page number and how many words it has.', ['course' => 'catword']],
['Groups', 10, true, 'start', 'ribbon', 'Sets of related buttons on a ribbon tab, with the group\'s name written underneath - Clipboard, Font, Paragraph, Styles.', ['course' => 'catword', 'also' => ['group']]],
['Dialog box launcher', 10, true, 'start', 'ribbon', 'The tiny arrow in the bottom right corner of a ribbon group. It opens a dialog box with every setting for that group.', ['course' => 'catword']],
['Word wrap', 10, true, 'start', 'typing', 'Word moves a word that does not fit onto the next line by itself, so you never press Enter in the middle of a paragraph.', ['course' => 'catword']],
['Paragraph', 10, true, 'start', 'typing', 'Everything typed up to a press of Enter - a heading, one line of a list, or many lines of text. Word keeps formatting such as alignment and spacing per paragraph.', ['course' => 'catword', 'also' => ['paragraphs']]],
['Select', 10, true, 'editing', 'selecting', 'Mark text so that the next command works on it. Selected text is shown with a grey or blue background.', ['course' => 'catword', 'also' => ['selecting', 'selected']]],
['Undo', 10, true, 'editing', 'deleting', 'Takes back the last change you made. Ctrl+Z, or the curved arrow at the top of the window. Press it again to take back the change before that.', ['course' => 'catword']],
['Clipboard', 10, true, 'editing', 'clipboard', 'A place in the computer\'s memory that holds what you last cut or copied, ready to be pasted.', ['course' => 'catword']],
['Symbol', 10, true, 'editing', 'symbols', 'A character that is not on the keyboard - such as é, ©, €, ½ or °. Insert tab > Symbol.', ['course' => 'catword', 'also' => ['symbols']]],
['AutoCorrect', 10, true, 'editing', 'symbols', 'Word changing what you type as you type it: fixing common spelling mistakes (teh to the), and turning (c) into © and straight quotes into curly ones.', ['course' => 'catword']],
['Typography', 10, true, 'editing', 'symbols', 'How text is set out to be easy and pleasant to read - the right quote marks, dashes and spacing, not only the right words.', ['course' => 'catword']],
['Font', 10, true, 'fonts', 'font', 'A design for the letters, numbers and signs of the alphabet - Aptos, Arial, Times New Roman. Also called a typeface.', ['course' => 'catword', 'also' => ['fonts', 'typeface']]],
['Font size', 10, true, 'fonts', 'font', 'How big the letters are, measured in points. 72 points is about 2.5 cm; ordinary text is 11 or 12 points.', ['course' => 'catword', 'also' => ['points']]],
['Font style', 10, true, 'fonts', 'styles', 'Regular, bold, italic or bold italic - how heavy or slanted the letters of a font are.', ['course' => 'catword']],
['Format Painter', 10, true, 'fonts', 'painter', 'A button (the paintbrush in the Clipboard group) that copies the formatting of the text the insertion point is in, and paints it onto the next text you click or select.', ['course' => 'catword']],
['Paragraph mark', 10, true, 'paragraphs', 'marks', 'The hidden ¶ character Word stores where you pressed Enter. It ends a paragraph and holds that paragraph\'s formatting.', ['course' => 'catword', 'also' => ['pilcrow']]],
['Formatting marks', 10, true, 'paragraphs', 'marks', 'The hidden characters Show/Hide displays - ¶ for Enter, a dot for a space, an arrow for a tab. They never print.', ['course' => 'catword', 'also' => ['formatting symbols']]],
['Style', 10, true, 'paragraphs', 'styles', 'A named set of formatting - font, size, colour, spacing - that you apply in one click. Heading 1 and Normal are styles.', ['course' => 'catword', 'also' => ['styles', 'quick styles']]],
['Alignment', 10, true, 'paragraphs', 'align', 'Where the lines of a paragraph sit between the margins: left, centred, right or justified.', ['course' => 'catword']],
['Indent', 10, true, 'paragraphs', 'indents', 'The distance between a paragraph and the margin - the whole paragraph moved in (left or right indent), only its first line (first-line indent), or every line but the first (hanging indent).', ['course' => 'catword', 'also' => ['indents']]],
['Hanging indent', 10, true, 'lists', 'bullets', 'An indent where every line of a paragraph except the first is moved in. In a list the bullet or number hangs out on the left and the text lines up under itself.', ['course' => 'catword']],
['List levels', 10, true, 'lists', 'numbering', 'Steps inside steps: a lower level is moved in and numbered differently (1. then a.). Tab at the start of an item moves it down a level; Shift+Tab moves it back up.', ['course' => 'catword']],
['Tab stop', 10, true, 'lists', 'tabs', 'A place on a line where the Tab key jumps to. Word has one every 1.27 cm; you can set your own, of four kinds - left, centre, right and decimal - with or without a leader.', ['course' => 'catword', 'also' => ['tab stops']]],
['Leader', 10, true, 'lists', 'tabs', 'Dots, dashes or a line that fill the gap a tab leaves, so the eye can follow it across - Scones ........ R5.', ['course' => 'catword', 'also' => ['dot leader']]],
```

## 3. CAPS lines

```php
'start' => [
    [10, 1, 'Word Processing: first looks - ribbons, tabs, menus; structure/elements of a document - pages, paragraphs, lines/texts, objects'],
    [10, 1, 'Word Processing: file management - create, open, close, save, save as'],
    [10, 1, 'Word Processing: enter text; basic punctuation - one space after all punctuation; Shift for one capital, Caps Lock for consecutive capitals'],
],
'editing' => [
    [10, 1, 'Word Processing: select data with keyboard and/or mouse; enter, edit and delete text; special characters (symbols)'],
    [10, 1, 'Word Processing: editing - cut, copy, paste, find and replace'],
    [10, 1, 'Word Processing: autocorrect and basic typography - quotes, dashes'],
],
'fonts' => [
    [10, 1, 'Word Processing: formatting - font type, style, size, colour, highlight, effects (all font styles and effects in the Font dialog)'],
],
'paragraphs' => [
    [10, 1, 'Word Processing: basic punctuation - formatting marks'],
    [10, 1, 'Word Processing: formatting - paragraph spacing (paragraph and lines within a paragraph), alignment, borders, shading, simple indents (increase and decrease); existing quick styles'],
    [10, 2, 'Word Processing: paragraphs - indents (first line, hanging)'],
],
'lists' => [
    [10, 2, 'Word Processing: paragraphs - bullets (pictures, symbols, font size and colour) and numbering (font size and colour)'],
    [10, 2, 'Word Processing: paragraphs - tabs (position, alignment, leader)'],
],
```

## 4. SAGs lines (topic 'P2' = 8.2 Word processing, as catpilot/sags.php)

```php
'start' => [
    [10, 'P2', 'standard features; workspace, ribbons, tabs and menus'],
    [10, 'P2', 'document management - open, close, save, save as; use inbuilt templates; Info - protect document, inspect document, version history'],
],
'editing' => [
    [10, 'P2', 'selecting with keyboard or mouse; clipboard - cut, copy, paste, undo'],
    [10, 'P2', 'editing - find, replace, select; symbols'],
],
'fonts' => [
    [10, 'P2', 'font formatting - type, style, size, colour, highlight, effects, bold, underline, italic, subscript, superscript, clear formatting, change case'],
    [10, 'P2', 'clipboard - format painter'],
],
'paragraphs' => [
    [10, 'P2', 'paragraph formatting - hanging indents, aligning, spacing, borders, shading, formatting symbols'],
    [10, 'P2', 'existing quick styles'],
],
'lists' => [
    [10, 'P2', 'paragraph formatting - bullets and numbering (basic), sorting'],
],
```

Grade 10 Word lines **not** in lessons 1-5 (they belong to 6-10, the other
writer): basic printing, page layout and breaks, tables, illustrations,
links, comments, headers and footers, text box and WordArt, page
background, arrange, spelling and grammar, view options and help. CAPS
"view options - print layout and preview" is touched in `start` (the view
buttons) but taught in `pagelayout` / `proofing`.

## 5. Drawings

Used (margin doodles, existing names; a CAT redraw `cat-<name>` is used
where one exists): typewriter-qwerty, click-maze, shift-vs-capslock,
sync-cloud, lost-file (start); click-maze, backspace-delete, ctrl-c-ctrl-v,
find-replace (editing); comic-sans, caps-shout (fonts); ghost-mouse,
enter-key (paragraphs); gran-recipe, aligned (lists).

Not yet CAT-drawn and worth redrawing in the marker style: comic-sans,
find-replace, enter-key (its caption is about Pascal's Writeln - only the
picture is used), ghost-mouse, gran-recipe, aligned.

Wished for (one line each):
- start: Clicky reading a 400-page manual while a pupil just clicks Blank document.
- start: a laptop with an umbrella in the rain, its files floating up safe into a cloud.
- editing: Clicky holding scissors and a glue stick over a paragraph ("cut, paste").
- editing: the clipboard as a waiting tray between two pages.
- fonts: a serif "A" with little feet next to a sans serif "A" in sneakers.
- fonts: Clicky with a paint roller painting a word bold red (Format Painter).
- paragraphs: a page with margins dashed and one paragraph stepping in (indent vs margin).
- paragraphs: a stack of empty ¶ boxes sliding down a page.
- lists: "iiiii" and "mmmmm" with the same number of spaces after them, ending in different places.

## 6. Anything I was unsure of

- **Portraits not in public/assets/quotes**: Brian Eno (editing) and Arj
  Barker (fonts) have portraits in the quote bank (sw_applications_files
  general_image-4415.png, CC BY 2.0; dc_netiquette_files general_image-1072.png,
  CC BY 2.0, Stuart Sevastos). I may not add files there, so both use
  anonymous.svg "no portrait" - the lead may add eno.png / barker.png.
  Gail Collins (paragraphs) has none.
- The 1984 date on the Steve Jobs WordStar quote is from its context (the
  Macintosh launch); the bank gives no date.
- "About one man in twelve is colour-blind" (fonts margin) - the usual
  figure for red-green colour blindness in men of European descent; lower in
  some African populations. Remove it if in doubt.
- "Aptos took over from Calibri as Word's standard font in 2024" - announced
  July 2023, rolled out through 2024.

## 7. Screen scripts written and run

All in AIResources/tools/sim-screens/, run in the CAT VM with
`pwsh -File vm-shots.ps1 <name>`:

- `work/catword-kit.ps1` - shared helpers for my five scripts (in work\ so
  vm-shots copies it into the VM): dialogs opened on a background thread
  (a modal box blocks UI Automation's Invoke) and pictured by their own
  handle, menus drawn onto the window, Escape posted to close them;
  pictures **cropped in the script** (never the title bar) with every target
  written in per cent to out\<name>.json, so no `cat-crop.py` entry is needed.
- `catword-start.ps1`, `catword-editing.ps1`, `catword-fonts.ps1`,
  `catword-paragraphs.ps1`, `catword-lists.ps1`.

Runs (8 October 2026): all five ran to the end in the VM after fixes; the
pictures are in public/assets/sims/catword/catword-<lesson>-*.png (only the
ones the lessons use). Problems met, for the next writer:
- **Document.SaveAs2 hangs** in the CAT VM (shown or hidden Word; no
  dialog appears). The kit saves the way a pupil does - File > Save As >
  Recent > the CAT Word folder on G: > name > Save - then copies the file
  from G:\My Drive\CAT\Word to C:\simsiles\<script>\. Writer B's
  scripts (catword-pagelayout etc.) call SaveAs2 too and may hit the same.
- A failed run leaves Word open with a modal box: the next run of my
  scripts kills WINWORD first (work/catword-kit.ps1).
- Busy VM: several runs waited the full 30 minutes for the lock.

## 8. Starter files made

Made by real Word in the VM, saved to C:\sims\files\<script>\ and
G:\My Drive\CAT\Word\, copied to public/assets/practical/catword/:
Trip letter.docx, Specials.docx, Lab rules.docx, Scones.docx. Done-right
copies (also real Word) in tests/uploads/catword/: Botha notice 2026-12-16.docx,
Trip letter done.docx, Specials done.docx, Lab rules done.docx, Scones done.docx.
Checked with my own runner (scratchpad, UploadMarkFile with Jev off): every
done-right file meets every exact check, every starter meets none; the Jev
checks (one space after full stops; sentence case) were shown the right
values - starter "400 pupils.  These" / "PLEASE ORDER BY THURSDAY." and done
"400 pupils. These" / "Please order by Thursday.". bin/check-uploads.php
--no-jev passes.

## 9. What the platform lacked

- *(Closed 9 October 2026: the reader reads these now; the uploads mark highlight and small caps (Specials), spacing and borders (Lab rules), list types and the dot-leader tab (Scones), the empty paragraphs, and the file's name (Botha notice).)*
- **lib/officexml.php did not read** highlight, strikethrough, sub/
  superscript, small caps, line or paragraph spacing, indents, borders,
  shading, tab stops, list type (bulleted vs numbered) or list level. So
  the uploads cannot check those, and the lessons' upload tasks leave them
  out (the simulations teach them). Worth adding to OfficeDocxRunProps /
  OfficeDocxParaProps: w:highlight, w:strike, w:vertAlign, w:smallCaps,
  w:caps, w:spacing, w:ind, w:pBdr, w:shd, w:tabs, w:numPr's numId/ilvl
  with numbering.xml's numFmt.
- **docx.document drops empty paragraphs**, so "remove the extra Enter"
  cannot be checked (Lab rules task asks for it, unmarked).
- **The uploaded file's name is not checked** - lesson 1 asks for a good
  name (Botha notice 2026-12-16) but no rule can see it.
- No **triple-click** step kind in simulations (left, right, double only);
  lesson 2 selected a line with a click in the left margin instead. Since
  9 October 2026 `'button' => 'triple'` exists, and simMoveSlip's first
  step is a triple-click on the paragraph (same screens).
- No way to capture Word's menus reliably (they are not new top-level
  windows most of the time), and Word's dialog boxes expose no controls to
  UI Automation - so no click-through in a dialog, and targets in dialogs
  are read off by eye.
- The VM's Office is signed in with Chris's school account: Backstage's
  Save As middle column and Info's right side name it - my pictures crop
  them away (see 7).
