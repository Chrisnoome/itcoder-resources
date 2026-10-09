# Real Excel 365 screens for catexcel Grade 12, Lookups (AIPascalCourse/
# content/catexcel/lookups.php - written to courses/cat-practical-writing.md,
# 9 October 2026). Botha's Bakery's order sheet: VLOOKUP for the price from
# the Prices sheet (exact match), the table without $ signs going wrong,
# #N/A for a code that is not in the list and fixing it, HLOOKUP for the
# delivery fee across the Zones table, XLOOKUP for the item's name, VLOOKUP
# with TRUE for the discount bands, and (IEB) MATCH and INDEX on the price
# list. Also makes the pupils' starter file BothaOrders.xlsx (and a
# done-right copy) in C:\sims\files\catexcel-lookups\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-lookups        (from the host)
$Name = 'catexcel-lookups'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$prices = @(
  @('BR01', 'White bread', 18), @('BR02', 'Brown bread', 17), @('BR03', 'Rolls (6)', 22), @('CK01', 'Chocolate cake', 180),
  @('CK02', 'Carrot cake', 165), @('CK03', 'Cupcakes (12)', 120), @('PS01', 'Sausage roll', 16), @('PS02', 'Pie', 28),
  @('SC01', 'Scones (6)', 36), @('TT01', 'Milk tart', 95))

function BakeryBook ($book, $orders) {
  while ($book.Worksheets.Count -lt 3) { $null = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count)) }
  $wo = $book.Worksheets.Item(1); $wo.Name = 'Orders'
  $wp = $book.Worksheets.Item(2); $wp.Name = 'Prices'
  $wz = $book.Worksheets.Item(3); $wz.Name = 'Zones'
  # Prices: a vertical table, A1:C11.
  Fill12 $wp @(,@('Code', 'Item', 'Price (R)')) 1
  Fill12 $wp $prices 2
  $wp.Range('A1:C1').Font.Bold = $true
  try { $wp.Range('A1:C1').Interior.Color = 0xF2E6D9 } catch { }
  $wp.Columns.Item('A').ColumnWidth = 8; $wp.Columns.Item('B').ColumnWidth = 16; $wp.Columns.Item('C').ColumnWidth = 10
  # Zones: a horizontal table, A1:E3.
  Fill12 $wz @(@('Zone', 'A', 'B', 'C', 'D'), @('Fee (R)', 0, 40, 80, 120), @('Days', 1, 1, 2, 3)) 1
  $wz.Range('A1:A3').Font.Bold = $true; $wz.Range('A1:E1').Font.Bold = $true
  try { $wz.Range('A1:E1').Interior.Color = 0xF2E6D9 } catch { }
  $wz.Columns.Item('A').ColumnWidth = 9
  # Orders.
  $wo.Range('A1').Formula = "Botha's Bakery - orders"
  Fill12 $wo @(,@('Order', 'Customer', 'Code', 'Item', 'Qty', 'Zone', 'Price (R)', 'Amount (R)', 'Fee (R)', 'Discount')) 3
  Fill12 $wo $orders 4
  # The discount bands: order amount from ... gets this discount.
  Fill12 $wo @(@('Amount from', 'Discount'), @(0, 0), @(500, 0.05), @(1000, 0.1), @(2000, 0.15)) 3 11
  $wo.Range('M4:M7').NumberFormat = '0%'
  $wo.Range('A1').Font.Bold = $true; $wo.Range('A1').Font.Size = 14
  $wo.Range('A3:J3').Font.Bold = $true; $wo.Range('L3:M3').Font.Bold = $true
  try { $wo.Range('A3:J3').Interior.Color = 0xF2E6D9; $wo.Range('L3:M3').Interior.Color = 0xF2E6D9 } catch { }
  $wo.Columns.Item('A').ColumnWidth = 6; $wo.Columns.Item('B').ColumnWidth = 18; $wo.Columns.Item('C').ColumnWidth = 7
  $wo.Columns.Item('D').ColumnWidth = 14; $wo.Columns.Item('E').ColumnWidth = 5; $wo.Columns.Item('F').ColumnWidth = 5
  $wo.Columns.Item('G').ColumnWidth = 9; $wo.Columns.Item('H').ColumnWidth = 10; $wo.Columns.Item('I').ColumnWidth = 7
  $wo.Columns.Item('J').ColumnWidth = 8; $wo.Columns.Item('K').ColumnWidth = 3; $wo.Columns.Item('L').ColumnWidth = 11
  $last = 3 + $orders.Count
  $wo.Range("J4:J$last").NumberFormat = '0%'
  return $wo
}

