// One booking for the school play. It knows the rules and the prices, and
// never reads or prints anything.
public class Booking {
  public static final int STANDARD_PRICE = 80;
  public static final int VIP_PRICE = 150;

  private String name;
  private String cellNumber;
  private int tickets;
  private boolean isVip;

  // Makes an empty booking for one standard ticket.
  public Booking() {
    name = "";
    cellNumber = "";
    tickets = 1;
    isVip = false;
  } // Booking

  // Stores the name, or throws an exception that says how to fix it.
  // aName - the name and surname of the person booking
  public void setName(String aName) {
    if (aName.trim().length() == 0) {
      throw new IllegalArgumentException("Type a name - it can't be empty.");
    } // if
    name = aName.trim();
  } // setName

  // Stores the cell number, or throws an exception that says how to fix it.
  // aCellNumber - 10 digits, starting with 0
  public void setCellNumber(String aCellNumber) {
    boolean isDigits = true;
    for (int index = 0; index < aCellNumber.length(); index++) {
      if (!Character.isDigit(aCellNumber.charAt(index))) {
        isDigits = false;
      } // if
    } // for
    if (aCellNumber.length() != 10 || !isDigits || !aCellNumber.startsWith("0")) {
      throw new IllegalArgumentException("A cell number is 10 digits starting with 0, like 0821234567.");
    } // if
    cellNumber = aCellNumber;
  } // setCellNumber

  // Stores the number of tickets, or throws an exception that says how to fix it.
  // aTickets - from 1 to 6
  public void setTickets(int aTickets) {
    if (aTickets < 1 || aTickets > 6) {
      throw new IllegalArgumentException("You can book from 1 to 6 tickets.");
    } // if
    tickets = aTickets;
  } // setTickets

  // Stores whether the seats are VIP seats.
  // aIsVip - true for VIP seats, false for standard seats
  public void setIsVip(boolean aIsVip) {
    isVip = aIsVip;
  } // setIsVip

  // Gives back the name.
  // Gives back: the name and surname
  public String getName() {
    return name;
  } // getName

  // Gives back the cell number.
  // Gives back: the 10-digit cell number
  public String getCellNumber() {
    return cellNumber;
  } // getCellNumber

  // Gives back the number of tickets.
  // Gives back: from 1 to 6
  public int getTickets() {
    return tickets;
  } // getTickets

  // Gives back whether the seats are VIP seats.
  // Gives back: true for VIP seats
  public boolean getIsVip() {
    return isVip;
  } // getIsVip

  // Works out what the booking costs.
  // Gives back: the total in rand
  public int getTotal() {
    int total = tickets * STANDARD_PRICE;
    if (isVip) {
      total = tickets * VIP_PRICE;
    } // if
    return total;
  } // getTotal

  // Describes the booking in one line.
  // Gives back: such as "Thabo Mokoena: 2 VIP tickets, R300"
  @Override
  public String toString() {
    String seats = "standard";
    if (isVip) {
      seats = "VIP";
    } // if
    if (tickets == 1) {
      seats = seats + " ticket";
    } // if
    else {
      seats = seats + " tickets";
    } // else
    return name + ": " + tickets + " " + seats + ", R" + getTotal();
  } // toString
} // class Booking
