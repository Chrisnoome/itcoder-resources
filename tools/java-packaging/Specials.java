import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

// Shows the tuck shop's specials, read from specials.txt (one line each, like Pie#18.50).
public class Specials {
  public static final String SPECIALS_FILE = "specials.txt";

  public static void main(String[] args) {
    MyUtils.writeHeading("Tuck shop specials", '=');
    try {
      Scanner fileIn = new Scanner(new File(SPECIALS_FILE));
      while (fileIn.hasNextLine()) {
        String[] parts = fileIn.nextLine().split("#");
        System.out.println(parts[0] + " - R" + parts[1]);
      } // while
      fileIn.close();
    } // try
    catch (FileNotFoundException error) {
      System.out.println("Can't find " + SPECIALS_FILE + ". It must be in the folder the program is started from.");
    } // catch
  } // main
} // class Specials
