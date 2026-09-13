# De La Salle Pascal Coding House Style

**Scope:** All Pascal/Delphi/Lazarus code written for teaching, WebQuests, exam papers, and marking memos at De La Salle Holy Cross College. Code follows first-principles data structures and techniques appropriate to Grades 10–12 — no advanced features (e.g. no ArrayLists, StringLists, generics) unless the curriculum explicitly calls for them.

## 1. Program structure

- Every standalone program's declared name matches its source file name (e.g.
  `hello.pas` starts `Program Hello;`). Free Pascal does not enforce this -
  the compiled executable is named after the *file*, not the declared program
  name - so this is taught as discipline, not as a compiler rule: matching
  them avoids exactly the kind of confusion a beginner hits when the two
  drift apart.
- Every program's executable statements sit inside one `Begin … End.` block
  (the final `End` takes a full stop, not a semicolon - it closes the
  program, not a block within it).
- Indentation is 2 spaces per nesting level. No tabs.

## 2. Naming conventions

| Element | Rule | Example |
|---|---|---|
| Method / function / procedure names | Start with a capital, CamelCase | `FormatDuration`, `GetCategory` |
| Field names (class fields) | Start lowercase, camelCase | `elapsedSeconds`, `studentName` |
| Ordinary variables (incl. loop variables) | camelCase, meaningful — never a single letter | `index`, `bestIndex`, `outer`, `inner`, `minutesPart` |
| Parameters | `a` + Type name, camelCase after the prefix | `aString`, `aSeconds`, `aStudentRecord` |
| Classes | `T` prefix | `TStopwatch`, `TBookArray` |
| Reserved words | Capitalised | `Begin`, `End`, `While`, `For`, `If`, `Then`, `Else`, `Var`, `Function`, `Procedure`, `Div`, `Mod` |

Parameters do not need the `const` keyword.

## 3. Whitespace

- Space before `:` — in variable declarations and return-type declarations (`minutesPart : Integer`, `Function GetElapsed : Integer`).
- Space before `(` — e.g. `FormatDuration (aSeconds : Integer)`.
- Space after `)`.
- Spaces around operators (`:=`, `+`, `<`, `Div`, `Mod`, etc.).

## 4. Comments

- Use `//` line comments exclusively. Brace comments (`{ }`) are not used anywhere.
- Code must be commented — explain what non-obvious lines and blocks do.
- Every closing `End` line carries a comment naming the block it closes: `End; // end for`, `End; // FormatDuration`, `End; // else`.

## 5. Control flow and structure

- Every `If`, `For`, and `While` — every branch of every one — uses `Begin … End`, even for a single statement.
- No semicolon before `Else`.
- Never use `Break`. Loop conditions and flags control termination instead.
- 1-based arrays throughout.
- Procedures must not produce output directly; functions return values, and the main program (or calling code) is what calls `Writeln`.
- Avoid long, complex lines. Break a complex expression into several simple steps, introducing extra variables where that makes the logic clearer.
- **Never put more than one instruction on a line** (Chris, 2026-09-13), even
  two short ones separated by a semicolon (`Write ('H'); Delay (200);` is
  wrong - each goes on its own line, however trivial either statement is).

## 6. Object-oriented conventions

- Class names take a `T` prefix.
- Class fields start lowercase; methods start with a capital.
- `Inherited Create` is always the first line of a constructor.
- Code should be written so it is reusable in both GUI and CLI contexts — keep logic out of event handlers where practical, so it can be called from either.

## 6a. Verified type-mismatch error text (FPC 3.2.2, default mode)

Found and corrected 13 September 2026: an earlier lesson had **invented**
`Incompatible types: got "Double" expected "Longint"` for `Integer := 3.5;`
without compiling it - real output on this project's fpc (identical on the
Windows testbed and the Linux server) is `got "Single" expected
"SmallInt"`. Every type name below was compiled for real, on both
machines, before being put in front of a pupil - never guess these, they
are easy to get wrong and pupils will paste the mismatch between what a
lesson says and what their own screen shows straight back at you.

| Assignment | Genuine `fpc` error |
|---|---|
| `Integer := 3.5` (a Real literal) | `Incompatible types: got "Single" expected "SmallInt"` |
| `Integer := 'ten'` (a String literal) | `Incompatible types: got "Constant String" expected "SmallInt"` |
| `Boolean := 1` | `Incompatible types: got "ShortInt" expected "Boolean"` |
| `Char := 'AB'` (2+ characters) | `Incompatible types: got "Constant String" expected "Char"` |
| `String := 5` | `Incompatible types: got "ShortInt" expected "ShortString"` |
| `Real := 5` (an Integer literal) | Compiles fine - Integer widens into Real with nothing lost |

Note the plain type names this course teaches (`Integer`, `String`) are not
what the compiler itself says back (`SmallInt`, `ShortString`,
`ShortInt`) - `Integer` is an alias for `SmallInt` in this project's
default mode, confirmed by `Low(Integer)`/`High(Integer)` returning
-32768/32767 on both machines. A lesson can teach "Integer" throughout and
still be honest, since that is the genuine declared type - just don't be
surprised when a genuine compiler message uses the alias's underlying name
instead.

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
    Constructor Create;
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

## 8. Quick checklist

- [ ] Program name matches its source file name
- [ ] Executable statements sit in one `Begin … End.` block, full stop on the last `End`
- [ ] 2-space indentation, no tabs
- [ ] Method names capitalised CamelCase; fields lowercase camelCase
- [ ] Loop and other variables are meaningful words, never single letters
- [ ] Parameters use the `a` + Type naming pattern, no `const`
- [ ] Reserved words capitalised
- [ ] Space before `:`, space before `(`, space after `)`
- [ ] Every `If` / `For` / `While` branch wrapped in `Begin … End`
- [ ] No semicolon before `Else`
- [ ] No `Break` anywhere
- [ ] `//` comments only, and every `End` line says what it closes
- [ ] Long lines broken into simple steps with extra variables
- [ ] Never more than one instruction on a line
- [ ] Procedures don't output; functions return, caller writes
- [ ] Classes `T`-prefixed; constructors call `Inherited Create` first
- [ ] Only first-principles data structures/techniques used
