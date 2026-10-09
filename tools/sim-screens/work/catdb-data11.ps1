# The catdb Grade 11 lessons 4-9's databases (AIPascalCourse/content/catdb/) - as
# catdb-data.ps1 (lessons 1-3): built in real Access through DAO and Access SQL DDL;
# -Done makes the copy with the lesson's task done the model answer's way.

# ---------------------------------------------------------------- lesson 4: properties
# Botha's Bakery's cake orders. Starter: every Short Text 255, nothing set. Done: the
# field sizes, a caption, Required, a date format and default, Candles a Byte, Price with
# no decimals. -Shots also: Size as a lookup (value list), Notes as Rich Text.
function Build-Orders($app, [string]$file, [switch]$Done, [switch]$Shots) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblOrders (OrderID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, CustomerName TEXT(255), Phone TEXT(255), OrderDate DATETIME, Cake TEXT(255), CakeSize TEXT(255), Candles LONG, Price CURRENCY, Paid BIT, Notes MEMO)')
  TickBox $db 'tblOrders' 'Paid'
  FieldFormat $db 'tblOrders' 'Price' 'Currency'
  Rows $db 'tblOrders' 'CustomerName, Phone, OrderDate, Cake, CakeSize, Candles, Price, Paid, Notes' @(
    @((Sq 'Lerato Mokoena'), (Sq '082 555 0311'), '#2026/10/02#', (Sq 'Chocolate'), (Sq 'Large'), 18, 420, -1, (Sq 'Happy 18th, Lerato!')),
    @((Sq 'Gogo Dlamini'), (Sq '060 555 0191'), '#2026/10/03#', (Sq 'Carrot'), (Sq 'Medium'), 0, 260, -1, (Sq 'No nuts, please.')),
    @((Sq 'Mr Pillay'), (Sq '084 555 0167'), '#2026/10/05#', (Sq 'Milk tart'), (Sq 'Large'), 0, 85, 0, 'Null'),
    @((Sq 'Ms Naidoo'), (Sq '083 555 0402'), '#2026/10/06#', (Sq 'Vanilla'), (Sq 'Small'), 1, 180, 0, (Sq 'Staff room farewell.')),
    @((Sq 'Thabo Mokoena'), (Sq '076 555 0152'), '#2026/10/08#', (Sq 'Red velvet'), (Sq 'Medium'), 17, 310, -1, 'Null'))
  if ($Done -or $Shots) {
    $db.Execute('ALTER TABLE tblOrders ALTER COLUMN CustomerName TEXT(40)')
    $db.Execute('ALTER TABLE tblOrders ALTER COLUMN Phone TEXT(12)')
    $db.Execute('ALTER TABLE tblOrders ALTER COLUMN Candles BYTE')
    $t = $db.TableDefs.Item('tblOrders')
    SetProp $t.Fields.Item('CustomerName') 'Caption' 10 'Customer name'
    $t.Fields.Item('CustomerName').Required = $true
    SetProp $t.Fields.Item('OrderDate') 'Format' 10 'dd mmm yyyy'
    $t.Fields.Item('OrderDate').DefaultValue = 'Date()'
    SetProp $t.Fields.Item('Price') 'DecimalPlaces' 2 0
  }
  if ($Shots) {
    $t = $db.TableDefs.Item('tblOrders')
    $f = $t.Fields.Item('CakeSize')
    SetProp $f 'DisplayControl' 3 111                        # a combo box
    SetProp $f 'RowSourceType' 10 'Value List'
    SetProp $f 'RowSource' 10 '"Small";"Medium";"Large"'
    SetProp $f 'LimitToList' 1 $true
    SetProp $t.Fields.Item('Notes') 'TextFormat' 2 1         # Rich Text
    $db.Execute("UPDATE tblOrders SET Notes = '<div><strong>No nuts</strong>, please.</div>' WHERE CustomerName = 'Gogo Dlamini'")
    SetProp $t.Fields.Item('Price') 'TextAlign' 2 2          # centred, to show Text Align
  }
  $db = $null
}

