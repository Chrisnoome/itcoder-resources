# Starter files (and done-right copies, to prove the checks) for the upload
# blocks of catexcel lessons 1-4 (content/catexcel/start.php, entering.php,
# formulas.php, formatting.php - 8 October 2026), made in real Excel 365 in
# the CAT VM. The starters go to C:\sims\files\catexcel-files\ (they come back
# to files\catexcel-files\, then public/assets/practical/catexcel/) and to
# Google Drive, G:\My Drive\CAT\Excel\; the -done copies only to C:\sims\files.
#     pwsh -File vm-shots.ps1 catexcel-files
$Name = 'catexcel-files'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$files = "C:\sims\files\$Name"
$cloud = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $files, $cloud | Out-Null
$xl = New-Object -ComObject Excel.Application
$xl.DisplayAlerts = $false

# A new workbook with these sheet names, the first one active.
function NewBook([string[]]$sheets) {
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt $sheets.Count) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  for ($i = 0; $i -lt $sheets.Count; $i++) { $wb.Worksheets.Item($i + 1).Name = $sheets[$i] }
  try { $wb.Author = 'Ms Naidoo' } catch { }
  return $wb
}

# Saves a workbook as .xlsx here (and in Google Drive if it is a starter), then closes it.
function SaveBook($wb, [string]$file, [bool]$starter) {
  $wb.Worksheets.Item(1).Activate()
  $null = $wb.Worksheets.Item(1).Range('A1').Select()
  $wb.SaveAs((Join-Path $files $file), 51)                  # xlOpenXMLWorkbook
  if ($starter) { Copy-Item (Join-Path $files $file) (Join-Path $cloud $file) -Force }
  $wb.Close($false)
  "made $file"
}

