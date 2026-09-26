import java.time.LocalDate;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Control;
import javafx.scene.control.DatePicker;
import javafx.scene.control.Label;
import javafx.scene.control.Spinner;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;
import javafx.scene.paint.Color;
import javafx.stage.Stage;

// Signing up for the U16 team: four kinds of data, checked by the components
// and by four validation rules in code.
public class SignUpApp extends Application {
  private static final Color RED = Color.rgb(192, 0, 0);
  private static final String HIGHLIGHT = "-fx-control-inner-background: #FFF3B0;";

  private TextField surnameField;
  private TextField idField;
  private Spinner<Double> heightSpinner;
  private CheckBox sportCheck;
  private DatePicker birthPicker;
  private Button validateButton;
  private Label surnameErrorLabel;
  private Label idErrorLabel;
  private Label birthErrorLabel;
  private Label resultLabel;

  // Builds the window: a label, a component and an error label on each row.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    surnameField = new TextField();
    idField = new TextField();
    heightSpinner = new Spinner<Double>(1.00, 2.30, 1.60, 0.01);
    sportCheck = new CheckBox("Yes");
    birthPicker = new DatePicker();
    validateButton = new Button("Validate");
    validateButton.setDefaultButton(true);
    validateButton.setOnAction(event -> validateClicked());
    surnameErrorLabel = new Label();
    idErrorLabel = new Label();
    birthErrorLabel = new Label();
    resultLabel = new Label();

    GridPane form = new GridPane();
    form.setHgap(12);
    form.setVgap(8);
    form.setPadding(new Insets(16));
    form.addRow(0, new Label("Surname"), surnameField, surnameErrorLabel);
    form.addRow(1, new Label("ID number"), idField, idErrorLabel);
    form.addRow(2, new Label("Height (m)"), heightSpinner);
    form.addRow(3, new Label("Plays a sport"), sportCheck);
    form.addRow(4, new Label("Date of birth"), birthPicker, birthErrorLabel);
    form.add(validateButton, 1, 5);
    form.add(resultLabel, 0, 6, 3, 1);
    aStage.setScene(new Scene(form));
    aStage.setTitle("U16 team sign-up");
    aStage.show();
  } // start

  // Empties every error label and takes the highlight off every box.
  private void clearMessages() {
    surnameErrorLabel.setText("");
    idErrorLabel.setText("");
    birthErrorLabel.setText("");
    surnameField.setStyle("");
    idField.setStyle("");
    birthPicker.getEditor().setStyle("");
  } // clearMessages

  // Shows a message beside a component, in red, and highlights the component.
  // aBox     - the component whose data is wrong
  // aLabel   - the error label beside it
  // aMessage - what is wrong, and how to fix it
  private void showError(Control aBox, Label aLabel, String aMessage) {
    aBox.setStyle(HIGHLIGHT);
    aLabel.setTextFill(RED);
    aLabel.setText(aMessage);
  } // showError

  // Checks the last digit of a 13-digit ID number against the others (lesson 19).
  // aIdNumber - the ID number, 13 digits
  // Gives back: true if the check digit is right
  private boolean idCheckDigitIsRight(String aIdNumber) {
    int total = 0;
    for (int position = 0; position < 13; position++) {
      int digit = aIdNumber.charAt(position) - '0';
      if (position % 2 == 1) {
        digit = digit * 2;
        if (digit > 9) {
          digit = digit - 9;
        } // if
      } // if an odd position
      total = total + digit;
    } // for
    return total % 10 == 0;
  } // idCheckDigitIsRight

  // Runs every validation rule. Each rule that fails shows its message beside
  // its component and highlights it; if none fails, the result label says so.
  private void validateClicked() {
    boolean allValid = true;
    clearMessages();

    // Presence check: a surname must be typed in
    if (surnameField.getText().trim().equals("")) {
      showError(surnameField, surnameErrorLabel, "Type your surname - the team sheet needs it.");
      allValid = false;
    } // if no surname

    // Length check: an ID number is exactly 13 digits
    String idNumber = idField.getText().trim();
    if (idNumber.length() != 13) {
      showError(idField, idErrorLabel, "An ID number has 13 digits. You typed " + idNumber.length() + ".");
      allValid = false;
    } // if the wrong length
    else {
      // Check digit: the last digit proves the others were typed correctly
      if (!idCheckDigitIsRight(idNumber)) {
        showError(idField, idErrorLabel, "The last digit does not match - check each digit against your ID book.");
        allValid = false;
      } // if the check digit is wrong
    } // else

    // Range check: a U16 player was born in 2011 or 2012
    LocalDate birth = birthPicker.getValue();
    if (birth == null || birth.getYear() < 2011 || birth.getYear() > 2012) {
      showError(birthPicker, birthErrorLabel, "The U16 team is for players born in 2011 or 2012. Pick your date of birth again.");
      allValid = false;
    } // if outside the team's years

    if (allValid) {
      resultLabel.setText("Everything is correct - you are signed up.");
    } // if
    else {
      resultLabel.setText("Fix the fields marked in yellow, then press Validate again.");
    } // else
  } // validateClicked

  public static void main(String[] args) {
    launch(args);
  } // main
} // class SignUpApp
