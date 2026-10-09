# Course: Grade 9 intro to SQL - the rhino case (`sql9`) - PLAN

Chris, 9 October 2026: "next course - intro to sql for grade 9 - like sql murder mystery but
more like my courses with guidance, step by step, pictures, etc." He chose the **rhino
poachers** storyline, **its own art style** (a style board first, as for CAT and the safety
course), and a term shared with the social media course
([socialmedia-course.md](socialmedia-course.md)): **social media first, then SQL**.

**Written and open, 9 October 2026** - all 8 lessons in `content/sql9/`, the database `content/sql/db/reserve.php` (built and clue-checked by `tools/sql9/`, every model answer run in SQLite). Not yet run on MySQL: the local runner has no MySQL - check on the test site.

General Computing, Grade 9. **8 lessons** (term 1: 2 lessons per 7-day cycle, about 15
lessons; social media takes 6, SQL 8, one spare). Status `open` from the start (no draft -
platform.md). Content in `AIPascalCourse/content/sql9/`. 

## The story

**Mabaso Game Reserve** (made up, Limpopo). Tumelo, a rhino with a tracking collar, has gone
silent. The rangers have data - and a hunch that the poaching gang will strike again at full
moon, in nine days. The reserve's data analyst is off sick; the pupil is the stand-in.

Each lesson's query turns up one clue, pinned on the ops-room board. Lesson 7's JOIN links a
vehicle at the gate to a phone ping near Tumelo's last position; lesson 8 is an open
investigation that names the gang's inside contact - in time. Nobody is hurt on screen;
Tumelo is found alive (dehorned by the vets and moved, in the epilogue). Careers note: real
reserves use exactly this kind of data.

## The database (SQLite, one file, used all course)

| Table | Holds | Used from |
|---|---|---|
| `rhinos` | id, name, sex, age, collar_id, last_seen (date, time), zone | lesson 1 |
| `sightings` | rhino_id, date, time, zone, ranger_id | lesson 2 |
| `camera_traps` | trap_id, zone, date, time, what (animal / person / vehicle), notes | lesson 3 |
| `gate_log` | date, time, gate, plate, direction (in/out), reason | lesson 4 |
| `vehicles` | plate, make, colour, owner_id | lesson 7 |
| `people` | id, name, role (ranger, guide, contractor, visitor), phone | lesson 7 |
| `phone_pings` | phone, date, time, tower, zone | lesson 7 |
| `shifts` | ranger_id, date, start, end, zone | lesson 6 |

About 20-400 rows a table: enough that pupils need the query, small enough to look at. Built
by a script so every clue is planted on purpose and checked by a test (every lesson's model
query returns exactly the clue).

## Lessons

1. **The silent collar** - what a database is: tables, rows (records), columns (fields), a
   drawn table first. `SELECT * FROM rhinos`, then `SELECT name, last_seen FROM rhinos`.
   Clue: Tumelo was last seen 3 days ago in zone K7.
2. **Where was she?** - `WHERE` with `=`, `<`, `>`, text in quotes, dates. Sightings in K7.
   Clue: no sightings since Tuesday 17:40.
3. **The camera traps** - `AND`, `OR`, `NOT`, `LIKE 'B%'`, brackets. Camera traps in K7 at
   night showing a person or vehicle. Clue: a vehicle at 02:14, plate starting "BX".
4. **Who came through the gate?** - `ORDER BY`, `DESC`, `LIMIT`, `DISTINCT`. Night entries at
   the gates around that time. Clue: three plates starting BX; one entered at 22:50 and left
   at 03:30.
5. **The pattern** - `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`. How many night entries, the
   longest stay. Clue: one plate came in at night five times this month - always near full
   moon.
6. **Who was on duty?** - `GROUP BY` (and `HAVING` as an extra). Shifts per ranger; who covered
   K7 on those nights. Clue: one ranger swapped onto K7 every time.
7. **Connecting the dots** - `JOIN` on a shared id: vehicles to people, people to
   phone_pings. The big idea drawn carefully (the db-keys-link figure's style). Clue: the
   BX vehicle's owner's phone pinged the K7 tower at 02:10.
8. **The full moon** - an open investigation across all the tables (pupils choose their own
   queries, with hint cards), then the **final report** (written, about 30 marks, banded
   rubric, on the AI and safety courses' model): who, how the data shows it, and which query
   proved each step.

Each lesson: the story beat, the table drawn, a worked query built clause by clause with a
reveal, a live try-it (the SQL course's runner, SQLite), typed queries marked clause by clause
with `'rules'` (Jev first), a scamSpotter-like evidence activity where it fits, a study block.

## Platform

- Reuse the SQL course's runner and clause-by-clause marking (`lib/sql.php`,
  ../sql-runner-design.md) with one fixed SQLite database; no dialects (`'dialects'` off).
- A new **evidence board** activity (like scamSpotter): clues pinned as each lesson is solved,
  saved as activity state - the course's through-line. To build.
- Art: [../brand/sql9-art-style.md](../brand/sql9-art-style.md) (Chris, 9 October 2026) - the
  ops room for data (SVG) plus realistic coloured-pencil scenes and animals (ComfyUI, queued in
  `comfyui-queue/requests/2026-10-09-sql9-scenes.json`), Oxi the oxpecker as the mascot.

## Questions for Chris

- Is the real-world careers angle (conservation data, SANParks) wanted, or story only?
- **Decided (Chris, 9 October 2026):** the open final case is marked **by result**, with hint
  cards that unlock when a pupil is stuck; the written report by rubric. Lessons are about
  40 minutes.
- Any rhino-poaching content too sensitive for the class? (Plan: no violence shown, no
  carcasses, Tumelo survives.)
