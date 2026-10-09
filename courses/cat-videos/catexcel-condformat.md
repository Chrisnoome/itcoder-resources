# CAT Spreadsheets lesson 12: Conditional formatting - videos

Lesson: `AIPascalCourse/content/catexcel/condformat.php` (Grade 11). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Ms Naidoo's Grade 11A marks (sheet 11A) -
`tools/sim-screens/catexcel-condformat.ps1` builds it. Board scenes in the
CAT marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words being talked about.

## catexcel-12.1 Highlight Cells Rules and a pass mark in a cell (about 7 min)

**Goes:** after the prose block "Highlight Cells Rules" (section
`#highlight`), before the simulation `simLessThan`.
**The pupil can afterwards:** say what conditional formatting is and why it
beats colouring by hand, use the Highlight Cells Rules, and make a rule
compare with a cell ($B$2).
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Let Excel hold the *red pen*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. 39 marks, a report
   meeting in ten minutes. Who failed? Who was absent? Who is in the list
   twice?
   > Screen: the plain 11A sheet.
   > Board: Ms Naidoo's red pen, and Clicky holding a second one.
2. **A rule, not a paintbrush (0:40-1:40).** Condition plus format; it
   updates itself. Colour Owen's 29 by hand, change it to 55 - still red.
   With a rule, the red goes.
3. **Less Than (1:40-3:20).** Select B4:D16, Home > Conditional Formatting >
   Highlight Cells Rules > Less Than..., 50, Light Red Fill with Dark Red
   Text, OK. 50 itself stays white.
   > Screen: the menu, the submenu, the dialog; highlighter on "Less Than".
4. **The other highlight rules (3:20-4:40).** Greater Than, Between (both
   ends included), Equal To, Text that Contains ABS, Duplicate Values (both
   copies of Lindiwe Zulu).
   > Screen: Text that Contains and Duplicate Values on the sheet.
5. **The pass mark in a cell (4:40-6:10).** The rule again, clicking B2:
   =$B$2. Type 40 in B2: the colours follow. Why the $ signs must stay.
   > Screen: the dialog with =$B$2; B2 changed.
   > Board: 39 arrows all pointing at one cell, B2.
6. **Sign-off.**

## catexcel-12.2 Data bars, colour scales, icon sets and the Rules Manager (about 7 min)

**Goes:** after the prose block "Data bars, colour scales and icon sets"
(section `#bars`), before the simulation `simDataBars`.
**The pupil can afterwards:** add the top three with Top/Bottom Rules, add
data bars, a two- or three-colour scale and an icon set, and edit, delete
and clear rules.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Why is *everything* green?"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Colour as a
   headline: point at the good news too.
2. **Top/Bottom Rules (0:30-1:50).** E4:E16, Top 10 Items, change 10 to 3:
   Imran, Chloe, Fatima. Above Average works out the average itself.
   > Screen: the submenu and the Top 10 Items box.
3. **Data bars, colour scales, icon sets (1:50-4:00).** Each from its
   gallery, with the preview: bars, Green - Yellow - Red, a two-colour scale,
   3 Traffic Lights.
   > Screen: the three galleries.
   > Board: a traffic light with "top third / middle / bottom third".
4. **Everything is green (4:00-5:50).** The student teacher's Cell Value > 0
   rule on top. Manage Rules..., This Worksheet, the order (top wins), Delete
   Rule, OK - red again. Edit Rule to change 50 to =$B$2 or an icon set's
   values.
   > Screen: the Rules Manager; highlighter on the two rules and their order.
5. **Clear Rules (5:50-6:30).** From Selected Cells or Entire Sheet. Delete
   on a cell keeps its rule.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| condition and format; why it beats colouring by hand | `#what` |
| Less Than step by step; the table of highlight rules; 50 stays white | `#highlight` |
| =$B$2 by clicking B2; changing the pass mark | `#cell` |
| Text that Contains ABS; Duplicate Values, both copies; Unique | `#duplicates` |
| Top 10 Items changed to 3; Top 10%; Above Average | `#topbottom` |
| data bars; two- and three-colour scales; icon sets; editing an icon set's values | `#bars` |
| the Rules Manager; the order; Delete Rule; Clear Rules | `#manage` |
