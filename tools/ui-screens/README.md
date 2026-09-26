# ui-screens - how the lessons' screens were made

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

## java/ - real text screens for the Java course (lesson 23)

Added 25 September 2026. `python jscreen.py Prog.java keys.json out` compiles
the program with the local JDK 21 and runs it with pipes (a Java program never
asks the terminal anything, so no pty and no server are needed). keys.json is
a list: a string is typed once the program has been quiet for 0.6 s, and
echoed into the saved output followed by CR LF, as a terminal does;
`"@@SNAP:name"` saves the output so far as `out-name.ans`. `php show.php
x.ans [-v]` prints the screen as text (with -v, each run's colours). The
programs are the ones in `AIPascalCourse/content/java/lesson23.php` (dump them
from there); `pb1.json` is the PlayBookings run. Copy the `.ans` files to
`AIPascalCourse/content/java/screens/lesson23-*.ans`. The screens were made on
Windows, so println ends lines with CR LF - TerminalScreen draws them the same.


## java-gui/ - real window screenshots for the Java course (lesson 24)

Added 26 September 2026. `sh build.sh` (Git Bash) compiles the lesson's
programs (`src/` booking, notes and tuck shop windows; `src2/` and `src2fx/`
the three-window program) with the screenshot drivers in `tools/`, runs each
driver, and `publish_shots.py` copies `build*/out/lesson24-*.png` into
`AIPascalCourse/public/assets/lessons/java/` and cuts the naming table's
component pictures (`lesson24-comp-*.png`) using the `.txt` component boxes the
Swing drivers write. JavaFX needs the OpenJFX 21 jars in `fxpath.txt` (they
came from `~/.m2`); `ShotsFonts` needs FreeSerif.ttf in `build/`. The
programs are pasted into `AIPascalCourse/content/java/lesson24.php` as
nowdocs by `make_sources.py` (it writes `part1b.php`) - change a program ->
paste it there again and re-run the drivers. Pictures are at the screen's
125% scaling; the lesson shows them at 80%.

**Safety rule (26 September 2026): the drivers never click.** A Robot
title-bar click once landed on another program's window and captured private
content (the images were deleted). So: every window (and a white backdrop
window behind it) is always-on-top; typing goes in with replaceSelection, not
key events; nothing is clicked; and every capture is compared with the
window's own drawing (`Shot.check` / `FxShot.window`: 3x3 block averages, 85%
must match) - on a mismatch the image is deleted and the driver stops. Title
bars look inactive in some shots because no click activates them; that was
accepted. Never keep a screenshot with another program's content in it.

**A second rule (26 September 2026): a program that brings itself to the
front can catch the keys someone is typing elsewhere** - Access did, and
Chris's typing landed in its SQL box. Drivers that open such a program run
only with nobody at the keyboard and mouse, and check the last-input time
before every capture (tools/access-screens/README.md).

`facts/` holds the small programs behind the lesson's "found by running"
facts: `MaskTable.java` (+ `make_mask_test.py`, `masktable.txt`) types into a
real JFormattedTextField - `java-tryit-ui.test.js` holds its 28 runs;
`SwingEvents`/`FxEvents` log the window-event order; `FontFacts`/
`FxFontFacts` the missing-font and createFont facts; `FocusPolicy`,
`SpinText`, `Snips`/`SnipsFx` and `CloseForm`/`CloseApp` check the snippets
quoted in the lesson compile and behave as described.
