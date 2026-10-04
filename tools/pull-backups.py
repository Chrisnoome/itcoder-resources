"""Pull the course database backups down from the VPS into Dropbox.

Lives in AIResources/tools; documented in AIResources/backups.md. Run from the
AIResources folder:

    python tools/pull-backups.py            # fetch anything new, verify it
    python tools/pull-backups.py --list     # just show both sides, change nothing

The server already keeps 14 nightly copies plus a year of month-firsts, but they
all live on the same VPS as the database. That covers a bad deploy or a wrong
DELETE. It does not cover losing the server. This is the other half.

Nothing is ever deleted locally. Backups compress to a few KB each, so a year of
them is a handful of megabytes, and deletion logic is where backup scripts go
wrong. The local copy therefore becomes the longer archive: it keeps the ones
that have already aged off the server.

Every file is opened after it lands and checked - integrity_check plus a row
count - because a transfer that half-worked is the failure mode that matters
here, and it is silent.

If the server stops making backups, this would otherwise just keep saying
"nothing new" for ever. So it also checks the age of the newest backup on the
server, and past a day and a half it logs a warning, copies the tail of the
server's backup log into the local log, puts a notification on screen and exits
with code 2. Try it without waiting for a real failure:

    python tools/pull-backups.py --stale-hours 1

ENCRYPTED (28 September 2026, security review): once the backup key is on this
PC (AGE_KEY below, made by setup-backup-encryption.py), only the server's
age-encrypted copies (.sqlite.gz.age) are pulled and kept - Dropbox never holds
a plain one again. Each is decrypted in memory and checked exactly as before,
so a backup the key cannot open is caught the day it arrives. Plain backups
pulled before then are encrypted in place, and the plain ones deleted after
asking, with:

    python tools/pull-backups.py --encrypt-existing
"""

import argparse
import base64
import datetime
import gzip
import os
import posixpath
import re
import sqlite3
import subprocess
import sys
import tempfile
from xml.sax.saxutils import escape

try:
    import paramiko
except ImportError as error:
    # Say what actually went wrong. "not installed" is a guess, and when this
    # ran under Task Scheduler the guess was wrong and cost an hour.
    sys.exit('cannot import paramiko: %s: %s%s   sys.executable = %s%s   sys.path = %s'
             % (type(error).__name__, error, chr(10), sys.executable, chr(10), sys.path))

HOST = '102.214.9.207'
USER = 'root'
KEY = os.path.expanduser(r'~\.ssh\gnomemedia_vps')
REMOTE_DIR = '/var/backups/itcoder'

# Dropbox, but deliberately outside any deployed tree, so a deploy never touches
# it and it never gets uploaded back to the server - and deliberately NOT in
# AIResources with this script, because these files are pupils' personal data
# and AIResources is the folder most likely to be shared. If it moves, change
# DATA in pull-backups.cmd to match.
LOCAL_DIR = r'D:\DB Sync\Dropbox\Projects\AIWebCourse\backups'
LOG = os.path.join(LOCAL_DIR, 'pull-backups.log')

# The tables a backup must contain. Two shapes, because the site is moving from
# the single-course version (v1, "learners") to the multi-course platform in
# AIPascalCourse (v2, "pupils" plus "enrolments"), and backups of both will sit
# side by side in Dropbox. A backup passes if it has every table of either
# shape. The first table of each holds the people, and that is the one counted.
SCHEMAS = {
    'v1': ['learners', 'quizResponses', 'writtenAnswers', 'activityState', 'apiUsage'],
    'v2': ['pupils', 'enrolments', 'quizResponses', 'writtenAnswers', 'activityState', 'apiUsage'],
}

# The server backs up at 02:30 every night, so while things are working its
# newest copy is never more than a day old. A day and a half means a single
# missed night is enough to raise the alarm.
STALE_HOURS = 36

