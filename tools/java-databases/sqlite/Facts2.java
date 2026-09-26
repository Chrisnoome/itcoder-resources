import java.sql.*;
public class Facts2 {
  public static void main(String[] args) throws Exception {
    Connection shop = DriverManager.getConnection("jdbc:sqlite:TuckShop.db");
    try {
      ResultSet results = shop.createStatement().executeQuery("SELECT Price, Stock, ProductName FROM tblProducts WHERE ProductName = 'Samoosa'");
      results.next();
      System.out.println("price double " + results.getDouble("Price") + " string " + results.getString("Price") + " stock string " + results.getString("Stock") + " getInt on price " + results.getInt("Price") + " getInt on name " + results.getInt("ProductName"));
      System.out.println("column 1 " + results.getDouble(1));
      System.out.println("missing column: " + results.getString("Prce"));
    } catch (SQLException error) { System.out.println("types: " + error.getMessage()); }
    shop.close();
    try { shop.createStatement(); } catch (SQLException error) { System.out.println("closed: " + error.getMessage()); }
    Connection c2 = DriverManager.getConnection("jdbc:sqlite:TuckShop.db");
    PreparedStatement statement = c2.prepareStatement("SELECT ProductName, Price FROM tblProducts ORDER BY ProductName");
    ResultSet results = statement.executeQuery();
    while (results.next()) { System.out.println(results.getString("ProductName") + " R" + results.getDouble("Price")); }
    results.close(); statement.close(); c2.close();
    System.out.println(String.format("%.2f", 12.5));
  }
}
