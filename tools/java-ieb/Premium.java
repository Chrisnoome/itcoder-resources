// Exam number: 1234567

// A premium account: a free account with a licence and a number of devices.
public class Premium extends Free {
  private String licNo;
  private int qty;
  private String[] macArr;

  // Makes a premium account, with every device place marked Available.
  // inN - the owner's name
  // inE - the owner's e-mail address
  // inA - the date it was activated, like 14 07 2025
  // inL - the licence number
  // inQ - how many devices it may be used on
  public Premium(String inN, String inE, String inA, String inL, int inQ) {
    super(inN, inE, inA);   // the parent sets its own fields - FIRST
    licNo = inL;
    qty = inQ;
    macArr = new String[qty];
    for (int index = 0; index < qty; index++) {
      macArr[index] = "Available";
    } // for
  } // Premium

  // Describes the account: the free account's line, then the licence and devices.
  // Gives back: the line
  @Override
  public String toString() {
    return super.toString() + " " + licNo + " " + qty;
  } // toString
} // class Premium
