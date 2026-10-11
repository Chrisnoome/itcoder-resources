"""Batch 11 (Weather Watch) art for the Grade 10 Maths Literacy course.

Theme A: a weather chart - pale sky ground, isobar lines, H and L, wind barbs.
The GRAPHS to read from are documents, drawn exactly (bar values sit on grid
lines, the pie's angles are exact). Writes
AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch11.py
"""
import math, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, plot, esc, SIGN, INK, RED, BLUE, WHITE, NUM, MARKER, MONO
from make_jokes import jcard, face

SKY, ISO, DEEP, LOWRED = '#e8f3f8', '#3a7ca5', '#1d4f73', '#c0392b'
MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
RAIN = [125, 90, 80, 50, 15, 5, 5, 5, 25, 70, 110, 120]          # the school's rainfall, mm a month
TEMPS = [24, 26, 27, 22, 19, 21, 25, 28, 29, 30, 26, 23, 24, 27]  # daily maximum, 1-14 October


def sky(name, w, h, label):
    svg = Svg(name, w, h, label, bg=SKY, rx=8)
    for i in range(5):
        svg.add(f'<path d="M{-20 + i * 8} {30 + i * (h / 6):.0f} C {w * .3:.0f} {10 + i * (h / 6):.0f}, {w * .6:.0f} {50 + i * (h / 6):.0f}, {w + 20} {20 + i * (h / 6):.0f}" fill="none" stroke="{ISO}" stroke-width="1.2" opacity=".5"/>')
    return svg


def bar_chart(name, label, cats, vals, y1, ys, heading, ylab, xlab, w=600, h=360, every=2, y0=0, colour=ISO):
    """An exact bar graph to read from."""
    svg = Svg(name, w, h, label, bg=WHITE, rx=6)
    L, R, T, B = 70, w - 20, 46, h - 58
    Y = lambda v: B - (v - y0) / (y1 - y0) * (B - T)
    n = round((y1 - y0) / ys)
    for i in range(n + 1):
        v = y0 + i * ys
        svg.add(f'<path d="M{L} {Y(v):.1f} H{R}" stroke="#d6e2ea" stroke-width="1"/>')
        if i % every == 0:
            svg.text(L - 8, Y(v) + 4, f'{v:g}', 12, INK, 'end', font=NUM)
    slot = (R - L) / len(cats)
    for i, (c, v) in enumerate(zip(cats, vals)):
        x = L + i * slot + slot * .18
        svg.add(f'<rect x="{x:.1f}" y="{Y(v):.1f}" width="{slot * .64:.1f}" height="{B - Y(v):.1f}" fill="{colour}"/>')
        svg.text(L + i * slot + slot / 2, B + 18, c, 12, INK, 'middle', font=NUM)
    svg.add(f'<path d="M{L} {B} H{R}" stroke="{INK}" stroke-width="1.8"/><path d="M{L} {T} V{B}" stroke="{INK}" stroke-width="1.8"/>')
    if y0 > 0:
        svg.add(f'<path d="M{L - 6} {B - 10} l12 -4 M{L - 6} {B - 4} l12 -4" stroke="{INK}" stroke-width="1.5"/>')
    svg.text((L + R) / 2, 26, heading, 15, INK, 'middle', 700, NUM)
    svg.text((L + R) / 2, h - 16, xlab, 13, INK, 'middle', 600, NUM)
    svg.add(f'<text x="18" y="{(T + B) / 2}" font-family="{NUM}" font-size="13" font-weight="600" fill="{INK}" text-anchor="middle" transform="rotate(-90 18 {(T + B) / 2})">{esc(ylab)}</text>')
    svg.save()


def pie():
    w, h = 520, 320
    svg = Svg('weatherpie', w, h, 'Pie chart of the weather on the 30 days of November: sunny 50%, partly cloudy 30%, rain 20%', bg=WHITE, rx=6)
    svg.text(w / 2, 28, 'Weather on the 30 days of November', 15, INK, 'middle', 700, NUM)
    cx, cy, r = 170, 175, 115
    parts = [('Sunny', 50, '#ffd166'), ('Partly cloudy', 30, '#9fb3c8'), ('Rain', 20, ISO)]
    a = -90
    for name, pct, col in parts:
        b = a + pct * 3.6
        x0, y0 = cx + r * math.cos(math.radians(a)), cy + r * math.sin(math.radians(a))
        x1, y1 = cx + r * math.cos(math.radians(b)), cy + r * math.sin(math.radians(b))
        large = 1 if pct > 50 else 0
        svg.add(f'<path d="M{cx} {cy} L{x0:.1f} {y0:.1f} A{r} {r} 0 {large} 1 {x1:.1f} {y1:.1f} Z" fill="{col}" stroke="{WHITE}" stroke-width="3"/>')
        m = math.radians((a + b) / 2)
        svg.text(cx + r * .6 * math.cos(m), cy + r * .6 * math.sin(m) + 6, f'{pct}%', 17, INK, 'middle', 800, NUM)
        a = b
    for i, (name, pct, col) in enumerate(parts):
        y = 120 + i * 34
        svg.add(f'<rect x="330" y="{y - 14}" width="18" height="18" rx="3" fill="{col}"/>')
        svg.text(358, y, name, 14, INK, 'start', 600, NUM)
    svg.save()


