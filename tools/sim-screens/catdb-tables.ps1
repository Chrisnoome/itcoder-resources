# Real Access 365 screens for catdb Grade 11 lesson 2, Tables, fields and data types
# (AIPascalCourse/content/catdb/tables.php - courses/cat-practical-writing.md, 9 October
# 2026). Botha's Bakery: the Create tab, a new table in Design View with a field typed in
# (characters posted to Access's grid by its handle - no keyboard), its data type, the
# Primary Key; tblProducts in Design View, its Data Type list, Datasheet View, and (IEB) a
# Calculated field. Also makes the starter Bakery.accdb and a done-right copy in
# C:\sims\files\catdb-tables\ and G:\My Drive\CAT\Access\.
#     pwsh -File vm-shots.ps1 catdb-tables            (from the host)
$Name = 'catdb-tables'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Bakery.accdb'
$done = Join-Path $work 'Bakery-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-Bakery $app $done -Done
  CloseDb $app $done
  Build-Bakery $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force

  $shots = Join-Path $work 'BakeryShots.accdb'
  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  Build-Bakery $app $shots -Shots
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1500

  # 1. Create > Table Design, a field typed in, its data type, the key.
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  TryMark 'Table Design' $root @('Table Design')
  SnapDb 't-1'
  Press (Find $root @('Table Design') $T::Button)
  Start-Sleep -Milliseconds 2000
  NoPropertySheet
  Dump 'newtable'
  foreach ($k in 'Primary Key', 'Insert Rows', 'Delete Rows', 'View', 'Property Sheet') { TryMark $k $root @($k) }
  SnapDb 't-2'
  GridType 'BakerID'
  SnapDb 't-3'
  GridKeys @(0x09)
  Start-Sleep -Milliseconds 600
  SnapDb 't-4'                                             # Short Text, the default
  FocusType 'AutoNumber'
  Start-Sleep -Milliseconds 600
  SnapDb 't-5a'                                            # typed, before Tab
  GridKeys @(0x09)
  Start-Sleep -Milliseconds 600
  SnapDb 't-5'
  GridKeys @(0x26, 0x26)                                   # back up to BakerID's row (Up)
  try { Press (Find $root @('Primary Key') $T::Button) } catch { "  key: $_" }
  Start-Sleep -Milliseconds 800
  SnapDb 't-6'
  GridKeys @(0x28)
  GridType 'FirstName' @(0x09)
  Start-Sleep -Milliseconds 600
  SnapDb 't-7'
  try { $app.DoCmd.Close(0, 'Table1', 2) } catch { "  close Table1: $_"; try { $app.DoCmd.Close(-1, '', 2) } catch { } }
  Start-Sleep -Milliseconds 1000

  # The finished tblBakers (made by DDL: BakerID an AutoNumber and the key) - Access's grid
  # does not take a data type typed through posted characters.
  $app.DoCmd.OpenTable('tblBakers', 1)
  Start-Sleep -Milliseconds 1500
  SnapDb 't-8'
  $app.DoCmd.Close(0, 'tblBakers', 2)
  Start-Sleep -Milliseconds 800

  # The key on tblProducts: taken off, then set with the Primary Key button.
  $d = $app.CurrentDb(); $d.Execute('DROP INDEX PrimaryKey ON tblProducts'); $d = $null
  $app.DoCmd.OpenTable('tblProducts', 1)
  Start-Sleep -Milliseconds 1500
  SnapDb 'k-1'
  try { Press (Find $root @('Primary Key') $T::Button); Start-Sleep -Milliseconds 900; SnapDb 'k-2' } catch { "  key: $_" }
  $app.DoCmd.Close(0, 'tblProducts', 2)
  Start-Sleep -Milliseconds 800
  $d = $app.CurrentDb(); try { $d.Execute('CREATE INDEX PrimaryKey ON tblProducts (ProductID) WITH PRIMARY') } catch { } ; $d = $null

  # 2. tblProducts in Design View; the Data Type list; Datasheet View.
  $app.DoCmd.OpenTable('tblProducts', 1)
  Start-Sleep -Milliseconds 1500
  GridKeys @(0x28, 0x28)                                   # Price's row
  Start-Sleep -Milliseconds 600
  Dump 'design'
  SnapDb 'd-1'
  GridKeys @(0x09)                                          # its Data Type box
  Start-Sleep -Milliseconds 500
  $grid = [DbComp]::Focused($h)
  "  focus for the list: $grid"
  [DbComp]::AltDown($grid)
  Start-Sleep -Milliseconds 1200
  DumpOthers 'typelist'
  SnapDb 'd-2' -Others
  [Shot]::PostKey($grid, 0x1B)
  Start-Sleep -Milliseconds 600
  GridKeys @(0x28, 0x28, 0x28, 0x28)                        # down to DozenPrice (IEB: Calculated)
  Start-Sleep -Milliseconds 600
  SnapDb 'd-4'
  $app.DoCmd.Close(0, 'tblProducts', 2)
  Start-Sleep -Milliseconds 800
  $app.DoCmd.OpenTable('tblProducts')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  SnapDb 'd-3'
  $app.DoCmd.Close(0, 'tblProducts', 2)

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
