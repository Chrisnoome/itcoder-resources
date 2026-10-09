# Real Excel 365 screens for catexcel Grade 11, lesson 14: COUNTIF and SUMIF
# (AIPascalCourse/content/catexcel/sumif.php - written to
# courses/cat-practical-writing.md, 9 October 2026, writer B). Botha's
# Bakery's orders for one week (20 orders, three areas): COUNTIF with the
# criterion in a cell and an absolute range, SUMIF for each area filled
# down, SUMIF with an operator (orders of R500 or more), COUNTBLANK and
# COUNTA on the Paid on column (IEB), a percentage of the whole, and Show
# Formulas. Also makes the pupils' starter file MarketDay11.xlsx (and a
# done-right copy) in C:\sims\files\catexcel-sumif\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel at the end.
# Crop: work/catexcel-sumif-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-sumif -TimeoutSec 1200   (from the host)
$Name = 'catexcel-sumif'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11b-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

# Botha's Bakery, 5-10 October 2026 (the lesson): date, area, item, amount, paid on ('' = not paid).
$orders = @(
  @('2026/10/05', 'Midrand', 'Pies', 180, ''),               @('2026/10/05', 'Pretoria', 'Cakes', 650, '2026/10/06'),
  @('2026/10/05', 'Centurion', 'Bread', 240, '2026/10/05'),              @('2026/10/06', 'Centurion', 'Cakes', 520, '2026/10/06'),
  @('2026/10/06', 'Centurion', 'Pies', 95, '2026/10/06'),   @('2026/10/06', 'Pretoria', 'Bread', 310, ''),
  @('2026/10/07', 'Midrand', 'Cakes', 780, '2026/10/08'),   @('2026/10/07', 'Centurion', 'Bread', 150, '2026/10/07'),
  @('2026/10/07', 'Pretoria', 'Pies', 220, '2026/10/07'),   @('2026/10/08', 'Centurion', 'Cakes', 1250, ''),
  @('2026/10/08', 'Midrand', 'Bread', 275, '2026/10/08'),   @('2026/10/08', 'Pretoria', 'Bread', 500, '2026/10/09'),
  @('2026/10/09', 'Centurion', 'Pies', 130, '2026/10/09'),  @('2026/10/09', 'Pretoria', 'Bread', 185, ''),
  @('2026/10/09', 'Midrand', 'Pies', 340, '2026/10/09'),    @('2026/10/09', 'Centurion', 'Bread', 410, '2026/10/10'),
  @('2026/10/10', 'Pretoria', 'Cakes', 960, '2026/10/10'),  @('2026/10/10', 'Centurion', 'Cakes', 600, ''),
  @('2026/10/10', 'Midrand', 'Bread', 120, '2026/10/10'),   @('2026/10/10', 'Pretoria', 'Pies', 265, '2026/10/10'))

