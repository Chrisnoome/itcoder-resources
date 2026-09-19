# The live console (branch `FullConsole`)

Started 18 September 2026 at Chris's decision. Start at [README.md](README.md)
if you haven't; read [compile-subsystem-design.md](compile-subsystem-design.md)
first, because this replaces its "one shot, simulated input" limitation without
replacing its sandbox principles.

**Status, 18 September 2026: design only. Nothing built, nothing deployed.**
All work happens on git branch **`FullConsole`** in `AIPascalCourse`, cut from
`next-work` at commit `df92f24`. Reverting is: `git checkout next-work`. Nothing
on the server changes until Chris publishes from this branch.

## What Chris decided (18 September 2026)

1. **The full thing**, not the replay shortcut. Programs run for real, live:
   `Now`, `Random`, `Delay`, `ReadKey`, `KeyPressed` and timing all work.
2. **Maximum Pascal functionality**: multi-file projects (a pupil's own unit plus
   a main program - the coding window will later have two tabs), reading text
   files, and writing them if it proves possible.
3. **Pascal first, Java later.** The executor is built with the language as a
   parameter so Java (IEB's second language; the course is to be duplicated in
   Java) drops in without a redesign. **No CheerpJ / in-browser JVM.**
4. The existing "Run this exercise" button on a `code` block becomes a live
   console. The block, the editor and the terminal rendering already exist.
5. Everything on a git branch so it can be reverted.

## Why the current design cannot do it

`bin/compile-sandbox.sh` runs compile and run in ONE `systemd-run` call whose
stdin is spent before the program starts (source + pre-typed input framed by
byte length). The program cannot wait on a live keyboard, and output is only
shown once it has finished. That is a deliberate property of the queue design,
and it stays for marked / auto-checked code questions, which must be
deterministic.

## Shape

```
browser (xterm.js) <-- WSS --> nginx /live/ <-- WS --> runner daemon
                                                          |  (unprivileged user)
        PHP (auth, enrolment, size, layout check) --local-->  |
                                                          v
                                   sudo -n itcoder-live-sandbox.sh <language>
                                                          v
                          systemd-run --pipe  (same DynamicUser sandbox as today)
                                     compile -> run under `script` (a pty)
```

- **PHP stays the gatekeeper.** `public/api/live-start.php` does exactly what
  `api/compile.php` does now (sign-in, enrolment, block exists, byte caps,
  layout check, one session per pupil) and then hands the job to the daemon
  over a local-only socket with a shared secret from `config.php`. The daemon
  never talks to the database and never trusts the browser for identity.
- **The browser gets a one-time session token** and opens a WebSocket to the
  daemon through nginx. It never sends source over the socket - the source was
  already handed over by PHP.
- **The daemon is a separate small service, not PHP.** A PHP request held open
  for a live session would pin a PHP-FPM worker for minutes (pool max is 40).
  That is the one design that could slow the site, so it is excluded.
- **The daemon runs unprivileged** and reaches systemd the way PHP does today: a
  root-owned script outside `/var/www`, allowed through `sudo` by an exact rule.
  Same principle as the compile sandbox: the account that is exposed to the
  network must not be the account that can rewrite what runs as root.
- **The sandbox properties are unchanged** (DynamicUser, no network,
  `InaccessiblePaths=/var/www /var/backups /var/log`, `ProtectProc`, memory and
  task caps, private `/tmp`). Read `bin/compile-sandbox.sh` before touching
  them - especially the "never write `${BRACED}` in the inner script" warning.
  What changes: `RUN_SECONDS` becomes a long idle/total limit, and a live unit
  also gets `CPUQuota` (a `while true do;` must not take a core for minutes).
- **A dedicated systemd slice** holds every pupil unit, with a combined ceiling
  (`MemoryMax`, `CPUQuota`), so pupils' programs cannot starve the site however
  many run. Sized so nginx, PHP-FPM, the marking queue and SQLite always keep
  headroom.
- **Concurrent compiles are capped by a semaphore** in the daemon (start at 4 -
  128 MB each would otherwise be 30 x 128 MB in a lockstep class), extra
  requests wait in line and are told their position. Idle programs cost almost
  nothing, so the cap on live sessions is much higher than on compiles.
- **Session limits, all enforced in the daemon and again by systemd:** one live
  session per pupil (a new Run replaces the old), idle timeout (start at 5 min),
  hard total (start at 15 min), output byte budget with backpressure (a program
  printing in a tight loop cannot fill the socket), input size cap per message.

## The language is a parameter

The sandbox script takes one argument, the language, checked against a fixed
list inside the script (and allowed by exact `sudoers` lines, as `--tty` is
today). A **profile** says how to compile and run:

| | Pascal | Java (later) |
|---|---|---|
| Source files | `*.pas`, `*.pp`, `*.inc` | `*.java` |
| Compile | `fpc -Mobjfpc -O1 <main>` | `javac` |
| Run | `./<main>` | `java -Xmx64m -XX:+UseSerialGC <Main>` |
| Rough live cost | **~12 MB measured** (see "Measured cost of a session"), ~0.3 s compile | ~60-80 MB *estimated* plus the same ~12 MB overhead, ~1.5 s compile |

Rules that hold for every profile: file names are validated by a strict regex
in the script itself (PHP checks first; the script is the lock that cannot be
skipped); a Pascal unit's file name must match its `unit` name (fpc finds
units by file name), and the editor can enforce that; the profile's memory and
concurrency caps are separate numbers, because a JVM session is roughly 15x a
Pascal one.

## Project files, data files, saving

- **A run is a set of files**, one designated main, sent to the sandbox as a
  length-prefixed bundle - the same idea as `FrameSandboxStdin()`, extended to
  N files: `<count>\n` then, per file, `<name>\n<bytes>\n<content>`. Lengths, not
  delimiters, for the reason already written up in the sandbox header.
- **Reading a text file works** with no extra machinery: data files ride in the
  same bundle and sit in the run's private working directory, so `Assign`/
  `Reset`/`Readln` just work. Lessons can ship starter data files.
