# AIResources - router

Chris's course platform (bestlessons.co.za; the old itcoder.co.za still works) and its course-development resources.
This folder is the source of truth: current state only, history in git and `history.md`. This file is a router: read the file your task needs (table below), not everything.

## Rules for every chat

1. **This folder wins** over a project README, code comment, memory or older chat. Fix whichever is wrong.
2. **Record decisions here**, in the right file, with the date Chris made them. Write the rule as it now stands (replace, don't append history). Also add one line to the end of `history.md` for every rule, style or engine change (not for new lesson content). Append only; read it only to learn why something changed.
3. **No secrets** (say where they live) and **no pupils' personal data**. Date facts that go stale (server specs, prices).
4. Write for the next chat, which knows nothing: say why, not just what.
5. Other chats may be editing the same files: make small, exact edits and never overwrite work you did not read.
6. **Ask when anything is unclear**, before building, about every choice that would change what gets built (Chris, 27 Sep 2026). Every question goes through AskUserQuestion with the recommended option first, never as text at the end of a reply (Chris, 1 Oct 2026). If Chris dismisses the questions, stop and wait.
7. **Keep off C: on Chris's PC** (low on space; Chris, 28 Sep 2026). VMs, videos, downloads, models, caches, renders and growing scratch files go on D: or E:. Set a program's own data or download folder to D:/E: when it would default to C:.
8. **ComfyUI pictures go through the queue** (Chris, 1 Oct 2026): add a request to `comfyui-queue/README.md`, show a stand-in on the site until the picture exists, and never run ComfyUI unless Chris says the GPU is ready.
9. **Jev first, wherever practical, in marking and everywhere in a course** (Chris, 6 Oct 2026: permanent for all course development). A quick yes/no, choice or score about a pupil's words (a marking point, an idea there or not, a term right, an own-words check, what a reply means) goes to Jev (TypeSafe, `lib/jev.php`) first. Claude handles only what Jev is unsure of, judgment, and writing feedback. Give written questions `points` Jev can mark; keep `rubric`/`markerRubric` for what needs Claude. A marking brief has checks for Jev and notes for Claude (platform.md, "Marking notes"). Always cost Jev's use.
10. **Finish with a question and spend no tokens idling** (Chris, 9 Oct 2026). When work is done, end the turn with AskUserQuestion so a yellow dot shows. Run no loops, wake-ups, monitors or polling that are not needed now, and stop a background run once its answer is in.
11. **One look for every course** (Chris, 25 Sep 2026). A new course keeps the E look (platform.md decision 27): lesson pages come through `public/lesson.php`; its own pages call `DesignHeadHtml()` and `DesignBodyAttr()` (lib/design.php); extra CSS goes under `body.design-e` using design-e.css tokens, never a separate stylesheet. It also keeps the content rules in `content-voice-and-pedagogy.md` (margin doodles and "Did you know?" notes, boxed captioned figures, code hints with no code, the whitespace check) and South African English (`writing-style.md`). A design change for one course is made for all, in design-e.css, lib/design.php or shared helpers, in the same commit.
12. **Every course gets a glossary, an Index and Fun practice**: `content/<id>/glossary.php` (or `glossaryFrom`) plus its own lobby symbols in `PracticeHeroGlyphs()`. Check with `bin/check-glossary.php`.
13. New courses go straight to 'open' or 'soon', never 'draft'; progress gated, own art style, own level names, margin extras (see memory). Course chats work in `Projects/<name>` with a `CLAUDE.md` pointing here (copy `Projects/AITheory`'s); the course also gets a file in `courses/`.

## Where things live

| What | Where |
|---|---|
| Platform code (all work) | `Projects/AIPascalCourse` -> `/var/www/itcoder` |
| Old v1 site (frozen, AI-course source only; never deploy it) | `Projects/AIWebCourse/itcoder` |
| Pupil backups (personal data) | `Projects/AIWebCourse/backups` |
| Secrets | `config/config.php` per project; server key `C:\Users\chris\.ssh\gnomemedia_vps` |
| Course research for other subjects | `Projects/itcoder-coursedev` |
| Git remotes | `Chrisnoome/itcoder-platform` (AIPascalCourse), `Chrisnoome/itcoder-resources` (this folder) |

## Read on demand

Paths are relative to this folder. For platform.md (235 KB) never read it whole: grep the heading, then read that range.

| Task | Read |
|---|---|
| Publish to test or live | `publishing.md` first (tools: `tools/publish-test.py`, `tools/deploy-live.py`) |
| Touch the server, run commands or uploads | `vps-access.md` (`tools/vps.py`) |
| Database, backups, restore, Dropbox pull | `backups.md` |
| Backlog, what is open | `open-items.md` (`grep -n '^## ' open-items.md`: Platform, Security review, Content, Operations) |
| Why a rule changed | `history.md` (append only) |
| Platform purpose, stack, architecture | `platform.md`: `grep -n '^## \(What it is\|Stack\|Architecture\)' platform.md` |
| Decisions that must not be undone | `platform.md`: `grep -n '^## Decisions that must not' platform.md` (read before changing design, engines, question types) |
| Marking, sign-in, privacy (load-bearing) | `platform.md`: `grep -n '^## Sign-in, marking' platform.md`; also `grep -n 'Marking notes' platform.md` |
| Keys, accounts, local testbed, checks | `platform.md`: `grep -n '^## \(Keys and accounts\|Local testbed\|Checks to run\|Before a demo\)' platform.md` |
| Page layout, game/collectables, Practice word games | `platform.md`: `grep -n '^## \(Page layout\|The lessons as a game\|Practice\)' platform.md` |
| Progress, planner, teacher tools, pupil queries, settings | `platform.md`: `grep -n '^## ' platform.md` and pick (Year planner, Progress, Teacher settings, School and teacher settings, Message my teacher, Access/onboarding, image bank) |
| Guided try-its, step gates, sequential courses; stream-only; grades/chapters/board sections | `platform.md`: `grep -n '^## \(Guided try-its\|Stream-only\|Grades, chapters\)' platform.md` |
| Lazarus code formatting | `platform.md`: `grep -n '^## Lazarus formats' platform.md`; `tools/lazformat/` |
| Lesson prose, voice, pedagogy, lesson checklist | `writing-style.md`, `content-voice-and-pedagogy.md` |
| English HL lessons | memory "English lesson voice"; `platform-english-helpers.md` |
| Writing or reviewing code | `pascal-house-style.md`, `java-house-style.md` |
| Marking practicals and code submissions | `marking-house-style.md` |
| Pascal compile sandbox; SQL runner; live console | `compile-subsystem-design.md`; `sql-runner-design.md`, `sql-dialects.md`; `live-console-design.md` |
| Syllabus, SAGs, CAPS | `sags-topic4-syllabus.md`, `sags-2025.md`, `caps-2024.md`, `caps-tasks.md`; CAT: `cat-caps.md`, `cat-sags.md` |
| Exam analyses (practical, theory, CAT) | `ieb-` and `caps-practical-exam-analysis.md`, `ieb-` and `caps-theory-exam-analysis.md`, `cat-*-exam-analysis.md` |
| A specific course | `courses/<course>.md` (ai, pascal, java, sql, theory, delphi-gui, install-videos, tutorial-videos, plus yearly-update files for stale facts) |
| New subject research | `course-development.md` |
| Schools, cohorts, classes, teachers | `schools-design.md`, `platform-roadmap.md` (subscriptions, payments, landing page), `home-page-design.md` |
| Privacy law (POPIA) | `popia-checklist.md` |
| Art for a course, logos, YouTube | `brand/<course>-art-style.md`, `brand/bestlessons/README.md`, `youtube-channels.md`, `comfyui-queue/README.md` |
| Real program screenshots | `tools/sim-screens/README.md` (VM first; hands off the keyboard while it runs), `tools/access-screens/`, `tools/ui-screens/` |
| Year planning, school calendars | `planning/README.md` |
| Checklists, remediation | `checklists/`, `remediation.md`, `remediation-checklist.md` (publish as OK / Needs-fixing pages) |
| Market, pricing, costs | `market-research.md`, `pricing-suggestions.md`, `costs-research.md`, `payments-research.md`, `competitor-review.md` |
| Workflow and manager setup | `workflow-plan.md` |

## Manager rules

Agreed with Chris, 15 Oct 2026 (`workflow-plan.md`).

- The main session is a manager on Opus 5.5, medium effort: it plans, routes, checks and makes small edits. Bulk reading, builds and bulk edits go to subagents or side sessions. Model is fixed per session because the cache is per model; effort may change mid-task.
- Before delegating, route model and effort through Jev; below 0.6 confidence Claude decides. Details: see `.claude/agents` and `tools/jev-route` (being built). The key lives in the user env var `TYPESAFE_ROUTER_KEY`, never in chat or the repo.
- Helpers are `helper-haiku`, `helper-sonnet`, `helper-opus`, `helper-fable` in `.claude/agents/`.
- A subagent gets a scoped brief and returns a summary, never file dumps. Because it knows nothing else, state the goal, what is ruled out, and the files to read.
- One task per session. `/clear` between unrelated tasks, `/btw` for side questions.
- After two failed corrections, `/rewind` instead of arguing.
- Compact by hand at a natural break, with a keep-list, before the meter goes red (amber 40%, red 60%).
- Before a break of more than an hour, `/compact` or `/clear`: the cache goes cold and resending is costly.
- A rule that must always hold becomes a hook, not prose.

# Compact instructions

When compacting, always keep:

- the current task and its done-criteria;
- decisions made with Chris this session (with dates), and any rule he stated;
- every file path touched or about to be touched;
- open questions and pending approvals (anything waiting on Chris);
- running or queued background work (VM jobs, ComfyUI requests, publishes) and where its output is.

Drop file dumps, long tool output and exploration that led nowhere.
