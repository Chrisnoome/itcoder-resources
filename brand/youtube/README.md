# YouTube channel art

Art for the six channels in `youtube-channels.md`. Chris chose all-SVG art for now (3 October 2026: "use
all svg for now. make svg parts for the rest"). The ideas and alternatives are on the design board:
https://claude.ai/artifact/LtgVBNvwsQKPhcxTb9feYz

| Folder | Channel | Mark | Colours |
|---|---|---|---|
| `pascal` | Pascal School SA | `begin … end.` with a teal cursor | navy `#12355b`, teal `#2ec4b6` |
| `java` | Java School SA | a coffee cup inside `{ }` | coffee `#2b1a12`, orange `#f28c28` |
| `sql` | SQL School SA | a database cylinder | green `#0e3b2a`, mint `#6fe3a5` |
| `cat` | CAT School SA | four app tiles in the site's CAT colours | slate `#1b2233`, blue/green/coral/cyan |
| `ai4all` | AI 4 All | the 4 drawn as a network | indigo `#2d2a8c`, lilac `#c9b8ff`, gold `#ffd166` |
| `ai4teachers` | AI for Teachers | a white apple with a gold spark for a leaf | red `#c8372d`, gold `#ffd166` |

**The family rule:** the four School SA channels go with bestlessons.co.za. They carry the BestLessons
light-blue rising line (`#7ea6ff`) under the mark, and their banners and end cards name the site. The
two AI channels stand alone: no line, no site.

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
