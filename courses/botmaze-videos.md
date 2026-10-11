# Grade 7 Bolt's maze - video plans for the video chat

Chris, 10 October 2026: "vide requirements to the video queue". The course is `botmaze`
(`AIPascalCourse/content/botmaze/`; plan [botmaze-course.md](botmaze-course.md)).

There are **7 videos, one per lesson, about 35 minutes in all.** Each **Goes** line gives the
place in the lesson. Add a `// VIDEO botmaze-NN.n` comment there when you start the video.

## Rules

- **Method and voice:** follow [tutorial-videos.md](tutorial-videos.md).
- **Thumbnails** come from a new `thumbs-botmaze.json`:
  - background `#c9a273` (card), accent `#c0392b` (felt pen), second colour `#ffe36b` (sticky note);
  - tag `BOLT'S MAZE · TUNNEL N`.
- **The look** is [../brand/botmaze-art-style.md](../brand/botmaze-art-style.md): a handmade
  adventure game - card walls, masking tape, felt pen, sticky notes. Bolt and Glitch appear in the
  hooks. The real thing on a desk is welcome: a paper grid, sticky notes, a cut-out Bolt.
- **The robot block on screen.** Record the course's own robot block (the test site), building
  programs with the blocks and pressing Run, so pupils see exactly what they will use.
- **Never show a marked answer.** Every video uses its own maze, not one from a robot block
  (r1Cupboard to r7Home), and never builds the right-hand rule program in full before lesson 6's
  check - show the idea with the paper maze instead.
- Nothing goes in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| botmaze-01.1 | Program a person: the paper robot game | 5 | `paper`, before `commands` |
| botmaze-02.1 | Whose left? Turning like a robot | 5 | `whose`, before `q2Whose` |
| botmaze-03.1 | Debugging: run, watch, find, fix | 5 | `loop`, after `m3Kinds` |
| botmaze-04.1 | Spot the pattern: loops | 5 | `pattern`, after `t4Count` |
| botmaze-05.1 | Look before you move: sensors and if | 5 | `if`, after `q5Sense` |
| botmaze-06.1 | The right-hand rule | 6 | `rule`, before `o6Rule` |
| botmaze-07.1 | Explaining your program | 4 | `think`, before `w7Explain` |

## What each video covers

Each video:
1. **Hook:** Bolt in the tunnel on the map, and what is in the way this time (Glitch, when it is
   to blame).
2. **The idea:** on paper first - a grid, sticky notes, the cut-out Bolt.
3. **On screen:** the same idea built in the robot block and run.
4. **Sign-off.**

What each one must show:
- **01.1:** two people, a paper grid, sticky-note commands; the robot follows exactly and walks
  into a wall; fix the notes and try again. What makes a step exact.
- **02.1:** a quarter turn on the spot; "sit on Bolt" for whose left; Bolt facing down the screen
  turning left goes to the screen's right; counting two routes for the shortest.
- **03.1:** the four kinds of bug on sticky notes; watching the lit line; the bump as a clue; fix
  only that line; run again.
- **04.1:** eight forwards become repeat 8; inside versus outside the loop (the little square);
  saying the moves out loud to hear a pattern (a staircase that is not the lesson's).
- **05.1:** the six tests; an if that skips; one program in two tunnels of different lengths.
- **06.1:** repeat until and the infinite loop; if ... else; the right-hand rule walked on a paper
  maze with a real hand on the card wall, then run in a maze that is not one of the lesson's.
- **07.1:** what a good explanation says (what it checks, in what order, why it works anywhere,
  one limit), using a different program as the example.
