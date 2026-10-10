"""Sets settings in the server's config/config.php - Chris types (or pastes)
each value when asked; secrets are never shown, stored or sent anywhere else
(Chris, 27 September 2026: "have it ask for the key. i will paste it in. use
this technique when i have to update settings on the server").

PowerShell:

    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-server-config.py" mail
    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-server-config.py" someKey otherKey
    ... --site test     the test site's config instead of live
    ... --site both     live and test, asked once (Chris, 10 October 2026)

'mail' is shorthand for the email settings (lib/mail.php): brevoApiKey,
mailFrom, mailReplyTo, mailFromName, and mailEnabled switched on (live only).
'youtube' is youtubeApiKey (lib/youtubestats.php, Admin > Monitor's YouTube tab);
after writing it asks YouTube for the channel from each server, with that key:

    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/set-server-config.py" youtube --site both

For each setting it asks for the value - shown as it is typed or pasted, so
a paste can be seen to work (Chris, 27 September 2026); Enter alone leaves
that setting as it is; true/false and whole numbers are stored as such. It
then shows what it will change - a secret (key, secret, password, token) as
its first and last characters and its length - and asks before writing.

How: the config is copied aside (config.php.bak-<date>); a small helper with
no secrets in it is uploaded; the values go to it over the SSH channel's
standard input - never into a file on either machine; it adds or replaces
each 'key' => value line; the config must then pass php -l, or the copy goes
back. The helper is deleted, and only "set"/"present" is printed, never a value.
"""
import json, os, re, sys
sys.dont_write_bytecode = True
sys.path.insert (0, os.path.dirname (os.path.abspath (__file__)))
import vps

SITES   = {'live': '/var/www/itcoder', 'test': '/var/www/itcoder-v2-test'}
SECRET  = re.compile (r'key|secret|password|token', re.I)
PRESETS = {
    'mail': [('brevoApiKey', 'the Brevo API key (Brevo - SMTP & API - API keys)'),
             ('mailFrom', 'the sender address, e.g. reminders@bestlessons.co.za'),
             ('mailReplyTo', 'where replies go (your own address) - Enter to skip'),
             ('mailFromName', 'the sender name - Enter to follow the site brand'),
             ('supportEmail', 'where Help page messages go, e.g. support@bestlessons.co.za - Enter to skip')],
    'youtube': [('youtubeApiKey', 'the YouTube Data API v3 key (Google Cloud Console - APIs & Services - Credentials)')],
}

args = sys.argv[1:]
site = 'live'

if '--site' in args:
    at   = args.index ('--site')
    site = (args[at + 1:at + 2] or ['live'])[0]
    del args[at:at + 2]

if site not in SITES and site != 'both':
    sys.exit ('--site must be live, test or both')

if not args:
    sys.exit (__doc__)

sites = ['live', 'test'] if site == 'both' else [site]

wanted = []
for name in args:
    wanted += PRESETS.get (name, [(name, '')])

print ('Settings for the %s site%s (%s). Enter alone leaves a setting as it is.\n'
       % (' and '.join (s.upper () for s in sites), 's' if len (sites) > 1 else '', ', '.join (SITES[s] + '/config/config.php' for s in sites)))

values = {}
for key, hint in wanted:
    prompt = '%s%s: ' % (key, (' - ' + hint) if hint else '')
    raw = input (prompt)   # visible on purpose: Chris checks the paste worked
    raw = raw.strip ()
    if raw == '':
        continue
    if raw.lower () in ('true', 'false'):
        values[key] = (raw.lower () == 'true')
    elif re.fullmatch (r'-?\d+', raw):
        values[key] = int (raw)
    else:
        values[key] = raw

if not values:
    sys.exit ('Nothing to change.')

print ('\nWill set:')
for key, value in values.items ():
    text  = str (value)
    shown = ('%s...%s (%d characters)' % (text[:6], text[-4:], len (text)) if len (text) > 12 else '(%d characters)' % len (text))             if SECRET.search (key) else repr (value)
    print ('  %-14s %s' % (key, shown))
if 'mail' in args and 'live' in sites:
    print ('  %-14s %s' % ('mailEnabled', 'True (live only)'))

if input ('\nWrite these to the %s config%s? [y/N] ' % (' and '.join (sites), 's' if len (sites) > 1 else '')).strip ().lower () != 'y':
    sys.exit ('Nothing written.')

HELPER = r'''<?php
// Uploaded by set-server-config.py and deleted straight after. Holds no secrets:
// the values arrive on standard input. Prints the keys it set, never a value.
$path = __DIR__ . '/config/config.php';
$text = file_get_contents ($path);
$keys = json_decode (stream_get_contents (STDIN), true);
if (!is_array ($keys) || $text === false) { fwrite (STDERR, "nothing read\n"); exit (1); }
foreach ($keys as $key => $value)
{
    if (!preg_match ('/^[A-Za-z][A-Za-z0-9_]*$/', $key)) { fwrite (STDERR, "bad key name\n"); exit (1); }
    $line    = "    '" . $key . "' => " . var_export ($value, true) . ",";
    $pattern = "/^[ \t]*'" . $key . "'[ \t]*=>.*$/m";
    if (preg_match ($pattern, $text))
    {
        $text = preg_replace_callback ($pattern, fn () => $line, $text, 1);
        echo "replaced $key\n";
        continue;
    }
    // The array's closing line: "];" (return [ ... ]) or ");" (return array ( ... )).
    if (!preg_match_all ('/^[ \t]*(\]|\));[ \t]*$/m', $text, $found, PREG_OFFSET_CAPTURE)) { fwrite (STDERR, "no closing ]; or ); in the config\n"); exit (1); }
    $end = end ($found[0])[1];
    $text = substr ($text, 0, $end) . "\n    // Set by set-server-config.py, " . date ('j F Y') . ".\n" . $line . "\n" . substr ($text, $end);
    echo "added $key\n";
}
if (file_put_contents ($path, $text) === false) { fwrite (STDERR, "could not write\n"); exit (1); }
'''

