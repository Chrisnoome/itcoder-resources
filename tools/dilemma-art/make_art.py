"""Pictures for the branching dilemmas (lib/dilemma.php), made with the local ComfyUI.

Chris, 28 September 2026: dilemmas get scene backgrounds, character avatars,
phone and chat screens and pop-up screens (the screens are drawn by the page,
not here); "realistic, cartoon a la no single letters characters, stylized,
illustrated - mix it up for variety". One look per story, so a story hangs
together and the stories differ:

    pat       cartoon, the No Single Letters caricature style (Qwen-Image-Edit 2511,
              styled on the video's art/gates.png)
    parcel    realistic photographs
    essay     illustrated: watercolour and ink, picture book
    helpdesk  stylised 3D, soft clay-like
    reception comic-book ink with halftone dots (theory11 compcrime, 1 October 2026)
    easymoney flat vector illustration (theory12 cybercrime12)
    groupchat coloured pencil on paper (theory12 privacylaw)
    farewell  paper cut-out collage (theory12 datacollection)
    tuckshop  16-bit pixel art (sql dbcare)

Backgrounds are places with nobody in them (the same person cannot be drawn
twice the same); the people are the avatars. Everything is made up - no real
person, brand or logo.

    python make_art.py                 every picture not yet made
    python make_art.py pat             one story
    python make_art.py pat/karabo 7    redo one picture with seed 7
    python make_art.py --publish       (also done after each picture) write the
                                       page's .webp files into the platform

Needs ComfyUI on 127.0.0.1:8188 with Qwen-Image 2512, Qwen-Image-Edit 2511 and
their 4-step Lightning LoRAs (D:\\ComfyUIModels). Raw PNGs go to D:\\temp\\dilemma-art
(off C:, README rule 9); the page's copies to public/assets/dilemma/<story>/:
backgrounds 1280x720, avatars 320x320, WebP.
"""
import json
import sys
import time
import urllib.parse
import urllib.request
import uuid
from pathlib import Path

from PIL import Image

URL      = "http://127.0.0.1:8188"
RAW      = Path ("D:/temp/dilemma-art")
PLATFORM = Path (__file__).resolve ().parents[3] / "AIPascalCourse" / "public" / "assets" / "dilemma"
ANCHOR   = Path ("D:/DB Sync/Dropbox/Projects/Video/Music Videos/no single letters/cartoon/art/gates.png")

# ---- the looks ---------------------------------------------------------------

LOOKS = {
    "pat": ("Cartoon illustration in a caricature comic style: thick black ink outlines, bold cel-shaded flat "
            "colours, slightly exaggerated shapes, clean and bright, like a modern editorial cartoon."),
    "parcel": ("Realistic photograph, natural light, 35 mm lens, shallow depth of field, true-to-life colours, "
               "an ordinary South African home."),
    "essay": ("Watercolour and ink picture-book illustration: loose ink lines, soft washes of colour, textured "
              "paper, warm and gentle."),
    "helpdesk": ("Stylised 3D render: soft clay-like materials, rounded chunky shapes, warm studio lighting, "
                 "miniature diorama feel, pastel and saturated colours."),
    "reception": ("Comic-book illustration: bold black ink outlines, flat bright colours, halftone dot shading, "
                  "strong shadows and dramatic angles, like a panel from a printed comic."),
    "easymoney": ("Flat vector illustration: clean geometric shapes, no outlines, smooth flat colours with soft "
                  "gradients, a limited palette of teal, coral and mustard, like a modern editorial web illustration."),
    "groupchat": ("Coloured-pencil drawing on textured paper: soft hatched shading, visible pencil strokes, gentle "
                  "muted colours, calm and quiet."),
    "farewell": ("Paper cut-out collage: layers of coloured craft paper with cut and torn edges, soft shadows "
                 "between the layers, playful and handmade, like a paper diorama seen from the front."),
    "tuckshop": ("16-bit pixel art, like a scene from a retro video game: crisp square pixels, a limited bright "
                 "palette, clean dithering, no blur."),
}

