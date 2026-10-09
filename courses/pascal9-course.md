# Course: Grade 9 Pascal - Station Kestrel (`pascal9`) - PLAN

Chris, 9 October 2026: "need a similar themed interactive pascal course for grd 9 term 2 - whole
of term 2. console only - write code to solve a scenario problem with its own themed art and
scenario. basic input, output, make it pretty, variables, calculations, decisions. less formal
questions, more fun programs needed to solve the problem."

**Written 9 October 2026** - all 12 lessons in `content/pascal9/`. Every program is a file
in `content/pascal9/programs/` (compiled and run by `tools/pascal9/run_programs.py`, layout
checked by `tools/pascal9/style_check.php`); every screen a real server run in
`content/pascal9/screens/` (`tools/pascal9/capture_screens.py`); the pixel art from
`tools/pascal9/make_art.py`. The final is mission `m12Docking` (8 checks, 16 marks) plus the
written debrief `w12Debrief` (markMax 10, banded rubric shown).

He chose the following:
- the **Station Kestrel** storyline;
- **12 lessons**;
- **missions marked by auto-run plus Jev**.

The art style comes from a style board first, as for the other Grade 9 courses.

- **Course:** General Computing, Grade 9, term 2. Two lessons per 7-day cycle, about 40
  minutes each. Term 2 holds about 14-15 lessons; 12 leave room for exams and catch-up.
- **Status:** `open` from the start (no draft, platform.md).
- **Content:** `AIPascalCourse/content/pascal9/`.
- **Code:** written to [../pascal-house-style.md](../pascal-house-style.md), so pupils who
  move on to the Grade 10 Pascal course already write the same way.
- **Voice:** [../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md), pitched at
  Grade 9: shorter paragraphs, more pictures, and every new idea used in a program within
  minutes.

## The story

**Station Kestrel** is a small research station in orbit. A solar storm has wiped its
computers. The six crew are safe in the shelter module, but every system has to be brought
back by new programs, sent up from the ground.

The pupil is a trainee at the **ground station at Hartebeesthoek**. Hartebeesthoek is real:
SANSA's space operations site near Johannesburg, which does track spacecraft. That makes the
pupil the only coder the crew can reach.

Each lesson is a **mission**: a message from the station, the screen the crew needs, and a
program the pupil writes to bring one system back online. Every lesson ends with a system
lit green on the station map.

In the final mission the pupil writes the docking computer, so the supply ship can dock.
Nobody is in real danger on screen: the crew's worst day is cold coffee and a long wait.

**The crew** (names and jobs to be confirmed; mixed South African and international):
- Commander Naledi Mokoena ("Naledi" means star);
- engineer Pieter van Wyk;
- medic Aisha Patel;
- botanist Sipho Dube;
- pilot Lena Fischer;
- scientist Kenji Mori.

**The mascot** is the station's small maintenance robot, chosen on the style board. It is
in the margin doodles, it is in the figures pointing at the line that matters, and its one
light shows the mission's status.

## How a lesson works (less formal, more programs)

1. **Incoming transmission.** A short message from the crew, with the station picture and
   the problem in one paragraph.
2. **The screen they need.** A drawn terminal showing exactly what the finished program
   prints. Pupils are told to "first know what output you want" (the Pascal course's
   thesis).
3. **Learn it.** Short explanation, then try-its: a `code` box with a working example to
   run and change.
4. **Quick checks.** At most 3-4 per lesson, all quick and visual:
   - predict the output;
   - a Parsons-style `order` (put the lines in order);
   - a `select`;
   - a spot-the-bug `markwords`.
   Few typed or written definitions.
5. **The mission program** (new `mission` block, below). The pupil writes it, runs it, and
   the station checks it.
6. **Bonus systems.** 1-2 optional extra programs for fast finishers, plus a stretch goal
   on the mission ("add colour", "warn when...").
7. **System online.** A system lights up on the station map, and the next transmission is
   teased.

## The mission block (new, platform work) - built like the HTML block

`lib/mission.php` + `api/mission-answer.php`, modelled on the HTML block (`lib/html.php`):
checks with their own marks, decided by rules or by Jev, **two tries** (Check uses one;
the same program twice is refused), each check's marks doubled when met first time. **Run
is unlimited** and works as every code box does (the mission is also a code box: Run, the
input box, the virtual terminal, style check).

```php
[
    'type'       => 'mission',
    'id'         => 'm5Oxygen',
    'title'      => 'Mission: the oxygen counter',
    'prompt'     => '<p>...the brief...</p>',
    'takesInput' => true,
    'starter'    => "Program OxygenCounter;
...",
    'model'      => "Program OxygenCounter;
...",    // full marks; shown when finished; checked by bin/check-missions.php
    'hint'       => '...',
    'checks'     => [
        ['say' => 'Six crew, 1200 litres: 50 hours', 'input' => "6
1200
", 'expect' => ['50', 'hours']],
        ['say' => 'Two crew: 150 hours',             'input' => "2
1200
", 'expect' => ['150'], 'hint' => '...'],
        ['say' => 'Locked when the pressure is low', 'input' => "80
",       'expect' => ['LOCKED'], 'absent' => ['OPEN']],
        ['say' => 'Uses a constant for the rate',    'source' => ['Const']],
        ['say' => 'A neat, readable screen',         'input' => "6
1200
", 'jev' => 'Is `pupil_output` laid out neatly ...?'],
    ],
    'explain'    => '...',
],
```

