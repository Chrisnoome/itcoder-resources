# The catdb lessons' databases (AIPascalCourse/content/catdb/), built in real Access
# through DAO and Access SQL DDL. Dot-source after catdb-kit.ps1. Each Build- function
# makes one file: the starter a pupil downloads, or (-Done) the same file with the
# lesson's task done the way the model answer does it - for proving the upload checks.
# The data is the same in the screens, the starter and the done copy.

# ---------------------------------------------------------------- Grade 11 lesson 1: whatfor
# Phumlani Secondary's library. Starter: Coconut has no Copies; Spud has 6.
function Build-Library($app, [string]$file, [switch]$Done, [switch]$Objects) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblBooks (BookID COUNTER CONSTRAINT pkBooks PRIMARY KEY, Title TEXT(80), Author TEXT(50), Category TEXT(20), Published SHORT, Copies SHORT)')
  Rows $db 'tblBooks' 'Title, Author, Category, Published, Copies' @(
    @((Sq 'Long Walk to Freedom'), (Sq 'Nelson Mandela'), (Sq 'Biography'), 1994, 3),
    @((Sq 'Cry, the Beloved Country'), (Sq 'Alan Paton'), (Sq 'Fiction'), 1948, 4),
    @((Sq 'Born a Crime'), (Sq 'Trevor Noah'), (Sq 'Biography'), 2016, 5),
    @((Sq 'Things Fall Apart'), (Sq 'Chinua Achebe'), (Sq 'Fiction'), 1958, 3),
    @((Sq 'Thirteen Cents'), (Sq 'K. Sello Duiker'), (Sq 'Fiction'), 2000, 1),
    @((Sq 'Dog Eat Dog'), (Sq 'Niq Mhlongo'), (Sq 'Fiction'), 2004, 3),
    @((Sq 'Coconut'), (Sq 'Kopano Matlwa'), (Sq 'Fiction'), 2007, 'Null'),
    @((Sq 'Tsotsi'), (Sq 'Athol Fugard'), (Sq 'Fiction'), 1980, 2),
    @((Sq 'Spud'), (Sq 'John van de Ruit'), (Sq 'Fiction'), 2005, 6),
    @((Sq 'A Brief History of Time'), (Sq 'Stephen Hawking'), (Sq 'Science'), 1988, 1),
    @((Sq 'The Boy Who Harnessed the Wind'), (Sq 'William Kamkwamba'), (Sq 'Biography'), 2009, 2),
    @((Sq 'Everything Maths Grade 11'), (Sq 'Siyavula'), (Sq 'Textbook'), 2011, 25),
    @((Sq 'Nervous Conditions'), (Sq 'Tsitsi Dangarembga'), (Sq 'Fiction'), 1988, 2),
    @((Sq 'Long Story Short'), (Sq 'Sihle Ngobese'), (Sq 'Fiction'), 2019, 2))
  $null = $db.CreateQueryDef('qryFiction', 'SELECT tblBooks.Title, tblBooks.Author, tblBooks.Copies FROM tblBooks WHERE (((tblBooks.Category)="Fiction")) ORDER BY tblBooks.Title;')
  if ($Done) {
    $db.Execute("INSERT INTO tblBooks (Title, Author, Category, Published, Copies) VALUES ('The Hidden Star', 'K. Sello Duiker', 'Fiction', 2006, 2)")
    $db.Execute("UPDATE tblBooks SET Copies = 4 WHERE Title = 'Coconut'")
    $db.Execute("UPDATE tblBooks SET Copies = 5 WHERE Title = 'Spud'")
    $db.Execute("DELETE FROM tblBooks WHERE Title = 'A Brief History of Time'")
  }
  $db = $null
  if ($Objects) {
    $app.RefreshDatabaseWindow()
    MakeForm $app 'tblBooks' 'frmBooks' 'Books' @('BookID', 'Title', 'Author', 'Category', 'Published', 'Copies')
    MakeReport $app 'qryFiction' 'rptFiction' 'Fiction in the library' @(@('Title', 4200), @('Author', 3000), @('Copies', 1200))
  }
}

