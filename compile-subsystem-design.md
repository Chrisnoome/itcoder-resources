# The Pascal compile subsystem

Written 11 September 2026 by the Pascal chat after testing the sandboxing
question directly against the live server (not guessed); **built 12 September
2026**. Start at [README.md](README.md) if you haven't. This file assumes
you've read [vps-access.md](vps-access.md), especially "Before pupil code goes
anywhere near that compiler."

**Status, 12 September 2026: built, tested locally end to end, and the sandbox
itself re-validated against the live server. Not deployed anywhere.** Nothing
under `/var/www` has been changed - not the live site, not the test deployment.
Deploying is Chris's call and the commands are at the bottom of this file.

What exists now, all in `AIPascalCourse`:

| Piece | Where |
|---|---|
| `codeSubmissions` table | `schema.sql` (+ `$expected` in `bin/backup.php`) |
| The sandbox itself | `bin/compile-sandbox.sh` |
| PHP side, both machines | `lib/compile.php` |
| Queue worker | `bin/compilequeue.php` |
| API | `public/api/compile.php`, `public/api/compile-result.php` |
| `code` block type | `lib/content.php`, `public/lesson.php`, `assets/app.js`, `assets/style.css` |
| First real use | `content/pascal/proofoflife.php` - two blocks, `c1HelloWorld` and `c2FixTheErrors` |

**Two things were found while building that the design below had wrong or
missing. Both are written up under "What building it changed" - read that
before touching `bin/compile-sandbox.sh`.**

## The question that was open, now answered

`vps-access.md` flagged that `bubblewrap` isn't installed and Ubuntu 24.04's
`kernel.apparmor_restrict_unprivileged_userns=1` blocks the unprivileged user
namespaces it needs, and said: test before designing around it. Tested
directly on the live server, 11 September 2026:

- **Confirmed**: an unprivileged user creating its own user namespace fails -
  `sudo -u nobody unshare --user --map-root-user echo` gives `Operation not
  permitted`. Bubblewrap, firejail, or anything else that works this way is a
  dead end on this box without an AppArmor profile change.
- **`systemd-run --property=DynamicUser=yes` works fine**, because the
  request comes from systemd (PID 1, already privileged), not from an
  unprivileged process calling `unshare()` on its own behalf - a different
  code path the sysctl doesn't touch. This is the way in.

## The validated design

Every compile, and every run of the resulting binary, goes through the same
wrapper - one transient scope, both steps as one shell script, so nothing
persists between them and nothing needs a second handoff:

```
systemd-run --pipe --quiet --wait \
  --property=DynamicUser=yes \
  --property=PrivateNetwork=yes \
  --property=ProtectSystem=strict \
  --property=ProtectHome=yes \
  --property=NoNewPrivileges=yes \
  --property=RuntimeMaxSec=5 \
  --property=MemoryMax=64M \
  -- bash -c 'cd /tmp && cat > p.pas && fpc -O1 p.pas && ./p'
```

**That was the design as tested on 11 September. It is not what shipped** - it
is missing the `InaccessiblePaths=` lines that turned out to matter (finding 2
below), and an inner script written this way cannot report the program's exit
code back (finding 1). `bin/compile-sandbox.sh` is the real thing; read it
rather than copying the block above.

Source code is written to the process's **stdin** (`--pipe` wires your own
stdin through to the transient unit), which the inner `cat > p.pas` captures.
**Not a shared file path** - see the two failed approaches below, both of
which taught something worth knowing.

### Verified, one at a time, on the real server

