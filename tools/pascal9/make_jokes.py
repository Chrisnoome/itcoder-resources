"""The Station Kestrel course's joke drawings (brand/pascal9-art-style.md).

Chris, 11 October 2026: "don't put the word 'joke' above a joke. rather do an
appropriate drawing". Every lesson's joke is a margin doodle: a small pixel
cartoon of the joke, with the joke itself as the caption. Uses the pieces in
make_art.py (its main() only runs when it is run itself). Writes
AIPascalCourse/public/assets/doodles/kestrel-joke-<lesson file>.svg.

  python -X utf8 tools/pascal9/make_jokes.py
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from make_art import (Pic, stars, earth, bolt, crew_member, CREW, OUT, SPACE, BLACK, NAVY, VIOLET, GREY,
                      LIGHT, WHITE, RED, ORANGE, YELLOW, GREEN, DARKGREEN, BLUE, PINK, BROWN, PEACH, TITLE)

NALEDI, PIETER, AISHA, SIPHO, LENA, KENJI = CREW
HEART = ["p.p", "ppp", ".p."]


def disc(pic, cx, cy, radius, colour):
    """A stepped pixel disc centred on cx, cy."""
    for row in range(-radius, radius):
        half = int((radius * radius - (row + 0.5) ** 2) ** 0.5 + 0.5)
        if half > 0:
            pic.rect(cx - half, cy + row, half * 2, 1, colour)


def draw_console():
    """How do you organise a party in space? You planet."""
    pic = Pic(64, 40, 'Two crew members planning a party, planets hanging up as balloons')
    stars(pic, 18, 31, 0, 22)
    # Bunting across the top
    for flag, colour in enumerate([RED, YELLOW, GREEN, BLUE, PINK, ORANGE, RED, YELLOW]):
        x = 2 + flag * 8
        pic.rect(x, 2, 8, 1, LIGHT)
        pic.sprite(x + 1, 3, ["ccccc", ".ccc.", "..c.."], {'c': colour})
    # The planets, on strings, as balloons
    for cx, cy, r, colour, string_to in [(10, 13, 4, RED, 22), (54, 13, 4, BLUE, 22)]:
        disc(pic, cx, cy, r, colour)
        pic.rect(cx, cy + r, 1, string_to - cy - r + 5, LIGHT)
    pic.px(52, 11, GREEN)
    pic.rect(55, 13, 2, 2, GREEN)
    pic.px(8, 11, ORANGE)
    pic.px(11, 15, BROWN)
    disc(pic, 32, 14, 5, ORANGE)  # Saturn, ring and all
    pic.rect(24, 14, 17, 1, YELLOW)
    pic.rect(25, 13, 2, 1, YELLOW)
    pic.rect(38, 15, 2, 1, YELLOW)
    # The two planners and their party plan
    crew_member(pic, 6, 26, LENA)
    crew_member(pic, 50, 26, KENJI)
    pic.rect(24, 22, 16, 17, BROWN)
    pic.rect(25, 23, 14, 15, WHITE)
    pic.rect(29, 21, 6, 2, GREY)
    pic.text(32, 28, 'PARTY', RED, 3.2, TITLE, 'middle')
    for line_y in (31, 34):
        pic.rect(27, line_y, 10, 1, LIGHT)
        pic.px(26, line_y, GREEN)
    pic.save('joke-console')


def draw_docking1():
    """How does the Moon cut its hair? Eclipse it."""
    pic = Pic(64, 40, 'The Moon in a barber cape, Bolt snipping its hair with scissors')
    stars(pic, 16, 41)
    # A barber's pole
    pic.rect(3, 6, 5, 30, WHITE)
    for stripe_y in range(7, 35, 4):
        pic.rect(3, stripe_y, 5, 2, RED)
        pic.rect(4, stripe_y + 2, 4, 1, BLUE)
    pic.rect(2, 4, 7, 2, LIGHT)
    pic.rect(2, 36, 7, 2, LIGHT)
    # The Moon, a little shy, under a cape
    pic.sprite(14, 28, [
        "......rrrrrrrrrrrrrrrrrr......",
        "....rrrrwwrrrrwwrrrrwwrrrrr...",
        "..rrrrrrwwrrrrwwrrrrwwrrrrrrr.",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
        "rrrrrrrrwwrrrrwwrrrrwwrrrrrrrr",
    ])
    disc(pic, 29, 19, 10, LIGHT)
    for cx, cy, colour in [(24, 14, GREY), (34, 22, GREY), (22, 23, GREY)]:
        pic.rect(cx, cy, 2, 2, colour)
    pic.rect(25, 18, 2, 2, BLACK)
    pic.rect(31, 18, 2, 2, BLACK)
    pic.rect(27, 23, 4, 1, BLACK)
    pic.rect(26, 22, 1, 1, BLACK)
    pic.rect(31, 22, 1, 1, BLACK)
    # Its hair, being cut
    pic.sprite(20, 5, [
        "..w.w..w.w..w...",
        ".ww.ww.ww.ww.ww.",
        "wwwwwwwwwwwwwww.",
        "wwwwwwwwwwwwwwww",
    ])
    # Snipped hair falling
    for hx, hy in [(42, 12), (45, 16), (41, 20), (46, 23)]:
        pic.rect(hx, hy, 1, 2, WHITE)
    # Bolt the barber, with scissors
    bolt(pic, 47, 1, ORANGE)
    pic.sprite(38, 6, [
        "ll.....",
        ".ll..oo",
        "..lllo.",
        ".ll..oo",
        "ll.....",
    ])
    pic.save('joke-docking1')


def draw_rations():
    """Why wasn't the astronaut hungry after take-off? She had just had a big launch."""
    pic = Pic(64, 40, 'An astronaut holding a huge stacked sandwich as a rocket lifts off')
    stars(pic, 16, 51, 0, 30)
    # The rocket, lifting off
    pic.sprite(43, 2, [
        "....rr....",
        "...rrrr...",
        "..wwwwww..",
        "..wwwwww..",
        "..wwbbww..",
        "..wwbbww..",
        "..wwwwww..",
        "..wwwwww..",
        "..wwwwww..",
        ".rwwwwwwr.",
        "rrwwwwwwrr",
        "rr.gggg.rr",
        "...oyyo...",
        "...oyyo...",
        "....oo....",
        "....o.....",
    ])
    for cx, cy, r in [(42, 33, 4), (49, 35, 4), (56, 33, 4), (37, 37, 3), (61, 37, 3)]:
        disc(pic, cx, cy, r, LIGHT)
    pic.rect(30, 38, 34, 2, GREY)
    # Aisha and her enormous lunch
    crew_member(pic, 10, 26, AISHA, 1)
    pic.sprite(3, 13, [
        "....BBBBBBBBBBBBBB....",
        "..BBBBBPBBBBBPBBBBBB..",
        ".BBBBBBBBBBBBBBBBBBBB.",
        "GGGdGGGGdGGGGdGGGGdGGG",
        ".BBBBBBBBBBBBBBBBBBBB.",
        "yyyyyyyyyyyyyyyyyyyyyy",
        ".rrrrrrrrrrrrrrrrrrrr.",
        "GGGGdGGGGdGGGGGdGGGGGG",
        ".BBBBBBBBBBBBBBBBBBBB.",
        "..BBBBBBBBBBBBBBBBBB..",
    ])
    for arm_x in (9, 16):  # her arms, up, holding it
        pic.rect(arm_x, 23, 1, 9, WHITE)
        pic.rect(arm_x, 23, 1, 1, BROWN)
    pic.sprite(8, 2, HEART)
    pic.text(18, 8, 'YUM', YELLOW, 3.4, TITLE, 'middle')
    pic.save('joke-rations')


