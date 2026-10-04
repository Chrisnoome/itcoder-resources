# Publishing - test site, then live

Server facts are in [vps-access.md](vps-access.md); this file is only how to
publish. **Read it before putting anything on the server.**

**Chris publishes, not the chats (Chris, 1 October 2026: "don't just
automatically publish. multiple chats working. publish should be
synchronised which i will do when chats are finished").** Several chats share
one working tree, and a publish uploads all of it - half-finished work of
other chats included (it has carried unfinished files to live, and failed
when another chat removed a file mid-upload). So a chat never runs
publish-test.py or deploy-live.py on its own: it finishes, lints, commits its
own hunks, and tells Chris it is ready to publish. Testing a change on the
server without publishing: upload single files to /tmp and run them there
(as the remediation chat's php -l checks do), never into the sites.

## The two scripts, always in this order

1. **Test:** `tools/publish-test.py` - puts all of `AIPascalCourse` on the test
   site (`/var/www/itcoder-v2-test`, http://102.214.9.207:8082) and proves the
   compile sandbox there.
2. **Look at it** on the test site (dev login is on there, behind a
   password - the browser asks once; set or change it with
   `tools/set-test-password.py`, 28 Sep 2026).
3. **Live:** `tools/deploy-live.py` - the same code to https://bestlessons.co.za (the old itcoder.co.za still works).
   Refuses to run until step 1 has passed for the installed sandbox.

**A publish that runs over an hour: terminate it and start it again**
(Chris, 4 Oct 2026: "publishing seems to be stalling. if it goes over an hour,
terminate and restart"). With about 4,000 public files a run now takes 20-35
minutes - run it in the background, not under the Bash tool's 10-minute limit.
A re-run is safe: it backs up again and re-sends every file. Since 4 Oct 2026
`vps.put_tree()` also sends a file again on a fresh connection when it has
stalled for 2 minutes (3 tries) - before that, two live deploys hung for good
on one picture.

Bash tool (run it in the background - see above):

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

**Reminders and email (27 September 2026):** deploy-live.py also makes
`/var/log/itcoder-remind.log` and adds the cron line for `bin/remind.php`
(weekdays 04:30 UTC) - live only; the test site never gets it. Email keys go to
live with `tools/set-server-config.py mail` (it asks for the key; never printed).

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

**nginx hardening (28 September 2026):** both scripts then run
`tools/nginx_hardening.py` - server_tokens off and the rate-limit zones
(`conf.d/itcoder.conf`, shared by every site, so publish-test already sets it
for live), the limits snippet included in the test block (publish-test) or
the itcoder and bestlessons blocks (deploy-live), and the security headers
in `/assets/`. Only what differs is changed, each changed file copied aside
first, `nginx -t` before the reload, everything put back if it fails.

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

**The one exception so far (Chris, 1 October 2026):** a fix for pupils' saves
failing with "database is locked" in class time (lib/db.php, commit 1687029)
could not wait, and the working tree held another chat's half-finished
refactor, so a whole-tree publish was not safe. Chris approved putting that
one file on live by hand: live's own lib/db.php plus only the fix, linted and
proved with bin/check-db-locks.php against a copy of live's lib/ in /tmp, the
old file kept in /root/itcoder-code-backups/. It does not make hand uploads
normal: the next whole-tree publish carries the same change. Anything like it
needs Chris's say-so each time.

## After publishing

Tell Chris briefly: what went up, where, whether every check passed, any NOTE
or warning. Record it in [open-items.md](open-items.md) if it closes or opens an
item.
