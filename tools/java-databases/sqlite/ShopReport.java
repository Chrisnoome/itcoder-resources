import java.sql.SQLException;

// A text report of the tuck shop's stock, straight from TuckShop.db.
public class ShopReport {
  public static void main(String[] args) {
    try {
      ProductsDB shop = new ProductsDB("TuckShop.db");
      Product[] low = shop.getLowStock(10);
      System.out.println("Order more of these (" + low.length + "):");
      for (int index = 0; index < low.length; index++) {
        System.out.println("  " + low[index]);
      } // for
      System.out.println("Everything on the shelves is worth R" + String.format("%.2f", shop.getStockValue()));
      shop.close();
    } // try
    catch (SQLException error) {
      System.out.println("The database said: " + error.getMessage());
    } // catch
  } // main
} // class ShopReport
