"""Draws the Tuck-shop tycoon course's art (brand/tuckshop-art-style.md).

The board-game tycoon look: the term is a board game (one square per lesson,
the class's pawn on the lesson's square), play money and dice, bright primary
colours with dark green outlines, Fredoka for every word - and the mascots
Till (the grumpy old cash register who only rings for real formulas) and Calc
(the pocket calculator who types answers in). Writes
AIPascalCourse/public/assets/doodles/tuckshop-*.svg.

  python -X utf8 tools/tuckshop/make_art.py
"""
import os, math

DOODLES = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'

INK, GREEN_BG, WHITE = '#10301d', '#dff0e2', '#ffffff'
YELLOW, SKY, RED, LIME, VIOLET = '#ffd84d', '#8fd3ff', '#e8483b', '#b6e388', '#6a4cff'
TILL_GREEN, TILL_GOLD, CREAM = '#1d5c4a', '#e9b949', '#f1e6cf'
CALC_VIOLET, CALC_SCREEN, PEACH = '#6a5cff', '#c9f2dd', '#ffb4a2'
FONT = "'Fredoka', 'Baloo 2', 'Segoe UI', sans-serif"
GRIDFONT = "'Segoe UI', Calibri, Arial, sans-serif"


def esc(text):
    return text.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, w, h, label, bg=GREEN_BG):
        self.w, self.h, self.label, self.parts = w, h, label, []
        if bg:
            self.add(f'<rect width="{w}" height="{h}" rx="10" fill="{bg}"/>')

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=INK, anchor='start', weight=700, font=FONT):
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" font-weight="{weight}" fill="{fill}" text-anchor="{anchor}">{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self, name):
        os.makedirs(DOODLES, exist_ok=True)
        with open(os.path.join(DOODLES, 'tuckshop-' + name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print('tuckshop-' + name + '.svg')


# ------------------------------------------------------------- pieces ----

def bubble(svg, x, y, w, lines, tail_x, tail_y, size=13, fill=WHITE):
    """A rounded speech bubble with its tail pointing at (tail_x, tail_y)."""
    h = 14 + len(lines) * (size + 5)
    bx = min(max(tail_x, x + 16), x + w - 16)
    by = y + h if tail_y > y + h else y
    svg.add(f'<path d="M{bx - 9} {by} L{tail_x} {tail_y} L{bx + 9} {by}" fill="{fill}" stroke="{INK}" stroke-width="2.5" stroke-linejoin="round"/>')
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="12" fill="{fill}" stroke="{INK}" stroke-width="2.5"/>')
    svg.add(f'<path d="M{bx - 7} {by} L{bx + 7} {by}" stroke="{fill}" stroke-width="4"/>')
    for i, line in enumerate(lines):
        svg.text(x + 12, y + 7 + size + i * (size + 5), line, size, INK, weight=600)


def eyes(svg, cx, cy, s, mood, gap=12, r=5.5):
    for dx in (-gap, gap):
        ex = cx + dx * s
        if mood == 'shut':
            svg.add(f'<path d="M{ex - 5 * s} {cy} q{5 * s} {4 * s} {10 * s} 0" stroke="{INK}" stroke-width="{2.5 * s}" fill="none" stroke-linecap="round"/>')
        else:
            svg.add(f'<circle cx="{ex}" cy="{cy}" r="{r * s}" fill="{WHITE}" stroke="{INK}" stroke-width="{1.5 * s}"/>')
            look = 2 * s if mood == 'side' else 0
            svg.add(f'<circle cx="{ex + look}" cy="{cy + 0.5 * s}" r="{2.6 * s}" fill="{INK}"/>')
    if mood == 'cross':
        svg.add(f'<path d="M{cx - (gap + 7) * s} {cy - 9 * s} l{10 * s} {4 * s} M{cx + (gap + 7) * s} {cy - 9 * s} l{-10 * s} {4 * s}" stroke="{INK}" stroke-width="{2.5 * s}" stroke-linecap="round"/>')


def mouth(svg, cx, cy, s, mood):
    if mood in ('happy', 'shut', 'side'):
        svg.add(f'<path d="M{cx - 9 * s} {cy} q{9 * s} {9 * s} {18 * s} 0" stroke="{INK}" stroke-width="{2.6 * s}" fill="none" stroke-linecap="round"/>')
    elif mood == 'cross':
        svg.add(f'<path d="M{cx - 8 * s} {cy + 4 * s} q{8 * s} {-6 * s} {16 * s} 0" stroke="{INK}" stroke-width="{2.6 * s}" fill="none" stroke-linecap="round"/>')
    elif mood == 'oh':
        svg.add(f'<ellipse cx="{cx}" cy="{cy + 2 * s}" rx="{4.5 * s}" ry="{5.5 * s}" fill="{INK}"/>')
    elif mood == 'grin':
        svg.add(f'<path d="M{cx - 11 * s} {cy - 2 * s} q{11 * s} {14 * s} {22 * s} 0 z" fill="{WHITE}" stroke="{INK}" stroke-width="{2.4 * s}" stroke-linejoin="round"/>')


def till(svg, cx, cy, s=1.0, mood='happy', shows='R0'):
    """Till: the old green cash register. (cx, cy) is the middle of its body."""
    o = lambda v: v * s
    svg.add(f'<path d="M{cx - o(44)} {cy - o(22)} L{cx - o(30)} {cy - o(54)} L{cx + o(30)} {cy - o(54)} L{cx + o(44)} {cy - o(22)} Z" fill="{TILL_GOLD}" stroke="{INK}" stroke-width="{o(3)}" stroke-linejoin="round"/>')
    for i in range(4):
        svg.add(f'<circle cx="{cx - o(22) + i * o(14.7)}" cy="{cy - o(36)}" r="{o(4)}" fill="{CREAM}" stroke="{INK}" stroke-width="{o(1.2)}"/>')
    svg.add(f'<rect x="{cx - o(20)}" y="{cy - o(76)}" width="{o(40)}" height="{o(22)}" rx="{o(3)}" fill="{CREAM}" stroke="{INK}" stroke-width="{o(2.5)}"/>')
    svg.text(cx, cy - o(60), shows, o(12), INK, 'middle')
    svg.add(f'<rect x="{cx - o(52)}" y="{cy - o(22)}" width="{o(104)}" height="{o(66)}" rx="{o(8)}" fill="{TILL_GREEN}" stroke="{INK}" stroke-width="{o(3)}"/>')
    svg.add(f'<rect x="{cx - o(46)}" y="{cy + o(28)}" width="{o(92)}" height="{o(10)}" rx="{o(3)}" fill="{CREAM}" stroke="{INK}" stroke-width="{o(1.5)}"/>')
    svg.add(f'<circle cx="{cx}" cy="{cy + o(33)}" r="{o(2.5)}" fill="{INK}"/>')
    eyes(svg, cx, cy - o(4), s, mood)
    mouth(svg, cx, cy + o(12), s, mood)
    svg.add(f'<path d="M{cx + o(52)} {cy} q{o(16)} {o(-4)} {o(18)} {o(-20)}" stroke="{INK}" stroke-width="{o(3)}" fill="none" stroke-linecap="round"/>')
    svg.add(f'<circle cx="{cx + o(70)}" cy="{cy - o(22)}" r="{o(5)}" fill="{RED}" stroke="{INK}" stroke-width="{o(2)}"/>')


def calc(svg, cx, cy, s=1.0, mood='happy', shows='0'):
    """Calc: the violet pocket calculator. (cx, cy) is the middle of its body."""
    o = lambda v: v * s
    svg.add(f'<rect x="{cx - o(34)}" y="{cy - o(52)}" width="{o(68)}" height="{o(104)}" rx="{o(10)}" fill="{CALC_VIOLET}" stroke="{INK}" stroke-width="{o(3)}"/>')
    svg.add(f'<rect x="{cx - o(25)}" y="{cy - o(43)}" width="{o(50)}" height="{o(20)}" rx="{o(3)}" fill="{CALC_SCREEN}" stroke="{INK}" stroke-width="{o(2)}"/>')
    svg.text(cx + o(21), cy - o(28), shows, o(12), INK, 'end')
    eyes(svg, cx, cy - o(8), s, mood, gap=10, r=5)
    mouth(svg, cx, cy + o(6), s, mood)
    for row in range(2):
        for col in range(3):
            fill = PEACH if (row, col) == (1, 2) else '#eef1ff'
            svg.add(f'<rect x="{cx - o(24) + col * o(17)}" y="{cy + o(18) + row * o(15)}" width="{o(13)}" height="{o(11)}" rx="{o(2.5)}" fill="{fill}" stroke="{INK}" stroke-width="{o(1.4)}"/>')
    svg.add(f'<path d="M{cx - o(34)} {cy} q{o(-16)} {o(-2)} {o(-20)} {o(-18)}" stroke="{INK}" stroke-width="{o(3)}" fill="none" stroke-linecap="round"/>')


def note(svg, x, y, value, fill, rot=0):
    svg.add(f'<g transform="translate({x} {y}) rotate({rot})"><rect width="92" height="46" rx="4" fill="{fill}" stroke="{INK}" stroke-width="2"/>'
            f'<rect x="5" y="5" width="82" height="36" fill="none" stroke="{INK}" stroke-dasharray="3 2"/>'
            f'<text x="46" y="30" text-anchor="middle" font-family="{FONT}" font-weight="700" font-size="17" fill="{INK}">{esc(value)}</text></g>')


def die(svg, x, y, n, fill=WHITE, pip=INK, rot=0, size=38):
    spots = {1: [(.5, .5)], 2: [(.27, .27), (.73, .73)], 3: [(.25, .25), (.5, .5), (.75, .75)],
             4: [(.28, .28), (.72, .28), (.28, .72), (.72, .72)], 5: [(.26, .26), (.74, .26), (.5, .5), (.26, .74), (.74, .74)],
             6: [(.28, .22), (.72, .22), (.28, .5), (.72, .5), (.28, .78), (.72, .78)]}[n]
    dots = ''.join(f'<circle cx="{size * a}" cy="{size * b}" r="{size * .095}" fill="{pip}"/>' for a, b in spots)
    svg.add(f'<g transform="translate({x} {y}) rotate({rot})"><rect width="{size}" height="{size}" rx="{size * .2}" fill="{fill}" stroke="{INK}" stroke-width="2.5"/>{dots}</g>')


def pawn(svg, cx, base_y, s=1.0):
    o = lambda v: v * s
    svg.add(f'<ellipse cx="{cx}" cy="{base_y}" rx="{o(13)}" ry="{o(4)}" fill="{INK}" opacity=".25"/>')
    svg.add(f'<path d="M{cx - o(11)} {base_y} q{o(11)} {o(-30)} 0 {o(-36)} q{o(-11)} {o(6)} 0 {o(36)} z" fill="{VIOLET}"/>')
    svg.add(f'<path d="M{cx - o(12)} {base_y} C{cx - o(10)} {base_y - o(16)} {cx - o(4)} {base_y - o(22)} {cx - o(4)} {base_y - o(26)} L{cx + o(4)} {base_y - o(26)} C{cx + o(4)} {base_y - o(22)} {cx + o(10)} {base_y - o(16)} {cx + o(12)} {base_y} Z" fill="{VIOLET}" stroke="{INK}" stroke-width="{o(2)}" stroke-linejoin="round"/>')
    svg.add(f'<circle cx="{cx}" cy="{base_y - o(32)}" r="{o(8)}" fill="{VIOLET}" stroke="{INK}" stroke-width="{o(2)}"/>')
    svg.add(f'<circle cx="{cx - o(3)}" cy="{base_y - o(35)}" r="{o(2.2)}" fill="{WHITE}" opacity=".7"/>')


def grid(svg, x, y, cols, rows, widths, cells, row_h=22, yellow=(), formats=None, header=True, font_size=12):
    """A small Excel-like grid. cells: {(col, row): text}; col 0 = A. yellow: cells to mark as the pupil's."""
    lead = 26
    total_w = lead + sum(widths)
    svg.add(f'<rect x="{x}" y="{y}" width="{total_w}" height="{row_h * (rows + 1)}" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    if header:
        svg.add(f'<rect x="{x}" y="{y}" width="{total_w}" height="{row_h}" fill="#eef0ec"/>')
        svg.add(f'<rect x="{x}" y="{y}" width="{lead}" height="{row_h * (rows + 1)}" fill="#eef0ec"/>')
    cx = x + lead
    for c in range(cols):
        svg.text(cx + widths[c] / 2, y + row_h - 7, chr(65 + c), 11, '#555', 'middle', 400, GRIDFONT)
        cx += widths[c]
    for r in range(rows):
        svg.text(x + lead / 2, y + row_h * (r + 2) - 7, str(r + 1), 11, '#555', 'middle', 400, GRIDFONT)
    for (c, r) in yellow:
        cx = x + lead + sum(widths[:c])
        svg.add(f'<rect x="{cx}" y="{y + row_h * (r + 1)}" width="{widths[c]}" height="{row_h}" fill="#fff6b3"/>')
    cx = x + lead
    for c in range(cols + 1):
        svg.add(f'<line x1="{cx}" y1="{y}" x2="{cx}" y2="{y + row_h * (rows + 1)}" stroke="#c9cec6" stroke-width="1"/>')
        if c < cols:
            cx += widths[c]
    for r in range(rows + 1):
        svg.add(f'<line x1="{x}" y1="{y + row_h * (r + 1)}" x2="{x + total_w}" y2="{y + row_h * (r + 1)}" stroke="#c9cec6" stroke-width="1"/>')
    for (c, r), words in cells.items():
        cx = x + lead + sum(widths[:c])
        right = isinstance(words, (int, float)) or (isinstance(words, str) and (words[:1].isdigit() or words.startswith('R ') or words.startswith('#')))
        weight = 700 if r == 0 and header else 400
        label = words if isinstance(words, str) else f'{words:g}'
        if right:
            svg.text(cx + widths[c] - 6, y + row_h * (r + 2) - 7, label, font_size, '#222', 'end', weight, GRIDFONT)
        else:
            svg.text(cx + 6, y + row_h * (r + 2) - 7, label, font_size, '#222', 'start', weight, GRIDFONT)
    return total_w


def cell_box(svg, x, y, w, h, color=RED):
    svg.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="none" stroke="{color}" stroke-width="3" rx="2"/>')


# ------------------------------------------------------------- the board ----

SQUARES = [  # (label, colour) for GO and the 8 lessons
    ('GO', YELLOW), ('PRICES', SKY), ('TAKINGS', WHITE), ('TOTALS', LIME), ('PROFIT', RED),
    ('BEST', YELLOW), ('LOOKS', SKY), ('CHARTS', LIME), ('BIG DAY', RED),
]
SAYINGS = {
    1: (['Every cell has an address.', 'Like a house on a street!'], 'till'),
    2: (['Price times number sold.', 'Let the sheet do the sums.'], 'till'),
    3: (['SUM adds a whole column', 'in one go. Ka-ching!'], 'till'),
    4: (['Selling price minus cost', 'price. That is the profit.'], 'till'),
    5: (['Which snack sells best?', 'MAX knows.'], 'calc'),
    6: (['#####? The column is just', 'too narrow. Make it wider!'], 'calc'),
    7: (['A picture of the numbers.', 'One look tells the story.'], 'till'),
    8: (['The big day: plan the', 'fundraiser, every rand.'], 'till'),
}


def board(n):
    """The lesson-n opener: the board track with the pawn on square n, Till and Calc in the middle."""
    s = Svg(560, 312, f'The Tuck-shop tycoon board, with the class\'s pawn on square {n}: {SQUARES[n][0].lower()}')
    sw, sh = 92, 56
    spots = [(18 + i * (sw + 15), 34) for i in range(5)] + [(18 + (3 - i) * (sw + 15) + (sw + 15) / 2, 240) for i in range(4)]
    # the track joining the squares
    pts = [(x + sw / 2, y + sh / 2) for x, y in spots]
    d = 'M' + ' L'.join(f'{px} {py}' for px, py in pts[:5]) + f' Q{pts[4][0] + 40} {(pts[4][1] + pts[5][1]) / 2} {pts[5][0]} {pts[5][1]} L' + ' L'.join(f'{px} {py}' for px, py in pts[5:])
    s.add(f'<path d="{d}" fill="none" stroke="{INK}" stroke-width="6" stroke-dasharray="2 10" stroke-linecap="round" opacity=".35"/>')
    for i, ((x, y), (label, colour)) in enumerate(zip(spots, SQUARES)):
        here = (i == n)
        done = 0 < i < n
        s.add(f'<rect x="{x}" y="{y}" width="{sw}" height="{sh}" rx="6" fill="{colour}" stroke="{INK}" stroke-width="{4 if here else 2.5}"/>')
        if i:
            s.add(f'<circle cx="{x + 14}" cy="{y + 14}" r="9" fill="{WHITE}" stroke="{INK}" stroke-width="1.8"/>')
            s.text(x + 14, y + 18.5, str(i), 11, INK, 'middle')
        s.text(x + sw / 2 + (6 if i else 0), y + sh / 2 + (12 if i else 8), label, 13 if i else 20, INK, 'middle')
        if done:
            s.add(f'<path d="M{x + sw - 22} {y + 14} l5 6 l10 -11" stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/>')
    px, py = spots[n]
    pawn(s, px + sw - 12, py + 20, 0.82)
    # the middle: Till and Calc, and the lesson's saying
    lines, who = SAYINGS[n]
    till(s, 130, 176, 0.75, 'happy' if who == 'till' else 'side', 'R' + str(n * 12))
    calc(s, 430, 170, 0.75, 'happy' if who == 'calc' else 'side', str(n))
    if who == 'till':
        bubble(s, 196, 120, 206, lines, 182, 160)
    else:
        bubble(s, 186, 120, 206, lines, 400, 150)
    die(s, 486, 140, (n % 6) + 1, WHITE, INK, 14, 30)
    s.save(f'board-{n:02d}')


# ------------------------------------------------------------- doodles ----

def pair():
    s = Svg(300, 180, 'Till the cash register and Calc the calculator, side by side')
    till(s, 90, 110, 0.85, 'happy', 'R0')
    calc(s, 220, 104, 0.85, 'grin', '0')
    s.save('pair')


def calc_wrong():
    s = Svg(320, 190, 'Calc typed in 432. Then the price went up, and 432 is now wrong; the formula =B2*C2 gave the new answer.')
    grid(s, 14, 16, 3, 2, [70, 50, 64], {(0, 0): 'Price', (1, 0): 'Sold', (2, 0): 'Takings', (0, 1): 'R 20.00', (1, 1): '24', (2, 1): '432'}, yellow=[(2, 1)])
    s.add(f'<line x1="46" y1="66" x2="104" y2="56" stroke="{RED}" stroke-width="3"/>')
    s.text(76, 92, 'was R 18.00!', 12, RED, 'middle')
    calc(s, 260, 110, 0.75, 'oh', '432')
    bubble(s, 14, 120, 186, ['Oops. I typed 432.', 'Now it should be 480.'], 228, 106, 12)
    s.save('calc-wrong')


def kaching():
    s = Svg(300, 180, 'Till rings: ka-ching! for a real formula that points at cells')
    till(s, 100, 116, 0.9, 'shut', 'R480')
    for a in (-60, -30, 0, 30):
        r = math.radians(a)
        s.add(f'<line x1="{100 + 70 * math.sin(r)}" y1="{40 - 20 * math.cos(r)}" x2="{100 + 86 * math.sin(r)}" y2="{40 - 34 * math.cos(r)}" stroke="{RED}" stroke-width="3" stroke-linecap="round"/>')
    s.text(222, 92, 'KA-', 26, RED, 'middle')
    s.text(222, 124, 'CHING!', 26, RED, 'middle')
    s.save('kaching')


def address():
    s = Svg(370, 200, 'Column C and row 4 cross at cell C4')
    grid(s, 20, 20, 4, 6, [56, 56, 56, 56], {}, row_h=24)
    s.add(f'<rect x="{20 + 26 + 112}" y="{20}" width="56" height="{24 * 7}" fill="{SKY}" opacity=".45"/>')
    s.add(f'<rect x="20" y="{20 + 24 * 4}" width="{26 + 224}" height="24" fill="{YELLOW}" opacity=".55"/>')
    cell_box(s, 20 + 26 + 112, 20 + 24 * 4, 56, 24, RED)
    s.text(20 + 26 + 140, 20 + 24 * 5 - 7, 'C4', 13, RED, 'middle')
    s.text(284, 46, 'column C', 13, INK, 'start')
    s.add(f'<path d="M282 42 q-40 0 -96 -4" stroke="{INK}" stroke-width="2" fill="none" stroke-dasharray="4 3"/>')
    s.text(284, 132, 'row 4', 13, INK, 'start')
    s.save('address')


def fill_handle():
    s = Svg(320, 210, 'The fill handle: drag the small square at the corner of D2 down, and the formula is copied to every row')
    grid(s, 16, 16, 4, 6, [62, 48, 40, 62], {(0, 0): 'Item', (1, 0): 'Price', (2, 0): 'Sold', (3, 0): 'Takings',
                                             (3, 1): '=B2*C2', (3, 2): '=B3*C3', (3, 3): '=B4*C4', (3, 4): '=B5*C5'}, yellow=[(3, 1), (3, 2), (3, 3), (3, 4)], font_size=11)
    x = 16 + 26 + 62 + 48 + 40
    cell_box(s, x, 16 + 44, 62, 22 * 4, '#1f8a5b')
    s.add(f'<rect x="{x + 57}" y="{16 + 44 + 22 * 4 - 5}" width="8" height="8" fill="#1f8a5b" stroke="{WHITE}" stroke-width="1.5"/>')
    s.add(f'<path d="M{x + 82} {16 + 22 * 2} L{x + 82} {16 + 22 * 5}" stroke="{RED}" stroke-width="3" marker-end="url(#ah)"/>')
    s.add(f'<defs><marker id="ah" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="5" markerHeight="5" orient="auto"><path d="M0 0 L10 5 L0 10 z" fill="{RED}"/></marker></defs>')
    s.text(x + 92, 16 + 22 * 3, 'drag', 13, RED)
    s.text(x + 92, 16 + 22 * 3 + 16, 'down', 13, RED)
    s.text(16, 196, 'The row numbers change by themselves.', 13, INK)
    s.save('fill-handle')


def sum_column():
    s = Svg(300, 220, 'SUM gathers a whole column of numbers into one total')
    grid(s, 16, 16, 2, 7, [72, 62], {(0, 0): 'Day', (1, 0): 'Takings', (0, 1): 'Mon', (1, 1): '640', (0, 2): 'Tue', (1, 2): '585',
                                     (0, 3): 'Wed', (1, 3): '712', (0, 4): 'Thu', (1, 4): '498', (0, 5): 'Fri', (1, 5): '903', (0, 6): 'Total', (1, 6): '3338'}, yellow=[(1, 6)])
    s.add(f'<path d="M{16 + 26 + 72 + 66} 44 q22 60 0 112" stroke="{RED}" stroke-width="3" fill="none"/>')
    s.text(198, 104, '=SUM(B2:B6)', 13, RED)
    till(s, 236, 184, 0.38, 'happy', '')
    s.save('sum')


def profit():
    s = Svg(340, 180, 'Selling price take away cost price is the profit on each item')
    def tag(x, y, top, value, fill):
        s.add(f'<g transform="translate({x} {y})"><path d="M0 12 L12 0 H86 V56 H12 L0 44 Z" fill="{fill}" stroke="{INK}" stroke-width="2.5" stroke-linejoin="round"/>'
              f'<circle cx="14" cy="28" r="4" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>'
              f'<text x="50" y="22" text-anchor="middle" font-family="{FONT}" font-weight="600" font-size="11" fill="{INK}">{esc(top)}</text>'
              f'<text x="50" y="44" text-anchor="middle" font-family="{FONT}" font-weight="700" font-size="17" fill="{INK}">{esc(value)}</text></g>')
    tag(14, 30, 'we sell for', 'R 18', YELLOW)
    s.text(116, 66, '-', 30, INK, 'middle')
    tag(128, 30, 'it cost us', 'R 11', SKY)
    s.text(230, 66, '=', 30, INK, 'middle')
    tag(242, 30, 'profit', 'R 7', LIME)
    s.text(170, 124, 'Selling price - cost price = profit', 14, INK, 'middle')
    s.text(170, 150, 'on every mince pie we sell', 12, INK, 'middle', 600)
    s.save('profit')


def podium():
    s = Svg(320, 190, 'A podium: MAX finds the most, MIN the fewest')
    for x, h, fill, place, item in ((40, 70, SKY, '2', 'Juice'), (120, 100, YELLOW, '1', 'Popcorn'), (200, 50, RED, '3', 'Muffin')):
        s.add(f'<rect x="{x}" y="{170 - h}" width="76" height="{h}" fill="{fill}" stroke="{INK}" stroke-width="2.5"/>')
        s.text(x + 38, 170 - h + 30, place, 24, INK, 'middle')
        s.text(x + 38, 170 - h - 10, item, 13, INK, 'middle')
    s.text(158, 24, 'MAX', 18, '#1f8a5b', 'middle')
    s.add(f'<path d="M158 30 v18" stroke="#1f8a5b" stroke-width="3"/>')
    s.text(238, 92, 'MIN', 18, RED, 'middle')
    s.save('podium')


def hashes():
    s = Svg(320, 170, 'A column too narrow shows ##### instead of the number')
    grid(s, 14, 16, 2, 3, [70, 46], {(0, 0): 'Item', (1, 0): 'Takings', (0, 1): 'Mince pie', (1, 1): '#####', (0, 2): 'Juice', (1, 2): '#####'}, font_size=12)
    s.add(f'<path d="M{14 + 26 + 70 + 46} 24 v60" stroke="{RED}" stroke-width="3"/>')
    s.add(f'<path d="M{14 + 26 + 70 + 46 + 4} 54 h26" stroke="{RED}" stroke-width="3" marker-end="url(#ah2)"/>')
    s.add(f'<defs><marker id="ah2" viewBox="0 0 10 10" refX="5" refY="5" markerWidth="5" markerHeight="5" orient="auto"><path d="M0 0 L10 5 L0 10 z" fill="{RED}"/></marker></defs>')
    s.text(14, 130, 'Drag the line between the column', 12, INK, weight=600)
    s.text(14, 148, 'letters to make the column wider.', 12, INK, weight=600)
    calc(s, 268, 92, 0.55, 'oh', '####')
    s.save('hashes')


def format_before_after():
    s = Svg(560, 220, 'The same price list before and after formatting: bold headings, rands with two decimals, wide enough columns')
    s.text(20, 26, 'Before', 15, RED)
    grid(s, 20, 36, 3, 5, [70, 44, 44], {(0, 0): 'item', (1, 0): 'price', (2, 0): 'sold', (0, 1): 'Mince pi', (1, 1): '18', (2, 1): '24',
                                          (0, 2): 'Juice', (1, 2): '12', (2, 2): '31', (0, 3): 'Lollipop', (1, 3): '2.5', (2, 3): '58', (0, 4): 'Koeksist', (1, 4): '6', (2, 4): '40'}, header=True)
    s.text(300, 26, 'After', 15, '#1f8a5b')
    grid(s, 300, 36, 3, 5, [96, 70, 50], {(0, 0): 'Item', (1, 0): 'Price', (2, 0): 'Sold', (0, 1): 'Mince pie', (1, 1): 'R 18.00', (2, 1): '24',
                                           (0, 2): 'Juice', (1, 2): 'R 12.00', (2, 2): '31', (0, 3): 'Lollipop', (1, 3): 'R 2.50', (2, 3): '58', (0, 4): 'Koeksister', (1, 4): 'R 6.00', (2, 4): '40'})
    s.add(f'<rect x="{300 + 26}" y="{36 + 22}" width="216" height="22" fill="{YELLOW}" opacity=".35"/>')
    s.text(20, 196, 'Cut-off names, plain numbers, no money sign.', 12, INK, weight=600)
    s.text(300, 196, 'Bold headings, rands with 2 decimals, room.', 12, INK, weight=600)
    s.save('format')


def chart_kinds():
    s = Svg(560, 200, 'Three kinds of chart: a column chart compares, a line chart shows change over time, a pie chart shows parts of a whole')
    for i, (title, kind) in enumerate((('Column: compare', 'col'), ('Line: over time', 'line'), ('Pie: parts of a whole', 'pie'))):
        x = 16 + i * 182
        s.add(f'<rect x="{x}" y="14" width="168" height="172" rx="8" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
        s.text(x + 84, 38, title, 13, INK, 'middle')
        if kind == 'col':
            for j, (h, f) in enumerate(((70, SKY), (100, YELLOW), (46, RED), (84, LIME))):
                s.add(f'<rect x="{x + 22 + j * 34}" y="{166 - h}" width="24" height="{h}" fill="{f}" stroke="{INK}" stroke-width="2"/>')
            s.add(f'<line x1="{x + 14}" y1="166" x2="{x + 156}" y2="166" stroke="{INK}" stroke-width="2"/>')
        elif kind == 'line':
            pts = [(x + 22 + j * 26, 160 - v) for j, v in enumerate((20, 34, 30, 60, 74, 96))]
            s.add(f'<polyline points="{" ".join(f"{a},{b}" for a, b in pts)}" fill="none" stroke="{VIOLET}" stroke-width="3.5" stroke-linejoin="round"/>')
            for a, b in pts:
                s.add(f'<circle cx="{a}" cy="{b}" r="4" fill="{WHITE}" stroke="{VIOLET}" stroke-width="2.5"/>')
            s.add(f'<line x1="{x + 14}" y1="166" x2="{x + 156}" y2="166" stroke="{INK}" stroke-width="2"/>')
        else:
            cx, cy, r = x + 84, 108, 56
            start = -90
            for part, f in ((0.4, YELLOW), (0.25, SKY), (0.2, RED), (0.15, LIME)):
                end = start + part * 360
                a0, a1 = math.radians(start), math.radians(end)
                big = 1 if part > 0.5 else 0
                s.add(f'<path d="M{cx} {cy} L{cx + r * math.cos(a0):.1f} {cy + r * math.sin(a0):.1f} A{r} {r} 0 {big} 1 {cx + r * math.cos(a1):.1f} {cy + r * math.sin(a1):.1f} Z" fill="{f}" stroke="{INK}" stroke-width="2"/>')
                start = end
    s.save('chart-kinds')


def chart(name, label, good):
    """A column chart of a week's takings - the good one has a title, axis titles and labels; the bad one has none, and a cut axis."""
    s = Svg(400, 250, label, WHITE)
    s.add(f'<rect x="1" y="1" width="398" height="248" rx="10" fill="none" stroke="{INK}" stroke-width="2"/>')
    days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri']
    vals = [640, 585, 712, 498, 903]
    x0, y0, w, h = 72, 200, 300, 140
    lo = 0 if good else 450
    top = 1000
    if good:
        s.text(200, 30, 'Takings this week', 16, INK, 'middle')
        for v in (0, 250, 500, 750, 1000):
            y = y0 - (v - lo) / (top - lo) * h
            s.add(f'<line x1="{x0}" y1="{y:.1f}" x2="{x0 + w}" y2="{y:.1f}" stroke="#d6dcd4" stroke-width="1"/>')
            s.text(x0 - 6, y + 4, f'R{v}', 10, '#444', 'end', 400, GRIDFONT)
        s.add(f'<text x="18" y="{y0 - h / 2}" font-family="{FONT}" font-size="12" font-weight="600" fill="{INK}" text-anchor="middle" transform="rotate(-90 18 {y0 - h / 2})">Takings (rands)</text>')
        s.text(x0 + w / 2, 240, 'Day of the week', 12, INK, 'middle', 600)
    else:
        for v in (500, 750, 1000):
            y = y0 - (v - lo) / (top - lo) * h
            s.text(x0 - 6, y + 4, str(v), 10, '#444', 'end', 400, GRIDFONT)
    for i, (d, v) in enumerate(zip(days, vals)):
        bh = (v - lo) / (top - lo) * h
        bx = x0 + 14 + i * 58
        s.add(f'<rect x="{bx}" y="{y0 - bh:.1f}" width="36" height="{bh:.1f}" fill="{SKY if good else YELLOW}" stroke="{INK}" stroke-width="1.8"/>')
        if good:
            s.text(bx + 18, y0 + 16, d, 11, '#222', 'middle', 400, GRIDFONT)
    s.add(f'<line x1="{x0}" y1="{y0}" x2="{x0 + w}" y2="{y0}" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<line x1="{x0}" y1="{y0}" x2="{x0}" y2="{y0 - h - 6}" stroke="{INK}" stroke-width="2"/>')
    s.save(name)


def line_chart():
    s = Svg(420, 240, 'A line chart of the takings for weeks 1 to 8, going up', WHITE)
    s.add(f'<rect x="1" y="1" width="418" height="238" rx="10" fill="none" stroke="{INK}" stroke-width="2"/>')
    s.text(210, 28, 'Takings, week by week', 15, INK, 'middle')
    vals = [2400, 2650, 2550, 2900, 3100, 3050, 3400, 3700]
    x0, y0, w, h, lo, hi = 70, 196, 320, 140, 2000, 4000
    for v in (2000, 2500, 3000, 3500, 4000):
        y = y0 - (v - lo) / (hi - lo) * h
        s.add(f'<line x1="{x0}" y1="{y:.1f}" x2="{x0 + w}" y2="{y:.1f}" stroke="#d6dcd4" stroke-width="1"/>')
        s.text(x0 - 6, y + 4, f'R{v}', 10, '#444', 'end', 400, GRIDFONT)
    pts = [(x0 + 18 + i * 41, y0 - (v - lo) / (hi - lo) * h) for i, v in enumerate(vals)]
    s.add(f'<polyline points="{" ".join(f"{a:.1f},{b:.1f}" for a, b in pts)}" fill="none" stroke="{VIOLET}" stroke-width="3.5" stroke-linejoin="round"/>')
    for i, (a, b) in enumerate(pts):
        s.add(f'<circle cx="{a:.1f}" cy="{b:.1f}" r="4" fill="{WHITE}" stroke="{VIOLET}" stroke-width="2.5"/>')
        s.text(a, y0 + 16, f'W{i + 1}', 10, '#222', 'middle', 400, GRIDFONT)
    s.add(f'<line x1="{x0}" y1="{y0}" x2="{x0 + w}" y2="{y0}" stroke="{INK}" stroke-width="2"/>')
    s.text(x0 + w / 2, 230, 'Week', 12, INK, 'middle', 600)
    s.save('chart-line')


def money():
    s = Svg(300, 170, 'Play money and dice: R50 and R20 notes, and two dice')
    note(s, 20, 30, 'R50', LIME, -8)
    note(s, 40, 74, 'R20', YELLOW, 6)
    note(s, 150, 40, 'R10', SKY, -3)
    die(s, 170, 104, 5, WHITE, INK, 12)
    die(s, 224, 100, 3, RED, WHITE, -14)
    s.save('money')


def brackets():
    s = Svg(320, 180, 'Brackets first: =(B2-B3)/2 takes away first, then halves')
    s.text(160, 40, '=(B2-B3)/2', 26, INK, 'middle')
    s.add(f'<path d="M100 50 q48 34 96 0" stroke="{RED}" stroke-width="3" fill="none"/>')
    s.text(148, 96, '1. first', 14, RED, 'middle')
    s.add(f'<path d="M202 50 q18 30 36 0" stroke="#1f8a5b" stroke-width="3" fill="none"/>')
    s.text(232, 96, '2. then', 14, '#1f8a5b', 'middle')
    s.text(160, 140, 'Brackets first, then * and /, then + and -', 13, INK, 'middle', 600)
    s.save('brackets')


def float_coins():
    s = Svg(320, 180, 'Counting the till: coins and notes, each value times how many')
    for i, (label, fill, r) in enumerate((('R5', '#d9b44a', 26), ('R2', '#cfcfcf', 23), ('R1', '#cfcfcf', 21), ('50c', '#c98a3a', 18))):
        x = 40 + i * 68
        s.add(f'<circle cx="{x}" cy="62" r="{r}" fill="{fill}" stroke="{INK}" stroke-width="2.5"/>')
        s.add(f'<circle cx="{x}" cy="62" r="{r - 6}" fill="none" stroke="{INK}" stroke-width="1" opacity=".5"/>')
        s.text(x, 67, label, 13, INK, 'middle')
    note(s, 24, 108, 'R20', YELLOW, -4)
    note(s, 130, 112, 'R50', LIME, 3)
    s.text(232, 132, 'value', 13, INK)
    s.text(232, 150, 'x how many', 13, INK)
    s.save('float')


def fundraiser():
    s = Svg(340, 200, 'The Grade 7 farewell fund: a jar filling up with money towards the target')
    s.add(f'<path d="M70 40 h80 v12 q20 10 20 40 v80 q0 14 -14 14 h-92 q-14 0 -14 -14 v-80 q0 -30 20 -40 z" fill="#eaf6ff" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<path d="M52 120 h116 v46 q0 14 -14 14 h-88 q-14 0 -14 -14 z" fill="{LIME}" stroke="{INK}" stroke-width="2"/>')
    for x, y in ((80, 140), (110, 150), (140, 136), (96, 162), (128, 166)):
        s.add(f'<circle cx="{x}" cy="{y}" r="9" fill="#d9b44a" stroke="{INK}" stroke-width="1.8"/>')
    s.add(f'<line x1="44" y1="84" x2="176" y2="84" stroke="{RED}" stroke-width="2.5" stroke-dasharray="6 4"/>')
    s.text(184, 88, 'target R4 000', 14, RED)
    s.text(184, 128, 'raised so far', 13, '#1f8a5b')
    s.text(110, 30, 'FAREWELL', 14, INK, 'middle')
    till(s, 270, 172, 0.36, 'happy', '')
    s.save('fundraiser')


def main():
    for n in range(1, 9):
        board(n)
    pair(); calc_wrong(); kaching(); address(); fill_handle(); sum_column(); profit(); podium()
    hashes(); format_before_after(); chart_kinds()
    chart('chart-good', 'A column chart of the takings for Monday to Friday, with a title, axis titles and day labels', True)
    chart('chart-bad', 'A column chart with no title, no axis titles, no day labels, and a value axis that starts at 450', False)
    line_chart(); money(); brackets(); float_coins(); fundraiser()


if __name__ == '__main__':
    main()
