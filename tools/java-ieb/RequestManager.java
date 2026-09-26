// Exam number: 1234567
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

// Keeps every account from Accounts.txt in one array.
public class RequestManager {
  private Free[] accArr;
  private int accSize;

  // Reads Accounts.txt: a line with 5 fields is a premium account, 3 a free one.
  public RequestManager() {
    accArr = new Free[40];
    accSize = 0;
    try {
      Scanner fileIn = new Scanner(new File("Accounts.txt"));
      while (fileIn.hasNextLine() && accSize < accArr.length) {
        String[] parts = fileIn.nextLine().split("#");

        // The number of fields decides the class
        if (parts.length == 5) {
          accArr[accSize] = new Premium(parts[0], parts[1], parts[2], parts[3], Integer.parseInt(parts[4]));
        } // if
        else {
          accArr[accSize] = new Free(parts[0], parts[1], parts[2]);
        } // else
        accSize++;
      } // while
      fileIn.close();
    } // try
    catch (FileNotFoundException error) {
      System.out.println("Accounts.txt could not be read - check it is in the program's folder.");
    } // catch
  } // RequestManager

  // Puts the accounts in alphabetical order of name, with a selection sort.
  public void sortByName() {
    for (int outer = 0; outer < accSize - 1; outer++) {
      for (int inner = outer + 1; inner < accSize; inner++) {
        if (accArr[inner].getName().compareTo(accArr[outer].getName()) < 0) {
          Free temp = accArr[outer];
          accArr[outer] = accArr[inner];
          accArr[inner] = temp;
        } // if
      } // for inner
    } // for outer
  } // sortByName

  // Lists every account, one per line.
  // Gives back: the list
  @Override
  public String toString() {
    String list = "";
    for (int index = 0; index < accSize; index++) {
      list = list + accArr[index] + "\n";
    } // for
    return list;
  } // toString
} // class RequestManager
