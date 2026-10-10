# Grade 9 Pascal (Station Kestrel) - video plans for the video chat

Chris, 10 October 2026: "vide requirements to the video queue". The course is `pascal9`
(`AIPascalCourse/content/pascal9/`; plan [pascal9-course.md](pascal9-course.md)).

There are **12 videos, one per mission, about 70 minutes in all.** Each **Goes** line gives
the place in the lesson. Add a `// VIDEO pascal9-NN.n` comment there when you start the video.

## Rules

- **Method and voice:** follow [tutorial-videos.md](tutorial-videos.md).
- **Thumbnails** come from a new `thumbs-pascal9.json`:
  - background `#1d1832`, accent `#ffa300`, second colour `#29366f`;
  - tag `PASCAL · MISSION N`.
- **The look** is [../brand/pascal9-art-style.md](../brand/pascal9-art-style.md):
  - the pixel station, the mission maps (`doodles/kestrel-map-NN.svg`) and Bolt;
  - **plain terminals** for every program screen, never decorated.
- **Every program is typed and run on screen** in the lesson's own code box on
  bestlessons.co.za.
  - Record in the VM, signed in with a test pupil, so the output on screen is the real run.
  - Type at a readable speed.
  - Run after every few lines, and pause on the output.
- **Never show a mission's answer.**
  - The videos build the lesson's code blocks (`c*`), worked examples and their variations,
    never the `m*` mission programs.
  - Video 12 shows the method of the docking program (plan, test cases), not its code.
- **Errors on purpose:** in videos 1, 4 and 8, make a typical mistake, read the compiler's
  message together, and fix it.
- Nothing goes in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| pascal9-01.1 | Wake up, Kestrel: your first program | 6 | `errors` after `c1FixMe` |
| pascal9-02.1 | Make it readable: quotes, spaces and ASCII art | 5 | `art` after `c2Numbers` |
| pascal9-03.1 | Red alert: colours and GotoXY | 6 | `place` after `c3Place` |
| pascal9-04.1 | Who's aboard? Variables and Readln | 7 | `joining` after `c4Readln` |
| pascal9-05.1 | Oxygen maths: types and calculations | 6 | `maths` after `c5Maths` |
| pascal9-06.1 | Rations: DIV, MOD and rounding | 6 | `time` after `c6DivMod` |
| pascal9-07.1 | Fuel: constants and Random | 6 | `random` after `c7Random` |
| pascal9-08.1 | The airlock: IF ... THEN ... ELSE | 6 | `ifelse` after `c8IfElse` |
| pascal9-09.1 | Life support: AND, OR and ELSE IF | 6 | `elseif` after `c9ElseIf` |
| pascal9-10.1 | The console: CASE | 5 | `ranges` after `c10Ranges` |
| pascal9-11.1 | Docking, part 1: plan before you code | 5 | `ipo` after `m11Types` |
| pascal9-12.1 | Docking, part 2: test like an engineer | 6 | `test` after `q12BothBroken` |

## What each video covers

Each video:
1. **Hook:** the station's problem, with the mission map and Bolt.
2. **The idea:** shown on a board, in the pixel style.
3. **Build:** the lesson's example, typed and run step by step.
4. **Recap:** "that's what you need for mission N".
5. **Sign-off.**

What each one must show:
- **01.1:** `program`, `begin`, `end.`, `Writeln`, quotes. Leave out the full stop and read the
  error.
- **02.1:** an empty `Writeln` for spacing, lining up text, a two-line ASCII picture.
- **03.1:** `uses Crt`, `TextColor`, `TextBackground`, `ClrScr`, `GotoXY(x, y)` on a drawn
  grid.
- **04.1:**
  - variables as labelled lockers, then `var`, `:=` and `Readln`;
  - joining text and variables in `Writeln`;
  - a missing semicolon error.
- **05.1:** Integer and Real, the four operators, brackets, `:0:2` for decimals.
- **06.1:** `DIV` and `MOD` with seconds into minutes and seconds; `Round` and `Trunc`.
- **07.1:**
  - `const`, and why a constant beats a typed number;
  - `Randomize` and `Random(n)`, run three times.
- **08.1:**
  - comparisons, then `if ... then ... else` with `begin ... end` blocks;
  - testing below, at and above the boundary;
  - a `;` before `else` error.
- **09.1:** `and` / `or` with brackets, and an `else if` chain whose order matters.
- **10.1:** `case` with single values and ranges, plus an `else`.
- **11.1:** IPO planning (input, process, output) on the board, then the types. No code for
  the mission.
- **12.1:** a test plan of normal, boundary and wrong input, run against the lesson's
  example, not the mission.
