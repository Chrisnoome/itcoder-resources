r"""Deploy AIPascalCourse to LIVE - /var/www/itcoder, itcoder.co.za.

    & "C:\Python314\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"

Use that FULL interpreter path, not a bare `python`. A bare `python` goes
wherever PATH sends it, and in an interactive PowerShell that was a
different install with no paramiko (13 September 2026, first real run:
ModuleNotFoundError). C:\Python314 is the one vps-access.md names.

Written 13 September 2026, when Claude Code's permission classifier refused to
run a live deployment itself (vps-access.md, House rules: don't work around it
- write the change as a file and give Chris the exact command). Everything in
it was run first, step for step, against the test deployment.

SAFE TO RUN AGAIN. Every one-time piece is guarded: the compile settings are
skipped if already present, the crontab line is skipped if already there, and
bin/setup.php only creates what is missing. Re-running it simply redeploys
whatever is in AIPascalCourse at the time.

IT REFUSES TO RUN UNTIL tools/publish-test.py HAS PASSED (13 September 2026).
The root-owned /usr/local/bin/itcoder-compile-sandbox.sh is shared by test
and live, and the PHP that talks to it has to match it byte for byte - so the
first thing this does is check that bin/compile-sandbox.sh, the installed
copy, and the copy publish-test.py last proved all have the same sha256. If
any differs, nothing is touched and it tells you to publish to test first.
That was learned the hard way: another chat's change to the sandbox's input
protocol arrived in the same commit as the lessons, and a live deploy on its
own would have shipped PHP that the installed sandbox could not understand.

WHAT IT DOES NOT DO, on purpose:
  - it never uploads config/ or data/, so the live config and the live
    database are out of range of the file copy entirely;
  - it never installs the sandbox. publish-test.py does that, on test, where
    being wrong is allowed.

It takes a fresh database backup and copies config.php aside before it starts,
and finishes with a real compile on live, through live's own code.
"""
import hashlib
import sys
sys.dont_write_bytecode = True
sys.path.insert(0, r'D:/DB Sync/Dropbox/Projects/AIResources/tools')

# Fail in words, not a traceback, when run with the wrong interpreter - and
# before anything has touched the server, so a wrong-python run changes nothing.
try:
    import paramiko  # noqa: F401 - vps.py needs it; checked here to explain
except ImportError:
    print('This Python has no paramiko:')
    print('    ' + sys.executable)
    print('Run it with the interpreter that does:')
    print(r'    & "C:\Python314\python.exe" -X utf8 '
          r'"D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live.py"')
    sys.exit(1)

import vps

LOCAL = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse'
LIVE = '/var/www/itcoder'
HELPER = 'D:/DB Sync/Dropbox/Projects/AIResources/tools/deploy-live-config-keys.php'
INSTALLED = '/usr/local/bin/itcoder-compile-sandbox.sh'
MARKER = '/root/itcoder-sandbox-validated.sha256'

failures = []

print('== 0. has this exact sandbox been proven on test? ==')
local_sha = hashlib.sha256(open(LOCAL + '/bin/compile-sandbox.sh', 'rb').read()).hexdigest()
_code, _out = vps.run("sha256sum %s 2>/dev/null | cut -d' ' -f1; cat %s 2>/dev/null" % (INSTALLED, MARKER))
_shas = _out.split()
installed_sha = _shas[0] if len(_shas) > 0 else ''
validated_sha = _shas[1] if len(_shas) > 1 else ''

if not (local_sha == installed_sha == validated_sha):
    print('[STOP] Not published to test yet - nothing on live has been touched.')
    print('       bin/compile-sandbox.sh here   %s' % local_sha[:16])
    print('       installed on the server       %s' % (installed_sha[:16] or 'none'))
    print('       last proven by publish-test   %s' % (validated_sha[:16] or 'never'))
    print('       Run tools/publish-test.py first, check test in a browser, then run this again.')
    sys.exit(1)
print('[ok ] sandbox %s is installed and was proven on test' % local_sha[:16])
print()


def Step(label, cmd, expect_zero=True):
    code, out = vps.run(cmd)
    ok = (code == 0) or not expect_zero
    print('[%s] %s' % ('ok ' if ok else 'FAIL', label))
    if out.strip():
        # 40, not 12: the sandbox report is ~17 lines, and cutting it off hid
        # its NOTE lines and final verdict on the first live run.
        for line in out.strip().split('\n')[:40]:
            print('      ' + line[:160])
    if not ok:
        failures.append(label)
    return code, out


print('== 1. a fresh backup before anything changes ==')
Step('backup', 'cd %s && sudo -u www-data php bin/backup.php' % LIVE)

print('\n== 2. copy the config aside (house rules) ==')
Step('config aside', 'cd %s && cp -a config/config.php config/config.php.bak-$(date +%%F-%%H%%M)' % LIVE)

print('\n== 3. upload the code (never config/, never data/) ==')
for folder in ['lib', 'bin', 'content', 'public']:
    n = vps.put_tree('%s/%s' % (LOCAL, folder), '%s/%s' % (LIVE, folder))
    print('      uploaded %s: %s files' % (folder, n))
vps.put('%s/schema.sql' % LOCAL, '%s/schema.sql' % LIVE)
vps.put('%s/config/config.sample.php' % LOCAL, '%s/config/config.sample.php' % LIVE)
print('      uploaded schema.sql and config.sample.php')

