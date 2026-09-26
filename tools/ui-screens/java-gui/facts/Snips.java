import java.awt.Color;
import java.awt.Font;
import java.awt.event.KeyEvent;
import javax.swing.*;
public class Snips {
  public static void main(String[] args) {
    JButton saveButton = new JButton("Save", UIManager.getIcon("FileView.floppyDriveIcon"));
    JButton printButton = new JButton("Print", new ImageIcon("print.png"));
    JTextField nameField = new JTextField(22);
    JLabel totalLabel = new JLabel("R300");
    JPanel titleBar = new JPanel();
    nameField.setBackground(Color.YELLOW);
    totalLabel.setForeground(new Color(31, 58, 95));
    titleBar.setBackground(Color.decode("#1F3A5F"));
    JLabel titleLabel = new JLabel("x");
    titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 18));
    totalLabel.setFont(totalLabel.getFont().deriveFont(Font.BOLD));
    saveButton.setMnemonic(KeyEvent.VK_B);
    saveButton.setEnabled(false);
    JSpinner ticketsSpinner = new JSpinner(new SpinnerNumberModel(1, 1, 6, 1));
    int tickets = (int) ticketsSpinner.getValue();
    Timer countdownTimer = new Timer(1000, event -> System.out.println("tick"));
    System.out.println(Color.decode("#1F3A5F").equals(new Color(31, 58, 95)) + " " + tickets + " " + countdownTimer.getDelay());
    try {
      int number = Integer.parseInt(null);
    }
    catch (NumberFormatException error) {
      System.out.println(error.getMessage());
    }
    System.out.println(new JFrame().getDefaultCloseOperation() == WindowConstants.HIDE_ON_CLOSE);
    System.exit(0);
  }
}
