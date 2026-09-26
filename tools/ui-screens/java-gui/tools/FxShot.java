import java.awt.Rectangle;
import java.util.concurrent.CountDownLatch;
import javafx.application.Platform;
import javafx.stage.Stage;
import javafx.stage.StageStyle;
import javafx.stage.Window;
import javafx.scene.Scene;
import javafx.scene.layout.Pane;

// JavaFX side of the screenshot kit: run a job on the FX thread and wait,
// put a white backdrop behind a stage, and capture exactly the window (the
// title bar and the scene, one pixel of frame round it) with java.awt.Robot.
public class FxShot {
  static Stage back;

  static void fx(Runnable aJob) {
    if (Platform.isFxApplicationThread()) { aJob.run(); return; }
    CountDownLatch done = new CountDownLatch(1);
    Platform.runLater(() -> { try { aJob.run(); } finally { done.countDown(); } });
    try { done.await(); } catch (InterruptedException e) { }
  }

  // A white stage behind this one; then this one is shown again, so it is on top and active.
  static void backdrop(Stage aStage) {
    Shot.pause(300);
    fx(() -> {
      if (back == null) {
        back = new Stage(StageStyle.UNDECORATED);
        Pane white = new Pane();
        white.setStyle("-fx-background-color: white;");
        back.setScene(new Scene(white));
      }
      back.setX(aStage.getX() - 60);
      back.setY(aStage.getY() - 60);
      back.setWidth(aStage.getWidth() + 120);
      back.setHeight(aStage.getHeight() + 120);
      back.setAlwaysOnTop(true);
      back.show();
      aStage.setAlwaysOnTop(true);
      aStage.toFront();
      aStage.requestFocus();
    });
  }

  // Puts a stage on top, in front, and asks for the focus. No mouse clicks.
  static void activate(Window aWindow) {
    fx(() -> {
      if (aWindow instanceof Stage) { ((Stage) aWindow).setAlwaysOnTop(true); ((Stage) aWindow).toFront(); }
      aWindow.requestFocus();
    });
    Shot.pause(400);
  }

  // The window's own area on the screen: the title bar down to the bottom of the scene.
  static Rectangle area(Window aWindow) {
    Rectangle[] box = new Rectangle[1];
    fx(() -> {
      Scene scene = aWindow.getScene();
      double left = aWindow.getX() + scene.getX();
      double top = aWindow.getY();
      double bottom = aWindow.getY() + scene.getY() + scene.getHeight();
      boolean framed = !(aWindow instanceof Stage) || ((Stage) aWindow).getStyle() == StageStyle.DECORATED;
      int edge = framed ? 1 : 0;
      if (!framed) { top = aWindow.getY() + scene.getY(); }
      box[0] = new Rectangle((int) Math.round(left) - edge, (int) Math.round(top), (int) Math.round(scene.getWidth()) + 2 * edge,
                             (int) Math.round(bottom - top) + edge);
    });
    return box[0];
  }

  static void window(Window aWindow, String aName) {
    Shot.pause(600);
    activate(aWindow);
    Shot.pause(300);
    Shot.capturePlain(area(aWindow), aName);
    java.awt.image.BufferedImage[] own = new java.awt.image.BufferedImage[1];
    int[] where = new int[2];
    fx(() -> {
      Scene scene = aWindow.getScene();
      javafx.scene.image.WritableImage picture = scene.snapshot(null);
      javafx.scene.image.PixelReader reader = picture.getPixelReader();
      int width = (int) picture.getWidth();
      int height = (int) picture.getHeight();
      own[0] = new java.awt.image.BufferedImage(width, height, java.awt.image.BufferedImage.TYPE_INT_RGB);
      for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) { own[0].setRGB(x, y, reader.getArgb(x, y)); }
      }
      where[0] = (int) Math.round(aWindow.getX() + scene.getX());
      where[1] = (int) Math.round(aWindow.getY() + scene.getY());
    });
    Shot.check(own[0], where[0], where[1]);
  }
}
