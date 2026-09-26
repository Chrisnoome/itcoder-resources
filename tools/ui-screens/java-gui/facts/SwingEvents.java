import java.awt.event.*;
import javax.swing.*;

public class SwingEvents {
  static JDialog dialog;
  static void log(String aText) { System.out.println(aText); }

  public static void main(String[] args) throws Exception {
    SwingUtilities.invokeAndWait(() -> {
      JFrame main = new JFrame("main");
      main.setSize(300, 200);
      main.setLocationRelativeTo(null);
      main.setVisible(true);
      dialog = new JDialog(main, "details", true);
      log("constructor done");
      dialog.setSize(200, 120);
      dialog.addWindowListener(new WindowListener() {
        public void windowOpened(WindowEvent e) { log("windowOpened"); }
        public void windowActivated(WindowEvent e) { log("windowActivated"); }
        public void windowDeactivated(WindowEvent e) { log("windowDeactivated"); }
        public void windowClosing(WindowEvent e) { log("windowClosing"); }
        public void windowClosed(WindowEvent e) { log("windowClosed"); }
        public void windowIconified(WindowEvent e) { log("windowIconified"); }
        public void windowDeiconified(WindowEvent e) { log("windowDeiconified"); }
      });
      dialog.addComponentListener(new ComponentAdapter() {
        public void componentShown(ComponentEvent e) { log("componentShown"); }
        public void componentHidden(ComponentEvent e) { log("componentHidden"); }
      });
    });
    for (int time = 1; time <= 2; time++) {
      log("--- show " + time);
      SwingUtilities.invokeLater(() -> { dialog.setVisible(true); log("setVisible(true) came back"); });
      Thread.sleep(1200);
      log("--- X clicked (WINDOW_CLOSING)");
      SwingUtilities.invokeAndWait(() -> dialog.dispatchEvent(new WindowEvent(dialog, WindowEvent.WINDOW_CLOSING)));
      Thread.sleep(800);
    }
    log("--- dispose");
    SwingUtilities.invokeAndWait(() -> dialog.dispose());
    Thread.sleep(500);
    System.exit(0);
  }
}
