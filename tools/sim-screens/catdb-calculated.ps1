# Real Access 365 screens for catdb Grade 12 lesson 11, Calculated fields
# (AIPascalCourse/content/catdb/calculated.php - courses/cat-practical-writing.md,
# 9 October 2026). A Durban shuttle's bookings at R6.25 a km: Cost: [KM]*6.25,
# Round() per person, a full name joined with &, a 10% discount - each in Design View
# and its answer; the Expression Builder; the query's Property Sheet. Also makes the
# starter Shuttle.accdb and a done-right copy in C:\sims\files\catdb-calculated\ and
# G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-calculated            (from the host)
$Name = 'catdb-calculated'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Shuttle.accdb'
$done = Join-Path $work 'Shuttle-done.accdb'

function ShowQuery($app, [string]$q, [string]$pic) {
  $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb $pic; $app.DoCmd.Close(1, $q, 2)
  $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb ($pic + 'r'); $app.DoCmd.Close(1, $q, 2)
}

$app = New-Object -ComObject Access.Application
try {
  Build-Shuttle $app $done -Done
  $answers = [ordered]@{ 'Shuttle-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Shuttle $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'ShuttleShots.accdb'
  Build-Shuttle $app $shots -Done
  $d = $app.CurrentDb()
  $null = $d.CreateQueryDef('qryCostEmpty', 'SELECT tblBookings.FirstName, tblBookings.Surname, tblBookings.KM FROM tblBookings ORDER BY tblBookings.Surname;')
  $d = $null
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  $app.DoCmd.OpenQuery('qryCostEmpty', 1); Start-Sleep -Milliseconds 1500; Dump 'grid'
  foreach ($k in 'Builder', 'Property Sheet', 'Run', 'View', 'Totals') { TryMark $k $root @($k) }
  SnapDb 'c-0'
  try {
    Press (Find $root @('Builder') $T::Button)
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'builder'
    SnapDb 'c-b' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1000
  } catch { "  builder: $_" }
  try { $app.DoCmd.Close(1, 'qryCostEmpty', 2) } catch { }
  ShowQuery $app 'qryCost' 'c-1'
  $app.DoCmd.OpenQuery('qryCost', 1); Start-Sleep -Milliseconds 1500
  NoPropertySheet
  try { Press (Find $root @('Property Sheet') $T::Button); Start-Sleep -Milliseconds 1500; SnapDb 'c-1p' -KeepPanes } catch { "  property sheet: $_" }
  $app.DoCmd.Close(1, 'qryCost', 2)
  ShowQuery $app 'qryPerPerson' 'c-2'
  ShowQuery $app 'qryFullName' 'c-3'
  ShowQuery $app 'qryDiscount' 'c-4'

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
