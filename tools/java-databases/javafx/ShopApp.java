import java.sql.SQLException;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.TitledPane;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

// The tuck shop's stock window, in JavaFX. It shows products in a table and
// changes them only through ProductsDB - there is no SQL in this class.
public class ShopApp extends Application {
  public static final String DATABASE_FILE = "TuckShop.db";
  private static final Color NAVY = Color.rgb(31, 58, 95);
  private static final Color GREEN = Color.rgb(0, 128, 0);
  private static final Color RED = Color.rgb(192, 0, 0);

  private ProductsDB shop;
  private TableView<Product> productsTable;
  private Button showAllButton;
  private Spinner<Integer> limitSpinner;
  private Button lowStockButton;
  private Button sellButton;
  private Button deleteButton;
  private Button valueButton;
  private TextField nameField;
  private Spinner<Double> priceSpinner;
  private Spinner<Integer> stockSpinner;
  private Button addButton;
  private Label messageLabel;

  // Builds the window, opens the database and shows every product.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    BorderPane root = new BorderPane();
    root.setTop(makeTitleBar());
    makeTable();
    BorderPane middle = new BorderPane();
    middle.setCenter(productsTable);
    middle.setRight(makeButtons());
    BorderPane.setMargin(productsTable, new Insets(0, 8, 0, 0));
    middle.setPadding(new Insets(8, 8, 0, 8));
    root.setCenter(middle);
    root.setBottom(makeNewProductGroup());

