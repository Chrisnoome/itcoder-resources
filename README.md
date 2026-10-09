# AIResources - start here

**The source of truth for the BestLessons project**: the bestlessons.co.za platform (the old itcoder.co.za still works), its
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
8. **Ask when anything is unclear** (Chris, 27 September 2026: "ask questions
   whenever anything is unclear - and to do so always in interactive mode").
   Before building, ask about every choice that would change what gets built,
   always with the interactive question tool (multiple choice, the
   recommended option first) - never as questions typed into a reply. If
   Chris dismisses the questions, stop and wait. **This covers every
   question, not only before building** (Chris, 1 October 2026: "always ask
   questions interactively"): "is that OK?", "which do you want?", choices
   left open at the end of a report - all go through the tool, never as
   text at the end of a reply.
9. **Keep off C: on Chris's PC** (Chris, 28 September 2026: "c: is low on
   space, if you need space work on d: or e:"). Anything big - VMs, videos,
   downloads, models, caches, renders, scratch files that grow - goes on D:
   or E:, never C: (the scratchpad on C: is for small files only). Set a
   program's own data or download folder to D: or E: when it would default
   to C:.
10. **Pictures from ComfyUI go through the queue** (Chris, 1 October 2026:
    "a general comfyui queue that all chats can add their requirements
    to"). Add a request to [comfyui-queue/](comfyui-queue/README.md) and
    show a stand-in on the site until the picture exists; never run
    ComfyUI yourself unless Chris says the GPU is ready.
11. **Jev wherever practical - in marking and everywhere in a course**
    (Chris, 6 October 2026: "always remember to use jev in question marking
    where practical - and elsewhere in a course. this should be a permanent
    note for all course development"; the same day: "use of jev must be
    standard in all course development - in marking, interactive activities,
    wherever it would be useful"). A judgment about a pupil's words that is a
    quick yes/no, a choice or a score - a marking point, an idea there or not,
    a term right, an own-words check, what a reply means - goes to **Jev**
    (TypeSafe, `lib/jev.php`) first; **Claude** only for what Jev is unsure
    of, for judgment, and for writing words (feedback). Building a question:
    give a written question `points` Jev can mark, and keep its `rubric` (or
    `markerRubric`) for what needs Claude. A marking brief has two parts -
    **checks for Jev, notes for Claude** (platform.md, "Marking notes").
12. **Finish with a question, and spend no tokens idling** (Chris, 9 October
    2026: "tell chats when they have finished work to pop up a question
    (create a visible yellow status dot) and cut any unnecessary background
    tasks that consume tokens - token use running very high"). When a piece
    of work is done, end the turn with a question (AskUserQuestion), so the
    session shows Chris a yellow dot. Run no background work that is not
    needed now: no loops, wake-ups, monitors or polling, and stop a
    background run as soon as its answer is in.

## Files

| File | Holds |
|---|---|
| [platform.md](platform.md) | Purpose, stack, architecture, **decisions that must not be undone**, sign-in and privacy, keys, local testbed, checks |
| [publishing.md](publishing.md) | **How to publish** to test then live - read before touching the server |
| [vps-access.md](vps-access.md) | The server: access, what is on it, house rules, the install kit for a new one |
| [compile-subsystem-design.md](compile-subsystem-design.md) | The Pascal compile sandbox and queue |
| [sql-runner-design.md](sql-runner-design.md) | The SQL runner: MySQL, Java DB and SQLite for the SQL course's `sql` blocks - guard, limits, sandbox, install |
| [live-console-design.md](live-console-design.md) | The live console (interactive Pascal, files, editor, layout check, code completion) |
| [backups.md](backups.md) | Backups, restore, the Dropbox pull and its alarm |
| [open-items.md](open-items.md) | The backlog |
| [platform-roadmap.md](platform-roadmap.md) | PLAN: teachers and classes, subscriptions and payments, the public landing page - with Chris's open questions |
| [popia-checklist.md](popia-checklist.md) | **POPIA** (3 Oct 2026, draft for an attorney): what the site holds, children's consent (s35), operator agreements for schools, approval before work is shown, cross-border, the questions to ask |
| [schools-design.md](schools-design.md) | **Schools, cohorts and classes** (3 Oct 2026, agreed): school, teacher, cohort, class, TIC, weighting, term marks, the sign-up wizard, home schools - replaces the roadmap's "no school level yet" |
| [history.md](history.md) | Append-only log of rule, style and engine changes - don't load unless asked why |
| [writing-style.md](writing-style.md) | Base rules for lesson prose |
| [content-voice-and-pedagogy.md](content-voice-and-pedagogy.md) | Voice, pedagogy and lesson rules, with the lesson checklist |
| [pascal-house-style.md](pascal-house-style.md) | How Pascal code is written |
| [java-house-style.md](java-house-style.md) | How Java code is written (the Java course) |
| [marking-house-style.md](marking-house-style.md) | How practicals and code submissions are marked |
| [sags-topic4-syllabus.md](sags-topic4-syllabus.md) | IEB SAGs Topic 4 (programming) as a teaching checklist |
| [sags-2025.md](sags-2025.md) | The rest of the SAGs as reference |
| [ieb-practical-exam-analysis.md](ieb-practical-exam-analysis.md) | Every IEB practical paper analysed: structure, what always appears, marking, exam technique - for lesson 24 |
| [caps-practical-exam-analysis.md](caps-practical-exam-analysis.md) | Every DBE (CAPS) Paper 1 analysed, Pascal questions only (1, 3, 4): structure, what always appears, marking, technique - for lesson 25 |
| [ieb-theory-exam-analysis.md](ieb-theory-exam-analysis.md) | Every IEB theory paper (2009-May 2021) analysed: structure, scenarios, question formats with counts, marking, verbs, recurring topics, technique - and specs for the theory courses' multipart and identify questions |
| [caps-theory-exam-analysis.md](caps-theory-exam-analysis.md) | Every DBE (CAPS) Paper 2 (2016-May/June 2026, 23 papers) analysed: structure and the 2024-amendment shape, question formats with counts, marking, verbs, recurring topics, technique - and specs for the multipart and identify questions |
| [caps-tasks.md](caps-tasks.md) | The CAPS school-based tasks (the DBE PAT, the alternative task) and a proposal for lessons 28+ |
| [caps-2024.md](caps-2024.md) | The DBE CAPS (2024 amendment) as reference: every topic per grade and term, assessment, Paper 1/2 formats |
| [sql-dialects.md](sql-dialects.md) | Access vs MySQL vs Java DB vs SQLite, tested on real engines - **each dialect runs on its own engine, never imitated**; Access is simulated; the IEB's data files disagree |
| [courses/ai-course.md](courses/ai-course.md) | The Grade 9 AI course |
| [courses/ai-yearly-update.md](courses/ai-yearly-update.md) | Facts in the AI course that go stale (prices, products, data centres, company figures, video links), checked every January; add a line whenever a lesson states one |
| [courses/pascal-course.md](courses/pascal-course.md) | The Pascal course: lessons, decisions, verified facts |
| [courses/java-course.md](courses/java-course.md) | The Java course (IEB only): Chris's brief, lessons, verified facts |
| [courses/sql-course.md](courses/sql-course.md) | PLAN: the SQL and databases course - shared theory, SQL lessons per dialect (Access, MySQL, Java DB, SQLite), marks per dialect, the SQL runner, questions for Chris |
| [courses/install-videos.md](courses/install-videos.md) | PLAN: install videos for the tools (Lazarus, Delphi, JDK, jGRASP, NetBeans, Java DB, MySQL, DBeaver, Letos) - recorded in a clean Windows VM, blue sketch notes, Chris's cloned voice, uploaded to YouTube by Chris |
| [youtube-channels.md](youtube-channels.md) | The seven YouTube channels made 3 Oct 2026 (AI 4 All, AI for Teachers, Pascal/Java/SQL/CAT School SA, Computer Skills SA): handles, channel IDs, purpose, art folders, what's left |
| [courses/tutorial-videos.md](courses/tutorial-videos.md) | PLAN: tutorial videos - install-video pipeline and voice, blue doodle style, sped-up typing then held code, house-style code zip on bestlessons.co.za, .srt captions, doodle thumbnail template |
| [courses/delphi-gui.md](courses/delphi-gui.md) | PLAN, waits for the Delphi IDE: Delphi GUI simulations from real screens, CAPS Delphi lessons and GUI tutorials (Chris, 4 Oct 2026) |
| [courses/theory-course.md](courses/theory-course.md) | PLAN: the IT Theory courses - Chris's decisions, sources (the old textbook), chapter outlines per grade, platform work |
| [courses/theory-review-queue.md](courses/theory-review-queue.md) | IT Theory review items still open after the 27 Sep 2026 reviews of Grades 10-12 - delete an item when it is done |
| [courses/theory-yearly-update.md](courses/theory-yearly-update.md) | Facts in the theory lessons that go stale (brands, statistics, "most"), checked every January; add a line whenever a lesson states one |
| [course-development.md](course-development.md) | PLAN: researching courses for other subjects (CAT first) in the separate `itcoder-coursedev` repo - scope, subject order, sources and how to get them, outputs |
| `tools/publish-test.py`, `tools/deploy-live.py`, `tools/sandbox-check.php`, `tools/marking-check.php` | Publishing ([publishing.md](publishing.md)) |
| `tools/vps.py` | Run commands and upload files on the server |
| `tools/sim-screens/` | Real program screens (Excel first) for the software simulations - its README |
| [comfyui-queue/](comfyui-queue/README.md), `tools/comfy-queue/run.py` | Every chat's ComfyUI picture requests, and the runner that makes them when the GPU is ready |
| `tools/pull-backups.py`, `.cmd` | The daily Dropbox pull |
| `tools/sql-dialects/` | The SQL dialect test harness and its results ([sql-dialects.md](sql-dialects.md)) |
| `tools/ui-screens/` | How the lessons' text screens and window screenshots were made (Pascal, Java lesson 23 and 24) - the no-clicks rule is in its README |
| `tools/access-screens/` | Real Access screenshots and the downloadable TuckShop.mdb for the SQL course's Access lessons - **hands off the keyboard and mouse while it runs** (its README) |
| `tools/java-packaging/` | The test programs behind Java lesson 28 (JAR files, jpackage) |
| `tools/java-databases/` | The programs behind Java lessons 25-27 (SQLite, JavaFX tables, Java DB) and their screenshot drivers |
| `tools/java-ieb/`, `tools/java-glossary/` | The Java IEB lessons' example programs, and the script that drafted the Java glossary |
| `word documents/`, `Quote images/`, `Logos and icons/`, the SAGS PDF | Source material |

## Elsewhere

| What | Where |
|---|---|
| Platform code - all work | `Projects/AIPascalCourse` -> `/var/www/itcoder` |
| Old v1 site (not deployed; AI-course source only) | `Projects/AIWebCourse/itcoder` |
| Pupil backups (personal data) | `Projects/AIWebCourse/backups` |
| Secrets | `config/config.php` per project; server key `C:\Users\chris\.ssh\gnomemedia_vps` |
| Brand: BestLessons logo and icons (bestlessons.co.za) | [brand/bestlessons/](brand/bestlessons/README.md) |
| Year planning 2027: school calendars (DBE, ISASA, named schools) and ready-made plans | [planning/](planning/README.md) |
| Future courses | `Projects/AITheory`, `Projects/AIQuestionDatabase` (empty) |
| Research for other subjects' courses | `Projects/itcoder-coursedev` - see [course-development.md](course-development.md) |
| Git remotes | Private GitHub `Chrisnoome/itcoder-platform` (AIPascalCourse), `Chrisnoome/itcoder-resources` (this folder) - see platform.md, "Keys and accounts" |

## Adding a course or a chat

A new course's chat works in `Projects/<name>` with a `CLAUDE.md` pointing here
(copy `Projects/AITheory`'s). Courses are added to the platform in
`AIPascalCourse` and get a file in `courses/`. New shared rules go in the
matching file here; a new file is fine if nothing fits - add it to the table.

**One look for every course** (Chris, 25 September 2026: all design changes
apply to the Java course - being built now - and to every course created
later). There is no per-course design. A new course gets, and must keep:

- the E look (platform.md decision 27): the same masthead, fonts, outline
  rail, margin, numbered questions and figures, and bottom bar. Lesson pages
  come through `public/lesson.php` and get it automatically; any page of the
  course's own calls `DesignHeadHtml()` and `DesignBodyAttr()`
  (lib/design.php). Extra CSS for the course goes under `body.design-e` and
  uses the design-e.css tokens - never a separate stylesheet or colour scheme;
- the content rules in content-voice-and-pedagogy.md: margin doodles and
  "Did you know?" notes (§5b), boxed and captioned figures (§5a), code hints
  as short ways of thinking with no code (§4), and the whitespace check;
- South African English (writing-style.md).

A design change made for one course is made for all of them in the same
commit - in design-e.css, lib/design.php or the shared helpers, not in one
course's files - and the rule goes into the file here that owns it.
