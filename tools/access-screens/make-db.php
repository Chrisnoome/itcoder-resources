<?php
// Writes work/tuckshop.json: the tuck shop sample's statements in Access form,
// straight from the platform (lib/sql.php), so the pictures show the same data
// as the lessons - and work/access01.json, the same plus lesson B1's
// tblSuppliers with two suppliers. Then run make-db.ps1 in the 32-bit
// PowerShell (-Json access01.json -Out work\Access01.mdb for B1).
require_once 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/lib/sql.php';

$tuckShop = SqlSampleStatements (SqlSample ('tuckshop'), 'access');
file_put_contents (__DIR__ . '/work/tuckshop.json', json_encode ($tuckShop));

// B1's table, as the lesson makes it (content/sql/access01.php, $createSuppliers).
$suppliers = [
    "CREATE TABLE tblSuppliers (SupplierID COUNTER PRIMARY KEY, SupplierName TEXT(40) NOT NULL, ContactNumber TEXT(10), "
  . "City TEXT(20) DEFAULT 'Johannesburg', DaysToDeliver INTEGER DEFAULT 2, Active YESNO DEFAULT True, FirstOrder DATETIME, Notes MEMO)",
    "INSERT INTO tblSuppliers (SupplierName, ContactNumber, FirstOrder) VALUES ('Joburg Bakery', '0821234567', #2026/01/12#)",
    "INSERT INTO tblSuppliers (SupplierName, ContactNumber, City, DaysToDeliver, FirstOrder, Notes) "
  . "VALUES ('Karoo Biltong', '0235551234', 'Beaufort West', 5, #2026/02/03#, 'Delivers on Mondays only')",
];
file_put_contents (__DIR__ . '/work/access01.json', json_encode (array_merge ($tuckShop, $suppliers)));
echo "wrote work/tuckshop.json and work/access01.json\n";
