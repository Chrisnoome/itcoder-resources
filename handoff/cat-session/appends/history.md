# Append to: AIResources/history.md

A dated entry, in whatever shape the file already uses. Add it at the end
(or wherever the newest entry goes) - do not reorder what is there.

---

## 27 September 2026 - CAT planned; the bundle designed (cloud session)

A cloud session read the CAT sources (the CAPS document with its 2024
amendment, the IEB SAGs, and the last three November papers and memos for
both boards) and produced six reference and planning files, now at the
AIResources root as `cat-*.md` and `courses/cat-course.md`.

**Shape.** CAT becomes **eight courses**: CAT Theory Grades 10, 11 and 12
(94 lessons), plus Word, Excel, Access, PowerPoint and HTML as courses of
their own (~86 lessons). One course per grade for both boards with
`BoardSection()`, as IT Theory does - about 80% of the content is shared.
Grade 10 is built end to end first.

**The IT Theory course feeds it.** 77 of the 106 built IT Theory lessons
hold usable CAT content, 58 of them almost whole; they cover 79 of CAT's 146
lessons. The other 67 - the whole Solution Development half - have no source
anywhere. The lessons are **rewritten, not shared**: CAPS tells CAT to stay
non-technical, so the CAT version of a lesson is often a third of the
length, and a shared lesson would need a depth flag the platform does not
have. Details in `cat-it-theory-reuse.md`.

**Three traps recorded there:** IT's "Information management" chapter is
data representation (binary, hex, ASCII) and **none of it is in CAT** -
those words appear nowhere in either syllabus or any of the six papers; CAT
has a hard depth ceiling CAPS states outright; and the IEB's "algorithms"
means three one-mark IPO boxes, not pseudocode.

**Decisions (Chris, the same day).** Marking as IT - fixed answers plus
Haiku 4.5 against a rubric, now including uploaded documents, over values
extracted from the file rather than the file itself. Microsoft 365 on
Windows 11, Microsoft only. A textbook PDF for scope and sequence only, the
course written in Chris's voice. Uploads gated on consent - refused means no
upload and no marking, with the reason shown. Plain-English chapter names
with the board's name as a subtitle. A study block on every lesson. Optical
storage stays taught content in CAT while IT keeps it as Good to Know.
**Pricing deferred**: free for De La Salle pupils while AI costs are tracked
through `aiUsage`, prices set from those figures.

**New platform structure: the bundle** (`bundle-design.md`). A grade-aware
set of courses a pupil joins once - horizontal, where `includes` is
vertical. One per grade, a grade carrying those below it, with a pricing
differential. IEB bundles carry both Pascal and Java, because the IEB lets
the school choose. **IT needs a bundle as much as CAT does.**

**Two source defects found**, recorded in the files and not fixed: the DBE's
published November 2023 Paper 2 memo is a second copy of the 2023 Paper 1
memo, and the 2024 CAPS amendment replaces Sections 3 **and** 4, not just
Section 3 as its title says.

Nothing was built. Nothing in `Projects/AIPascalCourse` was touched.
