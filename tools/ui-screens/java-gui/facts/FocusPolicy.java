import javax.swing.*;
public class FocusPolicy {
  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    SwingUtilities.invokeAndWait(() -> {
      JFrame frame = new JFrame("x");
      System.out.println(frame.getFocusTraversalPolicy().getClass().getName());
      JTextField field = new JTextField();
      System.out.println("undo on ctrl Z: " + field.getInputMap().get(KeyStroke.getKeyStroke("ctrl Z")));
      System.out.println("copy on ctrl C: " + field.getInputMap().get(KeyStroke.getKeyStroke("ctrl C")));
      System.out.println("select all on ctrl A: " + field.getInputMap().get(KeyStroke.getKeyStroke("ctrl A")));
      frame.dispose();
    });
    System.exit(0);
  }
}
