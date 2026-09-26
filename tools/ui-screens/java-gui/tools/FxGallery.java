import java.time.LocalDate;
import javafx.application.Application;
import javafx.application.Platform;
import javafx.geometry.Insets;
import javafx.scene.Node;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.layout.*;
import javafx.scene.text.Font;
import javafx.scene.text.FontPosture;
import javafx.scene.text.FontWeight;
import javafx.stage.Stage;

// Lesson 24's component pictures (JavaFX), built in code only for the pictures.
public class FxGallery extends Application {
  static GridPane grid;
  static int row;

  public static class Mark {
    private final String name;
    private final int term1;
    private final int term2;
    public Mark(String aName, int aTerm1, int aTerm2) { name = aName; term1 = aTerm1; term2 = aTerm2; }
    public String getName() { return name; }
    public int getTerm1() { return term1; }
    public int getTerm2() { return term2; }
  }

  static Scene page() {
    grid = new GridPane();
    grid.setHgap(18);
    grid.setVgap(10);
    grid.setPadding(new Insets(12));
    row = 0;
    return new Scene(grid);
  }

  static void add(Node aNode, String aNote) {
    Label note = new Label(aNote);
    note.setStyle("-fx-text-fill: #808080;");
    note.setFont(Font.font(null, FontPosture.ITALIC, 12));
    grid.addRow(row++, aNode, note);
  }

  static Scene text() {
    Scene scene = page();
    Label heading = new Label("Your details");
    heading.setFont(Font.font(null, FontWeight.BOLD, 15));
    add(heading, "Label - headingLabel");
    add(new TextField("Thabo Mokoena"), "TextField - nameField");
    TextField hint = new TextField();
    hint.setPromptText("like 0821234567");
    add(hint, "TextField with a prompt - cellField");
    add(new PasswordField() {{ setText("secret123"); }}, "PasswordField - passwordField");
    TextField shown = new TextField("R300");
    shown.setEditable(false);
    add(shown, "TextField, not editable - totalField");
    TextArea notes = new TextArea("Wheelchair seat, please.\nArrives at 18:30.\nPaid at the office.");
    notes.setPrefRowCount(3);
    notes.setPrefColumnCount(14);
    add(notes, "TextArea - notesArea");
    return scene;
  }

  static Scene choose() {
    Scene scene = page();
    CheckBox bus = new CheckBox("Takes the school bus");
    bus.setSelected(true);
    add(bus, "CheckBox - busCheck");
    ToggleGroup times = new ToggleGroup();
    RadioButton morning = new RadioButton("Morning");
    morning.setToggleGroup(times);
    morning.setSelected(true);
    RadioButton afternoon = new RadioButton("Afternoon");
    afternoon.setToggleGroup(times);
    add(new HBox(12, morning, afternoon), "RadioButton x 2, in a ToggleGroup - morningRadio");
    ToggleGroup houses = new ToggleGroup();
    GridPane houseGrid = new GridPane();
    houseGrid.setHgap(12);
    houseGrid.setVgap(6);
    String[] names = {"Red", "Blue", "Green", "Yellow"};
    for (int index = 0; index < names.length; index++) {
      RadioButton radio = new RadioButton(names[index]);
      radio.setToggleGroup(houses);
      radio.setSelected(index == 1);
      houseGrid.add(radio, index % 2, index / 2);
    }
    TitledPane house = new TitledPane("House", houseGrid);
    house.setCollapsible(false);
    add(house, "RadioButtons in a TitledPane - housePane");
    ComboBox<String> province = new ComboBox<String>();
    province.getItems().addAll("Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal", "Limpopo", "Mpumalanga",
                               "North West", "Northern Cape", "Western Cape");
    province.setValue("Gauteng");
    add(province, "ComboBox - provinceCombo");
    ListView<String> list = new ListView<String>();
    list.getItems().addAll("Thabo Mokoena", "Lebo Dlamini", "Pieter van der Merwe", "Aisha Patel");
    list.getSelectionModel().select(1);
    list.setPrefHeight(110);
    list.setPrefWidth(190);
    add(list, "ListView - bookingsList");
    return scene;
  }

