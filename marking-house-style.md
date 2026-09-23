# Marking house style - practical exams and programming submissions

**Scope:** marking Grade 10-12 IT/CAT practical programming (Pascal/Delphi/
Lazarus) against a memo, and writing memos, under the IEB SAGs - formal,
summative marking. Code is written in [pascal-house-style.md](pascal-house-style.md),
but style is never a criterion here.

This is **not** itcoder's in-course policy, which deducts 1 mark for a
house-style violation on practice questions (content-voice-and-pedagogy.md §4)
- that one is formative, building the habit before the exam.

## 1. Philosophy

- **Marks for correct steps**, even if the surrounding code is wrong or
  misplaced (a correct loop structure earns its marks with wrong contents).
- **Full carry-forward:** a correct call (right identifier, parameters,
  wrapping) earns full marks even if the called function is wrong.
- **One root-cause bug loses marks once**, however often it shows.
- **Never penalise:** style, naming, layout, a missing semicolon, project/file
  naming (e.g. `<Initial_Surname>`), screenshot filenames.
- **Accept valid built-in substitutes** (e.g. `StringReplace` for a manual
  search-and-replace) when the outcome is correct.

## 2. Cognitive levels (SAGs 2.6.2)

Practical paper: L1 30% / L2 40% / L3 30%. **L1** recall (declarations, fixed
output, process compliance); **L2** application (a given formula, routine
loop, call as instructed); **L3** problem solving (not fully spelled out,
combining results, unmodelled edge cases). One question may split its marks
across levels.

## 3. Output

- Mark **on a full listing**, with comments showing marks awarded and why.
- **Never offer alternative or corrected code.**
- Comment on incorrect code even where no mark is lost.
- Name (from the filename or code comments), total and percentage at the top.
- Follow the memo; ask for one if none was supplied.
- Explain and motivate every mark.

## 4. Conventions that carry marks

- A `PadStr`-type formatting helper is a separate **private method** of the
  class (2 marks where a rubric has it).
- **Procedures do not produce output; functions return values**, and the
  calling code does the `Writeln`.

## 5. Writing a memo

Break marks into steps (a line or small group per mark), give acceptable
alternatives per step, and structure it for sections 1-3: per-step marks,
carry-forward, style ignored, on a full listing.
