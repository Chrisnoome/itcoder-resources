# Publishing - getting work onto the test site and the live site

Written 13 September 2026, after several chats tried to publish and failed in
several different ways - and after one partial, by-hand publish left the test
site running new pages on top of old compile code. **Read this before you put
anything on the server.** Server facts live in [vps-access.md](vps-access.md);
this file is only about publishing.

## The short version

Publishing is **two scripts, always in this order**, run from Chris's Windows
machine. Nothing else. Do not copy individual files up by hand.

1. **Test** - `tools/publish-test.py` puts the whole of `AIPascalCourse` on the
   test site and proves the Pascal compile sandbox works there.
2. **Look at it** - Chris (or you) checks the change on the test site in a
   browser: http://102.214.9.207:8082
3. **Live** - `tools/deploy-live.py` puts the same code on https://itcoder.co.za.
   **It refuses to run until step 1 has passed** for the sandbox that is
   installed.

## The exact commands

From Claude Code's Bash tool:

    /c/Python314/python.exe -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"
    /c/Python314/python.exe -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"

From PowerShell (what to give Chris):

    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"
    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"

**Always the full interpreter path.** A bare `python` goes wherever PATH sends
it, and in Chris's own PowerShell that is a Python with no `paramiko` - the
first real live run died with `ModuleNotFoundError: No module named 'paramiko'`.
Both scripts now say so in plain words if it happens, before touching the
server. Each run takes one to three minutes; give the Bash tool a 10-minute
timeout.

## What the scripts do, so you can read their output

**`publish-test.py`** (test site, `/var/www/itcoder-v2-test`):

| Step | What | Why |
|---|---|---|
| 0 | Refuses a `bin/compile-sandbox.sh` with Windows line endings | This repo is checked out with `core.autocrlf=true`; a CRLF bash script run by sudo breaks in ways that look like anything but line endings. `.gitattributes` now pins `*.sh` to LF as well |
| 1 | Uploads `lib/`, `bin/`, `content/`, `public/`, `schema.sql` | Whole folders, every time - never a hand-picked subset. **Never `config/` or `data/`** |
| 2 | `chown`/`chmod` | SFTP uploads land owned by root; the site runs as www-data |
| 3 | `bin/setup.php` as www-data | New tables and columns exist before a page asks for them. Skip this and pages die with `no such table` |
| 4 | Installs `bin/compile-sandbox.sh` as root at `/usr/local/bin/itcoder-compile-sandbox.sh` **if it changed** | That root-owned copy is what sudo actually runs, and it is **shared with live** |
| 5 | Runs `tools/sandbox-check.php` as www-data through the real `sudo -> systemd-run -> fpc` path | Proves compiling, simulated input, the Crt terminal, timeouts, and that a pupil's program cannot read any site's config or lesson files |
| 6 | Records the sandbox's sha256 as proven in `/root/itcoder-sandbox-validated.sha256` | Only if every gating check passed. This is what `deploy-live.py` checks |

**`deploy-live.py`** (live site, `/var/www/itcoder`): checks the sandbox gate
first, then takes a database backup, copies `config.php` aside, uploads the
same folders, fixes permissions, adds any missing compile settings to the live
config (without printing it), runs `setup.php`, makes sure the compile
worker's cron line and log exist, and finishes by running the same
`sandbox-check.php` against live's own code.

Both scripts are safe to run again. Neither deletes anything on the server.

## When something goes wrong

**`[STOP] Not published to test yet - nothing on live has been touched.`**
The sandbox script here, the installed one, and the last one proven on test
do not all match. Run `publish-test.py`. This includes comment-only edits to
`bin/compile-sandbox.sh` - the gate compares sha256, deliberately.

**`FAIL` lines under `sandbox checks`.** Do not go near live. Each failing
check prints what it actually got. The first real run of the new simulated
input feature failed four checks with `head: invalid number of bytes: ''` -
the script set `INPUT_LIMIT_BYTES` but never passed it into the systemd unit
with `--setenv`, so every program read empty input while plain compiling
kept working. Fix the cause in `bin/compile-sandbox.sh` or `lib/compile.php`,
then run `publish-test.py` again. **The two halves of the sandbox protocol
(`FrameSandboxStdin()` in `lib/compile.php` and the script) must always be
published together** - that is why the scripts upload everything.

**`NOTE` lines** are informational checks for things no lesson relies on yet
(currently: `Readln` and `ReadKey` under `--tty` time out). They never block.
If a lesson starts to depend on one, move it into the gating set in
`sandbox-check.php` first.

**The permission classifier refuses to run the script.** Claude Code's auto
mode has refused live deployments in some chats. **Do not work around it** -
not by splitting the deploy into small uploads, not by hand-copying files, not
by any other route. Stop, tell Chris plainly, and give him the PowerShell
command above. (This is the same house rule as in vps-access.md.)

**`ModuleNotFoundError`** - see "The exact commands": use the full path.

## Rules

- **Only the two scripts publish.** A by-hand upload of "just the files I
  changed" is how the test site ended up with a new masthead and lessons on
  top of an old `lib/compile.php`. If a script cannot do what you need, change
  the script, prove it on test, and say so here.
- **Test before live, every time.** The gate enforces it for the sandbox; for
  everything else it is on you and Chris to actually look at the test site.
- **Never upload `config/` or `data/`.** The test site's config is
  hand-written; the local one, if uploaded, points at the LIVE database and
  turns dev login off. The live database is pupils' work.
- **Never edit `/usr/local/bin/itcoder-compile-sandbox.sh` or
  `/etc/sudoers.d/itcoder-compile` by hand.** Change `bin/compile-sandbox.sh`
  and publish to test. The sudoers rule allows exactly two forms - no
  arguments, and `--tty` - so a new command-line argument needs Chris.
- **A sandbox change on test is a sandbox change on live**, because the
  installed script is shared. If live already compiles, publish live as soon as
  test passes; `publish-test.py` prints a warning when this applies.
- **Don't write server-side Python inline in a Bash command.** Between bash and
  Python's own escapes, Windows backslashes get mangled - it broke three
  patches in one session on 13 September 2026, including one `sed` that ate a
  line-continuation backslash so `bash -n` still passed but `systemd-run`
  would have been cut in half. Write a script file and run it.
- **Committing and pushing are separate from publishing.** Publishing puts the
  working tree on the server, committed or not. Ask Chris before committing or
  pushing.

## After publishing

Tell Chris, briefly: what went up, to which site, whether every check passed,
and anything a `NOTE` or warning said. Record it in
[open-items.md](open-items.md) with the date if it closes or opens an item.