# ---------------------------------------------------------------- Grade 11 lesson 2: tables
# Botha's Bakery. Starter: tblProducts with only ProductID (a Number, not yet the key) and
# ProductName. Done: the key, four new fields and a new table tblBakers. -Shots: everything,
# with data, and (IEB) a calculated field DozenPrice.
function Build-Bakery($app, [string]$file, [switch]$Done, [switch]$Shots) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblProducts (ProductID LONG, ProductName TEXT(40))')
  $names = @('White bread 600 g', 'Brown bread 600 g', 'Seed loaf', 'Koeksisters (6)', 'Milk tart', 'Vetkoek', 'Sausage roll', 'Banana bread (gluten-free)')
  for ($i = 0; $i -lt $names.Count; $i++) { $db.Execute("INSERT INTO tblProducts (ProductID, ProductName) VALUES ($($i + 1), $(Sq $names[$i]))") }
  if ($Done -or $Shots) {
    $db.Execute('CREATE INDEX PrimaryKey ON tblProducts (ProductID) WITH PRIMARY')
    $db.Execute('ALTER TABLE tblProducts ADD COLUMN Price CURRENCY, GlutenFree BIT, FirstBaked DATETIME, Description MEMO')
    TickBox $db 'tblProducts' 'GlutenFree'
    FieldFormat $db 'tblProducts' 'Price' 'Currency'
    $db.Execute('CREATE TABLE tblBakers (BakerID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, FirstName TEXT(30), Surname TEXT(30), Phone TEXT(15))')
  }
  if ($Shots) {
    $rows = @(@(18, 0, '2019/03/01', 'Soft white loaf, sliced.'), @(17.5, 0, '2019/03/01', 'Brown loaf, sliced.'), @(32, 0, '2021/06/14', 'Sunflower, linseed and pumpkin seeds.'),
              @(30, 0, '2019/03/02', 'Six plaited koeksisters in syrup.'), @(85, 0, '2019/05/10', 'A whole milk tart, 24 cm.'), @(6, 0, '2019/03/01', 'Fried fresh every morning.'),
              @(19.5, 0, '2020/02/03', 'Beef sausage in puff pastry.'), @(45, -1, '2024/08/19', 'Made without wheat flour.'))
    for ($i = 0; $i -lt $rows.Count; $i++) {
      $r = $rows[$i]
      $db.Execute("UPDATE tblProducts SET Price = $($r[0]), GlutenFree = $($r[1]), FirstBaked = #$($r[2])#, Description = $(Sq $r[3]) WHERE ProductID = $($i + 1)")
    }
    Rows $db 'tblBakers' 'FirstName, Surname, Phone' @(@((Sq 'Johan'), (Sq 'Botha'), (Sq '082 555 0147')), @((Sq 'Precious'), (Sq 'Sithole'), (Sq '073 555 0192')))
    try {
      $td = $db.TableDefs.Item('tblProducts')
      $f = $td.CreateField('DozenPrice', 5)                  # dbCurrency, worked out from Price
      $f.Expression = '[Price]*12'
      $td.Fields.Append($f)
      FieldFormat $db 'tblProducts' 'DozenPrice' 'Currency'
      '  calculated field DozenPrice made'
    } catch { "  calculated field: $_" }
  }
  $db = $null
}

