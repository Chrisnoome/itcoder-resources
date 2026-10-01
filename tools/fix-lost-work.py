"""One-off repair on LIVE for the two marking faults found on 1 October 2026
(remediation chat "Marking issues"). Run it only AFTER Chris has published
the fixes (the pasteAllowed table, AllowPaste() in lib/typing.php, and the
"same answer" guard on every two-try question) - it checks and stops if not.

PowerShell (dry run - lists what it would do, changes nothing):

    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/fix-lost-work.py"

Then, to do it:

    & "C:\\Python314\\python.exe" -X utf8 "D:/DB Sync/Dropbox/Projects/AIResources/tools/fix-lost-work.py" --apply

What it does (Chris's choices, 1 October 2026):

1. Answers cut at 4000 characters. The server used to cut every written
   answer at 4000 characters without a word, so programs lost their main
   block and were marked as missing it. Pascal answers stored at exactly
   4000 characters, with no open mark query, are reset (archived in
   resetAnswers, as a teacher's reset is), pasting is switched on for that
   question so the pupil can paste their work back, and they get a bell
   saying why. AI-course answers are left alone (their marks were high).
   One with an OPEN query is left for the teacher to answer on Pupil
   queries with "Reset the question" and "Allow pasting" ticked.
2. Second tries lost to an identical answer. Pressing "Try again" straight
   after a wrong first try re-checked the same answer and spent the second
   try. Every wrong answer whose second try is identical to its first goes
   back to one try used, and the pupil gets a bell. Their first try is kept,
   so the marks for a second try are as before.

Runs on the server as www-data from /tmp (vps-access.md house rules), and
prints no names - only ids, lessons and questions.
"""
import os, sys
sys.dont_write_bytecode = True
sys.path.insert (0, os.path.dirname (os.path.abspath (__file__)))
import vps

APPLY = '--apply' in sys.argv

PHP = r'''<?php
$apply = in_array ('--apply', $argv, true);
chdir ('/var/www/itcoder/public');
require '/var/www/itcoder/lib/course.php';
require_once '/var/www/itcoder/lib/content.php';
require_once '/var/www/itcoder/lib/queries.php';   // ResetQuestion() through questionreset.php, Notify()
require_once '/var/www/itcoder/lib/typing.php';

if (!function_exists ('AllowPaste') || !function_exists ('SameAsLastTry'))
{
    exit ("STOP: the fixes are not on live yet - publish first.\n");
} // if not published

$pdo = Db ();

if ($pdo->query ("SELECT COUNT(*) FROM sqlite_master WHERE name = 'pasteAllowed'")->fetchColumn () == 0)
{
    exit ("STOP: no pasteAllowed table on live - publish (setup.php) first.\n");
} // if the table is missing

$admin = (int) $pdo->query ("SELECT id FROM pupils WHERE isTeacher = 1 ORDER BY id LIMIT 1")->fetchColumn ();   // resetBy: the site's first teacher (Chris)

echo ($apply ? "APPLYING\n" : "DRY RUN - nothing changed\n");

/* ---- 1. answers cut at 4000 characters ---- */
echo "\n1. Pascal answers cut at 4000 characters\n";
$cut = $pdo->query ("SELECT w.id, w.pupilId, w.courseId, w.lessonId, w.questionId, COALESCE(w.teacherMark, w.markAwarded) AS mark, w.markMax,
                            (SELECT id FROM markQueries q WHERE q.pupilId = w.pupilId AND q.courseId = w.courseId AND q.lessonId = w.lessonId
                               AND q.questionId = w.questionId AND q.status = 'open') AS openQuery
                     FROM writtenAnswers w
                     WHERE w.courseId = 'pascal' AND w.status = 'done' AND length(w.answerText) = 4000")->fetchAll ();

foreach ($cut as $row)
{
    $what = "answer {$row['id']} (pupil {$row['pupilId']}, {$row['lessonId']} {$row['questionId']}, {$row['mark']}/{$row['markMax']})";

    if ($row['openQuery'] !== null)
    {
        echo "  - $what: has open query {$row['openQuery']} - answer it on Pupil queries: Reset the question, Allow pasting ticked\n";
        continue;
    } // if the teacher answers it

    echo "  - $what: reset, pasting on, bell\n";

    if (!$apply) { continue; }

    if (!ResetQuestion ((int) $row['pupilId'], $row['courseId'], $row['lessonId'], $row['questionId'], $admin, null, false))
    {
        echo "    ! not reset (gone?)\n";
        continue;
    } // if nothing was reset

    AllowPaste ((int) $row['pupilId'], $row['courseId'], $row['lessonId'], $row['questionId'], $admin);
    Notify ((int) $row['pupilId'], 'reset',
            'Sorry - the site cut your answer in ' . LessonName ($row['courseId'], $row['lessonId']) . ' short at 4000 characters, so the end of your program was never marked. '
            . 'The question is open again and pasting is switched on for it: paste your whole program back in and hand it in.',
            QuestionLink ($row['courseId'], $row['lessonId'], $row['questionId']), 'lostwork-' . $row['id'], true);
} // foreach cut answer

/* ---- 2. second tries spent on an identical answer ---- */
echo "\n2. Second tries spent on the same answer as the first\n";
$same = $pdo->query ("SELECT id, pupilId, courseId, lessonId, questionId, attempts FROM quizResponses
                      WHERE isCorrect = 0 AND attempts >= 2 AND firstResponse IS NOT NULL AND firstResponse = response")->fetchAll ();

foreach ($same as $row)
{
    echo "  - response {$row['id']} (pupil {$row['pupilId']}, {$row['courseId']} {$row['lessonId']} {$row['questionId']}): back to 1 try used, bell\n";

    if (!$apply) { continue; }

    $pdo->prepare ('UPDATE quizResponses SET attempts = 1 WHERE id = ? AND isCorrect = 0 AND attempts >= 2 AND firstResponse = response')->execute ([(int) $row['id']]);
    Notify ((int) $row['pupilId'], 'reset',
            'Your second try in ' . LessonName ($row['courseId'], $row['lessonId']) . ' was spent on the same answer as your first, so you have it back. '
            . 'Change your answer, then press Check again.',
            QuestionLink ($row['courseId'], $row['lessonId'], $row['questionId']), 'retryback-' . $row['id'], true);
} // foreach lost try

echo "\n" . count ($cut) . " cut answer(s), " . count ($same) . " lost try/tries.\n";
'''

LOCAL  = os.path.join (os.environ.get ('TEMP', '.'), 'fix-lost-work.php')
REMOTE = '/tmp/fix-lost-work.php'

with open (LOCAL, 'w', encoding = 'utf-8', newline = '\n') as handle:
    handle.write (PHP)

vps.put (LOCAL, REMOTE)
os.remove (LOCAL)

code, out = vps.run ('chmod 644 {0} && sudo -u www-data php {0}{1}; rm -f {0}'.format (REMOTE, ' --apply' if APPLY else ''))
print (out)
sys.exit (code)
