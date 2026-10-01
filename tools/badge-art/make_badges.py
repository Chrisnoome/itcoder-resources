"""Achievement badges for every course (lib/achievements.php), made with the local ComfyUI.

Chris, 1 October 2026: badges "juicy, colourful, exciting looking, inspire drive
to earn", generated with ComfyUI; glossy 3D game badges, a different look per
course. Each badge: the course's frame and colours, the achievement's picture
in the middle, no text. The white background is made transparent, so a badge
sits on the page's own card.

    python make_badges.py                 every badge not made yet
    python make_badges.py pascal          one course
    python make_badges.py pascal/flawless 7   redo one badge with seed 7

The list of achievements comes from the site itself (php: AchievementCatalogue()
for each course) - run from any folder. Raw PNGs in D:\\temp\\badge-art; the
page's copies in public/assets/badges/<course>/<code>.webp (256 x 256, the code
lower-cased as GameBadgeUrl() expects). Uses ../dilemma-art/make_art.py's
ComfyUI client (Qwen-Image 2512).
"""
import json
import re
import subprocess
import sys
from pathlib import Path

from PIL import Image, ImageDraw

sys.path.insert (0, str (Path (__file__).resolve ().parent.parent / "dilemma-art"))
from make_art import TextToImage, Run   # noqa: E402

SITE     = Path (__file__).resolve ().parents[3] / "AIPascalCourse"
RAW      = Path ("D:/temp/badge-art")
PHP      = "D:/xampp/php/php.exe"

# The look of each course's badges.
LOOKS = {
    "pascal":    "a shield-shaped badge with a royal purple enamel face, a thick polished gold rim and little retro 8-bit pixel squares along the edge",
    "java":      "a round badge in warm coffee brown and cream enamel with a polished copper rim and curls of steam rising around the edge",
    "sql":       "a hexagonal badge in teal enamel with a brushed silver rim made of stacked database cylinders",
    "theory10":  "a round badge in deep navy enamel with an electric cyan rim and glowing circuit-board traces",
    "theory11":  "a star-shaped badge in emerald green enamel with a gold rim and glowing network nodes joined by lines",
    "theory12":  "a diamond-shaped badge in magenta and violet holographic chrome with a glowing rim",
    "ai":        "a futuristic badge of polished chrome with a violet neon glow and a sleek rounded frame",
    "catword":   "a ribbon rosette badge in royal blue and white enamel with a silver rim",
    "catsheets": "a square badge with rounded corners in fresh green enamel with a faint grid pattern and a white rim",
    "cathtml":   "a round badge in bright orange enamel with angle-bracket shapes around a gold rim",
    "cattheory": "a round badge in sunset orange and red enamel with a bronze rim",
    "catdb":     "a hexagonal badge in deep maroon enamel with a gold rim of stacked discs",
    "catpilot":  "a round badge in sky blue enamel with a white rim and a small paper plane flying around the edge",
}

# Each achievement's picture, without text.
ICONS = {
    "footprints":                  "two small glowing footprints",
    "starting blocks":             "a pair of running starting blocks with a chequered flag",
    "five stars":                  "five golden stars in an arc",
    "number ten":                  "ten small golden stars in a ring",
    "mountain halfway flag":       "a mountain with a red flag planted halfway up",
    "crown":                       "a jewelled golden crown",
    "diamond":                     "a sparkling cut diamond",
    "target with arrow":           "an archery target with an arrow in the bullseye",
    "golden target":               "a golden archery target with three arrows in the bullseye",
    "wind swirl":                  "a swirl of wind lifting a paper plane upwards",
    "quill pen":                   "a feather quill pen beside an ink pot",
    "quill and trophy":            "a feather quill crossed over a golden trophy cup",
    "gold medal":                  "a shining gold medal on a ribbon",
    "calendar with tick":          "a calendar page with a big green tick",
    "bird at sunrise":             "a small bird singing in front of a rising sun",
    "small flame":                 "a small bright orange flame",
    "big flame":                   "a big roaring flame",
    "rocket with flames":          "a rocket blasting off with bright flames",
    "shield and sword":            "a small shield and sword with a sun and a moon behind them",
    "treasure map":                "a rolled-out treasure map with a red X",
    "stack of books":              "a stack of colourful books",
    "owl":                         "a wise owl wearing round glasses",
    "eye and music note":          "a big eye with musical notes floating around it",
    "globe waving":                "a cartoon globe of the Earth waving hello",
    "robot":                       "a friendly little robot with a lightning bolt",
    "magnifying glass over table": "a magnifying glass over a grid of table cells",
    "binary digits":               "a glowing light bulb made of circuit lines",
}

