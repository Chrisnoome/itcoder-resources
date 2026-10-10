"""Draws the Station Kestrel pixel art (brand/pascal9-art-style.md).

Every picture is SVG <rect>s on a small pixel grid, shape-rendering crispEdges,
in the 16-colour palette only. Sprites are character grids (one character per
pixel, PALETTE keys below); scenes are built from rects. Writes
AIPascalCourse/public/assets/doodles/kestrel-*.svg.

  python -X utf8 tools/pascal9/make_art.py
"""
import os, math, random

OUT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'

SPACE, BLACK, NAVY, VIOLET = '#1d1832', '#000000', '#29366f', '#83769c'
GREY, LIGHT, WHITE = '#5f574f', '#c2c3c7', '#fff1e8'
RED, ORANGE, YELLOW = '#ff004d', '#ffa300', '#ffec27'
GREEN, DARKGREEN, BLUE, PINK = '#00e436', '#008751', '#29adff', '#ff77a8'
BROWN, PEACH = '#ab5236', '#ffccaa'
TITLE = "'Press Start 2P', monospace"
TEXT = "'VT323', monospace"

PALETTE = {'k': BLACK, 'n': NAVY, 'v': VIOLET, 'g': GREY, 'l': LIGHT, 'w': WHITE, 'r': RED, 'o': ORANGE,
           'y': YELLOW, 'G': GREEN, 'd': DARKGREEN, 'b': BLUE, 'p': PINK, 'B': BROWN, 'P': PEACH, 's': SPACE}


