# Tutorial videos (PLAN)

**Status (4 October 2026, evening): 01 (18:15) and 02 (14:28) re-recorded
and sent to Chris** - Google Drive, uClass unit names, End-first typing with
Lazarus's methods tidied and filled, tips with a gold star and chime, the
pronunciation fixes, "code in the links below" at the start and end. Earlier:
**01 and 02 remade from Chris's draft-2 scripts**
(a grounded opening - one game, then the library - and the paragraph
layout) and sent to Chris: 01 is 16:27, 02 is 14:01. The coding takes were
reused: `take\edit.json` "logStepShift" maps the take's old step numbers.
`out\NN-name-final.mp4` (title card on), `.srt`, `NN-name.zip` (the code
download) and `youtube.md` (title, description) in each folder; draft 1 is
kept in `v1\` and `script-v1-approved.md`. Made in the video-production chat.

**How a tutorial is made** (tools in `E:\itcoder-videos\tools\tutorial\`,
host side `tutorials\tut-host.ps1`):
- narration with `voice\narrate.py`;
- the explanation and planning scenes from the folder's `board_scenes.py` by
  `make_board.py` (blue pen on paper, each drawing cued to a narration line);
- the coding part recorded in the VM from checkpoint **`tutorial`** (`apps` +
  Lazarus: Modern one-window layout on the right two thirds, Consolas 14,
  editor-only panels, and these off - each changed or broke typed code: Auto
  indent, Add close statement for Pascal blocks, Auto display function
  prototypes, Automatically invoke after point) by `take\job.ps1`, typing
  `take\code.json` (`take_code.py` cuts it from `code\` and checks the pieces
  rebuild the files);
- `compose_take.py` edits the take with `take\overlay.py` (the plan on the
  left, link lines to the code, asides, code pages to pause on) and
  `take\edit.json` (red pointer notes); `finish.py` joins board + take + end;
  `titlecard.py` splices the card on; `check_take.py` checks timing, clicks
  and circles (typing is cued at the start of its line on purpose: it is sped
  up under the words);
- a dry run with placeholder timing (`_dry\drytake.ps1`) first checks the
  typed project comes out byte-for-byte as the code;
- File Explorer opens on This PC with recent files off: Home shows the
  signed-in account's own documents.

## Where

`E:\itcoder-videos\tutorials\NN-name\`, one folder per tutorial (Chris,
28 September 2026): `script.md`, `code\`, `voice\`, `raw\`, `edit\`, `out\`
(`tutorials\README.md` lists them).

| # | Tutorial | Lesson | Notes |
|---|---|---|---|
| 01 | Creating a class | Pascal 16 | Lazarus, console; TGame (title, platform, price, rating) in its own unit - a fresh example, not the lessons' TPupil (Chris) |
| 02 | An array manager class | Pascal 20 | the exam-style manager (Chris); TGameShelf builds on 01's game.pas |

## Rules (Chris, 28 September 2026)

- **Same process, voice and pipeline as the install videos**
  (courses/install-videos.md): the clean Hyper-V VM, Chris's cloned voice
  (Qwen3, one sentence at a time, `pronounce.json`), narration made first,
  "Hi, and welcome to BestLessons." and the same sign-off.
- **Everything on screen in the blue doodle style** used for IT: notes,
  diagrams, animation and text (pen `#1f4fa3`, round caps, Kalam bold).
- **Humour allowed**: puns, interesting asides and facts.
- **Long stretches are sped up** (typing code especially). Then the complete
  code is held on screen and the narration suggests pausing the video to
  read it.
- **Code for download with every tutorial**: clean, commented, following
  pascal-house-style.md / java-house-style.md. A zip of the complete
  project (Lazarus .lpi/.lpr, or the NetBeans project) hosted on
  **bestlessons.co.za** (not itcoder); the YouTube description links to it.
- **Every tutorial also gets** a closed-caption file for YouTube (.srt) and
  a thumbnail.
- **Thumbnail: one doodle series template**: paper background, big
  blue-pen title, one doodle for the topic, a course badge (Pascal / Java /
  SQL) and the lesson number. 1280 x 720.

## Shape of a class tutorial (Chris, 29 September 2026)

1. What a class is: data plus the procedures and functions that work on it
   (called methods), and why a program wants one. Then access modifiers.
2. Plan it first, because a class is a complex structure: a blank UML class
   diagram (name / fields / methods), fields private (-), methods public
   (+). Fields in, then the methods in this order: constructor (why its
   parameters matter), destructor (why), getters and setters (accessors and
   mutators), ToString (always - exams expect it), the processing methods,
   then private helper methods.
3. "Ready to code it - at last!", then a **split screen: UML on the left
   (about a third), code on the right**, with a blue line drawn from each
   part of the diagram to its code as it is written.
4. Ctrl+Shift+C in Lazarus: it writes the empty bodies; without it you type
   them yourself; if nothing happens the class has a mistake; with neither,
   "Forward declaration not solved". Say that the website console's
   Ctrl+Shift+C also writes the comment blocks to complete and fills the
   getters, setters and constructor, and Lazarus doesn't.
