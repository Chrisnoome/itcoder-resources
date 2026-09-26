import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Node;
import javafx.scene.Parent;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import javafx.stage.Window;

// Drives lesson 24's three-window booking program in JavaFX (src2fx) and takes its pictures.
public class ShotsFormsFx extends Application {
  static Stage find(String aTitle) {
    for (int attempt = 0; attempt < 50; attempt++) {
      Stage[] found = new Stage[1];
      FxShot.fx(() -> {
        for (Window window : Window.getWindows()) {
          if (window instanceof Stage && window.isShowing() && aTitle.equals(((Stage) window).getTitle())) { found[0] = (Stage) window; }
        }
      });
      if (found[0] != null) { return found[0]; }
      Shot.pause(100);
    }
    throw new RuntimeException("no stage " + aTitle);
  }

  static Node child(Parent aParent, Class<?> aType, String aText) {
    for (Node node : aParent.getChildrenUnmodifiable()) {
      if (aType.isInstance(node) && (aText == null || (node instanceof Button && aText.equals(((Button) node).getText())))) { return node; }
      if (node instanceof Parent) {
        Node found = child((Parent) node, aType, aText);
        if (found != null) { return found; }
      }
    }
    return null;
  }

  static void titles() {
    FxShot.fx(() -> {
      for (Window window : Window.getWindows()) {
        if (window instanceof Stage) { System.out.println("  open: " + ((Stage) window).getTitle() + " showing=" + window.isShowing()); }
      }
    });
  }

  @Override
  public void start(Stage aStage) {
    MainApp app = new MainApp();
    app.start(aStage);
    new Thread(() -> {
      FxShot.fx(() -> ((ListView<?>) Shot.get(app, "bookingsList")).getSelectionModel().select(0));
      FxShot.backdrop(aStage);
      FxShot.window(aStage, "fx-forms-main");

      Platform.runLater(() -> Shot.call(app, "detailsClicked"));
      Stage details = find("Booking details");
      FxShot.window(details, "fx-forms-details");
      FxShot.fx(() -> details.hide());
      Shot.pause(300);

      Platform.runLater(() -> Shot.call(app, "seatsClicked"));
      Stage seats = find("Seating plan");
      FxShot.fx(() -> {
        for (String seat : new String[] {"A6", "B4", "B5"}) { ((Button) child(seats.getScene().getRoot(), Button.class, seat)).fire(); }
        ((Button) child(seats.getScene().getRoot(), Button.class, "Start the spotlight")).fire();
      });
      FxShot.backdrop(seats);
      Shot.pause(1600);
      FxShot.window(seats, "fx-forms-seats");
      FxShot.fx(() -> seats.hide());

      Platform.runLater(() -> Shot.call(app, "findClicked"));
      Stage input = find("Find a booking");
      FxShot.fx(() -> ((TextField) child(input.getScene().getRoot(), TextField.class, null)).setText("lebo dlamini"));
      FxShot.window(input, "fx-forms-inputbox");
      FxShot.fx(() -> ((Button) child(input.getScene().getRoot(), Button.class, "OK")).fire());
      Stage message = find("Message");
      FxShot.window(message, "fx-forms-message");
      titles();
      Platform.exit();
      System.exit(0);
    }).start();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
