# Reaching the itcoder VPS from Claude Code

Part of AIResources, the source of truth for the itcoder project - start at
[README.md](README.md). For any local Claude Code session on Chris's machine
that needs the server. First written on 11 September 2026 by the chat that
built and deployed itcoder v1; every fact was checked against the live server
that day.

## You already have access

You are running on Chris's Windows machine, as the same Windows user as the
session that deployed itcoder. The SSH key is on this disk. What was missing is
the route, not permission.

The route is **Python + paramiko**. Not `ssh` or `scp`: when Claude Code starts
the OpenSSH client on this machine it is silently intercepted, probably by
endpoint security, and hangs or fails without saying why. Don't spend time on
it. (Chris's own terminal is fine - `ssh gnomemedia` works for him - but that
is his route, not yours.)

This only works from a local session. A claude.ai chat, Claude Code on the web
or any cloud sandbox has outbound port 22 blocked and no key.

## Facts

| | |
|---|---|
| Host | `102.214.9.207` - Absolute Hosting VPS "GnomeMedia" |
| User | `root` |
| Key | `C:\Users\chris\.ssh\gnomemedia_vps` - RSA, no passphrase |
| Login | Key only. Root password login was switched off on 11 September 2026 (`/etc/ssh/sshd_config.d/00-root-keys-only.conf`). If something asks you for a password, it is not using the key. |
| Python | `C:\Python314\python.exe` has paramiko. So does the clean venv `D:\xampp\itcoder-tools-venv\Scripts\python.exe`. |
| OS | Ubuntu 24.04.5 LTS (Noble) |
| Size | 4 vCPU, 3921 MB RAM, 77 GB disk with 2.5 GB used. Upgraded 10 September 2026 from 1 vCPU / 961 MB. **If your notes say 1 vCPU or 20 GB, they are stale.** |
| Stack | nginx, PHP 8.3-FPM, certbot, cron |

Load the key from that path and nowhere else. Never print it, copy it into a
project folder, or move it.

## What is on the server

- `/var/www/itcoder` - **v2, since cutover on 11 September 2026.** Live at
  https://itcoder.co.za. Its database was reset fresh at cutover (Chris
  confirmed the two accounts in it, including one real pupil sign-in, did
  not need preserving - see `open-items.md`, "Cutover"), so `pupils` starts
  empty. Same path v1 used to run from - v1's code is no longer deployed
  anywhere, only still on disk at `Projects/AIWebCourse/itcoder` as source
  material for the still-pending AI course port.
- `/var/www/marking-app` - a separate marking tool. Its nginx symlink is disabled
  on purpose and the directory kept. Its server block still names
  `itcoder.co.za` (it served that domain before itcoder did), so re-enabling it
  would collide with the live site. Don't delete it, don't re-enable it, never
  point anything at its database.
- nginx: `sites-enabled/itcoder` is the live site, a symlink to
  `sites-available/itcoder`. That file has the port-80 redirect and the SSL
  block, written by hand around the certbot certificate (renews by itself;
  the current one expires 8 December 2026).
- `/var/www/itcoder-v2-test` - an **isolated test deployment** of v2, added 11
  September 2026 to verify "Proof of life" content and multi-course
  visibility without touching the live site. Its own SQLite database, its
  own nginx server block (`sites-enabled/itcoder-v2-test`, port 8082, also
  enabled), its own crontab line (below), `ufw` opened for 8082 (commented
  "itcoder v2 test deployment - remove at teardown"), dev login on. Safe to
  tear down once nobody needs it - `open-items.md`, "Operations and
  housekeeping" has the exact commands, crontab line and ufw rule included.
- PHP-FPM: one pool, `www`, `pm.max_children = 40`, sized for this hardware by
  `bin/tune-fpm.sh` (in both v1 and v2).
