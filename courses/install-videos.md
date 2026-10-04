# Install videos - how to install and use the tools (PLAN)

**Status: in production, 29 September 2026** (eight of nine made - Delphi waits for Chris's login; planned 27
September 2026). Chris: "plan and execute
installation videos for lazarus (recommend install on c:), delphi, netbeans,
jgrasp, dbeaver, mysql - anything else. i'll upload to youtube, then we can
insert into lessons. use the blue sketch style for on screen instructions.
can we create a voice clone for me?"

## Rules for every tutorial video (Chris, 1 October 2026)

These override anything older below. Every one is checked on every video
after it is made, before it is sent.

1. **The voice describes each action as it happens.** One short line per
   action, spoken while that action is on screen: "Go to jgrasp dot org" -
   the page loads - "and click Download" - the click. Never a line that
   runs ahead ("click Next, Next and Next" before any of them) and never
   the video lagging behind the voice. A job cues each line right before
   its action; the action lands at the end of its line.
2. **Sketch notes are red** (circles, arrows, captions), not blue - clearer.
3. **Every mouse click shows a red expanding circle** where it lands, and
   the click must land on the thing named - never in a blurred advert or
   empty space.
4. **A circle goes when its target goes**: when the window, menu or page
   it marks closes or changes, the circle is already gone.
5. **Say ".co.za" as "dot co dot Zed-A"**; say "Apache" the same everywhere
   (as in "Apache Derby"), so db.apache.org is "D B dot Apache dot org".
6. **Checks after every render**, precise, before sending: voice-to-action
   timing on every line, every click's landing spot, every circle's start
   and end. `tools\check_video.py` measures them; the click and circle
   frames are looked at as well.
7. **Good file habits on camera**, explained in the video (why it matters):
   - installers are saved to **Downloads\Installs**, never loose in
     Downloads;
   - portable (unzipped) programs go to **C:\Tools\<Name>** (C:\Tools\Letos,
     C:\Tools\Derby) - never left in Downloads;
   - lesson files (TuckShop.db, the tuck shop scripts) are saved straight
     into the synced Coding folder, not Downloads;
   - code always lives in the **cloud-synced folder**: `<cloud>\Coding\Pascal`,
     `\Java`, `\SQL`.
8. **Decimals use a point, never a comma** (Chris, 1 October 2026: "always
   use 'point' and full stops - never use commas"): in scripts, captions,
   numbers passed between tools, and the VM's own number format (its
   decimal symbol is set to "."). The voice says "point".
9. **Every IDE video ends by setting its default folder** to the
   cloud-synced Coding folder, with: "If you haven't set up your cloud
   service yet, pause this video and do it now - the videos for that are
   up in the right-hand corner" (YouTube cards to the cloud videos; Chris
   adds the cards).

**How the timing works now** (1 October 2026): narration is made line by
line; a job asks for each line (`Line`) right before its action, and the
agent starts it only when that action is ready - the pointer already on its
target - so a slow machine cannot put the voice ahead. The click lands as
the words end (`Act`). `compose.py` places every line where it was cued;
`check_video.py` measures each line against its action, each click's
landing spot and every circle, and writes a picture sheet to look at.
Shared job helpers live in `jobs\_common.ps1`; `Take` refuses to run with a
narration older than its script. Takes run with nothing else loading the PC.

