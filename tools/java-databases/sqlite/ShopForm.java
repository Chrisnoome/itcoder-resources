import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.sql.SQLException;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSpinner;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.ListSelectionModel;
import javax.swing.SpinnerNumberModel;
import javax.swing.UIManager;
import javax.swing.table.DefaultTableModel;

// The tuck shop's stock window. It shows products in a table and changes them
// only through ProductsDB - there is no SQL in this class.
public class ShopForm extends JFrame {
  public static final String DATABASE_FILE = "TuckShop.db";
  private static final Color NAVY = new Color(31, 58, 95);
  private static final Color GREEN = new Color(0, 128, 0);
  private static final Color RED = new Color(192, 0, 0);

  private ProductsDB shop;
  private DefaultTableModel productsModel;
  private JTable productsTable;
  private JButton showAllButton;
  private JSpinner limitSpinner;
  private JButton lowStockButton;
  private JButton sellButton;
  private JButton deleteButton;
  private JButton valueButton;
  private JTextField nameField;
  private JSpinner priceSpinner;
  private JSpinner stockSpinner;
  private JButton addButton;
  private JLabel messageLabel;

  // Builds the window, opens the database and shows every product.
  public ShopForm() {
    setTitle("Tuck shop - stock");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    add(makeTitleBar(), BorderLayout.NORTH);

    // The middle: the table, with the buttons down its right side
    productsModel = new DefaultTableModel(new String[] {"Product", "Price", "Stock"}, 0);
    productsTable = new JTable(productsModel);
    productsTable.setDefaultEditor(Object.class, null);   // the table only shows; the buttons change things
    productsTable.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
    JScrollPane tableScroll = new JScrollPane(productsTable);
    tableScroll.setPreferredSize(new Dimension(320, 200));
    JPanel middle = new JPanel(new BorderLayout(8, 0));
    middle.setBorder(BorderFactory.createEmptyBorder(8, 8, 0, 8));
    middle.add(tableScroll, BorderLayout.CENTER);
    middle.add(makeButtons(), BorderLayout.EAST);
    add(middle, BorderLayout.CENTER);
    add(makeNewProductGroup(), BorderLayout.SOUTH);
    getRootPane().setDefaultButton(addButton);

    try {
      shop = new ProductsDB(DATABASE_FILE);
      showAllClicked();
    } // try
    catch (SQLException error) {
      showMessageLine("Could not open " + DATABASE_FILE + ": " + error.getMessage(), RED);
    } // catch
    pack();
    setLocationRelativeTo(null);
  } // ShopForm

