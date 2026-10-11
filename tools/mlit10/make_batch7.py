"""Batch 7 (Matchday) art for the Grade 10 Maths Literacy course.

Theme A: stadium wayfinding - navy, colour-coded zones, bold pictograms, big
arrows. The MAP and the SEATING PLAN are documents, drawn exactly: the
precinct map is on a faint grid of 1 cm squares (pupils count squares,
because there is no on-screen ruler yet) at a scale of 1 : 5 000, so 1 cm =
50 m. Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch7.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, bubble, SIGN, INK, RED, BLUE, WHITE, NUM, HAND, MARKER
from make_jokes import jcard, face, person

NAVY, ZONE_Y, ZONE_R, ZONE_T, ZONE_B, GRASS, WALK = '#14213d', '#ffd60a', '#e63946', '#2a9d8f', '#4895ef', '#7bc96f', '#e9dcc3'
SQ = 30          # one map square = 1 cm on the map, drawn 30 units wide


def precinct_map():
    w, h = 18 * SQ + 60, 12 * SQ + 110
    svg = Svg('precinctmap', w, h, 'Layout map of the stadium precinct on 1 cm squares at a scale of 1 to 5 000: the station bottom left, a walkway east then north to Gate C, the stadium with Gates A to D, the fan park, food stalls and parking', bg=WHITE, rx=6)
    ox, oy = 30, 50
    X = lambda c: ox + c * SQ
    Y = lambda r: oy + r * SQ
    svg.text(w / 2, 32, 'MZANSI STADIUM PRECINCT - LAYOUT MAP', 15, NAVY, 'middle', 800, NUM)
    svg.add(f'<rect x="{X(0)}" y="{Y(0)}" width="{18 * SQ}" height="{12 * SQ}" fill="#f7faf7" stroke="{INK}" stroke-width="2"/>')
    for c in range(1, 18):
        svg.add(f'<path d="M{X(c)} {Y(0)} V{Y(12)}" stroke="#dfe7ec" stroke-width="1"/>')
    for r in range(1, 12):
        svg.add(f'<path d="M{X(0)} {Y(r)} H{X(18)}" stroke="#dfe7ec" stroke-width="1"/>')
    # walkways (drawn under everything)
    for (c1, r1, c2, r2) in [(4, 10, 12, 10), (12, 10, 12, 8), (8, 10, 8, 5), (5, 2, 12, 2), (12, 10, 14, 10)]:
        svg.add(f'<path d="M{X(c1)} {Y(r1)} L{X(c2)} {Y(r2)}" stroke="{WALK}" stroke-width="14" stroke-linecap="round"/>')
    # stadium
    svg.add(f'<ellipse cx="{X(12)}" cy="{Y(5)}" rx="{4 * SQ}" ry="{3 * SQ}" fill="#cfd8e3" stroke="{NAVY}" stroke-width="3"/>'
            f'<ellipse cx="{X(12)}" cy="{Y(5)}" rx="{2.4 * SQ}" ry="{1.5 * SQ}" fill="{GRASS}" stroke="{WHITE}" stroke-width="2"/>')
    svg.text(X(12), Y(5) + 5, 'PITCH', 12, WHITE, 'middle', 800, NUM)
    for name, c, r, col in [('A', 12, 2, ZONE_Y), ('B', 16, 5, ZONE_R), ('C', 12, 8, ZONE_T), ('D', 8, 5, ZONE_B)]:
        svg.add(f'<rect x="{X(c) - 13}" y="{Y(r) - 13}" width="26" height="26" rx="4" fill="{col}" stroke="{INK}" stroke-width="2"/>')
        svg.text(X(c), Y(r) + 6, name, 15, INK, 'middle', 800, NUM)
    # places
    places = [('MZANSI STATION', 1, 9, 3, 2, '#e8e0ff'), ('FAN PARK', 1, 1, 4, 3, '#e6f6e6'), ('PARKING', 14, 9, 3, 2, '#eeeeee')]
    for t, c, r, cw, rh, col in places:
        svg.add(f'<rect x="{X(c)}" y="{Y(r)}" width="{cw * SQ}" height="{rh * SQ}" fill="{col}" stroke="{INK}" stroke-width="2"/>')
        svg.text(X(c) + cw * SQ / 2, Y(r) + rh * SQ / 2 + 4, t, 10, INK, 'middle', 800, NUM)
    for k in range(3):
        svg.add(f'<rect x="{X(6) + 2}" y="{Y(6) + k * 22}" width="{SQ - 4}" height="16" fill="#ffd0b0" stroke="{INK}" stroke-width="1.5"/>')
    svg.text(X(6) + SQ / 2, Y(9) + 6, 'FOOD', 9, INK, 'middle', 800, NUM)
    # key: scale
    by = Y(12) + 34
    svg.text(X(0), by - 12, 'Scale 1 : 5 000   (one grid square is 1 cm on the map)', 12, INK, 'start', 700, NUM)
    for k in range(4):
        svg.add(f'<rect x="{X(0) + k * 2 * SQ}" y="{by}" width="{2 * SQ}" height="8" fill="{INK if k % 2 == 0 else WHITE}" stroke="{INK}"/>')
        svg.text(X(0) + k * 2 * SQ, by + 24, f'{k * 100} m', 10, INK, 'middle', 600, NUM)
    svg.text(X(0) + 8 * SQ, by + 24, '400 m', 10, INK, 'middle', 600, NUM)
    svg.text(X(18), by + 10, '▲ N', 14, INK, 'end', 800, NUM)
    svg.save()


def bar_scale():
    svg = Svg('barscale', 520, 150, 'A bar scale: every 2 cm on the map stands for 100 m on the ground, so 1 cm is 50 m', bg=WHITE, rx=6)
    x0, unit = 40, 44            # 1 cm drawn 44 units
    svg.text(260, 30, 'Bar scale', 14, INK, 'middle', 800, NUM)
    for k in range(5):
        svg.add(f'<rect x="{x0 + k * 2 * unit}" y="60" width="{2 * unit}" height="12" fill="{INK if k % 2 == 0 else WHITE}" stroke="{INK}"/>')
        svg.text(x0 + k * 2 * unit, 92, f'{k * 100} m', 12, INK, 'middle', 600, NUM)
    svg.text(x0 + 10 * unit, 92, '500 m', 12, INK, 'middle', 600, NUM)
    for cm in range(11):
        svg.add(f'<path d="M{x0 + cm * unit} 112 v10" stroke="{BLUE}" stroke-width="1.5"/>')
        svg.text(x0 + cm * unit, 138, str(cm), 11, BLUE, 'middle', 600, NUM)
    svg.text(x0 + 10 * unit + 26, 138, 'cm', 11, BLUE, 'start', 600, NUM)
    svg.save()


def seat_plan():
    rows, seats = 20, 24
    w, h = seats * 22 + 120, rows * 18 + 120
    svg = Svg('seatplan', w, h, 'Seating plan of Block K: rows 1 to 20, row 1 nearest the pitch at the bottom, seats 1 to 24 numbered from left to right; Row 14 Seat 7 is marked', bg=WHITE, rx=6)
    ox, oy = 70, 40
    svg.text(w / 2, 24, 'BLOCK K - SEATING PLAN', 15, NAVY, 'middle', 800, NUM)
    for r in range(1, rows + 1):
        y = oy + (rows - r) * 18
        svg.text(ox - 10, y + 12, f'Row {r}', 10, INK, 'end', 600, NUM)
        for s in range(1, seats + 1):
            x = ox + (s - 1) * 22
            mark = (r, s) == (14, 7)
            svg.add(f'<rect x="{x}" y="{y}" width="18" height="14" rx="3" fill="{ZONE_Y if mark else "#c9d6e3"}" stroke="{INK if mark else "#8aa"}" stroke-width="{2 if mark else 1}"/>')
    for s in (1, 6, 12, 18, 24):
        svg.text(ox + (s - 1) * 22 + 9, oy + rows * 18 + 14, str(s), 10, INK, 'middle', 600, NUM)
    svg.text(ox + seats * 11, oy + rows * 18 + 30, 'seat numbers', 10, INK, 'middle', 600, NUM)
    svg.add(f'<rect x="{ox}" y="{oy + rows * 18 + 40}" width="{seats * 22 - 4}" height="22" fill="{GRASS}"/>')
    svg.text(ox + seats * 11, oy + rows * 18 + 56, 'PITCH SIDE', 12, WHITE, 'middle', 800, NUM)
    svg.save()


def wayfinding(name, label):
    return Svg(name, 320, 200, label, bg=NAVY, rx=8)


def d_signs():
    svg = wayfinding('signs', 'Stadium signs: Block K this way, colour-coded gates')
    svg.add(f'<rect x="20" y="24" width="120" height="70" rx="6" fill="{ZONE_Y}"/>')
    svg.text(80, 76, 'K', 44, NAVY, 'middle', 800, NUM)
    svg.add(f'<path d="M156 58 h90" stroke="{WHITE}" stroke-width="8" stroke-linecap="round"/><path d="M226 38 l24 20 l-24 20" stroke="{WHITE}" stroke-width="8" fill="none" stroke-linecap="round" stroke-linejoin="round"/>')
    for i, (g, c) in enumerate([('A', ZONE_Y), ('B', ZONE_R), ('C', ZONE_T), ('D', ZONE_B)]):
        svg.add(f'<rect x="{20 + i * 74}" y="{120}" width="64" height="54" rx="4" fill="{c}"/>')
        svg.text(52 + i * 74, 156, 'GATE ' + g, 12, NAVY, 'middle', 800, NUM)
    svg.save()


def d_ticket():
    svg = wayfinding('ticket', 'A match ticket: Block K, Row 14, Seat 7, Gate C')
    svg.add(f'<rect x="30" y="40" width="260" height="120" rx="10" fill="{WHITE}"/><path d="M220 40 v120" stroke="{NAVY}" stroke-width="2" stroke-dasharray="5 4"/>')
    svg.text(50, 70, 'CUP FINAL', 16, NAVY, 'start', 800, NUM)
    for i, (a, b) in enumerate([('GATE', 'C'), ('BLOCK', 'K'), ('ROW', '14'), ('SEAT', '7')]):
        svg.text(50 + (i % 2) * 84, 100 + (i // 2) * 40, a, 10, '#555', 'start', 600, NUM)
        svg.text(50 + (i % 2) * 84, 120 + (i // 2) * 40, b, 18, NAVY, 'start', 800, NUM)
    svg.text(255, 106, 'ADMIT', 10, NAVY, 'middle', 800, NUM, extra='transform="rotate(-90 255 100)"')
    svg.save()


def d_houses():
    svg = Svg('houses', 330, 200, 'A street with odd house numbers on one side and even numbers on the other', bg='#cdeee0', rx=8)
    svg.add(f'<rect x="0" y="88" width="330" height="30" fill="#9aa5ad"/><path d="M0 103 H330" stroke="{WHITE}" stroke-width="2" stroke-dasharray="12 8"/>')
    for i, n in enumerate([1, 3, 5, 7]):
        x = 20 + i * 78
        svg.add(f'<path d="M{x} 80 v-40 l26 -22 l26 22 v40z" fill="{ZONE_Y}" stroke="{INK}" stroke-width="2"/>'); svg.text(x + 26, 70, str(n), 14, INK, 'middle', 800, NUM)
    for i, n in enumerate([2, 4, 6, 8]):
        x = 20 + i * 78
        svg.add(f'<path d="M{x} 126 v40 h52 v-40z" fill="{ZONE_B}" stroke="{INK}" stroke-width="2"/>'); svg.text(x + 26, 152, str(n), 14, WHITE, 'middle', 800, NUM)
    svg.save()


def d_jobdone7():
    svg = Svg('jobdone7', 320, 200, 'Hadi with a JOB DONE stamp after Matchday', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Games Night', 15, INK, 'middle', font=MARKER)
    svg.save()


def jokes7():
    j = jcard('matchscale', 'A tiny map holding up a huge stadium on its shoulders')
    j.add(f'<ellipse cx="150" cy="60" rx="90" ry="34" fill="#cfd8e3" stroke="{NAVY}" stroke-width="3"/><ellipse cx="150" cy="60" rx="50" ry="18" fill="{GRASS}"/>')
    j.add(f'<rect x="126" y="110" width="48" height="40" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/><path d="M126 110 L110 96 M174 110 L190 96" stroke="{INK}" stroke-width="3"/>')
    face(j, 150, 128, 12, 'flat'); j.text(150, 172, '1 : 5 000', 12, INK, 'middle'); j.save()

    j = jcard('matchmap', 'A map folded the wrong way, tangled around a confused fan')
    person(j, 150, 60)
    j.add(f'<path d="M100 90 l40 -16 l30 14 l40 -18 l-6 50 l-40 16 l-30 -14 l-40 18z" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    j.text(230, 50, '?!', 22, RED, 'middle'); j.save()

    j = jcard('matchseat', 'A stadium seat with a face, waiting patiently for its fan')
    j.add(f'<path d="M110 70 h80 v50 h-80z" fill="{ZONE_Y}" stroke="{INK}" stroke-width="3"/><path d="M100 120 h100 v18 h-100z M110 138 v30 M190 138 v30" fill="{ZONE_Y}" stroke="{INK}" stroke-width="3"/>')
    face(j, 150, 94, 16); j.text(150, 40, 'ROW 14, SEAT 7', 13, NAVY, 'middle'); j.save()

    j = jcard('matchroute', 'Hadi following arrows on the ground in a circle')
    j.add(f'<circle cx="150" cy="104" r="62" fill="none" stroke="{WHITE}" stroke-width="8" stroke-dasharray="20 14"/>')
    hadi(j, 104, 66, .9)
    j.text(150, 30, 'GATE C THIS WAY', 12, NAVY, 'middle'); j.save()


if __name__ == '__main__':
    for o in [(35, 7, 1, 4, 'What scale means', '1 cm on paper, 50 m on the ground.', ['1 : 5 000']),
              (36, 7, 2, 4, 'The precinct map', 'Where am I? Where is the gate?', ['GATE C,', 'NOT D!']),
              (37, 7, 3, 4, 'Find your seat', 'Block, row, seat - in that order.', ['ROW 14,', 'SEAT 7']),
              (38, 7, 4, 4, 'Giving directions', 'Left, right, along, opposite.', ['TURN LEFT', 'AT THE FOOD'])]:
        opener(*o)
    precinct_map(); bar_scale(); seat_plan()
    d_signs(); d_ticket(); d_houses(); d_jobdone7()
    jokes7()
