# Real Excel 365 screens for the Excel 'Try this' practice simulation
# (SimulationPractice ('excel') in lib/simulation.php, shown at the start of
# catexcel lesson 1 - 8 October 2026). Botha's Bakery price list with the
# milk tart's price missing: click its cell, type it, then press Ctrl+S.
# Read office-kit.ps1's safety rules. Run it in the CAT VM:
#     pwsh -File vm-shots.ps1 catexcel-practice
# Then: python cat-crop.py catexcel-practice
$Name = 'catexcel-practice'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catexcel-kit.ps1')

Get-Process EXCEL -ErrorAction SilentlyContinue | Stop-Process -Force   # a stuck Excel from an earlier run (the VM lock means nobody else is running)
Start-Sleep -Milliseconds 800
$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1); $ws.Name = 'Prices'
  FillRows $ws @(
    @('Item', 'Price', 'Sold', 'Takings'),
    @('White bread', 18, 40, '=B2*C2'),
    @('Brown bread', 17, 25, '=B3*C3'),
    @('Rolls (6)', 22, 12, '=B4*C4'),
    @('Koeksisters', 8, 60, '=B5*C5'),
    @('Milk tart', '', 18, '=B6*C6'),
    @('Total', '', '', '=D2+D3+D4+D5+D6'))
  $ws.Columns.Item('A').ColumnWidth = 16
  foreach ($col in 'B', 'C', 'D') { $ws.Columns.Item($col).ColumnWidth = 10 }
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 40, 40, 1600, 720); Start-Sleep -Milliseconds 1500
  [Shot]::Place($h, 40, 40, 1750, 720)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  $root = $AE::FromHandle($h)

  foreach ($a in 'A1', 'B6', 'B7', 'D6') { Mark $a (CellBox $ws $a) }
  TryMark 'nameBox'    $root @('Name Box')
  TryMark 'formulaBar' $root @('Formula Bar')

  Snap '1'                                                          # A1 active, B6 empty
  $null = $ws.Range('B6').Select(); Snap '2'                        # B6 clicked
  $ws.Range('B6').Formula = '15'
  $null = $ws.Range('B7').Select(); Snap '3'                        # 15 typed, Enter: B7 active, D6 shows 270

  SaveMarks
}
catch {
  "FAILED: $_"
  throw
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { } }
  try { $xl.Quit() } catch { Stop-Process -Id ([Shot]::Pid($h)) -Force -ErrorAction SilentlyContinue }
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
