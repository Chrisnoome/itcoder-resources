"""Memory match pictures made with the local ComfyUI (lib/memorymatch.php).

Chris, 28 September 2026: "comfyui can be used to generate better images for
the matching game - icons, realistic, etc", mixed styles "for variety". Each
picture below is one term's card, in one of four looks, so a round mixes them:

    photo     a realistic studio photograph or scene
    icon3d    a glossy 3D icon
    flat      a flat vector icon
    paint     a watercolour and ink drawing

Rules for a card (the memory match's own, matchcards.php's header): the picture
must say the term without its word - no text, no labels, no logos; and terms
that would look alike share a 'group' in matchcards.php.

    python make_match_art.py              every picture not made yet
    python make_match_art.py theory10     one glossary
    python make_match_art.py --write      add the made pictures (and the groups) to
                                          content/<home>/matchcards.php

Raw PNGs in D:\\temp\\match-art; the page's copies in public/assets/match/<home>/
as <slug>-g<n>.webp (480x480) - "g" for generated, so they never clash with
the Eagle pictures' numbers. Each is listed in that folder's SOURCES.txt.
Uses the ComfyUI client in ../dilemma-art/make_art.py (Qwen-Image 2512).
"""
import re
import sys
from pathlib import Path

from PIL import Image

sys.path.insert (0, str (Path (__file__).resolve ().parent.parent / "dilemma-art"))
from make_art import TextToImage, Run   # noqa: E402

RAW      = Path ("D:/temp/match-art")
PLATFORM = Path (__file__).resolve ().parents[3] / "AIPascalCourse" / "public" / "assets" / "match"

LOOKS = {
    "photo":  "Realistic photograph of {x}. Sharp focus, soft even light, true colours, centred, on a plain light grey background.",
    "scene":  "Realistic photograph of {x}. Natural light, true colours, 35 mm lens.",
    "icon3d": "Glossy 3D icon of {x}: soft clay-like render, rounded chunky shapes, bright friendly colours, soft shadow, centred on a plain white background.",
    "flat":   "Flat vector icon of {x}: bold simple shapes, a few bright colours, clean thick outlines, centred on a plain white background.",
    "paint":  "Watercolour and ink illustration of {x}: loose ink lines, soft washes of colour, centred on plain white paper.",
}
NO_TEXT = " No text, no letters, no numbers, no labels, no logos, no brand names anywhere in the picture."

