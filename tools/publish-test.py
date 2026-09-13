r"""Publish AIPascalCourse to the TEST deployment - /var/www/itcoder-v2-test,
http://102.214.9.207:8082 - and prove the compile sandbox works there.

    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"

Always the full interpreter path, never a bare `python` (see publishing.md).

This is step one of publishing, and tools/deploy-live.py REFUSES to run until
this has passed for the sandbox script that is currently installed. The order
is the point: test is where a change is allowed to be wrong.

What it does, in order:
  1. refuses a CRLF bin/compile-sandbox.sh (a Windows line ending in a bash
     script run by sudo breaks it on the server in ways that look like
     anything but a line-ending problem);
  2. uploads lib/, bin/, content/, public/ and schema.sql - NEVER config/ or
     data/, so the test deployment's own hand-written config and its own
     database are out of range entirely;
  3. fixes ownership and permissions (SFTP uploads land owned by root);
  4. runs bin/setup.php as www-data, so any new table or column exists before
     a page asks for it;
  5. if bin/compile-sandbox.sh differs from the root-owned installed copy,
     installs the new one - the installed copy is SHARED with live;
  6. runs tools/sandbox-check.php as www-data, through this deployment's own
     lib/compile.php and the real sudo -> systemd-run path, and records the
     installed sandbox's sha256 as validated only if every check passes.

Safe to run again. It never deletes anything on the server.
"""

import hashlib
import sys

sys.dont_write_bytecode = True
sys.path.insert(0, r'D:/DB Sync/Dropbox/Projects/AIResources/tools')

try:
    import paramiko  # noqa: F401 - vps.py needs it; checked here to explain
except ImportError:
    print('This Python has no paramiko:')
    print('    ' + sys.executable)
    print('Run it with the interpreter that does:')
    print(r'    & "C:\Python314\python.exe" -X utf8 '
          r'"D:/DB Sync/Dropbox/Projects/AIResources/tools/publish-test.py"')
    sys.exit(1)

import vps

LOCAL     = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse'
TEST      = '/var/www/itcoder-v2-test'
INSTALLED = '/usr/local/bin/itcoder-compile-sandbox.sh'
CHECK     = 'D:/DB Sync/Dropbox/Projects/AIResources/tools/sandbox-check.php'
MARKER    = '/root/itcoder-sandbox-validated.sha256'   # outside every web root

failures = []


def Step(label, cmd):
    code, out = vps.run(cmd)
    ok = (code == 0)
    print('[%s] %s' % ('ok ' if ok else 'FAIL', label))
    for line in out.strip().split('\n')[:40] if out.strip() else []:
        print('      ' + line[:180])
    if not ok:
        failures.append(label)
    return code, out


print('== 0. the sandbox script must have Unix line endings ==')
raw = open(LOCAL + '/bin/compile-sandbox.sh', 'rb').read()
if b'\r\n' in raw:
    print('[FAIL] bin/compile-sandbox.sh has Windows (CRLF) line endings.')
    print('       Convert it to LF before publishing - nothing has been uploaded.')
    sys.exit(1)
local_sha = hashlib.sha256(raw).hexdigest()
print('[ok ] LF only, sha256 %s' % local_sha[:16])

print('\n== 1. upload the code (never config/, never data/) ==')
for folder in ['lib', 'bin', 'content', 'public']:
    n = vps.put_tree('%s/%s' % (LOCAL, folder), '%s/%s' % (TEST, folder))
    print('      %s: %s files' % (folder, n))
vps.put(LOCAL + '/schema.sql', TEST + '/schema.sql')
print('      schema.sql')

print('\n== 2. ownership and permissions ==')
Step('chown', 'chown -R www-data:www-data %s' % TEST)
Step('dirs 755, files 644',
     'find %s -type d -exec chmod 755 {} + && find %s -type f -exec chmod 644 {} +' % (TEST, TEST))
Step('config/data 750, config.php 640',
     'chmod 750 %s/config %s/data && chmod 640 %s/config/config.php' % (TEST, TEST, TEST))

print('\n== 3. tables and columns ==')
Step('setup.php', 'cd %s && sudo -u www-data php bin/setup.php' % TEST)

print('\n== 4. the root-owned sandbox (shared with live) ==')
code, out = vps.run('sha256sum %s 2>/dev/null' % INSTALLED)
installed_sha = out.split()[0] if (code == 0 and out.strip()) else ''

if installed_sha == local_sha:
    print('[ok ] installed copy already matches bin/compile-sandbox.sh')
else:
    print('      installed %s  ->  new %s' % (installed_sha[:16] or 'none', local_sha[:16]))
    Step('uploaded copy matches local', "test \"$(sha256sum %s/bin/compile-sandbox.sh | cut -d' ' -f1)\" = %s"
         % (TEST, local_sha))
    Step('install', 'install -o root -g root -m 755 %s/bin/compile-sandbox.sh %s && ls -l %s'
         % (TEST, INSTALLED, INSTALLED))
    Step('forget the old validation', 'rm -f %s' % MARKER)

    code, out = vps.run('[ -e /var/www/itcoder/lib/compile.php ] && echo yes || echo no')
    if out.strip() == 'yes':
        print()
        print('      !! LIVE HAS THE COMPILE SUBSYSTEM AND NOW SHARES THIS NEW SANDBOX.')
        print('      !! If the change altered what PHP sends it, live compiles are broken')
        print('      !! until live is published too. Run deploy-live.py as soon as the')
        print('      !! checks below pass - do not leave it for later.')

Step('sudoers rule still valid', 'visudo -c -f /etc/sudoers.d/itcoder-compile')

print('\n== 5. prove the sandbox, as www-data, through the real sudo path ==')
vps.put(CHECK, '/tmp/itcoder-sandbox-check.php')
Step('sandbox checks', 'chmod 644 /tmp/itcoder-sandbox-check.php && cd %s && '
     'sudo -u www-data php /tmp/itcoder-sandbox-check.php %s' % (TEST, TEST))
vps.run('rm -f /tmp/itcoder-sandbox-check.php')

print('\n== 6. result ==')
if failures:
    print('FAILURES: ' + ', '.join(failures))
    print('The sandbox is NOT marked validated, so deploy-live.py will refuse to run.')
    sys.exit(1)

vps.run("sha256sum %s | cut -d' ' -f1 > %s && chmod 600 %s" % (INSTALLED, MARKER, MARKER))
print('ALL STEPS OK - test is published, and this sandbox (%s) is recorded as validated.'
      % local_sha[:16])
print('Check it in a browser on http://102.214.9.207:8082, then run deploy-live.py.')
