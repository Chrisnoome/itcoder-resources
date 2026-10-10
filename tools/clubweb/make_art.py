"""Draws the Club website course's art (brand/clubweb-art-style.md).

Comic panels (thick ink, flat primary panels, speech bubbles) with isometric
blocks inside them (HTML elements as blocks; nesting is stacking), and the
mascots Tag (<, blue) and Gat (>, pink). Writes
AIPascalCourse/public/assets/doodles/clubweb-*.svg, and the club's own pictures
the pupils put on their page (Boxy and friends) as SVG, which shots.py turns
into PNG in public/assets/practical/html/robotics/.

  python -X utf8 tools/clubweb/make_art.py
"""
import os, math

DOODLES = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'
PICS = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'pics')

INK, WHITE, YELLOW, SKY, PINK, RED = '#111111', '#ffffff', '#ffe14d', '#7fd3ff', '#ff8fa3', '#e63b2e'
TAG_BLUE, GAT_PINK = '#2f6fde', '#ff4f7a'
BLOCK = {  # element kind: (top, left side, right side)
    'base':    ('#d8e1f0', '#b7c4de', '#c7d2e8'),
    'heading': ('#6c5ce7', '#5141c8', '#5d4ed6'),
    'text':    ('#2ec4b6', '#1fa396', '#26b3a6'),
    'list':    ('#ffb84d', '#e59a2a', '#f0a838'),
    'image':   ('#ff7a59', '#e0603f', '#ef6d4c'),
    'link':    ('#3b82f6', '#2563d0', '#2f72e6'),
    'table':   ('#7bc96f', '#5aa94e', '#6bb95f'),
    'head':    ('#c9c2ff', '#a99ff0', '#b9b0f8'),
}
SHOUT = "'Rubik Mono One', 'Arial Black', sans-serif"
SPEECH = "'Inter Tight', 'Segoe UI', sans-serif"
CODE = "'Space Mono', Consolas, monospace"


