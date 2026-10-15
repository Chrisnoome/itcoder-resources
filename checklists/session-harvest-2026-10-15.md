# Session harvest, 15 Oct 2026

Read-only sweep of Chris's non-archived desktop sessions before archiving. Method: read each session's transcript tail (last messages and last compaction summary) from `C:\Users\chris\.claude\projects\...`. Excluded as asked: the current session, Ebook processing, Audiobook processing, De la Salle exams, Sandra's grade 11 comparison, System maintenance. Also skipped as not course work: 14 Unity sessions (`D:\Unity projects\iac` and `pm`), Icon cutting and resizing, Extract text and quotes, Error log review.

Many Sept sessions end with "nothing committed or published"; their work has since gone out in later whole-tree publishes, so they are marked done. Several Oct 12-14 sessions ended on "You've hit your weekly limit" with Chris's last request unanswered: those are the main loose ends.

"Recorded" = found in `open-items.md` or a `courses/*.md` file. "NO" = not found by grep.

## Sessions with loose ends

| Session | Last activity | Loose ends | Recorded? |
|---|---|---|---|
| Site design alternatives and mockups | 12 Oct | Three requests unanswered (weekly limit): login-times heatmap tab (pupil + teacher view); per-teacher "gated" course setting, off by default; login page still says "itcoder". Dismiss-without-changing-marker and Remove course are committed but unpublished. | NO |
| General computing courses | 11 Oct | Chris said an eng10 "Do this" answer marked wrong was correct. Cause found: the checker is Jev-only, and an unsure Jev counts the idea as missing with no Claude fallback (breaks Jev-first rule). Not fixed. Text-window/example-mark work committed, live status unclear. | NO |
| English courses | 12 Oct | Chris's voice review of eng10 ("way too many AI tells", Spill post, quoted text in a box, not SA-teen) and "give the PowerShell to publish live" unanswered. Commits 1d60dba, 1715f9a, f7e90f5 not live. | partly (english-courses memory, no open item) |
| Video production | 11 Oct | Stopped for credits. Queue paused; take loops still run old code (mark videos done when nothing recorded); re-record Pascal 15.6, 18.1, 18.2, 18.3; Pascal 18.x exception-box step untested; `thumbs-java.json` / `thumbs-pascal.json` uncommitted; wait for Art chat "GPU free" before restarting voice servers; itcoder-cat VM left running. | NO (youtube-channels.md lists uploads only) |
| YouTube management | 11 Oct | Chris to delete old uploads (3Kh5JXDrJEE, PoP4TPoW0PM, sLMHjwsVgvM, plus GgEOY8EcL4A, W5p4d9uG0og, JwcwT3DLynQ, rrKfSqYQ6_U); recheck 7.2 public thumbnail; Chris sets `youtubeApiKey` (set-server-config.py); Monitor rebuild 4af915b unpublished; final comments report not given. | NO |
| Marking issues | 11 Oct | Daily-limit fix and limit of 150 waiting on a publish and setup. Question left open: how another chat's code reached live without the publish scripts. Alexandro's switch-and-hub answer still a draft (Chris may reply to him). | NO |
| Lesson corrections | 11 Oct | Unpublished: AI course agent-loop stepper pictures, lesson08 pics, `theory-tryit.js` picture support + CSS, `scores.php` My marks link, "View the log" button and token-limit fix (1500 to 4000). Offered, not asked: pictures for ~60 other processSteppers. Delphi GUI plan is recorded. | Delphi: yes; rest NO |
| Maths Lit courses (maths-lit) / Maths lit courses (manager) | 11-13 Oct | All 71 mlit10 lessons written, none published. Chris must test and publish; Maths Lit teacher review per batch open. | yes (courses/mlit10-course.md) |
| Graph-and-grid engine (Maths Lit) | 10 Oct | Follow-ups not done: keyboard-only drawing; `bin/check-jev.php` does not check graph hints for give-aways; no graph block in a real lesson yet. | NO |
| Art chat | 11 Oct | Rhino-print ControlNet tries (12) waiting for Chris's choice; Bot maze requests (36 rank emblems, 3 course icons) wait for the GPU; 21 Bot maze badges committed unseen. | queue: yes; rhino choice NO |
| Database planning: caps and sags (install-video work) | 4 Oct | Office/Access install video waits for Chris's M365 sign-in; Delphi install video needs his Embarcadero login; unload Qwen3 server (pid 67268); Office outcomes to record in AIResources; nothing committed. | Delphi: yes; rest NO |
| CAT course | 9 Oct | Phase B agents (Word, PowerPoint, Access, five Excel sub-agents): merge reports, run totals/upcheck/scrub; BakeryTV.pptx starter missing. | probably (courses/cat-practical-notes) |
| Site commercialisation | 10 Oct | Home-page scroller change committed, unpublished. Chris's own list: price plan "AI a month", move lesson 17 to Term 3, accountant, CIPC trade mark, publisher contract check. De La Salle IP letter (business/ IP acknowledgement .docx) written, awaits letterhead and signature. | Paystack/AI a month: yes; rest NO |
| Admin People + Courses and billing rebuild | 11 Oct | Nightly school-calendar cron goes up with next publish. Local test of gating etc. passed. | yes (open-items Operations) |
| Redraw labelled jokes in other courses | 12 Oct | Chris had said "not yet" to publishing the jokes, but the General computing session was deploying the whole tree; confirm that deploy was meant. | NO |
| Site review tool | 4 Oct | Teacher "Your IT periods" settings form and planner never checked in a browser (needs teacher sign-in). | NO |
| Compiler work preparation | 23 Sep | Code-evaluation questions to show a whole formatted program (lesson 7 "Does this compile?"); re-mark the 8 failed live answers; rotate the exposed secret. Fork-bomb TasksMax test is recorded. | TasksMax: yes; rest NO (may be done since) |
| Lesson 18: Error handling | 23 Sep | Waiting on Chris's answer about the validation-checks table (stays a Learn/Memorise box until then). | unclear (open-items line ~642 mentions validation) |
| Remediation strategies / Checklist | 1 Oct | Checklist items 13-16 (Habits) need a synchronised publish, then Chris works through the page; save/Copy report never tested in a browser. | NO |
| Course development research | 6 Oct | Add Jev to the site's AI usage log (`lib/jev.php`) so `costs-research.md` can replace "Jev: not costed". | NO |
| PAT marksheet grading (De La Salle, not platform) | 5 Oct | Moderation zip ready to upload; declaration date typos (Kata "04/10/20276", Gareth); stray .tmp downloads; "email declaration forms to the four pupils" asked. | n/a |
| Pascal assignment statement video | 26 Sep | Parked: "Left Gets Right" karaoke is really Match The Types; two versions of the song. | NO |
| Pascal debugging video brainstorm | 26 Sep | "Read and Think" parked, then embedded in lesson 4; rough spots listed in notes. | NO |
| Fix Windows 10 update date | 6 Oct | Past tense used before the programme ends (13 Oct); now correct. Not viewed in a browser. | n/a |
| AnyDesk alternatives | 4 Oct | Remote Control switch not found; no device added under Trusted devices. | NO (minor) |

