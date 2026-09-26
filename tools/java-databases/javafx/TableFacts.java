import javafx.application.Platform;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;

class Hidden {
  private String name = "Pie";
  public String getName() { return name; }
}

public class TableFacts {
  public static void main(String[] args) throws Exception {
    Platform.startup(() -> {
      TableView<Product> table = new TableView<Product>();
      Product pie = new Product("Pie", 18.5, 12);
      TableColumn<Product, String> good = new TableColumn<Product, String>("Product");
      good.setCellValueFactory(new PropertyValueFactory<Product, String>("name"));
      TableColumn<Product, String> typo = new TableColumn<Product, String>("Product");
      typo.setCellValueFactory(new PropertyValueFactory<Product, String>("nmae"));
      TableColumn<Product, String> capital = new TableColumn<Product, String>("Product");
      capital.setCellValueFactory(new PropertyValueFactory<Product, String>("Name"));
      table.getColumns().add(good);
      table.getColumns().add(typo);
      table.getColumns().add(capital);
      table.getItems().setAll(new Product[] {pie});
      System.out.println("good: " + good.getCellObservableValue(0).getValue());
      System.out.println("typo: " + typo.getCellObservableValue(0));
      System.out.println("capital: " + capital.getCellObservableValue(0));
      TableView<Hidden> hiddenTable = new TableView<Hidden>();
      TableColumn<Hidden, String> hiddenColumn = new TableColumn<Hidden, String>("Name");
      hiddenColumn.setCellValueFactory(new PropertyValueFactory<Hidden, String>("name"));
      hiddenTable.getColumns().add(hiddenColumn);
      hiddenTable.getItems().add(new Hidden());
      System.out.println("non-public class: " + hiddenColumn.getCellObservableValue(0));
      System.out.println("selected with none chosen: " + table.getSelectionModel().getSelectedItem());
      System.out.println("items " + table.getItems().size());
      Platform.exit();
    });
  }
}
