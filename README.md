# AIResources - start here

**This folder is the source of truth for the itcoder project** - the
itcoder.co.za platform, its courses, the server it runs on, and the house styles
its content and marking follow. Every Claude chat that works on any part of it
reads this first and records its decisions here.

Set up on 11 September 2026, when the chat that built itcoder v1 (in
`AIWebCourse`) handed the project to the platform chat (in `AIPascalCourse`).
Everything the first chat knew is in this folder.

## Rules for every chat

1. **Read this file first**, then the files your task touches. Each project
   folder's `CLAUDE.md` loads this file automatically.
2. **This folder wins.** If a project README, a code comment, your own memory or
   an older chat disagrees with what is here, this folder is right - and then fix
   the other one, so the disagreement doesn't come back. If *this* folder is the
   one that's wrong, fix it here.
3. **Record decisions here, not only in chat memory.** Memory belongs to one chat;
   this folder belongs to all of them. When Chris decides something another chat
   will need, write it into the right file below, with the date.
4. **Date your facts and check them.** "4 vCPU (checked 11 Sep 2026)" beats
   "4 vCPU". Server facts go stale when the VM changes; prices go stale monthly.
5. **No secrets here** - no API keys, client secrets, passwords or private keys.
   Say where they live instead.
6. **No pupils' personal data here** - no backups, class lists or exports. This
   is the folder most likely to be shared with a colleague, and everything in it
   goes along.
7. **Write for the next chat**, which knows nothing. Say why, not just what.

## What is in this folder

| File | What it holds |
|---|---|
| [platform.md](platform.md) | The platform: purpose, audience, stack, v2 architecture, **the decisions that must not be undone**, sign-in and privacy rules, keys, local testbeds, checks to run |
| [publishing.md](publishing.md) | **How to put work on the test site and the live site** - the two scripts, in order, their exact commands, and what to do when one fails. Read before publishing anything |
| [vps-access.md](vps-access.md) | The server: how to reach it, what is on it, house rules, installing Free Pascal, sandboxing pupil code, cutover |
| [compile-subsystem-design.md](compile-subsystem-design.md) | The Pascal compile subsystem: sandboxing tested and validated against the live server, what worked and what didn't, suggested shape for the queue - handoff for whoever builds it |
| [backups.md](backups.md) | Server backups, restoring, the Dropbox pull and its staleness alarm |
| [open-items.md](open-items.md) | The backlog for the whole project |
| [writing-style.md](writing-style.md) | Base rules for lesson prose, calibrated against Chris's own writing |
| [content-voice-and-pedagogy.md](content-voice-and-pedagogy.md) | Voice and pedagogy for all new lessons, built on writing-style.md |
| [pascal-house-style.md](pascal-house-style.md) | How Pascal code is written |
| [marking-house-style.md](marking-house-style.md) | How practical exams and programming submissions are marked |
| [sags-topic4-syllabus.md](sags-topic4-syllabus.md) | IEB SAGs Topic 4 as a teaching checklist |
| [sags-2025.md](sags-2025.md) | The rest of the SAGs (exam structure, taxonomies, SBA/PAT rules, Topics 1-3 in full) as clean markdown - a token-cheap reference, not a teaching document |
| [courses/ai-course.md](courses/ai-course.md) | The Grade 9 AI course: lesson order, scope, activities and what they must never break |
| [courses/pascal-course.md](courses/pascal-course.md) | The Pascal course - kept by the Pascal chat |
| [courses/pascal-lesson10-draft-prime-check.md](courses/pascal-lesson10-draft-prime-check.md) | Prime-checking content cut from lesson 9 - consumed by lesson 10 (18 September 2026), kept as a historical record, not reused verbatim |
| `tools/publish-test.py`, `tools/deploy-live.py`, `tools/sandbox-check.php`, `tools/marking-check.php` | Publishing, test then live ([publishing.md](publishing.md)) |
| `tools/vps.py` | Run commands on the server and upload files ([vps-access.md](vps-access.md)) |
| `tools/pull-backups.py`, `.cmd` | The nightly Dropbox pull ([backups.md](backups.md)) |
| `word documents/`, `Quote images/`, `Logos and icons/`, the SAGS PDF | Source material |

## What lives elsewhere, and why

| What | Where |
|---|---|
| Platform code (v2) - **all new work** | `Projects/AIPascalCourse` -> `/var/www/itcoder` |
| The live site today (v1) | `Projects/AIWebCourse/itcoder` - replaced by v2 at cutover; frozen apart from AI-course content still being edited |
| Pupil backups | `Projects/AIWebCourse/backups` - personal data, kept out of here on purpose |
| Secrets | `config/config.php` in each project; the server key at `C:\Users\chris\.ssh\gnomemedia_vps` |
| Future courses | `Projects/AITheory`, `Projects/AIQuestionDatabase` - empty so far |
| Git history / off-machine backup | Private GitHub repos under Chris's account (`Chrisnoome`) - [github.com/Chrisnoome/itcoder-platform](https://github.com/Chrisnoome/itcoder-platform) (`AIPascalCourse`) and [github.com/Chrisnoome/itcoder-resources](https://github.com/Chrisnoome/itcoder-resources) (this folder, including `vps-access.md` - a deliberate choice, made 12 September 2026, for a complete backup rather than a partial one). `config/config.php` stays out of `itcoder-platform` via `.gitignore` - it is not a backup gap, it just isn't a secret worth putting in git history when `config.sample.php` already documents its shape. Push with plain `git push` once a remote is set - see platform.md, "Keys and accounts", for how this machine authenticates. |

## State of play, 11 September 2026

- itcoder.co.za runs **v1**, the Grade 9 AI course. **No pupils have started**,
  so replacing it loses nothing.
- **v2**, the multi-course platform, holds the AI course (draft, to be ported) and
  Pascal (open, two lessons). It replaces v1 at cutover - intended, confirmed by
  Chris.
- The server was upgraded on 10 September (4 vCPU, 3921 MB RAM, 77 GB disk) and
  made key-only for root on 11 September.
- Backups run nightly on the server and are pulled to Dropbox daily, with an alarm
  if they stop.
- **The Pascal chat carries the project from here.** The AIWebCourse chat is
  finished and is not coming back - don't look for it.

## Adding a new course or a new chat

- A new course's chat works in its own `Projects/<name>` folder, with a
  `CLAUDE.md` that points here (copy the one in `Projects/AITheory`). Courses are
  added to the v2 platform in `AIPascalCourse` (platform.md, "v2 architecture"),
  and get a file in `courses/`.
- New shared rules go in the matching file here. A new file is fine if nothing
  fits - add it to the table above.
