# The Pascal compile subsystem (queue path)

One-shot compile-and-run of pupils' Pascal in a systemd sandbox. The live
console ([live-console-design.md](live-console-design.md)) reuses its sandbox
principles for interactive runs; this queue path remains for `code` blocks
when the console is off, for deterministic checks, and for the Windows testbed.
Live on the server; installed and proven only through
[publishing.md](publishing.md).

| Piece | Where |
|---|---|
| Table | `codeSubmissions` (one row per pupil per block, latest run; + `simulatedInput`) |
| Sandbox | `bin/compile-sandbox.sh` -> installed `/usr/local/bin/itcoder-compile-sandbox.sh` |
| PHP (both machines) | `lib/compile.php` (`CompileLimits()`, `FrameSandboxStdin()`, `ProcessCodeSubmission()`, `TidyCompilerOutput()`, `RunBounded()`, `CodeCelebrations()`) |
| Worker | `bin/compilequeue.php` (cron each minute; loops picking work up within ~250ms until 48s) |
| API | `public/api/compile.php`, `compile-result.php` |
| Terminal | `lib/terminal.php` |
| Server check | `tools/sandbox-check.php` (run by publish-test.py and deploy-live.py) |

## The sandbox

`sudo -n /usr/local/bin/itcoder-compile-sandbox.sh [--tty]` (www-data cannot
call `systemd-run` itself - "Interactive authentication required" - and a
polkit rule would be broader than one sudo line). Inside one transient
`systemd-run --pipe --wait` unit: `DynamicUser` (implies `PrivateTmp`),
`PrivateNetwork`, `ProtectSystem=strict`, `ProtectHome`, `NoNewPrivileges`,
`InaccessiblePaths=/var/www /var/backups /var/log`, `ProtectProc=invisible`,
`ProcSubset=pid`, `TasksMax=32`, memory and time limits; compile then run in
the unit's private `/tmp` (on disk, exec allowed; cleaned up automatically).
Run 5s, output 64 KB, 128M memory.

Load-bearing facts, all verified on the server:
- Unprivileged user namespaces are blocked; `DynamicUser` via systemd works.
- **Read-only is not unreadable** - without `InaccessiblePaths`, a pupil
  program read `content/pascal/lesson02.php` (every answer). Now `Runtime
  error 5`; `{$I config.php}` gives `Cannot open include file`; no network.
- **Source and input arrive on stdin, length-framed**, never as a file path
  (`PrivateTmp` hides staged files; a root-created dir isn't writable by the
  dynamic uid; `/run` is `noexec`; `StateDirectory` persists):
  `<sourceBytes>\n<source><inputBytes>\n<input>`, read with `read -r` and
  `dd bs=n count=1 iflag=fullblock` (**fullblock is required**; `head -c` on a
  pipe can swallow the next payload). `FrameSandboxStdin()` and the script
  always change together.
- **Never write `${BRACED}` in the inner script** - systemd expands it to empty
  before bash sees it. Use `set -o pipefail` and plain `exit $?`.
- Every limit passed into the unit needs its own `--setenv` (a missing
  `INPUT_LIMIT_BYTES` once made every program read empty input).
- Limits are hardcoded in the script, not taken from the environment;
  `CompileLimits()` keeps copies for PHP's pre-checks - change both.
