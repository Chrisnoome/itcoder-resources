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
  **Picture activities - PAUSED mid-build 28 Sep (Chris shut down; resume
  here).** Chris chose: pilots in all four (IT Theory hardware, IT Theory
  networks, Pascal/Java IDE, databases); 1-2 extra labels that belong
  nowhere; hotspots built now with drag and drop; these before the
  memory-match picture top-ups. **Written, committed, NOT tested, NOT
  published:** `lib/picture.php` (both types: `labelpic` drag names into
  boxes, `hotspot` pins; zones in per cent; scored per zone like a match
  line), `public/api/picture-answer.php`, the lesson.php case, app.js
  `SetUpLabelPic`/`SetUpHotspot` (drag, tap, keyboard), style.css `.pic-*`,
  block icons `labelpic.svg`/`hotspot.svg`, and the wiring (content.php
  totals, whywrong, workanswers, pupil-work, review, check-why,
  check-figures, check-lesson-links, teacher.php). **Next:** (1) a sample
  block, rendered with the page harness and clicked through in headless
  Edge; (2) pilots - theory10 `insidecase` (label the motherboard, plus a
  hotspot), a network diagram (`whynetworks`/`commsdevices`),
  `databasesintro` (a table's parts), Pascal lesson 26 `ides` (a real
  Lazarus screenshot: ask Chris for ~30 s hands off, reuse the
  tools/excel-screens approach; NetBeans is installed for Java too); (3) a
  `bin/check-pictures.php` (zones inside 0-100, the image exists, boxes do
  not overlap, 1-2 extras); (4) platform.md block types and
  content-voice; (5) publish to test. The class-results subtotals,
  drill-down and "Below 50% in written work" are on test, not live.
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
  any pupil there. Switch off or restrict 8082 to Chris's IP while real names
  are in its database (publishing still needs a way to look at test).
- **Subscription purchase flow** - gating exists, dates are set by hand.
- **Google OAuth** - consent screen External; **Publish app** to lift the
  100-test-user cap (branding submitted for review 26 Sep 2026).
- **API spend limit** - set one on the Anthropic workspace; no global daily cap.
- **Review voice** - the "evaluate my performance" review has only been read by
  Claude; read one against a real pupil's marks.
- **Marked code questions** - `code` blocks are unmarked by design; no scoring
  shape built.
- **Teacher dashboard: per-question view across a class.**
- **Confirm `ClassList()` labels** with Chris.
- Optional: log `SQLITE_BUSY` if it appears. (Parallel marking done 25 September 2026 - platform.md decision 1.)
- PDF icon (`public/assets/icons/pdf.png`) was derived from `txt.png`; swap in
  a real one if found.

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