# glossary home -> term -> (look, what to draw)
JOBS = {
    "theory10": {
        "Coaxial cable":          ("photo",  "a coaxial cable cut open in steps to show its layers: a copper centre wire, white insulation, a braided metal shield and a black outer jacket"),
        "Ethernet":               ("icon3d", "a blue network cable with a clear square RJ45 plug at its end"),
        "Expansion card":         ("photo",  "a green computer expansion card with a gold-contact edge connector and a metal bracket"),
        "DSLR":                   ("flat",   "a black DSLR camera with a big lens"),
        "Dot matrix printer":     ("paint",  "an old beige dot matrix printer feeding continuous paper with holes along both edges"),
        "E-waste":                ("scene",  "a heap of broken old computers, keyboards, cables and mobile phones dumped outdoors"),
        "CMOS battery":           ("photo",  "a shiny silver coin cell battery sitting in its round holder on a green motherboard, close-up"),
        "Cell tower":             ("paint",  "a tall steel mobile phone tower with antenna panels, against the sky"),
        "Compressed air":         ("photo",  "a can of compressed air duster with a thin red straw nozzle, as used to clean keyboards"),
        "Carpal tunnel syndrome": ("paint",  "a hand on a computer mouse with the wrist glowing red with pain"),
        "Cyberbullying":          ("paint",  "a sad teenager looking at a phone while angry speech bubbles with frowning faces fly out of the screen"),
        "Digitising tablet":      ("photo",  "a black graphics drawing tablet with a pen stylus lying on it"),
        "ATM":                    ("scene",  "a cash machine built into a bank wall, with a keypad and a screen, seen from the front"),
        "Augmented reality":      ("paint",  "a phone held up in a lounge, its screen showing a cartoon dinosaur standing on the real carpet"),
        "Capacitor":              ("photo",  "three electrolytic capacitors, small blue and black cylinders with two metal legs each"),
        "Cobot":                  ("icon3d", "a friendly robot arm working side by side with a person at a workbench"),
        "Dumpster diving":        ("paint",  "a person leaning into a rubbish bin, pulling out thrown-away papers and letters"),
        "Emoji":                  ("icon3d", "a group of small round yellow smiley faces: laughing, crying with joy, winking and heart eyes"),
        "Eye strain":             ("paint",  "a tired person rubbing their eyes in front of a bright computer screen at night"),
        "Geostationary satellite":("paint",  "a communications satellite with solar panel wings above the curve of the Earth"),
        "Hotspot":                ("flat",   "a smartphone sending out Wi-Fi signal waves to a laptop"),
        "Interactive flat panel": ("scene",  "a large touchscreen display on a classroom wall with a teacher's hand touching it"),
        "Loyalty card":           ("icon3d", "a plastic store rewards card with a star on it and a few shopping bags"),
        "Magnetic tape":          ("photo",  "a data backup tape cartridge next to an old reel of brown magnetic tape"),
        "Mainframe":              ("scene",  "a row of tall black mainframe computer cabinets in a clean white computer room"),
        "Microfibre cloth":       ("photo",  "a folded soft blue microfibre cleaning cloth wiping a laptop screen"),
        "Mesh Wi-Fi":             ("flat",   "a house seen in cross-section with three small Wi-Fi units in different rooms linked by signal waves"),
        "Multifunction printer":  ("photo",  "an office multifunction printer with a scanner lid on top and paper trays"),
        "Punched card":           ("paint",  "an old computer punched card, a stiff paper card full of small rectangular holes in rows"),
        "Single-board computer":  ("photo",  "a tiny bare green single-board computer the size of a credit card, with USB ports and pins"),
        "Security token":         ("icon3d", "a small key-fob security token with a tiny screen and a button, on a key ring"),
        "Shoulder surfing":       ("paint",  "a person secretly peeking over someone's shoulder as they type a PIN at a cash machine"),
        "Smart meter":            ("photo",  "a digital electricity meter on a wall with a small screen and a blinking light"),
        "Supercomputer":          ("scene",  "long rows of tall supercomputer cabinets with blue lights in a huge hall"),
        "Surveillance":           ("flat",   "a CCTV security camera on a wall bracket"),
        "Power surge":            ("paint",  "a lightning bolt striking a wall plug socket with sparks flying out"),
        "Geotagging":             ("flat",   "a photo with a red map pin stuck onto its corner, over a map"),
        "Microwave link":         ("photo",  "two round grey microwave dish antennas mounted on a tall steel mast, facing sideways"),
        "Precision farming":      ("scene",  "a drone flying low over rows of green crops on a farm"),
        "Live stream":            ("paint",  "a teenager talking to a phone on a tripod with a ring light, a red recording dot glowing"),
        "E-sports":               ("scene",  "young gamers with headsets playing on computers on a stage in front of a crowd"),
        "Remote work":            ("paint",  "a person working on a laptop at a kitchen table at home, a cat beside the laptop"),
        "Standalone headset":     ("icon3d", "a white virtual reality headset with two hand controllers"),
        "Nanobot":                ("paint",  "a tiny robot swimming among red blood cells"),
        "PIN":                    ("flat",   "a finger pressing the buttons of a number keypad"),
        "Gyroscope":              ("flat",   "a smartphone tilting sideways with curved rotation arrows around it"),
        "Heat sink":              ("icon3d", "a metal heat sink with many thin cooling fins"),
        "Trackball":              ("photo",  "a computer trackball mouse with a big red ball on top"),
        "Undersea cable":         ("paint",  "a thick cable lying on the sea floor with fish swimming past"),
        "Cloud storage":          ("icon3d", "a white cloud with folders and files floating up into it"),
        "Laser printer":          ("flat",   "an office laser printer with a sheet of paper coming out"),
        "Switch":                 ("photo",  "a network switch box with a row of blue network cables plugged into its ports"),
    },
    "ai": {
        "Chatbot":             ("flat",   "a chat window with speech bubbles and a friendly round robot face answering"),
        "Cloud":               ("icon3d", "a white cloud with a small stack of servers inside it, connected by lines to a laptop"),
        "Data centre":         ("scene",  "a long aisle between rows of server racks with blinking lights in a cool data centre hall"),
        "Rack":                ("photo",  "one tall black server rack, the height of a fridge, full of stacked servers with blinking lights"),
        "Evaporative cooling": ("scene",  "big cooling towers on the roof of an industrial building, with clouds of water vapour rising"),
        "Liquid cooling":      ("photo",  "clear tubes of blue coolant running across the chips of a computer inside its case"),
        "Graphics card":       ("photo",  "a large computer graphics card with three cooling fans"),
        "Motherboard":         ("icon3d", "a green computer motherboard with slots, chips and connectors"),
        "Processor":           ("flat",   "a square computer processor chip with golden pins around its edges"),
        "Robot":               ("paint",  "a humanoid robot walking carefully, carrying a box in a warehouse"),
        "Grid":                ("scene",  "a line of tall electricity pylons with power cables crossing the countryside at sunset"),
        "Megawatt":            ("paint",  "hundreds of electric kettles all boiling at once in long rows, steam everywhere"),
        "Dataset":             ("scene",  "people in black motion-capture suits covered in small white dots, walking in a studio"),
        "Bubble":              ("paint",  "a huge shiny soap bubble with a rising graph line inside it, a pin about to pop it"),
        "Weights":             ("flat",   "a neural network: circles in columns joined by many lines of different thicknesses"),
    },
}

