# Lists every table's columns (with .NET types) and row count in an .mdb.
param([string]$File)
$c = New-Object System.Data.OleDb.OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=$File;Mode=Read")
$c.Open()
$tables = $c.GetSchema('Tables') | Where-Object { $_.TABLE_TYPE -eq 'TABLE' }
foreach ($t in $tables) {
  $n = $t.TABLE_NAME
  $cmd = $c.CreateCommand(); $cmd.CommandText = "SELECT * FROM [$n]"
  $r = $cmd.ExecuteReader(); $cols = @(); for ($i = 0; $i -lt $r.FieldCount; $i++) { $cols += "$($r.GetName($i)) $($r.GetFieldType($i).Name)" }
  $rows = 0; while ($r.Read()) { $rows++ }; $r.Close()
  "  $n ($rows rows): " + ($cols -join ', ')
}
$c.Close()
