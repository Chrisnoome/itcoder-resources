# De La Salle Pascal coding house style

**Scope:** all Pascal/Delphi/Lazarus code for teaching, exams and memos at De
La Salle Holy Cross College. First-principles data structures and techniques
for Grades 10-12 - no ArrayLists, StringLists or generics unless the
curriculum calls for them. The console's layout check (`lib/codestyle.php`,
`lib/routines.php`) enforces much of this - see live-console-design.md.

## 1. Program structure

- A program's name matches its file (`hello.pas` -> `Program Hello;`) - taught
  as discipline; fpc doesn't enforce it.
- Executable statements in one `Begin ... End.` (full stop on the last `End`).
- 2 spaces per level, no tabs.
- **A blank line between sections**: after `Program`/`Unit`, after `Uses`,
  between routines, before the main `Var`, between the main `Var` and `Begin`.
  A routine's own `Var` and `Begin` stay together. **Inside a longer block, a
  blank line between steps too**, each step starting with a `//` comment saying
  what it does (`// Load`, `// Use the objects`, `// Free every object`)
  (Chris, 23 September 2026). **The longer the code, the more it needs these
  open lines** - a wall of code with no gaps is hard to read, however right it
  is. In a class declaration, a blank line before each of `private` and
  `public` after the first; between routines, always one. (Lesson 14 on follows it;
  if earlier lessons are changed, recompile every error example - quoted line
  numbers move.)

## 2. Naming

| Element | Rule | Example |
|---|---|---|
| Methods, functions, procedures | Capital, CamelCase | `FormatDuration` |
| Class fields | lowercase camelCase | `elapsedSeconds` |
| Variables, including loop counters | camelCase, meaningful - **never a single letter** (not `i`, `j`, `k`) | `index`, `outer`, `inner` |
| Parameters | `a` + name, no `const` | `aSeconds`, `aStudentRecord` |
| Classes | `T` prefix | `TStopwatch` |
| Reserved words | Capitalised | `Begin`, `End`, `If`, `Then`, `Div`, `Mod` |

## 3. Whitespace

- Space before `:` (`minutesPart : Integer`, `Function GetElapsed : Integer`).
- Space before `(` and after `)`: `FormatDuration (aSeconds : Integer)`.
- Spaces around operators (`:=`, `+`, `<`, `Div`, `Mod`).
- **A heading too long for one line** continues on the next line lined up one
  place after its opening bracket:
  `Procedure DrawBox (aLeft : Integer;` / `                   aTop : Integer);`.
  Lessons never need to split a line by hand for the screen: listings wrap long
  lines the same way automatically (content-voice-and-pedagogy.md §7c).
- **`>=` and `<=` are always two ASCII characters**, never `≥`/`≤`, anywhere a
  pupil might copy from (prose, tables, popups, code) - site-wide. The code
  font's ligatures are switched off in `style.css` (`font-variant-ligatures:
  none; font-feature-settings: "liga" 0, "calt" 0` on `body`, and again on
  `code, pre`, `.code-editor`) so JetBrains Mono never draws `>=` as one glyph.

## 4. Comments

- `//` only - never `{ }`.
- Comment non-obvious lines and blocks.
- Every `End` says what it closes: `End; // for`, `End; // FormatDuration`,
  `End; // else`.
- **Every procedure, function, constructor and destructor has a comment block
  directly above it** (enforced by the layout check):

  ```pascal
  // What it does (one or more lines).
  // aFirst  - what the first parameter is for
  // aSecond - what the second parameter is for
  // Gives back: what the answer means     (functions only, always last)
  ```

  One line per parameter in heading order; no `Gives back` on a procedure; no
  blank line before the heading. Written **once, above the code** - the
  routine's body, or the `TThing.Method` body of a class's method.
