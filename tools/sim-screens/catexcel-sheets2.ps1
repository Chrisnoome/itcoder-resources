# catexcel-sheets.ps1, part 2 (9 October 2026): the shots its first run lost
# or got wrong - (CAPS) Protect Sheet and Confirm Password; (IEB) New Window
# with the View tab open in the new window, Arrange All > Vertical; and,
# last (its first try tripped the input guard, which deletes the run's
# pictures), Home > Format > Move or Copy Sheet with Create a copy.
# No starter files here (catexcel-sheets.ps1 made them).
# Real Excel 365 screens for catexcel Grade 11, lesson 15: Working with
# sheets and windows (AIPascalCourse/content/catexcel/sheets.php - written to
# courses/cat-practical-writing.md, 9 October 2026, writer B). Ms Naidoo's
# Grade 11C mark book: sheets Term 1, Term 2 and Year. Home > Format > Move
# or Copy Sheet (the menu, the dialog, Create a copy); links on the Year
# sheet (='Term 1'!B4, ='Term 2'!B4); Freeze Panes at B4 (the View tab, its
# menu, the list scrolled down); (CAPS) Review > Protect Sheet, a password,
# Confirm Password; (IEB) New Window and Arrange All (Vertical), Split, and
# the Custom Views dialog. Also makes the pupils' starter file
# MarkBook11C.xlsx (and a done-right copy) in C:\sims\files\catexcel-sheets\
# and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel at the end.
# Crop: work/catexcel-sheets-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-sheets -TimeoutSec 1200   (from the host)
$Name = 'catexcel-sheets2'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11b-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

# Ms Naidoo's 11C (the lesson): 30 pupils, term 1 and term 2 marks.
$class = @(
  @('Thabo', 64, 68), @('Ayanda', 81, 77), @('Imran', 49, 56), @('Zanele', 50, 61), @('Gift', 38, 44), @('Chloe', 72, 70),
  @('Bongani', 55, 52), @('Fatima', 93, 95), @('Mpho', 45, 51), @('Tamsin', 67, 73), @('Sipho', 29, 41), @('Carmen', 58, 63),
  @('Kagiso', 62, 59), @('Naledi', 77, 80), @('Pieter', 54, 49), @('Refilwe', 88, 91), @('Yusuf', 47, 53), @('Busisiwe', 69, 66),
  @('Riaan', 51, 58), @('Palesa', 74, 79), @('Jason', 60, 57), @('Lungile', 43, 50), @('Ayesha', 71, 75), @('Ethan', 36, 42),
  @('Nandi', 83, 86), @('Sibusiso', 57, 62), @('Kavitha', 79, 74), @('Andile', 66, 70), @('Joanne', 52, 55), @('Thulani', 90, 88))

# 11B (the upload): 20 pupils.
$classB = @(
  @('Dineo', 72, 75), @('Owen', 58, 61), @('Hendrik', 64, 60), @('Mandla', 47, 55), @('Priya', 85, 88),
  @('Graham', 39, 46), @('Kagiso', 66, 70), @('Annelie', 91, 89), @('Sizwe', 53, 50), @('Fatima', 77, 82),
  @('Tumelo', 44, 49), @('Megan', 69, 73), @('Lindiwe', 58, 64), @('Musa', 81, 79), @('Chantel', 62, 58),
  @('Bheki', 35, 41), @('Nomsa', 74, 77), @('Dylan', 56, 63), @('Zinhle', 88, 92), @('Karabo', 60, 66))

function Heads ($ws, $range) {
  $ws.Range($range).Font.Bold = $true
  try { $ws.Range($range).Interior.Color = 0xF2E6D9 } catch { }
}

function TermSheet ($ws, $title, $rows, [int]$col) {
  $ws.Range('A1').Formula = $title
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill11 $ws @(,@('Name', 'Mark (%)')) 3
  for ($i = 0; $i -lt $rows.Count; $i++) { $ws.Range("A$($i + 4)").Formula = [string]$rows[$i][0]; $ws.Range("B$($i + 4)").Formula = [string]$rows[$i][$col] }
  Heads $ws 'A3:B3'
  $ws.Columns.Item('A').ColumnWidth = 14; $ws.Columns.Item('B').ColumnWidth = 11
}

