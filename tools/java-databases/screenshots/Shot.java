import java.awt.*;
import java.awt.image.BufferedImage;
import java.awt.image.MultiResolutionImage;
import java.io.File;
import java.io.PrintWriter;
import java.lang.reflect.Field;
import java.util.List;
import javax.imageio.ImageIO;
import javax.swing.*;

// Screenshot kit for lesson 24 (not part of the lesson): a white backdrop
// behind the window, then a Robot capture of the window without Windows 11's
// invisible resize border, at the screen's real pixels (125% here).
public class Shot {
  static String outDir = "out";
  static String prefix = "lesson25-";
  static JWindow back;
  static Rectangle lastCrop;
  static double scale = 1.25;

  // A white window behind the one being shot, so nothing else shows round its corners.
  static void backdrop(Rectangle aAround) {
    runOnEdt(() -> {
      if (back == null) {
        back = new JWindow();
        back.getContentPane().setBackground(Color.WHITE);
      }
      back.setBounds(aAround.x - 60, aAround.y - 60, aAround.width + 120, aAround.height + 120);
      back.setAlwaysOnTop(true);
      back.setVisible(true);
    });
  }

  static void runOnEdt(Runnable aJob) {
    try {
      if (SwingUtilities.isEventDispatchThread()) { aJob.run(); } else { SwingUtilities.invokeAndWait(aJob); }
    } catch (Exception e) { throw new RuntimeException(e); }
  }

  static void pause(int aMillis) {
    try { Thread.sleep(aMillis); } catch (InterruptedException e) { }
  }

  // Captures a decorated window (title bar and all) by its outer bounds and its side border.
  static void capture(Rectangle aBounds, int aSide, String aName) {
    Rectangle crop = new Rectangle(aBounds.x + aSide, aBounds.y, aBounds.width - 2 * aSide, aBounds.height - aSide);
    capturePlain(crop, aName);
  }

  static BufferedImage lastImage;
  static File lastFile;

  static void capturePlain(Rectangle aCrop, String aName) {
    try {
      lastCrop = aCrop;
      Robot robot = new Robot();
      MultiResolutionImage shot = robot.createMultiResolutionScreenCapture(aCrop);
      List<Image> variants = shot.getResolutionVariants();
      Image biggest = variants.get(variants.size() - 1);
      scale = biggest.getWidth(null) / (double) aCrop.width;
      BufferedImage out = new BufferedImage(biggest.getWidth(null), biggest.getHeight(null), BufferedImage.TYPE_INT_RGB);
      out.getGraphics().drawImage(biggest, 0, 0, null);
      new File(outDir).mkdirs();
      lastImage = out;
      lastFile = new File(outDir, prefix + aName + ".png");
      ImageIO.write(out, "png", lastFile);
      System.out.println("shot " + aName + " " + out.getWidth() + "x" + out.getHeight());
    } catch (Exception e) { throw new RuntimeException(e); }
  }

  // Puts a window on top of everything, in front, and asks for the focus. No
  // mouse clicks: a click could land on another program.
  static void activate(Window aWindow) {
    runOnEdt(() -> { aWindow.setAlwaysOnTop(true); aWindow.toFront(); aWindow.requestFocus(); });
    pause(400);
  }

  // A Swing window.
  static void window(Window aWindow, String aName) {
    pause(500);
    if (aWindow instanceof Frame || aWindow instanceof Dialog) { activate(aWindow); }
    Rectangle[] bounds = new Rectangle[1];
    int[] side = new int[1];
    runOnEdt(() -> { bounds[0] = aWindow.getBounds(); side[0] = Math.max(0, aWindow.getInsets().left - 1); });
    if (!(aWindow instanceof Frame || aWindow instanceof Dialog) || ((aWindow instanceof Frame) && ((Frame) aWindow).isUndecorated())) {
      side[0] = 0;
    }
    capture(bounds[0], side[0], aName);
    checkSwing(aWindow);
  }

  // Checks the last picture against a drawing of the same area made by the
  // program itself (aOwn, at 1x, whose top-left is at aLeft/aTop on the
  // screen). If they don't match, another window was in front: the picture is
  // deleted and the program stops, so nothing else on the screen is kept.
  static int[] average(BufferedImage aImage, int aX, int aY, int aSize) {
    long red = 0;
    long green = 0;
    long blue = 0;
    int n = 0;
    for (int y = aY - aSize; y <= aY + aSize; y++) {
      for (int x = aX - aSize; x <= aX + aSize; x++) {
        if (x < 0 || y < 0 || x >= aImage.getWidth() || y >= aImage.getHeight()) { continue; }
        int rgb = aImage.getRGB(x, y);
        red += (rgb >> 16) & 255;
        green += (rgb >> 8) & 255;
        blue += rgb & 255;
        n++;
      }
    }
    return n == 0 ? new int[] {0, 0, 0} : new int[] {(int) (red / n), (int) (green / n), (int) (blue / n)};
  }

