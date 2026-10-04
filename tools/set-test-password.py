"""Puts a password on the test site (http://102.214.9.207:8082) - Chris types
(or pastes) it when asked; it is never shown again, stored on the PC or sent
anywhere but the server (Chris, 28 September 2026, after the security review:
the test site had dev login on for anyone, with real pupils' addresses in its
database - "password prompt").

PowerShell:

    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-test-password.py"

Run it again to change the password. The browser asks for the name and
password once per session; dev login still works behind it.

How: the password goes over the SSH channel's standard input to
`openssl passwd -apr1 -stdin` on the server, so only its hash is written -
to /etc/nginx/itcoder-test.htpasswd (root:www-data 640). The first run also
adds auth_basic to the test site's nginx block (copied aside first,
sites-available/itcoder-v2-test.bak-<date>); nginx -t must pass or the copy
goes back. Live (itcoder.co.za, bestlessons.co.za) is not touched.

The test site is plain http, so the password crosses the network unencrypted:
use one that is not used anywhere else.
"""
import os, re, sys
sys.dont_write_bytecode = True
sys.path.insert (0, os.path.dirname (os.path.abspath (__file__)))
import vps

SITE     = '/etc/nginx/sites-available/itcoder-v2-test'
PASSFILE = '/etc/nginx/itcoder-test.htpasswd'
# The server's own checks (install-live.sh's smoke test goes through nginx on
# 127.0.0.1:8082) need no password; everyone else does.
LOCAL_OK = ('    satisfy any;\n'
            '    allow 127.0.0.1;\n'
            '    allow ::1;\n'
            '    deny all;\n')
AUTH     = ('    # A password in front of the whole test site (set-test-password.py, 28 September 2026).\n'
            '    auth_basic "BestLessons test site";\n'
            '    auth_basic_user_file ' + PASSFILE + ';\n'
            + LOCAL_OK)

print ('A password for the TEST site (http://102.214.9.207:8082). Live is not touched.\n')

name = input ('User name [chris]: ').strip () or 'chris'
if not re.fullmatch (r'[A-Za-z0-9._-]{1,32}', name):
    sys.exit ('A user name is letters, digits, dot, dash or underscore - nothing changed.')

password = input ('Password (shown as you paste it; use one not used anywhere else): ')   # visible on purpose: Chris checks the paste worked
password = password.strip ()
if len (password) < 10 or '\n' in password:
    sys.exit ('Use at least 10 characters - nothing changed.')

print ('\nWill set: user %s, password (%d characters)' % (name, len (password)))
if input ('Put this password on the test site? [y/N] ').strip ().lower () != 'y':
    sys.exit ('Nothing changed.')

# 1. The hash, made on the server from standard input - the password is in no command line or file.
chan = vps.client ().get_transport ().open_session (timeout=30)
chan.set_combine_stderr (True)
chan.exec_command ("umask 027 && h=$(openssl passwd -apr1 -stdin) && [ -n \"$h\" ] "
                   "&& printf '%%s:%%s\\n' '%s' \"$h\" > %s.new && chown root:www-data %s.new && chmod 640 %s.new "
                   "&& mv %s.new %s && echo 'password file written'" % (name, PASSFILE, PASSFILE, PASSFILE, PASSFILE, PASSFILE))
chan.sendall ((password + '\n').encode ())
chan.shutdown_write ()
output = b''
while True:
    data = chan.recv (65536)
    if not data:
        break
    output += data
status = chan.recv_exit_status ()
chan.close ()
password = None   # drop it as soon as it is sent
print (output.decode ('utf-8', 'replace').strip ())
if status != 0:
    sys.exit ('The password file could not be written - nothing else changed.')

# 2. auth_basic in the test site's nginx block, once.
code, block = vps.run ('cat %s' % SITE)
if code != 0:
    sys.exit ('Could not read %s.' % SITE)

if 'auth_basic_user_file' in block and 'satisfy any;' in block:
    print ('nginx already asks for the password - only the password changed.')
elif 'auth_basic_user_file' in block:
    sys.exit ('nginx asks for the password but without the localhost exception (satisfy any) - add those lines by hand.')
else:
    if 'server_name 102.214.9.207;' not in block:
        sys.exit ('The nginx block does not look as expected (no "server_name 102.214.9.207;") - add the auth_basic lines by hand.')
    new_block = block.replace ('server_name 102.214.9.207;\n', 'server_name 102.214.9.207;\n\n' + AUTH, 1) + '\n'   # run() strips the last newline
    local = os.path.join (os.environ.get ('TEMP', '.'), 'itcoder-v2-test.nginx')
    open (local, 'w', encoding='utf-8', newline='\n').write (new_block)   # no secrets in this file
    code, out = vps.run ('cp -a %s %s.bak-$(date +%%F-%%H%%M%%S) && echo copied' % (SITE, SITE))
    if code != 0:
        sys.exit ('Could not copy the nginx block aside - nothing changed there.\n' + out)
    vps.put (local, SITE + '.new')
    os.remove (local)
    code, out = vps.run ('mv %s.new %s && nginx -t 2>&1' % (SITE, SITE))
    if code != 0:
        vps.run ('cp -a "$(ls -t %s.bak-* | head -1)" %s' % (SITE, SITE))
        sys.exit ('nginx -t failed - the old block is back:\n' + out)
    print ('nginx block updated (nginx -t passed).')

code, out = vps.run ('nginx -t 2>&1 && systemctl reload nginx && echo reloaded')
print (out.strip ())

code, out = vps.run ("curl -s -o /dev/null -w '%{http_code}' http://127.0.0.1:8082/")
print ('Test site without the password now answers: %s (401 = locked)' % out.strip ())
