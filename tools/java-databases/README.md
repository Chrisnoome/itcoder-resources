# java-databases - the programs behind Java lessons 25, 26 and 27

Added 26 September 2026. JDK 21 (`D:\xampp\jdk-21`). Nothing was downloaded:
sqlite-jdbc 3.48.0.0 was in `~/.m2/repository/org/xerial/sqlite-jdbc/`,
OpenJFX 21 in `~/.m2/repository/org/openjfx/`, and Derby 10.17.1.0 (derby,
derbyshared, derbytools) came from the jars fetched for `tools/sql-dialects`.

- `sqlite/` - lesson 25: MakeShop (makes TuckShop.db), Product, ProductsDB (all
  the SQL), ShopReport, ShopForm (Swing), and Facts/Facts2 (the JDBC error
  experiments quoted in the lesson). Run with
  `-cp ".;sqlite-jdbc-3.48.0.0.jar"`.
- `javafx/` - lesson 26: ShopApp (uses sqlite/'s Product and ProductsDB
  unchanged) and TableFacts (PropertyValueFactory mistakes, no window).
- `derby/` - lesson 27: MakeShopDB, ProductsDB with the jdbc:derby: URL,
  ShopReport, DerbyFacts, Open (the one-program lock, run twice), AllMethods,
  FxDerbyCheck (reads ShopApp's table instead of capturing), tuckshop.sql for
  ij. Run with `-cp ".;derby-10.17.1.0.jar;derbyshared-10.17.1.0.jar"`.
- `screenshots/` - lesson 24's kit (ui-screens/java-gui) with a settable
  file prefix, and the drivers ShotsShop / ShotsShopFx. Same rules: no
  clicks, always-on-top, every capture checked against the window's own
  drawing. Run them in a folder with a fresh TuckShop.db (MakeShop);
  `ShotsShop nodb` in an empty folder for the missing-table picture. Copy
  `out/lesson25-*.png` / `lesson26-*.png` to
  `AIPascalCourse/public/assets/lessons/java/`.

The lessons embed the sources as nowdocs (built by l25's assemble step, which
reads the .java files) - change a program -> paste it into the lesson again.
