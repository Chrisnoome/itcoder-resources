import java.awt.*;
import java.util.Calendar;
import java.util.Date;
import javax.swing.*;
import javax.swing.border.TitledBorder;
import javax.swing.table.DefaultTableModel;
import javax.swing.text.MaskFormatter;

// Lesson 24's component pictures (Swing), built in code only for the pictures.
// Each component has a grey note: its class and a name in the course's style.
public class SwingGallery {
  static JPanel grid;
  static int row;
  static java.util.Map<String, Component> named = new java.util.LinkedHashMap<>();

  static JFrame frame(String aTitle) {
    JFrame frame = new JFrame(aTitle);
    frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    grid = new JPanel(new GridBagLayout());
    grid.setBorder(BorderFactory.createEmptyBorder(10, 12, 10, 12));
    row = 0;
    frame.add(grid);
    return frame;
  }

  static void add(Component aComponent, String aNote, String aName) {
    GridBagConstraints place = new GridBagConstraints();
    place.gridy = row++;
    place.insets = new Insets(5, 4, 5, 12);
    place.anchor = GridBagConstraints.WEST;
    place.gridx = 0;
    grid.add(aComponent, place);
    JLabel note = new JLabel(aNote);
    note.setForeground(new Color(128, 128, 128));
    note.setFont(note.getFont().deriveFont(Font.ITALIC));
    place.gridx = 1;
    grid.add(note, place);
    named.put(aName, aComponent);
  }

  static MaskFormatter mask(String aMask) {
    try {
      MaskFormatter m = new MaskFormatter(aMask);
      m.setPlaceholderCharacter('_');
      return m;
    } catch (Exception e) { throw new RuntimeException(e); }
  }

  static JFrame textWindow() {
    JFrame f = frame("Components for typing");
    JLabel heading = new JLabel("Your details");
    heading.setFont(heading.getFont().deriveFont(Font.BOLD, 14f));
    add(heading, "JLabel - headingLabel", "headingLabel");
    add(new JTextField("Thabo Mokoena", 16), "JTextField - nameField", "nameField");
    JPasswordField password = new JPasswordField("secret123", 16);
    add(password, "JPasswordField - passwordField", "passwordField");
    JTextField shown = new JTextField("R300", 16);
    shown.setEditable(false);
    add(shown, "JTextField, not editable - totalField", "totalField");
    JFormattedTextField cell = new JFormattedTextField(mask("### ### ####"));
    cell.setColumns(16);
    cell.setFocusLostBehavior(JFormattedTextField.PERSIST);
    cell.setCaretPosition(0);
    for (char key : "082123".toCharArray()) { cell.replaceSelection(String.valueOf(key)); }
    add(cell, "JFormattedTextField with a mask - cellField", "cellField");
    JTextArea notes = new JTextArea("Wheelchair seat, please.\nArrives at 18:30.\nPaid at the office.", 3, 16);
    notes.setBorder(BorderFactory.createLineBorder(new Color(170, 170, 170)));
    notes.setFont(cell.getFont());
    add(notes, "JTextArea - notesArea", "notesArea");
    f.pack();
    return f;
  }