- **A test check** runs the program with `input` as stdin (the same compile and sandbox as
  Run) and passes when every `expect` is in the output and no `absent` is. Matching ignores
  case, spacing and line breaks (the layout is the pupil's own); a purely numeric expect
  matches a number of that value (`50` = `50.0` = `50.00`, never `150`). `'exact' => "..."`
  compares the whole output line by line (trailing spaces ignored) - lesson 1 only.
- **A source check** looks for words in the code (comments and strings left out).
- **A Jev check** asks Jev a yes/no question about `pupil_code` and the run's `pupil_output`;
  Claude where Jev is unsure (as the HTML block). Costed.
- Each check is one mark (doubled first time). After a first try the pupil sees each test's
  label, the input sent and their own output, with a tick or cross - never the expected
  strings beyond what the brief says.
- One compile per check run (no sandbox change); a server-wide limit on mission checks at
  the same moment, and a busy station says "try again in a moment" without using a try.

## Lessons

Each lesson has a brief, a mission (with tests), 3-4 quick checks and bonus systems. The
planned mission programs are listed; numbers and names are to be fixed when written.

| # | id | Title | Pascal | Mission program |
|---|---|---|---|---|
| 1 | `wakeup` | Wake up the terminal | What a program is; `Program`, `Begin`, `End.`; `Writeln`; text in quotes; the computer is stupid (exact spelling); the first compiler error | **Boot message:** "KESTREL SYSTEMS ONLINE" plus the date and the crew count. Tests are exact. |
| 2 | `readable` | Make it readable | `Write` versus `Writeln`; blank lines; `''` in text; commas joining text and numbers; layout; ASCII art | **The mission patch:** an ASCII Kestrel badge plus a status board with neat columns. |
| 3 | `redalert` | Red alert: make it pretty | `Uses Crt`; `ClrScr`; `TextColor` and `TextBackground`; `GotoXY`; `Delay`; colour with meaning (red alert, green OK) | **The alert screen:** a red banner, a boxed message in the middle, a green "CREW SAFE" line. Jev marks the look. |
| 4 | `aboard` | Who's still aboard? | Variables as labelled lockers; `Var`; `String`; `Readln`; prompts with `Write`; joining text | **Crew check-in:** asks a name and a job, then greets them on a coloured welcome card. |
| 5 | `oxygen` | The oxygen counter | `Integer` and `Real`; `:=`; `+ - * /`; brackets; `:0:1` output; always give a variable a starting value | **Oxygen left:** tank litres and crew, then the hours of air and the days. |
| 6 | `rations` | Rations for six | `Div` and `Mod`; `Round` and `Trunc`; minutes to hours:minutes | **Ration splitter:** packs per crew member, packs left over, and the countdown to the supply ship as h:mm. |
| 7 | `fuel` | Fuel and distance | `Const`; formulas from words; `Random` and `Randomize` (a meteor reading) | **Burn calculator:** distance and speed in, burn time and fuel needed out. The fuel rate is a constant. |
| 8 | `airlock` | Airlock: open or not? | `Boolean` comparisons; `If ... Then ... Else`; `Begin`/`End` blocks; testing both sides | **Airlock control:** pressure and suit check in, OPEN (green) or LOCKED (red) out, with the reason. |
| 9 | `lifesupport` | Life-support check | `And`, `Or`, `Not`; brackets round each comparison; `Else If` for ranges | **Status lights:** temperature and CO2 in, a GREEN, AMBER or RED status for each, then an overall alarm. |
| 10 | `console` | The station console | `Case` with numbers, ranges and characters; choosing `If` or `Case` | **Command console:** one menu, one choice (no loops yet), each option a small calculation or report from earlier missions. |
| 11 | `docking1` | Final mission: the docking computer, part 1 | Planning: the screen first, then input, processing, output; test data | **Docking computer:** distance, closing speed, angle and fuel in. Time to dock, fuel needed and the decision (DOCK / SLOW DOWN / ABORT) out, on a Crt screen. Has tests. |
| 12 | `docking2` | Final mission, part 2, and the debrief | Testing with normal, edge and wrong data; finishing and polishing | Finish the docking computer, then answer a short debrief written with a rubric. The final is `w12FinalMission`, markMax 30 = tests + Jev's screen and code marks + the debrief. The epilogue: the ship docks and the station map is all green. |

Loops are not in the course: Grade 10 starts them. Lesson 10's console runs one choice per
run, on purpose. The last line of the course looks ahead to "in Grade 10 you make it repeat".

## Art (chosen 9 October 2026: C pixel station, Bolt, plain terminals - brand/pascal9-art-style.md)

The style board is `brand/pascal9-art-board.html`. Candidates:
1. retro NASA blueprints with amber CRT screens;
2. a 1970s space-age poster;
3. pixel-art space;
4. a crew notebook.

There are also mascot candidates (robots) and the terminal look for the "screen they
need" pictures. Whatever is chosen, figures that show program output are drawn from **real
fpc runs** of the model answers, never typed by hand.

## Order of work

1. Choose the style board, then write `brand/pascal9-art-style.md`.
2. Build the mission block and checker, with tests.
3. Write lessons 1-12 with model answers.
4. Run every model answer and test through fpc, so every mission's model passes all its
   tests and the starter fails at least one.
5. Run the checks and Jev.
6. Add the course entry: `'pascal9'`, gc, Grade 9, open; the home icon; fonts; caption
   CSS.
7. Publish: test site, then live (Chris says when).
8. Write the video plans.
