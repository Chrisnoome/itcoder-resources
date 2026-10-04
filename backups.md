# Backups

**Backups are pupils' personal data.** Never in AIResources, never quoted into
a chat, opened only to restore.

| Piece | Where | When |
|---|---|---|
| `bin/backup.php` | the site's `bin/` on the server | 02:30 nightly (www-data cron) |
| Server copies | `/var/backups/itcoder/course-YYYY-MM-DD-HHMMSS.sqlite.gz` | 14 nightly + the 1st of each month for a year |
| `tools/pull-backups.py` + `.cmd` | this folder | 18:30 daily, Windows task **itcoder backup pull** |
| Encrypted copies | the same folder, `...sqlite.gz.age` beside each server backup | made with each backup once the public key is there |
| Local copies | `D:\DB Sync\Dropbox\Projects\AIWebCourse\backups` - **encrypted only** once set up | kept forever |
| The backup key | secret: `C:\Users\chris\.ssh\itcoder-backups.agekey` + Chris's second copy; public: server `/etc/itcoder-backup/age-recipient.txt` | made once |
| Logs | server `/var/log/itcoder-backup.log`; local `pull-backups.log`, `task-output.log` in the local folder | |

## Encryption (Chris, 28 September 2026)

Backups leave South Africa (Dropbox), so the pull keeps only **age-encrypted**
copies. `bin/backup.php` makes `course-...sqlite.gz.age` beside each verified
backup with the **public** key (it can lock, never unlock); the plain `.gz`
stays on the server for a quick restore and never leaves it. The pull fetches
only `.age` files, decrypts each in memory and checks it as before, so a copy
the key cannot open is caught the day it arrives. Only Chris holds the
**secret** key: on his PC outside Dropbox, plus one copy he keeps elsewhere
(password manager or paper) - **lose both and the Dropbox copies can never be
opened**; the server's own 14 days and 12 months are unaffected.

- **Set up / check:** Chris runs `tools/setup-backup-encryption.py` with the
  venv's Python (its docstring has the command). It installs pyrage, makes
  the key (never replaces one), puts `age` and the public key on the server,
  proves the pair with a test message, and - once the new backup.php is live -
  makes the first encrypted backup. **Never run it from a chat: it shows the
  secret key.** Safe to run again.
- **The plain backups already in Dropbox:** `pull-backups.py --encrypt-existing`
  encrypts each, checks it byte for byte, then asks before deleting the plain
  ones (Dropbox keeps deleted files a while - empty them there too).
- **If the server is not encrypting** (key on the PC, no `.age` on the server)
  the pull warns and notifies with what to do, instead of "backups stopped".
- **A failed encryption** is logged as a WARNING line in the backup log; the
  plain backup is kept, and the pull's staleness alarm fires within 36 hours.

## backup.php

- **`VACUUM INTO`, never a file copy** - WAL mode means a copied file can miss
  committed data.
- Every backup is opened and checked (`integrity_check`, expected tables, row
  counts), gzipped, `0640`, in a `0750` directory outside the site.
- **Every table the database has must arrive; a listed table the database
  does not have yet is only named** ("not in the database yet: ...") - a
  deploy backs up before setup.php adds new tables, and an interrupted deploy
  can leave the new backup.php on the server first (28 Sep 2026: that failed
  the pre-deploy backup). The snapshot is `0640` from the moment it exists,
  and a failed run removes its own snapshot.
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

**From an encrypted local copy** (the server's own copies are gone): on the PC,
`pull-backups.py --decrypt <path to the .sqlite.gz.age>` writes the plain
`.sqlite` to `D:\itcoder-restore` (outside Dropbox) and checks it; upload that
as `/tmp/restore.sqlite`, carry on as above, then **delete the plain copy on
both machines**.

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

- **Encryption switched on** - built 28 Sep 2026 (above); it starts when Chris
  has run setup-backup-encryption.py and the new backup.php is live. Until
  then the pull keeps plain copies as before.
- **Retention** - local copies are kept forever; POPIA prefers a limit. Chris
  to choose one.
- **Local folder** is under the legacy `AIWebCourse`. If it moves, change
  `LOCAL_DIR` in `pull-backups.py` and `DATA` in `pull-backups.cmd` together.
