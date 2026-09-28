# Install videos - how to install and use the tools (PLAN)

**Status: planning, 27 September 2026.** Chris: "plan and execute
installation videos for lazarus (recommend install on c:), delphi, netbeans,
jgrasp, dbeaver, mysql - anything else. i'll upload to youtube, then we can
insert into lessons. use the blue sketch style for on screen instructions.
can we create a voice clone for me?"

## Decisions (Chris, 27 September 2026)

- **Recorded in a clean Windows VM**, not on Chris's PC: VirtualBox 7.2, a
  Windows 11 Enterprise **evaluation** (en-GB, free for 90 days - it runs
  out about 26 December 2026; recordings made before then stay good). Every
  video starts from the same clean snapshot, nothing personal is on screen,
  and the automation drives the installers **inside the VM** - nothing moves
  on Chris's desktop. Chris clicks Windows permission prompts (UAC) and does
  any account logins himself.
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
  paid licence from Fish Audio, so it is not for itcoder's videos without
  one. It also needs about 11 GB of the card. Chris's first take in `sample.wav` is a
  false start: use `sample-clean.wav` from 11.6 s.
- **On-screen notes in the blue sketch style** of the lesson doodles: pen
  `#1f4fa3`, round-capped strokes (width 2 at doodle scale), hand-drawn
  arrows and circles, captions in **Kalam** bold. Drawn as transparent
  overlays and laid over the recording with ffmpeg.
- **Chris uploads to YouTube**; the lessons then embed them (platform.md,
  decision 10: never invent YouTube IDs). The channel is **Pascal Code
  Singer**, https://www.youtube.com/@PascalCodeSinger.
- **Opening, ending and waits** (Chris, 27 September 2026): every video
  opens "Hi, and welcome to BestLessons."; it ends with a sign-off that
  points to bestlessons.co.za and to Pascal Code Singer on YouTube (no "next
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
| 4 | jGRASP | Java course | needs a JDK (video 3) |
| 5 | NetBeans | Java course, SQL Java DB | Codelerity installer (brings Java) |
| 6 | Java DB in NetBeans | SQL Java DB | unzip Derby 10.17.1.0, Java DB Properties, Start Server, Create Database, run the tuck shop script |
| 7 | MySQL and Workbench | SQL MySQL | MySQL Installer 8.0 ("fine for school level"), root password, schema, script |
| 8 | DBeaver | SQL (all) | Community edition; a Derby Server and a MySQL connection |
| 9 | Letos (SQLite) | SQL SQLite | portable zip; open TuckShop.db, run a query |

Each is short (2-5 minutes), one job, and ends with the program working:
a Hello program compiled, or the tuck shop's fourteen products on screen.
The same recordings give the setup lessons their screenshots
(courses/sql-course.md, "Setup lessons").

## Pipeline

1. **VM** (`E:\itcoder-videos\vm`): 4 cores, 8 GB, 1920 x 1080, Guest
   Additions, notifications and tips off, a plain wallpaper. Snapshot
   **clean**; each video restores it first.
2. **Drive** each install from a script run inside the guest: smooth mouse
   moves to named buttons (UI Automation finds them), typing at a human
   pace. Every move and click is logged with its time.
3. **Record** with VirtualBox's own screen recording (the guest's screen
   only). The guest's pointer is not in that recording, so a large, clear
   pointer and a click ripple are drawn in afterwards from the log - easier
   to follow than the real one.
4. **Script and voice**: a narration line per step, in Chris's voice style
   (writing-style.md), spoken by the clone; each step's video is held or
   trimmed to fit its line.
5. **Notes**: an arrow, circle or caption per step, in the blue sketch
   style, timed from the log.
6. **Edit and check**: ffmpeg joins it all; blur anything personal (the
   Delphi serial, an e-mail address); captions as an .srt file for
   YouTube. Chris watches each before uploading.

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
- Recording waits for Hyper-V (Chris enables it and restarts) and the VM.
- Delphi: Chris's Embarcadero login during the Delphi recording.
- Where each video sits in the lessons, once the YouTube links exist.
