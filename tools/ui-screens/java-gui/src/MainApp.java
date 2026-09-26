import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Control;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.RadioButton;
import javafx.scene.control.Spinner;
import javafx.scene.control.TextField;
import javafx.scene.control.TitledPane;
import javafx.scene.control.ToggleGroup;
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

// The main window of the booking program, in JavaFX. It only reads the
// controls, hands what is in them to Booking, and shows what comes back.
public class MainApp extends Application {
  public static final int MAX_BOOKINGS = 20;
  private static final Color GREEN = Color.rgb(0, 128, 0);
  private static final Color RED = Color.rgb(192, 0, 0);

  private TextField nameField;
  private TextField cellField;
  private Spinner<Integer> ticketsSpinner;
  private RadioButton standardRadio;
  private RadioButton vipRadio;
  private Label totalLabel;
  private Label messageLabel;
  private Button bookButton;
  private Button clearButton;
  private ListView<String> bookingsList;
  private Label statusLabel;
  private Booking[] bookings;
  private int count;

  // Builds the window and everything on it, and shows it.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    bookings = new Booking[MAX_BOOKINGS];
    count = 0;
    BorderPane root = new BorderPane();
    root.setTop(makeTitleBar());
    HBox middle = new HBox(8, makeBookingGroup(), makeListGroup());
    middle.setPadding(new Insets(8));
    root.setCenter(middle);
    statusLabel = new Label("Enter  Book      Esc  Clear      F1  Help");
    statusLabel.setPadding(new Insets(4, 8, 4, 8));
    root.setBottom(statusLabel);

    Scene scene = new Scene(root);
    scene.setOnKeyPressed(event -> keyPressed(event));
    aStage.setScene(scene);
    aStage.setTitle("School play - bookings");
    showTotal();
    aStage.show();
  } // start

  // Makes the navy bar across the top of the window.
  // Gives back: the bar, with its title
  private HBox makeTitleBar() {
    Label titleLabel = new Label("Book seats for the school play");
    titleLabel.setTextFill(Color.WHITE);
    titleLabel.setFont(Font.font("Segoe UI", FontWeight.BOLD, 18));
    HBox titleBar = new HBox(titleLabel);
    titleBar.setPadding(new Insets(10, 12, 10, 12));
    titleBar.setStyle("-fx-background-color: #1F3A5F;");
    return titleBar;
  } // makeTitleBar

  // Makes the New booking group: the labels in one column, the boxes in another.
  // Gives back: the group
  private TitledPane makeBookingGroup() {
    nameField = new TextField();
    nameField.setPrefColumnCount(18);
    cellField = new TextField();
    cellField.setPrefColumnCount(8);
    cellField.setPromptText("0821234567");
    cellField.setMaxWidth(Control.USE_PREF_SIZE);
    ticketsSpinner = new Spinner<Integer>(1, 6, 1);
    ticketsSpinner.setPrefWidth(70);
    ticketsSpinner.valueProperty().addListener((observable, oldValue, newValue) -> showTotal());
    ToggleGroup seats = new ToggleGroup();
    standardRadio = new RadioButton("Standard (R" + Booking.STANDARD_PRICE + ")");
    standardRadio.setToggleGroup(seats);
    standardRadio.setSelected(true);
    standardRadio.setOnAction(event -> showTotal());
    vipRadio = new RadioButton("VIP (R" + Booking.VIP_PRICE + ")");
    vipRadio.setToggleGroup(seats);
    vipRadio.setOnAction(event -> showTotal());
    totalLabel = new Label();
    totalLabel.setStyle("-fx-font-weight: bold;");
    messageLabel = new Label(" ");
    bookButton = new Button("_Book");
    bookButton.setDefaultButton(true);
    bookButton.setOnAction(event -> bookClicked());
    clearButton = new Button("_Clear");
    clearButton.setCancelButton(true);
    clearButton.setOnAction(event -> clearClicked());
    HBox buttons = new HBox(8, bookButton, clearButton);
    buttons.setAlignment(Pos.CENTER_RIGHT);

    GridPane form = new GridPane();
    form.setHgap(16);
    form.setVgap(8);
    form.setPadding(new Insets(8));
    form.addRow(0, new Label("Name and surname"), nameField);
    form.addRow(1, new Label("Cell number"), cellField);
    form.addRow(2, new Label("Tickets (1 to 6)"), ticketsSpinner);
    form.addRow(3, new Label("Seats"), new HBox(12, standardRadio, vipRadio));
    form.addRow(4, new Label("Total"), totalLabel);
    form.add(messageLabel, 0, 5, 2, 1);
    form.add(buttons, 0, 6, 2, 1);
    TitledPane group = new TitledPane("New booking", form);
    group.setCollapsible(false);
    return group;
  } // makeBookingGroup

  // Makes the Bookings group: a list of every booking made.
  // Gives back: the group
  private TitledPane makeListGroup() {
    bookingsList = new ListView<String>();
    bookingsList.setPrefWidth(300);
    bookingsList.setPrefHeight(200);
    TitledPane group = new TitledPane("Bookings", bookingsList);
    group.setCollapsible(false);
    return group;
  } // makeListGroup

  // Writes a message under the boxes in a colour.
  // aMessage - the words to show
  // aColour  - RED for a problem, GREEN for good news
  private void showMessageLine(String aMessage, Color aColour) {
    messageLabel.setTextFill(aColour);
    messageLabel.setText(aMessage);
  } // showMessageLine

  // Shows what the chosen seats cost - the class works it out, not the window.
  private void showTotal() {
    Booking booking = new Booking();
    booking.setTickets(ticketsSpinner.getValue());
    booking.setIsVip(vipRadio.isSelected());
    totalLabel.setText("R" + booking.getTotal());
  } // showTotal

  // Reads the window into a new booking. The class checks every value; if it
  // refuses one, its message is shown and the cursor goes back to that box.
  private void bookClicked() {
    if (count == MAX_BOOKINGS) {
      showMessageLine("The play is full - no more bookings.", RED);
    } // if
    else {
      Booking booking = new Booking();
      Control box = nameField;
      try {
        booking.setName(nameField.getText());
        box = cellField;
        booking.setCellNumber(cellField.getText());
        box = ticketsSpinner;
        booking.setTickets(ticketsSpinner.getValue());
        booking.setIsVip(vipRadio.isSelected());

        // Keep it, show it, and clear the window for the next one
        bookings[count] = booking;
        count++;
        bookingsList.getItems().add(booking.toString());
        showMessageLine("Booking saved.", GREEN);
        clearClicked();
      } // try
      catch (IllegalArgumentException error) {
        showMessageLine(error.getMessage(), RED);
        box.requestFocus();
      } // catch
    } // else
  } // bookClicked

  // Empties the boxes for a new booking.
  private void clearClicked() {
    nameField.clear();
    cellField.clear();
    ticketsSpinner.getValueFactory().setValue(1);
    standardRadio.setSelected(true);
    showTotal();
    nameField.requestFocus();
  } // clearClicked

  // F1 anywhere in the window shows the help.
  // aEvent - which key was pressed
  private void keyPressed(KeyEvent aEvent) {
    if (aEvent.getCode() == KeyCode.F1) {
      Alert help = new Alert(Alert.AlertType.INFORMATION, "Fill in the name, the cell number and the number of tickets,"
                             + " choose the seats, then click Book (or press Enter). Esc clears the boxes.");
      help.setHeaderText("How to book");
      help.showAndWait();
    } // if
  } // keyPressed

  public static void main(String[] args) {
    launch(args);
  } // main
} // class MainApp
