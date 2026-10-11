# eng10 rework: handover

11 October 2026. This rework follows Chris's review (`AIResources/English/eng10-review-1.md`) and his messages during the session. Everything was read and written through the Dropbox connector. No git was used and no publish or deploy script was run. There is no progress gating: no `sequential` and no `gate` blocks.

## Files created or changed

Every upload's size was checked against the local file. All matched exactly, except english-text.js. Its 15-byte difference comes from the connector turning `\u` escapes into the real characters, so the code works the same.

### Lessons (`AIPascalCourse/content/eng10/`), all rewritten

| File | Bytes | What changed |
|---|---|---|
| `tone-diction-intention.php` | 41163 | **New Text A.** Naledi Mokoena (@naledi.writes), Grade 11, Pietermaritzburg; the made-up apps kept, no real brands. **Boxes and dock.** Text A and Text B in source boxes, with both kept in the text window. **Examples.** Three strong, middling and weak sets (tone, diction, comparison). **Margin.** "In the text" notes explain the red dot, autoplay, the feed and setwork. **New questions:** rv15ToneFive, rv15ToneSeven, m15ToneMatch, rv15Laps, s15Negative, m15AgreeDiffer. **Kept exactly:** the wording of mw15Crime, so saved answers still line up. |
| `rj-act1.php` | 37811 | **Prologue** as a poem box. **Act 1 summary** as scene cards (SceneTimeline) inside the "Learn this" box. **Texts:** the oxymoron speech, sonnet and extracts in boxes. **Examples:** strong, middling and weak Tybalt answers. **New questions:** rv34Lines34, m34Houses, rv34WhyOxymoron, rv34Pilgrim, o34Pqel, dw34Oxymoron. |
| `argumentative-essay.php` | 47861 | **Paragraphs.** PEEL and non-PEEL example paragraphs, with a fix-it task. **Rebuttals.** Three rebuttals: weak, middling, strong. **Essays.** Three essays of about 300 words in an SA pupil's voice: strong "Switch It Off at Nine", middling "Group Chats", weak "Group chats". **Analysis panel** `w42EssayAnalysis`: 6 steps, out of 12, with jevChecks. **Essay length** via ForExam. **New questions:** q42WhichPeel, m42Missing, w42FixParagraph, rv42FixThesis, o42RankEssays, s42Cliches. |
| `unseen-method.php` | 29848 | **'Invictus'** in a numbered poem box, kept beside the questions. **Examples:** strong, middling and weak answers on lines 13-14. **Analysis panel:** w52Paragraph is now built step by step (5 steps); its id, mark (4) and points are unchanged. **Wording:** board-neutral text inside the exam sections. **New questions:** rv52Title, mw52Turn, mw52Un. |
| `prepared-speech.php` | 36489 | **Speech length and marks** via ForExam, so each pupil sees only their exam's: 4-5 minutes or at most 5. **Examples:** three openings, with a notification-badge note. **Script box:** the script paragraph in a source box. **Other edits:** the verifiable 1964 Rivonia line replaces a disputed Mandela quotation, and the food-waste fact was reworded. **New questions:** rv105Purpose, m105Hooks, rv105Hook, rv105Card, q105Ear, mw105Signposts. |

All original question ids are kept.

### Platform (new files)

| File | Bytes |
|---|---|
| `AIPascalCourse/lib/englishtext.php` | 19368 |
| `AIPascalCourse/public/assets/english-text.css` | 20200 |
| `AIPascalCourse/public/assets/english-text.js` | 11654 |
| `AIPascalCourse/public/assets/analysis-panel.js` | 14118 |
| `AIResources/platform-english-helpers.md` | 10469 |

`platform-english-helpers.md` documents every helper. It also holds paste-ready text for `platform.md` and for the header of `lib/content.php`. Those two files (158-233 KB) are too big to rewrite safely through the connector, so **please paste those two sections in by hand.**

### Art (`AIPascalCourse/public/assets/doodles/`)

- **Replaced:**
  - `eng10-open-tone.svg`: the account is renamed @naledi.writes.
  - `eng10-open-argue.svg`, `eng10-argue-layout.svg` and `eng10-open-speech.svg`: the chips no longer name CAPS or IEB, and the middle dot is fixed.
- **New margin jokes:**
  - Ratel: genius, slim, advert, rosaline, mask, trace, captain;
  - Quill: peel, rebuttal, stamp, speedo, dropped;
  - no mascot: thumb.

  Each file is `eng10-joke-<name>.svg`.
- **Generator:** `AIResources/tools/eng10/make_art.py` (54491 bytes) is now plain ASCII. Run `python make_art.py <out> <name ...>` to draw only some drawings. I re-ran it and it reproduces all 17 uploaded SVGs byte for byte.
- **A deleted mistake.** My first upload of `eng10-argue-layout.svg` was 2 bytes off. I deleted it and uploaded it again; the bad copy is in Dropbox's Deleted files and can be ignored.

### Backups

`AIResources/English/eng10-rework-backup/` holds 10 files, each at its original relative path:

- the five lesson files;
- the four replaced SVGs;
- the old `make_art.py`.

