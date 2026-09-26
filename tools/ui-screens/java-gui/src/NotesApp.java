import javafx.application.Application;
import javafx.geometry.Insets;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TextArea;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

// A window that grows properly, in JavaFX: a bar along the top, a list and a
// notes box with a splitter between them, buttons in the bottom right and a
// status bar.
public class NotesApp extends Application {
  private ListView<String> pupilsList;
  private TextArea notesArea;
  private Button saveButton;
  private Button cancelButton;
  private Label statusLabel;

  // Builds the window with layout panes - no control has a fixed place.
  // aStage - the window JavaFX gives the program
  @Override
  public void start(Stage aStage) {
    BorderPane root = new BorderPane();

    // The top: a navy bar, as wide as the window
    Label titleLabel = new Label("Notes on each pupil");
    titleLabel.setTextFill(Color.WHITE);
    titleLabel.setFont(Font.font("Segoe UI", FontWeight.BOLD, 16));
    HBox titleBar = new HBox(titleLabel);
    titleBar.setPadding(new Insets(8, 12, 8, 12));
    titleBar.setStyle("-fx-background-color: #1F3A5F;");
    root.setTop(titleBar);

    // The middle: the list and the notes, with a splitter between them
    pupilsList = new ListView<String>();
    pupilsList.getItems().addAll("Thabo Mokoena", "Lebo Dlamini", "Pieter van der Merwe", "Aisha Patel");
    notesArea = new TextArea("Wants to join the chess club.");
    SplitPane middle = new SplitPane(pupilsList, notesArea);
    middle.setDividerPositions(0.33);
    BorderPane.setMargin(middle, new Insets(8));
    root.setCenter(middle);

    // The bottom: the buttons on the right, then the status bar
    saveButton = new Button("Save");
    cancelButton = new Button("Cancel");
    HBox buttons = new HBox(8, saveButton, cancelButton);
    buttons.setAlignment(Pos.CENTER_RIGHT);
    buttons.setPadding(new Insets(0, 8, 0, 8));
    statusLabel = new Label("4 pupils");
    statusLabel.setPadding(new Insets(6, 8, 4, 8));
    root.setBottom(new VBox(buttons, statusLabel));

    aStage.setScene(new Scene(root, 520, 300));
    aStage.setTitle("Pupil notes");
    aStage.show();
  } // start

  public static void main(String[] args) {
    launch(args);
  } // main
} // class NotesApp
