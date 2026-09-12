# Marking House Style — Practical Exams & Programming Submissions

**Scope:** Marking Grade 10–12 IT/CAT practical programming submissions (Pascal/Delphi/Lazarus) against a memo, and generating memos for practical exams, within the IEB SAGS framework — a **formal, summative exam**, marked against an official memo. Companion document: the [Pascal House Style](pascal-house-style.md) sheet (style is never a marking criterion here, but it's the convention candidates and memos are written in).

**This is not itcoder's in-course practice question policy.** The Pascal course on itcoder deducts a flat 1 mark for a house-style violation on its own written/code practice questions (content-voice-and-pedagogy.md §4) - deliberately different from this document, not a conflict with it. That policy is **formative**: it builds the habit of writing clean code *before* a candidate ever sits a real practical exam, where - per this document - style is rightly not examined at all. The exam tests problem-solving; the course-work builds the discipline that makes problem-solving legible. Both stand, for their own purpose.

## 1. Core marking philosophy

- **Allocate marks for correct steps**, even when the surrounding code is wrong or misplaced — e.g. give the marks for a correctly structured loop even if its contents are incorrect or it's in the wrong place.
- **Carry-forward applies fully.** If a caller correctly invokes a function (right identifier, right parameters, correctly wrapped — e.g. inside `Writeln`), award full marks for that line even if the called function's own internal logic is wrong.
- **Never penalise the same root-cause bug twice.** One mistake, one mark loss — even if it shows up in several places.
- **Do not penalise for style.** Naming, layout, and other house-style matters (see the Pascal House Style sheet) are never a markable criterion.
- **Do not penalise a missing semicolon.**
- **Do not penalise Pascal project/file naming conventions** (e.g. an `<Initial_Surname>` format) — treat as style, award full marks regardless.
- **Do not penalise screenshot filenames** for failing to identify the candidate — award full marks for that criterion regardless of filename.
- **Accept valid built-in-function substitutions.** Where a task can be solved with a built-in function (e.g. `StringReplace` for a search-and-replace task), award full marks if the correct outcome is achieved, even if the memo shows a manual/first-principles approach.

## 2. Cognitive level classification (SAGS 2.6.2)

The practical paper is weighted L1 30% / L2 40% / L3 30%.

- **L1 — Recall:** pure declarations, fixed direct-instruction output, non-code process compliance.
- **L2 — Application:** prescribed or guided steps — applying a given formula or threshold, a routine loop, a call made exactly as instructed.
- **L3 — Problem solving:** genuine independent thinking — working out something not fully spelled out, combining results in a way not described, handling an edge case not modelled elsewhere.

A single question is not necessarily one level throughout — its marks may be split across L1/L2/L3 where different parts of the answer demand different thinking.

## 3. Marking output format

- Always answer by marking directly **on a full listing of the program**, using comments to indicate marks awarded (and, where useful, why).
- **Never offer suggested alternative code.** Marking is not an editing pass.
- **Comment on incorrect code even where no marks are deducted for it** — the candidate (or teacher) should still see that something is wrong.
- Derive the **student's name** from the submission's filename or from comments in the code.
- Put the **student's name, total mark, and percentage** at the top of the marked document.
- Follow the memo. If no memo has been supplied, ask for one before marking.
- All marking must be **explained and motivated** — a mark awarded or withheld should say why, not just show a number.

## 4. Conventions that carry rubric weight

A small number of coding-structure conventions are specifically worth marks in this school's papers and memos, distinct from ordinary style:

- **`PadStr`-type formatting helpers must be a separate private method of the class**, not written inline — worth 2 marks where it appears in a rubric.
- **Procedures must not produce output; functions return values**, and the main program (or calling code) is what calls `Writeln`. This is a structural expectation the memo may mark on, not just a style preference.

## 5. Generating a marking memo

When asked to generate a memo for a practical exam:

1. **Break the marks down into steps** — each line or small group of lines that earns marks is its own line item, not a single lump total for the whole question.
2. **Provide acceptable alternatives** for each step wherever more than one valid approach exists (e.g. a built-in function vs. a first-principles loop; different but equally valid variable/data structure choices).
3. **Structure the memo to facilitate marking as described in Sections 1–3 above** — it should make it straightforward to award marks per correct step, apply carry-forward, and ignore style, on a full code listing.

## 6. Quick checklist

- [ ] Marks allocated per correct step, independent of surrounding correctness
- [ ] Carry-forward applied to correct calling code
- [ ] No double-penalising the same root cause
- [ ] No deductions for style, naming, missing semicolons, project/file naming, or screenshot filenames
- [ ] Valid built-in-function alternatives accepted
- [ ] Cognitive levels (L1/L2/L3) applied per the SAGS 30/40/30 weighting, split within a question where appropriate
- [ ] Marking shown as comments on a full code listing
- [ ] No suggested alternative/corrected code offered
- [ ] Incorrect code commented on even when no marks are lost
- [ ] Student name, total, and percentage at the top
- [ ] Memo followed (or requested if missing)
- [ ] Every mark explained and motivated
- [ ] Memo (when generating one) broken into steps with acceptable alternatives
