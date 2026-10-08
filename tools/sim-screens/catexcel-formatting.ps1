# Real Excel 365 screens for catexcel lesson 4, Formatting cells and numbers
# (content/catexcel/formatting.php - 8 October 2026). Botha's Bakery's new
# price list: a merged, bold title; headings with a fill and a border;
# Accounting, Percent Style and Increase Decimal; a long date in Format
# Cells and the ###### it causes; AutoFit; the Cell Styles gallery.
# Read office-kit.ps1's safety rules. Run it in the CAT VM:
#     pwsh -File vm-shots.ps1 catexcel-formatting
# Then: python cat-crop.py catexcel-formatting
$Name = 'catexcel-formatting'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$script:dialogOpen = $false
$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Prices'
  FillRows $ws @(
    @("Botha's Bakery price list"),
    @(),
    @('Item', 'Old price', 'New price', 'Increase', 'Changed on'),
    @('White bread', 18, 19.5, '=(C4-B4)/B4'),
    @('Brown bread', 17, 18, '=(C5-B5)/B5'),
    @('Rolls (6)', 22, 24, '=(C6-B6)/B6'),
    @('Koeksisters', 8, 8.5, '=(C7-B7)/B7'),
    @('Milk tart', 15, 16.5, '=(C8-B8)/B8'))
  $dates = @('=DATE(2026,3,1)', '=DATE(2026,3,1)', '=DATE(2026,4,1)', '=DATE(2026,5,4)', '=DATE(2026,3,1)')
  for ($i = 0; $i -lt 5; $i++) { $c = $ws.Range("E$(4 + $i)"); $c.Formula = $dates[$i]; $c.Value2 = $c.Value2 }
  $ws.Range('E4:E8').NumberFormat = 'yyyy/mm/dd'
  $ws.Columns.Item('A').ColumnWidth = 16
  foreach ($col in 'B', 'C', 'D', 'E') { $ws.Columns.Item($col).ColumnWidth = 11 }
  $null = $ws.Range('A1:E1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  foreach ($a in 'A1', 'A3', 'B4', 'D4', 'E4') { Mark $a (CellBox $ws $a) }
  $e4 = CellBox $ws 'E4'; $eh = ColHeadBox $ws 'E'
  Mark 'edgeE' @(($e4[0] + $e4[2] - 5), $eh[1], 10, $eh[3])        # the line at the right of column E's heading
  $fb = Box (Find $root @('Formula Bar') $T::Edit)
  Mark 'formulaBar' $fb
  TryMark 'merge'       $root @('Merge & Center') $T::Button
  TryMark 'mergeSplit'  $root @('Merge & Center') $T::SplitButton
  TryMark 'bold'        $root @('Bold') $T::Button
  TryMark 'growFont'    $root @('Increase Font Size') $T::Button
  TryMark 'fontSize'    $root @('Font Size') $T::ComboBox
  TryMark 'fill'        $root @('Fill Color') $T::Button
  TryMark 'fillSplit'   $root @('Fill Color') $T::SplitButton
  TryMark 'borders'     $root @('Bottom Border', 'Borders') $T::Button
  TryMark 'bordersSplit' $root @('Borders', 'Bottom Border') $T::SplitButton
  TryMark 'accounting'  $root @('Accounting Number Format') $T::Button
  TryMark 'accountingSplit' $root @('Accounting Number Format') $T::SplitButton
  TryMark 'percent'     $root @('Percent Style') $T::Button
  TryMark 'moreDecimal' $root @('Increase Decimal') $T::Button
  TryMark 'lessDecimal' $root @('Decrease Decimal') $T::Button
  TryMark 'wrap'        $root @('Wrap Text') $T::Button
  TryMark 'orientation' $root @('Orientation') $T::MenuItem
  TryMark 'numberFormat' $root @('Number Format') $T::ComboBox
  TryMark 'cellStyles'  $root @('Cell Styles') $T::MenuItem
  TryMark 'formatTable' $root @('Format as Table') $T::MenuItem
  TryMark 'numberLauncher' $root @('Format Cell Number')
  Dump 'home'

  # 1. The title: Merge & Center, Ctrl+B, Increase Font Size.
  Snap 't-1'                                                        # A1:E1 selected
  Press (Find $root @('Merge & Center') $T::Button)                 # the ribbon's own button
  Start-Sleep -Milliseconds 600
  $null = $ws.Range('A1:E1').Select(); Snap 't-2'                   # merged and centred
  $ws.Range('A1').Font.Bold = $true; Snap 't-3'                     # bold
  Press (Find $root @('Increase Font Size') $T::Button)
  Start-Sleep -Milliseconds 600;     Snap 't-4'                     # one size bigger

  # 2. The headings: Fill Color, then a bottom border.
  $null = $ws.Range('A3:E3').Select(); Snap 'h-1'
  $ws.Range('A3:E3').Interior.Color = 65535                          # yellow, the button's colour in a new Excel
  Snap 'h-2'
  try { Press (Find $root @('Bottom Border', 'Borders') $T::Button) } catch { }   # the button's own border (Bottom Border in a new Excel)
  Start-Sleep -Milliseconds 600
  if ($ws.Range('A3').Borders.Item(9).LineStyle -ne 1) { '  the Borders button put on no bottom border: set through COM'; $ws.Range('A3:E3').Borders.Item(9).LineStyle = 1; $ws.Range('A3:E3').Borders.Item(9).Weight = -4138 }
  Start-Sleep -Milliseconds 600
  $ws.Range('A3:E3').Font.Bold = $true
  $null = $ws.Range('A10').Select(); Snap 'h-3'

  # 3. The numbers: Accounting on the prices, Percent Style and one more decimal on the increases.
  $null = $ws.Range('B4:C8').Select(); Snap 'n-1'
  Press (Find $root @('Accounting Number Format') $T::Button)       # the ribbon's own button: rands, as the VM is set up for South Africa
  Start-Sleep -Milliseconds 600
  $null = $ws.Range('D4:D8').Select(); Snap 'n-2'                   # rands done; D4:D8 selected
  Press (Find $root @('Percent Style') $T::Button);    Start-Sleep -Milliseconds 600; Snap 'n-3'   # 8%, 6% ...
  Press (Find $root @('Increase Decimal') $T::Button); Start-Sleep -Milliseconds 600; Snap 'n-4'   # 8.3%, 5.9% ...
  "  percent format in use: $($ws.Range('D4').NumberFormat)" 
  "  accounting format in use: $($ws.Range('B4').NumberFormat)"

  # 4. A long date in Format Cells (Ctrl+1); the ###### it causes; AutoFit.
  $null = $ws.Range('E4:E8').Select(); Snap 'd-1'
  PressAsync (Find $root @('Format Cell Number'))
  $dlg = TopWindow @('Format Cells')
  if (-not $dlg) { throw 'No Format Cells dialog' }
  $script:dialogOpen = $true
  $dh = [IntPtr]$dlg.Current.NativeWindowHandle
  Start-Sleep -Milliseconds 1500
  $dr = [XlMsg]::Rect($dh)
  $script:marks['fcDialog'] = $dr
  SnapOf $dh 'd-2'                                                  # Number tab, Date, the short date chosen
  "  dialog class: $($dlg.Current.ClassName)"
  # Format Cells is one of Office's own dialogs (no Win32 controls inside): keys posted to the dialog
  # move its focus as on a real keyboard - Tab twice to the Type list, Down five times to "14 March 2012".
  [Shot]::PostKey($dh, 0x09); Start-Sleep -Milliseconds 400        # the Number tab -> the Category list
  [Shot]::PostKey($dh, 0x09); Start-Sleep -Milliseconds 400        # -> the Type list
  for ($i = 0; $i -lt 5; $i++) { [Shot]::PostKey($dh, 0x28); Start-Sleep -Milliseconds 250 }
  Start-Sleep -Milliseconds 900
  SnapOf $dh 'd-3'                                                  # the long date chosen
  # Places on the dialog, read off its picture (dialog-window pixels): the sixth Type line, OK, the Category list.
  $script:marks['fcLongDate'] = @(227, 273, 410, 17)
  $script:marks['fcOK']       = @(434, 588, 112, 30)
  $script:marks['fcCategory'] = @(33, 110, 155, 340)
  [Shot]::PostKey($dh, 0x0D)                                        # Enter: OK
  for ($i = 0; $i -lt 20 -and [Shot]::Pid($dh) -ne 0; $i++) { Start-Sleep -Milliseconds 300 }
  Start-Sleep -Milliseconds 1200
  if ($AE::RootElement.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'Format Cells')))) { '  the dialog is still open: Escape'; [Shot]::PostKey($dh, 0x1B); Start-Sleep -Milliseconds 1500 }
  if ($AE::RootElement.FindFirst($Scope::Children, (New-Object $PropCond($AE::NameProperty, 'Format Cells')))) { throw 'Format Cells did not close' }
  $script:dialogOpen = $false
  "  long date format: $($ws.Range('E4').NumberFormat)"
  if ($ws.Range('E4').NumberFormat -notlike '*mmmm*') { throw "Format Cells gave $($ws.Range('E4').NumberFormat), not the long date" }
  $null = $ws.Range('E4:E8').Select(); Snap 'd-4'                   # ######
  $null = $ws.Columns.Item('E').AutoFit()
  Start-Sleep -Milliseconds 600; Snap 'd-5'                         # the dates show

  # 5. The Cell Styles gallery, open (for a figure).
  $null = $ws.Range('A10').Select()
  try {
    PressAsync (Find $root @('Cell Styles'))
    $pop = PopupWindow
    if ($pop) {
      $ph = [IntPtr]$pop.Current.NativeWindowHandle
      "  gallery: '$($pop.Current.Name)' class $($pop.Current.ClassName)"
      DumpOf $ph 'styles'
      SnapWithPopup $ph 'styles'
      [Shot]::PostKey($ph, 0x1B); Start-Sleep -Milliseconds 600
    } else { '  NO Cell Styles gallery' }
  } catch { "  Cell Styles: $_" }

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
    if ($wb) { try { $wb.Close($false) } catch { } }
    try { $xl.Quit() } catch { Stop-Process -Id ([Shot]::Pid($h)) -Force -ErrorAction SilentlyContinue }
  }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
