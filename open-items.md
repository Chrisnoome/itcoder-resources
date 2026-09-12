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

- **Compile subsystem** for Pascal - `code` block, compile queue, sandboxed worker,
  API endpoint. Sandbox design tested and validated against the live server,
  11 September 2026 - see [compile-subsystem-design.md](compile-subsystem-design.md).
  Nothing built yet. Still open within it: fork-bomb/`TasksMax=` behaviour
  (blocked by Claude Code's own permission classifier, needs a chat or Chris
  authorised to run it directly), output-size capping, concurrency under a
  class burst, and whether compiling is gated like AI marking or open to
  everyone signed in.
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
- Pascal: lessons 3 onward; the "Proof of life" lesson (in discussion - don't
  build until Chris confirms).
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
