import javax.swing.*;
public class SpinText {
  public static void main(String[] args) throws Exception {
    JSpinner ticketsSpinner = new JSpinner(new SpinnerNumberModel(1, 1, 6, 1));
    SwingUtilities.invokeLater(() -> ticketsSpinner.setValue("1"));
    Thread.sleep(1500);
    System.exit(0);
  }
}
