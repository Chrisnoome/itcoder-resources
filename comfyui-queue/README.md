# The ComfyUI queue - art every chat needs

Chris, 1 October 2026: "we need a general comfyui queue that all chats can add
their requirements to". **Any chat that needs pictures from the local ComfyUI
adds a request here instead of making them.** One runner works through the
queue when Chris says the GPU is ready, and Chris picks the results.

**Why:** the GPU is a laptop RTX 3080 Ti that needs a cooler for long runs
(Chris, 1 October 2026: "wait till i get home with a cooler for the gpu"),
and several chats need art at once. One queue means one long run, nothing
made twice, and Chris sees every picture before it goes on the site.

## Adding a request

Add one JSON file to `requests/`, named `<yyyy-mm-dd>-<slug>.json`. Never edit
another chat's request, except to set its `status` after a run. Two kinds:

**Pictures** (`"kind": "items"`) - the runner makes them:

```json
{
  "id": "2026-10-01-course-icons",
  "from": "the platform chat (home page)",
  "added": "2026-10-01",
  "status": "waiting",
  "why": "What it is for, where it shows, who asked (quote Chris).",
  "style": "The house look, put after each item's prompt.",
  "size": [1024, 1024],
  "variants": 3,
  "items": [
    {
      "name": "pascal",
      "prompt": "One object or scene, no text.",
      "out": "AIPascalCourse/public/assets/course-art/pascal.png",
      "outSize": [256, 256],
      "transparent": true
    }
  ]
}
```

- `out` is relative to `Dropbox/Projects`; `.png` or `.webp`. The site code
  must already show a stand-in until the file exists (and use the file when
  it does), so nothing waits on the GPU.
- `style` and `size` can be set per item too. `seed` (per item) is the first
  seed; the runner makes `variants` pictures with seeds after it.
- Prompts: one thing per picture, and **no text, letters, logos or real
  people** - Qwen-Image draws text badly and the site must not carry brands.

**A script** (`"kind": "script"`) - a chat's own art script, run as it is:

```json
{ "id": "...", "kind": "script", "status": "waiting", "command": "python tools/badge-art/make_badges.py",
  "cwd": "AIResources", "minutes": 90, "why": "..." }
```

## Statuses

`waiting` -> `made` (pictures made, waiting for Chris to pick) -> `done`
(picked and copied to `out`). `script` requests go `waiting` -> `done`.
`parked` means Chris stopped it; leave it alone.

## Running it (only when Chris says the GPU is ready)

ComfyUI: `D:\ComfyUI App\RLComfyUI\run_nvidia_gpu.bat` (port 8188), models
in `D:\ComfyUIModels`. Then, from `AIResources`:

```
python tools/comfy-queue/run.py              list the queue (makes nothing)
python tools/comfy-queue/run.py --go         run everything waiting
python tools/comfy-queue/run.py --go <id>    run one request
python tools/comfy-queue/run.py --pick <id> <name> <seed>   copy Chris's choice to `out`
```

`--go` makes `variants` pictures per item in `D:\temp\comfy-queue\<id>\`
(off C:, README rule 9) and writes `review.html` there for Chris to choose
from; `--pick` copies the chosen one to `out` (resized, background made
transparent when asked). A request is `done` when every item is picked; then
commit the files in the project they went to.

The runner uses `tools/dilemma-art/make_art.py`'s ComfyUI client (Qwen-Image
2512, 4 Lightning steps, about 10 seconds a picture at 1024 x 1024) and
`tools/badge-art/make_badges.py`'s transparent background.
