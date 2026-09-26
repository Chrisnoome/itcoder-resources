import javax.swing.*;

// Drives lessons 25's ShopForm (Swing) and takes its pictures. Run it in a
// folder with a fresh TuckShop.db (MakeShop), or in an empty folder with the
// argument "nodb" for the missing-table picture.
public class ShotsShop {
  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    boolean noDatabase = args.length > 0 && args[0].equals("nodb");
    ShopForm[] holder = new ShopForm[1];
    Shot.runOnEdt(() -> { holder[0] = new ShopForm(); });
    ShopForm form = holder[0];
    Shot.backdrop(form.getBounds());
    Shot.runOnEdt(() -> { form.setVisible(true); form.toFront(); });
    Shot.pause(800);
    if (noDatabase) {
      Shot.window(form, "swing-shop-nodb");
      System.exit(0);
    }
    Shot.runOnEdt(() -> Shot.call(form, "valueClicked"));
    Shot.window(form, "swing-shop-all");
    Shot.runOnEdt(() -> Shot.call(form, "lowStockClicked"));
    Shot.window(form, "swing-shop-low");

    // Sell one pie: choose its row, then Sell one
    Shot.runOnEdt(() -> {
      Shot.call(form, "showAllClicked");
      JTable table = (JTable) Shot.get(form, "productsTable");
      for (int row = 0; row < table.getRowCount(); row++) {
        if (table.getValueAt(row, 0).equals("Pie")) { table.setRowSelectionInterval(row, row); }
      }
      Shot.call(form, "sellClicked");
    });
    Shot.window(form, "swing-shop-sold");

    // Add a product that is already there
    Shot.runOnEdt(() -> ((JTextField) Shot.get(form, "nameField")).setText(""));
    Shot.type((JTextField) Shot.get(form, "nameField"), "Samoosa");
    Shot.runOnEdt(() -> Shot.call(form, "addClicked"));
    Shot.window(form, "swing-shop-duplicate");
    System.exit(0);
  }
}
