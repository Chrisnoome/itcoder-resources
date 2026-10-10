# Course: Grade 8 Club website - your first HTML (`clubweb`) - PLAN

Chris chose this course first of the Grade 7/8 set on 10 October 2026
([grade7-8-courses.md](grade7-8-courses.md)). His instructions for it:
- "these should all be progress gated";
- "don't forget sidebar images, asides and factoids / jokes";
- "all courses must get their own distinct art style";
- "each course must get its own level names".

The art is comic panels with isometric blocks, Tag and Gat, and real screenshots
([../brand/clubweb-art-style.md](../brand/clubweb-art-style.md)).

- **Course:** General Computing, Grade 8. A short course: **8 lessons** of about 40 minutes, two
  per 7-day cycle.
- **Status:** `open`.
- **Sequential:** `'sequential' => true`. Inside each lesson the **build steps are gates**:
  HTML blocks with `'gate' => true`, so the lesson goes on once the step is finished.
- **Level names:** Blank Page, Tag, Heading, Paragraph, List, Link, Page, Website, Webmaster.
- **Content:** `AIPascalCourse/content/clubweb/`; figures `public/assets/doodles/clubweb-*.svg`;
  the club's pictures for the pages in `public/assets/practical/html/robotics/`.

## The story

The **Robotics Club** at Ridgeview High (a made-up school) has a stand at the school's Club
Expo in three weeks, and no website.
- **Zanele**, the club captain, asks the class to build it.
- **Boxy**, the club's cardboard robot, appears in the pictures.

Each lesson adds one part of the page, and the page grows lesson by lesson. Tag and Gat, the
angle brackets, explain everything in comic strips. The last lesson is the finished page,
built to Zanele's brief. In the epilogue the page goes up on the Expo screen.

## How a lesson works

1. **A comic strip.** Zanele asks for the next part of the page, and Tag and Gat set up the
   idea.
2. **The page the club wants.** A real screenshot of the finished page so far.
3. **Learn it.** Short, guided explanations of what each tag is for and why. Each new tag is
   shown as an isometric block, so nesting is stacking.
4. **Build steps.** Gated HTML blocks. Each adds one thing to the club's page, checked from
   the code, with a live preview beside it. Every step says what to do and why.
5. **Quick checks.** 2-3 short ones: match the tag to what it does, spot the unclosed tag,
   put the skeleton in order.
6. **Margin extras.** Tag and Gat doodles, "Did you know?" web facts, and a joke.
7. **Next time.** A one-line tease of the next lesson.

## Lessons

| # | id | Title | HTML | Build steps |
|---|---|---|---|---|
| 1 | `tags` | Tags: how a web page is built | What HTML is; the browser reads it; a tag opens and closes (Tag and Gat); the skeleton `html`, `head`, `title`, `body` | The skeleton with the title "Robotics Club"; a first line of text in the body |
| 2 | `headings` | Headings and paragraphs | `h1` to `h6`, one `h1` a page; `p`; why structure matters (screen readers, search) | The page heading; two paragraphs about the club; a `h2` for "What we do" |
| 3 | `lists` | Lists | `ul`, `ol`, `li`; a list inside a list (stacking) | "What we do" as a bullet list; "How to join" as numbered steps |
| 4 | `pictures` | Pictures | `img` with `src`, `alt` and `width`; why alt text matters; an empty tag | Boxy's picture with good alt text; a second picture at a set width |
| 5 | `links` | Links | `a` with `href`; link text that says where it goes; a link to a part of the page | A link to the school's page; an email link; a "Back to top" link |
| 6 | `tables` | Tables | `table`, `tr`, `th`, `td`, `border`; rows first, then cells | The competition fixtures table |
| 7 | `style` | A touch of colour | The `style` attribute: `color`, `background-color`, `text-align`; colour with care (contrast) | The heading in the club colours; a coloured banner; centred text |
| 8 | `expo` | The Club Expo | Everything together; checking a page against a brief | The final page, a marked HTML block with many checks; a short written reflection; the epilogue |

## Building it

- **HTML blocks and checks** follow the `html` block docs (`lib/html.php`). Each build step
  starts from the page so far (`starter`), and its `model` is the next version of the page.
  `bin/check-html.php` runs every check on every model.
- **Screenshots** of each model page are taken with headless Chrome or Edge at 800 px wide,
  then framed in a simple browser window. The script is in `AIResources/tools/clubweb/`.
- **The club's pictures** (Boxy, a robot build, the team) are drawn as SVG in the comic style,
  because ComfyUI isn't used now. They are saved as PNG for `img` tags.
- **Checks:** all the lesson checks, `check-html`, then Jev.
- **Course entry and polish:**
  - the course entry (gc, Grade 8, open, sequential);
  - the home icon;
  - fonts: Rubik Mono One, Space Mono and Inter Tight;
  - the caption CSS;
  - the level names (`RankFamily` clubweb).