## Done (nothing pending)

| Session | Last activity |
|---|---|
| English courses chat (delegates to English courses) | 11 Oct |
| Security chat testing (only encrypted backups left, recorded) | 28 Sep |
| Code review | 2 Oct |
| Case studies questions redraft (offer of more L3 questions to Sandra only) | 29 Sep |
| Lesson 6 basic maths (3 fixes committed, published elsewhere) | 28 Sep |
| Proofing and testing; Deployment (empty, "ready") | 28 Sep |
| Database backend music video; Music video on GUI design principles; Theory caps and sags content sharing; Pascal to Java course conversion | 27 Sep |
| Code commenting video ideas; Video ideas: decompose, analyse, problem solving; Karaoke lyrics parsing | 27 Sep / 6 Oct |
| Pascal procedures/functions video concepts; Pascal for loops video ideas; No Single Letters video; Lesson 10: For loops | 26 Sep |
| Cloud sessions explained; Lesson 5 input preparation; How AI Works fun activities; Pascal lessons 1 & 2; Pascal lesson 3 & 4; IT practice exams organization; Pascal course content audit; Marking latency optimization; Subscription limits and usage; Pascal course glossary and index | 24-25 Sep |
| Lessons 14-23 (14, 15, 16, 17, 19, 20, 21, 22 and 23) | 23-24 Sep |
| Matt Pocock skills setup (config drafted, never written; not needed) | 20 Sep |
| Lessons 11, 12, 13, 8, 9, pascal lesson 7; Interactive web console feasibility | 13-21 Sep |
| Pascal teaching website structure; Web course v2; AI Web Tutor; AI Marking house style | 10-12 Sep |