# ---------------------------------------------------------------- lesson 5: validation
# Phumlani Secondary's bursary applications. Starter: no masks, no rules. Done: the input
# masks, rules and texts, Indexed (No Duplicates) on IDNumber, Surname required.
function Build-Bursary($app, [string]$file, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblApplicants (ApplicantID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), IDNumber TEXT(13), Cell TEXT(12), Grade BYTE, Average DOUBLE, Postcode TEXT(4), Applied DATETIME)')
  Rows $db 'tblApplicants' 'FirstName, Surname, IDNumber, Cell, Grade, Average, Postcode, Applied' @(
    @((Sq 'Thabo'), (Sq 'Mokoena'), (Sq '0905125800083'), (Sq '0765550152'), 11, 74.5, (Sq '1818'), '#2026/09/01#'),
    @((Sq 'Naledi'), (Sq 'Mahlangu'), (Sq '0802140431087'), (Sq '0825550466'), 12, 81, (Sq '1818'), '#2026/09/02#'),
    @((Sq 'Sipho'), (Sq 'Ndlovu'), (Sq '0906305211082'), (Sq '0785550224'), 11, 68.25, (Sq '1804'), '#2026/09/04#'),
    @((Sq 'Aisha'), (Sq 'Patel'), (Sq '1003110293084'), (Sq '0835550519'), 10, 88, (Sq '1812'), '#2026/09/04#'),
    @((Sq 'Pieter'), (Sq 'van Wyk'), (Sq '0907015123089'), (Sq '0725550537'), 11, 59.5, (Sq '1801'), '#2026/09/07#'))
  if ($Done) {
    $t = $db.TableDefs.Item('tblApplicants')
    SetProp $t.Fields.Item('IDNumber') 'InputMask' 10 '0000000000000'
    $db.Execute('CREATE UNIQUE INDEX IDNumber ON tblApplicants (IDNumber)')
    $t = $db.TableDefs.Item('tblApplicants')
    SetProp $t.Fields.Item('Cell') 'InputMask' 10 '000\ 000\ 0000;;_'
    SetProp $t.Fields.Item('Postcode') 'InputMask' 10 '0000'
    $g = $t.Fields.Item('Grade'); $g.ValidationRule = 'Between 8 And 12'; $g.ValidationText = 'Grade must be from 8 to 12.'
    $a = $t.Fields.Item('Average'); $a.ValidationRule = '>=0 And <=100'; $a.ValidationText = 'An average is a percentage from 0 to 100.'
    $d = $t.Fields.Item('Applied'); $d.ValidationRule = '<=Date()'; $d.ValidationText = 'The date applied cannot be in the future.'
    $t.Fields.Item('Surname').Required = $true
  }
  $db = $null
}