- **Writing a text file works** too: the unit's `/tmp` is writable and private,
  so `Rewrite`/`Writeln` succeed and reading it back in the same session works.
  It is deleted when the session ends. **Persisting it between runs is phase two**
  (per-pupil rows with a size and count cap); at the end of a session the
  sandbox can emit files it finds that it was not given, framed with a length
  header, for the daemon to return.
- Per-file cap and total cap are both set from `CompileLimits()` so PHP, the
  daemon and the script cannot disagree - the same "change one, change all"
  discipline already used there.

## Wire protocol (browser <-> daemon)

JSON text frames; terminal bytes as binary frames.

- server -> browser: `{"t":"status","state":"queued|compiling|running|ended","pos":n}`,
  `{"t":"compile","ok":bool,"output":"..."}`, binary = program output (raw pty
  bytes, xterm.js renders them), `{"t":"end","code":n,"why":"exit|timeout|idle|killed|output"}`
- browser -> server: binary = keystrokes, `{"t":"resize","cols":80,"rows":25}`,
  `{"t":"stop"}`

xterm.js does the terminal emulation, so **`lib/terminal.php`'s `TerminalScreen()`
is not used for live sessions**. It stays for the stored result of a marked
block and for reloads. One emulator per path; do not try to unify them in this
branch.

## What stays exactly as it is

- The queue path (`api/compile.php`, `bin/compilequeue.php`,
  `compile-sandbox.sh`) for marked and auto-checked code questions, and for the
  Windows testbed, which has no systemd. `checkedcode-answer.php` and
  `gridtyped-answer.php` depend on it being deterministic.
- The layout check, `CodeStyleFeedback()`, celebrations. A live run can still
  finish by storing a `codeSubmissions` row so a reload shows the last result
  and the style comment still works - decision for the build, noted here so it
  is not forgotten.

## Not verifiable from the Windows testbed

There is no systemd and no pty on Windows. The daemon's protocol, limits and
framing can be unit-tested locally with a fake executor; **the sandbox, `script`
relaying keystrokes to `ReadKey`, and every resource limit must be proven on
the test deployment** (`/var/www/itcoder-v2-test`, port 8082), through the same
gate as today: `tools/publish-test.py` runs `sandbox-check.php`, and
`deploy-live.py` refuses an unproven sandbox. Extend `sandbox-check.php` for
every new property; do not weaken the gate.

## Things that need Chris (not to be worked around)

- **A new `sudoers` rule** for the live-sandbox script, one exact line per
  language. `vps-access.md` already says this is Chris's call.
- **An nginx `location /live/` block** (WebSocket upgrade, proxy to a
  localhost port), and a systemd service unit for the daemon. Both are server
  config. `nginx -t` before reload, config copied aside first.
- **A new apt package** if the daemon uses the `websockets` library
  (`python3-websockets`). The alternative is a hand-written minimal WebSocket
  handshake in the daemon - no dependency, but more code to get right.
