<?php
// Prints a captured screen as plain text (with | at the right edge), plus the
// colours of each run, so a screen can be checked without a browser.
require dirname (__DIR__, 4) . "/AIPascalCourse/lib/terminal.php";
foreach (array_slice ($argv, 1) as $file)
{
    echo "=== $file\n";
    $rows = TerminalScreen ((string) file_get_contents ($file));
    foreach ($rows as $index => $runs)
    {
        $text = implode ('', array_column ($runs, 't'));
        $colours = implode (' ', array_map (fn ($run) => $run['f'] . '/' . $run['b'] . ':' . strlen ($run['t']), $runs));
        printf ("%2d %-80s| %s\n", $index + 1, $text, in_array ('-v', $argv, true) ? $colours : '');
    } // foreach row
} // foreach file
