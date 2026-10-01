# Real Excel screens for a software simulation (lib/simulation.php - Chris,
# 1 October 2026: "real screenshots, step by step", Excel first): the AI
# course's lesson 4 "what one gigabyte of VRAM costs" task, one picture per
# moment of the task - the cell clicked, the formula typed, copied with
# Ctrl+C and pasted with Ctrl+V - and where cells D2 and D3 are on the picture.
#
# THE SAFETY RULES (as ..\excel-screens\flatfile.ps1): nothing is clicked or
# typed - Excel is driven through COM only and the pictures come from
# PrintWindow. NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS (about 30
# seconds); a run that sees input deletes its pictures. Run in Windows
# PowerShell 5.1:  powershell -ExecutionPolicy Bypass -File excel-vram.ps1
# Then: python crop.py excel-vram
$ErrorActionPreference = 'Stop'
$dir  = Split-Path -Parent $MyInvocation.MyCommand.Path
$name = 'excel-vram'
Add-Type -Path (Join-Path $dir '..\access-screens\Shot.cs') -ReferencedAssemblies System.Drawing
Add-Type -Path (Join-Path $dir '..\excel-screens\WinRect.cs')
[Shot]::DpiAware()
$out = Join-Path $dir 'out'
New-Item -ItemType Directory -Force $out | Out-Null
Remove-Item (Join-Path $out "$name-*") -ErrorAction SilentlyContinue

Start-Sleep -Seconds 2
$started = [Shot]::LastInput()
function Guard {
  if ([Shot]::LastInput() -ne $started) {
    Remove-Item (Join-Path $out "$name-*") -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used during the run - the pictures were deleted. Run it again with hands off.'
  }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Cards'
  $rows = @(@('Card', 'VRAM (GB)', 'Price (R)', 'Rand per GB'), @('RTX 5090', 32, 60000, $null), @('RTX PRO 6000', 96, 256000, $null))
  # Typed in as text, the way a person would: Excel turns 32 and 60000 into numbers itself.
  for ($r = 0; $r -lt $rows.Count; $r++) { for ($c = 0; $c -lt 4; $c++) { $v = $rows[$r][$c]; if ($null -ne $v) { $ws.Range(([string][char](65 + $c)) + ($r + 1)).Formula = [string]$v } } }
  $ws.Range('A1:D1').Font.Bold = $true
  $ws.Range('C2:C3').NumberFormat = '#,##0'
  foreach ($col in 'A', 'B', 'C', 'D') { $ws.Columns.Item($col).ColumnWidth = 16 }
  $null = $ws.Range('A1').Select()

  $xl.Visible = $true
  $xl.WindowState = -4143
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 60, 60, 1400, 820)
  $xl.ActiveWindow.Zoom = 100
  Start-Sleep -Milliseconds 2500
  Guard

  $win  = [WinRect]::Of($h)
  $pane = $xl.ActiveWindow.ActivePane
  function CellBox ($address) {
    $cell = $ws.Range($address)
    $x1 = $pane.PointsToScreenPixelsX($cell.Left) - $win[0]
    $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
    $y1 = $pane.PointsToScreenPixelsY($cell.Top) - $win[1]
    $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
    return @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
  }
  $cells = [ordered]@{ A1 = (CellBox 'A1'); D2 = (CellBox 'D2'); D3 = (CellBox 'D3'); E8 = (CellBox 'E8') }

  function Snap ($n) { Start-Sleep -Milliseconds 900; [Shot]::Back($h); Start-Sleep -Milliseconds 400; [void][Shot]::Save($h, (Join-Path $out "$name-$n.png")); Guard; "picture $n" }

  Snap 1                                                  # the sheet, A1 active
  $null = $ws.Range('D2').Select();  Snap 2               # D2 clicked
  $ws.Range('D2').Formula = '=C2/B2'
  $null = $ws.Range('D3').Select();  Snap 3               # typed and Enter: the active cell moved down to D3
  $null = $ws.Range('D2').Select();  Snap 4               # D2 clicked again
  $null = $ws.Range('D2').Copy();    Snap 5               # Ctrl+C: the moving border round D2
  $null = $ws.Range('D3').Select();  Snap 6               # D3 clicked, D2 still copied
  $ws.Paste();                       Snap 7               # Ctrl+V: the formula in D3

  (@{ window = $win; cells = $cells } | ConvertTo-Json -Depth 4) | Set-Content (Join-Path $out "$name.json") -Encoding utf8
  "cells -> out\$name.json"
}
catch {
  "FAILED: $_"
  throw
}
finally {
  if ($wb) { try { $wb.Close($false) } catch { } }
  $xl.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
