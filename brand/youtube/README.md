# YouTube channel art

Art for the eight channels in `youtube-channels.md`. Chris chose all-SVG art for now (3 October 2026: "use
all svg for now. make svg parts for the rest"). The ideas and alternatives are on the design board:
https://claude.ai/artifact/LtgVBNvwsQKPhcxTb9feYz

| Folder | Channel | Mark | Colours |
|---|---|---|---|
| `pascal` | Pascal School SA | `begin … end.` with a teal cursor | navy `#12355b`, teal `#2ec4b6` |
| `java` | Java School SA | a coffee cup inside `{ }` | coffee `#2b1a12`, orange `#f28c28` |
| `sql` | SQL School SA | a database cylinder | green `#0e3b2a`, mint `#6fe3a5` |
| `cat` | CAT School SA | four app tiles in the site's CAT colours | slate `#1b2233`, blue/green/coral/cyan |
| `skills` | Computer Skills SA | a mouse pointer clicking in an app window | plum `#4a1240`, pink `#ff8fd1` |
| `codesinger` | Pascal Code Singer (the songs) | a music note and Pascal's `;` | black `#141414`, white, gold `#ffcc33` |
| `ai4all` | AI 4 All | the 4 drawn as a network | indigo `#2d2a8c`, lilac `#c9b8ff`, gold `#ffd166` |
| `ai4teachers` | AI for Teachers | a white apple with a gold spark for a leaf | red `#c8372d`, gold `#ffd166` |

**The family rule:** the four School SA channels and Computer Skills SA go with bestlessons.co.za. They carry the BestLessons
light-blue rising line (`#7ea6ff`) under the mark, and their banners and end cards name the site. The
two AI channels stand alone: no line, no site. Pascal Code Singer is the songs channel, outside the
family: no line, but its banner says the lessons are at bestlessons.co.za.

**Each folder has:** `avatar` (800 x 800, full-bleed, YouTube crops it to a circle), `banner`
(2560 x 1440, name and logo inside the 1546 x 423 middle), `watermark` (150 x 150, clear background)
and `endcard-bg` (1920 x 1080, quiet left and middle for YouTube's end-screen elements). Every file is
an `.svg` with its letters as outlines, plus the `.png` that gets uploaded.

**To change them:** edit `source/build.py` and run it with a Python that has fontTools and Pillow (it
renders with headless Chrome). It needs Montserrat in the user fonts folder and JetBrains Mono NL in
`C:/Windows/Fonts`.

**ComfyUI alternatives:** illustrated avatars and banner backgrounds were made but not used (requests
`comfyui-queue/requests/2026-10-03-youtube-channels*.json`, pictures in
`D:\temp\comfy-queue\2026-10-03-youtube-channels*\`), in case Chris wants them later.

## Video thumbnails

One style for every channel's video thumbnails (1280 x 720), set up on Pascal Code Singer's 14 videos
on 3 October 2026 and recorded for the rest (Chris: "record similar styles with different colours for
the other channels"). `source/thumbs.py` makes them; its `CHANNELS` table holds the colours.

**The layout:** the channel background colour; a tag pill top left in the accent (`SONG · FOR LOOPS`,
`SQL · JOINS`); a big Montserrat Black title on the left, white with the key word in the accent; the
channel's mark and name bottom left (Code Singer: the note and `;`; the others: their avatar), with the
BestLessons blue line under it for the School SA channels and Computer Skills SA. On the right, a frame
from the video fading into the background (preferred), or a code card when there is no good frame.
The bottom-right corner stays clear for YouTube's video length. Titles follow "Name - topic"
(songs end in "(IT song)").

| Channel | Background | Accent | Sample |
|---|---|---|---|
| Pascal Code Singer | `#141414` | `#ffcc33` | `codesinger/thumbs/*.png` (live) |
| Pascal School SA | `#12355b` | `#2ec4b6` | `source/samples/pascal.png` |
| Java School SA | `#2b1a12` | `#f28c28` | `source/samples/java.png` |
| SQL School SA | `#0e3b2a` | `#6fe3a5` | `source/samples/sql.png` |
| CAT School SA | `#1b2233` | `#ff6a4d` | `source/samples/cat.png` |
| Computer Skills SA | `#4a1240` | `#ff8fd1` | `source/samples/skills.png` |
| AI 4 All | `#2d2a8c` | `#ffd166` | `source/samples/ai4all.png` |
| AI for Teachers | `#c8372d` | `#ffd166` | `source/samples/ai4teachers.png` |

**To make a channel's thumbnails:** write `source/thumbs-FOLDER.json` (id, tag, title lines with
`*accent*` words, and `code` lines or a frame), put frames in `FOLDER/frames/<id>.jpg` (ffmpeg, one
clear character or scene, no lyric caption), run `python thumbs.py --channel FOLDER`, then review on an
OK / Needs fixing page (`source/review.py` builds one) before uploading. `python thumbs.py --samples`
redraws the samples.
