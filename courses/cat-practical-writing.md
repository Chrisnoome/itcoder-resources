# Writing the CAT practical lessons - the brief

Chris, 8 October 2026: "do the cat practical courses. nb do a tutorial video
('How to work with software simulations') that gives examples. also, try to
make the instructions and steps for software simulations clearer. at the start
of the course, before doing the first software simulation do a 'try this' that
walks them through a software simulation, how it works - and the number of
chances they get". Then: "you need google drive on the vm - cat files also must
be stored using the cloud - google drive". Then "continue with the cat practical
courses".

Read this all before writing. Read [cat-theory-writing.md](cat-theory-writing.md)
too: **its voice, simplicity, people, questions, Jev, video and notes rules
all apply here** unless this file says otherwise. The plan is
[cat-course.md](cat-course.md) (3.0 for Chris's decisions, 3.3 for the
courses).

## Where things go

| What | Where |
|---|---|
| The courses | `catword`, `catexcel`, `catpowerpoint`, `cathtml` (and `catdb` for Access, Grade 11) in `lib/course.php`, drafts, glossary from `cattheory10` |
| Lesson map | `AIPascalCourse/content/<course>/index.php` - ids, titles, summaries, `'grade'` are set; do not change ids. You may sharpen a title or summary to match what you wrote. |
| A lesson | `AIPascalCourse/content/<course>/<lessonId>.php` |
| Screen scripts | `AIResources/tools/sim-screens/<course>-<lessonId>.ps1` (`$Name` = the file name) |
| Screens on the site | `AIPascalCourse/public/assets/sims/<course>/<course>-<lessonId>-<n>.png` |
| Starter files for pupils | made in real Office in the VM; on the site in `public/assets/practical/<course>/`; **and in the cloud**: `G:\My Drive\CAT\<Word/Excel/PowerPoint/HTML>\` in the VM |
| Video plans | `AIResources/courses/cat-videos/<course>-<lessonId>.md` |
| Glossary, CAPS and SAGs lines, drawings | your notes file (see cat-theory-writing.md "Your notes file") - merged afterwards |

## The model lessons

- **`content/catpilot/word.php`** - the shape of a practical lesson: the
  quote card, `contents`, short prose sections each with a `block-anchor`,
  a simulation after the explanation of each skill, `why` lines, a reveal, a
  written question with Jev `points`, the study block, and an **`upload`**
  block at the end ("now do it for real").
- **`content/catpilot/excel.php`** and **`access.php`** - more simulations,
  including typing (`'type'`) and key (`'keys'`) steps.
- **`content/catpilot/html.php`** - the **`html`** block (typed HTML, live
  preview, checks by `'exact'` rule and Jev).
- **`content/cattheory10/`** - the voice and the people (Thabo, Lerato,
  Gogo Dlamini, Mr Botha of Botha's Bakery, Ms Naidoo at Phumlani Secondary).

## What a practical lesson is

**Learn it, see it, try it on the screen, then do it in the program.**

1. **Say what the skill is for**, with a real job: Mr Botha's price list,
   Thabo's project cover page, Ms Naidoo's class list. Then the steps,
   numbered, one action each, naming the tab, the group and the button exactly
   as Word / Excel / PowerPoint 365 shows them ("Home tab > Paragraph group >
   Center"). Keyboard shortcuts beside the mouse way.
2. **Show it**: a screenshot (`Figure` with the real screen, a caption, the
   part being talked about pointed out in the caption or with a callout) when
   a step is hard to find.
3. **Simulation** right after: the pupil does those steps on real screens. 1-4
   simulations per lesson, 2-5 steps each. Each step's `say` is one clear
   instruction in the words the prose used ("Click **Center** in the Paragraph
   group."). Each step has a `hint` that points to where, never the answer
   itself. Use every kind: click, double-click, right-click (`'button'`),
   type, keys.
4. **Check understanding**: quick auto-marked questions between sections -
   which button, what happens if, put the steps in order, match the shortcut,
   spot the mistake - and one or two `written` with Jev `points` (why use a
   style, not bold; why a page break, not Enters).
5. **Do it for real**: an **`upload`** block (Word, Excel, PowerPoint) or an
   **`html`** block (HTML) near the end of most lessons: the starter file, a
   short numbered task, and 3-6 checks (`'exact'` rules where the file can
   say it, `'jev'` where judgement is needed - rule format in
   `lib/uploadmark.php`'s doc comment and in `lib/html.php`). The task uses
   only what the lesson (and earlier ones) taught.

**The first lesson of each course** starts, before any simulation, with the
"Try this first: how simulations work" prose block and
`SimulationPractice ('<program>')` - copy the Word pilot's block. Word has one;
**Excel and PowerPoint need theirs added** to `SimulationPractice()` in
`lib/simulation.php` (a new `case`, 3 steps: a click, typing in a box, a key
press, on that program's own screens, `'practice' => true` - the Word case is
the pattern). The lesson-1 writer for that course adds it. HTML has no
simulations: its lesson 1 opens with a "Try this first" for the HTML block
instead (type, watch the preview, press Check, two tries).

Simpler than IT, step by step, short sentences, one idea at a time - as the
theory brief says. A Grade 10 CAT pupil may never have used Word on a
computer: assume nothing.

## Screens: the CAT VM

All screens come from **the CAT VM `itcoder-cat`** (Windows 11, Microsoft 365,
Google Drive signed in) - never Chris's own desktop.

1. **Write a screen script** `tools/sim-screens/<course>-<lessonId>.ps1`,
   modelled on `cat-word.ps1` / `cat-excel.ps1` / `cat-access.ps1` and their
   shared `office-kit.ps1`: open the program through COM, build the document
   in code, then for each moment of a task change it through COM or UI
   Automation and `Snap` a picture; `Mark` where each target is (window
   pixels) and `Dump` the ribbon's controls so you can find names. **Read
   office-kit.ps1's rules.** Things learnt so far:
   - Word needs a **1750 px wide window** or the ribbon folds groups into
     menus. Turn off the Navigation pane (`$word.ActiveWindow.DocumentMap =
     $false`) and the rulers unless the lesson is about them.
   - `Range.Formula = [string]` for Excel values (PowerShell 5.1's COM binder).
   - After Enter, Excel moves down a row - write the steps the way it behaves.
   - PrintWindow does not draw Excel's moving "copied" border.
   - Only Office's built-in styles in galleries.
   - A dialog box (Page Setup, Paragraph, Format Cells, Insert Table, Insert
     Chart) is a separate window: find it with UI Automation and
     `[Shot]::Save` its own handle, or take the main window while it is open.
   - Starter files a pupil downloads: build them in the same script (or a
     `<course>-<lessonId>-files.ps1`) with real Office and `SaveAs2` / `SaveAs`
     into `C:\sims\files\<scriptName>\` **and** `G:\My Drive\CAT\<App>\`.
2. **Run it in the VM** from the host (PowerShell 7):
   `pwsh -File "D:\DB Sync\Dropbox\Projects\AIResources\tools\sim-screens\vm-shots.ps1" <course>-<lessonId>`
   It waits its turn (other writers share the VM - a lock file), runs the
   script in the VM's desktop, and brings back `out\<name>-*.png`,
   `out\<name>.json` (your marks) and `files\<name>\` (files the script
   made). A run takes 1-3 minutes. Look at every picture.
3. **Crop** with `cat-crop.py` (add an entry for your script to its `CROPS`
   table) or your own few lines of Pillow: **never keep the title bar** (it
   shows the Office account), keep the ribbon and enough of the document to
   see the result. Copy into `public/assets/sims/<course>/`. Work out each
   target in per cent of the cropped picture (what `cat-crop.py` prints).
4. **Starter files**: copy from `files\<name>\` to
   `public/assets/practical/<course>/` and point the upload block's `'files'`
   at them. Check the upload block marks the **model answer** full marks and
   the **starter** zero: make a done-right copy in the VM too and run the
   lesson's checks against it (see `bin/check-uploads.php` for how; add a
   fixture under `tests/uploads/<course>/` if you like).

If the VM is unreachable or a run fails twice, write the screen script, put
`// SCREENS TO DO: <script name>` where the simulation goes, write the rest
of the lesson, and say so in your notes - do not invent screens or targets.

