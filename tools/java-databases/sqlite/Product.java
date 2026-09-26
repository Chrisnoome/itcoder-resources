// One product the tuck shop sells: a row of tblProducts, as an object.
public class Product {
  private String name;
  private double price;
  private int stock;

  // Makes a product.
  // aName  - what it is called
  // aPrice - what one costs, in rand
  // aStock - how many are on the shelf
  public Product(String aName, double aPrice, int aStock) {
    name = aName;
    price = aPrice;
    stock = aStock;
  } // Product

  // Gives back the product's name.
  // Gives back: what it is called
  public String getName() {
    return name;
  } // getName

  // Gives back the price.
  // Gives back: what one costs, in rand
  public double getPrice() {
    return price;
  } // getPrice

  // Gives back the price as text, with an R and two decimals.
  // Gives back: the price to show, like R18.50
  public String getPriceText() {
    return "R" + String.format("%.2f", price);
  } // getPriceText

  // Gives back the stock.
  // Gives back: how many are on the shelf
  public int getStock() {
    return stock;
  } // getStock

  // Describes the product, for a list or a report.
  // Gives back: the product on one line, like Pie - R18.50 (12 left)
  @Override
  public String toString() {
    return name + " - " + getPriceText() + " (" + stock + " left)";
  } // toString
} // class Product
