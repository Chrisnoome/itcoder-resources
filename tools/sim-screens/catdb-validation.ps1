# Real Access 365 screens for catdb Grade 11 lesson 5, Input masks and validation
# (AIPascalCourse/content/catdb/validation.php - courses/cat-practical-writing.md,
# 9 October 2026). Phumlani Secondary's bursary applications: tblApplicants in Design
# View before and after - Input Mask, Indexed, Required, Validation Rule and Text (set
# through DAO, the table opened again); Datasheet View with the cell number's mask
# showing in a new record, and the validation text Access shows when 13 is typed in Grade
# (characters posted to the datasheet's window - no keyboard).
# Also makes the starter Bursary.accdb and a done-right copy in
# C:\sims\files\catdb-validation\ and G:\My Drive\CAT\Access\.
#     pwsh -File vm-shots.ps1 catdb-validation            (from the host)
$Name = 'catdb-validation'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Bursary.accdb'
$done = Join-Path $work 'Bursary-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-Bursary $app $done -Done
  CloseDb $app $done
  Build-Bursary $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)

  $before = Join-Path $work 'BursaryShots0.accdb'
  Build-Bursary $app $before
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.OpenTable('tblApplicants', 1)
  Start-Sleep -Milliseconds 1500
  GridKeys @(0x28, 0x28, 0x28)                              # IDNumber
  Start-Sleep -Milliseconds 600
  Dump 'design0'
  SnapDb 'v-1'
  GridKeys @(0x28, 0x28)                                    # Grade
  Start-Sleep -Milliseconds 600
  SnapDb 'v-4'
  $app.DoCmd.Close(0, 'tblApplicants', 2)
  CloseDb $app $before

  $after = Join-Path $work 'BursaryShots.accdb'
  Build-Bursary $app $after -Done
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200
  $app.DoCmd.OpenTable('tblApplicants', 1)
  Start-Sleep -Milliseconds 1500
  GridKeys @(0x28, 0x28)                                    # Surname
  Start-Sleep -Milliseconds 600
  SnapDb 'v-0'
  GridKeys @(0x28)                                          # IDNumber
  Start-Sleep -Milliseconds 600
  SnapDb 'v-2'
  GridKeys @(0x28)                                          # Cell
  Start-Sleep -Milliseconds 600
  SnapDb 'v-3'
  GridKeys @(0x28)                                          # Grade
  Start-Sleep -Milliseconds 600
  SnapDb 'v-5'
  GridKeys @(0x28, 0x28, 0x28)                              # Applied
  Start-Sleep -Milliseconds 600
  SnapDb 'v-6'
  $app.DoCmd.Close(0, 'tblApplicants', 2)
  Start-Sleep -Milliseconds 800

  # Datasheet: the mask in a new record's Cell box, then 13 typed in Grade.
  $app.DoCmd.OpenTable('tblApplicants')
  Start-Sleep -Milliseconds 1500
  NoFieldList
  SnapDb 'ds-1'
  try {
    $app.DoCmd.GoToRecord(0, 'tblApplicants', 5)
    $app.DoCmd.GoToControl('Cell')
    Start-Sleep -Milliseconds 600
    GridType '082'
    Start-Sleep -Milliseconds 500
    SnapDb 'ds-2'
    [Shot]::PostKey([Shot]::Child($h, 'OGrid'), 0x1B)
    [Shot]::PostKey([Shot]::Child($h, 'OGrid'), 0x1B)
    Start-Sleep -Milliseconds 600
    $app.DoCmd.GoToRecord(0, 'tblApplicants', 5)
    $app.DoCmd.GoToControl('Grade')
    Start-Sleep -Milliseconds 500
    GridType '13'
    $f = [DbComp]::Focused($h); "  focus: $f"
    [Shot]::PostKey($f, 0x0D)                               # Enter: leave the box, so the rule is tested
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'message'
    SnapDb 'ds-3' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 800
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    SnapDb 'ds-3b'
    [Shot]::PostKey([Shot]::Child($h, 'OGrid'), 0x1B)
    [Shot]::PostKey([Shot]::Child($h, 'OGrid'), 0x1B)
    Start-Sleep -Milliseconds 600
  } catch { "  datasheet: $_" }
  try { $app.DoCmd.Close(0, 'tblApplicants', 2) } catch { "  close: $_" }

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
