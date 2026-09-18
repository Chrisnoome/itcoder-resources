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
| Rough live cost | ~5 MB, ~0.3 s compile | ~60-80 MB, ~1.5 s compile |

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
   18 September 2026) rests on data. **Expect** ~5 MB per idle Pascal session
   and ~0.3 s per compile; these are estimates until measured.

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

## Server sizing note (for later, from 18 September 2026)

Estimates, not measurements: at ~4,000 registered pupils assume 10-15% online at
peak and ~40% of those with a console open, i.e. 150-250 live sessions. Pascal
sessions are close to free in RAM. Java sessions (later) are ~12-16 GB for 200.
Plan a **separate executor server** when Java arrives, so a pupil's runaway
program can never touch marks or sign-in: the daemon is already a separate
service, so the site talking to it over the network is a config change, not a
redesign. Marking (serial, one answer at a time) and SQLite write contention
become the bottlenecks before the executor does.