AVATAR_CARTOON = ("in exactly the same caricature art style as the image: huge head, small body, thick black ink "
                  "outlines, cel-shaded colours. Head and shoulders, facing the viewer, centred, on a plain pure "
                  "white background. Mouth closed with a gentle smile. No logos or badges on the clothes. Nothing else in "
                  "the picture.")

AVATAR = {
    "parcel": ("Realistic head-and-shoulders portrait photograph, facing the camera, natural window light, "
               "softly blurred home interior behind, 85 mm lens."),
    "essay": ("Watercolour and ink picture-book portrait, head and shoulders, facing the viewer, centred, on "
              "plain cream paper. Loose ink lines, soft washes."),
    "helpdesk": ("Stylised 3D character render, soft clay-like, head and shoulders, facing the viewer, centred, "
                 "friendly, on a plain soft pastel blue background."),
    "reception": ("Comic-book portrait, head and shoulders, facing the viewer, centred, bold black ink outlines, "
                  "flat colours, halftone dot shading, on a plain pale yellow background."),
    "easymoney": ("Flat vector portrait, head and shoulders, facing the viewer, centred, clean geometric shapes, "
                  "no outlines, flat colours, on a plain soft teal background."),
    "groupchat": ("Coloured-pencil portrait on textured paper, head and shoulders, facing the viewer, centred, "
                  "soft hatched shading, on plain cream paper."),
    "farewell": ("Paper cut-out collage portrait made of layered coloured craft paper, head and shoulders, facing "
                 "the viewer, centred, soft shadows between the layers, on a plain pale pink paper background."),
    "tuckshop": ("16-bit pixel art portrait, head and shoulders, facing the viewer, centred, crisp square pixels, "
                 "a limited bright palette, on a plain light blue background."),
}

EMPTY = " Nobody in the picture. No text, no words, no logos, no brand names anywhere."

# ---- what to make: story -> name -> (kind, description) -----------------------

