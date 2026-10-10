# Grade 8 Club website - video plans for the video chat

Chris, 10 October 2026: "vide requirements to the video queue". The course is `clubweb`
(`AIPascalCourse/content/clubweb/`; plan [clubweb-course.md](clubweb-course.md)).

There are **8 videos, one per lesson, about 45 minutes in all.** Each **Goes** line gives the
place in the lesson. Add a `// VIDEO clubweb-NN.n` comment there when you start the video.

## Rules

- **Method and voice:** follow [tutorial-videos.md](tutorial-videos.md).
- **Thumbnails** come from a new `thumbs-clubweb.json`:
  - background `#2f6fde`, accent `#ffe14d`, second colour `#ff4f7a`;
  - tag `HTML · STEP N`.
- **The look** is [../brand/clubweb-art-style.md](../brand/clubweb-art-style.md):
  - comic panels with isometric blocks;
  - **Tag** (`<`, blue) and **Gat** (`>`, pink) explain in speech bubbles;
  - the club's page is always a **real browser screenshot**, never drawn.
- **Every step is typed on screen** in the lesson's HTML block on bestlessons.co.za.
  - Record in the VM, signed in with a test pupil, with the live preview beside the code.
  - Type at a readable speed, and pause on the preview after each change.
- **Never show a marked step's answer.**
  - Build a *different* club's page in the videos: the **Chess Club**. The method is the
    same as the Robotics Club's, but the words, pictures and links differ.
  - The Chess Club's page and pictures are made like the robotics ones: `tools/clubweb/pages.py`
    for the page and `shots.py` for the pictures.
- **Mistakes on purpose:** an unclosed tag (video 2), a wrong file name in `src` (video 4),
  and `colour` instead of `color` (video 7). In each, see the preview break and then fix it.
- Nothing goes in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| clubweb-01.1 | Tags: how a web page is built | 6 | `skeleton` after `o1Skeleton` |
| clubweb-02.1 | Headings and paragraphs | 5 | `paras` after `mw2Unclosed` |
| clubweb-03.1 | Lists: bullets and numbers | 5 | `inside` after `m3UlOl` |
| clubweb-04.1 | Pictures, and alt text for everyone | 6 | `width` after `s4GoodAlt` |
| clubweb-05.1 | Links that say where they go | 5 | `kinds` after `q5LinkText` |
| clubweb-06.1 | Tables: rows, headings and cells | 6 | `th` after `q6Cells` |
| clubweb-07.1 | A touch of colour, with care | 6 | `care` after `mw7Spelling` |
| clubweb-08.1 | Checking a page against a brief | 6 | `brief` before `htmlExpoFinal` |

## What each video covers

Each video:
1. **Hook:** a comic panel with Zanele's request, told for the Chess Club.
2. **The idea:** shown with isometric blocks, where nesting is stacking.
3. **Build:** typed in the HTML block, with the preview.
4. **Recap.**
5. **Sign-off.**

What each one must show:
- **01.1:** opening and closing tags, `<!DOCTYPE html>`, `html`/`head`/`title`/`body`, and
  the title showing in the browser tab.
- **02.1:** `h1` to `h6` as levels, not sizes; `p`; an unclosed `h1` swallowing the page.
- **03.1:** `ul`, `ol` and `li`, and a list inside a list.
- **04.1:** `img` as an empty tag, then `src`, `alt` and `width`. Read the alt text aloud as
  a screen reader would.
- **05.1:** `a href`, link text that says where the link goes, `mailto:`, and `id` with `#`.
- **06.1:** `table`, `tr`, `th` and `td`, drawn row by row.
- **07.1:**
  - `style="property: value;"` with `color`, `background-color` and `text-align`;
  - the American spellings;
  - contrast, and never using colour alone.
- **08.1:** read a brief line by line, tick each line against the page, and fix what is
  missing. Use the Chess Club's own brief, not the Expo final's.