# backup.php names every file with the UTC time the snapshot was taken; its
# encrypted copy adds .age.
STAMP = re.compile(r'^course-(\d{4}-\d{2}-\d{2}-\d{6})\.sqlite\.gz(\.age)?$')

# The key that opens the encrypted backups - NOT in Dropbox, beside the server
# key. Its public half is on the server (/etc/itcoder-backup/age-recipient.txt).
# Made by setup-backup-encryption.py; a second copy is kept off this PC.
AGE_KEY = os.path.expanduser(r'~\.ssh\itcoder-backups.agekey')


def load_age_identity():
    """The backup key, or None while backups are not encrypted yet."""
    if not os.path.exists(AGE_KEY):
        return None
    try:
        from pyrage import x25519
    except ImportError as error:
        sys.exit('the backup key is at %s but pyrage will not load (%s) - run setup-backup-encryption.py '
                 'with this Python: %s' % (AGE_KEY, error, sys.executable))
    lines = [l.strip() for l in open(AGE_KEY, encoding='ascii') if l.strip() and not l.startswith('#')]
    return x25519.Identity.from_str(lines[-1])

# Windows PowerShell 5.1 specifically - PowerShell 7 cannot reach the WinRT
# notification API.
POWERSHELL = os.path.join(os.environ.get('SystemRoot', r'C:\Windows'),
                          'System32', 'WindowsPowerShell', 'v1.0', 'powershell.exe')

# The app id Windows PowerShell registers itself under, borrowed so the
# notification has somewhere to come from.
TOAST_APP_ID = r'{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'


