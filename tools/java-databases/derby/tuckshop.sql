-- Makes the tuck shop's table and fills it.
CREATE TABLE tblProducts (ProductName VARCHAR(30) PRIMARY KEY, Price DOUBLE, Stock INTEGER);
INSERT INTO tblProducts VALUES ('Samoosa', 12.50, 37), ('Vetkoek', 15.00, 25), ('Pie', 18.50, 12), ('Cooldrink', 12.00, 40);
INSERT INTO tblProducts VALUES ('Chips', 10.00, 6), ('Muffin', 9.50, 4), ('Sweets', 3.00, 80), ('Juice', 14.00, 9);
