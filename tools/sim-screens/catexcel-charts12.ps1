# Real Excel 365 screens for catexcel Grade 12, Charts for a scenario
# (AIPascalCourse/content/catexcel/charts12.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# recycling drive, kg a month: a stacked column chart from the Insert tab's
# gallery; the vertical axis and its Format Axis pane (Minimum, Maximum,
# Major unit); axis titles; Select Data (re-labelling the axis); a
# pictograph (bottles stacked and scaled, one picture = 100 kg); (CAPS) a
# linear trendline; and (IEB) a combo chart (columns and a line on a second
# axis), the largest pie slice pulled out, and line sparklines. Also makes
# the pupils' starter file Recycling12.xlsx (and a done-right copy) in
# C:\sims\files\catexcel-charts12\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-charts12 -TimeoutSec 1200   (from the host)
$Name = 'catexcel-charts12'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

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

# A plastic bottle, drawn here, for the pictograph.
function BottlePng ([string]$path) {
  $bmp = New-Object Drawing.Bitmap 60, 120
  $g = [Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.Clear([Drawing.Color]::Transparent)
  $blue = New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(40, 140, 210))
  $cap  = New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(20, 90, 160))
  $g.FillRectangle($cap, 22, 2, 16, 12)
  $g.FillRectangle($blue, 24, 14, 12, 10)
  $g.FillEllipse($blue, 10, 18, 40, 28)
  $g.FillRectangle($blue, 10, 32, 40, 82)
  $g.FillRectangle((New-Object Drawing.SolidBrush ([Drawing.Color]::White)), 14, 58, 32, 22)
  $g.Dispose(); $bmp.Save($path, [Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
}

$monthsA = @(@('Feb', 180, 120, 60), @('Mar', 240, 150, 80), @('Apr', 210, 170, 70), @('May', 320, 200, 110), @('Jun', 290, 260, 90), @('Jul', 380, 310, 140))
$monthsB = @(@('Feb', 150, 90, 40), @('Mar', 220, 130, 75), @('Apr', 260, 160, 60), @('May', 300, 210, 95), @('Jun', 280, 240, 120),
             @('Jul', 350, 300, 130), @('Aug', 410, 330, 150), @('Sep', 390, 360, 170), @('Oct', 450, 400, 190))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Recycling'
  RecyclingSheet $ss $monthsB
  $ss.Range('A13').Formula = 'Total'; $ss.Range('A13').Font.Bold = $true
  foreach ($c in 'B', 'C', 'D') { $ss.Range("$($c)13").Formula2 = "=SUM($($c)4:$($c)12)" }
  $null = $ss.Range('A1').Select()
  SaveStarter $sb 'Recycling12.xlsx'
  $co = $ss.ChartObjects().Add(300, 20, 460, 280)
  $co.Chart.SetSourceData($ss.Range('A3:D12'))
  $co.Chart.ChartType = 52                                          # xlColumnStacked
  $co.Chart.HasTitle = $true; $co.Chart.ChartTitle.Text = 'Recycling 2026 (kg)'
  $co.Chart.Axes(2).MaximumScale = 1200; $co.Chart.Axes(2).MajorUnit = 200
  $co.Chart.Axes(1).HasTitle = $true; $co.Chart.Axes(1).AxisTitle.Text = 'Month'
  $co.Chart.Axes(2).HasTitle = $true; $co.Chart.Axes(2).AxisTitle.Text = 'Mass (kg)'
  $cp = $ss.ChartObjects().Add(300, 320, 360, 240)
  $cp.Chart.SetSourceData($ss.Range('B3:D3,B13:D13'))
  $cp.Chart.ChartType = 5                                           # xlPie
  $cp.Chart.HasTitle = $true; $cp.Chart.ChartTitle.Text = 'Total recycled by material'
  $sb.SaveAs((Join-Path $filesDir 'Recycling12-done.xlsx'), 51)
  "done totals: $($ss.Range('B13').Text) $($ss.Range('C13').Text) $($ss.Range('D13').Text)"
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Recycling'
  RecyclingSheet $ws $monthsA
  $null = $ws.Range('A3:D9').Select()
  ShowExcel 1860 820 10
  $root = $AE::FromHandle($h)
  MarkCells $ws @('A3:D9', 'F3')
  foreach ($tab in 'Home', 'Insert') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }

  # 1. A stacked column chart from the Insert tab's gallery.
  SnapAll 's-0'                                                     # Home tab, A3:D9 selected
  Tab 'Insert'
  Dump 'insert'
  TryMark 'btnColumn' $root @('Insert Column or Bar Chart')
  SnapAll 's-1'                                                     # the Insert tab
  try {
    $colBtn = Find $root @('Insert Column or Bar Chart') -tries 6
    Expand $colBtn; WaitOthers
    DumpOthers 'colgallery'
    MarkAny 'galStacked' @('Stacked Column')
    MarkAny 'galClustered' @('Clustered Column')
    SnapAll 's-2' -Others                                           # the gallery open
    Collapse $colBtn
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "column gallery: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $shape = $ws.Shapes.AddChart2(297, 52, 330, 40, 520, 320)       # a stacked column chart, beside the data
  $chart = $shape.Chart
  $chart.SetSourceData($ws.Range('A3:D9'))
  $chart.HasTitle = $true; $chart.ChartTitle.Text = 'Recycling drive (kg)'
  Start-Sleep -Milliseconds 1500
  $null = $shape.Select()
  Start-Sleep -Milliseconds 800
  SnapAll 's-3'                                                     # the chart, selected (Chart Design tab)
  Dump 'chartdesign'
  foreach ($nm in 'Add Chart Element', 'Select Data...', 'Select Data', 'Change Chart Type...', 'Change Chart Type', 'Switch Row/Column') { TryMark ('cd' + ($nm -replace '[ ./]', '')) $root @($nm) }

  # chart pixels: where the vertical axis is
  $pane = $xl.ActiveWindow.ActivePane; $win = [WinRect]::Of($h)
  function ChartPart ($co, $part) {
    $x1 = $pane.PointsToScreenPixelsX($co.Left + $part.Left) - $win[0]
    $x2 = $pane.PointsToScreenPixelsX($co.Left + $part.Left + $part.Width) - $win[0]
    $y1 = $pane.PointsToScreenPixelsY($co.Top + $part.Top) - $win[1]
    $y2 = $pane.PointsToScreenPixelsY($co.Top + $part.Top + $part.Height) - $win[1]
    return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
  }
  try { Mark 'valueAxis' (ChartPart $shape $chart.Axes(2)) } catch { "axis place: $_" }
  try { Mark 'plotArea' (ChartPart $shape $chart.PlotArea) } catch { }
  try { Mark 'chartTitle' (ChartPart $shape $chart.ChartTitle) } catch { }

  # 2. The vertical axis: Format Axis pane, Maximum 1000.
  try {
    $null = $chart.Axes(2).Select()
    Start-Sleep -Milliseconds 600
    $null = $xl.CommandBars.ExecuteMso('ChartFormatSelection')
    Start-Sleep -Milliseconds 2500
    Dump 'axispane'
    MarkAny 'paneMinimum' @('Minimum') $T::Edit
    MarkAny 'paneMaximum' @('Maximum') $T::Edit
    MarkAny 'paneMajor' @('Major') $T::Edit
    SnapAll 'a-1'                                                   # the Format Axis pane: Bounds, Units
    $chart.Axes(2).MaximumScale = 1000
    $chart.Axes(2).MajorUnit = 200
    Start-Sleep -Milliseconds 1200
    SnapAll 'a-2'                                                   # Maximum 1000, Major 200
  } catch { "axis pane: $_" }
  try { $null = $xl.CommandBars.ExecuteMso('ChartFormatSelection') } catch { }
  # close the pane: its own Close button
  try { foreach ($b in @($root.FindAll($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Close pane')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))))) { Press $b; Start-Sleep -Milliseconds 800; break } } catch { }
  "axis: max $($chart.Axes(2).MaximumScale) unit $($chart.Axes(2).MajorUnit)"

  # 3. Axis titles, through the Add Chart Element menu (pictured), then set.
  $null = $shape.Select(); Start-Sleep -Milliseconds 600
  try {
    $ace = Find $root @('Add Chart Element') -tries 6
    Expand $ace; WaitOthers
    DumpOthers 'acemenu'
    SnapAll 'a-3' -Others                                           # Add Chart Element menu
    try {
      $at = FindAny @('Axis Titles') -tries 4
      Expand $at; Start-Sleep -Milliseconds 1200
      DumpOthers 'acetitles'
      SnapAll 'a-4' -Others                                         # Axis Titles: Primary Horizontal, Primary Vertical
    } catch { "axis titles menu: $_" }
    Collapse $ace
    if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "add chart element: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $chart.Axes(1).HasTitle = $true; $chart.Axes(1).AxisTitle.Text = 'Month (2026)'
  $chart.Axes(2).HasTitle = $true; $chart.Axes(2).AxisTitle.Text = 'Mass (kg)'
  Start-Sleep -Milliseconds 1000
  $null = $ws.Range('F22').Select()
  SnapAll 'a-5'                                                     # axis titles, maximum 1000

  # 4. Select Data: the horizontal axis labels.
  $null = $shape.Select(); Start-Sleep -Milliseconds 600
  try {
    PressAsync (Find $root @('Select Data...', 'Select Data') -tries 6)
    WaitOthers
    DumpOthers 'selectdata'
    SnapAll 'a-6' -Others                                           # Select Data Source
    CloseOthers
  } catch { "select data: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }

  # 5. A pictograph: Plastic only, bottles stacked and scaled (one bottle = 100 kg).
  $png = Join-Path $env:TEMP 'catexcel-bottle.png'
  BottlePng $png
  $wsP = $wb.Worksheets.Add([Type]::Missing, $ws); $wsP.Name = 'Pictograph'
  RecyclingSheet $wsP $monthsA
  $null = $wsP.Activate()
  $ps = $wsP.Shapes.AddChart2(201, 51, 300, 30, 460, 300)           # a clustered column chart
  $pc = $ps.Chart
  $pc.SetSourceData($wsP.Range('A3:A9,C3:C9'))
  $pc.HasTitle = $true; $pc.ChartTitle.Text = 'Plastic collected (kg) - one bottle is 100 kg'
  try { $pc.HasLegend = $false } catch { }
  $ser = $pc.SeriesCollection(1)
  try { $ser.Format.Fill.UserPicture($png) } catch { "picture fill: $_" }
  try { $ser.PictureType = 3; $ser.PictureUnit2 = 100 } catch { "stack and scale: $_" }
  try { $pc.ChartGroups(1).GapWidth = 60 } catch { }
  Start-Sleep -Milliseconds 1500
  $null = $wsP.Range('A12').Select()
  SnapAll 'p-1'                                                     # the pictograph
  try {
    $null = $ser.Select()
    Start-Sleep -Milliseconds 600
    $null = $xl.CommandBars.ExecuteMso('ChartFormatSelection')
    Start-Sleep -Milliseconds 2500
    Dump 'seriespane'
    SnapAll 'p-2'                                                   # Format Data Series: Fill
  } catch { "series pane: $_" }
  try { foreach ($b in @($root.FindAll($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Close pane')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))))) { Press $b; Start-Sleep -Milliseconds 800; break } } catch { }

  # 6. CAPS: a linear trendline on Paper (a line chart).
  $ws2 = $wb.Worksheets.Add([Type]::Missing, $wsP); $ws2.Name = 'Paper'
  Fill12 $ws2 @(,@('Month', 'Paper')) 3
  Fill12 $ws2 @($monthsA | ForEach-Object { ,@($_[0], $_[1]) }) 4
  $ws2.Range('A1').Formula = 'Paper collected (kg)'; $ws2.Range('A1').Font.Bold = $true; $ws2.Range('A1').Font.Size = 14
  Heads $ws2 'A3:B3'
  $ls = $ws2.Shapes.AddChart2(227, 4, 200, 30, 460, 280)
  $lc = $ls.Chart
  $lc.SetSourceData($ws2.Range('A3:B9'))
  $lc.HasTitle = $true; $lc.ChartTitle.Text = 'Paper collected (kg)'
  $null = $lc.SeriesCollection(1).Trendlines().Add(-4132)
  try { $lc.SeriesCollection(1).Trendlines(1).Forward = 2 } catch { }
  $null = $ws2.Activate(); $null = $ws2.Range('A12').Select()
  Start-Sleep -Milliseconds 1500
  SnapAll 't-1'                                                     # the trendline, two months forward

  # 7. IEB: a combo chart - Paper and Plastic as columns, Cans as a line on a second axis.
  $ws3 = $wb.Worksheets.Add([Type]::Missing, $ws2); $ws3.Name = 'Combo'
  RecyclingSheet $ws3 $monthsA
  $cs = $ws3.Shapes.AddChart2(201, 51, 300, 30, 480, 300)
  $cc = $cs.Chart
  $cc.SetSourceData($ws3.Range('A3:D9'))
  $cc.HasTitle = $true; $cc.ChartTitle.Text = 'Paper and plastic (columns), cans (line)'
  $cc.SeriesCollection(3).ChartType = 65                            # xlLineMarkers
  $cc.SeriesCollection(3).AxisGroup = 2
  $null = $ws3.Activate(); $null = $cs.Select()
  Start-Sleep -Milliseconds 1500
  SnapAll 'c-1'                                                     # the combo chart, selected
  try {
    PressAsync (Find $root @('Change Chart Type...', 'Change Chart Type') -tries 6)
    WaitOthers
    DumpOthers 'cctdlg'
    SnapAll 'c-2' -Others                                           # Change Chart Type: Combo
    CloseOthers
  } catch { "change chart type: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }

  # 8. IEB: a pie of the totals with the biggest slice pulled out.
  $ws3.Range('A11').Formula = 'Total'; $ws3.Range('A11').Font.Bold = $true
  foreach ($c in 'B', 'C', 'D') { $ws3.Range("$($c)11").Formula2 = "=SUM($($c)4:$($c)9)" }
  $ks = $ws3.Shapes.AddChart2(251, 5, 300, 350, 360, 240)
  $kc = $ks.Chart
  $kc.SetSourceData($ws3.Range('B3:D3,B11:D11'))
  $kc.HasTitle = $true; $kc.ChartTitle.Text = 'Total by material'
  $kc.SeriesCollection(1).Points(1).Explosion = 18
  try { $kc.SeriesCollection(1).HasDataLabels = $true; $kc.SeriesCollection(1).DataLabels().ShowPercentage = $true; $kc.SeriesCollection(1).DataLabels().ShowValue = $false } catch { }
  $null = $ws3.Range('A20').Select()
  Start-Sleep -Milliseconds 1500
  SnapAll 'k-1'                                                     # the pie, Paper pulled out

  # 9. IEB: line sparklines - months across, one row per material.
  $ws4 = $wb.Worksheets.Add([Type]::Missing, $ws3); $ws4.Name = 'Trend'
  $ws4.Range('A1').Formula = 'Recycling by month (kg)'; $ws4.Range('A1').Font.Bold = $true; $ws4.Range('A1').Font.Size = 14
  Fill12 $ws4 @(@('Material', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Trend'), @('Paper', 180, 240, 210, 320, 290, 380), @('Plastic', 120, 150, 170, 200, 260, 310), @('Cans', 60, 80, 70, 110, 90, 140)) 3
  Heads $ws4 'A3:H3'
  $ws4.Columns.Item('A').ColumnWidth = 10; $ws4.Columns.Item('H').ColumnWidth = 16
  $ws4.Rows.Item(4).RowHeight = 24; $ws4.Rows.Item(5).RowHeight = 24; $ws4.Rows.Item(6).RowHeight = 24
  $null = $ws4.Activate(); $null = $ws4.Range('H4:H6').Select()
  Start-Sleep -Milliseconds 800
  MarkCells $ws4 @('H4:H6', 'B4:G6') 'tr'
  SnapAll 'k-2'                                                     # H4:H6 selected
  Tab 'Insert'
  TryMark 'btnSparkLine' $root @('Line') $T::Button
  TryMark 'btnSparkLine2' $root @('Insert Line Sparkline', 'Line Sparkline')
  SnapAll 'k-3'                                                     # the Insert tab, Sparklines group
  try {
    $line = $null
    try { $line = Find $root @('Insert Line Sparkline', 'Line Sparkline') -tries 4 } catch { $line = Find $root @('Line') $T::Button -tries 4 }
    PressAsync $line
    WaitOthers
    DumpOthers 'sparkdlg'
    MarkAny 'sparkData' @('Data Range:', 'Data Range') $T::Edit
    MarkAny 'sparkOK' @('OK') $T::Button
    SnapAll 'k-4' -Others                                           # Create Sparklines, Location H4:H6
    CloseOthers
  } catch { "sparklines dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $ws4.Range('H4:H6').SparklineGroups.Add(1, 'B4:G6')
  try { $ws4.Range('H4:H6').SparklineGroups.Item(1).Points.Highpoint.Visible = $true } catch { }
  $null = $ws4.Range('A8').Select()
  Start-Sleep -Milliseconds 1200
  SnapAll 'k-5'                                                     # the sparklines

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