- **Isolation actually isolates.** `id` inside the sandbox shows a random
  `run-uNNNN` user with no relation to `www-data`. `PrivateNetwork` blocks
  network entirely (`curl` inside gets `RC=6`, cannot resolve anything).
  `ProtectSystem=strict` + `ProtectHome` mean `cat
  /var/www/itcoder/config/config.php` gets `Permission denied` - both a
  direct read attempt and, specifically, Pascal's own `{$I
  /var/www/itcoder/config/config.php}` include directive, which is the exact
  attack `vps-access.md` named. Confirmed: `Fatal: Cannot open include file`.
- **Resource limits are real, not advisory.** `MemoryMax=64M` against a
  Python process actually allocating 200 MB gets killed (no
  `ALLOCATED-OK` printed - exit 1). `RuntimeMaxSec=2` against `sleep 10`
  returns control in ~3 seconds, not 10.
- **`/run` is mounted `noexec` on this server.** `RuntimeDirectory=` (which
  lives under `/run`) compiles a binary fine but then refuses to execute it -
  `Permission denied`, confirmed by `mount` showing `tmpfs on /run/poc5 ...
  noexec`. This is why the design above uses plain `/tmp`, not
  `RuntimeDirectory=`.
- **`DynamicUser=yes` implies `PrivateTmp=yes`.** The sandboxed unit's `/tmp`
  is a private, empty, per-unit mount backed by the real disk (confirmed via
  `/proc/self/mountinfo`: `ext4 /dev/sda1`, no `noexec`) - not the host's
  `/tmp`, and not the `noexec` `/run` tmpfs either. This is *why* a shared
  staging file didn't work (see below) and why stdin is the right way to get
  source code in: nothing needs to be visible on a shared filesystem path at
  all. It also means cleanup is automatic - the private `/tmp` is torn down
  when the transient unit exits. No directory to remember to delete.
- **A full compile-and-run actually worked**, end to end, with real FPC
  3.2.2 (`fp-compiler`, installed and confirmed during this test - see
  `vps-access.md`'s install command): `Writeln ('Proof of life')` compiled,
  ran, and printed correctly inside the fully-isolated sandbox above.

### Two things that looked reasonable and didn't work - useful to know why

- **Pre-creating a working directory as root, then `ReadWritePaths=` to it,
  fails.** `mkdir /tmp/x` as root gives `755 root:root`; the `DynamicUser`'s
  random unprivileged uid can't write into that regardless of
  `ReadWritePaths=` granting the *mount namespace* permission - Unix file
  permissions still apply on top. Exit code 226 (`EXIT_NAMESPACE`)  with no
  compiler output at all was the symptom. Lesson: don't hand the sandbox a
  directory somebody else already owns.
- **`RuntimeDirectory=` and `StateDirectory=` both correctly solve the
  ownership problem** (systemd creates and chowns them for the dynamic
  uid), but `RuntimeDirectory=` sits on the `noexec` `/run` and
  `StateDirectory=` (`/var/lib/private/<unit>/`) works but **persists after
  the unit exits** - it's meant for state that outlives one run, so it needs
  manual cleanup if used this way. Plain `/tmp` (below) beats both: it works
  and cleans itself up.

## What building it changed

Two findings from building and re-testing on the live server, 12 September
2026. Both are the kind that look like nothing and cost an afternoon.

### 1. systemd expands `${BRACED}` in a unit's command line before bash sees it

The inner script is handed to `systemd-run ... -- bash -c "$INNER"`. systemd
does its own variable expansion on that command line first, and it expands the
**braced** form from the unit's environment - where a shell variable set at
runtime does not exist, so what bash finally receives is an empty string.
Unbraced `$VAR` is left alone and arrives intact. Proved on this server:

```
systemd-run ... -- bash -c 'X=hello; echo "[${X}] [$X]"'   ->  [] [hello]
bash           -c 'X=hello; echo "[${X}] [$X]"'            ->  [hello] [hello]
```

This broke the first working version. The inner script ended with
`exit "${PIPESTATUS[0]}"` to pass the program's exit code out; systemd blanked
it, and **every** run - correct programs included - exited 2 with
`exit: : numeric argument required`, while still looking nearly right, because
the compile and the program's output had already been printed by then. A
timeout was indistinguishable from a success.

The fix is `set -o pipefail` and a plain `exit $?`, so no braces are needed at
all. **Never write the braced form in that inner script.** systemd's escape for
a literal dollar is `$$`, but not needing it is safer.

### 2. Read-only is not the same as secret - `/var/www` was readable

`ProtectSystem=strict` makes the filesystem read-only. It does **not** make it
unreadable, and the sandbox's dynamic uid counts as "other" for Unix
permissions. `config/` and `data/` were already safe, because a deploy chmods
them 750 owned by `www-data` - but everything else under `/var/www` is 644.

Tested on the live server: a pupil's Pascal program opened
`/var/www/itcoder/content/pascal/lesson02.php` and read it straight back.
**That file is every quiz answer, every rubric and every explanation in the
course.** The original design checked `config.php` by name, found it blocked,
and stopped - this is the hole that left.

Closed with `InaccessiblePaths=` at the mount level, rather than by trusting
file permissions to stay right forever: `/var/www`, `/var/backups`,
`/var/log`. Nothing under any of them is needed to compile. Re-tested after:
reading the lesson file gets `Runtime error 5`, and `ls /var/www` gets
`Permission denied`.

`ProtectProc=invisible` and `ProcSubset=pid` went in at the same time, so the
unit cannot see other processes' command lines either.

### Verified end to end on the live server, 12 September 2026

Every one of these run through `bin/compile-sandbox.sh` as it now stands:

| What was run | What happened |
|---|---|
| `Writeln ('Proof of life')` | printed it, exit 0, 0.3s |
| Missing semicolon | exit 10, real fpc error, no path of ours in it |
| Compiles but prints nothing | exit 0, fpc's "Note: ... never used" shown |
| `While True Do n := n + 1` | exit 124 at 5.2s - `timeout` caught it |
| `While True Do Writeln ('x')` | capped at ~65 KB in 0.9s, killed by SIGPIPE |
| Open `config/config.php` and read it | `Runtime error 5` |
| `{$I /var/www/itcoder/config/config.php}` | `Fatal: Cannot open include file` |
| Open the pupil database | `Runtime error 5` |
| Write into `/var/www/itcoder/public` | `Runtime error 5` |
| Read `content/pascal/lesson02.php` | `Runtime error 5` (was readable before the fix) |
| `ls /var/www` | `Permission denied` (listed four directories before the fix) |
| `curl https://example.com` | no network - `000`, curl exit 6 |
| `id` | `uid=62351(run-u657)`, nothing to do with `www-data` |

### 3. The testbed has no cron, and the in-flight guard turned that into a lock-out

Found by Chris the moment he tried it, 12 September 2026: the first code block
just hung. Two separate faults, one on top of the other.

