# The catdb Grade 12 lessons' databases (AIPascalCourse/content/catdb/) - as
# catdb-data.ps1: built in real Access through DAO and Access SQL DDL; -Done makes
# the copy with the lesson's task done the model answer's way.

# ---------------------------------------------------------------- lessons 10 and 14: Ekasi Skills College
# A college's students: wildcards, Is Null, dates and Year() (lesson 10); a report's new
# record source, a totals count and an export (lesson 14).
function Build-College($app, [string]$file, [switch]$Done10, [switch]$Done14, [switch]$Report) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblStudents (StudentNo TEXT(6) CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), DOB DATETIME, Cell TEXT(12), Email TEXT(60), EnrolDate DATETIME, Course TEXT(30), FeesOwed CURRENCY)')
  FieldFormat $db 'tblStudents' 'FeesOwed' 'Currency'
  $rows = @(
    @('ES1001', 'Lerato', 'Mokoena', '2006/04/12', '082 555 1001', 'lerato.m@bestlessons.co.za', '2025/01/20', 'Office Administration', 0),
    @('ES1002', 'Sibusiso', 'Dlamini', '2007/02/28', '073 555 1002', 'Null', '2025/01/20', 'Electrical', 1500),
    @('ES1003', 'Naledi', 'Mahlangu', '2006/11/05', '071 555 1003', 'naledi.m@bestlessons.co.za', '2025/02/03', 'Hospitality', 750),
    @('ES1004', 'Kagiso', 'Molefe', '2007/07/19', '084 555 1004', 'Null', '2025/07/14', 'Plumbing', 2250),
    @('ES1005', 'Ayanda', 'Zulu', '2008/01/09', '061 555 1005', 'ayanda.z@bestlessons.co.za', '2026/01/19', 'Coding', 0),
    @('ES1006', 'Tshepo', 'Maseko', '2007/10/30', '076 555 1006', 'tshepo.m@bestlessons.co.za', '2026/01/19', 'Electrical', 3000),
    @('ES1007', 'Precious', 'Sithole', '2006/06/23', '072 555 1007', 'Null', '2026/02/02', 'Office Administration', 500),
    @('ES1008', 'Bongani', 'Zwane', '2005/12/14', '083 555 1008', 'bongani.z@bestlessons.co.za', '2026/02/02', 'Plumbing', 0),
    @('ES1009', 'Refilwe', 'Mabena', '2008/03/27', '060 555 1009', 'refilwe.m@bestlessons.co.za', '2026/03/09', 'Hospitality', 1250),
    @('ES1010', 'Mandla', 'Khoza', '2007/05/16', '078 555 1010', 'Null', '2026/03/09', 'Coding', 2000),
    @('ES1011', 'Lindiwe', 'Mthembu', '2006/09/02', '073 555 1011', 'lindiwe.m@bestlessons.co.za', '2026/04/13', 'Electrical', 0),
    @('ES1012', 'Musa', 'Cele', '2008/08/21', '079 555 1012', 'musa.c@bestlessons.co.za', '2026/04/13', 'Coding', 1750),
    @('ES1013', 'Zanele', 'Ngcobo', '2007/12/04', '071 555 1013', 'Null', '2026/07/13', 'Hospitality', 2500),
    @('ES1014', 'Pieter', 'van Wyk', '2006/03/15', '072 555 1014', 'pieter.vw@bestlessons.co.za', '2026/07/13', 'Plumbing', 1000),
    @('ES1015', 'Thandiwe', 'Nkosi', '2007/04/01', '082 555 1015', 'thandiwe.n@bestlessons.co.za', '2026/07/27', 'Office Administration', 250),
    @('ES1016', 'Sizwe', 'Shabangu', '2005/10/10', '084 555 1016', 'Null', '2026/08/10', 'Electrical', 3500),
    @('ES1017', 'Kayla', 'Adams', '2008/06/30', '061 555 1017', 'kayla.a@bestlessons.co.za', '2026/08/10', 'Coding', 0),
    @('ES1018', 'Themba', 'Radebe', '2007/09/11', '076 555 1018', 'themba.r@bestlessons.co.za', '2026/09/07', 'Hospitality', 1500))
  foreach ($r in $rows) {
    $email = $(if ($r[5] -eq 'Null') { 'Null' } else { Sq $r[5] })
    $db.Execute("INSERT INTO tblStudents VALUES ($(Sq $r[0]), $(Sq $r[1]), $(Sq $r[2]), #$($r[3])#, $(Sq $r[4]), $email, #$($r[6])#, $(Sq $r[7]), $($r[8]))")
  }
  if ($Done10) {
    $null = $db.CreateQueryDef('qrySurnameM', 'SELECT tblStudents.FirstName, tblStudents.Surname, tblStudents.Course FROM tblStudents WHERE (((tblStudents.Surname) Like "M*")) ORDER BY tblStudents.Surname;')
    $null = $db.CreateQueryDef('qryNoEmail', 'SELECT tblStudents.StudentNo, tblStudents.FirstName, tblStudents.Surname, tblStudents.Cell FROM tblStudents WHERE (((tblStudents.Email) Is Null));')
    $null = $db.CreateQueryDef('qryBorn2007', 'SELECT tblStudents.FirstName, tblStudents.Surname, tblStudents.DOB FROM tblStudents WHERE ((Year([DOB])=2007)) ORDER BY tblStudents.DOB;')
    $null = $db.CreateQueryDef('qryFirstHalf', 'SELECT tblStudents.FirstName, tblStudents.Surname, tblStudents.EnrolDate FROM tblStudents WHERE (((tblStudents.EnrolDate) Between #2026/1/1# And #2026/6/30#)) ORDER BY tblStudents.EnrolDate, tblStudents.Surname;')
  }
  if ($Done14) {
    $null = $db.CreateQueryDef('qryOwing', 'SELECT tblStudents.StudentNo, tblStudents.FirstName, tblStudents.Surname, tblStudents.Cell, tblStudents.Course, tblStudents.FeesOwed FROM tblStudents WHERE (((tblStudents.FeesOwed)>0)) ORDER BY tblStudents.FeesOwed DESC, tblStudents.Surname;')
    $null = $db.CreateQueryDef('qryCourseCount', 'SELECT tblStudents.Course, Count(tblStudents.StudentNo) AS Students FROM tblStudents GROUP BY tblStudents.Course ORDER BY tblStudents.Course;')
  }
  $db = $null
  if ($Report) {
    $app.RefreshDatabaseWindow()
    MakeReportFull $app 'tblStudents' 'rptStudents' 'Ekasi Skills College students' @(@('StudentNo', 1300), @('FirstName', 1800), @('Surname', 2000), @('Course', 2800), @('FeesOwed', 1500)) 'FeesOwed' 'Students:'
    if ($Done14) { $app.DoCmd.OpenReport('rptStudents', 1); Start-Sleep -Milliseconds 800; $app.Reports.Item('rptStudents').RecordSource = 'qryOwing'; $app.DoCmd.Close(3, 'rptStudents', 1) }
  }
}

