# Real Excel 365 screens for catexcel lesson 18, Importing, exporting, and
# advanced sorting and filtering (AIPascalCourse/content/catexcel/importing.php
# - written to courses/cat-practical-writing.md, 9 October 2026). Mr Botha's
# new till saves each day's sales as a CSV file, TillSales.csv: Data > Get
# Data (From File), From Text/CSV, the Import Data box, the preview, Load (a
# new sheet, TillSales); the CSV opened straight in Excel; File > Export (PDF,
# Change File Type) and Save As with the CSV types; then (IEB) his week's
# special orders: Sort A to Z on the days (wrong), the Sort dialog's Order list
# and Custom List, the days sorted Mon-Sat, urgent orders (yellow) on top by
# cell colour, Sort Options; a Top 10 filter; Data > Advanced with a criteria
# range, copied to another place. Menus, lists and dialogs are windows of
# their own: SnapAll -Others draws them over Excel's window; file dialogs show
# the VM's OneDrive account - its labels are marked (private*) and painted
# out by the crop.
# Also makes the pupils' starter files BakeryBook.xlsx and TillSales.csv (and
# a done-right BakeryBook-done.xlsx, the CSV imported with Power Query) in
# C:\sims\files\catexcel-importing\ and G:\My Drive\CAT\Excel\.
# Read office-kit.ps1's safety rules first. Stops only its own Excel.
# Crop: work/catexcel-importing-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-importing -TimeoutSec 1200   (from the host)
$Name = 'catexcel-importing'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11c-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

# ---------------------------------------------------------------- the till's CSV file
$csvLines = @(
  'Time,Item,Qty,Price,Amount',
  '07:05,White bread,2,18,36', '07:12,Pie,3,25,75', '07:20,Vetkoek,6,6,36', '07:31,Brown bread,1,17,17',
  '07:45,White bread,1,18,18', '08:02,Muffin,4,12,48', '08:10,Koeksister,10,5,50', '08:24,White bread,3,18,54',
  '08:40,Pie,2,25,50', '08:55,Brown bread,2,17,34', '09:03,Vetkoek,12,6,72', '09:18,White bread,1,18,18',
  '09:30,Muffin,2,12,24', '09:47,Pie,4,25,100', '10:05,Koeksister,6,5,30', '10:20,White bread,2,18,36',
  '10:36,Brown bread,1,17,17', '10:51,Pie,1,25,25', '11:08,Vetkoek,5,6,30', '11:30,White bread,4,18,72')
$csv = Join-Path $filesDir 'TillSales.csv'
[IO.File]::WriteAllText($csv, (($csvLines -join "`r`n") + "`r`n"), (New-Object Text.ASCIIEncoding))
try { Copy-Item $csv $cloudDir -Force } catch { "cloud copy failed: $_" }
$cloudCsv = Join-Path $cloudDir 'TillSales.csv'
if (-not (Test-Path $cloudCsv)) { $cloudCsv = $csv }

# Imports TillSales.csv into a new sheet of $book with Power Query, as Data > From Text/CSV > Load does.
function ImportTill ($book, [string]$path) {
  $m = "let`n    Source = Csv.Document(File.Contents(""$path""),[Delimiter="","", Columns=5, Encoding=1252, QuoteStyle=QuoteStyle.None]),`n" +
       "    #""Promoted Headers"" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),`n" +
       "    #""Changed Type"" = Table.TransformColumnTypes(#""Promoted Headers"",{{""Time"", type time}, {""Item"", type text}, {""Qty"", Int64.Type}, {""Price"", Int64.Type}, {""Amount"", Int64.Type}})`n" +
       "in`n    #""Changed Type"""
  $null = $book.Queries.Add('TillSales', $m)
  $sheet = $book.Worksheets.Add([Type]::Missing, $book.Worksheets.Item($book.Worksheets.Count))
  $sheet.Name = 'TillSales'
  $src = 'OLEDB;Provider=Microsoft.Mashup.OleDb.1;Data Source=$Workbook$;Location=TillSales;Extended Properties=""'
  $lo = $sheet.ListObjects.Add(0, $src, [Type]::Missing, 1, $sheet.Range('A1'))
  $qt = $lo.QueryTable
  $qt.CommandType = 2                                                     # xlCmdSql
  $qt.CommandText = 'SELECT * FROM [TillSales]'
  $qt.RowNumbers = $false
  $qt.PreserveFormatting = $true
  $qt.RefreshStyle = 1
  $qt.AdjustColumnWidth = $true
  $lo.DisplayName = 'TillSales'
  $null = $qt.Refresh($false)
  return $sheet
}