function Answers ($wo, [int]$last) {
  for ($r = 4; $r -le $last; $r++) {
    $wo.Range("D$r").Formula2 = "=XLOOKUP(C$r,Prices!`$A`$2:`$A`$11,Prices!`$B`$2:`$B`$11)"
    $wo.Range("G$r").Formula2 = "=VLOOKUP(C$r,Prices!`$A`$2:`$C`$11,3,FALSE)"
    $wo.Range("H$r").Formula2 = "=E$r*G$r"
    $wo.Range("I$r").Formula2 = "=HLOOKUP(F$r,Zones!`$B`$1:`$E`$2,2,FALSE)"
    $wo.Range("J$r").Formula2 = "=VLOOKUP(H$r,`$L`$4:`$M`$7,2,TRUE)"
  }
}

# The lesson's orders (rows 4-15); CK04 is not in the price list.
$ordersA = @(
  @(101, 'Phumlani Secondary', 'CK03', '', 10, 'B'), @(102, 'Gogo Dlamini', 'TT01', '', 1, 'A'), @(103, 'Centurion Primary', 'PS02', '', 40, 'C'),
  @(104, 'Mrs Venter', 'BR01', '', 3, 'A'), @(105, 'Soweto Book Club', 'SC01', '', 6, 'D'), @(106, 'Ms Naidoo', 'CK04', '', 1, 'B'),
  @(107, 'Lerato Dube', 'BR03', '', 2, 'A'), @(108, 'Centurion Church', 'PS01', '', 60, 'B'), @(109, 'Mr Khoza', 'CK01', '', 2, 'C'),
  @(110, 'Phumlani PTA', 'BR02', '', 25, 'B'), @(111, 'Mrs Pillay', 'CK02', '', 1, 'A'), @(112, 'Hope Creche', 'SC01', '', 12, 'C'))