# Is the YouTube key working? Asks YouTube for the channel from the server itself, with the
# key in its config (Chris, 10 October 2026: "need a script to add youtube api to server and
# test server"). The channel default is lib/youtubestats.php's. Prints the channel, never the key.
YOUTUBE_TEST = r'''<?php
// Uploaded by set-server-config.py and deleted straight after. Holds no secrets.
$c       = require __DIR__ . '/config/config.php';
$key     = trim ((string) ($c['youtubeApiKey'] ?? ''));
$channel = trim ((string) ($c['youtubeChannelId'] ?? '')) ?: 'UCb24pUo8CSo__XW2vB4q88Q';
if ($key === '') { echo "YouTube: no key set\n"; exit (1); }
$curl = curl_init ('https://www.googleapis.com/youtube/v3/channels?' . http_build_query (['part' => 'snippet,statistics', 'id' => $channel, 'key' => $key]));
curl_setopt_array ($curl, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 10, CURLOPT_CONNECTTIMEOUT => 5]);
$body   = curl_exec ($curl);
$status = (int) curl_getinfo ($curl, CURLINFO_RESPONSE_CODE);
curl_close ($curl);
$reply = is_string ($body) ? json_decode ($body, true) : null;
if ($status !== 200 || empty ($reply['items'][0]))
{
    echo 'YouTube: NOT working - ', ($status ?: 'no answer'), ' ', strip_tags ((string) ($reply['error']['message'] ?? 'no such channel')), "\n";
    exit (1);
}
$item = $reply['items'][0];
printf ("YouTube: working - %s: %s subscribers, %s videos, %s views\n", $item['snippet']['title'] ?? '?',
        $item['statistics']['subscriberCount'] ?? 'hidden', $item['statistics']['videoCount'] ?? '?', $item['statistics']['viewCount'] ?? '?');
'''

local = os.path.join (os.environ.get ('TEMP', '.'), 'set-config-helper.php')
open (local, 'w', encoding='utf-8', newline='\n').write (HELPER)   # no secrets in this file

try:
    for name in sites:
        root        = SITES[name]
        helper_path = '%s/.set-config-%d.php' % (root, os.getpid ())
        site_values = dict (values)
        if 'mail' in args and name == 'live':
            site_values['mailEnabled'] = True   # sending on - live only (lib/mail.php)
        print ('\n== %s (%s)' % (name.upper (), root))

        code, out = vps.run ('cp -a %s/config/config.php %s/config/config.php.bak-$(date +%%F-%%H%%M%%S) && echo copied' % (root, root))
        if code != 0:
            sys.exit ('Could not copy the %s config aside - nothing changed there.\n%s' % (name, out))

        try:
            vps.put (local, helper_path)
            vps.run ('chmod 600 %s' % helper_path)

            # The values go over the SSH channel's standard input only.
            chan = vps.client ().get_transport ().open_session (timeout=30)
            chan.set_combine_stderr (True)
            chan.exec_command ('php %s' % helper_path)
            chan.sendall (json.dumps (site_values).encode ())
            chan.shutdown_write ()
            output = b''
            while True:
                data = chan.recv (65536)
                if not data:
                    break
                output += data
            status = chan.recv_exit_status ()
            chan.close ()
            print (output.decode ('utf-8', 'replace').strip ())
        finally:
            vps.run ('rm -f %s' % helper_path)
            site_values = None

        code, out = vps.run ('php -l %s/config/config.php' % root)
        if status != 0 or code != 0 or 'No syntax errors' not in out:
            vps.run ('cd %s/config && cp -a "$(ls -t config.php.bak-* | head -1)" config.php' % root)
            sys.exit ('Something went wrong on %s - its config copy is back, nothing changed there.' % name)

        vps.run ('chown www-data:www-data %s/config/config.php; chmod 640 %s/config/config.php %s/config/config.php.bak-* 2>/dev/null' % (root, root, root))
        print ('Config checked (php -l) - saved.')

        keys = [key for key, _ in wanted]
        code, out = vps.run ("cd %s && sudo -u www-data php -r '$c = require \"config/config.php\"; foreach (%s as $k) "
                             "{ echo $k, \": \", (isset ($c[$k]) && $c[$k] !== \"\") ? \"present\" : \"not set\", PHP_EOL; }'" % (root, json.dumps (keys)))
        print (out.strip ())

        if 'mail' in args:
            code, out = vps.run ("cd %s && if [ -f lib/mail.php ]; then sudo -u www-data php -r 'require \"lib/mail.php\"; echo MailSendingOn () ? \"Email sending: ON\" : \"Email sending: off\";'; "
                                 "else echo 'Email code not deployed yet - sending starts after the deploy.'; fi" % root)
            print (out.strip ())

        if 'youtube' in args:
            test_local = os.path.join (os.environ.get ('TEMP', '.'), 'set-config-youtube.php')
            test_path  = '%s/.youtube-test-%d.php' % (root, os.getpid ())
            open (test_local, 'w', encoding='utf-8', newline='\n').write (YOUTUBE_TEST)   # no secrets in this file
            try:
                vps.put (test_local, test_path)
                vps.run ('chmod 644 %s' % test_path)
                code, out = vps.run ('cd %s && sudo -u www-data php %s' % (root, test_path))
                print (out.strip ())
            finally:
                vps.run ('rm -f %s' % test_path)
                os.remove (test_local)
finally:
    os.remove (local)
    values = None   # drop the secret from memory as soon as it is sent
