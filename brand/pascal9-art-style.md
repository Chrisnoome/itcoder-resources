# Grade 9 Pascal (Station Kestrel) art style: the pixel station and Bolt

Chris chose these on 9 October 2026, from the board
(https://claude.ai/artifact/Q77KV272kr8nmndnm5Q1Bj, source `brand/pascal9-art-board.html`):
- **C, the pixel station**;
- the mascot **Bolt**;
- **plain terminals** for the "screen they need" pictures.

## The pixel world (SVG, drawn by the chats)

Everything about the station is drawn as 8-bit pixel art: the station, its rooms, the crew,
Earth, the supply ship and Bolt.

- **Drawing:** pixel art drawn as SVG `<rect>`s on a small grid (for example `viewBox="0 0
  130 58"`), with `shape-rendering="crispEdges"`, scaled up. No curves, no gradients, no
  anti-aliasing. Each picture keeps one pixel size.
- **Palette** (16 colours, PICO-8-like; nothing else):
  - space `#1d1832`;
  - black `#000000`;
  - navy `#29366f`;
  - violet `#83769c`;
  - grey `#5f574f` and `#c2c3c7`;
  - white `#fff1e8`;
  - red `#ff004d`;
  - orange `#ffa300`;
  - yellow `#ffec27`;
  - green `#00e436` and `#008751`;
  - blue `#29adff`;
  - pink `#ff77a8`;
  - brown `#ab5236`;
  - peach `#ffccaa`.
- **Type:** **Press Start 2P** for headings, labels and mission titles, used sparingly
  because it is wide. **VT323** for anything longer in a picture.
- **Captions:** keep any text in a picture at least 12 px at 680 wide. Captions sit under the
  picture in the course caption style (`course-pascal9`).
- **The station map** is drawn every lesson. It shows the station's 10 rooms or systems,
  each dark until its mission is done, then lit:
  - Comms (L1)
  - Display (L2)
  - Alarm (L3)
  - Crew quarters (L4)
  - Oxygen (L5)
  - Galley (L6)
  - Engines (L7)
  - Airlock (L8)
  - Life support (L9)
  - Command (L10)

  The dock lights in L11-12. The lesson's own room is outlined in yellow.
- **The crew** are sprites about 12x16 px, each with a suit colour and a recognisable
  detail (the commander's yellow stripe, the medic's red cross). Never caricatures.
- **Nothing scary.** Alarms are red lights and Bolt looking worried, never injuries.

## Bolt

Bolt is the station's floating maintenance drone, drawn as a pixel sprite:
- a round grey-white body;
- **one big eye-light**;
- two little rotors on stubby arms.

The eye-light is the mission status:
- **amber** `#ffa300` while the lesson's system is down;
- **green** `#00e436` once it is fixed;
- **red** `#ff004d` only in lesson 3's red alert.

Bolt appears in the margin doodles (one-line captions, content-voice-and-pedagogy.md §5b),
points at the line that matters in figures, and celebrates when a mission passes. Bolt is
curious, cheerful and gets in the way, but is never the one who solves the problem. The
pupil does.

## Screens: plain terminals

The "screen they need" picture, and any figure that shows program output, is a **plain
terminal**: black, light grey text, the program's real Crt colours, and a monospace font.
It must look like what the Run box shows, so pupils compare like with like.

These screens are drawn from **real fpc runs** of the model answers, never typed by hand.
They use the Pascal course's `TerminalScreen()` from `.ans` captures where Crt is used; plain
text runs go in a pre block. A small pixel frame (a monitor bezel in `#5f574f`) round the
screen is allowed; the inside stays plain.

## Files

- Figures: `AIPascalCourse/public/assets/doodles/kestrel-*.svg`.
- The script that draws them: `AIResources/tools/pascal9/`.
- The course body class `course-pascal9` gets its own caption rule in `design-e.css`.
