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