- **A unit's Interface and a class declaration are only lists - no comments
  in them** (Chris, 23 September 2026: "comments not in the interface / class
  definition section. interface should just be a list. comments above actual
  methods"). The layout check (`lib/routines.php`) reports a block left in
  either; the console's Ctrl+Shift+C moves it down to the code
  (`pascal-complete.js`). Lessons 16 and 17 were converted the same day.
- **A method body is always named `TThing.Method`.**

## 5. Control flow

- Every branch of every `If`, `For`, `While` uses `Begin ... End`, even for one
  statement.
- No semicolon before `Else`.
- **Brackets round each comparison joined by `And`/`Or`/`Xor` or after `Not`**:
  `If (age >= 18) And (isCitizen) Then` (without them it is a compile error).
- Never `Break` - conditions and flags end loops.
- **Never change a For loop's counter inside the loop** (fpc refuses it).
- **Give every variable a starting value before using it** - a routine's local
  variable starts with whatever was in memory.
- 1-based arrays.
- **One instruction per line** - never `Write ('H'); Delay (200);`.
- Break long expressions into simple steps with extra variables.
- **Procedures don't produce output; functions return values; the caller
  writes.** **Exception (Chris, 23 September 2026): a procedure or function may
  do input or output when that is its very specific purpose** - its one job -
  e.g. `WriteHeading`, `DrawBox` (lesson 14), `ReadInt`, `ReadBoolean` (lesson
  18). A routine whose job is something else (an average, a count) never reads
  or writes.
  **A class's methods never read or write at all** - `ToString` gives the text
  back and the caller writes it.

## 6. Object-oriented conventions

- `T` prefix; fields lowercase, methods capitalised.
- **A program with a class starts with `{$H+}`** on its own line under the
  Program line, and **ToString is declared `Function ToString : String;
  Override;`** (Chris, 24 September 2026). `{$H+}` is a compiler switch, not a
  comment; without it Override on ToString is an error. Lessons 16 on.
- `Inherited Create` is a constructor's first line.
- **A constructor with parameters fills fields through the setters**
  (`SetTitle (aTitle);`, not `title := aTitle;`).
- Getter `GetX`/`IsX`/`HasX` gives back its field (`Result := title;`); setter
  `SetX` stores its parameter (`title := aTitle;`).
- **A class holding an array of objects frees them in its destructor**
  (`Destructor Destroy; Override;`): loop `Low (list) To High (list)`,
  `list[index].Free;`, `list[index] := Nil;`, then `Inherited Destroy;`.
- Every function sets `Result := ...;` (never `FunctionName := ...`); the
  console refuses a function without it.
- Ctrl+Shift+C / **Update code** (`public/assets/pascal-complete.js`) writes all
  of this - change the two together.
- Keep logic out of event handlers so it works in GUI and CLI.

## 6a. Verified type-mismatch errors (FPC 3.2.2, `-Mobjfpc`)

Never guess compiler messages - compile them. Under `-Mobjfpc` (what the site
uses; Lazarus and Delphi agree) `Integer` = `LongInt`, 32-bit
(-2147483648..2147483647); `String` = `ShortString` (255 chars, `SizeOf` 256).

| Assignment | fpc error |
|---|---|
| `Integer := 3.5` | `Incompatible types: got "Single" expected "LongInt"` |
| `Integer := 'ten'` | `Incompatible types: got "Constant String" expected "LongInt"` |
| `Boolean := 1` | `Incompatible types: got "ShortInt" expected "Boolean"` |
| `Char := 'AB'` | `Incompatible types: got "Constant String" expected "Char"` |
| `String := 5` | `Incompatible types: got "ShortInt" expected "ShortString"` |
| `Real := 5` | Compiles - Integer widens into Real |

Lessons say `Integer`/`String`; the compiler says the underlying names.

## 7. Worked example

```pascal
Function FormatDuration (aSeconds : Integer) : String;
Var
  minutesPart : Integer;
  secondsPart : Integer;
Begin
  minutesPart := aSeconds Div 60;
  secondsPart := aSeconds Mod 60;
  If secondsPart < 10 Then
  Begin
    Result := IntToStr (minutesPart) + ':0' + IntToStr (secondsPart);
  End // if secondsPart < 10
  Else
  Begin
    Result := IntToStr (minutesPart) + ':' + IntToStr (secondsPart);
  End; // else
End; // FormatDuration
```

```pascal
Type
  TStopwatch = Class (TObject)
  private
    elapsedSeconds : Integer;
  public
    // Makes a stopwatch at zero.
    Constructor Create;
    // Gives back the seconds counted.
    // Gives back: the elapsed seconds
    Function GetElapsed : Integer;
  End; // TStopwatch

Constructor TStopwatch.Create;
Begin
  Inherited Create;
  elapsedSeconds := 0;
End; // TStopwatch.Create

Function TStopwatch.GetElapsed : Integer;
Begin
  Result := elapsedSeconds;
End; // TStopwatch.GetElapsed
```
