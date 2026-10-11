# Grade 7 Bolt's maze (`botmaze`) - algorithms and robotics

Chris chose this course from the Grade 7/8 plan ([grade7-8-courses.md](grade7-8-courses.md)) on
11 October 2026. It fits CAPS Coding and Robotics and leads into Grade 9 Pascal
([pascal9-course.md](pascal9-course.md)): Bolt is the robot from Station Kestrel.

| Part | Where |
|---|---|
| Lessons | `AIPascalCourse/content/botmaze/` |
| The robot block | `AIPascalCourse/lib/robot.php`, `public/api/robot-answer.php`, `public/assets/robot-block.js/.css` |
| Art | `tools/botmaze/make_art.py`, `make_jokes.py` ([../brand/botmaze-art-style.md](../brand/botmaze-art-style.md)) |
| Videos | [botmaze-videos.md](botmaze-videos.md) |

The course is **sequential**, and its **key questions and every robot block are gated**. Like
every new course, it has:
- level names: Lost Bolt to Chief Programmer;
- margin extras (true facts, and a drawn joke in every lesson);
- its own home page colours (felt-pen red to card brown).

## The story

A solar storm hits Station Kestrel. Bolt, the maintenance robot, falls into the maintenance
tunnels with its memory wiped: it can only follow a program, exactly. The class programs it home,
one tunnel a lesson. **Glitch**, a purple bug who lives in the tunnels, swaps Bolt's commands
round (the debugging lesson). In lesson 7 Bolt reaches the Docking Bay, Glitch hides in the
toolbox, and Commander Naledi (from the Grade 9 course) is mentioned.

The look, from Chris's "c and d": a top-down adventure game built by hand on a desk - card
walls, masking tape, felt pen, sticky notes.

| # | Id | Title | Tunnel | Gated |
|---|---|---|---|---|
| 1 | `steps` | Exact steps | The Cupboard | `o1Noodles`, `q1Exact`, `r1Cupboard`, `r1Shaft` |
| 2 | `turning` | Turning | The Bend | `q2Whose`, `r2Bend`, `r2Short` (shortest path: 7 moves) |
| 3 | `debugging` | Glitch was here | Glitch's Nest | `m3Kinds`, `o3Debug`, `r3Swap`, `r3Missing` (starters with Glitch's bugs; "fix, don't rewrite" by a command limit) |
| 4 | `repeat` | Repeat | The Long Haul | `r4Haul`, `t4Count`, `r4Stairs` |
| 5 | `ifs` | Look before you move | The Doors | `q5Sense`, `r5Doors` (two mazes, one program) |
| 6 | `wall` | Follow the wall | The Twisty Bit | `q6Bend`, `o6Rule`, `r6Twisty` (three mazes: the right-hand rule) |
| 7 | `home` | The way home (final) | The Docking Bay | `q7Plan`, `r7Home` (three mazes, every battery), and the written `w7Explain` (4 marks, Jev) |

The plan's lesson 7 was "a maze of their own and its solution". The robot block marks fixed
mazes, so the final is instead three layouts the same program must solve, plus a written
explanation of how the program decides.

## The robot block (new platform work, 11 October 2026)

A program built from blocks (forward, turn left, turn right, repeat N, repeat until exit, if,
if ... else; the tests wall/path ahead/left/right), Run animates Bolt as often as the pupil
likes, Check marks it by what Bolt does - exit, every maze, every battery, at most N moves, at
most N commands, uses a block - two tries, doubled first time, no AI. The page and the marker run
the same rules (`tests/robot-cases.json`, run by `tests/robot.test.php` and
`public/assets/robot-block.test.js`); `bin/check-robots.php` checks every model meets every check
and no starter does.

## Checks

`php bin/check-robots.php botmaze` and the usual figures, popup-spacing, lesson-contents, titles,
why, glossary, lesson-links and Jev checks. Jev's one remaining flag (11 October 2026) is
`q5Sense` - a left/right question that is meant to be tricky; its answer was checked by hand.
