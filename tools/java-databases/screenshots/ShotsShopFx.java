import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.control.TableView;
import javafx.stage.Stage;

// Drives lesson 26's ShopApp (JavaFX) and takes its pictures. Run it in a
// folder with a fresh TuckShop.db (MakeShop).
public class ShotsShopFx extends Application {
  @Override
  public void start(Stage aStage) {
    ShopApp app = new ShopApp();
    app.start(aStage);
    new Thread(() -> run(app, aStage)).start();
  }

  @SuppressWarnings("unchecked")
  static void run(ShopApp app, Stage stage) {
    Shot.prefix = "lesson26-";
    FxShot.backdrop(stage);
    FxShot.fx(() -> Shot.call(app, "valueClicked"));
    FxShot.window(stage, "fx-shop-all");
    FxShot.fx(() -> Shot.call(app, "lowStockClicked"));
    FxShot.window(stage, "fx-shop-low");
    FxShot.fx(() -> {
      Shot.call(app, "showAllClicked");
      TableView<Product> table = (TableView<Product>) Shot.get(app, "productsTable");
      for (int row = 0; row < table.getItems().size(); row++) {
        if (table.getItems().get(row).getName().equals("Pie")) { table.getSelectionModel().select(row); }
      }
      Shot.call(app, "sellClicked");
    });
    FxShot.window(stage, "fx-shop-sold");
    Platform.exit();
    System.exit(0);
  }

  public static void main(String[] args) {
    launch(args);
  }
}
