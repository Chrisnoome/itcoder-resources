import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

// Runs ShopApp's handlers against Java DB and prints what the window shows - no screen capture.
public class FxDerbyCheck extends Application {
  @Override
  @SuppressWarnings("unchecked")
  public void start(Stage aStage) {
    ShopApp app = new ShopApp();
    app.start(aStage);
    TableView<Product> table = (TableView<Product>) Shot.get(app, "productsTable");
    Label message = (Label) Shot.get(app, "messageLabel");
    System.out.println("rows " + table.getItems().size() + ", first " + table.getItems().get(0));
    Shot.call(app, "valueClicked");
    System.out.println("value: " + message.getText());
    Shot.call(app, "lowStockClicked");
    System.out.println("low: " + table.getItems().size() + " rows - " + message.getText());
    Shot.call(app, "showAllClicked");
    for (int row = 0; row < table.getItems().size(); row++) {
      if (table.getItems().get(row).getName().equals("Pie")) { table.getSelectionModel().select(row); }
    }
    Shot.call(app, "sellClicked");
    System.out.println("sell: " + message.getText() + " - pie now " + table.getItems().get(4));
    Platform.exit();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