print('\n== 4. ownership and permissions ==')
Step('chown', 'chown -R www-data:www-data %s' % LIVE)
Step('dirs 755', 'find %s -type d -exec chmod 755 {} +' % LIVE)
Step('files 644', 'find %s -type f -exec chmod 644 {} +' % LIVE)
Step('config/data 750', 'chmod 750 %s/config %s/data' % (LIVE, LIVE))
Step('config.php 640', 'chmod 640 %s/config/config.php %s/config/config.php.bak-* 2>/dev/null || true' % (LIVE, LIVE))

print('\n== 5. the four compile settings ==')
vps.put(HELPER, '%s/add-compile-keys.php' % LIVE)
Step('add compile keys', 'cd %s && php add-compile-keys.php' % LIVE)
Step('config still parses', 'php -l %s/config/config.php' % LIVE)
Step('keys present', "cd %s && sudo -u www-data php -r '$c = require \"config/config.php\"; "
     "foreach ([\"pascalCompiler\",\"compileSandboxed\",\"compileInRequest\",\"compileSandboxScript\"] as $k) "
     "{ echo $k, \"=\", var_export ($c[$k] ?? null, true), \" \"; } echo PHP_EOL;'" % LIVE)
Step('remove the helper', 'rm -f %s/add-compile-keys.php' % LIVE)

print('\n== 6. the three new tables ==')
Step('setup.php', 'cd %s && sudo -u www-data php bin/setup.php' % LIVE)

print('\n== 7. the compile worker: log FIRST, then cron ==')
Step('create the log', 'touch /var/log/itcoder-compile.log && chown www-data:www-data /var/log/itcoder-compile.log && ls -l /var/log/itcoder-compile.log')
Step('add the cron line (only if absent)',
     "crontab -u www-data -l > /tmp/ct.txt; "
     "if grep -q 'itcoder/bin/compilequeue.php' /tmp/ct.txt; then echo 'already there'; else "
     "echo '* * * * * /usr/bin/php /var/www/itcoder/bin/compilequeue.php >> /var/log/itcoder-compile.log 2>&1' >> /tmp/ct.txt "
     "&& crontab -u www-data /tmp/ct.txt && echo added; fi; rm -f /tmp/ct.txt")
Step('crontab now', 'crontab -u www-data -l')

print('\n== 8. verify ==')
Step('every php file parses',
     "find %s/lib %s/bin %s/public %s/content -name '*.php' -exec php -l {} + 2>&1 "
     "| grep -v 'No syntax errors' | head -10; echo '(nothing above = clean)'" % (LIVE, LIVE, LIVE, LIVE))
Step('lesson numbering',
     "cd %s && sudo -u www-data php -r 'require \"lib/course.php\"; require \"lib/content.php\"; "
     "foreach (LessonIndex (\"pascal\") as $id => $l) { printf (\"%%-14s lesson %%d  %%s\\n\", $id, $l[\"number\"], $l[\"title\"]); }'" % LIVE)
Step('study notes build',
     "cd %s && sudo -u www-data php -r 'require \"lib/course.php\"; require \"lib/content.php\"; require \"lib/pdf.php\"; "
     "foreach (array_keys (LessonIndex (\"pascal\")) as $id) { $n = LessonStudyNotes (\"pascal\", $id); "
     "echo $id, \": \", $n === null ? \"none\" : strlen (PdfBuild (\"t\",\"s\",\"f\", StudyNotesPdfBlocks ($n))) . \" byte pdf\", PHP_EOL; }'" % LIVE)
Step('course catalogue - both open, and a pupil sees both',
     "cd %s && sudo -u www-data php -r 'require \"lib/course.php\"; "
     "foreach (CourseIndex () as $id => $c) { printf (\"%%-8s %%-24s %%s\\n\", $id, $c[\"title\"], $c[\"status\"]); } "
     "echo \"a pupil sees: \", implode (\", \", array_keys (VisibleCourses ([\"isTeacher\" => 0]))), PHP_EOL;'" % LIVE)
Step('all eight AI lessons load',
     "cd %s && sudo -u www-data php -r 'require \"lib/course.php\"; require \"lib/content.php\"; "
     "$bad = 0; foreach (array_keys (LessonIndex (\"ai\")) as $id) { "
     "if (!LessonExists (\"ai\", $id)) { echo $id, \": MISSING\", PHP_EOL; $bad++; continue; } "
     "if (count (LoadLesson (\"ai\", $id)) < 1) { echo $id, \": EMPTY\", PHP_EOL; $bad++; } } "
     "echo $bad === 0 ? \"all 8 load\" : \"$bad broken\", PHP_EOL;'" % LIVE)
Step('site responds', "curl -s -o /dev/null -w 'live=%{http_code}\\n' https://itcoder.co.za/")

# The same proof publish-test.py ran on test, now through LIVE's own code and
# config: a genuine compile, genuine simulated input, the terminal, and the
# security checks that a program cannot read any site's config or lessons.
print('\n== 9. prove compiling works on live ==')
vps.put('D:/DB Sync/Dropbox/Projects/AIResources/tools/sandbox-check.php', '/tmp/itcoder-sandbox-check.php')
Step('sandbox checks on live', 'chmod 644 /tmp/itcoder-sandbox-check.php && cd %s && '
     'sudo -u www-data php /tmp/itcoder-sandbox-check.php %s' % (LIVE, LIVE))
vps.run('rm -f /tmp/itcoder-sandbox-check.php')

print('\n' + ('ALL STEPS OK' if not failures else 'FAILURES: ' + ', '.join(failures)))
