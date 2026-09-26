# The Access screenshots for lesson B1 (access01, Building a table): a new
# table in Design View, tblSuppliers's design with a text field's properties,
# and its datasheet with the new-record row showing the defaults. Opens
# work\Access01.mdb (make-db.ps1 -Json access01.json -Out work\Access01.mdb).
# The same rules as shots.ps1 - read its header, and README.md: NOBODY MAY USE
# THE KEYBOARD OR MOUSE WHILE IT RUNS; any input stops it and deletes the
# pictures. The one new move: a Down-arrow key POSTED to Design View's own grid
# window by its handle (Shot.PostKey) to reach another field's row - a message
# to that one window, never typing at the desktop.
param([string]$Prefix = 'access01')
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

# Down arrow in the design grid, $times times.
function Down($times) {
  $grid = [Shot]::Child($h, 'OGrid')
  if ($grid -eq [IntPtr]::Zero) { throw 'no design grid' }
  for ($i = 0; $i -lt $times; $i++) { [Shot]::PostKey($grid, 0x28); Start-Sleep -Milliseconds 300 }
}

try {
  $app.Visible = $true
  $app.OpenCurrentDatabase((Join-Path $dir 'work\Access01.mdb'))
  $h = [IntPtr]$app.hWndAccessApp()
  [IO.File]::WriteAllText((Join-Path $dir 'work\access.pid'), [string][Shot]::Pid($h))   # to stop only this Access if it sticks
  [Shot]::Place($h, 60, 60, 1500, 950)
  $root = $A::FromHandle($h)

  Pick $root 'Create'
  Press $root 'Table Design'
  Start-Sleep 1
  $app.DoCmd.Maximize()
  Take 'tabledesign'
  $app.DoCmd.Close(0, 'Table1', 2)                   # acTable, acSaveNo

  $app.DoCmd.OpenTable('tblSuppliers', 1)            # acViewDesign
  $app.DoCmd.Maximize()
  Take 'design'
  Down 1
  Take 'design-name'
  Down 2
  Take 'design-city'
  $app.DoCmd.Close(0, 'tblSuppliers', 2)

  $app.DoCmd.OpenTable('tblSuppliers')
  $app.DoCmd.Maximize()
  Take 'sheet'
  $app.DoCmd.Close(0, 'tblSuppliers')
  'DONE'
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
