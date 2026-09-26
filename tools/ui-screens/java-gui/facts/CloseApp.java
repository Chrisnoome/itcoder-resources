import javafx.application.Application;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

// Asks before it closes, in JavaFX.
public class CloseApp extends Application {

  // Builds the window.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    aStage.setScene(new Scene(new Label("Bookings")));
    aStage.setOnCloseRequest(event -> closeRequested(event));
    aStage.setOnHidden(event -> System.out.println("hidden"));
  } // start

  // X was clicked: asks first, and cancels the close unless the answer is Yes.
  // aEvent - the close request; consume() cancels it
  private void closeRequested(WindowEvent aEvent) {
    Alert question = new Alert(Alert.AlertType.CONFIRMATION, "Close without saving?", ButtonType.YES, ButtonType.NO);
    if (question.showAndWait().orElse(ButtonType.NO) != ButtonType.YES) {
      aEvent.consume();
    } // if
  } // closeRequested

  public static void main(String[] args) {
    launch(args);
  } // main
} // class CloseApp