**The row was queued and nothing existed to pick it up.** Windows has no cron,
so `bin/compilequeue.php` never ran. Everything worked during development only
because the worker was being started by hand - which made local testing
possible but not actually usable. Fixed with `'compileInRequest' => $isLocal`
in `config.php`: on the testbed `public/api/compile.php` does the work in the
request itself, through the same `ProcessCodeSubmission()` in `lib/compile.php`
that the worker uses, so the two cannot drift. The client is unchanged and
still polls - it simply finds the answer already waiting on its first try. Tied
to `$isLocal` and never a switch to flip on the server, where thirty pupils
pressing Run at once is exactly the pile-up the queue exists to prevent.

**The "one compile in flight per pupil" guard then made it permanent.** The
check was an unbounded "does this pupil have anything `queued` or `running`?",
so once a row stuck, every further press was refused - including the press that
would have recovered. Now bounded to 30 seconds: after that a pupil may try
again regardless, and the worst it costs is one extra compile. **This mattered
on the server too**, not just the testbed - any worker outage would have locked
every pupil out of compiling until someone noticed, and the five-minute stuck
sweep only ever covered `running`, never `queued`.

The general lesson, worth keeping: a guard that depends on a background worker
being alive must have a timeout, or it becomes an outage amplifier.

## Layout is checked before anything is compiled

Chris, 12 September 2026: a `code` block checks formatting and indentation
first, says what is wrong in plain words, and **refuses to compile** until it
is fixed. `lib/codestyle.php`, called from `public/api/compile.php` before the
row is ever queued - a refused program creates no row, uses no CPU, and does
not consume the pupil's one-compile-in-flight allowance.

Two rules govern it, and both matter more than the checks themselves.

**It may only ever flag something the compiler would happily accept.** If
`fpc` would reject it, `fpc` rejects it - because reading real compiler errors
is the thing the lesson teaches. "Proof of life" ships `c2FixTheErrors`, whose
starter is deliberately missing its `End.` and a semicolon and which tells the
pupil in so many words to press Run first and read what Free Pascal says. A
layout check that refused that program would destroy the exercise it sits
inside. Both real starters were tested against the checker and pass it
untouched.

That rule turns out to cut **through** the semicolon question rather than
around it, which is worth knowing before anyone "improves" this. A semicolon
in Pascal is a separator, not a terminator, so:

| Where the semicolon is missing | `fpc` | Whose job |
|---|---|---|
| Last instruction before `End` / `Until` | compiles it happily | **ours** - flagged |
| Anywhere else | `";" expected but ...` | the compiler's - untouched |

Both verified against real FPC 3.2.2, 12 September 2026. So the checker catches
`writeln ('test')` sitting just above `End.` - sloppy, but legal - while
`c2FixTheErrors`, whose missing semicolon has another instruction after it,
still sails through to the compiler and still gets the genuine error the lesson
is built on. No per-block exemption was needed.

Counting semicolons is also not how to find two instructions on one line - the
first version did that and missed `Program Hello;Begin` (Chris, 12 September
2026), because two instructions can share a single semicolon when the second
one needs none. It now asks whether any code FOLLOWS a semicolon, and whether
`Begin` or `End` are sharing their line with anything else.

**It may only check what the course has already taught**
(content-voice-and-pedagogy.md §4). That is why the rule set is a per-block
field rather than the whole of `pascal-house-style.md`:

| Field | Effect |
|---|---|
| *(nothing)* | `tabs`, `indent`, `oneInstructionPerLine`, `programHeader` |
| `'styleRules' => [...]` | exactly those checks, nothing else |
| `'checkStyle' => false` | no checking at all for that block |

`reservedWords` (capitalising `Begin`, `End`, `Var`, ... - house style §2) is
implemented but **off by default**: every example in "Proof of life" writes
them that way, but the lesson never teaches it as a rule, so grading it there
would be retroactive. A later lesson that does teach it adds the word to its
own `styleRules`. `Writeln`/`Write`/`Readln` are deliberately not in that list
- they are ordinary procedures, not reserved words.

One house-style rule **cannot** be checked and is not attempted: §1 wants the
declared program name to match the source file name, and the sandbox always
compiles as `p.pas` whatever the pupil calls their program. Only the presence
of a `Program` line is checked.

**The wording of every message** follows content-voice-and-pedagogy.md §1: the
words "house style" and "convention" never appear in anything a pupil reads.
`StyleNoticeIntro()` holds the required sentence in one place - what is being
checked (how you format and lay out your code, matching what you have been
taught) and why (a habit being built, not a rule Pascal imposes) - and the
client renders it from the server's copy rather than repeating it.

## The virtual DOS terminal

Chris, 12 September 2026. Most exercises print a line or two and the plain
output panel suits them. Three things get a scrollable 80x25 DOS terminal
instead - `lib/terminal.php`:

1. the program used Crt's screen routines (`GotoXY`, `WhereX`, `WhereY`,
   `TextColor`, `TextBackground`, `Delay`, `ClrScr`)
2. it printed more than a screenful - over 24 rows, or a line wider than 80
3. the block said so with `'terminal' => true`

