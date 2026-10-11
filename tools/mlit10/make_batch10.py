"""Batch 10 (Room Rescue) art for the Grade 10 Maths Literacy course.

Theme A: blueprint + flat-pack - white lines on blueprint blue, dimension
text in mono; flat-pack line drawings. The PLANS are exact: 1 : 100, drawn
at CM = 40 units to the centimetre, so the on-screen ruler (planRuler in
public/assets/mlit-tryit.js, data-cm="40") measures them truly. The room is
8,0 m x 6,0 m inside. Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch10.py
"""
import math, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, SIGN, INK, RED, BLUE, WHITE, NUM, MARKER, MONO
from make_jokes import jcard, face

BLUE_BG, GRIDLINE, PALE = '#1f4e93', '#2c5aa0', '#cfe0f5'
CM = 40                       # drawing units per centimetre on the paper
M = CM                        # at 1 : 100, one metre is one centimetre


def blueprint(name, w, h, label, grid=True):
    svg = Svg(name, w, h, label, bg=BLUE_BG, rx=4)
    if grid:
        for x in range(0, w + 1, CM // 2):
            svg.add(f'<path d="M{x} 0 V{h}" stroke="{GRIDLINE}" stroke-width=".6"/>')
        for y in range(0, h + 1, CM // 2):
            svg.add(f'<path d="M0 {y} H{w}" stroke="{GRIDLINE}" stroke-width=".6"/>')
    return svg


def classroom(name, dims, label):
    """Classroom 10B, 8,0 m x 6,0 m inside, at 1 : 100 (1 cm = 1 m = 40 units)."""
    w, h = 600, 440
    svg = blueprint(name, w, h, label)
    ox, oy = 120, 92                        # the inside top-left corner
    X = lambda m: ox + m * M
    Y = lambda m: oy + m * M
    t = 0.2 * M                             # wall thickness 0,2 m
    svg.text(w / 2, 32, 'CLASSROOM 10B - FLOOR PLAN', 15, WHITE, 'middle', 700, MONO)
    # walls (outer and inner outline), with gaps for the door and windows drawn over
    svg.add(f'<path d="M{X(0) - t} {Y(0) - t} H{X(8) + t} V{Y(6) + t} H{X(0) - t} Z M{X(0)} {Y(0)} V{Y(6)} H{X(8)} V{Y(0)} Z" fill="{WHITE}" fill-rule="evenodd"/>')
    # windows: 1,0-3,0 m and 5,0-7,0 m on the top wall
    for a, b in [(1, 3), (5, 7)]:
        svg.add(f'<rect x="{X(a)}" y="{Y(0) - t}" width="{(b - a) * M}" height="{t}" fill="{BLUE_BG}"/>'
                f'<path d="M{X(a)} {Y(0) - t / 2 - 2} H{X(b)} M{X(a)} {Y(0) - t / 2 + 2} H{X(b)}" stroke="{WHITE}" stroke-width="1.4"/>'
                f'<path d="M{X(a)} {Y(0) - t} V{Y(0)} M{X(b)} {Y(0) - t} V{Y(0)}" stroke="{WHITE}" stroke-width="1.4"/>')
    # door: 1,0-1,9 m on the bottom wall, opening inwards
    svg.add(f'<rect x="{X(1)}" y="{Y(6)}" width="{0.9 * M}" height="{t}" fill="{BLUE_BG}"/>'
            f'<path d="M{X(1)} {Y(6)} V{Y(6) - 0.9 * M}" stroke="{WHITE}" stroke-width="2"/>'
            f'<path d="M{X(1)} {Y(6) - 0.9 * M} A{0.9 * M} {0.9 * M} 0 0 1 {X(1.9)} {Y(6)}" fill="none" stroke="{WHITE}" stroke-width="1.2" stroke-dasharray="4 3"/>')
    # cupboard 0,6 x 2,4 m against the left wall, 1,5 m from the top
    svg.add(f'<rect x="{X(0)}" y="{Y(1.5)}" width="{0.6 * M}" height="{2.4 * M}" fill="none" stroke="{WHITE}" stroke-width="1.6"/>'
            f'<path d="M{X(0)} {Y(1.5)} L{X(0.6)} {Y(3.9)} M{X(0.6)} {Y(1.5)} L{X(0)} {Y(3.9)}" stroke="{WHITE}" stroke-width=".8"/>')
    # teacher's desk 1,6 x 0,8 m
    svg.add(f'<rect x="{X(5.6)}" y="{Y(0.8)}" width="{1.6 * M}" height="{0.8 * M}" fill="none" stroke="{WHITE}" stroke-width="1.6"/>')
    svg.text(X(6.4), Y(1.2) + 4, 'DESK', 9, WHITE, 'middle', 600, MONO)
    # learner tables: 2 rows of 3, each 1,2 x 0,6 m
    for r in range(2):
        for c in range(3):
            x, y = 1.4 + c * 1.8, 2.4 + r * 1.4
            svg.add(f'<rect x="{X(x)}" y="{Y(y)}" width="{1.2 * M}" height="{0.6 * M}" fill="none" stroke="{PALE}" stroke-width="1.2"/>')
    # reading-corner rug: a quarter circle, radius 1,5 m, in the bottom-right corner
    svg.add(f'<path d="M{X(8)} {Y(4.5)} A{1.5 * M} {1.5 * M} 0 0 0 {X(6.5)} {Y(6)} L{X(8)} {Y(6)} Z" fill="none" stroke="#ffd166" stroke-width="2"/>')
    svg.text(X(7.45), Y(5.55), 'RUG', 9, '#ffd166', 'middle', 600, MONO)
    if dims:
        def dim_h(a, b, y, text):
            svg.add(f'<path d="M{X(a)} {y} H{X(b)} M{X(a)} {y - 5} V{y + 5} M{X(b)} {y - 5} V{y + 5}" stroke="{PALE}" stroke-width="1"/>')
            svg.text((X(a) + X(b)) / 2, y - 5, text, 11, WHITE, 'middle', 600, MONO)
        def dim_v(a, b, x, text):
            svg.add(f'<path d="M{x} {Y(a)} V{Y(b)} M{x - 5} {Y(a)} H{x + 5} M{x - 5} {Y(b)} H{x + 5}" stroke="{PALE}" stroke-width="1"/>')
            svg.text(x - 8, (Y(a) + Y(b)) / 2 + 4, text, 11, WHITE, 'end', 600, MONO)
        dim_h(0, 8, Y(6) + 34, '8 000')
        dim_v(0, 6, X(0) - 26, '6 000')
        dim_h(1, 3, Y(0) - 22, '2 000')
        dim_h(5, 7, Y(0) - 22, '2 000')
    # scale and key
    by = h - 22
    svg.text(X(0) - t, by - 14, 'Scale 1 : 100' + ('   (dimensions in mm)' if dims else ''), 11, WHITE, 'start', 600, MONO)
    for k in range(5):
        svg.add(f'<rect x="{X(0) - t + k * M}" y="{by - 6}" width="{M}" height="6" fill="{WHITE if k % 2 == 0 else BLUE_BG}" stroke="{WHITE}"/>')
    svg.text(X(0) - t + 5 * M + 8, by, '5 m', 10, WHITE, 'start', 600, MONO)
    svg.save()


def lshape():
    """An L-shaped notice board: a 3 000 x 2 000 mm rectangle with a 1 000 x 1 000 mm corner cut out (top right)."""
    w, h = 420, 300
    svg = blueprint('lshape', w, h, 'An L-shaped notice board: 3 000 mm along the bottom, 2 000 mm up the left side, with a 1 000 by 1 000 mm square cut out of the top-right corner')
    u = 80                                   # 1 m drawn 80 units here (not to scale with the ruler)
    ox, oy = 90, 60
    pts = [(0, 0), (2, 0), (2, 1), (3, 1), (3, 2), (0, 2)]          # metres from the top-left
    d = 'M' + ' L'.join(f'{ox + x * u} {oy + y * u}' for x, y in pts) + ' Z'
    svg.add(f'<path d="{d}" fill="none" stroke="{WHITE}" stroke-width="4" stroke-linejoin="miter"/>')
    def lab(x, y, t, anchor='middle'):
        svg.text(x, y, t, 12, WHITE, anchor, 600, MONO)
    lab(ox + 1.5 * u, oy + 2 * u + 24, '3 000')
    lab(ox - 12, oy + u + 4, '2 000', 'end')
    lab(ox + u, oy - 10, '2 000')
    lab(ox + 2 * u - 10, oy + 0.5 * u + 4, '1 000', 'end')
    lab(ox + 2.5 * u, oy + u - 10, '1 000')
    lab(ox + 3 * u + 10, oy + 1.5 * u + 4, '1 000', 'start')
    svg.text(w / 2, h - 16, 'Notice board (dimensions in mm)', 11, PALE, 'middle', 600, MONO)
    svg.save()


def rug():
    w, h = 360, 300
    svg = blueprint('rug', w, h, 'The reading-corner rug: a quarter of a circle with radius 1,5 m, fitted into the corner of the room')
    r = 180
    cx, cy = 300, 260
    svg.add(f'<path d="M{cx} {cy - r} A{r} {r} 0 0 0 {cx - r} {cy} L{cx} {cy} Z" fill="#ffd166" fill-opacity=".25" stroke="#ffd166" stroke-width="3"/>')
    svg.add(f'<path d="M{cx} {cy} V{cy - r - 10} M{cx} {cy} H{cx - r - 10}" stroke="{WHITE}" stroke-width="5"/>')
    svg.add(f'<path d="M{cx} {cy} L{cx - r * .7071:.1f} {cy - r * .7071:.1f}" stroke="{WHITE}" stroke-width="1.5" stroke-dasharray="5 4"/>')
    svg.text(cx - r * .42, cy - r * .3, 'r = 1,5 m', 13, WHITE, 'middle', 700, MONO, extra='transform="rotate(45 %d %d)"' % (cx - r * .42, cy - r * .3))
    svg.text(cx - 40, 30, 'walls', 11, PALE, 'middle', 600, MONO)
    svg.text(70, 40, 'READING-CORNER RUG', 13, WHITE, 'start', 700, MONO)
    svg.text(70, 58, 'a quarter circle', 11, PALE, 'start', 600, MONO)
    svg.save()


def plan_symbols():
    w, h = 600, 200
    svg = blueprint('plansymbols', w, h, 'Floor-plan symbols: a wall, a window, a door with its swing, a built-in cupboard, and a dimension line', grid=False)
    items = ['WALL', 'WINDOW', 'DOOR', 'CUPBOARD', 'DIMENSION']
    for i, name in enumerate(items):
        x = 20 + i * 116
        svg.add(f'<rect x="{x}" y="20" width="104" height="130" rx="4" fill="none" stroke="{GRIDLINE}" stroke-width="1.5"/>')
        svg.text(x + 52, 172, name, 11, WHITE, 'middle', 700, MONO)
    # wall
    svg.add(f'<rect x="32" y="76" width="80" height="12" fill="{WHITE}"/>')
    # window
    x = 136
    svg.add(f'<rect x="{x + 12}" y="76" width="80" height="12" fill="{WHITE}"/><rect x="{x + 32}" y="76" width="40" height="12" fill="{BLUE_BG}"/>'
            f'<path d="M{x + 32} 80 H{x + 72} M{x + 32} 84 H{x + 72} M{x + 32} 76 V88 M{x + 72} 76 V88" stroke="{WHITE}" stroke-width="1.4"/>')
    # door
    x = 252
    svg.add(f'<rect x="{x + 12}" y="100" width="80" height="12" fill="{WHITE}"/><rect x="{x + 30}" y="100" width="44" height="12" fill="{BLUE_BG}"/>'
            f'<path d="M{x + 30} 100 V56" stroke="{WHITE}" stroke-width="2"/><path d="M{x + 30} 56 A44 44 0 0 1 {x + 74} 100" fill="none" stroke="{WHITE}" stroke-width="1.2" stroke-dasharray="4 3"/>')
    # cupboard
    x = 368
    svg.add(f'<rect x="{x + 22}" y="50" width="60" height="70" fill="none" stroke="{WHITE}" stroke-width="1.6"/><path d="M{x + 22} 50 L{x + 82} 120 M{x + 82} 50 L{x + 22} 120" stroke="{WHITE}" stroke-width=".8"/>')
    # dimension
    x = 484
    svg.add(f'<path d="M{x + 12} 86 H{x + 92} M{x + 12} 80 V92 M{x + 92} 80 V92" stroke="{PALE}" stroke-width="1"/>')
    svg.text(x + 52, 78, '2 400', 11, WHITE, 'middle', 600, MONO)
    svg.save()


def iso(x, y, z, ox, oy, k=1.0):
    """An isometric point: x right-down, y left-down, z up."""
    return (ox + (x - y) * 0.866 * k, oy + (x + y) * 0.5 * k - z * k)


def box3d(svg, ox, oy, sx, sy, sz, k, fill=WHITE, stroke=INK, x0=0, y0=0, z0=0, sw=2):
    P = lambda x, y, z: iso(x0 + x, y0 + y, z0 + z, ox, oy, k)
    def poly(pts, f):
        svg.add('<path d="M' + ' L'.join(f'{a:.1f} {b:.1f}' for a, b in pts) + f' Z" fill="{f}" stroke="{stroke}" stroke-width="{sw}" stroke-linejoin="round"/>')
    poly([P(0, 0, sz), P(sx, 0, sz), P(sx, sy, sz), P(0, sy, sz)], fill)          # top
    poly([P(sx, 0, 0), P(sx, sy, 0), P(sx, sy, sz), P(sx, 0, sz)], '#e6ecf3')     # right
    poly([P(0, sy, 0), P(sx, sy, 0), P(sx, sy, sz), P(0, sy, sz)], '#cdd8e5')     # front


def flatpack():
    """A flat-pack bookshelf: the parts list and three assembly steps, in plain line drawings."""
    w, h = 640, 360
    svg = Svg('flatpack', w, h, 'Assembly instructions for a flat-pack bookshelf: parts A side panel x2, B shelf x4, C back panel x1, D screw x16, E wooden dowel x8; step 1 push dowels into the sides, step 2 screw the shelves between the sides, step 3 nail the back panel on', bg=WHITE, rx=4)
    svg.add(f'<rect x="6" y="6" width="{w - 12}" height="{h - 12}" fill="none" stroke="{INK}" stroke-width="1.5"/>')
    svg.text(24, 34, 'BOKAAP BOOKSHELF - ASSEMBLY', 14, INK, 'start', 700, MONO)
    # parts list
    parts = [('A', 'side panel', 2), ('B', 'shelf', 4), ('C', 'back panel', 1), ('D', 'screw', 16), ('E', 'dowel', 8)]
    for i, (code, name, n) in enumerate(parts):
        y = 70 + i * 26
        svg.add(f'<circle cx="34" cy="{y - 4}" r="10" fill="none" stroke="{INK}" stroke-width="1.5"/>')
        svg.text(34, y, code, 11, INK, 'middle', 700, MONO)
        svg.text(52, y, f'{name}', 11, INK, 'start', 400, MONO)
        svg.text(170, y, f'x{n}', 12, INK, 'end', 700, MONO)
    svg.add(f'<path d="M190 50 V330" stroke="#9aa5ad" stroke-width="1" stroke-dasharray="4 3"/>')
    # step boxes
    for i in range(3):
        x = 204 + i * 142
        svg.add(f'<rect x="{x}" y="50" width="130" height="280" rx="6" fill="none" stroke="#9aa5ad" stroke-width="1.2"/>')
        svg.add(f'<circle cx="{x + 18}" cy="70" r="12" fill="{INK}"/>')
        svg.text(x + 18, 75, str(i + 1), 13, WHITE, 'middle', 700, MONO)
    # step 1: a side panel lying flat with dowels going in
    box3d(svg, 270, 150, 30, 110, 6, 0.9)
    for k in range(4):
        px, py = iso(15, 15 + k * 26, 6, 270, 150, 0.9)
        svg.add(f'<path d="M{px:.1f} {py - 34:.1f} V{py - 6:.1f}" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>'
                f'<path d="M{px:.1f} {py - 44:.1f} v6 m-4 -4 l4 4 l4 -4" stroke="{INK}" stroke-width="1.2" fill="none"/>')
    svg.text(268, 300, 'A + E x4', 11, INK, 'middle', 700, MONO)
    svg.text(268, 316, '(each side)', 10, '#5b6670', 'middle', 400, MONO)
    # step 2: two sides standing with shelves between
    ox2, oy2 = 368, 250
    for side in (0, 70):
        box3d(svg, ox2, oy2, 6, 30, 130, 0.9, x0=side)
    for k in range(4):
        box3d(svg, ox2, oy2, 64, 30, 4, 0.9, x0=6, z0=10 + k * 34, sw=1.4)
    sx, sy = iso(76, 15, 112, ox2, oy2, 0.9)
    svg.add(f'<path d="M{sx + 26:.1f} {sy:.1f} h-18 m4 -4 l-4 4 l4 4" stroke="{INK}" stroke-width="1.4" fill="none"/>')
    svg.text(sx + 30, sy + 4, 'D', 11, INK, 'start', 700, MONO)
    svg.text(410, 300, 'B x4 + D x16', 11, INK, 'middle', 700, MONO)
    # step 3: the back panel on
    ox3, oy3 = 498, 250
    for side in (0, 70):
        box3d(svg, ox3, oy3, 6, 30, 130, 0.9, x0=side)
    box3d(svg, ox3, oy3, 76, 2, 130, 0.9, y0=30, fill='#f3e9d2', sw=1.4)
    svg.text(552, 300, 'C x1', 11, INK, 'middle', 700, MONO)
    svg.save()


def truck():
    """The back of the bakkie, seen from above: 2,4 m x 1,6 m, with boxes of 0,6 m x 0,4 m packed two ways."""
    w, h = 640, 300
    svg = blueprint('truck', w, h, 'Two ways to pack boxes of 0,6 m by 0,4 m onto a bakkie floor of 2,4 m by 1,6 m, seen from above: Way A fits 16 boxes; Way B, with the boxes turned, fits only 12 and leaves a strip empty', grid=False)
    u = 100                                   # 1 m drawn 100 units
    for i, (title, bw, bd) in enumerate([('WAY A', 0.6, 0.4), ('WAY B', 0.4, 0.6)]):
        ox, oy = 30 + i * 310, 60
        svg.text(ox, 40, title, 13, WHITE, 'start', 700, MONO)
        svg.add(f'<rect x="{ox}" y="{oy}" width="{2.4 * u}" height="{1.6 * u}" fill="none" stroke="{WHITE}" stroke-width="3"/>')
        nx, ny = int(round(2.4 / bw, 6) // 1), int(round(1.6 / bd, 6) // 1)
        for a in range(nx):
            for b in range(ny):
                svg.add(f'<rect x="{ox + a * bw * u + 2}" y="{oy + b * bd * u + 2}" width="{bw * u - 4}" height="{bd * u - 4}" fill="#ffd166" fill-opacity=".85" stroke="{BLUE_BG}" stroke-width="1"/>')
        svg.text(ox + 1.2 * u, oy + 1.6 * u + 24, '2,4 m', 12, WHITE, 'middle', 600, MONO)
        svg.text(ox + 2.4 * u + 10, oy + 0.8 * u + 4, '1,6 m', 12, WHITE, 'start', 600, MONO)
    svg.text(w / 2, h - 18, 'One box (seen from above): 0,6 m x 0,4 m', 11, PALE, 'middle', 600, MONO)
    svg.save()


def d_tools():
    svg = blueprint('roomtools', 300, 190, 'A paint tin, a roller and a stack of floor tiles, drawn in white on blueprint blue', grid=False)
    svg.add(f'<path d="M40 70 h70 v80 q0 10 -10 10 h-50 q-10 0 -10 -10z" fill="none" stroke="{WHITE}" stroke-width="3"/><ellipse cx="75" cy="70" rx="35" ry="8" fill="none" stroke="{WHITE}" stroke-width="3"/>')
    svg.text(75, 120, '5 L', 14, WHITE, 'middle', 700, MONO)
    svg.add(f'<rect x="130" y="44" width="70" height="22" rx="10" fill="none" stroke="{WHITE}" stroke-width="3"/><path d="M165 66 v20 h-30 v70" fill="none" stroke="{WHITE}" stroke-width="3"/>')
    for k in range(4):
        svg.add(f'<path d="M{214} {150 - k * 12} l30 -14 l30 14 l-30 14 z" fill="{BLUE_BG}" stroke="{WHITE}" stroke-width="2"/>')
    svg.save()


def d_jobdone10():
    svg = Svg('jobdone10', 320, 200, 'Hadi with a JOB DONE stamp after Room Rescue', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Term 3 assessment', 14, INK, 'middle', font=MARKER)
    svg.save()


def jokes10():
    j = jcard('roomedge', 'A skirting board with a face, walking all the way round the edge of a room')
    j.add(f'<rect x="60" y="40" width="180" height="120" fill="none" stroke="{INK}" stroke-width="5"/>')
    j.add(f'<rect x="150" y="146" width="70" height="12" fill="#c98b4a" stroke="{INK}" stroke-width="2"/>')
    face(j, 185, 152, 9)
    j.add(f'<path d="M60 170 H240 M240 170 l-8 -5 M240 170 l-8 5" stroke="{RED}" stroke-width="2.5" fill="none"/>')
    j.save()

    j = jcard('roomfloor', 'A proud floor tile with a face and a graduation cap')
    j.add(f'<path d="M150 70 l70 34 l-70 34 l-70 -34 z" fill="#e8eef6" stroke="{INK}" stroke-width="3"/>')
    face(j, 150, 104, 16)
    j.add(f'<path d="M150 40 l36 14 l-36 14 l-36 -14 z" fill="{INK}"/><path d="M186 54 v18" stroke="{INK}" stroke-width="2"/><circle cx="186" cy="74" r="4" fill="#ffd166"/>')
    j.text(150, 172, 'm²', 18, BLUE, 'middle')
    j.save()

    j = jcard('roomround', 'A dizzy circle with spiral eyes, going round and round')
    j.add(f'<circle cx="150" cy="96" r="56" fill="#ffd166" stroke="{INK}" stroke-width="3"/>')
    for cx in (130, 170):
        j.add(f'<path d="M{cx} 88 m-8 0 a8 8 0 1 1 8 8 a5 5 0 1 1 -5 -5" fill="none" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<path d="M134 122 q16 -8 32 0" stroke="{INK}" stroke-width="2.5" fill="none"/>')
    j.add(f'<path d="M80 40 a80 80 0 0 1 140 0" fill="none" stroke="{RED}" stroke-width="3" stroke-dasharray="6 5"/><path d="M220 40 l-10 -2 M220 40 l-2 -10" stroke="{RED}" stroke-width="3"/>')
    j.save()

    j = jcard('roomplan', 'A very thin window symbol with a face, two lines wide')
    j.add(f'<rect x="40" y="88" width="220" height="22" fill="{INK}"/><rect x="100" y="88" width="100" height="22" fill="#f6c94c"/>'
          f'<path d="M100 95 H200 M100 103 H200" stroke="{INK}" stroke-width="2"/>')
    face(j, 150, 70, 14, 'o')
    j.save()

    j = jcard('roommeasure', 'A ruler wearing a crown, standing proudly')
    j.add(f'<rect x="130" y="60" width="40" height="120" rx="4" fill="#ffe26e" stroke="{INK}" stroke-width="3"/>')
    for k in range(10):
        j.add(f'<path d="M130 {70 + k * 11} h{14 if k % 2 == 0 else 8}" stroke="{INK}" stroke-width="2"/>')
    face(j, 156, 92, 12)
    j.add(f'<path d="M128 56 l6 -24 l10 14 l6 -18 l6 18 l10 -14 l6 24 z" fill="#ffd166" stroke="{INK}" stroke-width="2.5"/>')
    j.save()

    j = jcard('roomdraw', 'A pencil with a face, surrounded by a crowd of little drawn people')
    j.add(f'<path d="M130 40 h40 v100 l-20 30 l-20 -30 z" fill="#ffd166" stroke="{INK}" stroke-width="3"/><path d="M130 140 h40" stroke="{INK}" stroke-width="2"/>')
    face(j, 150, 80, 14)
    for x in (50, 80, 220, 250):
        j.add(f'<g stroke="{INK}" stroke-width="2" fill="none"><circle cx="{x}" cy="120" r="6"/><path d="M{x} 126 v18 m-8 -10 h16 m-12 26 l4 -16 l4 16"/></g>')
    j.save()

    j = jcard('roomflatpack', 'A wobbly bookshelf with a worried face and a loose screw falling out')
    j.add(f'<g transform="rotate(-6 150 110)"><rect x="110" y="40" width="80" height="130" fill="none" stroke="{INK}" stroke-width="4"/>'
          f'<path d="M110 80 h80 M110 120 h80" stroke="{INK}" stroke-width="3"/></g>')
    face(j, 150, 60, 12, 'sad')
    j.add(f'<g transform="rotate(30 230 140)"><path d="M224 120 h12 l-2 6 h-8 z" fill="{INK}"/><path d="M230 126 v22" stroke="{INK}" stroke-width="3"/></g>')
    j.text(240, 96, '!', 22, RED, 'middle')
    j.save()

    j = jcard('roompack', 'A cardboard box with a face, squeezed between two other boxes')
    for x, mood in [(60, 'flat'), (120, 'sad'), (180, 'flat')]:
        j.add(f'<rect x="{x}" y="70" width="{56 if x != 120 else 56}" height="80" fill="#c98b4a" stroke="{INK}" stroke-width="3"/><path d="M{x} 92 h56" stroke="{INK}" stroke-width="1.5"/>')
    face(j, 148, 116, 14, 'sad')
    j.add(f'<path d="M50 110 l10 0 m-4 -4 l4 4 l-4 4 M250 110 l-10 0 m4 -4 l-4 4 l4 4" stroke="{RED}" stroke-width="3" fill="none"/>')
    j.save()


def garden():
    """The garden-club plot: 6 m x 4 m, three beds of 1,5 m x 4 m with 0,75 m paths, a 1 m gate."""
    w, h = 560, 420
    svg = blueprint('garden', w, h, 'Plan of the vegetable garden: a plot 6 000 by 4 000 mm with three beds, each 1 500 by 4 000 mm, separated by paths of 750 mm, and a 1 000 mm gate in the bottom side')
    u = 70
    ox, oy = 70, 50
    X = lambda m: ox + m * u
    Y = lambda m: oy + m * u
    svg.add(f'<rect x="{X(0)}" y="{Y(0)}" width="{6 * u}" height="{4 * u}" fill="none" stroke="{WHITE}" stroke-width="3" stroke-dasharray="10 4"/>')
    for k, x in enumerate([0, 2.25, 4.5]):
        svg.add(f'<rect x="{X(x)}" y="{Y(0)}" width="{1.5 * u}" height="{4 * u}" fill="#2f7d4f" fill-opacity=".55" stroke="{WHITE}" stroke-width="1.5"/>')
        svg.text(X(x + 0.75), Y(2) + 4, f'BED {k + 1}', 11, WHITE, 'middle', 700, MONO)
    svg.add(f'<rect x="{X(1.375)}" y="{Y(4) - 3}" width="{u}" height="6" fill="{BLUE_BG}"/><path d="M{X(1.375)} {Y(4)} l{u * .8:.0f} {-u * .45:.0f}" stroke="#ffd166" stroke-width="3"/>')
    svg.text(X(1.875), Y(4) + 40, 'GATE 1 000', 11, '#ffd166', 'middle', 600, MONO)
    svg.text(X(3), Y(0) - 14, '6 000', 12, WHITE, 'middle', 600, MONO)
    svg.text(X(0) - 12, Y(2) + 4, '4 000', 12, WHITE, 'end', 600, MONO)
    svg.text(X(0.75), Y(4) + 22, '1 500', 11, PALE, 'middle', 600, MONO)
    svg.text(X(1.875), Y(4) + 22, '750', 11, PALE, 'middle', 600, MONO)
    svg.text(w / 2, h - 12, 'Garden club plot (dimensions in mm) - fence along the dashed line', 11, PALE, 'middle', 600, MONO)
    svg.save()


def term3_assessment():
    opener(60, 10, 1, 2, 'Assignment workshop', 'Fence, beds, budget - start to finish.', ['A WHOLE', 'GARDEN!'], 'TERM 3 ASSESSMENT · 1 OF 2')
    opener(61, 10, 2, 2, 'Term 3 test', 'Money, measuring and plans.', ['RULER', 'READY?'], 'TERM 3 ASSESSMENT · 2 OF 2')
    garden()
    j = jcard('assign3', 'A cabbage with a face, sitting proudly in a neat garden bed with a fence')
    j.add(f'<rect x="40" y="120" width="220" height="40" fill="#8a5a3c" stroke="{INK}" stroke-width="3"/>')
    for x in range(40, 270, 22):
        j.add(f'<path d="M{x} 160 V96" stroke="{INK}" stroke-width="3"/>')
    j.add(f'<path d="M36 104 H264 M36 130 H264" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<circle cx="150" cy="96" r="34" fill="#7bc96f" stroke="{INK}" stroke-width="3"/><path d="M126 84 q24 -26 48 0 M132 108 q18 14 36 0" stroke="#2f7d4f" stroke-width="3" fill="none"/>')
    face(j, 150, 96, 14)
    j.save()


if __name__ == '__main__':
    classroom('roomplan', False, 'Floor plan of Classroom 10B at a scale of 1 to 100: the walls, two windows on the top wall, a door on the bottom wall, a cupboard, the teacher\'s desk, six learner tables and a quarter-circle rug in the bottom-right corner; no dimensions are written, so they must be measured')
    classroom('roomplan-dims', True, 'Floor plan of Classroom 10B at a scale of 1 to 100 with dimensions in millimetres: 8 000 by 6 000 inside, two windows of 2 000')
    for o in [(52, 10, 1, 8, 'Around the edge', 'Perimeter: walk the walls.', ['28 M OF', 'SKIRTING']),
              (53, 10, 2, 8, 'Covering the floor', 'Area: count the squares.', ['192', 'TILES!']),
              (54, 10, 3, 8, 'Round bits', 'Pi is 3,142. Every time.', ['A QUARTER', 'OF A RUG']),
              (55, 10, 4, 8, 'Reading a floor plan', 'Lines, arcs and millimetres.', ['DOOR', 'SWINGS IN']),
              (56, 10, 5, 8, 'Measuring on the plan', 'Ruler on, zero on the end.', ['1 CM IS', '1 METRE']),
              (57, 10, 6, 8, 'Draw your own plan', 'Squares to scale.', ['NEW', 'LAYOUT!']),
              (58, 10, 7, 8, 'Flat-pack', 'Parts, steps, and no spare screws.', ['STEP 1:', 'DOWELS']),
              (59, 10, 8, 8, 'Pack the truck', 'Which way round fits more?', ['THE', 'REVEAL!'])]:
        opener(*o)
    lshape(); rug(); plan_symbols(); flatpack(); truck(); d_tools(); d_jobdone10()
    jokes10()
    term3_assessment()
