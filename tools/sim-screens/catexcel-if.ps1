# Real Excel 365 screens for catexcel Grade 11, lesson 13: The IF function
# (AIPascalCourse/content/catexcel/if.php - written to
# courses/cat-practical-writing.md, 9 October 2026, writer B). Ms Naidoo's
# Grade 11C CAT test 2 at Phumlani Secondary: Pass or Fail with IF, filled
# down; the pass mark in a cell ($G$3) changed from 50 to 40; the Formulas
# tab's Logical list and the Function Arguments box (empty, then filled) for
# a "See me" note with "" for nothing; three broken formulas (no quotes;
# "50" in quotes; the wrong order). Then Mr Botha's orders: a 10% discount
# with a calculation as the IF's answer. Also makes the pupils' starter file
# CakeOrders.xlsx (and a done-right copy) in C:\sims\files\catexcel-if\ and
# G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel at the end.
# Crop: work/catexcel-if-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-if -TimeoutSec 1200   (from the host)
$Name = 'catexcel-if'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11b-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

# Ms Naidoo's 11C, test 2 (the lesson): the edges 50, 49, 45, 38.
$pupils = @(
  @('Thabo', 64), @('Ayanda', 81), @('Imran', 49), @('Zanele', 50), @('Gift', 38), @('Chloe', 72),
  @('Bongani', 55), @('Fatima', 93), @('Mpho', 45), @('Tamsin', 67), @('Sipho', 29), @('Carmen', 58))

# Mr Botha's orders (the lesson): the edges 500 and 495.
$orders = @(
  @('Phumlani Secondary', 1250), @('Gogo Dlamini', 180), @('Centurion Spar', 640), @('Soccer club', 495),
  @('Mrs Khoza', 85), @('Church bazaar', 500), @('Mr Venter', 320), @('Lerato', 150))

# The upload: cake orders for October (edges 500, 495; 10 and 11 cakes).
$cakes = @(
  @('Centurion Spar', 'Centurion', 14, 1260), @('Gogo Dlamini', 'Pretoria', 1, 180), @('Phumlani Secondary', 'Soweto', 12, 1080),
  @('Mrs Khoza', 'Midrand', 3, 345), @('Soccer club', 'Centurion', 6, 495), @('Church bazaar', 'Pretoria', 10, 500),
  @('Mr Venter', 'Centurion', 2, 230), @('Lerato', 'Pretoria', 1, 120), @('Old-age home', 'Midrand', 11, 990),
  @('Ms Naidoo', 'Soweto', 4, 420), @('Thabo''s class', 'Pretoria', 5, 550), @('Netball team', 'Centurion', 8, 760))

