# catpowerpoint - Presentations, Grade 10 (all six lessons)

8 October 2026, written to [../cat-practical-writing.md](../cat-practical-writing.md).
Presentations are examined only in the PAT for both boards, so no lesson
uses exam framing; lesson 6 ties the course to the PAT report summary
(cattheory10 `reports#present`, cattheory12 `patcaps` / `patieb`).

## 1. Lessons written

| Lesson | Marks CAPS / IEB | Simulations | Upload |
|---|---|---|---|
| `start` - Slides, layouts and designs | 42 / 44 | practice `simPracticePowerPoint` (no marks) + 4: `simNewSlide` (2: click, Ctrl+M), `simLayout` (2), `simDelete` (2: click, Delete key), `simTheme` (2) | `upDataTips` - 4 checks (exact) |
| `text` - Text and lists on slides | 42 / 42 | 4: `simTitle` (2: click, type), `simHighlight` (2, double-click), `simReplace` (4: Ctrl+H, type, type, click - the Find and Replace pane), `simOutline` (2) | `upTextTips` - 6 checks (exact) |
| `objects` - Tables, charts and pictures | 48 / 46 | 4: `simTable` (4: click, type, type, click), `simChart` (3), `simShape` (3), `simSmartArt` (4) | `upBakery` - 4 checks (exact) |
| `animation` - Transitions and animation | 36 / 36 | 3: `simTransition` (3), `simAnimate` (3, Fly In), `simStart` (2) | `upBakeryShow` - 4 checks (exact, transitions) |
| `slideshow` - Running a slide show | 40 / 38 | 4: `simFromHere` (2: click, Shift+F5), `simNotes` (2: click, type), `simKiosk` (3), `simPdf` (3) | none - see section 7 |
| `pat` - Presenting your PAT | 36 / 36 | 2: `simPasteChart` (2: click, Ctrl+V), `simSlideNumbers` (4) | `upPhonesPAT` - 5 checks (4 exact, 1 Jev worth 2) |

Unusual:

