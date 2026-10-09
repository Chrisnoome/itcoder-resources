# Real Excel 365 screens for catexcel Grade 12, Subtotals, outlines and
# pivot tables (AIPascalCourse/content/catexcel/summaries.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Phumlani Secondary's
# Market Day sales, sorted by stall: Data > Outline > Subtotal (the dialog,
# the result, levels 1 2 3, the SUBTOTAL formulas), Group by hand, and
# (IEB) Consolidate three days into one sheet, a pivot table from the
# Insert tab with its PivotTable Fields pane, a filter on it, and a pivot
# chart. The window is 1860 wide so the Data tab's Outline group is not
# folded into a menu. Also makes the pupils' starter file MarketDay12.xlsx
# (and a done-right copy for each task) in C:\sims\files\catexcel-summaries\
# and G:\My Drive\CAT\Excel\. Read office-kit.ps1's safety rules first.
#     pwsh -File vm-shots.ps1 catexcel-summaries -TimeoutSec 1200   (from the host)
$Name = 'catexcel-summaries'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel12-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

function SalesSheet ($ws, $title, $rows) {
  $ws.Range('A1').Formula = $title
  $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 14
  Fill12 $ws @(,@('Stall', 'Item', 'Grade', 'Amount (R)')) 2
  Fill12 $ws $rows 3
  $ws.Range('A2:D2').Font.Bold = $true
  try { $ws.Range('A2:D2').Interior.Color = 0xF2E6D9 } catch { }
  $ws.Columns.Item('A').ColumnWidth = 14; $ws.Columns.Item('B').ColumnWidth = 18; $ws.Columns.Item('C').ColumnWidth = 7; $ws.Columns.Item('D').ColumnWidth = 12
}

function SortByStall ($ws, [int]$last) {
  $s = $ws.Sort
  $s.SortFields.Clear()
  $null = $s.SortFields.Add($ws.Range("A3:A$last"), 0, 1)
  $null = $s.SortFields.Add($ws.Range("B3:B$last"), 0, 1)
  $s.SetRange($ws.Range("A2:D$last"))
  $s.Header = 1
  $s.Apply()
}

# The lesson's sales (16 rows), already sorted by stall.
$salesA = @(
  @('Boerewors rolls', 'Roll and chips', 12, 450), @('Boerewors rolls', 'Roll only', 11, 320), @('Boerewors rolls', 'Roll only', 12, 280),
  @('Boerewors rolls', 'Roll and cooldrink', 10, 390), @('Cakes', 'Cupcakes', 10, 240), @('Cakes', 'Koeksisters', 11, 180),
  @('Cakes', 'Milk tart', 12, 310), @('Drinks', 'Cooldrink', 10, 260), @('Drinks', 'Ice lolly', 11, 150),
  @('Drinks', 'Juice', 12, 210), @('Drinks', 'Water', 10, 90), @('Games', 'Beat the goalie', 11, 120),
  @('Games', 'Lucky dip', 10, 200), @('Games', 'Tin can alley', 12, 160), @('Games', 'Tug of war', 12, 60))

