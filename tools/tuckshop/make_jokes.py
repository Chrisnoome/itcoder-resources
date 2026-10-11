"""The Tuck-shop tycoon course's joke drawings (brand/tuckshop-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle: a small
board-game cartoon of the joke, with the joke itself as the caption. Uses the
pieces in make_art.py. Writes AIPascalCourse/public/assets/doodles/
tuckshop-joke-<lesson>.svg.

  python -X utf8 tools/tuckshop/make_jokes.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, till, calc, note, eyes, mouth, bubble, INK, WHITE, YELLOW, SKY, RED, LIME, VIOLET, TILL_GOLD, CREAM, PEACH


W, H = 300, 190
LINE = f'stroke="{INK}" stroke-width="2.5" stroke-linejoin="round" stroke-linecap="round"'


def face(svg, cx, cy, s, mood):
    eyes(svg, cx, cy, s, mood)
    mouth(svg, cx, cy + 16 * s, s, mood)


def average():
    s = Svg(W, H, 'A pupil with both hands in a hot oven and both feet in a bucket of ice, next to a thermometer that says the average is just right')
    # the oven, hot
    s.add(f'<rect x="14" y="66" width="86" height="96" rx="6" fill="{RED}" {LINE}/>')
    s.add(f'<rect x="24" y="90" width="66" height="44" rx="4" fill="{YELLOW}" {LINE}/>')
    for x in (34, 54, 74):
        s.add(f'<circle cx="{x}" cy="78" r="4" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>')
    for x in (30, 56, 82):
        s.add(f'<path d="M{x} 58 q-6 -10 0 -18 q6 -8 0 -16" fill="none" stroke="{RED}" stroke-width="3" stroke-linecap="round"/>')
    # the pupil
    s.add(f'<path d="M150 74 V122 M150 84 L92 104 M150 90 L92 118 M150 122 L138 156 M150 122 L162 156" fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<circle cx="150" cy="52" r="22" fill="{PEACH}" {LINE}/>')
    face(s, 150, 46, 0.7, 'oh')
    # the bucket of ice
    for x, y, r in ((128, 146, -12), (152, 142, 8), (170, 148, -4)):
        s.add(f'<rect x="{x}" y="{y}" width="16" height="16" rx="3" fill="{WHITE}" stroke="{INK}" stroke-width="2" transform="rotate({r} {x + 8} {y + 8})"/>')
    s.add(f'<path d="M118 154 H182 L176 184 H124 Z" fill="{SKY}" {LINE}/>')
    s.text(150, 177, 'ICE', 13, INK, 'middle')
    # the thermometer: on average, just right
    s.add(f'<rect x="210" y="34" width="18" height="104" rx="9" fill="{WHITE}" {LINE}/>')
    s.add(f'<rect x="215" y="84" width="8" height="58" fill="{LIME}"/>')
    s.add(f'<circle cx="219" cy="150" r="15" fill="{LIME}" {LINE}/>')
    s.add(f'<path d="M228 84 h8" stroke="{INK}" stroke-width="2.5"/>')
    s.text(240, 80, 'JUST', 13, INK)
    s.text(240, 97, 'RIGHT?', 13, INK)
    s.text(232, 24, 'AVERAGE', 12, INK, 'middle')
    s.save('joke-bestsellers-average')


def popcorn():
    s = Svg(W, H, 'A box of popcorn singing into a microphone, at number 1 on the music charts')
    # the chart: number 1
    s.add(f'<rect x="196" y="22" width="88" height="104" rx="6" fill="{WHITE}" {LINE}/>')
    s.text(240, 42, 'TOP HITS', 12, INK, 'middle')
    for i, (lab, fill) in enumerate((('1', YELLOW), ('2', SKY), ('3', LIME))):
        y = 50 + i * 24
        s.add(f'<rect x="204" y="{y}" width="72" height="18" rx="3" fill="{fill}" stroke="{INK}" stroke-width="1.8"/>')
        s.text(213, y + 14, lab, 12, INK, 'middle')
    s.text(244, 64, 'Pop-corn', 11, INK, 'middle')
    s.text(244, 88, 'Juice', 11, INK, 'middle')
    s.text(244, 112, 'Muffin', 11, INK, 'middle')
    # the popcorn, on top of the box
    for x, y in ((62, 52), (80, 44), (98, 48), (116, 54), (70, 64), (90, 60), (108, 64)):
        s.add(f'<circle cx="{x}" cy="{y}" r="11" fill="#fff8dc" stroke="{INK}" stroke-width="2"/>')
    # the box, red and white stripes
    s.add(f'<path d="M52 66 H128 L118 176 H62 Z" fill="{WHITE}" {LINE}/>')
    s.add(f'<path d="M60 66 H72 L74 176 H64 Z M84 66 H96 L95 176 H85 Z M108 66 H120 L116 176 H106 Z" fill="{RED}"/>')
    s.add(f'<path d="M52 66 H128 L118 176 H62 Z" fill="none" {LINE}/>')
    s.add(f'<rect x="66" y="96" width="48" height="40" rx="10" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>')
    face(s, 90, 108, 0.75, 'oh')
    # the microphone
    s.add(f'<path d="M114 128 L150 112" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<path d="M140 120 L160 106" stroke="{INK}" stroke-width="7" stroke-linecap="round"/>')
    s.add(f'<circle cx="164" cy="102" r="9" fill="#9aa5ad" {LINE}/>')
    # music notes
    for x, y in ((160, 70), (182, 150)):
        s.add(f'<path d="M{x} {y} v-22 l12 -4 v22" fill="none" stroke="{VIOLET}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>')
        s.add(f'<ellipse cx="{x - 4}" cy="{y}" rx="5" ry="4" fill="{VIOLET}"/><ellipse cx="{x + 8}" cy="{y - 4}" rx="5" ry="4" fill="{VIOLET}"/>')
    s.save('joke-bestsellers')


def counsellor():
    s = Svg(W, H, 'A zig-zag line chart lying on a counsellor\'s couch, while Till listens and takes notes')
    # the couch
    s.add(f'<path d="M14 120 q0 -18 18 -18 h10 v26 h120 v-10 q0 -12 12 -12 h6 v42 H14 Z" fill="{SKY}" {LINE}/>')
    s.add(f'<path d="M22 148 v14 M172 148 v14" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    # the line chart, up and down, lying down
    pts = [(56, 112), (72, 70), (88, 104), (104, 58), (120, 100), (136, 66), (154, 108)]
    s.add('<polyline points="' + ' '.join(f'{a},{b}' for a, b in pts) + f'" fill="none" stroke="{VIOLET}" stroke-width="4.5" stroke-linejoin="round" stroke-linecap="round"/>')
    for a, b in pts:
        s.add(f'<circle cx="{a}" cy="{b}" r="4" fill="{WHITE}" stroke="{VIOLET}" stroke-width="2.5"/>')
    s.add(f'<path d="M44 102 L56 112" stroke="{VIOLET}" stroke-width="4.5" stroke-linecap="round"/>')
    s.add(f'<circle cx="34" cy="88" r="17" fill="{WHITE}" {LINE}/>')
    eyes(s, 34, 85, 0.55, 'shut')
    mouth(s, 34, 99, 0.6, 'cross')
    # Till, the counsellor, with a notepad
    till(s, 240, 124, 0.62, 'side', 'Hmm')
    s.add(f'<rect x="196" y="140" width="26" height="34" rx="2" fill="{WHITE}" stroke="{INK}" stroke-width="2" transform="rotate(-10 209 157)"/>')
    for k in range(3):
        s.add(f'<path d="M{201 + k * 0.6} {150 + k * 7} h14" stroke="#9aa5ad" stroke-width="1.8" transform="rotate(-10 209 157)"/>')
    s.save('joke-charts')


def koeksister():
    s = Svg(W, H, 'A golden twisted koeksister on the winner\'s podium, wearing a first-prize rosette')
    # the podium
    s.add(f'<rect x="90" y="132" width="120" height="48" fill="{YELLOW}" {LINE}/>')
    s.add(f'<rect x="20" y="152" width="70" height="28" fill="{SKY}" {LINE}/>')
    s.add(f'<rect x="210" y="160" width="70" height="20" fill="{RED}" {LINE}/>')
    s.text(150, 166, '1', 24, INK, 'middle')
    s.text(55, 172, '2', 16, INK, 'middle')
    s.text(245, 176, '3', 14, INK, 'middle')
    # the koeksister: two strands plaited, glazed with syrup
    for k in range(6):
        y = 36 + k * 15
        for dx, rot in ((-8, 35), (8, -35)):
            s.add(f'<rect x="{150 + dx - 15}" y="{y + (8 if dx > 0 else 0) - 7}" width="30" height="16" rx="8" fill="#c9782f" {LINE} transform="rotate({rot} {150 + dx} {y + (8 if dx > 0 else 0) + 1})"/>')
            s.add(f'<path d="M{150 + dx - 7} {y + (8 if dx > 0 else 0) - 2} h10" stroke="#f3c26b" stroke-width="2.5" stroke-linecap="round" transform="rotate({rot} {150 + dx} {y + (8 if dx > 0 else 0) + 1})"/>')
    face(s, 150, 78, 0.6, 'grin')
    # the rosette
    s.add(f'<path d="M206 58 l-8 34 l10 -6 l6 10 l4 -34 Z M222 58 l8 34 l-10 -6 l-6 10 l-4 -34 Z" fill="{RED}" {LINE}/>')
    s.add(f'<circle cx="214" cy="52" r="18" fill="{YELLOW}" {LINE}/>')
    s.add(f'<circle cx="214" cy="52" r="11" fill="none" stroke="{INK}" stroke-width="1.5" stroke-dasharray="3 2"/>')
    s.text(214, 57, '1st', 12, INK, 'middle')
    # sparkle
    for x, y in ((82, 48), (60, 96), (240, 112)):
        s.add(f'<path d="M{x} {y - 9} v18 M{x - 9} {y} h18" stroke="{TILL_GOLD}" stroke-width="3" stroke-linecap="round"/>')
    s.save('joke-fundraiser')


def gym():
    s = Svg(W, H, 'A thin spreadsheet column full of ##### lifting a dumbbell at the gym, trying to get wider')
    # the column: header B, cells showing #####
    x, y, w = 128, 34, 44
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="22" fill="#eef0ec" {LINE}/>')
    s.text(x + w / 2, y + 16, 'B', 13, INK, 'middle')
    for r in range(5):
        s.add(f'<rect x="{x}" y="{y + 22 + r * 22}" width="{w}" height="22" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
        if r != 1:
            s.text(x + w / 2, y + 22 + r * 22 + 15, '####', 11, '#222', 'middle', 600)
    s.add(f'<rect x="{x + 3}" y="{y + 25}" width="{w - 6}" height="36" fill="{WHITE}"/>')
    eyes(s, x + w / 2, y + 36, 0.55, 'cross')
    mouth(s, x + w / 2, y + 50, 0.5, 'oh')
    # the arms and the barbell above its head
    s.add(f'<path d="M{x} {y + 58} L{x - 22} {y + 30} L{x - 24} {y + 2} M{x + w} {y + 58} L{x + w + 22} {y + 30} L{x + w + 24} {y + 2}" fill="none" stroke="{INK}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>')
    s.add(f'<path d="M60 {y} H240" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>')
    for bx in (62, 222):
        s.add(f'<rect x="{bx}" y="{y - 20}" width="16" height="40" rx="3" fill="{RED}" {LINE}/>')
    # legs and sweat
    s.add(f'<path d="M{x + 12} {y + 132} v18 M{x + w - 12} {y + 132} v18" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<path d="M{x + w + 12} {y + 70} q4 7 0 11 q-4 -4 0 -11 Z M{x - 14} {y + 80} q4 7 0 11 q-4 -4 0 -11 Z" fill="{SKY}" stroke="{INK}" stroke-width="1.5"/>')
    # the arrows: wider!
    s.add(f'<path d="M{x - 18} 128 h-38 m8 -8 l-8 8 l8 8 M{x + w + 18} 128 h38 m-8 -8 l8 8 l-8 8" fill="none" stroke="{RED}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>')
    s.text(52, 156, 'WIDER!', 15, RED, 'middle')
    s.text(248, 156, 'WIDER!', 15, RED, 'middle')
    s.save('joke-looks')


def doctor():
    s = Svg(W, H, 'A sick spreadsheet with a thermometer in its mouth, covered in far too many cells, while Till the doctor listens with a stethoscope')
    # the poorly spreadsheet: lots and lots of cells
    x, y, cols, rows, cw, rh = 22, 30, 8, 8, 17, 16
    s.add(f'<rect x="{x}" y="{y}" width="{cols * cw}" height="{rows * rh}" rx="4" fill="{WHITE}" {LINE}/>')
    for c in range(1, cols):
        s.add(f'<line x1="{x + c * cw}" y1="{y}" x2="{x + c * cw}" y2="{y + rows * rh}" stroke="#9aa5ad" stroke-width="1"/>')
    for r in range(1, rows):
        s.add(f'<line x1="{x}" y1="{y + r * rh}" x2="{x + cols * cw}" y2="{y + r * rh}" stroke="#9aa5ad" stroke-width="1"/>')
    for c, r in ((1, 6), (6, 1), (7, 6), (0, 3), (2, 0)):
        s.add(f'<rect x="{x + c * cw + 3}" y="{y + r * rh + 3}" width="{cw - 6}" height="{rh - 6}" rx="3" fill="{RED}" opacity=".7"/>')
    s.add(f'<rect x="{x + 2 * cw}" y="{y + 2 * rh}" width="{4 * cw}" height="{4 * rh}" rx="6" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>')
    cx = x + 4 * cw
    eyes(s, cx, y + 3 * rh + 2, 0.6, 'shut')
    mouth(s, cx, y + 5 * rh, 0.6, 'cross')
    s.add(f'<path d="M{cx + 4} {y + 5 * rh + 2} L{cx + 40} {y + 5 * rh - 12}" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<circle cx="{cx + 40}" cy="{y + 5 * rh - 12}" r="3.5" fill="{RED}"/>')
    s.add(f'<path d="M{x + 30} {y + rows * rh} v18 M{x + cols * cw - 30} {y + rows * rh} v18" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    # the doctor's cross
    s.add(f'<path d="M180 20 h12 v12 h12 v12 h-12 v12 h-12 v-12 h-12 v-12 h12 Z" fill="{RED}" {LINE}/>')
    # Till, the doctor, with a stethoscope
    till(s, 236, 132, 0.6, 'happy', 'Ahh')
    s.add(f'<path d="M220 134 q-20 30 -42 2 q-10 -14 -22 -20" fill="none" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    s.add(f'<circle cx="156" cy="114" r="7" fill="#9aa5ad" {LINE}/>')
    s.save('joke-prices')


def freezer():
    s = Svg(W, H, 'A freezer with its door open, full of rand notes and coins frozen stiff, with icicles hanging down: cold, hard cash')
    # the freezer, door open
    s.add(f'<rect x="40" y="18" width="130" height="164" rx="8" fill="{WHITE}" {LINE}/>')
    s.add(f'<rect x="50" y="28" width="110" height="144" rx="4" fill="#e6f6ff" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<path d="M50 100 H160" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<path d="M170 22 L232 12 V188 L170 178 Z" fill="{SKY}" {LINE}/>')
    s.add(f'<path d="M184 90 v26" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    # icicles hanging from the top shelf and the freezer roof
    for k in range(6):
        ix = 58 + k * 18
        s.add(f'<path d="M{ix} 28 l5 {14 + (k % 3) * 5} l5 {-14 - (k % 3) * 5} Z" fill="{WHITE}" stroke="{INK}" stroke-width="1.5" stroke-linejoin="round"/>')
    # the money, stiff with frost
    s.add(f'<g transform="translate(58 52) scale(.62)">')
    note(s, 0, 0, 'R50', LIME, -4)
    s.add('</g>')
    s.add(f'<g transform="translate(104 64) scale(.62)">')
    note(s, 0, 0, 'R20', YELLOW, 6)
    s.add('</g>')
    for cx, cy in ((72, 150), (96, 156), (122, 148), (146, 156)):
        s.add(f'<circle cx="{cx}" cy="{cy}" r="11" fill="#d9b44a" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<rect x="58" y="110" width="94" height="58" rx="6" fill="{WHITE}" opacity=".35" stroke="{SKY}" stroke-width="2"/>')
    # snowflakes, and the cold
    for x, y in ((258, 40), (272, 96), (254, 150)):
        s.add(f'<path d="M{x} {y - 10} v20 M{x - 9} {y - 5} l18 10 M{x - 9} {y + 5} l18 -10" stroke="{SKY}" stroke-width="3" stroke-linecap="round"/>')
    s.text(20, 104, 'BRRR', 13, INK, 'middle')
    s.save('joke-profit')


def belt():
    s = Svg(W, H, 'A round 0 admiring an 8, which wears a belt with a gold buckle round its middle')
    # the 0
    s.add(f'<ellipse cx="72" cy="104" rx="42" ry="58" fill="{SKY}" {LINE}/>')
    s.add(f'<ellipse cx="72" cy="104" rx="20" ry="34" fill="#dff0e2" {LINE}/>')
    face(s, 72, 96, 0.55, 'happy')
    # the 8, wearing a belt
    s.add(f'<circle cx="216" cy="62" r="34" fill="{YELLOW}" {LINE}/>')
    s.add(f'<circle cx="216" cy="138" r="42" fill="{YELLOW}" {LINE}/>')
    s.add(f'<circle cx="216" cy="62" r="13" fill="#dff0e2" {LINE}/>')
    s.add(f'<circle cx="216" cy="138" r="18" fill="#dff0e2" {LINE}/>')
    s.add(f'<rect x="180" y="90" width="72" height="16" rx="3" fill="#8a5a32" {LINE}/>')
    s.add(f'<rect x="206" y="86" width="20" height="24" rx="3" fill="{TILL_GOLD}" {LINE}/>')
    s.add(f'<rect x="212" y="92" width="8" height="12" rx="1" fill="#8a5a32"/>')
    eyes(s, 216, 50, 0.45, 'happy')
    mouth(s, 216, 62, 0.45, 'happy')
    # the 0's compliment
    bubble(s, 104, 14, 72, ['Nice', 'belt!'], 96, 58, 13)
    s.save('joke-takings')


def problems():
    s = Svg(W, H, 'A sad maths book crying, its open pages full of sums and question marks')
    # the open book
    s.add(f'<path d="M150 50 Q110 34 40 40 V160 Q110 154 150 170 Z" fill="{WHITE}" {LINE}/>')
    s.add(f'<path d="M150 50 Q190 34 260 40 V160 Q190 154 150 170 Z" fill="{WHITE}" {LINE}/>')
    s.add(f'<path d="M36 44 V166 Q110 158 150 176 Q190 158 264 166 V44" fill="none" stroke="{RED}" stroke-width="4" stroke-linejoin="round"/>')
    # the sad face on the left page
    eyes(s, 96, 92, 0.9, 'happy')
    s.add(f'<path d="M82 128 q14 -12 28 0" stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round"/>')
    for tx in (85, 107):
        s.add(f'<path d="M{tx} 102 q-6 12 0 17 q6 -5 0 -17 Z" fill="{SKY}" stroke="{INK}" stroke-width="1.5"/>')
    # the problems on the right page
    for i, words in enumerate(('7x = ?', '12 ÷ 0 = ?', '3 + ? = 9')):
        s.text(206, 72 + i * 22, words, 13, INK, 'middle')
    s.text(206, 146, '???', 20, RED, 'middle')
    s.text(150, 28, 'MATHS', 16, RED, 'middle')
    s.save('joke-totals')


def main():
    average(); popcorn(); counsellor(); koeksister(); gym(); doctor(); freezer(); belt(); problems()


if __name__ == '__main__':
    main()
