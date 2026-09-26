// Exam number: 1234567
import java.time.LocalDate;

// A free software account.
public class Free {
  private String name;
  private String email;
  private LocalDate actDate;

  // Makes a free account.
  // inN - the owner's name
  // inE - the owner's e-mail address
  // inA - the date it was activated, like 15 06 2025
  public Free(String inN, String inE, String inA) {
    name = inN;
    email = inE;

    // inA looks like "15 06 2025": day, space, month, space, year
    String[] dateParts = inA.split(" ");
    int day = Integer.parseInt(dateParts[0]);
    int month = Integer.parseInt(dateParts[1]);
    int year = Integer.parseInt(dateParts[2]);
    actDate = LocalDate.of(year, month, day);
  } // Free

  // Gives back the owner's name.
  // Gives back: the name
  public String getName() {
    return name;
  } // getName

  // Changes the owner's e-mail address.
  // inE - the new address
  public void setEmail(String inE) {
    email = inE;
  } // setEmail

  // Describes the account on one line: name, e-mail and date, one space apart.
  // Gives back: the line, like Madelyyn Smythe smythem@upe.ac.za 2025-07-12
  @Override
  public String toString() {
    return name + " " + email + " " + actDate;
  } // toString
} // class Free
