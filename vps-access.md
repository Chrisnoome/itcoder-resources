# The itcoder VPS

For local Claude Code sessions on Chris's machine. Publishing goes through
[publishing.md](publishing.md) only; backups in [backups.md](backups.md).

## Access

The route is **Python + paramiko** (`tools/vps.py`). Never `ssh`/`scp` from
Claude Code - the OpenSSH client is silently intercepted here and hangs.
(`ssh gnomemedia` works in Chris's own terminal.) Cloud sessions have no key
and port 22 blocked.

| | |
|---|---|
| Host | `102.214.9.207` - Absolute Hosting VPS "GnomeMedia" |
| User | `root`, key only (`/etc/ssh/sshd_config.d/00-root-keys-only.conf`) |
| Key | `C:\Users\chris\.ssh\gnomemedia_vps` (RSA, no passphrase) - load from there only; never print, copy or move it |
| Python | `C:\Python314\python.exe` or venv `D:\xampp\itcoder-tools-venv\Scripts\python.exe` (both have paramiko) |
| OS / size | Ubuntu 24.04.5 LTS; 4 vCPU, 3921 MB RAM, 77 GB disk (checked 10 Sep 2026) |
| Stack | nginx, PHP 8.3-FPM (pool `www`, `pm.max_children = 40` via `bin/tune-fpm.sh`), certbot, cron, fp-compiler 3.2.2 |

## tools/vps.py

`run(cmd)` runs as root and returns `(exit code, output)` - it does not raise,
so always check the code. `put()` uploads a file, `put_tree()` a folder (never
deletes, never uploads a database/WAL/lock). Keep scripts in your scratchpad,
not a project folder; write them to files, never inline Python in bash; use
forward slashes; run with `-X utf8`; don't name a script after a stdlib module.

```python
import sys
sys.dont_write_bytecode = True
sys.path.insert(0, r'D:\DB Sync\Dropbox\Projects\AIResources\tools')
import vps
print(vps.run('nginx -t'))
```

## What is on the server

- `/var/www/itcoder` - **live**, https://itcoder.co.za. nginx
  `sites-enabled/itcoder` -> `sites-available/itcoder` (port-80 redirect +
  hand-written SSL block; certbot renews; current cert expires 8 Dec 2026).
  **Never copy `nginx.conf.sample` over it** - that switches off HTTPS.
- `/var/www/itcoder-v2-test` - the test site: own database, nginx block on port
  8082 (`sites-enabled/itcoder-v2-test`), `ufw` open for 8082 ("remove at
  teardown"), dev login on. Teardown commands in [open-items.md](open-items.md).
- `/var/www/marking-app` - a separate tool, nginx symlink disabled on purpose;
  its server block still names itcoder.co.za. Don't delete, re-enable or touch
  its database.
- `/usr/local/bin/itcoder-compile-sandbox.sh` - root:root 755, outside
  `/var/www` (a deploy chowns `/var/www` to www-data, which must never be able
  to rewrite what sudo runs). **Shared by live and test**; installed only by
  `publish-test.py`. `/etc/sudoers.d/itcoder-compile` (440) lets www-data run it
  with no arguments or `--tty` only. Removing that sudoers file switches
  compiling off.
- `/var/backups/itcoder` - 14 daily + 12 monthly verified snapshots.
- **www-data's crontab** - every line's log must already exist, owned by
  www-data (`touch /var/log/X.log && chown www-data:www-data /var/log/X.log`);
  otherwise the line fails silently:
  - `* * * * *` `/var/www/itcoder/bin/markqueue.php` -> `itcoder-marking.log`
  - `* * * * *` `/var/www/itcoder/bin/compilequeue.php` -> `itcoder-compile.log`
    (empty when idle is normal)
  - `30 2 * * *` `/var/www/itcoder/bin/backup.php` -> `itcoder-backup.log`
  - test: `itcoder-v2-test/bin/markqueue.php` -> `itcoder-v2-test-marking.log`,
    `itcoder-v2-test/bin/compilequeue.php` -> `itcoder-v2-test-compile.log`
    (remove at teardown)

## Sandbox facts (why it is built as it is)

Details in [compile-subsystem-design.md](compile-subsystem-design.md).
Unprivileged user namespaces are blocked
(`kernel.apparmor_restrict_unprivileged_userns = 1`), so bubblewrap can't work;
`systemd-run --property=DynamicUser=yes` does. `{$I file}` and `{$I %ENV%}`
would read secrets into compiler errors, so the sandbox can't see
`/var/www`, `/var/backups` or `/var/log` at all (read-only is not unreadable:
lesson files are 644). Not yet tested: fork-bomb/`TasksMax=` behaviour (the
permission classifier refuses it - Chris runs it by hand; command in the design
doc) and a lockstep class burst.

If the server is ever rebuilt: install **`fp-compiler`** (13 packages), not
`fpc` (387), with `DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l` so PHP-FPM
isn't restarted; check `fpc -iV` = 3.2.2.

## Backups and schema changes

`bin/backup.php` snapshots with `VACUUM INTO` and verifies against `$expected`.
**Renaming or removing a table:** update `$expected` and `SCHEMAS['v2']` in
`tools/pull-backups.py`, or every backup is refused. **Adding a table:** add it
to `$expected`, but NOT to `SCHEMAS['v2']` (that would reject every older
snapshot). Take a manual backup as www-data
(`sudo -u www-data php /var/www/itcoder/bin/backup.php`), never by copying the
WAL-mode database file.

## House rules

- **Anything touching the database runs as www-data**
  (`sudo -u www-data php bin/setup.php`) - a root-owned `-wal`/`-shm` makes the
  database read-only for the site.
- After any upload (the scripts do this):

      chown -R www-data:www-data /var/www/itcoder
      find /var/www/itcoder -type d -exec chmod 755 {} +
      find /var/www/itcoder -type f -exec chmod 644 {} +
      chmod 750 /var/www/itcoder/config /var/www/itcoder/data
      chmod 640 /var/www/itcoder/config/config.php

- `nginx -t` before `systemctl reload nginx`; `php-fpm8.3 -t` before FPM; reload,
  don't restart; copy a config aside (`cp -a x x.bak-$(date +%F)`) first.
- **Nothing is deleted without Chris** - doubly `/var/www/marking-app` and
  `/var/backups`.
- Secrets stay out of the chat - read them programmatically, never echo.
- If Claude Code's permission checker blocks a server action, don't work
  around it: write the change as a file and give Chris the commands.
