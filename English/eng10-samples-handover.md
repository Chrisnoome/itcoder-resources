# eng10 sample lessons - hand-over

11 October 2026. Five sample lessons for English Home Language Grade 10 (course `eng10`), wired in as an **open** course so the English department can test it. Everything was read and written through Dropbox. No git was used, and no publish or deploy script was run. Publishing is yours.

## What is in Dropbox now

### New: course content (`/Projects/AIPascalCourse/content/eng10/`)

| File | What it is |
|---|---|
| `tone-diction-intention.php` | Lesson 15, comprehension. Text A is a post by @kaya.makes on the made-up app Spill (535 words, 8 numbered paragraphs). Text B is an advert for the made-up app Hush. Includes a cross-text question. |
| `unseen-method.php` | Lesson 52, poetry. The TRACE method on Henley's 'Invictus' (public domain). |
| `rj-act1.php` | Lesson 34, Romeo and Juliet. The Prologue in full plus Act 1 scene by scene, and an 8-mark literary paragraph. CAPS and IEB contextual questions. |
| `argumentative-essay.php` | Lesson 42, writing. Thesis, PEEL and rebuttal. CAPS essay out of 50 (30/15/5) and IEB extended writing out of 30. |
| `prepared-speech.php` | Lesson 105, oral. Topic, word count, cue cards, delivery, and a 10-mark script task. Self-assessment: CAPS 10 marks, IEB 20 marks. |
| `index.php` | All 153 lessons from `eng10-lessons.md`: 27 CAPS-only and 30 IEB-only, by `'stream'` and `'badge'`. Only the five above have files; the rest show as coming soon. |
| `caps.php`, `sags.php` | Curriculum and assessment maps. sags topics are p1, p2, sba and oral. |
| `glossary.php` | 24 terms, each anchored to one of the five lessons. |

Every lesson has:
- a guided try-it;
- a Doodle with a Ratel or Quill joke;
- a MarginNote aside and a factoid;
- CAPS and IEB `BoardSection`s;
- a `study` block at the end.

All texts are teen media. There are no newspapers, no TV news and no real brands.

### New: art (`/Projects/AIPascalCourse/public/assets/doodles/`)

16 SVGs:
- **Openers:** `eng10-open-{tone,unseen,rj,argue,speech}`
- **Figures:** `eng10-trace-tone`, `eng10-hush-ad`, `eng10-trace-steps`, `eng10-rj-houses`, `eng10-argue-layout`, `eng10-cue-cards`
- **Margin jokes:** `eng10-joke-{tone,unseen,rj,argue,speech}`

The script that makes them is `/Projects/AIResources/tools/eng10/make_art.py`. Run `python make_art.py` from that folder. It reads the mascots from `brand/eng-board-src` and writes into the doodles folder.

### Changed: site code (`/Projects/AIPascalCourse/lib/`)

- **`course.php`:**
  - New subject `'english'` ("English") in `SubjectIndex()`.
  - New course `'eng10'` in `CourseIndex()`:
    - title "English Home Language - Grade 10", grades "Grade 10";
    - `status => 'open'`;
    - **no `'sequential'`**.
- **`home.php`:**
  - An `eng10` course look: an open book in cobalt `#2747d6`.
  - An `english` subject icon: a speech bubble.
- **`practice.php`:**
  - `RankFamily()` sends eng10, eng11 and eng12 to the new family `'eng'`. Its ranks are Blank Page, First Line, Rough Draft, Second Draft, Proofreader, Editor's Pick, First Edition, Bestseller and Classic.
  - `PracticeHeroGlyphs()` has an `eng10` set.

All three pass `php -l`. Each new file was uploaded and its size checked. `practice.php` was also read back and compared byte for byte with the local copy.

### Backups of the three originals

`/Projects/AIResources/English/eng10-samples-backup/lib/`
- `course.php` (29894 bytes)
- `home.php` (25700 bytes)
- `practice.php` (63148 bytes)

To undo, move these three back over the new ones. The empty folder `/Projects/AIResources/English/eng10-samples-staging/` is left over from the upload and can be deleted.

## What to test

1. **Course list.** English shows as a subject. "English Home Language - Grade 10" is open and joinable, never draft. Its card has the cobalt book icon.
2. **The five lessons** open from the contents, and none of them is locked. Lessons are not progress gated, on Chris's instruction ("lessons are not progress gated", then "No gating at all"). There is no `'sequential'` on the course and no `'gate'` on any block.
3. **Board sections.** Switch a test pupil between CAPS and IEB, and check that each sees only its own section.
4. **Stream-only entries.** In the contents, CAPS-only lessons are hidden from an IEB pupil and the reverse. Unwritten lessons show as coming soon.
5. **Marking.** Answer the written tasks and check the rubric and band tables display:
   - essay: 50 marks for CAPS, 30 for IEB;
   - speech: script 10, self-assessment 10 (CAPS) and 20 (IEB);
   - comprehension and R&J extract questions.
6. **Glossary.** Terms such as sonnet, oxymoron and dramatic irony pop up in the lessons, and each glossary entry links back to its lesson.
7. **Practice.** The eng10 lobby shows the English glyphs and the Blank Page to Classic ranks.
8. **Art.** Openers, figures and jokes load, and the mascots show: Ratel with the cobalt visor, Quill with four quills.

## Changes from the brief, or choices to confirm

- **No gating at all**, per Chris mid-task. This replaces the brief's `'sequential' => true`.
- **Romeo and Juliet lesson:** I wrote the Act 1 reading guide (`rj-act1`, lesson 34) rather than the short opener. It has the full Prologue, Act 1 scene by scene, contextual questions and the literary paragraph.
- **Numbering:** every index entry uses its list number (1-153), including stream-only lessons, instead of the usual "101+ for stream lessons".
- **Marks the course proposes, to check:**
  - IEB extended-writing split of 6 / 16 / 8 out of 30;
  - the speech self-assessment checklists (CAPS 3/2/3/2 = 10, IEB 6/4/6/4 = 20);
  - the speech script task's 4 / 3 / 3 bands.
- **Essays have no Jev points.** They are marked on the rubric bands only, since an essay has no fixed points.
- **The critical view** in the R&J IEB question is labelled as the course's own reading, not a quoted critic.

## Not done yet

- `bin/check-jev.php` was not run, and nor were the full repository checkers. Only the five lessons were checked: my structural checks plus the real check-sags, check-lesson-contents, check-titles and check-figures logic in a harness. Run the full checkers before publishing.
- There is no rank emblem art at `/assets/rank-art/eng/`, so the drawn emblems stand in.
- There is no setting for which set works a class studies, and no audio upload for the speech. The speech is a script plus self-assessment.
- `CourseMarkStyle()` still gives eng10 the `'generic'` marking voice. An English voice would mark better.
- 148 of the 153 lessons are still to write.
