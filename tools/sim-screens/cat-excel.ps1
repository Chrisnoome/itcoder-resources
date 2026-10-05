# Real Excel 365 screens for the CAT pilot's Excel lesson (content/catpilot/
# excel.php - Chris, 5 October 2026). A tuck shop's week of sales; each
# picture is one moment of a task, and out\cat-excel.json says where the
# cells and buttons are (window pixels). Read office-kit.ps1's safety rules
# first: hands off the keyboard and mouse while it runs (about a minute).
#     powershell -ExecutionPolicy Bypass -File cat-excel.ps1
# Then: python cat-crop.py cat-excel
$Name = 'cat-excel'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Week 1'
  $rows = @(
    @('Item', 'Mon', 'Tue', 'Wed', 'Thu', 'Total'),
    @('Pies', 12, 15, 9, 14),
    @('Chips', 30, 26, 31, 28),
    @('Juice', 18, 22, 20, 25),
    @('Muffins', 8, 11, 7, 10),
    @('Total'),
    @('Average'))
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt $rows[$r].Count; $c++) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] } }
  foreach ($col in 'A', 'B', 'C', 'D', 'E', 'F', 'G') { $ws.Columns.Item($col).ColumnWidth = 10 }
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 60, 60, 1300, 640); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 60, 60, 1400, 640)   # sized twice: the ribbon lays itself out again at the full width
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)
  $grid = [Shot]::Child($h, 'EXCEL7')

  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  function CellBox ($address) {
    $cell = $ws.Range($address)
    $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
    $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
    $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
    $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
    return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
  }
  foreach ($a in 'A1', 'B6', 'B7', 'F2', 'F5', 'B2') { Mark $a (CellBox $a) }
  $a1 = CellBox 'A1'
  Mark 'row1' @(($a1[0] - 34), $a1[1], 30, $a1[3])                  # row 1's heading, left of A1
  $f2 = CellBox 'F2'
  Mark 'fillF2' @(($f2[0] + $f2[2] - 9), ($f2[1] + $f2[3] - 9), 18, 18)   # the fill handle: F2's bottom-right corner
  Mark 'formulaBar' (Box (Find $root @('Formula Bar') -tries 4))
  Dump 'home'

  # 1. A total for one row, typed.
  Snap 'sum-1'                                                      # A1 active
  $null = $ws.Range('F2').Select();  Snap 'sum-2'                   # F2 clicked
  $ws.Range('F2').Formula = '=SUM(B2:E2)'
  $null = $ws.Range('F3').Select();  Snap 'sum-3'                   # Enter: F2 shows 50, F3 active

  # 2. Fill it down with the fill handle.
  $null = $ws.Range('F2').Select();  Snap 'fill-1'                  # F2 clicked: the fill handle at its corner
  $null = $ws.Range('F2').AutoFill($ws.Range('F2:F5'), 0)
  $null = $ws.Range('F2:F5').Select(); Snap 'fill-2'                # double-clicked: F2:F5 filled

  # 3. A column total with AutoSum, on the Formulas tab.
  $null = $ws.Range('B6').Select();  Snap 'auto-1'                  # B6 clicked
  Press (Find $root @('Formulas') $T::TabItem)
  Start-Sleep -Milliseconds 800
  $auto = Find $root @('AutoSum', 'Sum')
  Mark 'tabFormulas' (Box (Find $root @('Formulas') $T::TabItem))
  Mark 'autoSum' (Box $auto)
  Dump 'formulas'
  Snap 'auto-2'                                                     # the Formulas tab
  Press $auto
  Start-Sleep -Milliseconds 1200
  Snap 'auto-3'                                                     # =SUM(B2:B5) waiting in B6
  [Shot]::PostKey($grid, 0x0D)                                      # Enter, posted to Excel's grid
  Start-Sleep -Milliseconds 1500
  Snap 'auto-4'                                                     # B6 shows 68; B7 active

  # 4. An average, typed straight into the active cell.
  $ws.Range('B7').Formula = '=AVERAGE(B2:B5)'
  $null = $ws.Range('B8').Select();  Snap 'avg-1'                   # Enter: B7 shows 17

  # 5. Bold headings: select row 1, then Bold on the Home tab.
  Press (Find $root @('Home') $T::TabItem)
  Start-Sleep -Milliseconds 800
  Mark 'tabHome' (Box (Find $root @('Home') $T::TabItem))
  Mark 'bold' (Box (Find $root @('Bold') $T::Button))
  Snap 'bold-1'                                                     # Home tab, B8 active
  $null = $ws.Rows.Item(1).Select(); Snap 'bold-2'                  # row 1 selected
  $ws.Rows.Item(1).Font.Bold = $true; Snap 'bold-3'                 # Bold pressed

  SaveMarks
}
catch {
  "FAILED: $_"
  throw
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { } }
  $xl.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
