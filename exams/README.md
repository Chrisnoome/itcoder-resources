# Exam library

Every past exam paper, memo and data file for the subjects we build courses
for, in one tree. Courses, exam analyses and question writing read from here.

## The standard (Chris, 15 Oct 2026)

- **Every subject we build a course for** has, for **CAPS (DBE) and IEB**,
  **every sitting from 2020 to now**: Nov, plus DBE May/June and Feb/Mar
  (supplementary) and IEB May (supplementary), where the board set one.
- Each sitting has **each paper, its memo, and its data files** (practical
  papers). Keep the IEB extras too: analysis grid, teacher instructions,
  inserts, answer sheets, appendices.
- Also, per subject and board: the curriculum (CAPS document and
  amendments; IEB SAGs), DBE examination guidelines, DBE Annual Teaching
  Plans, DBE study guides (Mind the Gap, self-study/revision books) and
  the DBE NSC diagnostic reports from 2020.
- **Grade 12 NSC only, English only** (no Afrikaans versions).
- Older papers already on disk stay (IEB IT goes back to 2009).
- A new subject gets its folder and the full set before its course is built
  (course-development.md, "Getting the sources" says how to download).
- Papers live in Dropbox only: `exams/` is git-ignored except this README.

## Layout

```
exams/<subject>/<board>/<year>/<Sitting>_<Paper>[_Kind].<ext>
```

- subject: `it`, `cat`, `english-hl`, `maths-lit`, `mathematics`,
  `physical-sciences`, `life-sciences`, `accounting`, `geography`,
  `history` (Chris added the last six, 15 Oct 2026)
- Non-exam material sits in `exams/<subject>/<board>/docs/`, named plainly
  (`CAPS.pdf`, `CAPS_Amendment_2024.pdf`, `ExamGuidelines_2021.pdf`,
  `ATP_Gr12_2024.pdf`, `MindTheGap_Gr12.pdf`, `SAGs_2025.pdf`); diagnostic
  reports go in the year folder as `Nov_DiagnosticReport.pdf` (one DBE
  report often covers many subjects: keep only that subject's pages if
  they can be split cleanly, else the whole volume once, in
  `exams/_dbe/<year>/`, and say so here).
- Answer books and addenda are Kinds too: `AnswerBook`, `Addendum`.
- board: `caps` (DBE NSC) or `ieb`
- Sitting: `Nov`, `MayJun` (DBE), `FebMar` (DBE), `May` (IEB supplementary)
- Paper: `P1`, `P2`, `P3` (the board's own numbering: IEB IT practical is
  P2 before 2021 and P1 from 2021; say so in the gap list, don't rename)
- Kind: none for the question paper, then `Memo`, `DataFiles`, `Solutions`,
  `AnalysisGrid`, `TeacherInstructions`, `Insert`, `AnswerSheet`,
  `Appendix`, `MarkSheet`
- Data files: keep the zip/exe as downloaded, and extract it beside it in
  `<Sitting>_<Paper>_DataFiles/` (DBE CAT `.exe` files are password
  7-Zip archives: extract with a 7-Zip library, never run them).

Example: `exams/it/caps/2024/Nov_P1_DataFiles.zip`.

## Gaps

Kept by whoever fills the library; one line per missing file, with why
(not published, login needed, wrong file on the site).

- cat/caps/2023/Nov_P2_Memo.pdf: the file we had was a copy of the P1 memo;
  re-download.
