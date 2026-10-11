# English Home Language Gr 10-12 (`eng10`, `eng11`, `eng12`) art style: strand looks, per-work literature, Ratel and Quill

Chris chose these on 11 October 2026 from three boards:
- the strands board https://claude.ai/artifact/SA6BkY6vxjoWyLvu7zaFhQ
  (`brand/eng-strands-art-board.html`);
- the literature board https://claude.ai/artifact/KkpPMA7r88woWhUcRMADUe
  (`brand/eng-literature-art-board.html`).

The scripts that generated the boards are in `brand/eng-board-src/`: `build.py`, the
mascot scripts `gen_folio.py` and `gen_quill.py`, and the mascot defs/poses
`m-*-defs.svg` / `m-*-poses.html`. Start the course's art script from them.

**There is no course-wide frame.** Chris said: "each part or section of the course
should be independent - language similar, writing similar, lit appropriate to the time,
setting, topic and tone of the work / poem". The three courses share this system. A grade
shows only in its accent colour.

## Grade accents

| Grade | Accent | Hex |
|---|---|---|
| Gr 10 | cobalt | `#2747d6` |
| Gr 11 | teal | `#0f8a7e` |
| Gr 12 | violet | `#6b3fd4` |

The accent colours the construction lines, the label chips, Ratel's visor and the
progress strip.

## Language strand: L1 Tracing overlay (the "Studio" family)

**Used for:** comprehension, summary, visual literacy (adverts, campaigns, cartoons),
language in context and editing.

- **Paper.** Studio paper `#f6f4ee` with ink `#16181d`. Example cards are white with a
  faint 16 px grid in the accent at 5% alpha and a `#d7dcf3` border.
- **The tracing sheet.** A sheet of tracing paper is taped over the text, and the
  analysis is drawn on it:
  - construction lines in the accent;
  - words outlined in the accent (1.6 px);
  - numbered leader lines to callouts (white number in an accent circle);
  - **one** signal-red `#ff4b2b` line for the key idea, also used for ticks.
- **Type.** Instrument Serif italic for headings, Instrument Sans for text, JetBrains
  Mono for labels and numbers.
- **Asides** ("Examiner's eye"): mark-earning advice in one or two sentences.
- **Texts in the art** are teen media only: posts, short-video ads, gamer blogs, group
  chats. Every app, brand and account is made up. No newspapers or TV news.

## Writing strand: W1 Drafting table (sibling of L1)

**Used for:** creative essays, transactional writing and process writing (drafts).

- **Same base as L1:** the same paper, grid, type and grade accent. Here the pupil
  builds instead of taking a text apart.
- **Drafts.** Drafts are stacked sheets with version tabs (v1, v2, v3).
- **Structure.** The essay's structure is drawn as a layout with construction lines.
- **Edits.** Edits use red proof-reader's marks: caret, delete, new paragraph.
- **The word count** chip shows each board's limit, e.g. "CAPS 400-450 · IEB 500-600
  (SBA)", plus the draft's current count.
- **Asides** ("Layout rule"): one structural rule.
- In a literature essay lesson, the draft-and-edit cards use W1. The pictures use the
  work's own look.

## Literature: per-work looks (literature board)

- **Shared skeleton, so pupils always recognise a literature lesson:**
  - the title bottom-left on the opener, with an 8-step progress strip top-right;
  - a quotation card with one context question under it;
  - a context-question box with marks in brackets;
  - an essay-topic card with the board's word count (CAPS 400-450 / IEB about 600).
- **Per work:** palette, display typeface, texture, motifs and illustration approach,
  chosen by period, then place, then the central symbols. Tone sets the light.
- **The ten works on the board:** *Hamlet* (white-line woodcut, Kronborg), *Othello*
  (Venetian/Moorish arch, the handkerchief), *The Crucible* (Salem broadside), *Life of
  Pi* (kolam border, the Pacific), *Dorian Gray* (Beardsley line, gilded frame), *Brave
  New World* (pastel Deco hatchery), *The White Tiger* (windscreen, Darkness/Light, the
  rooster coop), *Romeo and Juliet* (Verona fresco), *Frankenstein* (the Romantic
  sublime), *A Thousand Splendid Suns* (Persian miniature, tilework).
- **Poems** get their own small treatment each. The board shows six.
- **Respect rule.** Characters of colour and from other cultures (Othello, Balram,
  Mariam and Laila) and the creature are shown as symbols or distant silhouettes, never
  caricatured faces. *A Thousand Splendid Suns* shows no war imagery.
- **Copyright.** Copyrighted works get placeholder quotation cards, and the pupil quotes
  from their own copy. Before showing a poem in full, confirm its status in SA (life + 50
  years).
- **Polish.** Each work's art is polished when its unit is written. The board's figures
  are a sketch level.
- **Fonts.** A lesson page loads only its own work's display font plus the shared ones.

## Mascots: Ratel and Quill

Both are drawn in layers: base, shadow, highlight, and a cool rim light from the top
left. Each has three poses on the board: greeting, reacting to a mistake, and
celebrating. They are the one constant across every strand, and they carry the margin
jokes as drawings (the joke is the caption; never a "Joke" label).

- **Ratel** (honey badger), **the editor**, for the **language** sections. Blunt and
  fearless, secretly kind. Ratel has a green editor's visor (the grade accent on the
  visor band) and a red pencil.
  - **Nags about:** comma splices, waffle and "very", going over the word limit, unclear
    "it"/"they", "it's".
- **Quill** (secretary bird), **the stickler**, for the **writing** sections. Formal and
  theatrical, with a red bow tie. Its crest is a fan of quill pens: four in Gr 10, five
  in Gr 11, six with a gold nib in Gr 12. Quill stamps on clichés the way real secretary
  birds stamp on snakes.
  - **Nags about:** clichés, a missing salutation or sign-off, register slips,
    one-sentence paragraphs, the wrong format.
- **Literature lessons:** Ratel helps with evidence and quotation, and Quill helps with
  the essay.

## Level names: "Draft to classic" (all three grades)

Blank Page → First Line → Rough Draft → Second Draft → Proofreader → Editor's Pick →
First Edition → Bestseller → Classic.

Set a `RankFamily` for `eng10`, `eng11` and `eng12` in `lib/practice.php`. The rank
emblems are book/manuscript objects in the Studio look (paper, accent lines, one red
mark).

## The course page and lesson list

- Each lesson row shows a small swatch for its strand: Studio paper with an accent line
  for language, version tabs for writing, and the work's own colour for literature.
- The list should read like a varied timetable, not one wallpaper.
- The year map is a drafting-table strip of about 100 lesson ticks in four term
  sections, in the grade accent.
