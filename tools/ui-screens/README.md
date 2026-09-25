# ui-screens - how lessons 22 and 23's screens were made

Kept so the pictures can be redone after a change (24 September 2026).

## crt/ - real Crt screens (lesson 22)

`python -X utf8 crt.py prog.pas keys.json out.ans` uploads the program to
`/tmp/claude-ui` on the server (vps.py), compiles it with `fpc -Mobjfpc`, runs it
in an 80x25 pty with TERM=xterm (`ptyrun.py`, which also answers Crt's ESC[6n
cursor question), types the keys (`[[delay, "text"], ...]`; `"@@SNAP:name"` saves
the output so far as `out-name.ans`) and saves the raw bytes. `php show.php
x.ans` prints the screen via `lib/terminal.php`. Copy `.ans` files to
`AIPascalCourse/content/pascal/screens/`; lessons draw them with TerminalScreen().
Change a program in a lesson -> re-run it and re-copy its screens.

## lazarus/ - real window screenshots (lesson 23)

Build with `C:\lazarus\lazbuild.exe -B x.lpi` (always -B: an .lfm change was
not picked up without it). `shots.exe` builds the gallery, layout, font and bad
forms in code; `bookgui\playbookingsgui.exe shots` runs the real booking program
and types into it. Both write `out\*.png` plus `*.json` (each control's place,
for numbered badges). The process is made DPI-aware and captured with
PrintWindow, so pictures are at the screen's scaling (125% on Chris's machine -
lessons show them at 80%). Copy to `public/assets/lessons/pascal/lesson23-*.png`.
`masktest` types into a real TMaskEdit and prints Text/EditText/ValidateEdit;
`pascal-tryit-ui.test.js` holds its results.

`moreforms` (25 September 2026) is the booking list with a second form
(ShowModal), a seating plan (Show) whose seat buttons are made in code, a
TTimer spotlight, InputBox and ShowMessage. `moreforms.exe shots` writes
`outorms-*.png` (dialogs are caught by a timer while they are modal; the
native ShowMessage box by GetForegroundWindow). Its three units are pasted
into lesson 23 as `$moreMainUnit` etc. - change them there too. `eventorder`
logs which form events fire, in which order, to `events.txt`.

## fonts/ and the font demos (lesson 23)

`fontsheet.py` draws a sample of every Windows 11 font into
`public/assets/lessons/pascal/fonts/`; `lazarus/fontpic` (GDI) drew Symbol,
Marlett, Webdings and Wingdings, which Pillow can't (text in `sym-*.txt`, as
U+F0xx for the symbol fonts). `lazarus/fontdemo` is the FreeSerif private-font
program: run `fontdemo.exe font-private` with FreeSerif.ttf beside it and
`fontdemo.exe font-nofile` without. The component pictures in the prefix table
(`lesson23-comp-*.png`) are cut from the scene screenshots with the `.json`
control positions (a TGroupBox/TRadioGroup's position is its inside - start 26
pixels higher to include the caption).
