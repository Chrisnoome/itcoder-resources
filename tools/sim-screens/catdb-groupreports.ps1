# Real Access 365 screens for catdb Grade 12 lesson 13, Grouped reports
# (AIPascalCourse/content/catdb/groupreports.php - courses/cat-practical-writing.md,
# 9 October 2026). Botha's Bakery's sales grouped by branch: the report in Design View
# with its Branch Header and Branch Footer (=Count(*) and =Sum([Amount]) with labels),
# the Group, Sort and Total pane, Print Preview, and Report View. The report is built
# control by control through COM (CreateGroupLevel), as the Report Wizard would make it.
#     pwsh -File vm-shots.ps1 catdb-groupreports            (from the host)
$Name = 'catdb-groupreports'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null

$app = New-Object -ComObject Access.Application
try {
  # The pupils' files: SalesReport.accdb (the week's sales) and a done-right copy with the
  # grouped report and qryBranchTotals, the totals query that checks it.
  $file = Join-Path $work 'SalesReport.accdb'
  $done = Join-Path $work 'SalesReport-done.accdb'
  Build-Sales $app $done -Done13
  $answers = [ordered]@{ 'SalesReport-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Sales $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'SalesReportShots.accdb'
  Build-Sales $app $shots
  $app.RefreshDatabaseWindow()
  MakeGroupedReport $app 'SELECT * FROM tblSales ORDER BY Branch, SaleDate' 'rptSalesByBranch' 'Sales by branch, 5-9 October 2026' 'Branch' @(@('SaleDate', 1500), @('Product', 2200), @('Qty', 900), @('Amount', 1400)) 'Amount'
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  $app.DoCmd.OpenReport('rptSalesByBranch', 1)
  Start-Sleep -Milliseconds 2000
  Dump 'design'
  foreach ($k in 'Group & Sort', 'Totals', 'Text Box', 'Label', 'Property Sheet', 'View', 'Page Numbers') { TryMark $k $root @($k) }
  SnapDb 'g-1'
  try {
    Press (Find $root @('Group & Sort') $T::Button)
    Start-Sleep -Milliseconds 1500
    Dump 'grouppane'
    SnapDb 'g-2'
  } catch { "  group pane: $_" }
  $app.DoCmd.Close(3, 'rptSalesByBranch', 2)
  Start-Sleep -Milliseconds 800
  $app.DoCmd.OpenReport('rptSalesByBranch', 2)
  Start-Sleep -Milliseconds 2000
  SnapDb 'g-3'
  try { $app.DoCmd.RunCommand(19); Start-Sleep -Milliseconds 1200; SnapDb 'g-3z' } catch { "  zoom: $_" }
  $app.DoCmd.Close(3, 'rptSalesByBranch', 2)
  Start-Sleep -Milliseconds 800
  $app.DoCmd.OpenReport('rptSalesByBranch', 5)
  Start-Sleep -Milliseconds 2000
  SnapDb 'g-4'
  $app.DoCmd.Close(3, 'rptSalesByBranch', 2)

  # The Report Wizard's grouping page cannot be reached without clicking: its first page only.
  try {
    $app.DoCmd.SelectObject(0, 'tblSales', $true)
    Press (Find $root @('Create') $T::TabItem)
    Start-Sleep -Milliseconds 700
    Press (Find $root @('Report Wizard') $T::Button)
    Start-Sleep -Milliseconds 2500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'wizard'
    SnapDb 'g-5' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1000
  } catch { "  report wizard: $_" }

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