## What to test

1. **Text window (TextDock).**
   - Wide screen: open tone-diction-intention, scroll past Text A, and Text A should appear at the right. Further on, Text A and Text B should show as tabs.
   - Check "Keep beside me" and folding.
   - Phone: the window is a bottom panel, folded at first.
   - It should hide again where the lesson calls `TextDock ('')`.
2. **Analysis panel** (argumentative-essay, unseen-method).
   - Do all the steps and refresh the page: the steps should still be there.
   - Click a console line: that step should reopen for editing.
   - Try to paste: it should be refused.
   - Use "Put it in the answer box", then hand in. The typing record should show the text as typed, not pasted. It did in my local test (typed 236, bulk 0).
   - After hand-in, the stored steps should be cleared.
3. **ForExam.** Check prepared-speech and argumentative-essay four ways:
   - a CAPS pupil sees only 4-5 minutes and 300-350 words;
   - an IEB pupil sees only at most 5 minutes and 400-500 words;
   - a teacher sees both, tagged;
   - a pupil with no exam chosen sees both, tagged.
4. **Word counts** under every writing box. The count should turn green inside the target and amber over it.
5. **Exam sections** still show and hide as before. No question ids changed.
6. **Phone layout** for the source boxes, the example-answer columns, the scene cards and the panel (it stacks).
7. **Margin material.** Notes, doodles and "Examiner's eye" should sit in the margin on wide screens and inline on narrow ones.

## Limits and unfinished work

- **Checkers not run.** The `bin/check-*.php` checkers need the full platform and database, which were not available here. What I did run:
  - `php -l` on every PHP file;
  - `node --check` on both scripts;
  - a script check for duplicate ids, odd `markMax` and points that don't add up;
  - a Playwright render of each lesson, with stubbed platform helpers.

  **Please run the checkers before publishing.**
- **Assets load from the body,** not from lesson.php's `<head>` (see `platform-english-helpers.md`). This works, but the word counts only appear in lessons that use one of the new helpers until the files move to the head.
- **Mid-width screens.** With the text window open on screens 1400-1600 px wide, the margin column collapses and margin notes go inline. This is a deliberate trade-off.
- **Saved progress.** Inserting new blocks shifts block positions. If the platform remembers reveal or resume state by block index rather than by id, pupils who already started these sample lessons may see a reveal open in a different place. Three reveals in the old lessons had no id and now have one: the paragraph-5 tone reveal (now rv15ToneFive), the 'Invictus' title reveal (rv52Title) and the cue-card reveal (rv105Card). Question answers are keyed by id and are not affected.
- **index.php summaries need three one-line edits by hand.** I did not rewrite index.php: it holds the lesson keys (database keys), and a 34 KB retype through the connector is not worth the risk. Suggested wording:
  - `tone-diction-intention`: `'summary' => 'A pupil\'s post on a made-up app and an advert that answers it: tone, word choice, purpose and the cross-text question.'`
  - `argumentative-essay`: `'summary' => 'One side, well defended: the thesis, PEEL paragraphs, the rebuttal, three essays taken apart - and one of your own.'` (the current text says "for your board").
  - `prepared-speech`: `'summary' => 'A topic with substance, cue cards and delivery - then record yourself and mark it.'` (the current text says 4-5 minutes, which is wrong for IEB pupils).

## Not built: teachers choosing their class's poems and set works

Chris asked: "with this course, teachers must be able to select which poems, set works etc are included for their classes". This is a platform feature, not a lesson change, and it needs a database change. So I have not built it; here is a proposal to take forward as its own task.

### What already exists

`content/eng10/index.php` tags every literature lesson with `'text'`. The values are:

- `romeo-juliet`
- `midsummer`
- `animal-farm`
- `jekyll-hyde`
- `poems10a`

The header comment already says "Teachers will pick their class's texts; until that setting exists every pupil sees every unit's entries."

### Proposal

1. **Course list of texts.** Add `content/eng10/texts.php`, which returns a list of texts. Each one has:
   - key, title, kind (drama, novel or poems);
   - a group (for example "Shakespeare: choose 1", "Novel: choose 1");
   - for poem sets, the poem lesson keys, so a teacher can tick single poems.
2. **Storage.** Add a table `class_texts (class_id, course, text_key, item_key NULL)`. No rows means everything is included, which keeps the current behaviour.
3. **Teacher setting.** Add a "Texts for this class" panel on the class page: one tick per text, and a tick per poem inside `poems10a`. Show a warning when a group has none chosen, for example "your class has no Shakespeare play".
4. **Filtering.** A lesson is shown to a pupil only if:
   - it has no `'text'` tag, or
   - its text is chosen for one of the pupil's classes, and
   - for a poem lesson, that poem is chosen.

   Put this in `LessonShownTo()` next to the stream check. Teachers see everything, with unchosen texts greyed out.
5. **Knock-on effects.** Course totals, progress, the planner and the "what's next" logic must all use the filtered list.
6. **Grade 11 and 12.** Use the same `'text'` tags so one setting works for every English course.

I have queued this as a separate task suggestion.
