# Grade 9 SQL (the rhino case) art style: the ops room, coloured pencil and Oxi

Chris, 9 October 2026, from the board (https://claude.ai/artifact/SwqRT3UQ7giz4bxHjd6Czo,
source `brand/sql9-art-board.html`): **"b - but have more realistic coloured pencil sketches of
scenes, landscape, animals, etc."**, mascot **"ox - but more realistic drawings"**.

Two layers, each used where it is strongest:

## 1. The ops room - for data (SVG, drawn by the chats)

Everything that is data - tables, query results, queries, maps, the evidence board - is drawn
as the reserve's anti-poaching control room:

- **Ground:** dark bush green `#16201a`, a faint grid `#24342a`.
- **Data:** terminal green `#9fe870` in **IBM Plex Mono**; headers in a dimmer `#5fae5a`. The
  row or value that matters is an **amber bar** `#f2b33d` with dark text - one per figure.
- **Queries** are shown as typed at a prompt (`> SELECT ...`), with the row count and time
  under the result ("5 rows · 0.002 s"), like the SQL runner.
- **Maps:** contour lines `#3f6b48`, zones labelled (K7, C3), a pulsing amber pin for the place
  in question. Alerts in amber capitals ("! COLLAR R02 SILENT 72 H").
- Keep text at least 12 px at 680 wide; dark screens must stay readable when projected.

## 2. Coloured pencil - for the world (ComfyUI, queued)

Scenes, landscapes, animals and people are **realistic coloured-pencil drawings** on warm
paper: visible pencil strokes, natural colours, Limpopo bushveld light. Made by the ComfyUI
queue (`comfyui-queue/requests/2026-10-09-sql9-scenes.json`), never hand-coded SVG. No text in
the pictures; no blood, no carcasses, no weapons pointed at animals - the story never shows
harm. Until a picture exists the lesson shows the ops-room figure alone.

They sit in a `Figure()` beside or above the ops-room screen of the same moment (the waterhole
drawing beside the sightings query, the gate at night beside the gate log), or as the lesson's
opening picture.

## Oxi

**A red-billed oxpecker, drawn realistically in coloured pencil**: brown back, buff belly,
bright red bill, yellow eye-ring - the real bird. Oxpeckers ride on rhinos and give an alarm
call when danger comes, so Oxi is the course's lookout: in the margin doodles (one-line
captions, as in content-voice-and-pedagogy.md §5b), now and then in a figure pointing at the
clue. Poses: perched on Tumelo, calling an alarm (bill open), peering at a screen, flying with
a note. Ranger **Thandeka** (head ranger) appears in the story, drawn the same way.

## Fonts

IBM Plex Mono (data), Alfa Slab One (lesson openers and big numbers, sparingly), the platform's
own body font for prose.
