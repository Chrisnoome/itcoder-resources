import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.event.KeyEvent;
import java.text.ParseException;
import javax.swing.BorderFactory;
import javax.swing.ButtonGroup;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JComponent;
import javax.swing.JFormattedTextField;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JSpinner;
import javax.swing.JTextField;
import javax.swing.KeyStroke;
import javax.swing.SpinnerNumberModel;
import javax.swing.UIManager;
import javax.swing.text.MaskFormatter;

// The main window of the booking program. It only reads the components, hands
// what is in them to Booking, and shows what comes back.
public class MainForm extends JFrame {
  public static final int MAX_BOOKINGS = 20;
  private static final Color NAVY = new Color(31, 58, 95);
  private static final Color GREEN = new Color(0, 128, 0);
  private static final Color RED = new Color(192, 0, 0);

  private JTextField nameField;
  private JFormattedTextField cellField;
  private JSpinner ticketsSpinner;
  private JRadioButton standardRadio;
  private JRadioButton vipRadio;
  private JLabel totalLabel;
  private JLabel messageLabel;
  private JButton bookButton;
  private JButton clearButton;
  private DefaultListModel<String> bookingsModel;
  private JList<String> bookingsList;
  private JLabel statusLabel;
  private Booking[] bookings;
  private int count;

  // Builds the window and everything on it.
  public MainForm() {
    bookings = new Booking[MAX_BOOKINGS];
    count = 0;
    setTitle("School play - bookings");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    add(makeTitleBar(), BorderLayout.NORTH);
    JPanel middle = new JPanel(new GridLayout(1, 2, 8, 0));
    middle.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
    middle.add(makeBookingGroup());
    middle.add(makeListGroup());
    add(middle, BorderLayout.CENTER);
    statusLabel = new JLabel("Enter  Book      Esc  Clear      F1  Help");
    statusLabel.setBorder(BorderFactory.createEmptyBorder(4, 8, 4, 8));
    add(statusLabel, BorderLayout.SOUTH);

    // The keys everybody expects: Enter books, Esc clears, F1 helps
    getRootPane().setDefaultButton(bookButton);
    getRootPane().registerKeyboardAction(event -> clearClicked(), KeyStroke.getKeyStroke(KeyEvent.VK_ESCAPE, 0),
                                         JComponent.WHEN_IN_FOCUSED_WINDOW);
    getRootPane().registerKeyboardAction(event -> helpPressed(), KeyStroke.getKeyStroke(KeyEvent.VK_F1, 0),
                                         JComponent.WHEN_IN_FOCUSED_WINDOW);
    showTotal();
    pack();
    setLocationRelativeTo(null);
  } // MainForm

