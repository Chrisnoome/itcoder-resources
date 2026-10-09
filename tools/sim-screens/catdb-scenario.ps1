# Real Access 365 screens for catdb Grade 12 lesson 16, Designing for a scenario
# (AIPascalCourse/content/catdb/scenario.php - courses/cat-practical-writing.md,
# 9 October 2026). The Soweto Fun Run: the starter's tblRunners in Datasheet and Design
# View, and the done-right copy's queries' answers (to check work against), the
# Relationships-free one-table layout an exam supplies. Also makes the starter
# FunRun.accdb and a done-right copy in C:\sims\files\catdb-scenario\ and
# G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-scenario            (from the host)
$Name = 'catdb-scenario'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'FunRun.accdb'
$done = Join-Path $work 'FunRun-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-FunRun $app $done -Done
  $answers = [ordered]@{ 'FunRun-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-FunRun $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'FunRunShots.accdb'
  Build-FunRun $app $shots
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.OpenTable('tblRunners'); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb 's-1'; $app.DoCmd.Close(0, 'tblRunners', 2)
  $app.DoCmd.OpenTable('tblRunners', 1); Start-Sleep -Milliseconds 1500; GridKeys @(0x28, 0x28, 0x28, 0x28); Start-Sleep -Milliseconds 600; SnapDb 's-2'; $app.DoCmd.Close(0, 'tblRunners', 2)
  CloseDb $app $shots

  $app.OpenCurrentDatabase($done)
  Start-Sleep -Milliseconds 1500
  foreach ($q in 'qryLong', 'qryPerDistance') {
    $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb "q-$q"; $app.DoCmd.Close(1, $q, 2)
    $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb "q-$q-r"; $app.DoCmd.Close(1, $q, 2)
  }

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
