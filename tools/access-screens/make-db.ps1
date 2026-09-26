# Makes work\TuckShop.mdb, or -Out <file> (Jet 4.0 - the exams' kind of file),
# from statements make-db.php writes: work\tuckshop.json (the tuck shop), or
# -Json access01.json (the tuck shop plus lesson B1's tblSuppliers).
# Needs the 32-bit PowerShell (Jet is 32-bit only):
#   C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe -File make-db.ps1
param([string]$Out = '', [string]$Json = 'tuckshop.json')
$ErrorActionPreference = 'Stop'
$dir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$file = if ($Out) { $Out } else { Join-Path $dir 'work\TuckShop.mdb' }
Add-Type -AssemblyName System.Web.Extensions
$statements = (New-Object System.Web.Script.Serialization.JavaScriptSerializer).DeserializeObject([IO.File]::ReadAllText((Join-Path (Join-Path $dir 'work') $Json)))
Remove-Item $file -ErrorAction SilentlyContinue
$cat = New-Object -ComObject ADOX.Catalog
$null = $cat.Create("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=$file")
$cat.ActiveConnection.Close()
$c = New-Object System.Data.OleDb.OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=$file")
$c.Open()
foreach ($s in $statements) { $cmd = $c.CreateCommand(); $cmd.CommandText = $s; $null = $cmd.ExecuteNonQuery() }
$c.Close()
"made $file from $($statements.Count) statements"