try {
  # ---- Lesson 1: BothaPrices.xlsx - the milk tart's price, and a special to add.
  foreach ($done in $false, $true) {
    $wb = NewBook @('Prices', 'Specials')
    $ws = $wb.Worksheets.Item(1); $sp = $wb.Worksheets.Item(2)
    FillRows $ws @(
      @('Item', 'Price', 'Sold', 'Takings'),
      @('White bread', 18, 40, '=B2*C2'),
      @('Brown bread', 17, 25, '=B3*C3'),
      @('Rolls (6)', 22, 12, '=B4*C4'),
      @('Koeksisters', 8, 60, '=B5*C5'),
      @('Milk tart', '', 18, '=B6*C6'),
      @('Total', '', '', '=D2+D3+D4+D5+D6'))
    $ws.Columns.Item('A').ColumnWidth = 16
    FillRows $sp @(@('Special', 'Day', 'Price'), @(), @('Pie and juice', 'Friday', 30))
    $sp.Columns.Item('A').ColumnWidth = 20
    if ($done) { $ws.Range('B6').Formula = '15'; FillRows $sp (,@('Vetkoek and mince', 'Monday', 25)) 2 }
    SaveBook $wb ($(if ($done) { 'BothaPrices-done.xlsx' } else { 'BothaPrices.xlsx' })) (-not $done)
  }

  # ---- Lesson 2: Class10A.xlsx - Ms Naidoo's class list to fix, number and rename.
  foreach ($done in $false, $true) {
    $wb = NewBook @('Sheet1', 'Sheet2')
    $ws = $wb.Worksheets.Item(1)
    FillRows $ws @(
      @('No.', 'Surname', 'Name', 'Term 1', 'Term 2'),
      @('', 'Dlamini', 'Sipho', 64, 70),
      @('', 'Govender', 'Priya', 81, 78),
      @('', 'Khumalo', 'Nomvla', 73, 75),
      @('', 'Molefe', 'Kagiso', 58, 66),
      @('', 'Patel', 'Ayesha', 90, 88),
      @('', 'Van Wyk', 'Johan', 69, 72))
    $ws.Range('G1').Formula = 'Test date'
    $ws.Columns.Item('A').ColumnWidth = 6
    foreach ($col in 'B', 'C', 'D', 'E', 'G', 'H') { $ws.Columns.Item($col).ColumnWidth = 12 }
    if ($done) {
      $ws.Range('C4').Formula = 'Nomvula'
      $null = $ws.Rows.Item(5).Insert()
      $ws.Range('B5').Formula = 'Mahlangu'; $ws.Range('C5').Formula = 'Zanele'
      $ws.Range('A2').Formula = '1'; $ws.Range('A3').Formula = '2'
      $null = $ws.Range('A2:A3').AutoFill($ws.Range('A2:A8'), 0)
      $ws.Range('H1').Formula = '2026/03/12'                # typed as a pupil would (en-ZA: yyyy/mm/dd)
      $ws.Name = '10A'
    }
    SaveBook $wb ($(if ($done) { 'Class10A-done.xlsx' } else { 'Class10A.xlsx' })) (-not $done)
  }

  # ---- Lesson 3: MarketDayOrder.xlsx - amounts, a total and a share, all formulas.
  foreach ($done in $false, $true) {
    $wb = NewBook @('Order')
    $ws = $wb.Worksheets.Item(1)
    FillRows $ws @(
      @('Item', 'Price', 'Quantity', 'Amount'),
      @('Cupcakes', 6, 48),
      @('Koeksisters', 8, 60),
      @('Vetkoek', 10, 40),
      @('Milk tart slices', 15, 24),
      @('Brownies', 12, 36),
      @('Total'),
      @('Discount', '', '', 50),
      @('Each class pays'))
    $ws.Columns.Item('A').ColumnWidth = 18
    if ($done) {
      $ws.Range('D2').Formula = '=B2*C2'
      $null = $ws.Range('D2').AutoFill($ws.Range('D2:D6'), 0)
      $ws.Range('D7').Formula = '=D2+D3+D4+D5+D6'
      $ws.Range('D9').Formula = '=(D7-D8)/2'
    }
    SaveBook $wb ($(if ($done) { 'MarketDayOrder-done.xlsx' } else { 'MarketDayOrder.xlsx' })) (-not $done)
  }

  # ---- Lesson 4: PriceList.xlsx - the new price list, to format.
  foreach ($done in $false, $true) {
    $wb = NewBook @('Prices')
    $ws = $wb.Worksheets.Item(1)
    FillRows $ws @(
      @("Botha's Bakery price list"),
      @(),
      @('Item', 'Old price', 'New price', 'Increase', 'Changed on'),
      @('White bread', 18, 19.5, '=(C4-B4)/B4'),
      @('Brown bread', 17, 18, '=(C5-B5)/B5'),
      @('Rolls (6)', 22, 24, '=(C6-B6)/B6'),
      @('Koeksisters', 8, 8.5, '=(C7-B7)/B7'),
      @('Milk tart', 15, 16.5, '=(C8-B8)/B8'))
    $dates = @('=DATE(2026,3,1)', '=DATE(2026,3,1)', '=DATE(2026,4,1)', '=DATE(2026,5,4)', '=DATE(2026,3,1)')
    for ($i = 0; $i -lt 5; $i++) { $c = $ws.Range("E$(4 + $i)"); $c.Formula = $dates[$i]; $c.Value2 = $c.Value2 }
    $ws.Range('E4:E8').NumberFormat = 'yyyy/mm/dd'
    $ws.Columns.Item('A').ColumnWidth = 16
    foreach ($col in 'B', 'C', 'D', 'E') { $ws.Columns.Item($col).ColumnWidth = 11 }
    if ($done) {
      $null = $ws.Range('A1:E1').Merge(); $ws.Range('A1:E1').HorizontalAlignment = -4108
      $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
      $ws.Range('A3:E3').Font.Bold = $true; $ws.Range('A3:E3').Interior.Color = 65535
      $ws.Range('A3:E3').Borders.Item(9).LineStyle = 1
      $ws.Range('B4:C8').NumberFormat = '_-[$R-en-ZA]* #,##0.00_-;-[$R-en-ZA]* #,##0.00_-;_-[$R-en-ZA]* "-"??_-;_-@_-'
      $ws.Range('D4:D8').NumberFormat = '0.0%'
      $ws.Range('E4:E8').NumberFormat = 'dd mmmm yyyy'
      $null = $ws.Columns.Item('E').AutoFit()
    }
    SaveBook $wb ($(if ($done) { 'PriceList-done.xlsx' } else { 'PriceList.xlsx' })) (-not $done)
  }
}
catch {
  "FAILED: $_"
  throw
}
finally {
  try { $xl.Quit() } catch { Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
