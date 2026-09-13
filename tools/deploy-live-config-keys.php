<?php
/**
 * Add the four compile settings to a config/config.php that predates the
 * compile subsystem. Run ON THE SERVER, as www-data, from the site root.
 *
 * Prints a status line and nothing else - the file it edits holds the Google
 * client secret and the Anthropic key, and neither is ever going to appear in
 * this script's output (AIResources/vps-access.md, House rules).
 *
 * Safe to run twice: if 'pascalCompiler' is already there it changes nothing.
 */

$path = __DIR__ . '/config/config.php';

if (!is_file ($path))
{
    fwrite (STDERR, "no config at {$path}\n");
    exit (1);
} // if there is no config to edit

$text = file_get_contents ($path);

if (strpos ($text, 'pascalCompiler') !== false)
{
    echo "already has the compile keys - nothing to do\n";
    exit (0);
} // if this has been run before

$block = <<<'PHPBLOCK'

    // --- Compiling pupils' Pascal ---------------------------------------
    // Added when the compile subsystem went live. The full reasoning for each
    // of these is in config/config.sample.php - read it there before changing
    // any of them, particularly 'compileSandboxed'.

    // Where fpc lives on each machine. Both 3.2.2 on purpose: every worked
    // example in the Pascal course is compiled for real, so the output printed
    // in a lesson is the output pupils actually get.
    'pascalCompiler' => $isLocal
        ? 'C:/lazarus/fpc/3.2.2/bin/x86_64-win64/fpc.exe'
        : '/usr/bin/fpc',

    // NEVER set this false on the server. The sandbox is the thing stopping
    // {$I /var/www/itcoder/config/config.php} from handing a pupil the Google
    // and Anthropic secrets inside a compiler error message.
    'compileSandboxed' => !$isLocal,

    // The server runs bin/compilequeue.php from cron; Windows has no cron, so
    // the testbed does the work in the request instead. Tied to $isLocal, not
    // a switch to flip on the server - thirty pupils pressing Run at once is
    // the pile-up the queue exists to prevent (platform.md, decision 1).
    'compileInRequest' => $isLocal,

    // The root-owned copy of bin/compile-sandbox.sh, outside /var/www on
    // purpose: a deploy chowns everything there to www-data, and www-data is
    // the account the sandbox exists to contain.
    'compileSandboxScript' => '/usr/local/bin/itcoder-compile-sandbox.sh',
];
PHPBLOCK;

// Splice in before the array's own closing bracket - the last "];" in the
// file, matched at the start of a line so a "];" inside a string cannot be
// mistaken for it.
$position = strrpos ($text, "\n];");

if ($position === false)
{
    fwrite (STDERR, "could not find the closing bracket - config left untouched\n");
    exit (1);
} // if the file is not shaped as expected

$updated = substr ($text, 0, $position) . "\n" . $block . substr ($text, $position + 3);

if (file_put_contents ($path, $updated) === false)
{
    fwrite (STDERR, "could not write the config\n");
    exit (1);
} // if the write failed

echo "added 4 compile keys\n";
