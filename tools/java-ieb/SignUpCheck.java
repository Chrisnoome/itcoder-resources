import java.time.LocalDate;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.stage.Stage;

// Runs SignUpApp's validation with test data and prints the messages - no capture.
public class SignUpCheck extends Application {
  static Object get(Object aApp, String aName) throws Exception {
    Field field = aApp.getClass().getDeclaredField(aName);
    field.setAccessible(true);
    return field.get(aApp);
  }

  static void run(SignUpApp app, String aSurname, String aId, LocalDate aBirth) throws Exception {
    ((TextField) get(app, "surnameField")).setText(aSurname);
    ((TextField) get(app, "idField")).setText(aId);
    ((DatePicker) get(app, "birthPicker")).setValue(aBirth);
    Method validate = SignUpApp.class.getDeclaredMethod("validateClicked");
    validate.setAccessible(true);
    validate.invoke(app);
    System.out.println("[" + aSurname + "|" + aId + "|" + aBirth + "] surname: " + ((Label) get(app, "surnameErrorLabel")).getText()
        + " | id: " + ((Label) get(app, "idErrorLabel")).getText() + " | birth: " + ((Label) get(app, "birthErrorLabel")).getText()
        + " | result: " + ((Label) get(app, "resultLabel")).getText());
  }

  @Override
  public void start(Stage aStage) throws Exception {
    SignUpApp app = new SignUpApp();
    app.start(aStage);
    run(app, "Mokoena", "0203155009087", LocalDate.of(2011, 6, 1));
    run(app, "", "02031550090", LocalDate.of(2010, 12, 31));
    run(app, "Dlamini", "0203155009088", LocalDate.of(2012, 12, 31));
    run(app, "Patel", "0203155009087", null);
    run(app, "Naidoo", "0203155009087", LocalDate.of(2011, 1, 1));
    Platform.exit();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
