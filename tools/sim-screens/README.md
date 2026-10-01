# sim-screens - real program screens for the software simulations

Added 1 October 2026 (Chris: "software simulations for working with word,
excel, access & powerpoint and file explorer" - real screenshots, step by
step, each step marked with two tries, Excel first). A simulation block
(`lib/simulation.php` in the platform) shows one real screen per step; this
folder makes those screens.

## Excel (Excel 365 on Chris's PC)

`excel-vram.ps1` is the model: it types a small sheet into a new workbook
through COM, then for each moment of the task selects a cell, enters a
formula, copies, pastes - nothing is clicked or typed - and saves the window
with PrintWindow (`..\access-screens\Shot.cs`) as `out\<name>-<n>.png`, with
`out\<name>.json` saying where the cells are (window pixels).

1. **Ask Chris first. Hands off the keyboard and mouse** (about 40 seconds;
   a run that sees input deletes its pictures). Windows PowerShell 5.1:
   `powershell -ExecutionPolicy Bypass -File excel-vram.ps1`
2. Crop and copy (as done for vram): the box (8, 228, 708, 472) keeps the
   name box, the formula bar and columns A-E, rows 1-8 - **never the title
   bar** (it shows the Office account's initials) - into
   `AIPascalCourse/public/assets/sims/excel/<name>-<n>.png`. Work out each
   click target in per cent of the cropped picture from the `.json`.
3. Look at every picture, write the block, run `php bin/check-simulations.php`
   and play it through on the testbed.

Notes: type sheet values in as text (`Range.Formula = [string]`) - PowerShell
5.1's COM binder refuses numbers for Value2. PrintWindow does not draw Excel's
moving "copied" border; the status bar's "Select destination and press ENTER"
shows it instead. After Enter, Excel moves down a row - write the steps the
way Excel really behaves.

For Word, PowerPoint and Access, the same way through their COM objects; for
dialogs and File Explorer, take the screens in the video VM (its agent drives
the real mouse and keyboard there) - ask the install-video chat first, it uses
the VM for recordings.
