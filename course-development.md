# Course development for other subjects - PLAN

Research and planning for the subjects BestLessons may add after IT. Current
state only.

## Chris's decisions (25 September 2026)

- **Separate repo:** `Projects/itcoder-coursedev`, so the source documents
  (hundreds of MB once every subject is in) stay out of AIResources and the
  platform repo. Its `CLAUDE.md` is the brief for every session there; its
  `kit/` holds snapshot copies of AIResources files for sessions that cannot
  see this folder. **This folder wins** - refresh the kit by copying the
  files again.
- **Subjects, in order:** CAT (the pilot - finish it and settle the output
  format before starting the rest), Mathematics, Mathematical Literacy,
  Physical Sciences, Life Sciences, English Home Language, English First
  Additional Language, Afrikaans First Additional Language, History,
  Geography.
- **Scope:** Grades 10-12, both boards. Per subject: the IEB SAGs, the CAPS
  document with its amendments, and the last three **November** finals with
  their memos (plus inserts, instructions to teachers and data files where a
  paper has them). No May/June or supplementary papers. English versions
  only.
- **Outputs per subject** (`subjects/<subject>/`): `caps.md`, `sags.md`,
  `caps-exam-analysis.md`, `ieb-exam-analysis.md` (modelled on the IT files
  here) and `course-plan.md` - CAPS vs IEB overlap and whether one course
  with board sections will do, how well the subject fits the platform, a
  course outline, platform work, and questions for Chris.
- **Analysis in cloud sessions**, one per subject, two or three at a time,
  each returning its files as a pull request. The repo is on GitHub
  (private `Chrisnoome/itcoder-coursedev`, IEB documents included - Chris
  pushed it himself, 26 September 2026). Start a session from a terminal in
  the repo folder: `claude --cloud "<task>"` (it needs an interactive
  terminal, so Chris runs it).

## Getting the sources

Past papers, memos and data files go in `exams/` to its standard: both
boards, every sitting from 2020 (exams/README.md; Chris, 15 Oct 2026).

- **DBE:** education.gov.za, "Curriculum > CAPS > CAPS: FET" for the CAPS
  documents and the amendments list; "NSC Past Examination papers" links one
  page per sitting, each listing every subject's papers, memos and data
  files. No login.
- **IEB:** docs.ieb.co.za, a member login. **Chris logs in himself** - never
  ask for or type the password. Then High Schools > A to Z Subjects
  (Grades 10-12) > the subject > Subject Assessment Guidelines, Examination
  Papers/<year>, Marking Guidelines/<year>, NSC Data Files/<year>. The page
  is a Telerik file explorer; files fetch from the logged-in page only (a
  plain request gets an empty reply).
- **Chrome downloads:** "Ask where to save each file" is off and
  docs.ieb.co.za may download multiple files (both set 25 September 2026).
- **DBE CAT data files** are password-protected 7-Zip self-extractors
  (`.exe`); each P1 paper prints its password. Extract them with a 7-Zip
  library - don't run the `.exe`.

## Status

- **Eight more subjects, feasibility pass (5 October 2026):** Chris asked
  for Mathematics, Mathematical Literacy, Physical Sciences, Life Sciences,
  History, Geography, Sport and Exercise Science and Visual Arts (theory).
  Both boards' sources are in `itcoder-coursedev/sources/<subject>/`
  (DBE public; IEB through Chris's Chrome login). Each subject has a
  `course-plan.md` only. `subjects/OVERVIEW.md` compares all eight. All
  eight rate "partial", and all depend on the same shared engines: numeric
  answers, AI marking against the boards' rubrics, graphs/diagrams and a
  source panel. Sport and Exercise Science is examined by the IEB only. The
  work is on branch `subjects-research`, which is not pushed. The full
  caps/sags/exam analyses are still to do.
- **CAT outcome:** the cloud session could not push (no remote), but its
  findings were merged into AIResources on 27 September (`cat-*.md`,
  `bundle-design.md`). Its unmerged pilot lesson is in
  `itcoder-coursedev/pilot-cat/` (unreviewed).

- CAT: sources collected 25 September 2026 (17 DBE files, 22 IEB files) in
  `exams/cat/`. Analysis running in cloud session
  `session_015VWnWKuzaNEuhH2epRt1S5` (started 26 September 2026); it
  returns a pull request from branch `cat-analysis`, ending with "Notes on
  the brief" to fix CLAUDE.md before the other nine subjects.
