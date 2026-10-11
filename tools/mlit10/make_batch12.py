"""Batch 12 (The Road Trip) art for the Grade 10 Maths Literacy course.

Theme A: a scrapbook of postcards - taped postcards, each in an earlier
batch's theme. The hall plan for Paper 2 is exact (1 : 200, 40 units to the
cm, so planRuler data-cm="40" measures it). Writes
AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch12.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, SIGN, INK, RED, BLUE, WHITE, NUM, MARKER, MONO, BATCHES
from make_jokes import jcard, face
from make_batch10 import blueprint, BLUE_BG, PALE, CM

PAGE = '#e9e2d0'
STOPS = [('KOTA KITCHEN', '#26302b'), ('CAR WASH', '#7cc6fe'), ('RADIO 10', '#2b2d42'), ("GOGO'S SHOEBOX", '#c9a77c'),
         ('PLAN WARS', '#ff4f79'), ('BAKE-OFF', '#f7d1cd'), ('MATCHDAY', '#14213d'), ('GAMES NIGHT', '#2d6a63'),
         ('TRIP FUND', '#d1495b'), ('ROOM RESCUE', '#1f4e93'), ('WEATHER WATCH', '#e8f3f8')]


def postcard(svg, x, y, rot, title, colour, n):
    dark = colour not in ('#7cc6fe', '#f7d1cd', '#e8f3f8', '#c9a77c')
    svg.add(f'<g transform="rotate({rot} {x + 55} {y + 40})"><rect x="{x}" y="{y}" width="110" height="80" fill="{WHITE}" stroke="#cbbf9f"/>'
            f'<rect x="{x + 5}" y="{y + 5}" width="100" height="54" fill="{colour}"/>'
            f'<text x="{x + 55}" y="{y + 37}" font-family="{MONO}" font-size="20" font-weight="700" fill="{WHITE if dark else INK}" text-anchor="middle">{n}</text>'
            f'<text x="{x + 55}" y="{y + 73}" font-family="{NUM}" font-size="8.5" font-weight="700" fill="{INK}" text-anchor="middle">{title}</text>'
            f'<rect x="{x + 40}" y="{y - 6}" width="30" height="12" fill="#f3e9a5" opacity=".85"/></g>')


def scrapbook():
    w, h = 640, 260
    svg = Svg('scrapbook', w, h, 'A scrapbook page with eleven taped postcards, one for each stop of the year: Kota Kitchen, Car Wash, Radio 10, Gogo\'s Shoebox, Plan Wars, Bake-Off, Matchday, Games Night, Trip Fund, Room Rescue and Weather Watch', bg=PAGE, rx=8)
    svg.text(w / 2, 34, 'THE ROAD TRIP - EVERY STOP OF THE YEAR', 15, INK, 'middle', 700, MONO)
    for i, (t, c) in enumerate(STOPS):
        row, col = divmod(i, 6)
        x = 20 + col * 102 + (51 if row else 0)
        y = 60 + row * 128
        postcard(svg, x, y, [-6, 4, -3, 5, -5, 3][col] * (1 if row == 0 else -1), t, c, i + 1)
    svg.save()


def papers():
    w, h = 600, 300
    svg = Svg('papers', w, h, 'The two final exam papers side by side: Paper 1 on finance, data handling and probability; Paper 2 on maps and plans, measurement and probability; each 75 marks in 1 hour 30 minutes, with Question 1 short questions and Questions 4 and 5 integrated', bg=PAGE, rx=8)
    for k, (title, topics) in enumerate([('PAPER 1', ['Finance', 'Data handling', 'Probability']), ('PAPER 2', ['Maps and plans', 'Measurement', 'Probability'])]):
        x = 40 + k * 280
        svg.add(f'<g transform="rotate({-2 + 4 * k} {x + 120} 150)"><rect x="{x}" y="30" width="240" height="240" fill="{WHITE}" stroke="#cbbf9f"/>'
                f'<rect x="{x}" y="30" width="240" height="44" fill="{BLUE if k == 0 else RED}"/></g>')
        svg.text(x + 120, 60, f'MATHEMATICAL LITERACY - {title}', 11, WHITE, 'middle', 700, MONO)
        svg.text(x + 120, 98, '75 marks   ·   1 h 30 min', 12, INK, 'middle', 700, NUM)
        for i, t in enumerate(topics):
            svg.text(x + 30, 130 + i * 22, '• ' + t, 13, INK, 'start', 600, NUM)
        svg.text(x + 30, 214, 'Q1  short questions (Level 1)', 10, '#5b6670', 'start', 600, MONO)
        svg.text(x + 30, 230, 'Q2-3  one topic each', 10, '#5b6670', 'start', 600, MONO)
        svg.text(x + 30, 246, 'Q4-5  integrated', 10, '#5b6670', 'start', 600, MONO)
    svg.save()


def hall_plan():
    """The school hall, 12 m x 8 m inside, at 1 : 200 - 1 cm = 2 m = 40 units, so 1 m = 20 units."""
    w, h = 600, 400
    svg = blueprint('hallplan', w, h, 'Floor plan of the school hall at a scale of 1 to 200: a rectangle with a stage across one short end, a dance floor in the middle and doors on the long side; no dimensions are written, so they must be measured')
    m = CM / 2                                # 1 m = 20 units at 1 : 200
    ox, oy = 180, 110
    X = lambda v: ox + v * m
    Y = lambda v: oy + v * m
    t = 0.3 * m
    svg.text(w / 2, 40, 'SCHOOL HALL - FLOOR PLAN', 15, WHITE, 'middle', 700, MONO)
    svg.add(f'<path d="M{X(0) - t} {Y(0) - t} H{X(12) + t} V{Y(8) + t} H{X(0) - t} Z M{X(0)} {Y(0)} V{Y(8)} H{X(12)} V{Y(0)} Z" fill="{WHITE}" fill-rule="evenodd"/>')
    # stage: 2 m deep across the left (short) end, 8 m wide... the stage is 4 m wide, centred
    svg.add(f'<rect x="{X(0)}" y="{Y(2)}" width="{2 * m}" height="{4 * m}" fill="none" stroke="#ffd166" stroke-width="2"/>')
    svg.text(X(1), Y(4) + 4, 'STAGE', 9, '#ffd166', 'middle', 700, MONO)
    # dance floor 6 x 4 m in the middle
    svg.add(f'<rect x="{X(4)}" y="{Y(2)}" width="{6 * m}" height="{4 * m}" fill="none" stroke="{PALE}" stroke-width="1.6" stroke-dasharray="6 4"/>')
    svg.text(X(7), Y(4) + 4, 'DANCE FLOOR', 9, PALE, 'middle', 700, MONO)
    # double doors 2 m wide on the bottom long wall, 9-11 m
    svg.add(f'<rect x="{X(9)}" y="{Y(8)}" width="{2 * m}" height="{t}" fill="{BLUE_BG}"/>'
            f'<path d="M{X(9)} {Y(8)} V{Y(7)} M{X(11)} {Y(8)} V{Y(7)}" stroke="{WHITE}" stroke-width="2"/>'
            f'<path d="M{X(9)} {Y(7)} A{m} {m} 0 0 1 {X(10)} {Y(8)} M{X(11)} {Y(7)} A{m} {m} 0 0 0 {X(10)} {Y(8)}" fill="none" stroke="{WHITE}" stroke-width="1.2" stroke-dasharray="4 3"/>')
    by = h - 24
    svg.text(X(0) - t, by - 14, 'Scale 1 : 200', 11, WHITE, 'start', 600, MONO)
    for k in range(5):
        svg.add(f'<rect x="{X(0) - t + k * 2 * m}" y="{by - 6}" width="{2 * m}" height="6" fill="{WHITE if k % 2 == 0 else BLUE_BG}" stroke="{WHITE}"/>')
    svg.text(X(0) - t + 10 * m + 8, by, '10 m', 10, WHITE, 'start', 600, MONO)
    svg.save()


def d_jobdone12():
    svg = Svg('jobdone12', 320, 200, 'Hadi with a JOB DONE stamp at the end of the road trip', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'end of the route - good luck!', 14, INK, 'middle', font=MARKER)
    svg.save()


def jokes12():
    j = jcard('trippapers', 'An exam paper with a sad face, covered in question marks')
    j.add(f'<rect x="100" y="30" width="100" height="140" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    face(j, 150, 70, 16, 'sad')
    for k, (x, y) in enumerate([(120, 110), (160, 120), (135, 145), (180, 150)]):
        j.text(x, y, '?', 18, RED if k % 2 else BLUE, 'middle')
    j.save()

    j = jcard('tripq1', 'A card saying Q1 hanging from a hook, looking a bit forgotten')
    j.add(f'<path d="M150 20 v14 q0 10 -10 10" stroke="{INK}" stroke-width="4" fill="none"/>')
    j.add(f'<path d="M150 40 L110 70 M150 40 L190 70" stroke="{INK}" stroke-width="2"/><rect x="100" y="70" width="100" height="80" rx="6" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    j.text(150, 112, 'Q1', 26, BLUE, 'middle')
    face(j, 150, 134, 10, 'sad')
    j.text(150, 176, '20% OF THE MARKS', 11, RED, 'middle')
    j.save()

    j = jcard('tripp1', 'A calculator and a pencil sitting back to back, not talking')
    j.add(f'<rect x="60" y="60" width="70" height="100" rx="8" fill="#2b2d42" stroke="{INK}" stroke-width="3"/><rect x="70" y="70" width="50" height="22" fill="#cfe9d4"/>'
          + ''.join(f'<rect x="{70 + (k % 3) * 18}" y="{100 + (k // 3) * 16}" width="12" height="10" rx="2" fill="#9aa5ad"/>' for k in range(9)))
    face(j, 95, 81, 9, 'flat')
    j.add(f'<g transform="rotate(10 210 110)"><path d="M196 50 h28 v90 l-14 22 l-14 -22 z" fill="#ffd166" stroke="{INK}" stroke-width="3"/></g>')
    face(j, 212, 90, 9, 'flat')
    j.save()

    j = jcard('tripp2', 'A folded map with a face, striding along confidently with a ruler under its arm')
    j.add(f'<path d="M90 50 l40 -12 l40 12 l40 -12 v100 l-40 12 l-40 -12 l-40 12 z" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>'
          f'<path d="M130 38 v100 M170 50 v100" stroke="{INK}" stroke-width="1.5"/>')
    face(j, 150, 88, 16)
    j.add(f'<rect x="200" y="100" width="70" height="14" fill="#ffe26e" stroke="{INK}" stroke-width="2" transform="rotate(-20 235 107)"/>')
    j.add(f'<path d="M130 150 l-10 30 M170 150 l10 30" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    j.save()

    j = jcard('trippractice', 'A wall clock with a cheeky face, sticking out its tongue')
    j.add(f'<circle cx="150" cy="96" r="62" fill="{WHITE}" stroke="{INK}" stroke-width="4"/>')
    for k in range(12):
        import math
        a = math.radians(k * 30)
        j.add(f'<path d="M{150 + 52 * math.sin(a):.1f} {96 - 52 * math.cos(a):.1f} L{150 + 58 * math.sin(a):.1f} {96 - 58 * math.cos(a):.1f}" stroke="{INK}" stroke-width="3"/>')
    j.add(f'<path d="M150 96 V56 M150 96 L180 110" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    j.add(f'<circle cx="132" cy="80" r="4" fill="{INK}"/><circle cx="168" cy="80" r="4" fill="{INK}"/><path d="M140 124 q10 6 20 0" stroke="{INK}" stroke-width="2.5" fill="none"/><path d="M146 126 q4 12 8 0" fill="#ff8fa3" stroke="{INK}" stroke-width="1.5"/>')
    j.save()


if __name__ == '__main__':
    for o in [(67, 12, 1, 5, 'How the papers work', 'Two papers, four levels, one plan.', ['READ THE', 'VERB FIRST']),
              (68, 12, 2, 5, 'Question 1 drills', 'The easiest marks on the paper.', ['ONE STEP', 'EACH!']),
              (69, 12, 3, 5, 'Paper 1 stops', 'Money, data and chance together.', ['VERIFY', 'THAT!']),
              (70, 12, 4, 5, 'Paper 2 stops', 'Plans, measuring and maps together.', ['RULER', 'OUT!']),
              (71, 12, 5, 5, 'Practice papers', 'The real thing, one more time.', ['YOU\'VE', 'GOT THIS'])]:
        opener(*o)
    scrapbook(); papers(); hall_plan(); d_jobdone12()
    jokes12()
