# The Access screenshots for lesson B2 (access02, Asking questions): three
# queries in Query Design's grid, the SQL the grid shows in SQL View, and an
# answer. Each query is the SQL Query Design itself writes for the grid a pupil
# builds - short SQL (Price < 10) opened in the grid lands in extra hidden
# columns instead (seen 26 September 2026). Opens work\TuckShop.mdb (make-db.ps1). The same rules as shots.ps1 -
# read its header and README.md: NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT
# RUNS; any input stops it and deletes the pictures.
param([string]$Prefix = 'access02')
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

  InGrid 'SELECT tblProducts.ProductName, tblProducts.Price FROM tblProducts WHERE (((tblProducts.Price)<10)) ORDER BY tblProducts.Price;'
  Take 'grid'
  Press $root 'SQL View'
  Take 'grid-sql'
  Press $root 'Run'
  Take 'grid-result'

  InGrid 'SELECT tblProducts.ProductName, tblProducts.Category FROM tblProducts WHERE (((tblProducts.Category)="Drinks")) OR (((tblProducts.Category)="Snacks"));'
  Take 'grid-or'
  Press $root 'SQL View'
  Take 'grid-or-sql'

  InGrid 'SELECT tblProducts.ProductName, tblProducts.Category, tblProducts.Price FROM tblProducts WHERE (((tblProducts.Category)="Drinks") AND ((tblProducts.Price)<12)) OR (((tblProducts.Category)="Snacks") AND ((tblProducts.Price)<12));'
  Take 'grid-andor'
  Press $root 'SQL View'
  Take 'grid-andor-sql'

  $app.DoCmd.Close(1, 'Query1', 2)
  'DONE'
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
