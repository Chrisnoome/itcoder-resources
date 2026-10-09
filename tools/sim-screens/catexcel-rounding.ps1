# Real Excel 365 screens for catexcel Grade 11, lesson 11: ROUND, POWER,
# LARGE and SMALL (AIPascalCourse/content/catexcel/rounding.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Lerato's flat shares its
# bills three ways: two decimals shown (a total "out by 1c"), the real values
# (General), ROUND typed and filled down; Gogo Dlamini's fixed deposit with
# POWER; Ms Naidoo's Grade 11 test marks with LARGE and SMALL; a circular
# reference typed (the warning), the status bar, Formulas > Error Checking >
# Circular References, and the fix; Insert Function, the Function Arguments
# box and its Help link. Also makes the pupils' starter file Stokvel.xlsx (and
# a done-right copy) in C:\sims\files\catexcel-rounding\ and G:\My Drive\CAT\Excel\.
# Typing is posted to Excel's grid (work\catexcel11a-kit.ps1, Chars). Read
# office-kit.ps1's safety rules first. Crop: work/catexcel-rounding-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-rounding -TimeoutSec 1200   (from the host)
$Name = 'catexcel-rounding'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11a-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$bills = @(@('Electricity', 1000), @('Wi-Fi', 599), @('Water', 250), @('Groceries', 1420))
$testMarks = @(
  @('Sipho Ndlovu', 38), @('Lindiwe Zulu', 45), @('Gift Mahlangu', 29), @('Chloe Adams', 41),
  @('Imran Pillay', 47), @('Zanele Khumalo', 33), @('Owen Botha', 19), @('Fatima Patel', 44),
  @('Bongani Dlamini', 26), @('Ayanda Mokoena', 36), @('Tamsin Jacobs', 22), @('Kagiso Molefe', 40))
$members = @(
  @('Gogo Dlamini', 4800), @('Mrs Mokoena', 3600), @('Mr Zulu', 5200), @('Ms Khumalo', 2950),
  @('Mrs Pillay', 4100), @('Mr Nkosi', 3350), @('Mrs Venter', 6000), @('Ms Sithole', 2700),
  @('Mr Molefe', 4450), @('Mrs Radebe', 3920))

