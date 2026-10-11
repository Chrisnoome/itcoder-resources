# Brief: the full lesson list for one English HL course

This is for the agents writing `English/eng10-lessons.md`, `eng11-lessons.md` and
`eng12-lessons.md`. All three follow the same conventions so they read as one family.

## Read first

- `English/english-courses-plan.md`: decisions, exam formats, strands.
- `English/CAPS/caps-ehl-reference.md`: the CAPS policy, ATP week tables, task lists,
  exam guidelines, rubrics and past-paper patterns.
- `English/IEB/ieb-ehl-reference.md`: the IEB SAGs, prescribed works, papers, memos and
  user group.
- `brand/eng-art-style.md`: the strands (language = L1, writing = W1, literature =
  per-work looks), and the mascots Ratel (language) and Quill (writing).
- For an example of a finished plan's style, look at `courses/mlit10-course.md`.

## Rules (Chris's decisions)

- **One course per grade**, with lessons tagged by stream:
  - `shared`: every pupil;
  - `caps`: CAPS pupils only;
  - `ieb`: IEB pupils only.
- **Grades 10 and 11 copy the Grade 12 exam format and mark distribution** for each
  board. Only the text lengths scale (CAPS ref §1.3/§1.4; IEB ref §1.9):
  - **CAPS:** P1 70 (comprehension 30 / summary 10 / advert 10 / cartoon 10 / editing
    10); P2 80 (poetry 30 including an unseen poem 10, novel 25, drama 25, with one
    essay and one contextual answer); P3 100 (essay 50, transactional 2 × 25); orals.
  - **IEB:** P1 100 (comprehension 25 / summary 10 / seen poetry 15 / unseen poetry 15
    / critical and visual literacy 25 / language 10); P2 100 (Shakespeare essay 30 /
    novel essay 30 / transactional 2 × 20); SBA (extended writing, CAT, film study,
    tests); orals 100.
- **About 100 lessons of about 30 minutes on each pupil's path** (about 3 a week).
  - Text-specific units add entries to the course, but a pupil sees only their own
    texts.
  - Say how many lessons a typical CAPS pupil and a typical IEB pupil actually see.
- **Order:** follow the DBE ATP terms and weeks for that grade (CAPS ref §2). The IEB
  has no terms, so IEB pupils follow the same order.
  - Put each formal assessment's preparation lessons just before its ATP week.
  - Add IEB-only items (film study, the CAT, SBA extended writing, prelim-format
    practice) where they fit the year.
- **Set texts are tagged `text:<slug>`.** A pupil sees a text's unit only if the text
  is selected for them: chosen by the teacher for Gr 10/11, or a per-pupil choice for
  Gr 12. Give each set-text unit the same shape, so the units are interchangeable:
  - an opener and context (period, author, setting);
  - reading guides split by act or section;
  - character, theme and motif lessons;
  - board practice:
    - CAPS: contextual questions + a 400-450-word essay, scaled per grade;
    - IEB: an essay of about 600 words against a critic's quotation (scaled down in
      Gr 10/11);
  - a final unit task.
- **Copyrighted texts:** the pupil uses their own copy, and lessons quote only short
  extracts. Public-domain texts may be shown in full (SA life + 50 years). Flag each
  text's status.
- **Literary essay:** introduced in Gr 10 (IEB SAG). Build it up step by step across
  the year.
- **Orals:** coaching lessons plus practice tasks, mapped to each board's oral tasks
  (CAPS P4; the IEB's 7 oral tasks).
- **Kids' media world:** non-literary texts, scenes and prompts come from teen media:
  group chats, short-video apps, games, memes, streams and made-up apps. No newspapers or
  TV news, no real brands. (The real exams use op-eds and real campaigns. Our practice
  texts are written in the same register but set in teen media. Note this tension
  once.)
- **Every lesson** gets at least one gated guided try-it and margin extras (a Ratel or
  Quill drawing with the joke as its caption, an aside, a factoid). Don't list these
  per lesson; state it once.
- **Marking:** Jev first, using each board's rubrics. The summary word count is checked
  by code.

## Output format

Write `English/eng1X-lessons.md`:

1. **Header.** Grade, year (2027), status "PLAN", and a one-paragraph summary.
2. **Texts.**
   - Gr 12: the prescribed set works for each board and year (2027), plus anything to
     confirm.
   - Gr 10/11: the starter library offered to teachers, by genre, each with its
     copyright status. Teachers pick per class.
3. **Coverage summary.**
   - Lessons per strand: Language / Writing / Literature / Orals / Film (IEB) / Exam
     practice, per stream.
   - Lessons per term.
   - The per-pupil path count for CAPS and IEB.
4. **The lesson list, term by term**, as tables:

   | # | id | Lesson | Strand | Stream | Text | Covers (CAPS / SAGs refs) | Prepares for |
   |---|---|---|---|---|---|---|---|

   - Strand is L, W, Lit, Oral, Film or Exam.
   - The id is a short kebab-case slug.
   - "Prepares for" names the formal task:
     - CAPS: Task n;
     - IEB: SBA section or oral task;
     - the exam paper section.
   - Group set-text units under a sub-heading per text, all with the same shape.
5. **Assessment map:** each formal task for each board, the lessons that prepare for it,
   and the practice task built for it.
6. **Open points:** anything the sources leave unclear.

Be concrete. Give real lesson titles, never "Lesson 34: more poetry". Keep it
scannable. Don't invent requirements the references don't support.
