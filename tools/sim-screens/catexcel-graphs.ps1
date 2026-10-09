# Real Excel 365 (and Word 365) screens for catexcel lesson 17, More charts,
# and linking them (AIPascalCourse/content/catexcel/graphs.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Botha's Bakery's sales
# per month, January to June 2026: Add Chart Element > Axis Titles, a chart
# with every element, Switch Row/Column, Select Data (the chart data range
# made bigger), Change Chart Type (to Line), Move Chart (as an object on the
# Report sheet), options for the type (a pie with percentages, a column's gap
# width, a line's markers), (IEB) the line/area and pie/doughnut galleries, an
# area chart and a doughnut; then (CAPS) the chart pasted into Word as a
# linked chart (Word's Paste menu), and updated when the sheet changes. Menus,
# lists and dialogs are windows of their own: SnapAll -Others draws them over
# the main window. Word never saves anything here (its SaveAs2 has hung in
# this VM): the document is closed without saving.
# Also makes the pupils' starter file BakerySales.xlsx (and a done-right copy)
# in C:\sims\files\catexcel-graphs\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel and Word.
# Crop: work/catexcel-graphs-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-graphs -TimeoutSec 1200   (from the host)
$Name = 'catexcel-graphs'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11c-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$sales = @(
  @('Month', 'Bread', 'Pies', 'Muffins'),
  @('Jan', 1850, 960, 610),
  @('Feb', 1720, 1010, 580),
  @('Mar', 1960, 940, 640),
  @('Apr', 2010, 1120, 600),
  @('May', 2240, 1300, 560),
  @('Jun', 2380, 1410, 530),
  @('Total'))

function SalesSheet ($s) {
  Fill12 $s $sales
  $s.Range('A1:D1').Font.Bold = $true; $s.Range('A8').Font.Bold = $true
  $s.Columns.Item('A').ColumnWidth = 10
  foreach ($col in 'B', 'C', 'D') { $s.Columns.Item($col).ColumnWidth = 10 }
}

# A chart element's box on the main window's picture (window pixels): the chart's shape plus the element's place in it.
function ElementBox ($shape, $el) {
  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  $x1 = $pane.PointsToScreenPixelsX($shape.Left + $el.Left) - $win[0]
  $y1 = $pane.PointsToScreenPixelsY($shape.Top + $el.Top) - $win[1]
  $x2 = $pane.PointsToScreenPixelsX($shape.Left + $el.Left + $el.Width) - $win[0]
  $y2 = $pane.PointsToScreenPixelsY($shape.Top + $el.Top + $el.Height) - $win[1]
  return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
}
function ShapeBox ($shape) {
  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  $x1 = $pane.PointsToScreenPixelsX($shape.Left) - $win[0]; $y1 = $pane.PointsToScreenPixelsY($shape.Top) - $win[1]
  $x2 = $pane.PointsToScreenPixelsX($shape.Left + $shape.Width) - $win[0]; $y2 = $pane.PointsToScreenPixelsY($shape.Top + $shape.Height) - $win[1]
  return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
}

