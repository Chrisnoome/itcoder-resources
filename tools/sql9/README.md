# Grade 9 SQL (the rhino case) - build tools

- `build_reserve.py <reserve.php> [checks.json]` - builds
  `AIPascalCourse/content/sql/db/reserve.php` (Mabaso Game Reserve) with every clue planted,
  writes `reserve.json`, and runs the clue queries in `checks.json` (`explore.json`) in SQLite.
  Seeded, so it rebuilds the same rows. Never hand-edit reserve.php.
- `make_figs.py <out dir>` - the ops-room figures (`doodles/sql9-*.svg`) drawn from real query
  results; run after build_reserve.py (reads reserve.json).
- `check_lessons.py` - runs every `answer` and `sql` in the lessons against the data (expects
  the lessons in `lessons/` beside it: point it at `content/sql9/`).

Course plan: ../../courses/sql9-course.md. Art: ../../brand/sql9-art-style.md.
