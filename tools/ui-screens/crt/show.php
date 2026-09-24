<?php
// Render a raw .ans file as text (with colour codes as [f/b]) for checking.
require 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/lib/terminal.php';
$rows = TerminalScreen (file_get_contents ($argv[1]));
foreach ($rows as $n => $runs) {
  $t = ''; $c = '';
  foreach ($runs as $r) { $t .= $r['t']; if ($r['f'] !== 7 || $r['b'] !== 0) $c .= ' [' . $r['f'] . '/' . $r['b'] . ':' . strlen($r['t']) . ']'; }
  printf ("%2d|%s|%s\n", $n + 1, $t, $c);
}
