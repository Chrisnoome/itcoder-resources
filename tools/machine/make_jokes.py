"""The Inside the machine course's joke drawings (brand/machine-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle in the circuit
city's colours - board green, copper, Volt's yellow, Oswald labels - with the
parts acting the joke out, and the joke itself as the caption. Uses the pieces
in make_art.py. Writes AIPascalCourse/public/assets/doodles/machine-joke-<lessonId>.svg.

  python -X utf8 tools/machine/make_jokes.py
"""
import os, sys, math
sys.path.insert(0, os.path.dirname(__file__))
from make_art import (Svg, volt, ndlovu, DOODLES, BOARD, BOARD_DK, COPPER, CREAM, PIN, INK, VOLT, VOLT_DK, TEXT,
                      PCB, GOLD, CHIP, METAL, METAL_DK, PLASTIC, PLASTIC_DK)

PAPER = '#ffffff'


def eyes(s, cx, cy, gap=12, r=5, mood='open'):
    for dx in (-gap, gap):
        if mood == 'sleepy':
            s.add(f'<path d="M{cx + dx - 6} {cy} h12" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>'
                  f'<path d="M{cx + dx - 5} {cy + 5} q5 4 10 0" stroke="#7a6a9a" stroke-width="2" fill="none"/>')
        else:
            s.add(f'<circle cx="{cx + dx}" cy="{cy}" r="{r}" fill="#ffffff" stroke="{INK}" stroke-width="2"/><circle cx="{cx + dx + 1}" cy="{cy + 1}" r="{r * .5}" fill="{INK}"/>')


def monitor(s, cx, cy, sc=1.0, screen='#1f3b5c'):
    o = lambda v: v * sc
    s.add(f'<rect x="{cx - o(50)}" y="{cy - o(36)}" width="{o(100)}" height="{o(66)}" rx="{o(5)}" fill="{PLASTIC}"/>'
          f'<rect x="{cx - o(44)}" y="{cy - o(30)}" width="{o(88)}" height="{o(54)}" rx="{o(2)}" fill="{screen}"/>'
          f'<rect x="{cx - o(8)}" y="{cy + o(30)}" width="{o(16)}" height="{o(12)}" fill="{PLASTIC_DK}"/><rect x="{cx - o(26)}" y="{cy + o(42)}" width="{o(52)}" height="{o(6)}" rx="{o(3)}" fill="{PLASTIC_DK}"/>')


def binary():
    s = Svg(300, 200, 'Two light switches showing 1 and 0 - the number 10 - with one person laughing because they get it and one person puzzled', PAPER)
    for i, (on, x) in enumerate(((1, 96), (0, 156))):
        s.add(f'<rect x="{x}" y="20" width="48" height="74" rx="8" fill="#f1f2ee" stroke="{INK}" stroke-width="2"/>'
              f'<rect x="{x + 14}" y="{28 if on else 58}" width="20" height="28" rx="4" fill="{VOLT if on else "#9aa1a8"}" stroke="{INK}" stroke-width="2"/>')
        s.text(x + 24, 118, str(on), 26, INK, 'middle', 700)
    s.text(150, 118, '', 10, INK)
    s.text(280, 70, '= 2', 22, PIN, 'end', 700)
    for x, col, happy in ((50, '#2f6fde', True), (250, '#1f8a5b', False)):
        s.add(f'<circle cx="{x}" cy="146" r="16" fill="#8d5a3b"/><path d="M{x - 18} 196 q0 -28 18 -28 q18 0 18 28z" fill="{col}"/>')
        s.add(f'<circle cx="{x - 6}" cy="142" r="2.4" fill="{INK}"/><circle cx="{x + 6}" cy="142" r="2.4" fill="{INK}"/>')
        if happy:
            s.add(f'<path d="M{x - 8} 150 q8 10 16 0z" fill="{INK}"/>')
            s.text(x + 24, 140, 'HA!', 16, PIN, 'start', 700)
        else:
            s.add(f'<path d="M{x - 6} 154 h12" stroke="{INK}" stroke-width="2.4" stroke-linecap="round"/>')
            s.text(x - 26, 138, '?', 24, '#2a7d8c', 'end', 700)
    s.save(DOODLES, 'machine-joke-binary')


