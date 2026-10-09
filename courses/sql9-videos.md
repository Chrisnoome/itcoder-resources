# Grade 9 SQL (the rhino case) - video plans for the video chat

Chris, 9 October 2026: video plans for the Grade 9 courses. Course: `sql9`
(`AIPascalCourse/content/sql9/`, plan [sql9-course.md](sql9-course.md), database
`content/sql/db/reserve.php`).

**8 videos, one per lesson, about 50 minutes in all.** Each **Goes** line is the place in the
lesson (add a `// VIDEO sql9-NN.n` comment there when you start it).

## Rules

- Method and voice: [tutorial-videos.md](tutorial-videos.md). Thumbnails from a new
  `thumbs-sql9.json`: background `#16201a`, accent `#f2b33d`, second `#9fe870`; tag
  `SQL · CLUE N`.
- **Two looks** ([../brand/sql9-art-style.md](../brand/sql9-art-style.md)): the **ops room** for
  data - dark screens, terminal-green tables, an amber bar on the row that matters (the lesson
  figures `doodles/sql9-*.svg` are drawn from the real data); and **realistic coloured-pencil
  scenes** - the reserve, the waterhole, the gate at night, Tumelo, Oxi the oxpecker - from the
  ComfyUI queue (`comfyui-queue/requests/2026-10-09-sql9-scenes.json`). Until those exist, open
  each video on the ops room alone; never hand-draw a substitute for the pencil pictures.
- **Every query is typed and run on screen** in the lesson's own Run box on bestlessons.co.za,
  in the VM, signed in with a test pupil - so the results on screen are the real ones. Type at a
  readable speed, one clause per line, and pause on the result.
- The story never shows harm: no carcasses, weapons or blood; Tumelo is found alive (lesson 8).
- Never give away a marked question's model answer: the videos run the lessons' try-it (`sql`)
  blocks and their variations, not the `sqlquery` answers. Video 8 shows the method of the open
  case, not its answers.
- Nothing in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| sql9-01.1 | The silent collar: tables and SELECT | 6 | `collar` after reveal `r1Count` |
| sql9-02.1 | WHERE: only the rows you want | 6 | `where` after `q2WhichCondition` |
| sql9-03.1 | AND, OR, brackets and LIKE | 7 | `traps` after reveal `r3Brackets` |
| sql9-04.1 | Sorting: ORDER BY, LIMIT, DISTINCT | 6 | `gate` after `sql4BX` |
| sql9-05.1 | Counting the pattern: COUNT to MAX | 6 | `pattern` after reveal `r5WhatItMeans` |
| sql9-06.1 | GROUP BY: a total for each | 7 | `duty` after reveal `r6WhereHaving` |
| sql9-07.1 | JOIN: connecting the dots | 8 | `connect` after `sql7Owner` |
| sql9-08.1 | How a detective works an open case | 5 | `nextnight` after `sql8Scratch` |

### sql9-01.1 The silent collar: tables and SELECT (about 6 min)

1. **Hook.** Hi, and welcome to BestLessons. Mabaso Game Reserve, 06:10. Ten collared rhinos;
   nine are sending. Tumelo has gone silent.
   > Pencil: the reserve landscape, then Tumelo with her collar. Then the ops room.
2. **Database, table, record, field.** The file cabinet; tblRhinos; a row is one rhino (record),
   a column one fact (field).
   > Board (ops room): tblRhinos drawn, a row outlined, then a column.
3. **SELECT * FROM tblRhinos;** - typed, run: 10 records, 8 fields.
4. **Naming fields.** `SELECT RhinoName, LastSeenDate, LastSeenTime, Zone FROM tblRhinos;` - run;
   change the order and run again. The amber row: Tumelo, 12 March, 17:40, K7.
5. **Clue 1** pinned. Sign-off.

### sql9-02.1 WHERE: only the rows you want (about 6 min)

1. **Hook.** 58 sightings. Thandeka only cares about one rhino.
2. **WHERE as a sieve.** `WHERE RhinoID = 2` - run; change to 7 (Mpho).
   > Board: a sieve, 58 cards in, 6 out.