function SummarySheet ($s) {
  Fill12 $s @(
    @('Botha''s Bakery - Saturday 3 October 2026'), @(''),
    @('Number of sales'), @('Items sold'), @('Takings (R)'), @('White bread takings (R)'))
  $s.Range('A1').Font.Bold = $true; $s.Range('A1').Font.Size = 14
  $s.Columns.Item('A').ColumnWidth = 26; $s.Columns.Item('B').ColumnWidth = 12
}

$orders = @(
  @('Day', 'Customer', 'Item', 'Qty'),
  @('Wed', 'Phumlani Secondary', 'Pies', 120),
  @('Mon', 'Gogo Dlamini', 'Brown bread', 4),
  @('Sat', 'Centurion Rugby Club', 'Vetkoek', 200),
  @('Tue', 'Ms Naidoo', 'Muffins', 36),
  @('Fri', 'St Mary''s Church', 'White bread', 40),
  @('Mon', 'Spar Lyttelton', 'White bread', 60),
  @('Thu', 'Thabo Dlamini', 'Koeksisters', 24),
  @('Sat', 'Botha family braai', 'Pies', 30),
  @('Wed', 'Old age home', 'Brown bread', 25),
  @('Tue', 'Lerato''s residence', 'Muffins', 48),
  @('Fri', 'Phumlani Secondary', 'Koeksisters', 150),
  @('Thu', 'Spar Lyttelton', 'White bread', 60))
$urgent = @('Centurion Rugby Club', 'Old age home', 'St Mary''s Church')

function OrdersSheet ($s) {
  $s.Range('A1:L20').Clear()
  Fill12 $s $orders
  $s.Range('A1:D1').Font.Bold = $true
  $s.Columns.Item('A').ColumnWidth = 7; $s.Columns.Item('B').ColumnWidth = 22; $s.Columns.Item('C').ColumnWidth = 13; $s.Columns.Item('D').ColumnWidth = 7
  for ($r = 2; $r -le 13; $r++) { if ($urgent -contains $s.Range("B$r").Text) { $s.Range("A${r}:D${r}").Interior.Color = 10284031 } }   # light yellow (Excel's Neutral fill)
}

function SortOrders ($s, [int]$on, $order, [string]$custom = '') {
  $st = $s.Sort
  $st.SortFields.Clear()
  if ($on -eq 1) { $f = $st.SortFields.Add($s.Range('A2:A13'), 1, 1); $f.SortOnValue.Color = 10284031 }   # cell colour on top
  elseif ($custom) { $null = $st.SortFields.Add($s.Range('A2:A13'), 0, 1, $custom) }
  else { $null = $st.SortFields.Add($s.Range('A2:A13'), 0, $order) }
  $st.SetRange($s.Range('A1:D13'))
  $st.Header = 1
  $st.Apply()
}

# Marks every label of Excel's other windows that names the signed-in account, to be painted out.
$script:privateN = 0
function MarkPrivate {
  foreach ($top in (OtherRoots)) {
    foreach ($e in $top.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) {
      try {
        $c = $e.Current
        if (-not $c.IsOffscreen -and ($c.Name -like 'Chris*' -or $c.Name -like '*Noome*' -or $c.Name -like '*De La Salle*' -or $c.Name -like 'OneDrive - *' -or $c.Name -like '*@*.*')) { Mark ("private$($script:privateN)") (Box $e); $script:privateN++; "  private: '$($c.Name)'" }
      } catch { }
    }
  }
}

