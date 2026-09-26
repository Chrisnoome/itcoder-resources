import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import javax.swing.JOptionPane;

// Asks before it closes.
public class CloseForm extends JFrame {

  // Builds the window.
  public CloseForm() {
    setTitle("Bookings");
    setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
    addWindowListener(new WindowAdapter() {
      @Override
      public void windowClosing(WindowEvent aEvent) {
        closeClicked();
      } // windowClosing
    });
    setSize(300, 200);
  } // CloseForm

  // X was clicked: asks first, and only ends the program on Yes.
  private void closeClicked() {
    int answer = JOptionPane.showConfirmDialog(this, "Close without saving?", "Bookings", JOptionPane.YES_NO_OPTION);
    if (answer == JOptionPane.YES_OPTION) {
      System.exit(0);
    } // if
  } // closeClicked

  public static void main(String[] args) {
    CloseForm form = new CloseForm();
    System.out.println(form.getDefaultCloseOperation() == JFrame.DO_NOTHING_ON_CLOSE);
    System.exit(0);
  } // main
} // class CloseForm
