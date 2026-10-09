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

## Grades 11 and 12 (Chris, 8 October 2026: "continue with grades 11 and 12 when grade 10 is done")

Everything above applies. What changes:

- **The same courses**, new chapters: a Grade 11 or 12 lesson has
  `'grade' => 11` / `12` in the course's `index.php` (one course per program,
  chapters by grade). Access (`catdb`, title "Databases") starts in Grade 11.
  HTML Grade 11 is where **IEB** pupils start: its first lesson recaps the
  Grade 10 chapter quickly and links to it (CAPS pupils have done it).
- **You plan your own lessons** from the counts and chapters in
  [cat-course.md](cat-course.md) 3.3 and the Grade 11 / 12 lines of
  [../cat-caps.md](../cat-caps.md) (section 3) and [../cat-sags.md](../cat-sags.md)
  (8.2-8.5). Every line in your range is taught somewhere; where the boards
  differ by grade (CAPS teaches X in Grade 11, the IEB in Grade 12, or the
  other way round), teach it where the earlier board has it, inside a
  BoardSection for that board, and say in the note that the other board
  meets it a year later. Ids are short words, unique in the course
  (`styles`, `mailmerge`, `absolute`, `lookups`, `forms`).
- **Build on Grade 10**: the pupil has done the Grade 10 lessons of the same
  course (`content/<course>/`, grade 10 entries). Recap in a sentence and
  link (`/lesson.php?c=<course>&amp;id=<id>#anchor`); never teach it again.
- **Pitch**: a grade older - longer tasks, more "plan it for this scenario",
  troubleshooting, integration between programs. Grade 12 leans on scenarios
  like the practical exam (a starter file, a numbered task list, marked from
  the file).
- **Access uploads** are marked too (`.accdb`, `accdb.*` subjects in
  `lib/uploadmark.php`; a query is marked by what it returns - read
  platform.md "Access (.accdb)" and `content/catpilot/access.php`'s
  `upChess`). Make starter databases with real Access in the VM.
- **Index entries last**: add your lessons to the course's `index.php` only
  when each lesson file is complete and passes the checks (an entry with no
  file breaks shared checks). Two writers may share a course's index: re-read
  it just before your edit and use the Edit tool.
- **Glossary**: rows in `content/cattheory10/glossary.php`'s section for your
  course, grade 11 or 12, `'course' => '<course>'`; skip terms that exist.
  **Coverage**: `content/<course>/caps.php` and `sags.php`, `[11, ...]` /
  `[12, ...]` lines (create the files for `catdb` in catpilot's format).
- **Videos**: `<course>-<two-digit lesson number>.<n>`, numbering on from the
  course's last lesson.
- **The VM** is shared by every writer through `vm-shots.ps1`'s lock (90
  minutes' wait). Known: Word's `SaveAs2` can hang in the VM - save the way
  `work/catword-kit.ps1` does (File > Save As); right-click menus, many
  galleries and drop-downs don't capture; dialogs' controls aren't exposed
  to UI Automation (set state through COM, reopen, read targets off the
  picture). If your run hangs, the helper now stops it and its Office.
  Paint out the VM's "Add-ins"/"Claude" ribbon groups and any account name.
- **Never leave a placeholder that breaks a check** in the shared tree (an
  undefined constant, a missing picture, an index entry with no file).

## The Office account's name (9 October 2026)

The CAT VM's Office is signed in as Chris, and every file Word, Excel or
PowerPoint saves carries his name (document properties, tracked changes,
comments) - setting a local user name does not stop it. `vm-shots.ps1` now
scrubs files it brings back from `C:\sims\files\`, but a file you copy out
any other way, or a done-right copy you make or patch, must be scrubbed too:
`python tools/sim-screens/scrub-office.py <folder> --fix` on your starter
files and test fixtures before you report. The lead runs it before every
commit as well.
