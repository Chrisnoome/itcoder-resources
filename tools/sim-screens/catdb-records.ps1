# Real Access 365 screens for catdb Grade 11 lesson 3, Working with records
# (AIPascalCourse/content/catdb/records.php - courses/cat-practical-writing.md, 9 October
# 2026). Phumlani Secondary's Spring Day market: a new record typed in (posted to the
# datasheet's window), the pencil, a record selected for deleting, sorted A to Z, a filter,
# Find and Replace, (IEB) gridlines and alternate row colour, the External Data tab.
# Also makes the starter SpringMarket.accdb and LateStalls.csv, and a done-right copy
# (the CSV imported by Access's own Import Text), in C:\sims\files\catdb-records\ and
# G:\My Drive\CAT\Access\.
#     pwsh -File vm-shots.ps1 catdb-records            (from the host)
$Name = 'catdb-records'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'SpringMarket.accdb'
$done = Join-Path $work 'SpringMarket-done.accdb'
$csv  = Join-Path $work 'LateStalls.csv'
Write-LateStalls $csv

$app = New-Object -ComObject Access.Application
try {
  Build-Market $app $done $csv -Done
  $db = $app.CurrentDb(); $rs = $db.OpenRecordset('SELECT COUNT(*) FROM tblLateStalls'); "  tblLateStalls rows: $($rs.Fields.Item(0).Value)"; $rs.Close(); $rs = $null; $db = $null
  CloseDb $app $done
  Build-Market $app $file $csv
  CloseDb $app $file
  Publish $file
  Publish $csv
  Copy-Item $done "C:\sims\files\$Name" -Force

  $shots = Join-Path $work 'MarketShots.accdb'
  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  Build-Market $app $shots $csv
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1500

  $app.DoCmd.OpenTable('tblStalls')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  Dump 'datasheet'
  foreach ($k in 'Ascending', 'Descending', 'Remove Sort', 'Filter', 'Selection', 'Advanced', 'Toggle Filter', 'Find...', 'Replace...', 'Delete', 'New', 'Gridlines', 'Alternate Row Color', 'Next record', 'New (blank) record') { TryMark $k $root @($k) }
  SnapDb 'r-1'
  # a new record: go to the new row and type into it (posted to the datasheet's window)
  $app.DoCmd.GoToRecord(0, 'tblStalls', 5)                 # acNewRec
  Start-Sleep -Milliseconds 800
  SnapDb 'r-2'
  GridKeys @(0x09)                                          # past the AutoNumber
  GridType 'Lerato Khumalo' @(0x09)
  GridType 'Beaded bracelets' @(0x09)
  Start-Sleep -Milliseconds 500
  SnapDb 'r-3'                                             # the pencil
  try { $app.DoCmd.RunCommand(97) } catch { "  save record: $_" }   # acCmdSaveRecord (what Shift+Enter does)
  Start-Sleep -Milliseconds 700
  SnapDb 'r-3b'
  $app.DoCmd.Close(0, 'tblStalls', 2)
  Start-Sleep -Milliseconds 800
  $db = $app.CurrentDb(); $db.Execute("DELETE FROM tblStalls WHERE Stallholder = 'Lerato Khumalo'"); $db = $null

  # select the car wash's record (row 5) for deleting
  $app.DoCmd.OpenTable('tblStalls')
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.GoToRecord(0, 'tblStalls', 4, 5)              # acGoTo record 5
  Start-Sleep -Milliseconds 500
  try { $app.DoCmd.RunCommand(50) } catch { "  select record: $_" }   # acCmdSelectRecord (109 selects them all)
  Start-Sleep -Milliseconds 700
  SnapDb 'r-4'
  $app.DoCmd.Close(0, 'tblStalls', 2)
  $db = $app.CurrentDb(); $db.Execute("DELETE FROM tblStalls WHERE Stallholder = 'Thabo''s car wash'"); $db = $null
  $app.DoCmd.OpenTable('tblStalls')
  Start-Sleep -Milliseconds 1200
  SnapDb 'r-4b'

  # sorted A to Z on Stallholder
  $ds = $app.Screen.ActiveDatasheet
  $ds.OrderBy = '[tblStalls].[Stallholder]'; $ds.OrderByOn = $true
  Start-Sleep -Milliseconds 900
  SnapDb 'r-5'
  $ds.OrderByOn = $false
  # a filter: only Food
  $ds.Filter = "[tblStalls].[Category]='Food'"; $ds.FilterOn = $true
  Start-Sleep -Milliseconds 900
  SnapDb 'r-6'
  $ds.FilterOn = $false
  Start-Sleep -Milliseconds 600
  # Filter by Selection: the cursor in a Food cell, the Selection menu open
  try {
    $app.DoCmd.GoToRecord(0, 'tblStalls', 2)
    $app.Screen.ActiveDatasheet.Controls.Item('Category').SetFocus()
    Start-Sleep -Milliseconds 600
    SnapDb 'r-6a'
    $p = ExpandMenu (Find $root @('Selection') -tries 6)
    DumpOthers 'selection'
    SnapDb 'r-6b' -Others
    try { $p.Collapse() } catch { }
    Start-Sleep -Milliseconds 600
  } catch { "  selection menu: $_" }

  # Find and Replace (Home > Replace)
  $app.DoCmd.GoToRecord(0, 'tblStalls', 2)                 # acFirst
  try {
    Press (Find $root @('Replace...', 'Replace') $T::Button)
    Start-Sleep -Milliseconds 1500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'replace'
    SnapDb 'r-7' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 800
  } catch { "  replace: $_" }

  # IEB: gridlines and alternate row colour (the datasheet's own settings)
  try {
    $ds = $app.Screen.ActiveDatasheet
    $ds.DatasheetAlternateBackColor = 0xF2E6D9               # a light blue (BGR)
    $ds.DatasheetGridlinesBehavior = 1                       # horizontal only
    Start-Sleep -Milliseconds 900
    SnapDb 'r-8'
  } catch { "  datasheet look: $_" }
  $app.DoCmd.Close(0, 'tblStalls', 2)
  Start-Sleep -Milliseconds 800

  # External Data
  Press (Find $root @('External Data') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'external'
  foreach ($k in 'New Data Source', 'Excel', 'Text File', 'PDF or XPS') { TryMark "ext $k" $root @($k) }
  SnapDb 'x-1'
  try {
    $p = ExpandMenu (Find $root @('New Data Source') -tries 6)
    DumpOthers 'newsource'
    SnapDb 'x-2' -Others
    try {
      $ff = $null
      foreach ($w in [DbComp]::Others($h)) { try { $ff = $AE::FromHandle($w).FindFirst($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'From File'))) } catch { }; if ($ff) { break } }
      if ($ff) { $null = ExpandMenu $ff; DumpOthers 'fromfile'; SnapDb 'x-3' -Others } else { '  no From File item' }
    } catch { "  from file: $_" }
  } catch { "  new data source: $_" }

  SaveMarks
}
catch {
  "FAILED: $_"
  throw
}
finally {
  try { $app.CloseCurrentDatabase() } catch { }
  $app.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($app)
}
