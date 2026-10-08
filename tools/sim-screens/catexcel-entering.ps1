# Real Excel 365 screens for catexcel lesson 2, Entering and changing data
# (content/catexcel/entering.php - 8 October 2026). Ms Naidoo's class list
# at Phumlani Secondary: kinds of data, fixing a name by typing over it,
# inserting a row (right-click and the Home tab), numbering with the fill
# handle, and copying the headings to a second sheet and renaming it.
# Read office-kit.ps1's safety rules. Run it in the CAT VM:
#     pwsh -File vm-shots.ps1 catexcel-entering
# Then: python cat-crop.py catexcel-entering
$Name = 'catexcel-entering'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 3) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Sheet1'
  $s2 = $wb.Worksheets.Item(2); $s2.Name = 'Sheet2'
  $ty = $wb.Worksheets.Item(3); $ty.Name = 'Types'
  FillRows $ws @(
    @('No.', 'Surname', 'Name', 'Term 1', 'Term 2'),
    @('1', 'Dlamini', 'Sipho', 64, 70),
    @('', 'Govender', 'Priya', 81, 78),
    @('', 'Khumalo', 'Nomvla', 73, 75),
    @('', 'Molefe', 'Kagiso', 58, 66),
    @('', 'Patel', 'Ayesha', 90, 88),
    @('', 'Van Wyk', 'Johan', 69, 72))
  foreach ($col in 'A') { $ws.Columns.Item($col).ColumnWidth = 6 }
  foreach ($col in 'B', 'C', 'D', 'E', 'F') { $ws.Columns.Item($col).ColumnWidth = 12 }
  foreach ($col in 'A', 'B', 'C', 'D', 'E', 'F') { $s2.Columns.Item($col).ColumnWidth = 12 }
  $s2.Columns.Item('A').ColumnWidth = 6

  # The kinds of data: what was typed, and what Excel made of it.
  FillRows $ty @(
    @('You typed', 'Excel shows'),
    @('Sipho'),
    @('64'),
    @('2026/03/12'),
    @('12:30'),
    @('R18'),
    @('0821234567'),
    @("'0821234567"))
  $ty.Range('A2').Formula = "'Sipho"; $ty.Range('B2').Formula = 'Sipho'
  $ty.Range('A3').Formula = "'64";    $ty.Range('B3').Formula = '64'
  $ty.Range('A4').Formula = "'2026/03/12"; $ty.Range('B4').Formula = '=DATE(2026,3,12)'; $ty.Range('B4').Value2 = $ty.Range('B4').Value2; $ty.Range('B4').NumberFormat = 'yyyy/mm/dd'
  $ty.Range('A5').Formula = "'12:30"; $ty.Range('B5').Formula = '=TIME(12,30,0)'; $ty.Range('B5').Value2 = $ty.Range('B5').Value2; $ty.Range('B5').NumberFormat = 'hh:mm'
  $ty.Range('A6').Formula = "'R18";   $ty.Range('B6').Formula = 'R18'
  $ty.Range('A7').Formula = "'0821234567"; $ty.Range('B7').Formula = '821234567'
  $ty.Range('A8').Formula = "''0821234567"; $ty.Range('B8').Formula = "'0821234567"
  $ty.Columns.Item('A').ColumnWidth = 16; $ty.Columns.Item('B').ColumnWidth = 16

  $ws.Activate()
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)
  $grid = [Shot]::Child($h, 'EXCEL7')

  foreach ($a in 'A1', 'A2', 'A3', 'A8', 'B5', 'C4', 'E1') { Mark $a (CellBox $ws $a) }
  $a3 = CellBox $ws 'A3'
  Mark 'fillA3' @(($a3[0] + $a3[2] - 9), ($a3[1] + $a3[3] - 9), 18, 18)   # the fill handle of A2:A3
  Mark 'row5' (RowHeadBox $ws 5)
  TryMark 'sheet1'    $root @('Sheet1') $T::TabItem
  TryMark 'sheet2'    $root @('Sheet2') $T::TabItem
  TryMark 'insert'    $root @('Insert', 'Insert Cells') $T::Button
  TryMark 'insertSplit' $root @('Insert') $T::SplitButton
  TryMark 'delete'    $root @('Delete') $T::SplitButton
  TryMark 'paste'     $root @('Paste') $T::SplitButton
  TryMark 'copy'      $root @('Copy') $T::SplitButton
  TryMark 'undo'      $root @('Undo') $T::SplitButton
  Dump 'home'

  # 0. The kinds of data.
  $ty.Activate(); $null = $ty.Range('D2').Select()
  Start-Sleep -Milliseconds 600
  Snap 'types'
  $ws.Activate(); $null = $ws.Range('A1').Select()
  $ty.Delete()                                                      # the class list's pictures show only its own two sheets
  Start-Sleep -Milliseconds 600

  # 1. Fix a name: click it, type over it.
  Snap 'fix-1'                                                      # A1 active; Nomvla in C4
  $null = $ws.Range('C4').Select(); Snap 'fix-2'                    # C4 clicked
  $ws.Range('C4').Formula = 'Nomvula'
  $null = $ws.Range('C5').Select(); Snap 'fix-3'                    # typed, Enter: C5 active

  # 2. Insert a row above Molefe (row 5): right-click its heading, Insert.
  Snap 'ins-1'                                                      # before
  $null = $ws.Rows.Item(5).Select(); Start-Sleep -Milliseconds 500
  $r5 = RowHeadBox $ws 5
  $win = [WinRect]::Of($h)
  $sx = $win[0] + $r5[0] + 12; $sy = $win[1] + $r5[1] + 8
  $menu = $null
  [Shot]::PostKey($grid, 0x5D)                                      # the menu key (VK_APPS): the same menu a right-click on the selected row opens
  $cxy = [XlMsg]::ToClient($grid, $sx, $sy)
  for ($i = 0; $i -lt 32 -and -not $menu; $i++) {
    if ($i -eq 8)  { "  no menu from the menu key: trying WM_CONTEXTMENU"; [XlMsg]::Post($grid, 0x007B, [int]$grid, (($sy -shl 16) -bor ($sx -band 0xFFFF))) }
    if ($i -eq 16) { "  no menu from WM_CONTEXTMENU: trying a right button press posted to the grid"; [XlMsg]::Post($grid, 0x0204, 2, $cxy); [XlMsg]::Post($grid, 0x0205, 0, $cxy) }
    Start-Sleep -Milliseconds 300
    foreach ($el in $AE::RootElement.FindAll($Scope::Children, [System.Windows.Automation.Condition]::TrueCondition)) {
      try { if ($el.Current.ProcessId -eq [int][Shot]::Pid($h) -and $el.Current.NativeWindowHandle -ne [int]$h -and ($el.Current.ControlType -eq $T::Menu -or $el.Current.ClassName -like '*Net UI*' -or $el.Current.Name -like '*Context*')) { $menu = $el } } catch { }
    }
  }
  if ($menu) {
    $mh = [IntPtr]$menu.Current.NativeWindowHandle
    "  context menu: '$($menu.Current.Name)' class $($menu.Current.ClassName)"
    DumpOf $mh 'menu'
    $insItem = $menu.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::NameProperty, 'Insert')))
    if ($insItem) { $b = $insItem.Current.BoundingRectangle; Mark 'menuInsert' @([int]($b.X - $win[0]), [int]($b.Y - $win[1]), [int]$b.Width, [int]$b.Height) }
    SnapWithPopup $mh 'ins-2r'                                      # the right-click menu
    [Shot]::PostKey($mh, 0x1B); [Shot]::PostKey($grid, 0x1B)        # Escape closes it
    Start-Sleep -Milliseconds 800
  } else { '  NO context menu came up' }
  $null = $ws.Rows.Item(5).Select()
  Snap 'ins-2'                                                      # row 5 selected, Home tab
  $null = $ws.Rows.Item(5).Insert()
  Start-Sleep -Milliseconds 600
  Snap 'ins-3'                                                      # an empty row 5
  $ws.Range('B5').Formula = 'Mahlangu'
  $ws.Range('C5').Formula = 'Zanele'
  $null = $ws.Range('B6').Select(); Snap 'ins-4'                    # Mahlangu typed, Enter

  # 3. Number the pupils: 1 and 2, then the fill handle.
  $null = $ws.Range('A3').Select(); Snap 'num-1'                    # A2 holds 1; A3 active
  $ws.Range('A3').Formula = '2'
  $null = $ws.Range('A2:A3').Select(); Snap 'num-2'                 # A2:A3 selected
  $null = $ws.Range('A2:A3').AutoFill($ws.Range('A2:A8'), 0)
  $null = $ws.Range('A2:A8').Select(); Snap 'num-3'                 # 1 to 7

  # 4. Copy the headings to Sheet2, then rename it.
  $null = $ws.Range('A1:E1').Select(); Snap 'cp-1'                  # A1:E1 selected - Ctrl+C
  $ws.Range('A1:E1').Copy() | Out-Null
  Start-Sleep -Milliseconds 600; Snap 'cp-2'                        # copied (the status bar says so)
  $s2.Activate(); $null = $s2.Range('A1').Select()
  Start-Sleep -Milliseconds 600; Snap 'cp-3'                        # Sheet2, A1 active - Ctrl+V
  $s2.Paste($s2.Range('A1')) | Out-Null
  [Shot]::PostKey($grid, 0x1B)                                      # Esc: the copied border goes
  Start-Sleep -Milliseconds 600; Snap 'cp-4'                        # pasted
  try { $xl.CommandBars.ExecuteMso('SheetRename'); Start-Sleep -Milliseconds 900; Snap 'cp-5'; [Shot]::PostKey($grid, 0x1B); Start-Sleep -Milliseconds 600 }   # the tab's name ready to type over
  catch { "  NO rename mode: $_" }
  $s2.Name = '10B'
  Start-Sleep -Milliseconds 600; Snap 'cp-6'                        # renamed 10B
  TryMark 'sheet10B'  $root @('10B') $T::TabItem

  SaveMarks
}
catch {
  "FAILED: $_"
  SaveMarks
  throw
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { } }
  try { $xl.Quit() } catch { Stop-Process -Id ([Shot]::Pid($h)) -Force -ErrorAction SilentlyContinue }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