# ---------------------------------------------------------------- lesson 6: forms
# Gogo Dlamini's stokvel. Starter: tblMembers, ten members, no form. Done: frmMembers
# (a form made by Access's Form button) and the two new members typed in.
function Build-Stokvel($app, [string]$file, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblMembers (MemberID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), Cell TEXT(12), JoinDate DATETIME, Monthly CURRENCY, PaidUp BIT)')
  TickBox $db 'tblMembers' 'PaidUp'
  FieldFormat $db 'tblMembers' 'Monthly' 'Currency'
  Rows $db 'tblMembers' 'FirstName, Surname, Cell, JoinDate, Monthly, PaidUp' @(
    @((Sq 'Thandiwe'), (Sq 'Dlamini'), (Sq '060 555 0191'), '#2019/01/06#', 500, -1),
    @((Sq 'Busi'), (Sq 'Nkosi'), (Sq '073 555 0601'), '#2019/01/06#', 500, -1),
    @((Sq 'Martha'), (Sq 'Mokoena'), (Sq '082 555 0612'), '#2019/01/06#', 500, -1),
    @((Sq 'Zanele'), (Sq 'Sithole'), (Sq '071 555 0623'), '#2020/03/01#', 300, 0),
    @((Sq 'Grace'), (Sq 'Molefe'), (Sq '076 555 0634'), '#2020/03/01#', 500, -1),
    @((Sq 'Lindiwe'), (Sq 'Zulu'), (Sq '083 555 0645'), '#2021/07/04#', 300, -1),
    @((Sq 'Rose'), (Sq 'Mahlangu'), (Sq '072 555 0656'), '#2022/02/06#', 500, 0),
    @((Sq 'Precious'), (Sq 'Ndlovu'), (Sq '079 555 0667'), '#2023/01/08#', 500, -1),
    @((Sq 'Agnes'), (Sq 'Khumalo'), (Sq '084 555 0678'), '#2024/05/05#', 300, -1),
    @((Sq 'Dudu'), (Sq 'Mthembu'), (Sq '061 555 0689'), '#2025/09/07#', 500, -1))
  if ($Done) {
    Rows $db 'tblMembers' 'FirstName, Surname, Cell, JoinDate, Monthly, PaidUp' @(
      @((Sq 'Nomvula'), (Sq 'Shabalala'), (Sq '082 555 0701'), '#2026/10/04#', 500, 0),
      @((Sq 'Joyce'), (Sq 'Radebe'), (Sq '073 555 0712'), '#2026/10/04#', 300, 0))
  }
  $db = $null
  if ($Done) { $app.RefreshDatabaseWindow(); MakeForm $app 'tblMembers' 'frmMembers' 'Stokvel members' @('MemberID', 'FirstName', 'Surname', 'Cell', 'JoinDate', 'Monthly', 'PaidUp') }
}