**Cloud account in the VM** (Chris, 1 October 2026): his school account
(Microsoft 365 / Google Workspace), signed in by Chris himself inside the
VM; the address is blurred, but the synced folder keeps its own name ("OneDrive - <school>" shows as it is - Chris, 1 October 2026: "as is").
Portable programs: **C:\Tools\<Name>** (Chris's choice).

**New videos** (Chris, 1 October 2026): **OneDrive** and **Google Drive**
(two videos, same folder structure: set up, sign in, sync so files live on
the PC, in the cloud and on the school computer - with the sync app where
the school allows it, otherwise the browser: download, work, upload; a flash
drive as a backup); **File Explorer for programmers** (show file
extensions, structure Documents and Downloads, code only in the synced
folder); installs for **Notepad++, 7-Zip, Microsoft Office / Access through
the school's Microsoft 365, draw.io desktop, Git + GitHub Desktop**.

**Started 2 October 2026** (Chris: "do these"): the five videos with no
login first - File Explorer, Notepad++, 7-Zip, draw.io, Git + GitHub
Desktop; then OneDrive, Google Drive and Office/Access, where the take waits
at the sign-in screen until Chris has typed his school login in the VM
himself (Chris, 2 October 2026: "ping me when ready"). **Git repositories go
in Documents\GitHub** (GitHub Desktop's default), not OneDrive: OneDrive can
damage a `.git` folder it syncs halfway, and GitHub is the cloud copy - the
one exception to "code lives in the synced Coding folder", said on camera
(Chris, 2 October 2026). Sign-in to GitHub is skipped on camera ("Skip this
step"); the pupil signs in with their own account later.
**OneDrive video** (Chris, 3 October 2026): his cloud Coding folder (Java,
Pascal, SQL) is shown as already made - "make yours the same" - never made,
moved or renamed on camera; OneDrive's offer to back up Desktop, Documents and
Pictures is skipped (code lives in Coding, which syncs anyway).
**Cloud videos show how to check the sync app is working** (Chris, 3
October 2026, for Google Drive): after signing in, point to its taskbar icon
(by the clock, or under the ^ arrow), say what its colours and badges mean
(syncing, up to date, paused or offline, an error), and that no icon means
it isn't running - start it from the Start menu.

**A short title at the start of every finished video** (Chris, 3 October
2026: "when a video is finished, add a short title to the start of the
video. the title created using the design finalised in the youtube chat.
splice the start, don't remake the video"): made in the YouTube channel
design (brand/youtube) and joined onto the front of out\NN-name.mp4 - no
recompose. **How (3-4 October 2026):** the card is the video's thumbnail at
1920 x 1080 (`brand/youtube/source/thumbs-{pascal,java,sql,skills}.json`, ids
`install-NN-name`, frames from the video in `FOLDER/frames/` - picked where no
sketch note shows; Office's from the raw take with the initials blurred), held
3 s over the start with a 0.4 s fade, the narration under it (YouTube chat,
confirmed by Chris). `python tools\title.py NN-name` (or `all`) writes
`out\final\NN-name.mp4` + `.srt`; `out\NN-name.mp4` stays the plain master that
compose, check_video and resign work on. **`out\final\` is what gets uploaded.**

**Browser videos** (Chris, 3 October 2026: "do the browser videos - chrome,
firefox (edge is already installed by default)"): 18 Edge - settings only, no
install, set to ask where to save each download; 19 Chrome - installed to
Installs, **made the default browser**, then set to ask where to save; 20
Firefox - installed, **not made the default** ("Not now"), then set to ask
where to save. No browser sign-in or account on camera. **Made 3 October
2026, all 0 flags:** 18 Edge (63 s; the setting is on by default in a new
Windows, so the video circles it and says to click it if it's off), 19
Chrome (167 s; Stay signed out, Set as default + Windows' Set default, then
the toggle), 20 Firefox (195 s; firefox.com "Try Firefox"; data sharing
unticked, Continue = Firefox's terms, default unticked, welcome pages
skipped, Windows' default-apps page closed if it opens - step 08b is said
only then; Settings > Downloads > tick). Firefox's welcome pages slide in:
a control found before it has a position must be waited for (`FfBtn`).

**An "apps" checkpoint with everything installed** (Chris, 3 October 2026:
"keep all installs ... many tutorials to be made - everything you have made
an install video for"): each take starts from `clean` and its installs are
lost, so after the Office take that VM is kept and everything else with an
install video is added off camera (Lazarus in C:\lazarus, Delphi once its
video is made, the JDK, jGRASP, NetBeans with Java DB, MySQL and Workbench,
DBeaver, Letos, Notepad++, 7-Zip, draw.io, Git and GitHub Desktop, Google
Drive; OneDrive comes with Windows), set up as the videos leave them, and
saved as the checkpoint `apps`. Later tutorials start from `apps`.
**`apps` made 3 October 2026, 20:31** from `office` by `jobs\apps-install.ps1`
(silent installs, run with `jobs\dry\run-secret.ps1`, which puts the MySQL
test password in): Lazarus 4.8 in C:\lazarus, Temurin 25 (JAVA_HOME),
jGRASP 2.1.0_02, NetBeans 31 (en-GB numbers), Derby 10.17.1.0 in
C:\Tools\Derby with the TuckShop database (app/app) in C:\Tools\Derby\databases,
MySQL Server 8.0.46 (service MySQL80) and Workbench 8.0.47 with schema
tuckshop loaded, DBeaver 26.2.1 (all users; its virus-scanner exclusion
removed), Letos 4.0.3 in C:\Tools\Letos, Notepad++ 8.9.8.1, 7-Zip 26.03,
draw.io 31.7.0, Git 2.56.0 (editor Notepad, branch main), GitHub Desktop,
Google Drive (not signed in), Office with Access (activated). The installers
are in Downloads\Installs. Not done: first-run settings that need clicks
(NetBeans' Java switch-on and Java DB registration, DBeaver connections,
jGRASP's Browse folder, Notepad++'s default folder) and no lesson files in
OneDrive\Coding - a tutorial sets up what it needs. The VM is IPv4-only
with DNS 1.1.1.1/8.8.8.8 (since the Office take).

## Decisions (Chris, 27 September 2026)

- **Recorded in a clean Windows VM**, not on Chris's PC: a Windows 11
  Enterprise **evaluation** (en-GB, free for 90 days from its install on 28
  September 2026 - it runs out about 27 December 2026; recordings made
  before then stay good). Every video starts from the same clean snapshot,
  nothing personal is on screen, and the automation drives the installers
  **inside the VM** - nothing moves on Chris's desktop. Chris does any
  account logins himself.
- **Hyper-V, not VirtualBox** (Chris, 27 September 2026): VirtualBox crawled
  with Windows' hypervisor switched on and the PC crashed. The VM is
  `itcoder-win11`, built by `E:\itcoder-videos\vm-create-hyperv.ps1`
  (unattended install from an answer disc, local administrator "pupil" -
  password in `E:\itcoder-videos\vm-account.txt` - 6 cores, 8 GB, 1920 x
  1080, virtual TPM), **stored in `D:\VMs`** on the internal NVMe (Chris, 28
  September 2026): the first one was on E:, a USB drive, and crashed when
  E: and R: dropped out together at 14:49 that day. `E:\itcoder-videos\host-hv.ps1`
  drives it from the host with no elevation: keys into the VM (Alt+Y
  answers Windows' permission prompt, which runs on a secure desktop),
  pictures of its screen (2 s a frame - stills only) and PowerShell Direct
  for files and commands. Hyper-V has no recorder, so the agent in the VM
  records its own screen with ffmpeg; each permission prompt is a host
  still spliced into the edit.
- **Voice: a local clone of Chris's own voice** (free, stays on his PC):
  Pinokio's Qwen3-TTS or Ultimate TTS Studio (both installed; RTX 3080 Ti,
  16 GB). Chris records a 2-minute sample from
  `E:\itcoder-videos\voice\voice-sample-script.md`. Only Chris's voice,
  only for his videos.
- **Voice tests (27 September 2026):** Qwen3-TTS Base 1.7B sounds most
  like Chris ("b sounds more like me"); Chatterbox did not ("does not sound
  like me"); IndexTTS2 was too slow while ComfyUI shared the card. Best so
  far ("the best yet"): Qwen3 cloned from the **lively** reference
  (`voice\ref-lively.wav`, "Is it working? ... Excellent!") and made **one
  sentence at a time** with real gaps - 0.5 s between sentences, 1 s between
  steps (`voice\narrate.py`), because whole paragraphs came out "too rushed
  and close together". An exclamation such as "Right!" gets a pause after it.
  **Pronunciation list** `voice\pronounce.json` - words the voice says
  wrong, swapped for a spelling it says right (captions keep the real
  word). Chris's choices, 27 September 2026, one word at a time: **Pascal ->
  "Pascle"**, jGRASP -> "J-grasp", Temurin -> "Tem-yoo-rin", DBeaver ->
  "Dee beaver", SQL -> "sequel", MySQL -> "My sequel", SQLite -> "sequel
  light", Derby -> "Darby"; Lazarus, Letos and Delphi are right as spelt.
  **Licences:** Qwen3-TTS is Apache 2.0 (commercial use allowed). **Fish
  Speech S2 Pro** (inline tags such as `[excited]`, `[pause]`) is under the
  Fish Audio Research License - research and non-commercial only; use "in
  connection with a product or service for which You charge a fee" needs a
  paid licence from Fish Audio, so it is not for BestLessons' videos without
  one. It also needs about 11 GB of the card. Chris's first take in `sample.wav` is a
  false start: use `sample-clean.wav` from 11.6 s.
- **On-screen notes in the blue sketch style** of the lesson doodles: pen
  `#1f4fa3`, round-capped strokes (width 2 at doodle scale), hand-drawn
  arrows and circles, captions in **Kalam** bold. Drawn as transparent
  overlays and laid over the recording with ffmpeg.
- **Downloads inside the VM** (Chris, 28 September 2026: "Yes, all nine"):
  each video downloads its installer from the official site as part of the
  recording - Lazarus (SourceForge), Temurin (adoptium.net), jGRASP,
  NetBeans (Codelerity), Derby (apache.org), MySQL Installer, DBeaver,
  Letos, Delphi (with Chris's login) - and the tuck shop files from
  bestlessons.co.za.
- **Lazarus layout: Modern, one window** (Chris, 28 September 2026): at
  Lazarus 4.8's first start ("Configure Lazarus IDE", IDE Layout) the video
  picks Modern IDE (Single-Window) and Modern Form Editor (docked/tabbed) -
  everything in one window, like Delphi. Lessons that show Lazarus should
  match.
- **Edge in the clean VM** (28 September 2026): the new tab page has no MSN
  news, links or pictures (Edge policies NewTabPageContentEnabled=0 and
  friends), MSN's privacy pop-up was answered "Reject All" once before the
  checkpoint, Edge was allowed to finish its own update first and then told
  not to check again (EdgeUpdate AutoUpdateCheckPeriodMinutes=0) - so no
  video shows news, a pop-up or an "Update complete" page. Cookie banners
  on download sites are answered Deny on camera.
- **Ads on download sites are blurred** (Chris, 28 September 2026): a page
  such as SourceForge's is shown as it really looks for a few seconds, with
  its third-party ads softly blurred and the download bar left sharp. The
  evaluation watermark (bottom right) is covered with the background colour.
- **Chris uploads to YouTube**; the lessons then embed them (platform.md,
  decision 10: never invent YouTube IDs). **Each video goes to its
  subject's School SA channel** (Chris, 3 October 2026; was Pascal Code
  Singer): Lazarus and Delphi to Pascal School SA (@PascalSchoolSA); JDK,
  jGRASP and NetBeans to Java School SA (@JavaSchoolSA); Java DB, MySQL,
  DBeaver and Letos to SQL School SA (@SQLSchoolSA); the general tools
  (10-17: Explorer, Notepad++, 7-Zip, draw.io, Git, OneDrive, Google Drive,
  Office) to Computer Skills SA (@ComputerSkillsSA). See
  [../youtube-channels.md](../youtube-channels.md).
- **Opening, ending and waits** (Chris, 27 September 2026): every video
  opens "Hi, and welcome to BestLessons."; it ends with a sign-off that
  points to bestlessons.co.za and to the subject's School SA channel on
  YouTube (no "next
  video" - each sits in its own lesson). Downloads and install progress are
  **not waited through**: a 2-3 second fast-forward with a "(sped up)" note
  and one line, "This takes a few minutes, so I've sped it up." - "don't make
  them wait".
- **Narration first:** the voice is made before the recording, one file per
  step (`scripts\NN-name.md` -> `voice\out\NN-name\`); each step's video is
  cut or held to fit its audio, so no timings are measured first. A line the
  real installer proves wrong is re-made on its own.

## The videos

| # | Video | For | Notes |
|---|---|---|---|
| 1 | Lazarus (with Free Pascal) | Pascal course | install to **C:\lazarus** (Chris) - short path, no spaces |
| 2 | Delphi Community Edition | Pascal course | needs an Embarcadero account and a serial: Chris logs in; the serial is blurred |
| 3 | JDK (Eclipse Temurin) | Java course | for jGRASP and the NetBeans zip |
| 4 | jGRASP | Java course | the **bundled** Windows download (jGRASP 2.1.0_02 with its own Java 27, 241 MB): one install, no JDK first (28 September 2026 - jGRASP now offers it; Chris left the choice to Claude, so it can be switched to "plain jGRASP after video 3") |
| 5 | NetBeans | Java course, SQL Java DB | Codelerity installer (brings Java) |
| 6 | Java DB in NetBeans | SQL Java DB | unzip Derby 10.17.1.0, Java DB Properties, Start Server, Create Database, run the tuck shop script |
| 7 | MySQL and Workbench | SQL MySQL | MySQL Installer 8.0 ("fine for school level"), root password, schema, script |
| 8 | DBeaver | SQL (all) | Community edition; a Derby Server and a MySQL connection |
| 9 | Letos (SQLite) | SQL SQLite | portable zip; open TuckShop.db, run a query |
| 10 | File Explorer for programmers | setup lesson | extensions hidden first, then View > Show > File name extensions; Coding pinned to Quick access; Downloads\Installs and a Documents\IT folder made on camera |
| 11 | Notepad++ 8.9.8.1 | setup lesson | the big green button, not the adverts (blurred) that say DOWNLOAD; "Run Notepad++" unticked (it would run as administrator); default folder OneDrive\Coding; hello.pas saved to Coding\Pascal |
| 12 | 7-Zip 26.03 | setup lesson | a project folder zipped to hand in (Show more options > 7-Zip > Add to "Hello.zip") |
| 13 | draw.io 31.7.0 | setup and design lessons | get.diagrams.net (GitHub release page); two joined boxes; saved as Coding\Pascal\Flowchart.drawio |
| 14 | Git 2.56.0 + GitHub Desktop 3.6 | setup and project lessons | editor Notepad, not Vim; first branch "main"; sign-in skipped; repository in Documents\GitHub |
| 15-17 | OneDrive, Google Drive, Office/Access | setup lesson | wait for Chris's school login, typed by him in the VM |

Each is short (2-5 minutes), one job, and ends with the program working:
a Hello program compiled, or the tuck shop's fourteen products on screen.
The same recordings give the setup lessons their screenshots
(courses/sql-course.md, "Setup lessons").

## Pipeline

1. **VM** (Hyper-V, `D:\VMs\itcoder-win11`): 6 cores, 8 GB, 1920 x 1080,
   notifications and tips off, a plain wallpaper. Checkpoint **clean**;
   each video restores it first.
2. **Drive** each install from a script run inside the guest: smooth mouse
   moves to named buttons (UI Automation finds them), typing at a human
   pace. Every move and click is logged with its time.
3. **Record** inside the VM (the agent runs ffmpeg on its own screen, 30
   frames a second; permission prompts are host stills). The pointer is not
   in that recording, so a large, clear
   pointer and a click ripple are drawn in afterwards from the log - easier
   to follow than the real one.
4. **Script and voice**: a narration line per step, in Chris's voice style
   (writing-style.md), spoken by the clone, made first. The take is paced
   to it: `Say 'NN-name'` in the job holds each step for its narration.
5. **Notes**: an arrow, circle or caption per step, in the blue sketch
   style (`tools\sketch.py`), placed in `edit\NN-name.json` - by fixed
   boxes or `click:NAME` (the box of a click in the take's log).
6. **Edit and check**: `tools\compose.py NN-name [--draft]` makes
   `out\NN-name.mp4` and `.srt` - waits squeezed ("(sped up)"), each
   permission prompt shown as the host's picture with the pointer going to
   Yes, the narration placed step by step, the pointer and click ripples
   drawn, ads blurred, the watermark covered, the end card. Blur anything
   personal (the Delphi serial, an e-mail address). Chris watches each
   before uploading.

**How a video is made** (28 September 2026, first done for Lazarus): a dry
run in the VM step by step (`jobs\NN-dry-*.ps1`: pictures and control
lists of each screen - installers differ from what the storyboard
guessed), then the script is corrected and its narration re-made, then
`jobs\NN-name.ps1` is written and recorded with `Take 'NN-name'`
(`host-hv.ps1`: back to "clean", the job with its narration lengths, files
back to `raw\NN-name\`), then `compose.py`. Controls UI Automation can't
read (Lazarus's menus, Inno Setup's tick boxes, desktop icons) are clicked
by position (`ClickIn`, `MenuPick`), which is stable because every take
starts from the same clean VM.

**Scripts** (27 September 2026): `E:\itcoder-videos\scripts\01-lazarus.md`
to `09-letos.md`, one step per `## NN name`, edit notes on `>` lines,
`{caption|spoken}` where the voice must say something else (format in
`scripts\README.md`). Versions: Lazarus 4.8 (FPC 3.2.2), Delphi 13 CE,
Temurin 25 LTS, jGRASP 2.1.0, NetBeans 31, Derby 10.17.1.0, MySQL Installer
8.0, DBeaver 26, Letos 4.0.3. `> check:` lines are still to be confirmed
against the real installers while recording; `> optional` steps are
dropped if the screen never appears. The Pascal course's `ides` lesson and
Java lesson 3 are where videos 1-5 belong; the SQL setup lessons take 6-9.

**Narration** (made 27-28 September 2026, overnight): `voice\narrate.py`
makes `voice\out\NN-name\` - `narration.mp3` to listen to, `steps\*.wav`
(one per step, for the edit), `lines.json`, `report.txt`. Each line is
played back through speech recognition and re-made (up to three seeds) if
it doesn't come back as its words; names such as Letos are often misheard
by the recogniser, so a low score means "listen", not "wrong".

## Open

- Chris listens to the nine narrations (`voice\out\*\narration.mp3`;
  `voice\out\LISTEN-FIRST.txt` lists the lines worth a first listen).
- "Tuck shop": speech recognition often hears the voice's "Tuck Shop" as
  "touch shop". Chris picks a spelling from `voice\tuckshop\tuckshop-variants.mp3`
  (1 Tuck Shop, 2 Tuk Shop, 3 Tuckshop, 4 tuck-shop, 5 Tukk shop; 3 and 5
  came back as "Tuck Shop"); it goes into `pronounce.json` and the lines
  with it are re-made.
- Done and sent to Chris (29 September 2026): 1 Lazarus, 3 JDK, 4 jGRASP,
  5 NetBeans, 6 Java DB, 7 MySQL, 8 DBeaver, 9 Letos (`out\NN-name.mp4`
  and `.srt`). Chosen along the way:
  Lazarus - Simple Program (the shortest start), a desktop shortcut ticked,
  a narration line for the one-time debugging question and "Execution
  stopped"; NetBeans - a Java with Ant project (the lessons use its
  Libraries folder); Letos - the Explorer list is sorted by Type so
  letos.exe comes to the top of its 46 files, and TuckShop.db is put in
  Downloads before filming (pupils get it from the lesson).
- 6 Java DB made 29 September 2026: Derby 10.17.1.0 (Derby is retired;
  10.17 is the last) unzipped to C:\Derby, the two folders typed into Java
  DB Properties, app/app, NetBeans' own file chooser (Desktop, then
  Downloads). It starts from the VM checkpoint **netbeans** (clean + video
  5's install); `Take '06-javadb' 3600 'netbeans'`.
- 7 MySQL and 8 DBeaver (29 September 2026): MySQL Installer 8.0.46 is the
  last MySQL Installer (566 MB, Custom: Server 8.0.46 + Workbench 8.0.47);
  Windows asks twice (the MSI, then its launcher); both products need the
  Visual C++ runtime, which the installer puts in. The root password is a
  test one in `E:\itcoder-videos\vm-mysql.txt` (Take types it as dots, it is
  never in a job file). DBeaver 26.2.1 installs for the current user (no
  Windows prompt), its first-run wizard is answered "Do not share" usage
  statistics, and dbeaver.io's cookie bar (Accept only) is left alone.
  Its installer runs `add-windows-defender-exclusion.ps1`, so Windows asks
  whether PowerShell may make changes: the video says click **No** (the
  virus scanner keeps checking DBeaver's folder; it installs anyway) -
  Claude's choice, 29 September 2026, the safe answer; Chris can overrule.
  Video 8 starts from the checkpoint **mysql** (video 7's install, tuckshop
  loaded). The checkpoints are not refreshed by `VmRecheckpoint` - remake
  them if the agent changes.
- **Remade to the 1 October rules (1 October 2026, evening):** 9 Letos, 1
  Lazarus, 3 JDK and 4 jGRASP retaken, each checked by `check_video.py` with
  0 flags and sent to Chris. Each recording now lines up with the log
  exactly: the agent shows a black flash once ffmpeg's `-progress` file
  reports frames (a cold ffmpeg after a restore took up to 30 s to start
  capturing - a fixed wait missed it), and `compose.py` finds the flash in
  the first 60 s. An open file's size reads 0 on Windows, so don't wait on
  that.
- **5 NetBeans, new version (1 October 2026):** installer saved to
  Downloads\Installs; the project goes in OneDrive\Coding\Java - Browse in
  the New Java Application page, the up arrow (Documents -> Desktop), then
  OneDrive, Coding, Java, Open; NetBeans keeps the last location for new
  projects. Java takes its number format from the region, not Windows'
  decimal symbol, so NetBeans showed "162,7/311,0MB": the take adds
  `-J-Duser.language=en -J-Duser.country=GB` to `netbeans.conf` while the
  installer's Finish page is up (out of view). The desktop shortcut passes
  `--jdkhome` for the bundled JDK; starting `netbeans64.exe` without it says
  "Cannot find Java 1.8 or higher".
- **6 Java DB, new version (2 October 2026):** Derby unzipped to
  C:\Tools\Derby (portable programs: C:\Tools\<Name>), databases in
  C:\Tools\Derby\databases - on the PC, not in the cloud (a running
  database's files must never sync halfway; the video says so); the zip
  saved to Downloads\Installs; the tuck shop script opened from
  OneDrive\Coding\SQL (the take puts it there first and removes it after).
  It starts from the rebuilt checkpoint **netbeans** (clean + NetBeans 31
  installed silently, number format fixed, Java switched on, no project;
  the old one kept as **netbeans-0929**). NetBeans' menu bar is wider once
  Java is on (Window at x 726), and its Open box takes seconds to list the
  Desktop.
- **7 MySQL and 8 DBeaver, new versions (2 October 2026):** installers to
  Downloads\Installs, the extension lines, one line per action; MySQL's tuck
  shop script opened from OneDrive\Coding\SQL (put there by the take,
  removed after). The checkpoint **mysql** was remade from the new MySQL
  take's end (Workbench open, tuckshop loaded; the old one kept as
  **mysql-0929**). Its Edge remembers Installs as the last save folder, so
  the DBeaver take resets that to Downloads before filming. Workbench's
  password box moves: its OK is found by name. All nine install videos
  except Delphi are now made to the 1 October rules and sent.
- **Safeguards added 1-2 October 2026** (each found by a bad take):
  ffmpeg's start waited on via its `-progress` file; a recording frozen at
  Windows' prompt restarted; the host waits for the prompt to be drawn
  (a light dialog over the dimmed screen - an installer's own box is not
  it) before Alt+Y, and presses again only if that same prompt (its
  consent.exe) stays - MySQL's second prompt follows at once; the host
  retries its VM session right after a restore; Java-program steps wait for
  their part of the screen to change (`Grab`/`WaitChange` in
  `jobs\_common.ps1`) and a take stops if nothing appears, so clicks never
  land blind; a take's own files in the synced Coding folder are removed
  at its end, with a minute for OneDrive to pass that on; captions use a
  local copy of the Kalam font (`tools\fonts`), since the web font
  sometimes loaded too late and captions went missing. `check_video.py` now
  also flags a blank prompt picture and a caption missing from its note.
  It can't see a click that lands on the wrong thing when nothing errors,
  so the check sheets are still looked at frame by frame.
- **10-14 made and sent (3 October 2026, early):** File Explorer, Notepad++,
  7-Zip, draw.io, Git + GitHub Desktop - each `check_video.py` 0 flags, sheet
  and key frames looked at; files a take put in OneDrive\Coding removed after.
  Found on the way (now in the jobs and helpers): **never read a take's log
  while it records** - the agent's write failed on the locked file, the error
  report failed the same way and the agent stopped (its `Log` now retries);
  a page link read before the page settles sits elsewhere (Notepad++: wait,
  read again, check the next page opened); Explorer's close button and some
  dialogs' side panels and lists can't be read - by position (`CloseExplorer`,
  `PanelItem` with a fallback); in a classic right-click menu, **move straight
  across into a submenu, then down** - a curved path crosses other rows and
  closes it (7-Zip, Explorer's View > Show); a submenu opens on a click, not
  reliably on pointing. `compose.py` blurs can be held to a stretch of the
  take (`from`/`to`), for adverts that move; a circle on a fixed box needs
  `anchor`, not `line`. Captions on the right must end before x 1900 (Kalam is
  about half its size per letter).
- **15 OneDrive made and sent (3 October 2026):** from checkpoint
  **nocloud3** = nocloud + the fixed agent + OneDrive's self-update off (the
  OneDrive policy GPOSetUpdateRing = 0, its update task disabled): signed in,
  it updated itself to 26.173 mid-setup, restarted and lost the sign-in. Chris
  types his school login while the take waits (up to 25 minutes); the edit
  blurs the sign-in window and speeds it up, and blurs his whole OneDrive file
  list except the Coding row and the right-click menu (`unblur` boxes now take
  `mark:NAME` from the log). Watch for: a checkpoint keeps an old network
  lease - `Take` now restarts the VM's adapter after a restore (the Default
  Switch had moved to 172.29.x, so there was no DNS); Chris must connect
  **without Enhanced session** (it moves the desktop into an RDP session at
  his window's size, 2048 x 1152, and locks the console). Known flag: the
  sped-up tips clicks begin before "A few tips follow" ends.
- **16 Google Drive made and sent (3 October 2026):** from clean; Chris
  signs in with his school Google account in the browser during the take
  (blurred, sped up, and the address bar after it - it holds a one-time sign-in
  code); his profile picture in Drive's window and his My Drive files are
  blurred; a Coding folder is made on camera and removed after (his Drive has
  its own "New folder", so a new one may be "New folder (2)"). It shows how to
  check Drive is working (Chris's request): the icon under the tray's ^, what
  its signs mean, no icon = start it from the Start menu. Drive's installer,
  "Get started" and "Sign in" can't be read - by position. **From about midday
  on 3 October the background host process got no pictures or keys from
  Hyper-V while Windows' permission prompt showed** ("Invalid namespace"),
  though a foreground one did: that take's prompt was answered from the
  foreground (`VmShot` + `AllowPrompt`); the host now presses Yes after 8 failed
  pictures, and both retry. Never start a take with `&` in a shell - it dies
  with the shell; and stop an old take's host process before the next take.
- **17 Office/Access made and sent (3 October 2026):** office.com, sign in,
  office.com/apps, Install apps, Microsoft 365 apps, then Install Office on the
  account page (portal.office.com) - OfficeSetup.exe to Installs, about 12
  minutes of install (sped up). Access's first start asks for the school
  account again, then the licence and a privacy note (Chris accepted and
  closed them himself in the take; the job does it if he doesn't). Blurred:
  both sign-ins, his Copilot chats and name, his initials, Access's welcome box
  and title bar. **Background host processes can't reach Hyper-V at all now:**
  even the checkpoint restore failed silently (the first take ran on the old
  VM), so restore from the foreground and run `Take <video> <timeout> ''`
  (checkpoint '' = restored already); answer the permission prompt from the
  foreground while the job's `Prompt 300` waits. In a fresh VM the account
  page's first visit after sign-in bounces back to Copilot and it can load
  without its styles ("Please wait") - the job visits it once off camera
  during the blurred sign-in; IPv6 is switched off and DNS set to 1.1.1.1 in
  the VM before the take (helped or not, it worked). Checkpoints `office`
  (straight after the take) and `office-dry` (the dry-run VM) both have
  Office installed and activated.
- **Channel sign-offs redone (3 October 2026):** each video's last line and end
  card name its subject's channel (Pascal / Java / SQL School SA, Computer
  Skills SA for 10-17). 01 and 03-08 were recomposed in full; 09-17 got a
  new end card with `tools\resign.py NN-name` (keeps the video up to the end
  card, adds the card and the re-voiced ending lines; the old file stays as
  `out\NN-name.pre-resign.mp4`) - the quick way when only the ending changes.
  All checked: 0 flags, except 15's accepted timing flag.
- **One channel: BestLessons (Chris, 4 October 2026, via the YouTube chat):**
  Pascal Code Singer is now BestLessons (@BestLessonsSA); the School SA and
  Computer Skills SA channels are parked. All 20 scripts say "find BestLessons
  on YouTube", the end cards and the title cards' brand line say BestLessons
  (thumbs.py CHANNELS, subject colours kept). Re-voiced and re-spliced with
  `tools\resign.py`, re-titled with `tools\title.py all`; uploads were held
  for it (Chris: "Re-voice now, uploads wait").
- **Card notes** (youtube-channels.md, "Cards to other videos"):
  `python tools\cardnotes.py` writes `out\final\NN-name.youtube.md` - every
  line pointing to another video (the File Explorer video from each first
  save box; OneDrive / Google Drive from Lazarus, jGRASP, NetBeans,
  Notepad++), with its time in the final file. Re-run after any re-render.
- Still to make: 2 Delphi (Chris's Embarcadero login).
- Delphi: Chris's Embarcadero login during the Delphi recording.
- Where each video sits in the lessons, once the YouTube links exist.
- **Queued (Chris, 1 October 2026), now with the install-video chat
  ("Database planning: caps and sags", Chris, 3 October 2026). Status 3
  October: (1), (3), (4) done in every video made so far; (2) the Edge,
  Chrome and Firefox videos not made yet:** (1) file name extensions SHOWN in every
  Explorer shot, always - redo the Explorer parts of the videos already made;
  (2) three new short videos: Edge, Chrome, Firefox set to ask where to save
  each download (check the setting labels in the VM); (3) installers saved
  to Downloads\Installs through that dialog; (4) the first time a video
  shows Explorer (window or save dialog) the voice says what extensions are
  and points to the Explorer set-up video (YouTube card/link); (5) good file
  and folder names whenever a video makes them. The videos go in the new
  first lesson "Getting your computer set up to study programming"
  (`content/pascal/setup-lesson.php`, `$setupVideos`: onedrive, googledrive,
  explorer, edge, chrome, firefox, notepadpp, sevenzip, lazarus, delphi,
  jdk, jgrasp, netbeans); fill each YouTube id in as Chris uploads.
  **Taken on by the install-video chat (Chris, 1 October 2026: "this chat,
  now"):** the VM checkpoint **clean** shows extensions since 1 October 21:05
  (the old one is kept as **clean-hidext**); **nocloud** still hides them,
  because the File Explorer video switches them on. Every video's first save
  box now has two lines after "Click Save as.": "Look at the file name: the
  part after the last dot is its extension - .zip / .exe / .msi means ..."
  (the file name box circled, caption "after the dot = extension") and "If
  you can't see extensions on your computer, the File Explorer video shows
  how to switch them on - it's up in the right-hand corner." Letos, Lazarus,
  JDK, jGRASP and NetBeans are being retaken with them; Java DB, MySQL and
  DBeaver get them when they are redone.
