"""Batch 8 (Games Night) art for the Grade 10 Maths Literacy course.

Theme A: paper-cut dice and spinners - layered paper with soft drop shadows
on teal, like a pop-up card. The spinners, the probability scale and the tree
diagram are exact (equal sections are equal; the tree lists every outcome).
Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch8.py
"""
import math, os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, SIGN, INK, RED, BLUE, WHITE, NUM, HAND, MARKER
from make_jokes import jcard, face

NAVY_INK = '#14213d'
TEAL, CREAM, CORAL, SUN, MINT, SEA = '#2d6a63', '#f4efe6', '#ff8c69', '#ffd166', '#06d6a0', '#118ab2'
COLOURS = {'Red': CORAL, 'Yellow': SUN, 'Green': MINT, 'Blue': SEA}
SHADOW = '<defs><filter id="pc8" x="-10%" y="-10%" width="130%" height="130%"><feDropShadow dx="2" dy="3" stdDeviation="1.6" flood-opacity=".3"/></filter></defs>'


def paper(name, w, h, label):
    svg = Svg(name, w, h, label, bg=TEAL, rx=8)
    svg.add(SHADOW)
    return svg


def spinner(svg, cx, cy, r, sections, pointer=30, labels=True):
    """Equal sections, clockwise from the top; a pointer at `pointer` degrees from the top."""
    svg.add(f'<g filter="url(#pc8)"><circle cx="{cx}" cy="{cy}" r="{r + 8}" fill="{CREAM}"/></g>')
    n = len(sections)
    for i, s in enumerate(sections):
        a0, a1 = -90 + i * 360 / n, -90 + (i + 1) * 360 / n
        p = lambda a: (cx + r * math.cos(math.radians(a)), cy + r * math.sin(math.radians(a)))
        (x0, y0), (x1, y1) = p(a0), p(a1)
        svg.add(f'<path d="M{cx} {cy} L{x0:.1f} {y0:.1f} A{r} {r} 0 0 1 {x1:.1f} {y1:.1f} Z" fill="{COLOURS[s]}" stroke="{CREAM}" stroke-width="3"/>')
        if labels:
            am = math.radians((a0 + a1) / 2)
            svg.text(round(cx + r * .62 * math.cos(am), 1), round(cy + r * .62 * math.sin(am) + 5, 1), s.upper(), max(10, r // 7), INK, 'middle', 800, NUM)
    a = math.radians(pointer - 90)
    svg.add(f'<path d="M{cx} {cy} L{cx + r * .8 * math.cos(a):.1f} {cy + r * .8 * math.sin(a):.1f}" stroke="#222" stroke-width="5" stroke-linecap="round"/>'
            f'<circle cx="{cx}" cy="{cy}" r="8" fill="#222"/>')


def die(svg, x, y, s, n, rot=0):
    spots = {1: [(0, 0)], 2: [(-1, -1), (1, 1)], 3: [(-1, -1), (0, 0), (1, 1)], 4: [(-1, -1), (1, -1), (-1, 1), (1, 1)],
             5: [(-1, -1), (1, -1), (0, 0), (-1, 1), (1, 1)], 6: [(-1, -1), (1, -1), (-1, 0), (1, 0), (-1, 1), (1, 1)]}[n]
    svg.add(f'<g filter="url(#pc8)" transform="rotate({rot} {x + s / 2} {y + s / 2})"><rect x="{x}" y="{y}" width="{s}" height="{s}" rx="{s * .16}" fill="{WHITE}"/>'
            + ''.join(f'<circle cx="{x + s / 2 + dx * s * .26}" cy="{y + s / 2 + dy * s * .26}" r="{s * .08}" fill="#222"/>' for dx, dy in spots) + '</g>')


def prob_scale():
    w, h = 620, 230
    svg = paper('probscale', w, h, 'The probability scale from 0 to 1: impossible at 0, unlikely, even chance at one half, likely, certain at 1, with the same points as fractions, decimals and percentages')
    x0, x1, y = 50, 570, 110
    svg.add(f'<g filter="url(#pc8)"><rect x="{x0 - 20}" y="{y - 26}" width="{x1 - x0 + 40}" height="52" rx="6" fill="{CREAM}"/></g>')
    svg.add(f'<defs><linearGradient id="pcg8"><stop offset="0" stop-color="{SEA}"/><stop offset=".5" stop-color="{SUN}"/><stop offset="1" stop-color="{CORAL}"/></linearGradient></defs>'
            f'<rect x="{x0}" y="{y - 8}" width="{x1 - x0}" height="16" rx="8" fill="url(#pcg8)"/>')
    svg.text(w / 2, 40, 'THE PROBABILITY SCALE', 18, WHITE, 'middle', 800, NUM)
    marks = [(0, 'impossible', '0', '0%'), (.25, 'unlikely', '¼ = 0,25', '25%'), (.5, 'even chance', '½ = 0,5', '50%'),
             (.75, 'likely', '¾ = 0,75', '75%'), (1, 'certain', '1', '100%')]
    for p, word, num, pct in marks:
        x = x0 + p * (x1 - x0)
        svg.add(f'<path d="M{x} {y - 18} V{y + 18}" stroke="{INK}" stroke-width="3"/>')
        svg.text(x, y - 34, word, 14, WHITE, 'middle', 700, NUM)
        svg.text(x, y + 44, num, 14, WHITE, 'middle', 800, NUM)
        svg.text(x, y + 64, pct, 13, SUN, 'middle', 700, NUM)
    svg.text(w / 2, 214, 'Every probability is somewhere from 0 to 1 - never below, never above.', 13, CREAM, 'middle', 600, NUM)
    svg.save()


def forecast():
    w, h = 560, 230
    svg = paper('forecast', w, h, 'A weather app for the weekend: Friday 20% chance of rain, Saturday 70%, Sunday 10%')
    svg.text(w / 2, 34, 'WEEKEND FORECAST - JOBURG', 16, WHITE, 'middle', 800, NUM)
    for i, (day, pct, rain) in enumerate([('FRI', 20, False), ('SAT', 70, True), ('SUN', 10, False)]):
        x = 30 + i * 172
        svg.add(f'<g filter="url(#pc8)"><rect x="{x}" y="54" width="150" height="156" rx="10" fill="{CREAM}"/></g>')
        svg.text(x + 75, 82, day, 18, INK, 'middle', 800, NUM)
        cx, cy = x + 75, 122
        if rain:
            svg.add(f'<path d="M{cx - 34} {cy + 10} a16 16 0 0 1 10 -28 a22 22 0 0 1 40 -4 a16 16 0 0 1 18 32 z" fill="#9fb3c8"/>'
                    + ''.join(f'<path d="M{cx - 20 + k * 16} {cy + 18} l-5 12" stroke="{SEA}" stroke-width="4" stroke-linecap="round"/>' for k in range(4)))
        else:
            svg.add(f'<circle cx="{cx - 6}" cy="{cy - 4}" r="20" fill="{SUN}"/><path d="M{cx - 14} {cy + 14} a12 12 0 0 1 8 -20 a16 16 0 0 1 30 -2 a12 12 0 0 1 12 22 z" fill="{WHITE}" stroke="#d8dee6"/>')
        svg.text(x + 75, 182, f'{pct}%', 24, SEA if rain else INK, 'middle', 800, NUM)
        svg.text(x + 75, 200, 'chance of rain', 11, INK, 'middle', 600, NUM)
    svg.save()


def spinner_fig(name, sections, label, title):
    w, h = 300, 300
    svg = paper(name, w, h, label)
    svg.text(w / 2, 30, title, 15, WHITE, 'middle', 800, NUM)
    spinner(svg, w / 2, 164, 104, sections)
    svg.save()


def tree():
    w, h = 620, 400
    svg = paper('tree', w, h, 'A tree diagram for tossing a coin and then spinning the four-colour spinner: heads or tails, then red, yellow, green or blue - eight outcomes')
    svg.add(f'<g filter="url(#pc8)"><rect x="16" y="16" width="{w - 32}" height="{h - 32}" rx="10" fill="{CREAM}"/></g>')
    svg.text(40, 48, 'COIN', 13, INK, 'start', 800, NUM)
    svg.text(250, 48, 'SPINNER', 13, INK, 'start', 800, NUM)
    svg.text(450, 48, 'OUTCOME', 13, INK, 'start', 800, NUM)
    sx, sy = 46, 200
    for i, (coin, short) in enumerate([('Heads', 'H'), ('Tails', 'T')]):
        cy = 120 + i * 160
        svg.add(f'<path d="M{sx} {sy} L180 {cy}" stroke="{INK}" stroke-width="2.5"/>')
        svg.add(f'<circle cx="200" cy="{cy}" r="22" fill="{SUN}" stroke="{INK}" stroke-width="2"/>')
        svg.text(200, cy + 5, short, 15, INK, 'middle', 800, NUM)
        svg.text(200, cy + 40, coin, 11, INK, 'middle', 600, NUM)
        for k, col in enumerate(['Red', 'Yellow', 'Green', 'Blue']):
            ty = cy - 54 + k * 36
            svg.add(f'<path d="M222 {cy} L330 {ty}" stroke="{INK}" stroke-width="2"/>')
            svg.add(f'<rect x="334" y="{ty - 12}" width="74" height="24" rx="12" fill="{COLOURS[col]}" stroke="{INK}" stroke-width="1.5"/>')
            svg.text(371, ty + 5, col, 12, INK, 'middle', 700, NUM)
            svg.text(460, ty + 5, f'{short}, {col}', 13, INK, 'start', 700, NUM)
    svg.add(f'<circle cx="{sx}" cy="{sy}" r="6" fill="{INK}"/>')
    svg.text(w / 2, h - 30, '2 coin results x 4 colours = 8 outcomes', 13, INK, 'middle', 700, NUM)
    svg.save()


def d_dice():
    svg = paper('dice', 300, 190, 'Two paper-cut dice tumbling: a five and a two')
    die(svg, 60, 50, 80, 5, -12)
    die(svg, 166, 70, 70, 2, 14)
    svg.save()


def d_jobdone8():
    svg = Svg('jobdone8', 320, 200, 'Hadi with a JOB DONE stamp after Games Night', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: June exams', 15, INK, 'middle', font=MARKER)
    svg.save()


def jokes8():
    j = jcard('gameslikely', 'A worried die sweating, with a big 7 drawn on a thought bubble')
    j.add(SHADOW)
    die(j, 100, 70, 90, 3)
    j.add(f'<circle cx="214" cy="48" r="28" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/><circle cx="192" cy="82" r="6" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    j.text(214, 60, '7', 30, RED, 'middle', 800, NUM)
    j.add(f'<path d="M96 76 q-8 12 0 18" stroke="{SEA}" stroke-width="4" fill="none" stroke-linecap="round"/>')
    j.save()

    j = jcard('gamesfair', 'A spinner on a weighing scale, the scale tipping to one side')
    j.add(SHADOW)
    j.add(f'<path d="M150 170 V110 M80 108 L220 92" stroke="{INK}" stroke-width="5" stroke-linecap="round"/><path d="M130 176 h40" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>')
    spinner(j, 96, 70, 30, ['Red', 'Yellow', 'Green', 'Blue'], 120, labels=False)
    j.add(f'<g filter="url(#pc8)"><rect x="194" y="60" width="44" height="30" rx="4" fill="{SUN}"/></g>')
    j.text(216, 81, '1 KG', 10, INK, 'middle')
    j.save()

    j = jcard('gamestree', 'A tree whose branches end in tiny dice instead of leaves')
    j.add(SHADOW)
    j.add(f'<path d="M150 180 V110 M150 130 L100 80 M150 120 L205 70 M150 110 L150 54 M100 80 L74 56 M205 70 L232 52" stroke="#7a5230" stroke-width="7" stroke-linecap="round" fill="none"/>')
    for (x, y, n) in [(56, 34, 1), (84, 62, 4), (132, 26, 6), (190, 48, 3), (218, 28, 5)]:
        die(j, x, y, 26, n)
    j.save()


def term2_assessment():
    opener(42, 8, 1, 2, 'Assignment workshop', 'Method, answer, unit - every time.', ['SHOW THE', 'WORKING!'], 'TERM 2 ASSESSMENT · 1 OF 2')
    opener(43, 8, 2, 2, 'June exam practice', 'Paper 1, Paper 2, no panic.', ['UNITS!', 'SQUAWK!'], 'TERM 2 ASSESSMENT · 2 OF 2')
    j = jcard('assign2', 'A gym contract with a face, sweating as it lifts a dumbbell')
    j.add(f'<rect x="110" y="40" width="80" height="104" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    for k in range(3):
        j.add(f'<path d="M122 {100 + k * 12} h56" stroke="#9aa5ad" stroke-width="2"/>')
    j.text(150, 60, 'CONTRACT', 11, NAVY_INK, 'middle')
    face(j, 150, 78, 12, 'flat')
    j.add(f'<path d="M110 74 L80 28 M190 74 L220 28" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>'
          f'<path d="M56 28 H244" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>'
          f'<rect x="44" y="12" width="14" height="32" rx="3" fill="{INK}"/><rect x="242" y="12" width="14" height="32" rx="3" fill="{INK}"/>')
    j.add(f'<path d="M196 84 q6 10 0 16" stroke="{SEA}" stroke-width="4" fill="none" stroke-linecap="round"/>')
    j.text(150, 170, '24 MONTHS', 13, RED, 'middle')
    j.save()


if __name__ == '__main__':
    for o in [(39, 8, 1, 3, 'How likely?', 'From impossible to certain.', ['70% CHANCE', 'OF RAIN?']),
              (40, 8, 2, 3, 'Fair or not?', 'Theory says one thing. Spin and see.', ['IS IT', 'RIGGED?']),
              (41, 8, 3, 3, 'All the outcomes', 'List them all before you judge.', ['H, RED', 'H, BLUE...'])]:
        opener(*o)
    prob_scale(); forecast(); tree()
    spinner_fig('spinner4', ['Red', 'Yellow', 'Green', 'Blue'], 'A spinner with four equal sections: red, yellow, green and blue', 'THE FOUR-COLOUR SPINNER')
    spinner_fig('spinner31', ['Red', 'Red', 'Red', 'Blue'], 'A spinner with four equal sections: three red and one blue', "LWAZI'S SPINNER")
    d_dice(); d_jobdone8()
    jokes8()
    term2_assessment()
