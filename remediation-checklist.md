# Remediation - manual checks on the live site

Written 1 October 2026 by the remediation chat, for Chris to work through (or
hand to a new chat). Everything here is built and checked server-side; these
are the things only a person in a browser can confirm.

**Before you start:**
- Items 1-12 are live already. **Items 13-16 (Habits tabs, strategies, class
  Habits tab, focus card) need your next synchronised publish** (commit
  e239420).
- You need two accounts: your **teacher/admin** account, and a **pupil**
  account in one of your groups (call it *Test Pupil*). "Pupil view" = signed
  in as Test Pupil; "teacher view" = signed in as you.
- A pupil's work page link is `pupil-work.php?c=COURSE&p=PUPIL-ID`: the
  easiest way in is to click the pupil's name in Class results.
- Tick a box when it is right; note what is wrong next to it.

## A. Reset a question (live)

- [ ] **1. Reset from a query.** Pupil view: answer a question in
  [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01) (the
  quiz "The song says all a computer does is add and compare..."), then press
  *Query this mark with my teacher*. Teacher view:
  [Pupil queries](https://bestlessons.co.za/teacher-queries.php) - open it.
  **Look for:** three answers - *The mark is correct*, *New mark*, and
  **↺ Reset the question** (with a confirm box). Press Reset.
  **Then:** the query shows "Question reset (was x / y)" and the old answer
  still shows on the query. Pupil view: the question is unanswered again,
  with the line "Your teacher reset this question for you to answer again."
  Answer it again - **Query this mark** is available again.
- [ ] **2. Reset from the pupil's work page.** Teacher view:
  [Class results, Pascal](https://bestlessons.co.za/teacher.php?c=pascal) - click
  Test Pupil - find an answered question - **Reset this question**.
  **Look for:** the confirm text says the old answer is kept for staff; the
  question goes back to "Not answered yet". Try it on an SQL or grid question
  too (these failed before).

## B. Reading options for dyslexia (live)

- [ ] **3. The Reading card.** Pupil view:
  [My settings - Reading](https://bestlessons.co.za/pupil-settings.php#reading).
  **Look for:** Font, Text size, Background, Reading-aloud speed, Wider
  spacing, Reading ruler, Read aloud, Colour-safe colours. Each choice changes
  the page **straight away**, before Save. Press Save - the card says "✓ On".
- [ ] **4. Fonts.** Same card: try **OpenDyslexic** and **Atkinson
  Hyperlegible**. **Look for:** the whole page changes font; then open
  [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01) -
  the lesson text is in the chosen font but **code stays in its own
  monospace font** (no OpenDyslexic in code boxes or the console).
- [ ] **5. Size, spacing, tint, ruler.** With Largest + Wider spacing + Cream +
  Ruler on, open [AI lesson 1](https://bestlessons.co.za/lesson.php?c=ai&id=lesson01).
  **Look for:** bigger, more spaced text; cream background; a yellow band
  follows the mouse; the top menu bar stays its normal size. On your phone:
  nothing runs off the right edge (except the bottom bar, a known older issue).
- [ ] **6. Read aloud.** With Read aloud on, in
  [AI lesson 1](https://bestlessons.co.za/lesson.php?c=ai&id=lesson01): each part
  has a **🔊 Read aloud** button. **Look for:** it reads the part aloud, the
  word being read is highlighted, the button turns into **■ Stop**, and
  Escape stops it. Note which voice your school PCs use (no South African
  voice on yours).
- [ ] **7. Everything off.** Set everything back to the site's defaults and
  Save. **Look for:** lessons look exactly as before (no 🔊 buttons, normal
  font).

## C. Spelling concession (live)

- [ ] **8. The switch.** Teacher view: Test Pupil's work page in
  [Class results, Theory 10](https://bestlessons.co.za/teacher.php?c=theory10)
  (or any course) - **Spelling concession** switch near the top; turn it on.
  **Look for:** it stays on after the page reloads. Pupil view:
  [My settings - Reading](https://bestlessons.co.za/pupil-settings.php#reading)
  shows "Your teacher has given you a spelling concession".
- [ ] **9. A near-miss counts (not in code).** Pupil view, concession on:
  [Theory 10 - Binary](https://bestlessons.co.za/lesson.php?c=theory10&id=binary),
  the typed question "Give the term for the number of digits a number system
  uses" - type **radiz** (one letter off "radix"). **Look for:** marked
  right. Words of 1-4 letters must still be exact ("bace" for "base" is
  wrong). In [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01)
  nothing changes - no concession in Pascal, Java or SQL.

## D. Colour blindness (live)

- [ ] **10. Ticks and crosses everywhere.** Pupil view, answer wrongly on
  purpose in:
  - [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01):
    the quiz ("add and compare") - options say **✓ right** / **✗ not right**;
    the sort-into-groups question ("The computer is stupid, but it goes like
    mad") - a wrong line says **✗ should be: ...**; the mark-the-words
    question ("A program must find Lerato...") - a missed word has a
    **dashed** ring.
  - [Pascal lesson 2](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson02):
    "Tick every value that should be a constant" - each option ✓ / ✗.
  - [Pascal lesson 3](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson03):
    the GotoXY grid (hotspot) - each pin has a small ✓ or ✗.
  - [Pascal lesson 8](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson08):
    "This time the whole last column is missing" - wrong cells "✗ should be:".
  - [Practice, Pascal](https://bestlessons.co.za/practice.php?c=pascal): flash
    cards say RIGHT / NOT QUITE on the back; score dots have ✓ / ✗; the
    order game rows get ✓ / ✗ and the message no longer says "the green ones".
  Teacher view: [Class results, Pascal](https://bestlessons.co.za/teacher.php?c=pascal) -
  cells show ✓ (full marks) and ◐ (some), the key under the grid names ✓ ◐ ⚑ ⚠.
- [ ] **11. Colour-safe colours and the colour vision check.** Pupil view:
  [My settings - Colour vision](https://bestlessons.co.za/pupil-settings.php#colours) -
  Start the check. **Look for:** 8 circles of dots, the numbers clear to you
  (the first, 12, easy for everyone); "All clear" at the end. Then turn on
  **Colour-safe colours** (Reading card) and repeat a wrong answer in
  [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01):
  right/wrong are now **blue / orange** instead of green / red.

## E. The NB fold (live), then Habits, strategies, class view (after your next publish)

- [ ] **12. The NB fold (live).** [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01),
  the written question "Which language - A, B or C - do you think is easiest
  to understand, and why?". **Look for:** the *NB: one go only* box has a
  clear **Hide ▴ / Show ▾** button on the right.
- [ ] **13. Pupil work page tabs.** Teacher view: [Class results, Pascal](https://bestlessons.co.za/teacher.php?c=pascal) -
  click a pupil with marked written work. **Look for:** tabs **Current |
  Habits | Remediation strategies** and "staff only" on the right; Current is
  the page as before.
- [ ] **14. Habits tab.** Same pupil - **Habits**. **Look for:** a heatmap
  (lessons down, habit codes across, numbers in the cells, ⚠ on patterns),
  then each habit with the evidence links. (Written answers are tagged from
  1 October, so expect little at first - try a pupil who has handed in
  written work since then.)
- [ ] **15. Remediation strategies tab + the focus card.** Same pupil -
  **Remediation strategies** - on a pattern (or skip if none yet): pick a
  strategy, status **In progress**, tick **Show the pupil**, add a note,
  **Save**. **Look for:** it saves (status badge "In progress", "by you,
  today"); "Did it help?" shows "too soon to tell". Pupil view (that pupil):
  any lesson, e.g. [Pascal lesson 1](https://bestlessons.co.za/lesson.php?c=pascal&id=lesson01) -
  under the title, **🎯 Your focus, from your teacher** with the kind line,
  **never the habit's name or code**. Set it back to Planned or Remove the
  plan - the card disappears.
- [ ] **16. Class Habits tab.** Teacher view: [Class results, Pascal](https://bestlessons.co.za/teacher.php?c=pascal) -
  **Habits** tab. **Look for:** "Working out..." then pupils down, habit
  codes across, each cell a % (⚠ on patterns); a pupil's name opens their
  Habits tab; when several pupils share a pattern, a **Reteach the class**
  box. Note how long it takes for your biggest class (warn the chat if it is
  slow - the VPS is small).

**When done:** tell the chat which boxes failed, with what you saw.
