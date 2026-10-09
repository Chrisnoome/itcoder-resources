# Real Access 365 screens for catdb Grade 11 lesson 6, Forms
# (AIPascalCourse/content/catdb/forms.php - courses/cat-practical-writing.md, 9 October
# 2026). Gogo Dlamini's stokvel: the Create tab's Forms group, a form made by Form (Layout
# View), the Form Wizard's first page, a form in Design View with its sections, the
# Property Sheet, the Tab Order box, Form View and a new record.
# Also makes the starter Stokvel.accdb and a done-right copy in
# C:\sims\files\catdb-forms\ and G:\My Drive\CAT\Access\.
#     pwsh -File vm-shots.ps1 catdb-forms            (from the host)
$Name = 'catdb-forms'
. (Join-Path $PSScriptRoot 'office-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-kit.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data.ps1')
. (Join-Path $PSScriptRoot 'work\catdb-data11.ps1')

$work = 'C:\sims\catdb'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'Stokvel.accdb'
$done = Join-Path $work 'Stokvel-done.accdb'

$app = New-Object -ComObject Access.Application
try {
  Build-Stokvel $app $done -Done
  CloseDb $app $done
  Build-Stokvel $app $file
  CloseDb $app $file
  Publish $file
  Copy-Item $done "C:\sims\files\$Name" -Force

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [Shot]::Place($h, 40, 30, 1280, 900)
  $shots = Join-Path $work 'StokvelShots.accdb'
  Build-Stokvel $app $shots
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1200

  # 1. Create > Form, with tblMembers selected.
  $app.DoCmd.SelectObject(0, 'tblMembers', $true)
  Start-Sleep -Milliseconds 600
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  foreach ($k in 'Form', 'Form Design', 'Blank Form', 'Form Wizard', 'tblMembers') { TryMark "create $k" $root @($k) }
  SnapDb 'f-1'
  Press (Find $root @('Form') $T::Button)
  Start-Sleep -Milliseconds 2500
  $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
  Dump 'layout'
  foreach ($k in 'View', 'Title', 'Logo', 'Date and Time', 'Add Existing Fields', 'Property Sheet', 'Themes') { TryMark "layout $k" $root @($k) }
  SnapDb 'f-2'
  try { $nm = $app.Screen.ActiveForm.Name; $app.DoCmd.Close(2, $nm, 2) } catch { "  close the new form: $_" }
  Start-Sleep -Milliseconds 1000

  # 2. The Form Wizard's first page.
  try {
    Press (Find $root @('Create') $T::TabItem)
    Start-Sleep -Milliseconds 700
    Press (Find $root @('Form Wizard') $T::Button)
    Start-Sleep -Milliseconds 2500
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'wizard'
    SnapDb 'f-3' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1200
  } catch { "  form wizard: $_" }

  # 3. A saved form in Design View, its Property Sheet, the Tab Order box.
  MakeForm $app 'tblMembers' 'frmMembers' 'Stokvel members' @('MemberID', 'FirstName', 'Surname', 'Cell', 'JoinDate', 'Monthly', 'PaidUp')
  $app.RefreshDatabaseWindow()
  $app.DoCmd.OpenForm('frmMembers', 1)                      # acDesign
  Start-Sleep -Milliseconds 2000
  Dump 'design'
  NoFieldList
  NoPropertySheet
  foreach ($k in 'View', 'Title', 'Logo', 'Date and Time', 'Insert Image', 'Add Existing Fields', 'Property Sheet', 'Tab Order...', 'Controls') { TryMark "design $k" $root @($k) }
  SnapDb 'f-4'
  NoPropertySheet
  try {
    Press (Find $root @('Property Sheet') $T::Button)
    Start-Sleep -Milliseconds 1500
    SnapDb 'f-5' -KeepPanes
    Press (Find $root @('Property Sheet') $T::Button)
    Start-Sleep -Milliseconds 800
  } catch { "  property sheet: $_" }
  try {
    Press (Find $root @('Add Existing Fields') $T::Button)
    Start-Sleep -Milliseconds 1500
    SnapDb 'f-4b'
    Press (Find $root @('Add Existing Fields') $T::Button)
    Start-Sleep -Milliseconds 800
  } catch { "  field list: $_" }
  try {
    Press (Find $root @('Tab Order...') $T::Button)
    Start-Sleep -Milliseconds 2000
    $script:lastInput = [Shot]::LastInput(); $script:wasFront = $false
    DumpOthers 'taborder'
    SnapDb 'f-6' -Others
    foreach ($w in [DbComp]::Others($h)) { [DbComp]::Close($w) }
    Start-Sleep -Milliseconds 1000
  } catch { "  tab order: $_" }
  $app.DoCmd.Close(2, 'frmMembers', 2)
  Start-Sleep -Milliseconds 800

  # 4. Form View: the first member, then a new record.
  $app.DoCmd.OpenForm('frmMembers')
  Start-Sleep -Milliseconds 1500
  Dump 'formview'
  SnapDb 'f-7'
  $app.DoCmd.GoToRecord(2, 'frmMembers', 5)                # acNewRec
  Start-Sleep -Milliseconds 800
  SnapDb 'f-8'
  $app.DoCmd.Close(2, 'frmMembers', 2)

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
