// A toolbox of methods any program can use.
public class MyUtils {

  // Writes a heading with a line underneath it, the same length as the text.
  // aText      - the heading to write
  // aUnderline - the character the line under it is made of
  public static void writeHeading(String aText, char aUnderline) {
    System.out.println(aText);
    for (int position = 0; position < aText.length(); position++) {
      System.out.print(aUnderline);
    } // for
    System.out.println();
  } // writeHeading
} // class MyUtils
