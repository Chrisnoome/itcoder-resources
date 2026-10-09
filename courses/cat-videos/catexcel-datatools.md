# CAT Spreadsheets lesson 25: Data validation and the data tools - videos

Lesson: `AIPascalCourse/content/catexcel/datatools.php` (Grade 12). Written
to [../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365, a window 1860
wide), on the lesson's own workbook: Phumlani's sports day entries (sheets
Entries, Events and Signups) - `tools/sim-screens/catexcel-datatools.ps1`
builds it. Board scenes in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words being talked about.

## catexcel-25.1 A drop-down list and other validation rules (about 8 min)

**Goes:** after the prose block "A drop-down list" (section `#list`), before
the simulation `simValidList`.
**The pupil can afterwards:** give cells a drop-down list from another
sheet, a whole-number rule, an input message and a Stop alert, and find old
mistakes with Circle Invalid Data.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Keep bad data *out*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. "100m", "100 m",
   "100 metres": three spellings, and COUNTIF counts only one. Grade 21. A
   Grade 7 at a high school.
   > Board: Clicky as a bouncer at a cell's door, turning away "Grade 21".
2. **Garbage in, garbage out (0:40-1:20).** Validation checks while data is
   typed - the only tool that stops a mistake before it is made.
3. **The list (1:20-3:20).** Select C3:C14; Data > Data Validation; Allow
   List; Source =Events!$A$2:$A$9; OK. The arrow; a wrong entry refused.
   > Screen: v-0, v-1, v-2, v-4b, v-5.
4. **Other rules (3:20-4:40).** Whole number between 8 and 12; Date; Text
   length; Decimal; Custom.
   > Screen: the whole-number rule (k-2).
5. **Messages (4:40-6:00).** Input Message - the yellow note (k-1). Error
   Alert: Stop refuses; Warning and Information let it in.
   > Board: a red cross, a yellow triangle, a blue i.
6. **What was there before (6:00-7:20).** A rule checks only new typing.
   Circle Invalid Data: red circles on 13, 7 and 21. Fix from the register;
   Clear Validation Circles.
   > Screen: k-3.
7. **Sign-off (7:20-7:50).**

### In the text

| Video point | Lesson anchor |
|---|---|
| why validation; GIGO | `#why` |
| the drop-down list, the Source | `#list` |
| the Allow kinds, whole number 8-12 | `#kinds` |
| input message, error alert styles, copying and clearing | `#messages` |
| Circle Invalid Data, pasting past a rule | `#circle` |

The IEB tools (Remove Duplicates, Text to Columns, queries, protecting a
workbook, recording a macro) are shown in pictures and two short
simulations; no video.
