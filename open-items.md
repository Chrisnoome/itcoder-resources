# Open items

The backlog. Delete an item when it is done; add one with the date when found.
Details live in the linked files.

## Platform

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
  any pupil there. Switch off or restrict 8082 to Chris's IP while real names
  are in its database (publishing still needs a way to look at test).
- **Subscription purchase flow** - gating exists, dates are set by hand.
- **Google OAuth** - consent screen External; **Publish app** to lift the
  100-test-user cap; Branding URLs must match live.
- **API spend limit** - set one on the Anthropic workspace; no global daily cap.
- **Review voice** - the "evaluate my performance" review has only been read by
  Claude; read one against a real pupil's marks.
- **Marked code questions** - `code` blocks are unmarked by design; no scoring
  shape built.
- **Teacher dashboard: per-question view across a class.**
- **Confirm `ClassList()` labels** with Chris.
- Optional: log `SQLITE_BUSY` if it appears; parallel marking if the queue lags.
- PDF icon (`public/assets/icons/pdf.png`) was derived from `txt.png`; swap in
  a real one if found.

## Content

- **AI course restyle** - lessons are still v1's copy (no popups, reveals,
  mixed question types). Also worksheets, teacher pack, assessment weight,
  lesson 8 timing. See [courses/ai-course.md](courses/ai-course.md).
- **Pascal lessons 18-25** (18 testing/debugging/exceptions - being built by
  another chat; 19 dates and times; 20 array manager class; 21 inheritance and
  polymorphism; 22 text UI; 23 GUI; 24 practical exam; 25 PAT) - what each must
  cover is in [courses/pascal-course.md](courses/pascal-course.md), "Lessons
  still to come". Build only when Chris asks.
- **For the chat building lesson 18:** the SAGs check (23 Sep 2026) assigned
  testing and validation to it - see that plan (test data, trace tables,
  syntax/runtime/logic errors, debugger, validation checks, exceptions).
- **Theory course:** SAGs 4.2 data representation (binary, hex, bits,
  signed/unsigned, overflow, Real storage) belongs there, not in Pascal.
- Anonymous quotes (AI lessons 4, 5, 7) keep the question-mark placeholder
  portrait permanently, unless an attributed quote replaces them.

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