## HTML lessons

Pupils type HTML in an `html` block; the live preview shows the page. The
Grade 10 chapter is **CAPS-only** (decision 12): CAPS teaches it in Grade
10, the IEB in Grade 11, and IEB pupils are pointed back to these lessons
from Grade 11 as revision. So do not wrap the lessons in a BoardSection (an
IEB Grade 11 pupil doing them as revision should earn the marks); instead
open each Grade 10 HTML lesson with one short line: CAPS pupils learn this in
Grade 10, IEB pupils in Grade 11 - and it is a good start either way. Never
say it is "in the exam". Tags in lower case, closing tags,
nesting shown and checked. Screens: a browser and Notepad++ only where a
picture helps (VM); most "screens" here are the preview itself.

## Board sections, grades, marks

- Word, Excel and PowerPoint skills are the same for both boards; where one
  board names a feature the other does not, a `BoardSection`. Check the
  Grade 10 lines of [../cat-caps.md](../cat-caps.md) (section 3, Solution
  Development in each term) and [../cat-sags.md](../cat-sags.md) (section 8,
  Appendix M: 8.2 Word, 8.3 Spreadsheet, 8.5 Presentations). Every Grade 10
  line in your lessons' range is taught somewhere in the course: if a line
  fits none of your lessons, say so in your notes.
