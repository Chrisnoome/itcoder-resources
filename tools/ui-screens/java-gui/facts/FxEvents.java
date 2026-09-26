import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.Scene;
import javafx.scene.control.Label;
import javafx.stage.Modality;
import javafx.stage.Stage;
import javafx.stage.WindowEvent;

public class FxEvents extends Application {
  static void log(String aText) { System.out.println(aText); }
  @Override
  public void start(Stage aStage) {
    aStage.setScene(new Scene(new Label("main"), 300, 200));
    aStage.show();
    Stage details = new Stage();
    details.initOwner(aStage);
    details.initModality(Modality.APPLICATION_MODAL);
    details.setScene(new Scene(new Label("details"), 200, 120));
    details.setOnShowing(event -> log("onShowing"));
    details.setOnShown(event -> log("onShown"));
    details.setOnCloseRequest(event -> log("onCloseRequest"));
    details.setOnHiding(event -> log("onHiding"));
    details.setOnHidden(event -> log("onHidden"));
    log("stage made");
    new Thread(() -> {
      try {
        for (int time = 1; time <= 2; time++) {
          log("--- showAndWait " + time);
          Platform.runLater(() -> { details.showAndWait(); log("showAndWait came back"); });
          Thread.sleep(1000);
          if (time == 1) {
            log("--- X clicked (WINDOW_CLOSE_REQUEST)");
            Platform.runLater(() -> details.fireEvent(new WindowEvent(details, WindowEvent.WINDOW_CLOSE_REQUEST)));
          } else {
            log("--- close() in code");
            Platform.runLater(() -> details.close());
          }
          Thread.sleep(800);
          log("   showing now: " + details.isShowing());
        }
      } catch (Exception e) { e.printStackTrace(); }
      Platform.exit();
    }).start();
  }
  public static void main(String[] args) { launch(args); }
}