  // Makes the navy bar across the top of the window.
  // Gives back: the bar, with its title
  private JPanel makeTitleBar() {
    JPanel titleBar = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 10));
    titleBar.setBackground(NAVY);
    JLabel titleLabel = new JLabel("Book seats for the school play");
    titleLabel.setForeground(Color.WHITE);
    titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 18));
    titleBar.add(titleLabel);
    return titleBar;
  } // makeTitleBar

  // Makes the New booking group: the labels in one column, the boxes in another.
  // Gives back: the group
  private JPanel makeBookingGroup() {
    JPanel group = new JPanel(new GridBagLayout());
    group.setBorder(BorderFactory.createTitledBorder("New booking"));
    nameField = new JTextField(22);
    cellField = new JFormattedTextField(makeCellMask());
    cellField.setColumns(10);
    cellField.setFocusLostBehavior(JFormattedTextField.PERSIST);
    ticketsSpinner = new JSpinner(new SpinnerNumberModel(1, 1, 6, 1));
    ticketsSpinner.addChangeListener(event -> showTotal());
    standardRadio = new JRadioButton("Standard (R" + Booking.STANDARD_PRICE + ")", true);
    vipRadio = new JRadioButton("VIP (R" + Booking.VIP_PRICE + ")");
    ButtonGroup seats = new ButtonGroup();
    seats.add(standardRadio);
    seats.add(vipRadio);
    standardRadio.addActionListener(event -> showTotal());
    vipRadio.addActionListener(event -> showTotal());
    JPanel seatsPanel = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
    seatsPanel.add(standardRadio);
    seatsPanel.add(vipRadio);
    totalLabel = new JLabel();
    totalLabel.setFont(totalLabel.getFont().deriveFont(Font.BOLD));
    messageLabel = new JLabel(" ");
    bookButton = new JButton("Book");
    bookButton.setMnemonic(KeyEvent.VK_B);
    bookButton.addActionListener(event -> bookClicked());
    clearButton = new JButton("Clear");
    clearButton.setMnemonic(KeyEvent.VK_C);
    clearButton.addActionListener(event -> clearClicked());
    JPanel buttons = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
    buttons.add(bookButton);
    buttons.add(clearButton);

    addRow(group, 0, "Name and surname", nameField);
    addRow(group, 1, "Cell number", cellField);
    addRow(group, 2, "Tickets (1 to 6)", ticketsSpinner);
    addRow(group, 3, "Seats", seatsPanel);
    addRow(group, 4, "Total", totalLabel);
    addWide(group, 5, messageLabel);
    addWide(group, 6, buttons);
    return group;
  } // makeBookingGroup

  // Puts a label and a component on one row of a group, lined up with the rows above.
  // aGroup     - the group to add to
  // aRow       - the row, from 0 at the top
  // aText      - the words for the label
  // aComponent - the box or buttons for that row
  private void addRow(JPanel aGroup, int aRow, String aText, JComponent aComponent) {
    GridBagConstraints place = new GridBagConstraints();
    place.gridy = aRow;
    place.insets = new Insets(4, 8, 4, 8);
    place.anchor = GridBagConstraints.WEST;
    place.gridx = 0;
    aGroup.add(new JLabel(aText), place);
    place.gridx = 1;
    place.weightx = 1;
    aGroup.add(aComponent, place);
  } // addRow

  // Puts one component across both columns of a group.
  // aGroup     - the group to add to
  // aRow       - the row, from 0 at the top
  // aComponent - the message or the buttons for that row
  private void addWide(JPanel aGroup, int aRow, JComponent aComponent) {
    GridBagConstraints place = new GridBagConstraints();
    place.gridy = aRow;
    place.gridx = 0;
    place.gridwidth = 2;
    place.insets = new Insets(4, 8, 4, 8);
    place.anchor = GridBagConstraints.WEST;
    place.fill = GridBagConstraints.HORIZONTAL;
    aGroup.add(aComponent, place);
  } // addWide

  // Makes the mask for a cell number: ten digits, shown as 082 123 4567.
  // Gives back: the mask
  private MaskFormatter makeCellMask() {
    MaskFormatter mask = new MaskFormatter();
    try {
      mask = new MaskFormatter("### ### ####");
      mask.setPlaceholderCharacter('_');
    } // try
    catch (ParseException error) {
      System.out.println("The cell number mask is wrong: " + error.getMessage());
    } // catch
    return mask;
  } // makeCellMask

  // Makes the Bookings group: a list of every booking made.
  // Gives back: the group
  private JPanel makeListGroup() {
    JPanel group = new JPanel(new BorderLayout());
    group.setBorder(BorderFactory.createTitledBorder("Bookings"));
    bookingsModel = new DefaultListModel<String>();
    bookingsList = new JList<String>(bookingsModel);
    group.add(new JScrollPane(bookingsList), BorderLayout.CENTER);
    return group;
  } // makeListGroup

  // Writes a message under the boxes in a colour.
  // aMessage - the words to show
  // aColour  - RED for a problem, GREEN for good news
  private void showMessageLine(String aMessage, Color aColour) {
    messageLabel.setForeground(aColour);
    messageLabel.setText(aMessage);
  } // showMessageLine

  // Shows what the chosen seats cost - the class works it out, not the form.
  private void showTotal() {
    Booking booking = new Booking();
    booking.setTickets((int) ticketsSpinner.getValue());
    booking.setIsVip(vipRadio.isSelected());
    totalLabel.setText("R" + booking.getTotal());
  } // showTotal

  // Reads the form into a new booking. The class checks every value; if it
  // refuses one, its message is shown and the cursor goes back to that box.
  private void bookClicked() {
    if (count == MAX_BOOKINGS) {
      showMessageLine("The play is full - no more bookings.", RED);
    } // if
    else {
      Booking booking = new Booking();
      JComponent box = nameField;
      try {
        booking.setName(nameField.getText());
        box = cellField;
        booking.setCellNumber(cellField.getText().replace(" ", ""));
        box = ticketsSpinner;
        booking.setTickets((int) ticketsSpinner.getValue());
        booking.setIsVip(vipRadio.isSelected());

        // Keep it, show it, and clear the form for the next one
        bookings[count] = booking;
        count++;
        bookingsModel.addElement(booking.toString());
        showMessageLine("Booking saved.", GREEN);
        clearClicked();
      } // try
      catch (IllegalArgumentException error) {
        showMessageLine(error.getMessage(), RED);
        box.requestFocus();
      } // catch
    } // else
  } // bookClicked

  // Empties the form for a new booking.
  private void clearClicked() {
    nameField.setText("");
    cellField.setValue(null);
    ticketsSpinner.setValue(1);
    standardRadio.setSelected(true);
    showTotal();
    nameField.requestFocus();
  } // clearClicked

  // F1: says how to use the form.
  private void helpPressed() {
    JOptionPane.showMessageDialog(this, "Fill in the name, the cell number and the number of tickets, choose the seats,"
                                  + " then click Book (or press Enter). Esc clears the form.");
  } // helpPressed

  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } // try
    catch (Exception error) {
      System.out.println("Using Java's own look instead.");
    } // catch
    MainForm form = new MainForm();
    form.setVisible(true);
  } // main
} // class MainForm
