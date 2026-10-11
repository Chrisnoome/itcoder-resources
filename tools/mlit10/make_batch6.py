"""Batch 6 (The Great Bake-Off) art for the Grade 10 Maths Literacy course.

Theme A: retro recipe cards - mint ground, ruled index cards, pastel enamel,
dial scales and measuring cups. The measuring instruments are drawn EXACTLY
(the lessons ask pupils to read them): a kitchen scale at 340 g, a jug at
650 ml, a ruler under a biscuit from 1,0 cm to 7,4 cm, a thermometer at
22 °C and an oven dial at 180 °C. Uses the pieces in make_art.py and
make_jokes.py. Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch6.py
"""
import math, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, bubble, SIGN, INK, RED, BLUE, WHITE, NUM, HAND, MARKER
from make_jokes import jcard, face

MINT, CARD, CARDRED, CARDBLUE, PINK, BUTTER = '#cdeee0', '#fffdf6', '#e86a6a', '#a9c9e8', '#ffe1e8', '#ffe8a3'


def mint(name, w, h, label):
    return Svg(name, w, h, label, bg=MINT, rx=8)


def recipe_card(svg, x, y, w, h, title, lines, rot=0):
    svg.add(f'<g transform="rotate({rot} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{CARD}" stroke="#b9b0a0"/>'
            f'<path d="M{x} {y + 30} H{x + w}" stroke="{CARDRED}" stroke-width="2"/>'
            + ''.join(f'<path d="M{x} {y + 50 + i * 20} H{x + w}" stroke="{CARDBLUE}"/>' for i in range(int((h - 50) / 20)))
            + f'<text x="{x + 10}" y="{y + 22}" font-family="{HAND}" font-size="16" fill="{INK}">{title}</text>'
            + ''.join(f'<text x="{x + 10}" y="{y + 46 + i * 20}" font-family="{HAND}" font-size="14" fill="{INK}">{t}</text>' for i, t in enumerate(lines))
            + '</g>')


# ------------------------------------------------ exact instruments ------