def misleading():
    """The same two numbers drawn twice: honestly from 0, and with the axis starting at 60."""
    w, h = 640, 330
    svg = Svg('misleading', w, h, 'Two bar graphs of the same September rainfall, 30 mm this year against a 22 mm average: graph A starts its axis at 0 and the bars look fairly similar; graph B starts its axis at 20 and this year looks five times bigger', bg=WHITE, rx=6)
    for k, (title, y0, y1, step) in enumerate([('GRAPH A', 0, 40, 5), ('GRAPH B', 20, 32, 2)]):
        L = 70 + k * 320; R = L + 220; T, B = 60, 270
        Y = lambda v: B - (v - y0) / (y1 - y0) * (B - T)
        svg.text(L + 110, 34, title, 14, INK, 'middle', 700, NUM)
        for v in range(y0, y1 + 1, step):
            svg.add(f'<path d="M{L} {Y(v):.1f} H{R}" stroke="#d6e2ea"/>')
            svg.text(L - 8, Y(v) + 4, str(v), 11, INK, 'end', font=NUM)
        for i, (lab, v, col) in enumerate([('Average', 22, '#9fb3c8'), ('This year', 30, ISO)]):
            x = L + 30 + i * 100
            svg.add(f'<rect x="{x}" y="{Y(v):.1f}" width="60" height="{B - Y(v):.1f}" fill="{col}"/>')
            svg.text(x + 30, B + 18, lab, 11, INK, 'middle', 600, NUM)
        svg.add(f'<path d="M{L} {B} H{R} M{L} {T} V{B}" stroke="{INK}" stroke-width="1.8"/>')
        svg.text(L + 110, h - 12, 'September rainfall (mm)', 11, INK, 'middle', 600, NUM)
    svg.save()


def station():
    w, h = 560, 300
    svg = sky('weatherstation', w, h, 'The school weather station on the roof: a rain gauge, a thermometer in a white louvred box, and a wind vane, under a weather chart with a high-pressure H')
    svg.add(f'<rect x="0" y="230" width="{w}" height="70" fill="#9aa5ad"/><path d="M0 230 H{w}" stroke="{DEEP}" stroke-width="3"/>')
    # rain gauge
    svg.add(f'<path d="M90 120 h40 l-6 110 h-28 z" fill="{WHITE}" stroke="{DEEP}" stroke-width="3"/><path d="M84 120 h52" stroke="{DEEP}" stroke-width="4"/>')
    for k in range(6):
        svg.add(f'<path d="M100 {140 + k * 14} h{10 if k % 2 else 16}" stroke="{DEEP}" stroke-width="1.5"/>')
    svg.add(f'<rect x="97" y="190" width="26" height="38" fill="{ISO}" opacity=".6"/>')
    svg.text(110, 110, 'RAIN GAUGE', 11, DEEP, 'middle', 700, MONO)
    # louvred box with thermometer
    svg.add(f'<rect x="230" y="110" width="100" height="90" fill="{WHITE}" stroke="{DEEP}" stroke-width="3"/>'
            + ''.join(f'<path d="M234 {122 + k * 12} h92" stroke="#c9d6e3" stroke-width="3"/>' for k in range(7))
            + f'<path d="M260 200 V230 M300 200 V230" stroke="{DEEP}" stroke-width="5"/>')
    svg.add(f'<rect x="274" y="126" width="12" height="60" rx="6" fill="{WHITE}" stroke="{DEEP}" stroke-width="2"/><circle cx="280" cy="188" r="9" fill="{LOWRED}"/><rect x="277" y="150" width="6" height="36" fill="{LOWRED}"/>')
    svg.text(280, 100, 'THERMOMETER', 11, DEEP, 'middle', 700, MONO)
    # wind vane
    svg.add(f'<path d="M440 230 V100" stroke="{DEEP}" stroke-width="4"/><path d="M400 100 h80 l-14 -10 M480 100 l-14 10 M400 100 l-10 -12 h20 z" fill="{DEEP}" stroke="{DEEP}" stroke-width="3"/>')
    svg.text(440, 80, 'WIND VANE', 11, DEEP, 'middle', 700, MONO)
    svg.text(510, 50, 'H', 30, DEEP, 'middle', 800, NUM)
    svg.save()


