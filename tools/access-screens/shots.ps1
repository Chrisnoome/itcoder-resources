# The Access screenshots for the SQL course's Access lessons (the 64-bit
# PowerShell, Access 365 installed). Opens work\TuckShop.mdb in real Access and
# walks what a pupil does - a table, Design View, Query Design, SQL View, Run -
# saving out\<prefix>-<name>.png at each step. Then crop.py cuts them.
#
# THE SAFETY RULES (tools/ui-screens/README.md):
# - Nothing is clicked or typed. Access is driven through COM (OpenTable,
#   Maximize, a hidden query holding the SQL) and UI Automation on its own named
#   buttons ("Query Design", "SQL View", "Run", the "Create" tab) - never the
#   mouse or the keyboard. Every picture is taken with PrintWindow (Shot.cs),
#   which holds only Access's own drawing.
# - NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS (about a minute).
#   Access brings itself to the front, and on 26 September 2026 keys typed in
#   another program landed in its SQL box. So before every picture the run
#   checks when the keyboard or mouse was last used; if it was during the run,
#   it stops and deletes every picture it made.
param([string]$Prefix = 'access00')
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

try {
  $app.Visible = $true
  $app.OpenCurrentDatabase((Join-Path $dir 'work\TuckShop.mdb'))
  $h = [IntPtr]$app.hWndAccessApp()
  [IO.File]::WriteAllText((Join-Path $dir 'work\access.pid'), [string][Shot]::Pid($h))   # to stop only this Access if it sticks
  [Shot]::Place($h, 60, 60, 1500, 950)
  $root = $A::FromHandle($h)
  Take 'open'

  $app.DoCmd.OpenTable('tblProducts')
  $app.DoCmd.Maximize()
  Take 'products'
  $app.DoCmd.Close(0, 'tblProducts')

  $app.DoCmd.OpenTable('tblProducts', 1)             # acViewDesign
  $app.DoCmd.Maximize()
  Take 'design'
  $app.DoCmd.Close(0, 'tblProducts', 2)              # acSaveNo

  $app.DoCmd.OpenTable('tblSales')
  $app.DoCmd.Maximize()
  Take 'sales'
  $app.DoCmd.Close(0, 'tblSales')

  Pick $root 'Create'
  Take 'create'

  Press $root 'Query Design'
  Take 'querydesign'
  $app.DoCmd.Close(1, 'Query1', 2)                   # the new, unsaved query

  ShowSql 'SELECT * FROM tblProducts;'
  $app.DoCmd.Maximize()
  Take 'sqlview'
  Press $root 'Run'
  Take 'result'

  ShowSql 'SELECT COUNT(*) FROM tblProducts;'
  Press $root 'Run'
  Take 'count'

  # A misspelt field name: Access asks for a value.
  ShowSql 'SELECT ProductNam FROM tblProducts;'
  Press $root 'Run'
  $box = Dialog 'Enter Parameter Value'
  if ($box) {
    Start-Sleep -Milliseconds 800
    Guard
    'parameter ' + [Shot]::Save([IntPtr]$box.Current.NativeWindowHandle, (Join-Path $dir "out\$Prefix-parameter.png"))
    Press $box 'Cancel'
  } else { 'NO parameter box' }
  Start-Sleep 1
  $other = Dialog 'Microsoft Access'
  if ($other) { 'after Cancel: ' + (($other.FindAll($Scope::Descendants, (New-Object $C($A::ControlTypeProperty, $T::Text))) | ForEach-Object { $_.Current.Name }) -join ' | '); Press $other 'OK' }

  # A change while the security bar is unanswered (Disabled Mode): what happens?
  $sum = $app.CurrentDb().OpenRecordset('SELECT SUM(Price) AS Total FROM tblProducts').Fields.Item(0).Value
  "sum of prices before: $sum"
  ShowSql 'UPDATE tblProducts SET Price = Price + 1;'
  Press $root 'Run'
  Start-Sleep 2
  $ask = Dialog 'Microsoft Access'
  if ($ask) {
    'a message box: ' + (($ask.FindAll($Scope::Descendants, (New-Object $C($A::ControlTypeProperty, $T::Text))) | ForEach-Object { $_.Current.Name }) -join ' | ')
    Guard
    'update-ask ' + [Shot]::Save([IntPtr]$ask.Current.NativeWindowHandle, (Join-Path $dir "out\$Prefix-update-ask.png"))
    try { Press $ask 'No' } catch { Press $ask 'OK' }
  } else { 'no message box' }
  Take 'update'
  $sum = $app.CurrentDb().OpenRecordset('SELECT SUM(Price) AS Total FROM tblProducts').Fields.Item(0).Value
  "sum of prices after: $sum"
  "status bar: " + (($root.FindAll($Scope::Descendants, (New-Object $C($A::ControlTypeProperty, $T::Text))) | ForEach-Object { $_.Current.Name } | Where-Object { $_ -match 'block|Disabled|Ready' }) -join ' | ')
  $app.DoCmd.Close(1, 'Query1', 2)
  'DONE'
} finally {
  $app.Quit(2)
  [Runtime.InteropServices.Marshal]::ReleaseComObject($app) | Out-Null
}