# Opens Word's Paste menu by its arrow (the split button's MenuItem, 'More Options') - never the Paste button itself, which pastes.
function OpenPasteMenu ($paste) {
  $mi = $null
  try { $mi = $paste.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::MenuItem))) } catch { }
  if ($mi) { "  paste arrow: '$($mi.Current.Name)'"; Expand $mi } else { Expand $paste }
  Start-Sleep -Milliseconds 1800
  if (@([Comp11c]::Others($h)).Count -eq 0 -and $mi) { try { Press $mi } catch { "  press arrow: $_" }; Start-Sleep -Milliseconds 1800 }
  if (@([Comp11c]::Others($h)).Count -eq 0 -and $mi) {
    # a click posted to the window under the arrow, at its middle
    $b = Box $mi; $wr0 = [Comp11c]::Rect($h); $sx = $wr0[0] + $b[0] + [int]($b[2] / 2); $sy = $wr0[1] + $b[1] + [int]($b[3] / 2)
    $target = [Comp11c]::DeepestAt($h, $sx, $sy); $lp = [XlMsg]::ToClient($target, $sx, $sy)
    [XlMsg]::Post($target, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($target, 0x0202, 0, $lp); Start-Sleep -Milliseconds 1800
    "  paste arrow: a click posted, $(@([Comp11c]::Others($h)).Count) other windows"
  }
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
$word = $null
$wordPid = 0
try {
  $xl.DisplayAlerts = $false
  $oldUser = $xl.UserName; $xl.UserName = 'Mr Botha'                    # the files' author (put back at the end)
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  while ($sb.Worksheets.Count -lt 2) { $null = $sb.Worksheets.Add([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count)) }
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Sales'; SalesSheet $ss
  $sr = $sb.Worksheets.Item(2); $sr.Name = 'Report'
  $sr.Range('A1').Formula = 'Botha''s Bakery - report for the bank'; $sr.Range('A1').Font.Bold = $true; $sr.Range('A1').Font.Size = 14
  $null = $ss.Activate(); $null = $ss.Range('A1').Select()
  SaveStarter $sb 'BakerySales.xlsx'
  Fill12 $ss @(,@('Total', '=SUM(B2:B7)', '=SUM(C2:C7)', '=SUM(D2:D7)')) 8
  $line = $ss.Shapes.AddChart2(227, 4, 260, 10, 380, 230).Chart            # line
  $line.SetSourceData($ss.Range('A1:D7'))
  $line.HasTitle = $true; $line.ChartTitle.Text = 'Botha''s Bakery: items sold per month, January to June 2026'
  $null = $line.Location(2, 'Report')                                      # xlLocationAsObject, on the Report sheet
  $pie = $ss.Shapes.AddChart2(251, 5, 260, 10, 340, 220).Chart             # pie
  $pie.SetSourceData($ss.Range('A1:D1,A8:D8'), 1)                          # xlRows
  $pie.HasTitle = $true; $pie.ChartTitle.Text = 'Share of the items sold, January to June'
  $pie.SeriesCollection(1).HasDataLabels = $true
  $pie.SeriesCollection(1).DataLabels().ShowPercentage = $true
  $pie.SeriesCollection(1).DataLabels().ShowValue = $false
  "done: totals $($ss.Range('B8').Text) $($ss.Range('C8').Text) $($ss.Range('D8').Text); Report charts $($sr.ChartObjects().Count)"
  $sb.SaveAs((Join-Path $filesDir 'BakerySales-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Sales'; SalesSheet $ws
  Fill12 $ws @(,@('Total', '=SUM(B2:B7)', '=SUM(C2:C7)', '=SUM(D2:D7)')) 8
  $wr = $wb.Worksheets.Item(2); $wr.Name = 'Report'
  $wr.Range('A1').Formula = 'Botha''s Bakery - report for the bank'; $wr.Range('A1').Font.Bold = $true; $wr.Range('A1').Font.Size = 14
  # saved, so a chart pasted into Word can link to it
  $wb.SaveAs((Join-Path $filesDir 'BakeryCharts.xlsx'), 51)
  $null = $ws.Activate()
  $null = $ws.Range('A1').Select()

  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  $shape = $ws.Shapes.AddChart2(201, 51, 260, 10, 400, 240)               # clustered column of Bread and Pies (made once Excel shows, so it can be selected)
  $chart = $shape.Chart
  $chart.SetSourceData($ws.Range('A1:C7'))
  $shape.Name = 'Sales chart'
  Start-Sleep -Milliseconds 1500
  $null = $shape.Select()
  MarkCells $ws @('A1', 'A1:C7', 'A1:D7', 'B7')
  foreach ($tab in 'Home', 'Insert', 'Page Layout', 'Formulas', 'Data') { TryMark ('tab' + ($tab -replace ' ', '')) $root @($tab) $T::TabItem }
  $null = $ws.ChartObjects(1).Activate()
  # warm-up: in this VM the chart tabs appear only once an axis title has been selected - one is made, selected and taken away again
  try { $chart.Axes(2).HasTitle = $true; Start-Sleep -Milliseconds 500; $null = $chart.Axes(2).AxisTitle.Select(); Start-Sleep -Milliseconds 1500; $chart.Axes(2).HasTitle = $false; Start-Sleep -Milliseconds 500 } catch { "warm-up: $_" }
  try { $null = $chart.ChartArea.Select() } catch { }                    # then the whole chart, as a click on its edge
  Start-Sleep -Milliseconds 1200
  function ChartTab {
    for ($i = 0; $i -lt 6; $i++) {
      try { Tab 'Chart Design'; return } catch { Start-Sleep -Milliseconds 1500; try { $null = $ws.ChartObjects(1).Activate() } catch { }; try { $null = $ws.ChartObjects(1).Chart.ChartArea.Select() } catch { } }
    }
    'no Chart Design tab'
  }
  ChartTab
  Dump 'chartdesign'
  foreach ($nm in 'Add Chart Element', 'Quick Layout', 'Switch Row/Column', 'Select Data...', 'Select Data', 'Change Chart Type...', 'Change Chart Type', 'Move Chart...', 'Move Chart') { TryMark ('cd' + ($nm -replace '[ ./]', '')) $root @($nm) }
  Mark 'chartBox' (ShapeBox $shape)
  SnapAll 'el-1'                                                          # the chart selected, Chart Design tab

  # 1. Add Chart Element > Axis Titles > Primary Vertical, then typing the title.
  try {
    $add = Find $root @('Add Chart Element') -tries 8
    Expand $add; Start-Sleep -Milliseconds 1800
    DumpOthers 'addmenu'
    foreach ($nm in 'Axes', 'Axis Titles', 'Chart Title', 'Data Labels', 'Data Table', 'Gridlines', 'Legend', 'Lines', 'Trendline') { MarkAny ('ae' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'el-2' -Others                                                # the Add Chart Element menu
    $at = FindAny @('Axis Titles') -tries 6
    Expand $at; Start-Sleep -Milliseconds 1800
    DumpOthers 'axismenu'
    foreach ($nm in 'Primary Horizontal', 'Primary Vertical', 'More Axis Title Options...') { MarkAny ('at' + ($nm -replace '[ .]', '')) @($nm) }
    SnapAll 'el-3' -Others                                                # Axis Titles beside it
    Collapse $at; Collapse $add; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "add chart element: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $chart.Axes(2).HasTitle = $true
  Start-Sleep -Milliseconds 600
  $null = $chart.Axes(2).AxisTitle.Select()
  Start-Sleep -Milliseconds 800
  Mark 'vTitle' (ElementBox $shape $chart.Axes(2).AxisTitle)
  SnapAll 'el-4'                                                          # "Axis Title" up the side, selected
  $chart.Axes(2).AxisTitle.Text = 'Number sold'
  Start-Sleep -Milliseconds 800
  $null = $chart.ChartArea.Select()
  ChartTab
  SnapAll 'el-5'                                                          # Number sold
  # every element: a title, both axis titles, minor gridlines, the legend on the right
  $chart.HasTitle = $true; $chart.ChartTitle.Text = 'Botha''s Bakery: bread and pies sold per month, January to June 2026'
  $chart.Axes(1).HasTitle = $true; $chart.Axes(1).AxisTitle.Text = 'Month (2026)'
  $chart.Axes(2).HasMinorGridlines = $true
  $chart.HasLegend = $true; $chart.Legend.Position = -4152                 # right
  Start-Sleep -Milliseconds 800
  Mark 'chartTitle' (ElementBox $shape $chart.ChartTitle)
  Mark 'legendBox' (ElementBox $shape $chart.Legend)
  SnapAll 'el-6'                                                          # all the elements
  $chart.Axes(2).HasMinorGridlines = $false
  # the Add Chart Element steps again, now that the chart tabs show: the chart without its vertical axis title
  $chart.Axes(2).HasTitle = $false
  Start-Sleep -Milliseconds 800
  $null = $chart.ChartArea.Select(); ChartTab
  SnapAll 'el-1b'                                                         # Chart Design tab, no vertical axis title
  try {
    $add = Find $root @('Add Chart Element') -tries 8
    Mark 'addElement' (Box $add)
    Expand $add; Start-Sleep -Milliseconds 1800
    DumpOthers 'addmenu'
    foreach ($nm in 'Axes', 'Axis Titles', 'Chart Title', 'Data Labels', 'Data Table', 'Gridlines', 'Legend', 'Lines', 'Trendline') { MarkAny ('ae' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'el-2' -Others                                                # the Add Chart Element menu
    $at = FindAny @('Axis Titles') -tries 6
    Expand $at; Start-Sleep -Milliseconds 1800
    DumpOthers 'axismenu'
    foreach ($nm in 'Primary Horizontal', 'Primary Vertical', 'More Axis Title Options...') { MarkAny ('at' + ($nm -replace '[ .]', '')) @($nm) }
    SnapAll 'el-3' -Others                                                # Axis Titles beside it
    Collapse $at; Collapse $add; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "add chart element (2): $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $chart.Axes(2).HasTitle = $true
  Start-Sleep -Milliseconds 600
  $null = $chart.Axes(2).AxisTitle.Select()
  Start-Sleep -Milliseconds 800
  Mark 'vTitleB' (ElementBox $shape $chart.Axes(2).AxisTitle)
  SnapAll 'el-4b'                                                         # Axis Title up the side, selected
  $chart.Axes(2).AxisTitle.Text = 'Number sold'
  Start-Sleep -Milliseconds 600
  $null = $chart.ChartArea.Select(); ChartTab
  SnapAll 'el-5b'                                                         # Number sold

  # 2. Switch Row/Column (and back).
  try {
    Press (Find $root @('Switch Row/Column') -tries 8); Start-Sleep -Milliseconds 1200
    SnapAll 'sw-2'                                                        # the items along the bottom, the months as colours
    Press (Find $root @('Switch Row/Column') -tries 8); Start-Sleep -Milliseconds 1200
  } catch { "switch: $_"; $chart.PlotBy = 1; Start-Sleep -Milliseconds 800; SnapAll 'sw-2'; $chart.PlotBy = 2 }
  "plot by now: $($chart.PlotBy)"

  # 3. Select Data: the chart data range A1:C7 made A1:D7 (Muffins added).
  function DialogShot ($names, $n, $dump) {
    try {
      PressAsync (Find $root $names -tries 8)
      WaitOthers
      DumpOthers $dump
      SnapAll $n -Others
      CloseOthers
    } catch { "$n : $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  }
  DialogShot @('Select Data...', 'Select Data') 'sd-1' 'selectdata'      # Chart data range =Sales!$A$1:$C$7
  $chart.SetSourceData($ws.Range('A1:D7'))
  Start-Sleep -Milliseconds 800
  ChartTab
  DialogShot @('Select Data...', 'Select Data') 'sd-2' 'selectdata2'     # =Sales!$A$1:$D$7, Muffins in the list
  $null = $ws.ChartObjects(1).Activate(); ChartTab
  SnapAll 'sd-3'                                                          # three series

  # 4. Change Chart Type: the dialog on Column, then on Line; the line chart.
  DialogShot @('Change Chart Type...', 'Change Chart Type') 'ty-1' 'charttype'
  $chart.ChartType = 4                                                    # xlLine
  Start-Sleep -Milliseconds 800
  $null = $ws.ChartObjects(1).Activate(); ChartTab
  DialogShot @('Change Chart Type...', 'Change Chart Type') 'ty-2' 'charttype2'
  $null = $ws.ChartObjects(1).Activate(); ChartTab
  SnapAll 'ty-3'                                                          # the line chart

  # 5. Move Chart: the dialog; the chart as an object on the Report sheet.
  try {
    PressAsync (Find $root @('Move Chart...', 'Move Chart') -tries 8)
    WaitOthers
    DumpOthers 'movechart'
    SnapAll 'mv-1' -Others                                                # New sheet / Object in: Sales
    $combos = @()
    foreach ($top in (OtherRoots)) { foreach ($cb in $top.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ComboBox)))) { $combos += ,$cb } }
    "move chart combos: $($combos.Count)"
    if ($combos.Count -gt 0) {
      $i = 0; foreach ($cb in $combos) { Mark ("mvCombo$i") (Box $cb); $i++ }
      try { Expand $combos[-1]; Start-Sleep -Milliseconds 1500; DumpOthers 'movelist'; MarkAny 'itemReport' @('Report'); SnapAll 'mv-2' -Others; Collapse $combos[-1] } catch { "move list: $_" }
    } else {
      # the dialog draws its own controls: a click posted to its window, on the Object in list's arrow (632, 173 from its top left)
      $dlg = [Comp11c]::OtherByClass($h, 'bosa_sdm_XL9')
      if ($dlg -ne [IntPtr]::Zero) {
        $dr = [Comp11c]::Rect($dlg); $lp = [XlMsg]::ToClient($dlg, ($dr[0] + 632), ($dr[1] + 173))
        [XlMsg]::Post($dlg, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($dlg, 0x0202, 0, $lp)
        Start-Sleep -Milliseconds 1500
        "  after the posted click: $([Comp11c]::Describe($h))"
        SnapAll 'mv-2' -Others                                            # the Object in list open (if it opened)
      }
    }
    CloseOthers
  } catch { "move chart: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $moved = $chart.Location(2, 'Report')
  Start-Sleep -Milliseconds 1200
  $null = $wr.Activate()
  $mshape = $wr.ChartObjects(1)
  $mshape.Left = 20; $mshape.Top = 40
  $null = $mshape.Activate()
  $chart = $mshape.Chart
  Start-Sleep -Milliseconds 800
  ChartTab
  DialogShot @('Move Chart...', 'Move Chart') 'mv-3' 'movechart2'        # Object in: Report
  $null = $wr.ChartObjects(1).Activate(); ChartTab
  SnapAll 'mv-4'                                                          # the chart on the Report sheet
  SaveMarks

  # 6. Options for the type: a line's markers; a column's gap width (the Format pane); a pie with percentages.
  $chart.ChartType = 65                                                   # xlLineMarkers
  Start-Sleep -Milliseconds 800
  $null = $wr.Range('L2').Select()
  SnapAll 'op-3'                                                          # line with markers
  $chart.ChartType = 4
  $null = $ws.Activate()
  $colShape = $ws.Shapes.AddChart2(201, 51, 260, 10, 400, 240)
  $colShape.Chart.SetSourceData($ws.Range('A1:B7'))
  $colShape.Chart.HasTitle = $true; $colShape.Chart.ChartTitle.Text = 'Bread sold per month, 2026'
  $null = $colShape.Chart.SeriesCollection(1).Select()
  Start-Sleep -Milliseconds 800
  try {
    Tab 'Format'
    Dump 'formattab'
    Press (Find $root @('Format Selection') -tries 8); Start-Sleep -Milliseconds 2500
    Dump 'formatpane'
    TryMark 'gapWidth' $root @('Gap Width')
    SnapAll 'op-2'                                                        # Format Data Series: Series Overlap, Gap Width
  } catch { "format pane: $_" }
  try { $colShape.Chart.ChartGroups(1).GapWidth = 50; Start-Sleep -Milliseconds 800; SnapAll 'op-2b' } catch { "gap: $_" }
  try { foreach ($b in @($root.FindAll($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Close pane')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))))) { Press $b; break } } catch { }   # the pane's own Close - never Excel's
  Start-Sleep -Milliseconds 800
  $colShape.Delete()
  $pieShape = $ws.Shapes.AddChart2(251, 5, 260, 10, 380, 240)
  $pieShape.Chart.SetSourceData($ws.Range('A1:D1,A8:D8'), 1)
  $pieShape.Chart.HasTitle = $true; $pieShape.Chart.ChartTitle.Text = 'Share of the items sold, January to June'
  $pieShape.Chart.SeriesCollection(1).HasDataLabels = $true
  $pieShape.Chart.SeriesCollection(1).DataLabels().ShowPercentage = $true
  $pieShape.Chart.SeriesCollection(1).DataLabels().ShowValue = $false
  try { $pieShape.Chart.SeriesCollection(1).DataLabels().Font.Color = 16777215; $pieShape.Chart.SeriesCollection(1).DataLabels().Font.Bold = $true; $pieShape.Chart.SeriesCollection(1).DataLabels().Font.Size = 12 } catch { "labels: $_" }   # white on the slices
  $null = $ws.Range('L2').Select()
  Start-Sleep -Milliseconds 900
  SnapAll 'op-1'                                                          # a pie with percentages

  # 7. IEB: the Insert tab's line/area and pie/doughnut galleries; an area chart; a doughnut.
  $null = $ws.Range('A1:C7').Select()
  Tab 'Insert'
  Dump 'insert'
  foreach ($pair in @(@('Insert Line or Area Chart', 'kd-1', 'linemenu'), @('Insert Pie or Doughnut Chart', 'kd-4', 'piemenu'))) {
    try {
      $gal = Find $root @($pair[0]) -tries 8
      Mark ('gal' + ($pair[1] -replace '-', '')) (Box $gal)
      Expand $gal; Start-Sleep -Milliseconds 1800
      DumpOthers $pair[2]
      foreach ($nm in 'Line', 'Line with Markers', 'Area', 'Stacked Area', 'Pie', 'Doughnut') { MarkAny ('g' + $pair[1] + ($nm -replace ' ', '')) @($nm) }
      SnapAll $pair[1] -Others
      Collapse $gal; Start-Sleep -Milliseconds 600
      if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
    } catch { "gallery $($pair[0]): $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  }
  $pieShape.Chart.ChartType = -4120                                       # xlDoughnut
  $pieShape.Chart.ChartTitle.Text = 'Share of the items sold, January to June'
  $null = $ws.Range('L2').Select()
  Start-Sleep -Milliseconds 900
  SnapAll 'kd-3'                                                          # the doughnut
  $pieShape.Delete()
  $area = $ws.Shapes.AddChart2(276, 76, 260, 10, 400, 240)                # stacked area
  $area.Chart.SetSourceData($ws.Range('A1:D7'))
  $area.Chart.HasTitle = $true; $area.Chart.ChartTitle.Text = 'All items sold per month - and the total'
  $area.Chart.HasLegend = $true; $area.Chart.Legend.Position = -4107       # bottom
  $null = $ws.Range('L2').Select()
  Start-Sleep -Milliseconds 900
  SnapAll 'kd-2'                                                          # a stacked area chart
  $area.Delete()
  SaveMarks

  # 8. CAPS: the line chart into Word, linked. Word is never saved.
  $null = $wr.Activate()
  $null = $wr.ChartObjects(1).Activate()
  ChartTab
  SnapAll 'wd-0x'                                                         # the chart selected on the Report sheet (Ctrl+C next)
  try { $null = $wr.ChartObjects(1).Chart.ChartArea.Copy() } catch { "chart area copy: $_"; $null = $wr.ChartObjects(1).Copy() }   # as Ctrl+C on the selected chart
  Start-Sleep -Milliseconds 800
  try {
    $word = New-Object -ComObject Word.Application
    $word.DisplayAlerts = 0
    $doc = $word.Documents.Add()
    $doc.Content.Text = "Botha's Bakery`rReport to the bank - July 2026`rSales grew every month from January to June:`r"
    $doc.Paragraphs(1).Range.Style = -2                                   # wdStyleHeading1
    $word.Visible = $true
    $word.WindowState = 0
    $xlH = $h
    $hw = [IntPtr]$word.ActiveWindow.Hwnd
    $wordPid = [int][Shot]::Pid($hw)
    [Shot]::Place($hw, 40, 40, 1650, 800); Start-Sleep -Milliseconds 1500
    [Shot]::Place($hw, 40, 40, 1750, 800)
    $word.ActiveWindow.View.Type = 3
    $word.ActiveWindow.View.Zoom.Percentage = 100
    $word.ActiveWindow.DisplayRulers = $false
    try { $word.ActiveWindow.DocumentMap = $false } catch { }
    $end = $doc.Content; $end.Collapse(0); $end.Select()
    Start-Sleep -Milliseconds 2000
    $script:h = $hw
    $wroot = $AE::FromHandle($hw)
    Dump 'wordhome'
    TryMark 'wPaste' $wroot @('Paste')
    SnapAll 'wd-0'                                                        # the letter, cursor at the end, Home tab
    try {
      $paste = Find $wroot @('Paste') $T::SplitButton -tries 4
    } catch { $paste = $null }
    if (-not $paste) { try { $paste = Find $wroot @('Paste') -tries 6 } catch { "no Paste button" } }
    if ($paste) {
      try {
        OpenPasteMenu $paste
        DumpOthers 'wordpaste'
        foreach ($nm in 'Use Destination Theme & Embed Workbook', 'Keep Source Formatting & Embed Workbook', 'Use Destination Theme & Link Data', 'Keep Source Formatting & Link Data', 'Picture', 'Paste Special...') { MarkAny ('wp' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
        SnapAll 'wd-1' -Others                                            # Word's Paste menu: the chart's paste options
        Collapse $paste; Start-Sleep -Milliseconds 600
        if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
      } catch { "word paste menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
    }
    $sel = $word.Selection
    $end = $doc.Content; $end.Collapse(0); $end.Select()
    try { $sel.PasteAndFormat(15) } catch { "paste linked: $_"; try { $sel.Paste() } catch { "paste: $_" } }   # wdChartLinked
    Start-Sleep -Milliseconds 2500
    "word inline shapes: $($doc.InlineShapes.Count); type $(try { $doc.InlineShapes(1).Type } catch { '?' }); linked $(try { $doc.InlineShapes(1).Chart.ChartData.IsLinked } catch { '?' })"
    $doc.Range(0, 0).Select()
    Start-Sleep -Milliseconds 1200
    SnapAll 'wd-2'                                                        # the linked chart in the letter
    # the sheet changes: June's bread 2380 -> 3000; the linked chart follows
    $ws.Range('B7').Formula = '3000'
    $wb.Save()
    Start-Sleep -Milliseconds 1500
    try { $doc.InlineShapes(1).Chart.Refresh() } catch { "refresh: $_" }
    try { $doc.InlineShapes(1).LinkFormat.Update() } catch { }
    Start-Sleep -Milliseconds 2000
    SnapAll 'wd-3'                                                        # updated
    # cells: Paste Link (the Paste menu for copied cells)
    $null = $ws.Range('A1:D8').Copy()
    Start-Sleep -Milliseconds 800
    $end = $doc.Content; $end.Collapse(0); $end.Select()
    if ($paste) {
      try {
        OpenPasteMenu $paste
        DumpOthers 'wordpastecells'
        foreach ($nm in 'Keep Source Formatting', 'Use Destination Styles', 'Link & Keep Source Formatting', 'Link & Use Destination Styles', 'Picture', 'Keep Text Only') { MarkAny ('wc' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
        SnapAll 'wd-4' -Others                                            # the Paste menu for cells
        Collapse $paste; Start-Sleep -Milliseconds 600
        if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
      } catch { "word paste cells: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
    }
    try { $xl.CutCopyMode = 1 } catch { }
    $script:h = $xlH
    $doc.Close(0)                                                         # wdDoNotSaveChanges - nothing is saved
  } catch { "word: $_"; if ($xlH) { $script:h = $xlH } }

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { SaveMarks } catch { }
}
finally {
  try { if ($oldUser) { $xl.UserName = $oldUser } } catch { }
  if ($word) { try { $word.Quit(0) } catch { }; [void][Runtime.InteropServices.Marshal]::ReleaseComObject($word) }
  if ($wordPid) { Start-Sleep -Seconds 1; Stop-Process -Id $wordPid -Force -ErrorAction SilentlyContinue }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
