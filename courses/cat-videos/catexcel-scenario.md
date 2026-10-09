# CAT Spreadsheets lesson 27: An exam-style task - videos

Lesson: `AIPascalCourse/content/catexcel/scenario.php` (Grade 12). Written to
[../cat-practical-writing.md](../cat-practical-writing.md), 9 October 2026.
Screen recordings in the **CAT VM `itcoder-cat`** (Excel 365, a window 1860
wide), on the lesson's own workbook: Phumlani's Fun Day (sheets Stalls,
Prices and Summary) - `tools/sim-screens/catexcel-scenario.ps1` builds it.
Board scenes in the CAT marker style with Clicky (brand/cat-art-style.md);
yellow highlighter on any words being talked about.

## catexcel-27.1 Planning and troubleshooting an exam task (about 9 min)

**Goes:** after the prose block "Finding what is wrong" (section `#trouble`),
before the simulation `simTrace`.
**The pupil can afterwards:** pick a function from a task's words, use
building blocks, and find a broken formula with Show Formulas, Trace
Precedents and Evaluate Formula.
**Thumbnail:** tag `CAT · SPREADSHEETS`, title "Find the *broken* formula"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The exam's data file
   has a formula that works at the top of the column and fails at the
   bottom. Ninety seconds to find out why.
   > Board: Clicky with a magnifying glass over a column of #N/A.
2. **How the exam asks (0:40-1:40).** A data file, numbered tasks, marks per
   part, formulas marked - never values.
3. **Which function? (1:40-3:20).** Underline the words: "how many ...
   that" - COUNTIF; "the total for" - SUMIF; "from the table" - a lookup;
   "the first three characters" - LEFT; "boxes needed" - ROUNDUP.
   > Board: a task with its key words in highlighter and the function beside each.
4. **Building blocks (3:20-4:20).** A helper cell for FIND; each part earns
   its mark.
5. **Finding what is wrong (4:20-7:40).** E12 shows #N/A; the Formula Bar
   says Prices!A10:C17. Formulas > Trace Precedents - the arrows and the
   sheet icon. Evaluate Formula - step by step to #N/A. Fix E4 with $ signs
   and fill down.
   > Screen: t-1, t-2, t-3, e-1 to e-4, f-1, f-2.
6. **Check before you save (7:40-8:40).** Show Formulas; the last row; an
   edge; change a value; save under the given name.
   > Screen: f-3.
7. **Sign-off (8:40-9:10).**

### In the text

| Video point | Lesson anchor |
|---|---|
| how the exam asks and marks | `#asks` |
| the task's words and the functions | `#plan` |
| building blocks | `#blocks` |
| the Formula Auditing tools, Evaluate Formula, fix the first and fill down | `#trouble` |
| checking before saving | `#check` |
