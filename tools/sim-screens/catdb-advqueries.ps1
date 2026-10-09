# Real Access 365 screens for catdb Grade 12 lesson 10, Advanced queries
# (AIPascalCourse/content/catdb/advqueries.php - courses/cat-practical-writing.md,
# 9 October 2026). Ekasi Skills College's students: Like with wildcards, Is Null,
# a date range with Between, and Year([DOB]) as a calculated criterion - each query in
# Design View and its answer. Criteria set through the queries' SQL; places on the grid
# read off the pictures. Also makes the starter College.accdb and a done-right copy in
# C:\sims\files\catdb-advqueries\ and G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-advqueries            (from the host)
$Name = 'catdb-advqueries'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'College.accdb'
$done = Join-Path $work 'College-done.accdb'

function ShowQuery($app, [string]$q, [string]$pic) {
  $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb $pic; $app.DoCmd.Close(1, $q, 2)
  $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb ($pic + 'r'); $app.DoCmd.Close(1, $q, 2)
}

$app = New-Object -ComObject Access.Application
try {
  Build-College $app $done -Done10
  $answers = [ordered]@{ 'College-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-College $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'CollegeShots.accdb'
  Build-College $app $shots -Done10
  $d = $app.CurrentDb()
  $null = $d.CreateQueryDef('qryEmpty', 'SELECT tblStudents.FirstName, tblStudents.Surname, tblStudents.Course, tblStudents.Email FROM tblStudents;')
  $d = $null
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  $app.DoCmd.OpenQuery('qryEmpty', 1); Start-Sleep -Milliseconds 1500; Dump 'grid'; SnapDb 'a-0'; $app.DoCmd.Close(1, 'qryEmpty', 2)
  ShowQuery $app 'qrySurnameM' 'a-1'
  ShowQuery $app 'qryNoEmail' 'a-2'
  ShowQuery $app 'qryBorn2007' 'a-3'
  ShowQuery $app 'qryFirstHalf' 'a-4'

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
