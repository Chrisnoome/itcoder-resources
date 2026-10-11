"""The Grade 8 Fact or fake course's joke drawings (brand/factfake-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle: a small cartoon
of the joke in the group-chat and Lens-scanner look, with the joke itself as
the caption. Uses the pieces in make_art.py. Writes AIPascalCourse/public/
assets/doodles/factfake-joke-<lessonfile>.svg.

  python -X utf8 tools/factfake/make_jokes.py
"""
import os, sys, random
sys.path.insert(0, os.path.dirname(__file__))
from make_art import (Svg, DOODLES, echo, lens, chat_frame, bubble, scan_frame,
                      CHAT_BAR, BUBBLE, MINE, INK, GREY, LINK, SCAN_BG, CYAN, MAGENTA, GOLD, SCAN_INK,
                      PARROT_DK, BEAK_RED, CHATFONT, SCANFONT)

SKIN, SKIN_DK, HEART = '#e0a878', '#9c6a44', '#ff3b6b'


def face(s, cx, cy, r=10, mood='happy'):
    s.add(f'<circle cx="{cx - r * .35}" cy="{cy - r * .15}" r="{r * .13}" fill="{INK}"/><circle cx="{cx + r * .35}" cy="{cy - r * .15}" r="{r * .13}" fill="{INK}"/>')
    paths = {'happy': f'M{cx - r * .4} {cy + r * .25} Q{cx} {cy + r * .65} {cx + r * .4} {cy + r * .25}',
             'sad':   f'M{cx - r * .4} {cy + r * .55} Q{cx} {cy + r * .2} {cx + r * .4} {cy + r * .55}',
             'flat':  f'M{cx - r * .35} {cy + r * .4} H{cx + r * .35}'}
    s.add(f'<path d="{paths[mood]}" fill="none" stroke="{INK}" stroke-width="2.5" stroke-linecap="round"/>')


def browser(s, x, y, w, h, addr):
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="8" fill="#ffffff" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<path d="M{x} {y + 22} h{w}" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<rect x="{x + 8}" y="{y + 5}" width="{w - 16}" height="12" rx="6" fill="#f1f3f5"/>')
    s.text(x + 14, y + 15, addr, 9, LINK, weight=800)


