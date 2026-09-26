import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JDialog;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;

// A second window that shows one booking. It is modal: while it is open, the
// window it belongs to can't be used.
public class DetailsDialog extends JDialog {
  private JLabel nameLabel;
  private JLabel cellLabel;
  private JLabel ticketsLabel;
  private JLabel totalLabel;
  private JButton okButton;

  // Builds the dialog. It is not shown yet.
  // aOwner - the window it belongs to, and opens over
  public DetailsDialog(JFrame aOwner) {
    super(aOwner, "Booking details", true);
    nameLabel = new JLabel();
    cellLabel = new JLabel();
    ticketsLabel = new JLabel();
    totalLabel = new JLabel();
    JPanel grid = new JPanel(new GridLayout(4, 2, 16, 8));
    grid.add(new JLabel("Name"));
    grid.add(nameLabel);
    grid.add(new JLabel("Cell number"));
    grid.add(cellLabel);
    grid.add(new JLabel("Tickets"));
    grid.add(ticketsLabel);
    grid.add(new JLabel("Total"));
    grid.add(totalLabel);
    okButton = new JButton("OK");
    okButton.addActionListener(event -> setVisible(false));
    getRootPane().setDefaultButton(okButton);
    JPanel bottom = new JPanel(new FlowLayout(FlowLayout.RIGHT, 0, 0));
    bottom.add(okButton);
    JPanel page = new JPanel(new BorderLayout(0, 16));
    page.setBorder(BorderFactory.createEmptyBorder(16, 16, 12, 16));
    page.add(grid, BorderLayout.CENTER);
    page.add(bottom, BorderLayout.SOUTH);
    add(page);
    pack();
  } // DetailsDialog

  // Fills in the labels with a booking. The main window still keeps the booking.
  // aBooking - the booking to show
  public void setBooking(Booking aBooking) {
    nameLabel.setText(aBooking.getName());
    cellLabel.setText(aBooking.getCellNumber());
    String tickets = "" + aBooking.getTickets();
    if (aBooking.getIsVip()) {
      tickets = tickets + " VIP";
    } // if
    ticketsLabel.setText(tickets);
    totalLabel.setText("R" + aBooking.getTotal());
    pack();
    setLocationRelativeTo(getOwner());
  } // setBooking
} // class DetailsDialog
