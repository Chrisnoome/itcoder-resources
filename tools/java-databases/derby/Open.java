import java.sql.*;
public class Open {
  public static void main(String[] args) throws Exception {
    try {
      Connection db = DriverManager.getConnection("jdbc:derby:TuckShopDB");
      System.out.println("opened");
      if (args.length > 0) { Thread.sleep(Integer.parseInt(args[0])); }
      db.close();
    } catch (SQLException error) {
      System.out.println("[" + error.getSQLState() + "] " + error.getMessage());
      Throwable next = error.getNextException();
      while (next != null) { System.out.println("  next: " + next.getMessage()); next = next instanceof SQLException ? ((SQLException) next).getNextException() : null; }
      Throwable cause = error.getCause();
      while (cause != null) { System.out.println("  cause: " + cause.getMessage()); cause = cause.getCause(); }
    }
  }
}
