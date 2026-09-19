# Open items

The backlog for the whole itcoder project. Consolidated on 11 September 2026
from both chats. When you finish one, delete it; when you find one, add it with
the date. Details live in the linked files - this is the list.

## Cutover - done, 11 September 2026

v2 now runs at `/var/www/itcoder`, live at https://itcoder.co.za. Verified:
nginx and php8.3-fpm both active, landing page serves v2's multi-course copy,
`courses.php` redirects a signed-out visitor cleanly (302, no PHP error), no
real errors in the nginx log. The live nginx server block was left
untouched throughout - only the application code and database changed.

**How the database was actually handled, differently from the original
plan**: a real backup of v1's database was taken first
(`course-2026-09-11-212711.sqlite.gz`, verified). It held two real accounts
(Chris, and one genuine pupil sign-in, Tebatso Masetlane) - contrary to the
"no pupils have started" assumption this plan was written under. **Chris
explicitly said neither needed preserving**, so rather than migrating
`learners` to `pupils` in place, the database was deleted and recreated fresh
from `schema.sql` - zero rows in `pupils` now. The backup still exists if
that turns out to matter later.

**Still open, decoupled from cutover now that it's done:** the AI course port
and restyle - in progress, not pushed live. Full status in
[courses/ai-course.md](courses/ai-course.md) ("Where it lives now").

## Platform

