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
  `Appendix`, `MarkSheet`; also `ContentCoverage` (IEB 2014-15), `Addendum`
  and `AnswerBook` (DBE Maths Lit). A second version of a file gets a suffix
  (`Memo_Final`, `MarkSheet_FinalPremarking`). IEB's one March supplementary
  before the May ones (IT 2019) uses `FebMar`.
- Data files: keep the zip/exe as downloaded, and extract it beside it in
  `<Sitting>_<Paper>_DataFiles/` (DBE CAT `.exe` files are password
  7-Zip archives: extract with a 7-Zip library, never run them).

Example: `exams/it/caps/2024/Nov_P1_DataFiles.zip`.

Passwords for the DBE `.exe` archives are printed on the instruction page of
that sitting's P1 paper (CAT: see `cat/SOURCES.md`). Nested archives inside an
extracted IT data folder (`DataENG...exe`) are extracted beside the exe into
`<name>_extracted/`. Moved in from the old `CAPS/past papers`, `IEB/ieb prac
exams`, `IEB/theory papers`, `English/*/Past-papers` and
`itcoder-coursedev/sources/` (cat, maths-lit papers) on 15 Oct 2026.

## Gaps

Kept by whoever fills the library; one line per missing set of files, with
why. State on 15 Oct 2026; scope 2020 to May/June 2026 (paper, memo and, for
practical papers, data files; the IEB extras are not chased). Counted: **285
missing files**. Delete a line when its files are in.

Sittings that do not exist: DBE had no May/June 2020 (Covid) and IEB no May 2020.
Not sure whether they exist, so not listed: DBE Feb/Mar 2020 and 2021
supplementaries, IEB March 2021; check the boards' sites once.

### it (Information Technology)

Paper numbers: DBE P1 = practical, P2 = theory. IEB practical is P2 up to
Nov 2020 and May 2021, P1 from Nov 2021; IEB theory is P1 up to May 2021, P2
after (so a missing IEB "P2" below is the theory paper from 2021).

- it/caps Nov 2021-2025: P1_DataFiles (zip/exe on the DBE page, not yet fetched)
- it/caps MayJun 2021-2025: P1_DataFiles
- it/ieb Nov 2021-2025: P2 and P2_Memo (theory; members' site, login needed)
- it/ieb May 2022, 2023, 2026: P1_DataFiles, P2, P2_Memo (theory)
- it/ieb May 2024, 2025: P2, P2_Memo (theory)

### cat (Computer Applications Technology)

Only Nov 2023-2025 are on disk, so everything else for 2020 to May/June 2026
is missing: P1, P1_Memo, P1_DataFiles, P2, P2_Memo for each sitting.

- cat/caps Nov 2020-2022; MayJun 2021-2026 (DBE data files are password .exe)
- cat/ieb Nov 2020-2022; May 2021-2026 (IEB members' site)
- cat/caps/2023/Nov_P2_Memo.pdf: the file we had was a copy of the P1 memo;
  re-download (in addition to the above).

### english-hl (English Home Language)

Only Nov 2023-2025 are on disk. Missing for each sitting: P1, P1_Memo, P2,
P2_Memo (DBE also P3, P3_Memo).

- english-hl/caps Nov 2020-2022; MayJun 2021-2026
- english-hl/ieb Nov 2020-2022; May 2021-2026

### maths-lit (Mathematical Literacy)

Only Nov 2023-2025 are on disk. Missing for each sitting: P1, P1_Memo, P2,
P2_Memo (plus Addendum / AnswerBook / Insert where the sitting has one).

- maths-lit/caps Nov 2020-2022; MayJun 2021-2026
- maths-lit/ieb Nov 2020-2022; May 2021-2026

### mathematics, physical-sciences, life-sciences, accounting, geography, history (caps)

DBE half filled 15 Oct 2026 from education.gov.za (English only; Afrikaans
skipped). Sittings: Nov 2020-2025 and MayJun 2021-2026 (all on the site).
Kinds: the DBE "Addendum"/"Annexure" is saved as `_Addendum`; Maths P1/P2
memos on the site are bilingual files. Accounting 2020 "Senior Certificate"
(SC) papers were not taken (NSC only).

- all six subjects, FebMar 2020-2026: the DBE site lists no Feb/Mar
  supplementary papers after 2018, so none exist to download.
- physical-sciences/caps/2026/MayJun_P2.pdf: site link for P2 serves the P1
  file (same ticket); re-check later. (P2 memo is in.)
- life-sciences/caps/2024/MayJun_P1.pdf: site link for the paper serves the
  P1 memo; the paper itself is missing (memo is in).
- geography/caps/2026/MayJun_P1_Memo.pdf and MayJun_P2_Memo.pdf: site links
  serve the History 2026 memos; re-check later.
- accounting/caps/docs/ExamGuidelines_2021.pdf: the site's second
  "Accounting (English)" guideline is really Agricultural Sciences; not kept.
- mathematics/caps/2023 and 2024 MayJun_P2_Addendum.pdf: the site calls it
  "Paper 2 Addendum"; it is probably the answer book (not opened).
- Mathematics answer books exist for P2 only; the site has none for P1.
- history/caps/docs: CAPS.pdf is the 2011 CAPS (not on the main CAPS list;
  found by direct link); CAPS_Amended_Draft_Gr10-12.pdf is DBE's draft
  amended History CAPS (call for comment), not final.
- History has no Mind the Gap guide on the DBE site; physical-sciences has
  Physics and Chemistry separately, geography has its 3 map books.
- Exam guidelines: only the 2021 set exists; the DBE says it stays valid for
  2026 and a revision comes for 2027. No DBE national Gr 12 ATP after
  2023/24 (Circular S19 of 2025 keeps them); physical-sciences also has the
  2024 version.
- Diagnostic reports: not split per subject. The content-subject volume of
  each year is in `exams/_dbe/<year>/` (2020 Part1ContentSubjects, 2021
  Part1ContentSubjects, 2022 PART1Nonlanguages, 2023-2025 Book1), which holds
  all six subjects. The other volumes (languages, technology) are there too.
  Nothing for 2026 yet (published after results).
- CAPS_Errata_Gr12.pdf is the one DBE Grade 12 errata file, copied into each
  subject's docs.
