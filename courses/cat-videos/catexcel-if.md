# CAT Spreadsheets lesson 13: The IF function - videos

Lesson: `AIPascalCourse/content/catexcel/if.php` (Grade 11). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026
(writer B of the Grade 11 chapter). Screen recordings in the **CAT VM
`itcoder-cat`** (Excel 365), on the lesson's own workbook: Ms Naidoo's
Grade 11C test 2 (sheet Test 2) and Mr Botha's orders (sheet Orders) -
`tools/sim-screens/catexcel-if.ps1` builds both. Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words being talked about.

## catexcel-13.1 The IF function: one question, two answers (about 8 min)

**Goes:** after the prose block "The IF function" (section `#if`), before
the simulation `simPassFail`.
**The pupil can afterwards:** plan a decision (condition, true path, false
path), write =IF(condition,value_if_true,value_if_false) with words in
quotes, numbers and "", copy it down, and compare with a pass mark in a
cell ($G$3).
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "*IF*: Excel makes the decision"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Ms Naidoo has 30
   marks and wants Pass or Fail next to each. Typing them takes ten
   minutes - and the moment one mark changes, a typed word is wrong.
   > Board: Clicky at a fork in the road, signposts "50 or more?" - YES and NO.
2. **Plan it in words (0:40-1:50).** The condition (is B4 50 or more?), the
   true path (Pass), the false path (Fail). A building block: one test,
   two ways out - a traffic light, a PIN, a vending machine. "50 or more"
   is >=50; "more than 50" is >50 - and Zanele has exactly 50.
   > Board: the three-row plan table; highlighter on >=.
3. **The formula (1:50-3:30).** Click C4, type =IF(B4>=50,"Pass","Fail"),
   Enter: Pass. Read it aloud. Click C4, double-click the fill handle: the
   whole class. Show Formulas: each row tests its own mark.
   > Screen: the Test 2 sheet; highlighter on the three arguments and the commas.
4. **Words, numbers and nothing (3:30-4:40).** Words in quotes; numbers
   without; "" for nothing - the Note column, =IF(B4<40,"See me",""). Leave
   the false value out and the cell says FALSE.
   > Screen: D4 typed and filled; only Gift and Sipho get "See me".
5. **A calculation as the answer (4:40-5:40).** Mr Botha's 10% off from
   R500: =IF(B4>=500,B4*10%,0). R1 250 gets 125, R495 gets 0 - so close!
   > Screen: the Orders sheet; C4 typed and filled; =B4-C4 in column D.
6. **The pass mark in a cell (5:40-7:00).** Type 50 in G3 and use
   =IF(B4>=$G$3,"Pass","Fail") - F4 for the $ signs. Change G3 to 40: Imran
   and Mpho pass, nothing else touched. Without the $, the copies compare
   with G4, G5 ... and everyone passes.
   > Screen: G3 from 50 to 40 (the before-and-after of the lesson).
7. **Sign-off (7:00-7:30).** Plan it in words, write it in one line, test it
   on the edge.

### In the text

| Video point | Lesson anchor |
|---|---|
| condition, true path, false path; >= against > | `#decisions` |
| =IF(B4>=50,"Pass","Fail"), reading it aloud, filling down | `#if` |
| quotes, numbers, "", the FALSE you get with no false value | `#text` |
| =IF(B4>=500,B4*10%,0) | `#calc` |
| $G$3, F4, changing the pass mark | `#cell` |

## catexcel-13.2 When IF goes wrong (about 6 min)

**Goes:** after the prose block "When IF goes wrong" (section `#mistakes`),
before the simulation `simFixQuotes`.
**The pupil can afterwards:** find and fix the common IF mistakes, use the
Function Arguments box to check a formula part by part, and test a formula
on the edge.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Why is *everyone* failing?"

### Scenes

1. **Hook (0:00-0:30).** The whole class fails - even Fatima, with 93. No
   error anywhere. What happened?
   > Screen: the Result column, Fail in every row.
2. **Read it aloud (0:30-1:40).** Click C4, read the Formula Bar:
   =IF(B4>="50","Pass","Fail"). "50" in quotes is text, and text is bigger
   than any number. Take the quotes off: Pass.
   > Screen: the fix typed over C4; highlighter on "50".
3. **#NAME? (1:40-2:30).** =IF(B4>=50,Pass,Fail): words without quotes -
   Excel looks for something called Pass.
4. **Swapped and off by one (2:30-3:40).** =IF(B4>=50,"Fail","Pass"): 93
   fails. =IF(B4>50,...): only Zanele's 50 is wrong. And => makes Excel
   refuse the formula outright.
   > Board: the mistakes table, one line at a time.
5. **The Function Arguments box (3:40-5:00).** Formulas > Logical > IF:
   Logical_test, Value_if_true, Value_if_false; it adds the quotes and shows
   TRUE or FALSE beside the condition. fx on a finished IF opens it filled -
   a way to check each part.
   > Screen: the box, empty, then filled for "See me"; highlighter on Formula result.
6. **Test on the edge (5:00-5:40).** Exactly 50, exactly R500 - and one row
   you can work out in your head.
7. **Sign-off (5:40-6:00).**

### In the text

| Video point | Lesson anchor |
|---|---|
| the mistakes table, reading a formula aloud, Ctrl+` | `#mistakes` |
| "50" in quotes makes everyone fail | `#mistakes` (simulation `simFixQuotes`) |
| testing on the edge | `#mistakes` (the reveal `r13Edge`) |
| Formulas > Logical > IF, the Function Arguments box, fx, Help on this function | `#arguments` |
