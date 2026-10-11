"""The Grade 10 Maths Literacy course's joke drawings (brand/mlit10-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle: a small
sign-painter cartoon of the joke, with the joke itself as the caption. Uses
the pieces in make_art.py. Writes AIPascalCourse/public/assets/doodles/
mlit10-joke-<lessonId>.svg.

  python -X utf8 tools/mlit10/make_jokes.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, hadi, car, bubbles, SIGN, INK, RED, BLUE, WHITE, NUM


def jcard(name, label):
    svg = Svg('joke-' + name, 300, 190, label, bg=SIGN, rx=8)
    svg.add(f'<rect x="5" y="5" width="290" height="180" rx="4" fill="none" stroke="{INK}" stroke-width="3"/>')
    return svg


def face(svg, cx, cy, r=10, mood='happy'):
    svg.add(f'<circle cx="{cx - r * .35}" cy="{cy - r * .15}" r="{r * .12}" fill="{INK}"/><circle cx="{cx + r * .35}" cy="{cy - r * .15}" r="{r * .12}" fill="{INK}"/>')
    paths = {'happy': f'M{cx - r * .4} {cy + r * .25} Q{cx} {cy + r * .65} {cx + r * .4} {cy + r * .25}',
             'sad':   f'M{cx - r * .4} {cy + r * .5} Q{cx} {cy + r * .15} {cx + r * .4} {cy + r * .5}',
             'flat':  f'M{cx - r * .35} {cy + r * .4} H{cx + r * .35}'}
    if mood in paths:
        svg.add(f'<path d="{paths[mood]}" fill="none" stroke="{INK}" stroke-width="2" stroke-linecap="round"/>')
    else:
        svg.add(f'<circle cx="{cx}" cy="{cy + r * .4}" r="{r * .18}" fill="{INK}"/>')


def kota(svg, x, y, s=1.0):
    svg.add(f'<g transform="translate({x} {y}) scale({s})"><path d="M0 40 Q0 0 30 0 H70 Q80 0 80 12 V40 Z" fill="#e8b46a" stroke="{INK}" stroke-width="2.5"/>'
            + ''.join(f'<rect x="{10 + k * 9}" y="{-14 + (k % 3) * 4}" width="6" height="22" fill="#ffd84d" stroke="{INK}" stroke-width="1.5"/>' for k in range(7))
            + f'<path d="M6 14 H76" stroke="#c8102e" stroke-width="5"/></g>')


def person(svg, x, y, rot=0):
    svg.add(f'<g stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round" transform="rotate({rot} {x} {y})"><circle cx="{x}" cy="{y}" r="10"/>'
            f'<path d="M{x} {y + 10} v30 M{x} {y + 20} l-14 8 M{x} {y + 20} l14 8 M{x} {y + 40} l-10 20 M{x} {y + 40} l10 20"/></g>')


def jokes():
    j = jcard('priceboard', 'A stuffed kota, chips sticking out, refusing to step into a pot of stew')
    kota(j, 40, 80, 1.2)
    j.add(f'<path d="M190 100 h70 v50 q0 14 -14 14 h-42 q-14 0 -14 -14z" fill="{RED}" stroke="{INK}" stroke-width="2.5"/><path d="M180 100 h90" stroke="{INK}" stroke-width="4"/>')
    j.text(226, 90, 'STEW', 14, INK, 'middle')
    j.text(140, 40, 'NO THANKS!', 14, BLUE, 'middle')
    face(j, 88, 112, 11, 'flat')
    j.save()

    j = jcard('cashup', 'A calm calculator meditating with its eyes closed')
    j.add(f'<rect x="110" y="34" width="80" height="120" rx="10" fill="{BLUE}" stroke="{INK}" stroke-width="3"/><rect x="122" y="46" width="56" height="26" fill="#cfefff" stroke="{INK}" stroke-width="2"/>')
    j.text(150, 66, '1+1=2', 12, INK, 'middle', 600, NUM)
    for r in range(3):
        for c in range(3):
            j.add(f'<rect x="{124 + c * 18}" y="{84 + r * 20}" width="14" height="14" rx="3" fill="{WHITE}"/>')
    j.add(f'<path d="M126 26 q8 -6 16 0 M158 26 q8 -6 16 0" stroke="{INK}" stroke-width="2" fill="none"/>')
    j.text(150, 178, 'ZEN', 14, RED, 'middle')
    j.save()

    j = jcard('halfaloaf', 'A half loaf and a quarter loaf with faces, a heart between them')
    j.add(f'<path d="M40 140 Q40 70 100 70 H130 V140 Z" fill="#e8b46a" stroke="{INK}" stroke-width="3"/><path d="M190 140 Q190 100 220 100 H250 V140 Z" fill="#e8b46a" stroke="{INK}" stroke-width="3"/>')
    face(j, 92, 108, 16)
    face(j, 224, 122, 11)
    j.add(f'<path d="M160 92 c-10 -14 -28 0 0 20 c28 -20 10 -34 0 -20z" fill="{RED}"/>')
    j.text(85, 166, '½', 18, INK, 'middle')
    j.text(220, 166, '¼', 18, INK, 'middle')
    j.save()

    j = jcard('rounding', 'Hadi flying high over the top of a hill')
    j.add(f'<path d="M10 180 Q150 40 290 180 Z" fill="#7bc96f" stroke="{INK}" stroke-width="3"/>')
    hadi(j, 110, 22, 1.0, 'fly')
    j.add(f'<path d="M80 70 q20 -30 60 -40" stroke="{INK}" stroke-width="2" stroke-dasharray="4 4" fill="none"/>')
    j.text(240, 60, 'UP!', 20, RED, 'middle')
    j.save()

    j = jcard('ratio', 'A tomato sauce bottle blushing at a salad dressing bottle')
    for x, col, lab in [(70, RED, 'SAUCE'), (190, '#f4eccf', 'DRESSING')]:
        j.add(f'<path d="M{x - 10} 40 h20 v16 q16 8 16 26 v66 q0 10 -10 10 h-32 q-10 0 -10 -10 v-66 q0 -18 16 -26z" fill="{col}" stroke="{INK}" stroke-width="3"/>')
        j.text(x, 176, lab, 10, INK, 'middle')
    face(j, 70, 110, 14)
    j.add('<circle cx="58" cy="116" r="5" fill="#ff8fa3"/><circle cx="82" cy="116" r="5" fill="#ff8fa3"/>')
    face(j, 190, 110, 14, 'o')
    j.text(128, 70, '!', 30, RED, 'middle')
    j.save()

    j = jcard('proportion', 'Many hands lifting one light feather')
    j.add(f'<path d="M150 50 q50 10 60 50 q-50 -10 -60 -50z" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/><path d="M150 50 L210 100" stroke="{INK}" stroke-width="1.5"/>')
    for k in range(6):
        x = 60 + k * 36
        j.add(f'<path d="M{x} 180 V140 M{x - 8} 140 h16 v-12 h-16z" stroke="{INK}" stroke-width="3" fill="#e8b46a"/>')
    j.text(150, 30, 'LIGHT WORK', 14, BLUE, 'middle')
    j.save()

    j = jcard('rates', 'Hadi at a till with a price tag that says R2 per squawk')
    hadi(j, 30, 70, 1.1, 'shout')
    j.add(f'<g transform="rotate(6 220 90)"><rect x="160" y="60" width="120" height="56" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/></g>')
    j.text(220, 86, 'R2 PER', 14, RED, 'middle')
    j.text(220, 106, 'SQUAWK', 14, RED, 'middle')
    j.save()

    j = jcard('percentages', 'A kota with a 10 percent slice cut out of it')
    kota(j, 60, 80, 1.5)
    j.add(f'<path d="M150 80 l26 0 l0 60 l-26 0z" fill="{SIGN}" stroke="{INK}" stroke-width="2" stroke-dasharray="4 3"/>')
    j.text(232, 70, '-10%', 22, RED, 'middle')
    j.save()

    j = jcard('washthree', 'A muddy car giving a dirty look')
    car(j, 100, 80, '#9a7b5a', 1.5)
    for x, y in [(118, 112), (160, 104), (190, 118)]:
        j.add(f'<circle cx="{x}" cy="{y}" r="6" fill="#5d3b20"/>')
    j.add(f'<path d="M132 92 l14 6 M182 92 l-14 6" stroke="{INK}" stroke-width="3"/>')
    j.text(150, 40, 'GRRR', 16, RED, 'middle')
    j.save()

    j = jcard('washtable', 'A small block labelled dependent leaning on a big block labelled independent')
    j.add(f'<rect x="150" y="50" width="110" height="110" fill="{BLUE}" stroke="{INK}" stroke-width="3"/><g transform="rotate(-14 110 120)"><rect x="70" y="90" width="70" height="70" fill="{RED}" stroke="{INK}" stroke-width="3"/></g>')
    j.text(205, 140, 'INDEPENDENT', 10, WHITE, 'middle')
    j.text(104, 146, 'DEPENDENT', 9, WHITE, 'middle', extra='transform="rotate(-14 110 120)"')
    face(j, 205, 92, 14)
    face(j, 102, 116, 11)
    j.save()

    j = jcard('washgraph', 'A dotted graph line leading like a story map to a treasure X')
    j.add(f'<path d="M40 160 H270 M40 160 V30" stroke="{INK}" stroke-width="3"/>')
    pts = [(60, 140), (100, 110), (140, 120), (180, 80), (220, 70)]
    j.add('<path d="M' + ' L'.join(f'{a} {b}' for a, b in pts) + f'" stroke="{BLUE}" stroke-width="2.5" stroke-dasharray="5 4" fill="none"/>')
    for a, b in pts:
        j.add(f'<circle cx="{a}" cy="{b}" r="5" fill="{BLUE}"/>')
    j.text(246, 76, 'X', 24, RED, 'middle')
    j.text(150, 180, 'THE PLOT', 12, INK, 'middle')
    j.save()

    j = jcard('washread', 'A worried up-and-down line graph lying on a couch')
    j.add(f'<path d="M50 150 h200 v16 h-200z M50 150 v-24" fill="#c97a3a" stroke="{INK}" stroke-width="2.5"/>')
    j.add(f'<path d="M60 120 L90 60 L120 110 L150 50 L180 120 L210 70 L240 110" stroke="{RED}" stroke-width="4" fill="none"/>')
    face(j, 150, 34, 12, 'sad')
    j.save()

    j = jcard('washstory', 'A car-wash bucket washed up on a beach')
    j.add('<path d="M0 140 Q75 120 150 140 T300 140 V185 H0Z" fill="#8fd3ff"/><path d="M0 160 H300 V185 H0Z" fill="#e8d3a2"/>')
    j.add(f'<g transform="rotate(-25 150 130)"><path d="M126 110 h48 l-6 40 h-36z" fill="{RED}" stroke="{INK}" stroke-width="3"/></g>')
    j.text(150, 50, 'WASHED UP', 16, BLUE, 'middle')
    bubbles(j, [(200, 90, 8), (220, 70, 5)])
    j.save()

    j = jcard('radioask', 'A big question mark pushing a person: a leading question')
    j.text(100, 150, '?', 110, RED, 'middle')
    person(j, 220, 90, 20)
    j.add(f'<path d="M150 110 h30 M172 102 l10 8 l-10 8" stroke="{INK}" stroke-width="4" fill="none"/>')
    j.save()

    j = jcard('radiocollect', 'Five identical smiling faces all saying YES: a biased sample')
    for k in range(5):
        x = 40 + k * 55
        j.add(f'<circle cx="{x}" cy="110" r="20" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
        face(j, x, 110, 18)
        j.text(x, 76, 'YES', 12, BLUE, 'middle')
    j.text(150, 170, 'ALL MY FRIENDS', 13, RED, 'middle')
    j.save()

    j = jcard('radiosort', 'A frequency table wearing a party hat, with confetti')
    j.add(f'<rect x="90" y="70" width="120" height="100" fill="{WHITE}" stroke="{INK}" stroke-width="3"/><path d="M150 70 V170 M90 103 H210 M90 136 H210" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<path d="M130 70 L150 20 L170 70z" fill="{RED}" stroke="{INK}" stroke-width="2.5"/><circle cx="150" cy="20" r="6" fill="{BLUE}"/>')
    for x, y, c in [(60, 40, BLUE), (240, 50, RED), (250, 120, BLUE), (50, 130, RED)]:
        j.add(f'<rect x="{x}" y="{y}" width="8" height="8" fill="{c}" transform="rotate(30 {x} {y})"/>')
    j.save()

    j = jcard('radiomiddle', 'The mean shared out like a cake cut into equal slices')
    j.add(f'<path d="M60 100 v30 M240 100 v30" stroke="{INK}" stroke-width="3"/><ellipse cx="150" cy="130" rx="90" ry="26" fill="#e8b46a" stroke="{INK}" stroke-width="3"/><ellipse cx="150" cy="100" rx="90" ry="26" fill="#ffe1e8" stroke="{INK}" stroke-width="3"/>')
    for a in (-50, 0, 50):
        j.add(f'<path d="M150 100 L{150 + a * 1.6} 78" stroke="{INK}" stroke-width="2"/>')
    j.text(150, 50, 'SHARE IT EQUALLY', 12, BLUE, 'middle')
    j.save()

    j = jcard('radiotruth', 'The median standing calmly between two arguing values')
    for x, mood, fill in [(60, 'sad', '#ffd0c8'), (150, 'happy', WHITE), (240, 'sad', '#ffd0c8')]:
        j.add(f'<circle cx="{x}" cy="100" r="22" fill="{fill}" stroke="{INK}" stroke-width="2.5"/>')
        face(j, x, 100, 20, mood)
    j.text(60, 150, '15', 16, INK, 'middle')
    j.text(150, 150, '45', 16, BLUE, 'middle')
    j.text(240, 150, '240', 16, INK, 'middle')
    j.text(100, 60, '!!', 18, RED, 'middle')
    j.text(200, 60, '!!', 18, RED, 'middle')
    j.save()

    j = jcard('invest1', 'A magnifying glass with a plaster and a long list of limitations')
    j.add(f'<circle cx="120" cy="90" r="40" fill="#ffffff" fill-opacity=".5" stroke="{INK}" stroke-width="5"/><path d="M148 118 L190 160" stroke="{INK}" stroke-width="9" stroke-linecap="round"/>')
    j.add('<rect x="96" y="56" width="22" height="10" rx="4" fill="#f2c79a" transform="rotate(-30 107 61)"/>')
    j.add(f'<rect x="200" y="40" width="70" height="90" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    for k in range(4):
        j.add(f'<path d="M208 {58 + k * 18} h54" stroke="#9aa5ad" stroke-width="2"/>')
    j.text(235, 32, 'LIMITS', 11, RED, 'middle')
    face(j, 120, 92, 18)
    j.save()

    j = jcard('gogobill', 'An electricity meter surrounded by little lightning-bolt friends')
    j.add(f'<rect x="110" y="50" width="80" height="100" rx="8" fill="{WHITE}" stroke="{INK}" stroke-width="3"/><rect x="120" y="64" width="60" height="22" fill="#e8e8e8" stroke="{INK}"/>')
    j.text(150, 80, '48 791', 12, INK, 'middle', 600, NUM)
    face(j, 150, 116, 16)
    for x, y in [(60, 70), (60, 130), (240, 70), (240, 130), (150, 34)]:
        j.add(f'<path d="M{x} {y - 14} l-8 14 h8 l-6 14 l16 -18 h-8 l6 -10z" fill="{SIGN}" stroke="{INK}" stroke-width="2"/>')
    j.save()

    j = jcard('gogoslips', 'A till slip wearing a tie behind a bank counter, next to a pile of coins')
    j.add(f'<path d="M120 30 h60 v110 l-6 6 -6 -6 -6 6 -6 -6 -6 6 -6 -6 -6 6 -6 -6 -6 6z" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    face(j, 150, 64, 14)
    j.add(f'<path d="M150 82 l-8 8 l8 30 l8 -30z" fill="{RED}" stroke="{INK}" stroke-width="1.5"/>')
    j.add(f'<rect x="40" y="140" width="220" height="20" fill="#8a5a32" stroke="{INK}" stroke-width="2"/>')
    for k in range(4):
        j.add(f'<ellipse cx="226" cy="{132 - k * 6}" rx="16" ry="5" fill="#e0b84a" stroke="#9a7a1a"/>')
    j.save()

    j = jcard('gogobank', 'A bank statement balancing on a beam with its arms out')
    j.add('<path d="M30 150 H270" stroke="#8a5a32" stroke-width="10"/><path d="M80 150 v24 M220 150 v24" stroke="#8a5a32" stroke-width="6"/>')
    j.add(f'<g transform="rotate(8 150 90)"><rect x="120" y="40" width="60" height="100" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>'
          + ''.join(f'<path d="M128 {60 + k * 14} h44" stroke="#9aa5ad" stroke-width="2"/>' for k in range(5)) + '</g>')
    j.add(f'<path d="M120 90 L80 76 M180 98 L222 92" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    j.save()

    j = jcard('gogobudget', 'A budget sheet lifting a barbell at the gym')
    j.add(f'<rect x="120" y="60" width="60" height="80" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    face(j, 150, 90, 14)
    j.add(f'<path d="M70 50 H230" stroke="{INK}" stroke-width="5"/><rect x="56" y="34" width="14" height="32" fill="{INK}"/><rect x="230" y="34" width="14" height="32" fill="{INK}"/>')
    j.add(f'<path d="M120 80 L100 52 M180 80 L200 52 M135 140 v24 M165 140 v24" stroke="{INK}" stroke-width="3"/>')
    j.text(150, 180, 'BALANCE!', 13, RED, 'middle')
    j.save()

    j = jcard('planpower', 'A shocked lightning bolt looking at a price tag')
    j.add(f'<path d="M110 30 l-40 70 h36 l-24 70 l70 -90 h-36 l26 -50z" fill="{SIGN}" stroke="{INK}" stroke-width="3"/>')
    face(j, 106, 92, 14, 'o')
    j.add(f'<g transform="rotate(-8 225 90)"><rect x="180" y="66" width="90" height="44" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/></g>')
    j.text(225, 96, 'R3,40', 18, RED, 'middle')
    j.save()

    j = jcard('planphone', 'A phone wearing a graduation cap')
    j.add(f'<rect x="120" y="50" width="60" height="110" rx="10" fill="{INK}"/><rect x="126" y="62" width="48" height="84" rx="3" fill="#cfefff"/>')
    face(j, 150, 100, 16)
    j.add(f'<path d="M110 50 L150 34 L190 50 L150 66z" fill="{INK}"/><path d="M182 52 v20" stroke="{SIGN}" stroke-width="2"/>')
    j.text(150, 180, 'CELL-F ESTEEM', 13, BLUE, 'middle')
    j.save()

    j = jcard('plantaxi', 'A bus stopped at a road sign that says 10')
    j.add(f'<g transform="translate(40 90)"><rect x="0" y="0" width="140" height="56" rx="10" fill="{BLUE}" stroke="{INK}" stroke-width="3"/>'
          + ''.join(f'<rect x="{12 + k * 30}" y="10" width="22" height="18" fill="#cfefff" stroke="{INK}"/>' for k in range(4))
          + f'<circle cx="30" cy="58" r="9" fill="{INK}"/><circle cx="110" cy="58" r="9" fill="{INK}"/></g>')
    j.add(f'<path d="M240 160 V60" stroke="{INK}" stroke-width="4"/><circle cx="240" cy="60" r="30" fill="{WHITE}" stroke="{RED}" stroke-width="6"/>')
    j.text(240, 60, '10', 18, INK, 'middle')
    j.text(240, 76, 'KM', 10, INK, 'middle')
    j.save()

    j = jcard('plangraph', 'A tired stick figure climbing a step graph like stairs, sweating')
    j.add(f'<path d="M40 160 H100 V120 H160 V80 H220 V40 H270" stroke="{BLUE}" stroke-width="5" fill="none"/>')
    person(j, 190, 20)
    j.add('<path d="M204 16 q4 6 0 10" stroke="#1d4fd8" stroke-width="3" fill="none"/>')
    j.text(80, 60, 'PHEW', 16, RED, 'middle')
    j.save()


if __name__ == '__main__':
    jokes()
