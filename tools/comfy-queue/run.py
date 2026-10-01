"""The ComfyUI queue's runner (AIResources/comfyui-queue/README.md).

Chris, 1 October 2026: one queue that every chat adds its picture requests
to, run when the GPU is ready. Run it only when Chris says so (the laptop GPU
needs its cooler), with ComfyUI started on port 8188.

    python run.py                         list the queue - makes nothing
    python run.py --go                    run every waiting request
    python run.py --go <id>               run one request
    python run.py --pick <id> <name> <seed>   copy Chris's choice to the item's `out`

Pictures go to D:\\temp\\comfy-queue\\<id>\\<name>-s<seed>.png with a review.html
beside them. Uses ../dilemma-art/make_art.py's ComfyUI client and
../badge-art/make_badges.py's transparent background.
"""
import html
import json
import os
import subprocess
import sys
import urllib.request
from pathlib import Path

from PIL import Image

TOOLS    = Path (__file__).resolve ().parent.parent
QUEUE    = TOOLS.parent / "comfyui-queue" / "requests"
PROJECTS = TOOLS.parents[1]                 # Dropbox/Projects - every `out` is relative to it
RAW      = Path ("D:/temp/comfy-queue")     # off C: (README rule 9)
COMFY    = os.environ.get ("COMFY_URL", "http://127.0.0.1:8188")   # ComfyUI Desktop may use another port (8189, 1 Oct 2026)

sys.path.insert (0, str (TOOLS / "dilemma-art"))
sys.path.insert (0, str (TOOLS / "badge-art"))


def Requests ():
    """Every request file, oldest first: [(path, request), ...]."""
    return [(path, json.loads (path.read_text (encoding="utf-8"))) for path in sorted (QUEUE.glob ("*.json"))]


def Save (path, request):
    path.write_text (json.dumps (request, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")


def ComfyIsUp ():
    try:
        urllib.request.urlopen (COMFY + "/system_stats", timeout=3).read ()
        return True
    except OSError:
        return False


def Seeds (request, item):
    first = int (item.get ("seed", 1))
    return range (first, first + int (item.get ("variants", request.get ("variants", 3))))


def Review (request):
    """A page of every variant, for Chris to choose from."""
    folder = RAW / request["id"]
    rows = []
    for item in request["items"]:
        cells = "".join (f'<figure><img src="{html.escape (item["name"])}-s{seed}.png"><figcaption>--pick {html.escape (request["id"])} '
                         f'{html.escape (item["name"])} {seed}</figcaption></figure>' for seed in Seeds (request, item)
                         if (folder / f'{item["name"]}-s{seed}.png').is_file ())
        rows.append (f'<h2>{html.escape (item["name"])}</h2><p>{html.escape (item["prompt"])}</p><div>{cells}</div>')
    page = ('<!doctype html><meta charset="utf-8"><title>' + html.escape (request["id"]) + '</title><style>'
            'body{font:15px system-ui;margin:24px;background:#f4f6f7}div{display:flex;gap:12px;flex-wrap:wrap}'
            'figure{margin:0;background:#fff;padding:8px;border-radius:10px}img{width:240px;height:240px;object-fit:contain;'
            'background:repeating-conic-gradient(#eee 0 25%,#fff 0 50%) 0 0/20px 20px}figcaption{font:12px monospace}</style>'
            f'<h1>{html.escape (request["id"])}</h1><p>{html.escape (request.get ("why", ""))}</p>' + "".join (rows))
    (folder / "review.html").write_text (page, encoding="utf-8")
    return folder / "review.html"


def RunItems (path, request):
    from make_art import TextToImage, Run   # noqa: E402 - only when making pictures

    folder = RAW / request["id"]
    for item in request["items"]:
        style = item.get ("style", request.get ("style", ""))
        width, height = item.get ("size", request.get ("size", [1024, 1024]))
        prompt = (item["prompt"].rstrip (". ") + ". " + style).strip ()
        for seed in Seeds (request, item):
            raw = folder / f'{item["name"]}-s{seed}.png'
            if raw.is_file ():
                continue
            seconds = Run (TextToImage (prompt, width, height, seed), raw)
            print (f'  {item["name"]} seed {seed}: {seconds:.0f} s')
    request["status"] = "made"
    Save (path, request)
    print ("  review:", Review (request))


def RunScript (path, request):
    cwd = PROJECTS / request.get ("cwd", "AIResources")
    print ("  running:", request["command"], "in", cwd)
    # "python ..." runs with this same interpreter (it has Pillow), not whichever python is first on the PATH.
    command = request["command"].replace ("python ", '"' + sys.executable + '" -X utf8 ')
    subprocess.run (command, shell=True, cwd=cwd, check=True)
    request["status"] = "done"
    Save (path, request)


def Pick (requestId, name, seed):
    from make_badges import Transparent     # noqa: E402

    for path, request in Requests ():
        if request["id"] != requestId:
            continue
        item = next (i for i in request["items"] if i["name"] == name)
        image = Image.open (RAW / requestId / f"{name}-s{seed}.png")
        if item.get ("transparent"):
            image = Transparent (image)
        if "outSize" in item:
            image = image.resize (tuple (item["outSize"]), Image.LANCZOS)
        out = PROJECTS / item["out"]
        out.parent.mkdir (parents=True, exist_ok=True)
        image.save (out, quality=90) if out.suffix == ".webp" else image.save (out)
        item["picked"] = int (seed)
        if all ("picked" in i for i in request["items"]):
            request["status"] = "done"
        Save (path, request)
        print (f"{name}: seed {seed} -> {out}")
        return
    sys.exit (f"No request {requestId}")


def Main ():
    args = sys.argv[1:]

    if args[:1] == ["--pick"]:
        Pick (args[1], args[2], args[3])
        return

    if args[:1] != ["--go"]:
        for _, request in Requests ():
            size = (f'{sum (len (Seeds (request, i)) for i in request["items"])} pictures'
                    if request.get ("kind", "items") == "items" else f'~{request.get ("minutes", "?")} min script')
            print (f'{request["status"]:8} {request["id"]:36} {size:16} {request.get ("from", "")}')
        print ("\nNothing made. --go runs what is waiting - only when Chris says the GPU is ready.")
        return

    if not ComfyIsUp ():
        sys.exit ("ComfyUI is not answering at " + COMFY + " - start it first (set COMFY_URL if it is on another port).")

    only = args[1] if len (args) > 1 else None
    for path, request in Requests ():
        if request["status"] != "waiting" or (only and request["id"] != only):
            continue
        print (request["id"])
        if request.get ("kind", "items") == "script":
            RunScript (path, request)
        else:
            RunItems (path, request)


if __name__ == "__main__":
    Main ()
