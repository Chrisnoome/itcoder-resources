import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

// Everything the tuck shop program does with its database. No other class
// sees any SQL: they call these methods and get Products back.
public class ProductsDB {
  public static final int MAX_PRODUCTS = 200;
  private Connection connection;

  // Opens the database file, in the folder the program is started from.
  // aFileName - the database file, like TuckShop.db
  public ProductsDB(String aFileName) throws SQLException {
    connection = DriverManager.getConnection("jdbc:sqlite:" + aFileName);
  } // ProductsDB

  // Every product, A to Z.
  // Gives back: the products, in an array exactly as long as the answer
  public Product[] getAllProducts() throws SQLException {
    PreparedStatement statement = connection.prepareStatement(
        "SELECT ProductName, Price, Stock FROM tblProducts ORDER BY ProductName");
    Product[] found = readProducts(statement);
    statement.close();
    return found;
  } // getAllProducts

  // The products with fewer than a number on the shelf, fewest first.
  // aLimit - the stock level to look below
  // Gives back: those products, in an array exactly as long as the answer
  public Product[] getLowStock(int aLimit) throws SQLException {
    PreparedStatement statement = connection.prepareStatement(
        "SELECT ProductName, Price, Stock FROM tblProducts WHERE Stock < ? ORDER BY Stock");
    statement.setInt(1, aLimit);
    Product[] found = readProducts(statement);
    statement.close();
    return found;
  } // getLowStock

  // Runs a SELECT of ProductName, Price and Stock, and makes a Product of each row.
  // aStatement - the SELECT to run, with its parameters already set
  // Gives back: the products, in an array exactly as long as the answer
  private Product[] readProducts(PreparedStatement aStatement) throws SQLException {
    Product[] all = new Product[MAX_PRODUCTS];
    int count = 0;
    ResultSet results = aStatement.executeQuery();
    while (count < MAX_PRODUCTS && results.next()) {
      all[count] = new Product(results.getString("ProductName"), results.getDouble("Price"), results.getInt("Stock"));
      count++;
    } // while
    results.close();
    Product[] found = new Product[count];
    for (int index = 0; index < count; index++) {
      found[index] = all[index];
    } // for
    return found;
  } // readProducts

  // Adds a new product to the table.
  // aProduct - the product to add; its name must not be in the table yet
  public void addProduct(Product aProduct) throws SQLException {
    PreparedStatement statement = connection.prepareStatement(
        "INSERT INTO tblProducts (ProductName, Price, Stock) VALUES (?, ?, ?)");
    statement.setString(1, aProduct.getName());
    statement.setDouble(2, aProduct.getPrice());
    statement.setInt(3, aProduct.getStock());
    statement.executeUpdate();
    statement.close();
  } // addProduct

  // Sells one of a product: its stock goes down by one, if there are any left.
  // aName - the product's name
  // Gives back: true if one was sold, false if there were none left
  public boolean sellOne(String aName) throws SQLException {
    PreparedStatement statement = connection.prepareStatement(
        "UPDATE tblProducts SET Stock = Stock - 1 WHERE ProductName = ? AND Stock > 0");
    statement.setString(1, aName);
    int changed = statement.executeUpdate();
    statement.close();
    return changed == 1;
  } // sellOne

  // Removes a product from the table.
  // aName - the product's name
  public void deleteProduct(String aName) throws SQLException {
    PreparedStatement statement = connection.prepareStatement("DELETE FROM tblProducts WHERE ProductName = ?");
    statement.setString(1, aName);
    statement.executeUpdate();
    statement.close();
  } // deleteProduct

  // Works out what everything on the shelves is worth.
  // Gives back: the total of price times stock, for every product
  public double getStockValue() throws SQLException {
    double total = 0;
    PreparedStatement statement = connection.prepareStatement("SELECT Price, Stock FROM tblProducts");
    ResultSet results = statement.executeQuery();
    while (results.next()) {
      total = total + results.getDouble("Price") * results.getInt("Stock");
    } // while
    results.close();
    statement.close();
    return total;
  } // getStockValue

  // Closes the database. Call it once, when the program ends.
  public void close() throws SQLException {
    connection.close();
  } // close
} // class ProductsDB
