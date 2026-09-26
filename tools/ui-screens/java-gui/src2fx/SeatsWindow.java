import javafx.animation.Animation;
import javafx.animation.KeyFrame;
import javafx.animation.Timeline;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.Pane;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.stage.Stage;
import javafx.util.Duration;

// The seating plan, in JavaFX: a stage with a spotlight that moves on a
// timeline, and a button for every seat, made in a loop.
public class SeatsWindow extends Stage {
  public static final int NO_OF_ROWS = 3;
  public static final int SEATS_IN_ROW = 8;

  private Pane stagePane;
  private Circle spot;
  private Timeline spotTimeline;
  private Button spotButton;
  private GridPane seatsGrid;
  private Label messageLabel;
  private int stepSize;

  // Builds the window, with one button for every seat. Closing it only hides it.
  public SeatsWindow() {
    setTitle("Seating plan");
    stagePane = new Pane();
    stagePane.setPrefSize(520, 70);
    stagePane.setStyle("-fx-background-color: #282828;");
    spot = new Circle(20, 35, 16, Color.YELLOW);
    stagePane.getChildren().add(spot);
    stepSize = 6;
    spotTimeline = new Timeline(new KeyFrame(Duration.millis(30), event -> moveSpot()));
    spotTimeline.setCycleCount(Animation.INDEFINITE);
    spotButton = new Button("Start the spotlight");
    spotButton.setOnAction(event -> spotClicked());

    // One button for every seat: A1 to C8
    seatsGrid = new GridPane();
    seatsGrid.setHgap(6);
    seatsGrid.setVgap(6);
    seatsGrid.setPadding(new Insets(12));
    for (int row = 0; row < NO_OF_ROWS; row++) {
      for (int seat = 1; seat <= SEATS_IN_ROW; seat++) {
        Button seatButton = new Button((char) ('A' + row) + "" + seat);
        seatButton.setPrefWidth(56);
        seatButton.setOnAction(event -> seatClicked(event));
        seatsGrid.add(seatButton, seat - 1, row);
      } // for seat
    } // for row

    messageLabel = new Label("Click a seat to book it.");
    HBox bottom = new HBox(12, spotButton, messageLabel);
    bottom.setAlignment(Pos.CENTER_LEFT);
    bottom.setPadding(new Insets(0, 12, 12, 12));
    setScene(new Scene(new VBox(stagePane, seatsGrid, bottom)));
  } // SeatsWindow

  // Books the seat whose button was clicked.
  // aEvent - the click; getSource() is the button that was clicked
  private void seatClicked(ActionEvent aEvent) {
    Button seatButton = (Button) aEvent.getSource();
    seatButton.setDisable(true);
    messageLabel.setText("Seat " + seatButton.getText() + " is booked.");
  } // seatClicked

  // Moves the spotlight a little, and turns it round at either end of the stage.
  private void moveSpot() {
    spot.setCenterX(spot.getCenterX() + stepSize);
    if (spot.getCenterX() + spot.getRadius() >= stagePane.getWidth() || spot.getCenterX() - spot.getRadius() <= 0) {
      stepSize = -stepSize;
    } // if
  } // moveSpot

  // Switches the spotlight on or off.
  private void spotClicked() {
    if (spotTimeline.getStatus() == Animation.Status.RUNNING) {
      spotTimeline.stop();
      spotButton.setText("Start the spotlight");
    } // if
    else {
      spotTimeline.play();
      spotButton.setText("Stop the spotlight");
    } // else
  } // spotClicked
} // class SeatsWindow
