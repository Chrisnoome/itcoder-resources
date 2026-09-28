# The Excel screenshot for SQL lesson A2's "Why not a spreadsheet?" activity
# (the 64-bit PowerShell, Excel 365 installed). Types work\flatfile.json into a
# new workbook in real Excel, takes the window with PrintWindow, and writes
# where every cell of A1:J12 is on the picture - the activity circles cells by
# their address, so a new picture never needs the annotations moved by hand.
#
# THE SAFETY RULES (as ..\access-screens\shots.ps1):
# - Nothing is clicked or typed. Excel is driven through COM only, and the
#   picture comes from PrintWindow (..\access-screens\Shot.cs), which holds
#   only Excel's own drawing.
# - NOBODY MAY USE THE KEYBOARD OR MOUSE WHILE IT RUNS (about 20 seconds).
#   Excel can bring itself to the front, and keys typed then would land in a
#   cell. Before and after the picture the run checks when the keyboard or
#   mouse was last used; if it was during the run, it stops and deletes the
#   picture.
param([string]$Prefix = 'dbwhat-flatfile')
$ErrorActionPreference = 'Stop'
$dir = Split-Path -Parent $MyInvocation.MyCommand.Path
Add-Type -Path (Join-Path $dir '..\access-screens\Shot.cs') -ReferencedAssemblies System.Drawing
Add-Type -Path (Join-Path $dir 'WinRect.cs')
[Shot]::DpiAware()
New-Item -ItemType Directory -Force (Join-Path $dir 'out') | Out-Null
$sheet = Get-Content (Join-Path $dir 'work\flatfile.json') -Raw | ConvertFrom-Json

Start-Sleep -Seconds 2
$started = [Shot]::LastInput()
function Guard {
  if ([Shot]::LastInput() -ne $started) {
    Remove-Item (Join-Path $dir "out\$Prefix*") -ErrorAction SilentlyContinue
    throw 'The keyboard or mouse was used during the run - the picture was deleted. Run it again with hands off.'
  }
}

$xl = New-Object -ComObject Excel.Application
$wb = $null
try {
  $xl.DisplayAlerts = $false
  $wb = $xl.Workbooks.Add()
  $ws = $wb.Worksheets.Item(1)
  $ws.Name = 'Sales'

  for ($c = 0; $c -lt $sheet.header.Count; $c++) { $ws.Cells.Item(1, $c + 1).Value2 = $sheet.header[$c] }
  $r = 2
  foreach ($row in $sheet.rows) {
    $ws.Cells.Item($r, 1).Value2  = [int]$row[0]
    $ws.Cells.Item($r, 2).Formula = [string]$row[1]      # typed, so Excel reads it as a date
    $ws.Cells.Item($r, 3).Value2  = [string]$row[2]
    $ws.Cells.Item($r, 4).Value2  = [string]$row[3]
    $ws.Cells.Item($r, 5).Value2  = [double]$row[4]
    $ws.Cells.Item($r, 6).Value2  = [int]$row[5]
    $r++
  }
  $last = $r - 1
  $ws.Range('A1:F1').Font.Bold = $true
  $ws.Range("B2:B$last").NumberFormat = 'yyyy/mm/dd'
  $ws.Range("E2:E$last").NumberFormat = '0.00'           # shown with the machine's decimal comma (en-ZA)
  $null = $ws.Range('A:F').EntireColumn.AutoFit()
  foreach ($col in 'A', 'B', 'C', 'D', 'E', 'F') { $ws.Columns.Item($col).ColumnWidth = $ws.Columns.Item($col).ColumnWidth + 2 }
  $null = $ws.Range('A' + ($last + 2)).Select()

  $xl.Visible = $true
  $xl.WindowState = -4143                                # xlNormal
  $h = [IntPtr]$xl.Hwnd
  [Shot]::Place($h, 60, 60, 1400, 820)
  $xl.ActiveWindow.Zoom = 100
  $xl.ActiveWindow.ScrollRow = 1
  $xl.ActiveWindow.ScrollColumn = 1
  Start-Sleep -Milliseconds 2500
  Guard

  # Where each cell is on the picture: Excel's screen pixels less the window's corner.
  $win   = [WinRect]::Of($h)
  $pane  = $xl.ActiveWindow.ActivePane
  $cells = [ordered]@{}
  foreach ($row in 1..12) {
    foreach ($col in 1..10) {
      $cell = $ws.Cells.Item($row, $col)
      $x1 = $pane.PointsToScreenPixelsX($cell.Left)  - $win[0]
      $x2 = $pane.PointsToScreenPixelsX($cell.Left + $cell.Width) - $win[0]
      $y1 = $pane.PointsToScreenPixelsY($cell.Top)   - $win[1]
      $y2 = $pane.PointsToScreenPixelsY($cell.Top + $cell.Height) - $win[1]
      $cells[$cell.Address($false, $false)] = @($x1, $y1, ($x2 - $x1), ($y2 - $y1))
    }
  }

  [Shot]::Back($h)
  Start-Sleep -Milliseconds 500
  "picture " + [Shot]::Save($h, (Join-Path $dir "out\$Prefix-raw.png"))
  Guard
  (@{ window = $win; cells = $cells } | ConvertTo-Json -Depth 4) | Set-Content (Join-Path $dir "out\$Prefix-raw.json") -Encoding utf8
  "cells -> out\$Prefix-raw.json"
}
finally {
  if ($wb) { $wb.Close($false) }
  $xl.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($xl)
}
