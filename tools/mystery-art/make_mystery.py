"""The mist behind every unrevealed picture (public/assets/mystery-mist.webp).

Chris, 2 October 2026, of the "?" boxes on the achievements page: "make the
placeholders more interesting and mysterious - don't need to vary, just maybe
one standard animated swirling mist and question mark - use comfyui - for all
pages where there are unrevealed images". One picture, made once: a swirl of
mist on deep indigo. The page turns two copies of it slowly in opposite
directions inside a circle and puts a glowing "?" on top (achievements.css,
.mystery) - the question mark is the page's own text, not part of the picture.

    python make_mystery.py            three seeds, raw PNGs in D:\\temp\\mystery-art
    python make_mystery.py 2          publish seed 2 as the site's mystery-mist.webp

Needs ComfyUI (COMFY_URL, e.g. http://127.0.0.1:8189). Uses ../dilemma-art/make_art.py's
client (Qwen-Image 2512, 4 Lightning steps).
"""
import sys
from pathlib import Path

from PIL import Image

sys.path.insert (0, str (Path (__file__).resolve ().parent.parent / "dilemma-art"))
from make_art import TextToImage, Run      # noqa: E402

SITE   = Path (__file__).resolve ().parents[3] / "AIPascalCourse"
RAW    = Path ("D:/temp/mystery-art")
TARGET = SITE / "public" / "assets" / "mystery-mist.webp"
SEEDS  = [1, 2, 3]

PROMPT = ("Seen from directly above: a slow whirlpool of soft glowing mist and fog, wisps of pale lavender, "
          "violet and teal smoke spiralling inwards around a dark centre, like a magical portal or a crystal ball "
          "full of fog. Deep indigo and midnight blue all around, the swirl filling the whole square evenly, "
          "dreamy, mysterious, soft focus, painterly. No objects, no people, no text, no letters, no symbols.")


def Make (seed):
    raw = RAW / f"mist-{seed}.png"
    seconds = Run (TextToImage (PROMPT, 1024, 1024, seed), raw)
    print (f"seed {seed}: {seconds:.0f}s -> {raw}")


def Publish (seed):
    """The page's copy: 384 x 384 WebP (shown at 56-96 px, turned, on 2x screens)."""
    image = Image.open (RAW / f"mist-{seed}.png").convert ("RGB").resize ((384, 384), Image.LANCZOS)
    image.save (TARGET, "WEBP", quality=72, method=6)
    print (f"published seed {seed}: {TARGET} ({TARGET.stat ().st_size // 1024} KB)")


if __name__ == "__main__":
    if len (sys.argv) > 1:
        Publish (int (sys.argv[1]))
    else:
        for seed in SEEDS:
            Make (seed)
