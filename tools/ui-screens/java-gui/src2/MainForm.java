import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;
import javax.swing.BorderFactory;
import javax.swing.DefaultListModel;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.UIManager;

// The main window: a list of the bookings, and buttons that open the other windows.
public class MainForm extends JFrame {
  public static final int MAX_BOOKINGS = 20;
  public static final String BOOKINGS_FILE = "bookings.txt";

  private DefaultListModel<String> bookingsModel;
  private JList<String> bookingsList;
  private JButton detailsButton;
  private JButton findButton;
  private JButton seatsButton;
  private JButton saveButton;
  private JButton loadButton;
  private DetailsDialog detailsDialog;
  private SeatsForm seatsForm;
  private Booking[] bookings;
  private int count;

  // Builds the window, makes the other two windows once, and starts with four bookings.
  public MainForm() {
    bookings = new Booking[MAX_BOOKINGS];
    count = 0;
    setTitle("Bookings for the school play");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    bookingsModel = new DefaultListModel<String>();
    bookingsList = new JList<String>(bookingsModel);
    JScrollPane listScroll = new JScrollPane(bookingsList);
    listScroll.setPreferredSize(new Dimension(300, 170));
    detailsButton = new JButton("Details...");
    detailsButton.addActionListener(event -> detailsClicked());
    findButton = new JButton("Find...");
    findButton.addActionListener(event -> findClicked());
    seatsButton = new JButton("Seating plan");
    seatsButton.addActionListener(event -> seatsClicked());
    saveButton = new JButton("Save the list");
    saveButton.addActionListener(event -> saveClicked());
    loadButton = new JButton("Load the list");
    loadButton.addActionListener(event -> loadClicked());
    JPanel buttons = new JPanel(new GridLayout(5, 1, 0, 8));
    buttons.add(detailsButton);
    buttons.add(findButton);
    buttons.add(seatsButton);
    buttons.add(saveButton);
    buttons.add(loadButton);
    JPanel right = new JPanel(new BorderLayout());
    right.add(buttons, BorderLayout.NORTH);
    JPanel page = new JPanel(new BorderLayout(12, 0));
    page.setBorder(BorderFactory.createEmptyBorder(12, 12, 12, 12));
    page.add(listScroll, BorderLayout.CENTER);
    page.add(right, BorderLayout.EAST);
    add(page);

    detailsDialog = new DetailsDialog(this);
    seatsForm = new SeatsForm();
    addBooking("Thabo Mokoena", "0821234567", 2, true);
    addBooking("Lebo Dlamini", "0719876543", 4, false);
    addBooking("Pieter van der Merwe", "0835550101", 1, false);
    addBooking("Aisha Patel", "0605552020", 3, true);
    pack();
    setLocationRelativeTo(null);
  } // MainForm

  // Makes a booking, keeps it, and shows it in the list.
  // aName    - the name and surname
  // aCell    - the cell number
  // aTickets - how many tickets
  // aIsVip   - true for VIP seats
  private void addBooking(String aName, String aCell, int aTickets, boolean aIsVip) {
    Booking booking = new Booking();
    booking.setName(aName);
    booking.setCellNumber(aCell);
    booking.setTickets(aTickets);
    booking.setIsVip(aIsVip);
    bookings[count] = booking;
    count++;
    bookingsModel.addElement(booking.toString());
  } // addBooking

  // Shows the chosen booking in the details window, and waits until it is closed.
  private void detailsClicked() {
    int index = bookingsList.getSelectedIndex();
    if (index == -1) {
      JOptionPane.showMessageDialog(this, "Click a booking in the list first.");
    } // if
    else {
      detailsDialog.setBooking(bookings[index]);
      detailsDialog.setVisible(true);
    } // else
  } // detailsClicked

  // Asks for a name, and says how many tickets that person has.
  private void findClicked() {
    String wanted = JOptionPane.showInputDialog(this, "Type the name to look for:", "Find a booking",
                                                JOptionPane.QUESTION_MESSAGE);
    if (wanted == null) {
      wanted = "";
    } // if
    boolean found = false;
    int index = 0;
    while (index < count && !found) {
      if (bookings[index].getName().equalsIgnoreCase(wanted.trim())) {
        found = true;
      } // if
      else {
        index++;
      } // else
    } // while
    if (found) {
      bookingsList.setSelectedIndex(index);
      JOptionPane.showMessageDialog(this, bookings[index].getName() + " has booked " + bookings[index].getTickets() + " tickets.");
    } // if
    else {
      JOptionPane.showMessageDialog(this, "Nobody called \"" + wanted + "\" has booked.");
    } // else
  } // findClicked

  // Opens the seating plan, and carries on without waiting for it.
  private void seatsClicked() {
    seatsForm.setVisible(true);
  } // seatsClicked

  // Saves every line of the list to a text file.
  private void saveClicked() {
    try {
      PrintWriter fileOut = new PrintWriter(new File(BOOKINGS_FILE));
      for (int index = 0; index < bookingsModel.getSize(); index++) {
        fileOut.println(bookingsModel.getElementAt(index));
      } // for
      fileOut.close();
      JOptionPane.showMessageDialog(this, "Saved " + bookingsModel.getSize() + " lines to " + BOOKINGS_FILE + ".");
    } // try
    catch (FileNotFoundException error) {
      JOptionPane.showMessageDialog(this, BOOKINGS_FILE + " could not be saved.");
    } // catch
  } // saveClicked

  // Fills the list from the text file, one line per item.
  private void loadClicked() {
    try {
      Scanner fileIn = new Scanner(new File(BOOKINGS_FILE));
      bookingsModel.clear();
      while (fileIn.hasNextLine()) {
        bookingsModel.addElement(fileIn.nextLine());
      } // while
      fileIn.close();
      detailsButton.setEnabled(false);   // the list is only text now, not bookings
    } // try
    catch (FileNotFoundException error) {
      JOptionPane.showMessageDialog(this, "There is no " + BOOKINGS_FILE + " yet. Click Save first.");
    } // catch
  } // loadClicked

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
