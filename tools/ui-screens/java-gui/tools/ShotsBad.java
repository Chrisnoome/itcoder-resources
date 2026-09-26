import java.awt.*;
import java.io.PrintWriter;
import java.io.File;
import javax.swing.*;

// Lesson 24's bad booking form (Swing): every mistake the lesson lists, with
// NetBeans' default names and texts left in. Absolute places, as a form
// dragged together without lining anything up.
public class ShotsBad {
  static JComponent put(JPanel aPanel, JComponent aComponent, int aX, int aY, int aWidth, int aHeight) {
    aComponent.setBounds(aX, aY, aWidth, aHeight);
    aPanel.add(aComponent);
    return aComponent;
  }

  public static void main(String[] args) throws Exception {
    UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
    JFrame[] holder = new JFrame[1];
    JComponent[] c = new JComponent[20];
    Shot.runOnEdt(() -> {
      JFrame f = new JFrame();
      f.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
      JPanel p = new JPanel(null);
      p.setBackground(new Color(255, 255, 0));
      JLabel title = new JLabel("BOOKINGS!!!");
      title.setFont(new Font("Jokerman", Font.PLAIN, 34));
      title.setForeground(new Color(255, 0, 0));
      c[0] = put(p, title, 150, 6, 300, 50);
      JLabel name = new JLabel("NAME:");
      c[1] = put(p, name, 4, 72, 80, 22);
      c[2] = put(p, new JTextField("jTextField1"), 90, 70, 150, 24);
      JLabel cell = new JLabel("cell no");
      c[3] = put(p, cell, 30, 108, 60, 22);
      c[4] = put(p, new JTextField("jTextField2"), 118, 106, 90, 24);
      JLabel tickets = new JLabel("Numbr Of Tikets");
      tickets.setFont(tickets.getFont().deriveFont(Font.BOLD));
      c[5] = put(p, tickets, 10, 146, 110, 22);
      c[6] = put(p, new JTextField("jTextField3"), 130, 150, 60, 24);
      JLabel seats = new JLabel("Seat's (VIP or normal)");
      seats.setFont(new Font("Comic Sans MS", Font.PLAIN, 13));
      c[7] = put(p, seats, 20, 186, 150, 22);
      c[8] = put(p, new JTextField("jTextField4"), 175, 184, 120, 24);
      JLabel date = new JLabel("date");
      c[9] = put(p, date, 44, 226, 40, 22);
      c[10] = put(p, new JTextField("jTextField5"), 96, 222, 170, 24);
      JTextArea notes = new JTextArea("jTextArea1");
      notes.setBackground(new Color(0, 255, 0));
      c[11] = put(p, notes, 330, 70, 180, 150);
      JButton big = new JButton("Click here to do the booking now!!!");
      big.setFont(new Font("Arial Black", Font.PLAIN, 16));
      c[12] = put(p, big, 120, 270, 380, 60);
      c[13] = put(p, new JButton("jButton2"), 6, 340, 90, 26);
      c[14] = put(p, new JButton("X"), 470, 8, 44, 30);
      p.setPreferredSize(new Dimension(520, 372));
      f.add(p);
      f.pack();
      f.setLocationRelativeTo(null);
      holder[0] = f;
    });
    JFrame f = holder[0];
    Shot.backdrop(f.getBounds());
    Shot.runOnEdt(() -> f.setVisible(true));
    Shot.window(f, "swing-bad");
    try (PrintWriter out = new PrintWriter(new File(Shot.outDir, "lesson24-swing-bad.txt"))) {
      String[] names = {"title", "nameLabel", "field1", "cellLabel", "field2", "ticketsLabel", "field3", "seatsLabel", "field4",
                        "dateLabel", "field5", "notes", "bigButton", "button2", "xButton"};
      for (int index = 0; index < names.length; index++) {
        int[] box = Shot.where(c[index]);
        out.println(names[index] + "=" + box[0] + "," + box[1] + "," + box[2] + "," + box[3]);
      }
    }
    System.exit(0);
  }
}