  static JFrame chooseWindow() {
    JFrame f = frame("Components for choosing");
    JCheckBox bus = new JCheckBox("Takes the school bus", true);
    add(bus, "JCheckBox - busCheck", "busCheck");
    JRadioButton morning = new JRadioButton("Morning", true);
    JRadioButton afternoon = new JRadioButton("Afternoon");
    ButtonGroup times = new ButtonGroup();
    times.add(morning);
    times.add(afternoon);
    JPanel pair = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
    pair.add(morning);
    pair.add(afternoon);
    add(pair, "JRadioButton x 2, in a ButtonGroup - morningRadio", "morningRadio");
    JPanel houses = new JPanel(new GridLayout(2, 2));
    houses.setBorder(BorderFactory.createTitledBorder("House"));
    ButtonGroup houseGroup = new ButtonGroup();
    for (String house : new String[] {"Red", "Blue", "Green", "Yellow"}) {
      JRadioButton radio = new JRadioButton(house, house.equals("Blue"));
      houseGroup.add(radio);
      houses.add(radio);
    }
    add(houses, "JRadioButtons in a titled JPanel - housePanel", "housePanel");
    JComboBox<String> province = new JComboBox<String>(new String[] {"Eastern Cape", "Free State", "Gauteng", "KwaZulu-Natal",
        "Limpopo", "Mpumalanga", "North West", "Northern Cape", "Western Cape"});
    province.setSelectedItem("Gauteng");
    add(province, "JComboBox - provinceCombo", "provinceCombo");
    JList<String> list = new JList<String>(new String[] {"Thabo Mokoena", "Lebo Dlamini", "Pieter van der Merwe", "Aisha Patel"});
    list.setSelectedIndex(1);
    list.setVisibleRowCount(4);
    JScrollPane scroll = new JScrollPane(list);
    scroll.setPreferredSize(new Dimension(180, 84));
    add(scroll, "JList - bookingsList", "bookingsList");
    f.pack();
    return f;
  }

  static JFrame numbersWindow() {
    JFrame f = frame("Components for numbers and dates");
    JSpinner tickets = new JSpinner(new SpinnerNumberModel(2, 1, 6, 1));
    add(tickets, "JSpinner, whole numbers - ticketsSpinner", "ticketsSpinner");
    JSpinner mass = new JSpinner(new SpinnerNumberModel(2.5, 0.1, 30.0, 0.1));
    add(mass, "JSpinner, decimals - massSpinner", "massSpinner");
    JSlider volume = new JSlider(0, 10, 7);
    volume.setMajorTickSpacing(1);
    volume.setPaintTicks(true);
    add(volume, "JSlider - volumeSlider", "volumeSlider");
    Calendar when = Calendar.getInstance();
    when.set(2010, Calendar.MARCH, 21);
    JSpinner birthday = new JSpinner(new SpinnerDateModel(when.getTime(), null, null, Calendar.DAY_OF_MONTH));
    birthday.setEditor(new JSpinner.DateEditor(birthday, "dd/MM/yyyy"));
    add(birthday, "JSpinner, dates - birthdaySpinner", "birthdaySpinner");
    f.pack();
    return f;
  }

  static JFrame containersWindow() {
    JFrame f = new JFrame("Components that hold components");
    f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
    JMenuBar menus = new JMenuBar();
    for (String menu : new String[] {"File", "Edit", "View", "Help"}) { menus.add(new JMenu(menu)); }
    f.setJMenuBar(menus);
    JPanel top = new JPanel(new FlowLayout(FlowLayout.LEFT, 8, 6));
    top.setBackground(new Color(31, 58, 95));
    JLabel search = new JLabel("Search:");
    search.setForeground(Color.WHITE);
    top.add(search);
    top.add(new JTextField("Patel", 12));
    top.add(new JButton("Find"));
    f.add(top, BorderLayout.NORTH);
    JPanel contact = new JPanel(new GridLayout(2, 2, 6, 6));
    contact.setBorder(BorderFactory.createTitledBorder("Contact details"));
    contact.add(new JLabel("Cell"));
    contact.add(new JTextField("0821234567"));
    contact.add(new JLabel("E-mail"));
    contact.add(new JTextField("thabo@school.co.za"));
    JTabbedPane tabs = new JTabbedPane();
    DefaultTableModel marks = new DefaultTableModel(new Object[][] {{"Thabo", 67, 72}, {"Lebo", 82, 79}, {"Pieter", 45, 58}},
                                                    new Object[] {"Name", "Term 1", "Term 2"});
    JTable table = new JTable(marks);
    JScrollPane tableScroll = new JScrollPane(table);
    tableScroll.setPreferredSize(new Dimension(300, 90));
    tabs.addTab("Marks", tableScroll);
    tabs.addTab("Attendance", new JPanel());
    tabs.addTab("Reports", new JPanel());
    JPanel middle = new JPanel(new BorderLayout(8, 8));
    middle.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
    middle.add(contact, BorderLayout.NORTH);
    middle.add(tabs, BorderLayout.CENTER);
    f.add(middle, BorderLayout.CENTER);
    JLabel status = new JLabel("3 pupils      Term 2      Saved");
    status.setBorder(BorderFactory.createCompoundBorder(BorderFactory.createMatteBorder(1, 0, 0, 0, new Color(200, 200, 200)),
                                                        BorderFactory.createEmptyBorder(3, 8, 3, 8)));
    f.add(status, BorderLayout.SOUTH);
    named.put("menus", menus);
    named.put("top", top);
    named.put("contact", contact);
    named.put("tabs", tabs);
    named.put("table", table);
    named.put("status", status);
    f.pack();
    f.setSize(470, f.getHeight());
    return f;
  }

