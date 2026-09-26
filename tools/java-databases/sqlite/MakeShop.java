import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

// Makes TuckShop.db with one table, tblProducts, and eight products. Run it once.
public class MakeShop {
  public static void main(String[] args) {
    try {
      Connection connection = DriverManager.getConnection("jdbc:sqlite:TuckShop.db");
      Statement statement = connection.createStatement();
      statement.executeUpdate("DROP TABLE IF EXISTS tblProducts");
      statement.executeUpdate("CREATE TABLE tblProducts (ProductName TEXT PRIMARY KEY, Price REAL, Stock INTEGER)");
      statement.executeUpdate("INSERT INTO tblProducts VALUES ('Samoosa', 12.50, 37), ('Vetkoek', 15.00, 25), "
                              + "('Pie', 18.50, 12), ('Cooldrink', 12.00, 40), ('Chips', 10.00, 6), "
                              + "('Muffin', 9.50, 4), ('Sweets', 3.00, 80), ('Juice', 14.00, 9)");
      statement.close();
      connection.close();
      System.out.println("TuckShop.db is ready.");
    } // try
    catch (SQLException error) {
      System.out.println("Could not make the database: " + error.getMessage());
    } // catch
  } // main
} // class MakeShop
