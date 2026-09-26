import java.awt.*;
import javax.swing.*;

// Drives lesson 24's three-window booking program (src2) and takes its pictures.
public class ShotsForms {
  static Window find(String aTitle) {
    for (int attempt = 0; attempt < 40; attempt++) {
      for (Window window : Window.getWindows()) {
        String title = window instanceof Dialog ? ((Dialog) window).getTitle() : window instanceof Frame ? ((Frame) window).getTitle() : "";
        if (window.isShowing() && aTitle.equals(title)) { return window; }
      }
      Shot.pause(100);
    }
    throw new RuntimeException("no window " + aTitle);
  }

  static Component child(Container aParent, Class<?> aType, String aText) {
    for (Component component : aParent.getComponents()) {
      if (aType.isInstance(component) && (aText == null || (component instanceof AbstractButton && aText.equals(((AbstractButton) component).getText())))) {
        return component;
      }
      if (component instanceof Container) {
        Component found = child((Container) component, aType, aText);
        if (found != null) { return found; }
      }
    }
    return null;
  }

  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    MainForm[] holder = new MainForm[1];
    Shot.runOnEdt(() -> holder[0] = new MainForm());
    MainForm form = holder[0];
    Shot.backdrop(new Rectangle(form.getX() - 200, form.getY() - 150, form.getWidth() + 400, form.getHeight() + 300));
    Shot.runOnEdt(() -> { form.setVisible(true); ((JList<?>) Shot.get(form, "bookingsList")).setSelectedIndex(0); });
    Shot.window(form, "forms-main");

    // Details: a modal dialog - shown from the event thread, while this thread waits for it
    SwingUtilities.invokeLater(() -> Shot.call(form, "detailsClicked"));
    Window details = find("Booking details");
    Shot.window(details, "forms-details");
    Shot.runOnEdt(() -> ((JButton) Shot.get(details, "okButton")).doClick());
    Shot.pause(300);

    // The seating plan: three seats booked, the spotlight moving
    Shot.runOnEdt(() -> Shot.call(form, "seatsClicked"));
    Window seats = find("Seating plan");
    Shot.runOnEdt(() -> {
      for (String seat : new String[] {"A6", "B4", "B5"}) {
        ((JButton) child((Container) seats, JButton.class, seat)).doClick();
      }
      ((JButton) child((Container) seats, JButton.class, "Start the spotlight")).doClick();
    });
    Shot.backdrop(seats.getBounds());
    Shot.pause(1600);
    Shot.window(seats, "forms-seats");
    Shot.runOnEdt(() -> seats.setVisible(false));

    // Find: the input dialog, then the message
    SwingUtilities.invokeLater(() -> Shot.call(form, "findClicked"));
    Window input = find("Find a booking");
    Shot.runOnEdt(() -> ((JTextField) child((Container) input, JTextField.class, null)).setText("lebo dlamini"));
    Shot.window(input, "forms-inputbox");
    Shot.runOnEdt(() -> ((JButton) child((Container) input, JButton.class, "OK")).doClick());
    Window message = find("Message");
    Shot.window(message, "forms-message");
    Shot.runOnEdt(() -> ((JButton) child((Container) message, JButton.class, "OK")).doClick());
    System.exit(0);
  }
}
