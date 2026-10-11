"""Draws the Grade 10 Maths Literacy course's art (brand/mlit10-art-style.md).

The frame: hand-painted South African street signage (sign yellow, black
border, red pinstripe, Bungee lettering with a hard drop shadow, the year as a
minibus-taxi route of 12 painted stops) and Hadi the hadeda, drawn the riso
way (no outline, a misregistered purple overprint, grain) in the frame's
colours. Each batch has its own theme for its scenes; batch 1 (Kota Kitchen)
is a chalkboard menu. Only fonts the lesson page already loads are used
(lib/design.php): Bungee, Permanent Marker, Caveat, Patrick Hand.

Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_art.py
"""
import os

DOODLES = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'

# The frame (F2 sign-painter streets)
SIGN, INK, RED, BLUE, WHITE = '#f7c948', '#111111', '#e63b2e', '#1d4fd8', '#ffffff'
# Hadi (riso, F2 colours)
H_BODY, H_WING, H_PURPLE = '#8a7d6e', '#16b37a', '#7b3fe4'
# Batch 1 theme: chalkboard menu
BOARD, WOOD, WOOD_DARK, CHALK, CHALK_DIM, TAG = '#26302b', '#8a5a32', '#5d3b20', '#f2efe6', '#c9c6bb', '#ffd84d'
CHALK_PINK, CHALK_BLUE, CHALK_YELLOW, CHALK_ORANGE = '#f6a6b2', '#9fd3f5', '#ffe58a', '#f9b26b'

BUNGEE = "'Bungee', 'Arial Black', sans-serif"
MARKER = "'Permanent Marker', 'Comic Sans MS', cursive"
CHALKF = "'Caveat', 'Patrick Hand', 'Comic Sans MS', cursive"
HAND = "'Patrick Hand', 'Comic Sans MS', cursive"

BATCHES = ['Kota Kitchen', 'Car Wash', 'Radio 10', "Gogo's Shoebox", 'Plan Wars', 'Bake-Off',
           'Matchday', 'Games Night', 'Trip Fund', 'Room Rescue', 'Weather Watch', 'Road Trip']