  // Buttons with the pictures Swing already has: the metaphors section.
  static JFrame iconsWindow() {
    JFrame f = frame("Pictures on buttons");
    String[][] buttons = {
      {"Save", "FileView.floppyDriveIcon"}, {"Open", "FileView.directoryIcon"}, {"Computer", "FileView.computerIcon"},
      {"New folder", "FileChooser.newFolderIcon"}, {"Help", "OptionPane.questionIcon"}, {"Information", "OptionPane.informationIcon"},
      {"Warning", "OptionPane.warningIcon"}, {"Error", "OptionPane.errorIcon"}};
    JPanel strip = new JPanel(new GridLayout(2, 4, 8, 8));
    for (String[] button : buttons) {
      JButton b = new JButton(button[0], UIManager.getIcon(button[1]));
      b.setHorizontalAlignment(SwingConstants.LEFT);
      strip.add(b);
    }
    grid.add(strip);
    f.pack();
    return f;
  }

  static void shoot(JFrame aFrame, String aName) {
    Shot.backdrop(aFrame.getBounds());
    Shot.runOnEdt(() -> { aFrame.setLocationRelativeTo(null); aFrame.setVisible(true); aFrame.toFront(); });
    Shot.backdrop(aFrame.getBounds());
    Shot.runOnEdt(() -> { aFrame.toFront(); KeyboardFocusManager.getCurrentKeyboardFocusManager().clearGlobalFocusOwner(); });
    Shot.pause(300);
    Shot.runOnEdt(() -> KeyboardFocusManager.getCurrentKeyboardFocusManager().clearGlobalFocusOwner());
    Shot.window(aFrame, aName);
    try (java.io.PrintWriter out = new java.io.PrintWriter(new java.io.File(Shot.outDir, "lesson24-" + aName + ".txt"))) {
      for (java.util.Map.Entry<String, Component> entry : named.entrySet()) {
        int[] box = Shot.where(entry.getValue());
        out.println(entry.getKey() + "=" + box[0] + "," + box[1] + "," + box[2] + "," + box[3]);
      }
    } catch (Exception e) { throw new RuntimeException(e); }
    named.clear();
    Shot.runOnEdt(() -> aFrame.dispose());
  }

  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    JFrame[] f = new JFrame[1];
    Shot.runOnEdt(() -> f[0] = textWindow());
    shoot(f[0], "swing-text");
    Shot.runOnEdt(() -> f[0] = chooseWindow());
    shoot(f[0], "swing-choose");
    Shot.runOnEdt(() -> f[0] = numbersWindow());
    shoot(f[0], "swing-numbers");
    Shot.runOnEdt(() -> f[0] = containersWindow());
    shoot(f[0], "swing-containers");
    Shot.runOnEdt(() -> f[0] = iconsWindow());
    shoot(f[0], "swing-icons");
    System.exit(0);
  }
}