**Why it needs a pseudo-terminal.** Free Pascal's Crt unit asks the OS whether
it is writing to a terminal. Down a pipe the answer is no, and every visual
call becomes a *silent* no-op - the text appears, uncoloured, with no hint why.
Given a pty, the same program emits real ANSI. So the sandbox script takes one
optional argument, `--tty`, which runs the compiled program under `script -qec`.
Both forms are listed in `/etc/sudoers.d/itcoder-compile` as exact invocations,
and the script validates the argument itself as well - anything other than a
bare call or `--tty` is refused twice over.

**Two decisions at two different times**, and they must not be conflated:
`WantsTty()` runs before the program does and changes *how* it runs;
`ShowAsTerminal()` runs afterwards and changes only how the result is shown.
Long output qualifies for the second and never needs the first. Neither is
stored - both are worked out again from the block and the saved output, so a
reload and a fresh run cannot disagree.

**One emulator, one renderer.** `TerminalScreen()` in PHP plays the raw bytes
back onto a screen (colour, `ESC[y;xH` positioning, clear-screen,
erase-to-end-of-line, tabs, backspace, carriage returns; anything unrecognised
is dropped rather than printed) and returns rows of coloured runs. `app.js`
only draws them - it never parses an escape sequence. `lesson.php` prints the
same structure into a `data-screen` attribute on a reload and lets `app.js`
draw that too, with a plain-text `<pre>` inside as the no-JavaScript fallback.
That way there is one emulator and one renderer rather than a copy of each in
both places.

**ANSI and DOS disagree about colour numbers** - ANSI has blue at 4 and red at
1, DOS the other way about - so `AnsiToDosColour()` maps between them. Skip it
and every red program prints blue.

Verified on the server: `TextColor(Red)` renders `tf4 tb0`, yellow-on-blue
`tf14 tb1`, `GotoXY(10,6)` puts light green at column 10 of row 6; a one-line
program stays in the plain panel; 40 lines of output switches to the terminal
and scrolls inside a 431px box; and a reload rebuilds all of it from the stored
screen with the fallback swapped out.

## A program that works is congratulated

Chris, 12 September 2026: a working run gets a bold, highlighted line with an
icon above "Your program printed", and the wording varies - ten phrases in
`CodeCelebrations()` in `lib/compile.php`, picked fresh each run.

**"Worked" deliberately means more than "compiled".** `CelebrationFor()` stays
silent for a program that built and then printed nothing, and for one stopped
on the time limit or cut off for printing without end. The whole argument of
"Proof of life" is that a program with no output gives you no way of knowing it
did anything - cheering one would undercut the point the lesson makes two
paragraphs further up. It is also, precisely, the moment that lesson wants a
pupil to notice.

Chosen server-side and sent with the result, not written into `app.js`, for the
same reason everything else about a code result is: `public/lesson.php` renders
a stored result on a reload and `app.js` renders it after a run, and the two
must not be able to disagree about whether a run was a success. The phrase
itself is not stored, so a reload can show a different one - deliberate, and
harmless.

### A `Crt` program shows NO output at all on the Windows testbed - not just uncoloured

Found 13 September 2026, building lesson 3 ("Making it pretty", the `Crt`
enrichment lesson). The design note above says a `Crt` call down a plain pipe
is "a *silent* no-op - the text appears, uncoloured" - true on the server's
Linux sandbox, where this was verified. **On Chris's Windows testbed it is
worse: nothing prints at all, not even the plain `Writeln` lines either side
of the `Crt` calls**, whenever the program's stdout is redirected rather than
a real console.

Confirmed independently of the site - three plain `fpc.exe` runs, no PHP or
web layer involved: a `Uses Crt;` program piped to a file (`p.exe > out.txt`)
produced an empty file both in Git Bash and in PowerShell (`& .\p.exe 2>&1`
came back `[]`); the same program with `Uses Crt;` removed printed normally
under identical redirection. So this is FPC 3.2.2's Windows `Crt` unit
detecting a non-console stdout and suppressing the run's entire output, not a
bug in `CompileWithoutSandbox()`, `RunBounded()`, or anything else in this
codebase - `CompileWithoutSandbox()` always redirects to a file (`RunBounded`
runs the binary with its output piped so it can be captured and bounded), so
every `Crt` code block hits this every time, with no exception.

**What this means in practice: any lesson's `code` block that uses `Crt`
cannot be verified locally at all.** `compileOk` still comes back `true` and
`exitCode` `0` - the program ran and exited cleanly - but `runOutput` is
always `''`, so there is no way to eyeball whether the pupil's actual output
is right from the Windows testbed. This is a sharper version of platform.md
decision 15's "local testing cannot prove the isolation" - here it cannot
even prove the *output*. Testing a `Crt` code block for real means the
server's test deployment (`/var/www/itcoder-v2-test`), not `localhost:8081`.

### `Sound`/`NoSound` do not work through this site, and never can

