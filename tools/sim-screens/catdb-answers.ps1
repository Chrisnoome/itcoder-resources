# Real Access 365 screens for catdb Grade 12 lesson 14, Reports that answer a question
# (AIPascalCourse/content/catdb/answers.php - courses/cat-practical-writing.md, 9 October
# 2026). Ekasi Skills College: rptStudents in Design View with the Property Sheet on the
# report's Data tab (its Record Source), the report on its new source in Print Preview,
# qryOwing and qryCourseCount, and the External Data tab's Export group (Excel, Word
# Merge, PDF). Also makes the starter CollegeReport.accdb (tblStudents and rptStudents on
# the table) and a done-right copy in C:\sims\files\catdb-answers\ and
# G:\My Drive\CAT\Access\, with Access's own answers.
#     pwsh -File vm-shots.ps1 catdb-answers            (from the host)
$Name = 'catdb-answers'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'CollegeReport.accdb'
$done = Join-Path $work 'CollegeReport-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-College $app $done -Done14 -Report
  $answers = [ordered]@{ 'CollegeReport-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-College $app $file -Report
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'CollegeReportShots.accdb'
  Build-College $app $shots -Done14 -Report
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  # 1. The report in Design View with the Property Sheet on the report itself.
  $app.DoCmd.OpenReport('rptStudents', 1)
  Start-Sleep -Milliseconds 2000
  NoPropertySheet
  try {
    Press (Find $root @('Property Sheet') $T::Button)
    Start-Sleep -Milliseconds 1500
    Dump 'props'
    SnapDb 's-1' -KeepPanes
  } catch { "  property sheet: $_" }
  $app.DoCmd.Close(3, 'rptStudents', 2)
  $app.DoCmd.OpenReport('rptStudents', 2)
  Start-Sleep -Milliseconds 2000
  SnapDb 's-2'
  $app.DoCmd.Close(3, 'rptStudents', 2)

  # 2. The two queries' answers.
  foreach ($q in 'qryOwing', 'qryCourseCount') {
    $app.DoCmd.OpenQuery($q, 1); Start-Sleep -Milliseconds 1500; SnapDb "q-$q"; $app.DoCmd.Close(1, $q, 2)
    $app.DoCmd.OpenQuery($q); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb "q-$q-r"; $app.DoCmd.Close(1, $q, 2)
  }

  # 3. External Data with a query selected: the Export group.
  $app.DoCmd.SelectObject(1, 'qryOwing', $true)
  Press (Find $root @('External Data') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Dump 'external'
  foreach ($k in 'Excel', 'Text File', 'PDF or XPS', 'Word Merge', 'More', 'Email') { TryMark "ext $k" $root @($k) }
  SnapDb 'x-1'
  try {
    $more = Find $root @('More') -tries 6
    $null = ExpandMenu $more
    DumpOthers 'more'
    SnapDb 'x-2' -Others
  } catch { "  more: $_" }

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
