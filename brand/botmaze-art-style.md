# Grade 7 Bolt's maze (`botmaze`) art style: a handmade adventure game, Bolt and Glitch

Chris chose this on 11 October 2026 from the board
(https://claude.ai/artifact/WXvw7jJCBHZucAut7wh2NA, source `brand/botmaze-art-board.html`):
**"c and d"** - the cardboard stop-motion maze together with the top-down adventure game - and
**Glitch** as Bolt's sidekick.

So the look is **a top-down adventure game that pupils built by hand on a desk**: the tunnels
are seen from above like a game level, but every piece is made of card, paper, masking tape and
felt pen. No other course uses it.

## The pieces

- **The desk:** kraft card `#c9a273`, with faint corrugation lines `#b48c5d`.
- **The level:** a sheet of paper `#f3e4cc` laid on the card, slightly crooked (a degree or two).
- **Walls:** strips of brown card `#8a6239`, edges a little darker `#6e4c2a`.
- **Floor squares:** paper, drawn in pencil grey `#b9a98c` lines - the game's tiles.
- **Tape:** pale yellow masking tape `#f5e7a8`, a few strips holding things down.
- **Felt pen:** red `#c0392b` for arrows, the path Bolt takes and circles round mistakes;
  dark brown `#2a1d10` for outlines and writing.
- **The game screen (HUD), on sticky notes:** yellow `#ffe36b` - hearts drawn in red felt pen,
  a battery counter, the tunnel's name. The exit is a green sticky note `#9be38a` saying EXIT.
- **Batteries:** yellow paper cut-outs `#ffd84a` with a felt-pen lightning bolt.
- **Type:** Gaegu (700) for captions and everything handwritten; Luckiest Guy for tunnel names
  and big game words (LEVEL, EXIT, TUNNEL 4).

## Bolt and Glitch

- **Bolt** is a paper cut-out: a boxy grey-blue head `#dfe3ea`, one big orange eye `#ff8a2a`, two
  antennae - the same robot as Station Kestrel (Grade 9), redrawn by hand. Seen from above in a
  maze, Bolt is the head with a felt-pen arrow showing which way it faces.
- **Glitch** is a small purple paper bug `#7b6cf6` with pipe-cleaner antennae and a grin. Glitch
  lives in the tunnels and swaps Bolt's commands round when nobody is looking: every debugging
  task is "what did Glitch change?". Glitch is cheeky, never nasty.

## The tunnels (one a lesson)

| # | Tunnel | Lesson |
|---|---|---|
| 1 | The Cupboard | exact steps |
| 2 | The Bend | turning |
| 3 | Glitch's Nest | debugging |
| 4 | The Long Haul | repeat |
| 5 | The Doors | if |
| 6 | The Twisty Bit | repeat until, follow the wall |
| 7 | The Docking Bay | the final: home |

The map (`doodles/botmaze-map-NN.svg`) is a paper map taped to the desk, filling in tunnel by
tunnel, Bolt's head on the tunnel it has reached.

## The robot block

`body.course-botmaze` sets the robot block's `--rb-*` colours (`public/assets/design-e.css`) so
the activity looks like the game: card walls, paper floor, a green sticky-note exit, yellow
batteries and a red felt-pen trail.

## Rules

- Drawn by `AIResources/tools/botmaze/make_art.py` (jokes: `make_jokes.py`). ComfyUI only for the
  icon, badges and rank emblems in the queue.
- No real games, consoles or brands: the "game" is the pupils' own, made of card.
