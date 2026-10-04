"""Sets up encrypted backups, step by step - Chris runs it and answers the
questions (Chris, 28 September 2026: "you will have to hand hold me through the
encrypted backups"). Safe to run again: every step checks first and skips what
is already done. NEVER run it from a Claude chat - step 3 shows the secret key.

PowerShell (the backup pull's own Python, so the library lands where the pull
needs it):

    & "D:\\xampp\\itcoder-tools-venv\\Scripts\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/setup-backup-encryption.py"

What it does (AIResources/backups.md, "Encryption"):
  1. explains the idea;
  2. installs pyrage (the age encryption library) into this Python, if missing;
  3. makes your backup key: a pair - a SECRET key kept on this PC, outside
     Dropbox (~/.ssh/itcoder-backups.agekey), plus a second copy YOU keep
     somewhere safe; and a PUBLIC key that can only lock, never unlock;
  4. gives the server the public key and the `age` tool, and proves the pair
     works: the server locks a test message, this PC unlocks it;
  5. makes the first encrypted backup (once the new backup.php is on live).
"""
import os, subprocess, sys, textwrap, time
sys.dont_write_bytecode = True
sys.path.insert (0, os.path.dirname (os.path.abspath (__file__)))

AGE_KEY   = os.path.expanduser (r'~\.ssh\itcoder-backups.agekey')
RECIPIENT = '/etc/itcoder-backup/age-recipient.txt'
LIVE      = '/var/www/itcoder'


def Say (text = ''):
    print (textwrap.fill (text, 78) if text else '')


def Heading (text):
    print ('\n' + '=' * 78 + '\n' + text + '\n' + '=' * 78)


def Ask (question):
    return input ('\n' + question + ' ').strip ()


def Stop (text):
    print ('\n' + text)
    input ('\nPress Enter to close.')
    sys.exit (1)


# ---- 1. the idea -----------------------------------------------------------

Heading ('STEP 1 of 5 - what this does')
Say ('Every night the server makes a backup of the database - pupils\' names, email addresses and '
     'their work - and your PC copies it into Dropbox. Dropbox is outside South Africa, so the '
     'copies there should be locked.')
Say ()
Say ('This sets up a lock with two keys. The PUBLIC key can only lock: it goes on the server, which '
     'locks each backup before your PC fetches it. The SECRET key is the only thing that can unlock: '
     'it stays on this PC (not in Dropbox), and you keep ONE more copy somewhere safe.')
Say ()
Say ('If both copies of the secret key are ever lost, the backups in Dropbox can never be opened '
     'again - by anyone, including you. The server\'s own recent copies (the last 14 days and one per '
     'month) are not affected, so the site itself is never at risk.')
if Ask ('Carry on? [y/N]').lower () != 'y':
    Stop ('Nothing changed.')

# ---- 2. the library --------------------------------------------------------

Heading ('STEP 2 of 5 - the encryption library (pyrage)')
try:
    import pyrage
    Say ('Already installed in this Python - skipping.')
except ImportError:
    Say ('pyrage is the Python version of "age", a small, widely used encryption tool. It comes from '
         'PyPI, the standard place Python libraries come from, and is installed only into this Python:')
    Say ('    ' + sys.executable)
    if Ask ('Install pyrage now? [y/N]').lower () != 'y':
        Stop ('Nothing changed - run this again when you are ready.')
    result = subprocess.run ([sys.executable, '-m', 'pip', 'install', 'pyrage'])
    if result.returncode != 0:
        Stop ('pip could not install pyrage (see above). Nothing else changed.')
    import pyrage
    Say ('Installed.')

from pyrage import x25519, encrypt, decrypt

# ---- 3. the key ------------------------------------------------------------

Heading ('STEP 3 of 5 - your backup key')
if os.path.exists (AGE_KEY):
    lines    = [l.strip () for l in open (AGE_KEY, encoding = 'ascii') if l.strip () and not l.startswith ('#')]
    identity = x25519.Identity.from_str (lines[-1])
    Say ('You already have a backup key at ' + AGE_KEY + ' - using it (it is never replaced; a new '
         'one could not open the backups the old one locked).')
