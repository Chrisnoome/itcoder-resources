# Tutorial videos (PLAN)

**Status (4 October 2026, night):**
- **Pascal 16.1 (Creating a class) is on YouTube: GgEOY8EcL4A** (BestLessons,
  Pascal playlist), **public** (Chris); its download link errors until the
  code zip is up at
  bestlessons.co.za/downloads/tutorials/pascal-16.1-creating-a-class.zip
  (Chris's publish). From 20.1 on, use the re-rendered endcard-bg.png
  (AIResources 8c1a4be: "for counter := 1 to 10 do"); 16.1 keeps the old one; lesson 16 links it (AIPascalCourse 1c55a18, not
  published). Folder `pascal-16.1-creating-a-class`; the final has the 16.1
  title card, the BestLessons sign-off and a 15 s quiet end screen
  (`tools\tutorial\endscreen.py`); chapters in thumbs-pascal.json.
- **Pascal 20.1 (array manager): draft 3 of the script waits for Chris** -
  thinking before code for every algorithm (by hand, a diagram on the five
  games, a flowchart, then the code beside its flowchart), `noOfGames`, one
  long video with chapters. To build after approval: flowcharts drawn box by
  box on the board, a flowchart split screen with links to the code, and the
  video cutting between board and Lazarus. Its take with MAX_GAMES (18:2x)
  is superseded by this. The `-final.mp4` in its folder is old - not for
  upload.
- DONE (not committed or published): the Pascal lessons' constants are
   SCREAMING_SNAKE_CASE (lessons 02, 15-23, theory10/12, a Try-it), lesson02
   teaches the rule, lib/naming.php checks it (+6 tests in
   bin/check-codestyle.php). Not run - no PHP here: php bin/check-codestyle.php,
   bin/check-code-blocks.php, bin/check-popup-spacing.php (run on the server).
   Left: AIResources/tools/ui-screens/lazarus/moreforms/useats.pas still says
   seatsInRow (lesson23 screenshots, if they show it).

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

**Thinking-first tutorials (from Pascal 20.1, 5 October 2026)** add:
`flowchart.py` (flowcharts drawn box by box; the tutorial's `flows.py` defines
them once for the board and the take), a flowchart panel beside the code with
a link line from each box to its code (`take\overlay.py`, per typed chunk),
`endfirst.split_ops` + `TypeOps -Live` (each method typed in chunks, each on
its own sentence, at a readable speed), and `assemble.py` with the folder's
`sequence.json` (board and take parts in turn - plan on the board, code it,
back to the board). Then `titlecard.py` and `endscreen.py` (15 s quiet end
screen for YouTube's end-screen elements, the subject's endcard-bg.png).

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

## General Computing course videos waiting (the video queue)

Chris, 10 October 2026: "vide requirements to the video queue". Each General Computing course has
its own plan for the video chat, with a table of the videos (where each one goes in the lesson) and
what each must show. Make them in this order. Mark a video **done** in its plan once it is in `for upload`.

| Course | Grade | Plan | Videos |
|---|---|---|---|
| Staying safe online (`safety`) | 8 | [safety-videos/README.md](safety-videos/README.md) | 8 |
| Social media (`socialmedia`) | 9 | [socialmedia-videos.md](socialmedia-videos.md) | see plan |
| The rhino case (`sql9`) | 9 | [sql9-videos.md](sql9-videos.md) | 8 |
| Station Kestrel (`pascal9`) | 9 | [pascal9-videos.md](pascal9-videos.md) | 12 |
| Club website (`clubweb`) | 8 | [clubweb-videos.md](clubweb-videos.md) | 8 |
| Tuck-shop tycoon (`tuckshop`) | 7 | [tuckshop-videos.md](tuckshop-videos.md) | 8 |
| Inside the machine (`machine`) | 7 | [machine-videos.md](machine-videos.md) | 7 |
| Fact or fake (`factfake`) | 8 | [factfake-videos.md](factfake-videos.md) | 6 |

## Where

`E:\itcoder-videos\tutorials\<subject>-<lesson>.<n>-<name>\` (e.g. pascal-16.1-creating-a-class - renumbered by lesson, Chris 4 October 2026), one folder per tutorial (Chris,
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
checks after every render. **The sign-off names the one channel, BestLessons
(@BestLessonsSA)**, for every subject (Chris, 4 October 2026: the School SA
channels are parked; each subject is a playlist - youtube-channels.md).
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
**Yellow highlighter (Chris, 5 October 2026: "when you refer specifically to
lines in the code - e.g. 'override' - highlight the code, like with a yellow
highlighter. pull that through for when the pupil must look at specific text
on the screen"):** every line of narration that names text on the screen -
a keyword, a line of code, a menu item, a file name - gets a yellow
highlighter band over that text while the line plays. In take\edit.json:
`"highlights": [{"step": "31-...", "line": 2, "text": "Override", "every": true}]`;
compose_take.py finds the text on the frame with Windows' OCR
(tools/tutorial/highlight.py) and snaps code to the editor's grid. On the board,
the same: a yellow band behind the words being talked about.
**Take jobs, from Pascal 17.1's failed take (5 October 2026):** close a
window with `CloseWin` (its own X), never Alt+F4 - Notepad hadn't taken the
focus, stayed open, and the next steps' code was typed into games.txt. Before
typing after another window, `LazFront` (Explorer: `ExFront`) - it checks the
focused window really is Lazarus. Narration must come from the script as it
is now: narrate.py writes `voice\script.sha1` and TutTake refuses a take if
the script changed since (an edit made while narrate.py ran slipped past the
old date check).
**We teach thinking, not code (Chris, 4 October 2026 - every tutorial from
now on):** before any algorithm is coded, the video explains the idea and
plans it - what the problem is, how a person would do it by hand, a diagram
or animation of it working on real data, then a flowchart (or trace table) -
and only then writes the code, showing how each part of the flowchart
becomes code (the flowchart beside the code, a line from each box to its
lines, as the UML split screen does for classes). Searching, sorting,
swapping, totals, counting, the best/worst: each gets this. Longer, more
detailed videos are fine. Fields and variables use the course's names (a
manager's count is `noOfGames`, not `count`).
**The code is not rushed (Chris, 5 October 2026 - every tutorial):** every
video follows the same method - explain, plan (diagram, flowchart), then
code - and the code is typed in small pieces, each important bit explained
as it appears (what the line does and why), not a whole method sped past
under one sentence. Only repetition the pupil has already seen explained
(the second, third and fourth getter) may be sped up.
**Make the video, not just the script (Chris, 5 October 2026: "im better at
looking at the video and making corrections than reading and correcting
scripts"):** write the script, then make the whole video straight away -
no waiting for the script to be approved. Chris watches it and lists the
changes, which go in as edits. (Replaces "scripts first for Chris to check".)
**Lesson 17's series (Chris, 5 October 2026), after 17.1 (text file basics):**
short videos, numbered by the lesson (17.2, 17.3, ...): reading a text file,
writing a text file, adding data to a text file, where the file is (NB),
parsing complex data, and adding a `StringForFile` method to a class to write
its data to a file. **As made (5 October 2026):** 17.1 Text file basics
(write, add to and read - one video, since it was already made that way;
Chris can ask for it split), 17.2 Where's the file? (current folder, hidden
extensions - games.txt.txt, `ExtractFilePath (ParamStr (0))`), 17.3 Cutting
up a line (CSV, Pos/Copy/Delete, StrToFloat/StrToInt, no spaces), 17.4 A game
on a line (TGame from 16.1 gets `Create (aLine)` + private `ParseLine` +
`StringForFile`). 17.4's uClassGame.pas is exactly 20.2's starting class, so
20.2 starts from 17.4's code and recaps StringForFile on the board instead of
typing it again. Prices in these files are whole rands: `FloatToStr` would
write a decimal comma on a South African Windows and break the CSV.
**After 20.2: inheritance (Chris, 5 October 2026: "then inheritance -
multiple lessons that culminate in a full example of class, subclass, array
manager as per ieb exams"):** a series numbered by lesson 21 (21.1, 21.2,
...), each short and thinking-first, ending in one exam-style example: a
class, its subclass and an array manager that holds both, the way IEB papers
set it. Chosen (Chris, 5 October 2026): **lesson 21's club** (TMember /
TJunior, as in the lesson) and a **# delimiter** like IEB papers (loader in
Try/Except, class chosen by the number of fields). Plan: 21.1 why inheritance
(ancestor/descendant, is-a) - 21.2 writing a descendant (Inherited Create,
protected, UML #) - 21.3 Virtual/Override and Inherited ToString - 21.4
polymorphism (one array, both kinds; Is and As) - 21.5 a file with two kinds
of line - 21.6 the full exam example: class, subclass, manager (load, toString,
sort, search, report), one long video with chapters.
**After the lesson 21 series: every lesson, from the start (Chris, 5 October
2026: "when done start at the beginning of the course and do videos for all
lessons"):** Pascal first, lesson 1 onwards; Java after Pascal is done. **CAT Theory's 206 videos (Gr 10: 79, Gr 11-12: 127)** (plans in [cat-videos/](cat-videos/README.md)) come after all of Pascal (Chris, 6 October 2026); where they go relative to Java isn't decided.
**The queue (9 October 2026):** `tutorials\queue.txt` lists the folders in order; `tutorials\pascal-queue.ps1 -Voice` and `-Takes` run beside each other. The voice loop is the only thing that may use the voice server (two jobs at once time out and restart it under each other): it narrates each folder whose narration doesn't match its script, and finishes any folder with `take\finish.request` (its text: the second of the render to take the thumbnail frame from) - `tools\tutorial\finish_video.py`: the code zip from the take, thumbnail and title card, `youtube.md` and `extras.json` from the folder's `yt.json` (`tools\tutorial\yt_page.py`: chapters are the script's **Chapters:** line, one per step, timed from the render), the extras, and the set into `for upload`. The take loop records and renders in order (`take\done.txt` marks a folder done). Before writing `finish.request`: check the take (its project zip against `code\`, no errors in the log) and the highlight sheet. **The plan panel never covers a run (9 October 2026):** the console opens at the left of the screen, under the 640 px flowchart panel - in 8.1-8.4's first renders the program's output was hidden. A panel's span ends where the run step starts (overlay.py FLOW_RULES spans); the hold step's code pages follow. **The thumbnail frame (9 October 2026):** the card darkens the left half, so pick a frame with the code on the RIGHT - the Lazarus editor with the finished code, just before the last F9 - never the hold step's listing or a mostly empty board (21.3's and 2.3's first cards showed a blank half). A narration line whose voice call hangs is retried with another seed after the server is restarted (`voice\narrate.py`), and lines already made for other tutorials are copied into a folder's voice cache before it is narrated.
**As many videos per lesson as it needs** - short ones numbered by lesson
(1.1, 1.2 ...), one per main idea or skill, like the lesson 17 series; lessons
already covered (16, 17, 20, 21) are skipped or topped up. **Lesson 1 is skipped** (Chris, 9 October 2026: no code, and it already has the song and the 12-minute video) - Pascal starts at lesson 2, Proof of Life. Video numbers follow the course's lesson numbers (index.php), not the file names: proofoflife is 2, lesson03 is 3, lesson02 is 4. Same method, voice
and rules as every tutorial; made straight to video for Chris to correct.
**Next tutorials (Chris, 5 October 2026):** Pascal 20.1 (the array manager,
draft 3) -> **Pascal 17.1, text file basics** -> **Pascal 20.2, the array
manager with text files** (loading the shelf from a file and saving it back;
it must explain that the class in the array gets a `StringForFile` method
that gives back one line in the file's format).
**Tutorials are numbered by lesson, in sequence** (Chris, 4 October 2026:
not "tutorial 2"): lesson number, a dot, the tutorial's place in that lesson
- **Pascal 16.1** (Creating a class), **Pascal 20.1** (the array manager);
a second tutorial for lesson 20 would be 20.2. Title card and YouTube title
carry it ("Pascal 16.1 - Creating a class"). A long tutorial stays one video
with a **chapter list** in its YouTube description (Chris: 20.1 is "long
with chapter list"), not a series.
**Fix by cutting and editing, not remaking (Chris, 4 October 2026: "cut and
edit where possible instead of remaking"):** a changed line, an added
explanation or a wrong word goes into the finished file as an edit (swap the
line's sound, hold a frame while new lines play, draw on it) - see
`pascal-16.1-creating-a-class\take\patch_final.py`. Re-record only what the screen
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
and the rest in the file (longest first). A SCREAMING_SNAKE_CASE constant
is said as its words (MAX_GAMES = "max games") by `narrate.py` itself. Use `{caption|spoken}` in a script
only for a one-off (e.g. "lives" said "livz" in "lives somewhere else").
**Chris, 5 October 2026 (every video):** Writeln = "write line" (Readln =
"read line"), .txt = "dot text" - also after a name (games.txt = "games dot
text"); Pascal must always follow the "Pascle" rule - speech recognition can't
hear a wrong stress, so `voice\word_check.py` compares the sound with a
reference (being calibrated with Chris's ear). **Typing sounds:** every bit of
typing in a take gets a fast touch typist's keys (`tools\tutorial\keysound.py`,
on by default in compose_take) - real keystrokes cut from Chris's Eagle sound library (R:\Eagle\Audio.library, 789ten "TYPING COMPUTER KEYBOARD 1/2/4") into `tools\tutorial\sounds\keys`, one per key typed, at most about 12 a second. **No dead air opening Lazarus:** the wait after
its icon's double-click is squeezed to a second (compose_take), and a board
part's sound stops at its own last line (make_board) - its 1.2 s tail used to
catch the first syllable of the next step's line.
**Teaser, chapter banners and questions (Chris, 8 October 2026, from YouTube's feedback on 16.1 - every video, and added to the ones already made):** (1) the first seconds: the title card, then a 5-6 s teaser of the finished result (the plan beside the finished code, or the final run) with one spoken promise - "In this video, you'll learn how to ..." - then "Hi, and welcome" as before; (2) a lower-third banner at every chapter start (CHAPTER n + its youtube.md title, about 3.5 s, Pascal colours); (3) questions to the viewers - spoken while the picture holds, with a "Tell me in the comments" card, more than one per video where it fits (e.g. after the first compile error, after the first run: "Lazarus or Delphi?", "which compiler error caught you out?"), and a pinned comment in youtube.md. All three are edits on the finished video: `tools\tutorial\extras.py <folder>` with the folder's `extras.json` (teaser time and line, questions, pinned text) makes out\<name>-final.mp4 and .srt and moves youtube.md's chapter and card times (the times before it are kept in youtube.base.md).
**For upload / uploaded (Chris, 6 October 2026: "when videos are [finished] put them in a 'for upload' [folder] - finding individual videos by crawling a folder tree is not optimal. when i have uploaded i will move them into an 'uploaded' folder"):** every finished video, any kind, goes into the one flat folder `E:\itcoder-videos\for upload\` with what goes with it, all named the same: `<name>.mp4`, `<name>.srt`, `<name>.png` (thumbnail), `<name>.youtube.md`. Chris moves each set to `E:\itcoder-videos\uploaded\` once it is on YouTube. Tutorials: `tools\tutorial\for_upload.py <folder> <thumbnail id>`. A re-made video goes back in `for upload` (its youtube.md says what it replaces). **Every video for upload must be in that folder - no exceptions (Chris, 8 October 2026: "the videos for upload are not being placed in the 'for upload' folder. please make a rule that all videos for upload must be placed there"):** a video is not finished, and is not reported as ready, until its set is in `E:\itcoder-videos\for upload\`. The render scripts (`tutorials\render-tut.ps1`, the queues) copy it there as their last step, and only when the build worked - a failed build never leaves an old copy looking new. When a video is remade, the new set replaces the old one there. Before telling Chris anything is ready, list the folder and check each file's time.

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
| T15 | Creating a class (made for Pascal: pascal-16.1-creating-a-class) | 16 | 17 | A |
| T16 | Text files: a CSV into an array of objects, and back | 17 | 18 | A |
| T17 | Exceptions and defensive input (Try / try-catch, ReadInt) | 18 | 19 | B |
| T18 | Dates and times | 19 | 20 | C |
| T19 | An array manager class (made for Pascal: pascal-20.1-array-manager) | 20 | 21 | A |
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
