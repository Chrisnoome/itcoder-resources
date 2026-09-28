"""Pictures for the branching dilemmas (lib/dilemma.php), made with the local ComfyUI.

Chris, 28 September 2026: dilemmas get scene backgrounds, character avatars,
phone and chat screens and pop-up screens (the screens are drawn by the page,
not here); "realistic, cartoon a la no single letters characters, stylized,
illustrated - mix it up for variety". One look per story, so a story hangs
together and the four stories differ:

    pat       cartoon, the No Single Letters caricature style (Qwen-Image-Edit 2511,
              styled on the video's art/gates.png)
    parcel    realistic photographs
    essay     illustrated: watercolour and ink, picture book
    helpdesk  stylised 3D, soft clay-like

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
