# Real Excel 365 screens for catexcel Grade 12, An exam-style task
# (AIPascalCourse/content/catexcel/scenario.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# Fun Day: a starter workbook with a numbered task list, as Paper 1 gives
# one. The screens: the starter (the Stalls and Prices sheets and the
# Summary), a lookup copied down without $ signs and its #N/A, the
# Formulas tab's Formula Auditing group - Trace Precedents (the blue arrows
# and the box round the table), Remove Arrows, Error Checking and the
# Evaluate Formula box - and the fixed sheet with Show Formulas. Also makes
# the pupils' starter file FunDay.xlsx (and a done-right copy) in
# C:\sims\files\catexcel-scenario\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-scenario -TimeoutSec 1200   (from the host)
$Name = 'catexcel-scenario'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Heads ($ws, $range) {
  $ws.Range($range).Font.Bold = $true
  try { $ws.Range($range).Interior.Color = 0xF2E6D9 } catch { }
}

$items = @(@('BW', 'Boerewors roll', 35), @('CC', 'Cupcake', 12), @('CD', 'Cooldrink', 15), @('FF', 'Face painting', 20),
           @('IL', 'Ice lolly', 8), @('KS', 'Koeksister', 10), @('LD', 'Lucky dip', 5), @('PC', 'Popcorn', 10))

# Stall code: class, a dash, the item code, a dash, a number. Qty sold.
function FunBook ($book, $stalls, [string]$funDay, [string]$today) {
  while ($book.Worksheets.Count -lt 3) { $null = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count)) }
  $ws = $book.Worksheets.Item(1); $ws.Name = 'Stalls'
  $wp = $book.Worksheets.Item(2); $wp.Name = 'Prices'
  $wm = $book.Worksheets.Item(3); $wm.Name = 'Summary'
  Fill12 $wp @(,@('Code', 'Item', 'Price (R)')) 1
  Fill12 $wp $items 2
  Heads $wp 'A1:C1'
  $wp.Columns.Item('A').ColumnWidth = 7; $wp.Columns.Item('B').ColumnWidth = 15; $wp.Columns.Item('C').ColumnWidth = 10
  $ws.Range('A1').Formula = 'Phumlani Fun Day 2026 - stalls'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill12 $ws @(,@('Stall code', 'Class', 'Item code', 'Qty sold', 'Price (R)', 'Amount (R)', 'Award')) 3
  $r = 4
  foreach ($s in $stalls) { $ws.Range("A$r").Formula = $s[0]; $ws.Range("D$r").Formula = [string]$s[1]; $r++ }
  Heads $ws 'A3:G3'
  $ws.Columns.Item('A').ColumnWidth = 13
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 9 }
  foreach ($c in 'E', 'F') { $ws.Columns.Item($c).ColumnWidth = 11 }
  $ws.Columns.Item('G').ColumnWidth = 9
  $wm.Range('A1').Formula = 'Fun Day summary'; $wm.Range('A1').Font.Bold = $true; $wm.Range('A1').Font.Size = 14
  Fill12 $wm @(@('Fun Day', $funDay), @('Today', $today), @('Days to go', ''), @('Class', '12A'), @('Takings for the class (R)', ''),
               @('Gold stalls', ''), @('Total takings (R)', ''), @('Cash boxes (R2 000 each)', '')) 3
  $wm.Range('B3:B4').NumberFormat = 'yyyy/mm/dd'
  $wm.Range('A3:A10').Font.Bold = $true
  $wm.Columns.Item('A').ColumnWidth = 26; $wm.Columns.Item('B').ColumnWidth = 12
  return $ws
}

$stallsA = @(@('12A-BW-01', 64), @('12B-CC-01', 85), @('12C-CD-01', 120), @('12A-FF-01', 30), @('11A-IL-01', 140), @('12B-KS-01', 75),
             @('12C-LD-01', 96), @('12A-PC-01', 110), @('11B-BW-02', 52), @('12B-CD-02', 70), @('12A-CC-02', 40), @('12C-FF-02', 22))
