<?php
/**
 * Prove the Pascal compile sandbox actually works on a server deployment.
 *
 *     sudo -u www-data php /tmp/itcoder-sandbox-check.php /var/www/itcoder-v2-test
 *
 * Run by tools/publish-test.py - uploaded to /tmp, run, removed. It never
 * lives inside a web root. It goes through the deployment's OWN
 * lib/compile.php and config, as www-data, so every check exercises the real
 * path a pupil's Run button takes: PHP -> sudo -> the root-owned
 * /usr/local/bin/itcoder-compile-sandbox.sh -> systemd-run -> fpc.
 *
 * Exit 0 only if every GATING check passes. Informational checks print what
 * happened and never fail the run - they cover behaviour the course does not
 * rely on yet (see AIResources/compile-subsystem-design.md, "Simulated input
 * for Readln/Read").
 *
 * The security checks print PASS or FAIL and nothing else. If one of them
 * ever fails, the output is exactly the thing that must not be printed.
 */

$root = rtrim ($argv[1] ?? '', '/');

if ($root === '' || !is_file ($root . '/lib/compile.php'))
{
    fwrite (STDERR, "usage: php sandbox-check.php <site root>\n");
    exit (2);
} // if there is no deployment to check

chdir ($root);
require_once $root . '/lib/compile.php';

if (!function_exists ('LoadConfig'))
{
    require_once $root . '/lib/db.php';
} // if compile.php did not already bring the config loader in

$config = LoadConfig ();

if (($config['compileSandboxed'] ?? true) !== true)
{
    echo "FAIL  this deployment's config does not sandbox compiles - refusing to run pupil-style code\n";
    exit (1);
} // if the sandbox is switched off here