def esc(text):
    return text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, name, w, h, label, bg=None, rx=10):
        self.name, self.w, self.h, self.label, self.parts = name, w, h, label, []
        if bg:
            self.add(f'<rect width="{w}" height="{h}" rx="{rx}" fill="{bg}"/>')

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=INK, anchor='start', weight=400, font=BUNGEE, extra=''):
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" font-weight="{weight}" '
                 f'fill="{fill}" text-anchor="{anchor}" {extra}>{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self):
        os.makedirs(DOODLES, exist_ok=True)
        path = os.path.join(DOODLES, 'mlit10-' + self.name + '.svg')
        with open(path, 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print('mlit10-' + self.name + '.svg')


# --------------------------------------------------------------- Hadi ----

def hadi(svg, x, y, s=1.0, mood='talk'):
    """Hadi the hadeda, facing left, about 105 x 78 at s=1, top-left at (x, y).
    Riso: a base layer with no outline, a purple overprint offset up and right,
    and grain clipped to Hadi's own shape (never a box)."""
    gid = f'{svg.name}-hadi-grain'
    svg.add(f'<defs><filter id="{gid}"><feTurbulence baseFrequency=".85" numOctaves="2" seed="5" result="n"/>'
            f'<feColorMatrix in="n" values="0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 .5 0" result="dots"/>'
            f'<feComposite in="dots" in2="SourceGraphic" operator="in" result="d"/>'
            f'<feMerge><feMergeNode in="SourceGraphic"/><feMergeNode in="d"/></feMerge></filter></defs>')

    def body(body, wing, bill, leg, cheek, eye, eye_r=2.1):
        legs = ('M53 56 L51 72 M51 72 L45 75 M51 72 L56 75 M62 56 L64 72 M64 72 L58 75 M64 72 L69 75' if mood != 'fly'
                else 'M58 55 L74 62 M62 55 L78 60')
        bill_path = 'M17 26 Q6 31 1 48' if mood != 'shout' else 'M17 24 Q6 22 -2 30 M17 28 Q8 34 2 44'
        return (f'<path d="M86 40 L104 47 L88 50Z" fill="{body}"/>'
                f'<path d="M30 42 Q34 22 60 23 Q84 25 90 41 Q82 55 58 56 Q38 57 30 42Z" fill="{body}"/>'
                f'<path d="M47 33 Q64 27 80 38 Q66 45 48 42Z" fill="{wing}"/>'
                f'<path d="M33 40 Q26 34 24 27" fill="none" stroke="{body}" stroke-width="9" stroke-linecap="round"/>'
                f'<circle cx="23" cy="25" r="8.5" fill="{body}"/>'
                f'<path d="{bill_path}" fill="none" stroke="{bill}" stroke-width="3.6" stroke-linecap="round"/>'
                f'<path d="M19 28 L28 30" stroke="{cheek}" stroke-width="1.6" stroke-linecap="round"/>'
                + (f'<circle cx="21" cy="23" r="{eye_r}" fill="{eye}"/>' if eye_r else '')
                + f'<path d="{legs}" fill="none" stroke="{leg}" stroke-width="2.2" stroke-linecap="round"/>')

    svg.add(f'<g transform="translate({x} {y}) scale({s})"><g filter="url(#{gid})">'
            + body(H_BODY, H_WING, INK, INK, SIGN, INK) + '</g>'
            + f'<g style="mix-blend-mode:multiply" opacity=".85" transform="translate(4 -3)">'
            + f'<path d="M47 33 Q64 27 80 38 Q66 45 48 42Z" fill="{H_PURPLE}"/>'
            + f'<path d="M17 26 Q6 31 1 48" fill="none" stroke="{H_PURPLE}" stroke-width="2" stroke-linecap="round" opacity=".6"/>'
            + '</g></g>')


def bubble(svg, x, y, w, lines, tail_x, tail_y, size=12, font=BUNGEE, fill=WHITE):
    """A sign-painter speech bubble: white, thick black outline, square-ish corners."""
    h = 12 + len(lines) * (size + 6)
    bx = min(max(tail_x, x + 18), x + w - 18)
    by = y + h if tail_y > y + h else y
    svg.add(f'<path d="M{bx - 8} {by} L{tail_x} {tail_y} L{bx + 8} {by}" fill="{fill}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>')
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="7" fill="{fill}" stroke="{INK}" stroke-width="3"/>')
    svg.add(f'<path d="M{bx - 6} {by} L{bx + 6} {by}" stroke="{fill}" stroke-width="5"/>')
    for i, line in enumerate(lines):
        svg.text(x + w / 2, y + 8 + (i + 1) * (size + 4), line, size, INK, 'middle', font=font)


def shadow_text(svg, x, y, words, size, fill, anchor='start'):
    svg.text(x + 3, y + 3, words, size, INK, anchor)
    svg.text(x, y, words, size, fill, anchor)


def wrap(title, width):
    words, lines, line = title.split(), [], ''
    for w in words:
        if line and len(line) + 1 + len(w) > width:
            lines.append(line)
            line = w
        else:
            line = (line + ' ' + w).strip()
    lines.append(line)
    return lines


# ------------------------------------------------------- lesson openers ----

def opener(n, batch, lesson_in_batch, of, title, slogan, says, kicker=None):
    """A lesson's opening sign: the batch, the lesson title, a slogan, the
    minibus route of the year with this batch's stop circled, and Hadi."""
    svg = Svg(f'open-{n:02d}', 560, 300, f'Lesson {n}: {title}', bg=SIGN, rx=8)
    svg.add(f'<rect x="10" y="10" width="540" height="280" rx="4" fill="none" stroke="{INK}" stroke-width="5"/>')
    svg.add(f'<rect x="18" y="18" width="524" height="264" rx="2" fill="none" stroke="{RED}" stroke-width="2"/>')
    svg.text(36, 50, kicker or f'{BATCHES[batch - 1].upper()} · LESSON {lesson_in_batch} OF {of}', 13, INK)
    lines = wrap(title.upper(), 13)
    if len(lines) > 2:
        lines = wrap(title.upper(), 15)
    if len(lines) > 2:
        lines = wrap(title.upper(), 17)
    longest = max(len(l) for l in lines)
    size = 34 if longest <= 11 else (29 if longest <= 13 else (25 if longest <= 15 else 22))
    for i, line in enumerate(lines):
        shadow_text(svg, 36, 96 + i * (size + 8), line, size, RED if i == 0 else BLUE)
    yy = 96 + len(lines) * (size + 8) - 4
    svg.add(f'<path d="M36 {yy} q30 -10 60 0 t60 0" stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round"/>')
    svg.text(36, yy + 30, slogan, 17, INK, font=MARKER)
    # The route: 12 stops, one per batch
    x0, x1, ry = 44, 516, 254
    svg.add(f'<path d="M{x0} {ry} H{x1}" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>')
    step = (x1 - x0) / 11
    for i in range(12):
        cx = x0 + i * step
        done = i < batch - 1
        here = i == batch - 1
        if here:
            svg.add(f'<circle cx="{cx}" cy="{ry}" r="15" fill="none" stroke="{RED}" stroke-width="3"/>')
        svg.add(f'<circle cx="{cx}" cy="{ry}" r="{10 if here else 8}" fill="{RED if (done or here) else WHITE}" stroke="{INK}" stroke-width="3"/>')
        if here:
            svg.text(cx, ry + 4, str(i + 1), 10, WHITE, 'middle')
    # The minibus at the current stop
    bx = x0 + (batch - 1) * step - 22
    svg.add(f'<g transform="translate({bx} {ry - 38})"><rect x="0" y="0" width="44" height="20" rx="5" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>'
            f'<rect x="4" y="4" width="9" height="7" fill="{BLUE}"/><rect x="16" y="4" width="9" height="7" fill="{BLUE}"/><rect x="28" y="4" width="9" height="7" fill="{BLUE}"/>'
            f'<path d="M0 14 H44" stroke="{RED}" stroke-width="2.5"/>'
            f'<circle cx="10" cy="21" r="4" fill="{INK}"/><circle cx="34" cy="21" r="4" fill="{INK}"/></g>')
    hadi(svg, 372, 112, 1.55)
    bw = max(len(l) for l in says) * 9 + 30
    bubble(svg, 540 - bw - 18, 34, bw, says, 410, 118, size=11)
    svg.save()


# ------------------------------------------------------- chalkboard bits ----

def chalk_defs(svg):
    fid = f'{svg.name}-chalk'
    svg.add(f'<defs><filter id="{fid}" filterUnits="userSpaceOnUse" x="0" y="0" width="{svg.w}" height="{svg.h}"><feTurbulence type="fractalNoise" baseFrequency="1.6" numOctaves="1" seed="3"/>'
            f'<feDisplacementMap in="SourceGraphic" scale="1.6"/></filter></defs>')
    return f'url(#{fid})'


def board(svg, x, y, w, h, frame=10):
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="6" fill="{WOOD}"/>')
    svg.add(f'<rect x="{x + 3}" y="{y + 3}" width="{w - 6}" height="{h - 6}" rx="4" fill="none" stroke="{WOOD_DARK}" stroke-width="1.5"/>')
    svg.add(f'<rect x="{x + frame}" y="{y + frame}" width="{w - 2 * frame}" height="{h - 2 * frame}" rx="2" fill="{BOARD}"/>')


def chalk(svg, f, x, y, words, size, fill=CHALK, anchor='start', weight=700):
    svg.add(f'<g filter="{f}">')
    svg.text(x, y, words, size, fill, anchor, weight, CHALKF)
    svg.add('</g>')


def price_tag(svg, x, y, w, h, words, rot=0, size=14, fill=TAG):
    svg.add(f'<g transform="rotate({rot} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}"/>'
            f'<rect x="{x}" y="{y}" width="{w}" height="6" fill="#000" opacity=".08"/>')
    svg.text(x + w / 2, y + h / 2 + size / 2.8, words, size, INK, 'middle', font=MARKER)
    svg.add('</g>')


def price_board():
    svg = Svg('priceboard', 520, 370, "Thandi's Kota Kitchen price board, in chalk")
    board(svg, 0, 0, 520, 370, 14)
    f = chalk_defs(svg)
    chalk(svg, f, 260, 58, "THANDI'S KOTA KITCHEN", 32, CHALK_YELLOW, 'middle')
    svg.add(f'<path d="M110 72 Q260 82 410 72" stroke="{CHALK_PINK}" stroke-width="2.5" fill="none" filter="{f}"/>')
    rows = [('¼ Kota (classic)', 'R35,00'), ('Full house kota', 'R58,50'), ('Vetkoek & mince', 'R12,50'),
            ('Chips  small / large', 'R18,00 / R28,00'), ('Cold drink 440 ml', 'R16,00')]
    for i, (item, price) in enumerate(rows):
        yy = 118 + i * 38
        chalk(svg, f, 44, yy, item, 25)
        svg.add(f'<path d="M{44 + len(item) * 10.5} {yy - 6} H{470 - len(price) * 11}" stroke="{CHALK_DIM}" stroke-width="2" stroke-dasharray="2 7" filter="{f}"/>')
        chalk(svg, f, 476, yy, price, 25, CHALK_BLUE, 'end')
    price_tag(svg, 318, 300, 168, 42, 'SPECIAL: 2 kotas R65!', -4, 13)
    chalk(svg, f, 44, 334, 'Open Saturdays 07:00 - 15:00', 20, CHALK_DIM)
    svg.save()


def doodle_board(name, label, w=300, h=190):
    svg = Svg(name, w, h, label)
    board(svg, 0, 0, w, h, 8)
    return svg, chalk_defs(svg)


def d_comma():
    svg, f = doodle_board('comma', 'R35,00 and R35.00 are both fine; R35.0 and R35,0 are not how money is written')
    chalk(svg, f, 24, 46, 'R35,00', 30, CHALK)
    chalk(svg, f, 138, 46, '✓', 30, '#9be29b')
    chalk(svg, f, 24, 92, 'R35.00', 30, CHALK)
    chalk(svg, f, 138, 92, '✓', 30, '#9be29b')
    chalk(svg, f, 24, 140, 'R35.0', 30, CHALK_DIM)
    chalk(svg, f, 138, 140, '✗', 30, CHALK_PINK)
    hadi(svg, 172, 86, 1.1, 'shout')
    bubble(svg, 168, 18, 118, ['TWO CENTS', 'DIGITS!'], 196, 96, size=10)
    svg.save()


def d_freezer():
    svg, f = doodle_board('freezer', 'The freezer at minus 18 degrees, the fridge at plus 4: 22 degrees apart')
    # thermometer
    svg.add(f'<g filter="{f}"><rect x="40" y="20" width="16" height="140" rx="8" fill="none" stroke="{CHALK}" stroke-width="2.5"/>'
            f'<circle cx="48" cy="164" r="13" fill="{CHALK_BLUE}"/><rect x="44" y="124" width="8" height="38" fill="{CHALK_BLUE}"/></g>')
    for i, t in enumerate([10, 0, -10, -20]):
        yy = 40 + i * 30
        svg.add(f'<path d="M58 {yy} H70" stroke="{CHALK}" stroke-width="2" filter="{f}"/>')
        chalk(svg, f, 74, yy + 6, f'{t}°C'.replace('-', '−'), 16, CHALK_DIM, weight=600)
    chalk(svg, f, 130, 60, 'fridge  +4 °C', 22, CHALK)
    chalk(svg, f, 130, 120, 'freezer  −18 °C', 22, CHALK_BLUE)
    chalk(svg, f, 130, 166, '22 degrees apart', 20, CHALK_YELLOW)
    svg.save()


def d_bodmas():
    svg, f = doodle_board('bodmas', 'Five kotas and three cold drinks: multiply first, then add', 320, 190)
    chalk(svg, f, 20, 46, '5 × 35 + 3 × 16', 28, CHALK)
    chalk(svg, f, 20, 92, '= 175 + 48', 28, CHALK_BLUE)
    chalk(svg, f, 20, 138, '= R223', 30, CHALK_YELLOW)
    hadi(svg, 196, 100, 1.05)
    bubble(svg, 190, 22, 118, ['× BEFORE +'], 222, 108, size=10)
    svg.save()


def d_loaf():
    svg, f = doodle_board('loaf', 'A loaf cut into four: each piece is a quarter loaf, a quarter kota', 320, 190)
    svg.add(f'<g filter="{f}">'
            f'<path d="M30 120 Q30 52 92 48 H250 Q290 52 290 120 Z" fill="none" stroke="{CHALK_ORANGE}" stroke-width="3"/>'
            + ''.join(f'<path d="M{30 + i * 65} 122 V{60 if i in (1, 2, 3) else 120}" stroke="{CHALK}" stroke-width="2.5" stroke-dasharray="6 5"/>' for i in (1, 2, 3))
            + '</g>')
    for i in range(4):
        chalk(svg, f, 62 + i * 65, 100, '¼', 30, CHALK_YELLOW, 'middle')
    chalk(svg, f, 160, 166, 'one loaf = 4 quarter kotas', 22, CHALK, 'middle')
    svg.save()


def d_roundup():
    svg, f = doodle_board('roundup', 'Russians come in packs of 6: 40 kotas need 7 packs, not 6,67', 320, 200)
    for p in range(7):
        x, y = 16 + (p % 4) * 42, 22 + (p // 4) * 46
        svg.add(f'<g filter="{f}"><rect x="{x}" y="{y}" width="36" height="34" rx="4" fill="none" stroke="{CHALK}" stroke-width="2"/>'
                + ''.join(f'<path d="M{x + 6 + k * 5} {y + 6} v22" stroke="{CHALK_PINK}" stroke-width="3" stroke-linecap="round"/>' for k in range(6))
                + '</g>')
    chalk(svg, f, 16, 140, '40 ÷ 6 = 6,67', 24, CHALK)
    chalk(svg, f, 16, 176, '→ buy 7 packs', 24, CHALK_YELLOW)
    hadi(svg, 196, 104, 1.05, 'shout')
    bubble(svg, 186, 16, 126, ['SQUAWK!', 'ROUND UP!'], 214, 112, size=11)
    svg.save()


def d_sauce():
    svg, f = doodle_board('sauce', 'The secret sauce: tomato, chutney and mayo in the ratio 3 : 2 : 1', 320, 190)
    def bottle(x, colour, label, parts):
        svg.add(f'<g filter="{f}"><path d="M{x + 12} 36 h16 v14 q14 6 14 22 v76 q0 8 -8 8 h-28 q-8 0 -8 -8 v-76 q0 -16 14 -22z" fill="none" stroke="{CHALK}" stroke-width="2.5"/>'
                f'<rect x="{x + 2}" y="{146 - parts * 22}" width="36" height="{parts * 22}" fill="{colour}" opacity=".85"/></g>')
        chalk(svg, f, x + 20, 180, label, 18, CHALK, 'middle')
    bottle(30, '#e05a4f', 'tomato 3', 3)
    bottle(120, CHALK_ORANGE, 'chutney 2', 2)
    bottle(210, '#f4eccf', 'mayo 1', 1)
    chalk(svg, f, 160, 26, '3 : 2 : 1', 24, CHALK_YELLOW, 'middle')
    svg.save()


def d_helpers():
    svg, f = doodle_board('helpers', 'One helper takes 6 hours, two take 3, three take 2: more helpers, less time', 330, 200)
    def person(x, y):
        svg.add(f'<g filter="{f}" stroke="{CHALK}" stroke-width="2.5" fill="none" stroke-linecap="round">'
                f'<circle cx="{x}" cy="{y}" r="6"/><path d="M{x} {y + 6} v16 M{x} {y + 12} l-8 6 M{x} {y + 12} l8 6 M{x} {y + 22} l-6 12 M{x} {y + 22} l6 12"/></g>')
    rows = [(1, '6 h'), (2, '3 h'), (3, '2 h')]
    for r, (n, t) in enumerate(rows):
        y = 18 + r * 58
        for k in range(n):
            person(30 + k * 26, y)
        chalk(svg, f, 130, y + 30, '→', 26, CHALK_DIM)
        chalk(svg, f, 170, y + 32, t, 28, CHALK_YELLOW)
    chalk(svg, f, 236, 112, 'n × h', 20, CHALK_BLUE)
    chalk(svg, f, 236, 136, '= 6', 20, CHALK_BLUE)
    svg.save()


def d_bestbuy():
    svg, f = doodle_board('bestbuy', 'Mince: 1 kg for R109,99 or 2,5 kg for R249,99 - which is cheaper per kilogram?', 330, 200)
    price_tag(svg, 20, 30, 130, 60, '1 kg  R109,99', -3, 15)
    price_tag(svg, 176, 30, 136, 60, '2,5 kg  R249,99', 4, 15, '#ffb4a2')
    chalk(svg, f, 22, 130, 'R109,99 per kg', 22, CHALK)
    chalk(svg, f, 178, 130, 'R100,00 per kg', 22, CHALK_YELLOW)
    chalk(svg, f, 165, 176, 'compare the SAME unit', 20, CHALK_BLUE, 'middle')
    svg.save()


def d_special():
    svg, f = doodle_board('special', 'A 10% special on a R35 kota: R3,50 off, so R31,50', 320, 190)
    svg.add(f'<g transform="rotate(-10 90 90)"><path d="M90 20 L104 50 L138 40 L122 70 L152 88 L118 96 L124 130 L96 110 L72 134 L68 100 L34 100 L58 76 L36 50 L72 54Z" fill="{RED}" stroke="{INK}" stroke-width="3"/></g>')
    svg.text(92, 92, '−10%', 22, WHITE, 'middle')
    chalk(svg, f, 180, 60, 'R35,00', 26, CHALK_DIM)
    svg.add(f'<path d="M176 52 L262 40" stroke="{CHALK_PINK}" stroke-width="3" filter="{f}"/>')
    chalk(svg, f, 180, 110, '− R3,50', 26, CHALK)
    chalk(svg, f, 180, 160, '= R31,50', 30, CHALK_YELLOW)
    svg.save()


def d_markup():
    svg, f = doodle_board('markup', 'A kota that costs R25 to make, sold with a 40% mark-up, sells for R35', 320, 190)
    chalk(svg, f, 20, 46, 'cost to make   R25', 24, CHALK)
    chalk(svg, f, 20, 90, '+ 40% of 25 = R10', 24, CHALK_BLUE)
    chalk(svg, f, 20, 140, 'selling price  R35', 28, CHALK_YELLOW)
    hadi(svg, 210, 106, .9)
    svg.save()


def d_jobdone():
    svg = Svg('jobdone', 320, 200, 'Hadi with a JOB DONE stamp after Market Saturday', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: the car wash', 15, INK, 'middle', font=MARKER)
    svg.save()


def hadi_card():
    svg = Svg('hadi', 260, 200, 'Hadi the hadeda', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="248" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    hadi(svg, 70, 64, 1.5)
    svg.text(130, 44, 'HADI', 26, RED, 'middle')
    svg.save()


# ------------------------------------------------------- figures in text ----

def number_line():
    svg = Svg('numberline', 520, 210, 'A number line from 12,45 to 12,46 in thousandths: 12,456 is past halfway, so it rounds to 12,46')
    board(svg, 0, 0, 520, 210, 12)
    f = chalk_defs(svg)
    svg.add(f'<path d="M40 110 H480" stroke="{CHALK}" stroke-width="3" filter="{f}"/>')
    for i in range(11):
        x = 40 + i * 44
        big = i in (0, 5, 10)
        svg.add(f'<path d="M{x} {110 - (16 if big else 8)} V{110 + (16 if big else 8)}" stroke="{CHALK if i != 5 else CHALK_BLUE}" stroke-width="{2.5 if big else 1.8}" filter="{f}"/>')
    chalk(svg, f, 40, 156, '12,45', 22, CHALK, 'middle')
    chalk(svg, f, 260, 156, '12,455', 20, CHALK_BLUE, 'middle')
    chalk(svg, f, 260, 178, 'halfway', 18, CHALK_BLUE, 'middle')
    chalk(svg, f, 480, 156, '12,46', 22, CHALK_YELLOW, 'middle')
    x = 40 + 6 * 44
    svg.add(f'<path d="M{x} 64 V100" stroke="{CHALK_PINK}" stroke-width="3" filter="{f}"/><circle cx="{x}" cy="110" r="6" fill="{CHALK_PINK}"/>')
    chalk(svg, f, x, 56, '12,456', 24, CHALK_PINK, 'middle')
    svg.add(f'<path d="M{x + 12} 88 Q{(x + 470) / 2} 60 470 92" stroke="{CHALK_YELLOW}" stroke-width="2.5" fill="none" filter="{f}"/>')
    svg.add(f'<path d="M470 92 l-10 -2 M470 92 l-4 -9" stroke="{CHALK_YELLOW}" stroke-width="2.5" filter="{f}"/>')
    chalk(svg, f, 420, 52, 'rounds to 12,46', 18, CHALK_YELLOW, 'middle')
    svg.save()


def ratio_bar():
    svg = Svg('ratiobar', 520, 190, '1,2 litres of sauce in the ratio 3 : 2 : 1 is 6 equal parts of 200 ml', bg=None)
    board(svg, 0, 0, 520, 190, 12)
    f = chalk_defs(svg)
    colours = ['#e05a4f'] * 3 + [CHALK_ORANGE] * 2 + ['#f4eccf']
    for i, c in enumerate(colours):
        x = 40 + i * 74
        svg.add(f'<rect x="{x}" y="50" width="70" height="56" fill="{c}" opacity=".9" filter="{f}"/>')
        chalk(svg, f, x + 35, 86, '200 ml', 18, INK, 'middle')
    chalk(svg, f, 151, 36, 'tomato: 3 parts = 600 ml', 18, CHALK, 'middle')
    chalk(svg, f, 336, 36, 'chutney: 400 ml', 18, CHALK, 'middle')
    chalk(svg, f, 447, 132, 'mayo: 200 ml', 18, CHALK, 'middle')
    chalk(svg, f, 40, 170, '1 200 ml ÷ 6 parts = 200 ml a part', 22, CHALK_YELLOW)
    svg.save()


def fraction_wall():
    svg = Svg('fractions', 520, 210, 'One loaf, two halves, four quarters: ¼ = 0,25 = 25%', bg=None)
    board(svg, 0, 0, 520, 210, 12)
    f = chalk_defs(svg)
    rows = [(1, '1 loaf'), (2, '½ = 0,5 = 50%'), (4, '¼ = 0,25 = 25%')]
    for r, (n, label) in enumerate(rows):
        y = 32 + r * 54
        w = 300 / n
        for k in range(n):
            svg.add(f'<rect x="{30 + k * w}" y="{y}" width="{w - 4}" height="40" rx="3" fill="none" stroke="{[CHALK, CHALK_BLUE, CHALK_YELLOW][r]}" stroke-width="2.5" filter="{f}"/>')
        chalk(svg, f, 346, y + 28, label, 22, [CHALK, CHALK_BLUE, CHALK_YELLOW][r])
    svg.save()


# ------------------------------------------- batch 2: Car Wash Saturday ----
# Theme A: roadside plank signs and soap bubbles in bright primaries on sky blue.

SKY, ROAD, PLANK, PLANK_DARK, SOAP = '#8fd3ff', '#7a8a95', '#fbf6ea', '#6b4a2b', '#ffffff'
NUM = "'Figtree', 'Segoe UI', Arial, sans-serif"


def sky_board(name, w, h, label):
    svg = Svg(name, w, h, label, bg=SKY)
    svg.add(f'<rect x="0" y="{h - 26}" width="{w}" height="26" fill="{ROAD}"/>')
    svg.add(f'<path d="M0 {h - 13} H{w}" stroke="{WHITE}" stroke-width="2" stroke-dasharray="14 10"/>')
    return svg


def bubbles(svg, spots):
    for x, y, r in spots:
        svg.add(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{SOAP}" fill-opacity=".35" stroke="{SOAP}" stroke-width="2"/>'
                f'<circle cx="{x - r / 3}" cy="{y - r / 3}" r="{max(1.5, r / 5)}" fill="{SOAP}"/>')


def plank(svg, x, y, w, h, lines, rot=0):
    """A hand-painted plank sign on one post: lines = [(text, size, colour, font)]."""
    cx = x + w / 2
    svg.add(f'<g transform="rotate({rot} {cx} {y + h / 2})">'
            f'<rect x="{cx - 4}" y="{y + h - 2}" width="8" height="40" fill="{PLANK_DARK}"/>'
            f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="3" fill="{PLANK}" stroke="{PLANK_DARK}" stroke-width="3"/>')
    total = sum(s + 6 for _, s, _, _ in lines)
    yy = y + (h - total) / 2
    for text, size, colour, font in lines:
        yy += size + 2
        svg.text(cx, yy, text, size, colour, 'middle', font=font)
        yy += 4
    svg.add('</g>')


def car(svg, x, y, colour, s=1.0):
    svg.add(f'<g transform="translate({x} {y}) scale({s})">'
            f'<path d="M0 22 L6 10 Q10 2 20 2 H44 Q52 2 56 10 L64 22 Z" fill="{colour}" stroke="{INK}" stroke-width="2.5" stroke-linejoin="round"/>'
            f'<rect x="-4" y="20" width="72" height="14" rx="5" fill="{colour}" stroke="{INK}" stroke-width="2.5"/>'
            f'<path d="M14 10 H30 V20 H9Z M34 10 H50 L55 20 H34Z" fill="#cfefff" stroke="{INK}" stroke-width="1.5"/>'
            f'<circle cx="12" cy="34" r="6" fill="{INK}"/><circle cx="52" cy="34" r="6" fill="{INK}"/></g>')


def d_hire():
    svg = sky_board('hire', 320, 200, 'The pressure washer costs R150 for the day, whether you wash 1 car or 40')
    plank(svg, 20, 24, 170, 80, [('WASHER HIRE', 16, RED, BUNGEE), ('R150 a day', 20, BLUE, HAND), ('1 car or 40', 15, INK, HAND)], -3)
    hadi(svg, 200, 98, 1.0)
    bubble(svg, 196, 22, 112, ['SAME PRICE', 'ALL DAY!'], 226, 104, size=10)
    bubbles(svg, [(36, 150, 9), (176, 140, 6)])
    svg.save()


def d_sponges():
    svg = sky_board('sponges', 330, 200, 'One washer takes 24 minutes a car, two take 12, three take 8: more washers, less time')
    rows = [(1, '24 min'), (2, '12 min'), (3, '8 min')]
    for r, (n, t) in enumerate(rows):
        y = 18 + r * 52
        for k in range(n):
            svg.add(f'<rect x="{20 + k * 34}" y="{y}" width="28" height="18" rx="6" fill="#ffe14d" stroke="{INK}" stroke-width="2"/>'
                    f'<circle cx="{26 + k * 34}" cy="{y + 6}" r="2" fill="{INK}" opacity=".4"/><circle cx="{38 + k * 34}" cy="{y + 12}" r="2" fill="{INK}" opacity=".4"/>')
        svg.text(140, y + 16, '→', 20, INK, 'middle', font=NUM)
        svg.text(170, y + 17, t, 20, BLUE, font=BUNGEE)
    svg.text(250, 160, 'WASHERS × MIN', 11, RED, 'middle', font=BUNGEE)
    svg.text(250, 178, '= 24', 14, RED, 'middle', font=BUNGEE)
    bubbles(svg, [(300, 40, 10), (288, 90, 6)])
    svg.save()


def d_dots():
    svg = Svg('dots', 330, 200, 'Cars are counted in whole numbers, so the points are not joined; water flows all the time, so its line is joined', bg=WHITE, rx=8)
    for gx in range(2):
        ox = 20 + gx * 160
        svg.add(f'<path d="M{ox} 150 H{ox + 130} M{ox} 150 V40" stroke="{INK}" stroke-width="2"/>')
        if gx == 0:
            for i in range(6):
                svg.add(f'<circle cx="{ox + 10 + i * 22}" cy="{146 - i * 20}" r="4.5" fill="{BLUE}"/>')
            svg.text(ox + 65, 178, 'cars: dots only', 14, INK, 'middle', font=HAND)
        else:
            svg.add(f'<path d="M{ox} 150 L{ox + 120} 50" stroke="{RED}" stroke-width="3"/>')
            svg.text(ox + 65, 178, 'water: a line', 14, INK, 'middle', font=HAND)
    svg.text(165, 26, 'JOIN THE DOTS?', 14, INK, 'middle', font=BUNGEE)
    svg.save()


def d_hose():
    svg = sky_board('hose', 320, 200, 'The hose runs 12 litres every minute')
    svg.add(f'<path d="M20 150 Q60 110 110 130 T200 90" fill="none" stroke="#2f9e44" stroke-width="9" stroke-linecap="round"/>'
            f'<rect x="196" y="80" width="26" height="16" rx="4" fill="{RED}" stroke="{INK}" stroke-width="2"/>')
    for k in range(6):
        svg.add(f'<path d="M224 {84 + k * 2} q{30 + k * 8} {-10 + k * 6} {50 + k * 10} {10 + k * 10}" fill="none" stroke="{WHITE}" stroke-width="2.5" opacity=".9"/>')
    plank(svg, 20, 16, 150, 60, [('12 LITRES', 16, BLUE, BUNGEE), ('every minute', 16, INK, HAND)], 3)
    svg.save()


def d_queue():
    svg = sky_board('queue', 340, 200, 'The queue of cars grows in the morning, shrinks at lunch and grows again')
    for i, c in enumerate(['#e63b2e', '#ffd84d', '#1d4fd8', '#7bc96f']):
        car(svg, 16 + i * 80, 120, c, .95)
    hadi(svg, 236, 20, .85)
    bubble(svg, 20, 18, 190, ['THE QUEUE IS', 'A STORY TOO'], 226, 80, size=11)
    svg.save()


def d_jobdone2():
    svg = Svg('jobdone2', 320, 200, 'Hadi with a JOB DONE stamp after the car wash', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Radio 10', 15, INK, 'middle', font=MARKER)
    svg.save()


def plot(name, label, xr, yr, xlab, ylab, heading, series, w=520, h=340, xevery=1, yevery=1):
    """A plain, exact graph to read values from (a document, not a theme): grid,
    numbered axes, heading and labels. xr/yr = (min, max, step); series =
    [('dots'|'line', [(x, y), ...], colour)]."""
    svg = Svg(name, w, h, label, bg=WHITE, rx=6)
    L, R, T, B = 70, w - 24, 46, h - 58
    (x0, x1, xs), (y0, y1, ys) = xr, yr
    X = lambda v: L + (v - x0) / (x1 - x0) * (R - L)
    Y = lambda v: B - (v - y0) / (y1 - y0) * (B - T)
    nx, ny = round((x1 - x0) / xs), round((y1 - y0) / ys)
    for i in range(nx + 1):
        v = x0 + i * xs
        svg.add(f'<path d="M{X(v):.1f} {T} V{B}" stroke="#d6e2ea" stroke-width="1"/>')
        if i % xevery == 0:
            svg.text(X(v), B + 18, f'{v:g}'.replace('.', ','), 12, INK, 'middle', font=NUM)
    for i in range(ny + 1):
        v = y0 + i * ys
        svg.add(f'<path d="M{L} {Y(v):.1f} H{R}" stroke="#d6e2ea" stroke-width="1"/>')
        if i % yevery == 0:
            svg.text(L - 8, Y(v) + 4, f'{v:g}'.replace('.', ','), 12, INK, 'end', font=NUM)
    zero_y = Y(0) if y0 <= 0 <= y1 else B
    svg.add(f'<path d="M{L} {zero_y:.1f} H{R}" stroke="{INK}" stroke-width="1.8"/><path d="M{L} {T} V{B}" stroke="{INK}" stroke-width="1.8"/>')
    for kind, pts, colour in series:
        if kind == 'line':
            svg.add('<path d="M' + ' L'.join(f'{X(a):.1f} {Y(b):.1f}' for a, b in pts) + f'" fill="none" stroke="{colour}" stroke-width="2.6"/>')
        for a, b in pts if kind == 'dots' else []:
            svg.add(f'<circle cx="{X(a):.1f}" cy="{Y(b):.1f}" r="4.2" fill="{colour}"/>')
    svg.text((L + R) / 2, 26, heading, 15, INK, 'middle', 700, NUM)
    svg.text((L + R) / 2, h - 16, xlab, 13, INK, 'middle', 600, NUM)
    svg.add(f'<text x="18" y="{(T + B) / 2}" font-family="{NUM}" font-size="13" font-weight="600" fill="{INK}" text-anchor="middle" transform="rotate(-90 18 {(T + B) / 2})">{esc(ylab)}</text>')
    svg.save()


def story_choice():
    """Four small queue graphs, A to D, for the story question."""
    svg = Svg('storychoice', 560, 200, 'Four graphs of queue length over the day, labelled A to D', bg=WHITE, rx=6)
    shapes = {
        'A': [(0, 0), (2, 6), (4, 2), (5, 8), (7, 0)],
        'B': [(0, 0), (2, 2), (4, 4), (5, 6), (7, 8)],
        'C': [(0, 8), (2, 2), (4, 6), (5, 0), (7, 8)],
        'D': [(0, 4), (7, 4)],
    }
    for i, (k, pts) in enumerate(shapes.items()):
        ox = 14 + i * 136
        svg.add(f'<path d="M{ox + 10} 160 H{ox + 124} M{ox + 10} 160 V40" stroke="{INK}" stroke-width="1.8"/>')
        svg.add('<path d="M' + ' L'.join(f'{ox + 10 + a * 16:.1f} {160 - b * 14:.1f}' for a, b in pts) + f'" fill="none" stroke="{BLUE}" stroke-width="2.6"/>')
        svg.text(ox + 67, 30, k, 18, RED, 'middle', font=BUNGEE)
        svg.text(ox + 67, 182, 'time of day', 11, INK, 'middle', font=NUM)
    svg.save()


# ------------------------------------------- batch 3: Radio 10 Survey -----
# Theme A: a retro radio studio - wood panels, cream VU meters with a red
# zone, cassette labels in a typewriter face, the ON AIR lamp.

WOOD3, WOOD3_DARK, CREAM3, TYPE = '#5a3a24', '#2b1c10', '#f1e2b8', "'Special Elite', 'Courier New', monospace"


def studio(name, w, h, label):
    svg = Svg(name, w, h, label, bg=WOOD3, rx=8)
    for i in range(1, 6):
        svg.add(f'<path d="M0 {i * h / 6:.0f} H{w}" stroke="{WOOD3_DARK}" stroke-width="1" opacity=".35"/>')
    return svg


def vu(svg, x, y, w=120, needle=0.7, caption='VU'):
    h = w * .62
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="6" fill="{CREAM3}" stroke="{WOOD3_DARK}" stroke-width="3"/>')
    cx, cy, r = x + w / 2, y + h * .9, w * .4
    svg.add(f'<path d="M{cx - r} {cy} A{r} {r} 0 0 1 {cx + r} {cy}" fill="none" stroke="{WOOD3_DARK}" stroke-width="2"/>')
    svg.add(f'<path d="M{cx + r * .5} {cy - r * .866} A{r} {r} 0 0 1 {cx + r} {cy}" fill="none" stroke="{RED}" stroke-width="5"/>')
    import math
    a = math.pi * (1 - needle)
    svg.add(f'<path d="M{cx} {cy} L{cx + r * 1.05 * math.cos(a):.1f} {cy - r * 1.05 * math.sin(a):.1f}" stroke="{WOOD3_DARK}" stroke-width="2.5"/>')
    svg.text(cx, y + 18, caption, 11, WOOD3_DARK, 'middle', font=TYPE)


def cassette(svg, x, y, label, w=150):
    h = w * .62
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="6" fill="#e9e4da" stroke="{WOOD3_DARK}" stroke-width="2.5"/>'
            f'<rect x="{x + 10}" y="{y + 8}" width="{w - 20}" height="{h * .3}" fill="{WHITE}" stroke="{WOOD3_DARK}" stroke-width="1"/>'
            f'<circle cx="{x + w * .3}" cy="{y + h * .65}" r="{w * .08}" fill="{WOOD3_DARK}"/><circle cx="{x + w * .7}" cy="{y + h * .65}" r="{w * .08}" fill="{WOOD3_DARK}"/>')
    svg.text(x + w / 2, y + 8 + h * .22, label, 12, WOOD3_DARK, 'middle', font=TYPE)


def on_air(svg, x, y, lit=True):
    svg.add(f'<rect x="{x}" y="{y}" width="110" height="34" rx="6" fill="{RED if lit else "#7a2a22"}" stroke="{WOOD3_DARK}" stroke-width="3"/>')
    svg.text(x + 55, y + 23, 'ON AIR', 16, WHITE if lit else '#c99', 'middle')


def d_leading():
    svg = studio('leading', 330, 200, 'A leading question pushes people to one answer; a fair question does not')
    cassette(svg, 14, 20, 'SIDE A: LEADING', 150)
    svg.text(89, 130, '"Don\'t you agree', 13, CREAM3, 'middle', font=TYPE)
    svg.text(89, 148, 'amapiano is best?"', 13, CREAM3, 'middle', font=TYPE)
    cassette(svg, 170, 20, 'SIDE B: FAIR', 150)
    svg.text(245, 130, '"Which kind of music', 13, CREAM3, 'middle', font=TYPE)
    svg.text(245, 148, 'do you like most?"', 13, CREAM3, 'middle', font=TYPE)
    svg.text(165, 186, 'same tape, different answers', 12, '#e0c89a', 'middle', font=HAND)
    svg.save()


def d_soup():
    svg = studio('soup', 320, 200, 'You taste a spoonful to know the whole pot - a sample tells you about the population, if it is stirred well')
    svg.add(f'<path d="M50 90 h150 v60 q0 26 -26 26 h-98 q-26 0 -26 -26z" fill="#c8102e" stroke="{WOOD3_DARK}" stroke-width="3"/>'
            f'<ellipse cx="125" cy="90" rx="75" ry="12" fill="#e2603c" stroke="{WOOD3_DARK}" stroke-width="3"/>'
            f'<path d="M190 60 L250 30" stroke="{CREAM3}" stroke-width="5" stroke-linecap="round"/><ellipse cx="186" cy="64" rx="14" ry="7" fill="{CREAM3}"/>')
    svg.text(250, 110, 'sample', 16, CREAM3, 'middle', font=TYPE)
    svg.text(125, 140, 'population', 14, WHITE, 'middle', font=TYPE)
    svg.text(160, 192, 'stir first: a random sample', 12, '#e0c89a', 'middle', font=HAND)
    svg.save()


def d_tally():
    svg = studio('tally', 320, 200, 'Tally marks in fives: four strokes and a fifth across them')
    svg.add(f'<rect x="20" y="20" width="200" height="160" rx="4" fill="{CREAM3}" stroke="{WOOD3_DARK}" stroke-width="3"/>')
    rows = [('Amapiano', 11), ('Hip hop', 7), ('Gospel', 4)]
    for r, (g, n) in enumerate(rows):
        y = 56 + r * 44
        svg.text(32, y, g, 14, WOOD3_DARK, font=TYPE)
        x = 120
        for k in range(n):
            grp, pos = divmod(k, 5)
            if pos < 4:
                svg.add(f'<path d="M{x + grp * 34 + pos * 6} {y - 16} v20" stroke="{WOOD3_DARK}" stroke-width="2.2"/>')
            else:
                svg.add(f'<path d="M{x + grp * 34 - 4} {y} L{x + grp * 34 + 24} {y - 16}" stroke="{RED}" stroke-width="2.2"/>')
    hadi(svg, 222, 98, .85)
    svg.save()


def d_middle():
    svg = studio('middle', 330, 200, 'Seven learners in a line, shortest listening time to longest: the median is the one in the middle')
    vals = [15, 20, 30, 45, 50, 75, 240]
    for i, v in enumerate(vals):
        x = 26 + i * 42
        hh = 30 + i * 9
        col = '#ffd84d' if i == 3 else CREAM3
        svg.add(f'<g stroke="{col}" stroke-width="3" fill="none" stroke-linecap="round"><circle cx="{x}" cy="{150 - hh}" r="7"/><path d="M{x} {157 - hh} V{150} M{x} {150} l-7 14 M{x} 150 l7 14 M{x} {165 - hh} l-9 8 M{x} {165 - hh} l9 8"/></g>')
        svg.text(x, 186, str(v), 12, col, 'middle', font=TYPE)
    svg.text(152, 24, 'THE MEDIAN STANDS IN THE MIDDLE', 11, '#ffd84d', 'middle')
    svg.save()


def d_vu():
    svg = studio('vumeter', 320, 200, 'Two VU meters: one reading high, one low - the range is the gap between the highest and the lowest')
    vu(svg, 20, 30, 130, .9, 'HIGHEST')
    vu(svg, 170, 30, 130, .12, 'LOWEST')
    svg.text(160, 150, 'range = highest - lowest', 15, CREAM3, 'middle', font=TYPE)
    on_air(svg, 105, 160)
    svg.save()


def d_outlier():
    svg = studio('outlier', 330, 200, 'One learner listens for 240 minutes and drags the mean up; the median does not move')
    for i, v in enumerate([45, 45, 50, 60, 240]):
        x = 30 + i * 56
        hh = min(v, 130) * .9
        svg.add(f'<rect x="{x}" y="{160 - hh}" width="36" height="{hh}" fill="{"#ffd84d" if v == 240 else CREAM3}" stroke="{WOOD3_DARK}" stroke-width="2"/>')
        svg.text(x + 18, 180, str(v), 12, CREAM3, 'middle', font=TYPE)
    svg.add(f'<path d="M244 24 l10 -10 l10 10" stroke="#ffd84d" stroke-width="3" fill="none"/>')
    hadi(svg, 210, 4, .7, 'shout')
    svg.text(70, 30, 'OUTLIER!', 16, '#ffd84d', 'middle')
    svg.save()


def d_jobdone3():
    svg = Svg('jobdone3', 320, 200, 'Hadi with a JOB DONE stamp after the Radio 10 survey', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next: the Term 1 test', 15, INK, 'middle', font=MARKER)
    svg.save()


# ------------------------------------------- batch 4: Gogo's Shoebox ------
# Theme A for the scenes: paper collage - kraft ground, tilted slips,
# paperclips, rubber stamps. The DOCUMENTS themselves stay plain and realistic
# (fictional names: Mzansi Metro, Ubuntu Foods, Thread & Co, Khaya Bank).

KRAFT, PAPER, DOCINK, DOCGREY, DOCLINE = '#c9a77c', '#ffffff', '#1b1f24', '#5b6670', '#cfd6dc'
DOC = "'Figtree', 'Segoe UI', Arial, sans-serif"
MONO = "'IBM Plex Mono', Consolas, 'Courier New', monospace"


def doc(name, w, h, label):
    svg = Svg(name, w, h, label, bg='#f3f4f5', rx=4)
    svg.add(f'<rect x="8" y="8" width="{w - 16}" height="{h - 16}" fill="{PAPER}" stroke="{DOCLINE}" stroke-width="1"/>')
    return svg


def row(svg, x1, x2, y, left, right, size=12, bold=False, font=DOC, colour=DOCINK, mid=None, midx=None):
    w = 700 if bold else 400
    svg.text(x1, y, left, size, colour, 'start', w, font)
    if mid is not None:
        svg.text(midx, y, mid, size, colour, 'end', w, font)
    if right != '':
        svg.text(x2, y, right, size, colour, 'end', w, font)


def hline(svg, x1, x2, y, dash=False, colour=DOCLINE):
    svg.add(f'<path d="M{x1} {y} H{x2}" stroke="{colour}" stroke-width="1"{" stroke-dasharray=\"3 3\"" if dash else ""}/>')


def municipal_bill():
    svg = doc('municipalbill', 560, 620, 'Mzansi Metro municipal account for Mrs N Nkosi, March: electricity, water, refuse, sewerage, rates and VAT, total due R3 894,73 by 15 April')
    svg.add(f'<rect x="8" y="8" width="544" height="64" fill="#1f5c8b"/>')
    svg.text(28, 40, 'MZANSI METRO MUNICIPALITY', 18, WHITE, 'start', 700, DOC)
    svg.text(28, 60, 'Consolidated municipal account - tax invoice', 12, '#d6e6f2', 'start', 400, DOC)
    rows = [('Account holder', 'Mrs N Nkosi'), ('Address', '14 Mahlangu Street, Mzansi'), ('Account number', '5520 3318 07'),
            ('Statement date', '25 March'), ('Due date', '15 April')]
    for i, (a, b) in enumerate(rows):
        row(svg, 28, 300, 100 + i * 20, a, '', 12, colour=DOCGREY)
        svg.text(170, 100 + i * 20, b, 12, DOCINK, 'start', 600, DOC)
    svg.add(f'<rect x="330" y="86" width="200" height="86" rx="4" fill="#eef5fb" stroke="#1f5c8b"/>')
    svg.text(430, 112, 'AMOUNT DUE', 12, '#1f5c8b', 'middle', 700, DOC)
    svg.text(430, 144, 'R3 894,73', 26, DOCINK, 'middle', 800, DOC)
    svg.text(430, 164, 'by 15 April', 11, DOCGREY, 'middle', 400, DOC)
    y = 210
    svg.text(28, y, 'ACCOUNT SUMMARY', 12, '#1f5c8b', 'start', 700, DOC); hline(svg, 28, 532, y + 6)
    for a, b in [('Previous balance', 'R3 512,40'), ('Payment received - thank you', '-R3 512,40'), ('Balance brought forward', 'R0,00')]:
        y += 22; row(svg, 28, 532, y, a, b)
    y += 34
    svg.text(28, y, 'CURRENT CHARGES', 12, '#1f5c8b', 'start', 700, DOC); hline(svg, 28, 532, y + 6)
    y += 20
    for a, b in [('Electricity', ''), ('  Meter readings: previous 48 216 kWh, current 48 791 kWh', ''), ('  Units used 575 kWh x R3,10 per kWh', 'R1 782,50'),
                 ('Water', ''), ('  Meter readings: previous 1 204 kl, current 1 222 kl', ''), ('  Water used 18 kl x R38,00 per kl', 'R684,00'),
                 ('Refuse removal (fixed)', 'R245,00'), ('Sewerage (fixed)', 'R310,00')]:
        y += 21
        bold = not a.startswith('  ')
        row(svg, 28, 532, y, a.strip() if bold else '   ' + a.strip(), b, 12 if bold else 11, bold and b == '', colour=DOCINK if bold else DOCGREY)
    y += 26; hline(svg, 330, 532, y - 14, True)
    row(svg, 28, 532, y, 'Subtotal of charges with VAT', 'R3 021,50')
    y += 21; row(svg, 28, 532, y, 'VAT at 15%', 'R453,23')
    y += 21; row(svg, 28, 532, y, 'Property rates (no VAT)', 'R420,00')
    y += 14; hline(svg, 28, 532, y, colour=DOCINK)
    y += 22; row(svg, 28, 532, y, 'TOTAL DUE', 'R3 894,73', 14, True)
    y += 40
    svg.add(f'<rect x="28" y="{y - 16}" width="504" height="64" rx="4" fill="#fff6e5" stroke="#e0a43a"/>')
    svg.text(40, y + 2, 'Pay by the due date. Accounts in arrears may have their electricity', 11, DOCINK, 'start', 400, DOC)
    svg.text(40, y + 18, 'supply restricted and interest charged on the overdue amount.', 11, DOCINK, 'start', 400, DOC)
    svg.text(40, y + 36, 'Pay at any Mzansi Metro office, by EFT (reference: your account number) or at a store.', 11, DOCGREY, 'start', 400, DOC)
    svg.save()


def till_slip():
    svg = Svg('tillslip', 300, 640, 'Ubuntu Foods till slip: eight items, three zero-rated, total R512,91, VAT included R42,77, cash R600, change R87,09', bg='#f3f4f5', rx=4)
    teeth = ''.join(f' L{280 - 10 * (k + 1)} {614 + (12 if k % 2 == 0 else 0)}' for k in range(26))
    svg.add(f'<path d="M20 10 H280 V614{teeth} L20 10 Z" fill="{PAPER}" stroke="{DOCLINE}"/>')
    svg.text(150, 44, 'UBUNTU FOODS', 18, DOCINK, 'middle', 700, MONO)
    svg.text(150, 62, 'Mzansi Plaza  VAT no. 4120 3355 18', 10, DOCGREY, 'middle', 400, MONO)
    svg.text(150, 78, 'TAX INVOICE', 11, DOCINK, 'middle', 600, MONO)
    hline(svg, 34, 266, 90, True, DOCINK)
    items = [('BROWN BREAD 700G', '19,99 Z'), ('MAIZE MEAL 10KG', '109,99 Z'), ('EGGS LARGE X18', '54,99 Z'), ('SUNFLOWER OIL 2L', '79,98'),
             ('TEA BAGS X100', '49,99'), ('WASHING POWDER 2KG', '89,99'), ('POLONY 1KG', '54,99'), ('WHITE SUGAR 2.5KG', '52,99')]
    y = 112
    for a, b in items:
        row(svg, 34, 266, y, a, b, 11, font=MONO); y += 22
    hline(svg, 34, 266, y - 6, True, DOCINK)
    y += 14
    row(svg, 34, 266, y, 'TOTAL', 'R512,91', 14, True, MONO); y += 26
    row(svg, 34, 266, y, 'CASH', '600,00', 11, font=MONO); y += 20
    row(svg, 34, 266, y, 'CHANGE', '87,09', 11, font=MONO); y += 30
    row(svg, 34, 266, y, 'ITEMS: 8', '', 11, font=MONO); y += 24
    row(svg, 34, 266, y, 'VAT INCLUDED @ 15%', '42,77', 11, font=MONO); y += 20
    row(svg, 34, 266, y, 'Z = ZERO-RATED (NO VAT)', '', 10, font=MONO, colour=DOCGREY); y += 30
    svg.text(150, y, '08 MAR  10:42  TILL 3', 10, DOCGREY, 'middle', 400, MONO); y += 24
    svg.text(150, y, 'THANK YOU - SALA KAHLE', 11, DOCINK, 'middle', 600, MONO)
    svg.save()


def store_statement():
    svg = doc('storestatement', 560, 380, 'Thread & Co store account statement: opening balance R1 450,00, a purchase, a payment, interest, closing balance R1 773,50, minimum payment R265,00')
    svg.text(28, 44, 'Thread & Co', 22, '#8a2b4b', 'start', 800, DOC)
    svg.text(532, 40, 'STORE ACCOUNT STATEMENT', 12, DOCINK, 'end', 700, DOC)
    svg.text(532, 58, 'Mrs N Nkosi   Account 7781 2290', 11, DOCGREY, 'end', 400, DOC)
    y = 96
    svg.add(f'<rect x="28" y="{y - 16}" width="504" height="24" fill="#f6eef1"/>')
    for x, t, a in [(36, 'Date', 'start'), (110, 'Description', 'start'), (524, 'Amount', 'end')]:
        svg.text(x, y, t, 11, DOCINK, a, 700, DOC)
    for d, t, amt in [('1 Mar', 'Opening balance', 'R1 450,00'), ('3 Mar', 'Purchase - school shoes and jersey', 'R899,00'),
                      ('10 Mar', 'Payment received - thank you', '-R600,00'), ('28 Mar', 'Interest on balance', 'R24,50')]:
        y += 26
        svg.text(36, y, d, 12, DOCINK, 'start', 400, DOC); svg.text(110, y, t, 12, DOCINK, 'start', 400, DOC); svg.text(524, y, amt, 12, DOCINK, 'end', 400, DOC)
        hline(svg, 28, 532, y + 8)
    y += 32
    row(svg, 36, 524, y, 'Closing balance', 'R1 773,50', 14, True)
    y += 40
    svg.add(f'<rect x="28" y="{y - 18}" width="504" height="66" rx="4" fill="#f6eef1" stroke="#8a2b4b"/>')
    row(svg, 40, 520, y, 'Minimum payment due', 'R265,00', 13, True)
    row(svg, 40, 520, y + 22, 'Payment due by', '5 April', 12)
    svg.text(40, y + 40, 'Interest is charged on any amount not paid in full.', 11, DOCGREY, 'start', 400, DOC)
    svg.save()


def bank_statement(blank=False):
    name = 'bankstatement' + ('-blank' if blank else '')
    svg = doc(name, 640, 560, 'Khaya Bank statement for Mrs N Nkosi, 1 to 31 March: opening balance R2 140,35, credits, debits, fees, closing balance R2 960,21' + (' - some balances left blank' if blank else ''))
    svg.add(f'<rect x="8" y="8" width="624" height="58" fill="#0f5c4d"/>')
    svg.text(28, 44, 'KHAYA BANK', 20, WHITE, 'start', 800, DOC)
    svg.text(612, 34, 'Savings and transaction account', 11, '#cfe9e2', 'end', 400, DOC)
    svg.text(612, 52, 'Mrs N Nkosi   Account 6201 4477 3150   1 - 31 March', 11, '#cfe9e2', 'end', 400, DOC)
    y = 98
    svg.add(f'<rect x="20" y="{y - 16}" width="600" height="24" fill="#e8f2ef"/>')
    cols = [(28, 'Date', 'start'), (84, 'Description', 'start'), (420, 'Debit', 'end'), (510, 'Credit', 'end'), (612, 'Balance', 'end')]
    for x, t, a in cols:
        svg.text(x, y, t, 11, DOCINK, a, 700, DOC)
    lines = [('01 Mar', 'Opening balance', '', '', '2 140,35'), ('01 Mar', 'Pension payment', '', '2 890,00', '5 030,35'),
             ('02 Mar', 'Rent received - backroom', '', '2 500,00', '7 530,35'), ('03 Mar', 'Debit order - Thuthuka funeral policy', '185,00', '', '7 345,35'),
             ('05 Mar', 'ATM withdrawal', '800,00', '', '6 545,35'), ('05 Mar', 'ATM withdrawal fee', '12,50', '', '6 532,85'),
             ('08 Mar', 'Card purchase - Ubuntu Foods', '512,91', '', '6 019,94'), ('10 Mar', 'Transfer from S Nkosi', '', '1 500,00', '7 519,94'),
             ('14 Mar', 'Payment - Mzansi Metro', '3 894,73', '', '3 625,21'), ('20 Mar', 'Payment - Thread & Co', '600,00', '', '3 025,21'),
             ('31 Mar', 'Monthly account fee', '65,00', '', '2 960,21')]
    hide = {'7 345,35', '6 532,85', '7 519,94', '3 625,21'} if blank else set()
    for d, t, dr, cr, bal in lines:
        y += 30
        svg.text(28, y, d, 12, DOCINK, 'start', 400, DOC); svg.text(84, y, t, 12, DOCINK, 'start', 400, DOC)
        svg.text(420, y, dr, 12, '#a3271b' if dr else DOCINK, 'end', 400, DOC); svg.text(510, y, cr, 12, '#0f5c4d', 'end', 400, DOC)
        if bal in hide:
            svg.add(f'<rect x="530" y="{y - 14}" width="84" height="20" rx="3" fill="#fff6c2" stroke="#e0a43a"/>')
            svg.text(572, y + 1, '?', 13, '#a36b00', 'middle', 700, DOC)
        else:
            svg.text(612, y, bal, 12, DOCINK, 'end', 600 if t in ('Opening balance',) else 400, DOC)
        hline(svg, 20, 620, y + 10)
    y += 40
    row(svg, 28, 612, y, 'Closing balance', 'R2 960,21', 14, True)
    y += 26
    svg.text(28, y, 'Fees this month are shown as separate lines. Debits take money out; credits put money in.', 11, DOCGREY, 'start', 400, DOC)
    svg.save()


def collage_bg(name, w, h, label):
    svg = Svg(name, w, h, label, bg=KRAFT, rx=8)
    return svg


def slip(svg, x, y, w, h, rot, lines=4, fill=PAPER):
    svg.add(f'<g transform="rotate({rot} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{fill}" stroke="#b9a07f"/>'
            + ''.join(f'<path d="M{x + 8} {y + 14 + i * 12} H{x + w - 8 - (i % 3) * 10}" stroke="#9aa5ad" stroke-width="2"/>' for i in range(lines)) + '</g>')


def stamp(svg, x, y, word, rot=-12, colour=RED):
    svg.add(f'<g transform="rotate({rot} {x} {y})"><rect x="{x - 48}" y="{y - 18}" width="96" height="34" rx="4" fill="none" stroke="{colour}" stroke-width="3"/></g>')
    svg.text(x, y + 6, word, 18, colour, 'middle', extra=f'transform="rotate({rot} {x} {y})"')


def paperclip(svg, x, y):
    svg.add(f'<path d="M{x} {y} v26 a6 6 0 0 0 12 0 v-22 a4 4 0 0 0 -8 0 v20" fill="none" stroke="#7d8790" stroke-width="2.5" stroke-linecap="round"/>')


def d_shoebox():
    svg = collage_bg('shoebox', 330, 210, 'A shoebox stuffed with slips, bills and statements')
    svg.add(f'<path d="M30 120 h260 l-20 76 h-220z" fill="#e8dcc6" stroke="#8a6a44" stroke-width="3"/><path d="M30 120 h260" stroke="#8a6a44" stroke-width="6"/>')
    for i, (x, r) in enumerate([(50, -14), (100, 6), (150, -4), (200, 12), (240, -8)]):
        slip(svg, x, 48 + (i % 2) * 12, 50, 80, r)
    paperclip(svg, 118, 40)
    svg.text(160, 168, 'GOGO\'S PAPERS', 15, '#8a6a44', 'middle')
    svg.save()


def d_paid():
    svg = collage_bg('paid', 320, 200, 'A municipal bill stamped PAID before the due date')
    slip(svg, 40, 26, 150, 150, -4, 8)
    stamp(svg, 118, 104, 'PAID')
    hadi(svg, 196, 96, .95)
    bubble(svg, 196, 18, 112, ['BEFORE THE', 'DUE DATE!'], 228, 100, size=10)
    svg.save()


def d_magnifier():
    svg = collage_bg('magnifier', 320, 200, 'A magnifying glass over a till slip, finding the same item charged twice')
    slip(svg, 40, 20, 110, 160, 3, 10)
    svg.add(f'<circle cx="160" cy="96" r="44" fill="#ffffff" fill-opacity=".35" stroke="{INK}" stroke-width="5"/><path d="M192 128 L236 172" stroke="{INK}" stroke-width="9" stroke-linecap="round"/>')
    svg.text(160, 92, 'POLONY', 11, INK, 'middle', 700, MONO)
    svg.text(160, 108, 'POLONY', 11, RED, 'middle', 700, MONO)
    svg.text(262, 60, 'TWICE?', 16, RED, 'middle')
    svg.save()


def d_debitcredit():
    svg = collage_bg('debitcredit', 320, 200, 'Debits take money out of the account, credits put money in')
    slip(svg, 24, 30, 128, 130, -5, 0, '#fde7e4')
    slip(svg, 168, 30, 128, 130, 5, 0, '#e4f5ee')
    svg.text(88, 82, 'DEBIT', 20, '#a3271b', 'middle', extra='transform="rotate(-5 88 95)"')
    svg.text(88, 112, 'money out', 15, INK, 'middle', font=HAND, extra='transform="rotate(-5 88 95)"')
    svg.text(232, 82, 'CREDIT', 20, '#0f5c4d', 'middle', extra='transform="rotate(5 232 95)"')
    svg.text(232, 112, 'money in', 15, INK, 'middle', font=HAND, extra='transform="rotate(5 232 95)"')
    paperclip(svg, 150, 20)
    svg.save()


def d_jar():
    svg = collage_bg('jars', 330, 200, 'Money jars labelled for food, transport, electricity and savings - a budget plans where the money goes')
    for i, (lab, lvl) in enumerate([('FOOD', .8), ('TAXI', .5), ('POWER', .6), ('SAVE', .3)]):
        x = 18 + i * 78
        svg.add(f'<path d="M{x + 8} 50 h52 v8 q10 6 10 20 v86 q0 10 -10 10 h-52 q-10 0 -10 -10 v-86 q0 -14 10 -20z" fill="#ffffff" fill-opacity=".5" stroke="{INK}" stroke-width="2.5"/>'
                f'<rect x="{x + 2}" y="{174 - 110 * lvl}" width="64" height="{110 * lvl - 2}" fill="#e0b84a" opacity=".85"/>'
                f'<rect x="{x + 6}" y="96" width="56" height="20" fill="{PAPER}" stroke="{INK}"/>')
        svg.text(x + 34, 111, lab, 10, INK, 'middle')
    svg.save()


def d_jobdone4():
    svg = Svg('jobdone4', 320, 200, 'Hadi with a JOB DONE stamp after month-end for Gogo', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Plan Wars', 15, INK, 'middle', font=MARKER)
    svg.save()


# ------------------------------------------- batch 5: Plan Wars -----------
# Theme A: a game-show "versus" screen - a diagonal red/blue split, a big
# yellow VS, plan cards with stat bars.

VS_RED, VS_BLUE, VS_YELLOW = '#e63b2e', '#1d4fd8', '#ffd84d'


def versus(name, w, h, label):
    svg = Svg(name, w, h, label, rx=8)
    svg.add(f'<path d="M0 0 H{w * .58} L{w * .42} {h} H0Z" fill="{VS_RED}"/><path d="M{w * .58} 0 H{w} V{h} H{w * .42}Z" fill="{VS_BLUE}"/>')
    return svg


def plan_card(svg, x, y, w, title, bars, colour):
    h = 34 + len(bars) * 24
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="6" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    svg.text(x + w / 2, y + 22, title, 12, colour, 'middle')
    for i, (lab, frac) in enumerate(bars):
        yy = y + 34 + i * 24
        svg.text(x + 8, yy + 9, lab, 10, INK, 'start', 600, NUM)
        svg.add(f'<rect x="{x + 58}" y="{yy}" width="{w - 68}" height="10" rx="3" fill="#e8e8e8"/><rect x="{x + 58}" y="{yy}" width="{(w - 68) * frac:.1f}" height="10" rx="3" fill="{colour}"/>')


def vs_badge(svg, cx, cy, s=1.0):
    svg.text(cx + 3 * s, cy + 3 * s, 'VS', int(40 * s), INK, 'middle')
    svg.text(cx, cy, 'VS', int(40 * s), VS_YELLOW, 'middle')


def d_versus():
    svg = versus('versus', 330, 200, 'Two plans face off: compare the total cost for the way you actually use it')
    plan_card(svg, 14, 26, 120, 'PLAN A', [('fee', .3), ('per min', .8), ('data', .5)], VS_RED)
    plan_card(svg, 196, 26, 120, 'PLAN B', [('fee', .8), ('per min', .3), ('data', .6)], VS_BLUE)
    vs_badge(svg, 165, 112)
    svg.text(165, 186, 'WHO WINS? IT DEPENDS ON YOU', 11, WHITE, 'middle')
    svg.save()


def d_blocks():
    svg = versus('blocks', 330, 200, 'Block tariff: the first 350 units are cheaper, every unit after that costs more')
    svg.add(f'<rect x="20" y="40" width="290" height="130" rx="6" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    for i in range(10):
        x = 32 + i * 27
        hgt = 34 if i < 5 else 58
        col = '#7bc96f' if i < 5 else VS_RED
        svg.add(f'<rect x="{x}" y="{150 - hgt}" width="22" height="{hgt}" fill="{col}" stroke="{INK}" stroke-width="1.5"/>')
    svg.text(98, 66, 'BLOCK 1: R2,80', 11, '#2f7d32', 'middle')
    svg.text(234, 66, 'BLOCK 2: R3,40', 11, VS_RED, 'middle')
    svg.add(f'<path d="M165 46 V160" stroke="{INK}" stroke-width="2" stroke-dasharray="4 3"/>')
    svg.text(165, 26, '350 UNITS', 13, VS_YELLOW, 'middle')
    svg.text(165, 190, 'units used this month →', 11, WHITE, 'middle', 600, NUM)
    svg.save()


def d_phone():
    svg = versus('phone', 320, 200, 'A phone showing 100 free minutes used up and out-of-bundle minutes ticking')
    svg.add(f'<rect x="110" y="16" width="100" height="170" rx="14" fill="{INK}"/><rect x="118" y="30" width="84" height="138" rx="4" fill="#e9f3ff"/>')
    svg.text(160, 56, '100 MIN', 12, VS_BLUE, 'middle')
    svg.add(f'<rect x="128" y="64" width="64" height="10" rx="3" fill="{VS_BLUE}"/>')
    svg.text(160, 98, 'USED UP', 10, INK, 'middle')
    svg.text(160, 128, '+R1,20', 16, VS_RED, 'middle')
    svg.text(160, 146, 'a minute', 11, INK, 'middle', 600, NUM)
    hadi(svg, 222, 98, .8, 'shout')
    svg.save()


def d_taxi():
    svg = versus('taxi', 330, 200, 'A minibus taxi with a flat fare sign and an e-hailing car with a fare that grows with distance')
    bx = 22
    svg.add(f'<g transform="translate({bx} 70)"><rect x="0" y="0" width="120" height="56" rx="12" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>'
            + ''.join(f'<rect x="{10 + k * 26}" y="10" width="20" height="16" fill="#9fd3f5" stroke="{INK}" stroke-width="1.5"/>' for k in range(4))
            + f'<path d="M0 38 H120" stroke="{VS_RED}" stroke-width="4"/><circle cx="26" cy="58" r="9" fill="{INK}"/><circle cx="94" cy="58" r="9" fill="{INK}"/></g>')
    svg.text(82, 56, 'R18 ANY TRIP', 12, VS_YELLOW, 'middle')
    car(svg, 214, 92, VS_YELLOW, 1.0)
    svg.text(246, 56, 'R15 + R8,50/KM', 12, VS_YELLOW, 'middle')
    vs_badge(svg, 165, 160, .7)
    svg.save()


def d_jobdone5():
    svg = Svg('jobdone5', 320, 200, 'Hadi with a JOB DONE stamp after Plan Wars', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: the Bake-Off', 15, INK, 'middle', font=MARKER)
    svg.save()


if __name__ == '__main__':
    for o in [(25, 5, 1, 4, 'Prepaid electricity', 'The first units are the cheapest.', ['BLOCK 2', 'COSTS MORE']),
              (26, 5, 2, 4, 'Phone and data', 'Free minutes are not free forever.', ['OUT OF', 'BUNDLE!']),
              (27, 5, 3, 4, 'Taxi, bus or e-hailing', 'A fee, a rate, or both?', ['R18 FLAT!']),
              (28, 5, 4, 4, 'Tariffs as graphs', 'Draw the deal, see the deal.', ['STEP BY', 'STEP'])]:
        opener(*o)
    d_versus(); d_blocks(); d_phone(); d_taxi(); d_jobdone5()
    for o in [(21, 4, 1, 4, 'The municipal bill', 'Read every line before you pay.', ['DUE DATE!', 'SQUAWK!']),
              (22, 4, 2, 4, 'Till slips and accounts', 'Keep the slip. Check the slip.', ['CHECK', 'THE SLIP']),
              (23, 4, 3, 4, 'The bank statement', 'Money in, money out, what is left.', ['DEBIT OR', 'CREDIT?']),
              (24, 4, 4, 4, 'Where does the money go?', 'Plan it before you spend it.', ['BUDGET', 'FIRST!'])]:
        opener(*o)
    municipal_bill(); till_slip(); store_statement(); bank_statement(); bank_statement(True)
    d_shoebox(); d_paid(); d_magnifier(); d_debitcredit(); d_jar(); d_jobdone4()
    openers3 = [
        (14, 3, 1, 5, 'Ask a good question',  'Ask it fair, or the answers lie.', ['NO LEADING', 'QUESTIONS!']),
        (15, 3, 2, 5, 'Collecting it',        'Taste the soup: one well-stirred spoon.', ['WHO DO', 'WE ASK?']),
        (16, 3, 3, 5, 'Sorting it',           'Count it, group it, table it.', ['FOUR AND', 'A CROSS']),
        (17, 3, 4, 5, 'The middle and the spread', 'Mean, median, mode - and range.', ['MIDDLE', 'OF WHAT?']),
        (18, 3, 5, 5, 'Which average tells the truth?', 'One loud number can fool a mean.', ['SQUAWK!', 'OUTLIER!']),
    ]
    for o in openers3:
        opener(*o)
    opener(19, 3, 1, 2, 'Investigation workshop', 'Question, collect, sort, sum up, conclude.', ['SHOW YOUR', 'THINKING'], 'TERM 1 ASSESSMENT · 1 OF 2')
    opener(20, 3, 2, 2, 'Term 1 test', 'Read twice, show working, give units.', ['UNITS!', 'SQUAWK!'], 'TERM 1 ASSESSMENT · 2 OF 2')
    d_leading(); d_soup(); d_tally(); d_middle(); d_vu(); d_outlier(); d_jobdone3()

    openers2 = [
        (9,  2, 1, 5, 'Three kinds of relationship', 'Fixed, together, or opposite?', ['R150 NO', 'MATTER WHAT']),
        (10, 2, 2, 5, 'Tables of values',            'One thing depends on the other.', ['WHICH ONE', 'DEPENDS?']),
        (11, 2, 3, 5, 'Formula to graph',            'Plot it, then join it - or not.', ['JOIN THE', 'DOTS?']),
        (12, 2, 4, 5, 'Reading the graph',           'Across, up, read it off.',       ['ACROSS,', 'THEN UP!']),
        (13, 2, 5, 5, 'The graph tells a story',     'Every line has a plot.',         ['ONCE UPON', 'A GRAPH']),
    ]
    for o in openers2:
        opener(*o)
    d_hire(); d_sponges(); d_dots(); d_hose(); d_queue(); d_jobdone2()
    plot('incomegraph', 'Income from the car wash: R60 for every car washed, from 0 to 10 cars',
         (0, 10, 1), (0, 600, 50), 'Number of cars washed', 'Income (R)', 'Income from washing cars',
         [('dots', [(c, 60 * c) for c in range(11)], BLUE)], yevery=2)
    plot('tankgraph', 'Water left in a 480 litre tank used at 12 litres a minute, from 0 to 40 minutes',
         (0, 40, 5), (0, 480, 40), 'Time (minutes)', 'Water left in the tank (litres)', 'Water left in the tank',
         [('line', [(0, 480), (40, 0)], RED)], yevery=2)
    plot('profitgraph', 'Profit from the car wash: R60 a car less the R150 hire, from 0 to 10 cars',
         (0, 10, 1), (-150, 450, 50), 'Number of cars washed', 'Profit (R)', 'Profit from the car wash',
         [('dots', [(c, 60 * c - 150) for c in range(11)], BLUE)], yevery=1)
    story_choice()

    openers = [
        (1, 1, 1, 8, 'The price board',       'Write it the way South Africa reads it.', ['COMMA, NOT', 'POINT!']),
        (2, 1, 2, 8, 'Cash-up',               'Add up the day - no phone needed.',        ['× BEFORE +!']),
        (3, 1, 3, 8, 'Half a loaf',           'A quarter kota is a fraction you can eat.', ['¼ LOAF,', 'FULL BELLY']),
        (4, 1, 4, 8, 'Round it how?',         'Up, down or off - ask the situation.',      ['SQUAWK!', 'ROUND UP!']),
        (5, 1, 5, 8, 'The secret sauce',      'Three, two, one - and never tell.',         ['3 : 2 : 1']),
        (6, 1, 6, 8, 'Feeding a crowd',       'More mouths? More rolls.', ['MORE HANDS,', 'LESS TIME']),
        (7, 1, 7, 8, 'Rand per kilogram',     'Same unit, fair fight.', ['PER KG,', 'PLEASE']),
        (8, 1, 8, 8, 'Specials and mark-ups', 'Percent means "out of a hundred".',         ['10% OFF?', 'SQUAWK!']),
    ]
    for o in openers:
        opener(*o)
    price_board()
    d_comma(); d_freezer(); d_bodmas(); d_loaf(); d_roundup(); d_sauce(); d_helpers()
    d_bestbuy(); d_special(); d_markup(); d_jobdone(); hadi_card()
    number_line(); ratio_bar(); fraction_wall()
