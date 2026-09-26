import javax.swing.*;

// Drives lesson 24's MainForm (Swing) and takes its three pictures.
public class ShotsBooking {
  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    MainForm[] holder = new MainForm[1];
    Shot.runOnEdt(() -> { holder[0] = new MainForm(); });
    MainForm form = holder[0];
    Shot.backdrop(form.getBounds());
    Shot.runOnEdt(() -> { form.setVisible(true); form.toFront(); });
    Shot.pause(800);
    Shot.window(form, "swing-good-empty");
    Shot.places("swing-good-empty", form, "nameField", "cellField", "ticketsSpinner", "standardRadio", "vipRadio",
                "totalLabel", "bookButton", "clearButton", "bookingsList", "statusLabel");

    // A half-typed cell number, then Book
    Shot.runOnEdt(() -> {
      ((JTextField) Shot.get(form, "nameField")).setText("Thabo Mokoena");
    });
    Shot.type((JFormattedTextField) Shot.get(form, "cellField"), "082123");
    Shot.runOnEdt(() -> {
      ((JSpinner) Shot.get(form, "ticketsSpinner")).setValue(2);
      ((JRadioButton) Shot.get(form, "vipRadio")).doClick();
      ((JButton) Shot.get(form, "bookButton")).doClick();
    });
    Shot.window(form, "swing-good-error");

    // Put it right, and two more bookings
    Shot.runOnEdt(() -> {
    });
    JFormattedTextField cell = (JFormattedTextField) Shot.get(form, "cellField");
    Shot.runOnEdt(() -> cell.setValue(null));
    Shot.type(cell, "0821234567");
    Shot.runOnEdt(() -> {
      ((JButton) Shot.get(form, "bookButton")).doClick();
      ((JTextField) Shot.get(form, "nameField")).setText("Lebo Dlamini");
    });
    Shot.type(cell, "0719876543");
    Shot.runOnEdt(() -> {
      ((JSpinner) Shot.get(form, "ticketsSpinner")).setValue(4);
      ((JButton) Shot.get(form, "bookButton")).doClick();
      ((JTextField) Shot.get(form, "nameField")).setText("Pieter van der Merwe");
    });
    Shot.type(cell, "0835550101");
    Shot.runOnEdt(() -> ((JButton) Shot.get(form, "bookButton")).doClick());
    Shot.window(form, "swing-good-saved");
    System.exit(0);
  }
}
