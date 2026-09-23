# History - append only

Rule, style and engine changes, one line each, oldest first. Not lesson
content. **Append to the end; never edit or delete a line.** Not loaded into
chats - read it only when asked why something is the way it is. The full
detail is in this folder's git history (snapshot `46383a3` holds the long
pre-compaction files).

## 2026-09

- 09-10 Server upgraded to 4 vCPU / 3.9 GB / 77 GB.
- 09-11 AIResources made the source of truth; v1 chat handed over to the platform chat.
- 09-11 v2 (multi-course, `pupils`/`enrolments`) replaced v1 live; database recreated fresh.
- 09-11 Root SSH key-only. Sign-in open to any Google account; AI marking limited to school pupils and subscribers.
- 09-11 Rules: say "pupil"; no odd mark totals; quiz/typed marks doubled for two attempts; `typed` block added.
- 09-11 Code questions graded for layout as well as correctness: flat 1-mark deduction, only for what has been taught.
- 09-11 Compile sandbox design proven: systemd-run DynamicUser (bubblewrap blocked).
- 09-12 Compile subsystem built: queue, sandbox via sudo, `code` blocks unmarked, open to all enrolled pupils.
- 09-12 `InaccessiblePaths=/var/www` added after a pupil program could read lesson files.
- 09-12 Layout check before compiling: only what fpc accepts, only what has been taught.
- 09-12 Virtual DOS terminal (pty via `--tty`) for Crt programs.
- 09-12 Marking at temperature 0; marker shown the broken original; strict code-marking prompt.
- 09-12 First-attempt celebrations; YouTube `referrerpolicy` fix; shown marks = awardable marks.
- 09-12 Band rubrics (markMax >= 10, `showRubric`) with per-criterion breakdown; `match` scored per line.
- 09-12 Marking worker loops through the minute (pick-up ~0.3s).
- 09-12 Private GitHub repos for both folders.
- 09-13 Publishing only through publish-test.py then deploy-live.py (sandbox hash gate).
- 09-13 Study block + PDF on every Pascal lesson; "evaluate my performance"; server-side bookmarks; `important` block.
- 09-13 Shared masthead function; pinned masthead; "Lesson contents" dropdown; one `contents` block per lesson made a rule.
- 09-13 Simulated input for Readln (`takesInput`), length-framed stdin.
- 09-13 Rules: never "house style"/"convention" to pupils; pupil text for a 15-year-old beginner; `markerRubric`; shown rubrics never give the answer; blanks hide about half the letters; one instruction per line.
- 09-13 Lesson ids kept when lessons were renumbered (ids are database keys).
- 09-13 AI course opened live without the restyle.
- 09-17 Structured-output marking, failed answers handed back, `/admin.php` for the admin only.
- 09-17 Marking accepts any valid option or working route; feedback shape with "Where you lost marks".
- 09-17 Written prompts must say what to cover and what to avoid.
- 09-17 Rules: no Unicode `>=`/`<=` and code-font ligatures off; banned "genuine/genuinely/for real/binds"; whole programs in question code fields; Learn boxes show full instructions; flowchart shapes keep a 20px gap.
- 09-18 fpc run as `-Mobjfpc` everywhere (32-bit Integer).
- 09-18 No SAGs named in lesson text.
- 09-19 Live console: daemon, supervisor, xterm.js, slice; console panel with files, themes, Help, Analysis tab; switched on live.
- 09-19 Console layout check on every run, with no single letters; Analysis only after layout passes.
- 09-19 Every listing a whole program (Copy to console) or `no-console`.
- 09-19 Feedback shape enforced in code (`NormaliseFeedback()`); paste detection with a third of the mark on flagged answers.
- 09-19 Security headers (CSP, Permissions-Policy, HSTS); titles <= 55 characters; `goodtoknow` block (plum); banned "reach for", "lean on".
- 09-21 SAGs coverage shown per lesson on the course page (only place the SAGs is named); subjects layer; hamburger menu.
- 09-22 Every lesson needs SAGs coverage (`check-sags.php`).
- 09-22 Listings coloured like the console; Common errors blocks; every algorithm an `algorithm` block with `Flowchart()` and pseudocode.
- 09-22 Routine comment blocks and `Result :=` enforced; Comment button, Ctrl+Shift+C, Update code; blank lines between program sections; constructors fill fields through setters.
- 09-22 Teacher options and Admin moved into the hamburger menu; "Try this" interactives started.
- 09-23 Every illustration in `Figure()` with a caption.
- 09-23 One account, one session.
- 09-23 Try-its and diagrams wherever they help, no limit; always initialise variables; never change a For counter inside the loop.
- 09-23 Brackets round comparisons joined by And/Or/Not (console rule); CSP allows www.google.com for YouTube; My marks shows percentages.
- 09-23 Pascal: no video placeholders (`check-videos.php`).
- 09-23 Typed code answers compared ignoring spacing, with AI fallback; one-word hint only for one plain word; wider answer box.
- 09-23 Unit comments go in the Implementation, never the Interface; Ctrl+Shift+C: `TThing.Method` fix, no-Implementation error, pop-up; console tab close, `.pas` added automatically; contents menu closes on click-away.
- 09-23 A class's methods never read or write.
- 09-23 AIResources compacted to current state only; this history file started.
- 09-23 Pascal plan fixed: 18 testing/exceptions, 19 dates, 20 array manager, 21 inheritance, 22 text UI, 23 GUI, 24 practical exam, 25 PAT; data representation to the theory course.