- www-data's crontab - **every line's log file must already exist, owned by
  www-data.** `/var/log` is `drwxrwxr-x root:syslog`, so www-data cannot create
  a file there: a cron line redirecting to a log that does not exist fails in
  the shell before PHP is ever started, and fails **silently**, because the
  error has nowhere to go. That is exactly what happened to the test
  deployment's marking worker - added 11 September 2026, never once ran, found
  12 September when marking "wasn't finishing". Create the log first:
  `touch /var/log/NAME.log && chown www-data:www-data /var/log/NAME.log`.
  - `* * * * *` `/var/www/itcoder/bin/markqueue.php` - the marking worker
  - `30 2 * * *` `/var/www/itcoder/bin/backup.php` - the nightly backup
  - `* * * * *` `/var/www/itcoder-v2-test/bin/compilequeue.php` - the Pascal
    compile worker for the test deployment, added 12 September 2026, logging to
    `/var/log/itcoder-v2-test-compile.log`. Remove at teardown.
  - `* * * * *` `/var/www/itcoder-v2-test/bin/markqueue.php` - added 11
    September 2026, marks written answers submitted on the test deployment
    (it has no worker of its own otherwise - the first test submission sat
    queued indefinitely until this was noticed and added). Logs separately
    to `/var/log/itcoder-v2-test-marking.log`. Remove at teardown.
- `/var/backups/itcoder` - verified, gzipped snapshots, 14 daily plus 12
  monthly. Pulled down to Dropbox every evening by the Windows scheduled task
  **itcoder backup pull** (`tools/pull-backups.py` in this folder).
- `/usr/local/bin/itcoder-compile-sandbox.sh` - **root:root, 755, outside the
  web root on purpose** (added 12 September 2026). The Pascal compile sandbox.
  `systemd-run` cannot be called by an unprivileged user - as `www-data` it
  fails with "Interactive authentication required" - so
  `/etc/sudoers.d/itcoder-compile` (440) allows exactly
  `www-data ALL=(root) NOPASSWD: /usr/local/bin/itcoder-compile-sandbox.sh`.
  It lives outside `/var/www` because a deploy chowns everything there to
  `www-data`, which would let the account the sandbox contains rewrite the
  script sudo runs as root. **A deploy does not update it** - re-run the
  `install` line in [compile-subsystem-design.md](compile-subsystem-design.md)
  whenever `bin/compile-sandbox.sh` changes. Removing that sudoers file is the
  clean way to switch compiling off.
- Logs: `/var/log/itcoder-marking.log`, `/var/log/itcoder-backup.log`,
  `/var/log/itcoder-v2-test-marking.log` and
  `/var/log/itcoder-v2-test-compile.log` (test deployment only).

Backups and restoring: [backups.md](backups.md). The rest of the platform:
[platform.md](platform.md).

## The helper - `tools/vps.py`

It sits next to this file. `run()` runs a command as root and returns
`(exit code, output)`; `put()` uploads one file; `put_tree()` uploads a folder -
never deleting anything on the server, never uploading a database, WAL or lock
file. Tested against the server on 11 September 2026.

From a shell, in the AIResources folder:

    python -X utf8 tools/vps.py "systemctl is-active nginx php8.3-fpm"

From a script - keep your scripts in your scratchpad, not in a project folder,
because project folders get deployed whole:

```python
import sys
sys.dont_write_bytecode = True      # no __pycache__ syncing around Dropbox
sys.path.insert(0, r'D:\DB Sync\Dropbox\Projects\AIResources\tools')
import vps

code, out = vps.run('nginx -t')
print(code, out)
```

`run()` returns the exit code instead of raising, so a failed `apt` or
`nginx -t` is easy to walk past. Always look at it.

Write your scripts to files and run them. Don't inline Python in a bash
command: between bash and Python's own escapes, backslashes and Windows paths
get mangled. Use forward slashes in Python paths.

## Installing Free Pascal on the server

**Done - `fp-compiler` is installed, 11 September 2026, as part of testing
the sandbox design.** `fpc -iV` on the server returns `3.2.2`, matching the
local install. Left here for the record and in case it's ever needed again
(a server rebuild, say).

Asked of the server on 11 September 2026:

    Ubuntu 24.04.5 LTS
    fp-compiler   Candidate: 3.2.2+dfsg-32
    fpc           Candidate: 3.2.2+dfsg-32

