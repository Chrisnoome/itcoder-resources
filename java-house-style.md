# Java coding house style (the Java course)

**Scope:** all Java for the `java` course (IEB IT Grades 10-12; CAPS schools
use Delphi, so this course is IEB only - Chris, 25 September 2026). Built from
[pascal-house-style.md](pascal-house-style.md) - "same basic principles as
Pascal" (Chris) - with Java's own naming, which the IEB papers and memos use.
First principles only: arrays and a count, no ArrayList, generics, streams,
lambdas (except the one line a GUI event needs), var, records or text blocks.
Java 21 (LTS) on the server and in the lessons.

## 1. Program structure

- One public class per file, the file named after the class (`Hello.java`
  holds `public class Hello`) - javac enforces this.
- A program is a class with `public static void main(String[] args)`.
- 2 spaces per level, no tabs.
- **Braces K&R with end comments** (Chris, 25 September 2026): the opening
  brace ends the line that starts the block; the closing brace is on its own
  line and says what it closes. `else` starts a new line after the `} // if`:

  ```java
  if (mark > 49) {
    System.out.println("Pass");
  } // if
  else {
    System.out.println("Fail");
  } // else
  ```

  `} // for`, `} // while`, `} while (answer != 0); // do`, `} // getName`, `} // Pupil` (a constructor),
  `} // class Pupil`, `} // main`, `} // try`, `} // catch`, `} // switch`.
- **Blank lines between sections**: after the imports, between methods, and
  inside a longer method between steps, each step opening with a `//` comment
  (`// Load`, `// Show the list`). The longer the code, the more it needs them.
  In a class, fields first, then constructors, then methods.

## 2. Naming

| Element | Rule | Example |
|---|---|---|
| Classes | UpperCamelCase, no prefix (Chris, 26 Sep 2026: the Java course says UpperCamelCase, never PascalCase) | `Pupil`, `PupilManager` |
| Methods | camelCase, lower-case first letter | `getName`, `calcTotal` |
| Fields and variables, loop counters too | camelCase, meaningful - **never a single letter** (not `i`, `j`, `k`) | `index`, `outer`, `inner` |
| Parameters | `a` + name (Chris, 25 September 2026) | `aName`, `aMark` |
| Constants | `static final`, UPPER_SNAKE_CASE | `MAX_PUPILS` |

**Checked before a program runs** (Chris, 28 September 2026 - the `naming`
rule, `lib/naming.php` via `lib/javastyle.php`; it stops the run like the
layout checks): each row of the table above, for classes, methods,
constructor and method parameters (main's `args` excepted), variables, fields
and constants. Java's own words in the wrong capitals are javac's errors, so
they are left to javac. Console always; code copied from an exercise from
lesson 5 on (`JavaStyleGates()`). A pupil who copies the `this.name = name`
form (lesson 17) into the console is asked for `aName`.

**Parameters and `this`** (Chris, 25 September 2026): the course uses `aName`
so a parameter never has the same name as a field. Lesson 17 says plainly that
most Java code (textbooks, IEB memos, the internet) gives the parameter the
field's own name and tells them apart with `this` (`this.name = name;`), and
explains `this` with a diagram; pupils must be able to read that form.

## 3. Whitespace

- Java's own spacing, not Pascal's: no space between a method's name and its
  `(` (`println("Hi")`, `getName()`); one space after `if`, `for`, `while`,
  `switch`, `catch` and before `{`.
- Spaces around operators (`=`, `+`, `<`, `==`, `&&`), after commas.
- `>=` and `<=` are always two ASCII characters (as in Pascal).

## 4. Comments

- `//` only - never `/* */` or Javadoc `/** */`.
- Comment non-obvious lines and blocks; every closing brace says what it closes.
- **Every method and constructor has a comment block directly above it**, the
  same shape as Pascal's:

  ```java
  // What it does (one or more lines).
  // aFirst  - what the first parameter is for
  // aSecond - what the second parameter is for
  // Gives back: what the answer means     (non-void methods only, always last)
  ```

  One line per parameter in order; no `Gives back` on a void method or a
  constructor; no blank line between the block and the heading. An
  `@Override` line sits between the comment block and the heading.

## 5. Control flow

- Every `if`, `else`, `for`, `while` and `do` has braces, even for one statement.
- `switch` is the classic form with `break` ending each case (what the exam
  memos use); the arrow form is a Good to Know.
- **Never `break` out of a loop and never `continue`** - conditions and flags
  end loops. `break` only ends a switch case.
- **One `return`, as the method's last line** (the Java form of Pascal's
  `Result :=`): searches use a `while` loop with a `found` flag, not a
  `return` from inside a loop.
- Never change a `for` loop's counter inside the loop (Java allows it; don't).
- **Give every variable a starting value before using it** (javac refuses a
  local that might not have one - `variable total might not have been
  initialized`).
- Arrays are 0-based (Java has no choice): `for (int index = 0; index < count; index++)`.
- One instruction per line.
- Strings are compared with `.equals()` / `.compareTo()`, never `==`.
- **Methods don't read or write** unless that is their one job (`readInt`,
  `drawBox`); a class's methods never read or write at all - `toString()`
  gives the text back and the caller prints it.

## 6. Input and output

- Output: `System.out.println`, `System.out.print`, `System.out.printf` /
  `String.format`.
- Input: **one `Scanner` on `System.in` per program**, made in `main`:
  `Scanner keyboard = new Scanner(System.in);`. Lesson 6 teaches `nextLine`,
  `nextInt`, `nextDouble` and the `nextInt`-then-`nextLine` trap; from lesson
  19 the safe way is a whole line with `nextLine()` converted with
  `Integer.parseInt` inside `try ... catch`.
- Delimited text: `String.split("#")` (Chris, 25 September 2026: "can use
  string.split for parsing delimiters"); a Scanner with `useDelimiter` is shown
  as another way, since the memos accept both.
- Text files: `Scanner` on a `File` with `hasNextLine()`/`nextLine()`;
  writing with `PrintWriter` on a `FileWriter` (`true` to append); `close()`
  every time.

## 7. Object-oriented conventions

- Fields `private`; constants `public static final`.
- **A constructor with parameters fills fields through the setters**
  (`setTitle(aTitle);`).
- Getter `getX`/`isX`/`hasX` gives back its field; setter `setX` stores its
  parameter.
- `toString()` always carries `@Override` on the line above.
- A subclass constructor's first line is `super(...)`.
- No destructors: Java frees objects itself (garbage collection); a manager
  class sets a removed slot to `null`.
- Keep logic out of event handlers so the same class works in a console
  program, in Swing and in JavaFX.

## 8. Worked example

```java
// Turns a number of seconds into minutes and seconds, like 3:07.
// aSeconds - the number of seconds
// Gives back: the time as text
public static String formatDuration(int aSeconds) {
  int minutesPart = aSeconds / 60;
  int secondsPart = aSeconds % 60;
  String result = "";
  if (secondsPart < 10) {
    result = minutesPart + ":0" + secondsPart;
  } // if
  else {
    result = minutesPart + ":" + secondsPart;
  } // else
  return result;
} // formatDuration
```