def say(message):
    line = '%s %s' % (datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S'), message)

    # The log first, and the console only if there is one. Task Scheduler
    # gives the process no console, so sys.stdout is None and an unguarded
    # print raises - which is exactly how a scheduled backup ends up failing
    # every night without writing one line saying why. It did, until this.
    try:
        os.makedirs(LOCAL_DIR, exist_ok=True)
        with open(LOG, 'a', encoding='utf-8') as fh:
            fh.write(line + '\n')
    except OSError:
        pass          # a broken log must not break the backup

    if sys.stdout is not None:
        try:
            print(line)
        except Exception:
            pass


def load_key():
    for loader in (paramiko.RSAKey, paramiko.Ed25519Key, paramiko.ECDSAKey):
        try:
            return loader.from_private_key_file(KEY)
        except Exception:
            continue
    sys.exit('could not read the key at %s' % KEY)


def verify(path, identity=None):
    """Decompress (decrypting first, with an identity) and open the backup.
    Returns (ok, description)."""
    tmp = None
    try:
        if identity is not None:
            from pyrage import decrypt
            with open(path, 'rb') as fh:
                plain = gzip.decompress(decrypt(fh.read(), [identity]))
            with tempfile.NamedTemporaryFile(suffix='.sqlite', delete=False) as dst:
                tmp = dst.name
                dst.write(plain)
            plain = None
        else:
            with gzip.open(path, 'rb') as src:
                with tempfile.NamedTemporaryFile(suffix='.sqlite', delete=False) as dst:
                    tmp = dst.name
                    while True:
                        chunk = src.read(262144)
                        if not chunk:
                            break
                        dst.write(chunk)

        con = sqlite3.connect(tmp)
        try:
            integrity = con.execute('PRAGMA integrity_check').fetchone()[0]
            if integrity.lower() != 'ok':
                return False, 'integrity_check said %r' % integrity

            tables = {r[0] for r in con.execute(
                "SELECT name FROM sqlite_master WHERE type = 'table'")}
            shape = next((s for s, need in SCHEMAS.items() if set(need) <= tables), None)
            if shape is None:
                # Name what is missing from whichever shape it came closest to.
                # Fewest missing first; on a tie, the shape it has most tables
                # of - a v2 database minus one table is also one short of v1.
                closest = min(SCHEMAS.values(),
                              key=lambda need: (len(set(need) - tables), -len(set(need) & tables)))
                return False, 'missing tables: %s' % ', '.join(sorted(set(closest) - tables))

            people_table = SCHEMAS[shape][0]
            people = con.execute('SELECT COUNT(*) FROM %s' % people_table).fetchone()[0]
            written = con.execute('SELECT COUNT(*) FROM writtenAnswers').fetchone()[0]
            return True, '%s=%d written=%d' % (people_table, people, written)
        finally:
            con.close()
    except Exception as error:
        return False, '%s: %s' % (type(error).__name__, error)
    finally:
        if tmp and os.path.exists(tmp):
            try:
                os.remove(tmp)
            except OSError:
                pass


def newest_backup(names):
    """The newest backup and its age in hours, or (None, None) if there are none."""
    stamped = sorted(n for n in names if STAMP.match(n))   # the names sort by time
    if not stamped:
        return None, None

    taken = datetime.datetime.strptime(STAMP.match(stamped[-1]).group(1), '%Y-%m-%d-%H%M%S')
    taken = taken.replace(tzinfo=datetime.timezone.utc)
    age = datetime.datetime.now(datetime.timezone.utc) - taken
    return stamped[-1], age.total_seconds() / 3600


def notify(title, message):
    """Put a Windows notification on screen. Returns True if it was shown.

    A log line nobody reads is exactly how backups stop unnoticed, so this one
    failure goes where Chris will see it. The 'reminder' scenario keeps the
    notification on screen until it is dismissed, rather than letting it slide
    away after five seconds while nobody is looking.
    """
    toast = ('<toast scenario="reminder"><visual><binding template="ToastGeneric">'
             '<text>%s</text><text>%s</text></binding></visual><actions>'
             '<action content="Dismiss" arguments="dismiss" activationType="system"/>'
             '</actions></toast>') % (escape(title), escape(message))

    script = '\n'.join([
        "$ErrorActionPreference = 'Stop'",
        "[void][Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]",
        "[void][Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime]",
        "$xml = New-Object Windows.Data.Xml.Dom.XmlDocument",
        "$xml.LoadXml('%s')" % toast.replace("'", "''"),
        "$toast = [Windows.UI.Notifications.ToastNotification]::new($xml)",
        "[Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier('%s').Show($toast)" % TOAST_APP_ID,
    ])

    # -EncodedCommand takes the script as base64 UTF-16, which sidesteps every
    # quoting rule between Python, cmd and PowerShell at once.
    encoded = base64.b64encode(script.encode('utf-16-le')).decode('ascii')

    try:
        result = subprocess.run(
            [POWERSHELL, '-NoProfile', '-NonInteractive', '-EncodedCommand', encoded],
            stdin=subprocess.DEVNULL, capture_output=True, timeout=60,
            creationflags=getattr(subprocess, 'CREATE_NO_WINDOW', 0))
    except (OSError, subprocess.SubprocessError) as error:
        say('could not show a notification: %s: %s' % (type(error).__name__, error))
        return False

    if result.returncode != 0:
        say('could not show a notification (exit %d): %s'
            % (result.returncode, result.stderr.decode('utf-8', 'replace').strip()[:300]))
        return False

    return True


def warn_stale(client, newest, age, limit):
    if newest is None:
        detail = 'there are no backups on the server at all'
    else:
        detail = 'the newest on the server is %s, %.0f hours old' % (newest, age)

    say('WARNING: backups have stopped - %s (the limit is %g hours)' % (detail, limit))

    # The server's own account of its last few runs, in the same log, so the
    # reason is one file away rather than one SSH session away.
    try:
        _, out, _ = client.exec_command('tail -n 5 /var/log/itcoder-backup.log 2>&1', timeout=30)
        for line in out.read().decode('utf-8', 'replace').splitlines():
            say('   server log: ' + line)
    except Exception as error:
        say('   could not read the server log: %s: %s' % (type(error).__name__, error))

    notify('itcoder backups have stopped',
           detail[0].upper() + detail[1:] + '. Check /var/log/itcoder-backup.log on the server.')


def encrypt_existing(identity):
    """Encrypts every plain backup already in Dropbox (course-*.sqlite.gz ->
    .sqlite.gz.age), checks each encrypted copy opens and matches byte for
    byte, then - only when asked at the console - deletes the plain ones."""
    if identity is None:
        say('no backup key at %s yet - run setup-backup-encryption.py first' % AGE_KEY)
        return 1

    from pyrage import encrypt, decrypt
    recipient = identity.to_public()
    plain = sorted(n for n in os.listdir(LOCAL_DIR) if STAMP.match(n) and n.endswith('.sqlite.gz'))
    done, failed = [], 0

    for name in plain:
        source = os.path.join(LOCAL_DIR, name)
        target = source + '.age'
        with open(source, 'rb') as fh:
            original = fh.read()
        if not os.path.exists(target):
            with open(target + '.part', 'wb') as fh:
                fh.write(encrypt(original, [recipient]))
            os.replace(target + '.part', target)
        with open(target, 'rb') as fh:
            same = decrypt(fh.read(), [identity]) == original
        ok, detail = verify(target, identity)
        if same and ok:
            done.append(name)
        else:
            failed += 1
            say('FAILED to encrypt %s safely (%s) - the plain file is kept' % (name, detail if not ok else 'not the same bytes'))

    say('encrypted and checked: %d, failed: %d' % (len(done), failed))

    if done and sys.stdin is not None and sys.stdin.isatty():
        answer = input('Delete the %d plain backups that now have a checked encrypted copy? '
                       'Dropbox keeps deleted files for a while - empty them from its "Deleted files" too. [y/N] ' % len(done))
        if answer.strip().lower() == 'y':
            for name in done:
                os.remove(os.path.join(LOCAL_DIR, name))
            say('deleted %d plain backups' % len(done))
        else:
            say('plain backups kept - run this again to delete them')

    return 1 if failed else 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--list', action='store_true', help='show both sides and exit')
    ap.add_argument('--stale-hours', type=float, default=STALE_HOURS,
                    help='warn if the newest backup on the server is older than this (default: %(default)s)')
    ap.add_argument('--encrypt-existing', action='store_true',
                    help='encrypt the plain backups already here, then offer to delete the plain ones')
    ap.add_argument('--decrypt', metavar='FILE',
                    help='for a restore: write FILE (a .sqlite.gz.age) as a plain .sqlite in D:\\itcoder-restore')
    args = ap.parse_args()

    os.makedirs(LOCAL_DIR, exist_ok=True)

    identity = load_age_identity()
    suffix = '.sqlite.gz.age' if identity is not None else '.sqlite.gz'

    if args.encrypt_existing:
        return encrypt_existing(identity)

    if args.decrypt:
        # Outside Dropbox on purpose: a plain copy must never sync. Delete it after the restore.
        if identity is None:
            say('no backup key at %s - it cannot be opened here' % AGE_KEY)
            return 1
        from pyrage import decrypt
        out_dir = r'D:\itcoder-restore'
        os.makedirs(out_dir, exist_ok=True)
        target = os.path.join(out_dir, os.path.basename(args.decrypt)[:-len('.gz.age')])
        with open(args.decrypt, 'rb') as fh:
            plain = gzip.decompress(decrypt(fh.read(), [identity]))
        with open(target, 'wb') as fh:
            fh.write(plain)
        ok, detail = verify(args.decrypt, identity)
        say('decrypted to %s (%s) - upload it for the restore (backups.md), then DELETE it' % (target, detail if ok else 'CHECK FAILED: ' + detail))
        return 0 if ok else 1

    client = paramiko.SSHClient()
    client.set_missing_host_key_policy(paramiko.AutoAddPolicy())

    try:
        client.connect(HOST, username=USER, pkey=load_key(), timeout=30,
                       allow_agent=False, look_for_keys=False)
    except Exception as error:
        say('FAILED to connect: %s: %s' % (type(error).__name__, error))
        return 1

    sftp = client.open_sftp()

    try:
        remote = {}
        plain_on_server = 0
        for entry in sftp.listdir_attr(REMOTE_DIR):
            if entry.filename.startswith('course-') and entry.filename.endswith(suffix):
                remote[entry.filename] = entry.st_size
            elif entry.filename.startswith('course-') and entry.filename.endswith('.sqlite.gz'):
                plain_on_server += 1
    except IOError as error:
        say('FAILED to list %s: %s' % (REMOTE_DIR, error))
        sftp.close()
        client.close()
        return 1

    local = {n: os.path.getsize(os.path.join(LOCAL_DIR, n))
             for n in os.listdir(LOCAL_DIR)
             if n.startswith('course-') and n.endswith(suffix)}

    # The key is on this PC but the server is not encrypting yet (backup.php
    # not deployed, or its public key missing): say so, rather than "stopped".
    if identity is not None and not remote and plain_on_server and not args.list:
        say('WARNING: this PC expects encrypted backups but the server has none yet (%d plain ones) - '
            'deploy-live.py, then run setup-backup-encryption.py again' % plain_on_server)
        notify('itcoder backups are not encrypted yet',
               'The server is still making plain backups only. Publish to live, then run setup-backup-encryption.py again.')
        sftp.close()
        client.close()
        return 2

    newest, age = newest_backup(remote)
    stale = newest is None or age > args.stale_hours

    if args.list:
        if sys.stdout is None:
            return 0          # --list only makes sense at a console

        say('server has %d, local has %d' % (len(remote), len(local)))
        for name in sorted(remote):
            here = local.get(name)
            state = 'have it' if here == remote[name] else ('size differs' if here else 'MISSING locally')
            print('   %-42s %6d B  %s' % (name, remote[name], state))
        only_local = sorted(set(local) - set(remote))
        if only_local:
            print('   %d kept locally that the server has already rotated away:' % len(only_local))
            for name in only_local[-5:]:
                print('     %s' % name)
        if newest is None:
            print('   STALE: the server has no backups at all')
        else:
            print('   newest on the server is %.1f hours old%s'
                  % (age, ' - STALE, the limit is %g' % args.stale_hours if stale else ''))
        sftp.close()
        client.close()
        return 0

    # Checked before "nothing new", because nothing new is exactly what a
    # stopped backup looks like from here.
    if stale:
        warn_stale(client, newest, age, args.stale_hours)

    status = 2 if stale else 0

    wanted = [n for n in sorted(remote) if local.get(n) != remote[n]]

    if not wanted:
        say('nothing new - %d backups already here (server holds %d)' % (len(local), len(remote)))
        sftp.close()
        client.close()
        return status

    fetched = 0
    failed = 0

    for name in wanted:
        target = os.path.join(LOCAL_DIR, name)
        part = target + '.part'
        try:
            sftp.get(posixpath.join(REMOTE_DIR, name), part)
        except Exception as error:
            say('FAILED to fetch %s: %s' % (name, error))
            failed += 1
            if os.path.exists(part):
                os.remove(part)
            continue

        ok, detail = verify(part, identity)

        if not ok:
            say('FAILED verification, not keeping %s - %s' % (name, detail))
            os.remove(part)
            failed += 1
            continue

        os.replace(part, target)
        fetched += 1
        say('pulled %s (%d B) verified: %s' % (name, os.path.getsize(target), detail))

    total = len([n for n in os.listdir(LOCAL_DIR) if n.startswith('course-')])
    say('done: %d pulled, %d failed, %d backups now in Dropbox' % (fetched, failed, total))

    sftp.close()
    client.close()
    return 1 if failed else status


if __name__ == '__main__':
    sys.exit(main())
