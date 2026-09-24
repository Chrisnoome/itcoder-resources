# The live console

A panel beside every Pascal lesson where pupils run real, interactive Pascal
(like OnlineGDB). **Live on itcoder.co.za and on test.** The sandbox rules come
from [compile-subsystem-design.md](compile-subsystem-design.md); the queue path
there still serves marked/auto-checked code (`checkedcode`, `gridtyped`) and
the Windows testbed.

## Shape

    browser (xterm.js 6.0.0) --WSS--> nginx /live/ --> runner daemon (user itcoder-live)
    PHP api/live-start.php (auth, enrolment, caps, layout check) --control socket--> daemon
    daemon --sudo -n--> /usr/local/bin/itcoder-live-sandbox.sh run pascal | stop <16 hex>
      --> systemd-run unit itcoder-live-<id> in itcoder-pupils.slice
          --> bin/live/supervisor.py owns a pty: fpc -Mobjfpc, then the program

- **PHP is the gatekeeper**: `lib/live.php`, `api/live-start.php`,
  `live-result.php`, `live-stop.php` - same checks as `api/compile.php`, then
  hands the job to the daemon over a local socket (`unix:`, mode 0660 group
  www-data). The browser gets a one-use `/live/<32 hex>` capability and never
  sends source over the socket. The daemon never touches the database.
- **Daemon** `bin/live/runner.py` (asyncio): fair FIFO compile queue (a slot is
  held only while compiling; start at 4), one session per pupil (a new Run
  replaces the old), session cap (`MAX_SESSIONS` 60), unclaimed-session expiry,
  keystroke size/rate limits, a watchdog that stops units by name, `GET /stats`.
  Tests: `python -m unittest discover -s bin/live -p "test_*.py" -v`.
- **Supervisor** frames every byte both ways as `<TAG> <ARG> <LENGTH>\n<bytes>`
  (tags in its header comment - the single source of truth): `K` keys, `Z`
  resize (20-250 x 5-100; starts 80x25), `X` stop.
- **Launcher** `bin/live-sandbox.sh` validates every argument itself (sudoers
  can only match the first words), gives each unit a name, and `stop` accepts
  only a 16-hex id.
- **Limits:** unit `CPUQuota=50%`, `MemoryMax=128M`, `TasksMax=32`,
  `RuntimeMax=16min`; slice `MemoryMax=1.5G`, `MemoryHigh=1.25G`,
  `CPUQuota=200%`, `TasksMax=512`; idle 5 min, total 15 min; output budget with
  backpressure; per-file write cap `RLIMIT_FSIZE` 256 KB (no tmpfs /tmp yet).
  Same sandbox as compiling: DynamicUser, no network,
  `InaccessiblePaths=/var/www /var/backups /var/log`, private /tmp.
- **Files:** a run is a length-prefixed bundle of files (`<count>\n`, then per
  file `<name>\n<bytes>\n<content>`), one main. Data files sit in the run's
  directory, so reading works; writing works within a run but isn't kept.
- **Cost (measured):** ~12 MB per idle Pascal session (unit ~6.6 MB; `sudo` and
  `systemd-run` clients ~7 MB each, in the daemon's cgroup - hence the daemon's
  640 MB limit). 200 sessions ~2.5-3 GB. Java later (~60-80 MB each) wants a
  separate executor server - the daemon already is a separate service.
- **Language is a parameter** (profile: sources, compile, run); Java to follow,
  never an in-browser JVM.

## Installed

- Daemons `itcoder-live@test` and `itcoder-live@live` (live: port 8771, control
  `/run/itcoder-live-live/control.sock`), from
  `bin/live/deploy/install-live.sh test|live` (root). Live nginx has
  `include snippets/itcoder-live-live.conf;` in the 443 block of
  `sites-available/itcoder`.
- Config keys: `'liveConsole' => true`, `'liveControl' => 'unix:...'`. Off =
  `'liveConsole' => false`; remove = `systemctl disable --now itcoder-live@live`
  and delete the include line.
- **The publish scripts don't install or prove the live files** - updating
  `runner.py`, `supervisor.py` or `live-sandbox.sh` needs the installer re-run
  and then, as the daemon's user:
  `sudo -u itcoder-live python3 live-check.py sudo -n /usr/local/bin/itcoder-live-sandbox.sh run pascal`
  (20 checks; `tools/live-check.py`; `smoke.py` 10 checks through nginx).
