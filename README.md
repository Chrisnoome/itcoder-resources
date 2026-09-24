# AIResources - start here

**The source of truth for the itcoder project**: the itcoder.co.za platform, its
courses, the server and the house styles. Every chat reads this first and
records decisions here. Files hold the **current state only** - history is in
this folder's git log.

## Rules for every chat

1. Read this file, then the files your task touches (each project's `CLAUDE.md`
   loads this one).
2. **This folder wins** over a project README, code comment, memory or older
   chat. Fix whichever is wrong.
3. **Record decisions here**, in the right file, with the date Chris made them.
   Write the rule as it now stands; replace, don't append history. **Also add
   one line to the end of [history.md](history.md)** for every rule, style or
   engine change (not for new lesson content). Append only; don't read it
   unless you need to know why something changed.
4. Date facts that go stale (server specs, prices).
5. **No secrets** (say where they live) and **no pupils' personal data**.
6. Write for the next chat, which knows nothing: say why, not just what.
7. Other chats may be editing the same lessons or files - make small, exact
   edits and never overwrite work you did not read.

## Files

| File | Holds |
|---|---|
| [platform.md](platform.md) | Purpose, stack, architecture, **decisions that must not be undone**, sign-in and privacy, keys, local testbed, checks |
| [publishing.md](publishing.md) | **How to publish** to test then live - read before touching the server |
| [vps-access.md](vps-access.md) | The server: access, what is on it, house rules |
| [compile-subsystem-design.md](compile-subsystem-design.md) | The Pascal compile sandbox and queue |
| [live-console-design.md](live-console-design.md) | The live console (interactive Pascal, files, editor, layout check, code completion) |
| [backups.md](backups.md) | Backups, restore, the Dropbox pull and its alarm |
| [open-items.md](open-items.md) | The backlog |
| [platform-roadmap.md](platform-roadmap.md) | PLAN: teachers and classes, subscriptions and payments, the public landing page - with Chris's open questions |
| [history.md](history.md) | Append-only log of rule, style and engine changes - don't load unless asked why |
| [writing-style.md](writing-style.md) | Base rules for lesson prose |
| [content-voice-and-pedagogy.md](content-voice-and-pedagogy.md) | Voice, pedagogy and lesson rules, with the lesson checklist |
| [pascal-house-style.md](pascal-house-style.md) | How Pascal code is written |
| [marking-house-style.md](marking-house-style.md) | How practicals and code submissions are marked |
| [sags-topic4-syllabus.md](sags-topic4-syllabus.md) | IEB SAGs Topic 4 (programming) as a teaching checklist |
| [sags-2025.md](sags-2025.md) | The rest of the SAGs as reference |
| [ieb-practical-exam-analysis.md](ieb-practical-exam-analysis.md) | Every IEB practical paper analysed: structure, what always appears, marking, exam technique - for lesson 24 |
| [caps-practical-exam-analysis.md](caps-practical-exam-analysis.md) | Every DBE (CAPS) Paper 1 analysed, Pascal questions only (1, 3, 4): structure, what always appears, marking, technique - for lesson 25 |
| [caps-tasks.md](caps-tasks.md) | The CAPS school-based tasks (the DBE PAT, the alternative task) and a proposal for lessons 28+ |
| [caps-2024.md](caps-2024.md) | The DBE CAPS (2024 amendment) as reference: every topic per grade and term, assessment, Paper 1/2 formats |
| [courses/ai-course.md](courses/ai-course.md) | The Grade 9 AI course |
| [courses/pascal-course.md](courses/pascal-course.md) | The Pascal course: lessons, decisions, verified facts |
| `tools/publish-test.py`, `tools/deploy-live.py`, `tools/sandbox-check.php`, `tools/marking-check.php` | Publishing ([publishing.md](publishing.md)) |
| `tools/vps.py` | Run commands and upload files on the server |
| `tools/pull-backups.py`, `.cmd` | The daily Dropbox pull |
| `word documents/`, `Quote images/`, `Logos and icons/`, the SAGS PDF | Source material |

## Elsewhere

| What | Where |
|---|---|
| Platform code - all work | `Projects/AIPascalCourse` -> `/var/www/itcoder` |
| Old v1 site (not deployed; AI-course source only) | `Projects/AIWebCourse/itcoder` |
| Pupil backups (personal data) | `Projects/AIWebCourse/backups` |
| Secrets | `config/config.php` per project; server key `C:\Users\chris\.ssh\gnomemedia_vps` |
| Future courses | `Projects/AITheory`, `Projects/AIQuestionDatabase` (empty) |
| Git remotes | Private GitHub `Chrisnoome/itcoder-platform` (AIPascalCourse), `Chrisnoome/itcoder-resources` (this folder) - see platform.md, "Keys and accounts" |

## Adding a course or a chat

A new course's chat works in `Projects/<name>` with a `CLAUDE.md` pointing here
(copy `Projects/AITheory`'s). Courses are added to the platform in
`AIPascalCourse` and get a file in `courses/`. New shared rules go in the
matching file here; a new file is fine if nothing fits - add it to the table.