# Phumlani Secondary's Grade 11 market day (the upload): sale, class, item, amount. 11A 8, 11B 9, 11C 7.
$sales = @(
  @(1, '11A', 'Boerewors rolls', 70), @(2, '11B', 'Cupcakes', 45), @(3, '11C', 'Pizza', 50), @(4, '11B', 'Juice', 24),
  @(5, '11A', 'Cake', 120), @(6, '11B', 'Vetkoek', 40), @(7, '11C', 'Chips', 20), @(8, '11A', 'Doughnuts', 60),
  @(9, '11B', 'Boerewors rolls', 105), @(10, '11C', 'Cake', 120), @(11, '11A', 'Juice', 12), @(12, '11B', 'Cupcakes', 30),
  @(13, '11A', 'Pizza', 75), @(14, '11C', 'Vetkoek', 60), @(15, '11B', 'Doughnuts', 60), @(16, '11A', 'Chips', 30),
  @(17, '11B', 'Cake', 240), @(18, '11C', 'Juice', 36), @(19, '11A', 'Boerewors rolls', 35), @(20, '11B', 'Pizza', 25),
  @(21, '11C', 'Cupcakes', 15), @(22, '11A', 'Vetkoek', 20), @(23, '11B', 'Chips', 10), @(24, '11C', 'Doughnuts', 60))

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
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Sales'
  $ss.Range('A1').Formula = 'Phumlani Secondary - Grade 11 market day, 2 October 2026'
  $ss.Range('A1').Font.Bold = $true; $ss.Range('A1').Font.Size = 14
  Fill11 $ss @(,@('Sale', 'Class', 'Item', 'Amount (R)')) 3
  Fill11 $ss $sales 4
  Heads $ss 'A3:D3'
  Fill11 $ss @(,@('Class', 'Sales', 'Takings (R)')) 3 5
  Heads $ss 'F3:H3'
  Fill11 $ss @(@('11A'), @('11B'), @('11C')) 4 5
  $ss.Range('F4:F6').NumberFormat = '@'
  foreach ($r in 4..6) { $ss.Range("F$r").Value2 = @('11A', '11B', '11C')[$r - 4] }
  $ss.Range('F8').Formula = 'Takings from sales of R50 or more'
  $ss.Range('F9').Formula = '11B''s share of the sales'
  $ss.Range('D4:D27').NumberFormat = '0.00'
  $ss.Range('H4:H8').NumberFormat = '0.00'
  $ss.Columns.Item('A').ColumnWidth = 7; $ss.Columns.Item('B').ColumnWidth = 8; $ss.Columns.Item('C').ColumnWidth = 16
  $ss.Columns.Item('D').ColumnWidth = 12; $ss.Columns.Item('E').ColumnWidth = 3; $ss.Columns.Item('F').ColumnWidth = 32
  $ss.Columns.Item('G').ColumnWidth = 9; $ss.Columns.Item('H').ColumnWidth = 13
  $null = $ss.Range('A1').Select()
  SaveStarter $sb 'MarketDay11.xlsx'
  "starter F4: '$($ss.Range('F4').Text)' type $($ss.Range('F4').Value2.GetType().Name)"
  $ss.Range('G4').Formula2 = '=COUNTIF($B$4:$B$27,F4)'
  $null = $ss.Range('G4').AutoFill($ss.Range('G4:G6'), 0)
  $ss.Range('H4').Formula2 = '=SUMIF($B$4:$B$27,F4,$D$4:$D$27)'
  $null = $ss.Range('H4').AutoFill($ss.Range('H4:H6'), 0)
  $ss.Range('H8').Formula2 = '=SUMIF(D4:D27,">=50")'
  $ss.Range('G9').Formula2 = '=G5/COUNTA(B4:B27)'
  $ss.Range('G9').NumberFormat = '0.0%'
  $sb.SaveAs((Join-Path $filesDir 'MarketDay11-done.xlsx'), 51)
  "done: G4..G6 $($ss.Range('G4').Text) $($ss.Range('G5').Text) $($ss.Range('G6').Text); H4..H6 $($ss.Range('H4').Text) $($ss.Range('H5').Text) $($ss.Range('H6').Text); H8 $($ss.Range('H8').Text); G9 $($ss.Range('G9').Text) ($($ss.Range('G9').Value2))"
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Orders'
  $ws.Range('A1').Formula = 'Botha''s Bakery - orders, 5 to 10 October 2026'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill11 $ws @(,@('Date', 'Area', 'Item', 'Amount (R)', 'Paid on')) 3
  Fill11 $ws $orders 4
  Heads $ws 'A3:E3'
  $ws.Range('A4:A23').NumberFormat = 'yyyy/mm/dd'
  $ws.Range('E4:E23').NumberFormat = 'yyyy/mm/dd'
  $ws.Range('D4:D23').NumberFormat = '0.00'
  Fill11 $ws @(,@('Area', 'Orders', 'Takings (R)')) 3 6
  Heads $ws 'G3:I3'
  Fill11 $ws @(@('Centurion'), @('Pretoria'), @('Midrand')) 4 6
  $ws.Range('G8').Formula = 'Takings from orders of R500 or more'
  $ws.Range('G10').Formula = 'Orders not paid yet'
  $ws.Range('G11').Formula = 'Orders paid'
  $ws.Range('G13').Formula = 'Centurion''s share of the orders'
  $ws.Range('I4:I8').NumberFormat = '0.00'
  $ws.Columns.Item('A').ColumnWidth = 11; $ws.Columns.Item('B').ColumnWidth = 10; $ws.Columns.Item('C').ColumnWidth = 8
  $ws.Columns.Item('D').ColumnWidth = 11; $ws.Columns.Item('E').ColumnWidth = 11; $ws.Columns.Item('F').ColumnWidth = 3
  $ws.Columns.Item('G').ColumnWidth = 31; $ws.Columns.Item('H').ColumnWidth = 8; $ws.Columns.Item('I').ColumnWidth = 12

  $null = $ws.Range('K4').Select()
  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $ws @('H4', 'I4', 'I8', 'H10', 'H11', 'H13', 'K4', 'B4:B23', 'D4:D23', 'E4:E23', 'G4')
  MarkHandle $ws 'H4'
  MarkHandle $ws 'I4'
  TryMark 'nameBox' $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  Dump 'home'

  # 1. COUNTIF with the criterion in G4 and an absolute range.
  SnapAll 'k-0'                                                     # the orders and the empty summary, K4 active
  $null = $ws.Range('H4').Select(); SnapAll 'k-1'                   # H4 clicked
  $ws.Range('H4').Formula2 = '=COUNTIF($B$4:$B$23,G4)'
  $null = $ws.Range('H5').Select(); SnapAll 'k-2'                   # 8; H5 active
  $null = $ws.Range('H4').Select(); SnapAll 'k-3'                   # H4 again: its fill handle
  $null = $ws.Range('H4').AutoFill($ws.Range('H4:H6'), 0)
  $null = $ws.Range('H4:H6').Select(); SnapAll 'k-4'                # 8, 7, 5

  # 2. SUMIF for each area.
  $null = $ws.Range('I4').Select(); SnapAll 'u-1'                   # I4 clicked
  $ws.Range('I4').Formula2 = '=SUMIF($B$4:$B$23,G4,$D$4:$D$23)'
  $null = $ws.Range('I5').Select(); SnapAll 'u-2'                   # 3395.00; I5 active
  $null = $ws.Range('I4').Select(); SnapAll 'u-3'                   # I4 again: its fill handle
  $null = $ws.Range('I4').AutoFill($ws.Range('I4:I6'), 0)
  $null = $ws.Range('I4:I6').Select(); SnapAll 'u-4'                # 3395, 3090, 1695
  "summary: $($ws.Range('H4').Text)/$($ws.Range('I4').Text), $($ws.Range('H5').Text)/$($ws.Range('I5').Text), $($ws.Range('H6').Text)/$($ws.Range('I6').Text)"

  # 3. SUMIF with an operator.
  $null = $ws.Range('I8').Select(); SnapAll 'g-1'                   # I8 clicked
  $ws.Range('I8').Formula2 = '=SUMIF(D4:D23,">=500")'
  $null = $ws.Range('I9').Select(); SnapAll 'g-2'                   # 5260.00

  # 4. IEB: COUNTBLANK and COUNTA on the Paid on column.
  $null = $ws.Range('H10').Select(); SnapAll 'b-1'                  # H10 clicked
  $ws.Range('H10').Formula2 = '=COUNTBLANK(E4:E23)'
  $null = $ws.Range('H11').Select(); SnapAll 'b-2'                  # 5; H11 active
  $ws.Range('H11').Formula2 = '=COUNTA(E4:E23)'

  # 5. A percentage of the whole.
  $ws.Range('H13').Formula2 = '=H4/COUNTA($B$4:$B$23)'
  $ws.Range('H13').NumberFormat = '0%'
  $null = $ws.Range('H13').Select(); SnapAll 'p-1'                  # 40%
  "unpaid $($ws.Range('H10').Text), paid $($ws.Range('H11').Text), share $($ws.Range('H13').Text), big $($ws.Range('I8').Text)"

  # 6. Show Formulas: the whole summary.
  $xl.ActiveWindow.DisplayFormulas = $true; Start-Sleep -Milliseconds 800
  $ws.Columns.Item('G').ColumnWidth = 31; $ws.Columns.Item('H').ColumnWidth = 25; $ws.Columns.Item('I').ColumnWidth = 36
  $null = $ws.Range('K4').Select()
  $xl.ActiveWindow.ScrollColumn = 7; Start-Sleep -Milliseconds 600
  SnapAll 's-1'                                                     # columns G to I, every formula in full
  $xl.ActiveWindow.DisplayFormulas = $false; Start-Sleep -Milliseconds 800
  $ws.Columns.Item('G').ColumnWidth = 31; $ws.Columns.Item('H').ColumnWidth = 8; $ws.Columns.Item('I').ColumnWidth = 12
  $xl.ActiveWindow.ScrollColumn = 1; Start-Sleep -Milliseconds 600

  # 7. A mistake: the range not absolute, filled down (Midrand misses rows).
  $ws.Range('I4').Formula2 = '=SUMIF(B4:B23,G4,D4:D23)'
  $null = $ws.Range('I4').AutoFill($ws.Range('I4:I6'), 0)
  $null = $ws.Range('I6').Select(); SnapAll 'm-1'                   # I6: =SUMIF(B6:B25,G6,D6:D25)
  "relative: $($ws.Range('I4').Text), $($ws.Range('I5').Text), $($ws.Range('I6').Text)"

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
