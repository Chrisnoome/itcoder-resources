# catexcel Grade 12, Charts for a scenario - the third run (9 October 2026, the
# last CAT practical gaps). What catexcel-charts122.ps1 missed:
#   a-*  its double-click on the vertical axis hit the chart's edge (Format Chart
#        Area opened): here a real double-click on the axis's own numbers, the
#        Format Axis pane, and 1000 typed into Maximum;
#   c-*  Chart Design > Change Chart Type (its Esc had left the chart, so the
#        click landed on Home's Format): the chart clicked again first, then the
#        Change Chart Type box and its Combo page.
# The workbook and the chart (the same size and place, stacked, the whole chart
# on the window) are built as in catexcel-charts122.ps1. Nothing saved.
# Uses REAL mouse and keyboard input inside the VM (work\catexcel-real-kit.ps1).
#     pwsh -File vm-shots.ps1 catexcel-charts12x -TimeoutSec 900   (from the host)
# Runs (9 October 2026): run 1 made c-0..c-2 (used); runs 1 and 2 both opened Format SHAPE, not
# Format Axis, on the double-click (a-1 shows it) - the axis pictures are NOT made; given up after two tries.
param([int]$AxisX = 470, [int]$AxisY = 600, [switch]$NoChartType)
$Name = 'catexcel-charts12x'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-real-kit.ps1')

function Heads ($ws, $range) {
  $ws.Range($range).Font.Bold = $true
  try { $ws.Range($range).Interior.Color = 0xF2E6D9 } catch { }
}
function RecyclingSheet ($ws, $rows) {
  $ws.Range('A1').Formula = 'Phumlani Secondary - recycling drive (kg)'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill12 $ws @(,@('Month', 'Paper', 'Plastic', 'Cans')) 3
  Fill12 $ws $rows 4
  Heads $ws 'A3:D3'
  $ws.Columns.Item('A').ColumnWidth = 9
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 8 }
}
$monthsA = @(@('Feb', 180, 120, 60), @('Mar', 240, 150, 80), @('Apr', 210, 170, 70), @('May', 320, 200, 110), @('Jun', 290, 260, 90), @('Jul', 380, 310, 140))

# The newest small window of Excel's (a gallery, a menu): [x, y, w, h] in window pixels.
function PopRect ([int]$maxW = 900, [int]$maxH = 900) {
  $w0 = [WinRect]::Of($h); $found = $null
  foreach ($d in [Comp12]::Others($h)) { $r = [Comp12]::Rect($d); if ($r[2] -le $maxW -and $r[3] -le $maxH -and $r[2] -gt 40) { $found = @(($r[0] - $w0[0]), ($r[1] - $w0[1]), $r[2], $r[3]) } }
  return $found
}
function BigRect {
  $w0 = [WinRect]::Of($h); $best = $null
  foreach ($d in [Comp12]::Others($h)) { $r = [Comp12]::Rect($d); if (-not $best -or $r[2] * $r[3] -gt $best[2] * $best[3]) { $best = $r } }
  if ($best) { return @(($best[0] - $w0[0]), ($best[1] - $w0[1]), $best[2], $best[3]) }
  return $null
}
function TryFindAny ($key, [string[]]$names, $type = $null) {
  try { Mark $key (Box (FindAny $names $type -tries 6)); return $true } catch { "  MISSING $key ($($names -join ' / '))"; return $false }
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Recycling'
  RecyclingSheet $ws $monthsA
  $null = $ws.Range('A3:D9').Select()
  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  RealFront 1860 1000
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 1500
  $root = $AE::FromHandle($h)
  $shape = $ws.Shapes.AddChart2(297, 52); $shape.Chart.SetSourceData($ws.Range('A3:D9'))
  $chart = $shape.Chart
  $shape.Left = $ws.Range('F3').Left; $shape.Top = $ws.Range('F3').Top
  $shape.Width = 500; $shape.Height = 290
  $chart.HasTitle = $true; $chart.ChartTitle.Text = 'Recycling drive (kg)'
  $null = $shape.Select()
  Start-Sleep -Milliseconds 1200
  Mark 'axisNumbers' @(($AxisX - 14), ($AxisY - 9), 28, 18)
  RealPark
  RealSnap 's-3'                                                    # the chart, selected, whole (as charts122's s-3)

  # 1. The chart clicked first (run 1: a double-click on a chart selected only through COM opened
  # Format Shape), the axis's numbers clicked once, then double-clicked: the Format Axis pane.
  Mark 'chartEdge' @(1241, 356, 24, 16)
  RealClickBox $script:marks['chartEdge'] -wait 1200
  RealClickBox $script:marks['axisNumbers'] -wait 1200
  "selected first: $(try { $xl.Selection.Name } catch { '?' })"
  RealClickBox $script:marks['axisNumbers'] -Double -wait 3000
  "selection: $(try { $xl.Selection.Name } catch { '?' })"
  Dump 'axispane'
  $max = $null
  try { $max = FindAny @('Maximum') $T::Edit -tries 8 } catch { }
  if (-not $max) { try { $max = FindAny @('Maximum') -tries 4 } catch { } }
  if ($max) { Mark 'paneMaximum' (Box $max) } else { '  MISSING paneMaximum' }
  TryFindAny 'paneClose' @('Close pane') $T::Button | Out-Null
  RealPark
  RealSnap 'a-1'                                                    # Format Axis: Bounds and Units
  if ($script:marks['paneMaximum']) {
    RealClickBox $script:marks['paneMaximum'] -wait 400
    RealKeys 0x11, 0x41 -wait 300                                   # Ctrl+A in the box
    RealType "1000`n" -wait 1500
    RealPark
    RealSnap 'a-2'                                                  # Maximum 1000 (Reset beside it)
  }
  "axis: max $($chart.Axes(2).MaximumScale) (auto $($chart.Axes(2).MaximumScaleIsAuto))"
  if ($script:marks['paneClose']) { RealClickBox $script:marks['paneClose'] -wait 1000 }

  # 2. Change Chart Type: the chart clicked (an empty corner), Chart Design, Change Chart Type.
  if (-not $NoChartType) {
  RealClickBox $script:marks['chartEdge'] -wait 1200
  TryMark 'tabChartDesign' $root @('Chart Design') $T::TabItem
  if ($script:marks['tabChartDesign']) { RealClickBox $script:marks['tabChartDesign'] -wait 1200 }
  TryMark 'cdChangeChartType' $root @('Change Chart Type', 'Change Chart Type...')
  RealPark
  RealSnap 'c-0'                                                    # the Chart Design tab
  if ($script:marks['cdChangeChartType']) {
    RealClickBox $script:marks['cdChangeChartType'] -wait 2500
    WaitOthers
    $ct = BigRect; if ($ct) { Mark 'ctDialog' $ct }
    DumpOthers 'charttype'
    $okc = TryFindAny 'ctCombo' @('Combo')
    RealPark
    RealSnap 'c-1'                                                  # Change Chart Type: All Charts
    if ($okc) { RealClickBox $script:marks['ctCombo'] -wait 1500; RealPark; RealSnap 'c-2' }   # the Combo page
    RealKeys 0x1B -wait 1200
  }
  }
  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { SaveMarks } catch { }
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