# ---------------------------------------------------------------- Grade 11 lesson 3: records
# Phumlani Secondary's Spring Day market. Starter: 14 stalls, "Craft" typed for two of the
# crafts stalls (the rest say Crafts), Dube Sweets not paid, Thabo's car wash still in.
# Done: a new stall, Dube Sweets paid, the car wash deleted, Craft replaced by Crafts, and
# LateStalls.csv imported as tblLateStalls (Access's own Import Text).
function Build-Market($app, [string]$file, [string]$csv, [switch]$Done) {
  Remove-Item $file -ErrorAction SilentlyContinue
  $app.NewCurrentDatabase($file)
  $db = $app.CurrentDb()
  $db.Execute('CREATE TABLE tblStalls (StallID COUNTER CONSTRAINT PrimaryKey PRIMARY KEY, Stallholder TEXT(40), Product TEXT(40), Category TEXT(20), Phone TEXT(15), Fee CURRENCY, Paid BIT)')
  TickBox $db 'tblStalls' 'Paid'
  FieldFormat $db 'tblStalls' 'Fee' 'Currency'
  Rows $db 'tblStalls' 'Stallholder, Product, Category, Phone, Fee, Paid' @(
    @((Sq 'Mama Zodwa'), (Sq 'Vetkoek and mince'), (Sq 'Food'), (Sq '082 555 0110'), 80, -1),
    @((Sq 'Dube Sweets'), (Sq 'Sweets and popcorn'), (Sq 'Food'), (Sq '071 555 0123'), 80, 0),
    @((Sq 'Grade 11A'), (Sq 'Face painting'), (Sq 'Games'), (Sq '083 555 0131'), 50, -1),
    @((Sq 'Ntombi Mahlangu'), (Sq 'Beaded jewellery'), (Sq 'Crafts'), (Sq '072 555 0145'), 50, -1),
    @((Sq "Thabo's car wash"), (Sq 'Car wash'), (Sq 'Games'), (Sq '076 555 0152'), 50, 0),
    @((Sq 'Mr Pillay'), (Sq 'Samoosas'), (Sq 'Food'), (Sq '084 555 0167'), 80, -1),
    @((Sq 'Art Club'), (Sq 'Painted pots'), (Sq 'Craft'), (Sq '082 555 0174'), 50, -1),
    @((Sq "Botha's Bakery"), (Sq 'Koeksisters'), (Sq 'Food'), (Sq '082 555 0147'), 80, -1),
    @((Sq 'Grade 8B'), (Sq 'Lucky dip'), (Sq 'Games'), (Sq '079 555 0186'), 50, -1),
    @((Sq 'Gogo Dlamini'), (Sq 'Knitted beanies'), (Sq 'Craft'), (Sq '060 555 0191'), 50, 0),
    @((Sq 'Soccer Club'), (Sq 'Penalty shoot-out'), (Sq 'Games'), (Sq '081 555 0203'), 50, -1),
    @((Sq 'Mrs Nkosi'), (Sq 'Boerewors rolls'), (Sq 'Food'), (Sq '073 555 0219'), 80, -1),
    @((Sq 'Sipho Ndlovu'), (Sq 'Wire cars'), (Sq 'Crafts'), (Sq '078 555 0224'), 50, -1),
    @((Sq 'Environmental Club'), (Sq 'Seedlings'), (Sq 'Crafts'), (Sq '082 555 0238'), 50, 0))
  if ($Done) {
    $db.Execute("INSERT INTO tblStalls (Stallholder, Product, Category, Phone, Fee, Paid) VALUES ('Lerato Khumalo', 'Beaded bracelets', 'Crafts', '072 555 0188', 50, -1)")
    $db.Execute("UPDATE tblStalls SET Paid = -1 WHERE Stallholder = 'Dube Sweets'")
    $db.Execute("DELETE FROM tblStalls WHERE Stallholder = 'Thabo''s car wash'")
    $db.Execute("UPDATE tblStalls SET Category = 'Crafts' WHERE Category = 'Craft'")
  }
  $db = $null
  if ($Done) { $app.DoCmd.TransferText(0, '', 'tblLateStalls', $csv, $true) }   # acImportDelim, the first row has the field names
}

function Write-LateStalls([string]$csv) {
  @('Stallholder,Product,Category,Phone,Fee',
    'Kagiso Molefe,Bunny chows,Food,082 555 0251,80',
    'Drama Club,Stocks (wet sponges),Games,083 555 0262,50',
    'Ayanda Zulu,Phone covers,Crafts,061 555 0279,50') | Set-Content $csv -Encoding Ascii   # no byte-order mark: Access would read it into the first field's name
}