function YearSheet ($ws, $title, $rows) {
  $ws.Range('A1').Formula = $title
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill11 $ws @(,@('Name', 'Term 1', 'Term 2', 'Average')) 3
  for ($i = 0; $i -lt $rows.Count; $i++) { $ws.Range("A$($i + 4)").Formula = [string]$rows[$i][0] }
  Heads $ws 'A3:D3'
  $ws.Columns.Item('A').ColumnWidth = 14
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 10 }
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # The starter's cloud copy got a new name (the class is 11B): MarkBook11C.xlsx -> MarkBook11B.xlsx.
  try { $old = Join-Path $cloudDir 'MarkBook11C.xlsx'; if (Test-Path $old) { Move-Item $old (Join-Path $cloudDir 'MarkBook11B.xlsx') -Force; 'cloud copy renamed MarkBook11B.xlsx' } } catch { "cloud rename: $_" }
  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 3) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $w1 = $wb.Worksheets.Item(1); $w1.Name = 'Term 1'
  $w2 = $wb.Worksheets.Item(2); $w2.Name = 'Term 2'
  $wy = $wb.Worksheets.Item(3); $wy.Name = 'Year'
  TermSheet $w1 'Grade 11C CAT - term 1' $class 1
  TermSheet $w2 'Grade 11C CAT - term 2' $class 2
  YearSheet $wy 'Grade 11C CAT - the year so far' $class
  $saved = Join-Path $env:TEMP '11C marks.xlsx'
  Remove-Item $saved -ErrorAction SilentlyContinue
  $wb.SaveAs($saved, 51)                                            # a name for the window titles (New Window: 11C marks.xlsx:2)
  $null = $w2.Activate()
  $null = $w2.Range('D5').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  foreach ($tab in 'Home', 'View', 'Review') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  foreach ($s in 'Term 1', 'Term 2', 'Year') { TryMark ('sheet' + ($s -replace ' ', '')) $root @($s) $T::TabItem }
  Dump 'home'

  
  # 1. CAPS: Review > Protect Sheet (Term 1), a password, Confirm Password.
  try {
    $null = $w1.Activate()
    $null = $w1.Range('D5').Select()
    Tab 'Review'
    foreach ($nm in 'Protect Sheet...', 'Protect Sheet', 'Protect Workbook...', 'Unprotect Sheet...') { TryMark ('btn' + ($nm -replace '[ .]', '')) $root @($nm) }
    SnapAll 'p-1'                                                   # the Review tab
    PressAsync (Find $root @('Protect Sheet...', 'Protect Sheet') -tries 6)
    WaitOthers 1 30
    DumpOthers 'protect'
    SnapAll 'p-2' -Others                                           # the Protect Sheet dialog
    $dlg = FirstOther
    if ($dlg -ne [IntPtr]::Zero) {
      DlgChars $dlg '11C-cat'
      SnapAll 'p-3' -Others                                         # the password typed (dots)
      [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 1500
      DumpOthers 'confirm'
      SnapAll 'p-4' -Others                                         # Confirm Password
      $dlg2 = FirstOther
      if ($dlg2 -ne [IntPtr]::Zero) { DlgChars $dlg2 '11C-cat'; [Comp11B]::Key($dlg2, 0x0D, $false); Start-Sleep -Milliseconds 1500 }
    }
  } catch { "protect: $_" }
  if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
  "protected: $($w1.ProtectContents)"
  if (-not $w1.ProtectContents) { $w1.Protect('11C-cat') }
  Start-Sleep -Milliseconds 800
  Tab 'Review'
  SnapAll 'p-5'                                                     # Unprotect Sheet on the ribbon now
  $w1.Unprotect('11C-cat')

  # 2. IEB: New Window (its View tab), Arrange All, Vertical, OK.
  $h2 = [IntPtr]::Zero
  try {
    $null = $w1.Range('D5').Select()
    Tab 'View'
    SnapAll 'w-1'                                                   # the View tab, Term 1
    Press (Find $root @('New Window') -tries 6)
    Start-Sleep -Milliseconds 2500
    $h2 = [IntPtr]$xl.ActiveWindow.Hwnd
    "  new window $h2, first $h"
    [Shot]::Place($h2, 40, 40, 1600, 800); Start-Sleep -Milliseconds 1200
    $root2 = $AE::FromHandle($h2)
    Press (Find $root2 @('View') $T::TabItem -tries 8); Start-Sleep -Milliseconds 1200
    [void][Comp11B]::Away($h)
    SnapAll 'w-2' -Others                                           # the new window, its View tab
    PressAsync (Find $root2 @('Arrange All') -tries 6)
    WaitOthers 2 30
    SnapAll 'w-3' -Others                                           # the Arrange Windows dialog
    $dlg = [IntPtr]::Zero
    foreach ($w in [Comp11B]::Others($h)) { if ($w -ne $h2) { $dlg = $w } }
    if ($dlg -ne [IntPtr]::Zero) {
      DlgKey $dlg 'V'
      SnapAll 'w-4' -Others                                         # Vertical chosen
      [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 2000
    }
    $xl.Windows.Arrange(-4166)
    Start-Sleep -Milliseconds 1500
    foreach ($w in $xl.Windows) { if ([IntPtr]$w.Hwnd -eq $h2) { $null = $w.Activate(); $null = $wb.Worksheets.Item('Year').Activate() } }
    Start-Sleep -Milliseconds 800
    [void][Comp11B]::Away($h)
    $r1 = [Comp11B]::Rect($h); $r2 = [Comp11B]::Rect($h2)
    $left = [Math]::Min($r1[0], $r2[0]); $top = [Math]::Min($r1[1], $r2[1])
    $right = [Math]::Max($r1[0] + $r1[2], $r2[0] + $r2[2]); $bottom = [Math]::Max($r1[1] + $r1[3], $r2[1] + $r2[3])
    Guard
    Start-Sleep -Milliseconds 1000
    [void][Comp11B]::SaveArea($h, (Join-Path $out "$Name-w-5.png"), $left, $top, ($right - $left), ($bottom - $top))
    Guard
    'picture w-5 (the two windows side by side)'
  } catch { "new window: $_" }
  try { foreach ($w in @($xl.Windows)) { if ([IntPtr]$w.Hwnd -eq $h2) { $null = $w.Close() } } } catch { "close window 2: $_" }
  Start-Sleep -Milliseconds 1000
  "windows left: $($xl.Windows.Count), main still $($xl.Windows.Item(1).Hwnd) = $h"
  $xl.WindowState = -4143
  [Shot]::Place($h, 40, 40, 1600, 800); Start-Sleep -Milliseconds 1500
  if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }

  # 3. Copy a sheet (last): Home > Cells > Format > Move or Copy Sheet..., Create a copy, OK.
  $null = $w2.Activate()
  $null = $w2.Range('D5').Select()
  Tab 'Home'
  TryMark 'btnFormat' $root @('Format') $T::MenuItem
  SnapAll 'h-1'                                                     # Term 2, the Home tab
  try {
    $fmt = Find $root @('Format') $T::MenuItem -tries 6
    Expand $fmt; WaitOthers
    MarkAny 'itemMoveCopy' @('Move or Copy Sheet...', 'Move or Copy Sheet')
    SnapAll 'h-2' -Others                                           # the Format menu open
    PressAsync (FindAny @('Move or Copy Sheet...', 'Move or Copy Sheet') -tries 6)
    WaitOthers 1 30
    DumpOthers 'movecopy'
    SnapAll 'h-3' -Others                                           # the Move or Copy dialog
    $dlg = FirstOther
    if ($dlg -ne [IntPtr]::Zero) {
      DlgKey $dlg 'C'                                               # Alt+C: Create a copy
      SnapAll 'h-4' -Others                                         # Create a copy ticked
      [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 1500
    }
  } catch { "move or copy: $_" }
  if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
  "sheets after the dialog: $(($wb.Worksheets | ForEach-Object { $_.Name }) -join ', ')"

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
