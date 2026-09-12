# Designing the Pascal compile subsystem

For whichever chat builds this - written 11 September 2026 by the Pascal chat,
after testing the sandboxing question directly against the live server (not
guessed). Start at [README.md](README.md) if you haven't. This file assumes
you've read [vps-access.md](vps-access.md), especially "Before pupil code goes
anywhere near that compiler."

**Status: sandbox design tested and validated on the actual server. Nothing
built yet** - no `code` block type, no queue table, no worker script, no API
endpoint. This is a design handoff, not a progress report on code that exists.

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

### Not yet tested - left for you

- **Fork-bomb / `TasksMax=` behaviour.** Claude Code's own permission
  classifier refused to run a fork-bomb test even sandboxed, and per
  `vps-access.md`'s house rules that's not something to work around - it
  should be run directly by Chris, or by a chat explicitly authorised for it.
  Suggested command (already scoped with a double timeout as a safety net):
  ```
  timeout 5 systemd-run --pipe --quiet --wait --property=DynamicUser=yes \
    --property=TasksMax=16 --property=RuntimeMaxSec=3 -- \
    bash -c ':(){ :|:& };:'
  ```
  Expect it to be capped and to exit within ~3-5 seconds either way; if the
  box's load spikes hard or it doesn't return, that's the finding.
- **Output size capping.** Nothing here yet stops `while true do Writeln
  ('x');` from producing gigabytes of stdout before `RuntimeMaxSec` cuts it
  off. Whatever calls `systemd-run` (PHP's `proc_open()`, most likely) needs
  to read the pipe with a byte-count cutoff and kill the process itself if
  it's exceeded - `RuntimeMaxSec` alone isn't enough, since a few seconds of
  unthrottled `Writeln` in a tight loop is still a lot of output.
- **Concurrency under a lockstep class burst.** Untested how many of these
  can run at once on 4 vCPU / ~3.9 GB before compiles start queueing
  visibly. `bin/markqueue.php`'s serial batch-per-minute pattern is the
  starting assumption (see below) - measure before assuming it needs more.

## Suggested shape for the rest of the subsystem

Mirror `bin/markqueue.php` - it's the existing precedent for exactly this
kind of "queue it, cron picks it up, write the result back" flow, already
proven under this app's load:

- **Table**: `codeSubmissions` - `pupilId`, `courseId`, `lessonId`,
  `questionId`, `sourceCode`, `status` (`queued`/`compiling`/`running`/
  `done`/`failed`), `compileOutput`, `runOutput`, `timedOut`, `submittedAt`,
  `completedAt`. Cap `sourceCode` at something small (8 KB is generous for a
  beginner exercise) at the API layer, before it ever reaches the queue.
- **Worker**: `bin/compilequeue.php`, same `flock` single-runner lock as
  `markqueue.php`, same "anything stuck for 5 minutes goes back to `queued`"
  recovery sweep, same serial batch-per-cron-tick (no parallel pool needed
  until measurement says otherwise).
- **The actual sandbox invocation belongs in one script**
  (`bin/compile-sandbox.sh` or similar), called via `proc_open()` so PHP can
  write source to stdin and read stdout/stderr/exit code directly - not
  built as a PHP string of shell arguments assembled inline.
- **Before showing compiler output to a pupil**, strip the sandbox's own
  path prefix if one leaks through (shouldn't, since the working directory is
  just `/tmp` inside the unit, but check) so error messages read as
  `p.pas(3,15) Error: ...`, matching what the "Proof of life" lesson teaches
  them to expect.
- **Two scoring shapes sit on top of the same primitive** - don't conflate
  them: (a) auto-marked "predict what prints" or "write code producing X",
  compile+run+compare trimmed stdout via `MatchesTypedAnswer()`, same doubled
  two-attempt scoring as `quiz`/`typed`/`order`; (b) AI/human-marked "write
  code that does X", using the compile result to confirm it runs, but the
  actual mark comes from a rubric that also judges house style (the flat
  1-mark deduction - `content-voice-and-pedagogy.md` §4).

## Who can trigger a compile - still an open product question

AI marking is gated by `CanUseMarking()` because it spends Anthropic tokens.
Compiling spends CPU on this box instead, not tokens. Chris hasn't decided
whether compiling should be open to everyone signed in (like quizzes) or
gated the same as AI marking. Ask before building the endpoint's access
check.

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
