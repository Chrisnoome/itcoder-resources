# Real Access 365 screens for the CAT pilot's Access lesson (content/catpilot/
# access.php - Chris, 5 October 2026). A chess club's members table in a new
# .accdb (the boards' kind of file); each picture is one moment of a task, and
# out\cat-access.json says where the buttons are (window pixels). Places on
# Access's own grids (no UI Automation there) are read off the pictures.
# Read office-kit.ps1's safety rules first: hands off the keyboard and mouse
# while it runs (about a minute and a half). Access brings itself to the front.
#     powershell -ExecutionPolicy Bypass -File cat-access.ps1
# Then: python cat-crop.py cat-access
$Name = 'cat-access'
. (Join-Path $PSScriptRoot 'office-kit.ps1')

$work = Join-Path $PSScriptRoot 'work'
New-Item -ItemType Directory -Force $work | Out-Null
$file = Join-Path $work 'ChessClub.accdb'
Remove-Item $file -ErrorAction SilentlyContinue

$app = New-Object -ComObject Access.Application
try {
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblMembers (MemberID COUNTER, FirstName TEXT(30), Surname TEXT(30), Grade SHORT, Joined DATETIME)')
  $members = @(
    @('Thandeka', 'Mokoena', 10, '2026/01/21'), @('Pieter', 'van Wyk', 11, '2025/02/03'),
    @('Aisha', 'Patel', 10, '2026/02/11'), @('Sipho', 'Dlamini', 12, '2024/01/30'),
    @('Megan', 'Smith', 9, '2026/03/04'), @('Lerato', 'Khumalo', 10, '2026/01/28'),
    @('Johan', 'Botha', 11, '2025/07/22'), @('Naledi', 'Mahlangu', 12, '2024/02/14'))
  foreach ($m in $members) { $db.Execute("INSERT INTO tblMembers (FirstName, Surname, Grade, Joined) VALUES ('$($m[0])', '$($m[1].Replace("'", "''"))', $($m[2]), #$($m[3])#)") }
  $db = $null

  $app.Visible = $true
  $h = [IntPtr]$app.hWndAccessApp()
  [IO.File]::WriteAllText((Join-Path $work 'access.pid'), [string][Shot]::Pid($h))   # to stop only this Access if it sticks
  [Shot]::Place($h, 40, 30, 1150, 1000)
  $root = $AE::FromHandle($h)
  $app.RefreshDatabaseWindow()
  Start-Sleep -Milliseconds 1500

  function Down ($times) { $grid = [Shot]::Child($h, 'OGrid'); for ($i = 0; $i -lt $times; $i++) { [Shot]::PostKey($grid, 0x28); Start-Sleep -Milliseconds 300 } }

  # 1. Design View and a primary key.
  $app.DoCmd.OpenTable('tblMembers')                       # Datasheet View
  Start-Sleep -Milliseconds 1200
  Mark 'view' (Box (Find $root @('View') $T::SplitButton -tries 6))
  Dump 'datasheet'
  Snap 'k-1'
  $app.DoCmd.Close(0, 'tblMembers', 2)
  $app.DoCmd.OpenTable('tblMembers', 1)                    # Design View, MemberID's row current
  Start-Sleep -Milliseconds 1500
  Mark 'primaryKey' (Box (Find $root @('Primary Key') $T::Button))
  Dump 'design'
  Snap 'k-2'
  Press (Find $root @('Primary Key') $T::Button)
  Start-Sleep -Milliseconds 800
  Snap 'k-3'                                               # the key beside MemberID

  # 2. A new field: typed into the first empty Field Name box.
  $app.DoCmd.Close(0, 'tblMembers', 1)                     # acSaveYes - keeps the key
  $db = $app.CurrentDb()
  $db.Execute('ALTER TABLE tblMembers ADD COLUMN Phone TEXT(15)')
  $db = $null
  $app.DoCmd.OpenTable('tblMembers', 1)
  Start-Sleep -Milliseconds 1500
  Snap 'f-1'                                               # Phone added (Short Text)

  # 3. A validation rule on Grade: its row current, then the rule set.
  Down 3
  Start-Sleep -Milliseconds 800
  Snap 'v-1'                                               # Grade's properties below
  $app.DoCmd.Close(0, 'tblMembers', 2)
  $db = $app.CurrentDb()
  $field = $db.TableDefs.Item('tblMembers').Fields.Item('Grade')
  $field.ValidationRule = '>=8 And <=12'
  $field.ValidationText = 'Grade must be from 8 to 12.'
  $field = $null; $db = $null
  $app.DoCmd.OpenTable('tblMembers', 1)
  Start-Sleep -Milliseconds 1200
  Down 3
  Start-Sleep -Milliseconds 800
  Snap 'v-2'
  $app.DoCmd.Close(0, 'tblMembers', 2)

  # 4. A query: Create, Query Design, a criterion, Run.
  Start-Sleep -Milliseconds 800
  Snap 'q-1'                                               # Home tab, nothing open
  Press (Find $root @('Create') $T::TabItem)
  Start-Sleep -Milliseconds 900
  Mark 'tabCreate' (Box (Find $root @('Create') $T::TabItem))
  Mark 'queryDesign' (Box (Find $root @('Query Design') $T::Button))
  Dump 'create'
  Snap 'q-2'
  $db = $app.CurrentDb()
  $null = $db.CreateQueryDef('qryGrade10', 'SELECT tblMembers.FirstName, tblMembers.Surname, tblMembers.Grade FROM tblMembers;')
  $db = $null
  $app.DoCmd.OpenQuery('qryGrade10', 1)                    # Design View
  Start-Sleep -Milliseconds 1500
  Snap 'q-3'                                               # the grid, no criterion yet
  $app.DoCmd.Close(1, 'qryGrade10', 2)
  $db = $app.CurrentDb()
  $db.QueryDefs.Item('qryGrade10').SQL = 'SELECT tblMembers.FirstName, tblMembers.Surname, tblMembers.Grade FROM tblMembers WHERE (((tblMembers.Grade)=10));'
  $db = $null
  $app.DoCmd.OpenQuery('qryGrade10', 1)
  Start-Sleep -Milliseconds 1500
  Mark 'run' (Box (Find $root @('Run') $T::Button))
  Dump 'querydesign'
  Snap 'q-4'                                               # 10 in Grade's Criteria
  $app.DoCmd.Close(1, 'qryGrade10', 2)
  $app.DoCmd.OpenQuery('qryGrade10')                       # Datasheet View: the answer
  Start-Sleep -Milliseconds 1500
  Snap 'q-5'
  $app.DoCmd.Close(1, 'qryGrade10', 2)

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
