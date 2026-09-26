import javafx.application.Application;
import javafx.application.Platform;
import javafx.stage.Stage;

// Proves JavaFX starts, without opening a window.
public class FxCheck extends Application {
  @Override
  public void start(Stage aStage) {
    System.out.println("JavaFX " + System.getProperty("javafx.runtime.version") + " started.");
    Platform.exit();
  } // start

  public static void main(String[] args) {
    launch(args);
  } // main
} // class FxCheck
