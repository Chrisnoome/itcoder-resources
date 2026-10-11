"""Batch 9 (The Trip Fund) art for the Grade 10 Maths Literacy course.

Theme A: travel posters and stamps - flat sunset bands, mountain silhouettes
and outlined passport-style stamps. Documents (the till slip) stay plain and
realistic, like batch 4's: Ubuntu Foods, VAT at 15%, zero-rated items
marked Z. Writes AIPascalCourse/public/assets/doodles/mlit10-*.svg.

  python -X utf8 tools/mlit10/make_batch9.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, opener, hadi, SIGN, INK, RED, BLUE, WHITE, NUM, MARKER, PAPER, DOCINK, DOCGREY, DOCLINE, MONO, row, hline
from make_jokes import jcard, face

BANDS = ['#ffb26b', '#ff7b54', '#d1495b', '#6a2c70']
NIGHT, SUNDISC, SEA = '#2b2d42', '#ffe6a7', '#3a86a8'


def poster(name, w, h, label):
    svg = Svg(name, w, h, label, rx=8)
    bh = h / len(BANDS)
    for i, c in enumerate(BANDS):
        svg.add(f'<rect y="{i * bh}" width="{w}" height="{bh + 1}" fill="{c}"/>')
    return svg


def stamp(svg, x, y, w, h, lines, rot=-8, colour=WHITE, size=11):
    svg.add(f'<g transform="rotate({rot} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" rx="5" fill="none" stroke="{colour}" stroke-width="2.5"/>'
            f'<rect x="{x + 4}" y="{y + 4}" width="{w - 8}" height="{h - 8}" rx="3" fill="none" stroke="{colour}" stroke-width="1"/>')
    for i, t in enumerate(lines):
        svg.text(x + w / 2, y + h / 2 + (i - (len(lines) - 1) / 2) * (size + 4) + size * .35, t, size, colour, 'middle', 700, MONO)
    svg.add('</g>')


def trip_poster():
    w, h = 560, 320
    svg = poster('tripposter', w, h, 'A travel poster for the Grade 10 coast trip to Durban in September: a sunset over the sea, mountains, and a stamp showing the target of R52 800')
    svg.add(f'<circle cx="400" cy="150" r="54" fill="{SUNDISC}"/>')
    svg.add(f'<path d="M0 320 V196 L70 150 L130 190 L190 136 L260 196 L320 170 L360 200 V320 Z" fill="{NIGHT}"/>')
    svg.add(f'<path d="M330 214 H560 V320 H330 Z" fill="{SEA}"/>'
            + ''.join(f'<path d="M{350 + k * 44} {236 + (k % 2) * 22} q11 -7 22 0" stroke="{WHITE}" stroke-width="2.5" fill="none" stroke-linecap="round"/>' for k in range(5)))
    svg.text(28, 52, 'SEE THE COAST', 30, WHITE, 'start', 400)
    svg.text(28, 82, 'GRADE 10 TRIP · DURBAN · SEPTEMBER', 14, WHITE, 'start', 700, NUM)
    stamp(svg, 396, 26, 144, 64, ['TARGET', 'R52 800'], -10, size=15)
    stamp(svg, 30, 230, 170, 64, ['30 LEARNERS', '3 DAYS'], 6, size=15)
    svg.save()


def d_stamps():
    svg = poster('tripstamps', 300, 190, 'Passport-style stamps on a sunset: PAID, SAVED and CIVVIES DAY')
    stamp(svg, 18, 22, 120, 54, ['PAID', 'R150'], -10)
    stamp(svg, 156, 40, 126, 54, ['SAVED', 'R4 800'], 8)
    stamp(svg, 60, 110, 170, 54, ['CIVVIES DAY', 'R10'], -4)
    svg.save()


def trip_receipt():
    svg = Svg('tripreceipt', 300, 480, 'Ubuntu Foods till slip for the bus snacks: six lines, three zero-rated, total R484,83, VAT included R42,51', bg='#f3f4f5', rx=4)
    teeth = ''.join(f' L{280 - 10 * (k + 1)} {454 + (12 if k % 2 == 0 else 0)}' for k in range(26))
    svg.add(f'<path d="M20 10 H280 V454{teeth} L20 10 Z" fill="{PAPER}" stroke="{DOCLINE}"/>')
    svg.text(150, 44, 'UBUNTU FOODS', 18, DOCINK, 'middle', 700, MONO)
    svg.text(150, 62, 'Mzansi Plaza  VAT no. 4120 3355 18', 10, DOCGREY, 'middle', 400, MONO)
    svg.text(150, 78, 'TAX INVOICE', 11, DOCINK, 'middle', 600, MONO)
    hline(svg, 34, 266, 90, True, DOCINK)
    items = [('BROWN BREAD 700G X3', '59,97 Z'), ('APPLES 1,5KG', '32,99 Z'), ('FRESH MILK 2L X2', '65,98 Z'),
             ('CHIPS 120G X6', '95,94'), ('COLD DRINK 2L X4', '99,96'), ('SUNSCREEN SPF50', '129,99')]
    y = 112
    for a, b in items:
        row(svg, 34, 266, y, a, b, 11, font=MONO); y += 22
    hline(svg, 34, 266, y - 6, True, DOCINK)
    y += 14
    row(svg, 34, 266, y, 'TOTAL', 'R484,83', 14, True, MONO); y += 26
    row(svg, 34, 266, y, 'CARD - KHAYA BANK', '484,83', 11, font=MONO); y += 20
    row(svg, 34, 266, y, 'CHANGE', '0,00', 11, font=MONO); y += 30
    row(svg, 34, 266, y, 'ITEMS: 17', '', 11, font=MONO); y += 24
    row(svg, 34, 266, y, 'VAT INCLUDED @ 15%', '42,51', 11, font=MONO); y += 20
    row(svg, 34, 266, y, 'Z = ZERO-RATED (NO VAT)', '', 10, font=MONO, colour=DOCGREY); y += 30
    svg.text(150, y, '12 SEP  06:05  TILL 1', 10, DOCGREY, 'middle', 400, MONO); y += 24
    svg.text(150, y, 'THANK YOU - SALA KAHLE', 11, DOCINK, 'middle', 600, MONO)
    svg.save()


def d_growth():
    svg = poster('tripgrowth', 300, 190, 'Two stacks of coins growing year by year: simple interest adds the same each year, compound interest adds a little more each year')
    for k in range(4):
        for n in range(3 + k):
            svg.add(f'<ellipse cx="{40 + k * 32}" cy="{170 - n * 9}" rx="13" ry="4.5" fill="{SUNDISC}" stroke="{NIGHT}" stroke-width="1.5"/>')
    tops = [3, 4, 5, 7]
    for k, t in enumerate(tops):
        for n in range(t):
            svg.add(f'<ellipse cx="{170 + k * 32}" cy="{170 - n * 9}" rx="13" ry="4.5" fill="{SUNDISC}" stroke="{NIGHT}" stroke-width="1.5"/>')
    svg.text(88, 30, 'SIMPLE', 13, WHITE, 'middle', 700, MONO)
    svg.text(218, 30, 'COMPOUND', 13, WHITE, 'middle', 700, MONO)
    svg.save()


def d_jobdone9():
    svg = Svg('jobdone9', 320, 200, 'Hadi with a JOB DONE stamp after the Trip Fund', bg=SIGN, rx=8)
    svg.add(f'<rect x="6" y="6" width="308" height="188" rx="4" fill="none" stroke="{INK}" stroke-width="4"/>')
    svg.add(f'<g transform="rotate(-12 110 90)"><rect x="34" y="54" width="160" height="70" rx="6" fill="none" stroke="{RED}" stroke-width="5"/>'
            f'<rect x="42" y="62" width="144" height="54" rx="3" fill="none" stroke="{RED}" stroke-width="2"/></g>')
    svg.text(116, 90, 'JOB', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    svg.text(116, 114, 'DONE', 26, RED, 'middle', extra='transform="rotate(-12 110 90)"')
    hadi(svg, 196, 96, 1.05)
    svg.text(160, 186, 'next stop: Room Rescue', 15, INK, 'middle', font=MARKER)
    svg.save()


def coin(svg, x, y, r=16, mood='happy'):
    svg.add(f'<circle cx="{x}" cy="{y}" r="{r}" fill="{SUNDISC}" stroke="{INK}" stroke-width="2.5"/>')
    face(svg, x, y, r * .8, mood)


def jokes9():
    j = jcard('tripin', 'Coins with faces queueing to get into a jar labelled TRIP FUND')
    j.add(f'<path d="M206 60 h56 v12 q10 6 10 20 v66 q0 10 -10 10 h-56 q-10 0 -10 -10 v-66 q0 -14 10 -20z" fill="{WHITE}" stroke="{INK}" stroke-width="3"/>')
    j.text(234, 120, 'TRIP', 12, BLUE, 'middle'); j.text(234, 136, 'FUND', 12, BLUE, 'middle')
    for k in range(4):
        coin(j, 40 + k * 42, 150 - k * 14, 15)
    j.add(f'<path d="M190 70 q10 -20 26 -10" stroke="{INK}" stroke-width="2" fill="none" stroke-dasharray="4 3"/>')
    j.save()

    j = jcard('tripout', 'A wallet with a face, dragging a small suitcase, chased by a long receipt')
    j.add(f'<rect x="70" y="70" width="90" height="62" rx="8" fill="#8a5a3c" stroke="{INK}" stroke-width="3"/><path d="M70 92 H160" stroke="{INK}" stroke-width="2"/>')
    face(j, 115, 108, 16, 'sad')
    j.add(f'<rect x="174" y="100" width="40" height="32" rx="4" fill="{RED}" stroke="{INK}" stroke-width="2.5"/><path d="M186 100 v-8 h16 v8" fill="none" stroke="{INK}" stroke-width="2.5"/>')
    j.add(f'<path d="M20 60 v110 l8 -6 l8 6 l8 -6 l8 6 V60 z" fill="{WHITE}" stroke="{INK}" stroke-width="2"/>')
    for k in range(6):
        j.add(f'<path d="M26 {72 + k * 14} h24" stroke="#9aa5ad" stroke-width="2"/>')
    j.save()

    j = jcard('tripstatement', 'A statement with a face, balancing calmly on a seesaw')
    j.add(f'<path d="M60 150 L240 150" stroke="{INK}" stroke-width="6" stroke-linecap="round"/><path d="M150 150 L134 178 H166 Z" fill="{INK}"/>')
    j.add(f'<rect x="120" y="58" width="60" height="86" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/>')
    face(j, 150, 84, 14, 'happy')
    for k in range(3):
        j.add(f'<path d="M130 {110 + k * 10} h40" stroke="#9aa5ad" stroke-width="2"/>')
    j.text(150, 40, 'BALANCE', 14, BLUE, 'middle')
    j.save()

    j = jcard('tripbudget', 'A shopping trolley with a face, rolling over a dashed line marked LIMIT')
    j.add(f'<path d="M170 30 V176" stroke="{RED}" stroke-width="3" stroke-dasharray="8 6"/>')
    j.text(170, 22, 'LIMIT', 12, RED, 'middle')
    j.add(f'<path d="M80 70 h20 l14 60 h80 l14 -46 H108" fill="none" stroke="{INK}" stroke-width="4" stroke-linejoin="round"/>'
          f'<circle cx="124" cy="150" r="9" fill="{INK}"/><circle cx="186" cy="150" r="9" fill="{INK}"/>')
    face(j, 160, 104, 16, 'o')
    j.save()

    j = jcard('tripvat', 'A loaf of brown bread in sunglasses, relaxed, beside a packet of chips with a VAT sticker')
    j.add(f'<path d="M50 150 V100 q0 -36 50 -36 q50 0 50 36 V150 Z" fill="#a8743f" stroke="{INK}" stroke-width="3"/>')
    j.add(f'<path d="M72 98 h22 v10 h-22z M106 98 h22 v10 h-22z M94 102 h12" fill="{INK}" stroke="{INK}" stroke-width="2"/>')
    j.add(f'<path d="M84 124 q16 10 32 0" stroke="{INK}" stroke-width="2.5" fill="none" stroke-linecap="round"/>')
    j.add(f'<path d="M186 60 l60 -6 l6 104 l-60 6 z" fill="{RED}" stroke="{INK}" stroke-width="3"/>')
    face(j, 218, 104, 14, 'sad')
    j.add(f'<rect x="196" y="130" width="44" height="18" rx="3" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>')
    j.text(218, 144, '+15%', 10, INK, 'middle')
    j.text(100, 176, 'ZERO-RATED', 11, BLUE, 'middle')
    j.save()

    j = jcard('tripsimple', 'A coin with a face, lying back in a hammock')
    j.add(f'<path d="M40 50 V170 M260 50 V170" stroke="#7a5230" stroke-width="7" stroke-linecap="round"/>'
          f'<path d="M40 70 Q150 150 260 70" stroke="{INK}" stroke-width="3" fill="#7bc96f"/>')
    coin(j, 150, 92, 20, 'happy')
    j.text(214, 40, 'Zzz', 18, BLUE, 'middle')
    j.save()

    j = jcard('tripcompound', 'Stacks of coins growing taller step by step, the tallest wearing a medal')
    for k in range(5):
        for n in range(2 + k * k // 3 + k):
            j.add(f'<ellipse cx="{50 + k * 48}" cy="{172 - n * 9}" rx="16" ry="5" fill="{SUNDISC}" stroke="{INK}" stroke-width="1.5"/>')
    j.add(f'<path d="M242 64 l-10 -24 M242 64 l10 -24" stroke="{BLUE}" stroke-width="5"/><circle cx="242" cy="74" r="11" fill="{SUNDISC}" stroke="{INK}" stroke-width="2.5"/>')
    j.save()

    j = jcard('tripbank', 'A cracked piggy bank with a plaster, looking a bit broke')
    j.add(f'<ellipse cx="150" cy="110" rx="78" ry="52" fill="#ff9fb2" stroke="{INK}" stroke-width="3"/>'
          f'<ellipse cx="226" cy="108" rx="14" ry="18" fill="#ff8aa1" stroke="{INK}" stroke-width="2.5"/>'
          f'<path d="M110 160 v18 M190 160 v18" stroke="{INK}" stroke-width="7" stroke-linecap="round"/>'
          f'<path d="M126 60 h40" stroke="{INK}" stroke-width="5" stroke-linecap="round"/>'
          f'<path d="M96 84 l14 18 l-10 14 l16 20" stroke="{INK}" stroke-width="2.5" fill="none"/>')
    j.add('<rect x="84" y="96" width="34" height="13" rx="5" fill="#f2c79a" transform="rotate(-35 101 102)"/>')
    face(j, 186, 100, 16, 'sad')
    j.save()


if __name__ == '__main__':
    for o in [(44, 9, 1, 8, 'Money in', 'Where the money comes from.', ['R150 A', 'MONTH!']),
              (45, 9, 2, 8, 'Money out', 'Fixed, variable, occasional.', ['BUS:', 'R14 400']),
              (46, 9, 3, 8, 'Income and expenditure', 'In minus out: surplus or loss?', ['PROFIT', 'OR LOSS?']),
              (47, 9, 4, 8, 'Make a budget', 'The plan, then the truth.', ['OVER', 'BUDGET?']),
              (48, 9, 5, 8, 'VAT on the receipts', 'Fifteen percent - of what?', ['Z MEANS', 'NO VAT']),
              (49, 9, 6, 8, 'Interest rate vs interest', 'A percent per year, paid in rand.', ['6% OF', 'WHAT?']),
              (50, 9, 7, 8, 'Interest on interest', 'Money that grows on its growth.', ['YEAR BY', 'YEAR']),
              (51, 9, 8, 8, 'Which account?', 'Interest, access and fees.', ["TREASURER'S", 'REPORT'])]:
        opener(*o)
    trip_poster(); d_stamps(); trip_receipt(); d_growth(); d_jobdone9()
    jokes9()
