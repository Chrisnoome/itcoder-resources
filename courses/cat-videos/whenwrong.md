# CAT 11 lesson 25: When computers get it wrong - videos

Lesson: `content/cattheory11/whenwrong.php`. Two videos. Board in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words on screen being talked about. Video 2 has one short screen recording in
Access in the video VM. Everything below is in the lesson text.

## cat11-25.1 Who got it wrong? People, bugs and broken hardware (about 7 min)

**Goes:** after section `#hardware` - the comment after `w25Backup`.
**The pupil can afterwards:** tell accurate from valid, name the usual human errors at data input and ways to reduce them, explain what a software bug is and why the quiet ones are dangerous, and say why hardware fails and how to protect work.
**Thumbnail:** tag `CAT · SOCIAL`, title "A bill for *R48 650*"

### Scenes

1. **Hook (0:00-0:45).** Hi, and welcome to BestLessons. Gogo's municipal account says she owes R48 650 for one month of electricity. She usually pays about R1 200. The meter reader typed one digit wrong, and the computer did every sum after that perfectly. Who got it wrong?
   > Board: a bill with "R48 650" circled; Gogo's raised eyebrow; Clicky pointing at one digit.
2. **GIGO, and two words (0:45-1:50).** Garbage in, garbage out, from Grade 10. Accurate means correct - it matches the real world. Valid means sensible and allowed. Thabo's grade typed as 12: allowed, but wrong. Typed as 15: not even allowed.
   > Board: the three-row table (11, 12, 15) with ticks and crosses. Yellow highlighter on the middle row.
3. **People at the keyboard (1:50-3:10).** Typing errors; transposition errors - 58 for 85; data left out; the wrong box; a 7 read as a 1; the same order twice; last year's address. Cut them down: scan it, choose it from a list, let the source type it, let a sensor measure it.
   > Board: a form with each mistake appearing in red marker; then four arrows to a barcode, a drop-down list, a parent at a phone, a smart meter.
4. **Software bugs (3:10-4:50).** A bug is a mistake in a program's instructions - every copy carries it. Crashes, broken features, security holes, and the worst: wrong answers that look right. Ms Naidoo's =AVERAGE(C2:C31) leaves out the last pupil in row 32: no error, a neat average, wrong. Testing, patches, reporting. The 1947 moth in the Harvard Mark II.
   > Board: a spreadsheet column of 31 marks with the formula's range drawn as a bracket that stops one short; highlighter on "C31". A moth taped in a logbook in the corner.
5. **Hardware failure (4:50-6:30).** A physical part stops working: wear, heat and dust, a surge after a power cut, a dropped laptop, a faulty part. Data lost, work stopped, wrong readings. Warning signs: clicking, sudden switch-offs, files that will not open, a hot laptop, a swollen battery. Protect: back up somewhere else, a surge protector or UPS, keep it cool and clean, replace old parts, handle with care. About 1 or 2 drives in every 100 die each year.
   > Board: a hard drive with a crack and a "click click" bubble; then a numbered checklist. Pink highlighter on "back up".
6. **Sign-off (6:30-7:00).** People, programs or parts - three ways in for wrong information.

### In the text

| Video point | Lesson anchor |
|---|---|
| Gogo's R48 650 bill | Start here |
| GIGO; accurate vs valid; the grade table | `#gigo` |
| human errors at input; four ways to type less | `#human` |
| software bugs; the AVERAGE example; what is done | `#bugs` (and its margin note for the moth) |
| why hardware fails; effects; signs; protection; 1-2 in 100 | `#hardware` (and its margin note) |

## cat11-25.2 Validation and verification - allowed, or correct? (about 7 min)

**Goes:** after section `#verification` - the comment after `r25Both`.
**The pupil can afterwards:** name and use the presence, range, type and format checks, set them up in Access, explain verification and its methods, and tell validation from verification.
**Thumbnail:** tag `CAT · SOCIAL`, title "Allowed - but *wrong*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Anele is in Grade 11. Somebody types 12. Will the computer notice?
   > Board: the validation-verification drawing, left half only: the paper form (11) and the screen (12).
2. **Validation (0:30-1:30).** The computer checks, as data is typed in, that it is sensible and follows the rules - and refuses it with a message if not. It is the bouncer: it checks you are allowed in, not who you are.
   > Board: Clicky as a bouncer at a door marked DATABASE; a "15" turned away, a "12" let in.
3. **Four checks (1:30-3:10).** Presence - not empty. Range - between a lowest and a highest: a test mark from 0 to 50. Type - the right kind: numbers only in "Quantity". Format - a pattern: a cell number of 10 digits starting with 0.
   > Board: the Learn / Memorise table built row by row. Yellow highlighter on each check's name.
4. **In Access (3:10-4:30).**
   > Screen (VM, Access, a table "Pupils" in Design View): click the field "Surname", set **Required** to Yes; click "TestMark", set **Validation Rule** to `Between 0 And 50` and **Validation Text** to "A mark must be from 0 to 50"; switch to Datasheet View, type 63 in TestMark and show the message; leave Surname empty and show the message.
   Narration: Required is a presence check. The Validation Rule is a range check, and the Validation Text is the message the user sees. The data type is a type check, and an input mask is a format check.
5. **What validation cannot do (4:30-5:00).** 43 typed instead of 34 passes every check. Valid - and still wrong.
6. **Verification (5:00-6:20).** Checking that the data is correct - it matches the source. Double entry: type it twice and the computer compares ("confirm your password"). Proofreading against the original form. Reading it back. A confirmation screen. A one-time PIN to a cell number. Back to Anele: a person compares the screen with the form - 11 against 12 - caught.
   > Board: the right half of validation-verification drawn in; Clicky with a magnifying glass between form and screen.
7. **Side by side (6:20-6:50).** Validation asks "Is it allowed?" - done by the computer, catches the impossible. Verification asks "Is it correct?" - a person or a second copy, catches the possible-but-wrong. Good systems use both.
   > Board: the two-column comparison table; highlighter on "allowed" and "correct".
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| validation; the bouncer | `#validation` (the doodle caption) |
| presence, range, type, format | `#validation` (Learn / Memorise table) |
| Required, Validation Rule and Text, data type, input mask | `#validation` (Where you set them up yourself) |
| 43 for 34 gets through | `#validation` (What validation cannot do) |
| verification and its methods; Anele | `#verification` (and the figure) |
| the comparison table; use both | `#verification`; the reveal `r25Both` |