# ---------------------------------------------------------------- lesson 11: calculated fields
# A Durban shuttle's bookings at R6.25 a kilometre.
function Build-Shuttle($app, [string]$file, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblBookings (BookingID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), Pickup TEXT(30), Destination TEXT(30), DepartDate DATETIME, KM DOUBLE, Passengers BYTE, Paid BIT)')
  TickBox $db 'tblBookings' 'Paid'
  $rows = @(
    @('Johan', 'Botha', 'King Shaka Airport', 'Umhlanga', '2026/12/01', 24, 2, -1),
    @('Gogo', 'Dlamini', 'Durban Station', 'Pinetown', '2026/12/02', 28, 1, -1),
    @('Ms', 'Naidoo', 'King Shaka Airport', 'Chatsworth', '2026/12/02', 52, 4, 0),
    @('Sipho', 'Ndlovu', 'Durban Station', 'Umlazi', '2026/12/03', 26, 3, -1),
    @('Megan', 'Smith', 'King Shaka Airport', 'Ballito', '2026/12/04', 22, 5, 0),
    @('Kagiso', 'Molefe', 'uShaka Marine World', 'King Shaka Airport', '2026/12/05', 38, 2, -1),
    @('Aisha', 'Patel', 'Durban Station', 'Westville', '2026/12/05', 16, 1, 0),
    @('Thabo', 'Mokoena', 'King Shaka Airport', 'uShaka Marine World', '2026/12/06', 36, 6, -1),
    @('Naledi', 'Mahlangu', 'Pinetown', 'Durban Station', '2026/12/07', 27, 2, 0),
    @('Mr', 'Pillay', 'King Shaka Airport', 'Phoenix', '2026/12/08', 20, 4, -1),
    @('Zanele', 'Ngcobo', 'Umlazi', 'King Shaka Airport', '2026/12/09', 58, 3, 0),
    @('Bongani', 'Zwane', 'Durban Station', 'Amanzimtoti', '2026/12/10', 30, 8, -1))
  foreach ($r in $rows) {
    $db.Execute("INSERT INTO tblBookings (FirstName, Surname, Pickup, Destination, DepartDate, KM, Passengers, Paid) VALUES ($(Sq $r[0]), $(Sq $r[1]), $(Sq $r[2]), $(Sq $r[3]), #$($r[4])#, $($r[5]), $($r[6]), $($r[7]))")
  }
  if ($Done) {
    $null = $db.CreateQueryDef('qryCost', 'SELECT tblBookings.FirstName, tblBookings.Surname, tblBookings.KM, [KM]*6.25 AS Cost FROM tblBookings ORDER BY tblBookings.Surname;')
    $null = $db.CreateQueryDef('qryPerPerson', 'SELECT tblBookings.Surname, tblBookings.Passengers, Round([KM]*6.25/[Passengers],2) AS PerPerson FROM tblBookings WHERE (((tblBookings.Passengers)>=3));')
    $null = $db.CreateQueryDef('qryFullName', 'SELECT [FirstName] & " " & [Surname] AS FullName, tblBookings.Destination FROM tblBookings WHERE (((tblBookings.Paid)=False));')
    $null = $db.CreateQueryDef('qryDiscount', 'SELECT tblBookings.Surname, [KM]*6.25 AS Cost, [KM]*6.25*0.9 AS Discounted FROM tblBookings WHERE (((tblBookings.Passengers)>=4));')
  }
  $db = $null
}