def draw_readable():
    """Which key does an astronaut like best? The space bar."""
    pic = Pic(64, 40, 'An astronaut hugging a giant space bar key full of stars')
    # Some ordinary keys behind
    pic.rect(0, 2, 44, 13, GREY)
    for row, offset in [(3, 1), (8, 3)]:
        for key_x in range(offset, 40, 6):
            pic.rect(key_x, row, 5, 3, LIGHT)
            pic.rect(key_x, row + 3, 5, 1, VIOLET)
    # The space bar, actually full of space
    pic.rect(2, 19, 48, 16, LIGHT)
    pic.rect(2, 34, 48, 2, VIOLET)
    pic.rect(4, 21, 44, 12, SPACE)
    for sx, sy, colour in [(7, 24, WHITE), (12, 30, YELLOW), (19, 23, WHITE), (24, 31, LIGHT), (31, 22, YELLOW),
                           (36, 29, WHITE), (43, 24, VIOLET), (8, 31, WHITE), (16, 27, VIOLET), (40, 31, WHITE)]:
        pic.px(sx, sy, colour)
    disc(pic, 27, 27, 3, ORANGE)  # a ringed planet
    pic.rect(22, 27, 11, 1, YELLOW)
    # Lena hugging it, arms round the end, hearts rising
    crew_member(pic, 45, 22, LENA)
    for arm_y in (28, 30):
        pic.rect(39, arm_y, 7, 1, BLUE)
        pic.rect(38, arm_y, 1, 1, PEACH)
    pic.sprite(50, 15, HEART)
    pic.sprite(55, 10, HEART)
    pic.sprite(59, 5, HEART)
    pic.save('joke-readable')


def main():
    os.makedirs(OUT, exist_ok=True)
    draw_console()
    draw_docking1()
    draw_rations()
    draw_readable()


if __name__ == '__main__':
    main()
