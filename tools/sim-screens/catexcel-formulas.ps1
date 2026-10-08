# Real Excel 365 screens for catexcel lesson 3, Formulas and cell references
# (content/catexcel/formulas.php - 8 October 2026). Botha's Bakery's order for
# Phumlani Secondary's market day: a first formula, copying it down, a
# formula with brackets, a price change that updates everything, and Show
# Formulas. Read office-kit.ps1's safety rules. Run it in the CAT VM:
#     pwsh -File vm-shots.ps1 catexcel-formulas
# Then: python cat-crop.py catexcel-formulas
$Name = 'catexcel-formulas'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Order'
  FillRows $ws @(
    @('Item', 'Price', 'Quantity', 'Amount'),
    @('Cupcakes', 6, 48),
    @('Koeksisters', 8, 60),
    @('Vetkoek', 10, 40),
    @('Milk tart slices', 15, 24),
    @('Brownies', 12, 36),
    @('Total'),
    @('Discount', '', '', 50),
    @('Each class pays'))
  $ws.Columns.Item('A').ColumnWidth = 18
  foreach ($col in 'B', 'C', 'D') { $ws.Columns.Item($col).ColumnWidth = 11 }
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  foreach ($a in 'A1', 'B2', 'D2', 'D3', 'D6', 'D7', 'D9') { Mark $a (CellBox $ws $a) }
  $d2 = CellBox $ws 'D2'
  Mark 'fillD2' @(($d2[0] + $d2[2] - 9), ($d2[1] + $d2[3] - 9), 18, 18)   # the fill handle: D2's bottom-right corner
  $fb = Box (Find $root @('Formula Bar') $T::Edit)
  Mark 'formulaBar' $fb
  Mark 'nameBox' @(18, ($fb[1] + 10), 128, 30)
  TryMark 'tabFormulas' $root @('Formulas') $T::TabItem
  Dump 'home'

  # 1. A first formula: click D2, type =B2*C2.
  Snap 'f-1'                                                        # A1 active
  $null = $ws.Range('D2').Select(); Snap 'f-2'                      # D2 clicked
  $ws.Range('D2').Formula = '=B2*C2'
  $null = $ws.Range('D3').Select(); Snap 'f-3'                      # Enter: D2 shows 288, D3 active

  # 2. Copy it down with the fill handle.
  $null = $ws.Range('D2').Select(); Snap 'c-1'                      # D2 clicked: the formula in the Formula Bar
  $null = $ws.Range('D2').AutoFill($ws.Range('D2:D6'), 0)
  $null = $ws.Range('D2:D6').Select(); Snap 'c-2'                   # D2:D6 filled
  $null = $ws.Range('D4').Select(); Snap 'c-3'                      # D4 clicked: =B4*C4

  # 3. The total, and a formula with brackets.
  $ws.Range('D7').Formula = '=D2+D3+D4+D5+D6'
  $null = $ws.Range('D7').Select(); Snap 'b-1'                      # D7: the total
  $null = $ws.Range('D9').Select(); Snap 'b-2'                      # D9 clicked
  $ws.Range('D9').Formula = '=(D7-D8)/2'
  $null = $ws.Range('D10').Select(); Snap 'b-3'                     # Enter: 955

  # 4. A price changes: everything that uses it changes too.
  $null = $ws.Range('B2').Select(); Snap 'r-1'                      # cupcakes R6
  $ws.Range('B2').Formula = '7'
  $null = $ws.Range('B3').Select(); Snap 'r-2'                      # cupcakes R7: 336, 2008, 979
  $ws.Range('B2').Formula = '6'

  # 5. Show Formulas, on the Formulas tab.
  $null = $ws.Range('A1').Select(); Snap 's-1'
  Press (Find $root @('Formulas') $T::TabItem)
  Start-Sleep -Milliseconds 900
  TryMark 'showFormulas' $root @('Show Formulas')
  Dump 'formulas'
  Snap 's-2'                                                        # the Formulas tab
  $xl.ActiveWindow.DisplayFormulas = $true
  Start-Sleep -Milliseconds 800
  Snap 's-3'                                                        # the formulas showing
  $xl.ActiveWindow.DisplayFormulas = $false
  Press (Find $root @('Home') $T::TabItem)

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