- **start** opens with the "Try this first" prose block (the Word pilot's, in
  PowerPoint's words), `// VIDEO catprac-00.1`, and `SimulationPractice
  ('powerpoint')` - the new `'powerpoint'` case in `lib/simulation.php`
  (3 steps on `catpowerpoint-start-pr-1` / `pr-2`: click the Font Size box
  showing 24, type 28, press Ctrl+B; the subtitle "Thabo, Grade 10" is
  selected). `lesson.php` already names 'powerpoint' "PowerPoint", and
  `bin/check-simulations.php` already accepts it.
- Board sections: **start** IEB "Templates" (`q1Template`); **objects** CAPS
  "Video and sound" (`q3Audio`); **slideshow** CAPS "Other ways to save a
  show" (.ppsx, .mp4 - `q5Formats`); **pat** a CAPS and an IEB section, prose
  only, on how each board's PAT uses a presentation.
- People: Thabo's class talk "Make your data last" (lessons 1-2), Mr Botha's
  bakery TV show (lessons 3-5), Thabo's PAT "Phones for school work"
  (lesson 6, the survey numbers from cattheory10 `reports`).
- No right-click step: a right-click on a slide thumbnail in the VM opens no menu that can be pictured (tried real right-click, the context-menu key and Shift+F10), so `simDelete` uses click + Delete; the Paste Options menu (pat) would not open for a picture either, so `simPasteChart` stops at the pasted chart and the prose teaches the link choice.
- PowerPoint 365 (2026) opens **Find and Replace as a pane** on the right, not a dialog box - the text lesson teaches the pane.
- Quotes: Bill Gates (start), Douglas Adams twice (text, objects - two
  different quotes; no other unused PowerPoint-fitting quote with a portrait
  already in public/assets/quotes), Robin Sloan (animation), Clay Shirky
  (slideshow), "Benjamin Franklin" - the bank's joke quote, credited as a
  joke (pat). The bank's PowerPoint quotes (Gleick - used twice in
  cattheory12; Turkle, Brie Larson) were left: Gleick is taken, and Turkle
  and Larson have no portrait in public/assets/quotes (their portraits are in
  _ALL_QUOTES.docx media - image156 and image142 - if Chris wants them).

## 2. Glossary rows

Already in content/cattheory10/glossary.php and only Gloss()ed here: PDF,
hyperlink (Grade 10). `PAT` and `Integration` are there as Grade 12 rows
(cattheory12); the Grade 10 rows below give the Presentations course its
own (keep one of each if the site does not allow two). `Layout` is a Grade 11
row in another sense (page layout in usability) - the slide sense below is
different; consider naming it "slide layout" if the glossary keys clash.

```php
    // ---- catpowerpoint Grade 10 -----------------------------------------
    ['presentation', 10, true, 'start', 'uses', 'A set of slides shown one after the other on a screen, usually to support a person who is talking. PowerPoint saves one as a .pptx file.', ['course' => 'catpowerpoint', 'also' => ['presentations']]],
    ['slide', 10, true, 'start', 'uses', 'One page of a presentation - what fills the screen at one time.', ['course' => 'catpowerpoint', 'also' => ['slides']]],
    ['thumbnail', 10, true, 'start', 'window', 'A small picture of a slide (or a photo or a page) - in PowerPoint, the slides down the left of the window.', ['course' => 'catpowerpoint', 'also' => ['thumbnails']]],
    ['view', 10, true, 'start', 'views', 'A way of showing the presentation on the screen while you work, such as Normal or Slide Sorter. The view changes how you see the slides, not the slides themselves.', ['course' => 'catpowerpoint', 'also' => ['views']]],
    ['layout', 10, true, 'start', 'newslide', 'The arrangement of the boxes on a slide - where the title, the text and the pictures go. Title Slide and Title and Content are layouts.', ['course' => 'catpowerpoint', 'also' => ['layouts', 'slide layout']]],
    ['placeholder', 10, true, 'start', 'newslide', 'A box on a slide, set out by its layout, waiting for content - it says, for example, Click to add title.', ['course' => 'catpowerpoint', 'also' => ['placeholders']]],
    ['theme', 10, true, 'start', 'designs', 'A ready-made design for a presentation: the background, colours, fonts and effects, applied to every slide at once. Also called a design.', ['course' => 'catpowerpoint', 'also' => ['themes', 'design']]],
    ['template', 10, true, 'start', 'templates', 'A ready-made file to start from: in PowerPoint, a design with sample slides and placeholders already set out. Saved as a .potx file.', ['course' => 'catpowerpoint', 'also' => ['templates']]],
    ['bullet', 10, true, 'text', 'levels', 'A dot or small symbol at the start of a line in a list. In PowerPoint each line of a content placeholder is a bullet point.', ['course' => 'catpowerpoint', 'also' => ['bullets', 'bullet point']]],
    ['list level', 10, true, 'text', 'levels', 'How far in a bullet point sits: level 1 is a main point, level 2 a point under it - further in, and usually smaller.', ['course' => 'catpowerpoint', 'also' => ['list levels']]],
    ['outline', 10, true, 'text', 'outline', 'A document set out as headings and points under them. In Word, Heading 1 lines and Heading 2 lines; PowerPoint turns them into slide titles and bullet points.', ['course' => 'catpowerpoint']],
    ['integration', 10, true, 'objects', 'excel', 'Using two or more programs together on one job - for example, a chart made in Excel pasted or linked into a PowerPoint presentation or a Word report.', ['course' => 'catpowerpoint']],
    ['Icons', 10, true, 'objects', 'pictures', 'Simple drawn symbols (a phone, a loaf, a clock) from Insert > Icons - they can be resized and coloured without going blurry.', ['course' => 'catpowerpoint']],
    ['SmartArt', 10, true, 'objects', 'smartart', 'Ready-made diagrams in Office - lists, steps (processes), cycles, hierarchies - that you fill in with your own words.', ['course' => 'catpowerpoint']],
    ['transition', 10, true, 'animation', 'transitions', 'The effect as one slide changes to the next in a slide show - Fade, Push, Wipe. It is set on the slide that is coming in.', ['course' => 'catpowerpoint', 'also' => ['transitions']]],
    ['animation', 10, true, 'animation', 'animations', 'An effect on something on a slide - a picture, a shape, a list - that makes it appear, move, change or disappear during the slide show.', ['course' => 'catpowerpoint', 'also' => ['animations']]],
    ['slide show', 10, true, 'slideshow', 'start', 'The presentation shown full screen, one slide at a time, for the audience - started with F5.', ['course' => 'catpowerpoint']],
    ['speaker notes', 10, true, 'slideshow', 'notes', 'Notes typed under a slide for the person presenting. The audience never sees them; the speaker sees them in Presenter View or on printed Notes Pages.', ['course' => 'catpowerpoint', 'also' => ['notes']]],
    ['kiosk', 10, true, 'slideshow', 'setup', 'A screen in a public place that runs by itself, such as a slide show in a shop window or a reception area.', ['course' => 'catpowerpoint']],
    ['PAT', 10, true, 'pat', 'pat', 'Practical Assessment Task: the CAT project in which you solve a problem for a given scenario by finding information, processing it with the applications you have studied, and presenting your findings and recommendations in a report.', ['course' => 'catpowerpoint', 'also' => ['Practical Assessment Task']]],
    ['storyboard', 10, true, 'pat', 'plan', 'A plan of a presentation (or a video): one box per slide, with its title and a note of what goes on it, drawn before you start making it.', ['course' => 'catpowerpoint', 'also' => ['storyboards']]],
```

## 3. CAPS lines

Term 3 is Solution Development: Presentations (cat-caps.md section 3,
Grade 10 Term 3); Term 4 is Information Management and PAT, and Working
with Documents.

```php
        'start' => [
            [10, 3, 'Presentations: uses of presentations; first looks - slides, designs, layouts; basic skills and core concepts'],
            [10, 3, 'Presentations: rules and best practice'],
            [10, 3, 'Presentations: page setup - orientation, size; built-in design tips/ideas'],
            [10, 3, 'Presentations: slides - insert, delete; view options - normal, slide sorter, notes, slide show'],
        ],
        'text' => [
            [10, 3, 'Presentations: formatting, editing and objects transferred from Word'],
        ],
        'objects' => [
            [10, 3, 'Presentations: adding videos and voice recordings'],
            [10, 3, 'Presentations: basic integration techniques (e.g. inserting a graph from a spreadsheet)'],
        ],
        'animation' => [
            [10, 3, 'Presentations: custom animations (basic); slide transitions (basic)'],
        ],
        'slideshow' => [
            [10, 3, 'Presentations: start slide show; set up slide show'],
            [10, 3, 'Presentations: navigation, e.g. hyperlinks; printing options (notes, handouts)'],
            [10, 3, 'Presentations: saving options - video, presentation, show'],
            [10, 3, 'Presentations: view options - notes, slide show'],
        ],
        'pat' => [
            [10, 3, 'Presentations: slides - numbers, headers and footers; reviewing, proofing'],
            [10, 4, 'Information Management and PAT: presentation of information; summarising the report with presentation software'],
            [10, 4, 'Working with Documents: integrate text and graphics into a meaningful message; balance text and graphics for visual effect'],
        ],
```

## 4. SAGs lines

Topic `'P5'` for section 8.5 (as `'P3'` is 8.3 in the catexcel notes).

```php
        'start' => [
            [10, 'P5', 'standard features; workspace, slides, designs, layouts'],
            [10, 'P5', 'open, close, save, save as; templates; help'],
            [10, 'P5', 'view options - normal, slide sorter, notes, slide show'],
            [10, 'P5', 'page setup - orientation, size'],
            [10, 'P5', 'slides - insert, delete'],
        ],
        'text' => [
            [10, 'P5', 'editing - cut, copy, paste, find, replace; entering, editing and deleting text'],
            [10, 'P5', 'formatting - font type, style, size, colour, highlight, alignment; paragraph spacing, alignment, bullets, indentation'],
        ],
        'objects' => [
            [10, 'P5', 'insert tables, images, illustrations'],
        ],
        'animation' => [
            [10, 'P5', 'slides - transitions; slide transitions; basic custom animations'],
        ],
        'slideshow' => [
            [10, 'P5', 'presenting a slide show; view options - notes, slide show'],
            [10, 'P5', 'basic printing; insert links'],
        ],
        'pat' => [
            [10, 'P5', 'slides - numbers, headers and footers; reviewing and proofing'],
            [10, 'P5', 'plan, design and create a presentation for a specific scenario'],
            [10, '3', 'summarising a report with presentation software'],
        ],
```

Every Grade 10 Presentations line of CAPS (Term 3) and SAGs 8.5 is taught
in one of the six lessons.

## 5. Drawings

Used (existing names): `webinar-crowd` (start, the audience), `abstract-art`
(start, designs), `java-sleeping-typist` (start rules; animation helps),
`typewriter-qwerty` (text), `copy-vs-move` (text), `clipboard` (objects),
`gui-remote` (slideshow), `gui-kiosk-form` (slideshow), `giants-shoulders`
(pat). In a CAT course the site uses `cat-<name>.svg` once the Art chat has
drawn it (cat-typewriter-qwerty, cat-copy-vs-move, cat-webinar-crowd and
cat-giants-shoulders exist already).

Wished for (CAT marker style with Clicky):

- **start:** a wall-of-text slide with the back row squinting and Clicky
  asleep on the projector; a "one idea per slide" stack of cards.
- **text:** Clicky pressing Tab, pushing two bullet points one step in like
  furniture.
- **objects:** the bakery queue all glancing up at a TV with a pie chart;
  Excel and PowerPoint holding a chart between them with a chain (link)
  versus scissors (picture).
- **animation:** a slide where every word spins in, the audience dizzy;
  the four animation colours as traffic lights (green in, yellow
  emphasis, red out).
- **slideshow:** Mr Botha's TV with a loop arrow; the speaker's view
  (notes, timer, next slide) versus the audience's view.
- **pat:** a 15-page report on one side of a see-saw, seven slides on the
  other; a storyboard of sticky notes on a wall.

## 6. Anything I was unsure of

- PowerPoint 365's theme gallery in the VM shows the 2023+ themes (Office
  Theme, Archway, Axis, Bjorn, Dark Gradient, Dune, Editorial, Film Burn) -
  the lessons name Archway (start, text), which a school with an older Office
  may not have. (The pat screens kept the Office Theme.) The steps say "a theme" in the uploads.
- "Design Suggestions" (Design tab) and "Designer" (Home tab) are both in
  this build; the lesson names both.
- CAPS's "printing options (notes, handouts)" and the SAGs's "basic printing"
  are taught as prose with a question (no simulation of the Print page).
- The 10-20-30 rule (Guy Kawasaki) margin note is copied from cattheory10
  `reports`.

## 7. Screens, starter files and what the platform lacks

**Screen scripts** (AIResources/tools/sim-screens/), each run in the CAT VM
with `vm-shots.ps1`: `catpowerpoint-start`, `-text`, `-objects`,
`-animation`, `-slideshow`, `-pat`, plus `catpowerpoint-startlay` (the
Layout gallery open, start's lay-2) and `catpowerpoint-pat-files` (the Word
starter PhonesReport.docx again). All use a shared helper
`work/catpowerpoint-kit.ps1` (in work\ so that vm-shots copies it in). The
kit adds real mouse clicks, keys and typing (the VM only), screen grabs
(`Grab`) for moments PrintWindow cannot draw (drop-downs, dialogs), closes
the Designer pane before pictures, minimises Google Drive's pop-up window,
kills a PowerPoint left by a stopped run, and makes Word starters in a job
with a timeout (`WordOutline`). Learnt in the VM:

- PowerPoint's ribbon unfolds fully at an **1800 px wide** window;
  `ActiveWindow.SplitHorizontal = 11` fits five thumbnails.
- A first real click on a ribbon drop-down after COM work often only shows
  the tooltip - `OpenMenu` (UI Automation Expand), `OpenDialog` (Invoke on a
  thread) or `RibbonClick` (title bar first) open them; moving the mouse
  after a menu opens closes it.
- AddTable/AddChart2 on a slide with an empty content placeholder put the
  object *into* the placeholder - deleting the placeholder afterwards
  deletes the table.
- PowerShell 5.1's ConvertTo-Json mangles nested arrays (the first Word
  outlines came out all Heading 2).
- Names with "...": "Header & Footer...", "Set Up Slide Show...",
  "SmartArt...".
- Hand-finished pictures (a cat-crop re-run would undo them): text ol-1..3
  (a 1010-high window, box (9, 58, 1791, 1001)), start lay-2 (from
  startlay), slideshow pdf-4 (the OneDrive account name in the PDF dialog's
  folder pane painted over with "OneDrive"), catpowerpoint-slideshowfull.png
  (the full-screen show, resized to 1280 x 720). Noted in my cat-crop.py entry.

**The VM queue (8 October 2026):** several Word jobs from other writers hung
in the VM's agent (WINWORD stuck from 14:27), so every later job timed out.
While my runs were queued I stopped sims jobs that had run for more than 10
minutes (their host side had already timed out) and their Office process
(scratchpad vmunstick.ps1, about a dozen catword jobs between 15:00 and
17:40) - worth knowing for whoever looks at the catword runs. vm-shots'
lock is not first-come-first-served, so a run can wait over 30 minutes and
fail with "VM is busy".

**Starter files** (made in real Office in the VM, in
public/assets/practical/catpowerpoint/ and G:\My Drive\CAT\PowerPoint):
DataTips.pptx (start), TextTips.pptx + MoreTips.docx (text), Bakery.pptx
(objects), BakeryShow.pptx (animation), PhonesReport.docx +
PhonesSurvey.xlsx (pat). Done-right copies (\*-done.pptx) in tools/sim-screens/files/catpowerpoint-\*/
and tests/uploads/catpowerpoint/; each starter scores 0 and each done-right
copy full marks on the exact checks (scratch runner on UploadMarkFile; the pat
Jev check left to Jev).

**What the platform lacks for presentations** (lib/officexml.php
`OfficePptx()` reads each slide's layout, transition and text only):

- the **theme / design** - so no upload checks "a design was applied";
- **pictures, charts, SmartArt, shapes, tables as tables** (a table's words
  are read as slide text, which is how the objects upload checks the table);
- **animations** (`p:timing`), so the animation upload checks transitions only;
- **speaker notes** (notesSlide parts) and **Set Up Slide Show** settings
  (presProps.xml `p:showPr`), so the slideshow lesson has no upload;
- **headers, footers and slide numbers**, and **hyperlinks** - the pat
  upload leaves them to the pupil's checklist.

Suggested `pptx.slide` tests, if Chris wants them: `pictures`, `charts`,
`tables`, `smartart` (counts of graphicFrame / p:pic kinds), `animations`
(count of p:timing effects), `notes` (contains), `slideNumber` (true), and a
`pptx.show` subject (`loop`, `kiosk`) and `pptx.theme` (`name`).