- **Vendoring xterm.js** (a downloaded third-party file, about 300 KB, kept in
  `public/assets/`; no build step, matching the platform's rule). Needs an
  explicit yes to fetch it, with source and filename stated.

## Open questions, to answer by testing rather than reasoning

1. Does `script -qec` relay a live stdin to a Crt `ReadKey`/`KeyPressed`? (The
   old test fed a file that hit EOF; a live stream is different.)
2. Window size: the pty defaults to 0x0 under `script`; set 80x25 with `stty`
   before the program starts, and on `resize`.
3. Does `TasksMax`/`CPUQuota` hold under a program that keeps its main process
   alive while burning CPU? (The fork-bomb test from the compile design is
   still un-run for the same reason.)
4. Real numbers: peak concurrent sessions, per-session RSS, compile burst for a
   class of 30. Log them from day one so sizing (see the 4,000-user discussion,
   18 September 2026) rests on data. **First measurement done, 19 September
   2026 - see "Measured cost of a session" - and the ~5 MB estimate written on
   18 September was wrong by 2-3x.** Compile time under a class-sized burst is
   still unmeasured.

## Build order

1. Sandbox script v2 (bundle in, language parameter, live stdin) + extend
   `sandbox-check.php`. Prove on test.
2. Runner daemon: protocol, limits, semaphore, slice. Prove with a scripted
   client on the server before any UI exists.
3. PHP: `live-start.php`, token, `config.php` keys.
4. Front end: xterm.js console in the `code` block, Stop button, queue message.
5. Multi-file editor tabs, data files, written-file return.
6. Load test with a scripted class of 30; record numbers here.
7. Only then: deploy live, via the normal two-script publish.

## Built and proved: the sandbox layer (19 September 2026)

Step 1 of the build order is done and **proved on the real server** (Ubuntu
24.04, systemd 255, Python 3.12.3, fpc 3.2.2), through real `systemd-run`, as
root over SSH from a throwaway copy in `/opt/itcoder-livetest` - nothing under
`/usr/local`, `/etc` or `/var/www` was touched. **21 of 21 checks pass**
(`tools/live-check.py`):

live `Readln` (the prompt shows before anything is typed), live `ReadKey`, Crt
escape sequences, a compile error reported with nothing run, a pupil's own unit
used by a main program, reading a supplied text file, writing a text file and
reading it back, `Now`/`Random`/`Delay`, stop (`X`), an endless loop, endless
output cut off, `config.php` and a lesson file unreadable, a runaway file write
stopped, bad and upper-case file names refused, a vanished daemon ending the
session, and no unit left behind.

**Two decisions that changed from the sketch above, both because of what
building it showed:**

1. **A Python supervisor inside the unit replaces `script` and a bash relay**
   (`bin/live/supervisor.py`). It owns the pty, so it can carry `K` keystrokes,
   `Z` resize and `X` stop on the same pipe, and it frames every byte the
   program prints so nothing can forge a frame. The wire format is now
   `<TAG> <ARG> <LENGTH>\n<bytes>` in both directions; the tags are in the
   supervisor's header comment, which is the single source of truth.
2. **Stop is by unit name.** The unprivileged daemon cannot signal a root-owned
   `sudo`/`systemd-run`, so `bin/live-sandbox.sh` gives each session a unit
   `itcoder-live-<16 hex>` and offers `stop <id>`, which only ever accepts a
   16-hex-digit id - it can stop one of these units and nothing else on the box.
   `sudoers` can only match the script and its first words, so **the script is
   the second lock** and validates every argument itself.

**Answers to the open questions:**

- **Q1 - live `ReadKey` works.** A single live keystroke reaches `ReadKey`
  through the supervisor's pty. The earlier failure was the piped file hitting
  EOF, exactly as suspected.
- **Q2 - window size:** the supervisor sets 80x25 before the program starts and
  again on any `Z` frame (validated: 20-250 columns, 5-100 rows).
- **Q3 - still open.** `TasksMax`/`CPUQuota` under a live CPU-burning program
  has not been measured yet, and `TemporaryFileSystem=/tmp` (a small tmpfs so a
  program cannot fill the real disk) is **not in the launcher yet** - the disk
  check passes today only because of the per-file `RLIMIT_FSIZE` (256 KB) in the
  supervisor. Test it before relying on it.
- **Not yet proved:** the `itcoder-pupils.slice` ceiling (the slice file is a
  deploy step and does not exist), `sudo` as the daemon user, and behaviour under
  many sessions at once.

**Still on the server from testing:** `/opt/itcoder-livetest/` - three files,
mine, safe to remove (`rm -r /opt/itcoder-livetest`). Left in place while this
is iterated on; remove it before publishing.

## Built and tested locally: the runner daemon and PHP hand-off (19 September 2026)

Steps 2 and 3 of the build order are written and tested **locally only** -
the daemon has not been run on the server, and real WebSockets have not been
exercised at all (the `websockets` package is not installed there; see below).

- `bin/live/runner.py` - the daemon. asyncio, one process, no threads. Session
  manager, **fair FIFO compile queue** (a session holds a slot only while
  compiling - a program waiting at `Readln` releases it), one session per pupil
  (a new Run replaces the old, stopping the old unit by name), a session cap,
  unclaimed-session expiry, per-message and per-second limits on keystrokes,
  a watchdog that stops a unit by name if the supervisor's own limit somehow
  fails, and `GET /stats` for the load test. Browsers connect to
  `/live/<32 hex>` (a one-use capability); PHP talks to a local control socket
  (`unix:` on the server, `tcp:` for tests, mode 0660 group www-data, so file
  permissions are the authentication).
- `bin/live/test_runner.py` - 18 tests, fake sandbox and fake browser socket,
  run anywhere: `python -m unittest discover -s bin/live -p "test_*.py" -v`.
  **Checked for real, not just green:** five deliberate bugs (LIFO queue, slot
  never released, no per-pupil replacement, no key rate limit, no wake-on-finish)
  were each introduced in a scratch copy and each made tests fail.
- `lib/live.php`, `public/api/live-start.php`, `public/api/live-stop.php` - the
  PHP side. Same gate as `api/compile.php` (sign-in, enrolment, block exists,
  byte caps, layout check). **Dark by default:** `'liveConsole' => false` in
  `config.sample.php`; absent means every Run behaves exactly as before.
  Verified against the daemon's real control handler from real PHP, including
  accents and quotes in source, refusals, and daemon-down (`[0, null]`, which
  the endpoint turns into a `fallback` reply so the page can use the queue path).

**Not built yet:** the browser side (xterm.js console in the `code` block, Stop
button, queue message, falling back to the queue path on `fallback`); the
two-tab editor; the sandbox check in `tools/publish-test.py`; the slice file; the
deploy/`systemd` unit for the daemon; the load test. `codeSubmissions` is not yet
written by a live run, so a reload shows the last queue-path result, not the last
live run - decide when the front end lands.

**What is waiting on Chris (server changes and one download):**

1. `apt install python3-websockets` (Ubuntu candidate 10.4-1; the daemon uses
   the library's `serve(handler, host, port, origins=...)`, which 10.4 has).
2. A `sudoers` file for the daemon's user - a dedicated `itcoder-live` user, not
   `www-data` - allowing exactly the launcher's `run *` and `stop *` forms.
3. An nginx `location /live/` block: proxy to `127.0.0.1:8770` with the
   WebSocket upgrade headers, on both the live server block and the test one.
4. A systemd service for the daemon and the `itcoder-pupils.slice`.
5. Fetching xterm.js (and its fit addon) from jsdelivr into `public/assets/`.

## Measured cost of a session (19 September 2026)

Eight idle sessions, each parked at a `Readln`, on the real server (4 vCPU,
3.9 GB): system memory in use rose **645 MB -> 738 MB, i.e. +93 MB, about 12 MB
per session**. Where it goes:

| Process | Each (RSS, before shared pages are de-duplicated) |
|---|---|
| Pascal program waiting at `Readln` | 0.2 MB |
| Python supervisor inside the unit | ~10-13 MB |
| `systemd-run --pipe --wait` client | ~7 MB |
| `sudo` (sits between the daemon and the launcher) | ~7 MB |

The unit itself (supervisor + program) is **~6.6 MB in the slice's accounting**
(`MemoryCurrent` of `itcoder-pupils.slice`, 52.6 MB for 8). The `sudo` and
`systemd-run` clients live in the **daemon's** cgroup, which is why the daemon's
memory limit is 640 MB, not the 256 MB first written - that guess would have
killed the daemon, and every session with it, at roughly 20 pupils. Both were
cleaned up afterwards (no units left).

**What this changes.** The 18 September sizing note (below) assumed ~5 MB per
Pascal session; use **~12-15 MB**. 200 concurrent Pascal sessions is therefore
~2.5-3 GB, not ~1 GB. Still comfortable on a bigger server, and the design's
shape (separate executor, capped slice) is unaffected - but at 4,000 users the
executor wants ~8 GB, not 4. `MAX_SESSIONS` defaults to 60 for the current box.
If it ever matters, the levers are: `python3 -I -S` for the supervisor, dropping
`sudo` from the path (only possible if the daemon itself runs as root, which is
a bigger trade), and one shared supervisor for many programs (much more work).
Not worth doing before real usage says so.

Compile burst (30 at once) is still not measured; the semaphore of 4 exists
because 30 x 128 MB would not fit.

## The console beside the lesson - the design as built (19 September 2026)

**Chris's design change, 19 September 2026:** instead of a Run button inside each
lesson exercise, a **"Show / hide console" item in the top toolbar** opens a
**panel to the right of the lesson** (the model is OnlineGDB: file tabs, an
editor, Run, a black terminal underneath). **Every code section in a lesson gets
a "Copy to console" button**; if the console is hidden when it is pressed, it
appears. The lesson's own Run box goes away. This also delivers the two-tab
editor (main program + a unit) - tabs are simply the project's files.

Built on branch `FullConsole`. Files: `public/assets/console.js` and
`console.css` (the panel), `vendor/xterm/` (xterm.js 6.0.0, see its README for
hashes), `lib/console.php` (workspace, file limits, unit detection),
`public/api/console-save.php`, `live-start.php`, `live-result.php`,
`live-stop.php`, and a `consoleWorkspaces` table. **Everything is behind
`'liveConsole' => true` in `config.php`; with it false (the default) every page
is exactly as before** - checked, 19 September: no panel, no assets loaded, the
old editors and Run buttons back.

**Decisions made while building it - Chris to overrule any of them:**

1. **Which listings get a "Copy to console" button.** Every `<pre>` that is a
   *whole program or unit* (has a `Program`/`Unit` header, or a `Begin ... End.`),
   found by `LooksRunnable()` in `console.js`. **Not** on fragments
   (`score := score + 1;` can never compile alone), sample output
   (`Hello, world!`), or `algorithm-pseudocode`. 158 of the 216 `<pre>` blocks
   in the Pascal lessons *look like* code by a crude test; the console's own
   test is stricter, so expect fewer. An exercise's starter always gets one,
   even if empty. To include fragments too, change that one function.
   Authors can opt a listing out with `class="no-console"`.
2. **Copying never silently overwrites work.** Into an untouched console it just
   goes in; otherwise the pupil chooses *Replace / Open in a new tab / Cancel*.
   A unit copies to `<unitname>.pas`.
3. ~~**The layout check applies only to exercises.**~~ **REVERSED the same day by
   Chris - see "Second round" below: the layout check now runs on everything in
   the console, and includes "no single letters".**
4. **Exercise runs are still recorded** (`codeSubmissions`, via `live-start.php`
   and `live-result.php`), because "Evaluate my performance" (`lib/review.php`)
   counts how many code boxes a pupil got to compile and would have read zero.
   The browser reports one boolean (did it compile) - acceptable for a summary
   sentence, and marks never depend on it (marked work still goes through the
   queue path, which believes nothing the browser says).
5. **The workspace is saved server-side per pupil** (autosave ~1 s after typing),
   not in browser storage: shared lab machines would hand one pupil's work to the
   next, and it must follow them home. Whether the console is open is saved too,
   so it opens on the first paint. (Only the panel *width* is in `localStorage` -
   a screen convenience, not the pupil's.)
6. **Terminal: fixed 80 x 25** like the existing virtual DOS terminal, VGA
   palette, font scaled to the panel (min 9 px, max 16 px). A 360 px-wide panel
   is legible but tight. Panel width is draggable (min 360 px, max 70% of the
   window). Below 900 px wide the console covers the lesson instead of sitting
   beside it.
7. **A unit's file must be named after it** (`Unit Shapes;` lives in
   `shapes.pas`) - checked *before* running, in plain words, so the pupil is not
   left with fpc's "Can't find unit". File names are lower-case only. Up to 8
   files; `.pas`/`.pp` code, `.txt`/`.dat`/`.csv`/`.inc` data.
8. **Run with no daemon** (or the daemon refusing) shows a plain message in the
   terminal. There is no queued fallback: a queue cannot take a keyboard.

**Syntax highlighting and Ctrl+Space suggestions (Chris, 19 September 2026).**
Built by hand rather than with an editor library (Ace, CodeMirror): no download,
no build step, no third-party code between a pupil and what is sent, and the
suggestions can insert **house style**. Files: `public/assets/pascal-syntax.js`
(tokenizer, name collection, suggestions - no DOM, tested in Node),
`console.js` (drawing and the popup), `console.css`.

- **Highlighting** works by a coloured copy laid exactly *under* a transparent
  textarea: the textarea is still what they type in and what is sent; the copy
  is `aria-hidden` decoration. Colours only - **never bold or italic**, which can
  change a letter's width and push the copy out of line. Reserved words orange,
  types blue, built-in routines yellow, strings green, numbers purple, comments
  and `{$directives}` muted. `.pas/.pp/.inc` are coloured; `.txt` is plain.
- **Ctrl+Space** opens a list at the caret (arrows, Enter/Tab accept, Esc
  closes, typing narrows it, clicking a row works). Exactly one match after some
  typing completes at once. **Suggestions come from every file in the project**,
  so the main program completes a procedure declared in the unit tab. Ranking:
  the pupil's own names (variables, procedures, functions, parameters,
  constants, types, units) -> reserved words -> the library -> other words in
  their code. Each shows a one-line plain-words description.
- **It inserts house style** (pascal-house-style.md): typing `wri` gives
  `Writeln`, `beg` gives `Begin`, `int` offers `Integer`; a name they declared
  is inserted as they declared it.
- **Two bugs found only by looking at the page**, both worth remembering:
  (1) `app.js` rewrites *every* `<pre>` into numbered lines, which wiped the
  first version of the highlight layer - it is a `<div>` now, and any future
  element in the console must not be a `<pre>`; (2) the site's global `code`
  styling gave the layer 6px of padding and shifted every colour 6.8px right -
  found by measuring, fixed by resetting it. After the fixes the coloured copy
  sits within **0.06px** of the letters, unscrolled and scrolled.
- **Tested:** 20 Node tests (the tokenizer is checked to be *lossless* over
  every code listing in the real lessons and 3,000 random garbage strings -
  half-typed code can be anything); 27 real-keyboard-event checks in the browser
  (list, arrows, Enter, house-style insertion, own names first, a name from the
  unit tab, narrowing, Escape, no-match message, mouse, `.txt` files, Enter still
  keeping indent); the earlier 10 end-to-end console flows re-run with no
  regression; a screenshot of the colours and of the list.
- **Speed:** at the largest file allowed (32 KB, 420 lines) a keystroke redraws
  in ~19 ms (0.7 ms of that is tokenizing; the rest is rebuilding the coloured
  DOM); a typical pupil file is a few KB and takes about a millisecond.
- **Choices to review:** the suggestion list offers the *whole* vocabulary, not
  only what the course has taught by that lesson (content-voice-and-pedagogy.md §4
  governs *marking*, not tools, but a pupil may find `Format` before it is
  taught - the list is one array in `pascal-syntax.js` if you want it gated).
  **Ctrl+Space can be intercepted** by an operating system or input-method
  editor on some machines (macOS uses it to switch input source); if lab
  machines do that, a second shortcut is a one-line addition. Lesson code
  *listings* are not coloured - only the console; colouring them is a small
  follow-up if wanted.

### Second round (Chris, 19 September 2026): layout check back, tabs, splitter, AI analysis

Asked for, in order: (1) *"resume check for house style, indentation, etc
before compiling ... include no single letters"*; (2) scrollbars only when there
is not enough space; (3) a resize bar between the code and the output; (4) the
console in a tab, another tab where the AI analyses the code and suggests
improvements (an "Analyse" button and a display), and a third tab of layout
fixes that the console **switches to when the precheck fails**.

**The layout check (reverses decision 3 above).**
- **Every run** is checked before anything compiles: `ConsoleLayoutProblems()` in
  `lib/console.php`, called from `api/live-start.php`. Free code and copied
  examples get `ConsoleStyleRules()` = the everyday set + the new
  **`noSingleLetters`** rule (`lib/codestyle.php`). Code copied from an exercise
  gets *that block's* rules, as before, **plus single letters once the exercise
  is from lesson number 4 or later** (variables are taught in lesson 4,
  "How to remember"; §4 of the pedagogy notes says never grade what has not been
  taught). A block with `checkStyle => false` is not checked at all.
- **`noSingleLetters`** flags a single-letter *name* once, on the line it first
  appears, listing every line it is used on. It works on the whole file so a
  `{ multi-line comment }` is not mistaken for code, and it deliberately ignores
  everything that only *looks* like a letter: strings, comments, `$F`, `1E5`,
  `#13`, `%101`, and anything after a dot (a field, or the `n` in `1..n` - the
  name is flagged where it is declared). Wording is plain ("The name n is only
  one letter, so it does not say what it holds. Give it a name that does - like
  playerScore or lineCount"), and never says "house style".
- **It is NOT in `DefaultStyleRules()`**, on purpose: that is what the lesson
  `code` blocks run when they name no rules, and adding it there would grade the
  early lessons on something they have not taught.
- **Units get a smaller set** (`UnitStyleRules()`: tabs, one instruction per
  line, single letters). *Measured, not assumed:* the everyday `indent` and
  `programHeader` rules gave **8 false problems on a correct house-style unit**
  (`indent` does not understand Interface/Implementation or a Record's End; a
  unit has no Program line), and refusing a correct unit is the worst thing this
  checker can do. The three chosen rules give none on the correct unit and each
  catches a real fault in a faulty one.
- **The checker's one rule is intact:** the deliberately broken "Fix the errors"
  starter (missing `End.` and a semicolon) still reaches the compiler, as its own
  exercise and pasted in as free code - tested through the real endpoint.
- **Content flag for Chris - not changed by me:** three *whole-program* listings
  in the lessons use single-letter variables and would be refused if copied to
  the console: **lesson05.php twice (`a`, `b`)** and **lesson07.php (`n`)**. (Five
  other listings contain a single letter but are sample output or fragments and
  get no Copy button.) Renaming them is your call - they are lesson content.

**Tabs, splitter, scrollbars.**
- The lower half of the panel is now three tabs: **Console** (the terminal),
  **Analysis**, **Layout fixes** (with a count badge). A failed precheck fills the
  Layout fixes tab and switches to it; pressing Run switches back to Console. Each
  problem is a button that takes the pupil to the right *file*, selects the *line*
  and scrolls to it. **Check layout** runs the same check without running
  anything (`live-start.php` with `layoutOnly`).
- A **draggable splitter** (a grip between the editor and the output) - mouse,
  touch and keyboard (arrows; Shift for bigger steps; `role="separator"`). Floor
  110px for the output, and the editor always keeps room. Height is remembered in
  this browser only (like the panel width).
- **Scrollbars only when needed.** Measured, not guessed: xterm forces
  `overflow-y: scroll` on its own viewport (a permanent scrollbar with nothing
  behind it), and its `.xterm` box keeps a stale first-render height that made the
  pane scroll for no reason. Both fixed in `console.css`. xterm 6 draws its own
  thin scrollbar which appears only once output has scrolled off; **checked with a
  real mouse wheel** (3 notches = 3 lines). Everything else was already `auto`.
- **Narrow windows (under 900px):** the console now covers the whole screen,
  including the masthead and the lesson's bottom bar, which had been floating over
  its tabs and terminal.

**Analysis (the AI tab).** `lib/analyse.php`, `api/console-analyse.php`,
`console-analyse-result.php`, table `codeAnalyses`, worker hook in
`bin/markqueue.php`.
- **Queued like every other AI call here** (platform.md decision 1): the request
  writes a row and returns; `markqueue.php` writes the analysis when no written
  answer is waiting (before a performance review - the pupil is watching a button
  they just pressed); the console polls. One row per pupil, replaced each time.
- **Gated like marking:** `CanUseMarking()` (school pupils, staff, subscribers) and
  the shared daily cap (`apiUsage`). An identical request is answered from the
  stored result with **no second paid call** (proved: usage counter unchanged).
  A duplicate press while one is in flight queues nothing; after 2 minutes a pupil
  may ask again, so a dead worker cannot lock them out.
- **What it is told** (the prompt is the product - read `AnalysisSystemPrompt()`):
  only talk about lessons already taught (their titles are listed to it); never
  teach a later technique, only say "you will meet a tidier way later"; do not
  suggest a check or a loop unless a lesson on decisions/loops has been taught;
  **do not comment on layout** (already enforced); say what the code "looks like it
  does" - it cannot run it; describe fixes in words, never rewrite their program;
  about 200 words, in a fixed shape (`**Things to check:**`, `**Ways to improve
  it:**`) that the console turns into headings and bullets with `textContent` only.
- **A factual error was caught by reading the first real output**, and fixed: it
  said a non-number typed into `Readln` "fails silently" - lesson 5 teaches that
  it crashes with Runtime error 106. The prompt now carries **facts verified
  against the real compiler** (3.2.2): letters or a decimal into `Readln` -> 106
  (an empty line -> the variable becomes 0); `Div`/`Mod` by zero -> 200; `/` by
  zero and `Sqrt` of a negative -> a runtime error; integer overflow wraps
  *silently*; array bounds are *not* checked; and "if unsure, say try it and see".
  Re-run: correct.
- **Cost:** one small Haiku call, about 5 seconds and ~200 words. Tested for real:
  fresh code, identical code (cached), changed code, at the daily cap (429), too
  much code, blank code, wrong course, unknown lesson, bad file name, the
  in-flight guard, and a stale row after a dead worker.
- **Bug found by the first real call:** the worker function `echo`es a log line
  (right under cron, wrong in a web request); on the Windows testbed, where the
  request does the work itself, that text landed in front of the JSON reply.
  Output buffering now discards it there. The server path is unaffected.
- **Not built:** the analysis is not stored per exercise or shown to teachers.

**Tested this round:** `php bin/check-codestyle.php` (35 checks, incl. every lesson
listing and units), `node public/assets/console.test.js` (11), `pascal-syntax.test.js`
(20), the daemon's 18; in a real browser: 19 layout-tab checks against the real
server code, 15 analysis-UI checks (polling, rendering, stale note, hostile text
shown as text and never run, failure wording), splitter by real mouse drag and
keyboard, the terminal wheel, geometry, and a 13-check regression of everything
from before, with screenshots. **Not yet tested on the test server.**

### Third round (Chris, 19 September 2026): light/dark, files, Help

Asked for: a light/dark toggle, where *"list [light] should resemble Lazarus IDE
style code formatting"*; the ability to save and load / download files; and a
Help button explaining how the console works, the formatting precheck ("not
standard for normal IDEs") and code completion. (I read "list" as "light".)

**Themes.** Every colour in `console.css` is now a variable (`--k-*` panel,
`--hl-*` code) on `.console-panel`; `data-theme="light"` overrides them. The
choice is remembered **in this browser** (`localStorage`), like the panel's width
- a preference for a screen, not something that follows a pupil. Dark is the
default and looks exactly as before.
- **The light theme is Lazarus's own, read from its install, not remembered:**
  `C:\lazarus\ide\ColorDefault.xml` ("Default"). White editor, reserved words
  **bold** black, comments blue *italic*, strings blue, numbers navy, symbols
  (`; := ( ) , .`) red, directives red italic, and identifiers - including
  `Integer` and `Writeln` - plain black, light grey gutter, navy selection.
  (The other schemes it ships - Twilight, Ocean, Delphi, Pascal Classic - are in
  the same folder if you ever want more themes; one block of variables each.)
- **One assumption to check against your Lazarus:** the scheme file marks
  comments `Style="fsBold"` while Lazarus's highlighter itself defaults them to
  italic. I could not confirm from the source how the two combine, so comments
  are **blue italic, not bold** (which is also what I remember seeing). If yours
  are bold, it is one variable: `--hl-c` weight.
- **Bold and italic are safe for alignment only because the font is monospace.**
  Measured, not assumed: 121 sampled letters in the light theme sit within
  0.30px of the textarea's grid, and a bold `Program` is exactly 7 characters
  wide. Do not change the editor font to a proportional one without redoing this.
- **The black output screen stays black in both themes**: `Crt` colours were made
  for a black screen (light text on a white screen would be unreadable).
- **Contrast checked by computing it**, both themes, every text/background pair
  (WCAG 4.5:1). Four fell short and were nudged just enough: dark active tab
  (4.3 -> 5.8), dark gutter numbers (4.0 -> 4.9), light gutter numbers (3.5 -> 5.0;
  Lazarus's `#808080` is too faint) and Lazarus's pure red `#FF0000`, which is
  only 4.0:1 on white - the light theme uses `#E00000`, the same red to the eye.
- **Cost:** the light theme draws a span per symbol, twice the dark theme's spans.
  At the largest file allowed (32 KB, 420 lines) a keystroke redraws in ~36 ms
  (dark ~27 ms); a typical 40-line pupil program takes under 1 ms.

**Files.** A **Files** menu (replaces the old ⋮): New, **Open from my
computer**, **Download this file**, **Download all files (.zip)**, Rename, Delete.
- **Saving was already automatic** (server-side, per pupil). Now it is visible: a
  "✓ Saved" tick disappears the moment something changes and returns when the
  server has it, so nobody goes looking for a Save button. **Ctrl+S** (Cmd+S) saves
  immediately and stops the browser's own "save page" dialog.
- **Open** (button, or drag files onto the editor): names are tidied into valid
  ones (`My Program.PAS` -> `my_program.pas`, a Windows path is stripped, `.lpr`
  and `.dpr` -> `.pas`), and each file is checked for type, being text, and the
  same size caps the server enforces. **Nothing is guessed:** `picture.png` is
  refused in plain words. A name that clashes asks *Replace / Keep both / Skip*
  (Keep both makes `name2.pas`); an identical file is not added twice; Windows
  line breaks are tidied; the 8-file cap holds; an untouched "Hello, world"
  starter is removed when their own code arrives. Anything refused is listed at
  the end, never dropped silently.
- **Download all builds a real .zip in the browser with no library** (a small
  writer in `console.js`, stored not compressed). **Bug found by testing it:** the
  first version measured the central-directory size in the middle of writing the
  end record and came out 12 bytes too big; an independent reader caught it.
  Fixed, and the bytes the *browser* produced were then opened with Python's
  `zipfile` (every CRC good, empty file, accented name and euro sign included).
- **Not built:** files a *program writes* (`Rewrite`) live only for that run and
  cannot be downloaded yet - that is the "phase two" return-the-files step from the
  original design.

**Help.** A **?** button covers the whole panel with a scrolling Help page (Esc,
the ×, or hiding the console closes it; Tab stays inside while it is open).
- **The words are in `content/console/help.php`**, like lesson content, rendered by
  `ConsoleHelpHtml()` (everything escaped first; only `**bold**`, `` `code` `` and
  `[[Key]]` become markup). Seven sections: the console in one minute; your files;
  **the layout check**; code completion; Analysis; colours and space; keys.
- **The layout check section says plainly it is not standard:** programs like
  Lazarus run untidy code without complaint, this does not, on purpose - then what
  is checked, *why* (people read your code; it is a habit; Pascal itself does not
  care), that the **Layout fixes** tab opens by itself, that **Check layout**
  checks without running, that it never hides a real compiler error, and that an
  exercise is only checked for what has been taught.
- **Voice:** written to writing-style.md and content-voice-and-pedagogy.md §1 -
  short sentences, "you", bullets, hyphens; no "house style", "convention",
  "genuine", "for real", "binds" or dashes (checked by test).
- **It states facts that can go stale** - 15 minutes and 5 minutes (the
  launcher's limits), 8 files, the layout rules. The file's header lists where
  each comes from: change the console and change the help in the same commit.
- **Not done:** Help does not open by itself the first time; easy to add if you
  want it (it would need remembering per pupil, not per browser).

**Tested this round:** Node 16 (console logic incl. zip) + 20 (syntax); PHP
`bin/check-codestyle.php` 35; in a real browser: light/dark colours and 121-point
alignment (17), Help (20), files - menu, download, open, refusals, clashes, cap
(18), Saved tick, Ctrl+S, drag-and-drop, reload from server (13), and the whole
earlier regression in **both** themes (24); contrast for every pair; screenshots.
**Not yet on the test server.**

**Known consequences and gaps:**

- The `code` blocks' old stored **results** (output, compiler text, celebration,
  AI style comment) are no longer produced while the console is on: it shows the
  program's real live output instead. **The "well done" celebrations and the AI
  house-style note are not in the console yet** - they hang off the queue result.
  If you want them back for exercise runs, they need a hook on the `compile`
  message / end-of-run; a follow-up, not built.
- ~~No syntax highlighting~~ (superseded the same day - see above) (a plain textarea with line numbers, on purpose:
  what they type is exactly what is sent, nothing between them and their code).
  A highlighter is a possible later addition; the screenshot has one.
- The console is offered only in the **Pascal** course (`ConsoleAvailable()`).
- xterm.js is 489 KB, not the ~300 KB estimated before it was fetched.

**How it was tested (local, Windows, real PHP, real browser; no daemon exists
here so the WebSocket was scripted):** 7 Node tests for the logic (`node
public/assets/console.test.js`); 14 browser flows (copy into an empty console, copy
over own work, new tab, Run -> prompt -> typing -> answer -> end, Stop, layout
problems, a refusal, a wrongly named unit, a dropped connection); 11 requests
through the real endpoints (validation, wrong course, oversized, exercise vs free
layout rules, recording); persistence across a reload; layout geometry at
1400x900 (lesson and its bottom bar sit beside the panel, no horizontal scroll).
**Not yet tested against the real daemon through a browser** - that needs the
branch on the test site.

## Installed and proved on the test deployment (19 September 2026)

`install-live.sh test` was run by Chris on the test deployment
(`/var/www/itcoder-v2-test`, port 8082). Checked afterwards by Claude, read-only
plus test runs:

- `itcoder-live@test` **active and enabled**, running as `itcoder-live`; control
  socket `/run/itcoder-live-test/control.sock` is `srw-rw---- itcoder-live:www-data`
  in a `0750` directory, as designed; websockets 10.4; `nginx -t` clean with the
  one `include` line (backup `itcoder-v2-test.bak-2026-09-19-061716` kept); live
  site and test site both still answer 200.
- The three installed root-owned files are **byte-identical to the repo** (same
  sha256 as `bin/live/runner.py`, `supervisor.py`, `live-sandbox.sh` on the
  test site).
- **`smoke.py`: 10/10** - a live `Readln` conversation through nginx and a real
  WebSocket, a used session id refused, an unknown one refused, a foreign Origin
  refused (403), Stop ends a runaway program, nothing left behind. Mean compile
  0.24 s.
- **`live-check.py` as `itcoder-live` through the real `sudo` path and the
  installed launcher: 20/20.** (Earlier notes say 21: one check that could never
  fail was removed on 19 September, so 20 is the honest count.)
- **Slice confirmed:** a session's unit is in `itcoder-pupils.slice` with
  `CPUQuota=50%`, `MemoryMax=128M`, `TasksMax=32`, `RuntimeMax=16min`; the slice
  itself is `MemoryMax=1.5G`, `MemoryHigh=1.25G`, `CPUQuota=200%`, `TasksMax=512`.

**Still NOT proven:** whether the CPU quota actually holds under a program that
burns CPU for a long time (the `stop` test proves it can be killed, not that it
is throttled); `TemporaryFileSystem` (not used - see the launcher); the compile
burst of a class at once; nothing has been run from a browser, because there is
no browser console yet. `/opt/itcoder-livetest/` (my throwaway test copies) is
still on the server; it holds a superseded launcher and is safe to remove once
the load test is done.

## Installing on the server

Everything is in `bin/live/deploy/`, uploaded with the rest of `bin/` by
`tools/publish-test.py`. **Dry-run-checked on the real server on 19 September
2026, nothing installed:** the installer's shell syntax, `visudo -cf` on the
sudoers file, `systemd-analyze verify` on the slice and the service, and the
nginx edit applied to a copy of the real test block (exactly one added line,
nothing else changed). **The installer itself has not been run**; run it, then
read its smoke-test output.

    # 1. put the branch on the test site (Chris's Windows machine)
    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"

    # 2. on the server (ssh gnomemedia), as root
    bash /var/www/itcoder-v2-test/bin/live/deploy/install-live.sh test

Then the sandbox gate as the daemon's user, through the real `sudo` path (the
one thing the smoke test does not do):

    cd /opt/itcoder-livetest   # or wherever live-check.py has been copied
    sudo -u itcoder-live python3 live-check.py sudo -n /usr/local/bin/itcoder-live-sandbox.sh run pascal

`live` is the same with `live` for the instance, and prints the one nginx line
to add by hand (it never edits the live server block). Nothing is visible to
pupils until `'liveConsole' => true` is put in that deployment's `config.php`.

**Still to do in the publishing tools:** `tools/publish-test.py` does not yet
install/prove the live files or record their hashes the way it does the compile
sandbox, and `deploy-live.py` has no gate for them. Until that exists, the
installer above is the only path, and it is manual on purpose.

## Server sizing note (for later, from 18 September 2026)

**Superseded in part - see "Measured cost of a session" above: Pascal sessions
cost ~12 MB, not ~5.** The rest of this note stands.

Estimates, not measurements: at ~4,000 registered pupils assume 10-15% online at
peak and ~40% of those with a console open, i.e. 150-250 live sessions. Pascal
sessions are close to free in RAM. Java sessions (later) are ~12-16 GB for 200.
Plan a **separate executor server** when Java arrives, so a pupil's runaway
program can never touch marks or sign-in: the daemon is already a separate
service, so the site talking to it over the network is a config change, not a
redesign. Marking (serial, one answer at a time) and SQLite write contention
become the bottlenecks before the executor does.

## Published to live - 19 September 2026

The whole FullConsole branch (console code, layout precheck, analysis queue, themes,
files, Help, the "+" button, and the content edits other chats made) went out with
`publish-test.py` then `deploy-live.py`. Both finished ALL STEPS OK; sandbox checks
passed on test and live.

The console is **still OFF on live**: `config.php` there has no `liveConsole` key and
the `itcoder-live@live` daemon is not installed (the deploy scripts do neither). Pages
look and work as before. To switch it on later: install the daemon for live
(`bin/live/deploy/install-live.sh`), prove it with `tools/live-check.py`, then add
`'liveConsole' => true` and `'liveControl'` to the live config - with Chris's say-so.

FullConsole has not been merged into main or next-work.

## Switched on for live - 19 September 2026

Chris asked for it ("add the console to live"), so, in this order:

1. `bash /var/www/itcoder/bin/live/deploy/install-live.sh live` (root, on the server): the
   `itcoder-live@live` daemon (port 8771, control socket
   `/run/itcoder-live-live/control.sock`), its env file and the nginx snippet. Its own
   smoke test: **10/10** (direct to the daemon).
2. The one include line, `include snippets/itcoder-live-live.conf;`, added by hand to
   `sites-available/itcoder` (the 443 block), before `location /assets/`. Backup
   `itcoder.bak-2026-09-19-130042`, `nginx -t` clean, reload. (It landed between the
   `/assets/` comment and its block - harmless, cosmetic.)
3. The smoke test again through the public route, `wss://itcoder.co.za` with
   Origin `https://itcoder.co.za`: **10/10**. Runner, supervisor and launcher on the server
   are the same three files (sha256 `a4701c76`, `d9671d01`, `9b97bdd5`) that passed
   `live-check.py` 20/20 on test.
4. `'liveConsole' => true` and `'liveControl' => 'unix:/run/itcoder-live-live/control.sock'`
   appended to the live `config.php` (backup `config.php.bak-2026-09-19-before-console`,
   permissions kept 640 www-data).

**`live-check.py` was NOT re-run on live**: the permission classifier refused the step
(upload to `/opt/itcoder-livetest` and run it through `sudo -u itcoder-live`). The launcher it
tests is the shared, byte-identical copy already proven on test, so nothing new is untested,
but re-run it when convenient:

    sudo -u itcoder-live python3 live-check.py sudo -n /usr/local/bin/itcoder-live-sandbox.sh run pascal

Checked after: the site 200, `/api/live-start.php` answers 401 without a session (the PHP
route is live), `/live/...` reaches the daemon (426 without a WebSocket upgrade), both
daemons and nginx/PHP-FPM active, error logs quiet. **Not seen: a real pupil session in a
signed-in browser on live** - sign-in there is Google only. Try one Run yourself.

To switch it off: `'liveConsole' => false` in the live `config.php`. To remove it:
`systemctl disable --now itcoder-live@live` and delete the include line.

## The Analysis tab's rules (Chris, 19 September 2026)

`lib/analyse.php`. The analysis judges the code **on its own**, and its emphasis
is readable code:

1. **No analysis until the layout passes.** `api/console-analyse.php` runs the
   console's layout check first; code that would not get past Run (no program
   name, single-letter names, two instructions on a line) is not sent to the AI.
   The pupil is taken to the Layout fixes tab, and no paid call is made.
2. **What it weighs, in order:** one concept per line; don't repeat yourself (loops,
   procedures, functions - **only once a lesson has taught them**); comments on
   complex code; meaningful names; the layout of what the program prints; **an empty
   line between steps** (it names the line to add it after); does it do what its
   names and comments say; things that could go wrong in the code as written.
3. **Building a string in a variable before displaying it is praised**, never
   "improved away".
4. **It must not:** comment on a variable's type (an age being an Integer) unless it
   causes a real problem; talk about what would happen if the program did something
   else (asking for input); suggest features; say the code will not compile, or is
   wrong, because it uses something the lessons have not covered. The "taught so far"
   list limits what it may RECOMMEND, it is never a test of what the pupil wrote.
5. **House rules apply to everything it writes:** any code it quotes or names it
   suggests follows the house style, as far as it has been taught.
6. **In the browser:** pressing Analyse clears the box and shows "Working" with
   animated dots until the answer replaces it.
7. Analyses stored before the prompt changed are not reused for identical code
   (`AnalysisPromptSince()`); they are asked again.