JOBS = {
    "pat": {
        "karabo": ("avatar", "Karabo, a 17-year-old Black South African boy, short neat hair, a grey school "
                             "hoodie, a determined look"),
        "naledi": ("avatar", "Naledi, a 17-year-old Black South African girl, long braids tied up, a navy school "
                             "jersey, a friendly confident smile"),
        "room-night": ("bg", "A teenager's small bedroom at night in a South African house: a desk with an open "
                             "laptop, a desk lamp glowing, school books, a flash drive, a mug, posters on the "
                             "wall, a window with the dark night outside."),
        "room-dawn": ("bg", "The same kind of small teenage bedroom at dawn: grey-blue early light through the "
                            "window, a laptop on the desk with its charger, a packed school bag by the door."),
        "candle": ("bg", "A dark bedroom during a power cut: one candle on the desk beside a closed laptop, a "
                         "phone torch, long shadows, everything else dark."),
        "interview": ("bg", "A high-school computer classroom in the morning: a teacher's desk with a laptop and "
                            "a marking sheet, two chairs facing each other, rows of computers behind."),
        "office": ("bg", "The corridor outside a school principal's office: a closed wooden door, two chairs "
                         "against the wall, a notice board, polished floor."),
        "gate": ("bg", "A South African high-school gate early in the morning: a palisade fence, a guard hut, "
                       "trees, a sunny sky."),
    },
    "parcel": {
        "lerato": ("avatar", "Lerato, a 15-year-old Black South African girl from Pretoria in a school uniform "
                             "(white shirt, maroon jersey), natural hair in a puff, a warm smile"),
        "sipho": ("avatar", "Sipho, a 15-year-old Black South African boy in a school uniform (white shirt, grey "
                            "jersey), short hair, looking worried"),
        "lounge": ("bg", "A lounge in a Pretoria suburban house in the afternoon: a couch with a school bag on "
                         "it, sunlight through the curtains, a coffee table with a glass of juice."),
        "bedroom": ("bg", "An empty teenage girl's bedroom in the evening, nobody in it: a neatly made bed with a duvet, a desk with textbooks, a "
                          "warm lamp, fairy lights, a window with the dusk outside."),
        "kitchen": ("bg", "A South African kitchen early in the morning: a table with a bowl of cereal and a mug "
                          "of tea, school shoes by the door, morning light."),
        "classroom": ("bg", "An empty South African high-school classroom: rows of desks and chairs, a "
                            "whiteboard, windows with burglar bars, afternoon light."),
        "doorstep": ("bg", "A cardboard delivery box waiting on the front step of a suburban house, a garden "
                           "gate behind, sunny afternoon."),
        "card": ("bg", "A bank card and a smartphone lying on a dark wooden table at night, dramatic low light, "
                       "the mood of something gone wrong."),
    },
    "essay": {
        "thabo": ("avatar", "Thabo, a 16-year-old Black South African boy, short hair, round glasses, a white "
                            "school shirt, a thoughtful look"),
        "naledi": ("avatar", "Naledi, a 16-year-old South African girl with shoulder-length curly hair, a school "
                             "blazer, looking a little desperate"),
        "desk-night": ("bg", "An empty study desk at night with an empty chair, nobody sitting there: an open laptop glowing, a desk lamp, piles of notes, "
                             "a cup of rooibos tea, a window with stars."),
        "ewaste": ("bg", "A huge mountain of old broken mobile phones, computer keyboards, monitors and cables "
                         "at a dump, a grey sky."),
        "morning": ("bg", "A South African school corridor in the morning: lockers, a bench, sunlight through "
                          "high windows."),
        "classroom": ("bg", "A teacher's desk in a classroom with a pile of marked essays, a red pen, a laptop, "
                            "a whiteboard behind."),
        "office": ("bg", "A school principal's office: a big desk, a chair in front of it, certificates on the "
                         "wall, a pot plant."),
    },
    "helpdesk": {
        "pillay": ("avatar", "Mrs Pillay, a South African Indian woman in her fifties, an accountant, reading "
                             "glasses on a chain, a colourful blouse, looking stressed"),
        "naidoo": ("avatar", "Mr Naidoo, a South African Indian man in his sixties, owner of a small accounting "
                             "firm, grey moustache, a white shirt and a tie"),
        "zanele": ("avatar", "Zanele, a young Black South African woman in her twenties, a new bookkeeper, a smart "
                             "blazer, a cheerful smile"),
        "printer": ("bg", "A small accounting office in Durban: desks with computers, filing cabinets, and an "
                          "office laser printer in front with an empty paper tray, a window with palm trees."),
        "screen": ("bg", "An office desk with a computer monitor glowing alarming red, a keyboard, a coffee mug, "
                         "papers, the rest of the office dim."),
        "server": ("bg", "A small server cupboard in an office: a rack with a server and a network switch with "
                         "blinking lights, a backup drive, cables."),
        "newdesk": ("bg", "A tidy new employee's desk in an office: a computer, a pot plant, a welcome mug, a "
                          "chair, morning light."),
        "evening": ("bg", "A small office at the end of a Friday: warm evening light, chairs pushed in, a "
                          "window with a sunset over Durban."),
        "dark": ("bg", "A dark empty office on a Sunday night: a server cupboard with one red warning light, "
                       "everything else in shadow."),
    },
    "reception": {
        "imraan": ("avatar", "Imraan, a 16-year-old South African boy with light brown skin, short dark hair and a "
                             "neat collared work shirt, alert and friendly"),
        "petersen": ("avatar", "Mrs Petersen, a South African office manager in her fifties with light brown skin, "
                               "short grey curly hair, reading glasses and a cardigan, kind but no-nonsense"),
        "lobby": ("bg", "The empty front desk of a small transport company's office in Gqeberha in the morning: a "
                        "reception counter with a desk phone and a visitors' book, a locked glass door with a card "
                        "reader leading to the offices, a pot plant, harbour cranes far away through the window."),
        "desk": ("bg", "Close-up of an empty reception counter: a desk phone, a computer screen, a mug of coffee, a "
                       "notepad and a pen, morning light."),
        "carpark": ("bg", "A small company's staff car park early in the morning, empty: a few parked cars, a "
                          "bicycle against a wall beside a back door, a small flash drive lying on the tarmac in "
                          "the front."),
        "accounts": ("bg", "An empty accounts office in the afternoon: a desk with a computer, a tray of invoices, "
                           "a calculator, a filing cabinet, sunlight through blinds."),
        "sales": ("bg", "An empty sales office: two desks with laptop chargers hanging loose where the laptops "
                        "used to be, an open door, papers on the floor."),
        "night": ("bg", "An empty office at night: one computer monitor glowing blue on a desk, everything else "
                        "dark, city lights through the window."),
        "server": ("bg", "A small server cupboard in an office: a rack with a server and a network switch, one red "
                         "warning light glowing, everything else in shadow."),
        "meeting": ("bg", "An empty small meeting room in the morning: chairs around a table, coffee mugs, a "
                          "whiteboard, sunlight through the window."),
    },
    "easymoney": {
        "lesedi": ("avatar", "Lesedi, a 17-year-old Black South African girl from Polokwane with short natural hair, "
                             "small earrings and a mustard-yellow jersey, a hopeful smile"),
        "neo": ("avatar", "Neo, a 17-year-old Black South African boy with a short fade haircut and a grey hoodie, a "
                          "cheeky grin"),
        "bedroom": ("bg", "An empty teenage girl's bedroom in the afternoon: a bed with a patterned duvet, a desk "
                          "with school books, a phone charging, a picture of a long dress pinned to the wall."),
        "lounge": ("bg", "An empty lounge in a Polokwane house on a Saturday morning: a couch with cushions, a "
                         "coffee table with a phone on it, sunlight through the curtains."),
        "desk": ("bg", "An empty study desk at night: an open laptop glowing, a desk lamp, school books and a "
                       "pencil case, a dark window."),
        "quad": ("bg", "An empty high-school quad at lunchtime: benches, a big tree, a corridor of classrooms, "
                       "bright sun."),
        "farewell": ("bg", "An empty school hall decorated for a matric farewell: fairy lights, round tables with "
                           "white cloths and flowers, a dance floor, balloons."),
        "police": ("bg", "The empty front counter of a South African police station: a counter with a bell and "
                         "forms, a bench against the wall, a notice board."),
        "principal": ("bg", "An empty school principal's office: a big wooden desk, two chairs in front of it, a "
                            "bookshelf, a pot plant."),
    },
    "groupchat": {
        "kayla": ("avatar", "Kayla, a 17-year-old white South African girl with long light-brown hair in a ponytail "
                            "and a navy school jersey, a thoughtful look"),
        "ofentse": ("avatar", "Ofentse, a 17-year-old Black South African boy with short hair and a white school "
                              "shirt, quiet and a little sad"),
        "bedroom": ("bg", "An empty teenage girl's bedroom at night: a bed with a phone lying on it, its screen "
                          "glowing, a bedside lamp, posters, a dark window."),
        "kitchen": ("bg", "An empty kitchen in a Bloemfontein house on a Saturday morning: a table with a bowl of "
                          "fruit and a mug of tea, sunlight through the window."),
        "gate": ("bg", "The gate of a South African high school early on a Monday morning, empty: a palisade "
                       "fence, the gate standing open, trees, long morning shadows."),
        "busstop": ("bg", "An empty bus stop on a suburban road in the afternoon: a shelter with a bench, a school "
                          "bag lying in the gutter, trees."),
        "classroom": ("bg", "An empty high-school classroom in the morning: rows of desks and chairs, a "
                            "whiteboard, sunlight through the windows."),
        "principal": ("bg", "An empty school principal's office: a desk, two chairs in front of it, a bookshelf, "
                            "a pot plant."),
        "corridor": ("bg", "An empty school corridor with lockers and notice boards, afternoon light."),
        "quad": ("bg", "An empty school quad on a sunny morning: benches under a tree, a green lawn, classrooms "
                       "around it."),
    },
    "farewell": {
        "tshepiso": ("avatar", "Tshepiso, a 17-year-old Black South African boy from Durban with short hair, "
                               "glasses and a white school shirt with a tie, a focused look"),
        "megan": ("avatar", "Megan, a 17-year-old white South African girl with curly red hair and a school "
                            "blazer, confident and full of plans"),
        "junaid": ("avatar", "Junaid, a South African photographer in his thirties of Indian descent, a short beard, "
                             "a camera strap over his shoulder, a salesman's smile"),
        "lab": ("bg", "An empty school computer lab after school: rows of computers, chairs pushed in, afternoon "
                      "sun through the windows."),
        "kitchen": ("bg", "An empty kitchen in a Durban flat early in the morning: an open laptop on the table, a "
                          "mug of tea, a bowl of cereal, morning light."),
        "committee": ("bg", "An empty classroom at lunchtime: a desk with a cash box, a pile of envelopes and a "
                            "laptop."),
        "hall": ("bg", "An empty school hall the morning after a matric farewell: fairy lights still up, balloons "
                       "on the floor, chairs stacked against the wall."),
        "office": ("bg", "An empty school principal's office: a big desk with a phone, two chairs in front of it, "
                         "a bookshelf."),
        "door": ("bg", "The empty entrance of a school hall at night, decorated for a farewell: a table with a "
                       "lamp and a ticket box, fairy lights round the doors."),
    },
    "tuckshop": {
        "amahle": ("avatar", "Amahle, a 16-year-old Black South African girl from Pietermaritzburg with braids and "
                             "a green school jersey, clever and determined"),
        "simphiwe": ("avatar", "Simphiwe, a 16-year-old Black South African boy with short hair and a white school "
                               "shirt, a mischievous grin"),
        "abrahams": ("avatar", "Mrs Abrahams, a South African woman in her fifties with light brown skin, a "
                               "headscarf and an apron, warm and busy"),
        "counter": ("bg", "An empty school tuck shop counter: shelves of chips and sweets, a fridge of cold drinks, "
                          "a tablet on a stand by the till."),
        "quad": ("bg", "An empty school quad at break on a sunny day: benches, the tuck shop's serving window, "
                       "trees."),
        "backroom": ("bg", "The small empty room behind a school tuck shop: a desk with an old computer and a "
                           "flash drive plugged into it, boxes of stock, a window with burglar bars."),
        "home": ("bg", "An empty teenager's desk at home on a Friday afternoon: an open laptop, a school bag, a "
                       "flash drive, a glass of juice."),
        "lab": ("bg", "An empty school computer lab at break: rows of computers, chairs pushed in, sunlight through "
                      "the windows."),
        "dark": ("bg", "A school tuck shop at night after a break-in: a broken window, an empty desk where a "
                       "computer stood, torch light and shadows."),
        "taxi": ("bg", "The inside of an empty South African minibus taxi: rows of seats, the sliding door, a small "
                       "flash drive lying on a seat."),
    },
}

