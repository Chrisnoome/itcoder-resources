# CAT Spreadsheets lesson 19: Nested IF, AND and OR - videos

Lesson: `AIPascalCourse/content/catexcel/nestedif.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: Ms Naidoo's Grade 12A prelims (sheet Prelims) and the
prelim timetable (sheet Timetable) - `tools/sim-screens/catexcel-nestedif.ps1`
builds both. Board scenes in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words being talked about.

## catexcel-19.1 A nested IF, step by step (about 8 min)

**Goes:** after the prose block "A nested IF" (section `#nested`), before
the simulation `simNestedIf`.
**The pupil can afterwards:** turn a rule with three answers into a nested
IF, read one aloud, and say why the order of the tests matters.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Three answers? *Two* IFs."

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Ms Naidoo's prelim
   marks must go into three groups: Distinction, Pass and Support. One IF
   gives two answers. Here is how to get three.
   > Board: Clicky at a fork in the road; a second fork further down the "no" road.
2. **IF in one minute (0:40-1:30).** =IF(test, value if TRUE, value if FALSE),
   with =IF(D3>=50,"Pass","Fail"). Words in quotes, numbers not.
   > Screen: the Prelims sheet; highlighter on each of the three parts in the Formula Bar.
3. **Two questions, one after the other (1:30-3:00).** Is it 80 or more?
   If not - is it 50 or more? The second IF goes in the FALSE part.
   Type =IF(D3>=80,"Distinction",IF(D3>=50,"Pass","Support")) in E3 slowly,
   naming each piece; point out the bracket colours.
   > Screen: E3 clicked, the formula typed, Enter: Pass.
4. **Work it through (3:00-4:00).** Imran, 86: the first test is TRUE -
   Distinction, the second IF is never read. Zanele, 70: FALSE, then TRUE -
   Pass. One IF fewer than the number of answers.
   > Board: the decision staircase with 86 and 70 walking down it.
5. **Copy it down (4:00-4:40).** Select E3, double-click the fill handle.
   Chloe's exactly 80.0 is a Distinction because of >=.
   > Screen: the fill handle double-clicked; highlighter on row 6.
6. **The wrong order (4:40-6:00).** =IF(D3>=50,"Pass",IF(D3>=80,...)):
   everyone 80 and up gets Pass. Excel stops at the first TRUE test. The two
   orders that work: biggest first with >=, smallest first with <.
   > Screen: the wrong formula filled down (e-2); highlighter on Imran, Chloe, Fatima, Owen.
7. **Five mistakes (6:00-7:20).** No quotes round a word (#NAME? - e-1),
   quotes round a number, brackets, => for >=, > for "or more".
   > Screen: the #NAME? cell; Board: a checklist ticked off by Clicky.
8. **Sign-off (7:20-7:50).** Plan it first: the cell, the answers, the
   boundaries in order, one IF each, close, test the edges.

### In the text

| Video point | Lesson anchor |
|---|---|
| IF's three parts | `#recap` |
| the second IF in the FALSE part; the formula piece by piece; Imran and Zanele worked through; one IF fewer than the answers | `#nested` |
| fill down; 80.0 is a Distinction | `#nested` (the simulation `simNestedIf`), the quiz `q19Edge` |
| the wrong order, and the two orders that work | `#order` |
| the five mistakes, #NAME? for a word without quotes | `#mistakes` |
| planning in four steps | `#plan` |

## catexcel-19.2 AND and OR inside IF (about 6 min)

**Goes:** after the prose block "OR: at least one" (section `#or`), before
the simulation `simOrLetter`.
**The pupil can afterwards:** choose between AND and OR from a rule in
words, put either inside IF, and check a sheet with Show Formulas.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "*AND* or *OR*?"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Two rules: the CAT
   trip needs 70 for the PAT and 70 for the exam; a letter home goes out for
   under 40 in either. Two conditions each - but not the same kind.
   > Board: two circles overlapping, Clicky standing in the middle (AND), then anywhere (OR).
2. **AND (0:30-2:00).** =AND(B3>=70,C3>=70) is TRUE only when both are.
   Inside IF: =IF(AND(B3>=70,C3>=70),"Yes","No"). AND closes its bracket
   before the IF's comma. Zanele, 72 and 68: No.
   > Screen: F3 clicked, the formula typed, filled down; highlighter on Tamsin's 70 and 70 (Yes).
3. **OR (2:00-3:20).** =IF(OR(B3<40,C3<40),"Letter","OK"). Gift (exam 38)
   and Mpho (PAT 38) get letters - one is enough.
   > Screen: G3, the formula, filled down.
4. **The table (3:20-4:10).** TRUE/FALSE pairs and what AND and OR give.
   "Both", "and also" - AND; "either", "any of" - OR.
   > Board: the four-row table, highlighter on the one TRUE in the AND column.
5. **Show Formulas (4:10-5:00).** Ctrl+` - every formula at once; each row
   tests its own cells. Ctrl+` again.
   > Screen: Ctrl+` pressed (o-3).
6. **Where they live (5:00-5:40).** Formulas tab > Logical: IF, AND, OR -
   and IFS, which some markers accept, but learn the nested IF.
   > Screen: the Logical list open (f-2).
7. **Sign-off (5:40-6:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| AND, the trip formula, Zanele's No | `#and` |
| OR, the letter formula | `#or` |
| the TRUE/FALSE table; "both" against "either" | `#or` |
| Show Formulas, Ctrl+` | `#or` |
| the Logical list, IFS | `#logical` |

CHOOSE (IEB) is short and shown step by step in its simulation; no video.