Tested 13 September 2026, prompted by a direct question ("does sound in
browser work as expected?") after lesson 3 mentioned `Sound` in passing as
an unexplored extra. Two separate reasons, either one enough on its own:

1. **`Sound` is a silent no-op on this server, even outside any sandboxing.**
   A plain `Uses Crt;` program calling `Sound (1000); Delay (500); NoSound;`
   between two `Writeln`s was compiled and run directly on the VPS - once
   down an ordinary pipe, once under `script -qec` (the same pty mechanism
   `--tty` uses for colour and `GotoXY`). Both runs exited 0 with both
   `Writeln` lines printed and produced no `chr(7)`/BEL byte, no error, no
   difference in output at all with `Sound` in the program or without it.
   Free Pascal's Linux `Crt` unit implements `Sound` via a `KIOCSOUND` ioctl,
   which only works on a real Linux virtual console (a physical or kernel
   `tty`) - a pty, which is what both a plain pipe and `script` provide, is
   not one, so the ioctl has nothing to act on and the call does nothing,
   silently, with no error surfaced either way.
2. **Even if it worked, nothing here could deliver it.** The whole compile
   subsystem - `--tty`, `TerminalScreen()`, the `data-screen` it produces -
   only ever carries the program's *screen*: text, colour, cursor position.
   There is no audio channel anywhere in this design, so a genuine beep on
   the server has no path to a pupil's speakers regardless of the ioctl
   question above.

So `Sound`/`NoSound` join `Delay` as Crt commands lesson 3 teaches honestly
as "compiles and runs here, but you will not see/hear the actual effect on
this site" - `Delay`'s pause is swallowed because a `code` block only ever
shows a finished run (design note above), `Sound`'s beep is swallowed for
the two independent reasons here. Both point pupils at Lazarus / Delphi to
actually experience them.

## Simulated input for Readln/Read (2026-09-13)

Built for the Pascal course's new Input lesson, at Chris's choice: rather than
teach `Readln`/`Read`/`ReadKey`/`KeyPressed` only through trace questions
("what would this print"), a `code` block can now declare `'takesInput' =>
true` (`lib/content.php`) and gets a second box under the editor - "What will
you type when this runs?" - whose contents are fed to the compiled program's
own stdin, so a genuine `Readln` in the pupil's program reads back exactly
what they typed there.

**The hard part is that compile and run already shared one stdin pipe.**
`bin/compile-sandbox.sh` runs both inside one `systemd-run` unit -
`cat > p.pas && fpc ... && ./p` - because the compiled binary lives in that
unit's own private `/tmp` and cannot be handed to a second process. So there
was only ever one stdin stream available, and now two things need to travel
down it: the source, and what the program should read once it's running.

**The fix is a length-prefixed protocol, not a delimiter** - the same
reasoning the sandbox's own OUTPUT framing already uses (see "OUTPUT FRAMING"
above): a pupil's source or typed input can legitimately contain anything we
might pick as a separator, but neither can change a byte count our own PHP
computes before sending. `FrameSandboxStdin()` in `lib/compile.php` writes:

    <sourceBytes>\n<source bytes><inputBytes>\n<input bytes>

and `bin/compile-sandbox.sh` reads it back with `read -r` for each length
line (safe on a pipe - bash's `read` takes one byte at a time up to the
newline, so it cannot consume into the payload that follows) and
`dd bs=<n> count=1 iflag=fullblock` for exactly that many payload bytes.
**`iflag=fullblock` is not optional**: a single read() on a pipe can return
fewer bytes than asked for well before EOF, and `dd` without it would hand
back that short read as if it were everything. This is also why the SOURCE
side changed from the original design's bare `head -c $SOURCE_LIMIT_BYTES` -
GNU `head` reading from a pipe is free to pull a whole internal buffer ahead
in one syscall and silently discard whatever it did not print, which would
have ripped bytes out of the payload sitting right behind it. Explicit
lengths remove the ambiguity entirely.

**Verified, locally, against real fpc 3.2.2** (`CompileWithoutSandbox()` -
compile and run are already two separate `proc_open()` calls there, each
with its own stdin pipe, so the local path needed nothing but passing the
pupil's typed text straight to the run step's stdin - no framing required):

| Program | Simulated input | Result |
|---|---|---|
| `Readln (playerName); Readln (age);` | `Thabo\n16\n` | `Hello, Thabo! In 5 years you will be 21.` - correct |
| `Read (a); Read (b);` | `3\n4\n` | `Sum: 7` - correct; `Read` happily crosses the line break looking for the next value |
| `Read (a);` then `Readln (name);` right after | `5\nThabo\n` | `Got number 5 and name []` - **`name` comes back empty.** `Read (a)` stops the instant it has a whole number and leaves the rest of that line - just the newline - sitting in the buffer; the `Readln` immediately after reads THAT (empty) remainder, not the next line down, so `Thabo` is never reached. This is the exact "same shape as Write vs Writeln" trap the lesson teaches, reproduced with genuine fpc, not invented. |
| `Readln (a);` | *(nothing typed)* | `Got 0` - reading an Integer from an already-closed/empty stdin does not raise a runtime error on this fpc; the variable is simply left at its default 0. Genuine, but a corner case the lesson does not need to lean on. |

**VALIDATED ON THE REAL SERVER, 13 September 2026 - after it found a bug.**
The first run through `systemd-run` failed every input check: the script set
`INPUT_LIMIT_BYTES` but never passed it into the unit with `--setenv` like
the other limits, so inside the unit it was blank, `head -c ''` refused, and
every program read empty input - while plain compiling kept working. Fixed
with the missing `--setenv` line. Re-run on the test deployment, all three
programs in the table above, plus input that looks like a length header and
source whose first line is digits, gave exactly the output in the table.
Security checks unchanged: no `{$I}` of any config, no program can open any
site's config or lesson files. **Under `--tty`, `Readln` and `ReadKey` both
receive the typed text but then wait until the run is killed** - so the open
question below is answered "no, not as it stands"; no lesson relies on it.