# ---- ComfyUI --------------------------------------------------------------------


def _Post (path, data, headers=None):
    with urllib.request.urlopen (urllib.request.Request (URL + path, data=data, headers=headers or {})) as response:
        return json.loads (response.read ())


def _Get (path):
    with urllib.request.urlopen (URL + path) as response:
        return response.read ()


def Upload (path):
    """A local image into ComfyUI's input folder; returns its name there."""
    boundary = uuid.uuid4 ().hex
    body = (f"--{boundary}\r\nContent-Disposition: form-data; name=\"image\"; filename=\"dl_{path.name}\"\r\n"
            f"Content-Type: application/octet-stream\r\n\r\n").encode () + path.read_bytes () + \
           (f"\r\n--{boundary}\r\nContent-Disposition: form-data; name=\"overwrite\"\r\n\r\ntrue"
            f"\r\n--{boundary}--\r\n").encode ()
    return _Post ("/upload/image", body, {"Content-Type": f"multipart/form-data; boundary={boundary}"})["name"]


def TextToImage (prompt, width, height, seed):
    """Qwen-Image 2512, 4 Lightning steps."""
    return {
        "1": {"class_type": "UNETLoader", "inputs": {"unet_name": "qwen_image_2512_fp8_e4m3fn.safetensors", "weight_dtype": "default"}},
        "2": {"class_type": "CLIPLoader", "inputs": {"clip_name": "qwen_2.5_vl_7b_fp8_scaled.safetensors", "type": "qwen_image"}},
        "3": {"class_type": "VAELoader", "inputs": {"vae_name": "qwen_image_vae.safetensors"}},
        "4": {"class_type": "LoraLoaderModelOnly", "inputs": {"model": ["1", 0], "strength_model": 1.0,
              "lora_name": "Qwen\\Qwen-Image-2512-Lightning-4steps-V1.0-fp32.safetensors"}},
        "5": {"class_type": "ModelSamplingAuraFlow", "inputs": {"model": ["4", 0], "shift": 3.1}},
        "10": {"class_type": "CLIPTextEncode", "inputs": {"clip": ["2", 0], "text": prompt}},
        "11": {"class_type": "CLIPTextEncode", "inputs": {"clip": ["2", 0], "text": "text, words, letters, logo, watermark, blurry"}},
        "12": {"class_type": "EmptySD3LatentImage", "inputs": {"width": width, "height": height, "batch_size": 1}},
        "13": {"class_type": "KSampler", "inputs": {"model": ["5", 0], "seed": seed, "steps": 4, "cfg": 1.0,
               "sampler_name": "euler", "scheduler": "simple", "positive": ["10", 0], "negative": ["11", 0],
               "latent_image": ["12", 0], "denoise": 1.0}},
        "14": {"class_type": "VAEDecode", "inputs": {"samples": ["13", 0], "vae": ["3", 0]}},
        "15": {"class_type": "SaveImage", "inputs": {"images": ["14", 0], "filename_prefix": "dilemma/dl"}},
    }