# ---------------------------------------------------------------- lessons 12 and 13: Botha's Bakery's sales
# A week of sales at three branches. Totals queries (12) and grouped reports (13).
function Build-Sales($app, [string]$file, [switch]$Done12, [switch]$Done13) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblSales (SaleID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, SaleDate DATETIME, Branch TEXT(20), Product TEXT(30), Category TEXT(15), Qty SHORT, Amount CURRENCY)')
  FieldFormat $db 'tblSales' 'Amount' 'Currency'
  $prices = @{ 'White bread' = 18; 'Brown bread' = 17.5; 'Seed loaf' = 32; 'Milk tart' = 85; 'Koeksisters (6)' = 30; 'Chocolate cake' = 260; 'Sausage roll' = 19.5; 'Vetkoek' = 6; 'Pie' = 28 }
  $cats = @{ 'White bread' = 'Bread'; 'Brown bread' = 'Bread'; 'Seed loaf' = 'Bread'; 'Milk tart' = 'Cakes'; 'Koeksisters (6)' = 'Cakes'; 'Chocolate cake' = 'Cakes'; 'Sausage roll' = 'Savoury'; 'Vetkoek' = 'Savoury'; 'Pie' = 'Savoury' }
  $sales = @(
    @('2026/10/05', 'Centurion', 'White bread', 40), @('2026/10/05', 'Centurion', 'Milk tart', 3), @('2026/10/05', 'Centurion', 'Vetkoek', 60),
    @('2026/10/05', 'Midrand', 'Brown bread', 25), @('2026/10/05', 'Midrand', 'Pie', 22), @('2026/10/05', 'Pretoria North', 'White bread', 30),
    @('2026/10/05', 'Pretoria North', 'Koeksisters (6)', 8), @('2026/10/06', 'Centurion', 'Seed loaf', 12), @('2026/10/06', 'Centurion', 'Sausage roll', 35),
    @('2026/10/06', 'Midrand', 'Chocolate cake', 2), @('2026/10/06', 'Midrand', 'White bread', 28), @('2026/10/06', 'Pretoria North', 'Vetkoek', 45),
    @('2026/10/06', 'Pretoria North', 'Pie', 18), @('2026/10/07', 'Centurion', 'Koeksisters (6)', 10), @('2026/10/07', 'Centurion', 'Brown bread', 20),
    @('2026/10/07', 'Midrand', 'Sausage roll', 30), @('2026/10/07', 'Midrand', 'Milk tart', 4), @('2026/10/07', 'Pretoria North', 'Seed loaf', 9),
    @('2026/10/08', 'Centurion', 'Chocolate cake', 1), @('2026/10/08', 'Centurion', 'Pie', 26), @('2026/10/08', 'Midrand', 'Vetkoek', 50),
    @('2026/10/08', 'Midrand', 'Koeksisters (6)', 6), @('2026/10/08', 'Pretoria North', 'Brown bread', 15), @('2026/10/08', 'Pretoria North', 'Milk tart', 2),
    @('2026/10/09', 'Centurion', 'White bread', 45), @('2026/10/09', 'Centurion', 'Vetkoek', 70), @('2026/10/09', 'Midrand', 'Seed loaf', 14),
    @('2026/10/09', 'Midrand', 'Pie', 24), @('2026/10/09', 'Pretoria North', 'Sausage roll', 20), @('2026/10/09', 'Pretoria North', 'Chocolate cake', 1))
  foreach ($s in $sales) {
    $amount = [double]$prices[$s[2]] * [int]$s[3]
    $db.Execute("INSERT INTO tblSales (SaleDate, Branch, Product, Category, Qty, Amount) VALUES (#$($s[0])#, $(Sq $s[1]), $(Sq $s[2]), $(Sq $cats[$s[2]]), $($s[3]), $amount)")
  }
  if ($Done12) {
    $null = $db.CreateQueryDef('qryByCategory', 'SELECT tblSales.Category, Sum(tblSales.Amount) AS TotalSales FROM tblSales GROUP BY tblSales.Category ORDER BY Sum(tblSales.Amount) DESC;')
    $null = $db.CreateQueryDef('qryBranchCount', 'SELECT tblSales.Branch, Count(tblSales.SaleID) AS Sales, Sum(tblSales.Qty) AS Items FROM tblSales GROUP BY tblSales.Branch ORDER BY tblSales.Branch;')
    $null = $db.CreateQueryDef('qryBestSellers', 'SELECT tblSales.Product, Sum(tblSales.Qty) AS Sold FROM tblSales GROUP BY tblSales.Product HAVING (((Sum(tblSales.Qty))>=50)) ORDER BY Sum(tblSales.Qty) DESC;')
    $null = $db.CreateQueryDef('qryCakesAvg', 'SELECT tblSales.Branch, Avg(tblSales.Amount) AS AvgSale, Max(tblSales.Amount) AS BiggestSale FROM tblSales WHERE (((tblSales.Category)="Cakes")) GROUP BY tblSales.Branch;')
    $null = $db.CreateQueryDef('qryBranchByCategory', 'TRANSFORM Sum(tblSales.Amount) AS SumOfAmount SELECT tblSales.Branch FROM tblSales GROUP BY tblSales.Branch PIVOT tblSales.Category;')
  }
  if ($Done13) {
    $null = $db.CreateQueryDef('qryBranchTotals', 'SELECT tblSales.Branch, Count(*) AS Sales, Sum(tblSales.Amount) AS BranchTotal FROM tblSales GROUP BY tblSales.Branch;')
  }
  $db = $null
  if ($Done13) {
    $app.RefreshDatabaseWindow()
    MakeGroupedReport $app 'tblSales' 'rptSalesByBranch' 'Sales by branch' 'Branch' @(@('SaleDate', 1500), @('Product', 2200), @('Qty', 900), @('Amount', 1400)) 'Amount'
  }
}

