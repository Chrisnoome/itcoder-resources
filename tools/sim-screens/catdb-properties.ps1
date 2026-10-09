# Real Access 365 screens for catdb Grade 11 lesson 4, Field properties
# (AIPascalCourse/content/catdb/properties.php - courses/cat-practical-writing.md,
# 9 October 2026). Botha's Bakery's cake orders: tblOrders in Design View before and
# after - Field Size, Caption, Required, Format, Default Value, Decimal Places, Text Align
# (set through DAO, the table opened again: Access's property grid is not visible to UI
# Automation, so places are read off the pictures); Datasheet View with the caption, the
# date format, the CakeSize lookup's list open, and (IEB) Rich Text in Notes.
# Also makes the starter CakeOrders.accdb and a done-right copy in
# C:\sims\files\catdb-properties\ and G:\My Drive\CAT\Access\.
#     pwsh -File vm-shots.ps1 catdb-properties            (from the host)
$Name = 'catdb-properties'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'CakeOrders.accdb'
$done = Join-Path $work 'CakeOrders-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-Orders $app $done -Done
  CloseDb $app $done
  Build-Orders $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)

  # Before: the starter's properties.
  $before = Join-Path $work 'OrdersShots0.accdb'
  Build-Orders $app $before
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.OpenTable('tblOrders', 1)
  Start-Sleep -Milliseconds 1500
  GridKeys @(0x28)                                          # CustomerName
  Start-Sleep -Milliseconds 600
  Dump 'design0'
  SnapDb 'pr-1'
  GridKeys @(0x28, 0x28)                                    # OrderDate
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-3'
  GridKeys @(0x28, 0x28, 0x28)                              # Candles
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-7'
  $app.DoCmd.Close(0, 'tblOrders', 2)
  CloseDb $app $before

  # After: the done properties, with the lookup and Rich Text.
  $after = Join-Path $work 'OrdersShots.accdb'
  Build-Orders $app $after -Shots
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.OpenTable('tblOrders', 1)
  Start-Sleep -Milliseconds 1500
  GridKeys @(0x28)
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-2'
  GridKeys @(0x28, 0x28)
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-4'
  GridKeys @(0x28)                                          # Cake
  GridKeys @(0x28)                                          # CakeSize (a lookup)
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-8'
  GridKeys @(0x28)                                          # Candles
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-5'
  GridKeys @(0x28)                                          # Price
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-6'
  GridKeys @(0x28, 0x28)                                    # Notes
  Start-Sleep -Milliseconds 600
  SnapDb 'pr-9'
  $app.DoCmd.Close(0, 'tblOrders', 2)
  Start-Sleep -Milliseconds 800

  $app.DoCmd.OpenTable('tblOrders')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  SnapDb 'ds-1'
  try {
    $app.DoCmd.GoToRecord(0, 'tblOrders', 4, 3)
    $app.DoCmd.GoToControl('CakeSize')
    Start-Sleep -Milliseconds 600
    $f = [DbComp]::Focused($h); "  focus for the list: $f"
    [DbComp]::AltDown($f)
    Start-Sleep -Milliseconds 1200
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'lookup'
    SnapDb 'ds-2' -Others
    [Shot]::PostKey([Shot]::Child($h, 'OGrid'), 0x1B)
    Start-Sleep -Milliseconds 600
  } catch { "  lookup list: $_" }
  $app.DoCmd.Close(0, 'tblOrders', 2)

  SaveMarks
}
catch {
  "FAILED: $_"
  throw
}
finally {
  try { $app.CloseCurrentDatabase() } catch { }
  $app.Quit()
  [void][Runtime.InteropServices.Marshal]::ReleaseComObject($app)
}
