# catexcel Grade 12, Charts for a scenario - simAxisMax's Format Axis pictures (9 October
# 2026). catexcel-charts12x.ps1's real double-clicks on the axis opened Format SHAPE twice;
# here the vertical axis is selected through COM and Ctrl+1 is pressed with the real
# keyboard: the Format Axis pane opens, and 1000 is typed into Maximum.
#   a-1  Format Axis: Bounds and Units, Maximum still Auto
#   a-2  Maximum 1000 (Reset beside it), the axis ending at 1000
# The workbook and chart are built as in catexcel-charts12x.ps1 (the whole chart on the
# window). Nothing saved. Cropped by work/catexcel-real-crop.py catexcel-charts12y 'a-\d'
# 9 58 1851 992 --marks paneMaximum.
#     pwsh -File vm-shots.ps1 catexcel-charts12y            (from the host)
$Name = 'catexcel-charts12y'
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
  RealPark
  RealSnap 's-3'

  # The vertical axis selected through COM, then Ctrl+1 with the real keyboard: Format Axis.
  $chart.Axes(2).Select()
  Start-Sleep -Milliseconds 800
  "selected: $(try { $xl.Selection.Name } catch { '?' })"
  RealFront 1860 1000
  RealKeys 0x11, 0x31 -wait 3000                                    # Ctrl+1
  "pane for: $(try { $xl.Selection.Name } catch { '?' })"
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
