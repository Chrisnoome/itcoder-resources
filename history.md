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
- 09-23 House style: blank line between steps inside a longer block, each step opened by a // comment.
- 09-23 Every quote has an image (a fitting picture when there is no portrait).
- 09-23 New try-it file pascal-tryit-dates.js (lesson 19), loaded by lesson.php, with a node test against fpc output.
- 09-24 Layout check: `Result[index] :=` counts as setting Result (functions giving back arrays); new try-it file pascal-tryit-manager.js (lesson 20) with a node test against fpc.
- 09-24 Typing flags: events/s not chars/s, starterText not counted, save on pagehide; no pasting in typed/checked-code/grid answers; answer timestamps and work time; pupil-work percentages and filters.
- 09-24 Closing the last page frees the account in ~90 s; "Leaving?" pop-up with Sign out; console Template menu, done-toasts, Clear fixed; empty class sections pass the layout check.
- 09-24 platform-roadmap.md started: plan and open questions for teacher groups, subscriptions, landing page.
- 09-24 From lesson 16 on, every program with a class starts with {$H+} and declares ToString with Override (Chris) - lessons 16-20 converted, rubrics accept either; Update code adds Override to a ToString only when {$H+} is there. New try-it file pascal-tryit-inherit.js with a node test against fpc; Flowchart(): an If with an empty No branch now keeps its No line clear of a wide Yes branch (fixed lesson 20's clipped Remove chart).
- 09-24 Roadmap questions Q1-Q25 answered: invitation-only teacher groups, Brevo later, yearly plans, payer covers group, reminders not auto-renew, IEB/CAPS/neither chosen at enrolment.
- 09-25 Long lines in every listing, output, errors card and try-it wrap with a hanging indent under the first bracket (no sideways scrolling); every output has its main program shown above it (check-output-programs.php, class no-program for data); failing code says will-not-compile / error-when-run beside it; reveal button "What happens next? Show me" made big and pulsing, remembered, with a scrolled-past bar; console Program and Unit templates start with {$H+}.
- 09-24 Long Pascal listings (over 15 lines) start folded with a Show the whole program bar (app.js FoldLongListing); lesson 7 safe conversions (StrToIntDef, TryStrToInt, Val, Real versions); lesson 20 methods renamed AddPupil/InsertPupil/UpdatePupil/DeletePupil/FindPupil plus sorts; billing tables, Entitlements(), per-call AI cost (aiUsage).
- 09-24 {$H+} in every program in every lesson (not only lessons with classes), the console default and templates; quoted error positions recompiled; lesson 2 explains it. SAGs lines on the course page fold (closed by default).
- 09-24 Lessons 22 (text UI) and 23 (GUI design) built; real Crt screens (.ans from server pty runs) and real Lazarus screenshots introduced, tools in tools/ui-screens; try-it file pascal-tryit-ui.js.
- 09-24 Teacher groups (step 2): teachers see only pupils who accepted their invitation; admin grants teachers, approves domains, turns classes into groups; teacher plans cover their groups' marking up to seats.
- 09-24 Notifications (step 3): a bell on every signed-in page (answer marked, summary ready, invitation, teacher reset or flag, subscription ending in 30/7 days), notifications.php, and Carry on where you were on Subjects.
- 09-24 CAPS coverage per Pascal lesson (`caps.php`, 2024 CAPS amendment); the course page shows a SAGs box, a CAPS box, both or neither per person (`pupils.syllabus`; pupils pick IEB/CAPS/neither, teachers and admins may pick both; asked once on the course page, changed on My account).
- 09-24 Practical exam guides: lesson 24 IEB (Section B only; SQL is a separate course), lesson 25 CAPS (stands alone, Questions 1, 3, 4), PAT moves to 26. Analyses in ieb-practical-exam-analysis.md and caps-practical-exam-analysis.md.
- 09-24 Pascal lessons: every "lesson N" reference is a link to the section meant (297 links, `bin/check-lesson-links.php`, content-voice-and-pedagogy.md §7a). Proof of life's "a box, which lesson 3 teaches" corrected to lesson 4.
- 09-24 Plan for a Pascal glossary (all terms, plum = not examined, grade checkboxes, PDF, popups read from it) and a per-course searchable index popup (no PDF) - courses/pascal-course.md.
- 09-25 Lessons 26 (data validation task) and 27 (PAT) with AI pre-checks of uploaded parts (lib/tasks.php, never a mark); questions fold, headers show earned marks, Hide questions for syllabus 'none', tooltips on the top bar and console; CAPS tasks researched (caps-tasks.md).
- 09-24 Built the Pascal glossary (276 terms, grade filter, plum = not examined, PDF; Gloss() popups now read the glossary) and a per-course Index popup (search + Cancel) on course, lesson and glossary pages - courses/pascal-course.md.
