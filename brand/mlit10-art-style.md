# Grade 10 Maths Lit (`mlit10`) art style: sign-painter streets, Hadi the hadeda

Chris chose these on 10 October 2026 from the style board at
https://claude.ai/artifact/3f3FzFohjv3KPcuB759Nxy (source `brand/mlit10-art-board.html`):
- **F2 Sign-painter streets** as the course frame;
- **Hadi** the hadeda, drawn the **riso-passport way** but in F2's colours ("make the hadeda
  look like in passport, don't change colours");
- **theme A** for every one of the 12 batches.

No other course uses this look. Each course's style is its own.

## Two layers

1. **The course frame** is the same all year: lesson openers, the year map, margin doodles,
   the asides' look, the course icon, badges and rank emblems, and Hadi.
2. **The batch theme** changes with each scenario batch. It covers the scene pictures and
   the "brief" art for that batch.

**Documents stay realistic in every theme.** Bills, till slips, statements, plans, maps and
data tables are drawn as plain, real-looking South African documents in the document
panel, because pupils have to read them the way they will in the exam. They are never
copied from exam papers. **Graphs that pupils draw** use the graph engine's own plain grid
and are not themed.

## The frame: hand-painted South African street signage

The look comes from spaza walls, barbershop boards and taxi-rank signs.

- **Ground.** Sign yellow `#f7c948`, with a black `#111` 4 px border and an inner red
  `#e63b2e` pinstripe (sizes are for a 520-wide figure).
- **Ink.** Red `#e63b2e`, blue `#1d4fd8` and black `#111`, with white `#fff` for speech
  bubbles.
- **Lettering.**
  - **Bungee** for titles, in capitals, with a hard black drop shadow offset 3 px.
  - **Permanent Marker** for the one-line "slogan" under a title and for punchlines. The
    board showed Shrikhand, but the lesson page does not load it; the art keeps to fonts
    `lib/design.php` already loads.
  - **Bungee** at small sizes for speech bubbles and stamps.
  - Batch 1's chalkboard writing is **Caveat** (700), roughened with a small displacement
    filter (`filterUnits="userSpaceOnUse"`, or thin horizontal lines vanish).
- **Flourishes.** A wavy pinstripe underline (3 px black) under titles. Drawn
  sign-painter's lines only; no gradients.
- **The year map** is a minibus-taxi route: a thick black road line with 12 painted stops,
  one per batch. Finished stops are red and the rest are white. Stops 4 and 9 sit where the
  terms break. Each lesson opener shows the route with the current stop circled.
- **Rank emblems** (10c to R200) are painted coin and banknote signs with the same lettering
  and outline. They go through ComfyUI in this style, like the course icon and badges.

## Hadi the hadeda

- **Riso treatment.** No black outline, which is the one place the frame's outline rule does
  not apply. Hadi is two flat ink layers, slightly misregistered:
  - the **base layer**: body `#8a7d6e`, wing `#16b37a`, bill and legs `#111`, eye `#111`,
    and a cheek stripe in the ground colour;
  - an **overprint layer** in purple `#7b3fe4`, multiply blend, offset about 2 px right and
    1.5 px up. It carries the wing's iridescent patch and a ghost of the bill.
  - Fine **grain** (fractal noise, about 50% alpha) clipped to Hadi's shape only, never as a
    box over the background.
  - Reference: `#hadi` in the F2 panel of `mlit10-art-board.html`.
- **Character.** Hadi is loud, like every hadeda. Hadi squawks at rounding errors,
  forgotten units and "R" left off an answer, and is proud of every correct calculation.
  The catchphrase is "SQUAWK! Round UP!" (or DOWN, or OFF, whichever the context needs).
- **Jobs.**
  - In the lesson openers, a speech bubble in Bungee.
  - In the margin doodles, a one-line caption (content-voice-and-pedagogy.md §5b).
  - In the gags, Hadi gets things wrong in very real-life ways, such as buying 2,4 packs of
    rolls.

## The 12 batch themes (all option A)

| Batch | Theme | Key look |
|---|---|---|
| 1 Kota Kitchen | Chalkboard menu | Chalk lettering (Cabin Sketch) on a black board in a wood frame, sticky yellow price tags |
| 2 Car Wash Saturday | Roadside signs + bubbles | Painted plank signs on sky blue, soap bubbles with white highlights |
| 3 Radio 10 Survey | Retro radio studio | Wood panel, cream VU meter with a red zone, cassette labels (Special Elite), ON AIR lamp |
| 4 Gogo's Shoebox | Paper collage | Kraft ground, tilted slips, paperclips, red rubber stamps |
| 5 Plan Wars | Game-show versus | Diagonal red/blue split, yellow VS (Bagel Fat One), plan cards with stat bars |
| 6 The Great Bake-Off | Retro recipe cards | Mint ground, ruled index cards (Patrick Hand), dial scales, measuring cups |
| 7 Matchday | Stadium wayfinding | Navy ground, yellow block letters, colour-coded zones, big arrows |
| 8 Games Night | Paper-cut dice and spinner | Layered paper with soft drop shadows on teal |
| 9 The Trip Fund | Travel posters and stamps | Flat sunset bands, mountain silhouettes, outlined passport-style stamps |
| 10 Room Rescue | Blueprint + flat-pack | White line on blueprint blue `#1f4e93`, dimension text in mono; flat-pack line drawings |
| 11 Weather Watch | Weather chart | Pale sky ground, isobar lines, H and L, wind barbs |
| 12 The Road Trip | Scrapbook of postcards | Taped postcards, each in an earlier batch's theme |

The thumbnails on the board are the reference for each theme. Hadi appears in every
batch, always in the riso treatment, whatever the theme.

## Drawing

- **SVG by script:** `AIResources/tools/mlit10/make_art.py`, with output to
  `AIPascalCourse/public/assets/doodles/mlit10-*.svg`.
- **ComfyUI** only for the course icon, badges and the nine rank emblems, in the F2 style.
  None of the chosen batch themes needs realistic photos.
