# The Access screenshots for lesson B5 (access05, Dates): a date range and
# "this year" in Query Design's grid, with the SQL View of each (read to copy
# the SQL into the lesson - Query Design writes its own dates into the SQL).
# Each query is opened from the SQL Query Design itself writes - see
# shots02.ps1. Opens work\TuckShop.mdb (make-db.ps1). The same rules as
# shots.ps1 - read its header and README.md: NOBODY MAY USE THE KEYBOARD OR
# MOUSE WHILE IT RUNS; any input stops it and deletes the pictures.
param([string]$Prefix = 'access05')
. (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'kit.ps1')

Start-Sleep -Seconds 2

# THE GUARD (26 September 2026, after three runs stopped): keys can only land in Access while Access is the
# window in front. So any keyboard or mouse use while Access is in front - or was
# in front at the last check - stops the run and deletes its pictures. Input that
# goes to other windows can't touch the pictures (PrintWindow draws only Access),
# and every picture is looked at before it is used.
$script:lastInput = [Shot]::LastInput()
$script:wasFront  = $false
function Guard {
  $front = ($h -ne [IntPtr]::Zero) -and ([Shot]::FrontPid() -eq [Shot]::Pid($h))
  $now   = [Shot]::LastInput()
  if ($now -ne $script:lastInput -and ($front -or $script:wasFront)) {
    Remove-Item (Join-Path $dir "out\$Prefix-*.png") -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used while Access was in front - every picture was deleted. Run it again.'
  }
  if ($now -ne $script:lastInput) { "  (input went to another window - Access was not in front)" }
  $script:lastInput = $now
  $script:wasFront  = $front
}
function Take($name) { Guard; Snap $name; Guard; "  Access in front: " + $script:wasFront }

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

  InGrid 'SELECT tblSales.SaleID, tblSales.SaleDate FROM tblSales WHERE (((tblSales.SaleDate) Between #2026/02/01# And #2026/02/28#));'
  Take 'range'
  Press $root 'SQL View'
  Take 'range-sql'

  InGrid 'SELECT tblSales.SaleID, tblSales.SaleDate FROM tblSales WHERE ((Year([SaleDate])=Year(Date())));'
  Take 'thisyear'
  Press $root 'SQL View'
  Take 'thisyear-sql'

  $app.DoCmd.Close(1, 'Query1', 2)
  'DONE'
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
