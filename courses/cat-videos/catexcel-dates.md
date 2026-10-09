# CAT Spreadsheets lesson 23: Dates and times - videos

Lesson: `AIPascalCourse/content/catexcel/dates.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Botha's Bakery's staff and shifts (sheets Staff and
Shifts, and Orders for the IEB functions) -
`tools/sim-screens/catexcel-dates.ps1` builds it. Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words being talked about.

## catexcel-23.1 Dates are numbers (about 7 min)

**Goes:** after the simulation `simStaffDates` (section `#date`).
**The pupil can afterwards:** explain why dates can be subtracted, take a
date apart with YEAR, MONTH and DAY, count days with DAYS, and build this
year's birthday with DATE.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "A date is a *number*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. To Excel, Mr Botha
   was born on day 26006. That one fact makes every date question easy.
   > Board: a calendar starting at 1 January 1900 with "day 1" circled.
2. **Dates as numbers (0:40-2:00).** The Born and Started columns switched
   to General: 26006, 35947. Format them back - nothing changed but the look.
   Subtract two dates: the days between.
   > Screen: d-0 and d-1; highlighter on 26006.
3. **YEAR, MONTH, DAY (2:00-3:20).** =YEAR(B4) 1971; the age this year,
   =YEAR(TODAY())-YEAR(B4) - and why it is one too many before the birthday.
   > Screen: D4 and E4 typed (d-2, d-3).
4. **DAYS, TODAY, NOW (3:20-4:40).** =DAYS(TODAY(),C4), the end date first.
   TODAY changes every day; use a date in a cell when the answer must stay.
   > Screen: F4 (d-4).
5. **DATE (4:40-6:10).** =DATE(YEAR(TODAY()),MONTH(B4),DAY(B4)), built from
   the inside out. DATE(2026,2,29) is 1 March.
   > Screen: G4 (d-5, d-6); Board: the leap-day birthday cake.
6. **Sign-off (6:10-6:40).**

### In the text

| Video point | Lesson anchor |
|---|---|
| a date is a serial number; times are parts of a day | `#numbers` |
| YEAR, MONTH, DAY, TODAY, NOW; the age this year | `#parts` |
| DAYS, the end date first; a fixed date in a cell | `#between` |
| DATE; impossible dates | `#date` |

## catexcel-23.2 Times and hours worked (about 5 min)

**Goes:** after the simulation `simShifts` (section `#times`).
**The pupil can afterwards:** work out hours from two times, take a time
apart with HOUR and MINUTE, and compare a time with TIME(6,0,0).
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Why *times 24*?"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Thandi worked from
   05:45 to 14:00. Excel says 0.34375. It is right - in days.
   > Board: a 24-hour clock with a third of it shaded.
2. **Times are parts of a day (0:30-1:40).** 12:00 is 0.5, 06:00 is 0.25.
   =(D2-C2)*24 gives 8.25 hours - the brackets first.
   > Screen: t-6 (0.34375), then E2 (t-1, t-2).
3. **Late? (1:40-3:00).** "06:00" in quotes is text; TIME(6,0,0) is a time.
   =IF(C2>TIME(6,0,0),"Late","On time"). Pieter at exactly 06:00 is on time.
   > Screen: F2 (t-3).
4. **HOUR, MINUTE, SECOND (3:00-4:10).** =HOUR(C2) is 5 for 05:45; MINUTE 45.
   TIME carries over: TIME(0,90,0) is 01:30.
   > Screen: G2 (t-4).
5. **Sign-off (4:10-4:40).**

### In the text

| Video point | Lesson anchor |
|---|---|
| a time is a part of a day; (D2-C2)*24 | `#times` |
| TIME, "06:00" is text | `#times` (the written question `w23Text`) |
| HOUR, MINUTE, SECOND | `#times` |

EDATE, WORKDAY, NETWORKDAYS, WEEKNUM and YEARFRAC (IEB) are in a table, a
figure and a short simulation; no video.