function Heading ($ws, $range) {
  try { $ws.Range($range).Style = 'Accent1' } catch { }
  $ws.Range($range).Font.Bold = $true
  $ws.Range($range).WrapText = $true
}
function Title ($ws, $text) {
  $ws.Range('A1').Formula = $text
  try { $ws.Range('A1').Style = 'Title' } catch { $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 16 }
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 3) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Shares'
  $wv = $wb.Worksheets.Item(2); $wv.Name = 'Savings'
  $wm = $wb.Worksheets.Item(3); $wm.Name = 'Marks'

  Title $ws 'Lerato''s flat - October bills'
  $ws.Range('A2').Formula = 'People sharing'; $ws.Range('B2').Formula = '3'
  FillAt $ws @(,@('Bill', 'Amount (R)', 'Each pays (R)')) 4
  FillAt $ws $bills 5
  $ws.Range('A10').Formula = 'Total'; $ws.Range('A10').Font.Bold = $true
  $ws.Range('B10').Formula = '=SUM(B5:B8)'
  $ws.Range('C10').Formula = '=SUM(C5:C8)'
  Heading $ws 'A4:C4'
  $ws.Range('B5:C10').NumberFormat = '0.00'
  $ws.Columns.Item('A').ColumnWidth = 16
  foreach ($c in 'B', 'C') { $ws.Columns.Item($c).ColumnWidth = 13 }
  $ws.Rows.Item(4).RowHeight = 33

  Title $wv 'Gogo Dlamini''s fixed deposit'
  FillAt $wv @(@('Amount put in (R)', 5000), @('Interest a year', '0.08'), @('Years', 3)) 3
  $wv.Range('A7').Formula = 'Amount at the end (R)'; $wv.Range('A7').Font.Bold = $true
  $wv.Range('B4').NumberFormat = '0%'
  $wv.Range('B3').NumberFormat = '0.00'; $wv.Range('B7').NumberFormat = '0.00'
  $wv.Columns.Item('A').ColumnWidth = 22; $wv.Columns.Item('B').ColumnWidth = 13

  Title $wm 'Grade 11 CAT - Test 2 (out of 50)'
  FillAt $wm @(,@('Name', 'Mark')) 3
  FillAt $wm $testMarks 4
  FillAt $wm @(@('Highest'), @('Second highest'), @('Second lowest'), @('Lowest')) 4 'D'
  $wm.Range('E4').Formula = '=MAX(B4:B15)'
  $wm.Range('E7').Formula = '=MIN(B4:B15)'
  Heading $wm 'A3:B3'
  $wm.Range('D3').Formula = 'Summary'; Heading $wm 'D3:E3'
  $wm.Columns.Item('A').ColumnWidth = 18; $wm.Columns.Item('B').ColumnWidth = 9
  $wm.Columns.Item('D').ColumnWidth = 16; $wm.Columns.Item('E').ColumnWidth = 9

  $null = $ws.Activate()
  $null = $ws.Range('F5').Select()
  ShowExcel
  foreach ($a in 'A1', 'B2', 'B10', 'C5', 'C6', 'C5:C8', 'C10', 'F5', 'D12') { Mark ('cell' + ($a -replace ':', '_')) (CellBox $ws $a) }
  Mark 'fillC5' (FillHandleBox $ws 'C5')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  TryMark 'nameBox'    $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  TryMark 'insertFn'   $root @('Insert Function')
  TryMark 'decDecimal' $root @('Decrease Decimal')
  TryMark 'incDecimal' $root @('Increase Decimal')
  TryMark 'search'     $root @('Search', 'Microsoft Search')
  Dump 'home'
  "grid: $grid"

  # 1. Formatting is not rounding: two decimals shown, the real values behind them.
  $ws.Range('C5:C8').Formula = '=B5/$B$2'
  $null = $ws.Range('C5').Select()
  SnapAll 'f-1'                                                     # 333.33 ...; C10 1089.67
  $ws.Range('C5:C10').NumberFormat = 'General'
  SnapAll 'f-2'                                                     # 333.3333333 ...; 1089.666667
  $ws.Range('C5:C10').NumberFormat = '0.00'
  $ws.Range('C5:C8').ClearContents()

  # 2. ROUND typed in C5, filled down.
  $null = $ws.Range('F5').Select()
  SnapAll 'r-1'
  $null = $ws.Range('C5').Select()
  SnapAll 'r-2'                                                     # C5 active
  TypeAndSnap '=ROUND(B5/$B$2,2)' 'r-2t'                            # typed; Enter
  if ($ws.Range('C5').Formula -ne '=ROUND(B5/$B$2,2)') { $ws.Range('C5').Formula = '=ROUND(B5/$B$2,2)'; "  (typed into C5 by COM)" }
  $null = $ws.Range('C5').Select()
  SnapAll 'r-3'                                                     # 333.33, selected
  $null = $ws.Range('C5').AutoFill($ws.Range('C5:C8'), 0)
  $null = $ws.Range('C6').Select()
  SnapAll 'r-4'                                                     # C6 =ROUND(B6/$B$2,2); C10 1089.66

  # 3. Circular reference: =SUM(B5:B10) typed in B10.
  $null = $ws.Range('B10').Select()
  SnapAll 'c-0'                                                     # B10 selected, =SUM(B5:B8)
  $xl.DisplayAlerts = $true                                         # the circular warning is an alert: off, it never shows
  TypeAndSnap '=SUM(B5:B10)' 'c-0t' -NoEnd
  [CompA]::Key($grid, 0x0D)
  WaitOthers 1 20
  FitDialogs
  DumpOthers 'circwarn'
  MarkAny 'warnOK' @('OK')
  MarkAny 'warnHelp' @('Help')
  SnapAll 'c-w' -Others                                             # the warning
  if (@([CompA]::Others($h)).Count -gt 0) { try { Press (FindAny @('OK') $T::Button -tries 4) } catch { "ok: $_"; CloseOthers } }
  Start-Sleep -Milliseconds 1200
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  $xl.DisplayAlerts = $false
  "B10 now: $($ws.Range('B10').Formula)"
  if ($ws.Range('B10').Formula -ne '=SUM(B5:B10)') { $ws.Range('B10').Formula = '=SUM(B5:B10)'; "  (circular by COM)" }
  $null = $ws.Range('D12').Select()
  Start-Sleep -Milliseconds 800
  TryMark 'statusCirc' $root @('Circular References B10', 'Circular References: B10', 'Circular References')
  SnapAll 'c-1'                                                     # the status bar: Circular References: B10
  try {
    Press (Find $root @('Formulas') $T::TabItem)
    Start-Sleep -Milliseconds 1000
    Dump 'formulas'
    TryMark 'errCheck' $root @('Error Checking...', 'Error Checking')
    TryMark 'showFormulas' $root @('Show Formulas')
    SnapAll 'c-2'                                                   # the Formulas tab
    $ec = $null
    foreach ($e in @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Error Checking...'))))) {
      $p = $null
      "  Error Checking: $($e.Current.ControlType.ProgrammaticName) $(Box $e)"
      if ($e.TryGetCurrentPattern([System.Windows.Automation.ExpandCollapsePattern]::Pattern, [ref]$p)) { $ec = $e }
    }
    if ($ec) {
      Mark 'errCheckArrow' (Box $ec)
      Expand $ec; Start-Sleep -Milliseconds 1500
      DumpOthers 'errmenu'
      MarkAny 'circItem' @('Circular References')
      MarkAny 'traceItem' @('Trace Error')
      SnapAll 'c-3' -Others                                         # the Error Checking menu
      try {
        $ci = FindAny @('Circular References') -tries 6
        Expand $ci; Start-Sleep -Milliseconds 1500
        DumpOthers 'circmenu'
        MarkAny 'circB10' @('$B$10', 'B10', 'Shares!$B$10')
        SnapAll 'c-4' -Others                                       # the Circular References list: $B$10
        try { Press (FindAny @('$B$10', 'B10', 'Shares!$B$10') -tries 4); Start-Sleep -Milliseconds 1200 } catch { "b10 item: $_" }
      } catch { "circular submenu: $_" }
      if (@([CompA]::Others($h)).Count -gt 0) { Collapse $ec; Start-Sleep -Milliseconds 500 }
      if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
    } else { "  no Error Checking menu" }
  } catch { "formulas tab: $_"; if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } }
  "active after the menu: $($xl.ActiveCell.Address(0, 0))"
  $null = $ws.Range('B10').Select()
  SnapAll 'c-5'                                                     # B10 selected: =SUM(B5:B10)
  TypeAndSnap '=SUM(B5:B8)' 'c-5t'                                  # the fix typed; Enter
  if ($ws.Range('B10').Formula -ne '=SUM(B5:B8)') { $ws.Range('B10').Formula = '=SUM(B5:B8)'; "  (fixed by COM)" }
  $null = $ws.Range('B10').Select()
  SnapAll 'c-6'                                                     # 3269.00, no warning
  try { Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 800 } catch { }

  # 4. Help: Insert Function (fx) on C5's ROUND - the Function Arguments box; then on an empty cell.
  $null = $ws.Range('C5').Select()
  SnapAll 'h-1'                                                     # C5 =ROUND(B5/$B$2,2)
  # fx beside the Formula Bar is not in UI Automation: the Formulas tab's Insert Function... opens the same boxes
  try { Press (Find $root @('Formulas') $T::TabItem); Start-Sleep -Milliseconds 1000 } catch { "formulas tab: $_" }
  try {
    PressAsync (Find $root @('Insert Function...', 'Insert Function') -tries 6)
    WaitOthers
    FitDialogs
    DumpOthers 'fnargs'
    MarkAny 'helpLink' @('Help on this function')
    MarkAny 'argNumber' @('Number')
    MarkAny 'argDigits' @('Num_digits')
    MarkAny 'argsOK' @('OK')
    SnapAll 'h-2' -Others                                           # Function Arguments: ROUND
    CloseOthers
  } catch { "function arguments: $_"; if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $ws.Range('E5').Select()
  Mark 'cellE5' (CellBox $ws 'E5')
  SnapAll 'h-3'                                                     # E5 empty, active
  try {
    PressAsync (Find $root @('Insert Function...', 'Insert Function') -tries 6)
    WaitOthers
    FitDialogs
    DumpOthers 'insfn'
    MarkAny 'searchFn' @('Search for a function:', 'Search for a function')
    MarkAny 'goBtn' @('Go')
    MarkAny 'category' @('Or select a category:', 'Or select a category')
    SnapAll 'h-4' -Others                                           # Insert Function
    try {
      $sbox = FindAny @('Search for a function:', 'Search for a function') -tries 4
      $ed = $sbox
      if ($sbox.Current.ControlType -ne $T::Edit) { $x = $sbox.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit))); if ($x) { $ed = $x } }
      SetText $ed 'round a number'
      Start-Sleep -Milliseconds 600
      SnapAll 'h-5' -Others                                         # words typed
      Press (FindAny @('Go') -tries 4); Start-Sleep -Milliseconds 1500
      DumpOthers 'insfn2'
      SnapAll 'h-6' -Others                                         # ROUND in the list
    } catch { "search for a function: $_" }
    CloseOthers
  } catch { "insert function: $_"; if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } }

  # 5. POWER on Savings.
  $null = $wv.Activate()
  $null = $wv.Range('E3').Select()
  Start-Sleep -Milliseconds 800
  foreach ($a in 'B3', 'B4', 'B5', 'B7', 'E3') { Mark ('v' + $a) (CellBox $wv $a) }
  SnapAll 'p-1'                                                     # E3 active
  $null = $wv.Range('B7').Select()
  SnapAll 'p-2'                                                     # B7 active
  TypeAndSnap '=B3*POWER(1+B4,B5)' 'p-2t'
  if ($wv.Range('B7').Formula -ne '=B3*POWER(1+B4,B5)') { $wv.Range('B7').Formula = '=B3*POWER(1+B4,B5)'; "  (typed into B7 by COM)" }
  $null = $wv.Range('B7').Select()
  SnapAll 'p-3'                                                     # 6298.56
  $wv.Range('D7').Formula = '=B3*(1+B4)^B5'
  $null = $wv.Range('D7').Select()
  SnapAll 'p-4'                                                     # the same with ^ in D7
  $wv.Range('D7').ClearContents()

  # 6. LARGE and SMALL on Marks.
  $null = $wm.Activate()
  $null = $wm.Range('G4').Select()
  Start-Sleep -Milliseconds 800
  foreach ($a in 'E4', 'E5', 'E6', 'E7', 'G4', 'B4:B15') { Mark ('m' + ($a -replace ':', '_')) (CellBox $wm $a) }
  SnapAll 'l-1'                                                     # G4 active
  $null = $wm.Range('E5').Select()
  SnapAll 'l-2'                                                     # E5 active
  TypeAndSnap '=LARGE(B4:B15,2)' 'l-2t'                             # typed; Enter -> E6
  if ($wm.Range('E5').Formula -ne '=LARGE(B4:B15,2)') { $wm.Range('E5').Formula = '=LARGE(B4:B15,2)'; $null = $wm.Range('E6').Select(); "  (typed into E5 by COM)" }
  SnapAll 'l-3'                                                     # E5 45; E6 active
  TypeAndSnap '=SMALL(B4:B15,2)' 'l-3t'
  if ($wm.Range('E6').Formula -ne '=SMALL(B4:B15,2)') { $wm.Range('E6').Formula = '=SMALL(B4:B15,2)'; "  (typed into E6 by COM)" }
  $null = $wm.Range('E6').Select()
  SnapAll 'l-4'                                                     # E6 22

  SaveMarks

  # ---------------------------------------------------------------- the starter file and a done-right copy
  # Made last, in the lesson's own window: the circular total is TYPED into B16 (posted to the grid) and
  # its warning closed through its own OK button - a circular formula written through COM could leave a
  # warning up that blocks COM. Then the lesson's sheets are deleted and the workbook saved as the starter.
  $sf = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)); $sf.Name = 'Stokvel'
  Title $sf 'Gogo Dlamini''s stokvel - 2026'
  $sf.Range('A2').Formula = 'Interest a year'; $sf.Range('B2').Formula = '0.07'; $sf.Range('B2').NumberFormat = '0%'
  $sf.Range('A3').Formula = 'Years';           $sf.Range('B3').Formula = '3'
  FillAt $sf @(,@('Member', 'Saved (R)', 'After the years (R)')) 5
  FillAt $sf $members 6
  $sf.Range('A16').Formula = 'Total'; $sf.Range('A16').Font.Bold = $true
  FillAt $sf @(@('Second most saved'), @('Second least saved'), @('Average, to the nearest R10')) 5 'E'
  Heading $sf 'A5:C5'
  $sf.Range('B6:C16').NumberFormat = '0.00'
  $sf.Range('F5:F7').NumberFormat = '0.00'
  $sf.Columns.Item('A').ColumnWidth = 16
  foreach ($c in 'B', 'C') { $sf.Columns.Item($c).ColumnWidth = 14 }
  $sf.Columns.Item('E').ColumnWidth = 27; $sf.Columns.Item('F').ColumnWidth = 12
  $null = $sf.Activate()
  $null = $sf.Range('B16').Select()
  Start-Sleep -Milliseconds 800
  TypeAndSnap '=SUM(B6:B16)' $null -NoEnd
  [CompA]::Key($grid, 0x0D)
  WaitOthers 1 12
  if (@([CompA]::Others($h)).Count -gt 0) { try { Press (FindAny @('OK') $T::Button -tries 4) } catch { "ok: $_"; CloseOthers } }
  Start-Sleep -Milliseconds 1000
  if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers }
  "starter B16: $($sf.Range('B16').Formula)"
  if ($sf.Range('B16').Formula -ne '=SUM(B6:B16)') { $sf.Range('B16').Formula = '=SUM(B6:B16)'; "  (B16 by COM)" }
  foreach ($old in 'Shares', 'Savings', 'Marks') { $wb.Worksheets.Item($old).Delete() }
  $null = $sf.Range('A1').Select()
  $wb.SaveAs((Join-Path $filesDir 'Stokvel.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'Stokvel.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  # done right, by real Excel
  $sf.Range('B16').Formula = '=SUM(B6:B15)'
  $sf.Range('C6:C15').Formula = '=ROUND(B6*POWER(1+$B$2,$B$3),2)'
  $sf.Range('F5').Formula = '=LARGE(B6:B15,2)'
  $sf.Range('F6').Formula = '=SMALL(B6:B15,2)'
  $sf.Range('F7').Formula = '=ROUND(AVERAGE(B6:B15),-1)'
  "done: B16 $($sf.Range('B16').Text) C6 $($sf.Range('C6').Value2) C15 $($sf.Range('C15').Value2) F5 $($sf.Range('F5').Text) F6 $($sf.Range('F6').Text) F7 $($sf.Range('F7').Value2)"
  $wb.SaveAs((Join-Path $filesDir 'Stokvel-done.xlsx'), 51)

}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { if ($grid) { [CompA]::Key($grid, 0x1B) } } catch { }
}
finally {
  try { SaveMarks } catch { }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