def jokes():
    # aifakes: an AI drew a hand with seven fingers; Lens counts them in the scanner
    s = Svg(300, 190, 'In the Lens scanner, an AI drawing of a hand with seven fingers, numbered one to seven, while Lens stares at it', None)
    scan_frame(s, 4, 4, 200, 182)
    s.add(f'<rect x="22" y="40" width="164" height="128" rx="6" fill="#1d2633"/>')
    s.add(f'<path d="M78 166 v-30 q0 -14 14 -16 h40 q14 2 14 16 v30z" fill="{SKIN}" stroke="{SKIN_DK}" stroke-width="2"/>')
    for i in range(7):
        x = 80 + i * 9.4
        top = 74 + abs(i - 3) * 6
        s.add(f'<rect x="{x:.1f}" y="{top}" width="8" height="{132 - top}" rx="4" fill="{SKIN}" stroke="{SKIN_DK}" stroke-width="1.5"/>')
        s.text(f'{x + 4:.1f}', top - 6, str(i + 1), 16, CYAN if i < 5 else MAGENTA, 'middle', 400, SCANFONT)
    s.add(f'<ellipse cx="135" cy="80" rx="20" ry="24" fill="none" stroke="{MAGENTA}" stroke-width="3"/>')
    s.text(104, 32, 'AI ART', 18, GOLD, 'middle', 400, SCANFONT)
    lens(s, 244, 74, 0.62)
    s.text(254, 150, '7?!', 30, MAGENTA, 'middle', 400, SCANFONT)
    s.save(DOODLES, 'factfake-joke-aifakes')

    # photos: a photo lifting weights, the crop lines and scissors closing in
    s = Svg(300, 190, 'A photo with a face lifting a dumbbell at the gym while a pair of scissors and dashed crop lines close in on its edge', None)
    s.add(f'<rect x="96" y="22" width="120" height="140" rx="4" fill="#ffffff" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<rect x="106" y="32" width="100" height="98" fill="#9db7c9"/><path d="M106 130 l30 -36 l22 22 l16 -14 l32 28z" fill="#4b5d6e"/>')
    face(s, 156, 70, 22, 'flat')
    s.add('<path d="M172 50 q5 7 0 12" stroke="#2a6fd6" stroke-width="2.5" fill="none"/>')
    s.add(f'<path d="M96 70 q-26 -10 -26 -52 M216 70 q26 -10 26 -52" stroke="{INK}" stroke-width="4" fill="none" stroke-linecap="round"/>')
    s.add(f'<path d="M56 16 h200" stroke="{INK}" stroke-width="6" stroke-linecap="round"/>')
    for x in (44, 56, 256, 268):
        s.add(f'<rect x="{x - 5}" y="0" width="10" height="32" rx="3" fill="{CHAT_BAR}" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<path d="M136 162 v20 M176 162 v20" stroke="{INK}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<path d="M84 40 v148" stroke="{MAGENTA}" stroke-width="2.5" stroke-dasharray="6 5"/>')
    s.add(f'<g transform="translate(66 150) rotate(-90)"><circle cx="-8" cy="-10" r="7" fill="none" stroke="{INK}" stroke-width="3"/><circle cx="-8" cy="10" r="7" fill="none" stroke="{INK}" stroke-width="3"/>'
          f'<path d="M-2 -6 L26 6 M-2 6 L26 -6" stroke="{GREY}" stroke-width="4" stroke-linecap="round"/></g>')
    s.text(264, 120, 'NOT', 13, BEAK_RED, 'middle', 900)
    s.text(264, 136, 'THIS', 13, BEAK_RED, 'middle', 900)
    s.text(264, 152, 'TIME!', 13, BEAK_RED, 'middle', 900)
    s.save(DOODLES, 'factfake-joke-photos')

    # search: a sad browser, a broken heart, and the search bar walking off with a more relevant result
    s = Svg(300, 190, 'A sad browser window with a tear, a broken heart, and a happy search bar holding hands with a search result marked most relevant', None)
    browser(s, 6, 60, 92, 82, 'my.browser')
    face(s, 52, 108, 22, 'sad')
    s.add('<path d="M40 112 q-3 7 0 10 q3 -3 0 -10z" fill="#2a6fd6"/>')
    s.add(f'<path d="M126 92 c-14 -20 -40 0 0 30 c40 -30 14 -50 0 -30z" fill="{HEART}"/><path d="M126 92 l-6 10 l8 6 l-6 12" stroke="#ffffff" stroke-width="3" fill="none"/>')
    s.add(f'<rect x="160" y="20" width="134" height="30" rx="15" fill="#ffffff" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<circle cx="178" cy="35" r="6" fill="none" stroke="{INK}" stroke-width="2.5"/><path d="M182 39 l5 5" stroke="{INK}" stroke-width="2.5"/>')
    s.text(194, 40, 'Seekr', 14, CHAT_BAR, weight=900)
    face(s, 260, 35, 12)
    s.add(f'<rect x="174" y="84" width="112" height="62" rx="8" fill="{MINE}" stroke="{INK}" stroke-width="2.5"/>')
    s.text(184, 102, '#1 RESULT', 12, CHAT_BAR, weight=900)
    face(s, 230, 124, 14)
    s.add(f'<path d="M230 50 q-8 16 -2 34" stroke="{INK}" stroke-width="3" fill="none" stroke-linecap="round"/>')
    s.add(f'<path d="M262 74 c-5 -7 -14 0 0 10 c14 -10 5 -17 0 -10z" fill="{HEART}"/>')
    s.text(230, 172, 'MORE RELEVANT', 14, MAGENTA, 'middle', 900)
    s.save(DOODLES, 'factfake-joke-search')

    # source: a scam website in a graduation cap with a fake tick sticker
    s = Svg(300, 190, 'A grinning scam website wearing a graduation cap and a stuck-on tick, its address reads totally-legit.example, while Lens frowns at it', None)
    browser(s, 20, 54, 170, 124, 'totally-legit.example')
    face(s, 100, 114, 30)
    s.add(f'<g transform="rotate(12 160 44)"><path d="M120 44 L160 26 L200 44 L160 62z" fill="{INK}"/><path d="M193 47 v22" stroke="{GOLD}" stroke-width="3"/><circle cx="193" cy="71" r="4" fill="{GOLD}"/></g>')
    s.add(f'<g transform="rotate(-14 162 110)"><circle cx="162" cy="110" r="15" fill="{LINK}" stroke="#ffffff" stroke-width="3"/><path d="M155 110 l5 5 l9 -10" stroke="#ffffff" stroke-width="3" fill="none"/></g>')
    s.text(50, 168, '100% REAL SCHOOL', 9, BEAK_RED, weight=900)
    lens(s, 240, 98, 0.56)
    s.text(244, 168, 'hmm.', 16, INK, 'middle', 900)
    s.save(DOODLES, 'factfake-joke-source')

    # spread: one rumour bubble in a group chat, surrounded by 300 new friends
    s = Svg(300, 190, 'A group chat where one rumour bubble with a face is surrounded by a crowd of little profile pictures, and a badge says 300 friends', None)
    chat_frame(s, 4, 4, 292, 182, 'Gr 8 Squad')
    s.text(286, 29, '5 min later', 11, '#d6f5e3', 'end', 800)
    rnd = random.Random(8)
    cols = ['#f59e0b', '#2a6fd6', '#e5484d', '#8b5cf6', '#14b8a6', '#f472b6', '#84cc16']
    spots = []
    for row in range(5):
        for col in range(13):
            x = 22 + col * 21 + (row % 2) * 10
            y = 62 + row * 26
            if 64 < x < 214 and 76 < y < 150:
                continue
            if x > 282:
                continue
            spots.append((x + rnd.randint(-2, 2), y + rnd.randint(-2, 2)))
    for x, y in spots:
        s.add(f'<circle cx="{x}" cy="{y}" r="9" fill="{rnd.choice(cols)}" stroke="#ffffff" stroke-width="1.5"/>'
              f'<circle cx="{x - 3}" cy="{y - 1}" r="1.3" fill="{INK}"/><circle cx="{x + 3}" cy="{y - 1}" r="1.3" fill="{INK}"/>')
    s.add(f'<rect x="78" y="80" width="126" height="62" rx="12" fill="{BUBBLE}" stroke="{INK}" stroke-width="2"/>')
    s.text(88, 96, '↪ Forwarded many times', 8, GREY, weight=700)
    s.text(88, 112, 'RUMOUR', 14, '#c2410c', weight=900)
    face(s, 176, 116, 16)
    s.add(f'<rect x="88" y="120" width="56" height="6" rx="3" fill="#dfe6e2"/><rect x="88" y="130" width="40" height="6" rx="3" fill="#dfe6e2"/>')
    s.add(f'<rect x="196" y="150" width="92" height="28" rx="14" fill="{BEAK_RED}" stroke="#ffffff" stroke-width="2"/>')
    s.text(242, 169, '+300 friends', 13, '#ffffff', 'middle', 900)
    s.save(DOODLES, 'factfake-joke-spread')

    # verdict: Echo at the fact-check desk, the old "SHARE! SHARE!" crossed out
    s = Svg(300, 190, 'Echo the parrot sits calmly at the fact-check desk with a CHECKED stamp; the speech bubble saying share share share is crossed out', None)
    echo(s, 76, 46, 0.66)
    s.add(f'<rect x="10" y="118" width="190" height="66" rx="6" fill="#c8a272" stroke="{INK}" stroke-width="2.5"/>')
    s.add(f'<rect x="34" y="132" width="142" height="26" rx="4" fill="#ffffff" stroke="{INK}" stroke-width="2"/>')
    s.text(105, 150, 'FACT-CHECK DESK', 12, CHAT_BAR, 'middle', 900)
    s.add(f'<rect x="150" y="96" width="36" height="22" rx="4" fill="{PARROT_DK}"/><rect x="158" y="80" width="20" height="18" rx="4" fill="#8a5a2b"/>')
    s.add(f'<path d="M148 50 L114 46 L148 36z" fill="#ffffff" stroke="{INK}" stroke-width="2" stroke-linejoin="round"/>')
    s.add(f'<rect x="146" y="6" width="146" height="62" rx="12" fill="#ffffff" stroke="{INK}" stroke-width="2"/><path d="M146 38 v10" stroke="#ffffff" stroke-width="4"/>')
    s.text(219, 30, 'SHARE! SHARE!', 13, GREY, 'middle', 900)
    s.text(219, 50, 'SHARE! SHARE!', 13, GREY, 'middle', 900)
    s.add(f'<path d="M158 14 L280 60 M280 14 L158 60" stroke="{BEAK_RED}" stroke-width="4" stroke-linecap="round"/>')
    s.add(f'<g transform="rotate(-10 250 150)"><rect x="206" y="130" width="88" height="38" rx="6" fill="none" stroke="{CHAT_BAR}" stroke-width="4"/>'
          f'<text x="250" y="156" font-family="{CHATFONT}" font-size="16" font-weight="900" fill="{CHAT_BAR}" text-anchor="middle">CHECKED</text></g>')
    s.save(DOODLES, 'factfake-joke-verdict')


if __name__ == '__main__':
    jokes()
