import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;
import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextInputDialog;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.VBox;
import javafx.stage.Stage;

// The main window, in JavaFX: a list of the bookings, and buttons that open the other windows.
public class MainApp extends Application {
  public static final int MAX_BOOKINGS = 20;
  public static final String BOOKINGS_FILE = "bookings.txt";

  private ListView<String> bookingsList;
  private Button detailsButton;
  private Button findButton;
  private Button seatsButton;
  private Button saveButton;
  private Button loadButton;
  private DetailsWindow detailsWindow;
  private SeatsWindow seatsWindow;
  private Booking[] bookings;
  private int count;

  // Builds the window, makes the other two windows once, and starts with four bookings.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    bookings = new Booking[MAX_BOOKINGS];
    count = 0;
    bookingsList = new ListView<String>();
    bookingsList.setPrefSize(300, 170);
    detailsButton = new Button("Details...");
    detailsButton.setOnAction(event -> detailsClicked());
    findButton = new Button("Find...");
    findButton.setOnAction(event -> findClicked());
    seatsButton = new Button("Seating plan");
    seatsButton.setOnAction(event -> seatsClicked());
    saveButton = new Button("Save the list");
    saveButton.setOnAction(event -> saveClicked());
    loadButton = new Button("Load the list");
    loadButton.setOnAction(event -> loadClicked());
    VBox buttons = new VBox(8, detailsButton, findButton, seatsButton, saveButton, loadButton);
    for (Button button : new Button[] {detailsButton, findButton, seatsButton, saveButton, loadButton}) {
      button.setMaxWidth(Double.MAX_VALUE);
    } // for
    BorderPane page = new BorderPane();
    page.setPadding(new Insets(12));
    page.setCenter(bookingsList);
    page.setRight(buttons);
    BorderPane.setMargin(buttons, new Insets(0, 0, 0, 12));

    detailsWindow = new DetailsWindow(aStage);
    seatsWindow = new SeatsWindow();
    addBooking("Thabo Mokoena", "0821234567", 2, true);
    addBooking("Lebo Dlamini", "0719876543", 4, false);
    addBooking("Pieter van der Merwe", "0835550101", 1, false);
    addBooking("Aisha Patel", "0605552020", 3, true);
    aStage.setScene(new Scene(page));
    aStage.setTitle("Bookings for the school play");
    aStage.show();
  } // start

  // Makes a booking, keeps it, and shows it in the list.
  // aName    - the name and surname
  // aCell    - the cell number
  // aTickets - how many tickets
  // aIsVip   - true for VIP seats
  private void addBooking(String aName, String aCell, int aTickets, boolean aIsVip) {
    Booking booking = new Booking();
    booking.setName(aName);
    booking.setCellNumber(aCell);
    booking.setTickets(aTickets);
    booking.setIsVip(aIsVip);
    bookings[count] = booking;
    count++;
    bookingsList.getItems().add(booking.toString());
  } // addBooking

  // Shows a message in a small window, and waits for OK.
  // aText - the words to show
  private void showMessage(String aText) {
    Alert message = new Alert(Alert.AlertType.INFORMATION, aText);
    message.setHeaderText(null);
    message.showAndWait();
  } // showMessage

  // Shows the chosen booking in the details window, and waits until it is closed.
  private void detailsClicked() {
    int index = bookingsList.getSelectionModel().getSelectedIndex();
    if (index == -1) {
      showMessage("Click a booking in the list first.");
    } // if
    else {
      detailsWindow.setBooking(bookings[index]);
      detailsWindow.showAndWait();
    } // else
  } // detailsClicked

  // Asks for a name, and says how many tickets that person has.
  private void findClicked() {
    TextInputDialog question = new TextInputDialog();
    question.setTitle("Find a booking");
    question.setHeaderText(null);
    question.setContentText("Type the name to look for:");
    String wanted = question.showAndWait().orElse("");
    boolean found = false;
    int index = 0;
    while (index < count && !found) {
      if (bookings[index].getName().equalsIgnoreCase(wanted.trim())) {
        found = true;
      } // if
      else {
        index++;
      } // else
    } // while
    if (found) {
      bookingsList.getSelectionModel().select(index);
      showMessage(bookings[index].getName() + " has booked " + bookings[index].getTickets() + " tickets.");
    } // if
    else {
      showMessage("Nobody called \"" + wanted + "\" has booked.");
    } // else
  } // findClicked

  // Opens the seating plan, and carries on without waiting for it.
  private void seatsClicked() {
    seatsWindow.show();
  } // seatsClicked

  // Saves every line of the list to a text file.
  private void saveClicked() {
    try {
      PrintWriter fileOut = new PrintWriter(new File(BOOKINGS_FILE));
      for (int index = 0; index < bookingsList.getItems().size(); index++) {
        fileOut.println(bookingsList.getItems().get(index));
      } // for
      fileOut.close();
      showMessage("Saved " + bookingsList.getItems().size() + " lines to " + BOOKINGS_FILE + ".");
    } // try
    catch (FileNotFoundException error) {
      showMessage(BOOKINGS_FILE + " could not be saved.");
    } // catch
  } // saveClicked

  // Fills the list from the text file, one line per item.
  private void loadClicked() {
    try {
      Scanner fileIn = new Scanner(new File(BOOKINGS_FILE));
      bookingsList.getItems().clear();
      while (fileIn.hasNextLine()) {
        bookingsList.getItems().add(fileIn.nextLine());
      } // while
      fileIn.close();
      detailsButton.setDisable(true);   // the list is only text now, not bookings
    } // try
    catch (FileNotFoundException error) {
      showMessage("There is no " + BOOKINGS_FILE + " yet. Click Save first.");
    } // catch
  } // loadClicked

  public static void main(String[] args) {
    launch(args);
  } // main
} // class MainApp
