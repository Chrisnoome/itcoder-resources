import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

// Makes the Java DB database TuckShopDB with one table, tblProducts, and
// eight products. Run it again to start fresh.
public class MakeShopDB {
  public static void main(String[] args) {
    try {
      Connection connection = DriverManager.getConnection("jdbc:derby:TuckShopDB;create=true");
      Statement statement = connection.createStatement();

      // Throw away the old table, if there is one - Java DB has no DROP TABLE IF EXISTS
      try {
        statement.executeUpdate("DROP TABLE tblProducts");
      } // try
      catch (SQLException error) {
        System.out.println("There was no old table - making a new one.");
      } // catch

      statement.executeUpdate("CREATE TABLE tblProducts (ProductName VARCHAR(30) PRIMARY KEY, Price DOUBLE, Stock INTEGER)");
      statement.executeUpdate("INSERT INTO tblProducts VALUES ('Samoosa', 12.50, 37), ('Vetkoek', 15.00, 25), "
                              + "('Pie', 18.50, 12), ('Cooldrink', 12.00, 40), ('Chips', 10.00, 6), "
                              + "('Muffin', 9.50, 4), ('Sweets', 3.00, 80), ('Juice', 14.00, 9)");
      statement.close();
      connection.close();
      System.out.println("TuckShopDB is ready.");
    } // try
    catch (SQLException error) {
      System.out.println("Could not make the database: " + error.getMessage());
    } // catch
  } // main
} // class MakeShopDB
