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
  - **On the test deployment since 13 September 2026; live still untouched**
    (`/var/www/itcoder` has no `lib/pdf.php`). Only `lib/`, `bin/`, `content/`
    and `public/` were uploaded, never `config/` or `data/` - that keeps the
    test deployment's own hand-written config out of range entirely, rather
    than copying it aside and putting it back the way the compile deploy had
    to. Both new tables created there, both sites still serving 200. The
    existing `markqueue.php` cron line now writes reviews as well; it needed
    no crontab change.
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
- **Subscription purchase flow** - the gating exists (`subscriptionExpiresAt`,
  `CanUseMarking()`), but dates are set by hand; nobody can pay yet.
- **Google OAuth** - the consent screen is External and needs **Publish app**
  (non-sensitive scopes, no review) to lift the 100-test-user cap. The homepage,
  privacy and terms URLs in its Branding tab must match what is live.
- **API spend limit** - marking is gated and capped per pupil per day, but there
  is no global daily cap and no spend limit on the Anthropic workspace. Set a
  limit in the Anthropic console before real outside traffic.
- **Teacher dashboard: per-question view across a class** - seeing that 70% got
  the VRAM question wrong *before* teaching lesson 5. More useful than the current
  per-pupil view.
- **Confirm `ClassList()` labels** with Chris (`9C 9J 9R 9L Gr 10 Gr 11 Gr 12
  Staff Other`).
- Optional: log `SQLITE_BUSY` if it ever appears; parallel marking in
  `markqueue.php` if the queue ever lags.

## Content

- AI course: **worksheets** (one page a lesson - VRAM and cost sums, demo
  observation, debate prep); **teacher pack** (demo run sheet with exact
  commands, answer key, fallback if a demo dies); **assessment weight** (marked or
  enrichment; is lesson 8 a test); **lesson 8 timing** (four videos plus a 5-mark
  capstone in one period).
- Pascal: lessons 3 onward. **"Proof of life" is built** (not just discussed -
  see [courses/pascal-course.md](courses/pascal-course.md)), still awaiting
  only a final lesson number.
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
