# Grade 7 Inside the machine (`machine`) art style: circuit-city map, accurate parts, Volt and Dr Ndlovu

Chris chose these on 10 October 2026, from the board
(https://claude.ai/artifact/ExD8HPhhaNJ3ZiEGvVn4dy, source `brand/machine-art-board.html`):

- **C, the circuit-city map**, with a condition: *"c - but we need more accurate svgs of
  components when they are discussed - as inline images, etc"*;
- **Dr Ndlovu and Volt** as the mascots.

No other course uses this look. Each course's style is its own.

## The city map (lesson openers and doodles)

The motherboard, seen from above, is a city.

**Districts**, each matched to a real part:

| District | Real part |
|---|---|
| City Gates | the back-panel ports |
| CPU Downtown | the CPU, with the Switch Yard inside it |
| RAM Row | the RAM slots |
| The Warehouse | the SSD |
| The Harbour | the network port |
| The Power Station | the power supply |

**How the map is drawn:**
- The roads are copper traces.
- A red "you are here" pin moves to each lesson's district, and finished districts get a tick.
- **Colours:**
  - board green `#0f5132` (dark `#0b3d26`);
  - copper `#c99a1a`;
  - cream labels `#e7efe4`;
  - pin red `#d9542c`.
- **Type:** Oswald, in capitals, for the map labels. Inter Tight for speech.

The lesson doodle captions are in Oswald, in board green.

## Accurate parts (inline in the text)

Every part is drawn **true to its real shape and proportions** whenever the text talks about it.
They are shown with `MachinePart()` (`content/machine/helpers.php`), floated beside the
paragraph.

**How the parts are drawn:**
- Flat and clean, on white.
- Real colours: green PCB `#1f5e3a`, gold contacts `#d4af37`, black chips, steel.
- **No labels on the part itself**, so the same drawing serves the hotspot and label-the-picture
  questions.
- The labelled motherboard is a separate file.

**The parts so far:**
- CPU, top and bottom;
- RAM stick (DIMM);
- M.2 SSD and 2.5 inch SSD;
- hard drive with its lid off;
- power supply;
- motherboard (ATX), in three versions: plain, labelled, and with margins for labels
  (`part-motherboard-quiz`);
- keyboard, mouse, monitor and printer;
- router and RJ45 plug.

## Volt and Dr Ndlovu

- **Volt** is a spark of electricity: yellow `#ffd34d` with a `#c48a00` outline and a simple
  face. Volt is the guide inside the city and speaks in the opener bubbles.
- **Dr Ndlovu** is the science teacher whose shrink ray went wrong. She appears in a round
  radio screen as the voice from outside.

## Drawing

- `AIResources/tools/machine/make_art.py` draws two sets:
  - the city and the doodles, as `doodles/machine-*.svg` (`machine-cycle.svg` belongs to
    another course);
  - the parts, as `lessons/machine/part-*.svg`.
- ComfyUI is used only for the queue items: the course icon, badges and level emblems.
