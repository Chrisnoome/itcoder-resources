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

def opener(n, batch, lesson_in_batch, of, title, slogan, says):
    """A lesson's opening sign: the batch, the lesson title, a slogan, the
    minibus route of the year with this batch's stop circled, and Hadi."""
    svg = Svg(f'open-{n:02d}', 560, 300, f'Lesson {n}: {title}', bg=SIGN, rx=8)
    svg.add(f'<rect x="10" y="10" width="540" height="280" rx="4" fill="none" stroke="{INK}" stroke-width="5"/>')
    svg.add(f'<rect x="18" y="18" width="524" height="264" rx="2" fill="none" stroke="{RED}" stroke-width="2"/>')
    svg.text(36, 50, f'{BATCHES[batch - 1].upper()} · LESSON {lesson_in_batch} OF {of}', 13, INK)
    lines = wrap(title.upper(), 13)
    size = 34 if max(len(l) for l in lines) <= 11 else 29
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
    svg.text(114, 96, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(114, 122, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
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


if __name__ == '__main__':
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
