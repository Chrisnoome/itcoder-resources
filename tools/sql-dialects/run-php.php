<?php
// Runs the MySQL forms on MariaDB (default mode and MySQL 8's default mode),
// and the Access, MySQL and Java DB forms on SQLite.
$data = json_decode(file_get_contents(__DIR__ . '/tests.json'), true);

function Norm($v) {
  if (is_string($v) && is_numeric($v)) return $v + 0;
  return $v;
}
function RunSql(PDO $db, string $sql) {
  if (preg_match('/^\s*(UPDATE|INSERT|DELETE)/i', $sql)) { $n = $db->exec($sql); return [["changed $n"]]; }
  $rows = [];
  foreach ($db->query($sql)->fetchAll(PDO::FETCH_NUM) as $r) $rows[] = array_map('Norm', $r);
  return $rows;
}
function Fresh(string $engine, ?string $mode) : PDO {
  global $data;
  if ($engine === 'sqlite') {
    $db = new PDO('sqlite::memory:');
    $setup = $data['setup']['sqlite'];
  } else {
    $db = new PDO('mysql:host=127.0.0.1;port=3399', 'root', '');
    $db->exec('DROP DATABASE IF EXISTS t'); $db->exec('CREATE DATABASE t'); $db->exec('USE t');
    $db->exec("SET SESSION sql_mode = '" . $mode . "'");
    $setup = $data['setup']['mysql'];
  }
  $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
  foreach ($setup as $s) $db->exec($s);
  return $db;
}
function RunAll(string $engine, string $form, ?string $mode = null) : array {
  global $data;
  $out = [];
  foreach ($data['tests'] as $t) {
    if (empty($t[$form])) continue;
    $res = [];
    try {
      $db = Fresh($engine, $mode);
      $res['rows'] = RunSql($db, $t[$form]);
      if (!empty($t['check'])) $res['check'] = RunSql($db, $t['check']);
      if (!empty($t['checkDate'])) $res['checkDate'] = RunSql($db, $t['checkDate']['other']);
      $res['ok'] = true;
    } catch (Throwable $e) {
      $res = ['ok' => false, 'error' => $e->getMessage()];
    }
    $out[$t['id']] = $res;
  }
  return $out;
}
$mariaDefault = (new PDO('mysql:host=127.0.0.1;port=3399', 'root', ''))->query('SELECT @@GLOBAL.sql_mode')->fetchColumn();
$mysql8 = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
$runs = [
  'mysql'         => RunAll('mysql', 'mysql', $mariaDefault),
  'mysql8mode'    => RunAll('mysql', 'mysql', $mysql8),
  'sqlite-access' => RunAll('sqlite', 'access'),
  'sqlite-mysql'  => RunAll('sqlite', 'mysql'),
  'sqlite-derby'  => RunAll('sqlite', 'derby'),
];
foreach ($runs as $k => $v) file_put_contents(__DIR__ . "/result-$k.json", json_encode($v, JSON_PRETTY_PRINT));
echo "MariaDB default mode: $mariaDefault\nSQLite ", (new PDO('sqlite::memory:'))->query('select sqlite_version()')->fetchColumn(), "\n";
