import java.awt.BorderLayout;
import java.awt.Font;
import java.awt.FontFormatException;
import java.awt.GridLayout;
import java.io.File;
import java.io.IOException;
import javax.swing.BorderFactory;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.UIManager;

// A window whose title is in FreeSerif - a font the program brings with it
// and loads for itself. Nothing is installed on the computer.
public class TuckShopForm extends JFrame {
  private JLabel titleLabel;
  private JLabel messageLabel;

  // Builds the window: the title in the loaded font, and a message saying what happened.
  public TuckShopForm() {
    setTitle("Tuck shop");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    titleLabel = new JLabel("Tuck shop specials");
    messageLabel = new JLabel();
    titleLabel.setFont(loadTitleFont());
    JPanel page = new JPanel(new GridLayout(2, 1, 0, 12));
    page.setBorder(BorderFactory.createEmptyBorder(16, 20, 16, 20));
    page.add(titleLabel);
    page.add(messageLabel);
    add(page, BorderLayout.CENTER);
    pack();
    setLocationRelativeTo(null);
  } // TuckShopForm

  // Loads FreeSerif.ttf from the program's folder, for this program only. If
  // the file is missing (or is not a font), the title uses Segoe UI instead.
  // Gives back: the font for the title, 28 points
  private Font loadTitleFont() {
    Font titleFont = new Font("Segoe UI", Font.BOLD, 28);
    try {
      titleFont = Font.createFont(Font.TRUETYPE_FONT, new File("FreeSerif.ttf")).deriveFont(28f);
      messageLabel.setText("FreeSerif.ttf was loaded for this program only.");
    } // try
    catch (IOException error) {
      messageLabel.setText("FreeSerif.ttf is missing - using Segoe UI instead.");
    } // catch
    catch (FontFormatException error) {
      messageLabel.setText("FreeSerif.ttf is not a font file - using Segoe UI instead.");
    } // catch
    return titleFont;
  } // loadTitleFont

  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } // try
    catch (Exception error) {
      System.out.println("Using Java's own look instead.");
    } // catch
    TuckShopForm form = new TuckShopForm();
    form.setVisible(true);
  } // main
} // class TuckShopForm
