// Exam number: 1234567

// The text interface: it only creates the manager and shows what it gives back.
public class RequestUI {
  public static void main(String[] args) {
    RequestManager manager = new RequestManager();   // 5.2 declare and instantiate
    manager.sortByName();                            // 5.3 call the sort
    System.out.println(manager);                     // 5.4 display - println calls toString
  } // main
} // class RequestUI
