# CAT Spreadsheets lesson 22: Text functions - videos

Lesson: `AIPascalCourse/content/catexcel/text.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365), on the
lesson's own workbook: the matric yearbook list (sheets Names and Contacts) -
`tools/sim-screens/catexcel-text.ps1` builds it. Board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words being talked about.

## catexcel-22.1 Joining and cutting text (about 7 min)

**Goes:** after the prose block "Joining text" (section `#join`), before the
simulation `simJoinNames`.
**The pupil can afterwards:** join cells and typed text with &, cut a piece
out of a code with LEFT, RIGHT and MID, and turn digits stored as text into
a number with VALUE.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Cut it. *Join* it."

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The yearbook needs
   200 names in a new shape by next week. Nobody is retyping them.
   > Board: Clicky with scissors and a glue stick, a name tag in pieces.
2. **Positions (0:40-1:30).** PS12-0417 as nine boxes numbered 1 to 9; the
   dash and spaces count.
   > Board: the boxes; highlighter on positions 3 and 4.
3. **Joining (1:30-3:00).** =B2&" "&A2 typed in D2: Zanele Khumalo. Without
   the " " - ZaneleKhumalo. CONCATENATE and CONCAT do the same.
   > Screen: D2 clicked, the formula typed, filled down (j-1 to j-4).
4. **LEFT, RIGHT, MID (3:00-4:40).** =LEFT(C2,2), =RIGHT(C2,4), =MID(C2,3,2)
   on PS12-0417. Then the short name =LEFT(B2,1)&". "&A2.
   > Board: the boxes again, highlighter sliding over each piece. Screen: E2 (l-1, l-2).
5. **Text that looks like a number (4:40-6:20).** RIGHT gives 0417 on the left
   of the cell; the total is 0. =VALUE(RIGHT(C2,4)) - 417 on the right, and
   the total adds up.
   > Screen: l-4 (the 0 total, highlighter on it), then G2 retyped (l-5, l-6).
6. **Sign-off (6:20-6:50).** Positions from 1; text in quotes; text functions
   give text - VALUE makes a number.

### In the text

| Video point | Lesson anchor |
|---|---|
| characters and positions, a space counts | `#basics` |
| & and CONCATENATE/CONCAT | `#join` |
| LEFT, RIGHT, MID, the short name | `#cut` |
| text on the left, SUM ignores it, VALUE | `#value` |

## catexcel-22.2 FIND, LEN and the username (about 6 min)

**Goes:** after the prose block "Building a long formula" (section
`#blocks`), before the simulation `simUsername`.
**The pupil can afterwards:** find a character's position with FIND, count
characters with LEN, and build =LEFT(B2,FIND("@",B2)-1) and the domain
formula in two steps.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Everything *before* the @"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Every e-mail address
   has its @ in a different place. One formula has to cut every username.
   > Board: two addresses of different lengths, Clicky pointing at each @.
2. **FIND (0:30-1:40).** =FIND("@",B2) gives 15. Count it on screen. Capitals
   matter; no @ gives #VALUE!.
   > Screen: D2 on the Contacts sheet (f-1, f-2).
3. **Wrap LEFT around it (1:40-3:10).** Click D2 again: =LEFT(B2,FIND("@",B2)-1).
   One fewer than the @'s position. Filled down: imranp, @ at 7, 6 characters.
   > Screen: f-3, f-4, f-5; highlighter on the -1.
4. **LEN and the domain (3:10-4:40).** =LEN(B2) is 27; 27 - 15 = 12;
   =RIGHT(B2,LEN(B2)-FIND("@",B2)) gives mymail.co.za.
   > Board: the address with 15 and 27 marked, the last 12 boxes highlighted.
5. **Building blocks (4:40-5:30).** Build the inside part first and test it;
   or keep it in a helper cell - both boards accept building blocks, and each
   part earns a mark.
6. **Sign-off (5:30-5:50).**

### In the text

| Video point | Lesson anchor |
|---|---|
| FIND, capitals, #VALUE! when not found | `#find` |
| LEN | `#find` |
| the username and the domain formulas | `#find` |
| building in two steps; helper cells | `#blocks` |

SUBSTITUTE (IEB) is one short formula, shown in its simulation; no video.