  static void check(BufferedImage aOwn, int aLeft, int aTop) {
    int matched = 0;
    int tried = 0;
    for (int y = aOwn.getHeight() / 12; y < aOwn.getHeight(); y += Math.max(1, aOwn.getHeight() / 12)) {
      for (int x = aOwn.getWidth() / 12; x < aOwn.getWidth(); x += Math.max(1, aOwn.getWidth() / 12)) {
        int sx = (int) Math.round((aLeft - lastCrop.x + x) * scale);
        int sy = (int) Math.round((aTop - lastCrop.y + y) * scale);
        if (sx < 0 || sy < 0 || sx >= lastImage.getWidth() || sy >= lastImage.getHeight()) { continue; }
        tried++;
        int[] a = average(aOwn, x, y, 3);
        int[] b = average(lastImage, sx, sy, (int) Math.round(3 * scale));
        int difference = Math.abs(a[0] - b[0]) + Math.abs(a[1] - b[1]) + Math.abs(a[2] - b[2]);
        if (difference < 75) { matched++; }
      }
    }
    if (tried == 0 || matched < tried * 0.85) {
      lastFile.delete();
      System.out.println("CHECK FAILED for " + lastFile.getName() + " (" + matched + " of " + tried + ") - deleted");
      System.exit(1);
    }
    System.out.println("  check " + matched + "/" + tried);
  }

  // The same check for a Swing window: its content pane, drawn by Swing.
  static void checkSwing(Window aWindow) {
    BufferedImage[] own = new BufferedImage[1];
    Point[] where = new Point[1];
    runOnEdt(() -> {
      Container content = aWindow instanceof RootPaneContainer ? ((RootPaneContainer) aWindow).getContentPane() : aWindow;
      own[0] = new BufferedImage(Math.max(1, content.getWidth()), Math.max(1, content.getHeight()), BufferedImage.TYPE_INT_RGB);
      Graphics g = own[0].getGraphics();
      content.printAll(g);
      g.dispose();
      where[0] = content.getLocationOnScreen();
    });
    check(own[0], where[0].x, where[0].y);
  }

  // Where a component is on the last picture, in its pixels: x, y, width, height.
  static int[] where(Component aComponent) {
    int[][] box = new int[1][];
    runOnEdt(() -> {
      Point p = aComponent.getLocationOnScreen();
      box[0] = new int[] {(int) Math.round((p.x - lastCrop.x) * scale), (int) Math.round((p.y - lastCrop.y) * scale),
                          (int) Math.round(aComponent.getWidth() * scale), (int) Math.round(aComponent.getHeight() * scale)};
    });
    return box[0];
  }

  // Writes name = x,y,w,h lines for some components of the last picture.
  static void places(String aName, Object aForm, String... aFields) {
    try (PrintWriter out = new PrintWriter(new File(outDir, prefix + aName + ".txt"))) {
      for (String field : aFields) {
        int[] box = where((Component) get(aForm, field));
        out.println(field + "=" + box[0] + "," + box[1] + "," + box[2] + "," + box[3]);
      }
    } catch (Exception e) { throw new RuntimeException(e); }
  }

  // A private field of a form, by name.
  static Object get(Object aForm, String aField) {
    try {
      Class<?> type = aForm.getClass();
      while (type != null) {
        try {
          Field field = type.getDeclaredField(aField);
          field.setAccessible(true);
          return field.get(aForm);
        } catch (NoSuchFieldException e) { type = type.getSuperclass(); }
      }
      throw new RuntimeException("no field " + aField);
    } catch (IllegalAccessException e) { throw new RuntimeException(e); }
  }

  // Types into a text box the way a person does, one key at a time from the start.
  static void type(javax.swing.text.JTextComponent aBox, String aKeys) {
    runOnEdt(() -> {
      aBox.setCaretPosition(0);
      for (char key : aKeys.toCharArray()) { aBox.replaceSelection(String.valueOf(key)); }
    });
  }

  static void call(Object aForm, String aMethod) {
    try {
      java.lang.reflect.Method method = aForm.getClass().getDeclaredMethod(aMethod);
      method.setAccessible(true);
      method.invoke(aForm);
    } catch (Exception e) { throw new RuntimeException(e); }
  }
}
