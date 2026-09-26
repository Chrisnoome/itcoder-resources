# The Access screenshots for lesson B4 (access04, Calculated fields): a
# calculated field in Query Design's grid with its own name, its answer, and
# one left unnamed - which Query Design names Expr1 by itself - with the SQL
# View of each (read to copy the SQL into the lesson as text). Each query is
# opened from the SQL Query Design itself writes - see shots02.ps1. Opens
# work\TuckShop.mdb (make-db.ps1). The same rules as shots.ps1 - read its
# header and README.md: NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS;
# any input stops it and deletes the pictures.
param([string]$Prefix = 'access04')
. (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'kit.ps1')

Start-Sleep -Seconds 2
$started = [Shot]::LastInput()
function Guard {
  if ([Shot]::LastInput() -ne $started) {
    Remove-Item (Join-Path $dir "out\$Prefix-*.png") -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used during the run - every picture was deleted. Run it again with hands off.'
  }
}
function Take($name) { Guard; Snap $name; Guard }

# The query in Query Design's grid (Design View), filling the window.
function InGrid($sql) {
  try { $app.DoCmd.Close(1, 'Query1', 2) } catch { }
  $db = $app.CurrentDb()
  try { $db.QueryDefs.Delete('Query1') } catch { }
  $null = $db.CreateQueryDef('Query1', $sql)
  $app.SetHiddenAttribute(1, 'Query1', $true)
  $app.DoCmd.OpenQuery('Query1', 1)                  # acViewDesign
  $app.DoCmd.Maximize()
}

try {
  $app.Visible = $true
  $app.OpenCurrentDatabase((Join-Path $dir 'work\TuckShop.mdb'))
  $h = [IntPtr]$app.hWndAccessApp()
  [IO.File]::WriteAllText((Join-Path $dir 'work\access.pid'), [string][Shot]::Pid($h))   # to stop only this Access if it sticks
  [Shot]::Place($h, 60, 60, 1500, 950)
  $root = $A::FromHandle($h)

  InGrid 'SELECT tblProducts.ProductName, tblProducts.Price, [Price]*1.1 AS NewPrice FROM tblProducts WHERE (((tblProducts.Price)<10));'
  Take 'calc'
  Press $root 'Run'
  Take 'calc-result'
  Press $root 'SQL View'
  Take 'calc-sql'

  InGrid 'SELECT tblProducts.ProductName, [Price]*1.1 AS Expr1 FROM tblProducts WHERE (((tblProducts.Price)<10));'
  Take 'expr'
  Press $root 'Run'
  Take 'expr-result'
  Press $root 'SQL View'
  Take 'expr-sql'

  $app.DoCmd.Close(1, 'Query1', 2)
  'DONE'
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
