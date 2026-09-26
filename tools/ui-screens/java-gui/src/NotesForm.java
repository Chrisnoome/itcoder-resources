import java.awt.BorderLayout;
import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Font;
import javax.swing.BorderFactory;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JList;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JSplitPane;
import javax.swing.JTextArea;
import javax.swing.UIManager;

// A window that grows properly: a bar along the top, a list and a notes box
// with a splitter between them, buttons in the bottom right and a status bar.
public class NotesForm extends JFrame {
  private JList<String> pupilsList;
  private JTextArea notesArea;
  private JButton saveButton;
  private JButton cancelButton;
  private JLabel statusLabel;

  // Builds the window with layout managers - no component has a fixed place.
  public NotesForm() {
    setTitle("Pupil notes");
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

    // The top: a navy bar, as wide as the window
    JPanel titleBar = new JPanel(new FlowLayout(FlowLayout.LEFT, 12, 8));
    titleBar.setBackground(new Color(31, 58, 95));
    JLabel titleLabel = new JLabel("Notes on each pupil");
    titleLabel.setForeground(Color.WHITE);
    titleLabel.setFont(new Font("Segoe UI", Font.BOLD, 16));
    titleBar.add(titleLabel);
    add(titleBar, BorderLayout.NORTH);

    // The middle: the list and the notes, with a splitter between them
    pupilsList = new JList<String>(new String[] {"Thabo Mokoena", "Lebo Dlamini", "Pieter van der Merwe", "Aisha Patel"});
    notesArea = new JTextArea("Wants to join the chess club.");
    notesArea.setFont(pupilsList.getFont());   // the Windows look gives a JTextArea a typewriter font
    JSplitPane middle = new JSplitPane(JSplitPane.HORIZONTAL_SPLIT, new JScrollPane(pupilsList), new JScrollPane(notesArea));
    middle.setDividerLocation(160);
    middle.setBorder(BorderFactory.createEmptyBorder(8, 8, 8, 8));
    add(middle, BorderLayout.CENTER);

    // The bottom: the buttons on the right, then the status bar
    saveButton = new JButton("Save");
    cancelButton = new JButton("Cancel");
    JPanel buttons = new JPanel(new FlowLayout(FlowLayout.RIGHT, 8, 0));
    buttons.add(saveButton);
    buttons.add(cancelButton);
    statusLabel = new JLabel("4 pupils");
    statusLabel.setBorder(BorderFactory.createEmptyBorder(6, 8, 4, 8));
    JPanel bottom = new JPanel(new BorderLayout());
    bottom.add(buttons, BorderLayout.NORTH);
    bottom.add(statusLabel, BorderLayout.SOUTH);
    add(bottom, BorderLayout.SOUTH);

    setSize(520, 300);
    setLocationRelativeTo(null);
  } // NotesForm

  public static void main(String[] args) {
    try {
      UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    } // try
    catch (Exception error) {
      System.out.println("Using Java's own look instead.");
    } // catch
    NotesForm form = new NotesForm();
    form.setVisible(true);
  } // main
} // class NotesForm
