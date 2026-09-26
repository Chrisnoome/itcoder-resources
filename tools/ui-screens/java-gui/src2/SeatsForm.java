import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridLayout;
import java.awt.event.ActionEvent;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.Timer;

// The seating plan: a stage with a spotlight that moves on a timer, and a
// button for every seat, made in a loop.
public class SeatsForm extends JFrame {
  public static final int NO_OF_ROWS = 3;
  public static final int SEATS_IN_ROW = 8;

  private JPanel stagePanel;
  private JLabel spotLabel;
  private Timer spotTimer;
  private JButton spotButton;
  private JPanel seatsPanel;
  private JLabel messageLabel;
  private int stepSize;

  // Builds the window, with one button for every seat. Closing it only hides it.
  public SeatsForm() {
    setTitle("Seating plan");
    stagePanel = new JPanel(null);
    stagePanel.setBackground(new Color(40, 40, 40));
    stagePanel.setPreferredSize(new Dimension(520, 70));
    spotLabel = new JLabel("●");
    spotLabel.setForeground(Color.YELLOW);
    spotLabel.setFont(new Font("Segoe UI", Font.PLAIN, 48));
    spotLabel.setBounds(20, 0, 44, 66);
    stagePanel.add(spotLabel);
    stepSize = 6;
    spotTimer = new Timer(30, event -> moveSpot());
    spotButton = new JButton("Start the spotlight");
    spotButton.addActionListener(event -> spotClicked());

    // One button for every seat: A1 to C8
    seatsPanel = new JPanel(new GridLayout(NO_OF_ROWS, SEATS_IN_ROW, 6, 6));
    seatsPanel.setBorder(BorderFactory.createEmptyBorder(12, 12, 12, 12));
    for (int row = 0; row < NO_OF_ROWS; row++) {
      for (int seat = 1; seat <= SEATS_IN_ROW; seat++) {
        JButton seatButton = new JButton((char) ('A' + row) + "" + seat);
        seatButton.addActionListener(event -> seatClicked(event));
        seatsPanel.add(seatButton);
      } // for seat
    } // for row

    messageLabel = new JLabel("Click a seat to book it.");
    JPanel bottom = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 8));
    bottom.add(spotButton);
    bottom.add(messageLabel);
    add(stagePanel, BorderLayout.NORTH);
    add(seatsPanel, BorderLayout.CENTER);
    add(bottom, BorderLayout.SOUTH);
    pack();
    setLocationRelativeTo(null);
  } // SeatsForm

  // Books the seat whose button was clicked.
  // aEvent - the click; getSource() is the button that was clicked
  private void seatClicked(ActionEvent aEvent) {
    JButton seatButton = (JButton) aEvent.getSource();
    seatButton.setEnabled(false);
    messageLabel.setText("Seat " + seatButton.getText() + " is booked.");
  } // seatClicked

  // Moves the spotlight a little, and turns it round at either end of the stage.
  private void moveSpot() {
    int left = spotLabel.getX() + stepSize;
    spotLabel.setLocation(left, spotLabel.getY());
    if (left + spotLabel.getWidth() >= stagePanel.getWidth() || left <= 0) {
      stepSize = -stepSize;
    } // if
  } // moveSpot

  // Switches the spotlight on or off.
  private void spotClicked() {
    if (spotTimer.isRunning()) {
      spotTimer.stop();
      spotButton.setText("Start the spotlight");
    } // if
    else {
      spotTimer.start();
      spotButton.setText("Stop the spotlight");
    } // else
  } // spotClicked
} // class SeatsForm