# The upload's orders (rows 4-23); SC10 in row 15 is a typing mistake for SC01.
$ordersB = @(
  @(201, 'Laerskool Eldoraigne', 'PS02', '', 50, 'B'), @(202, 'Thabo Dube', 'BR01', '', 2, 'A'), @(203, 'Centurion Rotary', 'CK01', '', 3, 'C'),
  @(204, 'Mrs Smith', 'TT01', '', 2, 'A'), @(205, 'Phumlani Secondary', 'CK03', '', 15, 'B'), @(206, 'Mr Govender', 'BR03', '', 4, 'D'),
  @(207, 'Irene Bowls Club', 'SC01', '', 10, 'C'), @(208, 'Gogo Dlamini', 'CK02', '', 1, 'A'), @(209, 'Hope Creche', 'PS01', '', 30, 'B'),
  @(210, 'Mrs Venter', 'BR02', '', 6, 'A'), @(211, 'Lyttelton Library', 'TT01', '', 4, 'C'), @(212, 'Soweto Book Club', 'SC10', '', 8, 'D'),
  @(213, 'Mr Khoza', 'CK01', '', 1, 'B'), @(214, 'Centurion Primary', 'PS02', '', 75, 'C'), @(215, 'Ms Naidoo', 'CK03', '', 2, 'A'),
  @(216, 'Phumlani PTA', 'BR01', '', 40, 'B'), @(217, 'Mrs Pillay', 'SC01', '', 3, 'A'), @(218, 'Centurion Church', 'PS01', '', 100, 'D'),
  @(219, 'Lerato Dube', 'BR03', '', 1, 'A'), @(220, 'Irene Primary', 'CK02', '', 6, 'C'))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $so = BakeryBook $sb $ordersB
  $null = $so.Activate(); $null = $so.Range('A1').Select()
  SaveStarter $sb 'BothaOrders.xlsx'
  $so.Range('C15').Formula = 'SC01'
  Answers $so 23
  $sb.SaveAs((Join-Path $filesDir 'BothaOrders-done.xlsx'), 51)
  foreach ($r in 4..23) { "  done row $($r): $($so.Range("C$r").Text) $($so.Range("D$r").Text) | $($so.Range("G$r").Text) | $($so.Range("H$r").Text) | $($so.Range("I$r").Text) | $($so.Range("J$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $wo = BakeryBook $wb $ordersA
  $wp = $wb.Worksheets.Item('Prices')
  $wz = $wb.Worksheets.Item('Zones')
  $null = $wo.Activate()
  $null = $wo.Range('O4').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $wo @('C4', 'D4', 'G4', 'H4', 'I4', 'J4', 'C9', 'G9', 'O4', 'G4:G15', 'L4:M7')
  MarkHandle $wo 'G4'
  MarkHandle $wo 'I4'
  TryMark 'formulaBar' $root @('Formula Bar')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  # where the sheet tabs are (for a click on Prices)
  Dump 'home'

  # 1. The price list, then VLOOKUP in G4 and fill down.
  SnapAll 'v-0'                                                     # the orders, O4 active
  $null = $wp.Activate(); $null = $wp.Range('E2').Select()
  SnapAll 'v-p'                                                     # the Prices sheet
  $null = $wo.Activate()
  $null = $wo.Range('G4').Select(); SnapAll 'v-1'                   # G4 clicked
  $wo.Range('G4').Formula2 = '=VLOOKUP(C4,Prices!$A$2:$C$11,3,FALSE)'
  $null = $wo.Range('G5').Select(); SnapAll 'v-2'                   # 120; G5 active
  $null = $wo.Range('G4').Select(); SnapAll 'v-3'                   # G4 again: its fill handle
  $null = $wo.Range('G4').AutoFill($wo.Range('G4:G15'), 0)
  for ($r = 4; $r -le 15; $r++) { $wo.Range("H$r").Formula2 = "=E$r*G$r" }
  $null = $wo.Range('G4:G15').Select(); SnapAll 'v-4'               # the prices; G9 is #N/A
  "prices: $((4..15 | ForEach-Object { $wo.Range("G$_").Text }) -join ', ')"

  # 2. Without $ signs: the table slides down as the formula is copied.
  for ($r = 4; $r -le 15; $r++) { $wo.Range("G$r").Formula2 = "=VLOOKUP(C$r,Prices!A$($r - 2):C$($r + 7),3,FALSE)" }
  $null = $wo.Range('G14').Select()
  SnapAll 'v-5'                                                     # the relative table: wrong answers lower down
  "relative: $((4..15 | ForEach-Object { $wo.Range("G$_").Text }) -join ', ')"
  for ($r = 4; $r -le 15; $r++) { $wo.Range("G$r").Formula2 = "=VLOOKUP(C$r,Prices!`$A`$2:`$C`$11,3,FALSE)" }

  # 3. #N/A: CK04 is not in the list. Click C9 and type the right code.
  $null = $wo.Range('G9').Select(); SnapAll 'n-1'                   # G9 shows #N/A
  $null = $wo.Range('C9').Select(); SnapAll 'n-2'                   # C9 clicked
  $wo.Range('C9').Formula = 'CK03'
  $null = $wo.Range('C10').Select(); SnapAll 'n-3'                  # fixed: 120
  "fixed G9: $($wo.Range('G9').Text)"

  # 4. HLOOKUP for the fee: the Zones sheet, then I4 and fill down.
  $null = $wz.Activate(); $null = $wz.Range('A6').Select()
  SnapAll 'h-z'                                                     # the Zones sheet
  $null = $wo.Activate()
  $null = $wo.Range('I4').Select(); SnapAll 'h-1'                   # I4 clicked
  $wo.Range('I4').Formula2 = '=HLOOKUP(F4,Zones!$B$1:$E$2,2,FALSE)'
  $null = $wo.Range('I4').AutoFill($wo.Range('I4:I15'), 0)
  $null = $wo.Range('I4:I15').Select(); SnapAll 'h-2'               # the fees
  "fees: $((4..15 | ForEach-Object { $wo.Range("I$_").Text }) -join ', ')"

  # 5. XLOOKUP for the item's name in D4.
  $null = $wo.Range('D4').Select(); SnapAll 'x-1'                   # D4 clicked
  $wo.Range('D4').Formula2 = '=XLOOKUP(C4,Prices!$A$2:$A$11,Prices!$B$2:$B$11)'
  $null = $wo.Range('D4').AutoFill($wo.Range('D4:D15'), 0)
  $null = $wo.Range('D4').Select(); SnapAll 'x-2'                   # the names
  "items: $((4..15 | ForEach-Object { $wo.Range("D$_").Text }) -join ', ')"

  # 6. VLOOKUP with TRUE: the discount bands in L3:M7.
  $null = $wo.Range('J4').Select(); SnapAll 'a-1'                   # J4 clicked
  $wo.Range('J4').Formula2 = '=VLOOKUP(H4,$L$4:$M$7,2,TRUE)'
  $null = $wo.Range('J4').AutoFill($wo.Range('J4:J15'), 0)
  $null = $wo.Range('J4').Select(); SnapAll 'a-2'                   # the discounts
  "amounts: $((4..15 | ForEach-Object { $wo.Range("H$_").Text }) -join ', ')"
  "discounts: $((4..15 | ForEach-Object { $wo.Range("J$_").Text }) -join ', ')"
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  SnapAll 'a-3'                                                     # the formulas
  $xl.ActiveWindow.DisplayFormulas = $false

  # 7. IEB: MATCH and INDEX on the price list.
  $null = $wp.Activate()
  Fill12 $wp @(@('Item to find', 'Pie'), @('Position', ''), @('Price (R)', '')) 2 4
  $wp.Columns.Item('E').ColumnWidth = 13; $wp.Columns.Item('F').ColumnWidth = 10
  $wp.Range('E2:E4').Font.Bold = $true
  $null = $wp.Range('F3').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $wp @('F3', 'F4') 'p'
  SnapAll 'm-1'                                                     # F3 clicked
  $wp.Range('F3').Formula2 = '=MATCH(F2,B2:B11,0)'
  $null = $wp.Range('F4').Select(); SnapAll 'm-2'                   # 8; F4 active
  $wp.Range('F4').Formula2 = '=INDEX(C2:C11,F3)'
  $null = $wp.Range('F5').Select(); SnapAll 'm-3'                   # 28
  "match $($wp.Range('F3').Text), index $($wp.Range('F4').Text)"

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
