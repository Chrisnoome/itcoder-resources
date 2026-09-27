# Pilot - NOT for merging

**Do not copy anything in this folder into `content/` or
`public/assets/`.** It is one CAT lesson written as a sample, for Chris to
read and decide about. `MERGE.md` in the folder above deliberately leaves it
out of its merge table.

## What is here

| File | What it is |
|---|---|
| `computer.php` | CAT Grade 10, Lesson 1 - "What a computer is, and the IPO model". Modelled on `content/theory10/datainfo.php`, read on 27 September 2026. |
| `doodles/gigo-salt.svg` | The one doodle `computer.php` uses. |
| `doodles/caps-shouting.svg` | For a later lesson - netiquette, "typing in capitals is shouting". |
| `doodles/phishing-hook.svg` | For a later lesson - phishing. |
| `doodles/folder-maze.svg` | For a later lesson - file management. |

Every SVG was rendered in headless Chromium and looked at before it was
kept. A fifth drawing (an input-processing-output sandwich) was attempted
three times, never read as a sandwich, and was thrown away rather than
shipped.

## What has been checked

- `php -l computer.php` - **passes**.
- **Marks: 22 for a CAPS pupil, 26 for an IEB pupil.** Both even (decision
  8). The first draft came to 21 and 25 - odd, and wrong - which is why the
  totals are now counted by script rather than by hand.
- No written part is worth more than 4, and every 2-mark part asks for TWO
  things, matching what both boards' papers actually do.
- No escaped apostrophes left inside a nowdoc. The first draft had three
  (`pupil\'s`), which would have rendered the backslash on the page.
- Every drawing rendered and inspected.

## What has NOT been checked, and needs a local eye

1. **`BoardSection()` - the signature is a guess.** It is written as
   `...BoardSection ('ieb', 'Title', [blocks], 'note')`, taken from the 25
   September snapshot of `platform.md` in the course-development kit. **No
   real lesson file using it was available to copy from.** Check it against
   `lib/content.php` before anything else - it is the one construct here
   that was not copied from a working example.
2. **The platform's own checkers have not run** - `check-figures.php`,
   `check-popup-spacing.php` and the rest. This container has PHP but not
   the platform, so only `php -l` was possible.
3. **The margin is under-filled.** One `Doodle()` and two `MarginNote()`s.
   The rule is at least three items in a full lesson and **mostly
   drawings**, so it wants two or three more doodles.
4. **The quote is not from the quote bank.** Donald Knuth, no portrait;
   `word documents/_ALL_QUOTES.docx` was not read. Replace it with one from
   there, or add a portrait and a credit.
5. **One fact to verify** - the margin note about NASA losing a spacecraft
   in 1999. It was the Mars Climate Orbiter, and the mismatch was
   pound-force-seconds against newton-seconds; the note says "pounds" and
   "newtons", which is true in substance and loose in wording.
6. **No `video` block**, because a YouTube id is never invented. If a good
   video exists for the IPO model, it goes in from
   `word documents/_ALL_VIDEOS.csv`.
7. **The glossary.** `Gloss()` is used for *a computer*, *GIGO* and *an
   algorithm*; the `study` block's `keyTerms` list nine. Whether any of
   those need rows in a shared CAT glossary has not been worked out.

## Things worth knowing that came out of writing it

- **A `Figure()` diagram must be inline SVG.** An external `.svg` loaded
  through `<img src>` is an isolated document, so `var(--ink)` never reaches
  it and every stroke resolves to nothing - the figure renders as an empty
  box with no error anywhere. Doodles survive the same treatment only
  because `currentColor` falls back to black.
- The IEB-only algorithms section is **taught to everyone and marked only
  for the IEB**, per Chris's decision 16. A CAPS pupil reads it; the four
  marks are not in their total.
