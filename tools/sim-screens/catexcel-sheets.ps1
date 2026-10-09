# Real Excel 365 screens for catexcel Grade 11, lesson 15: Working with
# sheets and windows (AIPascalCourse/content/catexcel/sheets.php - written to
# courses/cat-practical-writing.md, 9 October 2026, writer B). Ms Naidoo's
# Grade 11C mark book: sheets Term 1, Term 2 and Year. Home > Format > Move
# or Copy Sheet (the menu, the dialog, Create a copy); links on the Year
# sheet (='Term 1'!B4, ='Term 2'!B4); Freeze Panes at B4 (the View tab, its
# menu, the list scrolled down); (CAPS) Review > Protect Sheet, a password,
# Confirm Password; (IEB) New Window and Arrange All (Vertical), Split, and
# the Custom Views dialog. Also makes the pupils' starter file
# MarkBook11B.xlsx (and a done-right copy) in C:\sims\files\catexcel-sheets\
# and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel at the end.
# Crop: work/catexcel-sheets-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-sheets -TimeoutSec 1200   (from the host)
$Name = 'catexcel-sheets'
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

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  while ($sb.Worksheets.Count -lt 4) { $null = $sb.Worksheets.Add([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count)) }
  $t1 = $sb.Worksheets.Item(1); $t1.Name = 'Term 1'
  $t2 = $sb.Worksheets.Item(2); $t2.Name = 'Term 2'
  $yr = $sb.Worksheets.Item(3); $yr.Name = 'Year'
  $sb.Worksheets.Item(4).Name = 'Sheet3'
  TermSheet $t1 'Grade 11B CAT - term 1' $classB 1
  TermSheet $t2 'Grade 11B CAT - term 2' $classB 2
  YearSheet $yr 'Grade 11B CAT - the year so far' $classB
  $null = $t1.Activate(); $null = $t1.Range('A1').Select()
  SaveStarter $sb 'MarkBook11B.xlsx'
  "starter sheets: $(($sb.Worksheets | ForEach-Object { $_.Name }) -join ', ')"
  $sb.Worksheets.Item('Sheet3').Delete()
  $t3 = $sb.Worksheets.Add([Type]::Missing, $t2); $t3.Name = 'Term 3'
  for ($r = 4; $r -le 23; $r++) {
    $yr.Range("B$r").Formula2 = "='Term 1'!B$r"
    $yr.Range("C$r").Formula2 = "='Term 2'!B$r"
    $yr.Range("D$r").Formula2 = "=AVERAGE(B$($r):C$($r))"
  }
  $yr.Range('D4:D23').NumberFormat = '0.0'
  $null = $yr.Activate(); $null = $yr.Range('B4').Select()
  $xl.ActiveWindow.FreezePanes = $true
  $sb.SaveAs((Join-Path $filesDir 'MarkBook11B-done.xlsx'), 51)
  "done sheets: $(($sb.Worksheets | ForEach-Object { $_.Name }) -join ', '); Year B4 $($yr.Range('B4').Formula) = $($yr.Range('B4').Text), C23 $($yr.Range('C23').Formula) = $($yr.Range('C23').Text), D4 $($yr.Range('D4').Text)"
  $sb.Close($false); $sb = $null

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

  # 1. Copy a sheet: Home > Cells > Format > Move or Copy Sheet..., Create a copy, OK.
  TryMark 'btnFormat' $root @('Format') $T::MenuItem
  SnapAll 'h-1'                                                     # Term 2, the Home tab
  try {
    $fmt = Find $root @('Format') $T::MenuItem -tries 6
    Expand $fmt; WaitOthers
    DumpOthers 'formatmenu'
    MarkAny 'itemMoveCopy' @('Move or Copy Sheet...', 'Move or Copy Sheet')
    MarkAny 'itemRename' @('Rename Sheet')
    MarkAny 'itemTabColor' @('Tab Color')
    MarkAny 'itemProtect' @('Protect Sheet...')
    MarkAny 'itemLock' @('Lock Cell')
    SnapAll 'h-2' -Others                                           # the Format menu open
    PressAsync (FindAny @('Move or Copy Sheet...', 'Move or Copy Sheet') -tries 6)
    WaitOthers 1 30
    DumpOthers 'movecopy'
    SnapAll 'h-3' -Others                                           # the Move or Copy dialog
    $dlg = FirstOther
    "  dialog: $([Comp11B]::Describe($h))"
    if ($dlg -ne [IntPtr]::Zero) {
      DlgKey $dlg 'C'                                               # Alt+C: Create a copy
      SnapAll 'h-4' -Others                                         # Create a copy ticked?
      [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 1500    # Enter: OK
    }
  } catch { "move or copy: $_" }
  if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
  "sheets after the dialog: $(($wb.Worksheets | ForEach-Object { $_.Name }) -join ', ')"
  if ($wb.Worksheets.Count -lt 4) { $w2.Copy($w2); "copied through COM" }      # Before Term 2, as the dialog's first choice
  Start-Sleep -Milliseconds 800
  foreach ($ws in $wb.Worksheets) { if ($ws.Name -like 'Term 2 (*') { TryMark 'sheetCopy' $root @($ws.Name) $T::TabItem } }
  SnapAll 'h-5'                                                     # the copy, Term 2 (2)
  foreach ($ws in @($wb.Worksheets)) { if ($ws.Name -like 'Term 2 (*') { $ws.Delete() } }

  # 2. Links on the Year sheet.
  $null = $wy.Activate()
  $null = $wy.Range('F5').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wy @('B4', 'C4', 'F5', 'B4:B33') 'y'
  MarkHandle $wy 'B4' 'yfillB4'
  SnapAll 'l-1'                                                     # Year, F5 active
  $null = $wy.Range('B4').Select(); SnapAll 'l-2'                   # B4 clicked
  $wy.Range('B4').Formula2 = "='Term 1'!B4"
  $null = $wy.Range('B5').Select(); SnapAll 'l-3'                   # 64; B5 active
  $null = $wy.Range('C4').Select(); SnapAll 'l-4'                   # C4 clicked
  $wy.Range('C4').Formula2 = "='Term 2'!B4"
  $null = $wy.Range('C5').Select(); SnapAll 'l-5'                   # 68; C5 active
  for ($r = 4; $r -le 33; $r++) {
    $wy.Range("B$r").Formula2 = "='Term 1'!B$r"
    $wy.Range("C$r").Formula2 = "='Term 2'!B$r"
    $wy.Range("D$r").Formula2 = "=AVERAGE(B$($r):C$($r))"
  }
  $wy.Range('D4:D33').NumberFormat = '0.0'
  $null = $wy.Range('B4').Select(); SnapAll 'l-6'                   # everything linked; the formula bar shows ='Term 1'!B4
  $w1.Range('B4').Formula = '70'                                    # a link updates: Thabo's term 1 mark corrected
  Start-Sleep -Milliseconds 600
  SnapAll 'l-7'                                                     # B4 shows 70
  $w1.Range('B4').Formula = '64'

  # 3. Freeze Panes at B4 on Term 1.
  $null = $w1.Activate()
  $null = $w1.Range('D5').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $w1 @('B4', 'A4') 't'
  SnapAll 'z-0'                                                     # Term 1, D5 active
  $null = $w1.Range('B4').Select(); SnapAll 'z-1'                   # B4 clicked
  try {
    Tab 'View'
    Dump 'view'
    foreach ($nm in 'Freeze Panes', 'New Window', 'Arrange All', 'Split', 'Hide', 'Unhide...', 'Switch Windows', 'Custom Views...', 'Custom Views', 'Gridlines', 'Headings') { TryMark ('btn' + ($nm -replace '[ .]', '')) $root @($nm) }
    SnapAll 'z-2'                                                   # the View tab
    $fp = Find $root @('Freeze Panes') -tries 6
    Expand $fp; WaitOthers
    DumpOthers 'freezemenu'
    MarkAny 'itemFreezePanes' @('Freeze Panes') $T::MenuItem
    MarkAny 'itemFreezeTopRow' @('Freeze Top Row')
    MarkAny 'itemFreezeFirstColumn' @('Freeze First Column')
    SnapAll 'z-3' -Others                                           # the Freeze Panes menu
    Collapse $fp
    if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "freeze menu: $_"; if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $w1.Range('B4').Select()
  $xl.ActiveWindow.FreezePanes = $true
  $xl.ActiveWindow.ScrollRow = 20
  Start-Sleep -Milliseconds 800
  SnapAll 'z-4'                                                     # scrolled down: rows 1-3 stay
  try {                                                             # a fact for the lesson: Split while frozen
    Press (Find $root @('Split') -tries 6); Start-Sleep -Milliseconds 1200
    "after Split while frozen: FreezePanes $($xl.ActiveWindow.FreezePanes), Split $($xl.ActiveWindow.Split)"
    SnapAll 'z-5'
    $xl.ActiveWindow.Split = $false
  } catch { "split while frozen: $_" }
  $xl.ActiveWindow.FreezePanes = $false
  $xl.ActiveWindow.ScrollRow = 1

  # 4. IEB: Split, Custom Views, New Window and Arrange All.
  try {
    $null = $w1.Range('A1').Select()
    $xl.ActiveWindow.SplitRow = 12
    $xl.ActiveWindow.ScrollRow = 1
    Start-Sleep -Milliseconds 800
    SnapAll 'sp-1'                                                  # split into two panes
    $xl.ActiveWindow.Split = $false
    Start-Sleep -Milliseconds 600
  } catch { "split: $_" }
  try {
    PressAsync (Find $root @('Custom Views...', 'Custom Views') -tries 6)
    WaitOthers 1 30
    DumpOthers 'customviews'
    SnapAll 'cv-1' -Others                                          # the Custom Views dialog
  } catch { "custom views: $_" }
  if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
  try {
    $null = $w1.Range('D5').Select()
    SnapAll 'w-1'                                                   # the View tab, Term 1
    Press (Find $root @('New Window') -tries 6)
    Start-Sleep -Milliseconds 2500
    "windows: $($xl.Windows.Count); $([Comp11B]::Describe($h))"
    $h2 = [IntPtr]$xl.ActiveWindow.Hwnd
    "  new window $h2, first $h"
    [Shot]::Place($h2, 40, 40, 1600, 800); Start-Sleep -Milliseconds 1200
    [void][Comp11B]::Away($h)
    SnapAll 'w-2' -Others                                           # the new window over the first
    $root2 = $AE::FromHandle($h2)
    try { PressAsync (Find $root2 @('Arrange All') -tries 6) } catch { PressAsync (FindAny @('Arrange All') -tries 6) }
    WaitOthers 2 30
    DumpOthers 'arrange'
    SnapAll 'w-3' -Others                                           # the Arrange Windows dialog
    $dlg = [IntPtr]::Zero
    foreach ($w in [Comp11B]::Others($h)) { if ($w -ne $h2) { $dlg = $w } }
    if ($dlg -ne [IntPtr]::Zero) {
      DlgKey $dlg 'V'                                               # Alt+V: Vertical
      SnapAll 'w-4' -Others
      [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 2000
    }
    if (@([Comp11B]::Others($h)).Count -gt 1) { CloseOthers }
    $xl.Windows.Arrange(-4166)                                      # xlArrangeStyleVertical (again, in case the dialog was not driven)
    Start-Sleep -Milliseconds 1500
    foreach ($w in $xl.Windows) { "  window $($w.Caption): $($w.Left),$($w.Top) $($w.Width)x$($w.Height)" }
    $null = $xl.Windows.Item(2).Activate()
    $null = $wb.Worksheets.Item('Year').Activate()
    Start-Sleep -Milliseconds 800
    [void][Comp11B]::Away($h)
    $r1 = [Comp11B]::Rect($h); $r2 = [Comp11B]::Rect($h2)
    $left = [Math]::Min($r1[0], $r2[0]); $top = [Math]::Min($r1[1], $r2[1])
    $right = [Math]::Max($r1[0] + $r1[2], $r2[0] + $r2[2]); $bottom = [Math]::Max($r1[1] + $r1[3], $r2[1] + $r2[3])
    "  area $left,$top to $right,$bottom"
    Guard
    Start-Sleep -Milliseconds 1000
    [void][Comp11B]::SaveArea($h, (Join-Path $out "$Name-w-5.png"), $left, $top, ($right - $left), ($bottom - $top))
    Guard
    'picture w-5 (the two windows side by side)'
    $xl.Windows.Item(2).Close()
    Start-Sleep -Milliseconds 1000
    $null = $wb.Windows.Item(1).Activate()
    $xl.WindowState = -4143
    [Shot]::Place($h, 40, 40, 1600, 800); Start-Sleep -Milliseconds 1500
  } catch { "new window: $_"; if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers } }

  # 5. CAPS: Review > Protect Sheet (Term 1), a password, Confirm Password.
  try {
    $null = $w1.Activate()
    $null = $w1.Range('D5').Select()
    Tab 'Review'
    Dump 'review'
    foreach ($nm in 'Protect Sheet...', 'Protect Sheet', 'Protect Workbook...', 'Allow Edit Ranges...', 'Unprotect Sheet...') { TryMark ('btn' + ($nm -replace '[ .]', '')) $root @($nm) }
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
  SnapAll 'p-5'                                                     # Unprotect Sheet on the ribbon now
  $w1.Unprotect('11C-cat')

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