3. **Quotes.** `WHERE Zone = 'K7'`; leave the quotes off on purpose and read the error together.
4. **Comparisons and dates.** `<`, `>`, `<=`, `>=`, `<>`; `SightDate >= '2027-03-12'`; why
   'HH:MM' times sort correctly as text.
5. **Clue 2.** Sign-off.

### sql9-03.1 AND, OR, brackets and LIKE (about 7 min)

1. **Hook.** Camera traps never sleep. We need a person or a vehicle, in K7.
   > Pencil: a trail camera on a tree.
2. **AND, OR, NOT** - the bouncer: "over 18 AND on the list" versus OR.
3. **Brackets.** Run the K7 query with brackets, then without - the K6 ranger patrol appears.
   AND before OR, like multiplication before addition.
4. **LIKE and %.** 'BX%', '%GP', '%plate%' - run a LIKE on the gate log's plates.
5. **Clue 3** - the 02:14 vehicle, "BX 4?". Sign-off.

### sql9-04.1 Sorting: ORDER BY, LIMIT, DISTINCT (about 6 min)

1. **Hook.** The gate log: 98 records in no useful order.
   > Pencil: the gate at night.
2. **ORDER BY** - run the BX query sorted by date and time; add DESC; two fields.
3. **LIMIT** - the 5 latest East-gate entries. **DISTINCT** - each BX plate once.
4. **The order of the parts** - SELECT, FROM, WHERE, ORDER BY, LIMIT, as a sentence.
5. **Clue 4** - BX 48 LM GP, in 22:50, out 03:30. Sign-off.

### sql9-05.1 Counting the pattern: COUNT to MAX (about 6 min)

1. **Hook.** One night is a coincidence. Detectives look for patterns.
2. **COUNT(*)** - five night entries; change the plate to BX 21 KP GP.
3. **SUM, AVG, MIN, MAX and AS** - the four-number query; read the story in the numbers.
   > Board: the sql9-count screen, each number circled in amber as it's read.
4. **Clue 5.** Sign-off.

### sql9-06.1 GROUP BY: a total for each (about 7 min)

1. **Hook.** One total for everyone isn't enough - we need one per ranger.
2. **Piles of cards.** GROUP BY RangerID with COUNT(*); the grouped field in the SELECT.
   > Board: shift cards sorted into piles, each pile counted.
3. **IN** - the five dates in one list.
4. **WHERE versus HAVING** - before grouping, after counting.
5. **Clue 6** - ranger 4, every time, and again on 16 March. Sign-off.

### sql9-07.1 JOIN: connecting the dots (about 8 min)

1. **Hook.** A plate and a number - neither is a name.
2. **Keys.** Primary key (PersonID), foreign key (OwnerID); the cloakroom ticket.
   > Board: the sql9-join-link figure: OwnerID 11 -> PersonID 11, the arrow drawn last.
3. **JOIN ... ON** - typed clause by clause: FROM tblVehicles JOIN tblPeople ON the keys; table.field
   names; run - Musa Dlamini. Remove the WHERE: every vehicle with its owner.
4. **Joining on a phone number** - pings to people (the idea only; the marked question is the
   pupil's).
5. **Clue 7.** Sign-off.

### sql9-08.1 How a detective works an open case (about 5 min)

1. **Hook.** No more set questions - four open ones, your queries, your way.
2. **The method.** Read the question; pick the table(s); write the WHERE first in words; build
   the query a clause at a time in the scratch pad; check the rows, not only the number (the
   "before 18:00" trap in general terms).
3. **Writing the report.** The trail in order, a query for each step, what the data can and
   can't prove. Point to the rubric under the question.
4. **Ending.** No answers here - Tumelo is waiting. Sign-off.
   > Pencil: a rhino and calf at sunrise, an oxpecker on her back (only after the pupil has
   > read the epilogue - so use it at the end card, without spoiling the case).