def EditWithStyle (prompt, styleName, seed):
    """Qwen-Image-Edit 2511, 4 Lightning steps, one style reference - a new picture in its look."""
    return {
        "1": {"class_type": "UNETLoader", "inputs": {"unet_name": "qwen_image_edit_2511_bf16.safetensors", "weight_dtype": "fp8_e4m3fn"}},
        "2": {"class_type": "CLIPLoader", "inputs": {"clip_name": "qwen_2.5_vl_7b_fp8_scaled.safetensors", "type": "qwen_image"}},
        "3": {"class_type": "VAELoader", "inputs": {"vae_name": "qwen_image_vae.safetensors"}},
        "4": {"class_type": "LoraLoaderModelOnly", "inputs": {"model": ["1", 0], "strength_model": 1.0,
              "lora_name": "Qwen\\Qwen-Image-Edit-2511-Lightning-4steps-V1.0-bf16.safetensors"}},
        "5": {"class_type": "ModelSamplingAuraFlow", "inputs": {"model": ["4", 0], "shift": 3.0}},
        "6": {"class_type": "CFGNorm", "inputs": {"model": ["5", 0], "strength": 1.0}},
        "20": {"class_type": "LoadImage", "inputs": {"image": styleName}},
        "30": {"class_type": "ImageScaleToTotalPixels", "inputs": {"image": ["20", 0], "upscale_method": "lanczos",
               "megapixels": 1.0, "resolution_steps": 1}},
        "10": {"class_type": "TextEncodeQwenImageEditPlus", "inputs": {"clip": ["2", 0], "vae": ["3", 0], "image1": ["30", 0], "prompt": prompt}},
        "11": {"class_type": "TextEncodeQwenImageEditPlus", "inputs": {"clip": ["2", 0], "vae": ["3", 0], "image1": ["30", 0], "prompt": ""}},
        "12": {"class_type": "EmptySD3LatentImage", "inputs": {"width": 1024, "height": 1024, "batch_size": 1}},
        "13": {"class_type": "KSampler", "inputs": {"model": ["6", 0], "seed": seed, "steps": 4, "cfg": 1.0,
               "sampler_name": "euler", "scheduler": "simple", "positive": ["10", 0], "negative": ["11", 0],
               "latent_image": ["12", 0], "denoise": 1.0}},
        "14": {"class_type": "VAEDecode", "inputs": {"samples": ["13", 0], "vae": ["3", 0]}},
        "15": {"class_type": "SaveImage", "inputs": {"images": ["14", 0], "filename_prefix": "dilemma/dl"}},
    }


