# Grade 7 Tuck-shop tycoon (`tuckshop`) art style: board-game tycoon, Till and Calc

Chris chose these on 10 October 2026, from the board
(https://claude.ai/artifact/MFK5WhFX73dfGJ457TEjzd, source `brand/tuckshop-art-board.html`):
- **D, the board-game tycoon** style;
- the mascots **Till and Calc**, as a pair.

No other course uses this look. Each course's style is its own.

## The look: the term is a board game

- **The board.** The course is a board game round the edge of a square board: one square
  for each of the 8 lessons, plus GO. Every lesson opener (`tuckshop-board-01` to `-08`)
  shows the board with the class's pawn on that lesson's square. The square has the
  lesson's own colour and a small picture of what it teaches.
- **Colours.** Bright primary colours on white squares, each with a dark green outline:
  - outline and ink: `#10301d`;
  - board green: `#dff0e2`;
  - yellow `#ffd84d`, sky `#8fd3ff`, red `#e8483b`, lime `#b6e388`;
  - pawn violet `#6a4cff`.
- **Play money and dice.** These go in the margins: R20 and R50 notes with dashed inner
  borders, and dice with round pips. Prices are written on the squares in rands, such as
  `R12`.
- **Type.** **Fredoka** (700) for everything drawn: board text, prices, captions and speech.
  The doodle captions in the lesson are Fredoka too, in the outline green.
- **Line.** Outlines are 2 to 3 px at 520 wide, rounded joins, and flat fills with no
  gradients.
- **Drawing.** SVG, drawn by `AIResources/tools/tuckshop/make_art.py` into
  `AIPascalCourse/public/assets/doodles/tuckshop-*.svg`. No ComfyUI, except the course
  icon, badges and level emblems, which go through the queue.

## Till and Calc

The two mascots always appear together. Their running joke is the course's main lesson.
- **Calc** is a violet pocket calculator, fast and jealous of the spreadsheet. Calc always
  works the answer out and **types the number in**. It is right today, and wrong as soon as
  a price changes.
- **Till** is the shop's old green cash register: grumpy, exact and slow. Till only rings
  "ka-ching!" for a **real formula** that points at cells, and huffs at typed-in numbers.

Their jobs:
- **In the openers and step pictures,** speech bubbles with rounded corners.
- **In the margin doodles,** one-line captions (content-voice-and-pedagogy.md §5b).
- **In the gags,** Calc's typed answers going wrong when the prices change, and Till's
  "ka-ching".

## The spreadsheet

The spreadsheet block stays plain, like Excel, so pupils recognise it in the lab. The art
style changes everything around it: openers, step pictures, side notes, emblems and
badges.