# The upload: 24 rows, NOT sorted.
$salesB = @(
  @('Games', 'Lucky dip', 10, 220), @('Cakes', 'Muffins', 12, 180), @('Drinks', 'Cooldrink', 11, 300), @('Boerewors rolls', 'Roll only', 12, 410),
  @('Cakes', 'Koeksisters', 10, 260), @('Games', 'Tin can alley', 11, 140), @('Drinks', 'Juice', 12, 190), @('Boerewors rolls', 'Roll and chips', 11, 520),
  @('Sweets', 'Candyfloss', 10, 230), @('Cakes', 'Milk tart', 11, 340), @('Drinks', 'Water', 10, 80), @('Games', 'Beat the goalie', 12, 150),
  @('Boerewors rolls', 'Roll only', 10, 360), @('Sweets', 'Fudge', 12, 170), @('Cakes', 'Cupcakes', 12, 290), @('Drinks', 'Ice lolly', 11, 160),
  @('Sweets', 'Popcorn', 11, 210), @('Games', 'Tug of war', 10, 70), @('Boerewors rolls', 'Roll and cooldrink', 12, 430), @('Cakes', 'Scones', 10, 150),
  @('Drinks', 'Slush', 12, 240), @('Sweets', 'Toffee apples', 10, 120), @('Games', 'Lucky dip', 12, 190), @('Boerewors rolls', 'Roll and chips', 10, 380))

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)

  # ---------------------------------------------------------------- the starter file and two done-right copies
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Sales'
  SalesSheet $ss 'Phumlani Secondary - Market Day sales' $salesB
  $null = $ss.Range('A1').Select()
  SaveStarter $sb 'MarketDay12.xlsx'
  # (1) both boards: sorted by stall, then Subtotal at each change in Stall, Sum, Amount
  SortByStall $ss 26
  $null = $ss.Range('A2:D26').Subtotal(1, -4157, [int[]]@(4), $true, $false, $true)
  $sb.SaveAs((Join-Path $filesDir 'MarketDay12-done.xlsx'), 51)
  $lastRow = $ss.UsedRange.Rows.Count + $ss.UsedRange.Row - 1
  for ($r = 2; $r -le $lastRow; $r++) { if ($ss.Range("A$r").Text -like '*Total*') { "  subtotal row $($r): $($ss.Range("A$r").Text) | $($ss.Range("D$r").Formula) = $($ss.Range("D$r").Text)" } }
  $sb.Close($false); $sb = $null
  # (2) IEB: a pivot table on a sheet named Pivot, from the unsorted list
  $sb = $xl.Workbooks.Open((Join-Path $filesDir 'MarketDay12.xlsx'))
  $ss = $sb.Worksheets.Item('Sales')
  $wp = $sb.Worksheets.Add(); $wp.Name = 'Pivot'
  $pc = $sb.PivotCaches().Create(1, 'Sales!R2C1:R26C4')
  $pt = $pc.CreatePivotTable('Pivot!R3C1', 'MarketPivot')
  $pt.PivotFields('Stall').Orientation = 1
  $null = $pt.AddDataField($pt.PivotFields('Amount (R)'), 'Sum of Amount (R)', -4157)
  $sb.SaveAs((Join-Path $filesDir 'MarketDay12-pivot-done.xlsx'), 51)
  foreach ($r in 3..10) { "  pivot row $($r): $($wp.Range("A$r").Text) | $($wp.Range("B$r").Text)" }
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Sales'
  SalesSheet $ws 'Phumlani Secondary - Market Day sales' $salesA
  $null = $ws.Range('B6').Select()
  ShowExcel 1860 820 10
  $root = $AE::FromHandle($h)
  MarkCells $ws @('A2', 'B6', 'D3', 'A3:D17')
  TryMark 'formulaBar' $root @('Formula Bar')
  foreach ($tab in 'Home', 'Insert', 'Data') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }

  # 1. Data > Outline > Subtotal.
  SnapAll 's-0'                                                     # Home tab, B6 in the list
  Tab 'Data'
  Dump 'data'
  foreach ($nm in 'Subtotal', 'Group', 'Ungroup', 'Consolidate', 'Sort A to Z') { TryMark ('btn' + ($nm -replace ' ', '')) $root @($nm, "$nm...") }
  SnapAll 's-1'                                                     # the Data tab
  try {
    PressAsync (Find $root @('Subtotal', 'Subtotal...') -tries 8)
    WaitOthers
    DumpOthers 'subdlg'
    foreach ($nm in 'OK', 'Cancel', 'Remove All', 'Page break between groups', 'Summary below data', 'Replace current subtotals') { MarkAny ('dlg' + ($nm -replace '[ .]', '')) @($nm) }
    SnapAll 's-2' -Others                                           # the Subtotal dialog
    try { Press (FindAny @('OK') $T::Button -tries 6) } catch { "ok: $_"; CloseOthers }
    Start-Sleep -Milliseconds 1500
  } catch { "subtotal dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  if (-not ($ws.Range('A7').Text -like '*Total*')) { "  subtotal through COM"; $null = $ws.Range('A2:D17').Subtotal(1, -4157, [int[]]@(4), $true, $false, $true) }
  $null = $ws.Range('B6').Select()
  $lastRow = $ws.UsedRange.Rows.Count + $ws.UsedRange.Row - 1
  for ($r = 2; $r -le $lastRow; $r++) { if ($ws.Range("A$r").Text -like '*Total*') { Mark ("total$r") (CellAt $ws "A$r"); "  row $($r): $($ws.Range("A$r").Text) $($ws.Range("D$r").Formula) = $($ws.Range("D$r").Text)" } }
  MarkCells $ws @('A1', 'D7')
  SnapAll 's-3'                                                     # the subtotals, level 3
  $null = $ws.Outline.ShowLevels(2)
  SnapAll 's-4'                                                     # level 2: one row per stall
  $null = $ws.Outline.ShowLevels(1)
  SnapAll 's-5'                                                     # level 1: the grand total
  $null = $ws.Outline.ShowLevels(3)
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  $null = $ws.Range('D7').Select()
  SnapAll 's-6'                                                     # the SUBTOTAL formulas
  $xl.ActiveWindow.DisplayFormulas = $false
  # Remove All: the dialog again
  try {
    PressAsync (Find $root @('Subtotal', 'Subtotal...') -tries 8)
    WaitOthers
    SnapAll 's-7' -Others                                           # the dialog, Remove All at the bottom left
    try { Press (FindAny @('Remove All') $T::Button -tries 6) } catch { "remove all: $_"; CloseOthers }
    Start-Sleep -Milliseconds 1500
  } catch { "remove all dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  if ($ws.Range('A7').Text -like '*Total*') { $ws.Range('A2:D30').RemoveSubtotal() }

  # 2. Group rows by hand: rows 3-6 (the boerewors rows).
  $null = $ws.Range('A3:A6').EntireRow.Select()
  SnapAll 'g-1'                                                     # rows 3-6 selected, Data tab
  $null = $ws.Range('A3:A6').EntireRow.Group()
  $null = $ws.Range('B12').Select()
  SnapAll 'g-2'                                                     # the outline bar and its minus button
  $null = $ws.Range('A3:A6').EntireRow.Ungroup()

  # 3. IEB: Consolidate three days onto a Total sheet.
  $days = @(
    @(@('Boerewors rolls', 1440), @('Cakes', 730), @('Drinks', 710), @('Games', 540)),
    @(@('Boerewors rolls', 1210), @('Cakes', 880), @('Drinks', 640), @('Games', 470)),
    @(@('Boerewors rolls', 1630), @('Cakes', 950), @('Drinks', 820), @('Games', 610)))
  $prev = $ws
  for ($d = 1; $d -le 3; $d++) {
    $wd = $wb.Worksheets.Add([Type]::Missing, $prev); $wd.Name = "Day$d"; $prev = $wd
    Fill12 $wd @(,@('Stall', 'Amount (R)')) 1
    Fill12 $wd $days[$d - 1] 2
    $wd.Range('A1:B1').Font.Bold = $true; $wd.Columns.Item('A').ColumnWidth = 16; $wd.Columns.Item('B').ColumnWidth = 12
  }
  $wtot = $wb.Worksheets.Add([Type]::Missing, $prev); $wtot.Name = 'Total'
  $null = $wtot.Activate(); $null = $wtot.Range('A1').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'c-1'                                                     # the empty Total sheet, A1
  $null = $wtot.Range('A1').Consolidate([string[]]@("'Day1'!R1C1:R5C2", "'Day2'!R1C1:R5C2", "'Day3'!R1C1:R5C2"), -4157, $true, $true, $false)
  $wtot.Columns.Item('A').ColumnWidth = 16; $wtot.Columns.Item('B').ColumnWidth = 12
  "consolidated: $((2..5 | ForEach-Object { $wtot.Range("A$_").Text + ' ' + $wtot.Range("B$_").Text }) -join ', ')"
  try {
    PressAsync (Find $root @('Consolidate', 'Consolidate...') -tries 8)
    WaitOthers
    DumpOthers 'consdlg'
    SnapAll 'c-2' -Others                                           # the Consolidate dialog with three references
    CloseOthers
  } catch { "consolidate dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $null = $wtot.Range('D1').Select()
  SnapAll 'c-3'                                                     # the totals

  # 4. IEB: a pivot table from the Insert tab.
  $null = $ws.Activate(); $null = $ws.Range('B6').Select()
  Start-Sleep -Milliseconds 600
  Tab 'Insert'
  Dump 'insert'
  TryMark 'btnPivot' $root @('PivotTable', 'Insert PivotTable') $T::SplitButton
  TryMark 'btnPivot2' $root @('PivotTable', 'Insert PivotTable')
  SnapAll 'p-0'                                                     # the Insert tab, B6
  $made = $false
  try {
    $btn = $null
    try { $btn = Find $root @('PivotTable') $T::Button -tries 6 } catch { $btn = Find $root @('PivotTable', 'Insert PivotTable') -tries 6 }
    PressAsync $btn
    WaitOthers
    DumpOthers 'pivotdlg'
    MarkAny 'pivOK' @('OK') $T::Button
    MarkAny 'pivNew' @('New Worksheet')
    SnapAll 'p-1' -Others                                           # PivotTable from table or range
    try { Press (FindAny @('OK') $T::Button -tries 6); $made = $true } catch { "pivot ok: $_"; CloseOthers }
    Start-Sleep -Milliseconds 3000
  } catch { "pivot dialog: $_"; if (@([Comp12]::Others($h)).Count -gt 0) { CloseOthers } }
  $wpv = $xl.ActiveSheet
  $pt = $null
  try { $pt = $wpv.PivotTables(1) } catch { }
  if (-not $pt) {
    "  pivot through COM"
    $wpv = $wb.Worksheets.Add(); $wpv.Name = 'Pivot'
    $pc = $wb.PivotCaches().Create(1, 'Sales!R2C1:R17C4')
    $pt = $pc.CreatePivotTable('Pivot!R3C1', 'MarketPivot')
    $null = $wpv.Activate(); $null = $wpv.Range('A3').Select()
    Start-Sleep -Milliseconds 2500
  }
  "pivot sheet: $($wpv.Name)"
  Dump 'pivotpane'
  MarkAny 'fieldStall' @('Stall') $T::CheckBox
  MarkAny 'fieldItem' @('Item') $T::CheckBox
  MarkAny 'fieldGrade' @('Grade') $T::CheckBox
  MarkAny 'fieldAmount' @('Amount (R)') $T::CheckBox
  SnapAll 'p-2'                                                     # the empty pivot table and its Fields pane
  $pt.PivotFields('Stall').Orientation = 1
  Start-Sleep -Milliseconds 1200
  SnapAll 'p-3'                                                     # Stall in Rows
  $null = $pt.AddDataField($pt.PivotFields('Amount (R)'), 'Sum of Amount (R)', -4157)
  Start-Sleep -Milliseconds 1200
  SnapAll 'p-4'                                                     # Sum of Amount in Values
  "pivot: $((3..9 | ForEach-Object { $wpv.Range("A$_").Text + ' ' + $wpv.Range("B$_").Text }) -join ', ')"
  # a filter: Grade in Filters, only 12
  $pt.PivotFields('Grade').Orientation = 3
  Start-Sleep -Milliseconds 800
  try { $pt.PivotFields('Grade').CurrentPage = '12' } catch { "page: $_" }
  Start-Sleep -Milliseconds 1200
  SnapAll 'p-5'                                                     # filtered to Grade 12
  try { $pt.PivotFields('Grade').ClearAllFilters() } catch { }
  # a pivot chart
  try {
    $shape = $wpv.Shapes.AddChart2(201, 51, 300, 40, 420, 260)
    $shape.Chart.SetSourceData($pt.TableRange1)
    $shape.Chart.HasTitle = $true
    $shape.Chart.ChartTitle.Text = 'Market Day sales by stall'
    Start-Sleep -Milliseconds 1500
    $null = $wpv.Range('A3').Select()
    SnapAll 'p-6'                                                   # the pivot chart
  } catch { "pivot chart: $_" }

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