def Run (graph, destination, timeout=1800):
    """Queue a graph, wait, save its first image."""
    promptId = _Post ("/prompt", json.dumps ({"prompt": graph, "client_id": "dilemma"}).encode (),
                      {"Content-Type": "application/json"})["prompt_id"]
    started = time.time ()

    while time.time () - started < timeout:
        history = json.loads (_Get (f"/history/{promptId}"))
        if promptId in history:
            status = history[promptId].get ("status", {})
            if status.get ("status_str") == "error":
                raise RuntimeError (json.dumps (status)[:2000])
            for node in history[promptId]["outputs"].values ():
                for image in node.get ("images", []):
                    query = urllib.parse.urlencode ({"filename": image["filename"], "subfolder": image["subfolder"], "type": image["type"]})
                    destination.parent.mkdir (parents=True, exist_ok=True)
                    destination.write_bytes (_Get (f"/view?{query}"))
                    return time.time () - started
        time.sleep (1)

    raise TimeoutError (promptId)

# ---- making and publishing --------------------------------------------------------


def Publish (story, name, kind):
    """The page's copy: a 1280x720 background or a 320x320 avatar, WebP."""
    source = Image.open (RAW / story / f"{name}.png").convert ("RGB")
    size   = (1280, 720) if kind == "bg" else (320, 320)
    scale  = max (size[0] / source.width, size[1] / source.height)
    source = source.resize ((round (source.width * scale), round (source.height * scale)), Image.LANCZOS)
    left, top = (source.width - size[0]) // 2, (source.height - size[1]) // 2
    target = PLATFORM / story / f"{name}.webp"
    target.parent.mkdir (parents=True, exist_ok=True)
    source.crop ((left, top, left + size[0], top + size[1])).save (target, "WEBP", quality=(76 if kind == "bg" else 82), method=6)
    return target