- Unproven: CPU throttling under a long CPU burn; a class-sized compile burst;
  live-check has not been re-run on live (identical files proven on test).
- `/opt/itcoder-livetest/` on the server is throwaway test copies - safe to
  remove.

## The panel (`public/assets/console.js`, `console.css`, `lib/console.php`)

- **Show / hide console** in the lesson toolbar; right-hand panel (draggable
  360px to 70%; below 900px it covers the screen). Pascal course only
  (`ConsoleAvailable()`).
- **Copy to console** on every `<pre>` holding a whole program or unit
  (`LooksRunnable()`); `class="no-console"` opts out. Into an untouched console
  it just goes in; otherwise Replace / Open in a new tab / Cancel. A unit
  copies to `<unitname>.pas`.
- **Files:** tabs are the project's files (max 8; `.pas`/`.pp` code,
  `.txt`/`.dat`/`.csv`/`.inc` data; lower-case names). **+** adds a file;
  **x** on a tab closes it (removes the file - the question says so and points
  at Download). New/Rename: `.pas` is added if no extension is typed, never
  doubled, name lower-cased. A unit's file must be named after the unit
  (checked before running). **Files** menu: New, Open from my computer (or
  drag in; names tidied, `.lpr`/`.dpr` -> `.pas`, type/size checked, clashes ask
  Replace / Keep both / Skip, refusals listed), Download this file, Download
  all (.zip written in the browser), Rename, Delete.
- **Template ▾** (toolbar, 24 September 2026): Program, Unit (Interface,
  Implementation and an empty Initialization) or Class (asks for a T name; goes
  into a unit's Interface, or above a program's Var/Begin, with empty private
  and public). A program or unit fills the current file if it is still empty,
  otherwise a new tab. Every template passes the layout check as written.
- **Every button says when it has finished** (Chris, 24 September 2026): a
  toast for Clear, Comment, Update code, New/Rename/Delete file, the templates,
  and when an analysis is ready (which also switches to the Analysis tab).
  Clear shows the Console tab and wipes it (or says to Stop first).
- **Saving:** server-side per pupil (`consoleWorkspaces`, ~1s after typing,
  "✓ Saved", Ctrl+S). Whether the console is open is saved too. Panel width,
  splitter height and theme are per browser (`localStorage`).
- **Lower tabs:** Console (80x25 terminal, VGA palette, black in both themes),
  **Analysis**, **Layout fixes** (count badge; a failed precheck switches
  there; each problem jumps to its file and line). **Check layout** checks
  without running. Draggable splitter (mouse, touch, keyboard). Scrollbars only
  when needed.
- **Themes:** dark default; light = Lazarus's `ColorDefault.xml` (bold black
  reserved words, blue italic comments, `#E00000` symbols). Colours are
  variables (`--k-*`, `--hl-*`); contrast >= 4.5:1 computed. Bold/italic are
  safe only because the font is monospace.
- **Highlighting:** a coloured copy under a transparent textarea
  (`pascal-syntax.js`, tokenizer tested lossless). Colours only in dark. Nothing
  in the console may be a `<pre>` (`app.js` rewrites every `<pre>`).
- **Ctrl+Space:** suggestions from every project file - own names first, then
  reserved words, library, other words - inserting house style (`wri` ->
  `Writeln`). Offers the whole vocabulary, not only what's taught.
- **Help (?)**: text in `content/console/help.php` (`ConsoleHelpHtml()`: only
  `**bold**`, `` `code` ``, `[[Key]]`). States limits (15/5 minutes, 8 files,
  layout rules) - change help with the console.
- Exercise runs still write `codeSubmissions` (did it compile) for the
  performance review. The old celebrations and AI style note aren't shown in
  the console.
- No daemon -> a plain message in the terminal; there is no queued fallback.

## The layout check (before every run)

`ConsoleLayoutProblems()` (`lib/console.php`) from `api/live-start.php`, using
`CheckPascalStyle()` in `lib/codestyle.php`. It only flags what fpc accepts,
never hides a real compiler error, and never says "house style".