class Pic:
    """One picture: rects in pixel units, merged into runs as they are added."""

    def __init__(self, width, height, label):
        self.width, self.height, self.label = width, height, label
        self.parts = []

    def rect(self, x, y, w, h, colour, extra=''):
        self.parts.append(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{colour}"{extra}/>')

    def px(self, x, y, colour):
        self.rect(x, y, 1, 1, colour)

    def sprite(self, x, y, rows, swap=None, scale=1):
        """Draws a character grid; '.' is see-through. swap maps characters to other colours."""
        swap = swap or {}
        for row_index, row in enumerate(rows):
            col = 0
            while col < len(row):
                ch = row[col]
                if ch == '.':
                    col += 1
                    continue
                run = 1
                while col + run < len(row) and row[col + run] == ch:
                    run += 1
                colour = swap.get(ch, PALETTE.get(ch, ch))
                self.rect(x + col * scale, y + row_index * scale, run * scale, scale, colour)
                col += run

    def text(self, x, y, words, colour, size, font=TITLE, anchor='start'):
        words = words.replace('&', '&amp;').replace('<', '&lt;')
        self.parts.append(f'<text x="{x}" y="{y}" fill="{colour}" font-family="{font}" font-size="{size}" '
                          f'text-anchor="{anchor}">{words}</text>')

    def raw(self, svg):
        self.parts.append(svg)

    def save(self, name):
        svg = (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.width} {self.height}" '
               f'shape-rendering="crispEdges" role="img" aria-label="{self.label}">'
               + ''.join(self.parts) + '</svg>\n')
        with open(os.path.join(OUT, 'kestrel-' + name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(svg)
        print('kestrel-' + name + '.svg', len(svg), 'bytes')


def stars(pic, count, seed, top=0, bottom=None):
    rng = random.Random(seed)
    bottom = bottom or pic.height
    for _ in range(count):
        colour = rng.choice([WHITE, WHITE, LIGHT, VIOLET, YELLOW])
        pic.px(rng.randrange(pic.width), rng.randrange(top, bottom), colour)


def earth(pic, cx, cy, radius):
    """A stepped pixel Earth: blue sea, green land, white cloud bands."""
    rng = random.Random(7)
    for y in range(max(0, cy - radius), min(pic.height, cy + radius)):
        half = int(math.sqrt(max(0, radius * radius - (y - cy + 0.5) ** 2)))
        if half <= 0:
            continue
        pic.rect(cx - half, y, half * 2, 1, BLUE)
    for _ in range(int(radius * 1.2)):
        x, y = rng.randrange(cx - radius, cx + radius), rng.randrange(cy - radius, cy + radius)
        if (x - cx) ** 2 + (y - cy) ** 2 < (radius - 3) ** 2 and 0 <= y < pic.height:
            pic.rect(x, y, rng.choice([3, 4, 6]), 2, DARKGREEN)
    for y in range(max(0, cy - radius + 2), min(pic.height, cy + radius), 5):
        half = int(math.sqrt(max(0, radius * radius - (y - cy + 0.5) ** 2)))
        if half > 4:
            start = cx - half + rng.randrange(0, max(1, half))
            pic.rect(start, y, rng.randrange(4, 12), 1, WHITE)


BOLT = [
    "..ggg......ggg..",
    "...g........g...",
    "...g..wwww..g...",
    "...gwlllllllg...",
    "....lllllllll...",
    "...llkkkkkkll...",
    "...llkEEEEkll...",
    "...llkEyEEkll...",
    "...llkEEEEkll...",
    "...llkkkkkkll...",
    "....lllllllll...",
    ".....lllllll....",
    "......gggg......",
    ".......gg.......",
]


def bolt(pic, x, y, eye, scale=1):
    pic.sprite(x, y, BOLT, {'E': eye, 'y': WHITE}, scale)


CREW_SPRITE = [
    "..HHHH..",
    ".HHHHHH.",
    ".HSSSSH.",
    ".SkSSkS.",
    "..SSSS..",
    "...SS...",
    ".UUUUUU.",
    "UUUDDUUU",
    "U.UUUU.U",
    "S.UUUU.S",
    "..UUUU..",
    "..U..U..",
    "..k..k..",
]
CREW = [  # name, job, skin, hair, suit, detail
    ('Naledi', 'commander', BROWN, BLACK, NAVY, YELLOW),
    ('Pieter', 'engineer', PEACH, BROWN, ORANGE, GREY),
    ('Aisha', 'medic', BROWN, BLACK, WHITE, RED),
    ('Sipho', 'botanist', BROWN, BLACK, DARKGREEN, GREEN),
    ('Lena', 'pilot', PEACH, YELLOW, BLUE, WHITE),
    ('Kenji', 'scientist', PEACH, BLACK, VIOLET, PINK),
]


def crew_member(pic, x, y, member, scale=1):
    _, _, skin, hair, suit, detail = member
    pic.sprite(x, y, CREW_SPRITE, {'H': hair, 'S': skin, 'U': suit, 'D': detail}, scale)


def station(pic, x, y, lights=GREEN):
    """The station, 96 x 34 pixels, its top-left at x, y."""
    # Solar panels, two each side
    for panel_x in (x, x + 14, x + 68, x + 82):
        pic.rect(panel_x, y + 4, 12, 26, NAVY)
        for cell_y in range(y + 5, y + 29, 4):
            pic.rect(panel_x + 1, cell_y, 4, 3, BLUE)
            pic.rect(panel_x + 6, cell_y, 5, 3, BLUE)
    # The truss
    pic.rect(x + 12, y + 16, 72, 2, LIGHT)
    for truss_x in range(x + 12, x + 84, 4):
        pic.px(truss_x, y + 15, GREY)
        pic.px(truss_x + 2, y + 18, GREY)
    # Modules
    pic.rect(x + 30, y + 11, 36, 12, LIGHT)
    pic.rect(x + 30, y + 11, 36, 1, WHITE)
    pic.rect(x + 30, y + 22, 36, 1, GREY)
    pic.rect(x + 42, y + 5, 12, 6, LIGHT)
    pic.rect(x + 43, y + 3, 10, 2, WHITE)
    pic.rect(x + 66, y + 14, 6, 6, LIGHT)
    pic.rect(x + 72, y + 15, 2, 4, GREY)
    # Windows and lights
    for window_x in range(x + 33, x + 64, 5):
        pic.rect(window_x, y + 15, 2, 2, YELLOW)
    pic.px(x + 47, y + 7, lights)
    pic.px(x + 48, y + 7, lights)
    pic.text(x + 48, y + 21, 'KS-1', NAVY, 4, TITLE, 'middle')


def draw_station_scene():
    pic = Pic(200, 112, 'Station Kestrel in orbit above the Earth')
    pic.rect(0, 0, 200, 112, SPACE)
    stars(pic, 70, 1)
    earth(pic, 100, 190, 110)
    station(pic, 52, 22, ORANGE)
    bolt(pic, 150, 34, ORANGE)
    pic.text(8, 12, 'STATION KESTREL', WHITE, 6)
    pic.text(8, 20, '412 KM UP - CREW OF 6', LIGHT, 7, TEXT)
    pic.save('station')


def draw_ground():
    pic = Pic(200, 112, 'The dish at Hartebeesthoek ground station, sending a signal up at night')
    pic.rect(0, 0, 200, 112, SPACE)
    stars(pic, 50, 2, 0, 70)
    # Hills
    for x in range(200):
        height = int(14 + 6 * math.sin(x / 23) + 4 * math.sin(x / 9))
        pic.rect(x, 112 - height, 1, height, DARKGREEN)
    pic.rect(0, 104, 200, 8, '#065e3d' if False else DARKGREEN)
    # The dish: a tilted bowl (pixels inside a rotated ellipse), its inside in shadow, on a stand
    cx, cy = 70, 58
    angle = math.radians(-35)
    for y in range(cy - 22, cy + 22):
        for x in range(cx - 26, cx + 26):
            dx, dy = x + 0.5 - cx, y + 0.5 - cy
            u = dx * math.cos(angle) - dy * math.sin(angle)
            v = dx * math.sin(angle) + dy * math.cos(angle)
            if (u / 22) ** 2 + (v / 8) ** 2 <= 1:
                inner = (u / 19) ** 2 + ((v + 2.5) / 5.5) ** 2 <= 1
                pic.px(x, y, GREY if inner else LIGHT)
    pic.rect(cx - 3, cy + 6, 6, 19, GREY)
    pic.rect(cx - 10, cy + 25, 20, 4, GREY)
    # The feed sticking out of the bowl, towards the sky
    for step in range(12):
        pic.rect(cx + int(step * 0.57), cy - int(step * 0.82), 2, 1, LIGHT)
    pic.rect(cx + 6, cy - 12, 3, 3, RED)
    # The signal going up
    for step, (sx, sy) in enumerate([(84, 34), (98, 24), (112, 14), (126, 4)]):
        pic.rect(sx, sy + 4, 6, 1, YELLOW)
        pic.rect(sx + 2, sy + 2, 6, 1, YELLOW)
        pic.rect(sx + 4, sy, 6, 1, YELLOW)
    # A small building with a lit window
    pic.rect(120, 82, 34, 18, LIGHT)
    pic.rect(118, 80, 38, 3, GREY)
    pic.rect(126, 87, 6, 5, YELLOW)
    pic.rect(140, 87, 6, 5, YELLOW)
    pic.text(8, 12, 'HARTEBEESTHOEK', WHITE, 6)
    pic.text(8, 20, 'GROUND STATION, GAUTENG', LIGHT, 7, TEXT)
    pic.save('ground')


def draw_bolts():
    for name, eye, caption in [('bolt', ORANGE, 'Bolt, eye-light amber'), ('bolt-green', GREEN, 'Bolt, eye-light green'),
                               ('bolt-red', RED, 'Bolt, eye-light red')]:
        pic = Pic(20, 18, caption)
        bolt(pic, 2, 2, eye)
        pic.save(name)
    pic = Pic(24, 18, 'Bolt, puzzled')
    bolt(pic, 2, 3, ORANGE)
    pic.sprite(18, 0, [".yyy.", "y...y", "...y.", "..y..", ".....", "..y.."])
    pic.save('bolt-puzzled')
    pic = Pic(28, 20, 'Bolt, celebrating')
    bolt(pic, 6, 4, GREEN)
    for sx, sy, colour in [(1, 2, YELLOW), (24, 3, PINK), (3, 14, BLUE), (25, 13, YELLOW), (14, 0, GREEN)]:
        pic.sprite(sx, sy, [".c.", "ccc", ".c."], {'c': colour})
    pic.save('bolt-happy')


def draw_crew():
    pic = Pic(200, 64, 'The six crew of Station Kestrel')
    pic.rect(0, 0, 200, 64, SPACE)
    stars(pic, 20, 3)
    pic.rect(0, 46, 200, 2, GREY)
    for index, member in enumerate(CREW):
        x = 8 + index * 32
        crew_member(pic, x + 4, 10, member, 2)
        pic.text(x + 12, 56, member[0], WHITE, 8, TEXT, 'middle')
        pic.text(x + 12, 63, member[1], LIGHT, 7, TEXT, 'middle')
    pic.save('crew')


def draw_lockers():
    pic = Pic(200, 80, 'Three lockers, each with a name on the door and one thing inside')
    pic.rect(0, 0, 200, 80, NAVY)
    lockers = [('crewName', "'Naledi'", 'String'), ('job', "'commander'", 'String'), ('crew', '6', 'Integer')]
    for index, (label, value, kind) in enumerate(lockers):
        x = 10 + index * 64
        pic.rect(x, 10, 56, 62, LIGHT)
        pic.rect(x + 2, 12, 52, 58, GREY)
        pic.rect(x + 4, 14, 48, 10, WHITE)
        pic.text(x + 28, 22, label, BLACK, 9, TEXT, 'middle')
        pic.rect(x + 6, 30, 44, 26, BLACK)
        pic.text(x + 28, 46, value, YELLOW, 9, TEXT, 'middle')
        pic.text(x + 28, 66, kind, WHITE, 7, TEXT, 'middle')
        pic.rect(x + 48, 58, 3, 6, YELLOW)
    bolt(pic, 182, 60, ORANGE)
    pic.save('lockers')


def ship(pic, x, y, flame=True):
    """The supply ship Impala, 34 x 14, pointing left."""
    pic.sprite(x, y, [
        "......wwwwwwwwwwwwwwwwwwwww.......",
        "....wwwwwwwwwwwwwwwwwwwwwwwwg.....",
        "..wwwwbbwwwwwwwwwwwwwwwwwwwwggg...",
        ".wwwwwbbwwoooooooooooooooowwgggg..",
        "lwwwwwwwwwoooooooooooooooowwggggg.",
        "lwwwwwwwwwwwwwwwwwwwwwwwwwwwggggg.",
        ".wwwwwwwwwwwwwwwwwwwwwwwwwwwgggg..",
        "..wwwwwwwwwwwwwwwwwwwwwwwwwwggg...",
        "....wwwwwwwwwwwwwwwwwwwwwwwwg.....",
        "......wwwwwwwwwwwwwwwwwwwww.......",
    ])
    if flame:
        pic.sprite(x + 34, y + 2, ["oy..", "oyyr", "oyyy", "oyyr", "oy.."])


def draw_ship():
    pic = Pic(200, 90, 'The supply ship Impala closing in on the station')
    pic.rect(0, 0, 200, 90, SPACE)
    stars(pic, 45, 4)
    station(pic, 4, 30, ORANGE)
    ship(pic, 140, 40)
    for dash_x in range(108, 136, 6):
        pic.rect(dash_x, 46, 3, 1, YELLOW)
    pic.text(140, 34, 'IMPALA', WHITE, 5)
    pic.text(118, 62, '1500 m', YELLOW, 8, TEXT)
    pic.save('ship')


def draw_airlock(state='locked'):
    pic = Pic(200, 96, 'The airlock door, its pressure gauge and its warning light')
    pic.rect(0, 0, 200, 96, NAVY)
    pic.rect(0, 84, 200, 12, GREY)
    # Door frame and door
    pic.rect(50, 10, 64, 74, LIGHT)
    pic.rect(54, 14, 56, 70, GREY)
    pic.rect(56, 16, 52, 68, LIGHT)
    pic.rect(81, 16, 2, 68, GREY)
    for hazard_x in range(56, 108, 8):
        pic.rect(hazard_x, 76, 4, 6, YELLOW)
        pic.rect(hazard_x + 4, 76, 4, 6, BLACK)
    # Round window
    for row in range(12):
        half = int(math.sqrt(36 - (row - 5.5) ** 2) + 0.5)
        pic.rect(82 - half, 30 + row, half * 2, 1, BLACK)
    pic.rect(79, 33, 2, 2, WHITE)
    # Light above the door
    light = RED if state == 'locked' else GREEN
    pic.rect(76, 4, 12, 5, light)
    pic.rect(78, 2, 8, 2, light)
    # Gauge to the right
    pic.rect(130, 24, 40, 40, BLACK)
    pic.rect(132, 26, 36, 36, WHITE)
    pic.rect(134, 50, 10, 4, RED)
    pic.rect(144, 50, 6, 4, YELLOW)
    pic.rect(150, 50, 16, 4, GREEN)
    pic.text(150, 44, '80', BLACK, 14, TEXT, 'middle')
    pic.text(150, 60, 'kPa', BLACK, 7, TEXT, 'middle')
    pic.text(150, 74, 'NEEDS 95', YELLOW, 8, TEXT, 'middle')
    bolt(pic, 16, 62, RED if state == 'locked' else GREEN)
    pic.save('airlock')


ROOMS = ['COMMS', 'SCREEN', 'ALARM', 'CREW', 'OXYGEN', 'GALLEY', 'ENGINES', 'AIRLOCK', 'LIFE', 'COMMAND']


def draw_map(lesson):
    """The station map for a lesson: rooms before it lit, its own outlined; 13 = the end, all lit."""
    pic = Pic(200, 96, 'The station map: each room lights up when its mission is done')
    pic.rect(0, 0, 200, 96, SPACE)
    stars(pic, 30, 5)
    # The spine and the dock
    pic.rect(6, 44, 168, 8, GREY)
    pic.rect(6, 45, 168, 1, LIGHT)
    for room_index, name in enumerate(ROOMS):
        number = room_index + 1
        row, col = divmod(room_index, 5)
        x = 6 + col * 34
        y = 10 if row == 0 else 58
        done = number < lesson
        current = number == lesson
        fill = DARKGREEN if done else (NAVY if current else BLACK)
        if current:
            pic.rect(x - 2, y - 2, 34, 30, YELLOW)
        pic.rect(x, y, 30, 26, fill)
        pic.rect(x, y, 30, 2, GREEN if done else (ORANGE if current else GREY))
        pic.text(x + 15, y + 15, name, WHITE if (done or current) else GREY, 4.2, TITLE, 'middle')
        pic.text(x + 15, y + 23, f'L{number}', LIGHT if (done or current) else GREY, 7, TEXT, 'middle')
        # The connector to the spine
        pic.rect(x + 13, y + 26 if row == 0 else 52, 4, 8 if row == 0 else 6, GREY)
    # The dock - lessons 11 and 12
    dock_done = lesson >= 13
    dock_current = lesson in (11, 12)
    if dock_current:
        pic.rect(172, 34, 26, 28, YELLOW)
    pic.rect(174, 36, 22, 24, DARKGREEN if dock_done else (NAVY if dock_current else BLACK))
    pic.rect(174, 36, 22, 2, GREEN if dock_done else (ORANGE if dock_current else GREY))
    pic.text(185, 50, 'DOCK', WHITE if (dock_done or dock_current) else GREY, 4.2, TITLE, 'middle')
    pic.text(185, 57, 'L11-12', LIGHT if (dock_done or dock_current) else GREY, 6, TEXT, 'middle')
    # Bolt by the room being fixed
    if lesson <= 10:
        row, col = divmod(lesson - 1, 5)
        bolt(pic, 6 + col * 34 + 8, 40 - 2, ORANGE)
    elif lesson <= 12:
        bolt(pic, 154, 40 - 2, ORANGE)
    else:
        bolt(pic, 154, 38, GREEN)
    pic.save(f'map-{lesson:02d}')


def draw_docked():
    pic = Pic(200, 112, 'The supply ship docked at Station Kestrel, every light green')
    pic.rect(0, 0, 200, 112, SPACE)
    stars(pic, 70, 6)
    earth(pic, 100, 196, 112)
    station(pic, 30, 26, GREEN)
    ship(pic, 104, 36, flame=False)
    bolt(pic, 150, 12, GREEN)
    for sx, sy, colour in [(20, 10, YELLOW), (176, 30, PINK), (60, 70, BLUE), (140, 66, YELLOW)]:
        pic.sprite(sx, sy, [".c.", "ccc", ".c."], {'c': colour})
    pic.text(100, 100, 'DOCKED', GREEN, 8, TITLE, 'middle')
    pic.save('docked')


def draw_storm():
    pic = Pic(200, 96, 'A solar storm hits the station: every screen goes dark')
    pic.rect(0, 0, 200, 96, SPACE)
    stars(pic, 30, 8)
    # The sun's edge and the storm
    for row in range(96):
        half = int(math.sqrt(max(0, 60 * 60 - (row - 48) ** 2)))
        width = max(0, half - 40)
        if width > 0:
            pic.rect(0, row, width, 1, ORANGE if width < 14 else YELLOW)
    rng = random.Random(9)
    for _ in range(60):
        x, y = rng.randrange(20, 120), rng.randrange(0, 96)
        pic.rect(x, y, rng.randrange(3, 9), 1, rng.choice([YELLOW, ORANGE, RED]))
    station(pic, 100, 30, RED)
    bolt(pic, 176, 70, RED)
    pic.text(196, 12, 'SOLAR STORM', RED, 6, TITLE, 'end')
    pic.save('storm')


SPANNER = [
    ".......lllll",
    "llllllllg...",
    "gggggggg....",
    ".......lllll",
]
Z_LETTER = ["yyy", "..y", ".y.", "yyy"]
SPARKLE = [".c.", "ccc", ".c."]


def bolt_sleeping(pic, x, y):
    """Bolt with its eye-light off: a closed eye, a line where the light was."""
    pic.sprite(x, y, BOLT, {'E': BLACK, 'y': BLACK})
    pic.rect(x + 6, y + 7, 4, 1, GREY)


def draw_margin_art():
    """The margin doodles (content-voice-and-pedagogy.md 5b): small, one idea each, Bolt and the crew."""
    # Bolt with a spanner
    pic = Pic(32, 18, 'Bolt holding a spanner')
    bolt(pic, 1, 2, ORANGE)
    pic.sprite(17, 7, SPANNER)
    pic.sprite(28, 2, SPARKLE, {'c': YELLOW})
    pic.save('bolt-spanner')

    # Bolt staring at a semicolon
    pic = Pic(32, 18, 'Bolt staring at a big semicolon')
    bolt(pic, 1, 3, ORANGE)
    pic.sprite(21, 3, ["yyy", "yyy", "...", "...", "yyy", "yyy", ".yy", ".y.", "y.."])
    pic.sprite(27, 0, [".yyy.", "y...y", "...y.", "..y..", ".....", "..y.."], {'y': WHITE})
    pic.save('bolt-semicolon')

    # The 1947 logbook page with the moth taped to it
    pic = Pic(34, 24, 'A logbook page with a moth taped to it, 1947')
    pic.rect(2, 1, 30, 22, WHITE)
    pic.rect(2, 22, 30, 1, LIGHT)
    for line_y in (4, 7, 17, 20):
        pic.rect(5, line_y, 24 if line_y != 20 else 14, 1, LIGHT)
    pic.sprite(11, 9, [
        "BB.....BB",
        "BPB.k.BPB",
        "BBBBkBBBB",
        ".BBBkBBB.",
        "..BB.BB..",
    ])
    pic.rect(8, 10, 3, 2, LIGHT)
    pic.rect(20, 10, 3, 2, LIGHT)
    pic.text(29, 21, '1947', NAVY, 4, TITLE, 'end')
    pic.save('moth')

    # The mission patch
    pic = Pic(26, 26, 'The Station Kestrel mission patch')
    for row in range(26):
        half = int(math.sqrt(max(0, 13 * 13 - (row - 12.5) ** 2)) + 0.5)
        if half > 0:
            pic.rect(13 - half, row, half * 2, 1, ORANGE)
    for row in range(2, 24):
        half = int(math.sqrt(max(0, 11 * 11 - (row - 12.5) ** 2)) + 0.5)
        if half > 0:
            pic.rect(13 - half, row, half * 2, 1, NAVY)
    for sx, sy in [(7, 6), (18, 5), (5, 15), (20, 17), (12, 4)]:
        pic.px(sx, sy, WHITE)
    pic.rect(6, 11, 4, 4, BLUE)
    pic.rect(16, 11, 4, 4, BLUE)
    pic.rect(10, 12, 6, 2, LIGHT)
    pic.rect(11, 10, 4, 6, LIGHT)
    pic.px(12, 12, YELLOW)
    pic.px(13, 12, YELLOW)
    pic.text(13, 21, 'KS-1', YELLOW, 3.4, TITLE, 'middle')
    pic.save('patch')

    # Bolt, splashed with paint in every colour
    pic = Pic(32, 20, 'Bolt splashed with paint in every colour')
    bolt(pic, 8, 3, ORANGE)
    for sx, sy, colour in [(12, 7, PINK), (19, 13, BLUE), (13, 14, GREEN), (21, 6, YELLOW)]:
        pic.rect(sx, sy, 2, 1, colour)
    for sx, sy, colour in [(1, 2, RED), (2, 12, BLUE), (26, 1, GREEN), (27, 11, PINK), (4, 7, YELLOW),
                           (25, 16, ORANGE), (1, 17, GREEN), (28, 6, BLUE)]:
        pic.sprite(sx, sy, ["c.c", ".c.", "c.c"] if sx % 2 else SPARKLE, {'c': colour})
    pic.save('bolt-paint')

    # Bolt waiting, a speech bubble with three dots
    pic = Pic(34, 20, 'Bolt waiting, a speech bubble with three dots')
    bolt(pic, 1, 5, ORANGE)
    pic.rect(17, 1, 16, 9, WHITE)
    pic.rect(16, 2, 18, 7, WHITE)
    pic.rect(17, 10, 3, 1, WHITE)
    pic.rect(16, 11, 2, 1, WHITE)
    for dot_x in (20, 24, 28):
        pic.rect(dot_x, 5, 2, 2, BLACK)
    pic.save('bolt-wait')

    # Sipho and his tomato plant
    pic = Pic(28, 18, 'Sipho the botanist beside his tomato plant')
    crew_member(pic, 3, 3, CREW[3])
    pic.rect(17, 13, 8, 4, BROWN)
    pic.rect(16, 12, 10, 2, BROWN)
    pic.rect(20, 4, 1, 8, DARKGREEN)
    pic.sprite(15, 2, [
        "..GG.GG...",
        ".GGdGdGG..",
        "GGr.G.rGG.",
        ".G..G...G.",
        "..GGrGG...",
        "...rGr....",
        "....G.....",
    ])
    pic.save('sipho-plant')

    # Bolt and a never-ending decimal
    pic = Pic(52, 20, 'Bolt with a long paper strip of decimals')
    bolt(pic, 1, 4, ORANGE)
    pic.rect(16, 10, 34, 6, WHITE)
    pic.rect(16, 16, 34, 1, LIGHT)
    pic.text(18, 15, '0.3333333', BLACK, 6, TEXT)
    pic.save('bolt-decimals')

    # An open locker with a sock inside
    pic = Pic(28, 24, 'An open locker with an old sock inside')
    pic.rect(4, 1, 14, 22, LIGHT)
    pic.rect(5, 2, 12, 20, BLACK)
    pic.rect(5, 9, 12, 1, GREY)
    pic.rect(18, 2, 6, 20, GREY)
    pic.rect(19, 3, 4, 18, LIGHT)
    pic.rect(19, 11, 1, 3, YELLOW)
    pic.sprite(8, 12, [
        "..pp..",
        "..pp..",
        "..pp..",
        "..ppp.",
        ".ppppp",
        ".wwww.",
    ])
    pic.sprite(24, 0, [".yyy", "y..y", "..y.", ".y..", "....", ".y.."], {'y': YELLOW})
    pic.save('locker-sock')

    # Meal packs, five spare
    pic = Pic(34, 20, 'A pile of sealed meal packs')
    for row_index, row_y in enumerate((12, 6, 0)):
        count = 4 - row_index
        for pack in range(count):
            px = 1 + row_index * 4 + pack * 8
            pic.rect(px, row_y + 2, 7, 6, WHITE)
            pic.rect(px, row_y + 2, 7, 1, LIGHT)
            pic.rect(px + 1, row_y + 4, 5, 2, ORANGE)
            pic.px(px + 3, row_y + 7, GREY)
    pic.save('packs')

    # Bolt and a home-made dice with seven dots
    pic = Pic(32, 18, 'Bolt with a dice that has seven dots')
    bolt(pic, 1, 3, ORANGE)
    pic.rect(19, 4, 11, 11, WHITE)
    pic.rect(19, 14, 11, 1, LIGHT)
    for dot_x, dot_y in [(21, 6), (21, 9), (21, 12), (24, 9), (27, 6), (27, 9), (27, 12)]:
        pic.px(dot_x, dot_y, BLACK)
    pic.save('bolt-dice')

    # Lena the pilot at her controls
    pic = Pic(30, 18, 'Lena the pilot with her headset, at the controls')
    crew_member(pic, 3, 3, CREW[4])
    pic.rect(3, 3, 1, 4, GREY)
    pic.rect(4, 6, 2, 1, GREY)
    pic.rect(14, 10, 14, 7, GREY)
    pic.rect(15, 11, 12, 3, BLACK)
    pic.rect(16, 12, 3, 1, GREEN)
    pic.rect(20, 12, 2, 1, YELLOW)
    pic.rect(23, 12, 3, 1, GREEN)
    pic.rect(20, 6, 1, 4, LIGHT)
    pic.rect(19, 5, 3, 2, RED)
    pic.save('lena')

    # A spacewalk: a crew member on a tether outside the hull
    pic = Pic(40, 24, 'A crew member on a spacewalk, tied to the station by a tether')
    pic.rect(0, 0, 40, 24, SPACE)
    stars(pic, 12, 11)
    pic.rect(0, 16, 12, 8, LIGHT)
    pic.rect(0, 16, 12, 1, WHITE)
    pic.rect(3, 19, 2, 2, YELLOW)
    pic.rect(11, 18, 2, 3, GREY)
    crew_member(pic, 26, 4, ('', '', BLUE, WHITE, WHITE, RED))
    for step, (tx, ty) in enumerate([(13, 18), (15, 17), (17, 17), (19, 16), (21, 15), (23, 14), (25, 13)]):
        pic.px(tx, ty, YELLOW)
    pic.save('spacewalk')

    # A South African robot (traffic light), Bolt beside it
    pic = Pic(32, 26, 'A traffic light - a robot - and Bolt beside it')
    pic.rect(22, 15, 2, 11, GREY)
    pic.rect(19, 0, 8, 17, BLACK)
    pic.rect(21, 2, 4, 4, RED)
    pic.rect(21, 7, 4, 4, ORANGE)
    pic.rect(21, 12, 4, 4, GREEN)
    bolt(pic, 1, 9, GREEN)
    pic.save('robot')

    # Bolt asleep
    pic = Pic(28, 20, 'Bolt asleep, its eye-light off')
    bolt_sleeping(pic, 1, 5)
    pic.sprite(18, 6, Z_LETTER)
    pic.sprite(22, 1, Z_LETTER)
    pic.save('bolt-sleep')

    # The command keypad
    pic = Pic(26, 26, 'The command console keypad, buttons 1 to 4')
    pic.rect(1, 1, 24, 24, GREY)
    pic.rect(2, 2, 22, 22, LIGHT)
    pic.rect(4, 3, 18, 5, BLACK)
    pic.rect(5, 5, 8, 1, GREEN)
    for index, (bx, by) in enumerate([(4, 10), (14, 10), (4, 17), (14, 17)]):
        pic.rect(bx, by, 8, 6, GREY)
        pic.rect(bx, by, 8, 5, [BLUE, GREEN, ORANGE, RED][index])
        pic.text(bx + 4, by + 4, str(index + 1), WHITE, 4, TITLE, 'middle')
    pic.save('keypad')

    # Bolt with a clipboard of ticks
    pic = Pic(32, 20, 'Bolt with a clipboard of test results')
    bolt(pic, 1, 4, ORANGE)
    pic.rect(18, 2, 12, 16, BROWN)
    pic.rect(19, 4, 10, 13, WHITE)
    pic.rect(21, 1, 6, 2, GREY)
    for row_y in (6, 10, 14):
        pic.sprite(20, row_y - 1, ["..G", "GG."], {'G': GREEN})
        pic.rect(24, row_y, 4, 1, LIGHT)
    pic.save('bolt-clipboard')

    # A mug of cold coffee
    pic = Pic(28, 20, 'A mug of coffee gone cold, with a snowflake above it')
    pic.rect(6, 7, 12, 12, WHITE)
    pic.rect(6, 18, 12, 1, LIGHT)
    pic.rect(7, 8, 10, 2, BROWN)
    pic.rect(18, 9, 3, 1, WHITE)
    pic.rect(20, 10, 1, 4, WHITE)
    pic.rect(18, 14, 3, 1, WHITE)
    pic.rect(9, 12, 6, 1, BLUE)
    pic.sprite(9, 0, ["b.b.b", ".bbb.", "bbbbb", ".bbb.", "b.b.b"])
    pic.save('coffee')


def main():
    os.makedirs(OUT, exist_ok=True)
    draw_margin_art()
    draw_station_scene()
    draw_ground()
    draw_bolts()
    draw_crew()
    draw_lockers()
    draw_ship()
    draw_airlock()
    draw_storm()
    draw_docked()
    for lesson in range(1, 14):
        draw_map(lesson)


main()
