"""Joke drawings for the Pascal and Java courses' pen doodles: the hand-drawn
margin style (currentColor ink lines, Kalam lettering) of the existing
doodles such as beads.svg and palindrome.svg.

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". The joke itself is the caption. Writes
AIPascalCourse/public/assets/doodles/<name>.svg.

  python -X utf8 tools/pen-doodles/make_jokes.py
"""
import os

DOODLES = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\doodles'
HAND = "font-family: 'Kalam', cursive; font-weight: 700"


def save(name, w, h, body):
    svg = (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}" fill="none" stroke="currentColor" '
           f'stroke-width="2" stroke-linecap="round" stroke-linejoin="round">\n' + '\n'.join(body) + '\n</svg>\n')
    with open(os.path.join(DOODLES, name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
    print(name + '.svg')


def word(x, y, text, size, anchor='middle'):
    return f'<text x="{x}" y="{y}" text-anchor="{anchor}" fill="currentColor" stroke="none" style="{HAND}; font-size: {size}px">{text}</text>'


def person(x, y, arms):
    return (f'<circle cx="{x}" cy="{y}" r="12"/><path d="M{x} {y + 12} V{y + 46} M{x} {y + 46} l-12 26 M{x} {y + 46} l12 26"/>'
            f'<path d="{arms}"/>')


def binary_ten_kinds():
    """Two kinds of people: one laughing at the 10, one scratching their head."""
    body = [word(130, 42, '10', 40), word(130, 64, 'kinds', 14),
            person(50, 50, 'M50 72 l-18 -14 M50 72 l18 -14'),
            '<path d="M44 46 q6 6 12 0"/><circle cx="45" cy="47" r="0.8"/><circle cx="55" cy="47" r="0.8"/>',
            word(78, 30, 'ha!', 16, 'start'),
            person(210, 50, 'M210 72 l-16 10 M210 72 l14 -10 l-4 -22'),
            '<path d="M205 56 h10"/>',
            word(232, 34, '?', 26, 'start'),
            '<path d="M104 94 C120 104 140 104 156 94" stroke-width="1.5"/>',
            word(130, 122, '1 0 in binary = two', 13)]
    save('binary-ten-kinds', 260, 132, body)


if __name__ == '__main__':
    binary_ten_kinds()
