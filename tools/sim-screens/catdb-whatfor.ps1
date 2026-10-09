# Real Access 365 screens for catdb Grade 11 lesson 1, What a database is for
# (AIPascalCourse/content/catdb/whatfor.php - courses/cat-practical-writing.md,
# 9 October 2026). Phumlani Secondary's library: the Navigation Pane with a table,
# a query, a form and a report; the practice simulation (Coconut's empty Copies
# cell); opening each object; the Create tab; the File tab (Backstage); the Tell
# me box. Also makes the pupils' starter Library.accdb and a done-right copy in
# C:\sims\files\catdb-whatfor\ and G:\My Drive\CAT\Access\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catdb-whatfor            (from the host)
$Name = 'catdb-whatfor'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Library.accdb'

$app = New-Object -ComObject Access.Application
try {
  # The pupils' files first: the starter and the done copy, then Access's own answers.
  Build-Library $app (Join-Path $work 'Library-done.accdb') -Done
  $answers = [ordered]@{ 'Library-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app (Join-Path $work 'Library-done.accdb')
  Build-Library $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item (Join-Path $work 'Library-done.accdb') "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  # The screens: a copy with a form and a report too.
  $shots = Join-Path $work 'LibraryShots.accdb'
  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  Build-Library $app $shots -Objects
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1500
  Dump 'home'
  SnapDb 'w-1'                                             # the Navigation Pane, nothing open
  foreach ($k in 'tblBooks', 'qryFiction', 'frmBooks', 'rptFiction', 'Tell me what you want to do', 'File Tab', 'Create', 'Search...') { TryMark $k $root @($k) }

  # Practice: Coconut's Copies is empty.
  $app.DoCmd.OpenTable('tblBooks')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  Dump 'datasheet'
  SnapDb 'p-1'
  $app.DoCmd.Close(0, 'tblBooks', 2)
  $db = $app.CurrentDb(); $db.Execute("UPDATE tblBooks SET Copies = 4 WHERE Title = 'Coconut'"); $db = $null
  $app.DoCmd.OpenTable('tblBooks')
  Start-Sleep -Milliseconds 1500
  SnapDb 'p-2'
  $app.DoCmd.Close(0, 'tblBooks', 2)

  # Each kind of object, opened.
  $app.DoCmd.OpenQuery('qryFiction')
  Start-Sleep -Milliseconds 1500
  SnapDb 'o-q'
  $app.DoCmd.Close(1, 'qryFiction', 2)
  $app.DoCmd.OpenForm('frmBooks')
  Start-Sleep -Milliseconds 1500
  Dump 'form'
  SnapDb 'o-f'
  $app.DoCmd.GoToRecord(2, 'frmBooks', 1)                  # acNext
  Start-Sleep -Milliseconds 800
  SnapDb 'o-f2'
  $app.DoCmd.Close(2, 'frmBooks', 2)
  $app.DoCmd.OpenReport('rptFiction', 2)                     # acViewPreview
  Start-Sleep -Milliseconds 2000
  SnapDb 'o-r'
  $app.DoCmd.Close(3, 'rptFiction', 2)
  Start-Sleep -Milliseconds 800

  # The Create tab.
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'create'
  foreach ($k in 'Table Design', 'Query Design', 'Query Wizard', 'Form', 'Form Wizard', 'Report', 'Report Wizard', 'Table') { TryMark "create $k" $root @($k) }
  SnapDb 'c-1'
  Press (Find $root @('Database Tools') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'dbtools'
  TryMark 'tab Database Tools' $root @('Database Tools') $T::TabItem
  TryMark 'compact' $root @('Compact and Repair Database')
  SnapDb 'd-1'
  Press (Find $root @('Home') $T::TabItem)
  Start-Sleep -Milliseconds 800

  # Backstage (File tab): Info, with Compact & Repair; then out with Escape.
  try {
    Press (Find $root @('File Tab', 'File') $T::Button -tries 6)
    Start-Sleep -Milliseconds 2000
    Press (Find $root @('Info') $T::ListItem)
    Start-Sleep -Milliseconds 1500
    Dump 'backstage'
    SnapDb 'b-1'
    TryMark 'file Save As' $root @('Save As') $T::ListItem
    Press (Find $root @('Save As') $T::ListItem)
    Start-Sleep -Milliseconds 1500
    Dump 'saveas'
    SnapDb 'b-2'
    [Shot]::PostKey($h, 0x1B)
    Start-Sleep -Milliseconds 1200
  } catch { "  Backstage: $_" }

  # The security bar, if Access shows it when the file is opened again.
  $app.CloseCurrentDatabase()
  Start-Sleep -Milliseconds 800
  $app.OpenCurrentDatabase($shots)
  Start-Sleep -Milliseconds 2000
  Dump 'reopened'
  SnapDb 'sec-1'

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
