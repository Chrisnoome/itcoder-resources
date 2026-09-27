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
  decision 10: never invent YouTube IDs).

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

**Draft storyboards** (27 September 2026, to check against the real
installers while recording): `E:\itcoder-videos\scripts\01-lazarus.md`
(Lazarus 4.8, FPC 3.2.2) and `02-08-drafts.md` (Delphi 13 CE, Temurin 25
LTS, jGRASP 2.1.0, NetBeans 31, Derby 10.17.1.0, MySQL Installer 8.0,
DBeaver 26, Letos 4.0.3). The Pascal course's `ides` lesson and Java lesson 3
are where videos 1-5 belong; the SQL setup lessons take 6-9.

## Open

- Chris records the voice sample.
- Delphi: Chris's Embarcadero login during the Delphi recording.
- Where each video sits in the lessons, once the YouTube links exist.
