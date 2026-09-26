# Runs every test's Access form on a real Access engine.
# -Mode jet   : Jet 4.0 OLEDB, .mdb (what the CAPS Delphi projects use; 32-bit PowerShell)
# -Mode ace   : ACE 12.0 OLEDB, .accdb (ADO, 64-bit)
# -Mode odbc  : ACE ODBC driver, .accdb (64-bit)
param([string]$Mode)
$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
$data = Get-Content (Join-Path $dir 'tests.json') -Raw | ConvertFrom-Json
$work = Join-Path $dir "work-$Mode"
New-Item -ItemType Directory -Force $work | Out-Null
$ext = if ($Mode -eq 'jet') { 'mdb' } else { 'accdb' }
$template = Join-Path $work "template.$ext"
Remove-Item $template -ErrorAction SilentlyContinue
$prov = if ($Mode -eq 'jet') { 'Microsoft.Jet.OLEDB.4.0' } else { 'Microsoft.ACE.OLEDB.12.0' }
$cat = New-Object -ComObject ADOX.Catalog
$null = $cat.Create("Provider=$prov;Data Source=$template")
$cat.ActiveConnection.Close()

function Open-Db($file) {
  if ($Mode -eq 'odbc') {
    $c = New-Object System.Data.Odbc.OdbcConnection("Driver={Microsoft Access Driver (*.mdb, *.accdb)};Dbq=$file")
  } else {
    $c = New-Object System.Data.OleDb.OleDbConnection("Provider=$prov;Data Source=$file")
  }
  $c.Open(); return $c
}
function Run($conn, $sql) {
  $cmd = $conn.CreateCommand(); $cmd.CommandText = $sql
  if ($sql -match '^\s*(UPDATE|INSERT|DELETE)') { $n = $cmd.ExecuteNonQuery(); return ,@(,@("changed $n")) }
  $r = $cmd.ExecuteReader(); $rows = @()
  while ($r.Read()) {
    $row = @()
    for ($i = 0; $i -lt $r.FieldCount; $i++) {
      $v = $r.GetValue($i)
      if ($v -is [DBNull]) { $v = $null }
      elseif ($v -is [datetime]) { $v = $v.ToString('yyyy-MM-dd') }
      elseif ($v -is [bool]) { $v = [int]$v }
      $row += ,$v
    }
    $rows += ,$row
  }
  $r.Close(); return ,$rows
}

$conn = Open-Db $template
foreach ($s in $data.setup.access) { $cmd = $conn.CreateCommand(); $cmd.CommandText = $s; $null = $cmd.ExecuteNonQuery() }
$conn.Close()

$out = @{}
foreach ($t in $data.tests) {
  if (-not $t.access) { continue }
  $file = Join-Path $work "$($t.id).$ext"
  Copy-Item $template $file -Force
  $res = @{}
  try {
    $conn = Open-Db $file
    $res.rows = Run $conn $t.access
    if ($t.check) { $res.check = Run $conn $t.check }
    if ($t.checkDate) { $res.checkDate = Run $conn $t.checkDate.access }
    $res.ok = $true
  } catch {
    $res.ok = $false; $res.error = ($_.Exception.InnerException, $_.Exception | Where-Object { $_ } | Select-Object -First 1).Message
  } finally { if ($conn) { $conn.Close(); $conn = $null } }
  $out[$t.id] = $res
}
$out | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $dir "result-access-$Mode.json") -Encoding UTF8
"done $Mode"
