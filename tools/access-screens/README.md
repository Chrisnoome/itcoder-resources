# access-screens - real Access screenshots for the SQL course's Access lessons

Added 26 September 2026 for `access00` (Getting started in Access). Windows
with Access 365 (64-bit) and Jet 4.0 (32-bit, part of Windows).

## Run it

1. `php make-db.php` - writes `work/tuckshop.json`, the tuck shop's Access
   statements straight from the platform (`lib/sql.php`).
2. In the **32-bit** PowerShell (`C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe`):
   `make-db.ps1` makes `work/TuckShop.mdb` (Jet 4.0 - the exams' kind of
   file). `make-db.ps1 -Out <file>` writes it elsewhere: the lesson's download
   is `AIPascalCourse/public/assets/lessons/sql/TuckShop.mdb` - remake it
   whenever `content/sql/db/tuckshop.php` changes.
3. **Hands off the keyboard and mouse**, then in the 64-bit PowerShell:
   `shots.ps1 [-Prefix access00]` (about a minute) writes `out/<prefix>-*.png`.
4. `python crop.py` cuts them down (the CROPS table) and copies them to
   `AIPascalCourse/public/assets/lessons/sql/`. **Look at every picture.**

**Lesson B1** (`access01`): `make-db.php` also writes `work/access01.json`
(the tuck shop plus tblSuppliers and two suppliers); build it with
`make-db.ps1 -Json access01.json -Out <this folder>\work\Access01.mdb`, then
`shots01.ps1` (hands off). To show another field's properties in Design
View it posts a Down-arrow key to Access's own design grid window by its
handle (`Shot.PostKey`) - a message to that one window, never typing at the
desktop. The datasheet picture is cropped above the new-record row, whose
SQL-made default shows with quotes.

**Lesson B2** (`access02`): `shots02.ps1` on `work/TuckShop.mdb` opens three
queries in Query Design's grid. Each is opened from **the SQL Query Design
itself writes** (`tblProducts.Price`, `WHERE (((...)))`): short SQL such as
`Price < 10` opened in the grid lands in extra hidden columns, which is not
the grid a pupil builds. The SQL View pictures were too small to read, so
the lesson shows that SQL as text (copied from them).

**Lesson B3** (`access03`): `shots03.ps1`, the same way - Like, Is Null,
Between, In and the Return box (TOP) in Query Design, each with its SQL View
(read to copy the SQL into the lesson).

**Lesson B4** (`access04`): `shots04.ps1` - a calculated field with a name
and one without (Query Design names it Expr1), with their answers and SQL.

## The safety rules

- **Nothing clicks and nothing types.** Access is driven through COM
  (`OpenTable`, `Maximize`, a hidden query called Query1 that holds the SQL)
  and through UI Automation on Access's own named controls ("Create" tab,
  "Query Design", "SQL View", "Run", "Close pane") - `kit.ps1`. Typing into
  SQL View's box by UI Automation did not take, hence the hidden query.
- **Pictures come from PrintWindow** (`Shot.cs`): only Access's own drawing,
  never what is on the screen. Access won't paint a datasheet that is off
  every screen, so the window sits on the screen at the back of the stack.
- **Nobody may use the keyboard or mouse while it runs.** Access brings
  itself to the front: on 26 September 2026 keys Chris typed in another
  program landed in Access's SQL box and showed in a test picture (it and
  every draft were deleted). `shots.ps1` now checks Windows' last-input time
  before every picture; any input during the run stops it and deletes every
  picture it made.
- **Crop off the title bar** - it shows the signed-in Office account's
  initials. `crop.py` refuses a crop that keeps it.
- **Nothing else may be driving the computer during a run.** Another chat
  controlling Chrome sends synthetic keyboard and mouse input, which Windows
  counts like a person's - on 26 September 2026 it stopped four runs in a
  row. `shots05.ps1` stops only for input while Access is the window in
  front (the only time keys could land in it) and says whether Access came
  to the front.
- **When only the SQL Query Design writes is needed, no window is needed:**
  `criteria.ps1` asks an invisible Access with `Application.BuildCriteria`,
  the function the grid uses (it showed that the grid writes dates as
  #2/1/2026#).
- Stop only this Access if a run sticks: its process id is in
  `work/access.pid`. Never stop another Access - it may be Chris's.
- It never presses **Enable Content**: that would add the file to Access's
  Trusted Documents (a security setting).

## What the pictures showed (facts the lesson uses)

An .mdb opens in overlapping windows with a SECURITY WARNING bar; while it is
unanswered, an UPDATE run from SQL View changed nothing. Money shows as
R28,50 and dates as 2026/01/21 (a South African Windows). A Yes/No field shows
tick boxes in the table and -1 / 0 in a query. An unnamed column is Expr1 in
Access's window (Expr1000 through ADO). Access 365's Create tab has an SQL
Query button beside Query Design. The "Enter Parameter Value" box was not
caught (its title was not found as a top-level window) - the lesson describes
it without a picture.