def Make (story, name, seed=3):
    kind, description = JOBS[story][name]

    if kind == "avatar" and story == "pat":
        graph = EditWithStyle (f"Draw {description}. {AVATAR_CARTOON}", Upload (ANCHOR), seed)
    elif kind == "avatar":
        graph = TextToImage (f"{description}. {AVATAR[story]} No text, no logos.", 1024, 1024, seed)
    else:
        graph = TextToImage (f"{description} {LOOKS[story]}{EMPTY}", 1664, 928, seed)

    seconds = Run (graph, RAW / story / f"{name}.png")
    target  = Publish (story, name, kind)
    print (f"{story}/{name}: {seconds:.0f}s -> {target.name} {target.stat ().st_size // 1024} KB", flush=True)


if __name__ == "__main__":
    arguments = sys.argv[1:]

    if arguments[:1] == ["--publish"]:
        for story, jobs in JOBS.items ():
            for name, (kind, _) in jobs.items ():
                if (RAW / story / f"{name}.png").exists ():
                    Publish (story, name, kind)
    elif arguments and "/" in arguments[0]:
        story, name = arguments[0].split ("/")
        Make (story, name, int (arguments[1]) if len (arguments) > 1 else 3)
    else:
        for story, jobs in JOBS.items ():
            if arguments and story != arguments[0]:
                continue
            for name in jobs:
                if not (RAW / story / f"{name}.png").exists ():
                    Make (story, name)