- Output framing: first line `ITCODER 1 <compileRc> <compileBytes>` (a program
  can't forge a byte count written before it runs). Output is capped three
  ways (`head -c` SIGPIPE, `RunBounded()`, a final trim).
- `'compileSandboxed'` defaults to true when absent. `sudoers` allows the bare
  call and `--tty` only; the script validates its argument too. Always
  `visudo -cf` a candidate, `visudo -c` after. Removing
  `/etc/sudoers.d/itcoder-compile` switches compiling off cleanly.
- fpc runs `-Mobjfpc -O1` (platform.md decision 24).

## PHP side

- **Anyone signed in and enrolled may compile** (server CPU, not API tokens).
  One compile in flight per pupil, platform-wide, **bounded to 30s** so a dead
  worker can't lock pupils out. The worker's five-minute sweep recovers stuck
  rows.
- **Testbed:** no systemd, no cron - `'compileInRequest' => $isLocal` compiles
  in the request with no isolation, through the same `ProcessCodeSubmission()`.
  Never a server setting. PHP reads output via files, not pipes
  (`stream_select()` doesn't work on Windows pipes).
- `TidyCompilerOutput()` removes fpc's banner and the `ppcx64 returned an
  error` line (our path); everything else is fpc's own text. Warnings on a
  program that compiled are shown (amber).
- **Layout is checked first** (`lib/codestyle.php`), refusing before a row is
  made. **Only flag what fpc accepts** (the "Fix the errors" exercise must reach
  the compiler) and only what has been taught. A missing semicolon before
  `End`/`Until` compiles, so it is ours to flag; elsewhere it's fpc's. Two
  instructions on a line = code after a semicolon, or `Begin`/`End` sharing a
  line. Per block: nothing = `tabs`, `indent`, `oneInstructionPerLine`,
  `programHeader`; `'styleRules' => [...]` = exactly those; `'checkStyle' =>
  false` = none. `reservedWords` exists but is off by default. The program
  name vs file name can't be checked (always compiled as `p.pas`).
  `StyleNoticeIntro()` holds the pupil wording (never "house style").
- **Celebration** (`CelebrationFor()`, `CodeCelebrations()`) only when the
  program compiled, ran and printed something - never for silence, timeout or
  runaway output. Chosen server-side, not stored.
- **Simulated input:** `'takesInput' => true` adds "What will you type when
  this runs?". Verified: two `Readln`s read two lines; `Read` crosses line
  breaks; `Read` then `Readln` leaves the name empty (the lesson's trap); no
  input -> the variable is 0.

## The virtual DOS terminal (`lib/terminal.php`)

Used when the program calls Crt screen routines, prints more than 24 rows or
80 columns, or the block says `'terminal' => true`. Crt down a pipe is a silent
no-op, so `WantsTty()` (before the run) passes `--tty` and the program runs
under `script -qec`; `ShowAsTerminal()` (after) only affects display. Neither
is stored. `TerminalScreen()` is the one emulator (colours, `ESC[y;xH`, clear,
erase-line, tabs, backspace, CR; unknown dropped); `app.js` only draws; reloads
render from `data-screen` with a `<pre>` fallback. `AnsiToDosColour()` maps
ANSI to DOS numbering (red/blue swap).

Known limits:
- **On the Windows testbed a Crt program prints nothing at all** when stdout is
  redirected (fpc's Windows Crt) - Crt output can only be checked on the test
  site.
- **`Sound`/`NoSound` never work here** (a pty isn't a Linux console, and there
  is no audio channel). `Delay`'s pause isn't visible in a one-shot run. Lessons
  say so and point to Lazarus.
- Under `--tty`, `Readln` and `ReadKey` receive the input but then wait until
  killed (sandbox-check NOTE lines). The live console handles live keys.

## Marked code questions - not built

`code` blocks are unmarked and excluded from `LessonAutoMarkedQuestions()`. If
built: (a) auto-marked output comparison via `MatchesTypedAnswer()` with the
usual two-attempt doubling; (b) AI/human rubric marking including the flat
1-mark layout deduction. Both through `AutoMarkedEarned()`, even totals, shown
marks = awardable marks.

## Not yet tested

- **Fork bomb with `TasksMax`** - the permission classifier refuses it; Chris
  runs it after `ssh gnomemedia`:

      uptime; ps -eL --no-headers | wc -l
      timeout 8 systemd-run --pipe --quiet --wait \
        --property=DynamicUser=yes --property=TasksMax=32 \
        --property=RuntimeMaxSec=3 --property=MemoryMax=128M \
        -- bash -c ':(){ :|:& };: ; sleep 3'; echo "exit=$?"
      uptime; ps -eL --no-headers | wc -l
      systemctl is-active nginx php8.3-fpm
      curl -s -o /dev/null -w '%{http_code}\n' https://itcoder.co.za/

  (`sleep 3` keeps the parent alive so `TasksMax` is really exercised.) Expect
  a return in 3-8s, task count back to normal, the site still 200. If not,
  lower `TasksMax` in the script.
- **A lockstep class burst** (one compile ~0.3s; 30 serially ~9s - arithmetic).