PROMPT = ("A glossy 3D game achievement badge: {look}. In the centre of the badge: {icon}. "
          "Juicy, colourful and exciting, like a reward in a mobile game: shiny enamel and metal, "
          "soft studio light, a little sparkle. The whole badge centred on a plain pure white background "
          "with space all around it. No text, no letters, no numbers, no words anywhere.")


def Catalogue ():
    """course => {code: icon}, from the site's own AchievementCatalogue()."""
    script = ('chdir ("' + str (SITE).replace ("\\", "/") + '"); require "lib/course.php"; require_once "lib/achievements.php";'
              '$out = []; foreach (array_keys (CourseIndex ()) as $c) { $out[$c] = array_map (fn ($a) => $a["icon"], AchievementCatalogue ($c)); }'
              'echo json_encode ($out);')
    return json.loads (subprocess.run ([PHP, "-r", script], capture_output=True, text=True, check=True).stdout)


def FileName (code):
    return re.sub (r"[^A-Za-z0-9]+", "-", code).lower ()


def Transparent (image):
    """White around the badge becomes transparent: flood-filled from the corners and edges."""
    image = image.convert ("RGBA")
    marker = (255, 0, 255, 255)
    w, h = image.size
    for seed in [(0, 0), (w - 1, 0), (0, h - 1), (w - 1, h - 1), (w // 2, 0), (w // 2, h - 1), (0, h // 2), (w - 1, h // 2)]:
        if image.getpixel (seed)[:3] != marker[:3]:
            ImageDraw.floodfill (image, seed, marker, thresh=40)
    pixels = image.load ()
    for y in range (h):
        for x in range (w):
            if pixels[x, y] == marker:
                pixels[x, y] = (255, 255, 255, 0)
    box = image.getbbox ()
    if box:
        image = image.crop (box)
        side = max (image.size) + 16
        square = Image.new ("RGBA", (side, side), (255, 255, 255, 0))
        square.paste (image, ((side - image.size[0]) // 2, (side - image.size[1]) // 2))
        image = square
    return image


def Make (course, code, icon, seed=5):
    raw = RAW / course / f"{FileName (code)}.png"
    seconds = Run (TextToImage (PROMPT.format (look=LOOKS[course], icon=ICONS.get (icon, icon)), 1024, 1024, seed), raw)
    badge = Transparent (Image.open (raw)).resize ((256, 256), Image.LANCZOS)
    target = SITE / "public" / "assets" / "badges" / course / f"{FileName (code)}.webp"
    target.parent.mkdir (parents=True, exist_ok=True)
    badge.save (target, "WEBP", quality=82, method=6)
    print (f"{course}/{code}: {seconds:.0f}s -> {target.name} {target.stat ().st_size // 1024} KB", flush=True)


if __name__ == "__main__":
    catalogue = Catalogue ()
    args = sys.argv[1:]

    if args and "/" in args[0]:
        course, code = args[0].split ("/")
        Make (course, code, catalogue[course][code], int (args[1]) if len (args) > 1 else 5)
        sys.exit ()

    for course, badges in catalogue.items ():
        if args and course != args[0]:
            continue
        for code, icon in badges.items ():
            if not (SITE / "public" / "assets" / "badges" / course / f"{FileName (code)}.webp").exists ():
                Make (course, code, icon)
