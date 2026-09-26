import java.awt.*;
import java.io.File;
import javax.swing.*;

// Lesson 24's font pictures (Swing): an order form in an installed narrow font
// and in a font that is not installed, and TuckShopForm with and without
// FreeSerif.ttf in its folder. Run from a folder that holds FreeSerif.ttf only
// for the second TuckShopForm picture (the driver renames it).
public class ShotsFonts {
  static JFrame orderForm(String aFamily) {
    JFrame f = new JFrame("Tuck shop");
    f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    Font font = new Font(aFamily, Font.PLAIN, 17);
    JPanel page = new JPanel(new GridBagLayout());
    page.setBorder(BorderFactory.createEmptyBorder(12, 16, 12, 16));
    GridBagConstraints place = new GridBagConstraints();
    place.insets = new Insets(5, 4, 5, 4);
    place.anchor = GridBagConstraints.WEST;
    JLabel title = new JLabel("Tuck shop order");
    title.setFont(new Font(aFamily, Font.BOLD, 30));
    place.gridx = 0;
    place.gridy = 0;
    place.gridwidth = 2;
    page.add(title, place);
    place.gridwidth = 1;
    String[] rows = {"Pies (R18.50)", "Cooldrinks (R12.00)", "Vetkoek (R8.00)"};
    for (int row = 0; row < rows.length; row++) {
      JLabel label = new JLabel(rows[row]);
      label.setFont(font);
      label.setPreferredSize(new Dimension(150, 28));
      place.gridx = 0;
      place.gridy = row + 1;
      page.add(label, place);
      JSpinner spinner = new JSpinner(new SpinnerNumberModel(row == 0 ? 2 : 1, 0, 10, 1));
      spinner.setFont(font);
      place.gridx = 1;
      page.add(spinner, place);
    }
    JButton order = new JButton("Place order");
    JButton cancel = new JButton("Cancel order");
    for (JButton button : new JButton[] {order, cancel}) {
      button.setFont(font);
      button.setPreferredSize(new Dimension(118, 34));
    }
    JPanel buttons = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 0));
    buttons.add(order);
    buttons.add(cancel);
    place.gridx = 0;
    place.gridy = 4;
    place.gridwidth = 2;
    page.add(buttons, place);
    f.add(page);
    f.pack();
    f.setLocationRelativeTo(null);
    return f;
  }

  static void shoot(JFrame aFrame, String aName) {
    Shot.backdrop(aFrame.getBounds());
    Shot.runOnEdt(() -> aFrame.setVisible(true));
    Shot.window(aFrame, aName);
    Shot.runOnEdt(() -> aFrame.dispose());
  }

  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    JFrame[] f = new JFrame[1];
    Shot.runOnEdt(() -> f[0] = orderForm("Agency FB"));
    shoot(f[0], "swing-font-installed");
    Shot.runOnEdt(() -> f[0] = orderForm("Agency FB Condensed Pro"));
    shoot(f[0], "swing-font-missing");

    File font = new File("FreeSerif.ttf");
    File away = new File("FreeSerif.away");
    font.renameTo(away);
    Shot.runOnEdt(() -> { f[0] = new TuckShopForm(); f[0].setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); });
    shoot(f[0], "swing-font-nofile");
    away.renameTo(font);
    Shot.runOnEdt(() -> { f[0] = new TuckShopForm(); f[0].setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE); });
    shoot(f[0], "swing-font-private");
    System.exit(0);
  }
}