## Proposed open-items.md entries (unrecorded loose ends)

Source = session title.

**Platform**
- Login page still says "itcoder", should say BestLessons. (Source: Site design alternatives and mockups)
- Per-teacher "gated courses" setting in teacher settings, off by default; all that teacher's pupils then see gated courses. (Site design alternatives and mockups)
- "Login times" heatmap tab on the pupil activity page and in the teacher's view of the pupil. (Site design alternatives and mockups)
- Jev-only "Do this" checks (English helpers) must fall back to Claude when Jev is unsure, per the Jev-first rule; false "missing" results seen on eng10. (General computing courses)
- Add Jev calls to the AI usage log in `lib/jev.php`, then cost Jev in `costs-research.md`. (Course development research)
- Graph block: keyboard-only drawing; `check-jev.php` to catch hints that give the answer away. (Graph-and-grid engine)
- Daily-limit fix and per-pupil limit 150 await a publish and `setup.php`. (Marking issues)

**Security review**
- Find out how commit `b116c0b` reached live without its database step (only the publish scripts may upload). (Marking issues)
- Rotate the exposed secret noted in the compiler-work chat if not already done. (Compiler work preparation)

**Content**
- eng10 voice review (AI tells, SA-teen register, quotes in a box) and redeploy of example-answer marks and text-window changes. (English courses)
- Decide whether the validation-checks table in Pascal lesson 18 replaces its Learn/Memorise box. (Lesson 18: Error handling)
- Pictures for the other ~60 processSteppers; publish agent-loop stepper pictures and My marks link. (Lesson corrections)
- Left Gets Right karaoke video (wrong song file in folder) parked. (Pascal assignment statement video)
- Rhino-print ControlNet choice for the Maths Lit art. (Art chat)

**Operations**
- Video queue resume: restart take loops on current code, re-record Pascal 15.6/18.1/18.2/18.3, test the 18.x exception-box step, commit `thumbs-java.json`/`thumbs-pascal.json`, stop the itcoder-cat VM when CAT is done. (Video production)
- YouTube: Chris deletes the seven old uploads listed above; recheck 7.2 thumbnail; set `youtubeApiKey`; publish Monitor 4af915b. (YouTube management)
- Office/Access install video needs Chris's M365 sign-in; unload Qwen3 server. (Database planning: caps and sags)
- Business: letter for De La Salle to sign (IP acknowledgement); accountant, CIPC trade mark, publisher contract check; move lesson 17 to Term 3. (Site commercialisation)
- Publish pending commits (dismiss, Remove course, View the log, home scroller, mlit10) and confirm the joke redraw deploy was wanted. (Site design alternatives; Redraw labelled jokes)
- Check the IT periods settings form and the checklist page in a browser. (Site review tool; Checklist)
