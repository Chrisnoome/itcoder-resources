# Real Excel 365 screens for catexcel lesson 16, Print options
# (AIPascalCourse/content/catexcel/printoptions.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Ms Naidoo's Grade 11
# CAT mark book (three class sheets, 13 columns, 34 pupils and a class
# summary): Page Break Preview, File > Print (what to print, the scaling
# list), Scale to Fit (the Width list), Sheet Options (Gridlines and Headings
# Print), a page break before the summary (the Breaks menu), Print Area on
# 11B (a stray note far down the sheet), the Page Setup dialog's Sheet tab,
# and (IEB) the Arrange group for a chart, a shape and a picture on the
# Averages sheet. Menus, lists and dialogs are windows of their own: SnapAll
# -Others draws them over Excel's window. Nothing is printed.
# Also makes the pupils' practice file MarkBook11.xlsx in
# C:\sims\files\catexcel-printoptions\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel.
# Crop: work/catexcel-printoptions-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-printoptions -TimeoutSec 1200   (from the host)
$Name = 'catexcel-printoptions'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11c-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$first = @('Ayanda','Bongani','Chloe','Dineo','Ethan','Fatima','Gift','Hlengiwe','Imran','Jabu','Karabo','Lindiwe','Mpho','Nadia','Owen','Palesa','Quinton','Refilwe','Sipho','Tamsin','Unathi','Vusi','Wandile','Xolani','Yusuf','Zanele','Amahle','Bheki','Carmen','Duduzile','Eric','Fikile','Grace','Hendrik')
$last  = @('Adams','Botha','Cele','Dlamini','Fourie','Govender','Hassan','Jacobs','Khumalo','Mabaso','Mahlangu','Mazibuko','Mbatha','Mkhize','Mokoena','Molefe','Moosa','Naidoo','Ndlovu','Nel','Ngcobo','Nkosi','Ntuli','Patel','Petersen','Phiri','Pillay','Radebe','Shabalala','Sithole','Smith','Tau','van Wyk','Zulu')
$heads = @('Surname', 'Name', 'Task 1', 'Task 2', 'Test 1', 'Practical 1', 'Test 2', 'PAT phase 1', 'Practical 2', 'June P1', 'June P2', 'Total', 'Percent')

