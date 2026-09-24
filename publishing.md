# Publishing - test site, then live

Server facts are in [vps-access.md](vps-access.md); this file is only how to
publish. **Read it before putting anything on the server.**

## The two scripts, always in this order

1. **Test:** `tools/publish-test.py` - puts all of `AIPascalCourse` on the test
   site (`/var/www/itcoder-v2-test`, http://102.214.9.207:8082) and proves the
   compile sandbox there.
2. **Look at it** on the test site (dev login is on there).
3. **Live:** `tools/deploy-live.py` - the same code to https://itcoder.co.za.
   Refuses to run until step 1 has passed for the installed sandbox.

Bash tool (10-minute timeout; each run takes 1-3 minutes):

    /c/Python314/python.exe -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"
    /c/Python314/python.exe -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"

PowerShell (for Chris):

    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"
    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"

**Always the full interpreter path** - a bare `python` may have no paramiko.

## What they do

**publish-test.py:**
0. refuses a CRLF `bin/compile-sandbox.sh` (`.gitattributes` pins `*.sh` to LF);
1. uploads `lib/`, `bin/`, `content/`, `public/`, `schema.sql` - whole folders,
   **never `config/` or `data/`**;
2. chown/chmod for www-data;
3. runs `bin/setup.php` (new tables/columns);
4. installs `bin/compile-sandbox.sh` as root to
   `/usr/local/bin/itcoder-compile-sandbox.sh` if changed - **shared with live**;
5. runs `tools/sandbox-check.php` as www-data through the real
   sudo -> systemd-run -> fpc path (compiling, input, Crt, timeouts, and that a
   program cannot read any site's config or lessons);
6. records the sandbox sha256 as proven in `/root/itcoder-sandbox-validated.sha256`.

**deploy-live.py** (`/var/www/itcoder`): checks the sandbox gate, backs up the
database, sets `config.php` aside, uploads the same folders, fixes
permissions, adds missing compile settings to the live config (without
printing it), runs `setup.php`, ensures the compile worker's cron line and
log, and runs the sandbox check against live.

Both are safe to re-run and never delete anything.

## When something goes wrong

- **`[STOP] Not published to test yet`** - script, installed copy and proven
  hash differ (even a comment edit). Run publish-test.py.
- **`FAIL` in sandbox checks** - don't go near live. Fix `bin/compile-sandbox.sh`
  or `lib/compile.php` (`FrameSandboxStdin()` and the script must always ship
  together), then publish to test again.
- **`NOTE` lines** are informational (Readln and ReadKey under `--tty` time
  out); they never block. Move a check into the gating set in
  `sandbox-check.php` before a lesson depends on it.
- **The permission classifier refuses a deploy** - don't work around it (no
  small uploads, no hand copies). Stop and give Chris the PowerShell command.
- **`ModuleNotFoundError`** - use the full interpreter path.

**Upload size (25 September 2026):** both scripts make sure the site's nginx
block has `client_max_body_size 12m` (task pre-checks upload PDFs up to 10 MB;
PHP's own limit is `public/.user.ini`). Only that line changes, only when it is
not already 12m, with a dated backup beside it, `nginx -t` before the reload.

## Rules

- **Only the two scripts publish.** Never upload files by hand. If a script
  can't do something, change the script, prove it on test, record it here.
- **Test before live, every time.**
- **Never upload `config/` or `data/`** - the local config points at the LIVE
  database; the live database is pupils' work.
- **Never hand-edit** `/usr/local/bin/itcoder-compile-sandbox.sh` or
  `/etc/sudoers.d/itcoder-compile` (it allows exactly two forms: no arguments,
  and `--tty`; a new argument needs Chris).
- A sandbox change on test is a change on live - publish live as soon as test
  passes.
- Don't write server-side Python inline in a Bash command (escapes get
  mangled); write a script file.
- **Publishing uploads the working tree**, committed or not - including other
  chats' unfinished work in the same folders. Committing and pushing are
  separate; ask Chris first.

## After publishing

Tell Chris briefly: what went up, where, whether every check passed, any NOTE
or warning. Record it in [open-items.md](open-items.md) if it closes or opens an
item.