def scale_figure():
    svg = Svg('scaledial', 420, 320, 'A kitchen scale dial from 0 to 1 000 g, small marks every 20 g, the needle at 340 g', bg=WHITE, rx=6)
    cx, cy, r = 210, 160, 120
    svg.add(f'<circle cx="{cx}" cy="{cy}" r="{r + 14}" fill="{PINK}" stroke="{INK}" stroke-width="3"/><circle cx="{cx}" cy="{cy}" r="{r}" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    for g in range(0, 1001, 20):
        a = math.radians(-90 + g / 1000 * 300 - 150 + 150)  # 0 at top, clockwise, 300 degrees for 1 000 g
        a = math.radians(-90 + g * 0.3)
        big = g % 100 == 0
        r1 = r - (18 if big else 9)
        svg.add(f'<path d="M{cx + r1 * math.cos(a):.1f} {cy + r1 * math.sin(a):.1f} L{cx + r * math.cos(a):.1f} {cy + r * math.sin(a):.1f}" stroke="{INK}" stroke-width="{2.2 if big else 1}"/>')
        if big:
            rt = r - 32
            svg.text(cx + rt * math.cos(a), cy + rt * math.sin(a) + 5, str(g), 13, INK, 'middle', 600, NUM)
    a = math.radians(-90 + 340 * 0.3)
    svg.add(f'<path d="M{cx} {cy} L{cx + (r - 6) * math.cos(a):.1f} {cy + (r - 6) * math.sin(a):.1f}" stroke="{RED}" stroke-width="3"/><circle cx="{cx}" cy="{cy}" r="7" fill="{RED}"/>')
    svg.text(cx, cy + 46, 'grams', 13, INK, 'middle', 600, NUM)
    svg.save()


def jug_figure():
    svg = Svg('jug', 360, 340, 'A measuring jug marked every 50 ml up to 1 000 ml, filled to 650 ml', bg=WHITE, rx=6)
    x0, x1, yb, yt = 90, 250, 300, 60
    level = 650
    Y = lambda ml: yb - ml / 1000 * (yb - yt)
    svg.add(f'<rect x="{x0}" y="{Y(level):.1f}" width="{x1 - x0}" height="{yb - Y(level):.1f}" fill="#bfe3ff" opacity=".85"/>')
    svg.add(f'<path d="M{x0} {yt - 20} V{yb} H{x1} V{yt - 20}" fill="none" stroke="{INK}" stroke-width="3"/><path d="M{x1} {yt + 20} q50 10 46 70 q-4 50 -46 60" fill="none" stroke="{INK}" stroke-width="5"/>')
    for ml in range(50, 1001, 50):
        big = ml % 250 == 0
        svg.add(f'<path d="M{x0} {Y(ml):.1f} h{28 if big else 14}" stroke="{INK}" stroke-width="{2 if big else 1.2}"/>')
        if big:
            svg.text(x0 - 8, Y(ml) + 4, f'{ml} ml', 12, INK, 'end', 600, NUM)
    svg.save()


def ruler_figure():
    svg = Svg('ruler', 520, 200, 'A biscuit on a ruler: its left edge at 1,0 cm and its right edge at 7,4 cm', bg=WHITE, rx=6)
    x0, unit, y = 40, 44, 120
    svg.add(f'<rect x="{x0 - 16}" y="{y}" width="{unit * 10 + 32}" height="56" fill="#ffe8a3" stroke="{INK}" stroke-width="2"/>')
    for mm in range(0, 101):
        x = x0 + mm * unit / 10
        hh = 22 if mm % 10 == 0 else (14 if mm % 5 == 0 else 8)
        svg.add(f'<path d="M{x:.1f} {y} v{hh}" stroke="{INK}" stroke-width="{1.6 if mm % 10 == 0 else 1}"/>')
        if mm % 10 == 0:
            svg.text(x, y + 40, str(mm // 10), 13, INK, 'middle', 600, NUM)
    svg.text(x0 + unit * 10, y + 52, 'cm', 11, INK, 'middle', 600, NUM)
    a, b = x0 + 1.0 * unit, x0 + 7.4 * unit
    svg.add(f'<rect x="{a}" y="{y - 46}" width="{b - a}" height="44" rx="10" fill="#d9a35c" stroke="{INK}" stroke-width="2"/>')
    for k in range(5):
        svg.add(f'<circle cx="{a + 30 + k * 56}" cy="{y - 24}" r="3" fill="#8a5a32"/>')
    svg.add(f'<path d="M{a} {y - 50} V{y + 4} M{b} {y - 50} V{y + 4}" stroke="{RED}" stroke-width="1.5" stroke-dasharray="3 3"/>')
    svg.save()


def thermo_figure():
    svg = Svg('thermometer', 300, 360, 'A thermometer from -20 to 40 degrees Celsius, marks every 2 degrees, reading 22 degrees', bg=WHITE, rx=6)
    x, yt, yb = 150, 30, 300
    Y = lambda t: yb - (t + 20) / 60 * (yb - yt)
    svg.add(f'<rect x="{x - 10}" y="{yt - 10}" width="20" height="{yb - yt + 20}" rx="10" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>'
            f'<circle cx="{x}" cy="{yb + 26}" r="20" fill="{RED}" stroke="{INK}" stroke-width="2.5"/><rect x="{x - 5}" y="{Y(22):.1f}" width="10" height="{yb + 14 - Y(22):.1f}" fill="{RED}"/>')
    for t in range(-20, 41, 2):
        big = t % 10 == 0
        svg.add(f'<path d="M{x + 12} {Y(t):.1f} h{18 if big else 9}" stroke="{INK}" stroke-width="{1.8 if big else 1}"/>')
        if big:
            svg.text(x + 36, Y(t) + 4, f'{t} °C'.replace('-', '−'), 12, INK, 'start', 600, NUM)
    svg.save()


def oven_figure():
    svg = mint('ovendial', 320, 220, 'An oven dial from 0 to 250 degrees, pointing at 180 degrees')
    cx, cy, r = 110, 116, 70
    svg.add(f'<circle cx="{cx}" cy="{cy}" r="{r + 10}" fill="#eaeaea" stroke="{INK}" stroke-width="3"/><circle cx="{cx}" cy="{cy}" r="{r - 24}" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    for t in range(0, 251, 25):
        a = math.radians(150 + t / 250 * 240)
        svg.add(f'<path d="M{cx + (r - 6) * math.cos(a):.1f} {cy + (r - 6) * math.sin(a):.1f} L{cx + (r + 6) * math.cos(a):.1f} {cy + (r + 6) * math.sin(a):.1f}" stroke="{INK}" stroke-width="2"/>')
        if t % 50 == 0:
            svg.text(cx + (r - 18) * math.cos(a), cy + (r - 18) * math.sin(a) + 4, str(t), 10, INK, 'middle', 600, NUM)
    a = math.radians(150 + 180 / 250 * 240)
    svg.add(f'<path d="M{cx} {cy} L{cx + (r - 30) * math.cos(a):.1f} {cy + (r - 30) * math.sin(a):.1f}" stroke="{RED}" stroke-width="5" stroke-linecap="round"/>')
    hadi(svg, 196, 104, .9)
    bubble(svg, 190, 24, 112, ['180 °C,', 'PREHEAT!'], 222, 108, size=11)
    svg.save()


def metric_ladder():
    svg = mint('metricladder', 520, 230, 'The metric steps: km to m times 1 000, m to cm times 100, cm to mm times 10; kg to g times 1 000; l to ml times 1 000')
    rows = [(['km', 'm', 'cm', 'mm'], ['x 1 000', 'x 100', 'x 10']), (['kg', 'g'], ['x 1 000']), (['l', 'ml'], ['x 1 000'])]
    for r, (units, steps) in enumerate(rows):
        y = 40 + r * 64
        for i, u in enumerate(units):
            x = 30 + i * 130
            svg.add(f'<rect x="{x}" y="{y}" width="70" height="40" rx="8" fill="{CARD}" stroke="{INK}" stroke-width="2.5"/>')
            svg.text(x + 35, y + 27, u, 18, INK, 'middle', 700, NUM)
            if i < len(steps):
                svg.add(f'<path d="M{x + 74} {y + 20} h52" stroke="{BLUE}" stroke-width="2.5"/><path d="M{x + 118} {y + 13} l8 7 l-8 7" stroke="{BLUE}" stroke-width="2.5" fill="none"/>')
                svg.text(x + 100, y + 10, steps[i], 12, BLUE, 'middle', 700, NUM)
    svg.text(260, 222, 'bigger to smaller unit: multiply.  Smaller to bigger: divide.', 13, INK, 'middle', 600, NUM)
    svg.save()


# ------------------------------------------------------------ doodles ----

def d_cups():
    svg = mint('cups', 320, 200, 'A cup is 250 ml, a tablespoon 15 ml, a teaspoon 5 ml')
    svg.add(f'<path d="M30 70 h80 l-8 80 h-64z" fill="{WHITE}" stroke="{INK}" stroke-width="3"/><path d="M110 86 q24 4 18 30 q-6 14 -24 12" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.text(70, 116, '250 ml', 14, INK, 'middle', 700, NUM); svg.text(70, 178, '1 cup', 15, INK, 'middle', font=HAND)
    for x, w, lab, ml in [(170, 46, '1 tbsp', '15 ml'), (250, 34, '1 tsp', '5 ml')]:
        svg.add(f'<ellipse cx="{x}" cy="110" rx="{w / 2}" ry="{w / 3}" fill="{BUTTER}" stroke="{INK}" stroke-width="2.5"/><path d="M{x + w / 2} 110 h{40 - w / 3}" stroke="{INK}" stroke-width="5" stroke-linecap="round"/>')
        svg.text(x + 10, 160, ml, 13, INK, 'middle', 700, NUM); svg.text(x + 10, 178, lab, 15, INK, 'middle', font=HAND)
    svg.save()


def d_card():
    svg = mint('recipecard', 320, 200, 'A recipe card for a sponge cake that serves 8')
    recipe_card(svg, 30, 16, 260, 170, 'Showstopper Sponge (serves 8)', ['2 cups cake flour', '1½ cups sugar', '4 eggs, 125 g butter', '250 ml milk, 2 tsp baking powder'], -2)
    svg.save()


def d_timer():
    svg = mint('timer', 320, 200, 'A kitchen timer and a clock: 10:45 plus 35 minutes is 11:20')
    svg.add(f'<circle cx="90" cy="104" r="62" fill="{WHITE}" stroke="{INK}" stroke-width="4"/>')
    for k in range(12):
        a = math.radians(k * 30 - 90)
        svg.add(f'<path d="M{90 + 52 * math.cos(a):.1f} {104 + 52 * math.sin(a):.1f} L{90 + 60 * math.cos(a):.1f} {104 + 60 * math.sin(a):.1f}" stroke="{INK}" stroke-width="2"/>')
    for ang, ln, wd in [(-90 + 11.33 * 30, 32, 5), (-90 + 20 * 6, 48, 3)]:
        a = math.radians(ang)
        svg.add(f'<path d="M90 104 L{90 + ln * math.cos(a):.1f} {104 + ln * math.sin(a):.1f}" stroke="{INK}" stroke-width="{wd}" stroke-linecap="round"/>')
    svg.text(230, 70, '10:45', 22, INK, 'middle', 700, NUM)
    svg.text(230, 104, '+ 35 min', 18, BLUE, 'middle', 700, NUM)
    svg.text(230, 144, '11:20', 26, RED, 'middle', 800, NUM)
    svg.save()


def d_tv():
    svg = mint('tvschedule', 330, 210, 'A TV with the Bake-Off logo and a schedule showing it airs at 15:00')
    svg.add(f'<rect x="20" y="30" width="180" height="120" rx="10" fill="{INK}"/><rect x="30" y="40" width="160" height="100" rx="4" fill="{PINK}"/>'
            f'<path d="M80 150 l-20 30 M140 150 l20 30" stroke="{INK}" stroke-width="4"/>')
    svg.text(110, 86, 'THE BIG', 14, RED, 'middle'); svg.text(110, 108, 'BAKE', 18, RED, 'middle')
    recipe_card(svg, 214, 30, 100, 150, 'Saturday', ['14:00 News', '14:30 Sport', '15:00 BAKE', '16:00 Film'], 3)
    svg.save()


def d_jobdone6():
    svg = Svg('jobdone6', 320, 200, 'Hadi with a JOB DONE stamp after the Bake-Off', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Matchday', 15, INK, 'middle', font=MARKER)
    svg.save()


# --------------------------------------------------------------- jokes ----

def jokes6():
    j = jcard('bakemetric', 'A tiny millimetre and a long kilometre side by side, the millimetre looking up')
    j.add(f'<rect x="40" y="120" width="10" height="10" fill="{BLUE}" stroke="{INK}" stroke-width="2"/><rect x="70" y="60" width="200" height="16" fill="{RED}" stroke="{INK}" stroke-width="2"/>')
    j.text(45, 150, 'mm', 13, INK, 'middle'); j.text(170, 100, 'km', 16, INK, 'middle'); face(j, 170, 68, 10)
    j.add(f'<path d="M50 118 q20 -30 40 -38" stroke="{INK}" stroke-width="1.5" fill="none" stroke-dasharray="3 3"/>'); j.save()

    j = jcard('bakecups', 'A measuring cup tucking a teaspoon into bed')
    j.add(f'<path d="M150 150 h110 v20 h-110z" fill="{PINK}" stroke="{INK}" stroke-width="2.5"/><path d="M150 150 v-14 h20 v14" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<ellipse cx="200" cy="146" rx="14" ry="6" fill="{BUTTER}" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<path d="M50 60 h70 l-6 70 h-58z" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>'); face(j, 85, 90, 16)
    j.text(220, 60, 'Z z z', 18, BLUE, 'middle'); j.save()

    j = jcard('bakeread', 'A kitchen scale with the needle pointing up, flexing its arms')
    j.add(f'<rect x="90" y="110" width="120" height="50" rx="8" fill="{PINK}" stroke="{INK}" stroke-width="3"/><circle cx="150" cy="80" r="40" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>'
          f'<path d="M150 80 L150 46" stroke="{RED}" stroke-width="3"/>')
    j.add(f'<path d="M90 120 q-30 -10 -30 -40 q20 0 26 18 M210 120 q30 -10 30 -40 q-20 0 -26 18" fill="none" stroke="{INK}" stroke-width="4"/>')
    face(j, 150, 92, 14); j.save()

    j = jcard('bakeoven', 'An oven sweating and fanning itself')
    j.add(f'<rect x="90" y="40" width="130" height="120" rx="8" fill="#eaeaea" stroke="{INK}" stroke-width="3"/><rect x="104" y="80" width="102" height="64" rx="4" fill="#ffb26b" stroke="{INK}" stroke-width="2"/>')
    face(j, 155, 112, 18, 'flat')
    j.add(f'<path d="M226 60 q30 10 40 40 l-30 -6z" fill="{BLUE}" stroke="{INK}" stroke-width="2"/><path d="M110 56 q4 8 0 14 M200 56 q4 8 0 14" stroke="#1d4fd8" stroke-width="3" fill="none"/>')
    j.text(60, 50, '180°', 14, RED, 'middle'); j.save()

    j = jcard('bakeclock', 'A clock running fast with legs, past a calendar')
    j.add(f'<circle cx="140" cy="90" r="46" fill="{WHITE}" stroke="{INK}" stroke-width="4"/><path d="M140 90 v-30 M140 90 h22" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    j.add(f'<path d="M126 134 l-14 30 M154 134 l18 26" stroke="{INK}" stroke-width="4" stroke-linecap="round"/><path d="M60 80 h-30 M60 96 h-40 M60 112 h-26" stroke="{INK}" stroke-width="3"/>')
    j.add(f'<rect x="210" y="56" width="60" height="70" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/><rect x="210" y="56" width="60" height="16" fill="{RED}"/>'); j.text(240, 106, '31', 20, INK, 'middle'); j.save()

    j = jcard('bakeshow', 'A cake taking a bow on a TV stage under a spotlight')
    j.add(f'<path d="M150 10 L90 170 H210 Z" fill="#fff6c2" opacity=".9"/><rect x="110" y="110" width="80" height="44" rx="6" fill="{PINK}" stroke="{INK}" stroke-width="3"/><rect x="110" y="110" width="80" height="12" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    face(j, 150, 136, 14); j.add(f'<path d="M150 110 v-14" stroke="{INK}" stroke-width="3"/><path d="M146 92 q4 -10 8 0z" fill="#ffb26b"/>'); j.text(250, 60, 'TA-DA!', 16, RED, 'middle'); j.save()


if __name__ == '__main__':
    for o in [(29, 6, 1, 6, 'Metric moves', 'Kilo, centi, milli - one step at a time.', ['x 1 000!']),
              (30, 6, 2, 6, 'Spoons and cups', 'A recipe for 8, a party of 30.', ['SCALE IT', 'UP!']),
              (31, 6, 3, 6, 'Read the instrument', 'Count the little marks first.', ['WHAT IS ONE', 'MARK WORTH?']),
              (32, 6, 4, 6, 'Oven heat', 'Hot, cold and the space between.', ['180 °C!']),
              (33, 6, 5, 6, 'Clock watching', 'Twelve hours, twenty-four hours, no hours left.', ['TICK', 'TOCK']),
              (34, 6, 6, 6, 'The broadcast schedule', 'On air at three. Not a minute later.', ['ON AIR', 'AT 15:00'])]:
        opener(*o)
    scale_figure(); jug_figure(); ruler_figure(); thermo_figure(); oven_figure(); metric_ladder()
    d_cups(); d_card(); d_timer(); d_tv(); d_jobdone6()
    jokes6()