$stallsB = @(@('12A-BW-01', 72), @('12B-CC-01', 90), @('12C-CD-01', 135), @('12D-FF-01', 28), @('11A-IL-01', 150), @('12A-KS-01', 66),
             @('12B-LD-01', 104), @('12C-PC-01', 98), @('11B-BW-02', 48), @('12D-CD-02', 77), @('12A-CC-02', 55), @('12B-FF-02', 31),
             @('12C-IL-02', 112), @('12D-KS-02', 59), @('11A-LD-02', 83), @('12A-PC-02', 120), @('12B-BW-03', 61), @('12C-CC-03', 47),
             @('12D-CD-03', 92), @('12A-FF-03', 35))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = FunBook $sb $stallsB '2026/11/14' '2026/10/30'
  $sm = $sb.Worksheets.Item('Summary')
  # The starter's E4: a price lookup someone copied down without $ signs (task 9.2 fixes it).
  for ($r = 4; $r -le 23; $r++) { $ss.Range("E$r").Formula2 = "=VLOOKUP(C$r,Prices!A$($r - 2):C$($r + 5),3,FALSE)" }
  $null = $ss.Activate(); $null = $ss.Range('A1').Select()
  SaveStarter $sb 'FunDay.xlsx'
  for ($r = 4; $r -le 23; $r++) {
    $ss.Range("B$r").Formula2 = "=LEFT(A$r,3)"
    $ss.Range("C$r").Formula2 = "=MID(A$r,5,2)"
    $ss.Range("E$r").Formula2 = "=VLOOKUP(C$r,Prices!`$A`$2:`$C`$9,3,FALSE)"
    $ss.Range("F$r").Formula2 = "=D$r*E$r"
    $ss.Range("G$r").Formula2 = "=IF(F$r>=1500,""Gold"",IF(F$r>=750,""Silver"",""Bronze""))"
  }
  $sm.Range('B5').Formula2 = '=DAYS(B3,B4)'
  $sm.Range('B7').Formula2 = '=SUMIF(Stalls!B4:B23,B6,Stalls!F4:F23)'
  $sm.Range('B8').Formula2 = '=COUNTIF(Stalls!G4:G23,"Gold")'
  $sm.Range('B9').Formula2 = '=SUM(Stalls!F4:F23)'
  $sm.Range('B10').Formula2 = '=ROUNDUP(B9/2000,0)'
  $sb.SaveAs((Join-Path $filesDir 'FunDay-done.xlsx'), 51)
  foreach ($r in 4..23) { "  done $($r): $($ss.Range("A$r").Text) $($ss.Range("B$r").Text) $($ss.Range("C$r").Text) $($ss.Range("D$r").Text) $($ss.Range("E$r").Text) $($ss.Range("F$r").Text) $($ss.Range("G$r").Text)" }
  foreach ($r in 5, 7, 8, 9, 10) { "  done summary B$($r): $($sm.Range("B$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = FunBook $wb $stallsA '2026/11/14' '2026/10/09'
  for ($r = 4; $r -le 15; $r++) {
    $ws.Range("B$r").Formula2 = "=LEFT(A$r,3)"
    $ws.Range("C$r").Formula2 = "=MID(A$r,5,2)"
    $ws.Range("E$r").Formula2 = "=VLOOKUP(C$r,Prices!A$($r - 2):C$($r + 5),3,FALSE)"
    $ws.Range("F$r").Formula2 = "=D$r*E$r"
  }
  $null = $ws.Activate()
  $null = $ws.Range('I4').Select()
  ShowExcel 1860 820 10
  $root = $AE::FromHandle($h)
  MarkCells $ws @('E4', 'E11', 'E12', 'E15', 'I4', 'C12')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }

  SnapAll 't-0'                                                     # the stalls: E12 onwards shows #N/A
  "prices: $((4..15 | ForEach-Object { $ws.Range("E$_").Text }) -join ', ')"
  $null = $ws.Range('E12').Select()
  SnapAll 't-1'                                                     # E12 (#N/A) clicked: the formula in the Formula Bar
  Tab 'Formulas'
  Dump 'formulas'
  foreach ($nm in 'Trace Precedents', 'Trace Dependents', 'Remove Arrows', 'Show Formulas', 'Error Checking', 'Evaluate Formula', 'Evaluate Formula...') { TryMark ('btn' + ($nm -replace '[ .]', '')) $root @($nm) }
  SnapAll 't-2'                                                     # the Formulas tab, E12
  try { Press (Find $root @('Trace Precedents') -tries 6); Start-Sleep -Milliseconds 1500 } catch { "trace: $_"; $null = $ws.Range('E12').ShowPrecedents() }
  [void][Comp12]::Away($h)
  SnapAll 't-3'                                                     # the arrows: C12, and a table icon for the Prices sheet
  try { Press (Find $root @('Remove Arrows') -tries 6); Start-Sleep -Milliseconds 800 } catch { $ws.ClearArrows() }
  # Evaluate Formula
  try {
    PressAsync (Find $root @('Evaluate Formula', 'Evaluate Formula...') -tries 6)
    WaitOthers
    DumpOthers 'evaldlg'
    MarkAny 'evEvaluate' @('Evaluate') $T::Button
    SnapAll 'e-1' -Others                                           # Evaluate Formula: the formula, C12 underlined
    try { Press (FindAny @('Evaluate') $T::Button -tries 6); Start-Sleep -Milliseconds 900 } catch { "evaluate press: $_" }
    SnapAll 'e-2' -Others                                           # C12 replaced by "BW"
    try { Press (FindAny @('Evaluate') $T::Button -tries 6); Start-Sleep -Milliseconds 900 } catch { }
    SnapAll 'e-3' -Others                                           # the table part evaluated
    try { Press (FindAny @('Evaluate') $T::Button -tries 6); Start-Sleep -Milliseconds 900 } catch { }
    SnapAll 'e-4' -Others                                           # #N/A
    CloseOthers
  } catch { "evaluate formula: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  # Fix: E4 with $ signs, copied down.
  $null = $ws.Range('E4').Select()
  SnapAll 'f-1'                                                     # E4 clicked (Formulas tab)
  $ws.Range('E4').Formula2 = '=VLOOKUP(C4,Prices!$A$2:$C$9,3,FALSE)'
  $null = $ws.Range('E4').AutoFill($ws.Range('E4:E15'), 0)
  $null = $ws.Range('E4:E15').Select()
  SnapAll 'f-2'                                                     # every price
  "fixed prices: $((4..15 | ForEach-Object { $ws.Range("E$_").Text }) -join ', ')"
  for ($r = 4; $r -le 15; $r++) { $ws.Range("G$r").Formula2 = "=IF(F$r>=1500,""Gold"",IF(F$r>=750,""Silver"",""Bronze""))" }
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  $null = $ws.Range('E4').Select()
  SnapAll 'f-3'                                                     # Show Formulas: every formula on the sheet
  $xl.ActiveWindow.DisplayFormulas = $false
  "awards: $((4..15 | ForEach-Object { $ws.Range("F$_").Text + ' ' + $ws.Range("G$_").Text }) -join ', ')"
  Tab 'Home'
  # the Summary sheet, done
  $wm = $wb.Worksheets.Item('Summary')
  $wm.Range('B5').Formula2 = '=DAYS(B3,B4)'
  $wm.Range('B7').Formula2 = '=SUMIF(Stalls!B4:B15,B6,Stalls!F4:F15)'
  $wm.Range('B8').Formula2 = '=COUNTIF(Stalls!G4:G15,"Gold")'
  $wm.Range('B9').Formula2 = '=SUM(Stalls!F4:F15)'
  $wm.Range('B10').Formula2 = '=ROUNDUP(B9/2000,0)'
  $null = $wm.Activate(); $null = $wm.Range('D3').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'f-4'                                                     # the summary
  foreach ($r in 5, 7, 8, 9, 10) { "  summary B$($r): $($wm.Range("B$r").Text)" }

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
