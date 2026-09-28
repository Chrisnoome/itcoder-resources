# ide-screens - a real Lazarus window for the Pascal course

Added 28 September 2026 for Pascal lesson 26 (`ides`), the "where would you
click" picture activity `hsIdeWhere`. Windows with Lazarus 4.2 in
`C:\lazarus`.

## Run it

1. **Hands off the keyboard and mouse** (about 40 seconds), then in Windows
   PowerShell 5.1 (not PowerShell 7 - it can't compile `Shot.cs`):
   `powershell -ExecutionPolicy Bypass -File lazarus-ide.ps1`
   It starts a separate Lazarus with a throwaway copy of the settings in
   `D:\temp\lazshot` (`--pcp`), so the everyday Lazarus, its layout and its
   last project are never touched. It opens `demo\greeter.lpi` (a small
   Greeter form, named the course's way) with the form in the designer,
   captures each of its windows into `out\ide-window-N.png`, and closes only
   that Lazarus. A key or click during the run deletes the pictures.
2. `python crop.py` cuts `out\ide-window-1.png` down (below the title bar,
   which shows the throwaway path, with a white band in its place) and
   copies it to `AIPascalCourse/public/assets/lessons/pascal/pic-lazarus-ide.png`.
   It also prints the hotspot zones as per cent lines for
   `content/pascal/ides.php` - move a zone in `ZONES` (picture pixels) and
   paste the new lines. **Look at the finished render** (every area on its
   part) and run `php bin/check-pictures.php`.

## What it works around

- **Access violation at start** (Chris, 28 September 2026: "the access
  violation happens when previous project opens automatically, just close
  it"): the copied `environmentoptions.xml` gets
  `OpenLastProjectAtStart="False"`, and any small error box of that Lazarus
  with an OK button is clicked by a message to the button - no typing.
- **The form designer, not the code**: the editor's Code | Form | Anchors
  tab control is moved to Form with `TCM_SETCURFOCUS`, which the IDE takes
  as a click.
- **Size**: the capture is at the screen's 150% scaling. The lesson column
  is about 612 pixels wide, so the crop keeps 940 pixels (the Object
  Inspector, the palette's first tabs and the form designer) - the text then
  shows at about its real size. The whole 1100-pixel width was too small to
  read.
