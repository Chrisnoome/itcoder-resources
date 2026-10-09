# Real Access 365 screens for catdb Grade 12 lesson 12, Totals queries
# (AIPascalCourse/content/catdb/totals.php - courses/cat-practical-writing.md, 9 October
# 2026). Botha's Bakery's week of sales: the Totals button and the Total row, Group By
# with Sum, Count, Avg and Max, Where on a field that is not grouped, a criterion on a
# total (HAVING), and (IEB) a crosstab query - each in Design View and its answer.
# Also makes the starter Sales.accdb and a done-right copy in C:\sims\files\catdb-totals\
# and G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-totals            (from the host)
$Name = 'catdb-totals'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Sales.accdb'
$done = Join-Path $work 'Sales-done.accdb'

function ShowQuery($app, [string]$q, [string]$pic) {
  $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb $pic; $app.DoCmd.Close(1, $q, 2)
  $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb ($pic + 'r'); $app.DoCmd.Close(1, $q, 2)
}

$app = New-Object -ComObject Access.Application
try {
  Build-Sales $app $done -Done12
  $answers = [ordered]@{ 'Sales-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Sales $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'SalesShots.accdb'
  Build-Sales $app $shots -Done12
  $d = $app.CurrentDb()
  $null = $d.CreateQueryDef('qryPlain', 'SELECT tblSales.Category, tblSales.Amount FROM tblSales;')
  $null = $d.CreateQueryDef('qryTotalsOn', 'SELECT tblSales.Category, tblSales.Amount FROM tblSales GROUP BY tblSales.Category, tblSales.Amount;')
  $d = $null
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  $app.DoCmd.OpenQuery('qryPlain', 1); Start-Sleep -Milliseconds 1500; Dump 'grid'
  foreach ($k in 'Totals', 'Run', 'View', 'Crosstab', 'Select') { TryMark $k $root @($k) }
  SnapDb 't-0'; $app.DoCmd.Close(1, 'qryPlain', 2)
  $app.DoCmd.OpenQuery('qryTotalsOn', 1); Start-Sleep -Milliseconds 1500; SnapDb 't-0b'; $app.DoCmd.Close(1, 'qryTotalsOn', 2)
  ShowQuery $app 'qryByCategory' 't-1'
  ShowQuery $app 'qryBranchCount' 't-2'
  ShowQuery $app 'qryBestSellers' 't-3'
  ShowQuery $app 'qryCakesAvg' 't-4'
  ShowQuery $app 'qryBranchByCategory' 't-5'

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