    try {
      shop = new ProductsDB(DATABASE_FILE);
      showAllClicked();
    } // try
    catch (SQLException error) {
      showMessageLine("Could not open " + DATABASE_FILE + ": " + error.getMessage(), RED);
    } // catch
    aStage.setScene(new Scene(root));
    aStage.setTitle("Tuck shop - stock");
    aStage.show();
  } // start

  // Makes the navy bar across the top of the window.
  // Gives back: the bar, with its title
  private HBox makeTitleBar() {
    Label titleLabel = new Label("Tuck shop stock");
    titleLabel.setTextFill(Color.WHITE);
    titleLabel.setFont(Font.font("Segoe UI", FontWeight.BOLD, 16));
    HBox titleBar = new HBox(titleLabel);
    titleBar.setPadding(new Insets(8, 12, 8, 12));
    titleBar.setStyle("-fx-background-color: #1F3A5F;");
    return titleBar;
  } // makeTitleBar

  // Makes the table and its three columns. Each column shows one getter of Product.
  private void makeTable() {
    productsTable = new TableView<Product>();
    TableColumn<Product, String> nameColumn = new TableColumn<Product, String>("Product");
    nameColumn.setCellValueFactory(new PropertyValueFactory<Product, String>("name"));
    TableColumn<Product, String> priceColumn = new TableColumn<Product, String>("Price");
    priceColumn.setCellValueFactory(new PropertyValueFactory<Product, String>("priceText"));
    TableColumn<Product, Integer> stockColumn = new TableColumn<Product, Integer>("Stock");
    stockColumn.setCellValueFactory(new PropertyValueFactory<Product, Integer>("stock"));
    productsTable.getColumns().add(nameColumn);
    productsTable.getColumns().add(priceColumn);
    productsTable.getColumns().add(stockColumn);
    productsTable.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY_FLEX_LAST_COLUMN);
    productsTable.setPrefSize(320, 220);
  } // makeTable

  // Makes the column of buttons beside the table.
  // Gives back: the column
  private VBox makeButtons() {
    showAllButton = new Button("Show all");
    showAllButton.setOnAction(event -> showAllClicked());
    limitSpinner = new Spinner<Integer>(1, 999, 10);
    limitSpinner.setPrefWidth(70);
    HBox limitRow = new HBox(4, new Label("Stock below"), limitSpinner);
    limitRow.setAlignment(Pos.CENTER_LEFT);
    lowStockButton = new Button("Show low stock");
    lowStockButton.setOnAction(event -> lowStockClicked());
    sellButton = new Button("Sell one");
    sellButton.setOnAction(event -> sellClicked());
    deleteButton = new Button("Delete...");
    deleteButton.setOnAction(event -> deleteClicked());
    valueButton = new Button("Stock value");
    valueButton.setOnAction(event -> valueClicked());
    VBox column = new VBox(8, showAllButton, limitRow, lowStockButton, sellButton, deleteButton, valueButton);
    showAllButton.setMaxWidth(Double.MAX_VALUE);
    lowStockButton.setMaxWidth(Double.MAX_VALUE);
    sellButton.setMaxWidth(Double.MAX_VALUE);
    deleteButton.setMaxWidth(Double.MAX_VALUE);
    valueButton.setMaxWidth(Double.MAX_VALUE);
    return column;
  } // makeButtons

  // Makes the New product group along the bottom, with the message line under it.
  // Gives back: the group
  private VBox makeNewProductGroup() {
    nameField = new TextField();
    nameField.setPrefColumnCount(10);
    priceSpinner = new Spinner<Double>(0.5, 500.0, 10.0, 0.5);
    priceSpinner.setPrefWidth(80);
    stockSpinner = new Spinner<Integer>(0, 999, 20);
    stockSpinner.setPrefWidth(70);
    addButton = new Button("Add");
    addButton.setDefaultButton(true);
    addButton.setOnAction(event -> addClicked());
    HBox row = new HBox(6, new Label("Name"), nameField, new Label("Price"), priceSpinner, new Label("Stock"),
                        stockSpinner, addButton);
    row.setAlignment(Pos.CENTER_LEFT);
    TitledPane group = new TitledPane("New product", row);
    group.setCollapsible(false);
    messageLabel = new Label(" ");
    VBox bottom = new VBox(6, group, messageLabel);
    bottom.setPadding(new Insets(8));
    return bottom;
  } // makeNewProductGroup

  // Shows products in the table, one row each, in place of what it showed before.
  // aProducts - the products to show
  private void fillTable(Product[] aProducts) {
    productsTable.getItems().setAll(aProducts);
  } // fillTable

  // Writes a message under the New product group, in a colour.
  // aMessage - the words to show
  // aColour  - RED for a problem, GREEN for good news, NAVY for an answer
  private void showMessageLine(String aMessage, Color aColour) {
    messageLabel.setTextFill(aColour);
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
      Product[] low = shop.getLowStock(limitSpinner.getValue());
      fillTable(low);
      showMessageLine(low.length + " products have fewer than " + limitSpinner.getValue() + " left.", NAVY);
    } // try
    catch (SQLException error) {
      showMessageLine("The database said: " + error.getMessage(), RED);
    } // catch
  } // lowStockClicked

  // Sells one of the chosen product.
  private void sellClicked() {
    Product chosen = productsTable.getSelectionModel().getSelectedItem();
    if (chosen == null) {
      showMessageLine("Click a product in the table first.", RED);
    } // if
    else {
      try {
        if (shop.sellOne(chosen.getName())) {
          showMessageLine("Sold one " + chosen.getName() + ".", GREEN);
        } // if
        else {
          showMessageLine("There are no " + chosen.getName() + " left to sell.", RED);
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
    Product chosen = productsTable.getSelectionModel().getSelectedItem();
    if (chosen == null) {
      showMessageLine("Click a product in the table first.", RED);
    } // if
    else {
      Alert question = new Alert(Alert.AlertType.CONFIRMATION, "Delete " + chosen.getName() + " for good?",
                                 ButtonType.YES, ButtonType.NO);
      if (question.showAndWait().orElse(ButtonType.NO) == ButtonType.YES) {
        try {
          shop.deleteProduct(chosen.getName());
          showMessageLine(chosen.getName() + " was deleted.", GREEN);
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
        shop.addProduct(new Product(name, priceSpinner.getValue(), stockSpinner.getValue()));
        showMessageLine(name + " was added.", GREEN);
        nameField.clear();
        showAllClicked();
      } // try
      catch (SQLException error) {
        showMessageLine("Could not add " + name + " - is there a product with that name already?", RED);
      } // catch
    } // else
  } // addClicked

  public static void main(String[] args) {
    launch(args);
  } // main
} // class ShopApp