def esc(text):
    return text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, w, h, label):
        self.w, self.h, self.label, self.parts = w, h, label, []

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=INK, font=SPEECH, anchor='start', weight=None):
        w = f' font-weight="{weight}"' if weight else ''
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" fill="{fill}" text-anchor="{anchor}"{w}>{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self, name, folder=DOODLES, prefix='clubweb-'):
        os.makedirs(folder, exist_ok=True)
        with open(os.path.join(folder, prefix + name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print(prefix + name + '.svg')


# ------------------------------------------------------------- pieces ----

def panel(svg, x, y, w, h, fill):
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="{INK}" stroke-width="4"/>')


def bubble(svg, x, y, w, h, lines, tail_x, tail_y, size=13, font=SPEECH, shout=False):
    """A speech bubble with its tail pointing at (tail_x, tail_y)."""
    r = 12
    tx = min(max(tail_x, x + 18), x + w - 18)
    bottom = tail_y > y + h
    if bottom:
        svg.add(f'<path d="M{x + r} {y} H{x + w - r} Q{x + w} {y} {x + w} {y + r} V{y + h - r} Q{x + w} {y + h} {x + w - r} {y + h} '
                f'H{tx + 8} L{tail_x} {tail_y} L{tx - 6} {y + h} H{x + r} Q{x} {y + h} {x} {y + h - r} V{y + r} Q{x} {y} {x + r} {y}Z" '
                f'fill="{WHITE}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>')
    else:
        svg.add(f'<path d="M{x + r} {y} H{tx - 6} L{tail_x} {tail_y} L{tx + 8} {y} H{x + w - r} Q{x + w} {y} {x + w} {y + r} V{y + h - r} '
                f'Q{x + w} {y + h} {x + w - r} {y + h} H{x + r} Q{x} {y + h} {x} {y + h - r} V{y + r} Q{x} {y} {x + r} {y}Z" '
                f'fill="{WHITE}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>')
    for i, line in enumerate(lines):
        svg.text(x + 12, y + 20 + i * (size + 5), line, size, INK, SHOUT if shout else font)


def tag(svg, cx, cy, s=1.0, mood='happy'):
    """Tag: the opening bracket <, blue, with a face."""
    w = 7 * s
    svg.add(f'<path d="M{cx + 12 * s} {cy - 26 * s} L{cx - 14 * s} {cy} L{cx + 12 * s} {cy + 26 * s}" fill="none" stroke="{INK}" '
            f'stroke-width="{w + 5 * s}" stroke-linecap="round" stroke-linejoin="round"/>')
    svg.add(f'<path d="M{cx + 12 * s} {cy - 26 * s} L{cx - 14 * s} {cy} L{cx + 12 * s} {cy + 26 * s}" fill="none" stroke="{TAG_BLUE}" '
            f'stroke-width="{w}" stroke-linecap="round" stroke-linejoin="round"/>')
    face(svg, cx + 6 * s, cy - 4 * s, s, mood)


def gat(svg, cx, cy, s=1.0, mood='happy'):
    """Gat: the closing bracket >, pink, with a face."""
    w = 7 * s
    svg.add(f'<path d="M{cx - 12 * s} {cy - 26 * s} L{cx + 14 * s} {cy} L{cx - 12 * s} {cy + 26 * s}" fill="none" stroke="{INK}" '
            f'stroke-width="{w + 5 * s}" stroke-linecap="round" stroke-linejoin="round"/>')
    svg.add(f'<path d="M{cx - 12 * s} {cy - 26 * s} L{cx + 14 * s} {cy} L{cx - 12 * s} {cy + 26 * s}" fill="none" stroke="{GAT_PINK}" '
            f'stroke-width="{w}" stroke-linecap="round" stroke-linejoin="round"/>')
    face(svg, cx - 6 * s, cy - 4 * s, s, mood)


def face(svg, cx, cy, s, mood):
    for dx in (-5, 5):
        svg.add(f'<circle cx="{cx + dx * s}" cy="{cy}" r="{3.2 * s}" fill="{WHITE}" stroke="{INK}" stroke-width="{1.4 * s}"/>')
        svg.add(f'<circle cx="{cx + dx * s + 0.8 * s}" cy="{cy + 0.6 * s}" r="{1.4 * s}" fill="{INK}"/>')
    if mood == 'happy':
        svg.add(f'<path d="M{cx - 5 * s} {cy + 7 * s} Q{cx} {cy + 12 * s} {cx + 5 * s} {cy + 7 * s}" fill="none" stroke="{INK}" stroke-width="{1.8 * s}" stroke-linecap="round"/>')
    elif mood == 'shout':
        svg.add(f'<ellipse cx="{cx}" cy="{cy + 9 * s}" rx="{4 * s}" ry="{4.5 * s}" fill="{INK}"/>')
    elif mood == 'worried':
        svg.add(f'<path d="M{cx - 5 * s} {cy + 10 * s} Q{cx} {cy + 6 * s} {cx + 5 * s} {cy + 10 * s}" fill="none" stroke="{INK}" stroke-width="{1.8 * s}" stroke-linecap="round"/>')
    elif mood == 'wow':
        svg.add(f'<circle cx="{cx}" cy="{cy + 9 * s}" r="{2.6 * s}" fill="{INK}"/>')


def zanele(svg, cx, cy, s=1.0):
    """Zanele, the club captain: a simple comic figure (head, braids, school blazer)."""
    svg.add(f'<rect x="{cx - 22 * s}" y="{cy + 18 * s}" width="{44 * s}" height="{50 * s}" rx="{10 * s}" fill="#1e3a8a" stroke="{INK}" stroke-width="3"/>')
    svg.add(f'<path d="M{cx - 6 * s} {cy + 18 * s} L{cx} {cy + 34 * s} L{cx + 6 * s} {cy + 18 * s}" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    svg.add(f'<circle cx="{cx}" cy="{cy}" r="{20 * s}" fill="#8d5a3b" stroke="{INK}" stroke-width="3"/>')
    for dx in (-17, -11, 11, 17):
        svg.add(f'<path d="M{cx + dx * s} {cy - 8 * s} v{30 * s}" stroke="{INK}" stroke-width="{4 * s}" stroke-linecap="round"/>')
    svg.add(f'<path d="M{cx - 20 * s} {cy - 4 * s} Q{cx} {cy - 30 * s} {cx + 20 * s} {cy - 4 * s}" fill="{INK}"/>')
    for dx in (-7, 7):
        svg.add(f'<circle cx="{cx + dx * s}" cy="{cy + 2 * s}" r="{2.4 * s}" fill="{INK}"/>')
    svg.add(f'<path d="M{cx - 6 * s} {cy + 9 * s} Q{cx} {cy + 14 * s} {cx + 6 * s} {cy + 9 * s}" fill="none" stroke="{INK}" stroke-width="2" stroke-linecap="round"/>')


def boxy(svg, cx, cy, s=1.0, eye='#ffe14d'):
    """Boxy, the club's cardboard robot."""
    svg.add(f'<rect x="{cx - 24 * s}" y="{cy - 40 * s}" width="{48 * s}" height="{36 * s}" rx="{4 * s}" fill="#d9a066" stroke="{INK}" stroke-width="3"/>')
    for dx in (-10, 10):
        svg.add(f'<rect x="{cx + dx * s - 6 * s}" y="{cy - 30 * s}" width="{12 * s}" height="{10 * s}" fill="{INK}"/>')
        svg.add(f'<rect x="{cx + dx * s - 2 * s}" y="{cy - 27 * s}" width="{4 * s}" height="{4 * s}" fill="{eye}"/>')
    svg.add(f'<path d="M{cx} {cy - 40 * s} v{-12 * s}" stroke="{INK}" stroke-width="3"/><circle cx="{cx}" cy="{cy - 54 * s}" r="{5 * s}" fill="{RED}" stroke="{INK}" stroke-width="2"/>')
    svg.add(f'<rect x="{cx - 30 * s}" y="{cy - 2 * s}" width="{60 * s}" height="{40 * s}" rx="{4 * s}" fill="#c88a50" stroke="{INK}" stroke-width="3"/>')
    svg.add(f'<rect x="{cx - 12 * s}" y="{cy + 8 * s}" width="{24 * s}" height="{14 * s}" fill="#f6efe3" stroke="{INK}" stroke-width="2"/>')
    svg.add(f'<path d="M{cx - 30 * s} {cy + 8 * s} l{-16 * s} {12 * s}M{cx + 30 * s} {cy + 8 * s} l{16 * s} {-12 * s}" stroke="#c88a50" stroke-width="{8 * s}" stroke-linecap="round"/>')
    svg.add(f'<rect x="{cx - 34 * s}" y="{cy + 2 * s}" width="{14 * s}" height="{6 * s}" fill="#e8d9a8" opacity=".9" transform="rotate(-20 {cx - 27 * s} {cy + 5 * s})"/>')


def iso(svg, x, y, w, d, h, kind, label=None, label_side='left'):
    """An isometric block: (x, y) is the top corner of its top face; w along the right-down axis, d along the left-down axis."""
    top, left, right = BLOCK[kind]
    cx, sx = 0.866, 0.5
    p0 = (x, y)
    p1 = (x + w * cx, y + w * sx)
    p2 = (x + w * cx - d * cx, y + w * sx + d * sx)
    p3 = (x - d * cx, y + d * sx)
    pts = lambda ps: ' '.join(f'{px:.1f},{py:.1f}' for px, py in ps)
    svg.add(f'<polygon points="{pts([p3, p2, (p2[0], p2[1] + h), (p3[0], p3[1] + h)])}" fill="{left}" stroke="{INK}" stroke-width="2"/>')
    svg.add(f'<polygon points="{pts([p2, p1, (p1[0], p1[1] + h), (p2[0], p2[1] + h)])}" fill="{right}" stroke="{INK}" stroke-width="2"/>')
    svg.add(f'<polygon points="{pts([p0, p1, p2, p3])}" fill="{top}" stroke="{INK}" stroke-width="2"/>')
    if label:
        # The tag name on the block's own top face, so it never runs off the picture.
        light = kind in ('base', 'head', 'list', 'table')
        if light:
            # A container's label in its free corner (far along w, near the back), where nothing stacks on it.
            fa, fb = 0.86 * w, 0.12 * d
            mx, my = x + (fa - fb) * 0.866, y + (fa + fb) * 0.5
        else:
            mx, my = (p0[0] + p2[0]) / 2, (p0[1] + p2[1]) / 2
        svg.add(f'<text x="{mx:.1f}" y="{my + 4:.1f}" font-family="{CODE}" font-size="13" font-weight="700" fill="{INK if light else WHITE}" '
                f'text-anchor="middle" transform="rotate(30 {mx:.1f} {my:.1f})">{esc(label)}</text>')


# ------------------------------------------------------------- figures ----

def strip_lesson1():
    s = Svg(600, 250, 'Comic: Zanele asks for a website; Tag and Gat introduce themselves')
    panel(s, 8, 8, 190, 234, YELLOW); panel(s, 205, 8, 190, 234, SKY); panel(s, 402, 8, 190, 234, PINK)
    zanele(s, 103, 150, 1.2)
    bubble(s, 20, 20, 166, 70, ['The Club Expo is in', 'three weeks - and', 'we have no website!'], 103, 110, 12)
    tag(s, 265, 160, 1.4); gat(s, 335, 160, 1.4)
    bubble(s, 217, 20, 166, 70, ['We are Tag and Gat.', 'We hold every bit', 'of a web page.'], 300, 120, 12)
    tag(s, 436, 175, 1.0, 'wow')
    s.add(f'<rect x="460" y="158" width="92" height="34" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    s.text(506, 180, 'Robotics', 11, INK, SHOUT, 'middle')
    gat(s, 570, 175, 1.0, 'happy')
    bubble(s, 414, 20, 166, 70, ['Whatever we hold', 'between us, the', 'browser shows.'], 500, 130, 12)
    s.save('strip-01')


def on(top_x, top_y, a, b, w, d, h, kind, label=None, side='left', svg=None):
    """A block sitting on a surface whose top corner is (top_x, top_y): a along the right-down axis, b along the left-down axis. Gives back its own top corner."""
    x = top_x + (a - b) * 0.866
    y = top_y + (a + b) * 0.5 - h
    iso(svg, x, y, w, d, h, kind, label, side)
    return x, y


def skeleton():
    s = Svg(600, 340, 'The skeleton of a page as stacked blocks: html at the bottom, head and body on it, title on the head')
    bx, by = 300, 70
    iso(s, bx, by, 250, 210, 22, 'base', '<html>', 'right')
    hx, hy = on(bx, by, 20, 20, 110, 60, 18, 'head', '<head>', 'left', s)
    on(hx, hy, 15, 12, 55, 30, 14, 'heading', '<title>', 'left', s)
    on(bx, by, 20, 100, 210, 90, 18, 'base', '<body>', 'right', s)
    tag(s, 70, 280, 1.0); gat(s, 130, 280, 1.0)
    s.text(100, 328, 'html holds everything', 13, INK, SPEECH, 'middle', 600)
    s.save('skeleton')


def headings_blocks():
    s = Svg(600, 340, 'Blocks on the body: a big h1 block, a text block, a smaller h2 block and another text block')
    bx, by = 300, 40
    iso(s, bx, by, 290, 230, 20, 'base', '<body>', 'right')
    on(bx, by, 20, 15, 200, 32, 22, 'heading', '<h1>', 'left', s)
    on(bx, by, 20, 62, 190, 40, 10, 'text', '<p>', 'left', s)
    on(bx, by, 20, 118, 150, 26, 15, 'heading', '<h2>', 'left', s)
    on(bx, by, 20, 160, 190, 40, 10, 'text', '<p>', 'left', s)
    s.save('headings')


def list_blocks():
    s = Svg(600, 340, 'A list block on the body with three list item blocks stacked on it')
    bx, by = 300, 60
    iso(s, bx, by, 270, 210, 18, 'base', '<body>', 'right')
    ux, uy = on(bx, by, 30, 40, 185, 120, 14, 'list', '<ul>', 'left', s)
    for i in range(3):
        on(ux, uy, 15, 14 + i * 34, 130, 22, 10, 'text', '<li>' if i == 0 else None, 'right', s)
    s.save('lists')


def gat_lost():
    s = Svg(220, 170, 'Tag alone and worried: Gat is missing')
    tag(s, 70, 95, 1.6, 'worried')
    s.text(120, 70, '?', 46, GAT_PINK, SHOUT)
    s.text(150, 120, '?', 30, GAT_PINK, SHOUT)
    s.save('gat-lost')


def tag_shout():
    s = Svg(240, 170, 'Tag shouting through a megaphone')
    tag(s, 60, 100, 1.5, 'shout')
    s.add(f'<path d="M92 92 L160 62 L160 132 L92 108Z" fill="{YELLOW}" stroke="{INK}" stroke-width="3"/>')
    for i, (dx, dy) in enumerate([(176, 70), (186, 97), (176, 124)]):
        s.add(f'<path d="M{dx} {dy} l20 {(-8, 0, 8)[i]}" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    s.save('tag-shout')


def pair_wave():
    s = Svg(220, 160, 'Tag and Gat waving hello')
    tag(s, 75, 85, 1.5); gat(s, 145, 85, 1.5)
    s.add(f'<path d="M40 40 q-10 -14 6 -18M180 40 q10 -14 -6 -18" fill="none" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    s.save('pair-wave')


def pair_hold():
    s = Svg(260, 150, 'Tag and Gat holding the word Robotics between them')
    tag(s, 40, 75, 1.3)
    s.add(f'<rect x="70" y="55" width="120" height="40" fill="{YELLOW}" stroke="{INK}" stroke-width="3"/>')
    s.text(130, 81, 'Robotics', 14, INK, SHOUT, 'middle')
    gat(s, 220, 75, 1.3)
    s.save('pair-hold')


def boxy_doodle():
    s = Svg(180, 170, 'Boxy, the Robotics Club robot')
    boxy(s, 90, 100, 1.2)
    s.save('boxy')


# ----------------------------------------------- the club's own pictures ----

def club_pictures():
    os.makedirs(PICS, exist_ok=True)
    s = Svg(400, 300, 'Boxy the robot')
    s.add(f'<rect width="400" height="300" fill="{SKY}"/>')
    s.add(f'<rect y="230" width="400" height="70" fill="#9ad08c"/>')
    boxy(s, 200, 180, 2.2)
    with open(os.path.join(PICS, 'boxy.svg'), 'w', encoding='utf-8') as f: f.write(s.svg())
    s = Svg(400, 300, 'A robot on a workbench being built')
    s.add(f'<rect width="400" height="300" fill="{YELLOW}"/>')
    s.add(f'<rect x="20" y="200" width="360" height="20" fill="#a0703f" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<rect x="150" y="110" width="110" height="80" rx="8" fill="#9aa6c0" stroke="{INK}" stroke-width="3"/>')
    for wx in (165, 245):
        s.add(f'<circle cx="{wx}" cy="195" r="16" fill="{INK}"/><circle cx="{wx}" cy="195" r="6" fill="#9aa6c0"/>')
    s.add(f'<path d="M205 110 V70 L250 50" stroke="{INK}" stroke-width="9" fill="none" stroke-linecap="round"/><circle cx="252" cy="49" r="9" fill="{RED}" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<path d="M60 195 l40 -60 8 6 -38 58z" fill="#cfcfcf" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<rect x="300" y="150" width="50" height="40" fill="#2ec4b6" stroke="{INK}" stroke-width="3"/>')
    with open(os.path.join(PICS, 'build.svg'), 'w', encoding='utf-8') as f: f.write(s.svg())
    s = Svg(400, 300, 'A gold trophy shaped like a cog')
    s.add(f'<rect width="400" height="300" fill="{PINK}"/>')
    cx, cy = 200, 120
    teeth = ' '.join(f'{cx + (62 if i % 2 == 0 else 48) * math.cos(i * math.pi / 8):.1f},{cy + (62 if i % 2 == 0 else 48) * math.sin(i * math.pi / 8):.1f}' for i in range(16))
    s.add(f'<polygon points="{teeth}" fill="#f5c542" stroke="{INK}" stroke-width="4"/><circle cx="{cx}" cy="{cy}" r="20" fill="{PINK}" stroke="{INK}" stroke-width="4"/>')
    s.add(f'<rect x="185" y="180" width="30" height="40" fill="#f5c542" stroke="{INK}" stroke-width="4"/><rect x="150" y="220" width="100" height="30" fill="#7a4b2a" stroke="{INK}" stroke-width="4"/>')
    with open(os.path.join(PICS, 'trophy.svg'), 'w', encoding='utf-8') as f: f.write(s.svg())
    print('club pictures:', os.listdir(PICS))


def strip(name, label, panels):
    """A three-panel strip. Each panel: (colour, who, mood, bubble lines). who: 'zanele', 'tag', 'gat', 'pair', 'boxy'."""
    s = Svg(600, 250, label)
    for i, (colour, who, mood, lines) in enumerate(panels):
        x = 8 + i * 197
        panel(s, x, 8, 190, 234, colour)
        cx = x + 95
        if who == 'zanele':
            zanele(s, cx, 160, 1.15)
        elif who == 'tag':
            tag(s, cx, 175, 1.5, mood)
        elif who == 'gat':
            gat(s, cx, 175, 1.5, mood)
        elif who == 'pair':
            tag(s, cx - 34, 175, 1.3, mood); gat(s, cx + 34, 175, 1.3, mood)
        elif who == 'boxy':
            boxy(s, cx, 185, 1.1)
        bubble(s, x + 12, 20, 166, 18 + 17 * len(lines), lines, cx, 122 if who != 'zanele' else 126, 12)
    s.save(name)


def picture_block():
    s = Svg(600, 340, 'An img block on the body: an empty tag, with src saying which picture and alt saying what it shows')
    bx, by = 300, 60
    iso(s, bx, by, 270, 210, 18, 'base', '<body>', 'right')
    ix, iy = on(bx, by, 40, 40, 120, 90, 40, 'image', '<img>', 'left', s)
    s.text(40, 300, 'src="boxy.png"  - which picture', 14, INK, CODE, 'start', 700)
    s.text(40, 324, 'alt="Boxy waving" - what it shows', 14, INK, CODE, 'start', 700)
    s.save('picture')


def link_chain():
    s = Svg(240, 160, 'Two chain links joined: a link joins your page to another one')
    s.add(f'<rect x="30" y="58" width="100" height="44" rx="22" fill="none" stroke="{INK}" stroke-width="13"/>')
    s.add(f'<rect x="30" y="58" width="100" height="44" rx="22" fill="none" stroke="#3b82f6" stroke-width="7"/>')
    s.add(f'<rect x="110" y="58" width="100" height="44" rx="22" fill="none" stroke="{INK}" stroke-width="13"/>')
    s.add(f'<rect x="110" y="58" width="100" height="44" rx="22" fill="none" stroke="{GAT_PINK}" stroke-width="7"/>')
    s.save('link')


def table_blocks():
    s = Svg(600, 340, 'A table block with three row blocks on it, each row holding cell blocks')
    bx, by = 300, 50
    iso(s, bx, by, 280, 220, 18, 'base', '<body>', 'right')
    tx, ty = on(bx, by, 30, 30, 200, 160, 12, 'table', '<table>', 'left', s)
    for r in range(3):
        rx, ry = on(tx, ty, 12, 12 + r * 48, 150, 36, 8, 'list', '<tr>' if r == 0 else None, 'left', s)
        for c in range(3):
            on(rx, ry, 8 + c * 48, 6, 40, 24, 8, 'text', '<td>' if (r == 0 and c == 0) else None, 'left', s)
    s.save('table')


def paint():
    s = Svg(220, 170, 'Gat with a paint brush, a splash of navy and yellow')
    s.add(f'<path d="M120 40 q40 -10 60 20 q10 30 -30 40 q-40 10 -50 -20z" fill="navy" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<circle cx="168" cy="118" r="14" fill="yellow" stroke="{INK}" stroke-width="3"/>')
    gat(s, 70, 95, 1.5, 'happy')
    s.add(f'<path d="M96 70 l40 -30" stroke="#a0703f" stroke-width="7" stroke-linecap="round"/><path d="M136 40 l12 -10" stroke="navy" stroke-width="9" stroke-linecap="round"/>')
    s.save('paint')


def camera():
    s = Svg(220, 170, 'Tag describing a photo out loud, for people who cannot see it')
    s.add(f'<rect x="110" y="50" width="90" height="70" fill="{SKY}" stroke="{INK}" stroke-width="3"/><circle cx="155" cy="85" r="18" fill="#d9a066" stroke="{INK}" stroke-width="3"/>')
    tag(s, 60, 95, 1.4, 'shout')
    for i, (dx, dy) in enumerate([(92, 60), (96, 92), (92, 124)]):
        s.add(f'<path d="M{dx} {dy} l10 {(-6, 0, 6)[i]}" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    s.save('alt')


def strips():
    strip('strip-02', 'Comic: Zanele wants a big title; Tag shouts the h1; Gat says paragraphs hold the words', [
        (YELLOW, 'zanele', 'happy', ['People must see', 'the club name', 'from far away.']),
        (SKY, 'tag', 'shout', ['THAT IS A JOB', 'FOR H1 -', 'THE LOUDEST!']),
        (PINK, 'gat', 'happy', ['And the rest of', 'the words go in', 'paragraphs, <p>.']),
    ])
    strip('strip-03', 'Comic: Zanele lists what the club does; Tag and Gat show a list is a block of items', [
        (YELLOW, 'zanele', 'happy', ['We do three', 'things. And joining', 'takes three steps.']),
        (SKY, 'pair', 'happy', ['Things in any', 'order: bullets.', 'Steps: numbers.']),
        (PINK, 'boxy', 'happy', ['Beep. List', 'items live inside', 'the list.']),
    ])
    strip('strip-04', 'Comic: Zanele wants Boxy on the page; Tag explains alt text', [
        (YELLOW, 'zanele', 'happy', ['Boxy has to be', 'on the page.', 'Everyone loves him.']),
        (SKY, 'boxy', 'happy', ['Beep! Make my', 'good side', 'show, please.']),
        (PINK, 'tag', 'shout', ['ALT TEXT SAYS', 'WHAT A PICTURE', 'SHOWS - ALOUD!']),
    ])
    strip('strip-05', 'Comic: Zanele wants people to get in touch; Gat explains links', [
        (YELLOW, 'zanele', 'happy', ['How will people', 'find the school,', 'or email us?']),
        (SKY, 'gat', 'happy', ['With links. Click,', 'and you jump to', 'another page.']),
        (PINK, 'tag', 'worried', ['Never "click', 'here". Say where', 'the link goes!']),
    ])
    strip('strip-06', 'Comic: Zanele has the competition dates; Tag and Gat build a table row by row', [
        (YELLOW, 'zanele', 'happy', ['Three competitions,', 'each with a date', 'and a place.']),
        (SKY, 'pair', 'happy', ['That is a table:', 'rows across,', 'cells in each row.']),
        (PINK, 'boxy', 'happy', ['Beep. Rows', 'first, then', 'the cells.']),
    ])
    strip('strip-07', 'Comic: Zanele wants the club colours; Gat paints with the style attribute', [
        (YELLOW, 'zanele', 'happy', ['Our colours are', 'navy and yellow.', 'Can we add them?']),
        (SKY, 'gat', 'happy', ['Yes - with style.', 'It goes inside', 'the opening tag.']),
        (PINK, 'tag', 'worried', ['But keep it', 'readable. Yellow', 'on white? No!']),
    ])
    strip('strip-08', 'Comic: the Expo is tomorrow; Zanele hands over the brief', [
        (YELLOW, 'zanele', 'happy', ['The Expo is', 'tomorrow. Here is', 'my final list.']),
        (SKY, 'pair', 'wow', ['Everything we', 'know, on one', 'page. Let us go!']),
        (PINK, 'boxy', 'happy', ['Beep. Do not', 'forget the', 'trophies.']),
    ])


def main():
    strips()
    picture_block()
    link_chain()
    table_blocks()
    paint()
    camera()
    strip_lesson1()
    skeleton()
    headings_blocks()
    list_blocks()
    gat_lost()
    tag_shout()
    pair_wave()
    pair_hold()
    boxy_doodle()
    club_pictures()


main()