# ---------------------------------------------------------------- lesson 15: related tables
# The Kasi Netball League: teams and players. Done: the relationship (enforced, cascade
# update), a join query, a form with a subform and a main form (menu).
function Build-League($app, [string]$file, [switch]$Done, [switch]$Forms) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblTeams (TeamID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, TeamName TEXT(30), Coach TEXT(40), HomeGround TEXT(40))')
  $db.Execute('CREATE TABLE tblPlayers (PlayerID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), TeamID LONG, Position TEXT(20), Goals SHORT)')
  Rows $db 'tblTeams' 'TeamName, Coach, HomeGround' @(
    @((Sq 'Soweto Stars'), (Sq 'Ms Naidoo'), (Sq 'Phumlani Secondary')), @((Sq 'Kliptown Queens'), (Sq 'Mrs Nkosi'), (Sq 'Kliptown Hall')),
    @((Sq 'Orlando Eagles'), (Sq 'Mr Dube'), (Sq 'Orlando Stadium')), @((Sq 'Pimville Panthers'), (Sq 'Ms Mahlangu'), (Sq 'Pimville Square')))
  $players = @(
    @('Zanele', 'Ngcobo', 1, 'Goal Shooter', 24), @('Lerato', 'Khumalo', 1, 'Goal Attack', 17), @('Aisha', 'Patel', 1, 'Centre', 3), @('Naledi', 'Mahlangu', 1, 'Goal Keeper', 0),
    @('Kayla', 'Adams', 2, 'Goal Shooter', 19), @('Refilwe', 'Mabena', 2, 'Goal Attack', 12), @('Precious', 'Sithole', 2, 'Wing Defence', 0), @('Lindiwe', 'Mthembu', 2, 'Centre', 4),
    @('Ayanda', 'Zulu', 3, 'Goal Shooter', 21), @('Thandeka', 'Mabuza', 3, 'Goal Attack', 9), @('Megan', 'Smith', 3, 'Goal Defence', 0),
    @('Nomsa', 'Nkosi', 4, 'Goal Shooter', 15), @('Busi', 'Dlamini', 4, 'Goal Attack', 6), @('Grace', 'Molefe', 4, 'Wing Attack', 2))
  foreach ($p in $players) { $db.Execute("INSERT INTO tblPlayers (FirstName, Surname, TeamID, Position, Goals) VALUES ($(Sq $p[0]), $(Sq $p[1]), $($p[2]), $(Sq $p[3]), $($p[4]))") }
  if ($Done) {
    $rel = $db.CreateRelation('TeamsPlayers', 'tblTeams', 'tblPlayers', 256)      # dbRelationUpdateCascade; enforced (the default)
    $f = $rel.CreateField('TeamID'); $f.ForeignName = 'TeamID'; $rel.Fields.Append($f)
    $db.Relations.Append($rel)
    $null = $db.CreateQueryDef('qryTopScorers', 'SELECT tblTeams.TeamName, tblPlayers.FirstName, tblPlayers.Surname, tblPlayers.Goals FROM tblTeams INNER JOIN tblPlayers ON tblTeams.TeamID = tblPlayers.TeamID WHERE (((tblPlayers.Goals)>=10)) ORDER BY tblPlayers.Goals DESC;')
  }
  $db = $null
  if ($Forms) {
    $app.RefreshDatabaseWindow()
    MakeForm $app 'tblTeams' 'frmTeams' 'Teams and their players' @('TeamID', 'TeamName', 'Coach', 'HomeGround')
    MakeForm $app 'tblPlayers' 'frmPlayers' 'Players' @('PlayerID', 'FirstName', 'Surname', 'TeamID', 'Position', 'Goals')
  }
}

