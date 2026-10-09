# Real Excel 365 screens for catexcel Grade 11, lesson 10: Absolute references
# and range names (AIPascalCourse/content/catexcel/absolute.php - written to
# courses/cat-practical-writing.md, 9 October 2026). Botha's Bakery: Thabo's
# VAT formula copied down without $ (0, #VALUE!, 96 - and Show Formulas),
# the formula typed and made absolute ($B$2 - F4 tried), filled down; the VAT
# cell named in the Name Box and used (=B5*VAT); the Name Manager; each
# item's share of Saturday's takings (=B5/$B$12) and Percent Style. Also
# makes the pupils' starter file FarewellBudget.xlsx (and a done-right copy)
# in C:\sims\files\catexcel-absolute\ and G:\My Drive\CAT\Excel\.
# Typing is posted to Excel's grid (work\catexcel11a-kit.ps1, Chars), so the
# formula shows while it is typed. Read office-kit.ps1's safety rules first.
# Crop: work/catexcel-absolute-crop.py.
#     pwsh -File vm-shots.ps1 catexcel-absolute -TimeoutSec 1200   (from the host)
$Name = 'catexcel-absolute'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel11a-kit.ps1')

$filesDir = "C:\sims\files\$Name"
$cloudDir = 'G:\My Drive\CAT\Excel'
New-Item -ItemType Directory -Force $filesDir | Out-Null
try { New-Item -ItemType Directory -Force $cloudDir | Out-Null } catch { "no cloud folder: $_" }

$items = @(
  @('White bread', 16), @('Brown bread', 14), @('Koeksisters (6)', 24),
  @('Vetkoek', 6), @('Milk tart', 80), @('Cupcakes (6)', 42))
$takings = @(
  @('White bread', 1280), @('Brown bread', 560), @('Koeksisters (6)', 720),
  @('Vetkoek', 330), @('Milk tart', 960), @('Cupcakes (6)', 630))
$farewell = @(
  @('Hall hire', 3500), @('DJ', 2200), @('Catering', 18000), @('Decorations', 2600),
  @('Photographer', 1800), @('Flowers', 950), @('Printing the tickets', 480), @('Bus hire', 3000))

function Heading ($ws, $range) {
  try { $ws.Range($range).Style = 'Accent1' } catch { }
  $ws.Range($range).Font.Bold = $true
  $ws.Range($range).WrapText = $true
}
function Title ($ws, $text) {
  $ws.Range('A1').Formula = $text
  try { $ws.Range('A1').Style = 'Title' } catch { $ws.Range('A1').Font.Bold = $true; $ws.Range('A1').Font.Size = 16 }
}

