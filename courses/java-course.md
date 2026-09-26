# Course: Programming in Java (`java`)

`Projects/AIPascalCourse/content/java/`, status `open` - live for pupils,
with Java in the live console (Chris, 26 September 2026; draft while it was
written from 25 September). IEB IT Grades 10-12. **The Pascal course
converted to Java** (Chris, 25 September 2026: "take the pascal course and
convert to java for the ieb sags"). Code: [../java-house-style.md](../java-house-style.md);
voice and lesson rules: [../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md)
(every rule there applies, with Java for Pascal); syllabus:
[../sags-topic4-syllabus.md](../sags-topic4-syllabus.md). Other chats may be
editing the same files - edit exactly, never overwrite unread work.

## Chris's brief (25 September 2026)

- **IEB only - no CAPS.** CAPS schools use Pascal/Delphi, so the Java course
  has `sags.php` and no `caps.php`, no CAPS-stream lessons, no CAPS exam
  guide, and lesson 1 teaches computational thinking without Polya's CAPS
  names.
- **GUI lessons: Swing and JavaFX** side by side where Pascal has Lazarus and
  Delphi.
- **The console runs Java** (javac + java in the sandbox, JDK 21).
- **Pupils are warned that Java is slow in the console** (Chris, 25
  September 2026: "they should feel free to use their own machine instead
  (the best option), but if they are using a phone or tablet then the
  console will work"). Said in three places - keep them in step: the
  console's first Java Run on a page and its "Compiling…" status
  (`public/assets/console.js`), the Java Help
  (`content/console/help-java.php`), and lesson 3's "Which one should you
  use?". Measured: ~0.75 s a Run alone, ~8 s for a class of 30
  (../vps-access.md, Capacity).
- **Its own glossary and index, its own games** (Practice is built from the
  course glossary automatically).
- **I/O is `System.out` and `System.in`** (a `Scanner`); `String.split` for
  delimiters.
- **Same basic principles as the Pascal course - no advanced techniques**
  (no ArrayList, generics, streams, lambdas beyond a GUI's event line).
- **New lessons:** making a Java program others can run (executable jar,
  jpackage); Java IDEs (jGRASP, NetBeans, BlueJ, IntelliJ IDEA, Eclipse, VS
  Code); **Java DB (Apache Derby) as an alternative to SQLite** - the IEB
  gives the SQL exam database as Access, Java DB or MySQL.
- Braces K&R with end comments; parameters `aName`, with a lesson-16 note and
  diagram on `this` (other code uses the field's own name + `this`).

## Lesson ids are not lesson numbers - never rename

Same rule as Pascal: the key in `content/java/index.php` is the lessonId, a
database key. The ids were chosen to match the first numbering.

## Lessons (plan; status column updated as each is built)

| # | Id | Title | From Pascal | Status |
|---|---|---|---|---|
| 1 | lesson01 | What you learn when you learn programming | lesson01 (no Polya) | built 25 Sep |
| 2 | lesson02 | Proof of Life / Output - println and print | proofoflife | built 25 Sep |
| 3 | lesson03 | Where you write Java - IDEs | new | built 25 Sep |
| 4 | lesson04 | Making it pretty | lesson03 (import as the idea of units; ANSI colour and cursor codes) - enrichment | built 25 Sep |
| 5 | lesson05 | How to remember - Variables and constants | lesson02 | built 25 Sep |
| 6 | lesson06 | Getting input - Scanner | lesson05 | built 25 Sep |
| 7 | lesson07 | Processing - basic maths | lesson06 | built 25 Sep |
| 8 | lesson08 | Type conversion | lesson07 | built 25 Sep |
| 9 | lesson09 | Decisions / Branching | lesson08 | built 25 Sep |
| 10 | lesson10 | Division - / and % | lesson09 | built 25 Sep |
| 11 | lesson11 | For loops | lesson10 | built 25 Sep |
| 12 | lesson12 | Looped algorithms | lesson11 | built 25 Sep |
| 13 | lesson13 | Flexible loops - while and do-while | lesson12 | built 25 Sep |
| 14 | lesson14 | Working with text - Strings | lesson13 | built 25 Sep |
| 15 | lesson15 | Methods, parameters and classes of tools | lesson14 | built 25 Sep |
| 16 | lesson16 | Arrays | lesson15 | built 25 Sep |
| 17 | lesson17 | Classes and objects (+ `this`) | lesson16 | built 25 Sep |
| 18 | lesson18 | Persistence - Text files | lesson17 | built 25 Sep |
| 19 | lesson19 | Catching errors - Defensive programming | lesson18 | built 25 Sep |
| 20 | lesson20 | Dates and times (java.time) | lesson19 | built 25 Sep |
| 21 | lesson21 | Managing a list - the array manager class | lesson20 | built 25 Sep |
| 22 | lesson22 | Inheritance and polymorphism | lesson21 | built 25 Sep |
| 23 | lesson23 | Text user interfaces | lesson22 | built 25 Sep |
| 24 | lesson24 | GUI design - Swing and JavaFX | lesson23 | built 26 Sep |
| 25 | lesson25 | SQLite databases in Swing | capssqlitedelphi | built 26 Sep |
| 26 | lesson26 | SQLite databases in JavaFX | capssqlitelazarus | built 26 Sep |
| 27 | lesson27 | Java DB - an alternative to SQLite | new | built 26 Sep |
| 28 | lesson28 | Making a program others can run | new | built 26 Sep |
| IEB | examieb | Practical exam guide - IEB | lesson24 | built 26 Sep |
| IEB | dvtieb | The data validation task - IEB | lesson26 | built 26 Sep |
| IEB | patieb | The PAT - IEB | lesson27 | built 26 Sep |

Not converted: lesson25 (CAPS exam guide), capspat10/11/12, capsalttask.

## Verified Java facts used in lessons

(JDK 21 - the local `C:\Users\chris\.jdks\openjdk-21.0.2`, the server's
openjdk-21-jdk-headless. Every output and error in a lesson comes from a real
javac/java run; record the surprising ones here.)

- javac messages (JDK 21): missing `;` -> `';' expected` with a caret; a missing
  closing brace -> `reached end of file while parsing`; unknown name ->
  `cannot find symbol` + `symbol: variable age` + `location: class X`;
  `system.out` -> `package system does not exist`; `Println` -> `cannot find
  symbol ... method Println(String) ... location: variable out of type
  PrintStream`; `public class class` -> `<identifier> expected` twice; a
  broken class header also gives `unnamed classes are a preview feature and
  are disabled by default` (JDK 21 - avoid starters that trigger it);
  `mian` instead of main compiles, then `Error: Main method not found in
  class NoMain, please define the main method as: ...`; file/class name
  mismatch -> `class Hello is public, should be declared in a file named
  Hello.java`; a `package` line run outside its folder -> `NoClassDefFoundError:
  Hello (wrong name: hello/Hello)`.
- `"Total: " + 12 + 8` prints `Total: 128`; `"Score: " + 15 - 6` does not
  compile (`bad operand types for binary operator '-'`).
- `String.format("%.2f", x)` rounds HALF_UP on the shortest decimal form:
  2.675 -> 2.68, 1.005 -> 1.01, 0.05 -> 0.1 at 1 place, `%.0f` of 2.5 -> 3.
  `"%2f"` of 3.14159265 -> 3.141593. `String.format("%.2f", 5)` throws
  `IllegalFormatConversionException: f != java.lang.Integer`; `%d` of 3.5 ->
  `d != java.lang.Double`. The en-ZA locale prints `1234,50` - the course's
  JVM flags fix `-Duser.language=en -Duser.country=` so every machine prints
  a point (the server's default is `en` anyway).
- `System.out.println(0.1 + 0.2)` -> `0.30000000000000004`; `15.50 + 9.99` ->
  `25.490000000000002`; `3.14159265` prints as is.
- Types: `int score = 3.5;` -> `incompatible types: possible lossy conversion
  from double to int`; `String cannot be converted to int`; `int cannot be
  converted to boolean`; `True` -> `cannot find symbol ... variable True`;
  `int x = 9901015800083;` -> `integer number too large`; a local used with
  no value -> `variable total might not have been initialized`; changing a
  constant -> `cannot assign a value to static final variable VAT_RATE`.
- `new Random(2026)`: nextInt(6) + 1 gives 6, 5, 2 every run.
- Integer overflow wraps silently: 2147483647 + 1 -> -2147483648;
  50000 * 50000 -> -1794967296. `10.0 / 0` -> Infinity; `Math.sqrt(-4)` ->
  NaN; `7 / 0` -> `ArithmeticException: / by zero`; `-7 / 2` = -3, `-7 % 2` =
  -1; `Math.round(2.5)` = 3, `Math.round(-2.5)` = -2; `(int) -3.99` = -3.
- Scanner: nextInt on "abc" -> `java.util.InputMismatchException` (stops the
  program); after nextInt, nextLine gives "". `Integer.parseInt(" 12")` and
  `"12.5"` -> NumberFormatException; `Double.parseDouble(" 12.5 ")` -> 12.5.
- Decisions: a typed `"Thabo" == "Thabo"` is false (two written-in literals
  are true, which is why `==` seems to work); `"Zebra".compareTo("apple")` is
  -7; `if (x = 50)` -> `int cannot be converted to boolean`; `if (...);` and
  `for (...);` compile and ignore the condition; `while (...);` hangs; `!age
  >= 18` -> `bad operand type int for unary operator '!'`; `10 < age < 20` ->
  `bad operand types for binary operator '<'`; a switch on a double ->
  `selector type double is not allowed`; a missing `break` falls through.
- Loops: Java COMPILES a changed for counter (1..10 with `counter = counter +
  1` inside prints 1 3 5 7 9) - the console's style check refuses it
  (`noCounterChange`, lesson 11). A for counter is gone after the loop
  (`cannot find symbol`); the same name in a nested loop -> `variable counter
  is already defined`. `do { ... } while (c);` keeps going while c is TRUE (not
  Until's flip); a variable declared inside the do is not visible in its while.
- `-7 % 2` is -1, so `if (n % 2 == 1)` calls -7 even - test `== 0`.

## Platform changes made for the Java course (25 September 2026)

- `lib/flowchart.php`: step type `dowhile` (Yes goes round again, No leaves) for
  Java's do ... while; `repeat` is unchanged.
- `lib/javastyle.php`: rule `noCounterChange` in the lesson-11 loop rules;
  `JavaFlattenBrackets` fixed so a for line with a method call in its test
  (`position < message.length()`) is one instruction (it was flagged "more
  than one thing on this line").
- Java lesson listings: a bare `<` inside `<pre>` must be `&lt;` (the checker's
  strip_tags cut `row <= 4` short). Pseudocode listings are `no-console
  not-java`; a listing a question asks "does it compile?" about is `no-console`.
- Try-its live in `public/assets/java-tryit.js` (names start `java`); the
  generic `flowStepper` and the language-free `caesarWheel` are shared with
  Pascal. A `<pre class="no-console">` fragment must end in `;` or a brace, or
  the checker takes it for output.
- Strings (lesson 14, verified JDK 21): positions from 0; a String is
  immutable (`answer.toUpperCase();` alone changes nothing); `substring(start,
  end)` excludes `end` and throws `Range [7, 107) out of bounds for length 13`
  where Pascal's Copy forgave; `indexOf` is -1 when missing; `replace`
  replaces EVERY match, case-sensitive; `split` drops trailing empty pieces
  and reads its delimiter as a pattern (`split(".")` gives 0 pieces);
  `%05d` zero-pads (Free Pascal needed `%.5d`); `%s` takes anything; `%f`
  follows the region (en_ZA printed `12,50`). `split` brings `String[]` in
  before lesson 16 - only `pieces[0]` and `pieces.length` are used.
- Methods (lesson 15, verified JDK 21): every method is `public static` until
  lesson 17; missing static -> `non-static method sayHello() cannot be
  referenced from a static context`; method order in a class does not matter
  (the course writes helpers above main); a missing return is a compile error
  (`missing return statement`, also when the only return is inside an if);
  `'void' type not allowed here`; a call's wrong count -> `cannot be applied
  to given types;` + required/found/reason; a char quietly fills an int
  parameter (`drawLine('=', '*')` prints 61 stars). `addVat(100)` prints
  114.99999999999999. Pascal's units became a class of tools in its own file
  (`MyUtils.java`, called `MyUtils.countVowels(...)`), public = menu,
  private = kitchen (`has private access in MyUtils`); Pascal's Initialization
  Good to Know became overloading, Var parameters became "always a copy".
  The console runs several .java tabs only in the live runner (the server) -
  the two-file MyUtils flow was compile-checked, not clicked through locally.
- Arrays (lesson 16, verified JDK 21): indexes always from 0 (Pascal's any-
  range Good to Know became "why count from 0?"); new arrays are filled with
  0 / 0.0 / false / null; Java checks every index (ArrayIndexOutOfBounds-
  Exception: Index 5 out of bounds for length 5 - also for a fixed index,
  which javac does not warn about); println(marks) prints [I@...;
  marks.length has no brackets. The step demos are
  public/assets/java-array-demo.js (0-based twin of array-demo.js, loaded by
  the lesson itself); the 2-D try-it is javaArray2d. A method can change an
  array it is handed (sortMarks), unlike an int. Bubble with a flag is a
  do ... while.
- Classes and objects (lesson 17, verified JDK 21): every listing is ONE file -
  a non-public `class Pupil` first, then the public class with main (the
  lesson says an IDE gives each class its own file); check-java-code and the
  style rules accept that. No T prefix, no Free, no destructors: garbage
  collection, `= null`, one object with two names, and a static count that
  only goes up. Java's `private` holds even in one file (`mark has private
  access in Pupil`); the invisible default constructor vanishes once one is
  written; `Pupil newcomer;` then a call does not compile (`might not have
  been initialized`), `= null` then a call gives NullPointerException ...
  `"<local1>"` (the console compiles without -g). `println(thabo)` calls
  toString, `Pupil@72ea2f77` without one; @Override catches a misspelt
  `tostring`. Section thisKeyword (Chris, 25 Sep 2026: explain `this`, with a
  diagram, and note that other courses name the parameter like the field):
  `this.mark = mark;`, the silent `name = name;` trap (prints `null: 0`), and
  a code exercise in that style; written rubrics accept either style. The
  try-it is javaObjectFactory; doodles java-factory, java-hats, java-recycle.
- Text files (lesson 18, verified JDK 21): File names the file; Scanner reads
  (hasNextLine/nextLine, always a while); new PrintWriter(file) empties it at
  once; new PrintWriter(new FileWriter(file, true)) appends and MAKES a
  missing file (Pascal's Append stopped with error 2); split does the
  parsing (Chris: "can use String.split"). The try ... catch
  (FileNotFoundException error) that Java insists on is taught here as a
  fixed shape (catch on its own line after `} // try`, never `e`); lesson 19
  explains exceptions. Buffer 8192 characters: no close -> empty file;
  1000 lines -> exactly 8192 characters (488 lines on the server's line
  ends); a closed PrintWriter ignores println silently. A missing file's
  message is shown in the server's (Linux) words, "(No such file or
  directory)", with the Windows words named. `bin/check-java-code.php` now
  reads `<pre class="no-program data-file" data-name="pupils.txt">`: every
  program after it runs with that file beside it (latest one of a name
  wins); `data-files="none"` runs a listing without any. The try-it is
  javaFileModes (keeps one of fileIn/fileOut open at a time).
- Defensive programming (lesson 19, verified JDK 21): the safe-input methods
  (readInt, readIntInRange, readDouble, readBoolean) share ONE Scanner, a
  `private static Scanner keyboard` field - a new Scanner(System.in) per
  call lost input given all at once (NoSuchElementException). They read a
  line and parseInt it in a try; nextInt inside a try/catch loop repeats
  forever on letters (taught as the trap); hasNextInt is the "check first"
  way (it skips blank lines silently and takes the 15 of "15 years").
  Java-only facts taught: parseInt skips no spaces (" 7" fails, "+7" is 7);
  catch (Exception) above a particular catch does not compile; a double
  divided by 0 gives NaN/Infinity, no exception; a class throws
  IllegalArgumentException (a plain Exception would force a try on every
  caller); NumberFormatException is an IllegalArgumentException, so one
  catch takes parseInt's and the class's. Try-its javaExceptionJump,
  javaValidationLab, javaCheckDigitLab, javaGuiForm (Swing and JavaFX
  names). NOT checked: the debugger Good to Know's jGRASP/NetBeans wording
  (no IDE on the testbed) and the JavaFX class names (no OpenJFX yet).
- Dates (lesson 20, verified JDK 21): java.time only - LocalDate /
  LocalTime / LocalDateTime made with of, shown with toString (ISO, the same
  everywhere) or format(ofPattern(...)), read with parse. The lesson's key
  Java traps, all run: a plain ofPattern("dd/MM/yyyy") parse turns 31/02 into
  28/02 silently, so reading dates uses the line
  ofPattern("d/M/uuuu").withResolverStyle(ResolverStyle.STRICT) (strict needs
  u, not y); mm is minutes; YYYY is the week-based year (28/12/2026 ->
  2027); MMM and a follow the locale (console en: Sep, PM; a South African
  Windows PC, en_ZA: Sept, pm); DAYS.between is negative when swapped; dates
  are immutable (plusDays alone does nothing). Ages: Period.between and
  YEARS.between are right; year minus year, days/365 and days/365.25 are
  each wrong on some day - the lesson still teaches the algorithm. New file
  public/assets/java-tryit-dates.js (javaDateNumber, javaDateFormatLab,
  javaAgeLab, javaLeapYearLab, javaIdDateLab), loaded by public/lesson.php
  in the Java course after java-tryit.js; java-tryit-dates.test.js checks it
  against JDK tables (875 patterns in two locales, epoch days, ages).
- Array manager class (lesson 21, verified JDK 21): no destructors or
  ownership - Pascal's "who frees what" became "one object, many names" (the
  manager hands out its own objects; an object deleted from the list lives on
  while a variable refers to it). null / == null / != null replace Nil and
  Assigned. Arrays given back are made exactly as long as the answer
  (pupilsInClass counts, then fills), so callers loop to .length; no answers
  is length 0, not null. The working manager's current is -1 when empty and
  the menu shows getPosition() + 1. Helpful NPE messages quoted: `because
  "<local2>" is null`, `because the return value of "PupilList.getBest()" is
  null`, `Cannot store to object array because "this.pupils" is null`,
  `"this.pupils[<local2>]" is null`. Try-it javaManagerLab in the new
  public/assets/java-tryit-manager.js (loaded by public/lesson.php in the
  Java course); java-tryit-manager.test.js replays 51 calls against a JDK run.
- Platform fixes made for lesson 21 (25 September 2026): lib/javastyle.php
  expected a block opened under a `case` label (an if inside a case) two
  spaces too far left - it now tracks the level of the line that opened each
  brace (two tests added to bin/check-javastyle.php). bin/check-java-code.php
  compares output with the exception's `at Class.method(...)` lines left out,
  so a listing's output can end with the exception message.
- Inheritance (lesson 22, verified JDK 21): no Virtual in Java - every method
  can be overridden unless final, and the matching heading does it; @Override
  is taught as javac's check. Pascal's "no Virtual" demo became "misspelt
  heading, no @Override" (a new method nothing calls: juniors pay R250).
  super(...) is enforced on a constructor's first line (left out: "no
  suitable constructor found for Member(no arguments)"); super.method()
  anywhere; toString() without super. -> StackOverflowError. Is/As became
  instanceof and a cast (ClassCastException). protected also opens a member
  to the package, so main in a one-file program can call it; private is
  enforced across classes in one file ("name has private access in
  Member"). Parsing with split("#") inside a protected getField, fields from
  0. Try-it javaBindingLab in the new public/assets/java-tryit-inherit.js
  (loaded by public/lesson.php in the Java course); java-tryit-inherit.test.js
  checks its 12 choices against real runs.
- Text user interfaces (lesson 23, verified JDK 21): Crt became lesson 4's
  ANSI codes in a constant ESC = "\u001B[" plus moveTo(aRow, aColumn) (row
  first); ClrEol became \u001B[K (paints in the current background, so the
  title bar works). No ReadKey in Java: menus read a line and switch on
  charAt(0) (only when the length is more than 0 - just Enter otherwise gives
  StringIndexOutOfBoundsException); F1/Esc are taught as window-program
  standards and console programs show their letters (H, Q). The screens are
  real runs: tools/ui-screens/java/jscreen.py runs a program with pipes and
  echoes typed lines like a terminal; the .ans files are in
  content/java/screens/ and drawn by TerminalScreen(). Errors quoted: case
  "1" on a char, case 'Esc', case 1 never matching '1', a missing break,
  nextInt then nextLine, a code with no backslash.
- GUI design (lesson 24, verified JDK 21 + OpenJFX 21, 26 September 2026):
  Swing AND JavaFX side by side, every window built in code (MainForm extends
  JFrame, MainApp extends Application), names by job + kind (nameField,
  bookButton; prefixes allowed). OpenJFX 21 jars came from ~/.m2 (nothing
  downloaded); a pupil's IDE needs a JavaFX project or the OpenJFX library.
  Generics appear only as JList<String>, ComboBox<String>, Spinner<Integer>,
  DefaultListModel<String> ("a list of Strings"); the one anonymous class is
  the WindowAdapter for windowClosing, given as a shape to copy. Traps, all
  run: a JFrame's X only hides it (HIDE_ON_CLOSE - the program keeps
  running); spinner.setValue("1") -> IllegalArgumentException: illegal value,
  setValue(9) on a 1-6 spinner is accepted; a JLabel needs setOpaque(true)
  for a background; a JTextArea gets a typewriter font in the Windows look;
  MaskFormatter's default COMMIT_OR_REVERT wipes half-typed text when the
  focus leaves (the Book handler read "___ ___ ____") - PERSIST keeps it;
  new MaskFormatter without a try -> unreported exception ParseException;
  a missing font -> Dialog (JavaFX: System), silently; Font.createFont gives
  size 1 (deriveFont(28f)); Font.loadFont gives null for a missing file;
  JavaFX without OpenJFX -> "package javafx.application does not exist" /
  NoClassDefFoundError at run time. Tab order: Swing's default is
  LayoutFocusTraversalPolicy (screen positions); Swing text fields have no
  Ctrl+Z. Window event orders are in the lesson's docblock. Try-it javaMaskLab
  in the new public/assets/java-tryit-ui.js (28 real MaskFormatter runs in
  java-tryit-ui.test.js); the colour wheel is Pascal's colourWheel with
  data-lang="java" (shows new Color(r, g, b)). Screenshots:
  public/assets/lessons/java/lesson24-*.png, made by
  tools/ui-screens/java-gui (never synthetic mouse clicks - see its README).
  NOT checked: the NetBeans GUI-builder wording (no NetBeans on the testbed).
- Making a program others can run (lesson 28, verified JDK 21.0.2 + Java 17
  and 8 from ~/.jdks, 26 September 2026): enrichment (no SAG). jar
  --create --file X.jar --main-class X *.class; the manifest; "no main
  manifest attribute"; a .bat starter (cd /d "%~dp0", java -jar, pause) -
  a program finds data files in the folder it is STARTED from; javaw has no
  console; no .jar association on a zip-installed JDK. Class-Path in a
  --manifest file (the last line is silently dropped without a final
  newline); packages need javac -d build + jar -C build . and the full
  main-class name. UnsupportedClassVersionError (65 = 21, 61 = 17, 52 = 8);
  javac --release N also refuses newer methods (repeat on 8), -source/-target
  doesn't (NoSuchMethodError at run time). JavaFX: plain java -jar ->
  NoClassDefFoundError javafx/application/Application; JavaFX jars on the
  Class-Path -> "JavaFX runtime components are missing"; --module-path lib
  --add-modules javafx.controls works. jpackage --type app-image: 148 MB (55
  zipped), --add-modules java.base 42 MB, Swing java.base,java.desktop 71 MB;
  --win-console for console programs (the launcher is otherwise a GUI-
  subsystem exe); JavaFX jars in dist/javafx + --java-options "--module-path
  $APPDIR/javafx --add-modules javafx.controls" (jars at the top of dist
  fail: unnamed package not allowed in module); --type exe/msi needs WiX.
  Every command also run as typed in Command Prompt. Tools and test programs:
  AIResources/tools/java-packaging. NOT checked: the IDE menu names, and
  double-clicking (no clicks on the test machine).
- Databases from Java (lessons 25-27, verified 26 September 2026; tools:
  AIResources/tools/java-databases). Registered 'enrichment' like Pascal's
  capssqlite pair. ONE class holds all the SQL (ProductsDB, methods throw
  SQLException for the caller to catch - "throws" is new syntax, taught in
  lesson 25); Product objects come back in an exact-length array (lesson
  21's rule). Lesson 25 Swing (JTable + DefaultTableModel,
  setDefaultEditor(Object.class, null)); lesson 26 JavaFX reuses Product and
  ProductsDB unchanged (TableView<Product>, PropertyValueFactory per getter -
  a wrong word or a non-public class gives an EMPTY column and a console
  warning, no error); lesson 27 Java DB: the same ProductsDB with only the URL
  changed ran every method, and both windows ran on it. SQLite (sqlite-jdbc
  3.48, no slf4j needed): a misspelt file makes an empty one -> "no such
  table"; an unset ? is silently null; getString before next() is forgiven.
  Derby 10.17 is stricter (those three are errors), needs Java 21 (on 17:
  "No suitable driver found"), needs derbyshared.jar, is a folder plus
  derby.log, locks the database to one program, has no TEXT, no DROP TABLE IF
  EXISTS, no LIMIT (FETCH FIRST), and a LIKE that counts capitals. ij loads a
  .sql script; the lesson tells pupils to count every table's rows
  (sql-dialects.md). String.format follows the region: screenshots show
  R12,50; printed outputs are shown with a point, and the lessons say why.
- IEB lessons (26 September 2026), numbered 29-31 with the IEB badge:
  examieb (Pascal lesson24) - its Free / Premium extends Free /
  RequestManager / RequestUI are WHOLE classes the checker compiles and runs
  with an Accounts.txt data file (the memo PDF couldn't be read here - no PDF
  tools - so the Java follows the exam analysis; parameter names follow the
  diagram, inN not aName, and the lesson says the diagram's names win);
  dvtieb (Pascal lesson26) - a real JavaFX SignUpApp whose validateClicked was
  run with the test plan's data; patieb (Pascal lesson27) - the Pascal text
  with the Java words (make_patieb.py). Tools: AIResources/tools/java-ieb.
- Glossary (content/java/glossary.php, 279 terms, 26 September 2026): drafted
  by tools/java-glossary/make_glossary.php from every Gloss() and study key
  term, first clean occurrence wins, twins merged as 'also', grade/examined
  from the Pascal glossary where the term matches, else the lesson's SAGs
  (enrichment = not examined). A first draft for Chris to check. It feeds the
  Glossary page, the popups, the Index (1018 entries) and Practice (157
  words).
- Platform changes (26 September 2026): lib/courseindex.php strips javac's
  "X.java:12: " from error-message index entries (they sorted by file name);
  lib/tasks.php - the data validation task's naming line names both
  conventions (lblName or nameLabel), and the PAT's good-programming line says
  "Case or switch".