# ---------------------------------------------------------------- lesson 16: a scenario
# The Soweto Fun Run. Starter: tblRunners with no properties set. Done: the exam-style
# task list's table design and queries (the form and report are the teacher's to see).
function Build-FunRun($app, [string]$file, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblRunners (RunnerID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(255), Surname TEXT(255), Gender TEXT(255), Age SHORT, Distance TEXT(255), Club TEXT(255), EntryFee CURRENCY, Paid BIT, FinishMin DOUBLE)')
  TickBox $db 'tblRunners' 'Paid'
  FieldFormat $db 'tblRunners' 'EntryFee' 'Currency'
  $runners = @(
    @('Thabo', 'Mokoena', 'M', 17, '10 km', 'Phumlani AC', 80, -1, 52.5), @('Lerato', 'Khumalo', 'F', 16, '5 km', 'Null', 50, -1, 31.2),
    @('Johan', 'Botha', 'M', 52, '21 km', 'Centurion Striders', 150, -1, 118.4), @('Gogo', 'Dlamini', 'F', 71, '5 km', 'Null', 50, -1, 58.9),
    @('Sipho', 'Ndlovu', 'M', 17, '21 km', 'Phumlani AC', 150, 0, 101.7), @('Naledi', 'Mahlangu', 'F', 18, '10 km', 'Soweto Runners', 80, -1, 49.8),
    @('Kagiso', 'Molefe', 'M', 29, '10 km', 'Null', 80, 0, 44.1), @('Megan', 'Smith', 'F', 34, '21 km', 'Soweto Runners', 150, -1, 126.0),
    @('Aisha', 'Patel', 'F', 15, '5 km', 'Phumlani AC', 50, -1, 27.6), @('Bongani', 'Zwane', 'M', 45, '21 km', 'Soweto Runners', 150, -1, 109.3),
    @('Zanele', 'Ngcobo', 'F', 17, '10 km', 'Phumlani AC', 80, 0, 55.0), @('Mr', 'Pillay', 'M', 63, '5 km', 'Null', 50, -1, 36.4),
    @('Precious', 'Sithole', 'F', 26, '21 km', 'Null', 150, 0, 131.8), @('Tshepo', 'Maseko', 'M', 12, '5 km', 'Phumlani AC', 50, -1, 25.9),
    @('Ms', 'Naidoo', 'F', 41, '10 km', 'Soweto Runners', 80, -1, 61.3), @('Musa', 'Cele', 'M', 9, '5 km', 'Null', 50, -1, 39.0))
  foreach ($r in $runners) {
    $club = $(if ($r[5] -eq 'Null') { 'Null' } else { Sq $r[5] })
    $db.Execute("INSERT INTO tblRunners (FirstName, Surname, Gender, Age, Distance, Club, EntryFee, Paid, FinishMin) VALUES ($(Sq $r[0]), $(Sq $r[1]), $(Sq $r[2]), $($r[3]), $(Sq $r[4]), $club, $($r[6]), $($r[7]), $($r[8]))")
  }
  if ($Done) {
    $db.Execute('ALTER TABLE tblRunners ALTER COLUMN Gender TEXT(1)')
    $db.Execute('ALTER TABLE tblRunners ALTER COLUMN Surname TEXT(30)')
    $t = $db.TableDefs.Item('tblRunners')
    $t.Fields.Item('Surname').Required = $true
    $a = $t.Fields.Item('Age'); $a.ValidationRule = 'Between 7 And 90'; $a.ValidationText = 'Runners must be from 7 to 90 years old.'
    SetProp $t.Fields.Item('Gender') 'InputMask' 10 '>L'
    SetProp $t.Fields.Item('FinishMin') 'DecimalPlaces' 2 1
    $null = $db.CreateQueryDef('qryJuniors', 'SELECT tblRunners.FirstName, tblRunners.Surname, tblRunners.Age, tblRunners.Distance FROM tblRunners WHERE (((tblRunners.Age)<18)) ORDER BY tblRunners.Age;')
    $null = $db.CreateQueryDef('qryNoClub', 'SELECT tblRunners.FirstName, tblRunners.Surname, tblRunners.Distance FROM tblRunners WHERE (((tblRunners.Club) Is Null));')
    $null = $db.CreateQueryDef('qryLong', 'SELECT tblRunners.FirstName, tblRunners.Surname, tblRunners.FinishMin FROM tblRunners WHERE (((tblRunners.Distance)="21 km") AND ((tblRunners.Gender)="F")) OR (((tblRunners.Distance)="10 km") AND ((tblRunners.Gender)="F"));')
    $null = $db.CreateQueryDef('qryOwes', 'SELECT tblRunners.FirstName, tblRunners.Surname, tblRunners.EntryFee, [EntryFee]*0.9 AS EarlyBird FROM tblRunners WHERE (((tblRunners.Paid)=False));')
    $null = $db.CreateQueryDef('qryPerDistance', 'SELECT tblRunners.Distance, Count(tblRunners.RunnerID) AS Runners, Avg(tblRunners.FinishMin) AS AvgTime FROM tblRunners GROUP BY tblRunners.Distance;')
  }
  $db = $null
}
