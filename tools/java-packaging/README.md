# java-packaging - how lesson 28's facts were found

Added 26 September 2026 (Java lesson 28, "Making a program others can run").
Every command in the lesson was run with JDK 21.0.2 (`D:\xampp\jdk-21\bin`),
most also as typed in Command Prompt (`run.bat`, `fxpack.bat` - put the JDK's
bin on the PATH first). Older Javas for UnsupportedClassVersionError:
`~/.jdks/jbr-17.0.9` and `~/.jdks/corretto-1.8.0_402`.

- `Specials.java` + `MyUtils.java` + `specials.txt`: the console example. `run.bat`
  compiles, makes Specials.jar and runs it. `Specials.bat` is the starter
  shown in the lesson (`cd /d "%~dp0"`, `java -jar`, `pause`).
- Library test: pack MyUtils into `lib/MyUtils.jar`, `javac -cp
  lib/MyUtils.jar Specials.java`, manifest.txt = `Main-Class: Specials` +
  `Class-Path: lib/MyUtils.jar` + a final newline (without it the line is
  dropped silently).
- `Line.java`: `javac --release 8` refuses `repeat`; `-source 8 -target 8`
  compiles and fails on Java 8 with NoSuchMethodError.
- `FxCheck.java`: a JavaFX Application that prints its version and exits
  without a window - for testing JavaFX runs without opening anything. JavaFX
  jars: the OpenJFX 21 `-win.jar`s from `~/.m2/repository/org/openjfx`.
  `fxpack.bat` makes a jpackage app-image with the jars in `dist\javafx`.
- jpackage app-images take 15-18 s. Check a launcher's PE subsystem (2 = GUI,
  3 = console) to see what --win-console did. A GUI program's exe was checked
  by starting it, finding its window by title, and stopping it - no clicks.
