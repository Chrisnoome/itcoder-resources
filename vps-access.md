# The BestLessons VPS

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
| Stack | nginx, PHP 8.3-FPM (pool `www`, `pm.max_children = 40` via `bin/tune-fpm.sh`), certbot, cron, fp-compiler 3.2.2, openjdk-21-jdk-headless 21.0.12 (installed 25 Sep 2026 for the Java course, `/usr/lib/jvm/java-21-openjdk-amd64`), MySQL 8.0.46 and Apache Derby 10.17.1.0 (25 Sep 2026, for the SQL course - see below), SQLite 3.45.1 (PHP's) |

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

- **PHP 8.3 extensions**: curl, mbstring, mysql, sqlite3, xml, zip and **gd**
  (`php8.3-gd`, apt, 2 October 2026 - Chris: "install gd": it shrinks the
  pictures pupils add to "Message my teacher" to 1600 px; php8.3-fpm reloaded,
  `/etc/php/8.3/fpm/conf.d/20-gd.ini`). In the install kit
  (`deploy/server/steps/10-packages.sh`, `php-gd`).
- `/var/www/itcoder` - **live**, https://itcoder.co.za. nginx
  `sites-enabled/itcoder` -> `sites-available/itcoder` (port-80 redirect +
  hand-written SSL block; certbot renews; current cert expires 8 Dec 2026).
  **Never copy `nginx.conf.sample` over it** - that switches off HTTPS.
- **bestlessons.co.za** (26 Sep 2026) - the same site, `/var/www/itcoder/public`:
  `sites-enabled/bestlessons` -> `sites-available/bestlessons` (hand-written;
  www and http go to https://bestlessons.co.za). Its own certbot certificate
  (nginx plugin, as itcoder's). Keep its 443 block the same as itcoder's apart
  from the names and certificate. The live console runner lists both domains
  in `/etc/itcoder-live/live.env` (`install-live.sh` writes the same).
- `/var/www/itcoder-v2-test` - the test site: own database, nginx block on port
  8082 (`sites-enabled/itcoder-v2-test`), `ufw` open for 8082 ("remove at
  teardown"), dev login on. **Password in front of it** (28 Sep 2026: its
  database holds real pupils' addresses): nginx `auth_basic` with
  `/etc/nginx/itcoder-test.htpasswd` (root:www-data 640), set by
  `tools/set-test-password.py`. Plain http, so the password must not be used
  anywhere else. Teardown commands in [open-items.md](open-items.md) (also
  remove the htpasswd file).
- `/var/www/marking-app` - a separate tool, nginx symlink disabled on purpose;
  its server block still names itcoder.co.za. Don't delete, re-enable or touch
  its database.
- `/usr/local/bin/itcoder-compile-sandbox.sh` - root:root 755, outside
  `/var/www` (a deploy chowns `/var/www` to www-data, which must never be able
  to rewrite what sudo runs). **Shared by live and test**; installed only by
  `publish-test.py`. `/etc/sudoers.d/itcoder-compile` (440) lets www-data run it
  with no arguments or `--tty` only. Removing that sudoers file switches
  compiling off.
- `/var/backups/itcoder` - 14 daily + 12 monthly verified snapshots, each with
  an age-encrypted `.gz.age` copy once `/etc/itcoder-backup/age-recipient.txt`
  (the backup key's PUBLIC half, 644) exists - `age` 1.1.1 from apt
  (backups.md, "Encryption").
- **nginx hardening** (28 Sep 2026, security review): `conf.d/itcoder.conf`
  (server_tokens off, the rate-limit zones - shared by every site) and
  `snippets/itcoder-limits.conf` (sign-in 5/s burst 100, `/api/` 50/s burst
  300 per address - sized for a class behind one school address), included
  in each site block that runs PHP; `/assets/` repeats the three security
  headers. Written by `tools/nginx_hardening.py` from both publish scripts
  (templates in `AIPascalCourse/deploy/templates`). Measured on test: a burst
  of 600 at 100 at once gave 384 x 200 and 216 x 429.
- The cron logs are 640 (the reminder logs name pupils) - 28 Sep 2026.
- **www-data's crontab** - every line's log must already exist, owned by
  www-data (`touch /var/log/X.log && chown www-data:www-data /var/log/X.log`);
  otherwise the line fails silently:
  - `* * * * *` `/var/www/itcoder/bin/markqueue.php` -> `itcoder-marking.log`
  - `* * * * *` `/var/www/itcoder/bin/compilequeue.php` -> `itcoder-compile.log`
    (empty when idle is normal)
  - `30 2 * * *` `/var/www/itcoder/bin/backup.php` -> `itcoder-backup.log`
  - `30 4 * * 1-5` `/var/www/itcoder/bin/remind.php` -> `itcoder-remind.log`
    (06:30 SA time; weekly reminders to pupils behind - added by deploy-live.py
    from 27 Sep 2026, live only; the server clock is UTC)
  - test: `itcoder-v2-test/bin/markqueue.php` -> `itcoder-v2-test-marking.log`,
    `itcoder-v2-test/bin/compilequeue.php` -> `itcoder-v2-test-compile.log`
    (remove at teardown)

## whisper.cpp (spoken flash cards, 25 Sep 2026)

- `/opt/whisper.cpp` - v1.9.4 built from source (`build-essential`, `cmake`
  installed for it), root-owned, world-readable. Binary
  `build/bin/whisper-cli`; model `models/ggml-base.en.bin` (148 MB, sha256
  a03779c8...). Shared by live and test; PHP runs it as www-data
  (`PracticeTranscribe()` in lib/practice.php; paths overridable with
  `whisperCli` / `whisperModel` in config.php). Measured: ~0.7-1.5 s a word,
  ~150 MB RAM each, at most 2 at once.
- Rebuild: `cd /opt/whisper.cpp && git fetch --tags && git checkout <tag> &&
  cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=OFF &&
  cmake --build build -j 3 --target whisper-cli`. Removing the folder turns
  listening off; the site falls back to the honour system.
- Test clips from the first check are in `/tmp/wtest` (safe to delete).

## MySQL and Java DB for the SQL course (25 Sep 2026)

Installed for the SQL course's runner (courses/sql-course.md); **nothing
uses them yet** and they hold no data worth keeping (no backups needed).

- **MySQL 8.0.46** (`mysql-server`, apt, installed with
  `DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l`). Tuning in
  `/etc/mysql/mysql.conf.d/zz-itcoder.cnf`: `127.0.0.1` only, X protocol
  off, `performance_schema` off, 64 MB buffer pool, 30 connections -
  about 145 MB RAM. Default `sql_mode` kept (MySQL 8's, with
  `ONLY_FULL_GROUP_BY` - what pupils meet at school).
  **`lower_case_table_names = 1`** - table names ignore capitals, as on
  Windows (Chris's yes, 26 Sep 2026: the data folder was re-initialised
  for it, since it can only be set then; the old one, holding nothing but
  MySQL's own schemas, is at `/var/lib/mysql.old-2026-09-26` - safe to
  delete). **`skip-log-bin`** - no binary log: nothing replicates, and the
  runner's create-and-drop on every Run would grow it by about a gigabyte
  a month. After a re-initialise, run
  `INSTALL PLUGIN auth_socket SONAME 'auth_socket.so'`, set root to
  `auth_socket`, and recreate `debian-sys-maint` with the password in
  `/etc/mysql/debian.cnf` (what Ubuntu's installer normally does) - the
  scripts used are `/root/mysql-reset.sh` and `/root/mysql-reset-accounts.sh`
  (done; don't run again). MySQL's `root` signs in through the socket as
  the system root, no password. The runner's own account: see below.
- **Apache Derby (Java DB) 10.17.1.0** - `/opt/derby` ->
  `/opt/derby-10.17.1.0` (`derby`, `derbyshared`, `derbytools` jars from
  Maven Central, SHA-1 checked; root-owned, world-readable), run on the
  server's Java 21: `java -cp '/opt/derby/*' org.apache.derby.tools.ij`.
  No service - Derby runs inside whatever Java process uses it. Set
  `derby.stream.error.file` (or `derby.system.home`), or Derby writes
  `derby.log` into the current folder.
- Checked: all 34 MySQL tests in `tools/sql-dialects/` gave the same
  results as MariaDB in MySQL 8's mode. Safe to delete: `/tmp/sqltest`,
  `/tmp/sqlbench`, `/tmp/mysql-install.log`, `/root/derby.log` (from the
  checks).

## Capacity (measured 25 Sep 2026)

**Chris (25 Sep 2026): warn him whenever a plan looks likely to hit the
server's limits.** The limits: 4 vCPU, 3.9 GB RAM, 2 GB swap (below).
Idle: ~1 GB used, ~2.9 GB available. One class is ~30 pupils pressing Run
together.

| One Run of | Time | Memory | 30 at once |
|---|---|---|---|
| MySQL (fresh database, 2 tables, 80 rows, a join, drop) | 0.11 s | mysqld grows to ~240 MB, shared | 0.85 s |
| Java DB, a new Java process per Run | 1.1 s | ~95 MB each | **17.6 s, load 10.6, ~2.85 GB** |
| javac + java, hello-world size | 0.75 s | ~72 MB each | **8.3 s, ~2.1 GB** |

- **Java DB must not start a Java process per Run** - one class would
  take almost all free memory and every CPU for ~18 s. Plan: one warm,
  sandboxed Derby service with a queue (courses/sql-course.md).
- **Java in the live console:** a running Java program holds ~70 MB for
  as long as its session lasts; the live slice's 1.5 GB cap fits ~20 at
  once, well under `MAX_SESSIONS` 60. Compiles queue (4 slots), so a
  class waits up to ~8 s. live-console-design.md already says Java wants
  a separate executor server.
- **Swap (Chris's yes, 25 Sep 2026):** `/swapfile`, 2 GB, root 600, in
  `/etc/fstab` (old copy `/etc/fstab.bak-2026-09-25`),
  `vm.swappiness = 10` in `/etc/sysctl.d/99-itcoder-swap.conf` - used only
  under memory pressure, so a spike means slowness instead of a killed
  process. If swap is often in use (`free -m`), the server needs more RAM.
- **Pupils are told Java is slower here** (the console's first Java run,
  its Help, Java lesson 3): their own computer is the best option; the
  console is for phones and tablets.
- If the server is ever rebuilt: the same apt line for `mysql-server`,
  the same `.cnf`, and the three jars into `/opt/derby-<version>`.
- **The SQL runner** (26 Sep 2026, [sql-runner-design.md](sql-runner-design.md))
  uses them: `itcoder-sql@test` is installed and running (user
  `itcoder-sql`, `/usr/local/lib/itcoder/sql/`, socket
  `/run/itcoder-sql-test/sql.sock`, MySQL account `itcoder_sql@127.0.0.1`,
  password in `/etc/itcoder-sql/mysql.password`), and the test site's
  config has `'sqlRunner'` (backup `config.php.bak-2026-09-25-230318`).
  Measured on the server: ~105 MB; 30 Runs at once in 1.06 s; systemd
  exposure 2.9 "OK". **On live since 1 October 2026** (Chris: MySQL Try-it said "not switched on"): `itcoder-sql@live`, socket `/run/itcoder-sql-live/sql.sock`, and live's config.php has `'sqlRunner'` (backup `config.php.bak-2026-10-01-074518`); proven with a real query in all three dialects through the site's own code; ~2.9 GB still available after. Install/update:
  `bash /var/www/itcoder-v2-test/bin/sql/deploy/install-sql.sh test`
  (after publish-test.py). It does not use `/opt/derby` (its own jars).

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

## Rebuilding the server: the install kit (27 Sep 2026)

`AIPascalCourse/deploy/` (in git) builds a NEW server from nothing: every
package, tool, setting, cron line and key on this page, in numbered steps
(`deploy/server/deploy.sh`), with the keys asked one at a time, each with help
(`deploy/questions.json`). From the PC: `deploy/install-from-pc.py` (IP,
password once, files from the PC or GitHub, a backup to restore). Its
`deploy/README.md` says how.

- **Never run it on live** (Chris, 27 September 2026: "don't test run the
  script on the live server"). It refuses a database with people in it.
- **Keep it current** (Chris, 27 September 2026: "check this whenever new
  tools are added to the system"): a new package, service, tool, cron job,
  config key, secret or `/etc` file on this server goes into `deploy/` in the
  same change - the README's "Keeping this current" lists where. Compare it
  with this page read-only; never by running it.

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
- **Settings Chris must put on the server** (an API key, a password, any
  config value): give him a script that **asks for the value** and he pastes
  it in (Chris, 27 September 2026: "have it ask for the key. i will paste it
  in. use this technique when i have to update settings on the server"). For
  `config/config.php` that script exists: `tools/set-server-config.py`
  (`mail` for the email settings, or any key names; `--site test`) - values
  shown as pasted (Chris wants to see the paste worked), secrets masked in the
  summary, sent over SSH standard input only, config backed up,
  `php -l`-checked and restored on failure, values never printed. Other
  settings: a script built the same way.
- If Claude Code's permission checker blocks a server action, don't work
  around it: write the change as a file and give Chris the commands.
