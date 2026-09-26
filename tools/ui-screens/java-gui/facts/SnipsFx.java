import java.time.LocalDate;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
public class SnipsFx {
  static void check(DatePicker birthdayPicker, Label totalLabel, Label titleLabel, Button bookButton) {
    Button printButton = new Button("Print", new ImageView(new Image("file:print.png")));
    totalLabel.setTextFill(Color.rgb(31, 58, 95));
    totalLabel.setTextFill(Color.web("#1F3A5F"));
    titleLabel.setFont(Font.font("Segoe UI", FontWeight.BOLD, 18));
    LocalDate birthday = birthdayPicker.getValue();
    Spinner<Double> massSpinner = new Spinner<Double>(0.1, 30.0, 2.5, 0.1);
    bookButton.setDisable(true);
    Font titleFont = Font.loadFont("file:FreeSerif.ttf", 28);
    ComboBox<String> provinceCombo = new ComboBox<String>();
    String province = provinceCombo.getValue();
  }
}