def d_jobdone11():
    svg = Svg('jobdone11', 320, 200, 'Hadi with a JOB DONE stamp after Weather Watch', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: the Road Trip', 15, INK, 'middle', font=MARKER)
    svg.save()


def jokes11():
    j = jcard('weatherbar', 'A bar from a bar graph with a face, lifting a dumbbell')
    j.add(f'<rect x="130" y="70" width="40" height="100" fill="{ISO}" stroke="{INK}" stroke-width="3"/>')
    face(j, 150, 96, 13)
    j.add(f'<path d="M100 60 H200" stroke="{INK}" stroke-width="6" stroke-linecap="round"/><rect x="86" y="44" width="14" height="32" rx="3" fill="{INK}"/><rect x="200" y="44" width="14" height="32" rx="3" fill="{INK}"/>'
          f'<path d="M130 80 L112 60 M170 80 L188 60" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    j.save()

    j = jcard('weatherline', 'A line graph with a face that zigzags up and down like a mood swing')
    j.add(f'<path d="M30 160 L80 70 L120 140 L170 50 L210 130 L270 80" fill="none" stroke="{ISO}" stroke-width="6" stroke-linejoin="round"/>')
    face(j, 170, 50, 14, 'o')
    j.add(f'<path d="M30 170 H275 M30 170 V30" stroke="{INK}" stroke-width="3"/>')
    j.save()

    j = jcard('weatherhist', 'Histogram bars with faces, standing shoulder to shoulder with no gaps')
    for i, hgt in enumerate([60, 100, 80, 40]):
        x = 70 + i * 40
        j.add(f'<rect x="{x}" y="{170 - hgt}" width="40" height="{hgt}" fill="{ISO}" stroke="{INK}" stroke-width="3"/>')
        face(j, x + 20, 170 - hgt + 18, 10)
    j.add(f'<path d="M60 170 H250" stroke="{INK}" stroke-width="3"/>')
    j.save()

    j = jcard('weatherpie', 'A pie chart on a plate at a braai, with a fork stuck in it')
    j.add(f'<ellipse cx="150" cy="120" rx="110" ry="40" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    j.add(f'<path d="M150 112 L150 76 A60 36 0 0 1 206 104 Z" fill="#ffd166" stroke="{INK}" stroke-width="2"/><path d="M150 112 L206 104 A60 36 0 1 1 150 76 Z" fill="{ISO}" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<path d="M220 40 L180 96 M214 34 l12 12 M208 40 l12 12" stroke="{INK}" stroke-width="3"/>')
    j.save()

    j = jcard('weathertruth', 'A bar graph with a guilty face whose axis has been stretched like elastic')
    j.add(f'<path d="M80 40 V170 H250" stroke="{INK}" stroke-width="3" fill="none"/><path d="M74 150 l12 -4 M74 158 l12 -4" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<rect x="110" y="140" width="40" height="30" fill="#9fb3c8" stroke="{INK}" stroke-width="2"/><rect x="180" y="50" width="40" height="120" fill="{ISO}" stroke="{INK}" stroke-width="2"/>')
    face(j, 200, 76, 14, 'sad')
    j.add(f'<path d="M60 60 q-10 20 0 40 q10 20 0 40" fill="none" stroke="{RED}" stroke-width="3"/>')
    j.save()


if __name__ == '__main__':
    for o in [(62, 11, 1, 5, 'Bar graphs', 'How high is each bar?', ['125 MM', 'IN JAN!']),
              (63, 11, 2, 5, 'Line graphs', 'Join the dots - when it makes sense.', ['UP, UP,', 'DOWN']),
              (64, 11, 3, 5, 'Histograms', 'Bars that touch, for grouped data.', ['NO', 'GAPS!']),
              (65, 11, 4, 5, 'Pie charts', 'Slices of a whole.', ['HALF', 'SUNNY']),
              (66, 11, 5, 5, 'What the graph really says', 'Check the axis first.', ['STARTS', 'AT 20?!'])]:
        opener(*o)
    station(); pie(); misleading()
    bar_chart('rainyear', 'Bar graph of the rainfall at the school each month: Jan 125 mm, Feb 90, Mar 80, Apr 50, May 15, Jun 5, Jul 5, Aug 5, Sep 25, Oct 70, Nov 110, Dec 120',
              MONTHS, RAIN, 140, 5, 'Monthly rainfall at the school last year', 'Rainfall (mm)', 'Month', every=4)
    plot('tempweek', 'Broken-line graph of the daily maximum temperature from 1 to 14 October: 24, 26, 27, 22, 19, 21, 25, 28, 29, 30, 26, 23, 24 and 27 degrees',
         (0, 14, 1), (16, 32, 1), 'Day in October', 'Maximum temperature (°C)', 'Daily maximum temperature, 1-14 October',
         [('line', list(zip(range(1, 15), TEMPS)), ISO), ('dots', list(zip(range(1, 15), TEMPS)), DEEP)], w=600, h=360, yevery=2)
    d_jobdone11()
    jokes11()
