# The FunRun done-right copy with its form and report (9 October 2026): the test file
# AIPascalCourse/tests/uploads/catdb/FunRun-done.accdb (made by catdb-scenario: the table
# design and queries only, 16/20 on upFunRun) is put in work\FunRun-done-in.accdb, opened in
# real Access 365 in the CAT VM and given, through COM:
#   frmRunners  record source tblRunners; FirstName, Surname, Gender, Age, Distance, Club,
#               EntryFee, Paid, FinishMin; a title and =Date() in the Form Header.
#   rptDistance FirstName, Surname, Age, FinishMin grouped on Distance; =Count(*) and a label
#               in the Distance Footer.
# Everything already in the file is kept. Content is never enabled (the file has no code).
# Comes back as files\catdb-funrundone\FunRun-done.accdb.
#     pwsh -File vm-shots.ps1 catdb-funrundone
$Name = 'catdb-funrundone'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')

$work = 'C:\sims\catdb-done'
New-Item -ItemType Directory -Force $work | Out-Null
$dest = "C:\sims\files\$Name"
New-Item -ItemType Directory -Force $dest | Out-Null
$f = Join-Path $work 'FunRun-done.accdb'
Copy-Item (Join-Path $PSScriptRoot 'work\FunRun-done-in.accdb') $f -Force

$app = New-Object -ComObject Access.Application
try {
  $app.OpenCurrentDatabase($f)
  $app.RefreshDatabaseWindow()
  MakeForm $app 'tblRunners' 'frmRunners' 'Soweto Fun Run - runners' @('FirstName', 'Surname', 'Gender', 'Age', 'Distance', 'Club', 'EntryFee', 'Paid', 'FinishMin')
  # The date in the Form Header (Form Design > Date and Time makes the same: =Date(), Long Date).
  $app.DoCmd.OpenForm('frmRunners', 1)
  Start-Sleep -Milliseconds 800
  $d = $app.CreateControl('frmRunners', 109, 1, '', '', 6600, 200, 3400, 330)
  $d.ControlSource = '=Date()'; $d.Format = 'Long Date'
  $app.DoCmd.Close(2, 'frmRunners', 1)
  $d = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()
  "  =Date() on frmRunners"

  $r = $app.CreateReport()
  $r.RecordSource = 'tblRunners'
  $tmp = $r.Name
  $app.DoCmd.RunCommand(37)
  $t = $app.CreateReportControl($tmp, 100, 1, '', '', 100, 100, 6500, 600); $t.Caption = 'Runners by distance'; $t.FontSize = 18; $t.FontBold = $true
  # The Group, Sort and Total pane stays open from an earlier run, and CreateGroupLevel refuses
  # while it shows: close it (acCmdSortingAndGrouping, 51, toggles it) and try again.
  try { $null = $app.CreateGroupLevel($tmp, 'Distance', $true, $true) }
  catch { "  group pane open - closing it"; $app.DoCmd.RunCommand(51); Start-Sleep -Milliseconds 700; $null = $app.CreateGroupLevel($tmp, 'Distance', $true, $true) }
  $g = $app.CreateReportControl($tmp, 109, 5, '', 'Distance', 100, 60, 2400, 380); $g.FontBold = $true; $g.FontSize = 12
  $x = 2700
  foreach ($c in @(@('FirstName', 2000), @('Surname', 2200), @('Age', 900), @('FinishMin', 1400))) {
    $l = $app.CreateReportControl($tmp, 100, 3, '', '', $x, 60, $c[1] - 60, 330); $l.Caption = $c[0]; $l.FontBold = $true
    $null = $app.CreateReportControl($tmp, 109, 0, '', $c[0], $x, 40, $c[1] - 60, 330)
    $x += $c[1]
  }
  $fl = $app.CreateReportControl($tmp, 100, 6, '', '', 2700, 80, 1600, 330); $fl.Caption = 'Runners:'; $fl.FontItalic = $true
  $fc = $app.CreateReportControl($tmp, 109, 6, '', '', 4300, 80, 900, 330); $fc.ControlSource = '=Count(*)'
  $r.Section(0).Height = 420; $r.Section(3).Height = 450; $r.Section(5).Height = 480; $r.Section(6).Height = 520
  $app.DoCmd.Close(3, $tmp, 1)
  Start-Sleep -Milliseconds 500
  $app.DoCmd.Rename('rptDistance', 3, $tmp)
  $r = $null; $t = $null; $g = $null; $l = $null; $fl = $null; $fc = $null; [GC]::Collect(); [GC]::WaitForPendingFinalizers()
  "  made rptDistance"

  foreach ($o in $app.CurrentProject.AllForms)   { "  form: $($o.Name)" }
  foreach ($o in $app.CurrentProject.AllReports) { "  report: $($o.Name)" }
  $db = $app.CurrentDb(); foreach ($q in $db.QueryDefs) { if ($q.Name -notlike '~*') { "  query: $($q.Name)" } }; $q = $null; $db = $null
  $o = $null
  CloseDb $app $f
}
catch { "FAILED: $_"; $_.ScriptStackTrace; throw }
finally {
  try { $app.Quit(2) } catch { }
  try { [void][Runtime.InteropServices.Marshal]::ReleaseComObject($app) } catch { }
  Start-Sleep -Seconds 4
  Get-Process MSACCESS -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
}
# Copied once Access has quit, so the file is whole and let go.
Copy-Item $f $dest -Force
Get-ChildItem $dest | ForEach-Object { "  $($_.Name) $($_.Length)" }
