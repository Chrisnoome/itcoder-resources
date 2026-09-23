# Backups

**Backups are pupils' personal data.** Never in AIResources, never quoted into
a chat, opened only to restore.

| Piece | Where | When |
|---|---|---|
| `bin/backup.php` | the site's `bin/` on the server | 02:30 nightly (www-data cron) |
| Server copies | `/var/backups/itcoder/course-YYYY-MM-DD-HHMMSS.sqlite.gz` | 14 nightly + the 1st of each month for a year |
| `tools/pull-backups.py` + `.cmd` | this folder | 18:30 daily, Windows task **itcoder backup pull** |
| Local copies | `D:\DB Sync\Dropbox\Projects\AIWebCourse\backups` | kept forever |
| Logs | server `/var/log/itcoder-backup.log`; local `pull-backups.log`, `task-output.log` in the local folder | |

## backup.php

- **`VACUUM INTO`, never a file copy** - WAL mode means a copied file can miss
  committed data.
- Every backup is opened and checked (`integrity_check`, expected tables, row
  counts), gzipped, `0640`, in a `0750` directory outside the site.
- Table changes: see [vps-access.md](vps-access.md), "Backups and schema
  changes" (`$expected` vs `SCHEMAS['v2']`).
- By hand: `sudo -u www-data php /var/www/itcoder/bin/backup.php`

## Restoring

Check first; move the live database aside, never delete it:

    gunzip -c /var/backups/itcoder/course-XXXX.sqlite.gz > /tmp/restore.sqlite
    sudo -u www-data php -r '$p = new PDO("sqlite:/tmp/restore.sqlite");
      echo $p->query("PRAGMA integrity_check")->fetchColumn(), " people=",
      $p->query("SELECT COUNT(*) FROM pupils")->fetchColumn(), PHP_EOL;'

If `ok` with a sensible count:

    mv /var/www/itcoder/data/course.sqlite /var/www/itcoder/data/course.sqlite.replaced-$(date +%F)
    rm -f /var/www/itcoder/data/course.sqlite-wal /var/www/itcoder/data/course.sqlite-shm
    cp /tmp/restore.sqlite /var/www/itcoder/data/course.sqlite
    chown www-data:www-data /var/www/itcoder/data/course.sqlite
    chmod 640 /var/www/itcoder/data/course.sqlite

Deleting the stale `-wal`/`-shm` matters - an old log beside a restored
database corrupts it. A local copy is uploaded first with `vps.put()`.

## pull-backups.py

Fetches new server backups over the SSH key, **verifies each after it lands**,
keeps them in Dropbox, never deletes locally. Accepts v1 (`learners`) or v2
(`pupils`) shapes; a backup with a table missing is refused and logged.

    python tools/pull-backups.py --list          # compare, change nothing
    python tools/pull-backups.py                 # fetch and verify
    python tools/pull-backups.py --stale-hours 1 # test the alarm

**Staleness alarm:** if the newest server backup is over 36 hours old, it logs
a warning with the tail of the server log, shows a Windows notification that
stays until dismissed, and exits 2. Connection failures log but don't notify
(a network blocking SSH would cry wolf).

## The scheduled task

**itcoder backup pull** - daily 18:30, as chris when logged on, starts late if
missed, 15-minute limit. Runs the `.cmd` (Task Scheduler swallows errors; the
`.cmd` writes `task-output.log`) with the venv `D:\xampp\itcoder-tools-venv`
(the task can't import per-user paramiko). Rebuild:

    py -m venv D:\xampp\itcoder-tools-venv
    D:\xampp\itcoder-tools-venv\Scripts\python.exe -m pip install paramiko

The task still runs `AIWebCourse\tools\pull-backups.cmd`, a two-line stand-in
calling the real `.cmd` here. To re-point it (admin PowerShell), then delete
the stand-in and `AIWebCourse\tools` - **not before**, or the pull silently
stops:

    Set-ScheduledTask -TaskName 'itcoder backup pull' -Action (New-ScheduledTaskAction -Execute 'D:\DB Sync\Dropbox\Projects\AIResources\tools\pull-backups.cmd' -WorkingDirectory 'D:\DB Sync\Dropbox\Projects\AIResources\tools')

## Not done

- **Encryption** - plain gzip, a copy in Dropbox outside South Africa
  (`privacy.php` says so). Encrypt before the pull, or keep copies in SA.
- **Local folder** is under the legacy `AIWebCourse`. If it moves, change
  `LOCAL_DIR` in `pull-backups.py` and `DATA` in `pull-backups.cmd` together.
