"""Draws the Bolt's maze course's art (brand/botmaze-art-style.md).

Chris, 11 October 2026: "c and d" - a top-down adventure game built by hand on
a desk. Card walls on a paper level, masking tape, red felt-pen arrows and
paths, the game screen on sticky notes (hearts, batteries, the tunnel's name).
Bolt is a paper cut-out of the Station Kestrel robot; Glitch is a purple paper
bug who swaps Bolt's commands round.

Writes AIPascalCourse/public/assets/doodles/botmaze-*.svg.

  python -X utf8 tools/botmaze/make_art.py
"""
import os, math

DOODLES = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'

CARD, CARD_LINE, PAPER, WALL, WALL_DK = '#c9a273', '#b48c5d', '#f3e4cc', '#8a6239', '#6e4c2a'
PENCIL, TAPE, RED, INK = '#b9a98c', '#f5e7a8', '#c0392b', '#2a1d10'
STICKY, GREEN, BATTERY = '#ffe36b', '#9be38a', '#ffd84a'
BOLT, EYE, GLITCH, GLITCH_DK = '#dfe3ea', '#ff8a2a', '#7b6cf6', '#4b3fb8'
HAND = "'Gaegu', 'Comic Sans MS', cursive"
GAME = "'Luckiest Guy', 'Arial Black', sans-serif"

TUNNELS = ['The Cupboard', 'The Bend', "Glitch's Nest", 'The Long Haul', 'The Doors', 'The Twisty Bit', 'The Docking Bay']


