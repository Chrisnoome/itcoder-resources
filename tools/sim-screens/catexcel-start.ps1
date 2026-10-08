# Real Excel 365 screens for catexcel lesson 1, The spreadsheet window
# (content/catexcel/start.php - 8 October 2026). Botha's Bakery price list:
# the whole window for the tour, selecting cells and columns, the Name Box,
# sheet tabs and the View tab, and Save As (F12) into Google Drive.
# Read office-kit.ps1's safety rules. Run it in the CAT VM:
#     pwsh -File vm-shots.ps1 catexcel-start
# Then: python cat-crop.py catexcel-start
$Name = 'catexcel-start'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

$cloud = 'G:\My Drive\CAT'
$script:dialogOpen = $false
$oldPath = $null
Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 3) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Prices'
  $sp = $wb.Worksheets.Item(2); $sp.Name = 'Specials'
  $wb.Worksheets.Item(3).Name = 'Orders'
  FillRows $ws @(
    @('Item', 'Price', 'Sold', 'Takings'),
    @('White bread', 18, 40, '=B2*C2'),
    @('Brown bread', 17, 25, '=B3*C3'),
    @('Rolls (6)', 22, 12, '=B4*C4'),
    @('Koeksisters', 8, 60, '=B5*C5'),
    @('Milk tart', 15, 18, '=B6*C6'),
    @('Total', '', '', '=D2+D3+D4+D5+D6'))
  $ws.Columns.Item('A').ColumnWidth = 16
  foreach ($col in 'B', 'C', 'D') { $ws.Columns.Item($col).ColumnWidth = 10 }
  FillRows $sp @(
    @('Special', 'Day', 'Price'),
    @('Vetkoek and mince', 'Monday', 25),
    @('Pie and juice', 'Friday', 30))
  $sp.Columns.Item('A').ColumnWidth = 20
  $ws.Activate()
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)   # sized twice: the ribbon lays itself out again at the full width
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)
  $grid = [Shot]::Child($h, 'EXCEL7')

  foreach ($a in 'A1', 'B3', 'D20', 'B6') { Mark $a (CellBox $ws $a) }
  Mark 'colC' (ColHeadBox $ws 'C')
  Mark 'row3' (RowHeadBox $ws 3)
  $fb = Box (Find $root @('Formula Bar') $T::Edit)
  Mark 'nameBox' @(18, ($fb[1] + 10), 128, 30)                    # the Name Box: no name of its own in UI Automation
  TryMark 'formulaBar' $root @('Formula Bar')
  TryMark 'tabFile'    $root @('File Tab', 'File')
  TryMark 'tabHome'    $root @('Home') $T::TabItem
  TryMark 'tabView'    $root @('View') $T::TabItem
  TryMark 'sheetPrices'   $root @('Prices') $T::TabItem
  TryMark 'sheetSpecials' $root @('Specials') $T::TabItem
  TryMark 'newSheet'   $root @('Add Sheet', 'New sheet')
  TryMark 'zoom'       $root @('Zoom', 'Zoom Slider')
  TryMark 'selectAll'  $root @('Select All')
  TryMark 'search'     $root @('Microsoft search')
  Dump 'home'

  # 0. The whole window, for the tour (A1 active) - narrower, so that all of it fits a lesson's column.
  [Shot]::Place($h, 40, 40, 1150, 720); Start-Sleep -Milliseconds 2500
  $fbw = Box (Find $root @('Formula Bar') $T::Edit)
  Mark 'w-nameBox' @(18, ($fbw[1] + 10), 128, 30)
  Mark 'w-formulaBar' $fbw
  TryMark 'w-tabView'      $root @('View') $T::TabItem
  TryMark 'w-tabHome'      $root @('Home') $T::TabItem
  TryMark 'w-sheetSpecials' $root @('Specials') $T::TabItem
  TryMark 'w-newSheet'     $root @('Add Sheet', 'New sheet')
  TryMark 'w-zoom'         $root @('Zoom') $T::Slider
  TryMark 'w-zoomIn'       $root @('Zoom In') $T::Button
  TryMark 'w-pageLayout'   $root @('Page Layout') $T::Button
  Mark 'w-colD' (ColHeadBox $ws 'D')
  Mark 'w-A1' (CellBox $ws 'A1')
  Dump 'win'
  Snap 'win'
  [Shot]::Place($h, 40, 40, 1750, 720); Start-Sleep -Milliseconds 2500

  # 1. Select a cell, then a whole column.
  Snap '1'                                                          # A1 active
  $null = $ws.Range('B3').Select();      Snap '2'                   # B3 clicked: the Name Box says B3
  $null = $ws.Columns.Item('C').Select(); Snap '3'                  # column C selected

  # 2. Go to a cell by its address in the Name Box.
  $null = $ws.Range('D20').Select();     Snap '4'                   # D20 active

  # 3. Another sheet, and the View tab's Gridlines.
  $null = $ws.Range('A1').Select();      Snap '5'                   # Prices, A1 active
  $sp.Activate(); $null = $sp.Range('A1').Select()
  Start-Sleep -Milliseconds 600;         Snap '6'                   # Specials
  Press (Find $root @('View') $T::TabItem)
  Start-Sleep -Milliseconds 900
  TryMark 'gridlines'  $root @('Gridlines') $T::CheckBox
  TryMark 'formulaBarBox' $root @('Formula Bar') $T::CheckBox
  TryMark 'headingsBox'   $root @('Headings') $T::CheckBox
  TryMark 'pageLayout' $root @('Page Layout') $T::Button
  TryMark 'normalView' $root @('Normal') $T::Button
  Dump 'view'
  Snap '7'                                                          # the View tab
  $xl.ActiveWindow.DisplayGridlines = $false
  Start-Sleep -Milliseconds 600;         Snap '8'                   # no gridlines
  $xl.ActiveWindow.DisplayGridlines = $true
  Press (Find $root @('Home') $T::TabItem)
  $ws.Activate(); $null = $ws.Range('A1').Select()
  Start-Sleep -Milliseconds 800

  # 4. Save As (F12) into Google Drive, My Drive > CAT. The dialog opens in My Drive
  # (Excel's default folder, set for this run), and the workbook's author is Mr Botha.
  New-Item -ItemType Directory -Force $cloud | Out-Null
  Remove-Item (Join-Path $cloud 'Botha prices.xlsx') -ErrorAction SilentlyContinue
  $oldPath = $xl.DefaultFilePath
  $xl.DefaultFilePath = 'G:\My Drive'
  try { $wb.Author = 'Mr Botha' } catch { "  no author: $_" }
  Snap 's-1'                                                        # Prices, A1 active - press F12
  [Shot]::PostKey($grid, 0x7B)                                      # F12, posted to Excel's grid
  $dlg = TopWindow @('Save As')
  if (-not $dlg) { throw 'No Save As dialog after F12' }
  $script:dialogOpen = $true
  $dh = [IntPtr]$dlg.Current.NativeWindowHandle
  Start-Sleep -Milliseconds 1500
  $fnPane  = Find $dlg @('File name:') $T::Pane
  $editH   = [Shot]::Child($dh, 'Edit')                             # the File name box, a Win32 edit inside the combo
  $saveH   = [XlMsg]::ChildByText($dh, 'Button', 'Save')
  "  edit $editH, save $saveH"
  if ($editH -eq [IntPtr]::Zero) { throw 'No File name box (Win32)' }
  $saveBtn = $null
  foreach ($e in $dlg.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Save')))) { if ($e.Current.BoundingRectangle.Width -lt 200) { $saveBtn = $e } }
  $fileBox = $fnPane
  function DlgType([string]$text) { [XlMsg]::SetText($editH, $text) }
  function DlgSave { if ($saveH -ne [IntPtr]::Zero) { [XlMsg]::Click($saveH) } else { [Shot]::PostKey($editH, 0x0D) } }
  $addr = $null
  foreach ($e in $dlg.FindAll($Scope::Descendants, [System.Windows.Automation.Condition]::TrueCondition)) { if ($e.Current.Name -like 'Address: *') { $addr = $e.Current.Name; break } }
  "  the dialog opened at: $addr"
  if ($addr -notlike '*My Drive*') {
    DlgType 'G:\My Drive'; DlgSave                  # it opened somewhere else: open My Drive
    Start-Sleep -Milliseconds 2000
  }
  DlgType 'Book1.xlsx'
  Start-Sleep -Milliseconds 800
  DumpOf $dh 'saveas-1'
  $script:marks['dialog'] = [WinRect]::Of($dh)
  $script:marks['d-fileName'] = BoxIn $fileBox $dh
  if ($saveBtn) { $script:marks['d-save'] = BoxIn $saveBtn $dh }
  $catItem = $null
  foreach ($e in $dlg.FindAll($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'CAT')))) { if ($e.Current.ControlType -eq $T::ListItem) { $catItem = $e } }
  if ($catItem) { $script:marks['d-catFolder'] = BoxIn $catItem $dh } else { '  MISSING d-catFolder' }
  SnapPrivate $dlg $dh 's-2'                                        # My Drive, with the CAT folder

  DlgType $cloud; DlgSave                           # opens CAT (a double-click on it)
  Start-Sleep -Milliseconds 2000
  DlgType 'Book1.xlsx'
  Start-Sleep -Milliseconds 800
  DumpOf $dh 'saveas-2'
  SnapPrivate $dlg $dh 's-3'                                        # CAT - type the name here
  DlgType 'Botha prices'
  Start-Sleep -Milliseconds 500
  SnapPrivate $dlg $dh 's-4'                                        # the name typed
  DlgSave
  Start-Sleep -Milliseconds 3000
  $script:dialogOpen = $false
  $xl.DefaultFilePath = $oldPath
  Snap 's-5'                                                        # saved
  "saved: $($wb.FullName)"

  SaveMarks
}
catch {
  "FAILED: $_"
  SaveMarks
  throw
}
finally {
  if ($script:dialogOpen) { Stop-Process -Id ([Shot]::Pid($h)) -Force -ErrorAction SilentlyContinue }
  else {
    try { $xl.DefaultFilePath = $oldPath } catch { }
    if ($wb) { try { $wb.Close($false) } catch { } }
    try { $xl.Quit() } catch { Stop-Process -Id ([Shot]::Pid($h)) -Force -ErrorAction SilentlyContinue }
  }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