This proof is automated now rather than a checklist:
`tools/publish-test.py` runs `tools/sandbox-check.php` on every publish to
test, and `tools/deploy-live.py` refuses to ship a sandbox that has not passed
it - see [publishing.md](publishing.md). The notes below are kept as the
record of what was checked and why.

**NOT yet validated against the real server.** The two-length framing in
`bin/compile-sandbox.sh` has not been run through `systemd-run` for real -
only reasoned through and pattern-matched against the sandbox's existing
output-framing discipline. Before this goes anywhere near a pupil:

- Re-run the same three programs above through the actual sandbox path
  (`/var/www/itcoder-v2-test`, the way every other sandbox change has been
  checked - platform.md decision 15) and confirm identical output to the
  table above.
- **`ReadKey`/`KeyPressed` are a separate, harder, and still-open question.**
  They are Crt unit calls, not plain Pascal I/O - Free Pascal's Linux Crt
  implementation puts the terminal into raw mode via `tcgetattr`/`tcsetattr`
  and expects to read single keypresses off an actual tty, not a line-
  buffered redirect. `--tty` mode already gives the program a real pty
  (`script -qec`, for `GotoXY`/`TextColor`/etc - see "The virtual DOS
  terminal" above), and this feature now feeds `stdin.txt` into `script`'s
  own stdin on the theory that `script` relays it into the pty the way a
  real keystroke would - **but that relaying behaviour is untested**, and it
  is entirely possible `ReadKey` behaves correctly, hangs for the run-time
  limit and then times out, or reads something subtly wrong (an echoed
  character, an extra newline). Test explicitly with a small `ReadKey`
  program before any lesson content claims it works. If it does not, the
  honest fallback - matching how `Delay` and `Sound` are already taught - is
  telling pupils plainly that `ReadKey`/`KeyPressed` compile and run here but
  their live keypress behaviour cannot be demonstrated on this site, and to
  try them for real in Lazarus/Delphi.
- `codeSubmissions.simulatedInput` (schema.sql, `bin/setup.php`'s `$wanted`
  array) needs the same one-off `sudo -u www-data php bin/setup.php` any new
  column does before deploying - see open-items.md.

## Two Reads, one line, and the trap it sets

Worth stating plainly since it now has genuine fpc output behind it (table
above): `Read` and `Readln` differ only in what happens to the REST of the
line once a value has been read - `Read` leaves it sitting in the buffer,
`Readln` throws it away and moves on. This is exactly the same relationship
as `Write` and `Writeln` on the way out (`courses/pascal-course.md`'s "Proof
of life" already teaches that pairing), which makes it a genuine callback
rather than a new idea dressed up as one - see `content/pascal/lesson05.php`.

### Still not tested

- **Fork-bomb / `TasksMax=` behaviour.** Chris authorised this on 12 September
  2026, and Claude Code's permission classifier still refused to run it - as
  `vps-access.md`'s house rules say, that is not something to work around, so
  it is written up for Chris to run directly. The command is at the bottom of
  this file. The sandbox currently sets `TasksMax=32`.

  One thing *is* known: an earlier, accidentally-harmless version of the test
  showed the transient unit contains a fork bomb regardless of `TasksMax`,
  because `:(){ :|:& };:` returns immediately and systemd tears the whole
  cgroup down when the main process exits. Host task count went 170 -> 171,
  load stayed flat, the site kept serving 200. What is still unproven is
  `TasksMax` capping a bomb whose main process *stays alive* while it
  multiplies.

- **Concurrency under a lockstep class burst.** Still untested. One compile is
  ~0.3s on this box, so thirty of them serially is ~9s - which the worker below
  handles comfortably - but that is arithmetic, not a measurement.

- **Output size capping** is done, in three places: `head -c` inside the
  sandbox (which lands a SIGPIPE on a program printing in a tight loop and
  stops it there and then), a byte cap in `RunBounded()` in `lib/compile.php`,
  and a final trim before storing.

## The shape it was actually built in

Mirrors `bin/markqueue.php`, with one deliberate departure.

- **Table**: `codeSubmissions`, one row per pupil per code block, latest run
  replacing the one before it. `compiling` and `running` are **not** separate
  states as first sketched - both steps happen inside one transient unit (they
  have to: the compiled binary lives in that unit's private `/tmp`, destroyed
  the moment it exits), so nothing outside can observe the boundary. One
  `running` state is the truth.
- **Worker**: `bin/compilequeue.php`. Same `flock`, same five-minute stuck-row
  recovery sweep. **The departure: it does not do one pass per cron tick.** It
  loops, picking work up within ~250 ms, until 48 seconds in, then exits before
  the next tick. Marking can afford to wait a minute because the pupil has
  moved on down the page; a compile cannot, because the pupil is sitting there
  watching for their program to print, in a lesson whose whole argument is that
  a program with no output cannot be trusted. The arithmetic behind 48 seconds
  is written out in the worker's own header.
- **Sandbox invocation** lives in `bin/compile-sandbox.sh`, called through
  `proc_open()` - never assembled inline as a PHP string of shell arguments.
- **Output framing.** The caller has to separate the compiler's words from the
  pupil's, on one stream, and the pupil's program can print any delimiter you
  might pick. So the first line is a length prefix -
  `ITCODER 1 <compileRc> <compileBytes>` - written before the program starts. A
  program cannot forge it: it cannot change how many bytes fpc wrote, and it is
  not running yet.
- **Reading output in PHP goes to files, not pipes.** Two pipes read in
  sequence deadlock when the program fills the one you are not reading;
  reading them together needs `stream_select()`, which **does not work on
  Windows pipes**. The first version passed hello-world, a syntax error and a
  type error, then hung solid on `While True Do Writeln('x')` on the testbed
  and had to be killed by hand. A file has neither problem.
- **Path leaks are stripped.** `TidyCompilerOutput()` in `lib/compile.php`
  drops fpc's banner and its closing
  `Error: /usr/bin/ppcx64 returned an error exitcode` - which names our path
  and says nothing about the pupil's program - so what a pupil reads starts at
  `p.pas(3,15) Error: ...`, exactly as the lesson teaches them to expect.
  Nothing is reworded or summarised; every error, warning, note and hint is
  fpc's own text.
- **Warnings on a program that DID compile are shown too**, in an amber panel
  under the output. Found while testing: a program that compiles, runs, prints
  nothing and earns `Note: Local variable "n" is assigned but never used` is
  the lesson's own thesis in miniature, and swallowing the note would be odd
  in a course that teaches reading compiler output.

### Two scoring shapes sit on top of the same primitive - neither is built yet

The `code` block as it stands is **unmarked**: no `marks` field, excluded from
`LessonAutoMarkedQuestions()`, nothing totals it. It is a practice box, not an
assessment. Keeping it out of the auto-marked pool matters - adding it there
without a scoring rule would make every lesson containing one report a larger
"out of" than any pupil could reach.

When marked code questions are built, they are two different things and should
not be conflated:

- (a) auto-marked "predict what prints" / "write code producing X" -
  compile, run, compare trimmed stdout via `MatchesTypedAnswer()`, same doubled
  two-attempt scoring as `quiz`/`typed`/`order`;
- (b) AI/human-marked "write code that does X" - the compile result confirms it
  runs, but the mark comes from a rubric that also judges house style (the flat
  1-mark deduction, `content-voice-and-pedagogy.md` §4).

Either way they must go through `AutoMarkedEarned()` and honour platform.md
decisions 8 (no odd totals) and 12 (a displayed mark must be what the engine
can actually award).

## Who can trigger a compile - settled

**Anyone signed in and enrolled in the course** (Chris, 12 September 2026). Not
gated like AI marking, and the difference is the point: `CanUseMarking()` exists
because marking spends Anthropic tokens per answer, while compiling spends a
fraction of a second of this server's own CPU. There is no bill to run up, so
there is nothing to ration by account type.

What does still need rationing is the CPU, and `public/api/compile.php` does it
by refusing a pupil a second compile while their first is still `queued` or
`running` - checked platform-wide, not per question, because the CPU is shared.
A pupil leaning on the Run button gets "Your last program is still running."

## systemd-run cannot be called by an unprivileged user

**The one thing that would have made the whole subsystem fail in production**,
found 12 September 2026 while deploying. Every sandbox test up to that point
had been run as root over SSH, where it works perfectly. The worker runs as
`www-data`:

```
sudo -u www-data systemd-run --pipe --quiet --wait --property=DynamicUser=yes -- /bin/echo hi
  ->  Failed to start transient service unit: Interactive authentication required.
```

Creating a transient unit needs polkit, and `www-data` has no session to
authenticate one. So the sandbox needs a way through, and both available routes
grant `www-data` an effective root execution path - `systemd-run` runs its
payload as root by default, so a polkit rule permitting `manage-units` is
strictly *broader* than a single sudo entry. The tightest option wins:

- `bin/compile-sandbox.sh` is installed to **`/usr/local/bin/itcoder-compile-sandbox.sh`,
  root:root, mode 755**.
- **It must not live under `/var/www`.** A deploy chowns everything there to
  `www-data` - which would let the very account this sandbox exists to contain
  rewrite the script that sudo runs as root.
- `/etc/sudoers.d/itcoder-compile` (mode 440) allows exactly:
  `www-data ALL=(root) NOPASSWD: /usr/local/bin/itcoder-compile-sandbox.sh`
- The script **takes no arguments** and reads only stdin, which goes straight
  into the DynamicUser sandbox. Its limits are **hardcoded, not read from the
  environment**: sudo strips the environment anyway, but the principle stands -
  `www-data` is the thing being contained and must not be able to hand in a
  laxer `MemoryMax` or `TasksMax`. `CompileLimits()` in `lib/compile.php` keeps
  its own copies for the checks PHP does before calling; change one, change both.
- `lib/compile.php` invokes `['sudo', '-n', $config['compileSandboxScript']]`.

Always `visudo -cf` a candidate file before installing it, and `visudo -c`
afterwards. A broken drop-in breaks sudo for everyone.

`'compileSandboxed'` now **defaults to true when absent**, so a config that has
not been told about it (the test deployment's hand-written one) falls on the
safe side instead of silently running pupils' code with no isolation.

## Deployed to the test deployment, 12 September 2026

Live (`/var/www/itcoder`) is **untouched** - still the five original files in
`bin/`, still serving 200. What went to `/var/www/itcoder-v2-test`:

- the project (71 files), with its own `config/config.php` **copied aside first
  and put straight back** - `put_tree()` would otherwise overwrite it with the
  local one, which on a server resolves to the LIVE database and turns dev
  login off, locking the test site out entirely (Google's redirect URI cannot
  work on `:8082`)
- four compile keys appended to that config (`pascalCompiler`,
  `compileSandboxed`, `compileInRequest`, `compileSandboxScript`)
- `codeSubmissions` created via `sudo -u www-data php bin/setup.php`
- a crontab line for its own `compilequeue.php`, logging to
  `/var/log/itcoder-v2-test-compile.log`

Verified on the server, as `www-data`, through the deployment's own config:
hello-world compiles and runs (0.1s); a real syntax error comes back genuine;
reading the **live** site's `config.php` gets `Runtime error 5`; `{$I}` include
blocked; reading a lesson file blocked; an endless loop cut at 5.2s. Then
through the browser on `:8082`: badly laid-out code refused before compiling,
corrected code compiled by the **cron worker** and printed, celebration shown.

## Deploying to live

Not done. When it goes up:

```
# 1. upload, then fix ownership (SFTP lands everything owned by root)
chown -R www-data:www-data /var/www/itcoder
find /var/www/itcoder -type d -exec chmod 755 {} +
find /var/www/itcoder -type f -exec chmod 644 {} +
chmod 750 /var/www/itcoder/config /var/www/itcoder/data
chmod 640 /var/www/itcoder/config/config.php

# 2. add the codeSubmissions table (as www-data, never as root)
sudo -u www-data php /var/www/itcoder/bin/setup.php

# 3. the worker, once a minute like the marking one
crontab -u www-data -l > /tmp/ct
echo '* * * * * /usr/bin/php /var/www/itcoder/bin/compilequeue.php >> /var/log/itcoder-compile.log 2>&1' >> /tmp/ct
crontab -u www-data /tmp/ct && rm /tmp/ct
touch /var/log/itcoder-compile.log && chown www-data:www-data /var/log/itcoder-compile.log
```

Plus the two privileged pieces, which a deploy does **not** install because
they live outside `/var/www` on purpose (see the section above):

```
install -o root -g root -m 755 /var/www/itcoder/bin/compile-sandbox.sh \
        /usr/local/bin/itcoder-compile-sandbox.sh

printf '%s\n' 'www-data ALL=(root) NOPASSWD: /usr/local/bin/itcoder-compile-sandbox.sh' \
        > /root/itcoder-compile.sudoers
visudo -cf /root/itcoder-compile.sudoers \
  && install -o root -g root -m 440 /root/itcoder-compile.sudoers /etc/sudoers.d/itcoder-compile \
  && rm -f /root/itcoder-compile.sudoers && visudo -c
```

Both are already installed as of 12 September 2026 and serve the test
deployment; live will use the same ones. **Re-run the `install` line whenever
`bin/compile-sandbox.sh` changes** - the copy under `/var/www` is only the
source, and nothing picks up an edit to it automatically.

To undo the privilege entirely: `rm /etc/sudoers.d/itcoder-compile` (compiling
then fails cleanly with "the sandbox produced no usable output"; nothing else
is affected).

The worker logs nothing on an idle minute, so `/var/log/itcoder-compile.log`
stays small. Add it to logrotate if that ever stops being true.

### The fork-bomb test, for Chris to run

Claude Code's permission classifier refuses this, authorised or not. Paste into
your own terminal after `ssh gnomemedia`. Bounded three ways - `TasksMax` caps
the processes, `RuntimeMaxSec` the time, and the outer `timeout` is the net:

```
uptime; ps -eL --no-headers | wc -l

timeout 8 systemd-run --pipe --quiet --wait \
  --property=DynamicUser=yes --property=TasksMax=32 \
  --property=RuntimeMaxSec=3 --property=MemoryMax=128M \
  -- bash -c ':(){ :|:& };: ; sleep 3'; echo "exit=$?"

uptime; ps -eL --no-headers | wc -l
systemctl is-active nginx php8.3-fpm
curl -s -o /dev/null -w '%{http_code}\n' https://itcoder.co.za/
```

The `sleep 3` matters: without it the bomb's parent returns instantly,
systemd tears the cgroup down, and the test passes without ever exercising
`TasksMax`. What you want to see is it return within ~3-8 seconds, host task
count back to roughly where it started, load settling, and the site still
answering 200. If the box struggles, `TasksMax` needs lowering in
`bin/compile-sandbox.sh` - it is one number, near the top.

## The isolated test deployment, if it's still around

A side-by-side test copy of this whole platform was deployed 11 September
2026 to verify "Proof of life" content and multi-course visibility -
`/var/www/itcoder-v2-test`, its own SQLite database, its own nginx server
block on port 8082 (`sites-available/itcoder-v2-test`), dev login turned on
(Google's registered redirect URI is locked to `https://itcoder.co.za`, so
real sign-in can't complete on a different host:port). It does not touch the
live site or its database. If it's still there when you read this and nobody
needs it, it's safe to tear down - see "Operations and housekeeping" in
[open-items.md](open-items.md).
