# CAT Spreadsheets lesson 20: COUNTIFS, SUMIFS and rounding up or down - videos

Lesson: `AIPascalCourse/content/catexcel/countifs.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: the matric farewell tickets (sheet Tickets) -
`tools/sim-screens/catexcel-countifs.ps1` builds it. Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words being talked about.

## catexcel-20.1 COUNTIFS and SUMIFS (about 7 min)

**Goes:** after the prose block "SUMIFS" (section `#sumifs`), before the
simulation `simSumIfs`.
**The pupil can afterwards:** count and add with two conditions, put
SUMIFS's parts in the right order, and write a condition with an operator or
from a cell.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Two conditions: *COUNTIFS*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The farewell
   committee wants to know how many 12A tickets are paid. COUNTIF can count
   12A, or count Yes - not both at once.
   > Board: Clicky holding two sieves, one labelled 12A, one labelled Yes.
2. **COUNTIF in a minute (0:40-1:20).** =COUNTIF(D4:D27,"Yes") and
   =SUMIF(D4:D27,"Yes",E4:E27) - one condition each.
   > Screen: the Tickets sheet; highlighter on the Paid column.
3. **COUNTIFS (1:20-2:50).** Pairs: a range, then what to look for.
   =COUNTIFS(B4:B27,"12A",D4:D27,"Yes") in I3: 6. Chloe and Carmen are 12A
   but unpaid - not counted. Same-size ranges.
   > Screen: I3 clicked, the formula typed slowly, each pair highlighted in turn (c-1, c-2).
4. **SUMIFS - the order trap (2:50-4:30).** The sum range comes FIRST:
   =SUMIFS(E4:E27,B4:B27,"12B",D4:D27,"Yes") - 2 500. SUMIF has it last.
   > Board: the two functions one above the other, the sum range circled in each.
   > Screen: I4 typed (c-3).
5. **Conditions that compare (4:30-5:40).** ">=500" in quotes; a cell on its
   own; ">="&H15. Absolute data ranges when copying.
   > Board: ">=H15" crossed out beside ">="&H15.
6. **The Function Arguments box (5:40-6:30).** Formulas > Insert Function
   with I3 selected: one box per part, the answer at the bottom.
   > Screen: c-5, c-6.
7. **Sign-off (6:30-7:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| COUNTIF and SUMIF recap | `#recap` |
| COUNTIFS pairs, same-size ranges, the 12A example | `#countifs` |
| SUMIFS, the sum range first, the table of orders | `#sumifs` |
| ">=500", a cell, ">="&H15, $ signs | `#criteria` |
| Insert Function, the Function Arguments box | `#fnargs` |

## catexcel-20.2 Rounding up and down (about 5 min)

**Goes:** after the simulation `simRoundUp` (section `#roundup`).
**The pupil can afterwards:** choose between ROUND, ROUNDUP and ROUNDDOWN for
a planning question, and use a minus number of digits.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "3.4 tables = *4* tables"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. 34 guests, tables of
   ten. ROUND says 3 tables. Four guests disagree.
   > Board: three full tables and four people standing, Clicky with a fourth table.
2. **ROUNDUP and ROUNDDOWN (0:30-2:00).** The table of 3.4, 3.5 and 3.01.
   =ROUNDUP(I6/10,0) - 4; =ROUNDUP(I6/15,0) - 3 taxis.
   > Screen: I7 and I8 typed (r-1, r-2).
3. **Minus digits (2:00-3:20).** R7 350 banked in whole R100s:
   =ROUNDDOWN(I9,-2) - R7 300. -1 tens, -2 hundreds.
   > Screen: I10 (r-4, r-5); Board: 7350 with the last two digits wiped.
4. **Which one? (3:20-4:30).** Can you have a part of one? No part-taxis -
   up. No part-notes in the bank - down. Rounding against formatting: the
   value itself changes.
5. **Sign-off (4:30-5:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| ROUND against ROUNDUP and ROUNDDOWN, the table | `#roundup` |
| tables, taxis, whole R100s | `#roundup` (simulation `simRoundUp`) |
| minus digits | `#roundup` |
| the rule of thumb | `#roundup` (the margin note) |

INT and TRUNC (IEB) are short and shown in their simulation and table; no
video.