  static Scene numbers() {
    Scene scene = page();
    Spinner<Integer> tickets = new Spinner<Integer>(1, 6, 2);
    tickets.setPrefWidth(80);
    add(tickets, "Spinner<Integer> - ticketsSpinner");
    Spinner<Double> mass = new Spinner<Double>(0.1, 30.0, 2.5, 0.1);
    mass.setPrefWidth(80);
    add(mass, "Spinner<Double> - massSpinner");
    Slider volume = new Slider(0, 10, 7);
    volume.setShowTickMarks(true);
    volume.setMajorTickUnit(1);
    add(volume, "Slider - volumeSlider");
    DatePicker birthday = new DatePicker(LocalDate.of(2010, 3, 21));
    add(birthday, "DatePicker - birthdayPicker");
    return scene;
  }

  static Scene containers() {
    MenuBar menus = new MenuBar(new Menu("File"), new Menu("Edit"), new Menu("View"), new Menu("Help"));
    HBox top = new HBox(8, new Label("Search:") {{ setStyle("-fx-text-fill: white;"); }}, new TextField("Patel"), new Button("Find"));
    top.setPadding(new Insets(6, 8, 6, 8));
    top.setStyle("-fx-background-color: #1F3A5F;");
    top.setAlignment(javafx.geometry.Pos.CENTER_LEFT);
    GridPane contactGrid = new GridPane();
    contactGrid.setHgap(8);
    contactGrid.setVgap(6);
    contactGrid.addRow(0, new Label("Cell"), new TextField("0821234567"));
    contactGrid.addRow(1, new Label("E-mail"), new TextField("thabo@school.co.za"));
    TitledPane contact = new TitledPane("Contact details", contactGrid);
    contact.setCollapsible(false);
    TableView<Mark> table = new TableView<Mark>();
    TableColumn<Mark, String> nameColumn = new TableColumn<Mark, String>("Name");
    nameColumn.setCellValueFactory(new PropertyValueFactory<Mark, String>("name"));
    TableColumn<Mark, Integer> term1Column = new TableColumn<Mark, Integer>("Term 1");
    term1Column.setCellValueFactory(new PropertyValueFactory<Mark, Integer>("term1"));
    TableColumn<Mark, Integer> term2Column = new TableColumn<Mark, Integer>("Term 2");
    term2Column.setCellValueFactory(new PropertyValueFactory<Mark, Integer>("term2"));
    table.getColumns().add(nameColumn);
    table.getColumns().add(term1Column);
    table.getColumns().add(term2Column);
    table.getItems().addAll(new Mark("Thabo", 67, 72), new Mark("Lebo", 82, 79), new Mark("Pieter", 45, 58));
    table.setPrefHeight(120);
    table.setColumnResizePolicy(TableView.CONSTRAINED_RESIZE_POLICY);
    TabPane tabs = new TabPane(new Tab("Marks", table), new Tab("Attendance"), new Tab("Reports"));
    tabs.setTabClosingPolicy(TabPane.TabClosingPolicy.UNAVAILABLE);
    VBox middle = new VBox(8, contact, tabs);
    middle.setPadding(new Insets(8));
    Label status = new Label("3 pupils      Term 2      Saved");
    status.setPadding(new Insets(3, 8, 3, 8));
    status.setStyle("-fx-border-color: #c8c8c8; -fx-border-width: 1 0 0 0;");
    status.setMaxWidth(Double.MAX_VALUE);
    VBox all = new VBox(menus, top, middle, status);
    all.setPrefWidth(420);
    return new Scene(all);
  }

  static void shoot(Stage aStage, Scene aScene, String aTitle, String aName) {
    FxShot.fx(() -> {
      aStage.setScene(aScene);
      aStage.setTitle(aTitle);
      aStage.sizeToScene();
      aStage.centerOnScreen();
      aStage.show();
      aScene.getRoot().requestFocus();
    });
    FxShot.backdrop(aStage);
    FxShot.window(aStage, aName);
  }

  @Override
  public void start(Stage aStage) {
    new Thread(() -> {
      shoot(aStage, text(), "Controls for typing", "fx-text");
      shoot(aStage, choose(), "Controls for choosing", "fx-choose");
      shoot(aStage, numbers(), "Controls for numbers and dates", "fx-numbers");
      shoot(aStage, containers(), "Controls that hold controls", "fx-containers");
      Platform.exit();
      System.exit(0);
    }).start();
  }

  public static void main(String[] args) {
    launch(args);
  }
}