  // Makes the navy bar across the top of the window.
  // Gives back: the bar, with its title
  private JPanel makeTitleBar() {
    JPanel titleBar = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 8));
    titleBar.setBackground(NAVY);
    JLabel titleLabel = new JLabel("Tuck shop stock");
    titleLabel.setForeground(Color.WHITE);
    titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 16));
    titleBar.add(titleLabel);
    return titleBar;
  } // makeTitleBar

  // Makes the column of buttons beside the table.
  // Gives back: the column
  private JPanel makeButtons() {
    showAllButton = new JButton("Show all");
    showAllButton.addActionListener(event -> showAllClicked());
    limitSpinner = new JSpinner(new SpinnerNumberModel(10, 1, 999, 1));
    JPanel limitRow = new JPanel(new FlowLayout(FlowLayout.LEFT, 4, 0));
    limitRow.add(new JLabel("Stock below"));
    limitRow.add(limitSpinner);
    lowStockButton = new JButton("Show low stock");
    lowStockButton.addActionListener(event -> lowStockClicked());
    sellButton = new JButton("Sell one");
    sellButton.addActionListener(event -> sellClicked());
    deleteButton = new JButton("Delete...");
    deleteButton.addActionListener(event -> deleteClicked());
    valueButton = new JButton("Stock value");
    valueButton.addActionListener(event -> valueClicked());
    JPanel column = new JPanel(new GridLayout(0, 1, 0, 8));
    column.add(showAllButton);
    column.add(limitRow);
    column.add(lowStockButton);
    column.add(sellButton);
    column.add(deleteButton);
    column.add(valueButton);
    JPanel side = new JPanel(new BorderLayout());
    side.add(column, BorderLayout.NORTH);
    return side;
  } // makeButtons

  // Makes the New product group along the bottom, with the message line under it.
  // Gives back: the group
  private JPanel makeNewProductGroup() {
    nameField = new JTextField(12);
    priceSpinner = new JSpinner(new SpinnerNumberModel(10.0, 0.5, 500.0, 0.5));
    stockSpinner = new JSpinner(new SpinnerNumberModel(20, 0, 999, 1));
    addButton = new JButton("Add");
    addButton.addActionListener(event -> addClicked());
    JPanel row = new JPanel(new FlowLayout(FlowLayout.LEFT, 6, 4));
    row.add(new JLabel("Name"));
    row.add(nameField);
    row.add(new JLabel("Price"));
    row.add(priceSpinner);
    row.add(new JLabel("Stock"));
    row.add(stockSpinner);
    row.add(addButton);
    row.setBorder(BorderFactory.createTitledBorder("New product"));
    messageLabel = new JLabel(" ");
    messageLabel.setBorder(BorderFactory.createEmptyBorder(4, 4, 0, 0));
    JPanel bottom = new JPanel(new BorderLayout());
    bottom.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
    bottom.add(row, BorderLayout.CENTER);
    bottom.add(messageLabel, BorderLayout.SOUTH);
    return bottom;
  } // makeNewProductGroup

  // Shows products in the table, one row each, in place of what it showed before.
  // aProducts - the products to show
  private void fillTable(Product[] aProducts) {
    productsModel.setRowCount(0);
    for (int index = 0; index < aProducts.length; index++) {
      Object[] row = {aProducts[index].getName(), aProducts[index].getPriceText(), aProducts[index].getStock()};
      productsModel.addRow(row);
    } // for
  } // fillTable

  // Finds the product in the row that is chosen in the table.
  // Gives back: its name, or "" if no row is chosen
  private String selectedName() {
    String name = "";
    int row = productsTable.getSelectedRow();
    if (row != -1) {
      name = (String) productsModel.getValueAt(row, 0);
    } // if
    return name;
  } // selectedName

  // Writes a message under the New product group, in a colour.
  // aMessage - the words to show
  // aColour  - RED for a problem, GREEN for good news, NAVY for an answer
  private void showMessageLine(String aMessage, Color aColour) {
    messageLabel.setForeground(aColour);
    messageLabel.setText(aMessage);
  } // showMessageLine

  // Shows every product, A to Z.
  private void showAllClicked() {
    try {
      fillTable(shop.getAllProducts());
    } // try
    catch (SQLException error) {
      showMessageLine("The database said: " + error.getMessage(), RED);
    } // catch
  } // showAllClicked

  // Shows only the products with less stock than the number in the spinner.
  private void lowStockClicked() {
    try {
      Product[] low = shop.getLowStock((int) limitSpinner.getValue());
      fillTable(low);
      showMessageLine(low.length + " products have fewer than " + limitSpinner.getValue() + " left.", NAVY);
    } // try
    catch (SQLException error) {
      showMessageLine("The database said: " + error.getMessage(), RED);
    } // catch
  } // lowStockClicked

  // Sells one of the chosen product.
  private void sellClicked() {
    String name = selectedName();
    if (name.equals("")) {
      showMessageLine("Click a product in the table first.", RED);
    } // if
    else {
      try {
        if (shop.sellOne(name)) {
          showMessageLine("Sold one " + name + ".", GREEN);
        } // if
        else {
          showMessageLine("There are no " + name + " left to sell.", RED);
        } // else
        showAllClicked();
      } // try
      catch (SQLException error) {
        showMessageLine("The database said: " + error.getMessage(), RED);
      } // catch
    } // else
  } // sellClicked

  // Deletes the chosen product, once the user has said yes.
  private void deleteClicked() {
    String name = selectedName();
    if (name.equals("")) {
      showMessageLine("Click a product in the table first.", RED);
    } // if
    else {
      int answer = JOptionPane.showConfirmDialog(this, "Delete " + name + " for good?", "Delete a product",
                                                 JOptionPane.YES_NO_OPTION);
      if (answer == JOptionPane.YES_OPTION) {
        try {
          shop.deleteProduct(name);
          showMessageLine(name + " was deleted.", GREEN);
          showAllClicked();
        } // try
        catch (SQLException error) {
          showMessageLine("The database said: " + error.getMessage(), RED);
        } // catch
      } // if
    } // else
  } // deleteClicked

  // Says what everything on the shelves is worth.
  private void valueClicked() {
    try {
      showMessageLine("Everything on the shelves is worth R" + String.format("%.2f", shop.getStockValue()) + ".", NAVY);
    } // try
    catch (SQLException error) {
      showMessageLine("The database said: " + error.getMessage(), RED);
    } // catch
  } // valueClicked

  // Adds the product typed in the New product group.
  private void addClicked() {
    String name = nameField.getText().trim();
    if (name.equals("")) {
      showMessageLine("Type the new product's name first.", RED);
      nameField.requestFocus();
    } // if
    else {
      try {
        shop.addProduct(new Product(name, (double) priceSpinner.getValue(), (int) stockSpinner.getValue()));
        showMessageLine(name + " was added.", GREEN);
        nameField.setText("");
        showAllClicked();
      } // try
      catch (SQLException error) {
        showMessageLine("Could not add " + name + " - is there a product with that name already?", RED);
      } // catch
    } // else
  } // addClicked

  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } // try
    catch (Exception error) {
      System.out.println("Using Java's own look instead.");
    } // catch
    ShopForm form = new ShopForm();
    form.setVisible(true);
  } // main
} // class ShopForm
