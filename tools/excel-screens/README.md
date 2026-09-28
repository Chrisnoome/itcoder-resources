# excel-screens - real Excel screenshots for the lessons

Added 28 September 2026 for SQL lesson A2's "Why not a spreadsheet?"
activity (a `shotSteps` activity - `ShotStepsHtml()` in the platform's
`lib/content.php`). Windows with Excel 365. Uses `..\access-screens\Shot.cs`.

## Run it

1. `php flatfile.php` - writes `work/flatfile.json`: the tuck shop's sales 1-9
   and 18 as one flat sheet, from `content/sql/db/tuckshop.php`, with the two
   slips the activity points at (sale 9 at 30.00, sale 18 "Mince Pei").
2. **Ask Chris first. Hands off the keyboard and mouse**, then in **Windows
   PowerShell 5.1** (`powershell.exe` - PowerShell 7 can't compile Shot.cs):
   `flatfile.ps1` (about 20 seconds) writes `out/dbwhat-flatfile-raw.png` and
   `-raw.json` (where each cell of A1:J12 is on the picture).
3. `python crop.py` cuts it (the CROPS table: name box, formula bar, grid;
   never the title bar - it shows the Office account's initials) and writes
   `AIPascalCourse/public/assets/lessons/sql/dbwhat-flatfile.png` and `.json`.
   **Look at the picture.** The activity reads the `.json`, so its circles
   follow a new picture without being moved by hand.

## The safety rules (as access-screens)

- Nothing clicks and nothing types: Excel is driven through COM only, and the
  picture comes from PrintWindow - only Excel's own drawing.
- Nobody may use the keyboard or mouse while it runs: Excel can come to the
  front and a key would land in a cell. The run checks the last-input time
  before and after the picture and deletes it if anything was touched.
