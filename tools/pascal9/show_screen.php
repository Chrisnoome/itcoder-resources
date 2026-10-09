<?php
/* Prints a captured screen as plain text, the way TerminalScreen() reads it.
     D:\xampp\php\php.exe tools/pascal9/show_screen.php l5-oxygen */
$site = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse';
require_once $site . '/lib/terminal.php';
foreach (array_slice ($argv, 1) as $name)
{
    $rows = TerminalScreen ((string) file_get_contents ($site . '/content/pascal9/screens/' . $name . '.ans'));
    $text = array_map (fn ($runs) => rtrim (implode ('', array_column ($runs, 't'))), $rows);
    while (count ($text) > 0 && end ($text) === '') { array_pop ($text); }
    echo "=== $name\n" . implode ("\n", $text) . "\n";
}
