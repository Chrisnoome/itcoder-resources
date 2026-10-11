"""The Club website course's joke drawings (brand/clubweb-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle: one comic panel
(thick ink, flat colour) with Tag, Gat and the isometric blocks acting the
joke out, and the joke itself as the caption. Uses the pieces in make_art.py.
Writes AIPascalCourse/public/assets/doodles/clubweb-joke-<lessonId>.svg.

  python -X utf8 tools/clubweb/make_jokes.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import Svg, panel, bubble, tag, gat, face, iso, INK, WHITE, YELLOW, SKY, PINK, RED, TAG_BLUE, GAT_PINK, SHOUT, SPEECH, CODE


def card(label, fill):
    s = Svg(260, 190, label)
    panel(s, 4, 4, 252, 182, fill)
    return s


def headings():
    s = card('Tag and Gat at the bottom of a tall stack of blocks, gazing up in awe at the h1 block on top', SKY)
    iso(s, 160, 90, 70, 50, 12, 'base')
    iso(s, 160, 72, 60, 42, 14, 'text', '<p>')
    iso(s, 160, 52, 52, 36, 16, 'list')
    iso(s, 160, 18, 56, 40, 20, 'heading', '<h1>')
    for x1, y1, x2, y2 in ((110, 30, 98, 24), (112, 46, 98, 46), (212, 22, 226, 14), (220, 38, 236, 36)):
        s.add(f'<path d="M{x1} {y1} L{x2} {y2}" stroke="{INK}" stroke-width="3" stroke-linecap="round"/>')
    tag(s, 40, 150, 0.95, 'wow'); gat(s, 82, 150, 0.95, 'wow')
    s.add(f'<path d="M48 120 Q80 60 120 40" stroke="{INK}" stroke-width="2" stroke-dasharray="4 4" fill="none"/>')
    s.text(30, 30, 'WOW', 16, RED, SHOUT)
    s.save('joke-headings')


def links():
    s = card('A confident blue link block in sunglasses, following a signpost to page2.html', YELLOW)
    s.add(f'<path d="M190 176 V60" stroke="{INK}" stroke-width="6"/>')
    s.add(f'<path d="M150 40 H232 L248 56 L232 72 H150Z" fill="{WHITE}" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>')
    s.text(196, 61, 'page2.html', 12, INK, CODE, 'middle', 700)
    iso(s, 80, 74, 70, 50, 26, 'link')
    s.add(f'<rect x="66" y="90" width="20" height="10" rx="3" fill="{INK}"/><rect x="90" y="90" width="20" height="10" rx="3" fill="{INK}"/><path d="M86 94 h4" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<path d="M76 108 q12 8 24 0" stroke="{INK}" stroke-width="2.5" fill="none" stroke-linecap="round"/>')
    s.text(30, 172, '<a href="page2.html">', 12, INK, CODE, 'start', 700)
    s.add(f'<path d="M132 108 h30 M152 100 l10 8 l-10 8" stroke="{INK}" stroke-width="3.5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>')
    s.save('joke-links')


def pictures():
    s = card('A picture in a frame, behind jail bars, looking glum: it was framed', PINK)
    s.add(f'<rect x="70" y="40" width="120" height="96" fill="#c8a165" stroke="{INK}" stroke-width="4"/><rect x="84" y="54" width="92" height="68" fill="{SKY}" stroke="{INK}" stroke-width="3"/>')
    s.add(f'<path d="M84 122 L112 88 L132 108 L146 94 L176 122Z" fill="#7bc96f" stroke="{INK}" stroke-width="2.5" stroke-linejoin="round"/><circle cx="158" cy="72" r="8" fill="{YELLOW}" stroke="{INK}" stroke-width="2"/>')
    face(s, 120, 74, 1.6, 'worried')
    for x in (30, 52, 74, 96, 144, 166, 188, 210, 232):  # a gap at the face, so it can look out
        s.add(f'<path d="M{x} 8 V182" stroke="#55575c" stroke-width="7"/><path d="M{x} 8 V182" stroke="{INK}" stroke-width="2" fill="none"/>')
    s.add(f'<rect x="8" y="150" width="244" height="12" fill="#55575c" stroke="{INK}" stroke-width="2"/>')
    s.text(130, 178, '<img>', 13, WHITE, CODE, 'middle', 700)
    s.save('joke-pictures')


def style():
    s = card('Tag shivering in a scarf in front of three open browser windows, snow blowing in', SKY)
    for i, (x, y) in enumerate(((112, 22), (142, 58), (172, 94))):
        s.add(f'<rect x="{x}" y="{y}" width="76" height="56" fill="{WHITE}" stroke="{INK}" stroke-width="3"/><rect x="{x}" y="{y}" width="76" height="12" fill="#d8e1f0" stroke="{INK}" stroke-width="3"/>')
        for k in range(3):
            s.add(f'<circle cx="{x + 7 + k * 8}" cy="{y + 6}" r="2.2" fill="{(RED, YELLOW, "#7bc96f")[k]}"/>')
    for x, y in ((40, 30), (90, 52), (70, 100), (230, 40), (130, 150), (220, 166), (30, 170)):
        s.add(f'<path d="M{x - 6} {y} h12 M{x} {y - 6} v12 M{x - 4} {y - 4} l8 8 M{x + 4} {y - 4} l-8 8" stroke="{WHITE}" stroke-width="2.5" stroke-linecap="round"/>')
    tag(s, 58, 140, 1.2, 'worried')
    s.add(f'<path d="M44 152 q20 10 36 0 l4 10 q-22 12 -44 0z" fill="{RED}" stroke="{INK}" stroke-width="2.5"/><path d="M52 160 l-6 22 l10 0 l4 -18" fill="{RED}" stroke="{INK}" stroke-width="2.5"/>')
    for d in (-1, 1):
        s.add(f'<path d="M{58 + d * 30} 124 l{d * 6} -4 M{58 + d * 32} 136 l{d * 7} 0" stroke="{INK}" stroke-width="2.5" stroke-linecap="round"/>')
    s.save('joke-style')


def tables():
    s = card('A green table with a zip across its mouth, keeping quiet: shh', YELLOW)
    iso(s, 130, 40, 150, 110, 14, 'table')
    for k in range(1, 4):
        a = k * 150 / 4
        s.add(f'<path d="M{130 + a * .866:.1f} {40 + a * .5:.1f} l{-110 * .866:.1f} {110 * .5:.1f}" stroke="{INK}" stroke-width="2"/>')
    for k in range(1, 3):
        b = k * 110 / 3
        s.add(f'<path d="M{130 - b * .866:.1f} {40 + b * .5:.1f} l{150 * .866:.1f} {150 * .5:.1f}" stroke="{INK}" stroke-width="2"/>')
    for x in (128, 166):
        s.add(f'<circle cx="{x}" cy="96" r="9" fill="{WHITE}" stroke="{INK}" stroke-width="2.5"/><circle cx="{x + 2}" cy="97" r="4" fill="{INK}"/>')
    s.add(f'<path d="M118 120 H178" stroke="{INK}" stroke-width="7"/><path d="M118 120 H178" stroke="#c9ced3" stroke-width="3" stroke-dasharray="3 3"/>'
          f'<rect x="174" y="114" width="10" height="16" rx="2" fill="#c9ced3" stroke="{INK}" stroke-width="2"/>')
    bubble(s, 150, 16, 90, 30, ['SHH...'], 200, 70, 13, shout=True)
    s.save('joke-tables')


def tags():
    s = card('A light bulb with bugs buzzing round it on one side; Tag and Gat relaxing in the dark on the other', YELLOW)
    s.add(f'<rect x="130" y="4" width="126" height="182" fill="#1e1f2b" stroke="{INK}" stroke-width="4"/>')
    s.add(f'<circle cx="66" cy="72" r="30" fill="#fff6b0" stroke="{INK}" stroke-width="3.5"/><rect x="54" y="100" width="24" height="18" fill="#c9ced3" stroke="{INK}" stroke-width="3"/><path d="M66 4 V42" stroke="{INK}" stroke-width="3"/>')
    for x, y, r in ((30, 50, -20), (100, 46, 30), (36, 112, 10), (104, 104, -40), (68, 132, 0)):
        s.add(f'<g transform="rotate({r} {x} {y})"><ellipse cx="{x}" cy="{y}" rx="7" ry="5" fill="{INK}"/><ellipse cx="{x - 3}" cy="{y - 5}" rx="4" ry="3" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/>'
              f'<ellipse cx="{x + 3}" cy="{y - 5}" rx="4" ry="3" fill="{WHITE}" stroke="{INK}" stroke-width="1.5"/></g>')
    s.add(f'<path d="M20 150 q20 -20 40 0 t40 0" stroke="{INK}" stroke-width="2" stroke-dasharray="3 4" fill="none"/>')
    tag(s, 172, 120, 1.0, 'happy'); gat(s, 216, 120, 1.0, 'happy')
    s.text(193, 40, 'DARK', 14, WHITE, SHOUT, 'middle')
    s.text(193, 60, 'MODE', 14, WHITE, SHOUT, 'middle')
    s.save('joke-tags')


def main():
    headings(); links(); pictures(); style(); tables(); tags()


if __name__ == '__main__':
    main()
