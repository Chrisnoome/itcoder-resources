# Real Access 365 screens for catdb Grade 11 lesson 9, Reports
# (AIPascalCourse/content/catdb/reports.php - courses/cat-practical-writing.md, 9 October
# 2026). The tour's unpaid travellers: the Create tab's Reports group with qryNotPaid
# selected, a report made by Report (Layout View), the Report Wizard's first page, a report
# in Print Preview and in Design View with its five sections (a count and a sum in the
# Report Footer, page numbers in the Page Footer), and the Print Preview tab's PDF button.
# Also makes the starter TourReport.accdb (the tour table only) and a done-right copy in
# C:\sims\files\catdb-reports\ and G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-reports            (from the host)
$Name = 'catdb-reports'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'TourReport.accdb'
$done = Join-Path $work 'TourReport-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-Tour $app $done -Done9
  $answers = [ordered]@{ 'TourReport-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-Tour $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'TourReportShots.accdb'
  Build-Tour $app $shots -Done9
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  # 1. Create > Report with qryNotPaid selected: Layout View.
  $app.DoCmd.SelectObject(1, 'qryNotPaid', $true)
  Start-Sleep -Milliseconds 600
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  foreach ($k in 'Report', 'Report Design', 'Blank Report', 'Report Wizard', 'Labels', 'qryNotPaid', 'rptNotPaid') { TryMark "create $k" $root @($k) }
  SnapDb 'r-1'
  try {
    # Pressing Create > Report through UI Automation crashed Access (9 October 2026): the
    # report it makes is rptNotPaid's twin, so rptNotPaid in Layout View stands in for it.
    $app.DoCmd.OpenReport('rptNotPaid', 6)                  # acViewLayout
    Start-Sleep -Milliseconds 2500
    NoFieldList; NoGroupPane
    Dump 'layout'
    foreach ($k in 'View', 'Group & Sort', 'Totals', 'Title', 'Logo', 'Page Numbers', 'Date and Time', 'Add Existing Fields', 'Property Sheet') { TryMark "layout $k" $root @($k) }
    SnapDb 'r-2'
    $app.DoCmd.Close(3, 'rptNotPaid', 2)
    Start-Sleep -Milliseconds 1000
  } catch { "  report button: $_" }

  # 2. The Report Wizard's first page.
  try {
    Press (Find $root @('Create') $T::TabItem)
    Start-Sleep -Milliseconds 700
    Press (Find $root @('Report Wizard') $T::Button)
    Start-Sleep -Milliseconds 2500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'wizard'
    SnapDb 'r-3' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1200
  } catch { "  report wizard: $_" }

  # 3. rptNotPaid in Print Preview, then in Design View.
  $app.DoCmd.OpenReport('rptNotPaid', 2)
  Start-Sleep -Milliseconds 2000
  Dump 'preview'
  foreach ($k in 'Print', 'Landscape', 'Portrait', 'PDF or XPS', 'Excel', 'Close Print Preview', 'Margins', 'Zoom', 'One Page') { TryMark "preview $k" $root @($k) }
  SnapDb 'r-4'
  $app.DoCmd.Close(3, 'rptNotPaid', 2)
  Start-Sleep -Milliseconds 800
  $app.DoCmd.OpenReport('rptNotPaid', 1)                    # acViewDesign
  Start-Sleep -Milliseconds 2000
  NoFieldList; NoGroupPane
  Dump 'design'
  foreach ($k in 'View', 'Group & Sort', 'Totals', 'Label', 'Text Box', 'Page Numbers', 'Date and Time', 'Title', 'Property Sheet') { TryMark "design $k" $root @($k) }
  SnapDb 'r-5'
  $app.DoCmd.Close(3, 'rptNotPaid', 2)
  Start-Sleep -Milliseconds 800
  $app.DoCmd.OpenReport('rptNotPaid', 5)                    # acViewReport
  Start-Sleep -Milliseconds 2000
  SnapDb 'r-6'
  $app.DoCmd.Close(3, 'rptNotPaid', 2)

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
