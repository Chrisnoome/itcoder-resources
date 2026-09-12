# Backups

How the database is backed up, how to get a backup back, and what watches over
it. Built and tested 10-11 September 2026.

**Backups are pupils' personal data** - names, email addresses, written work.
They never go in AIResources, never get quoted into a chat, and are opened only
to restore.

## The pieces

| Piece | Where | When |
|---|---|---|
| `bin/backup.php` | on the server, in the site's `bin/` (v1 and v2 both have one) | 02:30 nightly, www-data's cron |
| Server copies | `/var/backups/itcoder/course-YYYY-MM-DD-HHMMSS.sqlite.gz` | 14 nightly + the 1st of each month for a year |
| `tools/pull-backups.py` + `.cmd` | this folder | 18:30 daily, Windows task **itcoder backup pull** |
| Local copies | `D:\DB Sync\Dropbox\Projects\AIWebCourse\backups` | kept forever - nothing is deleted locally |
| Logs | server: `/var/log/itcoder-backup.log`; local: `pull-backups.log` and `task-output.log` in the local backups folder | |

## On the server - `bin/backup.php`

- Uses **`VACUUM INTO`**, not a file copy. The site runs SQLite in WAL mode, and
  copying the live file can catch it mid-write: the `-wal` file holds committed
  data the main file has not absorbed yet, and the copy looks fine and is not.
- **Every backup is opened and checked before it is kept** - `integrity_check`,
  every expected table present, row counts - then gzipped, `chmod 0640`, in a
  `0750` directory outside the web root and outside the site folder, so it can't
  be downloaded or overwritten by a deploy.
- **The table list must match the schema.** v1's copy expects `learners, ...`;
  v2's (in `AIPascalCourse/bin/backup.php`) expects `pupils, enrolments, ...`.
  If a table is added or renamed in `schema.sql`, change `$expected` in v2's
  `backup.php` **and** `SCHEMAS['v2']` in `tools/pull-backups.py`, or every
  backup is refused. At cutover the v2 file lands on the same path, so the cron
  line needs no change.

Take one by hand, e.g. before a risky change:

    sudo -u www-data php /var/www/itcoder/bin/backup.php

## Restoring one

Check it before you trust it, and move the live database aside rather than
deleting it. On the server:

    gunzip -c /var/backups/itcoder/course-2026-09-11-023001.sqlite.gz > /tmp/restore.sqlite

    sudo -u www-data php -r '$p = new PDO("sqlite:/tmp/restore.sqlite");
      echo $p->query("PRAGMA integrity_check")->fetchColumn(), " people=",
      $p->query("SELECT COUNT(*) FROM pupils")->fetchColumn(), PHP_EOL;'

(A v1 backup has `learners` where v2 has `pupils`.) If it says `ok` and a
sensible number, swap it in:

    mv /var/www/itcoder/data/course.sqlite /var/www/itcoder/data/course.sqlite.replaced-$(date +%F)
    rm -f /var/www/itcoder/data/course.sqlite-wal /var/www/itcoder/data/course.sqlite-shm
    cp /tmp/restore.sqlite /var/www/itcoder/data/course.sqlite
    chown www-data:www-data /var/www/itcoder/data/course.sqlite
    chmod 640 /var/www/itcoder/data/course.sqlite

Deleting the stale `-wal` and `-shm` matters: an old write-ahead log next to a
restored database is a good way to corrupt the thing you just restored. To
restore from a local copy, upload it first (`vps.put()` - see
[vps-access.md](vps-access.md)).

## Off the server - `tools/pull-backups.py`

Server copies do not survive losing the server. The pull fetches anything new
over the same SSH key, **verifies each file after it lands** (a half-finished
transfer is the silent failure that matters), and keeps it in Dropbox. It never
deletes locally, so Dropbox is the longer archive.

It accepts backups of **either shape**, v1 or v2, so the cutover needs nothing
here. A backup with a table missing is refused and the log names the table.

From the AIResources folder:

    python tools/pull-backups.py --list    # compare both sides, change nothing
    python tools/pull-backups.py           # fetch and verify

**The staleness alarm.** Seen from Windows, a server that has stopped backing up
looks exactly like "nothing new". So every run checks how old the newest server
backup is. Past **36 hours** - one missed night - it logs a warning, copies the
tail of the server's backup log into the local log, puts a Windows notification
on screen that stays until dismissed, and exits with code 2. To see it without a
real failure:

    python tools/pull-backups.py --stale-hours 1

Connection failures are logged but raise no notification on purpose: a laptop on
a network that blocks SSH would otherwise cry wolf every day.

## The scheduled task

**itcoder backup pull** - daily 18:30, runs as chris only when logged on, starts
late if the laptop was off, 15-minute limit. It runs the `.cmd`, not Python
directly, because Task Scheduler gives the process no console and swallows
errors; the `.cmd` sends everything to `task-output.log`. It uses the venv at
`D:\xampp\itcoder-tools-venv`, because the task could not import paramiko from
the per-user packages (never explained; the venv sidesteps it). Rebuild if lost:

    py -m venv D:\xampp\itcoder-tools-venv
    D:\xampp\itcoder-tools-venv\Scripts\python.exe -m pip install paramiko

**One loose end (11 September 2026).** The tools moved here from
`AIWebCourse\tools`, but re-pointing the task needs administrator rights, which
Claude's shell does not have. So the task still runs
`AIWebCourse\tools\pull-backups.cmd`, now a two-line stand-in that calls the real
`.cmd` in this folder. It works - tested, result 0. To finish the job, run this
once in a PowerShell opened **as administrator**:

    Set-ScheduledTask -TaskName 'itcoder backup pull' -Action (New-ScheduledTaskAction -Execute 'D:\DB Sync\Dropbox\Projects\AIResources\tools\pull-backups.cmd' -WorkingDirectory 'D:\DB Sync\Dropbox\Projects\AIResources\tools')

Then delete `AIWebCourse\tools\pull-backups.cmd` and the empty `tools` folder.
**Don't delete the stand-in before re-pointing the task** - the pull would fail
every night without a trace, since the alarm lives inside the script that would
no longer start.

## Not done yet

- **Encryption.** Backups are plain gzip, and a copy sits in Dropbox, outside
  South Africa. `privacy.php` says so honestly. Encrypting before the pull (age
  or GPG, key kept somewhere other than this laptop), or a destination inside
  South Africa, is still a decision to take.
- **The local folder** is under `AIWebCourse`, a legacy project. It stays there
  until someone decides where pupils' data should live long-term. If it moves,
  change `LOCAL_DIR` in `pull-backups.py` and `DATA` in `pull-backups.cmd`
  together.