# Terms whose pictures look alike share a group (matchcards.php), so a round
# never has two of them - the new terms, and the existing ones they resemble.
GROUPS = {
    "theory10": {
        "server":      ["Supercomputer", "Mainframe"],
        "network box": ["Mesh Wi-Fi"],
        "printer":     ["Inkjet printer", "Laser printer", "Multifunction printer", "Dot matrix printer"],
        "camera":      ["Digital camera", "DSLR", "Surveillance"],
        "card":        ["GPU", "Expansion card"],
        "vr":          ["VR headset", "Standalone headset"],
        "satellite":   ["Satellite Internet", "Geostationary satellite"],
        "tower":       ["Cell tower", "Microwave link"],
        "cable":       ["Coaxial cable", "Ethernet", "Fibre-optic cable", "Undersea cable"],
        "handheld":    ["Hotspot", "Gyroscope", "Augmented reality"],
        "atm":         ["ATM", "Shoulder surfing", "PIN"],
    },
    "ai": {
        "server": ["Data centre", "Rack", "Cloud"],
        "board":  ["Graphics card", "Motherboard"],
    },
}


def GroupOf (home, term):
    for group, terms in GROUPS.get (home, {}).items ():
        if term in terms:
            return group
    return ""


def WriteCards (home):
    """Every made picture into content/<home>/matchcards.php: added to its term (a new
    term gets a line of its own, in order), and the groups above set."""
    path = PLATFORM.parents[2] / "content" / home / "matchcards.php"
    if path.exists ():
        text = path.read_text (encoding="utf-8")
    else:
        text = ("<?php\n/**\n * Memory match faces for the " + home + " glossary (lib/memorymatch.php).\n"
                " * term => ['pictures' => [...], 'group' => name]; the pictures were made with\n"
                " * ComfyUI (AIResources/tools/match-art/make_match_art.py) and are listed in\n"
                " * public/assets/match/" + home + "/SOURCES.txt. No picture may show the word it stands for.\n"
                " */\n\nreturn [\n];\n")

    head, body = text.split ("return [\n", 1)
    body, tail = body.rsplit ("];", 1)
    entries = {}
    for line in body.splitlines ():
        match = re.match (r"    '((?:[^'\\]|\\.)*)'\s*=> (\[.*\]),$", line)
        if not match:
            raise ValueError ("unexpected line in " + str (path) + ": " + line)
        entries[match.group (1).replace ("\\'", "'")] = match.group (2)

    for term in JOBS[home]:
        target = Target (home, term)
        if not target.exists ():
            continue
        url = f"/assets/match/{home}/{target.name}"
        face = entries.get (term, "['pictures' => []]")
        if url not in face:
            face = re.sub (r"'pictures' => \[(.*?)\]",
                           lambda m: "'pictures' => [" + (m.group (1) + ", " if m.group (1) else "") + "'" + url + "']", face, count=1)
        entries[term] = face

    for group, terms in GROUPS.get (home, {}).items ():
        for term in terms:
            if term in entries and "'group'" not in entries[term]:
                entries[term] = entries[term][:-1] + ", 'group' => '" + group + "']"

    width = max (len (term) for term in entries) + 4
    lines = ["    " + ("'" + term.replace ("'", "\\'") + "'").ljust (width) + "=> " + face + ","
             for term, face in sorted (entries.items (), key=lambda item: item[0].lower ())]
    path.write_text (head + "return [\n" + "\n".join (lines) + "\n];" + tail, encoding="utf-8")
    print (f"{path.name} ({home}): {len (entries)} terms")


def Slug (term):
    return re.sub (r"[^a-z0-9]+", "-", term.lower ()).strip ("-")


def Target (home, term):
    return PLATFORM / home / f"{Slug (term)}-g1.webp"


def Make (home, term, seed=5):
    look, subject = JOBS[home][term]
    raw = RAW / home / f"{Slug (term)}.png"
    seconds = Run (TextToImage (LOOKS[look].format (x=subject) + NO_TEXT, 1024, 1024, seed), raw)

    image = Image.open (raw).convert ("RGB").resize ((480, 480), Image.LANCZOS)
    target = Target (home, term)
    target.parent.mkdir (parents=True, exist_ok=True)
    image.save (target, "WEBP", quality=80, method=6)

    sources = target.parent / "SOURCES.txt"
    line = f"{target.name}\tComfyUI\tQwen-Image 2512, made for us 28 Sep 2026 ({look}: {subject})\n"
    text = sources.read_text (encoding="utf-8") if sources.exists () else "Memory match pictures and where they came from.\n"
    if target.name not in text:
        sources.write_text (text + line, encoding="utf-8")

    print (f"{home}/{term}: {look} {seconds:.0f}s -> {target.name} {target.stat ().st_size // 1024} KB", flush=True)


if __name__ == "__main__":
    if sys.argv[1:2] == ["--write"]:
        for home in JOBS:
            WriteCards (home)
        sys.exit ()

    only = sys.argv[1] if len (sys.argv) > 1 else ""
    for home, jobs in JOBS.items ():
        if only and only != home:
            continue
        for term in jobs:
            if not Target (home, term).exists ():
                Make (home, term)