- PowerPoint is examined only through the PAT: no exam-style framing; tie it
  to presenting a PAT report.
- Marks as the theory brief says (auto-marked count double; a simulation's
  `'marks'` per step; an upload's checks; both board totals even, 40-80).
  Simulations and uploads are marked questions; the practice simulation is
  not.
- The upload block's `'tries' => 2`. A pupil who said no to keeping files
  sees why and the lesson still completes - you need do nothing for that.

## Jev

As the theory brief: every `written` has `'points'`; typed answers listed in
their usual wordings; an own-words `reveal` where it fits; upload and html
checks use `'jev'` where a rule cannot judge. Run
`php bin/check-jev.php <course> <lesson>` and work through its flags.

## Videos

1-2 per lesson, under 10 minutes, mostly **screen recordings in the CAT VM**
of the skill being done (say exactly what is clicked), with CAT-style board
scenes for the ideas. Number them `<course>-<two-digit lesson>.<n>`, e.g.
`catword-03.1`. Everything in a video is in the text. Comment in the lesson:
`// VIDEO catword-03.1 Formatting characters - goes here once on YouTube`.
Each course's lesson 1 also shows `// VIDEO catprac-00.1 How to work with
software simulations` before its practice simulation (planned already:
cat-videos/simulations.md).

## Checks (PHP is on this machine: `D:/xampp/php/php.exe`, run from AIPascalCourse)

- `php -l` every file you touch.
- `bin/check-simulations.php <course>`, `bin/check-uploads.php --no-jev`,
  `bin/check-html.php <course>`, `bin/check-jev.php <course> <lesson>`,
  `bin/check-lesson-contents.php`, `bin/check-figures.php`,
  `bin/check-titles.php`, `bin/check-why.php`, `bin/check-code-questions.php`.
- Render it: `php <scratchpad>/renderone.php <course> <lesson>` (the lead
  gives you the path) prints bytes and pictures with no `WARN` lines.
- **Don't commit or publish.** Touch only your own lessons, screen scripts,
  pictures, starter files, video plans and notes - plus, for a lesson-1
  writer, your program's case in `SimulationPractice()`, and your entry in
  `cat-crop.py`. If something in the platform is broken or missing, say so
  in your notes rather than changing it.
