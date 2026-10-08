# Real Excel 365 screens for catexcel lesson 5, SUM, AVERAGE, MIN, MAX and
# COUNT (AIPascalCourse/content/catexcel/functions.php - written to
# courses/cat-practical-writing.md, 8 October 2026). Ms Naidoo's test marks
# for Grade 10A; each picture is one moment of a task, and
# out\catexcel-functions.json says where the cells and buttons are (window
# pixels). Also makes the pupils' starter file Marks10B.xlsx (and a done-right
# copy for checking the upload block) in C:\sims\files\catexcel-functions\
# and G:\My Drive\CAT\Excel\. Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-functions        (from the host)
$Name = 'catexcel-functions'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function Fill ($ws, $rows) {
  for ($r = 0; $r -lt $rows.Count; $r++) {
    for ($c = 0; $c -lt $rows[$r].Count; $c++) {
      if ($null -ne $rows[$r][$c] -and [string]$rows[$r][$c] -ne '') { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$rows[$r][$c] }
    }
  }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false

  # ---------------------------------------------------------------- the starter file (10B) and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1)
  $ss.Name = 'Marks'
  Fill $ss @(
    @('Name', 'Test 1', 'Test 2', 'Test 3', 'Total'),
    @('Hlengiwe', 36, 40, 42),
    @('Imran', 22, 30, 28),
    @('Jabu', 44, 46, 48),
    @('Karabo', 31, 'ABS', 35),
    @('Lindiwe', 39, 41, 37),
    @('Mpho', 27, 33, 30),
    @('Nadia', 48, 45, 49),
    @('Owen', 18, 24, 21),
    @(''),
    @('Highest'),
    @('Lowest'),
    @('Average'),
    @('Number written'))
  $ss.Columns.Item('A').ColumnWidth = 15
  foreach ($col in 'B', 'C', 'D', 'E') { $ss.Columns.Item($col).ColumnWidth = 9 }
  $ss.Rows.Item(1).Font.Bold = $true
  $ss.Range('B13:D13').NumberFormat = '0.0'
  $null = $ss.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'Marks10B.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'Marks10B.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  # The task done: totals filled down, the four functions under each test.
  $ss.Range('E2').Formula = '=SUM(B2:D2)'
  $null = $ss.Range('E2').AutoFill($ss.Range('E2:E9'), 0)
  $ss.Range('B11').Formula = '=MAX(B2:B9)'
  $ss.Range('B12').Formula = '=MIN(B2:B9)'
  $ss.Range('B13').Formula = '=AVERAGE(B2:B9)'
  $ss.Range('B14').Formula = '=COUNT(B2:B9)'
  $null = $ss.Range('B11:B14').AutoFill($ss.Range('B11:D14'), 0)
  $sb.SaveAs((Join-Path $filesDir 'Marks10B-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's sheet (10A)
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Term 1'
  Fill $ws @(
    @('Name', 'Test 1', 'Test 2', 'Test 3', 'Total'),
    @('Ayanda', 34, 41, 38),
    @('Bongani', 28, 'ABS', 31),
    @('Chloe', 45, 47, 44),
    @('Dineo', 19, 25, 27),
    @('Ethan', 37, 33, 40),
    @('Fatima', 41, 44, 46),
    @('Gift', 30, 36, 35),
    @(''),
    @('Highest'),
    @('Lowest'),
    @('Average'),
    @('Written'))
  $ws.Columns.Item('A').ColumnWidth = 11
  foreach ($col in 'B', 'C', 'D', 'E', 'F', 'G', 'H') { $ws.Columns.Item($col).ColumnWidth = 9 }
  $ws.Rows.Item(1).Font.Bold = $true
  $ws.Range('B12:D12').NumberFormat = '0.0'
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1500, 760); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1600, 760)   # sized twice: the ribbon lays itself out again at the full width
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
  foreach ($a in 'A1', 'E2', 'B10', 'C10', 'D10', 'B12', 'C13', 'B2', 'H14') { Mark $a (CellBox $a) }
  TryMark 'nameBox'    $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  TryMark 'autoSum'    $root @('AutoSum', 'Sum')
  TryMark 'tabHome'    $root @('Home') $T::TabItem
  TryMark 'tabFormulas' $root @('Formulas') $T::TabItem
  Dump 'home'

  # 1. A pupil's total with AutoSum (Alt+= does the same as the button).
  Snap 'f-1'                                                        # A1 active, the sheet as Ms Naidoo left it
  $null = $ws.Range('E2').Select();  Snap 'sum-1'                   # E2 clicked
  Press (Find $root @('AutoSum', 'Sum'))
  Start-Sleep -Milliseconds 1200
  Snap 'sum-2'                                                      # =SUM(B2:D2) waiting in E2
  [Shot]::PostKey($grid, 0x0D)                                      # Enter, posted to Excel's grid
  Start-Sleep -Milliseconds 1500
  Snap 'sum-3'                                                      # E2 shows 113; E3 active
  $ws.Range('E2').Formula = '=SUM(B2:D2)'                           # (in case the posted Enter went astray)
  $null = $ws.Range('E2').AutoFill($ws.Range('E2:E8'), 0)
  $null = $ws.Range('E3').Select(); Snap 'sum-4'                    # every total filled down; Bongani 59

  # 2. The highest mark, typed.
  $null = $ws.Range('B10').Select(); Snap 'max-1'                   # B10 clicked
  $ws.Range('B10').Formula = '=MAX(B2:B8)'
  $null = $ws.Range('B11').Select(); Snap 'max-2'                   # Enter: 45, B11 active

  # 3. Copy it right with Ctrl+R.
  $null = $ws.Range('B10:D10').Select(); Snap 'fill-1'              # B10:D10 selected
  $null = $ws.Range('B10').AutoFill($ws.Range('B10:D10'), 0)
  Snap 'fill-2'                                                     # 45, 47, 46
  $null = $ws.Range('C10').Select(); Snap 'fill-3'                  # C10 clicked: =MAX(C2:C8) in the Formula Bar

  # 4. MIN and COUNT in for the figure; then a range name for the average.
  $ws.Range('B11').Formula = '=MIN(B2:B8)'
  $null = $ws.Range('B11').AutoFill($ws.Range('B11:D11'), 0)
  $ws.Range('B13').Formula = '=COUNT(B2:B8)'
  $null = $ws.Range('B13').AutoFill($ws.Range('B13:D13'), 0)
  $null = $ws.Range('C13').Select(); Snap 'count-1'                 # C13: =COUNT(C2:C8) gives 6

  $null = $ws.Range('B2:B8').Select(); Snap 'name-1'                # B2:B8 selected; the Name Box says B2
  $null = $wb.Names.Add('Test1', "='Term 1'!`$B`$2:`$B`$8")
  # (No picture of the Name Box showing Test1: a name made through COM never shows there in a PrintWindow picture -
  # the lesson's step after naming uses name-1 again.)
  $null = $ws.Range('B12').Select(); Snap 'name-3'                  # B12 clicked
  $ws.Range('B12').Formula = '=AVERAGE(Test1)'
  $null = $ws.Range('B13').Select(); Snap 'name-4'                  # Enter: 33.4

  # 5. All of it, values and then formulas.
  $ws.Range('C12').Formula = '=AVERAGE(C2:C8)'
  $ws.Range('D12').Formula = '=AVERAGE(D2:D8)'
  $null = $ws.Range('H14').Select(); Snap 'all-1'
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 600
  Snap 'all-2'                                                      # Show Formulas: what is really in each cell
  $xl.ActiveWindow.DisplayFormulas = $false

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
