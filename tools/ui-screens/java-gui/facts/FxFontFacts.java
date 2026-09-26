import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.text.Font;
import javafx.stage.Stage;

public class FxFontFacts extends Application {
  @Override
  public void start(Stage aStage) {
    Font missing = Font.font("Agency FB Condensed Pro", 14);
    System.out.println("missing: family=" + missing.getFamily() + " name=" + missing.getName());
    Font there = Font.font("Agency FB", 14);
    System.out.println("installed: family=" + there.getFamily() + " name=" + there.getName());
    Font loaded = Font.loadFont("file:FreeSerif.ttf", 28);
    System.out.println("loaded relative: " + (loaded == null ? "null" : loaded.getFamily() + " " + loaded.getSize()));
    Font none = Font.loadFont("file:NoSuchFont.ttf", 28);
    System.out.println("missing file: " + (none == null ? "null" : none.getFamily()));
    System.out.println("default: " + Font.getDefault().getFamily() + " " + Font.getDefault().getSize());
    Platform.exit();
  }
  public static void main(String[] args) { launch(args); }
}
