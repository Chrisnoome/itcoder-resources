<?php
/**
 * Prove AI marking works on a server deployment - one real API call, on a
 * made-up answer, through the site's OWN bin/markqueue.php and config.
 *
 *     sudo -u www-data php /tmp/itcoder-marking-check.php /var/www/itcoder
 *
 * Written 17 September 2026, when marking moved to structured outputs. It
 * never touches the database and never sees a pupil's work: the answer below
 * is invented, and the result is only printed.
 *
 * Exit 0 on PASS.
 */

$root = rtrim ($argv[1] ?? '', '/');

if ($root === '' || !is_file ($root . '/bin/markqueue.php'))
{
    fwrite (STDERR, "usage: php marking-check.php <site root>\n");
    exit (2);
} // if there is no deployment to check

chdir ($root);
require_once $root . '/bin/markqueue.php';   // guarded: requiring it does not start the worker

$config   = LoadConfig ();
$question = null;

// Any written question will do; the AI course's first one is the one that
// failed most often under the old free-text replies.
foreach (['ai', 'pascal'] as $courseId)
{
    foreach (array_keys (LessonIndex ($courseId)) as $lessonId)
    {
        $questions = LessonExists ($courseId, $lessonId) ? LessonWrittenQuestions ($courseId, $lessonId) : [];

        if (count ($questions) > 0)
        {
            $question = reset ($questions);
            break 2;
        } // if this lesson has a written question
    } // foreach lesson
} // foreach course

if ($question === null)
{
    echo "FAIL  no written question found to mark\n";
    exit (1);
} // if there is nothing to mark

// Quote marks, a newline and a backslash on purpose - the characters most
// likely to have broken the old "please reply with JSON" marking.
$answer = "It is not \"thinking\" the way a person does.\nIt predicts the next word from patterns "
        . "in what it was trained on, so it can sound sure and still be wrong - a \\guess\\, really.";

try
{
    $started = microtime (true);
    $result  = MarkOneAnswer ($config, $courseId, $question, $answer);

    printf ("PASS  marked %s/%s: %d/%d, %d characters of feedback (%.1fs)\n",
        $courseId, $question['id'], $result['mark'], $question['markMax'],
        strlen ($result['feedback']), microtime (true) - $started);
    exit (0);
}
catch (Throwable $error)
{
    echo 'FAIL  ' . $error->getMessage () . "\n";
    exit (1);
} // try to mark