5. Units keep Lazarus's `{$mode ObjFPC}{$H+}` line. Dot notation is named
   as the way to reach fields and methods.

Array manager tutorials get the same full UML build-up and split screen.

**Ground it first (Chris, 4 October 2026, on 01's first cut):** open with
the real thing and the program we want ("Here's a game. I want a program to
manage my library of games."), then work out what we need to know about one
(the data) and what we want to do with it, then show why separate,
unrelated variables don't do it. Keep coming back to that thing all the way
through: the fields come from "what we need to know", the methods from
"what we want to do".

**Script layout (Chris, 4 October 2026: "too cluttered"):** a paragraph per
idea, not a line per sentence; every on-screen direction as a labelled `>`
line (**Board**, **Screen**, **Type**, **Link**, **Hold**, **Note**); a
short "what changed" list at the top of a redraft. `narrate.py` joins a
step's paragraphs and splits sentences itself, so the layout doesn't change
the timing. **Always in Chris's voice** (writing-style.md, including its
"your voice" tells - no "promise", "Here's why", the compiler as a person).

Also decided (Chris, 1 October 2026): code zips at
`bestlessons.co.za/downloads/tutorials/NN-name.zip`; tutorials that build on
each other say so, with a YouTube card to the earlier one; example prices
are round and obviously made up (R100, R150, R250, R400, R1000); every class
gets its own destructor (lesson 16 to be changed to match).

**Scripts 01 and 02 approved (Chris, 3 October 2026): "make the video and
voice".** The install videos' rules of 1 October 2026
(install-videos.md, "Rules for every tutorial video") apply to tutorials
too: one spoken line per action, the action landing as its line ends; code
in the synced `Coding\Pascal` folder; ".co.za" said "dot co dot Zed-A";
checks after every render. The sign-off names the subject's channel
(Pascal: Pascal School SA, @PascalSchoolSA - youtube-channels.md).
**Code is saved on Google Drive (Chris, 4 October 2026), in this and every
following tutorial:** My Drive > Coding > Pascal (Java: > Java), not
OneDrive, and the narration always adds that you may use OneDrive or other
cloud storage, but it works the same. 01 and 02 were re-recorded to match.
VM checkpoint **`tutorial-gdrive`** (4 October 2026) = `tutorial` + Google
Drive signed in by Chris with the course's own Google account, **mirror**
mode (Chris: no waiting for syncing), My Drive at `C:\Users\pupil\My Drive`
holding only `Coding\Pascal` (the account's old files moved to its Trash
with Chris's yes). Keep it: Chris doesn't want to sign in again. Lazarus
there keeps file names' capitals (environmentoptions.xml
`CharcaseFileAction Value="Ignore"` - its default saved uClassGame.pas as
uclassgame.pas). **Never redefine an agent function in a job** (e.g.
`function Act {}` in a quick probe): the agent keeps it for every later job,
and a checkpoint saved then carries it - on 4 October 2026 that made every
click land a line early until the agent was restarted (`VmDeployAgent`).
**Fix by cutting and editing, not remaking (Chris, 4 October 2026: "cut and
edit where possible instead of remaking"):** a changed line, an added
explanation or a wrong word goes into the finished file as an edit (swap the
line's sound, hold a frame while new lines play, draw on it) - see
`01-creating-a-class\take\patch_final.py`. Re-record only what the screen
itself must show differently (e.g. 4 October 2026: Google Drive instead of
OneDrive, the uClass unit names and the End-first typing changed the whole
coding part).
**Code downloads (Chris, 4 October 2026):** every video with code gets a
zip of it, put up in the site's downloads folder
(`bestlessons.co.za/downloads/tutorials/NN-name.zip`, one folder per kind of
video) and linked first in the YouTube description - YouTube can't attach a
file, so "attach" means that link; `youtube.md` says so for the YouTube chat.
The video says the code is ready to download "in the links below" near the
start and again at the end.
**Every pronunciation fix goes into `E:\itcoder-videos\voice\pronounce.json`**
(Chris, 4 October 2026: "add all pronunciation fixes to the rules for future
videos"), so every later video says it right without being told: matric =
"mutt-rick", .pas = "dot pazz", SysUtils = "Sis-you-tills" (utils as in
utility), FloatToStr(F) = "Float to String (F)", uClassGame = "you Class
Game", TGame = "T Game", bestlessons.co.za = "Best Lessons dot co dot Zed A",
and the rest in the file (longest first). Use `{caption|spoken}` in a script
only for a one-off (e.g. "lives" said "livz" in "lives somewhere else").
**Good programming habits, shown as tips (Chris, 4 October 2026 - every
coding video, every language):** always look for good habits like these and
use them on camera, each flagged as a **tip: a gold star and a short chime**
when it is first said (`overlay_kit.Tip`, `tools\tutorial\sounds\tip.wav`).
The two standing ones, typed that way in every take:
- **Close a structure the moment you open it**: type the `End` (with its
  comment, `End; // TGame`, `End; // if`) straight after the line that
  opens it (a class, `Begin`, `Record`, `Try`, `Case`; Java's `}`), then go
  back up and fill in between. Forgetting an End is a common mistake;
  doing it at once means no hunting for it later.
- **A function gets `Result := ` first** (Java: `return`), straight after
  its Begin, then completed - so it never forgets to give back a value.
The takes type code this way (`tools\tutorial\endfirst.py` turns the code
into keystrokes and checks they rebuild the file exactly).
**Colours (Chris, 3 October 2026): blue drawings, red pointers** - UML
diagrams, doodles, link lines and the explanation scenes in the blue house
pen; click circles and the arrows and circles that point at things on
screen in red. The VM and the voice server are shared with the install
videos: tutorial takes and narration wait until that chat has finished.

**Thumbnails and title cards use the channel style; the video's own content
uses the doodle style** (Chris, 3 October 2026 - replaces the doodle
thumbnail template of 28 September): `brand/youtube/source/thumbs.py`,
entries in `source/thumbs-pascal.json` (brand/youtube/README.md).
**A short title at the start of every finished video** (Chris, 3 October
2026): made in the title design finalised in the YouTube chat, and
**spliced onto the front** of the finished file - the video is not remade.

## The list (Chris, 3 October 2026: "All A's first, then B's")

Order: the A tutorials in course order (Pascal, then the same topic in Java),
then the B's; C (dates) last or dropped. **Java tutorials use NetBeans**;
**Pascal GUI and database tutorials use Lazarus only** (Chris, 3 October 2026).

One tutorial per row, made twice where both courses have the topic (Pascal
in Lazarus, Java in NetBeans). P = priority: A exam core or
hard to learn from text alone, B useful, C nice to have. Lessons are the
course files (Pascal `lessonNN`, Java `lessonNN`).

| # | Tutorial | Pascal | Java | P |
|---|---|---|---|---|
| T1 | Your first program: write, run, and read what comes back | proofoflife | 02 | A |
| T2 | Reading compiler errors: the common five, found and fixed | 02 (errors), 18 | 05, 19 | A |
| T3 | Variables and input: a tip calculator | 02, 05 | 05, 06 | B |
| T4 | Type conversion and tidy output (FloatToStrF / String.format, columns) | 07, 13 | 08, 14 | B |
| T5 | Decisions: marks to symbols with If / Else If and Case (switch) | 08 | 09 | A |
| T6 | Div and Mod at work: change, time, odd/even | 09 | 10 | B |
| T7 | Using the debugger: breakpoints, watches, stepping through a loop | 10, 18 | 11, 19 | A |
| T8 | Looped algorithms: total, average, biggest, smallest | 11 | 12 | A |
| T9 | While and Repeat: input checking and a menu loop | 12 | 13 | A |
| T10 | String handling: palindrome, Caesar cipher, splitting a CSV line | 13 | 14 | A |
| T11 | Procedures and functions: one long program made DRY, then a unit | 14 | 15 | A |
| T12 | Arrays: fill, total, linear and binary search | 15 | 16 | A |
| T13 | Sorting arrays: selection and bubble sort, traced | 15 | 16 | A |
| T14 | Parallel arrays: two lists that move together | 15 | 16 | B |
| T15 | Creating a class (made for Pascal: 01-creating-a-class) | 16 | 17 | A |
| T16 | Text files: a CSV into an array of objects, and back | 17 | 18 | A |
| T17 | Exceptions and defensive input (Try / try-catch, ReadInt) | 18 | 19 | B |
| T18 | Dates and times | 19 | 20 | C |
| T19 | An array manager class (made for Pascal: 02-array-manager) | 20 | 21 | A |
| T20 | A working manager: current record, CRUD and a menu | 20 | 21 | B |
| T21 | Inheritance and polymorphism | 21 | 22 | A |
| T22 | A text user interface: a menu-driven program | 22 | 23 | B |
| T23 | Your first GUI: a form, buttons, edits and events | 23 | 24 | A |
| T24 | A GUI over a class: logic out of the form | 23 | 24 | A |
| T25 | A database in your program (SQLite) | capssqlitedelphi, capssqlitelazarus | 25-27 | A |
| T26 | Making a program others can run (release build, hand-over folder) | ides | 28 | B |
| T27 | A practical exam question, solved live (IEB and CAPS) | 24, 25 | - | A |
| T28 | The data validation task | 26 | - | B |
| T29 | The PAT, planning to hand-over | 27, capspat10-12 | - | B |

## YouTube upload

**Decided (Chris, 28 September 2026): Claude uploads with the YouTube Data
API; Chris makes each video public with one click in YouTube Studio.** An
unaudited API project's uploads stay private; no audit applied for (only if
the clicking gets annoying). Each upload sets the title, description (with
the bestlessons.co.za code link), tags, captions (.srt), thumbnail and
playlist. Setup, done once by Chris: a Google Cloud project with the
YouTube Data API v3, an OAuth desktop client whose JSON he saves to disk
(never pasted into chat), the consent screen set to "In production" (a
"Testing" app's sign-in expires after 7 days), then one browser approval.
The channel must be phone-verified for custom thumbnails. Not built yet.
