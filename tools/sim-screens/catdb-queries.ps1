# Real Access 365 screens for catdb Grade 11 lesson 7, Queries
# (AIPascalCourse/content/catdb/queries.php - courses/cat-practical-writing.md, 9 October
# 2026). Phumlani Secondary's tour to Durban: the Create tab's Queries group, the New
# Query box (Query Wizard), a new query in Design View with the Add Tables pane, the
# design grid before and after a criterion and a sort, the answer, (IEB) SQL View, a
# text criterion and a descending sort. The grid's criteria are set through DAO (the
# query's SQL) and the query opened again - places on the grid are read off the pictures.
# Also makes the starter Tour.accdb and a done-right copy in C:\sims\files\catdb-queries\
# and G:\My Drive\CAT\Access\, with Access's own answers (answers.json).
#     pwsh -File vm-shots.ps1 catdb-queries            (from the host)
$Name = 'catdb-queries'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Tour.accdb'
$done = Join-Path $work 'Tour-done.accdb'

function SetSql($app, [string]$q, [string]$sql) { $d = $app.CurrentDb(); $d.QueryDefs.Item($q).SQL = $sql; $d = $null }

$app = New-Object -ComObject Access.Application
try {
  Build-Tour $app $done -Done7
  $answers = [ordered]@{ 'Tour-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Tour $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'TourShots.accdb'
  Build-Tour $app $shots -Done7
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  # 1. The Create tab; the New Query box; a new query with the Add Tables pane.
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  SnapDb 'q-1'
  try {
    Press (Find $root @('Query Wizard') $T::Button)
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'newquery'
    SnapDb 'q-2' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1000
  } catch { "  query wizard: $_" }
  try {
    Press (Find $root @('Create') $T::TabItem)
    Start-Sleep -Milliseconds 600
    Press (Find $root @('Query Design') $T::Button)
    Start-Sleep -Milliseconds 2500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    Dump 'newdesign'
    foreach ($k in 'Run', 'View', 'Add Tables', 'Totals', 'Select', 'Show Table', 'Add Selected Tables', 'tblTravellers') { TryMark "design $k" $root @($k) }
    SnapDb 'q-3'
    try { $nm = 'Query1'; $app.DoCmd.Close(1, $nm, 2) } catch { "  close Query1: $_" }
    Start-Sleep -Milliseconds 1000
  } catch { "  query design: $_" }

  # 2. qryGrade11: the grid with its fields only, then with 11 and the sort; the answer.
  SetSql $app 'qryGrade11' 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Grade, tblTravellers.Town FROM tblTravellers;'
  $app.DoCmd.OpenQuery('qryGrade11', 1)
  Start-Sleep -Milliseconds 1500
  Dump 'grid'
  SnapDb 'q-4'
  $app.DoCmd.Close(1, 'qryGrade11', 2)
  SetSql $app 'qryGrade11' 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Grade, tblTravellers.Town FROM tblTravellers WHERE (((tblTravellers.Grade)=11)) ORDER BY tblTravellers.Surname;'
  $app.DoCmd.OpenQuery('qryGrade11', 1)
  Start-Sleep -Milliseconds 1500
  SnapDb 'q-5'
  try { Press (Find $root @('SQL View', 'SQL') -tries 6); Start-Sleep -Milliseconds 1500; Dump 'sql'; SnapDb 'q-7' } catch { "  SQL view: $_" }
  $app.DoCmd.Close(1, 'qryGrade11', 2)
  $app.DoCmd.OpenQuery('qryGrade11')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  SnapDb 'q-6'
  $app.DoCmd.Close(1, 'qryGrade11', 2)

  # 3. qrySoweto (a text criterion) and qryBigDeposits (>=, descending).
  $app.DoCmd.OpenQuery('qrySoweto', 1)
  Start-Sleep -Milliseconds 1500
  SnapDb 'q-8'
  $app.DoCmd.Close(1, 'qrySoweto', 2)
  $app.DoCmd.OpenQuery('qryBigDeposits', 1)
  Start-Sleep -Milliseconds 1500
  SnapDb 'q-9'
  $app.DoCmd.Close(1, 'qryBigDeposits', 2)
  $app.DoCmd.OpenQuery('qryBigDeposits')
  Start-Sleep -Milliseconds 1500
  SnapDb 'q-10'
  $app.DoCmd.Close(1, 'qryBigDeposits', 2)

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