# ---------------------------------------------------------------- lessons 7 and 9: queries, reports
# Phumlani Secondary's Grade 10-12 tour to Durban (R2 500 each). Starter: tblTravellers only.
# Done (lesson 7): qryGrade11, qrySoweto, qryBigDeposits. Done (lesson 9): qryNotPaid and
# a report on it.
function Build-Tour($app, [string]$file, [switch]$Done7, [switch]$Done9) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblTravellers (TravellerID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), Gender TEXT(1), Grade BYTE, Town TEXT(20), Cell TEXT(12), Deposit CURRENCY, PaidInFull BIT, BirthDate DATETIME)')
  TickBox $db 'tblTravellers' 'PaidInFull'
  FieldFormat $db 'tblTravellers' 'Deposit' 'Currency'
  $rows = @(
    @('Thabo', 'Mokoena', 'M', 11, 'Soweto', '076 555 0152', 1500, 0, '2009/05/12'),
    @('Lerato', 'Khumalo', 'F', 10, 'Kliptown', '072 555 0188', 750, 0, '2010/08/30'),
    @('Sipho', 'Ndlovu', 'M', 11, 'Pimville', '078 555 0224', 2500, -1, '2009/06/30'),
    @('Aisha', 'Patel', 'F', 10, 'Lenasia', '083 555 0519', 2500, -1, '2010/03/11'),
    @('Naledi', 'Mahlangu', 'F', 12, 'Soweto', '082 555 0466', 1000, 0, '2008/02/14'),
    @('Pieter', 'van Wyk', 'M', 11, 'Kliptown', '072 555 0537', 500, 0, '2009/07/01'),
    @('Zanele', 'Ngcobo', 'F', 11, 'Orlando', '071 555 0745', 1500, 0, '2009/11/23'),
    @('Kagiso', 'Molefe', 'M', 12, 'Soweto', '082 555 0251', 2500, -1, '2008/09/09'),
    @('Thandeka', 'Mabuza', 'F', 10, 'Soweto', '073 555 0758', 500, 0, '2010/01/21'),
    @('Bongani', 'Zwane', 'M', 12, 'Diepkloof', '084 555 0761', 750, 0, '2008/04/18'),
    @('Ayanda', 'Zulu', 'F', 11, 'Meadowlands', '061 555 0279', 1000, 0, '2009/12/02'),
    @('Johan', 'Botha', 'M', 10, 'Centurion', '082 555 0773', 2500, -1, '2010/07/22'),
    @('Megan', 'Smith', 'F', 12, 'Kliptown', '079 555 0784', 1500, 0, '2008/03/04'),
    @('Tshepo', 'Maseko', 'M', 11, 'Soweto', '076 555 0796', 750, 0, '2009/10/15'),
    @('Precious', 'Sithole', 'F', 11, 'Pimville', '072 555 0803', 2500, -1, '2009/02/27'),
    @('Lwazi', 'Dube', 'M', 10, 'Orlando', '083 555 0815', 1000, 0, '2010/05/06'),
    @('Nomsa', 'Nkosi', 'F', 12, 'Soweto', '071 555 0826', 2000, 0, '2008/11/30'),
    @('Mandla', 'Khoza', 'M', 11, 'Diepkloof', '078 555 0837', 500, 0, '2009/08/08'),
    @('Refilwe', 'Mabena', 'F', 10, 'Meadowlands', '060 555 0848', 1500, 0, '2010/09/19'),
    @('Sizwe', 'Shabangu', 'M', 12, 'Pimville', '084 555 0859', 2500, -1, '2008/06/25'),
    @('Kayla', 'Adams', 'F', 11, 'Lenasia', '082 555 0861', 1000, 0, '2009/04/03'),
    @('Musa', 'Cele', 'M', 10, 'Soweto', '079 555 0872', 750, 0, '2010/12/12'),
    @('Lindiwe', 'Mthembu', 'F', 12, 'Orlando', '073 555 0883', 2500, -1, '2008/01/09'),
    @('Themba', 'Radebe', 'M', 11, 'Soweto', '061 555 0894', 2000, 0, '2009/03/17'))
  foreach ($r in $rows) {
    $db.Execute("INSERT INTO tblTravellers (FirstName, Surname, Gender, Grade, Town, Cell, Deposit, PaidInFull, BirthDate) VALUES ($(Sq $r[0]), $(Sq $r[1]), $(Sq $r[2]), $($r[3]), $(Sq $r[4]), $(Sq $r[5]), $($r[6]), $($r[7]), #$($r[8])#)")
  }
  if ($Done7) {
    $null = $db.CreateQueryDef('qryGrade11', 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Grade, tblTravellers.Town FROM tblTravellers WHERE (((tblTravellers.Grade)=11)) ORDER BY tblTravellers.Surname;')
    $null = $db.CreateQueryDef('qrySoweto', 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Cell FROM tblTravellers WHERE (((tblTravellers.Town)="Soweto"));')
    $null = $db.CreateQueryDef('qryBigDeposits', 'SELECT tblTravellers.Surname, tblTravellers.Deposit FROM tblTravellers WHERE (((tblTravellers.Deposit)>=1500)) ORDER BY tblTravellers.Deposit DESC;')
  }
  if ($Done9) {
    $null = $db.CreateQueryDef('qryNotPaid', 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Cell, tblTravellers.Deposit FROM tblTravellers WHERE (((tblTravellers.PaidInFull)=False)) ORDER BY tblTravellers.Surname;')
    $null = $db.CreateQueryDef('qryTownList', 'SELECT tblTravellers.FirstName, tblTravellers.Surname, tblTravellers.Grade, tblTravellers.Town FROM tblTravellers ORDER BY tblTravellers.Town, tblTravellers.Surname;')
  }
  $db = $null
  if ($Done9) { $app.RefreshDatabaseWindow(); MakeReportFull $app 'qryNotPaid' 'rptNotPaid' 'Still to pay for the tour' @(@('FirstName', 2000), @('Surname', 2200), @('Cell', 2000), @('Deposit', 1500)) 'Deposit' }
}

# ---------------------------------------------------------------- lesson 8: criteria
# Phumlani Secondary's athletics day (track events). Starter: tblAthletes only. Done:
# qryGirls11 (AND), qryRedBlue (OR), qryNoRelay (NOT), qryFast (Between, two sorts).
function Build-Athletics($app, [string]$file, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblAthletes (AthleteID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), Gender TEXT(1), Grade BYTE, House TEXT(10), Event TEXT(20), TimeSec DOUBLE, Points BYTE)')
  $rows = @(
    @('Zanele', 'Ngcobo', 'F', 11, 'Red', '100 m', 13.1, 5), @('Megan', 'Smith', 'F', 12, 'Blue', '100 m', 13.4, 3),
    @('Aisha', 'Patel', 'F', 10, 'Green', '100 m', 13.9, 1), @('Lerato', 'Khumalo', 'F', 10, 'Yellow', '100 m', 14.6, 0),
    @('Sipho', 'Ndlovu', 'M', 11, 'Red', '100 m', 11.8, 5), @('Kagiso', 'Molefe', 'M', 12, 'Blue', '100 m', 12.0, 3),
    @('Thabo', 'Mokoena', 'M', 11, 'Green', '100 m', 12.3, 1), @('Johan', 'Botha', 'M', 10, 'Yellow', '100 m', 12.9, 0),
    @('Naledi', 'Mahlangu', 'F', 12, 'Red', '200 m', 27.5, 5), @('Ayanda', 'Zulu', 'F', 11, 'Blue', '200 m', 28.2, 3),
    @('Kayla', 'Adams', 'F', 11, 'Yellow', '200 m', 29.0, 1), @('Refilwe', 'Mabena', 'F', 10, 'Green', '200 m', 30.4, 0),
    @('Bongani', 'Zwane', 'M', 12, 'Green', '200 m', 24.1, 5), @('Tshepo', 'Maseko', 'M', 11, 'Red', '200 m', 24.8, 3),
    @('Lwazi', 'Dube', 'M', 10, 'Blue', '200 m', 25.6, 1), @('Musa', 'Cele', 'M', 10, 'Yellow', '200 m', 26.3, 0),
    @('Precious', 'Sithole', 'F', 11, 'Green', '400 m', 63.2, 5), @('Lindiwe', 'Mthembu', 'F', 12, 'Red', '400 m', 65.0, 3),
    @('Sizwe', 'Shabangu', 'M', 12, 'Yellow', '400 m', 55.4, 5), @('Mandla', 'Khoza', 'M', 11, 'Blue', '400 m', 57.9, 3),
    @('Red team', 'Red House', 'M', 12, 'Red', 'Relay', 47.2, 5), @('Blue team', 'Blue House', 'M', 12, 'Blue', 'Relay', 48.0, 3),
    @('Green team', 'Green House', 'F', 11, 'Green', 'Relay', 54.6, 5), @('Yellow team', 'Yellow House', 'F', 11, 'Yellow', 'Relay', 55.1, 3))
  foreach ($r in $rows) {
    $db.Execute("INSERT INTO tblAthletes (FirstName, Surname, Gender, Grade, House, Event, TimeSec, Points) VALUES ($(Sq $r[0]), $(Sq $r[1]), $(Sq $r[2]), $($r[3]), $(Sq $r[4]), $(Sq $r[5]), $($r[6]), $($r[7]))")
  }
  if ($Done) {
    $null = $db.CreateQueryDef('qryGirls11', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.Event FROM tblAthletes WHERE (((tblAthletes.Gender)="F") AND ((tblAthletes.Grade)=11));')
    $null = $db.CreateQueryDef('qryRedBlue', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.House FROM tblAthletes WHERE (((tblAthletes.House)="Red")) OR (((tblAthletes.House)="Blue")) ORDER BY tblAthletes.House, tblAthletes.Surname;')
    $null = $db.CreateQueryDef('qryNoRelay', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.Event FROM tblAthletes WHERE (((tblAthletes.Event)<>"Relay"));')
    $null = $db.CreateQueryDef('qrySprinters', 'SELECT tblAthletes.FirstName, tblAthletes.Surname, tblAthletes.TimeSec FROM tblAthletes WHERE (((tblAthletes.Event)="100 m") AND ((tblAthletes.TimeSec) Between 12 And 13.5)) ORDER BY tblAthletes.TimeSec;')
  }
  $db = $null
}
