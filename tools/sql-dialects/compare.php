<?php
$data = json_decode(file_get_contents(__DIR__ . '/tests.json'), true);
$names = ['access-jet' => 'Jet4 OLEDB (CAPS)', 'access-ace' => 'ACE OLEDB', 'access-odbc' => 'ACE ODBC', 'mysql' => 'MariaDB', 'mysql8mode' => 'MariaDB, MySQL8 mode', 'derby' => 'Java DB (Derby 10.17)', 'ucan' => 'UCanAccess 5.1.8',
          'sqlite-access' => 'SQLite <- Access form', 'sqlite-mysql' => 'SQLite <- MySQL form', 'sqlite-derby' => 'SQLite <- JavaDB form'];
$r = [];
foreach ($names as $k => $_) {
  $raw = file_get_contents(__DIR__ . "/result-$k.json");
  $raw = preg_replace('/^\xEF\xBB\xBF/', '', $raw);
  $r[$k] = json_decode($raw, true);
}
function Show($res) {
  if ($res === null) return '-';
  if (!$res['ok']) return 'ERROR: ' . substr(preg_replace('/\s+/', ' ', $res['error']), 0, 110);
  $f = function ($rows) {
    if (!is_array($rows)) $rows = [$rows];
    return implode(' | ', array_map(function ($row) { return is_array($row) ? implode(', ', array_map(function ($v) { return $v === null ? 'NULL' : (is_array($v) ? json_encode($v) : $v); }, $row)) : $row; }, $rows));
  };
  $s = $f($res['rows']);
  if (isset($res['check'])) $s .= '  => after: ' . $f($res['check']);
  if (isset($res['checkDate'])) $s .= '  date rows: ' . $f($res['checkDate']);
  return $s === '' ? '(no rows)' : $s;
}
foreach ($data['tests'] as $t) {
  echo "\n== {$t['id']} {$t['feature']}\n";
  foreach ($names as $k => $label) {
    $res = $r[$k][$t['id']] ?? null;
    if ($res === null) continue;
    printf("  %-24s %s\n", $label, Show($res));
  }
}
