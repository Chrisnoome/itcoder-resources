import java.awt.Font;
import java.io.File;

public class FontFacts {
  public static void main(String[] args) throws Exception {
    Font missing = new Font("Agency FB Condensed Pro", Font.PLAIN, 14);
    System.out.println("missing: family=" + missing.getFamily() + " name=" + missing.getName() + " fontName=" + missing.getFontName());
    Font there = new Font("Agency FB", Font.PLAIN, 14);
    System.out.println("installed: family=" + there.getFamily() + " name=" + there.getName());
    Font loaded = Font.createFont(Font.TRUETYPE_FONT, new File("FreeSerif.ttf"));
    System.out.println("loaded: family=" + loaded.getFamily() + " size=" + loaded.getSize() + " name=" + loaded.getFontName());
    try {
      Font.createFont(Font.TRUETYPE_FONT, new File("NoSuchFont.ttf"));
    } catch (Exception error) {
      System.out.println("missing file: " + error.getClass().getName() + ": " + error.getMessage());
    }
    try {
      Font.createFont(Font.TRUETYPE_FONT, new File("FontFacts.java"));
    } catch (Exception error) {
      System.out.println("not a font: " + error.getClass().getName() + ": " + error.getMessage());
    }
  }
}