def cpu():
    s = Svg(300, 200, 'A sleepy CPU chip with droopy eyes and a mug of coffee, under the moon, after processing all night', PAPER)
    s.add(f'<rect x="60" y="40" width="130" height="130" rx="6" fill="{PCB}"/>')
    for k in range(9):
        s.add(f'<rect x="{70 + k * 13}" y="34" width="5" height="8" fill="{GOLD}"/><rect x="{70 + k * 13}" y="168" width="5" height="8" fill="{GOLD}"/>'
              f'<rect x="54" y="{50 + k * 13}" width="8" height="5" fill="{GOLD}"/><rect x="188" y="{50 + k * 13}" width="8" height="5" fill="{GOLD}"/>')
    s.add(f'<rect x="78" y="58" width="94" height="94" rx="4" fill="{METAL}" stroke="{METAL_DK}" stroke-width="2"/>')
    eyes(s, 125, 96, 18, mood='sleepy')
    s.add(f'<path d="M113 128 q12 -6 24 0" stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round"/>')
    s.add(f'<path d="M262 20 a26 26 0 1 0 22 40 a20 20 0 1 1 -22 -40z" fill="{VOLT}"/>')
    s.add(f'<rect x="214" y="130" width="40" height="44" rx="5" fill="{PIN}"/><path d="M254 140 q14 0 14 12 q0 12 -14 12" stroke="{PIN}" stroke-width="5" fill="none"/>')
    for x in (224, 236):
        s.add(f'<path d="M{x} 122 q-6 -8 0 -16 q6 -8 0 -16" stroke="{METAL_DK}" stroke-width="2.5" fill="none" stroke-linecap="round"/>')
    s.text(208, 70, 'z', 18, INK, 'start', 700)
    s.text(222, 52, 'Z', 24, INK, 'start', 700)
    s.save(DOODLES, 'machine-joke-cpu')


def files():
    s = Svg(300, 200, 'A photo file lifting a dumbbell on a scale that reads 3 MB going down to 2 MB', PAPER)
    s.add(f'<rect x="60" y="164" width="140" height="22" rx="4" fill="{PLASTIC}"/><rect x="104" y="168" width="52" height="14" rx="2" fill="#c9f2dd"/>')
    s.text(130, 180, '2 MB', 12, INK, 'middle', 700)
    s.add(f'<path d="M100 40 h44 l20 20 v100 h-64z" fill="{PAPER}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/><path d="M144 40 v20 h20" fill="none" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<rect x="108" y="66" width="48" height="34" fill="#bfe3ff"/><path d="M108 100 l16 -18 l12 10 l8 -6 l12 14z" fill="#7bc96f"/><circle cx="146" cy="74" r="4" fill="{VOLT}"/>')
    s.text(132, 122, '.JPG', 13, INK, 'middle', 700)
    eyes(s, 132, 140, 10, 4)
    s.add(f'<path d="M100 120 l-22 -40 M164 120 l22 -40" stroke="{INK}" stroke-width="4" stroke-linecap="round"/><path d="M60 80 h144" stroke="{INK}" stroke-width="6"/>'
          f'<rect x="52" y="64" width="14" height="32" rx="3" fill="{PIN}"/><rect x="198" y="64" width="14" height="32" rx="3" fill="{PIN}"/>')
    s.text(240, 150, '3 MB', 16, '#9aa1a8', 'middle', 700)
    s.add(f'<path d="M222 146 l36 -10" stroke="{PIN}" stroke-width="3"/><path d="M240 164 v20 M232 176 l8 8 l8 -8" stroke="#1f8a5b" stroke-width="3" fill="none" stroke-linecap="round"/>')
    s.save(DOODLES, 'machine-joke-files')


def fix():
    s = Svg(300, 200, 'A happy, working computer riding a surfboard on a wave that is a net of network cable', PAPER)
    s.add('<rect width="300" height="200" rx="8" fill="#e6f4ff"/>')
    s.add(f'<circle cx="250" cy="40" r="20" fill="{VOLT}"/>')
    s.add(f'<path d="M0 150 q40 -60 100 -30 q40 20 70 -10 q40 -40 80 0 q30 30 50 20 V200 H0z" fill="#2a7d8c"/>')
    for x in range(10, 300, 20):
        s.add(f'<path d="M{x} 200 l20 -60" stroke="#8fd3ff" stroke-width="1.5" opacity=".7"/><path d="M{x + 20} 200 l-20 -60" stroke="#8fd3ff" stroke-width="1.5" opacity=".7"/>')
    s.add(f'<g transform="rotate(-12 140 128)"><ellipse cx="140" cy="128" rx="80" ry="10" fill="{PIN}" stroke="{INK}" stroke-width="2"/></g>')
    monitor(s, 140, 74, 0.8, '#1f8a5b')
    eyes(s, 140, 64, 12, 4)
    s.add(f'<path d="M130 76 q10 10 20 0" stroke="#ffffff" stroke-width="3" fill="none" stroke-linecap="round"/>')
    s.text(60, 40, 'SURF\'S UP!', 18, INK, 'middle', 700)
    s.save(DOODLES, 'machine-joke-fix')


