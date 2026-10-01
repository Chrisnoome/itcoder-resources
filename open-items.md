# Open items

The backlog. Delete an item when it is done; add one with the date when found.
Details live in the linked files.

## Platform

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
    never in chat.
  - **Home page**: a landing page for visitors, a dashboard once signed in.
  - **Mark and correct** question type: to be discussed with examples first.
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
  `MatchMarkEarned()` (lib/content.php) gives every right line 1 mark once a
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
only to listed addresses (platform.md for each). Still open, most important
first:

- **Answer APIs check enrolment, not access** (`api/answer.php`,
  `typed-answer.php` and the other *-answer.php, `compile.php`,
  `cite-fetch.php`): a locked lesson's questions can be answered - and their
  answers revealed - by posting to the API. One helper: CourseExists +
  IsEnrolled + `AccessMode($p, $c, $lesson) !== ACCESS_LOCKED`.
  `study-notes.php` checks the course, not the lesson (`RequireCourseAccess`).
- **Attempts are not claimed atomically**: parallel requests all see
  attempts=0 - all options sent at once gives right-first-time marks, and one
  attempt can cost many AI checks. Claim first:
  `UPDATE ... SET attempts = attempts + 1 WHERE ... AND attempts = ?`, check
  rowCount. Same for the daily cap (`apiUsage`) and access-code `maxUses`.
- **Google sign-in** (`lib/auth.php` GoogleExchangeCode/SignIn): require
  `email_verified`, check `aud` = googleClientId and `iss`; once a googleSub is
  stored, refuse a different one (today it is silently re-bound).
- **Ban and "Free session" do not end a live session**: `CurrentPupil()` ignores
  `bannedAt`, and a NULL sessionId counts as free for anyone.
- **SQL marker prompt injection** (`lib/sql.php` ~1368): the pupil's query
  results and column names reach the marker outside `<pupil_work>` - fence
  them; keep pupil strings out of the "final" reason.
- **One user can exhaust PHP workers**: `practice-speech.php` waits up to 10 s
  for a whisper slot plus 15 s of work, per request, no per-person limit.
  One in-flight request per pupil, fail fast. No nginx `limit_req` anywhere
  (auth, api, /live/); no per-person limits on sql-run, compile, live-start.
- **Sandboxes** (`bin/compile-sandbox.sh`, `bin/live-sandbox.sh`): pupil code
  can reach host unix sockets (MySQL's is 777 - can use up its 30
  connections); add `RestrictAddressFamilies`, `InaccessiblePaths=-/run/mysqld
  -/run/dbus -/run/php`, `SystemCallFilter=@system-service`, the Protect*
  set, `PrivateDevices`, `LimitFSIZE`, `CPUQuota`; test Java; re-run
  sandbox-check.php.
- **Live console daemon**: `bin/live/runner.py` `recv()` takes any frame
  length from the sandbox (one program can OOM it and drop every session) -
  cap frames and `bytes_out`. Its user is in group www-data and **can read
  config.php and course.sqlite** (checked on the server; systemd exposure
  8.5) - add `InaccessiblePaths`, `ProtectSystem=strict` as the SQL runner has.
- **Backups unencrypted** and kept forever on Chris's PC/Dropbox (minors'
  data, POPIA) - encrypt on the server with `age` (public key), set a
  retention period. (Also under Operations.)
- **Low, together later**: CSRF - one Origin/Sec-Fetch-Site check for every
  non-GET (about 25 pages and every JSON API rely only on SameSite=Lax);
  sign-out by GET; `/\evil.com` passes the redirect filter (progress.php:28,
  notifications.php:21); `?note=`/`?flash=`/`?problem=` show any text; the
  access-code try count lives in the session; Practice XP and live-result
  `compileOk` are trusted from the browser; cite fetch: `FILTER_FLAG_GLOBAL_RANGE`
  and check `CURLINFO_PRIMARY_IP`; why-wrong hint has no OFF_TOPIC contract,
  review prompt no fence; hidden courses open by URL; `session.use_strict_mode`
  0; cron logs 644 with pupil emails (make 640); `/assets/` responses carry no
  security headers; fail2ban not installed; the install kit has no SSH
  hardening / fail2ban step; group membership gives Full access to every paid
  course (matters once teacher plans are sold).

## Content

- **Java course: open and live** (26 Sep 2026, Java in the live console -
  courses/java-course.md). For Chris: check the glossary's grades and
  plum marks (a script's first draft); IDE screenshots (lesson 3) and the
  NetBeans GUI-builder wording (lessons 24, 25, 28 - no IDEs on the testbed).

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

- **Re-point the backup task** (admin PowerShell), then delete the stand-in -
  [backups.md](backups.md).
- **Backup encryption** - [backups.md](backups.md).
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