function TextBoxIn ([string[]]$names) {
  foreach ($top in (OtherRoots)) {
    foreach ($nm in $names) {
      $f = $top.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, $nm)))
      if ($f) { return $f }
    }
  }
  return $null
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $oldUser = $xl.UserName; $xl.UserName = 'Mr Botha'                    # the files' author (put back at the end)
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"; try { "decimal '$($xl.International(3))', list '$($xl.International(5))', culture $((Get-Culture).Name)" } catch { "international: $_" }

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $ss = $sb.Worksheets.Item(1); $ss.Name = 'Summary'; SummarySheet $ss
  $null = $ss.Range('B3').Select()
  SaveStarter $sb 'BakeryBook.xlsx'
  try {
    $till = ImportTill $sb $csv
    "done import: $($till.Range('A1').Text) | $($till.Range('B2').Text) | $($till.Range('E21').Text) | rows $($till.UsedRange.Rows.Count)"
  } catch {
    "power query import failed: $_ - opening the CSV instead"
    $cb = $xl.Workbooks.Open($csv)
    $cb.Worksheets.Item(1).Copy([Type]::Missing, $sb.Worksheets.Item($sb.Worksheets.Count))
    $cb.Close($false)
    $till = $sb.Worksheets.Item($sb.Worksheets.Count)
  }
  Fill12 $ss @(
    @('Number of sales', '=COUNTA(TillSales!B2:B21)'),
    @('Items sold', '=SUM(TillSales!C2:C21)'),
    @('Takings (R)', '=SUM(TillSales!E2:E21)'),
    @('White bread takings (R)', '=SUMIF(TillSales!B2:B21,"White bread",TillSales!E2:E21)')) 3
  "done summary: $($ss.Range('B3').Text) $($ss.Range('B4').Text) $($ss.Range('B5').Text) $($ss.Range('B6').Text)"
  $null = $ss.Activate()
  $sb.SaveAs((Join-Path $filesDir 'BakeryBook-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Summary'; SummarySheet $ws
  $wo = $wb.Worksheets.Item(2); $wo.Name = 'Orders'; OrdersSheet $wo
  $null = $ws.Activate(); $null = $ws.Range('B3').Select()
  $docs = Join-Path $env:USERPROFILE 'Bakery'                            # not Documents: Excel nags to back that up to OneDrive
  New-Item -ItemType Directory -Force $docs | Out-Null
  $wb.SaveAs((Join-Path $docs 'BakeryBook.xlsx'), 51)                    # the Publish and Save As boxes open in this folder

  ShowExcel 1600 800
  $root = $AE::FromHandle($h)
  foreach ($tab in 'File Tab', 'Home', 'Insert', 'Data') { TryMark ('tab' + ($tab -replace ' ', '')) $root @($tab) $T::TabItem }

  # 1. Data tab: Get Data > From File; From Text/CSV.
  SnapAll 'im-0'                                                          # Summary sheet, Home tab
  Tab 'Data'
  Dump 'data'
  foreach ($nm in 'Get Data', 'From Text/CSV', 'From Web', 'From Table/Range', 'Recent Sources', 'Existing Connections', 'Queries & Connections', 'Sort...', 'Sort', 'Filter', 'Advanced...', 'Advanced', 'Text to Columns...', 'Text to Columns') { TryMark ('d' + ($nm -replace '[^A-Za-z]', '')) $root @($nm) }
  SnapAll 'im-1'                                                          # the Data tab
  try {
    $gd = Find $root @('Get Data') -tries 8
    Expand $gd; Start-Sleep -Milliseconds 1800
    DumpOthers 'getdata'
    MarkAny 'gdFromFile' @('From File')
    SnapAll 'gd-1' -Others                                                # the Get Data menu
    $ff = FindAny @('From File') -tries 6
    Expand $ff; Start-Sleep -Milliseconds 1800
    DumpOthers 'fromfile'
    foreach ($nm in 'From Excel Workbook', 'From Workbook', 'From Text/CSV', 'From XML', 'From JSON', 'From PDF', 'From Folder') { MarkAny ('ff' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
    SnapAll 'gd-2' -Others                                                # From File beside it
    Collapse $ff; Collapse $gd; Start-Sleep -Milliseconds 600
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "get data menu: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }

  # 2. From Text/CSV: the Import Data box (in the cloud folder), the preview, Load.
  $imported = $false
  try {
    Tab 'Data'
    PressAsync (Find $root @('From Text/CSV') -tries 8)
    WaitOthers 1 40
    Start-Sleep -Milliseconds 1500
    DumpOthers 'importdlg'
    # the file dialog is a classic Win32 one: its File name box and Open button are found as child windows
    $dlgH = [Comp11c]::OtherByClass($h, '#32770')
    $win0 = [WinRect]::Of($h)
    $label = TextBoxIn @('File name:', 'File name')
    $lb0 = if ($label) { Box $label } else { @(166, 506, 67, 20) }
    $editH = [XlMsg]::ChildAt($dlgH, 'Edit', ($win0[0] + $lb0[0] + $lb0[2] + 120), ($win0[1] + $lb0[1] + [int]($lb0[3] / 2)))
    $openH = [XlMsg]::ChildByText($dlgH, 'Button', 'Open')
    "dialog $dlgH, file name edit $editH, open button $openH"
    if ($editH -ne [IntPtr]::Zero -and $openH -ne [IntPtr]::Zero) {
      [XlMsg]::SetText($editH, $cloudDir)
      Start-Sleep -Milliseconds 400
      [XlMsg]::Click($openH)                                              # goes into the folder
      Start-Sleep -Milliseconds 3000
      [XlMsg]::SetText($editH, '')
      Start-Sleep -Milliseconds 800
      DumpOthers 'importdlg2'
      MarkPrivate
      MarkAny 'tillFile' @('TillSales.csv', 'TillSales')
      MarkAny 'importBtn' @('Import', 'Open')
      Mark 'fileNameBox' @(($lb0[0] + $lb0[2] + 4), ($lb0[1] - 4), 380, 28)
      SnapAll 'im-2' -Others                                              # the Import Data box, in My Drive > CAT > Excel
      [XlMsg]::SetText($editH, 'TillSales.csv')
      Start-Sleep -Milliseconds 400
      [XlMsg]::Click($openH)
      for ($i = 0; $i -lt 40; $i++) { Start-Sleep -Milliseconds 500; try { $null = FindAny @('Load', 'Transform Data') -tries 1; break } catch { } }
      Start-Sleep -Milliseconds 2500
      foreach ($w in [Comp11c]::Others($h)) { $r = [Comp11c]::Rect($w); "  preview window $w at $($r -join ',')"; [Shot]::Place($w, 430, 60, $r[2], 770) }   # the preview is taller than Excel's window: moved up so Load shows
      Start-Sleep -Milliseconds 1500
      DumpOthers 'preview'
      $loadH = [IntPtr]::Zero
      foreach ($w in [Comp11c]::Others($h)) { foreach ($t in 'Load', 'Transform Data') { $c = [Comp11c]::ChildByTextAny($w, $t); if ($c -ne [IntPtr]::Zero) { "  child '$t': $c"; if ($t -eq 'Load') { $loadH = $c } } } }
      foreach ($nm in 'Load', 'Transform Data', 'Cancel', 'File Origin', 'Delimiter', 'Data Type Detection') { MarkAny ('pv' + ($nm -replace ' ', '')) @($nm) }
      SnapAll 'im-3' -Others                                              # the preview: Delimiter Comma, Load, Transform Data
      $pv = @([Comp11c]::Others($h)) | Select-Object -First 1
      if ($loadH -eq [IntPtr]::Zero -and $pv) {
        # the preview's buttons are drawn inside it: a click posted to the preview window, at Load (775, 717 from its top left)
        $dr = [Comp11c]::Rect($pv); $sx = $dr[0] + 775; $sy = $dr[1] + 717
        $target = [Comp11c]::DeepestAt($pv, $sx, $sy)
        $lp = [XlMsg]::ToClient($target, $sx, $sy)
        [XlMsg]::Post($target, 0x0200, 0, $lp); Start-Sleep -Milliseconds 150
        [XlMsg]::Post($target, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($target, 0x0202, 0, $lp)
        "  load: a click posted to $target (the preview is $pv)"
      }
      elseif ($loadH -ne [IntPtr]::Zero) { [XlMsg]::Click($loadH) }
      else { try { $load = FindAny @('Load') -tries 4; Press $load } catch { "load: $_ - closing the preview; the import is done through COM" } }
      for ($i = 0; $i -lt 40; $i++) { Start-Sleep -Milliseconds 500; try { if ($wb.Worksheets.Count -gt 2) { break } } catch { } }
      Start-Sleep -Milliseconds 4000
      $imported = ($wb.Worksheets.Count -gt 2)
    } else { "no File name box" }
  } catch { "import dialog: $_" }
  if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  "imported by the dialog: $imported; sheets $($wb.Worksheets.Count)"
  if (-not $imported) { try { $null = ImportTill $wb $csv } catch { "import (COM): $_" } }
  $tsheet = $null
  foreach ($s in $wb.Worksheets) { if ($s.Name -like 'TillSales*') { $tsheet = $s } }
  if ($tsheet) {
    $null = $tsheet.Activate(); $null = $tsheet.Range('A1').Select()
    "TillSales sheet: $($tsheet.Name) | $($tsheet.Range('A1').Text) $($tsheet.Range('B2').Text) $($tsheet.Range('E21').Text) | A2 shows $($tsheet.Range('A2').Text)"
    Start-Sleep -Milliseconds 1500
    Tab 'Data'
    MarkCells $tsheet @('A1', 'B2', 'E21', 'A1:E21')
    SnapAll 'im-4'                                                        # the new sheet, the table, Queries & Connections
    # the pane's own Close - never Excel's (the later pictures need the whole width)
    try { foreach ($b in @($root.FindAll($Scope::Descendants, (New-Object System.Windows.Automation.AndCondition((New-Object $PropCond($AE::NameProperty, 'Close pane')), (New-Object $PropCond($AE::ControlTypeProperty, $T::Button))))))) { Press $b; "  closed the pane"; break } } catch { "close pane: $_" }
    Start-Sleep -Milliseconds 1000
  }
  SaveMarks

  # 3. The CSV opened straight in Excel.
  try {
    $cbook = $xl.Workbooks.Open($cloudCsv)
    Start-Sleep -Milliseconds 2000
    $null = $cbook.Worksheets.Item(1).Range('A1').Select()
    $mainH = $h
    $script:h = [IntPtr]$cbook.Windows.Item(1).Hwnd                     # each workbook has a window of its own
    [Shot]::Place($h, 40, 40, 1600, 800); Start-Sleep -Milliseconds 1500
    SnapAll 'op-1'                                                        # TillSales.csv open as a workbook
    "csv opened: A1 '$($cbook.Worksheets.Item(1).Range('A1').Text)' B1 '$($cbook.Worksheets.Item(1).Range('B1').Text)' A2 '$($cbook.Worksheets.Item(1).Range('A2').Text)' sheet '$($cbook.Worksheets.Item(1).Name)'"
    $cbook.Close($false)
    $script:h = $mainH
    Start-Sleep -Milliseconds 1000
  } catch { "open csv: $_" }

  # 4. Exporting: File > Export (PDF; Change File Type), Save As's CSV types.
  $null = $ws.Activate(); $null = $ws.Range('A1').Select()
  try {
    Press (Find $root @('File Tab', 'File') -tries 8); Start-Sleep -Milliseconds 2500
    Dump 'backstage'
    TryMark 'bsExport' $root @('Export') $T::ListItem
    TryMark 'bsSaveAs' $root @('Save As', 'Save a Copy') $T::ListItem
    SnapAll 'ex-0'                                                        # Backstage
    Press (Find $root @('Export') $T::ListItem -tries 8); Start-Sleep -Milliseconds 2500
    Dump 'exportpage'
    foreach ($nm in 'Create PDF/XPS Document', 'Change File Type', 'Create PDF/XPS') { TryMark ('ex' + ($nm -replace '[^A-Za-z]', '')) $root @($nm) }
    SnapAll 'ex-1'                                                        # Export: Create PDF/XPS Document
    try {
      Press (Find $root @('Change File Type') -tries 6); Start-Sleep -Milliseconds 2000
      Dump 'changetype'
      foreach ($nm in 'CSV (Comma delimited)', 'Text (Tab delimited)', 'Workbook') { TryMark ('ct' + ($nm -replace '[^A-Za-z]', '')) $root @($nm) }
      SnapAll 'ex-2'                                                      # Change File Type: CSV (Comma delimited)
      Press (Find $root @('Create PDF/XPS Document') -tries 6); Start-Sleep -Milliseconds 1500
    } catch { "change file type: $_" }
    try {
      PressAsync (Find $root @('Create PDF/XPS') $T::Button -tries 6)
      WaitOthers 1 30
      Start-Sleep -Milliseconds 1500
      DumpOthers 'publishdlg'
      MarkPrivate
      foreach ($nm in 'Publish', 'Options...', 'Save as type:', 'File name:') { MarkAny ('pub' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
      SnapAll 'ex-3' -Others                                              # Publish as PDF or XPS
      CloseOthers
    } catch { "publish dialog: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
    try { Press (Find $root @('Back') -tries 6) } catch { [Shot]::PostKey($h, 0x1B) }
    Start-Sleep -Milliseconds 1500
  } catch { "backstage: $_" }
  # Save As (F12): the Save as type list
  try {
    [Shot]::PostKey($h, 0x7B)                                             # F12, to Excel's window only
    WaitOthers 1 30
    Start-Sleep -Milliseconds 1500
    DumpOthers 'saveas'
    MarkPrivate
    $dlgH = [Comp11c]::OtherByClass($h, '#32770')
    $win0 = [WinRect]::Of($h)
    $tl = $null
    foreach ($top in (OtherRoots)) { foreach ($e in $top.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Save as type:')))) { if ($e.Current.ControlType -ne $T::Text) { $tl = $e } } }
    $tb = if ($tl) { Box $tl } else { @(175, 434, 779, 28) }
    $typH = [XlMsg]::ChildAt($dlgH, 'ComboBox', ($win0[0] + $tb[0] + 200), ($win0[1] + $tb[1] + [int]($tb[3] / 2)))
    "save as type combo: $typH"
    if ($typH -ne [IntPtr]::Zero) {
      Mark 'saveType' $tb
      SnapAll 'sv-1' -Others                                              # Save As
      [void][Comp11c]::Send($typH, 0x014F, 1, 0)                          # CB_SHOWDROPDOWN
      Start-Sleep -Milliseconds 1500
      DumpOthers 'savetypes'
      SnapAll 'sv-2' -Others                                              # the Save as type list
      [void][Comp11c]::Send($typH, 0x014F, 0, 0)
      Start-Sleep -Milliseconds 600
      $idx = [Comp11c]::FindItem($typH, 'CSV UTF-8')
      "csv utf-8 item: $idx"
      if ($idx -ge 0) { [void][Comp11c]::Send($typH, 0x014E, $idx, 0); Start-Sleep -Milliseconds 900; SnapAll 'sv-3' -Others }   # CB_SETCURSEL
    } else { "no Save as type box" }
    CloseOthers
  } catch { "save as: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  SaveMarks

  # 5. IEB: advanced sort on the Orders sheet.
  $null = $wo.Activate(); $null = $wo.Range('A3').Select()
  $xl.ActiveWindow.ScrollRow = 1
  Tab 'Data'
  MarkCells $wo @('A1', 'A2:A13', 'A1:D13', 'F1', 'F1:G2', 'I1')
  SnapAll 'as-1'                                                          # the orders, jumbled; Data tab
  SortOrders $wo 0 1
  Start-Sleep -Milliseconds 800
  SnapAll 'as-0'                                                          # Sort A to Z on the days: Fri, Mon, Sat ...
  OrdersSheet $wo
  $null = $wo.Range('A3').Select()
  try {
    PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8)
    WaitOthers
    DumpOthers 'sortdlg'
    $combos = @()
    for ($try = 0; $try -lt 12 -and $combos.Count -lt 3; $try++) {
      $combos = @(); foreach ($top in (OtherRoots)) { foreach ($cb in $top.FindAll($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::ComboBox)))) { $combos += ,$cb } }
      if ($combos.Count -lt 3) { Start-Sleep -Milliseconds 500 }
    }
    "sort combos: $($combos.Count)"
    $sortDlg = [Comp11c]::OtherByClass($h, 'NUIDialog')
    $i = 0; foreach ($cb in $combos) { Mark ("sortCombo$i") (Box $cb); $i++ }
    foreach ($nm in 'OK', 'Cancel', 'Add Level', 'Options...', 'My data has headers') { MarkAny ('sd' + ($nm -replace '[ .]', '')) @($nm) }
    SnapAll 'as-2' -Others                                                # the Sort dialog
    if ($combos.Count -ge 3 -or $sortDlg -ne [IntPtr]::Zero) {
      # Sort by already says Day (the sheet's last sort); open the Order list (the third)
      if ($combos.Count -ge 3) { Expand $combos[2] }
      else {
        # no UI Automation this time: a click posted to the dialog, on the Order list's arrow (718, 124 from its top left)
        $dr = [Comp11c]::Rect($sortDlg); $sx = $dr[0] + 718; $sy = $dr[1] + 124
        $target = [Comp11c]::DeepestAt($sortDlg, $sx, $sy); $lp = [XlMsg]::ToClient($target, $sx, $sy)
        [XlMsg]::Post($target, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($target, 0x0202, 0, $lp)
        "  order list: a click posted to $target"
      }
      Start-Sleep -Milliseconds 1500
      DumpOthers 'orderlist'
      $lbH = [Comp11c]::OtherByClass($h, 'REListBox20W')
      if ($lbH -ne [IntPtr]::Zero) { $r = [Comp11c]::Rect($lbH); $w0 = [WinRect]::Of($h); Mark 'orderList' @(($r[0] - $w0[0]), ($r[1] - $w0[1]), $r[2], $r[3]) }
      SnapAll 'as-3' -Others                                              # the Order list: A to Z, Z to A, Custom List...
      try {
        if ($lbH -eq [IntPtr]::Zero) { throw 'no order list' }
        foreach ($k in 1..2) { [Shot]::PostKey($lbH, 0x28); Start-Sleep -Milliseconds 200 }   # Down to Custom List...
        Start-Sleep -Milliseconds 500
        SnapAll 'as-3b' -Others
        [Shot]::PostKey($lbH, 0x0D)                                       # Enter chooses it: the Custom Lists box opens
        Start-Sleep -Milliseconds 3500
        DumpOthers 'customlists'
        foreach ($nm in 'Sun, Mon, Tue, Wed, Thu, Fri, Sat', 'OK') { MarkAny ('cl' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
        SnapAll 'as-4' -Others                                            # the Custom Lists box
      } catch { "custom list: $_" }
    }
    CloseOthers
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "sort dialog: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  OrdersSheet $wo
  SortOrders $wo 0 1 'Sun,Mon,Tue,Wed,Thu,Fri,Sat'
  $null = $wo.Range('A3').Select()
  Start-Sleep -Milliseconds 800
  SnapAll 'as-5'                                                          # Mon to Sat
  try { PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8); WaitOthers; SnapAll 'as-6' -Others; CloseOthers } catch { "sort dialog 2: $_"; CloseOthers }
  SortOrders $wo 1 1
  Start-Sleep -Milliseconds 800
  SnapAll 'as-7'                                                          # the urgent (yellow) orders on top
  try {
    PressAsync (Find $root @('Sort...', 'Sort', 'Custom Sort...') -tries 8); WaitOthers
    SnapAll 'as-8' -Others                                                # Sort On Cell Color, On Top
    try { PressAsync (FindAny @('Options...') -tries 4); Start-Sleep -Milliseconds 2500; DumpOthers 'sortoptions'; SnapAll 'as-9' -Others } catch { "sort options: $_" }
    CloseOthers
    if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers }
  } catch { "sort dialog 3: $_"; CloseOthers }

  # 6. IEB: a Top 10 filter (the 3 biggest orders), then Advanced with a criteria range.
  OrdersSheet $wo
  $null = $wo.Range('A1:D13').AutoFilter(4, '3', 3)                       # xlTop10Items: top 3 by Qty
  $null = $wo.Range('A3').Select()
  Start-Sleep -Milliseconds 1000
  SnapAll 'tf-1'                                                          # the three biggest orders
  $wo.AutoFilterMode = $false
  OrdersSheet $wo
  Fill12 $wo @(@('Item', 'Qty'), @('White bread', '>=50')) 1 5            # the criteria range F1:G2
  $wo.Range('F1:G1').Font.Bold = $true
  $wo.Columns.Item('F').ColumnWidth = 13
  $null = $wo.Range('A3').Select()
  Tab 'Data'
  SnapAll 'af-0'                                                          # the criteria range beside the list
  try {
    PressAsync (Find $root @('Advanced...', 'Advanced') -tries 8)
    WaitOthers
    DumpOthers 'advfilter'
    foreach ($nm in 'Filter the list, in-place', 'Copy to another location', 'List range:', 'Criteria range:', 'Copy to:', 'Unique records only', 'OK', 'Cancel') { MarkAny ('af' + ($nm -replace '[^A-Za-z]', '')) @($nm) }
    SnapAll 'af-1' -Others                                                # the Advanced Filter box
    # its controls are drawn by the dialog itself: clicks and characters posted to the dialog's window only
    $dlg = [Comp11c]::OtherByClass($h, 'bosa_sdm_XL9')
    function PostClick ($hw, [int]$px, [int]$py) {                        # px, py: from the dialog's own top left (its window rectangle)
      $dr = [Comp11c]::Rect($hw)
      $lp = [XlMsg]::ToClient($hw, ($dr[0] + $px), ($dr[1] + $py))
      [XlMsg]::Post($hw, 0x0201, 1, $lp); Start-Sleep -Milliseconds 120; [XlMsg]::Post($hw, 0x0202, 0, $lp); Start-Sleep -Milliseconds 500
    }
    function PostChars ($hw, [string]$text) { foreach ($ch in $text.ToCharArray()) { [XlMsg]::Post($hw, 0x0102, [int]$ch, 1); Start-Sleep -Milliseconds 60 } ; Start-Sleep -Milliseconds 400 }
    if ($dlg -ne [IntPtr]::Zero) {
      PostClick $dlg 40 109                                              # Copy to another location
      SnapAll 'af-1b' -Others
      PostClick $dlg 200 172                                              # the Criteria range box
      PostChars $dlg '$F$1:$G$2'
      SnapAll 'af-1c' -Others
      PostClick $dlg 200 202                                              # the Copy to box
      PostChars $dlg '$I$1'
      SnapAll 'af-1d' -Others
    }
    CloseOthers
  } catch { "advanced: $_"; if (@([Comp11c]::Others($h)).Count -gt 0) { CloseOthers } }
  try { $null = $wo.Range('A1:D13').AdvancedFilter(2, $wo.Range('F1:G2'), $wo.Range('I1')) } catch { "advanced filter (COM): $_" }
  $wo.Columns.Item('I').ColumnWidth = 7; $wo.Columns.Item('J').ColumnWidth = 18; $wo.Columns.Item('K').ColumnWidth = 13
  $null = $wo.Range('A3').Select()
  Start-Sleep -Milliseconds 900
  try { PressAsync (Find $root @('Advanced...', 'Advanced') -tries 8); WaitOthers; SnapAll 'af-2' -Others; CloseOthers } catch { "advanced 2: $_"; CloseOthers }
  $null = $wo.Range('A15').Select()
  SnapAll 'af-3'                                                          # the copied rows in I1:L4

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