else:
    identity = x25519.Identity.generate ()
    public   = str (identity.to_public ())
    os.makedirs (os.path.dirname (AGE_KEY), exist_ok = True)
    with open (AGE_KEY, 'x', encoding = 'ascii', newline = '\n') as fh:
        fh.write ('# itcoder / BestLessons backup key - made %s by setup-backup-encryption.py\n'
                  '# It opens the encrypted backups (.sqlite.gz.age). Keep it secret; never put it in Dropbox.\n'
                  '# public key: %s\n%s\n' % (time.strftime ('%Y-%m-%d'), public, str (identity)))
    Say ('Made. The secret key is saved on this PC at:')
    Say ('    ' + AGE_KEY)
    Say ()
    Say ('Now keep ONE more copy somewhere that is not this PC and not Dropbox - the best is your '
         'password manager (a new secure note), or printed on paper and filed at home. Copy the whole '
         'line below, including AGE-SECRET-KEY-1 at the start:')
    print ('\n    ' + str (identity) + '\n')
    Say ('Do not email it, message it or paste it into a chat.')
    while Ask ('When the second copy is safe, type SAVED:').upper () != 'SAVED':
        pass
    print ('\n' * 40)   # scroll the key off the screen
    Say ('Thank you - the key has been scrolled off the screen.')

public = str (identity.to_public ())
Say ('Your PUBLIC key (safe to show anyone - it can only lock): ' + public)

# ---- 4. the server -----------------------------------------------------------

Heading ('STEP 4 of 5 - the server')
import vps

code, out = vps.run ('command -v age || (DEBIAN_FRONTEND=noninteractive NEEDRESTART_MODE=l apt-get install -y age >/dev/null 2>&1 && command -v age)')
if code != 0:
    Stop ('Could not install age on the server:\n' + out)
Say ('age is on the server: ' + out.strip ().splitlines ()[-1])

code, out = vps.run ("mkdir -p /etc/itcoder-backup && chmod 755 /etc/itcoder-backup && "
                     "printf '%%s\\n' '%s' > %s && chmod 644 %s && cat %s" % (public, RECIPIENT, RECIPIENT, RECIPIENT))
if code != 0 or out.strip () != public:
    Stop ('Could not write the public key on the server:\n' + out)
Say ('The server has the public key (' + RECIPIENT + ').')

# The proof: the server locks a message with what it has; this PC unlocks it.
message = 'itcoder backup key test ' + time.strftime ('%Y-%m-%d %H:%M:%S')
code, out = vps.run ("printf '%%s' '%s' | age -R %s | base64 -w0" % (message, RECIPIENT))
try:
    import base64
    ok = (code == 0 and decrypt (base64.b64decode (out.strip ()), [identity]).decode () == message)
except Exception:
    ok = False
if not ok:
    Stop ('The test failed - the server\'s lock and this PC\'s key do not match. Nothing is encrypted yet, '
          'so nothing is lost. Ask a Claude chat to look at setup-backup-encryption.py.')
Say ('Tested: the server locked a message and this PC unlocked it. The pair works.')

# ---- 5. the first encrypted backup ------------------------------------------

Heading ('STEP 5 of 5 - the first encrypted backup')
code, out = vps.run ("grep -q 'age-recipient' %s/bin/backup.php && echo ready || echo old" % LIVE)
if out.strip () != 'ready':
    Say ('The live site still has the old backup.php (the one that does not encrypt). Publish first - '
         'publish-test.py, then deploy-live.py - then run this script again: it will skip the finished '
         'steps and make the first encrypted backup.')
    input ('\nPress Enter to close.')
    sys.exit (0)

code, out = vps.run ('sudo -u www-data php %s/bin/backup.php 2>&1 | tail -3; ls -1 /var/backups/itcoder | tail -2' % LIVE)
print (out)
if '.age' not in out:
    Stop ('The backup ran but made no encrypted copy - see the lines above.')
Say ('The first encrypted backup is on the server.')
Say ()
Say ('Last two things, both in PowerShell with this same Python:')
Say ()
print ('  1. Fetch it now (the nightly pull does this from now on, encrypted only):')
print ('     & "%s" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/pull-backups.py"' % sys.executable)
print ()
print ('  2. Lock the plain backups already in Dropbox (it asks before deleting the plain ones):')
print ('     & "%s" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/pull-backups.py" --encrypt-existing' % sys.executable)
input ('\nDone. Press Enter to close.')
