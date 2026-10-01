"""Art for the collectables (lib/collectables.php), made with the local ComfyUI.

Chris, 1 October 2026: collectables that match the lesson content - "comfyui,
glossy, attractive". Each item has its own 'art' prompt in
content/<course>/collectables.php (one object or character, no text); this
script wraps it in the house look - a glossy 3D collectible toy, a little
glow by rarity - and makes the white background transparent so the item sits
on the page's card.

    python make_collect_art.py                       every item not made yet
    python make_collect_art.py java                  one course
    python make_collect_art.py java/lesson10-looping-snake 7    redo one item with seed 7

Run it only when Chris says the GPU (and its cooler) is ready, with ComfyUI
started (D:\\ComfyUI App\\RLComfyUI\\run_nvidia_gpu.bat, port 8188). About 950
items at ~10 s each is ~3 hours on the RTX 3080 Ti laptop GPU - run a course
at a time. Raw PNGs in D:\\temp\\collect-art; the page's copies in
public/assets/collect/<course>/<code>.webp (256 x 256, as CollectArtUrl()
expects). Uses ../dilemma-art/make_art.py's ComfyUI client (Qwen-Image 2512)
and ../badge-art/make_badges.py's transparent background.
"""
import json
import subprocess
import sys
from pathlib import Path

from PIL import Image

sys.path.insert (0, str (Path (__file__).resolve ().parent.parent / "dilemma-art"))
sys.path.insert (0, str (Path (__file__).resolve ().parent.parent / "badge-art"))
from make_art import TextToImage, Run      # noqa: E402
from make_badges import Transparent        # noqa: E402

SITE = Path (__file__).resolve ().parents[3] / "AIPascalCourse"
RAW  = Path ("D:/temp/collect-art")
PHP  = "D:/xampp/php/php.exe"

RARITY = {
    "common":    "bright, cheerful colours",
    "rare":      "richer colours with a soft blue shimmer around it",
    "legendary": "gleaming gold and jewel tones with a warm magical glow and tiny sparkles around it",
}

PROMPT = ("{art}. A glossy 3D collectible toy figure, {rarity}, smooth shiny plastic and enamel, "
          "soft studio light, like a reward in a mobile game. The whole object centred on a plain pure white "
          "background with space all around it. No text, no letters, no numbers, no words, no logos anywhere.")


def Catalogue ():
    """course => [item, ...] from the site's own CollectableSets()."""
    script = ('chdir ("' + str (SITE).replace ("\\", "/") + '"); require "lib/course.php"; require_once "lib/collectables.php";'
              '$out = []; foreach (array_keys (CourseIndex ()) as $c) { foreach (CollectableSets ($c) as $items) { foreach ($items as $i) { $out[$c][] = $i; } } }'
              'echo json_encode ($out);')
    return json.loads (subprocess.run ([PHP, "-r", script], capture_output=True, text=True, check=True).stdout)


def Target (course, code):
    return SITE / "public" / "assets" / "collect" / course / f"{code}.webp"


def Make (course, item, seed=5):
    raw = RAW / course / f"{item['code']}.png"
    prompt = PROMPT.format (art=item["art"].rstrip (". "), rarity=RARITY.get (item["rarity"], RARITY["common"]))
    seconds = Run (TextToImage (prompt, 1024, 1024, seed), raw)
    image = Transparent (Image.open (raw)).resize ((256, 256), Image.LANCZOS)
    target = Target (course, item["code"])
    target.parent.mkdir (parents=True, exist_ok=True)
    image.save (target, "WEBP", quality=82, method=6)
    print (f"{course}/{item['code']}: {seconds:.0f}s -> {target.stat ().st_size // 1024} KB", flush=True)


if __name__ == "__main__":
    catalogue = Catalogue ()
    args = sys.argv[1:]

    if args and "/" in args[0]:
        course, code = args[0].split ("/")
        item = next (i for i in catalogue[course] if i["code"] == code)
        Make (course, item, int (args[1]) if len (args) > 1 else 5)
        sys.exit ()

    for course, items in catalogue.items ():
        if args and course != args[0]:
            continue
        for item in items:
            if not Target (course, item["code"]).exists ():
                Make (course, item)
