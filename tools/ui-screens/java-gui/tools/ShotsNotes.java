import javafx.application.Application;
import javafx.application.Platform;
import javafx.stage.Stage;
import javax.swing.UIManager;

// Lesson 24's resizing pictures: NotesForm (Swing) and NotesApp (JavaFX), small and big.
public class ShotsNotes extends Application {
  @Override
  public void start(Stage aStage) {
    new Thread(() -> {
      try {
        UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
      } catch (Exception e) { throw new RuntimeException(e); }
      NotesForm[] form = new NotesForm[1];
      Shot.runOnEdt(() -> { form[0] = new NotesForm(); form[0].setDefaultCloseOperation(javax.swing.JFrame.DISPOSE_ON_CLOSE); });
      Shot.backdrop(new java.awt.Rectangle(form[0].getX() - 150, form[0].getY() - 100, 820, 500));
      Shot.runOnEdt(() -> form[0].setVisible(true));
      Shot.window(form[0], "swing-notes-small");
      Shot.runOnEdt(() -> { form[0].setSize(760, 420); form[0].setLocationRelativeTo(null); });
      Shot.backdrop(form[0].getBounds());
      Shot.window(form[0], "swing-notes-big");
      Shot.runOnEdt(() -> form[0].dispose());
      Shot.runOnEdt(() -> Shot.back.setVisible(false));

      NotesApp app = new NotesApp();
      FxShot.fx(() -> { app.start(aStage); aStage.centerOnScreen(); });
      FxShot.backdrop(aStage);
      FxShot.window(aStage, "fx-notes-small");
      FxShot.fx(() -> { aStage.setWidth(760); aStage.setHeight(420); aStage.centerOnScreen(); });
      FxShot.backdrop(aStage);
      FxShot.window(aStage, "fx-notes-big");
      Platform.exit();
      System.exit(0);
    }).start();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
