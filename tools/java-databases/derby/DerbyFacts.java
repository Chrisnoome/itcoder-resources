import java.sql.*;
import java.io.File;

public class DerbyFacts {
  static void run(String aLabel, Connection aConnection, String aSql) {
    try {
      Statement statement = aConnection.createStatement();
      if (aSql.trim().toUpperCase().startsWith("SELECT")) {
        ResultSet results = statement.executeQuery(aSql);
        String shown = "";
        int rows = 0;
        while (results.next()) { rows++; if (rows <= 3) { shown += results.getString(1) + " "; } }
        System.out.println(aLabel + ": ok, " + rows + " rows: " + shown);
      } else {
        System.out.println(aLabel + ": ok, " + statement.executeUpdate(aSql));
      }
    } catch (SQLException error) {
      System.out.println(aLabel + ": " + error.getClass().getName() + " [" + error.getSQLState() + "] " + error.getMessage());
    }
  }

  public static void main(String[] args) throws Exception {
    try { DriverManager.getConnection("jdbc:derby:NoSuchDB"); } catch (SQLException error) { System.out.println("no create: [" + error.getSQLState() + "] " + error.getMessage()); }
    Connection db = DriverManager.getConnection("jdbc:derby:TuckShopDB;create=true");
    System.out.println("autocommit " + db.getAutoCommit());
    run("drop missing", db, "DROP TABLE tblProducts");
    run("drop if exists", db, "DROP TABLE IF EXISTS tblProducts");
    run("create text", db, "CREATE TABLE tblProducts (ProductName TEXT PRIMARY KEY, Price REAL, Stock INTEGER)");
    run("create", db, "CREATE TABLE tblProducts (ProductName VARCHAR(30) PRIMARY KEY, Price DOUBLE, Stock INTEGER)");
    run("create again", db, "CREATE TABLE tblProducts (ProductName VARCHAR(30) PRIMARY KEY, Price DOUBLE, Stock INTEGER)");
    run("multi insert", db, "INSERT INTO tblProducts VALUES ('Samoosa', 12.50, 37), ('Vetkoek', 15.00, 25), ('Pie', 18.50, 12), ('Cooldrink', 12.00, 40), ('Chips', 10.00, 6), ('Muffin', 9.50, 4), ('Sweets', 3.00, 80), ('Juice', 14.00, 9)");
    run("double quotes", db, "SELECT * FROM tblProducts WHERE ProductName = \"Pie\"");
    run("limit", db, "SELECT ProductName FROM tblProducts ORDER BY Stock LIMIT 3");
    run("fetch first", db, "SELECT ProductName FROM tblProducts ORDER BY Stock FETCH FIRST 3 ROWS ONLY");
    run("lower =", db, "SELECT ProductName FROM tblProducts WHERE ProductName = 'pie'");
    run("like lower", db, "SELECT ProductName FROM tblProducts WHERE ProductName LIKE 'p%'");
    run("upper like", db, "SELECT ProductName FROM tblProducts WHERE UPPER(ProductName) LIKE UPPER('p%')");
    run("missing table", db, "SELECT * FROM tblProduct");
    run("missing column", db, "SELECT Prce FROM tblProducts");
    run("glued apostrophe", db, "SELECT * FROM tblProducts WHERE ProductName = 'O'Brien's pie'");
    run("duplicate", db, "INSERT INTO tblProducts VALUES ('Pie', 1, 1)");
    run("division", db, "SELECT 120 / 100 FROM tblProducts FETCH FIRST 1 ROWS ONLY");
    run("sum", db, "SELECT SUM(Price * Stock) FROM tblProducts");
    ResultSet r = db.createStatement().executeQuery("SELECT Price, Stock FROM tblProducts WHERE ProductName = 'Samoosa'");
    r.next();
    System.out.println("price " + r.getDouble("Price") + " string " + r.getString("PRICE") + " lower name ok " + r.getInt("stock"));
    try {
      ResultSet r2 = db.createStatement().executeQuery("SELECT ProductName FROM tblProducts");
      System.out.println("before next: " + r2.getString("ProductName"));
    } catch (SQLException error) { System.out.println("before next: [" + error.getSQLState() + "] " + error.getMessage()); }
    try {
      PreparedStatement p = db.prepareStatement("SELECT * FROM tblProducts WHERE Stock < ?");
      ResultSet r3 = p.executeQuery();
      System.out.println("unbound ok " + r3.next());
    } catch (SQLException error) { System.out.println("unbound: [" + error.getSQLState() + "] " + error.getMessage()); }
    try {
      PreparedStatement p = db.prepareStatement("UPDATE tblProducts SET Stock = Stock WHERE ProductName = 'Pie'");
      p.executeQuery();
    } catch (SQLException error) { System.out.println("update as query: [" + error.getSQLState() + "] " + error.getMessage()); }
    db.close();
    try { DriverManager.getConnection("jdbc:derby:;shutdown=true"); } catch (SQLException error) { System.out.println("shutdown: [" + error.getSQLState() + "] " + error.getMessage()); }
    File folder = new File("TuckShopDB");
    System.out.println("folder: " + folder.isDirectory() + " " + String.join(" ", folder.list()));
    System.out.println("derby.log: " + new File("derby.log").exists());
  }
}
