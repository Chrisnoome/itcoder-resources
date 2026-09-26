// Loads an IEB .sql script statement by statement into an in-memory Derby
// database, or (with a jdbc URL as the second argument) into another engine,
// and reports each statement and the row counts. Usage:
// java -cp "jars/*" LoadSql.java file.sql [jdbcUrl]
import java.nio.file.*;
import java.sql.*;

public class LoadSql {

    public static void main(String[] args) throws Exception {
        String text = Files.readString(Paths.get(args[0]));
        String url = args.length > 1 ? args[1] : "jdbc:derby:memory:ieb" + System.nanoTime() + ";create=true";
        try (Connection conn = DriverManager.getConnection(url); Statement s = conn.createStatement()) {
            int n = 0;
            for (String part : text.split(";")) {
                String sql = part.trim();
                if (sql.isEmpty()) continue;
                n++;
                String head = sql.replaceAll("\\s+", " ");
                head = head.substring(0, Math.min(60, head.length()));
                try {
                    s.execute(sql);
                    System.out.println("  ok   " + n + ": " + head);
                } catch (SQLException ex) {
                    System.out.println("  FAIL " + n + ": " + head + "\n         " + ex.getMessage());
                }
            }
            DatabaseMetaData md = conn.getMetaData();
            try (ResultSet t = md.getTables(null, null, "%", new String[] {"TABLE"})) {
                while (t.next()) {
                    String name = t.getString("TABLE_NAME");
                    try (Statement c = conn.createStatement(); ResultSet r = c.executeQuery("SELECT COUNT(*) FROM " + name)) {
                        r.next();
                        System.out.println("  table " + name + ": " + r.getInt(1) + " rows");
                    }
                }
            }
        }
    } // main
} // LoadSql
