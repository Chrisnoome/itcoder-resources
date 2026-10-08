# CAT practical courses: How to work with software simulations - video

Chris, 8 October 2026: "do a tutorial video ('How to work with software
simulations') that gives examples." One video, shown at the start of every
CAT practical course (Word, Excel, Access, PowerPoint), before the course's
"Try this" practice simulation. First placed in `content/catpilot/word.php`
(the `// VIDEO catprac-00.1` comment after the prose block "Try this first:
how simulations work"). Everything below is in that block and in the
simulation's own "How it works" box (`SimHowItWorksHtml()` in
`lib/simulation.php`).

Mostly a **screen recording of a lesson page** (bestlessons.co.za, a test
pupil, Privacy screen on - no real names), with short board scenes in the CAT
marker style with Clicky (brand/cat-art-style.md). Show the cursor large;
yellow highlighter on the part of the page being talked about. One short
Word clip, recorded in the **CAT VM `itcoder-cat`** (not the video VM).

## catprac-00.1 How to work with software simulations (about 7 min)

**Goes:** at the start of each CAT practical course, after the prose block
"Try this first: how simulations work", before `SimulationPractice (...)`.
**The pupil can afterwards:** read a simulation step (step number, badge,
instruction), do each kind of step (click, double-click, right-click, type,
press keys), say what happens after a wrong try and a second wrong try, and
how marks are given.
**Thumbnail:** tag `CAT · PRACTICAL`, title "How *simulations* work"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. In the CAT practical
   courses you work on real screens from Word, Excel, Access and PowerPoint.
   Each task is a simulation: one picture at a time, one thing to do on each
   picture. They are easy - if you know three things: read the screen, do
   exactly one thing, and be accurate.
   > Board: Clicky in front of a big screenshot, a sticky note "1 picture = 1 thing to do".
   > Screen (5 s): the same task in real Word in the VM - click the Font Size box, type 16, Enter, Ctrl+B - then cut to the simulation of it.
2. **What is on the page (0:40-1:50).** Above Start: the task, and the How it
   works box - read it once. Press Start. Above the picture: "Step 1 of 3",
   a badge, and the instruction. The badge says what kind of step it is:
   Click, Double-click, Right-click, Type or Press keys. Read both before you
   do anything.
   > Screen: the practice simulation in the Word course; highlighter on the How it works box, then on "Step 1 of 3", the badge and the instruction in turn.
3. **A click (1:50-2:40).** Step 1: "Click in the Font Size box." Click once,
   right on the box. Near it is wrong. The frame goes green, "Done - next
   step", and the next picture comes.
   > Screen: zoom in on the Font Size box; Clicky's arrow lands right on the 12. Green frame.
4. **Typing (2:40-3:30).** Step 2: badge Type. Click in the box on the
   picture, type exactly what is asked - 16, no "pt" - and press Enter.
   > Screen: typing 16, Enter; green.
5. **Keys (3:30-4:10).** Step 3: badge Press keys. Click the picture, then
   press the keys together: hold Ctrl down and tap B.
   > Screen: an on-screen key overlay showing Ctrl + B.
   > Board: a hand holding Ctrl, a finger tapping B.
6. **Double-click and right-click (4:10-4:40).** Two other badges: Double-click
   - two quick clicks; Right-click - the right mouse button. Same rule: right
   on the spot.
   > Board: Clicky double-tapping a word; Clicky pressing the right side of a mouse.
7. **A wrong try (4:40-5:50).** Press Try it again, and this time click in the
   wrong place on purpose. A message pops up: "You clicked in the wrong
   place", the instruction again, a hint, and "You have one more try". Read
   it, click OK, and try again. Now wrong a second time: the picture shows in
   red where the right place was. That step earns nothing; press Next step
   and go on.
   > Screen: the click on the font name instead; the pop-up with highlighter on each line; OK; a second miss; the red box; Next step.
8. **Marks and order (5:50-6:40).** Right first time: full marks for the
   step. Right on the second try: half. Two misses: none, and you see where it
   was. The practice has no marks - the real ones do. The steps go in order,
   as in the real program: you cannot skip ahead. So: read the screen, do
   that one thing, be accurate.
   > Board: three sticky notes - "1st try: full", "2nd try: half", "2 misses: 0, see where". Then the three rules on one card.
9. **Sign-off.** Now do the Try this practice below.

### In the text

| Video point | Lesson anchor |
|---|---|
| one picture, one thing to do; practice has no marks | prose "Try this first", paragraphs 1-2 |
| Step 1 of 3, the five badges, read both | prose "Try this first", paragraph 3 |
| click right on it, double/right-click, typing then Enter, keys together | prose "Try this first", the list |
| the pop-up, one more try, second miss shows the place, marks, order, be accurate | prose "Try this first", last paragraph; the How it works box |
| Font Size 16 and Ctrl+B | the practice simulation's three steps |

### Other courses

The same video goes in Excel, Access and PowerPoint; their practice
simulations (`SimulationPractice ('excel')` etc., still to be built) use
their own screens, so the video says "for example in Word" and the Word
practice is the one recorded.
