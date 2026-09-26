import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.control.Button;
import javafx.scene.control.RadioButton;
import javafx.scene.control.Spinner;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

// Drives lesson 24's MainApp (JavaFX) and takes its three pictures.
public class ShotsBookingFx extends Application {
  @Override
  public void start(Stage aStage) {
    MainApp app = new MainApp();
    app.start(aStage);
    new Thread(() -> run(app, aStage)).start();
  }

  @SuppressWarnings("unchecked")
  static void run(MainApp app, Stage stage) {
    FxShot.backdrop(stage);
    FxShot.window(stage, "fx-good-empty");
    FxShot.fx(() -> {
      ((TextField) Shot.get(app, "nameField")).setText("Thabo Mokoena");
      ((TextField) Shot.get(app, "cellField")).setText("082 123");
      ((Spinner<Integer>) Shot.get(app, "ticketsSpinner")).getValueFactory().setValue(2);
      ((RadioButton) Shot.get(app, "vipRadio")).fire();
      ((Button) Shot.get(app, "bookButton")).fire();
    });
    FxShot.window(stage, "fx-good-error");
    FxShot.fx(() -> {
      ((TextField) Shot.get(app, "cellField")).setText("0821234567");
      ((Button) Shot.get(app, "bookButton")).fire();
      ((TextField) Shot.get(app, "nameField")).setText("Lebo Dlamini");
      ((TextField) Shot.get(app, "cellField")).setText("0719876543");
      ((Spinner<Integer>) Shot.get(app, "ticketsSpinner")).getValueFactory().setValue(4);
      ((Button) Shot.get(app, "bookButton")).fire();
      ((TextField) Shot.get(app, "nameField")).setText("Pieter van der Merwe");
      ((TextField) Shot.get(app, "cellField")).setText("0835550101");
      ((Button) Shot.get(app, "bookButton")).fire();
    });
    FxShot.window(stage, "fx-good-saved");
    Platform.exit();
    System.exit(0);
  }

  public static void main(String[] args) {
    launch(args);
  }
}