def internet():
    s = Svg(300, 200, 'A router and a laptop side by side, a heart between them and the Wi-Fi signal at full strength', PAPER)
    s.add(f'<rect x="20" y="120" width="100" height="40" rx="8" fill="{PLASTIC}"/>')
    for x in (40, 100):
        s.add(f'<path d="M{x} 120 V70" stroke="{PLASTIC}" stroke-width="6" stroke-linecap="round"/>')
    for x in (40, 56, 72):
        s.add(f'<circle cx="{x}" cy="148" r="4" fill="#7bc96f"/>')
    s.add(f'<rect x="184" y="88" width="96" height="62" rx="5" fill="{PLASTIC}"/><rect x="190" y="94" width="84" height="50" fill="#1f3b5c"/><path d="M170 150 h124 l-8 12 h-108z" fill="{METAL_DK}"/>')
    s.add(f'<path d="M150 108 c-10 -16 -32 -6 -24 10 c4 8 16 16 24 24 c8 -8 20 -16 24 -24 c8 -16 -14 -26 -24 -10z" fill="{PIN}"/>')
    for i, r in enumerate((16, 30, 44)):
        s.add(f'<path d="M{150 - r * .8} {64 - r * .3} a{r} {r} 0 0 1 {r * 1.6} 0" stroke="{VOLT_DK}" stroke-width="5" fill="none" stroke-linecap="round"/>')
    s.add(f'<circle cx="150" cy="66" r="5" fill="{VOLT_DK}"/>')
    eyes(s, 70, 140, 14, 4)
    eyes(s, 232, 116, 14, 4)
    s.text(150, 190, 'FULL SIGNAL', 14, INK, 'middle', 700)
    s.save(DOODLES, 'machine-joke-internet')


def ipo():
    s = Svg(300, 200, 'A computer sneezing ACHOO, spraying out 0s and 1s, with a box of tissues beside it', PAPER)
    monitor(s, 90, 90, 1.1, '#e6eef5')
    eyes(s, 90, 80, 14, mood='sleepy')
    s.add(f'<ellipse cx="90" cy="104" rx="10" ry="7" fill="{INK}"/><path d="M60 64 l14 6 M120 64 l-14 6" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    for i, (x, y, b) in enumerate(((160, 60, 1), (180, 90, 0), (200, 70, 1), (214, 110, 0), (236, 84, 1), (250, 126, 1), (196, 130, 0), (262, 60, 0))):
        s.text(x, y, str(b), 16 + (i % 3) * 3, '#2a7d8c', 'middle', 700)
    s.text(196, 34, 'ACHOO!', 24, PIN, 'middle', 700)
    s.add(f'<rect x="200" y="150" width="70" height="36" rx="4" fill="#8fd3ff" stroke="{INK}" stroke-width="2"/><path d="M226 150 q8 -20 18 0" fill="#ffffff" stroke="{INK}" stroke-width="2"/>')
    s.save(DOODLES, 'machine-joke-ipo')


def memory():
    s = Svg(300, 200, 'Dr Ndlovu on the radio checking a puzzled RAM stick, which holds an empty page with a question mark', PAPER)
    s.add(f'<rect x="20" y="100" width="170" height="44" rx="3" fill="{PCB}"/>')
    for k in range(7):
        s.add(f'<rect x="{30 + k * 22}" y="108" width="16" height="22" rx="1" fill="{CHIP}"/>')
    for k in range(26):
        s.add(f'<rect x="{24 + k * 6.3:.1f}" y="136" width="4" height="8" fill="{GOLD}"/>')
    s.add(f'<rect x="96" y="128" width="4" height="16" fill="{PAPER}"/>')
    eyes(s, 105, 82, 16, 6)
    s.add(f'<path d="M96 96 q9 -4 18 0" stroke="{INK}" stroke-width="3" fill="none"/>')
    s.add(f'<path d="M30 30 h40 l12 12 v46 h-52z" fill="{PAPER}" stroke="{INK}" stroke-width="2.5"/>')
    s.text(56, 76, '?', 34, PIN, 'middle', 700)
    ndlovu(s, 236, 74, 0.9)
    s.add(f'<path d="M206 150 q30 -10 60 0" stroke="{INK}" stroke-width="3" fill="none"/><circle cx="206" cy="150" r="6" fill="{METAL}" stroke="{INK}" stroke-width="2"/>')
    s.text(150, 186, 'NO SAVE FOUND', 16, INK, 'middle', 700)
    s.save(DOODLES, 'machine-joke-memory')


def main():
    binary(); cpu(); files(); fix(); internet(); ipo(); memory()


if __name__ == '__main__':
    main()
