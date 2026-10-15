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
- Older papers already on disk stay (IEB IT goes back to 2009).
- A new subject gets its folder and the full set before its course is built
  (course-development.md, "Getting the sources" says how to download).
- Papers live in Dropbox only: `exams/` is git-ignored except this README.

## Layout

```
exams/<subject>/<board>/<year>/<Sitting>_<Paper>[_Kind].<ext>
```

- subject: `it`, `cat`, `english-hl`, `maths-lit`
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
