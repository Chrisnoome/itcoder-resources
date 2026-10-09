<?php
/* Every Station Kestrel program through the site's own layout check, with every
   rule the console uses (ConsoleStyleRules) - so no Run or Check is ever refused.
     D:\xampp\php\php.exe tools/pascal9/style_check.php */
$site = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse';
require_once $site . '/lib/codestyle.php';
$broken = ['l1-typo', 'l1-err-quote', 'l1-err-semicolon'];
$bad = 0;
foreach (glob ($site . '/content/pascal9/programs/*.pas') as $file)
{
    $name = basename ($file, '.pas');
    $problems = CheckPascalStyle (file_get_contents ($file), ConsoleStyleRules ());
    if (count ($problems) === 0) { continue; }
    if (in_array ($name, $broken, true)) { echo "$name (broken on purpose): " . count ($problems) . " notes\n"; continue; }
    $bad++;
    echo "$name:\n";
    foreach ($problems as $problem) { echo '  ' . (is_array ($problem) ? json_encode ($problem) : $problem) . "\n"; }
}
echo "programs with problems: $bad\n";
