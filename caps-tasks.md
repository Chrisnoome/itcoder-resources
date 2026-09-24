# CAPS (DBE) school-based tasks - research for the lessons after 26 and 27

Researched 25 September 2026 for Chris ("what tasks are there for CAPS? they
will need to be the lessons that come after the IEB data validation task and
the IEB PAT"). Sources: [caps-2024.md](caps-2024.md) §4 (the 2024 CAPS
amendment) and the DBE's *Information Technology Guidelines for Practical
Assessment Task, Grade 12, 2026* (education.gov.za, 34 pages - saved text in
this conversation's notes; re-download from
`education.gov.za/Portals/0/CD/2026 PATs/Information Technology/`).

## What CAPS asks for

| Task | Grades | Weight | What it is |
|---|---|---|---|
| **PAT** | 10, 11, 12 | 20% (Gr 10-11), **25% (Gr 12)** of the promotion mark | A software project. Gr 12's is set by the DBE every year (a theme, two phases, a DBE rubric), externally moderated by Umalusi. Gr 10-11 PATs are set by the school or province. |
| **Alternative task** | 10, 11, 12 (one per year) | part of SBA | Closed or open book, OR a case study, OR an integrated task (theory and practical together - e.g. an algorithm and its code, a trace table to debug). No fixed rubric. |
| Tests, exams | all | SBA | Not tasks - covered by lessons 24/25. |

**There is no data validation task in CAPS** - it is IEB-only. Validation
is inside the CAPS PAT (Phase 1 Task 5 and the Phase 2 input marks).

## The DBE Grade 12 PAT (2026)

- **Theme 2026:** Information technology in the fashion industry (events,
  supply chain, design, history, careers, sustainability, entrepreneurship).
  The theme changes every year; the structure has not.
- **Language:** Delphi. **At most 10%** of the work from other sources (IEB: 20%).
- **Must include:** a database of at least **two linked tables**
  (referential integrity, ~5 fields, 10+ records each) used through
  **Delphi code AND SQL** (sort, search, insert, delete, edit); a **text
  file** read, written or appended; **at least one class**, instantiated
  and used in a form; **another data structure** (array, array of objects)
  or an advanced concept (inheritance, polymorphism, overloading); a GUI of
  **at least three forms** with navigation, following HCI principles.
- **Phase 1 - Analysis and design (48 marks)**, due a week before the
  mid-year exams. One document: Task 1A scenario and scope (~200 words);
  1B user requirements (table or use case diagram: role, activities,
  limitations of each user); 2 database design (tables, relationships,
  fields, types, sizes, normalised); 3A class description and class
  diagram; 3B where a text file is used; 3C the array or advanced concept;
  4A navigation / flow diagram; 4B GUI design by HCI principles (annotated
  prototype screenshots allowed); 5 IPO design for at least two interfaces
  (input source, type, format, component, validation of at least four
  inputs incl. empty field and nothing selected, error messages;
  processing with algorithms; output).
- **Phase 2 - Coding and testing (86 marks)**, due the last week of Term 3.
  The Delphi project, database, text files, user and developer project
  notes (help, tooltips, comments), testing with typical, erroneous and
  boundary data. Marked on data structures, input, processing, output,
  modularity, database manipulation, documentation, GUI.
- **Final product and impression (16 marks):** meets the Phase 1
  requirements, design and ease of use, explaining the code, attitude and
  keeping to due dates.
- **Total 150**, converted to 100. **Interview/demonstration**, about 15
  minutes: the pupil runs everything, the teacher picks code to explain -
  **code the pupil cannot explain earns nothing** on every related rubric
  line.
- Declarations: help received (Annexure B) and authenticity (Annexure C).

## The Grade 10 and 11 PATs (2025 guidelines, seen 25 September 2026)

Same shape as Grade 12 - 150 marks, phases, an interview - scaled down:

- **Grade 10:** Phase 1 (tasks 1-5, 64): task definition and user story,
  acceptance test, navigation between screens, GUI design, IPO table with
  data validation. Phase 2 (tasks 6-9, 70): two Delphi screens, HCI
  principles, code (20), testing and validation, documentation. Phase 3
  (task 10, 16): documentation and interview. Moderated at PLC, district
  and province level.
- **Grade 11:** a DBE-style theme (2025: a "Personal Smart School
  Assistant"); Phase 1 analysis and design 48, Phase 2 coding and testing
  86, final product and impression 16. A database built from the Phase 1
  plan and used through code (CAPS Gr 11 Term 3: one table, multi-form GUI).

So the structure is stable across grades and years; the theme, the exact
task list and the rubric change every year (and Gr 10-11 can differ by
province).

## Lesson plan for the CAPS projects (drafted 25 September 2026 - Chris to decide)

One set of lessons for all three grades, with a grade-by-grade table where
they differ - the phases and the skills are the same, only the size grows.

1. **28 - The CAPS PAT: how it works.** Phases and marks per grade, due
   dates, the interview (code you cannot explain earns nothing), the 10%
   limit and the two declarations, what stays the same each year and what
   the theme changes, choosing a topic inside the theme.
2. **29 - Phase 1: analysis and design.** Scenario and scope; user
   requirements (table or use case diagram); user stories and acceptance
   tests (Gr 10); the database design (tables, keys, relationships,
   normalised); the class diagram; where the text file and the array fit;
   the navigation diagram; the GUI design by HCI principles; IPO tables with
   validation and error messages. Pre-check of the Phase 1 document (PDF).
3. **30 - Phase 2: building and testing.** Building to the Phase 1 plan:
   at least three forms (two in Gr 10), the class, the text file, the array,
   defensive programming, project notes (help, tooltips, comments), testing
   with typical, erroneous and boundary data. The database through code and
   SQL is taught in the SQL course; this lesson shows where it plugs in.
   Pre-check of the code (source files).
4. **31 - The demonstration and the final product.** The 15-minute demo and
   questions, the 16 marks for the final product and impression, a
   checklist for the last week.
5. **Optional 32 - The alternative task** (case study, integrated task,
   open book) - how they are set and answered; no pre-check (no national
   rubric).

**Needs from Chris:** all grades or Grade 12 only; whether database
programming through code (ADO components, data-aware grids) is taught in
the SQL course or needs a lesson here; pre-check for Grade 12 only (the one
national rubric, retyped each January) or also Gr 10-11; the alternative
task lesson or not; examples on the current theme (fashion, 2026) or
theme-free.
