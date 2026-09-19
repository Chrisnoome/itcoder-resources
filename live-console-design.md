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
