# Delphi GUI lessons, simulations and tutorials (PLAN - waits for Delphi)

**Chris, 4 October 2026:** "when delphi is running plan lessons with software
simulation and screenshots for gui in delphi - along with gui caps
tutorials".

**Trigger:** the Delphi IDE runs. Delphi is installed on Chris's PC
(`C:\Program Files (x86)\Embarcadero\Studio\37.0`, `bds.exe` and
`DCC32.EXE`; dcc32 has been used from the command line, platform.md decision
24), but the IDE has not been run for this work. When a chat sees `bds.exe`
start (or Chris says Delphi is running), it **asks Chris the questions at the
bottom**, then builds from this plan. Until then nothing here is built.

## Why

The CAPS Paper 1 is **Delphi GUI from start to finish** (caps-practical-exam-
analysis.md): every question starts from a given project with a form and
named components, and pupils write code in button click events - reading
`edt.Text`, `spn.Value`, `cmb.Text`/`ItemIndex`, `chk.Checked`, writing to
panels, labels, memos and rich edits, `ShowMessage`. The site's console is
text only, so the Pascal course teaches this today with Lazarus screenshots
in lesson 23 and words in lesson 25. CAPS pupils need to see and *do* it in
Delphi.

## 1. Screens

- **Real Delphi screens only**, VCL, light theme, the default layout, a
  readable font size; never the title bar's account or licence details.
- Made like `tools/sim-screens` (Excel): a script drives the IDE and saves
  each moment with PrintWindow - **hands off the keyboard and mouse** while
  it runs (ask Chris first). Delphi has no COM automation for clicks, so the
  script uses UI Automation / SendInput; better still, Delphi Community
  Edition in the tutorial VM (install video 2, courses/install-videos.md),
  where nothing disturbs Chris. New folder `tools/sim-screens/delphi/`.
- Cropped to the part each step is about (about 612 pixels wide in the
  lesson column): the Tool Palette, the Object Inspector, the form, the
  code editor, the Messages pane.

## 2. Simulations (`simulation` blocks, lib/simulation.php)

One real screen per step, a click / typed value / key per step, a hint about
the target never its place, two tries per step. Candidates, in teaching
order:

1. **A new VCL Forms application, saved properly** - File > New > Windows VCL
   Application; Save All as `Question1_P` / `Question1_U` (the exam's names).
2. **Put a component on the form** - TButton, TEdit, TLabel from the Tool
   Palette (search box), placed on the form.
3. **Set properties in the Object Inspector** - Name (`btnCalculate`,
   `edtName`), Caption, Text cleared.
4. **Make a click event** - double-click the button, the `procedure
   TfrmQ1.btnCalculateClick(Sender: TObject);` shell appears, type a line,
   F9 to run.
5. **Read and write components** - `iAge := StrToInt(edtAge.Text);`,
   `spnAmount.Value`, `lblOut.Caption := ...`, `redOut.Lines.Add(...)`,
   `FloatToStrF(rTotal, ffFixed, 8, 2)`.
6. **Compiler errors** - F9 fails, the `[dcc32 Error] Question1_U.pas(34):
   E2003 Undeclared identifier` line in Messages, double-click it to jump
   to the line, fix, F9.
7. **Debugging** - F5 a breakpoint, F8 step over, hover or Watch a variable.
8. **The exam start** - open a given `Question1_P.dpr` from the exam folder,
   find a button's event from the form, add the exam number comment.
9. **A class in a GUI project** (Question 3) - File > New > Unit, the class
   in it, `uses` in the form's unit, `objX := TX.Create(...)` in a click
   event, `toString` into a rich edit.

## 3. Lessons

Where they go (Chris to choose - see the questions):
- **Lesson 23** (GUI design): Delphi screens beside or instead of the
  Lazarus ones, with simulations 2-4.
- **Lesson 25** (CAPS exam guide): simulations 5, 6 and 8 - reading from and
  writing to components, which the console course does not teach.
- Or **new CAPS-only lessons** (`'stream' => 'caps'`, like the SQLite in
  Delphi lesson): "Delphi 1 - forms, components and events", "Delphi 2 -
  reading and writing components", "Delphi 3 - errors, debugging and the exam
  project", "Delphi 4 - a class behind a form".
- Every lesson keeps the usual rules: a quote, contents, a step-through or
  simulation for every sequence, questions of mixed types (a `hotspot` on a
  real Delphi window: "where would you set the caption?"), label the IDE
  only where its own screen does not print the names (content-voice §5).
- Code checked with dcc32 (real error messages), and every output from a
  real run.

## 4. CAPS GUI tutorials (videos)

The tutorial pipeline (courses/tutorial-videos.md) with a Delphi checkpoint
in the VM instead of Lazarus. Each: a narrated plan on the board, the coding
in Delphi, a code download. Proposed, each mirroring a Paper 1 question:
- **Your first Delphi form** - a temperature converter: edit in, button,
  label out (Question 1's "read, convert, calculate, display").
- **Strings in a click event** - split a code at a `#`, count, reverse, into
  a rich edit (Question 1's biggest part).
- **A class behind a form** - TGame from tutorial 01, now made from a combo
  box, spin edit and edit, shown with `toString` (Question 3.2).
- **Arrays in a GUI** - parallel arrays given in the code, search and total,
  output to a memo with `#9` tabs (Question 4).
- **A past Paper 1 Question 1, worked** - the given project, every button,
  marked against the memo.

## 5. Ask Chris when Delphi is running

1. Which Delphi version do his CAPS schools use - 37.0 here, or an older
   Community Edition? (The screens should match theirs.)
2. Screens on his PC (hands off while a script runs) or Delphi CE in the VM?
3. New CAPS-only Delphi lessons, or Delphi added to lessons 23 and 25?
4. Which tutorials first, and should they replace or join the Lazarus ones
   for CAPS pupils?
