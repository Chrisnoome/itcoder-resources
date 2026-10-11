# eng10 sample lessons - Chris's review 1 (11 October 2026)

## First: Chris's style guide

Chris asked for this to be read before any lesson is touched. Read these in full, not
skimmed; they are the rules every lesson is checked against.

1. `/Projects/AIResources/writing-style.md`: the base rules for every word a pupil reads.
   - South African English and spelling.
   - Short sentences.
   - **Bullets for anything that can be listed** ("Chris lists far more than most").
   - Concrete analogies.
   - Warning and Note callouts.
   - A quote at the top of each lesson.
   - The banned words and the "tells" list.
2. `/Projects/AIResources/content-voice-and-pedagogy.md`: the voice (§1), popups (§2),
   "do this, observe, explain" (§3), question types (§4), Jev first (§4b), try-its
   (§5), boxed and captioned illustrations (§5a), **the margin (§5b)**, quotes with
   portraits (§6), one contents block (§7), and **the lesson checklist (§8)**.
   - Run every lesson through the §8 checklist before you finish.
3. Chris's own notes are the calibration that writing-style.md was built from:
   `/Projects/AIResources/word documents/` (the `hw_*.docx` files). Match their plain,
   list-heavy, direct style, not an essay's.

Where this review and the style guide disagree, this review wins: it is newer.

Chris read the five live sample lessons and sent this feedback. All of it applies to
every English lesson from now on, not just these five.

## Voice

- **"Way too many AI tells."** Examples Chris flagged:
  - "a post on Spill" (a made-up app name used as a label);
  - "here's what [the panic] gets wrong";
  - "trap".
  - Also cut: writerly set-ups, "here's what / here's why", "the trap", "the catch",
    colon reveals, three-beat lists, and cute asides. See `writing-style.md`, "What to
    avoid".
- **Text A "is not a South African pupil at all."** Written texts set in teen media
  must sound like a real South African teenager:
  - SA places, school life, family, money and weather (taxis, load-shedding, the
    school group chat, a braai, a spaza, exams in June);
  - SA English idiom used naturally, and an SA name and setting;
  - no American framing;
  - still no real brands.

## Layout

- **Bullets where they belong.** A list written as a sentence must become a bullet
  list. Chris's example: "...the three tools every comprehension paper asks for: tone,
  diction and the writer's intention." That should be three bullets.
- **Quoted text goes in its own box.** Every text that is not the lesson's own words
  must be set apart, in a box with a different font and formatting: Text A and B,
  poems, play extracts, the Prologue, and quotations inside a summary. Use the
  platform's quote styling (`.quote` / `.quote-card` in style.css). If it doesn't fit a
  long text or a poem, add a proper "source text" box.
- **Summaries should be more visual.** The scene-by-scene summary of Act 1 (in
  `rj-act1`) is a wall of paragraphs. Make it visually interesting, e.g. scene cards, a
  timeline, or a "Learn this" box, with the quotations in quote styling.

## More margin material

**"Not enough sidebar!"** Every lesson needs far more margin material: MarginNote
asides, factoids, Doodles with Ratel or Quill jokes, and "Examiner's eye" notes, spread
through the whole lesson, not only at the start.

## More interactivity

**"Lessons need more interactivity - that's your advantage. Use it."**
- More try-this exercises in **every** lesson. Guide the pupil and show how, step by
  step, before asking them to do it alone.

**`argumentative-essay` (site lesson 31):**
- Example paragraphs that **follow PEEL** and example paragraphs that **don't**.
- **Example argumentative essays on the same topic: good, average and bad.**
- Ask the pupil to explain the difference. Guide the explanation with **stepped
  questions that build an analysis in a console-like window at the side**. Each answer
  adds to the analysis being built, and the pupil ends with a full explanation they
  wrote step by step.

## Per lesson

| Lesson | File | What to change |
|---|---|---|
| 11 (list 15) | `tone-diction-intention` | Voice of Text A (an SA pupil); bullets; quote boxes; more margin material |
| 23 (list 34) | `rj-act1` | The Prologue and every quotation in quote boxes; the scene summary made visual; more margin material |
| 31 (list 42) | `argumentative-essay` | PEEL good and bad paragraphs; three essays (good, average, bad); the guided analysis side window |
| 38 (list 52) | `unseen-method` | Voice, bullets, quote box for the poem, more margin material and try-its |
| 68 (list 105) | `prepared-speech` | Voice, bullets, more margin material and try-its |
