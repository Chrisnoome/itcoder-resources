# Open items

The backlog. Delete an item when it is done; add one with the date when found.
Details live in the linked files.

## Platform

- **Commercialisation - before selling** (4 Oct 2026; research in
  [payments-research.md](payments-research.md),
  [costs-research.md](costs-research.md),
  [market-research.md](market-research.md),
  [competitor-review.md](competitor-review.md),
  [pricing-suggestions.md](pricing-suggestions.md); business case page
  https://claude.ai/artifact/6aFcGpBj1QeGuzwVmdz1HT). Done: live limits
  US$50 a day / 60 a person (config); monthly AI budgets per plan, marking
  cache off, the CPA expiry notice (platform commit 88766d2, **waiting for
  Chris's publish**). Still to do: set each plan's "AI a month" in Admin >
  Billing once plans exist; a school's shared AI budget; checkout must make
  the parent the buyer and show the ECT Act s43 information; Chris: Paystack
  sign-up (sole proprietorship), an accountant (VAT, entity, imported-services
  VAT on Anthropic and Brevo invoices).

- **Site review fixes** (3 Oct 2026: a review of the local site as a slow pupil,
  a strong pupil and a teacher, in
  [checklists/site-review.html](checklists/site-review.html) /
  https://claude.ai/artifact/ExxFJJB53jssL88dY56Ae3). Chris's decision for
  most items: "everywhere" (every course, all pages). **Do:**
  1. A teachers' way in on the home and sign-in pages (Staff gets the pupil view today).
  2. Courses: the pupil's own grade first, the others folded.
  3. Join only where a course has free lessons; say "Locked" before Join.
  4. My account's "What you can use" matches the course page's locks.
  5. Courses uses the home page's subject cards.
  6. One "Start lesson 1" / "Continue: lesson N, part M" button on the course page.
  7. Top bar "Index" becomes "Look up" with an icon.
  8. "Test view" says what it does, inside the lesson.
  9. Bottom bar "AI: 0 of 100 today" in plain words.
  10. Time counters stayed at 0:00:00 while reading - check, fix or relabel.
  11. Home page cards: no scroll inside the scroll; SQL sub-headings per database.
  12. One lesson count everywhere ("25 lessons + 10 guides").
  13. Help page gets the standard top bar.
  14. Marking rules folded into an ⓘ; one action line per question.
  16. A right answer collapses the earlier "Why that is not it" hint.
  17. The spelling-hint pattern on every typed question type.
  19. Phone: lesson status under the name on the course page.
  20. Phone: quote portrait above the quote, normal weight.
  21. A Teacher home page (queries, messages, pupils behind, next due date).
  22. "Remove from class" as the normal action; real deletion behind a second step.

  **Built locally 3 Oct 2026, not published or committed** (backups in
  D:\itcoder-backups\site-review-fixes-2026-10-03): 4, 7, 8, 9, 10 (the
  counter worked - it was days:hours:minutes; now "3 h 42 min"), 12
  (CourseSizeText(); the course page's "0 of 30 lessons completed" still
  counts only lessons with questions), 13, 16, 19, 20. Not yet checked
  signed in: the lesson page, My account, Courses, the phone layout.
  Also built locally: 1 (home and sign-in link to teach.php), 2 (Courses: own
  grade first, "Other grades" folded; Subjects: own grade's box first and
  open - CourseFitsGrade()), 3 (CourseJoinable(), CourseJoinHtml() in
  lib/access.php; JoinCourse() refuses a course locked through and through),
  6 (CourseNextLesson() in lib/home.php: Start / Continue / Next). **Chris:
  with item 3, a pupil outside a school can join only the AI course until
  some lessons are marked Free** (Manage courses - e.g. each course's lesson 1).
  Third batch, built locally: 11 (home cards list 5 lessons + "N more", no inner
  scroll; SQL rows name their database), 14 (MarksNoteHtml() in lib/content.php:
  one action line, the marking folded under "How this is marked" - every
  question type and SQL), 17 (WhySpelling() in lib/whywrong.php: typed answers
  and typed picture boxes, no AI call), 22 (group.php: Remove is the main
  button; Delete goes to a second step naming the pupils, type DELETE). Also
  the signed-out home and features pages at lesson width (platform.md).
  Last batch, built locally: 5 (Courses as cards in the home page's look,
  HomeCourseLook()), 21 (TeacherHomeHtml() in lib/home.php at the top of a
  teacher's home page: queries and messages waiting, the term countdown,
  links to who is behind, class results, invite, planner). **All 20 built and
  on test and live (the whole-tree publishes of 3-4 Oct 2026) and committed:
  4dcf81f on expansion (4 Oct 2026, not pushed). Still uncommitted, inside other
  chats' unfinished work: the spelling hint for typed picture boxes (lib/whywrong.php,
  needs typed-picture questions) and the folded note on rule-marked typed answers
  (public/lesson.php, needs TypedRules()) - commit them with that work.
  **Not seen signed in yet:** Courses cards, the
  teacher panel, the lesson page (Look up, Test view note, folded marking,
  spelling hint, bottom bar), My account, the course page's button, the
  class page's delete step, the phone lesson list.

  **Left as is:** 15 (outline the wrong card in place), 18 (a fast lane for
  strong pupils). Not tried hands-on: the teacher pages (no test teacher
  account on localhost) and a paid course's lessons.

- **The server's own names still say itcoder** (3 Oct 2026, Chris chose to
  rename everything else - platform.md, "The site is BestLessons"):
  /var/www/itcoder, the itcoder-live and itcoder-sql services, sockets, logs,
  backups, the MySQL user, the compile sandbox and the install kit. Renaming
  them would be a planned server move with a short outage - only if Chris
  wants it. (Mail: decided 3 Oct 2026 - it comes from bestlessons.co.za,
  already set up in Brevo; platform.md, "Email".)

- **New tables read on every page need a deploy-window guard** (found 3 Oct
  2026: one lesson page hit "no such table: questionNotes" in the minutes
  before setup.php ran - harmless, the page carried on). lib/notes.php's two
  reads now return nothing until the table exists (live 3 Oct with phase 3).
  Any new table read by a page every pupil opens: the same.
- **Committed code calls functions that are not committed** (found
  2026-10-01 with `tools/undefined-calls.php`, platform.md "Checks to run").
  TypedRules() is called by commit 236431c (28 Sep) and defined only in the
  uncommitted typed-rules work in lib/content.php (MarkTypedByRules() and the
  rest, with bin/check-typed-rules.php); check-groups' "newcomer finds the
  waiting invitation" needs uncommitted invitation code. Live is fine
  (publishing uploads the working tree); the chat that owns each piece
  commits it. Delete when the staged-tree scan is clean.
- **Weighted mark ratio set by the teacher, per course** (Chris, 3 Oct 2026:
  "for all courses the teacher gets to set the weighted mark ratio - a teacher
  may get to teach more than one course ... default ratio change to 70
  written, 30 other. the weighted gauge must explain this ratio"). Now part
  of the **schools, cohorts and classes redesign** (Chris, 3 Oct 2026:
  schools with several teachers, a cohort per grade and subject split into
  named classes, a TIC who sets the weighting and the term lessons, subject
  x grade course checklists, year plans per subject, admin fixing,
  home-schooling parents as teachers, a pain-free wizard). Design with 9
  questions for Chris: https://claude.ai/code/artifact/6dea2b45-17ce-41b7-95a4-3f1b96b2ddd8
  - agreed 3 Oct (all 9 answered; schools-design.md). **Phase 1 built,
  reviewed (10 findings fixed) and LIVE 3 Oct ~07:05 SAST** (test then live,
  Chris's go-ahead with the new privacy wording; ALL STEPS OK both; live: De
  La Salle school, "Grd 10 IT" -> cohort Grade 10 IT 2026, IEB, Pascal, TIC
  Chris; no members yet). Chris, 3 Oct: messages and mark queries stay with
  each class's own teacher, not the TIC. **Phase 2 LIVE 3 Oct ~12:45 SAST** (test then
  live, Chris's go-ahead; ALL STEPS OK both; reviewed first - 13 findings
  fixed with Chris's rule "see work only after approval"; live: De La Salle's
  addresses split, students.dlshcch.co.za pupils / dlshcch.co.za staff).
  **Phase 3 (term marks) LIVE 3 Oct ~16:20 SAST** (test then live, Chris's
  go-ahead; ALL STEPS OK both; reviewed first, Chris's rule "show coverage,
  zero after term"; live: no term ticks yet, so the first real term end is
  the first live test of the zero rule). **Phase 4 (year planner per grade,
  school calendars) LIVE 3 Oct ~18:30 SAST** (test then live, Chris's
  go-ahead; ALL STEPS OK both; reviewed first, 13 findings fixed; live: De
  La Salle's one staff teacher, Chris, is its school admin). **Phase 5
  (Admin > Schools) LIVE 3 Oct evening** (test then live, Chris's go-ahead;
  ALL STEPS OK both; reviewed first, 8 findings fixed). All five phases of
  the schools design are live. Open: the privacy policy now says the site's
  admin can move a pupil between their school's classes - an attorney
  question in popia-checklist.md.
  **POPIA:** popia-checklist.md is a draft for Chris to take to an attorney
  before self-sign-up is opened to the public (operator agreement for
  schools, parental consent outside schools, Information Officer,
  cross-border);
  phases 3-5 (wizard, marks views, planner per cohort, admin Schools page) to build. Decided so far: default 70
  written / 30 other; the ratio in steps of 5%; the weighted dial says the
  ratio. Today WeightedPercent() (lib/content.php) is a fixed 50/50 with 11
  callers, the lesson badge tiers among them; a teacher's courses come only
  from their groups (no admin list).
- **Message my teacher, My progress for everyone, the menu, the query page,
  the music-video tab** - live 2 Oct 2026 21:2x-21:4x (Chris: "install gd
  and publish"; php8.3-gd installed, all steps OK), not committed. Still
  open: **free lessons** - only the AI course and 3 Pascal lessons are marked
  Free on live, so an unsubscribed pupil can open nothing else (mark more in
  Manage courses); **bin/check-notifications.php's guard** now refuses a
  server database (it ran once on live from a server check, inside its
  rolled-back transaction, nothing left behind) - live since 3 Oct.
- **Live is ahead of git: commit the refactor and the video page** (2026-10-02;
  Chris, 1 Oct 23:30: "publish live when ready, monitor the code review and
  publish that when its done"). Published to test and live 2 Oct 01:31-06:00
  (all steps OK): the Code review chat's modular refactor (lib/jobqueue.php,
  public/assets/itc-core.js, the markChanges table), the video's own page
  (lesson.php?watch=N; lib/videoquestions.php, videoq.js, videoq.css), the
  Mission: Algorithm swap (9ce1ab7) and the first 520 collectable pictures.
  None of the refactor or the video page is committed: 41 of the refactor's
  files are tangled with other chats' uncommitted hunks, and the video page
  needs itc-core.js. Chris decides how to commit (2 October: "leave it
  uncommitted" for now). Published again 2 Oct 05:18-06:10 (all steps OK, on
  Chris's word): the follow-ups too - archived groups hidden everywhere
  (TeachingLinkSql), form tokens on 13 more pages, one leaderboard rule,
  written work counted for whoever can hand it in (CanHandInWritten). Still
  uncommitted. Delete when committed.
- **Publishing over a busy line** (2026-10-02): with the home line full
  (OpenAudible downloading ~5 MB/s; ~500 ms round trips, 10% loss) the
  file-by-file upload took 2 hours a site and dropped mid-upload twice; a
  drop on live leaves it half-updated. Until Chris decides: pause big
  downloads before publishing. Proposed, waiting for Chris: vps.put_tree
  sends each folder as one archive, unpacked on the server only once it has
  all arrived (minutes on a slow line, never half-uploaded).
- **H5P rollout - Chris's decisions** (2026-10-01; committed fc36005, live with
  the evening publish). Theory 10: the satellite drawing says 550 km, media's prose says
  Starlink is about 500 km; the coaxial-cable photo shows a stranded core
  where the lesson says one copper core; lp24ExplorerParts' two extras are
  Finder's names; tl19ByteHistory has only 3 dates; mp22TextTrouble picture
  C uses a different message. Theory 11: webgrewup has 6 new activities
  (pc20Token the easiest to drop); the JPEG "before" is very blotchy
  (quality 5); g24Factors and g20Factors both sort know / have / are;
  mp27AtWork pairs a drone with "A UAV" before the drone identify question;
  lp28Pattern uses a dot that is not on the lesson's map. Theory 10-12: the
  motherboard explore and zoom before/after use Eagle's Shutterstock photo
  (licensed for this?); router-1.png is also a memory-match card; Grade 12
  has many two-group benefit/risk sorts; the colour-blind seat map is a
  simulation. Java: lesson 4 says it is enrichment but now has three marked
  activities; hsDefensiveWindow (lesson 19) uses lesson 24's window.
  Part 1: LeftStr/RightStr and StrUtils in Pascal lesson 13; the SQL B9
  slider cuts through a row; gCapsButtonsAccess teaches a tendency;
  lc38KotaParts tests a Good to Know box; tl30ChatHistory's dates are in
  margin notes; the Eagle icons in mp40. Delete each as Chris decides.
- **Level emblems: IT Theory 5 and 6 to redo** (2026-10-01): Laptop and
  Smartphone hide their device behind the medal; queue new seeds or a
  clearer prompt (comfyui-queue). The other 34 are live.

- **Lost work and lost second tries - repair after publishing** (Chris,
  2026-10-01; platform.md 6a, 6c, "Allow pasting"). Built and checked on the
  local testbed, waiting for Chris's synchronised publish. Then: (1) run
  `tools/fix-lost-work.py` (dry run), then with `--apply` - resets the
  Pascal answer cut at 4000 characters that has no query (pasting on, a
  bell) and gives back the 12 second tries spent on an identical answer;
  (2) answer the two open queries from the same pupil on Pupil queries:
  the cut program with **Reset the question** + **Allow pasting** ticked,
  and the lost second try (the script gives it back) with a reply saying so.
  Delete this item when done.
- **Remediation: flaw log, diagnosis, accessibility** (Chris, 2026-10-01,
  still being discussed; the reset built, live and verified on test 1 Oct;
  all of it live 1 Oct (reset, reading options, spelling concession, colour
  work, flaw log / Habits; committed b275418). Then (1 Oct) the pupil work page tabs, the class Habits tab and Remediation strategies: built and checked server-side; waiting for Chris's synchronised publish. Left:
  Chris to review the draft remedies; D5/E2/F4 have no evidence yet): the flaw codes, their draft
  remedies and the decisions are in [remediation.md](remediation.md),
  which wins over this summary. Record a pupil's habitual flaws
  per marked question, never shown to the pupil, and use the pattern to
  diagnose and suggest remedies. Draft flaw codes: A reading the question
  (misread, command word, ignores context, part answered), B completeness
  (left out, too little for the marks, lists not explains, no example,
  padding), C knowledge (fact, misconception, confused terms, vague
  language), D care (syntax, language, boundary slips, no checking,
  naming/layout), E effort (rushed by time+length vs class median,
  guessing, second attempt unused, copy-paste), F code problem solving
  (can't start, logic, no decomposition, trial-and-error). A flaw is a
  pattern at >= 25% of questions where it could occur, across >= 2
  lessons. POPIA: a pupil/parent may request the log, so notes stay
  professional; dyslexia info is special personal information. **Decided
  1 Oct:**
  - Tag written answers (AI, in the same marking call), code (compiler,
    tests, existing checks) and automatic signals (time, length, attempts).
  - Diagnosis suggests remedies to the teacher; the teacher assigns. No
    auto-assigned remedial work.
  - Dyslexia: any pupil may choose font, spacing, tinted background and
    read-aloud in My settings; only the teacher sets a spelling concession
    (theory spelling ignored, never keywords or identifiers).
  - Colour blindness: never colour alone (WCAG 1.4.1), Okabe-Ito palette,
    audit every page with CVD simulation.
  - **Reset a question** becomes a third outcome on Pupil queries (beside
    "The mark is correct" and "New mark"). Every reset - there and on
    pupil-work.php, which today deletes the row - **archives** the old
    answer, mark and flaw entries (teacher-only history) instead of
    deleting them; the question goes back to not done.

- **Question review** (2026-09-28): questions the hint writers found wrong or
  arguable - [question-review.md](question-review.md). Fix the wrong keys first.
- **Email addresses** for the gateway (Chris asked, 2026-09-28): noreply@
  (reply-to support@), support@, billing@, admin@, privacy@ (POPIA information
  officer), schools@, postmaster@, abuse@, dmarc@ - all may forward to one
  inbox. Then set supportEmail with tools/set-server-config.py mail.

- **H5P-style activities and the memory match** (Chris, 2026-09-28): "investigate
  h5p for their range of activities. lets brainstorm what can be added to
  lessons ... you will need to be able to generate the questions /
  activities", and a memory match for theory practice (term on one card, a
  picture on the other, several pictures per term, images from the Eagle
  library at `R:\Eagle\Eagle Image Library.library` - read its files
  read-only, never its API token). Nothing built yet. **Decided 28 Sep:**
  - Our own block types, not the H5P player: our look, marks into My marks
    and class results, written as data in the lesson files by a chat.
  - All of them in time: pictures (drag and drop on a picture, find the
    hotspot, picture hotspots), code and text (mark the words, drag the
    words), games (timed conversion drill, picture ordering), scenarios
    and video (branching dilemmas, questions inside the music videos).
  - Marked activities inside lessons, the game-like ones in Practice for XP.
    The memory match is a Practice (fun) game only, not a lesson block.
  - Pictures: everything in Eagle is licensed except some screenshots - ask
    Chris when unsure, especially photos. Our own drawings are preferred
    when they are clear enough, but use real-world photos and common icons
    too, because exams and tests show those, not ours.
  - Build order: the memory match first (it sets up the Eagle picture
    pipeline the picture activities reuse).
  - Marking: a mark per item (label, hotspot, word), keeping totals even.
  - The memory match is a standard fun activity in every course, like the
    other Practice games. Pascal and Java pair code snippets with what they
    are ("loop", "decision" ...).
  - 10, 20 or 30 pairs, from the lessons the pupil has done so far.
  **Memory match built 28 Sep** (platform.md, Practice): code cards for
  Pascal, Java and SQL, pictures for 84 IT Theory terms (Eagle icon packs and
  stock photos, own topology drawings). Still to do: pictures for the AI
  course, more theory terms (file types without their name on them, cloud,
  e-waste, pixel), then the lesson activity types in the order above.
  **Picture activities built 28 Sep** (`labelpic`, `hotspot` -
  lib/picture.php; platform.md block types). Tested end to end on the
  testbed (tap and drag, a wrong first try with its hint, the second try,
  reload, the teacher's view). Pilots in IT Theory 10: `insidecase` (label
  the motherboard, pic-motherboard.svg), `whynetworks` (find the devices,
  pic-network.svg), `databasesintro` (label a table, pic-db-table.svg),
  `ports` (find the ports on a real motherboard - Eagle K7NN70MX20T0A,
  cropped, pic-back-ports.jpg), and Pascal lesson 26 `ides` (`hsIdeWhere`,
  "where would you click": a real Lazarus 4.2 window from
  tools/ide-screens, 28 Sep). **Still to do:** the Java one (NetBeans is
  installed; tools/ide-screens shows the way), then the next types in the
  order above (mark the words, drag the words, ...), and the memory-match
  picture top-ups.
  **Decided 28 Sep (Chris: "you can also do code - have code like a class
  definition and label elements, etc. be creative in its use. lets complete
  h5p first"):** finish every H5P type before other work, in this order:
  1. Code and text: **label the code** (numbered parts of real code, drag the
     names on - class name, field, constructor, parameter...), **mark the
     words** (click every word - or line - of one kind; wrong clicks cost),
     **drag the words** (gaps in code or text, words from a tray), **label
     the output** (link each output line to the code line that printed it).
  2. The Java IDE picture (NetBeans).
  3. Practice games: timed conversion drill, picture ordering.
  4. Branching dilemmas.
  5. Questions inside the music videos: the video pauses at set times for a
     quick question, **marked** like any lesson question.
  Each type is piloted in 2-4 lessons (Pascal, Java, IT Theory); once all
  types are done, they are rolled out across every suitable lesson.
  **Step 1 built 28 Sep** (lib/codeq.php, public/assets/codeq.js,
  api/code-answer.php, bin/check-code-questions.php): all four types, tested
  end to end on the testbed (tap and drag, a sticky tray and edge scrolling
  for long code, a wrong first try with its hints, the second try, reload,
  right first time, the teacher's view). Nine pilots (content-voice §code and
  text activities lists them). Next: step 2, the Java IDE picture
  (tools/ide-screens/netbeans-ide.ps1 is ready; it needs Chris hands off for
  about 3 minutes - waiting for his go).
  **Step 3 decided 28 Sep (Chris):** a **conversion drill** in Practice for
  IT Theory 10-12 only - binary and decimal, hex and octal, storage units
  (not character codes) - run like the other games: 20 questions against the
  clock, XP per right answer and a speed bonus. **Picture ordering** in
  Practice: processes drawn as cards (booting up, fetch-decode-execute, the
  SDLC, an email's journey ...) and, for Pascal and Java, Parsons puzzles -
  the shuffled lines of a short working program, put in order (not
  timelines).
  **Step 3 built 28 Sep** (platform.md, Practice): the conversion drill and
  Put in order - tested on the testbed (keypad and typing, a wrong answer and
  a skip, the score; cards with pictures, a Parsons puzzle ordered and
  indented, half XP on a second check, the answer after three). Put in order
  uses the 49 IT Theory ordering questions (7 with pictures so far) and 10
  Parsons puzzles each for Pascal and Java. Still to do here: pictures for
  more of the sequences. Next: step 4, branching dilemmas.
  **Step 4 decided 28 Sep (Chris):** branching dilemmas are a **marked lesson
  block** - each choice point scores (best choice full marks, a reasonable
  one half, a poor one nothing) - played as a **story with 3-5 choices**: a
  short scene (a drawing where it helps), a choice, a new scene with its
  consequences, and one of several endings with feedback on the path taken.
  Topics: online safety, ethics and the law, programming projects (PAT) and
  workplace IT (an IT support day).
  **Step 4 built 28 Sep** (lib/dilemma.php, assets/dilemma.js,
  api/dilemma-answer.php, bin/check-dilemmas.php): four pilots - the parcel
  SMS (theory10 malware), the essay due tomorrow (plagiarism), the first
  week on the help desk (computercare) and the night before the PAT code is
  due (Pascal 27 and Java patieb, one shared story). Tested on the testbed: a
  reasonable path with its feedback, a replay on the best path (half marks),
  reload, the teacher's view. Next: step 5, questions inside the music
  videos - check first what the other chat's WatchForHtml() (style.css
  .watch-for) is for.
  **Step 5 built 28 Sep** (lib/videoquestions.php, assets/videoq.js,
  bin/check-video-questions.php): a quiz, typed or select question with
  `'videoAt'` pops up in the video above it (the other chat's watchFor is a
  separate, static list). Pilots: Programmers Are Clever (Pascal and Java
  lesson 1, 3 questions) and You gotta comment your code (Pascal 8, Java 9,
  3 each). Tested on the testbed: the player answers on its message channel,
  a seek past a question's time pauses it and shows the question, answering
  marks it, and Carry on watching puts it back. Not tested: a real play
  through (the hidden test browser may not autoplay) - check on test.
  **All five H5P steps are built.** Left: the NetBeans picture (step 2,
  waiting for Chris hands off), pictures for more ordering sequences, and
  the rollout of every type across suitable lessons.
  **Not published yet (28 Sep, late):** Chris asked for commit, push and
  deploy live. All of this chat's work is committed and pushed (H5P steps,
  second-attempt marks, naming checks, the dilemma look, the ComfyUI match
  cards). Before publishing, the whole working tree (other chats' uncommitted
  work too) was checked: every changed PHP and JS file lints, every check
  script passes, all 236 lesson pages and the main pages render with no PHP
  error. The permission classifier refused publish-test.py, so nothing went
  to test or live - Chris runs publish-test.py, looks at the test site, then
  deploy-live.py (publishing.md). The nginx hardening that held this back is
  finished (vps-access.md).
- **Decided 28 Sep (Chris), being built:** (1) second-attempt marks - fix (a):
  store which lines were right on the first try; they keep 2 marks, lines
  fixed on the second try get 1 (old answers, with no first try stored, keep
  their marks). (2) Naming checks before a program runs, Pascal and Java -
  keyword case, procedure/function/class/variable/parameter names - **stop
  the run** like the layout checks (console always; exercises from the lesson
  that teaches naming). **Built 28 Sep** (`naming` rule, lib/naming.php;
  pascal-house-style.md and java-house-style.md §2, live-console-design.md).
  (3) **Built 28 Sep** (lib/dilemma.php's look, tools/dilemma-art and
  tools/match-art; content-voice §dilemmas, platform.md memory match):
  Dilemmas get scene backgrounds, character avatars,
  phone and chat screens and pop-up screens; pictures made with ComfyUI
  (D:\ComfyUI App, models in D:\ComfyUIModels - Flux, Qwen-Image, Z-Image),
  **mixed styles for variety: realistic, cartoon like the No Single Letters
  characters, stylised, illustrated** - for the dilemmas and for better
  memory match cards.
- **H5P rollout - where it stopped (1 Oct 2026, Chris: "pause activites and
  publish live")**: part 1 is committed and live - 403 activities, Pascal
  complete; Java, SQL and IT Theory 10-12 stopped part-way (each lesson's
  finished blocks kept), the video questions part-way, five new dilemmas
  done (their pictures in comfyui-queue). Still to do: finish Java, SQL and
  Theory 10-12; the video questions; a second round for the six new types
  (sort into groups, picture choice and pairing, time line, explore, before/
  after - lib/moreq.php, pilots in the AI course); the NetBeans "where would
  you click" picture (the video VM's 'netbeans' checkpoint has NetBeans 31
  at C:\Program Files\Apache NetBeans; tools/ide-screens/netbeans-ide.ps1
  needs Shot.cs beside it - checkpoint the VM first and restore it after).
  16 video questions on another chat's uncommitted videos (theory10
  internet/urls/www, theory11 addressing/protocolswan, theory12
  cloudcomputing) are in the files but not committed - commit them with
  those videos.
- **Software simulations** (Chris, 1 Oct 2026: "we also need to look at
  software simulations for working with word, excel, access & powerpoint and
  file explorer"): not started - plan first (what a pupil does in each, how
  it is marked, real screenshots vs a drawn copy of the program), and ask.
- **Chris's list, 1 Oct 2026** (the H5P chat is working through it; the
  video items go to the install-videos chat). Decided the same day:
  - **Weighted mark** = written work 50%, other questions 50% - **the main
    mark everywhere** (pages, marksheets, exports), the total on a smaller
    line; a course with no written work: weighted = other questions. My
    progress: 4 dials, 2 x 2 - total, other questions, written, weighted.
  - **Achievements** per course (shared ones too: finished lesson 1, first
    answer, never fell behind, written answer champion ...), an achievements
    page (all badges in a grid, greyed until earned, the requirement under
    each; badges made with ComfyUI - juicy, colourful), linked from the
    bottom bar with a count. Also **XP levels and ranks, streaks with a
    streak freeze, weekly quests, a class goal and an opt-in leaderboard**.
  - **Typed answers with more than one part** (code, output, a sentence) get
    marks per part - a 4-mark answer is never only 0 or 4. Each rubric point
    is a yes/no **Jev** judgment (TypeSafe), and a point Jev is unsure of goes
    to Claude. The Jev key goes on the server with the prompting script,
    never in chat. **Built 1 Oct 2026** (`lib/jev.php` JevMarkTypedRules(),
    key set on live): Jev sure of every point marks alone; any unsure point,
    an answer talking to the marker, or no key, and Claude marks it all.
    The hook and an off-topic fix sit in `MarkTypedByRules()` in
    `lib/content.php` - still uncommitted with the typed-rules work; commit
    them with it. Jev's lines say only "Partly there." / "Missing, or not
    right." where Claude explains the point.
  - **Home page**: a landing page for visitors, a dashboard once signed in.
    Built 1 Oct 2026 (platform.md, "Home page"): landing A built from the
    subject list, dashboard C, and "Tell me when it opens".
  - **Mark and correct** question type (decided later that day): all four
    kinds - code (Pascal/Java), written theory answers, SQL queries, trace
    tables/output. The question and an answer are given; the answer looks
    like **handwriting on a written exam** (not for code and SQL). Always a
    **written** question with a rubric and room to write - code and SQL too,
    in a normal text box. The pupil's marking, fixes and reasons are **all
    marked by AI against the memo**.
  - **Badges**: glossy 3D game badges, **a different look per course**.
  - Next after the fixes: achievements and the game features.
  **Game part 1 built 1 Oct** (lib/achievements.php, public/achievements.php):
  27 achievements (each course gets the ones that fit - 276 badges in all),
  course XP on Practice's ranks, a streak with freezes, weekly quests, the
  class goal, the opt-in leaderboard, the toolbar trophy and pop-up. **Badge
  art waits for Chris** (1 Oct: "wait till i get home with a cooler for the
  gpu"): then run `python tools/badge-art/make_badges.py` with ComfyUI up -
  about 1.5 hours; stand-ins show until then. Queued, with the collectables
  and the course icons, in `comfyui-queue/` (`python tools/comfy-queue/run.py`
  lists it).
  - **Flowchart pictures**: open, with a Hide button, remembered per device.
  - **MySQL Try-it** fails on live ("not switched on"): the SQL runner was
    only installed on test - install it on live (check memory first).
  - **Videos** (install-videos chat): Explorer parts redone with file
    extensions showing (always); a video per browser (Edge, Chrome, Firefox)
    to always ask where to save; installers save to the right place; the
    first time Explorer appears, say what file name extensions are and link
    the Explorer set-up video; good file organisation in every video.
  - **New first lesson in Pascal and Java**: getting your computer set up to
    study programming - every set-up video for the course, Notepad++ for
    text files; no questions, no marks.
  - Fixes: the class marks Summary's close button; back from a lesson keeps
    the chosen class; every class marksheet opens the lesson marksheet when a
    lesson is clicked (a rule); code listings on phones (one letter per line,
    portrait and landscape); a typed two-try answer keeps the first entry to
    edit; 'Check with my teacher' on every question that lost marks; Java
    Copy to console names the file after the class; every whole program in
    both courses gets Copy to console; the written questions' warning block
    folds; memory match words shrink and wrap, a long press enlarges a
    picture (in the instructions); the bell gets Clear all, a sound and a
    shake while unread; check the site through a proxy and Tor.
  **Done 1 Oct:** MySQL Try-it on live (the SQL runner installed, vps-access.md);
  **proxy and Tor checked:** the site loads from abroad (fetched from a US
  network), DNS is right (A records only, no stray IPv6), and nothing on the
  server blocks proxies or Tor (no deny/geo rules, ports 80/443 open to
  all). But **not one Tor exit address has ever reached the server** - none
  of 1 405 in two weeks of nginx access and error logs, none in the firewall
  log - so Tor is filtered upstream by the host (Absolute Hosting): ask them
  whether they block Tor exits or proxy ranges. A school's web filter is a
  different thing: it shows its own block page; ask its vendor to class
  bestlessons.co.za and itcoder.co.za as Education.
- **Second-attempt marks under-count - FIXED 28 Sep** (fix (a):
  LineMarksEarned(), lib/content.php, from quizResponses.firstResponse; tested:
  a hotspot 7 right both times is 14 of 16, a match with 2 right both times
  and 1 fixed is 5 of 10, reload and totals agree). The old note: match and picture questions say "each line/part is marked on its
  own - 2 marks right first time, 1 if it takes the second attempt", but
  `MatchMarkEarned()` (lib/content.php, removed 1 October 2026) gave every right line 1 mark once a
  second attempt is used, even the lines that were right the first time (7
  parts right first time, 1 still wrong after the second try: 7 of 16, not
  14). Either store which lines were right the first time and mark them x2,
  or change the wording.
- **Rebrand to bestlessons.co.za** (2026-09-26): both addresses, one site
  (platform.md, "Two addresses, one site"). Done 26 Sep: logo files,
  lib/brand.php (on test), name servers ns1-4.mydnscloud.com with A records @
  and www -> 102.214.9.207 (Absolute Hosting DNS Manager), certificate
  (renewal dry run passed) and nginx 80/443 blocks - https://bestlessons.co.za
  serves the site; Google OAuth takes both redirects; both domains verified in
  Search Console and branding submitted for review; brand code live and the
  live console accepts both addresses. **Left:** Google's branding review
  result. Later: home
  page, terms and privacy text written for pupils outside De La Salle; the
  OAuth consent screen's app name (one name shows on both addresses).
- **The E look** (2026-09-25, live - platform.md decision 27): admin and
  teacher pages still have the old look; `?design=classic` (the old look for
  one browser) can go once nobody needs it.
- **Fork-bomb / `TasksMax=` test** - Chris runs it himself (the permission
  classifier refuses it); command in
  [compile-subsystem-design.md](compile-subsystem-design.md). Concurrency under
  a lockstep class burst is still unmeasured.
- **Readln and ReadKey under `--tty`** time out in `sandbox-check.php` (NOTE
  lines). No lesson depends on them.
- **Server locale unchecked** (2026-09-13): `FloatToStr`/`Format` printed a
  comma on the Windows testbed. Lesson 7 teaches the `TFormatSettings` fix and
  never asks pupils to predict the default. Check what the server prints.
- **Failed written answers from before 17 Sep 2026** (8, mostly AI lesson 1-2)
  - re-mark from `/admin.php` ("Re-mark all failed", "Retry failed reviews")
  if not yet done.
- **Dev login is on for the public test site** (8082): anyone can sign in as
  any of its 19 people (real addresses). Chris chose a password (28 Sep 2026):
  **Chris runs `tools/set-test-password.py`** (PowerShell:
  `& "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-test-password.py"`),
  then checks the live console still connects on test. Delete this item then.
- **Subscription purchase flow** - gating exists, dates are set by hand.
- **Google OAuth** - consent screen External; **Publish app** to lift the
  100-test-user cap (branding submitted for review 26 Sep 2026).
- **API spend limit** - set one on the Anthropic workspace (Console - Limits),
  e.g. US$50 a month. The site now stops itself at $5 a day (AiSpendGuard,
  platform.md), but only the workspace limit also covers a leaked key.
- **Review voice** - the "evaluate my performance" review has only been read by
  Claude; read one against a real pupil's marks.
- **Marked code questions** - `code` blocks are unmarked by design; no scoring
  shape built.
- **Teacher dashboard: per-question view across a class.**
- **Confirm `ClassList()` labels** with Chris.
- Optional: log `SQLITE_BUSY` if it appears. (Parallel marking done 25 September 2026 - platform.md decision 1.)
- PDF icon (`public/assets/icons/pdf.png`) was derived from `txt.png`; swap in
  a real one if found.

## Security review (2026-09-28)

A read-only review of the code, both live addresses and the server found no
SQL or shell injection and no way from pupil code to secrets. Fixed the same
day (in the tree, **not yet published**): the two admin-page XSS bugs (the
Delete confirm on Admin > Users never showed), `microphone=(self)`,
AiSpendGuard ($5/day, 200 calls/person), the style comment only with AI
marking, invitations join at once only for the teacher's school domains,
teacher deletes spare accounts with more than that teacher's groups, Resend
only to listed addresses (platform.md for each). Also fixed, 28 Sep: the
answer, compile and marking APIs refuse a locked lesson (`ApiRequireAccess()`,
lib/access.php) and study notes check the lesson; Google sign-in needs
`email_verified`, checks `aud`/`iss`, and refuses an address now held by a
different Google account; a ban or "Free session" ends the live session; the
SQL marker's pupil result is fenced.

**Not a problem after all (checked 28 Sep):** "parallel requests all see
attempt 1" and "one user can hold every PHP worker" - PHP's file sessions
(`session.save_handler = files` on the server) lock the session for the whole
request and the code never calls `session_write_close()`, so one account runs
one request at a time, and one-account-one-session stops a second session.
**If anyone ever adds `session_write_close()` to an answer or AI API, add a
per-pupil lock there first.** Many accounts from one address are still
possible: that is what the nginx rate limits (vps-access.md) are for.

**Server round, 28 Sep (Chris chose all four):** already on the SERVER for
both sites - the tightened compile and console sandboxes (shared; all
sandbox checks and both console smoke tests pass), the console daemon's frame
caps and hidden config (live daemon restarted, 10/10), server_tokens off,
cron logs 640; the rate limits are on the test block (live's blocks get them
at deploy-live.py). Copies of the old console files:
`/root/live-console-bak-2026-09-28` (delete once live has run a week). Built,
waiting for Chris: **encrypted backups** (backups.md, "Encryption").

**Chris, in this order:**
1. Look at test, then `deploy-live.py` - everything above goes live (with
   other chats' work in the tree). The compile sandbox is already shared, so
   don't leave it long (publish-test's warning).
2. `setup-backup-encryption.py` with the venv's Python (command in its first
   lines) - makes the key, asks you to keep a second copy, sets up the server,
   makes the first encrypted backup. Then `pull-backups.py --encrypt-existing`.
3. Then a chat updates `public/privacy.php` (the backups paragraph: the
   Dropbox copy is now encrypted and only the owner holds the key).
4. Choose how long local backups are kept (backups.md, "Not done").

Still open:

- **Low, together later**: CSRF - one Origin/Sec-Fetch-Site check for every
  non-GET (about 25 pages and every JSON API rely only on SameSite=Lax);
  sign-out by GET; `/\evil.com` passes the redirect filter (progress.php:28,
  notifications.php:21); `?note=`/`?flash=`/`?problem=` show any text; the
  access-code try count lives in the session; Practice XP and live-result
  `compileOk` are trusted from the browser; cite fetch: `FILTER_FLAG_GLOBAL_RANGE`
  and check `CURLINFO_PRIMARY_IP`; why-wrong hint has no OFF_TOPIC contract,
  review prompt no fence; hidden courses open by URL; `session.use_strict_mode`
  0; fail2ban not installed (SSH is key-only, so it would mostly quieten the
  logs); the install kit has no SSH-hardening step; group membership gives
  Full access to every paid course (matters once teacher plans are sold); a
  `/live/` handshake rate limit (the daemon's own caps hold for now).

## Content

- **Java course: open and live** (26 Sep 2026, Java in the live console -
  courses/java-course.md). For Chris: check the glossary's grades and
  plum marks (a script's first draft); IDE screenshots (lesson 3) and the
  NetBeans GUI-builder wording (lessons 24, 25, 28 - no IDEs on the testbed).

- **WHEN DELPHI IS RUNNING: Delphi GUI lessons, simulations and CAPS GUI
  tutorials** (Chris, 4 Oct 2026) - plan and trigger in
  [courses/delphi-gui.md](courses/delphi-gui.md). Ask Chris its four
  questions first.

- **Lazarus formats code - pictures, an IDE run and the video** (Chris, 9 Oct
  2026: "add a lesson to pascal - customizing how lazarus formats its code
  ... export a style file that they can import ... schedule a video on this
  as well"). BUILT 10 Oct 2026, not published: the guide
  `content/pascal/lazformat.php` (after Set-up) and its download, made by
  `tools/lazformat/make_cfg.py` - see platform.md, "Lazarus formats code".
  Still to do, in the video VM (checkpoint it first, restore after; its start
  was not allowed on 10 Oct 2026, so ask Chris to allow it):
  1. Copy the download over `%LOCALAPPDATA%\lazarus\jcfsettings.cfg` in
     Lazarus there, press Ctrl+D on the guide's messy tuck shop program and
     check the result matches the guide's second listing.
  2. Pictures for the guide: Source > JEDI Code Format, and Tools > Options'
     JCF Format Settings (Capitalisation, Spaces) and Codetools (Words,
     Space) pages - check the guide's names against them.
  3. The tutorial video: queued with the video-production chat (told 10 Oct
     2026); embed it in the guide once it is on YouTube.

- **AI lesson 9's isiZulu prompt** (1 Oct 2026) - written by Claude; a fluent
  speaker must check it (the lesson's `everySubject` card and its study
  block) before lesson 9 is published.

- **AI course restyle** - lessons are still v1's copy (no popups, reveals,
  mixed question types). Also worksheets, teacher pack, assessment weight,
  lesson 8 timing. See [courses/ai-course.md](courses/ai-course.md).
- **Pascal lessons 28+** (the CAPS tasks - proposal in [caps-tasks.md](caps-tasks.md),
  Chris to decide; 24-27 are BUILT and live) - what each must
  cover is in [courses/pascal-course.md](courses/pascal-course.md), "Lessons
  still to come". Build only when Chris asks.
- **For the chat building lesson 18:** the SAGs check (23 Sep 2026) assigned
  testing and validation to it - see that plan (test data, trace tables,
  syntax/runtime/logic errors, debugger, validation checks, exceptions).
- **Review and publish the syllabus gap additions** (built 25 Sep 2026 in
  lessons 1, 4, 7, 8, 12, 13, 14, 15, 16, 19 and 23 - list in
  [courses/pascal-course.md](courses/pascal-course.md), "Gap additions").
  The new glossary rows' grades are a first draft too.
- **CAPS PAT lessons:** the Grade 10 2026 theme ("technology and education")
  is only partly verified and the Grade 11 one ("Smart Restaurant Solution")
  from secondary sources - Chris to check against the DBE PAT documents
  (`content/pascal/capspat10.php`, `capspat11.php`).
- **Theory course:** plan and Chris's questions in
  [courses/theory-course.md](courses/theory-course.md) (25 Sep 2026). SAGs
  4.2 data representation (binary, hex, bits, signed/unsigned, overflow, Real
  storage) belongs there, not in Pascal.
- **IEB theory Paper 2s 2022-2025** (27 Sep 2026): Chris will add the papers
  and their memos to `AIResources/IEB`; then re-check Grade 12 lesson 27
  (`examieb`) against them - its layout wording is hedged until then
  ([courses/theory-review-queue.md](courses/theory-review-queue.md)).
- Anonymous quotes (AI lessons 4, 5, 7) keep the question-mark placeholder
  portrait permanently, unless an attributed quote replaces them.
- **CAT bundle pricing.** Grade 12 carries three years of content and Grade
  10 one, so the three CAT bundles need different prices. Deferred on
  purpose: the courses go up free for De La Salle pupils while real AI costs
  are tracked (`aiUsage`, Admin > Billing's per-person figures and monthly
  CSV), and prices are set from those. The `plans` rows wait on a number
  from Chris. (`courses/cat-course.md` §5 q33.)
- **Verify `mdbtools` against a real Grade 12 Access database** before the
  upload marker is built. It read the boards' own `.accdb` files cleanly
  during the CAT analysis - `mdb-tables` and `mdb-schema` both - but only
  the schema read is proven. Test queries, calculated fields and a
  relationship. `.mdb` is the documented fallback, at the cost of four data
  types the SAGs names (Large Number, Rich Text, Attachment, Calculated
  Field).
- **Check whether Microsoft's terms allow its UI screenshots to be
  redistributed in a paid course.** The five CAT application courses need
  3-10 screenshots a lesson. Worth settling before the first capture rather
  than after 500 of them.
- **Re-download the DBE's November 2023 CAT Paper 2 memo.** The file
  published under that name on the DBE site is a second copy of the 2023
  Paper 1 memo - different bytes, identical extracted text, both headed
  "P1", both carrying the P1 totals. The 2023 Paper 2 analysis in
  `cat-caps-exam-analysis.md` therefore rests on the question paper alone.

## Operations and housekeeping

- **Deploy order: new tables after new code** (2026-10-01). deploy-live.py uploads all of the code (step 3) and
  only then runs setup.php (step 6): for about 90 seconds on 1 Oct, pages that read the new pasteAllowed table
  failed (10 "no such table" errors in nginx's log, none after setup). Run setup.php right after lib/ and
  bin/ go up, before content/ and public/ - in both scripts, proved on test (publishing.md).
- **Re-point the backup task** (admin PowerShell), then delete the stand-in -
  [backups.md](backups.md).
- **Backup encryption** - built; Chris runs setup-backup-encryption.py
  (Security review, above; [backups.md](backups.md)).
- **`AIWebCourse` root:** two copies of the Google `client_secret_*.json` (live
  credentials, already in config.php) - delete; `student_emails.csv` (pupils'
  emails) - keep only if needed; `tools/__pycache__` - delete with the stand-in.
- **nginx `server_tokens off`** (the Server header shows the version).
- **Test site teardown** - only if publishing stops needing it:

      rm -rf /var/www/itcoder-v2-test
      rm /etc/nginx/sites-enabled/itcoder-v2-test /etc/nginx/sites-available/itcoder-v2-test
      nginx -t && systemctl reload nginx
      ufw delete allow 8082/tcp
      crontab -u www-data -l | grep -v itcoder-v2-test | crontab -u www-data -
      rm -f /var/log/itcoder-v2-test-marking.log /var/log/itcoder-v2-test-compile.log
      rm -f /etc/nginx/itcoder-test.htpasswd