def esc(t):
    return t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, w, h, label, desk=True):
        self.w, self.h, self.label, self.parts = w, h, label, []
        if desk:
            self.add(f'<rect width="{w}" height="{h}" rx="8" fill="{CARD}"/>')
            for y in range(18, h, 26):
                self.add(f'<rect x="0" y="{y}" width="{w}" height="1.5" fill="{CARD_LINE}" opacity=".45"/>')

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=INK, anchor='start', font=HAND, weight=700, rot=0):
        r = f' transform="rotate({rot} {x} {y})"' if rot else ''
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" font-weight="{weight}" fill="{fill}" text-anchor="{anchor}"{r}>{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self, name):
        os.makedirs(DOODLES, exist_ok=True)
        with open(os.path.join(DOODLES, name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print(name + '.svg')


# ---------------------------------------------------------------- pieces --

def paper(s, x, y, w, h, rot=-1.2, fill=PAPER):
    s.add(f'<g transform="rotate({rot} {x + w / 2} {y + h / 2})"><rect x="{x + 3}" y="{y + 4}" width="{w}" height="{h}" fill="#000" opacity=".12"/>'
          f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}"/></g>')


def tape(s, x, y, rot=0, w=40):
    s.add(f'<rect x="{x - w / 2}" y="{y - 8}" width="{w}" height="16" fill="{TAPE}" opacity=".92" transform="rotate({rot} {x} {y})"/>')


def sticky(s, x, y, w, h, lines, fill=STICKY, rot=3, size=17, font=HAND):
    cx, cy = x + w / 2, y + h / 2
    s.add(f'<g transform="rotate({rot} {cx} {cy})"><rect x="{x + 2}" y="{y + 3}" width="{w}" height="{h}" fill="#000" opacity=".13"/>'
          f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}"/>')
    for i, line in enumerate(lines):
        s.add(f'<text x="{cx}" y="{y + 8 + size * (i + 1.05)}" font-family="{font}" font-size="{size}" font-weight="700" fill="{INK}" text-anchor="middle">{esc(line)}</text>')
    s.add('</g>')


def wall(s, x, y, w, h):
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{WALL}" stroke="{WALL_DK}" stroke-width="1.5"/>')


def grid(s, x, y, cols, rows, cell):
    for c in range(cols + 1):
        s.add(f'<line x1="{x + c * cell}" y1="{y}" x2="{x + c * cell}" y2="{y + rows * cell}" stroke="{PENCIL}" stroke-width="1"/>')
    for r in range(rows + 1):
        s.add(f'<line x1="{x}" y1="{y + r * cell}" x2="{x + cols * cell}" y2="{y + r * cell}" stroke="{PENCIL}" stroke-width="1"/>')


def maze(s, x, y, rows, cell, show_grid=True):
    """A maze from strings (# wall, . floor, E exit, * battery) on paper; returns {'S': (cx, cy), ...} centres."""
    found = {}
    if show_grid:
        grid(s, x, y, len(rows[0]), len(rows), cell)
    for r, row in enumerate(rows):
        for c, ch in enumerate(row):
            px, py = x + c * cell, y + r * cell
            if ch == '#':
                wall(s, px, py, cell, cell)
            elif ch == 'E':
                s.add(f'<rect x="{px + 3}" y="{py + 3}" width="{cell - 6}" height="{cell - 6}" fill="{GREEN}" transform="rotate(3 {px + cell / 2} {py + cell / 2})"/>')
                s.add(f'<text x="{px + cell / 2}" y="{py + cell / 2 + cell * .14}" font-family="{GAME}" font-size="{cell * .32}" fill="{INK}" text-anchor="middle">EXIT</text>')
            elif ch == '*':
                battery(s, px + cell / 2, py + cell / 2, cell / 40)
            if ch in 'SE*':
                found[ch] = (px + cell / 2, py + cell / 2)
    return found


def battery(s, cx, cy, sc=1.0):
    o = lambda v: v * sc
    s.add(f'<g transform="translate({cx} {cy}) rotate(-8)"><rect x="{o(-8)}" y="{o(-13)}" width="{o(16)}" height="{o(26)}" rx="{o(3)}" fill="{BATTERY}" stroke="{INK}" stroke-width="{o(2)}"/>'
          f'<rect x="{o(-4)}" y="{o(-17)}" width="{o(8)}" height="{o(4)}" fill="{INK}"/>'
          f'<path d="M{o(1)} {o(-9)} L{o(-4)} {o(1)} H{o(0)} L{o(-1)} {o(9)} L{o(4)} {o(-1)} H{o(0)} Z" fill="{RED}"/></g>')


def bolt_head(s, cx, cy, sc=1.0, facing=0, mood='happy'):
    """Bolt from above: the paper head, its eye, antennae, and a felt-pen arrow for where it faces (0 up, 90 right ...)."""
    o = lambda v: v * sc
    s.add(f'<g transform="translate({cx} {cy})">')
    s.add(f'<path d="M0 {o(-30)} l{o(-8)} {o(10)} h{o(16)} z" fill="{RED}" transform="rotate({facing})"/>')
    s.add(f'<line x1="{o(-8)}" y1="{o(-16)}" x2="{o(-12)}" y2="{o(-26)}" stroke="{INK}" stroke-width="{o(2.5)}" stroke-linecap="round"/>'
          f'<line x1="{o(8)}" y1="{o(-16)}" x2="{o(12)}" y2="{o(-26)}" stroke="{INK}" stroke-width="{o(2.5)}" stroke-linecap="round"/>'
          f'<circle cx="{o(-12)}" cy="{o(-27)}" r="{o(3)}" fill="{EYE}"/><circle cx="{o(12)}" cy="{o(-27)}" r="{o(3)}" fill="{EYE}"/>')
    s.add(f'<rect x="{o(-17)}" y="{o(-17)}" width="{o(34)}" height="{o(32)}" rx="{o(7)}" fill="{BOLT}" stroke="{INK}" stroke-width="{o(2.5)}"/>')
    s.add(f'<circle cx="0" cy="{o(-3)}" r="{o(8.5)}" fill="{EYE}" stroke="{INK}" stroke-width="{o(2)}"/><circle cx="{o(2)}" cy="{o(-5)}" r="{o(3)}" fill="{INK}"/>')
    if mood == 'happy':
        s.add(f'<path d="M{o(-6)} {o(8)} q{o(6)} {o(5)} {o(12)} 0" stroke="{INK}" stroke-width="{o(2)}" fill="none" stroke-linecap="round"/>')
    elif mood == 'dizzy':
        s.add(f'<path d="M{o(-6)} {o(10)} q{o(3)} {o(-3)} {o(6)} 0 q{o(3)} {o(3)} {o(6)} 0" stroke="{INK}" stroke-width="{o(2)}" fill="none"/>')
    else:
        s.add(f'<path d="M{o(-5)} {o(9)} h{o(10)}" stroke="{INK}" stroke-width="{o(2)}" stroke-linecap="round"/>')
    s.add('</g>')


def bolt_stand(s, cx, cy, sc=1.0, mood='happy', stick=True):
    """Bolt as a paper cut-out on a lolly stick, seen from the front (for margin drawings)."""
    o = lambda v: v * sc
    if stick:
        s.add(f'<rect x="{cx - o(4)}" y="{cy + o(30)}" width="{o(8)}" height="{o(60)}" rx="{o(3)}" fill="#e8c48a" stroke="{INK}" stroke-width="{o(1.5)}"/>')
    s.add(f'<rect x="{cx - o(24)}" y="{cy + o(16)}" width="{o(48)}" height="{o(28)}" rx="{o(6)}" fill="{BOLT}" stroke="{INK}" stroke-width="{o(2.5)}"/>')
    s.add(f'<line x1="{cx - o(10)}" y1="{cy - o(30)}" x2="{cx - o(16)}" y2="{cy - o(46)}" stroke="{INK}" stroke-width="{o(3)}" stroke-linecap="round"/>'
          f'<line x1="{cx + o(10)}" y1="{cy - o(30)}" x2="{cx + o(16)}" y2="{cy - o(46)}" stroke="{INK}" stroke-width="{o(3)}" stroke-linecap="round"/>'
          f'<circle cx="{cx - o(16)}" cy="{cy - o(48)}" r="{o(5)}" fill="{EYE}" stroke="{INK}" stroke-width="{o(1.5)}"/><circle cx="{cx + o(16)}" cy="{cy - o(48)}" r="{o(5)}" fill="{EYE}" stroke="{INK}" stroke-width="{o(1.5)}"/>')
    s.add(f'<rect x="{cx - o(30)}" y="{cy - o(32)}" width="{o(60)}" height="{o(50)}" rx="{o(12)}" fill="{BOLT}" stroke="{INK}" stroke-width="{o(3)}"/>')
    s.add(f'<rect x="{cx - o(20)}" y="{cy - o(24)}" width="{o(40)}" height="{o(26)}" rx="{o(8)}" fill="{INK}"/>')
    s.add(f'<circle cx="{cx}" cy="{cy - o(11)}" r="{o(10)}" fill="{EYE}"/><circle cx="{cx + o(3)}" cy="{cy - o(14)}" r="{o(3.5)}" fill="#fff"/>')
    if mood == 'happy':
        s.add(f'<path d="M{cx - o(9)} {cy + o(8)} q{o(9)} {o(7)} {o(18)} 0" stroke="{INK}" stroke-width="{o(2.5)}" fill="none" stroke-linecap="round"/>')
    elif mood == 'oops':
        s.add(f'<ellipse cx="{cx}" cy="{cy + o(9)}" rx="{o(5)}" ry="{o(4)}" fill="{INK}"/>')
    elif mood == 'dizzy':
        s.add(f'<path d="M{cx - o(10)} {cy + o(9)} q{o(5)} {o(-4)} {o(10)} 0 q{o(5)} {o(4)} {o(10)} 0" stroke="{INK}" stroke-width="{o(2.5)}" fill="none"/>')
    else:
        s.add(f'<path d="M{cx - o(8)} {cy + o(9)} h{o(16)}" stroke="{INK}" stroke-width="{o(2.5)}" stroke-linecap="round"/>')


def glitch(s, cx, cy, sc=1.0, mood='grin'):
    """Glitch: a purple paper bug with pipe-cleaner antennae."""
    o = lambda v: v * sc
    for side in (-1, 1):
        s.add(f'<path d="M{cx + side * o(8)} {cy - o(14)} q{side * o(4)} {o(-14)} {side * o(14)} {o(-18)}" stroke="#e85d9b" stroke-width="{o(3.5)}" fill="none" stroke-linecap="round"/>'
              f'<circle cx="{cx + side * o(22)}" cy="{cy - o(32)}" r="{o(4)}" fill="#e85d9b"/>')
        for k in range(3):
            s.add(f'<path d="M{cx + side * o(18)} {cy + o(-2 + k * 9)} l{side * o(13)} {o(-3 + k * 5)}" stroke="{INK}" stroke-width="{o(2.5)}" stroke-linecap="round"/>')
    s.add(f'<ellipse cx="{cx}" cy="{cy + o(6)}" rx="{o(22)}" ry="{o(18)}" fill="{GLITCH}" stroke="{INK}" stroke-width="{o(2.5)}"/>')
    s.add(f'<path d="M{cx} {cy - o(10)} v{o(32)}" stroke="{GLITCH_DK}" stroke-width="{o(2)}"/>')
    s.add(f'<circle cx="{cx}" cy="{cy - o(10)}" r="{o(14)}" fill="{GLITCH}" stroke="{INK}" stroke-width="{o(2.5)}"/>')
    s.add(f'<circle cx="{cx - o(5)}" cy="{cy - o(13)}" r="{o(4.5)}" fill="#fff"/><circle cx="{cx + o(5)}" cy="{cy - o(13)}" r="{o(4.5)}" fill="#fff"/>'
          f'<circle cx="{cx - o(4)}" cy="{cy - o(13)}" r="{o(2)}" fill="{INK}"/><circle cx="{cx + o(6)}" cy="{cy - o(13)}" r="{o(2)}" fill="{INK}"/>')
    if mood == 'grin':
        s.add(f'<path d="M{cx - o(7)} {cy - o(5)} q{o(7)} {o(7)} {o(14)} 0" stroke="{INK}" stroke-width="{o(2)}" fill="#fff"/>')
    else:
        s.add(f'<path d="M{cx - o(5)} {cy - o(4)} q{o(5)} {o(-3)} {o(10)} 0" stroke="{INK}" stroke-width="{o(2)}" fill="none"/>')


def pen_path(s, points, dashed=False, arrow=True, width=3.5, colour=RED):
    d = 'M' + ' L'.join(f'{x} {y}' for x, y in points)
    dash = ' stroke-dasharray="7 6"' if dashed else ''
    s.add(f'<path d="{d}" fill="none" stroke="{colour}" stroke-width="{width}" stroke-linecap="round" stroke-linejoin="round"{dash}/>')
    if arrow and len(points) > 1:
        (x1, y1), (x2, y2) = points[-2], points[-1]
        a = math.atan2(y2 - y1, x2 - x1)
        p = lambda d, r: (x2 - 13 * math.cos(a + d), y2 - 13 * math.sin(a + d))
        (ax, ay), (bx, by) = p(.5, 0), p(-.5, 0)
        s.add(f'<path d="M{ax:.1f} {ay:.1f} L{x2} {y2} L{bx:.1f} {by:.1f}" fill="none" stroke="{colour}" stroke-width="{width}" stroke-linecap="round" stroke-linejoin="round"/>')


def hearts(s, x, y, full=3, of=3, sc=1.0):
    for i in range(of):
        hx = x + i * 24 * sc
        fill = RED if i < full else 'none'
        s.add(f'<path d="M{hx} {y + 4 * sc} c{-5 * sc} {-8 * sc} {-16 * sc} 0 0 {13 * sc} c{16 * sc} {-13 * sc} {5 * sc} {-21 * sc} 0 {-13 * sc}z" fill="{fill}" stroke="{RED}" stroke-width="{2 * sc}"/>')


# ------------------------------------------------------------- pictures --

MAP_SPOTS = [(76, 210), (140, 120), (206, 205), (272, 110), (338, 200), (400, 105), (436, 200)]


def tunnel_map(n):
    """The tunnel map, taped to the desk, tunnels 1..n reached: Bolt on tunnel n."""
    s = Svg(520, 300, f'The tunnel map taped to the desk. Bolt has reached tunnel {n}: {TUNNELS[n - 1]}.')
    paper(s, 24, 30, 472, 244, rot=-1)
    tape(s, 60, 34, -8)
    tape(s, 462, 268, -6)
    s.text(40, 64, 'TUNNEL MAP', 22, INK, font=GAME, weight=400)
    hearts(s, 404, 46, 3, 3, 0.9)
    pts = MAP_SPOTS
    pen_path(s, pts[:n], dashed=False, arrow=False, width=4)
    pen_path(s, pts[n - 1:], dashed=True, arrow=False, width=2.5, colour=PENCIL)
    for i, (x, y) in enumerate(pts):
        done = i < n - 1
        here = i == n - 1
        s.add(f'<circle cx="{x}" cy="{y}" r="17" fill="{GREEN if done else (STICKY if here else PAPER)}" stroke="{INK}" stroke-width="2.5"/>')
        s.text(x, y + 6, str(i + 1), 17, INK, 'middle', GAME, 400)
        if done:
            s.add(f'<path d="M{x + 10} {y - 22} l5 6 l10 -12" stroke="{RED}" stroke-width="3" fill="none" stroke-linecap="round"/>')
        name = TUNNELS[i]
        ty = y + 38 if y > 150 else y - 26
        s.text(x, ty, name, 15, INK if i < n else PENCIL, 'middle')
    x, y = pts[n - 1]
    bolt_head(s, x, y - 2 - 34 if y > 150 else y + 46, 0.8, 0)
    return s


def pair():
    s = Svg(300, 190, 'Bolt, a paper robot on a lolly stick, and Glitch, a purple paper bug with pipe-cleaner antennae, waving')
    bolt_stand(s, 100, 80, 1.0, 'happy')
    glitch(s, 215, 110, 1.3)
    tape(s, 100, 168, 4, 36)
    return s


def paper_game():
    s = Svg(440, 260, 'Lesson 1 on paper: a grid taped on the classroom floor, one pupil is the robot, the programmer holds up sticky notes: forward, forward, turn right')
    paper(s, 30, 24, 250, 210, rot=-2)
    grid(s, 50, 44, 5, 4, 42)
    wall(s, 50 + 2 * 42, 44 + 42, 42, 42 * 2)
    s.add(f'<rect x="{50 + 4 * 42 + 4}" y="{44 + 3 * 42 + 4}" width="34" height="34" fill="{GREEN}"/>')
    s.text(50 + 4 * 42 + 21, 44 + 3 * 42 + 26, 'X', 20, INK, 'middle', GAME, 400)
    bolt_head(s, 50 + 21, 44 + 21, 0.8, 90)
    pen_path(s, [(71, 65), (155, 65), (197, 65), (197, 180)], dashed=True, width=3)
    sticky(s, 300, 30, 110, 46, ['forward'], rot=-3)
    sticky(s, 304, 86, 110, 46, ['forward'], rot=2)
    sticky(s, 298, 142, 110, 46, ['turn right'], rot=-2)
    sticky(s, 306, 198, 110, 46, ['forward ...'], STICKY, rot=3)
    return s


def left_right():
    s = Svg(440, 230, "Bolt's left is not always your left: Bolt faces down the page, so Bolt's left is on your right")
    paper(s, 26, 22, 388, 186, rot=1)
    bolt_head(s, 220, 112, 1.5, 180)
    pen_path(s, [(190, 112), (122, 112)], width=4)
    pen_path(s, [(250, 112), (318, 112)], width=4)
    s.text(70, 100, "Bolt's", 20, INK, 'middle')
    s.text(70, 124, 'RIGHT', 22, RED, 'middle', GAME, 400)
    s.text(372, 100, "Bolt's", 20, INK, 'middle')
    s.text(372, 124, 'LEFT', 22, RED, 'middle', GAME, 400)
    s.text(220, 196, 'Bolt is facing DOWN the page', 18, INK, 'middle')
    return s


def turn():
    s = Svg(260, 190, 'Bolt turning on the spot: a quarter turn right, without moving a square')
    paper(s, 20, 16, 220, 158, rot=-2)
    grid(s, 60, 36, 3, 3, 40)
    bolt_head(s, 120, 96, 1.0, 90)
    s.add(f'<path d="M120 50 A46 46 0 0 1 166 96" fill="none" stroke="{RED}" stroke-width="3.5" stroke-linecap="round"/>')
    s.add(f'<path d="M156 88 L166 98 L174 86" fill="none" stroke="{RED}" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round"/>')
    s.text(198, 62, '90°', 20, RED, 'middle')
    return s


def bump():
    s = Svg(260, 190, 'Bolt has walked into a card wall: a bump, stars round its head')
    paper(s, 18, 18, 224, 154, rot=1.5)
    wall(s, 168, 26, 30, 140)
    bolt_stand(s, 110, 92, 0.85, 'oops', stick=False)
    for x, y in [(150, 40), (160, 70), (138, 30)]:
        s.add(f'<path d="M{x} {y - 8} l2 6 l6 2 l-6 2 l-2 6 l-2 -6 l-6 -2 l6 -2z" fill="{STICKY}" stroke="{INK}" stroke-width="1.5"/>')
    s.text(64, 160, 'BONK', 26, RED, 'middle', GAME, 400, rot=-8)
    return s


def glitch_swap():
    s = Svg(440, 240, 'Glitch swapping two sticky notes in Bolt\'s program while nobody is looking')
    paper(s, 24, 20, 220, 200, rot=-1.5)
    s.text(46, 52, "Bolt's program", 20, INK)
    sticky(s, 52, 66, 150, 34, ['forward'], rot=-1, size=18)
    sticky(s, 52, 106, 150, 34, ['turn left'], rot=1, size=18)
    sticky(s, 52, 146, 150, 34, ['forward'], rot=-1, size=18)
    sticky(s, 270, 60, 150, 34, ['turn right'], rot=8, size=18)
    s.add(f'<path d="M206 128 Q240 60 268 80" fill="none" stroke="{GLITCH}" stroke-width="3" stroke-dasharray="6 5"/>')
    s.add(f'<path d="M268 96 Q236 160 206 132" fill="none" stroke="{GLITCH}" stroke-width="3" stroke-dasharray="6 5"/>')
    glitch(s, 340, 160, 1.3)
    s.text(340, 226, 'hee hee', 18, GLITCH_DK, 'middle')
    return s


def loop_notes():
    s = Svg(440, 230, 'Eight sticky notes saying forward, or one sticky note saying repeat 8, forward, end: the same program')
    for i in range(8):
        sticky(s, 30 + (i % 2) * 86, 18 + (i // 2) * 48, 80, 40, ['forward'], rot=(-3, 2, 1, -2)[i % 4], size=16)
    s.text(232, 120, '=', 40, INK, 'middle', GAME, 400)
    sticky(s, 270, 50, 150, 130, ['repeat 8', '  forward', 'end'], rot=-2, size=22)
    return s


def sensor():
    s = Svg(440, 240, 'Bolt checks before it moves: dotted lines look ahead, left and right; ahead is a wall, left is a path')
    paper(s, 24, 18, 392, 204, rot=-1)
    cell = 52
    x0, y0 = 116, 38
    maze(s, x0, y0, ['#.#', '.S#', '###'], cell)   # Bolt faces right: ahead a wall, left (up) a path, right (down) a wall
    bx, by = x0 + 1.5 * cell, y0 + 1.5 * cell
    bolt_head(s, bx, by, 1.0, 90)
    s.add(f'<path d="M{bx + 22} {by} H{bx + 46}" stroke="{RED}" stroke-width="3" stroke-dasharray="3 5" stroke-linecap="round"/>')
    s.add(f'<path d="M{bx} {by - 32} V{by - 66}" stroke="{RED}" stroke-width="3" stroke-dasharray="3 5" stroke-linecap="round"/>')
    s.add(f'<path d="M{bx} {by + 26} V{by + 46}" stroke="{RED}" stroke-width="3" stroke-dasharray="3 5" stroke-linecap="round"/>')
    sticky(s, 300, 60, 104, 40, ['ahead: WALL'], rot=3, size=16)
    sticky(s, 300, 112, 104, 40, ['left: PATH'], GREEN, rot=-2, size=16)
    sticky(s, 300, 164, 104, 40, ['right: WALL'], rot=2, size=16)
    return s


def wall_follow():
    s = Svg(440, 260, 'Follow the wall: Bolt keeps its right side next to a wall all the way through the maze, and the red path finds the exit')
    paper(s, 20, 16, 400, 228, rot=-1)
    rows = ['###########', '#S......###', '#######.###', '#######...#', '#######.###', '#######...E', '###########']
    cell = 24
    x0, y0 = 150, 44
    maze(s, x0, y0, rows, cell, show_grid=False)
    c = lambda col, row: (x0 + col * cell + cell / 2, y0 + row * cell + cell / 2)
    route = [c(1, 1), c(7, 1), c(7, 5), c(10, 5)]
    pen_path(s, route, width=3.5)
    bolt_head(s, *c(1, 1), 0.7, 90)
    sticky(s, 34, 150, 112, 52, ['right hand', 'on the wall'], rot=-4, size=16)
    return s


def circles():
    s = Svg(260, 190, 'Bolt going round and round in a loop that never ends, dizzy')
    paper(s, 18, 16, 224, 158, rot=-2)
    s.add(f'<ellipse cx="130" cy="96" rx="78" ry="52" fill="none" stroke="{RED}" stroke-width="3.5" stroke-dasharray="9 6"/>')
    s.add(f'<path d="M196 70 l14 -2 l-4 14" fill="none" stroke="{RED}" stroke-width="3.5" stroke-linecap="round" stroke-linejoin="round"/>')
    bolt_head(s, 130, 96, 1.1, 90, 'dizzy')
    s.text(130, 168, 'again... again... again...', 16, INK, 'middle')
    return s


def home():
    s = Svg(440, 250, 'The Docking Bay: Bolt rolls through the open door home, Glitch waving, felt-pen confetti')
    paper(s, 24, 18, 392, 214, rot=1)
    s.add(f'<rect x="250" y="44" width="140" height="160" fill="#5f6b78" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<rect x="268" y="60" width="104" height="144" fill="#ffe9a8"/>')
    s.text(320, 40, 'DOCKING BAY', 20, INK, 'middle', GAME, 400)
    bolt_stand(s, 320, 130, 0.9, 'happy', stick=False)
    glitch(s, 140, 160, 1.1)
    for i, (x, y) in enumerate([(70, 60), (110, 40), (190, 70), (220, 40), (160, 100), (60, 120)]):
        col = [RED, GLITCH, '#2f9e5a', STICKY][i % 4]
        s.add(f'<rect x="{x}" y="{y}" width="10" height="5" fill="{col}" transform="rotate({i * 37} {x} {y})"/>')
    return s


def main():
    for n in range(1, 8):
        tunnel_map(n).save(f'botmaze-map-{n:02d}')
    pair().save('botmaze-pair')
    paper_game().save('botmaze-paper-game')
    left_right().save('botmaze-left-right')
    turn().save('botmaze-turn')
    bump().save('botmaze-bump')
    glitch_swap().save('botmaze-glitch-swap')
    loop_notes().save('botmaze-loop-notes')
    sensor().save('botmaze-sensor')
    wall_follow().save('botmaze-wall-follow')
    circles().save('botmaze-circles')
    home().save('botmaze-home')


if __name__ == '__main__':
    main()
