# Real Access 365 screens for catdb Grade 11 lesson 8, Criteria that do more
# (AIPascalCourse/content/catdb/criteria.php - courses/cat-practical-writing.md, 9 October
# 2026). Phumlani Secondary's athletics day: AND on one row, OR on two rows, NOT, Between
# with a sort, a field used for its criterion but not shown, and the classic AND-for-OR
# mistake; and (CAPS) a calculated field on the tour's travellers. Grid criteria set
# through DAO; places read off the pictures. Also makes the starter Athletics.accdb and a
# done-right copy in C:\sims\files\catdb-criteria\ and G:\My Drive\CAT\Access\, with
# Access's own answers (answers.json).
#     pwsh -File vm-shots.ps1 catdb-criteria            (from the host)
$Name = 'catdb-criteria'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Athletics.accdb'
$done = Join-Path $work 'Athletics-done.accdb'

function ShowQuery($app, [string]$q, [string]$pic, [switch]$Result) {
  $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb $pic; $app.DoCmd.Close(1, $q, 2)
  if ($Result) { $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb ($pic + 'r'); $app.DoCmd.Close(1, $q, 2) }
}

$app = New-Object -ComObject Access.Application
try {
  Build-Athletics $app $done -Done
  $answers = [ordered]@{ 'Athletics-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Athletics $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'AthleticsShots.accdb'
  Build-Athletics $app $shots -Done
  $d = $app.CurrentDb()
  $null = $d.CreateQueryDef('qryRedOnly', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.House FROM tblAthletes WHERE (((tblAthletes.House)="Red")) ORDER BY tblAthletes.House, tblAthletes.Surname;')
  $null = $d.CreateQueryDef('qryWrongOr', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.House FROM tblAthletes WHERE (((tblAthletes.House)="Red" And (tblAthletes.House)="Blue"));')
  $d = $null
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  ShowQuery $app 'qryGirls11' 'c-1' -Result
  ShowQuery $app 'qryRedBlue' 'c-2' -Result
  ShowQuery $app 'qryNoRelay' 'c-3' -Result
  ShowQuery $app 'qrySprinters' 'c-4' -Result
  ShowQuery $app 'qryRedOnly' 'c-5' -Result
  ShowQuery $app 'qryWrongOr' 'c-6' -Result
  CloseDb $app $shots

  # CAPS: a calculated field, on the tour's travellers.
  $tour = Join-Path $work 'TourCalcShots.accdb'
  Build-Tour $app $tour
  $d = $app.CurrentDb()
  $null = $d.CreateQueryDef('qryBalance', 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Deposit, 2500-[Deposit] AS Balance FROM tblTravellers WHERE (((tblTravellers.PaidInFull)=False)) ORDER BY tblTravellers.Surname;')
  $answers['TourCalc.accdb'] = (QueryAnswers $d)
  $d = $null
  $app.RefreshDatabaseWindow()
  ShowQuery $app 'qryBalance' 'k-1' -Result
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

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