So apt carries exactly the 3.2.2 you tested locally. No tarball needed.

Install **`fp-compiler`, not `fpc`**. `fp-compiler` adds 13 packages: the
compiler, the runtime library (`fp-units-rtl-3.2.2`), binutils and the FPC
utilities. `fpc` is the whole distribution - 387 packages, including the text
IDE and GUI toolkits a web server will never use.

```python
import vps
print(vps.run('export DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l; '
              'apt-get update -q && apt-get install -y -q fp-compiler'))
print(vps.run('fpc -iV'))    # expect (0, '3.2.2')
```

`NEEDRESTART_MODE=l` stops Ubuntu's needrestart from restarting services -
PHP-FPM included - at the end of the install. Do it outside lesson time anyway.

Then compile a test program that `uses` every unit the syllabus needs. If one is
missing, `apt-cache search fp-units` shows which package carries it. Add that
one package, not the whole `fpc` set.

## Before pupil code goes anywhere near that compiler

Nothing in v2 calls the compiler yet. Decide this before it does.

This server holds pupils' names, email addresses and written work, plus the
Google and Anthropic secrets. PHP runs as `www-data`, which can read all of it.

- **Compiling untrusted Pascal is not harmless.**
  `{$I /var/www/itcoder/config/config.php}` pulls any file the compiler can read
  into the compile, and the error messages quote pieces of it back to the pupil.
  `{$I %NAME%}` does the same with environment variables.
- **Running what compiled means running a pupil's program as that user.**
  Somebody will try `fpSystem('cat ...')` within a week.

So compile and run as a separate unprivileged user that cannot read
`/var/www/*/config` or `/var/www/*/data`, in a throwaway directory, with a time
limit (`timeout`), memory and process limits (`prlimit`), and no network. With
that in place the include trick just gets "file not found".

`bubblewrap` (`bwrap`) is the usual tool for the filesystem and network part.
It is not installed, and this server has
`kernel.apparmor_restrict_unprivileged_userns = 1` - Ubuntu 24.04's default -
which blocks the user namespaces bwrap relies on unless an AppArmor profile
allows them.

