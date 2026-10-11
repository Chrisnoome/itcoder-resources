"""The Bolt's maze course's joke drawings (brand/botmaze-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle in the course's
handmade-game look, the joke itself the caption. Uses the pieces in
make_art.py. Writes AIPascalCourse/public/assets/doodles/botmaze-joke-<lessonId>.svg.

  python -X utf8 tools/botmaze/make_jokes.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import (Svg, paper, tape, sticky, wall, bolt_stand, bolt_head, glitch, pen_path,
                      RED, INK, STICKY, GREEN, BATTERY, GLITCH, GLITCH_DK, WALL, PAPER, GAME, HAND)


def chips():
    s = Svg(300, 190, 'Bolt holding a bag of micro-chips: tiny computer chips instead of crisps')
    paper(s, 14, 12, 272, 166, rot=-1.5)
    bolt_stand(s, 92, 84, 0.85, 'happy', stick=False)
    s.add(f'<g transform="rotate(6 210 110)"><path d="M168 52 h84 l-8 112 h-68z" fill="{RED}" stroke="{INK}" stroke-width="2.5"/>'
          f'<path d="M168 52 l6 -10 h72 l6 10" fill="#e8e8e8" stroke="{INK}" stroke-width="2.5"/></g>')
    s.text(210, 96, 'MICRO', 18, '#fff', 'middle', GAME, 400, rot=6)
    s.text(208, 118, 'CHIPS', 18, '#fff', 'middle', GAME, 400, rot=6)
    for x, y in [(186, 138), (214, 142), (232, 132)]:
        s.add(f'<g transform="translate({x} {y}) rotate(8)"><rect x="-8" y="-6" width="16" height="12" fill="#2a2a2a"/>'
              + ''.join(f'<path d="M{-6 + k * 4} -6 v-3 M{-6 + k * 4} 6 v3" stroke="#bbb" stroke-width="1.2"/>' for k in range(4)) + '</g>')
    return s


def never_right():
    s = Svg(300, 190, 'Bolt at a crossroads with a sign: RIGHT is crossed out in red felt pen, LEFT has a big tick')
    paper(s, 14, 12, 272, 166, rot=1.5)
    s.add(f'<rect x="196" y="40" width="8" height="120" fill="{WALL}"/>')
    s.add(f'<path d="M204 48 h62 l12 14 l-12 14 h-62z" fill="{STICKY}" stroke="{INK}" stroke-width="2"/>')
    s.text(236, 68, 'RIGHT', 15, INK, 'middle', GAME, 400)
    s.add(f'<path d="M210 52 L262 74 M262 52 L210 74" stroke="{RED}" stroke-width="3.5" stroke-linecap="round"/>')
    s.add(f'<path d="M196 92 h-62 l-12 14 l12 14 h62z" fill="{GREEN}" stroke="{INK}" stroke-width="2"/>')
    s.text(164, 112, 'LEFT', 15, INK, 'middle', GAME, 400)
    s.add(f'<path d="M110 100 l6 7 l12 -14" stroke="{RED}" stroke-width="3.5" fill="none" stroke-linecap="round"/>')
    bolt_head(s, 74, 134, 0.9, 270)
    return s


def turning_around():
    s = Svg(300, 190, 'Glitch spinning a sticky note that says turn left round and round until it says turn right')
    paper(s, 14, 12, 272, 166, rot=-1)
    glitch(s, 90, 112, 1.25)
    sticky(s, 160, 46, 110, 40, ['turn left'], rot=-24, size=17)
    sticky(s, 170, 112, 110, 40, ['turn right'], rot=12, size=17)
    s.add(f'<path d="M262 74 q26 26 0 52" fill="none" stroke="{GLITCH}" stroke-width="3" stroke-dasharray="5 5"/>')
    s.add(f'<path d="M256 120 l6 8 l8 -6" fill="none" stroke="{GLITCH}" stroke-width="3" stroke-linecap="round"/>')
    s.text(90, 176, 'ta-da!', 18, GLITCH_DK, 'middle')
    return s


def same_joke():
    s = Svg(300, 190, 'Glitch inside a loop arrow telling the same joke three times while Bolt rolls its eye')
    paper(s, 14, 12, 272, 166, rot=1)
    s.add(f'<ellipse cx="96" cy="104" rx="64" ry="54" fill="none" stroke="{RED}" stroke-width="3" stroke-dasharray="8 6"/>')
    s.add(f'<path d="M150 72 l10 -4 l0 12" fill="none" stroke="{RED}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>')
    glitch(s, 96, 114, 1.0)
    for i, y in enumerate([30, 66, 102]):
        s.add(f'<rect x="174" y="{y}" width="96" height="28" rx="8" fill="#fff" stroke="{INK}" stroke-width="2"/>')
        s.text(222, y + 19, 'knock knock', 15, INK, 'middle')
    bolt_head(s, 236, 158, 0.75, 0, 'flat')
    return s


def trust_issues():
    s = Svg(300, 190, 'Bolt poking the square in front of it with a long stick before stepping, a sticky note saying: wall?')
    paper(s, 14, 12, 272, 166, rot=-1.5)
    bolt_stand(s, 80, 90, 0.8, 'flat', stick=False)
    s.add(f'<path d="M104 108 L226 120" stroke="#b07a3c" stroke-width="5" stroke-linecap="round"/>')
    wall(s, 232, 60, 26, 100)
    for x, y in [(222, 104), (226, 128)]:
        s.add(f'<path d="M{x} {y} l-8 -4 M{x} {y} l-8 4" stroke="{INK}" stroke-width="2"/>')
    sticky(s, 150, 30, 70, 40, ['wall?'], rot=6, size=18)
    return s


def wall_tz():
    s = Svg(300, 190, 'Two card wall pieces with faces dancing a waltz together, music notes round them')
    paper(s, 14, 12, 272, 166, rot=1.5)
    for cx, rot, mood in [(118, -10, 1), (182, 10, 1)]:
        s.add(f'<g transform="rotate({rot} {cx} 104)"><rect x="{cx - 22}" y="50" width="44" height="110" fill="{WALL}" stroke="#6e4c2a" stroke-width="2"/>'
              f'<circle cx="{cx - 8}" cy="80" r="3.5" fill="{INK}"/><circle cx="{cx + 8}" cy="80" r="3.5" fill="{INK}"/>'
              f'<path d="M{cx - 8} 92 q8 7 16 0" stroke="{INK}" stroke-width="2.5" fill="none" stroke-linecap="round"/></g>')
    s.add(f'<path d="M136 118 h28 M136 132 h28" stroke="#6e4c2a" stroke-width="5" stroke-linecap="round"/>')
    for x, y in [(60, 60), (240, 50), (250, 120)]:
        s.add(f'<path d="M{x} {y} v-22 l14 -4 v22" stroke="{INK}" stroke-width="2.5" fill="none"/><ellipse cx="{x - 4}" cy="{y}" rx="5" ry="4" fill="{INK}"/><ellipse cx="{x + 10}" cy="{y - 4}" rx="5" ry="4" fill="{INK}"/>')
    return s


def home_ohm():
    s = Svg(300, 190, 'Bolt plugged into its charging dock, a heart above it with the ohm sign inside, and a sign: home sweet ohm')
    paper(s, 14, 12, 272, 166, rot=-1)
    s.add(f'<rect x="96" y="132" width="110" height="26" rx="6" fill="#5f6b78" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<rect x="140" y="120" width="22" height="14" fill="{BATTERY}" stroke="{INK}" stroke-width="2"/>')
    bolt_stand(s, 151, 84, 0.7, 'happy', stick=False)
    s.add(f'<path d="M240 70 c-10 -16 -34 0 0 26 c34 -26 10 -42 0 -26z" fill="{RED}"/>')
    s.text(240, 84, 'Ω', 19, '#fff', 'middle', GAME, 400)
    sticky(s, 26, 34, 92, 52, ['home', 'sweet ohm'], rot=-5, size=16)
    return s


def main():
    chips().save('botmaze-joke-steps')
    never_right().save('botmaze-joke-turning')
    turning_around().save('botmaze-joke-debugging')
    same_joke().save('botmaze-joke-repeat')
    trust_issues().save('botmaze-joke-ifs')
    wall_tz().save('botmaze-joke-wall')
    home_ohm().save('botmaze-joke-home')


if __name__ == '__main__':
    main()