- **Free code and copied examples:** `ConsoleStyleRules()` = everyday rules +
  `noSingleLetters` + `comparisonBrackets` + `routineComments` +
  `functionResult`.
- **Units:** `UnitStyleRules()` = tabs, oneInstructionPerLine,
  noSingleLetters, comparisonBrackets, routineComments, functionResult (the
  everyday indent/programHeader rules misread units).
- **Code copied from an exercise:** that block's rules, plus single letters
  from lesson 4, `comparisonBrackets` from lesson 8, the routine rules from
  lesson 14 (`live-start.php`, mirrored in `bin/check-code-blocks.php`).
  `checkStyle => false` skips it. `DefaultStyleRules()` (lesson code blocks
  naming no rules) stays without these.
- `noSingleLetters`: flags a one-letter name once, where it first appears,
  listing its lines; ignores strings, comments, `$F`, `1E5`, `#13`, `%101`,
  anything after a dot.
- `comparisonBrackets` (`ComparisonBracketProblem()`): in `If...Then`,
  `While...Do`, `Until...;` or `:=`, comparisons joined by And/Or/Xor or after
  Not each need brackets.
- `routineComments` / `functionResult` (`lib/routines.php`): the comment block
  and placement in pascal-house-style.md §4 (unit comments in the
  Implementation; a block left in the Interface is reported); a `...` left in
  a block is refused; every function body sets `Result :=`.
- The indent rule understands classes and records in a program's Type section,
  and `Destructor Destroy; Override;` is one instruction.
- Tests: `php bin/check-codestyle.php`.

## Code completion (`public/assets/pascal-complete.js`, no DOM)

Tests: `node public/assets/pascal-complete.test.js` (`--write DIR` saves the
completed programs for compiling). Results are applied as one `setRangeText`.

- **Comment** button: writes the block above the routine the cursor is in (if
  none), selecting the first `...`. A program's method body -> on its class
  declaration; in a unit -> above the body in the Implementation (on an
  Interface heading with no body yet it says to press Ctrl+Shift+C).
- **Ctrl+Shift+C:** writes a body for every routine declared (unit Interface
  or class) without one, named `TThing.Method` for methods (`Type TThing =
  Class` on one line is recognised). Functions get `Result :=`; getters and
  setters work; a constructor with parameters calls setters (missing ones are
  declared and written); a class holding an array of objects gets a
  destructor that frees and Nils them. Comments: program classes on the
  declaration; units above the body, and any block found in the Interface is
  moved down. **A unit with no Implementation is an error; nothing is
  written.** A **pop-up** over the editor says what it did (red edge for an
  error), for a few seconds.
- **Update code:** Ctrl+Shift+C plus - body headings rewritten to match their
  declarations; a method only in the implementation is declared in its class.
  A unit routine only in the Implementation is a private helper, left alone.
  **Nothing is ever deleted.**

## Analysis tab (`lib/analyse.php`)

- Queued like all AI calls: `api/console-analyse.php` writes a row
  (`codeAnalyses`, one per pupil); `markqueue.php` writes it (after written
  answers, before reviews); the console polls. Gated by `CanUseMarking()` and
  the daily cap; identical code reuses the stored result (no second call)
  unless the prompt changed (`AnalysisPromptSince()`); a pupil may re-ask after
  2 minutes.
- **No analysis until the layout passes** - no paid call; the pupil is sent to
  Layout fixes.
- `AnalysisSystemPrompt()` rules: talk only about lessons taught (the list
  limits what it may recommend, never what the pupil may write); weigh, in
  order: one concept per line; don't repeat yourself (only once loops/
  routines are taught); comments on complex code; meaningful names; output
  layout; an empty line between steps (names the line); does it do what its
  names say; what could go wrong. Praise building a string before displaying
  it. Never: comment on layout (already enforced), a variable's type without a
  real problem, other features, "won't compile" for untaught features,
  rewriting their program. Quoted code follows house style. ~200 words,
  `**Things to check:**` / `**Ways to improve it:**`, rendered with
  `textContent` only. It carries verified runtime facts (Readln of letters ->
  106, empty line -> 0; Div/Mod by 0 -> 200; `/` by 0, Sqrt of a negative ->
  runtime error; overflow wraps silently; array bounds unchecked).
- The button shows "Working" with animated dots.
