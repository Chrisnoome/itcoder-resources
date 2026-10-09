# Station Kestrel (Grade 9 Pascal) build tools

Course: `AIPascalCourse/content/pascal9/`. Plan: `courses/pascal9-course.md`. Art: `brand/pascal9-art-style.md`.

| Tool | Does |
|---|---|
| `run_programs.py` | Compiles every `content/pascal9/programs/*.pas` with local fpc (-Mdelphi -O1) and runs it with the inputs in `RUNS`; outputs to `out/`. The three `l1-err-*`/`l1-typo` programs must fail to compile. |
| `style_check.php` | Puts every program through the site's layout check with the console's full rules - nothing a lesson shows may be refused at Run. |
| `capture_screens.py` | Runs programs in an 80x25 pty on the VPS (via `../ui-screens/crt/crt.py`) and saves `content/pascal9/screens/*.ans`. |
| `show_screen.php` | Prints a captured screen as text. |
| `make_art.py` | Draws the pixel art: `public/assets/doodles/kestrel-*.svg` (station, ground, storm, crew, lockers, ship, airlock, docked, Bolt x5, the station map for each lesson 01-13). |

After changing a program: run `run_programs.py` and `style_check.php`, re-capture its screens, and run `bin/check-missions.php` in the platform.
