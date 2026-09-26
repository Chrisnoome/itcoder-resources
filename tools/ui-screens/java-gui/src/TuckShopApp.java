import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.scene.layout.VBox;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

// A window whose title is in FreeSerif - a font the program brings with it
// and loads for itself, in JavaFX. Nothing is installed on the computer.
public class TuckShopApp extends Application {
  private Label titleLabel;
  private Label messageLabel;

  // Builds the window: the title in the loaded font, and a message saying what happened.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    titleLabel = new Label("Tuck shop specials");
    messageLabel = new Label();
    Font titleFont = Font.loadFont("file:FreeSerif.ttf", 28);
    if (titleFont == null) {
      titleFont = Font.font("Segoe UI", FontWeight.BOLD, 28);
      messageLabel.setText("FreeSerif.ttf is missing - using Segoe UI instead.");
    } // if
    else {
      messageLabel.setText("FreeSerif.ttf was loaded for this program only.");
    } // else
    titleLabel.setFont(titleFont);
    VBox page = new VBox(12, titleLabel, messageLabel);
    page.setPadding(new Insets(16, 20, 16, 20));
    aStage.setScene(new Scene(page));
    aStage.setTitle("Tuck shop");
    aStage.show();
  } // start

  public static void main(String[] args) {
    launch(args);
  } // main
} // class TuckShopApp
