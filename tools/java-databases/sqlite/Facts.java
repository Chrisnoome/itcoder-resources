import java.sql.*;
import java.io.File;

public class Facts {
  static void tryIt(String aLabel, Connection aConnection, String aSql, boolean aQuery) {
    try {
      Statement statement = aConnection.createStatement();
      if (aQuery) {
        ResultSet results = statement.executeQuery(aSql);
        System.out.println(aLabel + ": ok, first next = " + results.next());
      } else {
        System.out.println(aLabel + ": ok, rows = " + statement.executeUpdate(aSql));
      }
    } catch (SQLException error) {
      System.out.println(aLabel + ": " + error.getClass().getName() + ": " + error.getMessage());
    }
  }

  public static void main(String[] args) throws Exception {
    Connection shop = DriverManager.getConnection("jdbc:sqlite:TuckShop.db");
    System.out.println("autocommit " + shop.getAutoCommit());
    new File("TuckShp.db").delete();
    Connection typo = DriverManager.getConnection("jdbc:sqlite:TuckShp.db");
    tryIt("misspelt file", typo, "SELECT * FROM tblProducts", true);
    System.out.println("TuckShp.db exists afterwards: " + new File("TuckShp.db").exists() + " size " + new File("TuckShp.db").length());
    typo.close();
    String name = "O'Brien's pie";
    tryIt("glued apostrophe", shop, "SELECT * FROM tblProducts WHERE ProductName = '" + name + "'", true);
    tryIt("misspelt column", shop, "SELECT Prce FROM tblProducts", true);
    tryIt("query that changes", shop, "UPDATE tblProducts SET Stock = Stock WHERE ProductName = 'Pie'", true);
    tryIt("update none", shop, "UPDATE tblProducts SET Stock = Stock WHERE ProductName = 'Nothing'", false);
    tryIt("update one", shop, "UPDATE tblProducts SET Stock = Stock WHERE ProductName = 'Pie'", false);
    tryIt("select via update", shop, "SELECT * FROM tblProducts", false);
    tryIt("duplicate key", shop, "INSERT INTO tblProducts VALUES ('Pie', 1, 1)", false);
    try {
      PreparedStatement statement = shop.prepareStatement("SELECT * FROM tblProducts WHERE Stock < ?");
      ResultSet results = statement.executeQuery();
      System.out.println("unbound: ok " + results.next());
    } catch (SQLException error) { System.out.println("unbound: " + error.getMessage()); }
    try {
      PreparedStatement statement = shop.prepareStatement("SELECT ProductName, Stock FROM tblProducts WHERE Stock < ?");
      statement.setInt(1, 10);
      ResultSet results = statement.executeQuery();
      System.out.println("before next: " + results.getString("ProductName"));
    } catch (SQLException error) { System.out.println("before next: " + error.getMessage()); }
    try {
      PreparedStatement statement = shop.prepareStatement("SELECT ProductName, Stock FROM tblProducts WHERE Stock < ?");
      statement.setInt(1, 10);
      ResultSet results = statement.executeQuery();
      while (results.next()) { System.out.println(results.getString("ProductName") + " " + results.getInt("Stock")); }
      System.out.println("after the end: " + results.getString("ProductName"));
    } catch (SQLException error) { System.out.println("after the end: " + error.getMessage()); }
    try {
      PreparedStatement statement = shop.prepareStatement("SELECT ProductName FROM tblProducts WHERE ProductName = ?");
      statement.setString(1, name);
      ResultSet results = statement.executeQuery();
      System.out.println("parameter apostrophe: found = " + results.next());
    } catch (SQLException error) { System.out.println("param: " + error.getMessage()); }
    try {
      PreparedStatement statement = shop.prepareStatement("SELECT ProductName FROM tblProducts WHERE ProductName = ?");
      statement.setString(2, "Pie");
    } catch (SQLException error) { System.out.println("index 2: " + error.getMessage()); }
    try {
      ResultSet results = shop.createStatement().executeQuery("SELECT Price, Stock FROM tblProducts WHERE ProductName = 'Samoosa'");
      results.next();
      System.out.println("price double " + results.getDouble("Price") + " string " + results.getString("Price") + " stock string " + results.getString("Stock") + " getInt on price " + results.getInt("Price"));
      System.out.println("getInt on name: " + shop.createStatement().executeQuery("SELECT ProductName FROM tblProducts").getInt("ProductName"));
    } catch (SQLException error) { System.out.println("types: " + error.getMessage()); }
    shop.close();
    try { shop.createStatement(); } catch (SQLException error) { System.out.println("closed: " + error.getMessage()); }
  }
}