# One class's sheet: title in row 1, headings in row 2, 34 pupils in rows 3-36, a summary in rows 39-42.
function ClassSheet ($ws, [string]$class, [int]$seed) {
  $rand = New-Object System.Random $seed
  $ws.Range('A1').Formula = "Phumlani Secondary - Grade $class CAT marks, Term 2"
  Fill12 $ws @(,$heads) 2
  for ($i = 0; $i -lt 34; $i++) {
    $r = $i + 3
    $ws.Range("A$r").Formula = $last[($i + $seed) % 34]; $ws.Range("B$r").Formula = $first[($i * 7 + $seed) % 34]
    foreach ($col in 'C', 'D', 'E', 'F', 'G', 'H', 'I') { $ws.Range("$col$r").Formula = [string]$rand.Next(19, 49) }
    foreach ($col in 'J', 'K') { $ws.Range("$col$r").Formula = [string]$rand.Next(60, 141) }
    $ws.Range("L$r").Formula = "=SUM(C${r}:K${r})"
    $ws.Range("M$r").Formula = "=L$r/650"
  }
  $ws.Range('A39').Formula = 'Class summary'
  Fill12 $ws @(@('Average', '', '=AVERAGE(C3:C36)'), @('Highest', '', '=MAX(C3:C36)'), @('Lowest', '', '=MIN(C3:C36)')) 40
  foreach ($r in 40..42) { $null = $ws.Range("C$r").Copy($ws.Range("D${r}:M${r}")) }
  $ws.Range('M3:M42').NumberFormat = '0%'
  $ws.Range('C40:L40').NumberFormat = '0.0'
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  $ws.Range('A2:M2').Font.Bold = $true; $ws.Range('A39').Font.Bold = $true
  $ws.Columns.Item('A').ColumnWidth = 13; $ws.Columns.Item('B').ColumnWidth = 11
  foreach ($col in 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M') { $ws.Columns.Item($col).ColumnWidth = 11 }
  $ws.Range('C2:M2').HorizontalAlignment = -4152   # right, over the numbers
}

# The Averages sheet: class averages, a column chart, a speech bubble half behind it, and a picture.
function AveragesSheet ($wa) {
  Fill12 $wa @(@('Class', 'Task 1', 'Test 1', 'Test 2', 'June P1'), @('11A', 33.1, 31.8, 34.2, 97.5), @('11B', 30.4, 33.9, 36.8, 101.2), @('11C', 34.7, 30.2, 32.5, 94.8))
  $wa.Range('A1:E1').Font.Bold = $true
  $bubble = $wa.Shapes.AddShape(106, 330, 30, 170, 70)                  # msoShapeRoundedRectangularCallout, put in first: behind the chart
  $bubble.Name = 'Well done bubble'
  $bubble.TextFrame2.TextRange.Text = '11B: most improved class!'
  $chartShape = $wa.Shapes.AddChart2(201, 51, 20, 80, 380, 220)          # clustered column
  $chartShape.Name = 'Averages chart'
  $chartShape.Chart.SetSourceData($wa.Range('A1:D4'))
  $chartShape.Chart.HasTitle = $true; $chartShape.Chart.ChartTitle.Text = 'Class averages, Term 2'
  $png = Join-Path $env:TEMP 'catexcel-badge.png'
  $bmp = New-Object Drawing.Bitmap 160, 180
  $g = [Drawing.Graphics]::FromImage($bmp)
  $g.SmoothingMode = 'AntiAlias'
  $g.Clear([Drawing.Color]::White)
  $pts = [Drawing.Point[]]@((New-Object Drawing.Point 10, 10), (New-Object Drawing.Point 150, 10), (New-Object Drawing.Point 150, 100), (New-Object Drawing.Point 80, 170), (New-Object Drawing.Point 10, 100))
  $g.FillPolygon((New-Object Drawing.SolidBrush ([Drawing.Color]::FromArgb(0, 84, 147))), $pts)
  $g.DrawPolygon((New-Object Drawing.Pen ([Drawing.Color]::FromArgb(230, 180, 30)), 8), $pts)
  $font = New-Object Drawing.Font 'Segoe UI', 30, ([Drawing.FontStyle]::Bold)
  $fmt = New-Object Drawing.StringFormat; $fmt.Alignment = 'Center'; $fmt.LineAlignment = 'Center'
  $g.DrawString('PS', $font, [Drawing.Brushes]::White, (New-Object Drawing.RectangleF 10, 20, 140, 100), $fmt)
  $g.Dispose(); $bmp.Save($png, [Drawing.Imaging.ImageFormat]::Png); $bmp.Dispose()
  $pic = $wa.Shapes.AddPicture($png, 0, -1, 420, 110, 60, 68)
  $pic.Name = 'School badge'
  return @($bubble, $chartShape, $pic)
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $oldUser = $xl.UserName; $xl.UserName = 'Ms Naidoo'                   # the files' author (put back at the end)
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"; try { "decimal '$($xl.International(3))', list '$($xl.International(5))', culture $((Get-Culture).Name)" } catch { "international: $_" }

  # ---------------------------------------------------------------- the practice file (no marked upload)
  $sb = $xl.Workbooks.Add()
  while ($sb.Worksheets.Count -lt 3) { $null = $sb.Worksheets.Add([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count)) }
  $classes = @('11A', '11B', '11C')
  for ($i = 0; $i -lt 3; $i++) { $s = $sb.Worksheets.Item($i + 1); $s.Name = $classes[$i]; ClassSheet $s $classes[$i] (11 + $i) }
  $sb.Worksheets.Item(2).Range('P48').Formula = 'Check Sipho''s PAT mark - Ms N'
  $null = $sb.Worksheets.Item(1).Activate(); $null = $sb.Worksheets.Item(1).Range('A1').Select()
  SaveStarter $sb 'MarkBook11.xlsx'
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 4) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  for ($i = 0; $i -lt 3; $i++) { $s = $wb.Worksheets.Item($i + 1); $s.Name = $classes[$i]; ClassSheet $s $classes[$i] (11 + $i) }
  $ws = $wb.Worksheets.Item(1)
  $wsB = $wb.Worksheets.Item(2)
  $wsB.Range('P48').Formula = 'Check Sipho''s PAT mark - Ms N'
  $wa = $wb.Worksheets.Item(4); $wa.Name = 'Averages'
  $objs = AveragesSheet $wa
  $null = $ws.Activate(); $null = $ws.Range('A1').Select()

  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  MarkCells $ws @('A1', 'A2', 'A39', 'C3', 'M2', 'A3:M36')
  foreach ($tab in 'File Tab', 'Home', 'Page Layout', 'View', 'Formulas', 'Data') { TryMark ('tab' + ($tab -replace ' ', '')) $root @($tab) $T::TabItem }
  Dump 'home'

  # 0. The sheet as it is: Home tab; Page Break Preview (two pages across).
  SnapAll 'rc-0'
  $xl.ActiveWindow.View = 2; $xl.ActiveWindow.Zoom = 60
  Start-Sleep -Milliseconds 1500
  SnapAll 'pb-1'                                                          # Page 1, Page 2 - the last columns alone
  $xl.ActiveWindow.View = 1; $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 800

  # 1. File > Print: the preview, what to print, and the scaling list (before any scaling).
  try {
    $fileTab = Find $root @('File Tab', 'File') -tries 8
    Press $fileTab; Start-Sleep -Milliseconds 2500
    Dump 'backstage'
    TryMark 'printItem' $root @('Print') $T::ListItem
    SnapAll 'fp-0'                                                        # Backstage, Info
    Press (Find $root @('Print') $T::ListItem -tries 8); Start-Sleep -Milliseconds 3500
    Dump 'printpage'
    foreach ($nm in 'Print Active Sheets', 'No Scaling', 'Portrait Orientation', 'A4', 'Normal Margins', 'Copies') { TryMark ('pp' + ($nm -replace ' ', '')) $root @($nm) }
    SnapAll 'fp-1'                                                        # the Print page: 1 of 2
    foreach ($pair in @(@('Print What', 'pw-1', 'whatlist'), @('Scale to Fit', 'fp-2', 'scalelist'))) {
      try {
        $dd = Find $root @($pair[0]) -tries 6
        Mark ('dd' + ($pair[0] -replace ' ', '')) (Box $dd)
        Expand $dd; Start-Sleep -Milliseconds 1800
        if (@([Comp11c]::Others($h)).Count -eq 0) {
          $btn = $dd.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))
          if ($btn) { "  $($pair[0]): its own button '$($btn.Current.Name)'"; try { Press $btn } catch { "  press: $_" }; Start-Sleep -Milliseconds 1800 }
        }
        if (@([Comp11c]::Others($h)).Count -eq 0) {
          $b = Box $dd; $wr0 = [Comp11c]::Rect($h); $sx = $wr0[0] + $b[0] + $b[2] - 12; $sy = $wr0[1] + $b[1] + [int]($b[3] / 2)
          $target = [Comp11c]::DeepestAt($h, $sx, $sy); $lp = [XlMsg]::ToClient($target, $sx, $sy)
          [XlMsg]::Post($target, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($target, 0x0202, 0, $lp); Start-Sleep -Milliseconds 1800
          "  $($pair[0]): a click posted, $(@([Comp11c]::Others($h)).Count) other windows"
        }
        DumpOthers $pair[2]
        foreach ($nm in 'Print Active Sheets', 'Print Entire Workbook', 'Print Selection', 'Fit Sheet on One Page', 'Fit All Columns on One Page', 'Fit All Rows on One Page', 'Custom Scaling Options...') { MarkAny ('item' + ($nm -replace '[ .]', '')) @($nm) }
        SnapAll $pair[1] -Others
        if ($pair[1] -eq 'pw-1') {
          try { Press (FindAny @('Print Entire Workbook') -tries 4); Start-Sleep -Milliseconds 2500; SnapAll 'pw-2'; "  chose Print Entire Workbook" } catch { "entire workbook: $_" }
          if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
          try { $dd = Find $root @($pair[0]) -tries 6; Expand $dd; Start-Sleep -Milliseconds 1500; Press (FindAny @('Print Active Sheets') -tries 4); Start-Sleep -Milliseconds 1500 } catch { "back to active sheets: $_" }
        }
        Collapse $dd; Start-Sleep -Milliseconds 600
        if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
      } catch { "list $($pair[0]): $_" }
    }
    try { Press (Find $root @('Back') -tries 6) } catch { [Shot]::PostKey($h, 0x1B) }
    Start-Sleep -Milliseconds 1500
  } catch { "backstage: $_" }

  # 2. Scale to Fit: Page Layout tab, the Width list, 1 page.
  Tab 'Page Layout'
  Dump 'pagelayout'
  foreach ($nm in 'Width', 'Height', 'Scale', 'Print Titles', 'Print Area', 'Breaks', 'Orientation', 'Bring Forward', 'Send Backward', 'Selection Pane', 'Align', 'Group', 'Rotate') { TryMark ('pl' + ($nm -replace ' ', '')) $root @($nm) }
  $i = 0
  foreach ($cb in @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::CheckBox))))) { try { if (-not $cb.Current.IsOffscreen) { Mark ("check$i-" + ($cb.Current.Name -replace '[^A-Za-z]', '')) (Box $cb); $i++ } } catch { } }
  SnapAll 'sc-1'                                                          # Page Layout tab
  try {
    $width = Find $root @('Width') $T::ComboBox -tries 8
    Mark 'widthCombo' (Box $width)
    $open = $width.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Button)))
    if ($open) { "  width's own button: $($open.Current.Name)"; Press $open } else { Expand $width }
    Start-Sleep -Milliseconds 1800
    DumpOthers 'widthlist'
    foreach ($nm in 'Automatic', '1 page', '2 pages') { MarkAny ('w' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'sc-2' -Others                                                # the Width list open
    Collapse $width; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "width list: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $ws.PageSetup.Zoom = $false
  $ws.PageSetup.FitToPagesWide = 1
  $ws.PageSetup.FitToPagesTall = $false
  $ws.DisplayPageBreaks = $true
  Start-Sleep -Milliseconds 1200
  Tab 'Home'; Tab 'Page Layout'
  SnapAll 'sc-3'                                                          # Width 1 page, Scale shows the new size
  try {
    Press (Find $root @('File Tab', 'File') -tries 8); Start-Sleep -Milliseconds 2500
    Press (Find $root @('Print') $T::ListItem -tries 8); Start-Sleep -Milliseconds 3500
    SnapAll 'fp-3'                                                        # the preview: all 13 columns, 1 of 1
    try { Press (Find $root @('Back') -tries 6) } catch { [Shot]::PostKey($h, 0x1B) }
    Start-Sleep -Milliseconds 1500
    Tab 'Page Layout'
  } catch { "preview after width: $_" }
  "scale now: $($ws.PageSetup.Zoom) wide $($ws.PageSetup.FitToPagesWide) pages $($ws.PageSetup.Pages.Count)"

  # 3. Sheet Options: Gridlines Print, Headings Print (tick boxes on the ribbon).
  $boxes = @($root.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::CheckBox))) | Where-Object { -not $_.Current.IsOffscreen })
  "check boxes: $(($boxes | ForEach-Object { $_.Current.Name + ' @' + ((Box $_) -join ',') }) -join ' | ')"
  $printBoxes = @($boxes | Where-Object { $_.Current.Name -match 'Print' })
  if ($printBoxes.Count -ge 2) {
    $sorted = @($printBoxes | Sort-Object { $_.Current.BoundingRectangle.X })
    Mark 'gridPrint' (Box $sorted[0]); Mark 'headPrint' (Box $sorted[1])
    try { Press $sorted[0]; Start-Sleep -Milliseconds 900 } catch { "grid print box: $_"; $ws.PageSetup.PrintGridlines = $true }
    SnapAll 'so-2'                                                        # Gridlines Print ticked
    try { Press $sorted[1]; Start-Sleep -Milliseconds 900 } catch { "head print box: $_"; $ws.PageSetup.PrintHeadings = $true }
    SnapAll 'so-3'                                                        # Headings Print ticked
  } else { "no Print tick boxes found"; $ws.PageSetup.PrintGridlines = $true; $ws.PageSetup.PrintHeadings = $true; SnapAll 'so-3' }
  "gridlines print: $($ws.PageSetup.PrintGridlines), headings print: $($ws.PageSetup.PrintHeadings)"
  try {
    Press (Find $root @('File Tab', 'File') -tries 8); Start-Sleep -Milliseconds 2500
    Press (Find $root @('Print') $T::ListItem -tries 8); Start-Sleep -Milliseconds 3500
    SnapAll 'so-4'                                                        # the preview: gridlines and A B C / 1 2 3, one page wide
    try { Press (Find $root @('Back') -tries 6) } catch { [Shot]::PostKey($h, 0x1B) }
    Start-Sleep -Milliseconds 1500
  } catch { "preview: $_" }
  $ws.PageSetup.PrintGridlines = $false; $ws.PageSetup.PrintHeadings = $false

  # 4. A page break before the class summary: A39, Page Layout > Breaks > Insert Page Break.
  $null = $ws.Range('A39').Select()
  Tab 'Page Layout'
  MarkCells $ws @('A39')
  SnapAll 'br-0'                                                          # A39 selected, Page Layout tab
  try {
    $breaks = Find $root @('Breaks') -tries 8
    Mark 'breaksBtn' (Box $breaks)
    Expand $breaks; Start-Sleep -Milliseconds 1800
    DumpOthers 'breaksmenu'
    foreach ($nm in 'Insert Page Break', 'Remove Page Break', 'Reset All Page Breaks') { MarkAny ('br' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'br-1' -Others                                                # the Breaks menu
    Collapse $breaks; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "breaks menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $ws.HPageBreaks.Add($ws.Range('A39'))
  $null = $ws.Range('A1').Select()
  $xl.ActiveWindow.View = 2; $xl.ActiveWindow.Zoom = 35; $xl.ActiveWindow.ScrollRow = 1
  Start-Sleep -Milliseconds 1500
  SnapAll 'br-2'                                                          # Page Break Preview: the summary on page 2
  $xl.ActiveWindow.View = 1; $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 800

  # 5. CAPS: Print Area on 11B (a note far down the sheet makes extra pages).
  $null = $wsB.Activate()
  $null = $wsB.Range('A1').Select()
  $xl.ActiveWindow.View = 2; $xl.ActiveWindow.Zoom = 30; $xl.ActiveWindow.ScrollRow = 1; $xl.ActiveWindow.ScrollColumn = 1
  Start-Sleep -Milliseconds 1500
  SnapAll 'pa-0'                                                          # the note makes more pages
  $xl.ActiveWindow.View = 1; $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 800
  $null = $wsB.Range('A1:M42').Select()
  $xl.ActiveWindow.ScrollRow = 1
  Tab 'Page Layout'
  SnapAll 'pa-1'                                                          # A1:M42 selected, Page Layout tab
  try {
    $pa = Find $root @('Print Area') -tries 8
    Mark 'printAreaBtn' (Box $pa)
    Expand $pa; Start-Sleep -Milliseconds 1800
    DumpOthers 'printareamenu'
    foreach ($nm in 'Set Print Area', 'Clear Print Area', 'Add to Print Area') { MarkAny ('pa' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'pa-2' -Others                                                # the Print Area menu
    Collapse $pa; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "print area menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $wsB.PageSetup.PrintArea = '$A$1:$M$42'
  $null = $wsB.Range('A1').Select()
  $xl.ActiveWindow.View = 2; $xl.ActiveWindow.Zoom = 30; $xl.ActiveWindow.ScrollRow = 1; $xl.ActiveWindow.ScrollColumn = 1
  Start-Sleep -Milliseconds 1500
  SnapAll 'pa-3'                                                          # only the print area is a page
  $xl.ActiveWindow.View = 1; $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 800
  # the Page Setup dialog, Sheet tab: print area, print titles, gridlines and headings together
  $wsB.PageSetup.PrintTitleRows = '$2:$2'
  $wsB.PageSetup.PrintGridlines = $true
  $wsB.PageSetup.PrintHeadings = $true
  Tab 'Page Layout'
  try {
    PressAsync (Find $root @('Print Titles') -tries 8)
    WaitOthers
    DumpOthers 'pagesetup'
    SnapAll 'pt-1' -Others                                                # Page Setup, Sheet tab
    CloseOthers
  } catch { "page setup: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  $wsB.PageSetup.PrintGridlines = $false; $wsB.PageSetup.PrintHeadings = $false

  SaveMarks

  # 6. IEB: Arrange - the speech bubble behind the chart; Bring Forward; Align; the Selection Pane.
  $null = $wa.Activate()
  $null = $objs[0].Select()
  Start-Sleep -Milliseconds 1200
  try { Tab 'Shape Format' } catch { "shape format tab: $_" }
  Dump 'shapeformat'
  foreach ($nm in 'Bring Forward', 'Send Backward', 'Selection Pane', 'Align', 'Group', 'Rotate', 'Align Objects', 'Rotate Objects', 'Group Objects') { TryMark ('ar' + ($nm -replace ' ', '')) $root @($nm) }
  SnapAll 'ar-1'                                                          # the bubble selected, behind the chart; Shape Format tab
  $objs[0].ZOrder(0)                                                      # msoBringToFront (one step forward is the same here: only the chart was in front)
  Start-Sleep -Milliseconds 900
  SnapAll 'ar-2'                                                          # the bubble in front
  try { $null = $wa.Shapes.Range([object[]]@('Well done bubble', 'School badge')).Select(); Start-Sleep -Milliseconds 900; Tab 'Shape Format' } catch { "two selected: $_" }
  try {
    $align = Find $root @('Align Objects', 'Align') -tries 6
    Expand $align; Start-Sleep -Milliseconds 1800
    DumpOthers 'alignmenu'
    foreach ($nm in 'Align Left', 'Align Center', 'Align Right', 'Align Top', 'Align Middle', 'Align Bottom') { MarkAny ('al' + ($nm -replace ' ', '')) @($nm) }
    SnapAll 'ar-3' -Others                                                # the Align menu
    Collapse $align; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "align menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  try {
    $rot = Find $root @('Rotate Objects', 'Rotate') -tries 6
    Expand $rot; Start-Sleep -Milliseconds 1800
    DumpOthers 'rotatemenu'
    SnapAll 'ar-5' -Others                                                # the Rotate menu
    Collapse $rot; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "rotate menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  try {
    $null = $objs[0].Select(); Start-Sleep -Milliseconds 800
    Press (Find $root @('Selection Pane...', 'Selection Pane') -tries 6); Start-Sleep -Milliseconds 2500
    Dump 'selectionpane'
    SnapAll 'ar-4'                                                        # the Selection pane
  } catch { "selection pane: $_" }

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { SaveMarks } catch { }
}
finally {
  try { if ($oldUser) { $xl.UserName = $oldUser } } catch { }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