**Tested directly against this server, 11 September 2026 - see
[compile-subsystem-design.md](compile-subsystem-design.md) for the full
findings.** Bubblewrap-style unprivileged namespaces are indeed blocked
(confirmed: `unshare --user` as a non-root user fails). `systemd-run
--property=DynamicUser=yes` is not blocked by the same restriction, and a
full compile-and-run - isolated, no network, config.php unreadable
(including via Pascal's own `{$I}` include directive), memory and wall-clock
limits both enforced - was proven working end to end with real FPC 3.2.2.
`fp-compiler` is now installed on this server as part of that test.

**Built 12 September 2026 and re-validated against this server**, including two
things the 11 September design missed - see
[compile-subsystem-design.md](compile-subsystem-design.md), "What building it
changed". The one that matters here: **`ProtectSystem=strict` makes the
filesystem read-only, not unreadable.** A pupil's Pascal program was confirmed
reading `/var/www/itcoder/content/pascal/lesson02.php` - every quiz answer in
the course - because those files are chmod 644 and the sandbox's dynamic uid
counts as "other". Closed with `InaccessiblePaths=/var/www` (plus
`/var/backups`, `/var/log`). `config/` and `data/` were never exposed; they are
750 owned by `www-data`, which is exactly why the house rules below insist on
those permissions after every deploy.

Nothing is deployed yet - nothing under `/var/www` has been changed. The deploy
commands, including the new crontab line for `bin/compilequeue.php`, are at the
bottom of the design file.

Still not tested: fork-bomb/`TasksMax=` behaviour (Claude Code's own permission
classifier refuses to run that test even sandboxed and even with Chris's
explicit authorisation, given 12 September 2026 - run it directly; the exact
command is in the design doc) and concurrency under a lockstep class burst.

## Carried into AIPascalCourse on 11 September 2026

The itcoder v1 chat made these changes in `AIPascalCourse`, so v2 loses
nothing v1 had. Don't undo them:

- **`bin/backup.php`** - v1's nightly backup, with the table list changed to
  v2's (`pupils`, `enrolments`, ...). Tested against your local database. The
  02:30 cron already calls `/var/www/itcoder/bin/backup.php`, so it takes over
  the night you deploy.

  **If you RENAME or remove a table in `schema.sql`, change `$expected` in
  `bin/backup.php` and `SCHEMAS['v2']` in `AIResources/tools/pull-backups.py`
  to match**, or every backup is refused.

  **Adding a table is different, and the rule above used to get it wrong**
  (corrected 12 September 2026, while adding `codeSubmissions`). `backup.php`
  snapshots with `VACUUM INTO`, which copies the whole database, new tables
  included - `$expected` is the *verification* list, not the selection, so
  forgetting to add a new table there loses nothing, it just means the backup
  does not check that table arrived. Add it anyway. But do **not** add it to
  `SCHEMAS['v2']` in `pull-backups.py`: that check is `set(need) <= tables`, so
  naming a table there that older snapshots do not contain would make the pull
  reject **every backup taken before today** - 14 daily and 12 monthly of them.
  The shape-detection there only needs enough tables to tell v1 from v2, and
  `pupils` + `enrolments` already do that.
- **`bin/tune-fpm.sh`** - sizes the PHP-FPM pool from the real CPU and RAM.
  Unchanged from v1; how to use it is in its own header comment.
- **`lib/db.php`** - three PRAGMAs v1 gained after the server upgrade:
  `synchronous = NORMAL`, `mmap_size`, `temp_store = MEMORY`. Explained in the
  comments there.
- **`public/privacy.php`** - a paragraph saying backups are also kept on the
  site owner's computer and in Dropbox, i.e. outside South Africa. v1 already
  said this; without it the policy would be wrong again after cutover.
- **`README.md`** - the "copy that file and you have a backup" line, which is
  unsafe while the site runs (WAL), now points at `bin/backup.php`.

The Dropbox pull (`tools/pull-backups.py`, here) now accepts backups of
either shape, so nothing on that side has to happen at cutover.

## At cutover

**Leave the nginx server block alone.** The live one already has the same web
root (`/var/www/itcoder/public`) and FPM socket as v2's `nginx.conf.sample`,
plus the SSL block. The sample is the pre-certbot, port-80-only version, and the
v2 README's install step copies it over the live file. That would switch off
HTTPS.

**Take a backup first**, the safe way:
`sudo -u www-data php /var/www/itcoder/bin/backup.php`. Never by copying the
database file - the site runs SQLite in WAL mode, so a plain copy can miss
committed data still sitting in the `-wal` file.

## House rules

- **Anything that touches the database runs as www-data:**
  `sudo -u www-data php bin/setup.php`. If root creates or writes the SQLite file
  or its `-wal`/`-shm`, the site can no longer write to it and every save fails
  with "attempt to write a readonly database".
- **SFTP uploads land owned by root.** After a deploy:

      chown -R www-data:www-data /var/www/itcoder
      find /var/www/itcoder -type d -exec chmod 755 {} +
      find /var/www/itcoder -type f -exec chmod 644 {} +
      chmod 750 /var/www/itcoder/config /var/www/itcoder/data
      chmod 640 /var/www/itcoder/config/config.php

- **Test before you reload.** `nginx -t` before `systemctl reload nginx`,
  `php-fpm8.3 -t` before touching FPM. Reload rather than restart. Copy a config
  aside (`cp -a x x.bak-$(date +%F)`) before changing it.
- **Nothing gets deleted without asking Chris.** That goes double for
  `/var/www/marking-app` and `/var/backups`.
- **Secrets stay out of the chat.** Read the Google client secret and the
  Anthropic key programmatically; never echo them.
- **Some server actions get blocked by Claude Code's permission checker.** It
  stopped an nginx switch during the v1 work. Don't work around it: write the
  change as a file and give Chris the exact commands to run.
- **Windows:** run Python with `-X utf8`, or the console chokes on output. Don't
  name a script after a standard-library module - an `inspect.py` in the
  scratchpad once broke every script in it.