- **Compile subsystem** for Pascal - **built 12 September 2026, not deployed.**
  `codeSubmissions` table, `bin/compile-sandbox.sh`, `lib/compile.php`,
  `bin/compilequeue.php`, two API endpoints and the `code` block type, with two
  blocks in `content/pascal/proofoflife.php` using it. Tested end to end
  locally; the sandbox itself re-validated against the live server, where it
  now also blocks reading `/var/www` (the lesson files, i.e. every quiz answer
  in the course - a hole the original design left open). Full write-up in
  [compile-subsystem-design.md](compile-subsystem-design.md). Settled while
  building: compiling is open to everyone signed in and enrolled, not gated
  like AI marking (Chris, 12 September 2026). Still open within it:
  - **Deployed to the test deployment (port 8082) on 12 September 2026** and
    verified end to end there, including through the cron worker. **Live is
    still untouched** - deploying it there is Chris's call; commands in the
    design file. Note it needs two privileged pieces a normal deploy does NOT
    install: the root-owned sandbox script at `/usr/local/bin/` and the
    `/etc/sudoers.d/itcoder-compile` rule (both already on the box, shared
    with live when it goes up), because `systemd-run` cannot be called by
    `www-data` at all.
  - **The fork-bomb / `TasksMax=` test**, for Chris to run directly - Claude
    Code's permission classifier refuses it even with Chris's authorisation
    (given 12 September 2026). Paste-ready command in the design file.
  - **Concurrency under a lockstep class burst** - still arithmetic, not a
    measurement.
  - **Marked code questions** - the block is deliberately unmarked for now.
    Two different scoring shapes, neither built; see the design file.
  - **Simulated input for Readln/Read - built 13 September 2026, for the new
    Input lesson, NOT yet validated against the real server.** A `code` block
    can now declare `'takesInput' => true` and gets a second box for what the
    pupil would type; `FrameSandboxStdin()` in `lib/compile.php` and the
    matching two-length-prefix read in `bin/compile-sandbox.sh` carry it down
    to the compiled program's own stdin. Proven against real fpc 3.2.2 on the
    local (unsandboxed) path - including reproducing the genuine "Read leaves
    the line's remainder for the next Readln to find, empty" trap. **The
    sandboxed path's own two-length framing has never been run through
    systemd-run for real** - re-test on `/var/www/itcoder-v2-test` before this
    reaches a pupil, and see compile-subsystem-design.md, "Simulated input for
    Readln/Read", for exactly what to check.
  - **ReadKey/KeyPressed under simulated input - open question, not answered.**
    Unlike plain `Readln`/`Read`, these are Crt calls expecting a real
    terminal in raw mode, not a line-buffered redirect. Whether `script`'s pty
    relaying (used for `--tty` mode's colour/cursor support already) makes a
    simulated keypress actually reach `ReadKey` the way a real one would is
    untested. `content/pascal/lesson05.php` deliberately does not offer a live
    `code` block claiming this works yet - teaches the two functions through
    quiz/typed/reveal instead, the way lesson 3 taught `Delay`/`Sound` as
    "compiles and runs here, but you cannot observe the real effect on this
    site." for now.
- **Study notes, performance evaluation and lesson bookmarks** - **built 13
  September 2026, not deployed anywhere.** Four things landed together
  (platform.md decisions 18-21):
  - a `study` block ("what to study") with a PDF of the same summary, written
    by a hand-rolled `lib/pdf.php` - on **every lesson of the Pascal course**
    (Chris asked for lessons 1 and 2, then for all of them, the same day),
    opt-in everywhere else;
  - an "evaluate my performance" panel on **every** lesson with questions, in
    every course, queued through `bin/markqueue.php`;
  - "carry on where you left off?", system wide;
  - an `important` block, used for the "programming is a practical subject"
    notice at the top of every Pascal lesson
    (`PracticalSubjectNotice()` in `lib/content.php`).

  Still open within it:
  - **Two new tables** - `lessonPositions` and `performanceReviews`. Any
    deployment needs `sudo -u www-data php <root>/bin/setup.php` run once
    after the upload, or the evaluate panel and the bookmark both fail on
    every page load. A normal file deploy does NOT do this.
  - **PUBLISHED TO LIVE, 13 September 2026 - test first, then live, both
    through the scripts in [publishing.md](publishing.md).** Live received
    everything at once: the compile subsystem (its four config settings, the
    `compilequeue.php` cron line and log), the three new tables plus
    `codeSubmissions.simulatedInput`, study notes, reviews, bookmarks, the
    shared masthead, Pascal lessons 1-7 in their new numbering, and the AI
    course (already opened on live earlier that day as a one-file change).
    Both runs ended ALL STEPS OK, and `tools/sandbox-check.php` passed against
    live's own code: real compiles, simulated input, the Crt terminal,
    timeouts, and no program able to read any site's config or lessons.
    Publishing to test first caught a real bug that would otherwise have gone
    straight to live: the new sandbox never passed `INPUT_LIMIT_BYTES` into
    its systemd unit, so every program read empty input
    ([compile-subsystem-design.md](compile-subsystem-design.md)). Still open
    from it: `Readln`/`ReadKey` under `--tty` time out - no lesson relies on
    either.
  - Tested end to end locally first: all three PDFs generated and read back,
    the review written for real through the API against a seeded "rushing"
    profile (both of Chris's rules fired), and the bookmark saved, offered,
    taken and cleared.
  - **A PDF icon had to be made.** `Logos and icons/` has csv, docx, txt, xlsx
    and zip but no pdf. One was derived from `txt.png` - same artwork, red
    badge - and saved to both that folder and
    `public/assets/icons/pdf.png`. Swap in a better one if there is a real
    one somewhere; nothing else needs to change.
  - **The register of the review's voice has only been read by Claude.** It
    tells a pupil plainly that they are rushing. Worth reading one against a
    real pupil's marks before a class sees it.
- **8 written answers on live failed marking before 17 September 2026** (7 of
  them AI course lesson 1-2, mostly `w1ExplainToGogo`) and 1 review. The fix
  is live (platform.md decision 23); Chris re-marks them from `/admin.php`
  ("Re-mark all failed", then "Retry failed reviews"). Sign out and back in
  first - older sessions do not get the Admin link. Their old failure reason
  is not recorded; any new failure's is.
- **Dev login is on for the public test site** (port 8082), so anyone who can
  reach it can sign in as any pupil there. Admin is now guarded against it,
  but the rest of the test site is not. Worth switching off, or restricting
  8082 to Chris's own IP, while real pupils' names are in its database.
- **Subscription purchase flow** - the gating exists (`subscriptionExpiresAt`,
  `CanUseMarking()`), but dates are set by hand; nobody can pay yet.
- **Google OAuth** - the consent screen is External and needs **Publish app**
  (non-sensitive scopes, no review) to lift the 100-test-user cap. The homepage,
  privacy and terms URLs in its Branding tab must match what is live.
- **API spend limit** - marking is gated and capped per pupil per day, but there
  is no global daily cap and no spend limit on the Anthropic workspace. Set a
  limit in the Anthropic console before real outside traffic.
- **AI course restyle** - opened to pupils on 13 September 2026 without it
  (Chris), so this is now polish rather than a gate: the eight lessons are
  still v1's copy - no `Gloss()`/`Aside()` popups, no `reveal` blocks, no
  mixed question types, no house-style deduction. Lesson by lesson, see
  [courses/ai-course.md](courses/ai-course.md).
- **Teacher dashboard: per-question view across a class** - seeing that 70% got
  the VRAM question wrong *before* teaching lesson 5. More useful than the current
  per-pupil view.
- **Confirm `ClassList()` labels** with Chris (`9C 9J 9R 9L Gr 10 Gr 11 Gr 12
  Staff Other`).
- Optional: log `SQLITE_BUSY` if it ever appears; parallel marking in
  `markqueue.php` if the queue ever lags.
- **Interactive Pascal console (asked for 18 September 2026, not started -
  Chris is doing it in a new chat, on the `next-work` branch in both
  `AIPascalCourse` and `AIResources`, because the changes are to the Pascal
  engine and may need reverting).** Brief, Chris's words: "change the pascal
  to an interactive console where readln works like a real program as well as
  now and random". Read that as: a `code` block gets a console where a pupil
  types at `Readln` while the program is running, like a real program, **as
  well as** the current fixed-input behaviour (`'takesInput' => true`, the
  second "What will you type when this runs?" box), not instead of it - both
  must keep working, since lesson 5 and lessons 10-12 use the fixed box.
  The last word, "random", is unclear from the message alone - most likely
  Random/Randomize output must also behave in the console (a fresh sequence
  each run), or a random-input mode; **ask Chris what he meant before
  building.** What the current code does, so the next chat does not have to
  rediscover it:
  - The compile and run steps share ONE stdin pipe inside a single
    `systemd-run` unit (the binary lives in that unit's private `/tmp`), so
    source and simulated input travel together, each announced by its byte
    length. `FrameSandboxStdin()` in `lib/compile.php` and the matching read
    in `bin/compile-sandbox.sh` must always change together.
  - A `code` block runs to completion and shows a finished result; there is
    no live session. A truly interactive console needs a long-lived process
    the browser can talk to (WebSocket or long-poll), which the queue and
    cron worker design (`bin/compilequeue.php`) does not have.
  - `sandbox-check.php` reports `Readln` and `ReadKey` under `--tty` as
    NOTE lines that time out (`Session terminated, killing shell`) - that is
    the behaviour a live console has to get past. The Crt virtual terminal
    (80x25, real DOS colours) already exists for output.
  - Limits today: 5-second run, 64 KB output, 128M memory, one compile in
    flight per pupil (`CompileLimits()`). A console that waits for a person
    typing needs a different clock - an idle limit and an overall cap.
  - The sudoers rule allows exactly two forms of the sandbox call (no
    arguments, and `--tty`); a new argument needs Chris.
  - **A sandbox change on test is a sandbox change on live** (shared
    installed script), and the fork-bomb / `TasksMax=` test still needs
    Chris to run it himself. Publish via `publishing.md`, test first.

## Content

- AI course: **worksheets** (one page a lesson - VRAM and cost sums, demo
  observation, debate prep); **teacher pack** (demo run sheet with exact
  commands, answer key, fallback if a demo dies); **assessment weight** (marked or
  enrichment; is lesson 8 a test); **lesson 8 timing** (four videos plus a 5-mark
  capstone in one period).
- Pascal: **lesson 8 onward.** Lessons 1-7 are now written - lesson 6
  ("Processing - basic maths") and lesson 7 ("Type conversion") both landed
  13 September 2026, in addition to the lessons 1-5 renumbering from earlier
  that day. Both have their own content-summary section in
  [courses/pascal-course.md](courses/pascal-course.md). Note that a new
  lesson is not finished until it has a study block.
  - **`FloatToStr`/`StrToFloat`/`Format` are locale-dependent - found 13
    September 2026, verified on the Windows testbed only.** `FloatToStr
    (49.9)` and `Format ('%.2f', [49.9])` both genuinely printed a comma,
    not a point, and `StrToFloat` genuinely crashes on the wrong symbol for
    the machine. The **server's locale has never been checked**, so whether
    a live pupil would see a point or a comma by default is unverified.
    Lesson 7 (`content/pascal/lesson07.php`, "Real and String" section)
    teaches the genuine comma output honestly labelled "on this course's
    own dev machine," then teaches the actual fix Chris asked for -
    `DefaultFormatSettings` copied into a `TFormatSettings` variable,
    `DecimalSeparator` overridden, passed as an extra argument - verified
    genuinely forcing a point on that same comma-locale machine regardless
    of the OS setting. No quiz asks a pupil to predict the default
    separator, only the fix. `TFormatSettings` also governs date formatting,
    flagged in the lesson as relevant again once a dates lesson exists.
- **Three quote portraits not in the corpus - resolved 2026-09-13.** Deming
  (AI lesson 6), Ken Olsen (AI lesson 8) and this second Wirth quote (Pascal
  lesson 2, "Algorithms + Data Structures = Programs" - distinct from the
  Feynman-adjacent one already paired elsewhere) were genuinely absent from
  `word documents/_ALL_QUOTES.docx`. Sourced instead from Wikimedia Commons,
  each confirmed free for commercial use before downloading: Deming (FDA,
  public domain - US government work), Olsen (public domain - published in
  the US pre-1989, no copyright notice), Wirth (photographer Tyomitch's own
  work, released for any use including commercial redistribution and
  modification). Cropped to a 256px square centred on the face and saved to
  both `public/assets/quotes/<person>.png` and this folder's `Quote images/`
  as the source copy - see each lesson file's own docblock for the exact
  Commons filename.
- **The three genuinely anonymous quotes** (AI lessons 4, 5, 7 - "RAM
  /abr./...", "The cloud is just...", "If you're not paying...") have no
  author to find a portrait of. They now show the same question-mark
  placeholder, permanently - the alternative is swapping in a different,
  attributed quote for that spot if a real portrait is wanted there instead.

## Operations and housekeeping

- **Re-point the backup task** - one admin PowerShell command, then delete the
  stand-in ([backups.md](backups.md), "One loose end").
- **Backup encryption** - plain gzip, a copy in Dropbox outside South Africa.
  Encrypt before the pull, or choose a destination in South Africa
  ([backups.md](backups.md)).
- **Two copies of the Google `client_secret_*.json`** in the `AIWebCourse` root.
  Live credentials; the values are already in `config.php`. Delete both.
- **`AIWebCourse/student_emails.csv`** - pupils' email addresses. Keep only if
  something needs it.
- **`AIWebCourse/tools/__pycache__`** - left by testing; delete with the stand-in.
- **Tear down the `/var/www/itcoder-v2-test` deployment** once nobody needs it -
  its own database, its own nginx server block on port 8082, its own crontab
  line and `ufw` rule ([vps-access.md](vps-access.md), "What is on the
  server"). Doesn't touch the live site, but no reason to leave it running
  once testing is done:
  ```
  rm -rf /var/www/itcoder-v2-test
  rm /etc/nginx/sites-enabled/itcoder-v2-test /etc/nginx/sites-available/itcoder-v2-test
  nginx -t && systemctl reload nginx
  ufw delete allow 8082/tcp
  crontab -u www-data -l | grep -v itcoder-v2-test | crontab -u www-data -
  rm -f /var/log/itcoder-v2-test-marking.log
  ```
