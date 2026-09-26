// Runs the tests on Java DB (Derby, the Java DB form, in memory) or on
// UCanAccess (the Access form, on copies of work-ace/template.accdb, which
// real Access built). Usage: java -cp "jars/*" RunJdbc.java derby|ucan <dir>
import java.nio.file.*;
import java.sql.*;
import java.util.*;

public class RunJdbc {

    public static void main(String[] args) throws Exception {
        String mode = args[0];
        Path dir = Paths.get(args[1]);
        String dialect = mode.equals("derby") ? "derby" : "access";
        List<String> setup = new ArrayList<>();
        Map<String, Map<String, String>> tests = new LinkedHashMap<>();
        for (String line : Files.readAllLines(dir.resolve("tests-flat.tsv"))) {
            if (line.isEmpty()) continue;
            String[] p = line.split("\t", -1);
            if (p[0].equals("setup")) {
                if (p[1].equals("derby")) setup.add(p[2]);
                continue;
            }
            Map<String, String> t = tests.computeIfAbsent(p[1], k -> new HashMap<>());
            String form = p[2], kind = p[3], sql = p[4];
            if (kind.equals("main") && form.equals(dialect)) t.put("main", sql);
            if (kind.equals("check")) t.put("check", sql);
            if (kind.equals("checkDate") && (form.equals(dialect) || (form.equals("other") && dialect.equals("derby")))) t.put("checkDate", sql);
        }
        Path work = dir.resolve("work-" + mode);
        Files.createDirectories(work);
        StringBuilder out = new StringBuilder("{\n");
        boolean first = true;
        for (Map.Entry<String, Map<String, String>> e : tests.entrySet()) {
            Map<String, String> t = e.getValue();
            if (!t.containsKey("main")) continue;
            String id = e.getKey();
            StringBuilder res = new StringBuilder();
            Connection conn = null;
            try {
                if (mode.equals("derby")) {
                    conn = DriverManager.getConnection("jdbc:derby:memory:" + id + ";create=true");
                    try (Statement s = conn.createStatement()) { for (String q : setup) s.execute(q); }
                } else {
                    Path file = work.resolve(id + ".accdb");
                    Files.copy(dir.resolve("work-ace/template.accdb"), file, StandardCopyOption.REPLACE_EXISTING);
                    conn = DriverManager.getConnection("jdbc:ucanaccess://" + file.toAbsolutePath());
                }
                res.append("\"ok\": true, \"rows\": ").append(run(conn, t.get("main")));
                if (t.containsKey("check")) res.append(", \"check\": ").append(run(conn, t.get("check")));
                if (t.containsKey("checkDate")) res.append(", \"checkDate\": ").append(run(conn, t.get("checkDate")));
            } catch (Exception ex) {
                res.setLength(0);
                res.append("\"ok\": false, \"error\": ").append(str(String.valueOf(ex.getMessage())));
            } finally {
                if (conn != null) try { conn.close(); } catch (Exception ignored) { }
            }
            out.append(first ? "" : ",\n").append(str(id)).append(": {").append(res).append("}");
            first = false;
        }
        out.append("\n}\n");
        Files.writeString(dir.resolve("result-" + mode + ".json"), out.toString());
        System.out.println("done " + mode);
    } // main

    static String run(Connection conn, String sql) throws SQLException {
        try (Statement s = conn.createStatement()) {
            if (sql.trim().toUpperCase().matches("^(UPDATE|INSERT|DELETE).*")) {
                return "[[" + str("changed " + s.executeUpdate(sql)) + "]]";
            }
            StringBuilder b = new StringBuilder("[");
            try (ResultSet r = s.executeQuery(sql)) {
                int n = r.getMetaData().getColumnCount();
                boolean firstRow = true;
                while (r.next()) {
                    b.append(firstRow ? "[" : ", [");
                    firstRow = false;
                    for (int i = 1; i <= n; i++) {
                        if (i > 1) b.append(", ");
                        b.append(value(r.getObject(i)));
                    }
                    b.append("]");
                }
            }
            return b.append("]").toString();
        }
    } // run

    static String value(Object v) {
        if (v == null) return "null";
        if (v instanceof Boolean) return ((Boolean) v) ? "1" : "0";
        if (v instanceof java.util.Date || v instanceof java.time.temporal.TemporalAccessor) return str(v.toString().substring(0, 10));
        if (v instanceof Number) {
            java.math.BigDecimal d = new java.math.BigDecimal(v.toString()).stripTrailingZeros();
            return d.scale() <= 0 ? d.toBigInteger().toString() : d.toPlainString();
        }
        return str(v.toString());
    } // value

    static String str(String s) {
        StringBuilder b = new StringBuilder("\"");
        for (char c : s.toCharArray()) {
            if (c == '"' || c == '\\') b.append('\\').append(c);
            else if (c < 32) b.append(String.format("\\u%04x", (int) c));
            else b.append(c);
        }
        return b.append("\"").toString();
    } // str
} // RunJdbc