function Heads ($ws, $range) {
  $ws.Range($range).Font.Bold = $true
  try { $ws.Range($range).Interior.Color = 0xF2E6D9 } catch { }
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
  $so = $sb.Worksheets.Item(1); $so.Name = 'Orders'
  $so.Range('A1').Formula = 'Botha''s Bakery - cake orders, October 2026'
  $so.Range('A1').Font.Bold = $true; $so.Range('A1').Font.Size = 14
  Fill11 $so @(,@('Customer', 'Area', 'Cakes', 'Amount (R)', 'Delivery (R)', 'Size', 'Discount (R)')) 3
  Fill11 $so $cakes 4
  Heads $so 'A3:G3'
  Fill11 $so @(@('Free delivery from (R)', 500), @('Delivery fee (R)', 60)) 3 8
  $so.Range('I3:I4').Font.Bold = $true
  for ($r = 4; $r -le 15; $r++) { $so.Range("G$r").Formula2 = "=IF(D$r>=""500"",D$r*5%,0)" }   # the broken discount: "500" in quotes
  $so.Range('D4:G15').NumberFormat = '0.00'
  $so.Range('C4:C15').NumberFormat = '0'
  $so.Range('F4:F15').NumberFormat = 'General'
  $so.Columns.Item('A').ColumnWidth = 20; $so.Columns.Item('B').ColumnWidth = 11
  foreach ($c in 'C', 'F') { $so.Columns.Item($c).ColumnWidth = 8 }
  foreach ($c in 'D', 'E', 'G') { $so.Columns.Item($c).ColumnWidth = 13 }
  $so.Columns.Item('H').ColumnWidth = 3; $so.Columns.Item('I').ColumnWidth = 21; $so.Columns.Item('J').ColumnWidth = 8
  $null = $so.Range('A1').Select()
  SaveStarter $sb 'CakeOrders.xlsx'
  "starter G4..G15: $((4..15 | ForEach-Object { $so.Range("G$_").Text }) -join ', ')"
  for ($r = 4; $r -le 15; $r++) {
    $so.Range("E$r").Formula2 = "=IF(D$r>=`$J`$3,0,`$J`$4)"
    $so.Range("F$r").Formula2 = "=IF(C$r>10,""Big"","""")"
    $so.Range("G$r").Formula2 = "=IF(D$r>=500,D$r*5%,0)"
  }
  $sb.SaveAs((Join-Path $filesDir 'CakeOrders-done.xlsx'), 51)
  foreach ($r in 4..15) { "  done row $($r): $($so.Range("A$r").Text) $($so.Range("D$r").Text) delivery $($so.Range("E$r").Text) size '$($so.Range("F$r").Text)' discount $($so.Range("G$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Test 2'
  $wo = $wb.Worksheets.Item(2); $wo.Name = 'Orders'
  $ws.Range('A1').Formula = 'Phumlani Secondary - Grade 11C CAT test 2'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill11 $ws @(,@('Name', 'Mark (%)', 'Result', 'Note')) 3
  Fill11 $ws $pupils 4
  Heads $ws 'A3:D3'
  $ws.Range('F3').Formula = 'Pass mark'; $ws.Range('F3').Font.Bold = $true
  $ws.Range('G3').Formula = '50'
  $ws.Columns.Item('A').ColumnWidth = 14
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 11 }
  $ws.Columns.Item('E').ColumnWidth = 4; $ws.Columns.Item('F').ColumnWidth = 11; $ws.Columns.Item('G').ColumnWidth = 7

  $wo.Range('A1').Formula = 'Botha''s Bakery - orders this week'
  $wo.Range('A1').Font.Bold = $true; $wo.Range('A1').Font.Size = 14
  Fill11 $wo @(,@('Customer', 'Amount (R)', 'Discount (R)', 'To pay (R)')) 3
  Fill11 $wo $orders 4
  Heads $wo 'A3:D3'
  $wo.Range('B4:D11').NumberFormat = '0.00'
  $wo.Columns.Item('A').ColumnWidth = 20
  foreach ($c in 'B', 'C', 'D') { $wo.Columns.Item($c).ColumnWidth = 13 }

  $null = $ws.Activate()
  $null = $ws.Range('F6').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $ws @('C4', 'D4', 'G3', 'F6', 'C4:C15', 'B4')
  MarkHandle $ws 'C4'
  MarkHandle $ws 'D4'
  TryMark 'nameBox' $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  TryMark 'insertFunction' $root @('Insert Function')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  Dump 'home'

  # 1. Pass or Fail in C4: click, type, click again, fill down.
  SnapAll 'i-0'                                                     # F6 active
  $null = $ws.Range('C4').Select(); SnapAll 'i-1'                   # C4 clicked
  $ws.Range('C4').Formula2 = '=IF(B4>=50,"Pass","Fail")'
  $null = $ws.Range('C5').Select(); SnapAll 'i-2'                   # Pass; C5 active
  $null = $ws.Range('C4').Select(); SnapAll 'i-3'                   # C4 again: its fill handle
  $null = $ws.Range('C4').AutoFill($ws.Range('C4:C15'), 0)
  $null = $ws.Range('C4:C15').Select(); SnapAll 'i-4'               # every result
  "results: $((4..15 | ForEach-Object { $ws.Range("C$_").Text }) -join ', ')"
  $xl.ActiveWindow.DisplayFormulas = $true; Start-Sleep -Milliseconds 800
  $null = $ws.Range('C4').Select(); SnapAll 'i-5'                   # Show Formulas: =IF(B4>=50,...) =IF(B5>=50,...)
  $xl.ActiveWindow.DisplayFormulas = $false; Start-Sleep -Milliseconds 800

  # 2. The pass mark in a cell: $G$3, then 50 -> 40 (before and after).
  $ws.Range('C4').Formula2 = '=IF(B4>=$G$3,"Pass","Fail")'
  $null = $ws.Range('C4').AutoFill($ws.Range('C4:C15'), 0)
  $null = $ws.Range('C4').Select(); SnapAll 'c-1'                   # pass mark 50
  $ws.Range('G3').Formula = '40'
  Start-Sleep -Milliseconds 600
  SnapAll 'c-2'                                                     # pass mark 40: Imran and Mpho pass
  "with 40: $((4..15 | ForEach-Object { $ws.Range("C$_").Text }) -join ', ')"
  $ws.Range('G3').Formula = '50'

  # 3. The Function Arguments box: Formulas > Logical > IF for D4 ("See me" or nothing).
  $null = $ws.Range('D4').Select()
  try {
    Tab 'Formulas'
    Dump 'formulas'
    TryMark 'btnLogical' $root @('Logical') $T::MenuItem
    TryMark 'btnInsertFunctionRibbon' $root @('Insert Function...')
    SnapAll 'f-1'                                                   # the Formulas tab, D4 active
    $logical = Find $root @('Logical') $T::MenuItem -tries 6
    Expand $logical; WaitOthers
    DumpOthers 'logical'
    MarkAny 'itemIF' @('IF')
    SnapAll 'f-2' -Others                                           # the Logical list open
    try {
      PressAsync (FindAny @('IF') -tries 6)
      WaitOthers 1 30
      DumpOthers 'args-empty'
      SnapAll 'f-3' -Others                                         # Function Arguments, empty
      "  windows: $([Comp11B]::Describe($h))"
      $dlg = FirstOther
      if ($dlg -ne [IntPtr]::Zero) {
        DlgChars $dlg 'B4<40'
        SnapAll 'f-3b' -Others                                      # the condition typed (if the box takes posted characters)
        [Comp11B]::Key($dlg, 0x09, $false); Start-Sleep -Milliseconds 500
        DlgChars $dlg 'See me'
        [Comp11B]::Key($dlg, 0x09, $false); Start-Sleep -Milliseconds 500
        DlgChars $dlg '""'
        [Comp11B]::Key($dlg, 0x09, $false); Start-Sleep -Milliseconds 800
        SnapAll 'f-4t' -Others                                      # all three typed
        [Comp11B]::Key($dlg, 0x0D, $false); Start-Sleep -Milliseconds 1500
      }
    } catch { "IF item: $_" }
    if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
    "D4 after typing into the dialog: '$($ws.Range('D4').Formula)'"
    $ws.Range('D4').Formula2 = '=IF(B4<40,"See me","")'
    $null = $ws.Range('D4').Select()
    Start-Sleep -Milliseconds 600
    try {
      PressAsync (Find $root @('Insert Function...', 'Insert Function') -tries 6)
      WaitOthers 1 30
      DumpOthers 'args-filled'
      SnapAll 'f-4' -Others                                         # Function Arguments, filled
    } catch { "insert function: $_" }
    if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers }
    "D4 after the dialog: '$($ws.Range('D4').Formula)'"
    $ws.Range('D4').Formula2 = '=IF(B4<40,"See me","")'
    $null = $ws.Range('D4').AutoFill($ws.Range('D4:D15'), 0)
    $null = $ws.Range('D5').Select()
    SnapAll 'f-5'                                                   # the notes: See me for Gift and Sipho
    Tab 'Home'
  } catch { "formulas tab: $_"; if (@([Comp11B]::Others($h)).Count -gt 0) { CloseOthers } }

  # 4. Three broken formulas.
  $ws.Range('G3').Formula = '50'
  $ws.Range('C4').Formula2 = '=IF(B4>=50,Pass,Fail)'
  $null = $ws.Range('C4').AutoFill($ws.Range('C4:C15'), 0)
  $null = $ws.Range('C4').Select(); SnapAll 'n-1'                   # #NAME?: no quotes
  $ws.Range('C4').Formula2 = '=IF(B4>=50,"Fail","Pass")'
  $null = $ws.Range('C4').AutoFill($ws.Range('C4:C15'), 0)
  $null = $ws.Range('C4').Select(); SnapAll 'n-2'                   # the wrong order: Fatima's 93 fails
  $ws.Range('C4').Formula2 = '=IF(B4>="50","Pass","Fail")'
  $null = $ws.Range('C4').AutoFill($ws.Range('C4:C15'), 0)
  $null = $ws.Range('F6').Select(); SnapAll 'x-0'                   # "50" in quotes: everyone fails
  $null = $ws.Range('C4').Select(); SnapAll 'x-1'                   # C4 clicked: the formula bar shows it
  "with ""50"": $((4..15 | ForEach-Object { $ws.Range("C$_").Text }) -join ', ')"
  $ws.Range('C4').Formula2 = '=IF(B4>=50,"Pass","Fail")'
  $null = $ws.Range('C5').Select(); SnapAll 'x-2'                   # C4 fixed: Pass

  # 5. Mr Botha's discount: a calculation as the answer.
  $null = $wo.Activate()
  $null = $wo.Range('F6').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wo @('C4', 'B4', 'D4', 'F6') 'o'
  SnapAll 'o-0'                                                     # the orders, F6 active
  $null = $wo.Range('C4').Select(); SnapAll 'o-1'                   # C4 clicked
  $wo.Range('C4').Formula2 = '=IF(B4>=500,B4*10%,0)'
  $null = $wo.Range('C5').Select(); SnapAll 'o-2'                   # 125.00; C5 active
  $null = $wo.Range('C4').AutoFill($wo.Range('C4:C11'), 0)
  $wo.Range('D4').Formula2 = '=B4-C4'
  $null = $wo.Range('D4').AutoFill($wo.Range('D4:D11'), 0)
  $null = $wo.Range('C4').Select(); SnapAll 'o-3'                   # every discount and what each pays
  "discounts: $((4..11 | ForEach-Object { $wo.Range("C$_").Text }) -join ', ')"

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
