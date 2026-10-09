# Real Access 365 screens for catdb Grade 12 lesson 15, Related tables, subforms and a
# main form (AIPascalCourse/content/catdb/mainform.php - courses/cat-practical-writing.md,
# 9 October 2026). The Kasi Netball League: the Database Tools tab, the Relationships
# window before and after (the 1 and infinity of an enforced relationship), a join query
# in Design View and its answer, a team form with its players in a subform, and a main
# form with buttons (a switchboard). Also makes the starter League.accdb and a done-right
# copy in C:\sims\files\catdb-mainform\ and G:\My Drive\CAT\Access\, with Access's answers.
#     pwsh -File vm-shots.ps1 catdb-mainform            (from the host)
$Name = 'catdb-mainform'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data12.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'League.accdb'
$done = Join-Path $work 'League-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-League $app $done -Done
  $answers = [ordered]@{ 'League-done.accdb' = (QueryAnswers $app.CurrentDb()) }
  CloseDb $app $done
  Build-League $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force
  ($answers | ConvertTo-Json -Depth 6) | Set-Content "C:\sims\files\$Name\answers.json" -Encoding utf8

  # The pictures' database, forms and all, made while Access is hidden: CreateForm in the
  # visible Access after the Relationships window crashed it twice (9 October 2026).
  $shots = Join-Path $work 'LeagueShots.accdb'
  Build-League $app $shots -Done -Forms
  CloseDb $app $shots; $app.OpenCurrentDatabase($shots)    # a third CreateForm in one session crashed Access
  MakeMenuForm $app 'frmMain' 'Kasi Netball League' @(@('Teams and players', 'frmTeams'), @('All players', 'frmPlayers'), @('Top scorers', 'qryTopScorers'))
  CloseDb $app $shots; $app.OpenCurrentDatabase($shots)
  AddSubform $app 'frmTeams' 'frmPlayers' 'TeamID'
  CloseDb $app $shots

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $root = $AE::FromHandle($h)

  # 1. Before: the Relationships window of the starter (no lines).
  $before = Join-Path $work 'LeagueShots0.accdb'
  Build-League $app $before
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1000
  Press (Find $root @('Database Tools') $T::TabItem)
  Start-Sleep -Milliseconds 900
  TryMark 'Relationships' $root @('Relationships') $T::Button
  SnapDb 'm-0'
  try {
    Press (Find $root @('Relationships') $T::Button)
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    Dump 'relempty'
    foreach ($k in 'Add Tables', 'Show Table', 'Edit Relationships', 'All Relationships', 'Close') { TryMark "rel $k" $root @($k) }
    SnapDb 'm-1'
    try { $app.DoCmd.Close(-1, '', 2) } catch { }
  } catch { "  relationships (before): $_" }
  CloseDb $app $before

  # 2. After: the relationship, the join query, the subform, the main form.
  $app.OpenCurrentDatabase($shots)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1000
  try {
    Press (Find $root @('Database Tools') $T::TabItem)
    Start-Sleep -Milliseconds 700
    Press (Find $root @('Relationships') $T::Button)
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    try { Press (Find $root @('All Relationships') -tries 6); Start-Sleep -Milliseconds 1200 } catch { }
    Dump 'relations'
    SnapDb 'm-2'
    try { $app.DoCmd.Close(-1, '', 2) } catch { }
  } catch { "  relationships (after): $_" }
  Start-Sleep -Milliseconds 800

  $app.DoCmd.OpenQuery('qryTopScorers', 1); Start-Sleep -Milliseconds 1500; SnapDb 'm-3'; $app.DoCmd.Close(1, 'qryTopScorers', 2)
  $app.DoCmd.OpenQuery('qryTopScorers'); Start-Sleep -Milliseconds 1500; NoFieldList; SnapDb 'm-3r'; $app.DoCmd.Close(1, 'qryTopScorers', 2)

  $app.DoCmd.OpenForm('frmTeams'); Start-Sleep -Milliseconds 2000; Dump 'subform'; SnapDb 'm-4'; $app.DoCmd.Close(2, 'frmTeams', 2)
  $app.DoCmd.OpenForm('frmTeams', 1); Start-Sleep -Milliseconds 2000; SnapDb 'm-5'; $app.DoCmd.Close(2, 'frmTeams', 2)
  $app.DoCmd.OpenForm('frmMain'); Start-Sleep -Milliseconds 1500; SnapDb 'm-6'; $app.DoCmd.Close(2, 'frmMain', 2)
  $app.DoCmd.OpenForm('frmMain', 1); Start-Sleep -Milliseconds 1500
  foreach ($k in 'Button', 'Use Control Wizards', 'Controls') { TryMark "design $k" $root @($k) }
  SnapDb 'm-7'; $app.DoCmd.Close(2, 'frmMain', 2)

  # 3. File > Options > Current Database (Display Form) is a dialog: its place, not a picture.
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