$xl = New-Object -ComObject Excel.Application
$xlPid = 0
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $xlPid = [int][Shot]::Pid([IntPtr]$xl.Hwnd)
  "my Excel: $xlPid"

  # ---------------------------------------------------------------- the starter file and a done-right copy
  $sb = $xl.Workbooks.Add()
  $sf = $sb.Worksheets.Item(1); $sf.Name = 'Budget'
  Title $sf 'Phumlani Secondary - Matric Farewell 2026'
  $sf.Range('A2').Formula = 'VAT rate'; $sf.Range('B2').Formula = '0.15'; $sf.Range('B2').NumberFormat = '0%'
  $sf.Range('A3').Formula = 'Tickets';  $sf.Range('B3').Formula = '120'
  FillAt $sf @(,@('Item', 'Cost excl. VAT (R)', 'VAT (R)', 'Cost incl. VAT (R)', 'Share of total')) 5
  FillAt $sf $farewell 6
  $sf.Range('A14').Formula = 'Total'
  $sf.Range('A16').Formula = 'Cost per ticket'
  Heading $sf 'A5:E5'
  $sf.Range('A14').Font.Bold = $true; $sf.Range('A16').Font.Bold = $true
  $sf.Range('B6:D16').NumberFormat = '0.00'
  $sf.Columns.Item('A').ColumnWidth = 22
  foreach ($c in 'B', 'C', 'D', 'E') { $sf.Columns.Item($c).ColumnWidth = 14 }
  $null = $sf.Range('A1').Select()
  $sb.SaveAs((Join-Path $filesDir 'FarewellBudget.xlsx'), 51)
  try { Copy-Item (Join-Path $filesDir 'FarewellBudget.xlsx') $cloudDir -Force } catch { "cloud copy failed: $_" }
  # done right, by real Excel
  $sf.Range('C6:C13').Formula = '=B6*$B$2'
  $sf.Range('D6:D13').Formula = '=B6+C6'
  $sf.Range('D14').Formula = '=SUM(D6:D13)'
  $sf.Range('E6:E13').Formula = '=D6/$D$14'
  $sf.Range('E6:E13').NumberFormat = '0%'
  $null = $sb.Names.Add('Tickets', '=Budget!$B$3')
  $sf.Range('D16').Formula = '=D14/Tickets'
  "done: C6 $($sf.Range('C6').Text) D14 $($sf.Range('D14').Text) E8 $($sf.Range('E8').Text) D16 $($sf.Range('D16').Text)"
  $sb.SaveAs((Join-Path $filesDir 'FarewellBudget-done.xlsx'), 51)
  $sb.Close($false); $sb = $null

  # ---------------------------------------------------------------- the lesson's workbook
  $wb = $xl.Workbooks.Add()
  while ($wb.Worksheets.Count -lt 2) { $null = $wb.Worksheets.Add([Type]::Missing, $wb.Worksheets.Item($wb.Worksheets.Count)) }
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Prices'
  $wt = $wb.Worksheets.Item(2); $wt.Name = 'Takings'
  Title $ws 'Botha''s Bakery - Saturday prices'
  $ws.Range('A2').Formula = 'VAT rate'; $ws.Range('B2').Formula = '0.15'; $ws.Range('B2').NumberFormat = '0%'
  FillAt $ws @(,@('Item', 'Price excl. VAT (R)', 'VAT (R)', 'Price incl. VAT (R)')) 4
  FillAt $ws $items 5
  Heading $ws 'A4:D4'
  $ws.Range('B5:D10').NumberFormat = '0.00'
  $ws.Columns.Item('A').ColumnWidth = 18
  foreach ($c in 'B', 'C', 'D') { $ws.Columns.Item($c).ColumnWidth = 13 }
  $ws.Rows.Item(4).RowHeight = 33

  Title $wt 'Botha''s Bakery - Saturday takings'
  FillAt $wt @(,@('Item', 'Takings (R)', 'Share of total')) 4
  FillAt $wt $takings 5
  $wt.Range('A12').Formula = 'Total'; $wt.Range('A12').Font.Bold = $true
  $wt.Range('B12').Formula = '=SUM(B5:B10)'
  Heading $wt 'A4:C4'
  $wt.Range('B5:B12').NumberFormat = '0.00'
  $wt.Columns.Item('A').ColumnWidth = 18
  foreach ($c in 'B', 'C') { $wt.Columns.Item($c).ColumnWidth = 13 }
  $wt.Rows.Item(4).RowHeight = 33

  $null = $ws.Activate()
  $null = $ws.Range('F5').Select()
  ShowExcel
  foreach ($a in 'A1', 'B2', 'C5', 'C6', 'C7', 'C5:C10', 'D5', 'F5') { Mark ('cell' + ($a -replace ':', '_')) (CellBox $ws $a) }
  Mark 'fillC5' (FillHandleBox $ws 'C5')
  foreach ($tab in 'Home', 'Formulas') { TryMark ('tab' + $tab) $root @($tab) $T::TabItem }
  TryMark 'nameBox'    $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')
  TryMark 'insertFn'   $root @('Insert Function')
  TryMark 'percent'    $root @('Percent Style')
  Dump 'home'
  "grid: $grid"

  # 1. The problem: Thabo's =B5*B2 filled down - relative, so B2 slides to B3, B4 ...
  $ws.Range('C5:C10').Formula = '=B5*B2'
  $null = $ws.Range('C7').Select()
  SnapAll 'p-1'                                                     # 2.40, 0.00, #VALUE!, 96.00 ...; C7 =B7*B4
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 600
  SnapAll 'p-2'                                                     # Show Formulas: B2, B3, B4, B5 ...
  $xl.ActiveWindow.DisplayFormulas = $false
  $ws.Range('C5:C10').ClearContents()

  # 2. Fixed: =B5*$B$2 (typed, then F4), Enter, filled down.
  $null = $ws.Range('F5').Select()
  SnapAll 'v-1'                                                     # the clean sheet, F5 active
  $null = $ws.Range('C5').Select()
  SnapAll 'v-1b'                                                    # C5 active
  TypeAndSnap '=B5*B2' 'v-2' -Escape                                # =B5*B2 being typed in C5
  $null = $ws.Range('C5').Select()
  # F4 itself, posted to the grid while =B5*B2 is being typed (kept if it works: x-f4)
  TypeAndSnap '=B5*B2' $null -NoEnd
  [CompA]::Key($grid, 0x73)
  Start-Sleep -Milliseconds 900
  SnapAll 'x-f4'
  [CompA]::Key($grid, 0x1B)
  Start-Sleep -Milliseconds 1000
  $null = $ws.Range('C5').Select()
  TypeAndSnap '=B5*$B$2' 'v-3'                                      # =B5*$B$2 being typed; then Enter
  "after Enter: C5 = $($ws.Range('C5').Formula), active $($xl.ActiveCell.Address(0, 0))"
  SnapAll 'v-3b'                                                    # Enter: 2.40, C6 active
  if ($ws.Range('C5').Formula -ne '=B5*$B$2') { $ws.Range('C5').Formula = '=B5*$B$2'; "  (typed into C5 by COM)" }
  $null = $ws.Range('C5').Select()
  SnapAll 'v-4'                                                     # C5 selected again, 2.40
  $null = $ws.Range('C5').AutoFill($ws.Range('C5:C10'), 0)
  $null = $ws.Range('C7').Select()
  SnapAll 'v-5'                                                     # all filled; C7 =B7*$B$2
  $ws.Range('D5:D10').Formula = '=B5+C5'
  $null = $ws.Range('D7').Select()
  SnapAll 'v-6'                                                     # incl. VAT too
  $ws.Range('C5:D10').ClearContents()

  # 3. A name for one cell: B2 is VAT (Name Box), then =B5*VAT.
  $null = $ws.Range('B2').Select()
  SnapAll 'n-1'                                                     # B2 selected; Name Box says B2
  $named = $false
  try {
    $nb = Find $root @('Name Box') -tries 4
    Mark 'nameBoxEl' (Box $nb)
    $edit = $nb.FindFirst($Scope::Descendants, (New-Object $PropCond($AE::ControlTypeProperty, $T::Edit)))
    if (-not $edit) { $edit = $nb }
    SetText $edit 'VAT'
    Start-Sleep -Milliseconds 700
    SnapAll 'n-1b'                                                  # VAT typed in the Name Box
    $hw = [IntPtr]$edit.Current.NativeWindowHandle
    if ($hw -eq [IntPtr]::Zero) { $hw = [IntPtr]$nb.Current.NativeWindowHandle }
    "name box handle: $hw"
    if ($hw -ne [IntPtr]::Zero) { [CompA]::Key($hw, 0x0D); Start-Sleep -Milliseconds 1200 }
    foreach ($n in $wb.Names) { "  name: $($n.Name) $($n.RefersTo)"; if ($n.Name -eq 'VAT') { $named = $true } }
  } catch { "name box: $_" }
  if (-not $named) { $null = $wb.Names.Add('VAT', '=Prices!$B$2'); "  (named by COM)" }
  $null = $ws.Range('B2').Select()
  SnapAll 'n-1c'                                                    # B2 selected after naming
  $null = $ws.Range('C5').Select()
  SnapAll 'n-2'                                                     # C5 active
  TypeAndSnap '=B5*VAT' 'n-3'                                       # =B5*VAT being typed; Enter
  if ($ws.Range('C5').Formula -ne '=B5*VAT') { $ws.Range('C5').Formula = '=B5*VAT'; "  (typed into C5 by COM)" }
  $null = $ws.Range('C5').Select()
  SnapAll 'n-4'                                                     # 2.40 from =B5*VAT
  $null = $ws.Range('C5').AutoFill($ws.Range('C5:C10'), 0)
  $null = $ws.Range('C8').Select()
  SnapAll 'n-5'                                                     # filled: C8 =B8*VAT

  # the Name Manager (Formulas tab)
  try {
    Press (Find $root @('Formulas') $T::TabItem)
    Start-Sleep -Milliseconds 1000
    Dump 'formulas'
    TryMark 'nameMgr' $root @('Name Manager')
    TryMark 'defineName' $root @('Define Name', 'Define Name...')
    SnapAll 'nm-0'                                                  # the Formulas tab
    PressAsync (Find $root @('Name Manager') -tries 6)
    WaitOthers
    FitDialogs
    DumpOthers 'namemgr'
    MarkAny 'nmEdit' @('Edit...', 'Edit')
    MarkAny 'nmDelete' @('Delete')
    MarkAny 'nmNew' @('New...', 'New')
    SnapAll 'nm-1' -Others                                          # the Name Manager: VAT =Prices!$B$2
    CloseOthers
  } catch { "name manager: $_"; if (@([CompA]::Others($h)).Count -gt 0) { CloseOthers } }
  try { Press (Find $root @('Home') $T::TabItem); Start-Sleep -Milliseconds 800 } catch { }

  # 4. Share of the total on Takings: =B5/$B$12, filled, Percent Style.
  $null = $wt.Activate()
  $null = $wt.Range('F5').Select()
  Start-Sleep -Milliseconds 800
  foreach ($a in 'B12', 'C5', 'C5:C10', 'C12', 'F5') { Mark ('t' + ($a -replace ':', '_')) (CellBox $wt $a) }
  Mark 'tfillC5' (FillHandleBox $wt 'C5')
  TryMark 'percent2' $root @('Percent Style')
  SnapAll 's-1'                                                     # Takings, F5 active
  $null = $wt.Range('C5').Select()
  SnapAll 's-2'                                                     # C5 active
  TypeAndSnap '=B5/$B$12' 's-2t'                                    # typed; Enter
  if ($wt.Range('C5').Formula -ne '=B5/$B$12') { $wt.Range('C5').Formula = '=B5/$B$12'; "  (typed into C5 by COM)" }
  $null = $wt.Range('C5').Select()
  SnapAll 's-3'                                                     # 0.285714...
  $null = $wt.Range('C5').AutoFill($wt.Range('C5:C10'), 0)
  $null = $wt.Range('C5:C10').Select()
  SnapAll 's-4'                                                     # filled, decimals, selected
  try { Press (Find $root @('Percent Style') -tries 6); Start-Sleep -Milliseconds 1000 } catch { "percent: $_"; $wt.Range('C5:C10').NumberFormat = '0%' }
  "C5 format: $($wt.Range('C5').NumberFormat)"
  SnapAll 's-5'                                                     # 29%, 13% ...
  $wt.Range('C12').Formula = '=SUM(C5:C10)'; $wt.Range('C12').NumberFormat = '0%'
  $null = $wt.Range('C7').Select()
  SnapAll 's-6'                                                     # C7 =B7/$B$12; C12 100%
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 600
  SnapAll 's-7'                                                     # Show Formulas: $B$12 in every row
  $xl.ActiveWindow.DisplayFormulas = $false

  SaveMarks
}
catch {
  "FAILED: $_ (line $($_.InvocationInfo.ScriptLineNumber)) - the pictures so far still come back"
  try { if ($grid) { [CompA]::Key($grid, 0x1B) } } catch { }
}
finally {
  try { SaveMarks } catch { }
  if ($wb) { try { $wb.Close($false) } catch { "close: $_" } }
  try { $xl.Quit() } catch { "quit: $_" }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
  if ($xlPid) { Start-Sleep -Seconds 2; Stop-Process -Id $xlPid -Force -ErrorAction SilentlyContinue }
}
