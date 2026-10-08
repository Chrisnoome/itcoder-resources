# Real Excel 365 screens for catexcel lesson 6, More functions and error
# values (AIPascalCourse/content/catexcel/more.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Botha's Bakery's loaves
# for two weeks: TODAY, MEDIAN, MODE, a comparison with >, COUNTIF and its
# kin, RANDBETWEEN; then a sheet of Mr Botha's nephew's mistakes, one error
# value each. Also makes the pupils' starter file Loaves.xlsx (and a
# done-right copy) in C:\sims\files\catexcel-more\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-more        (from the host)
$Name = 'catexcel-more'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Fill ($ws, $rows, $startRow = 1, $startCol = 0) {
  for ($r = 0; $r -lt $rows.Count; $r++) {
    for ($c = 0; $c -lt $rows[$r].Count; $c++) {
      if ($null -ne $rows[$r][$c] -and [string]$rows[$r][$c] -ne '') { $ws.Range(([string][char](65 + $startCol + $c)) + ($r + $startRow)).Formula = [string]$rows[$r][$c] }
    }
  }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1)
  $ss.Name = 'Loaves'
  Fill $ss @(
    @('Day', 'Loaves', 'Over 100?'),
    @('Mon 19 Oct', 90), @('Tue 20 Oct', 98), @('Wed 21 Oct', 87), @('Thu 22 Oct', 102),
    @('Fri 23 Oct', 128), @('Sat 24 Oct', 146), @('Mon 26 Oct', 95), @('Tue 27 Oct', 98),
    @('Wed 28 Oct', 110), @('Thu 29 Oct', 98), @('Fri 30 Oct', 133), @('Sat 31 Oct', 155))
  Fill $ss @(@('Today'), @('Median'), @('Mode'), @(''), @('Average', '=AVRAGE(B2:B13)')) 1 4
  $ss.Range('F5').Formula2 = '=AVRAGE(B2:B13)'                     # Formula2: as typed (Formula would add an @)
  $ss.Columns.Item('A').ColumnWidth = 12
  foreach ($col in 'B', 'C') { $ss.Columns.Item($col).ColumnWidth = 10 }
  $ss.Columns.Item('E').ColumnWidth = 10
  $ss.Columns.Item('F').ColumnWidth = 12
  $ss.Rows.Item(1).Font.Bold = $true
  $ss.Range('F5').NumberFormat = '0.0'
  $null = $ss.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'Loaves.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'Loaves.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  $ss.Range('F1').Formula = '=TODAY()'
  $ss.Range('F2').Formula = '=MEDIAN(B2:B13)'
  $ss.Range('F3').Formula = '=MODE(B2:B13)'
  $ss.Range('F5').Formula = '=AVERAGE(B2:B13)'
  $ss.Range('C2').Formula = '=B2>100'
  $null = $ss.Range('C2').AutoFill($ss.Range('C2:C13'), 0)
  $sb.SaveAs((Join-Path $filesDir 'Loaves-done.xlsx'), 51)
  "starter check: median $($ss.Range('F2').Text), mode $($ss.Range('F3').Text), average $($ss.Range('F5').Text)"
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Loaves'
  $wm = $wb.Worksheets.Item(2)
  $wm.Name = 'Mistakes'
  Fill $ws @(
    @('Day', 'Loaves', 'Over 100?'),
    @('Mon 5 Oct', 96), @('Tue 6 Oct', 88), @('Wed 7 Oct', 104), @('Thu 8 Oct', 96),
    @('Fri 9 Oct', 131), @('Sat 10 Oct', 142), @('Mon 12 Oct', 92), @('Tue 13 Oct', ''),
    @('Wed 14 Oct', 101), @('Thu 15 Oct', 96), @('Fri 16 Oct', 125), @('Sat 17 Oct', 150))
  Fill $ws @(@('Today'), @('Median'), @('Mode'), @('Over 100'), @('Days open'), @('Days closed'), @('Lucky draw')) 1 4
  $ws.Columns.Item('A').ColumnWidth = 12
  foreach ($col in 'B', 'C', 'D') { $ws.Columns.Item($col).ColumnWidth = 10 }
  $ws.Columns.Item('E').ColumnWidth = 11
  $ws.Columns.Item('F').ColumnWidth = 12
  foreach ($col in 'G', 'H', 'I') { $ws.Columns.Item($col).ColumnWidth = 9 }
  $ws.Rows.Item(1).Font.Bold = $true

  # The nephew's mistakes: one error value per row.
  Fill $wm @(
    @('What he wanted', 'First', 'Second', 'Answer'),
    @('Loaves per day', 120, 0, '=B2/C2'),
    @('Takings', 96, 'sixteen', '=B3*C3'),
    @('Average', 96, 88, '=AVRAGE(B4:C4)'),
    @('Total', 96, '', '=B5+B20'),
    @('Lucky draw', 100, 1, '=RANDBETWEEN(B6,C6)'),
    @('Today', '', '', '=TODAY()'))
  $wm.Range('D4').Formula2 = '=AVRAGE(B4:C4)'                      # Formula2: as typed (Formula would add an @)
  $wm.Range('B20').Formula = '50'
  $null = $wm.Rows.Item(20).Delete()                                # D5 becomes =B5+#REF!
  $wm.Range('D7').NumberFormat = 'dddd, d mmmm yyyy'
  $wm.Columns.Item('A').ColumnWidth = 16
  foreach ($col in 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I') { $wm.Columns.Item($col).ColumnWidth = 9 }
  $wm.Rows.Item(1).Font.Bold = $true
  $null = $ws.Activate()
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1500, 760); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1600, 760)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  $win  = [WinRect]::Of($h)
  function CellBox ($sheet, $address) {
    $pane = $xl.ActiveWindow.ActivePane
    $cell = $sheet.Range($address)
    $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
    $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
    $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
    $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
    return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
  }
  foreach ($a in 'F1', 'F2', 'F3', 'F4', 'C2', 'C3') { Mark $a (CellBox $ws $a) }
  $c2 = CellBox $ws 'C2'
  Mark 'fillC2' @(($c2[0] + $c2[2] - 9), ($c2[1] + $c2[3] - 9), 18, 18)
  TryMark 'nameBox'    $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  Dump 'home'

  # 1. Today, the median and the mode, one after the other (Enter moves down).
  Snap 'm-0'                                                        # A1 active
  $null = $ws.Range('F1').Select(); Snap 'm-1'                      # F1 clicked
  $ws.Range('F1').Formula = '=TODAY()'
  $null = $ws.Range('F2').Select(); Snap 'm-2'                      # the date; F2 active
  $ws.Range('F2').Formula = '=MEDIAN(B2:B13)'
  $null = $ws.Range('F3').Select(); Snap 'm-3'                      # 101; F3 active
  $ws.Range('F3').Formula = '=MODE(B2:B13)'
  $null = $ws.Range('F4').Select(); Snap 'm-4'                      # 96; F4 active
  "today shows $($ws.Range('F1').Text), median $($ws.Range('F2').Text), mode $($ws.Range('F3').Text)"

  # 2. A comparison: =B2>100, then filled down.
  $null = $ws.Range('C2').Select(); Snap 'r-1'                      # C2 clicked
  $ws.Range('C2').Formula = '=B2>100'
  $null = $ws.Range('C3').Select(); Snap 'r-2'                      # FALSE; C3 active
  $null = $ws.Range('C2').Select(); Snap 'r-3'                      # C2 clicked again: its fill handle
  $null = $ws.Range('C2').AutoFill($ws.Range('C2:C13'), 0)
  $null = $ws.Range('C2:C13').Select(); Snap 'r-4'                  # TRUE and FALSE all the way down

  # 3. COUNTIF and the other counts (CAPS), and a lucky draw.
  $null = $ws.Range('F4').Select(); Snap 'c-1'                      # F4 clicked
  $ws.Range('F4').Formula = '=COUNTIF(B2:B13,">100")'
  $null = $ws.Range('F5').Select(); Snap 'c-2'                      # 6; F5 active
  $ws.Range('F5').Formula = '=COUNTA(B2:B13)'
  $ws.Range('F6').Formula = '=COUNTBLANK(B2:B13)'
  $ws.Range('F7').Formula = '=RANDBETWEEN(1,50)'
  $null = $ws.Range('F7').Select(); Snap 'c-3'
  "countif $($ws.Range('F4').Text), counta $($ws.Range('F5').Text), countblank $($ws.Range('F6').Text), lucky draw $($ws.Range('F7').Text)"

  # 4. The mistakes sheet: every error value, then the formulas behind them.
  $null = $wm.Activate()
  $null = $wm.Range('A1').Select()
  Start-Sleep -Milliseconds 800
  foreach ($a in 'D2', 'D3', 'D4', 'D5', 'D6', 'D7') { Mark ('mistakes' + $a) (CellBox $wm $a) }
  $d1 = CellBox $wm 'D1'
  Mark 'borderD' @(($d1[0] + $d1[2] - 6), ($d1[1] - $d1[3] - 2), 12, $d1[3])   # the line between the D and E headings
  Snap 'e-1'                                                        # six error values
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 600
  Snap 'e-2'                                                        # the formulas behind them
  $xl.ActiveWindow.DisplayFormulas = $false
  Start-Sleep -Milliseconds 600
  $null = $wm.Columns.Item('D').AutoFit()
  Start-Sleep -Milliseconds 600
  Snap 'e-3'                                                        # column D double-clicked wider: the date shows
  Mark 'mistakesD4wide' (CellBox $wm 'D4')
  $null = $wm.Range('D4').Select(); Snap 'e-4'                      # D4 (#NAME?) clicked
  $wm.Range('D4').Formula = '=AVERAGE(B4:C4)'
  $null = $wm.Range('D5').Select(); Snap 'e-5'                      # 92

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