$checks = [

    // ---- the basics ---------------------------------------------------
    ['hello world compiles and runs', true, false, '',
     "Program Hello;\nBegin\n  Writeln ('Proof of life');\nEnd.\n",
     fn ($r) => $r['compileOk'] && str_contains ($r['runOutput'], 'Proof of life')],

    ['a real compiler error comes back genuine', true, false, '',
     "Program Bad;\nBegin\n  total := 3;\nEnd.\n",
     fn ($r) => !$r['compileOk'] && stripos ($r['compileOutput'], 'Identifier not found') !== false],

    ['an endless loop is stopped', true, false, '',
     "Program Forever;\nBegin\n  While True Do ;\nEnd.\n",
     fn ($r) => $r['timedOut']],

    // ---- simulated input: the table in compile-subsystem-design.md -------
    ['Readln twice reads both lines', true, false, "Thabo\n16\n",
     "Program Greet;\nVar\n  playerName : String;\n  age : Integer;\nBegin\n  Readln (playerName);\n  Readln (age);\n"
     . "  Writeln ('Hello, ', playerName, '! In 5 years you will be ', age + 5, '.');\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Hello, Thabo! In 5 years you will be 21.')],

    ['Read twice crosses the line break', true, false, "3\n4\n",
     "Program Add;\nVar\n  a, b : Integer;\nBegin\n  Read (a);\n  Read (b);\n  Writeln ('Sum: ', a + b);\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Sum: 7')],

    ['Read then Readln leaves the name empty (the lesson\'s trap)', true, false, "5\nThabo\n",
     "Program Trap;\nVar\n  a : Integer;\n  name : String;\nBegin\n  Read (a);\n  Readln (name);\n"
     . "  Writeln ('Got number ', a, ' and name [', name, ']');\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Got number 5 and name []')],

    ['input that looks like a length header is still just input', true, false, "12\n999\n",
     "Program Echo;\nVar\n  first, second : String;\nBegin\n  Readln (first);\n  Readln (second);\n"
     . "  Writeln ('[', first, '][', second, ']');\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], '[12][999]')],

    ['a first source line of digits is still just source', true, false, '',
     "{ 42 }\nProgram Digits;\nBegin\n  Writeln ('digits ok');\nEnd.\n",
     fn ($r) => $r['compileOk'] && str_contains ($r['runOutput'], 'digits ok')],

    // ---- the terminal -------------------------------------------------
    ['--tty gives Crt real colour', true, true, '',
     "Program Colour;\nUses Crt;\nBegin\n  TextColor (Red);\n  Writeln ('red text');\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], "\x1b[") && str_contains ($r['runOutput'], 'red text')],

    // ---- security: PASS/FAIL only, never the output ----------------------
    ['SECURITY {$I} cannot include the live config', true, false, '',
     "Program Steal;\n{\$I /var/www/itcoder/config/config.php}\nBegin\nEnd.\n",
     fn ($r) => !$r['compileOk']
                && stripos ($r['compileOutput'] . $r['runOutput'], 'apikey') === false
                && stripos ($r['compileOutput'] . $r['runOutput'], 'secret') === false,
     'secret'],

    ['SECURITY a program cannot open any site\'s config or lessons', true, false, '',
     "Program Peek;\nVar\n  f : Text;\n\nProcedure Try (aPath : String);\nBegin\n  Assign (f, aPath);\n"
     . "  {\$I-} Reset (f); {\$I+}\n  If IOResult = 0 Then Begin Writeln ('READABLE ', aPath); Close (f); End\n"
     . "  Else Writeln ('BLOCKED');\nEnd;\n\nBegin\n  Try ('/var/www/itcoder/config/config.php');\n"
     . "  Try ('/var/www/itcoder-v2-test/config/config.php');\n  Try ('/var/www/itcoder/content/pascal/lesson01.php');\n"
     . "  Try ('/var/backups/itcoder');\nEnd.\n",
     fn ($r) => $r['compileOk'] && substr_count ($r['runOutput'], 'BLOCKED') === 4
                && !str_contains ($r['runOutput'], 'READABLE'),
     'secret'],

    // ---- informational: open questions, never gating --------------------
    ['info: Readln with no input typed at all', false, false, '',
     "Program Empty;\nVar\n  a : Integer;\nBegin\n  Readln (a);\n  Writeln ('Got ', a);\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Got 0')],

    ['info: Readln under --tty', false, true, "Thabo\n",
     "Program TtyRead;\nUses Crt;\nVar\n  name : String;\nBegin\n  Readln (name);\n  Writeln ('Hi ', name);\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Hi Thabo')],

    ['info: ReadKey under --tty', false, true, 'x',
     "Program Key;\nUses Crt;\nVar\n  c : Char;\nBegin\n  c := ReadKey;\n  Writeln ('Key: ', c);\nEnd.\n",
     fn ($r) => str_contains ($r['runOutput'], 'Key: x')],
];

$gatingFailures = 0;

foreach ($checks as $check)
{
    [$name, $gating, $wantTty, $input, $source, $passes] = $check;
    $isSecret = (($check[6] ?? '') === 'secret');

    $started = microtime (true);
    $result  = CompilePascal ($config, $source, $wantTty, $input);
    $seconds = number_format (microtime (true) - $started, 1);

    $ok = (bool) $passes ($result);

    if (!$ok && $gating) { $gatingFailures++; }

    $label = $ok ? 'PASS' : ($gating ? 'FAIL' : 'NOTE');
    echo str_pad ($label, 6), $name, "  ({$seconds}s)\n";

    // Never print what a security check got back - if it failed, that output
    // is the leak. Everything else shows enough to diagnose without a rerun.
    if (!$ok && !$isSecret)
    {
        $detail = trim (($result['failReason'] ?? '') . ' ' . $result['compileOutput'] . ' ' . $result['runOutput']);
        $detail = preg_replace ('/\x1b\[[0-9;?]*[A-Za-z]/', '', $detail);
        echo '      got: ', substr (preg_replace ('/\s+/', ' ', $detail), 0, 300),
             ($result['timedOut'] ? '  [timed out]' : ''), "\n";
    } // if there is something worth showing
} // foreach check

echo "\n", $gatingFailures === 0 ? 'ALL GATING CHECKS PASSED' : "{$gatingFailures} GATING CHECK(S) FAILED", "\n";
exit ($gatingFailures === 0 ? 0 : 1);
