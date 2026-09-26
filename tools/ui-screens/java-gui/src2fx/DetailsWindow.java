import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.stage.Modality;
import javafx.stage.Stage;

// A second window that shows one booking. It is modal: while it is open, the
// window it belongs to can't be used.
public class DetailsWindow extends Stage {
  private Label nameLabel;
  private Label cellLabel;
  private Label ticketsLabel;
  private Label totalLabel;
  private Button okButton;

  // Builds the window. It is not shown yet.
  // aOwner - the window it belongs to, and opens over
  public DetailsWindow(Stage aOwner) {
    initOwner(aOwner);
    initModality(Modality.APPLICATION_MODAL);
    setTitle("Booking details");
    nameLabel = new Label();
    cellLabel = new Label();
    ticketsLabel = new Label();
    totalLabel = new Label();
    GridPane grid = new GridPane();
    grid.setHgap(16);
    grid.setVgap(8);
    grid.addRow(0, new Label("Name"), nameLabel);
    grid.addRow(1, new Label("Cell number"), cellLabel);
    grid.addRow(2, new Label("Tickets"), ticketsLabel);
    grid.addRow(3, new Label("Total"), totalLabel);
    okButton = new Button("OK");
    okButton.setDefaultButton(true);
    okButton.setOnAction(event -> hide());
    HBox bottom = new HBox(okButton);
    bottom.setAlignment(Pos.CENTER_RIGHT);
    VBox page = new VBox(16, grid, bottom);
    page.setPadding(new Insets(16, 16, 12, 16));
    setScene(new Scene(page));
  } // DetailsWindow

  // Fills in the labels with a booking. The main window still keeps the booking.
  // aBooking - the booking to show
  public void setBooking(Booking aBooking) {
    nameLabel.setText(aBooking.getName());
    cellLabel.setText(aBooking.getCellNumber());
    String tickets = "" + aBooking.getTickets();
    if (aBooking.getIsVip()) {
      tickets = tickets + " VIP";
    } // if
    ticketsLabel.setText(tickets);
    totalLabel.setText("R" + aBooking.getTotal());
  } // setBooking
} // class DetailsWindow
