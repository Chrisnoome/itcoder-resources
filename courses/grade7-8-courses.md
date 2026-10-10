# Grade 7 and 8 General Computing courses - PLAN

Chris, 10 October 2026: "other courses for grade 7 and 8 - suggestions?" He chose all six
suggestions, as **two short courses a term** (6-8 lessons each, 2 lessons per 7-day cycle,
about 40 minutes).

Every course follows the Grade 9 pattern:
- a story;
- its own art style, chosen from a style board;
- guided steps, so pupils know what they are doing and why (Chris on the SQL course, 9 October
  2026: "they know nothing and need to be guided");
- `open` from the start, never draft;
- sequential (`'sequential' => true`).

Each course gets its own plan file when it is started; this file is the overview.

## The courses

| Id | Course | Grade | Lessons | Built on |
|---|---|---|---|---|
| `machine` | Inside the machine: how computers work | 7 | 7 | existing blocks |
| `botmaze` | Bolt's maze: algorithms and robotics | 7 | 7 | **new** grid-robot activity |
| `tuckshop` | Tuck-shop tycoon: spreadsheets | 7 | 8 | spreadsheet block (`sheet`) |
| `safety` | Staying safe online (exists) | 8 | 8 | - |
| `factfake` | Fact or fake: searching and checking online | 8 | 6 | existing blocks |
| `clubweb` | Club website: your first HTML | 8 | 8 | HTML block (`html`) |
| `ai8` | AI for beginners | 8 | 6 | existing blocks + a sorting try-it |

A possible year:

| Term | Grade 7 | Grade 8 |
|---|---|---|
| 1 | Inside the machine, then Bolt's maze | Staying safe online, then Fact or fake |
| 2 | Tuck-shop tycoon (+ a free slot) | Club website (+ a free slot) |
| 3-4 | free | AI for beginners, free slots |

The free slots are left open for later courses or for revision.

### Inside the machine (`machine`, Grade 7)

A shrinking-ray story. The class is shrunk to the size of a dust speck and has to travel
through a computer to fix it, one part per lesson.

1. **Input, process, output.** Keyboard, mouse, touch and sensors bring things in; the
   screen, speakers and printer send them out.
2. **The CPU.** The brain that follows instructions very fast but very literally (a
   "computer is stupid" activity).
3. **Memory and storage.** RAM as a desk and storage as a filing cabinet; why a computer
   forgets when it is switched off.
4. **Binary.** Light switches, counting in 0s and 1s, and a binary-to-number try-it.
5. **Files and sizes.** Bytes, KB, MB, GB, compared with photos, songs and videos.
6. **The internet.** A message cut into packets, routers, and how a WhatsApp message
   travels.
7. **Final.** Fix the computer: a diagnostic case using every part.

### Bolt's maze (`botmaze`, Grade 7)

Bolt (from Station Kestrel) is lost in the station's maintenance tunnels. Pupils program it
with commands. This fits CAPS Coding and Robotics, and leads into Grade 9 Pascal.

1. **Algorithms.** Exact steps, order matters (unplugged first).
2. **Commands.** Forward, turn left, turn right; the shortest path.
3. **Debugging.** Find the wrong step.
4. **Repeat.** Loops: "repeat 4 times".
5. **If.** "If the path is blocked, turn".
6. **Combining.** Repeat with if: follow the wall to the exit.
7. **Final.** A maze of their own and its solution.

The **grid-robot activity** is new: a grid, a command list built from blocks or arrows, Run
animates Bolt, and the result is checked when Bolt reaches the exit. It is marked by result.

### Tuck-shop tycoon (`tuckshop`, Grade 7)

The pupils run the school tuck shop for a term.

1. **Cells, rows, columns.** The price list.
2. **Formulas.** `=B2*C2`, takings for each item.
3. **SUM and AutoFill.** The day's total.
4. **Profit.** Cost price against selling price.
5. **AVERAGE, MIN and MAX.** The best and worst sellers.
6. **Formatting.** Rands, widths, a readable sheet.
7. **Charts.** Sales by day.
8. **Final.** Plan the fundraiser budget.

The spreadsheet block marks the formulas themselves, on the data and on hidden variations of
it.

### Fact or fake (`factfake`, Grade 8)

A newsroom intern at a made-up online paper has to check viral stories before they run.

1. **Searching well.** Keywords, quotes, `site:`.
2. **Who made it?** Sources and checking the author.
3. **Photos.** Reverse image search, old photos passed off as new.
4. **AI fakes.** Generated images, voices and video, and clues to spot them.
5. **Why fakes spread.** Emotion, shares, and the "pause before you share" rule.
6. **Final.** Check a story and write the verdict.

It sits beside the safety course in Grade 8.

### Club website (`clubweb`, Grade 8)

The pupils build a web page for a school club, such as robotics, choir or chess.

1. **Tags.** What HTML is; tags and the page skeleton.
2. **Headings and paragraphs.**
3. **Lists.**
4. **Pictures.** With alt text.
5. **Links.**
6. **A table.** The fixture list.
7. **A touch of colour.** Simple attributes, which leads into CAT HTML later.
8. **Final.** The club's page against a brief.

The HTML block marks each check from the code, with a live preview.

### AI for beginners (`ai8`, Grade 8)

The pupils train a robot to sort, as a lead-in to the Grade 9 course "How AI really works".

1. **What AI is, and isn't.**
2. **Learning from examples.** A sorting try-it: they train it, it guesses.
3. **Data matters.** Too few or one-sided examples, and bias.
4. **Chatbots.** They predict the next word; they are confident but can be wrong.
5. **Using AI well and honestly.** School work, sources, privacy.
6. **Final.** Advise the school on an AI rule.

## Order of work (suggested)

1. **Club website and Tuck-shop tycoon first.** The blocks exist, so these are the
   quickest.
2. **Inside the machine and Fact or fake.** These need no new blocks.
3. **Bolt's maze.** This needs the grid-robot activity built first.
4. **AI for beginners.** This needs the sorting try-it.

For each course:
1. A style board, then an art style document.
2. The plan file.
3. The lessons, with guided steps.
4. The checks and Jev.
5. Publish: test site, then live.
6. Links from other courses where they fit.
7. Video plans.
