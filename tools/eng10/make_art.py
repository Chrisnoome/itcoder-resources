"""
English Home Language Grade 10 (eng10): the art for the five sample lessons.

Writes SVGs into AIPascalCourse/public/assets/doodles/ (DesignArtFile(), lib/design.php):
openers and figures for DesignFigure(), margin jokes for Doodle().

Looks (AIResources/brand/eng-art-style.md):
  - language lessons: L1 Tracing overlay - studio paper, white card with a faint
    cobalt grid, cobalt construction lines, numbered leaders, ONE signal-red line;
  - writing and speech lessons: W1 Drafting table - the same base, stacked drafts
    with version tabs, red proof-reader's marks, a word-count chip;
  - literature: each work its own look - Romeo and Juliet as a Verona fresco,
    'Invictus' as midnight iron and one gold star.
Mascots come from brand/eng-board-src (Ratel and Quill defs): Ratel's visor band
in the Gr 10 accent, Quill's crest cut to four quills with no gold nib (Gr 10).

Run:  python make_art.py [out_dir] [name ...]
Default out_dir: ../../../AIPascalCourse/public/assets/doodles (Chris's Dropbox layout).
Names after out_dir draw only those drawings (e.g. the new ones), else all.
Written 11 October 2026 for the eng10 sample lessons. Reworked the same day after
Chris's review (AIResources/English/eng10-review-1.md): thirteen new margin jokes
(eng10-joke-genius ... eng10-joke-dropped, at the end), the opener's account
renamed for the new Text A (@naledi.writes), and the chips' middle dot fixed (it
had been saved as two wrong characters).
"""

import os
import re
import sys

HERE = os.path.dirname (os.path.abspath (__file__))
BOARD = os.path.join (HERE, '..', '..', 'brand', 'eng-board-src')

PAPER = '#f6f4ee'
INK = '#16181d'
ACC = '#2747d6'        # Grade 10 cobalt
ACC_SOFT = '#d7dcf3'
RED = '#ff4b2b'        # the one signal-red line
SERIF = "'Instrument Serif', Georgia, 'Times New Roman', serif"
SANS = "'Instrument Sans', 'Inter Tight', Arial, sans-serif"
MONO = "'JetBrains Mono', 'IBM Plex Mono', monospace"
HAND = "Kalam, 'Comic Sans MS', cursive"
DOT = chr (0xB7)   # the middle dot in the chips, built with chr() so the file stays plain ASCII


def ReadDefs (aName):
    """One mascot's defs file from the style board."""
    with open (os.path.join (BOARD, aName), encoding = 'utf-8') as source:
        return source.read ()
    # end with
# end ReadDefs


def RatelDefs ():
    """Ratel's defs with the visor band in the Grade 10 accent."""
    defs = ReadDefs ('m-ratel-defs.svg')
    return defs.replace ('stroke="#17603f"', 'stroke="' + ACC + '"')
# end RatelDefs


def QuillDefs ():
    """Quill's defs with both crests cut to four quills and no gold nib (Grade 10)."""
    defs = ReadDefs ('m-quill-defs.svg')
    for crestId in ['qu-crest', 'qu-crestF']:
        pattern = re.compile (r'(<g id="' + crestId + r'">)(.*?)(</g>)', re.S)
        found = pattern.search (defs)
        paths = re.findall (r'<path [^>]*/>', found.group (2))
        fourQuills = ''.join (paths[0:12])          # three paths a quill
        defs = defs[:found.start ()] + found.group (1) + fourQuills + found.group (3) + defs[found.end ():]
    # end for each crest
    return defs
# end QuillDefs


def Unique (aSvg, aPrefix):
    """Gives every mascot id in one drawing its own prefix, so two drawings on one page never share an id."""
    return re.sub (r'(id="|#)(rt|qu)-', lambda match: match.group (1) + aPrefix + '-' + match.group (2) + '-', aSvg)
# end Unique


def Svg (aWidth, aHeight, aLabel, aBody, aDefs = '', aPrefix = ''):
    """A whole drawing. With a prefix, its mascot ids are made unique (Unique())."""
    if 'url(#GRIDID)' in aBody:
        aDefs += ('<pattern id="GRIDID" width="16" height="16" patternUnits="userSpaceOnUse">'
                  + '<path d="M16 0V16M0 16H16" fill="none" stroke="' + ACC + '" stroke-opacity=".07" stroke-width="1"/></pattern>')
    # end if the drawing has a grid
    defs = ('<defs>' + aDefs + '</defs>') if aDefs != '' else ''
    if aPrefix != '':
        defs = Unique (defs, aPrefix)
        aBody = Unique (aBody, aPrefix)
    # end if a mascot drawing
    return ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + str (aWidth) + ' ' + str (aHeight)
            + '" role="img" aria-label="' + aLabel + '">' + defs + aBody + '</svg>\n')
# end Svg


def Text (aX, aY, aWords, aSize = 14, aFill = INK, aFamily = SANS, aWeight = '400', anAnchor = 'start', aStyle = 'normal'):
    """One line of text. & and < are escaped."""
    words = aWords.replace ('&', '&amp;').replace ('<', '&lt;')
    return ('<text x="' + str (aX) + '" y="' + str (aY) + '" font-family="' + aFamily + '" font-size="' + str (aSize)
            + '" font-weight="' + aWeight + '" font-style="' + aStyle + '" fill="' + aFill + '" text-anchor="' + anAnchor + '">'
            + words + '</text>')
# end Text


def Grid (aX, aY, aWidth, aHeight, aStep = 16):
    """The faint accent grid on a white example card, as a pattern fill (Main() gives each drawing its own pattern id)."""
    return ('<rect x="' + str (aX) + '" y="' + str (aY) + '" width="' + str (aWidth) + '" height="' + str (aHeight)
            + '" fill="url(#GRIDID)"/>')
# end Grid


def Card (aX, aY, aWidth, aHeight):
    """A white L1/W1 card with its grid and border."""
    return ('<rect x="' + str (aX) + '" y="' + str (aY) + '" width="' + str (aWidth) + '" height="' + str (aHeight)
            + '" rx="6" fill="#ffffff"/>' + Grid (aX, aY, aWidth, aHeight)
            + '<rect x="' + str (aX) + '" y="' + str (aY) + '" width="' + str (aWidth) + '" height="' + str (aHeight)
            + '" rx="6" fill="none" stroke="' + ACC_SOFT + '" stroke-width="1.5"/>')
# end Card


def Badge (aX, aY, aNumber):
    """A numbered leader badge: white number in an accent circle."""
    return ('<circle cx="' + str (aX) + '" cy="' + str (aY) + '" r="10" fill="' + ACC + '"/>'
            + Text (aX, aY + 4.5, str (aNumber), 12, '#ffffff', MONO, '700', 'middle'))
# end Badge


def Chip (aX, aY, aWords, aWidth):
    """A label chip in the accent (word counts, marks)."""
    return ('<rect x="' + str (aX) + '" y="' + str (aY) + '" width="' + str (aWidth) + '" height="24" rx="12" fill="' + ACC + '"/>'
            + Text (aX + aWidth / 2, aY + 16.5, aWords, 11.5, '#ffffff', MONO, '600', 'middle'))
# end Chip


def Tape (aX, aY, anAngle):
    """A strip of tape holding the tracing sheet down."""
    return ('<rect x="' + str (aX) + '" y="' + str (aY) + '" width="46" height="14" fill="#efe3b8" fill-opacity=".85" transform="rotate('
            + str (anAngle) + ' ' + str (aX + 23) + ' ' + str (aY + 7) + ')"/>')
# end Tape


def Progress (aX, aY, aLit, aColour, aDim):
    """The literature skeleton's 8-step progress strip (top right of an opener)."""
    marks = ''
    for step in range (8):
        fill = aColour if step < aLit else aDim
        marks += '<rect x="' + str (aX + step * 16) + '" y="' + str (aY) + '" width="12" height="6" rx="2" fill="' + fill + '"/>'
    # end for each step
    return marks
# end Progress


def Star (aX, aY, aRadius, aFill, aRotate = 0):
    """A five-pointed star."""
    import math
    points = []
    for corner in range (10):
        radius = aRadius if corner % 2 == 0 else aRadius * 0.45
        angle = math.radians (-90 + corner * 36 + aRotate)
        points.append ('%.1f,%.1f' % (aX + radius * math.cos (angle), aY + radius * math.sin (angle)))
    # end for each corner
    return '<polygon points="' + ' '.join (points) + '" fill="' + aFill + '"/>'
# end Star


# ---- the mascots ---------------------------------------------------------------

RATEL_WAVE = '''<ellipse cx="120" cy="242" rx="62" ry="7" fill="#7a5a2a" opacity=".22"/><use href="#rt-body"/>
<path d="M152 118C168 128 175 146 171 164" stroke="url(#rt-fur)" stroke-width="21" stroke-linecap="round" fill="none"/>
<use href="#rt-pencil" transform="translate(171 170) rotate(-18)"/>
<use href="#rt-paw" transform="translate(171 170)"/>
<path d="M92 118C76 108 64 92 58 70" stroke="url(#rt-fur)" stroke-width="21" stroke-linecap="round" fill="none"/>
<use href="#rt-paw" transform="translate(57 62) rotate(-15)"/>
<use href="#rt-claw" transform="translate(48 56) rotate(160)"/><use href="#rt-claw" transform="translate(54 51) rotate(175)"/><use href="#rt-claw" transform="translate(61 50) rotate(190)"/><use href="#rt-claw" transform="translate(67 53) rotate(205)"/>
<g transform="translate(122 84) scale(1.13) translate(-122 -84)"><use href="#rt-head"/>
<ellipse cx="106" cy="78" rx="6" ry="6.6" fill="#f4efe2"/><circle cx="107" cy="79" r="4.1" fill="#2b1a0c"/><circle cx="108.6" cy="77.4" r="1.5" fill="#fff"/>
<ellipse cx="138" cy="78" rx="6" ry="6.6" fill="#f4efe2"/><circle cx="139" cy="79" r="4.1" fill="#2b1a0c"/><circle cx="140.6" cy="77.4" r="1.5" fill="#fff"/>
<path d="M111 105C117 109 127 109 135 102" stroke="#0b0b0e" stroke-width="2.2" fill="none" stroke-linecap="round"/></g>'''

RATEL_POINT = '''<ellipse cx="120" cy="242" rx="62" ry="7" fill="#7a5a2a" opacity=".22"/><use href="#rt-body"/>
<path d="M152 118C170 122 186 120 200 112" stroke="url(#rt-fur)" stroke-width="21" stroke-linecap="round" fill="none"/>
<use href="#rt-pencil" transform="translate(206 108) rotate(70)"/>
<use href="#rt-paw" transform="translate(203 110)"/>
<path d="M92 124C80 140 76 156 80 170" stroke="url(#rt-fur)" stroke-width="21" stroke-linecap="round" fill="none"/>
<use href="#rt-paw" transform="translate(80 172) rotate(80)"/>
<g transform="translate(122 84) scale(1.13) translate(-122 -84)"><use href="#rt-head"/>
<path d="M98 70L113 74M146 70L131 74" stroke="#c4c4d0" stroke-width="3" stroke-linecap="round"/>
<ellipse cx="106" cy="80" rx="5.8" ry="5.2" fill="#f4efe2"/><circle cx="108" cy="81" r="3.6" fill="#2b1a0c"/><circle cx="109.3" cy="79.8" r="1.2" fill="#fff"/>
<ellipse cx="138" cy="80" rx="5.8" ry="5.2" fill="#f4efe2"/><circle cx="140" cy="81" r="3.6" fill="#2b1a0c"/><circle cx="141.3" cy="79.8" r="1.2" fill="#fff"/>
<path d="M112 105C118 103 126 103 132 105" stroke="#0b0b0e" stroke-width="2.2" fill="none" stroke-linecap="round"/></g>'''

QUILL_STAND = '''<ellipse cx="140" cy="243" rx="70" ry="6" fill="#2b3a55" opacity=".2"/>
<use href="#qu-tail"/>{legfar}<use href="#qu-thighfar"/><use href="#qu-legnear"/>
<use href="#qu-body"/><use href="#qu-thighnear"/>
<use href="#qu-neck"/>
<path d="M104 96L95 90 95 102Z" fill="#c8372d"/><path d="M104 96L113 90 113 102Z" fill="#a82a22"/><circle cx="104" cy="96" r="2.8" fill="#e04a3c"/>
<g transform="translate(97 58) scale(1.38) translate(-97 -58)"><use href="#qu-crest"/><use href="#qu-head"/>
<circle cx="88.5" cy="{eyey}" r="4.4" fill="#2a160c"/><circle cx="87" cy="{glinty}" r="1.5" fill="#fff"/>
<path d="M83 42Q88 38.5 94 42" stroke="#1d1e22" stroke-width="1.6" fill="none" stroke-linecap="round"/>
<path d="M84 41.5q-4-2-6-7M87 40q-2-4-2-9M90.5 39.8q0-5 2.5-9M93.5 41q3-4 6.5-6" stroke="#1d1e22" stroke-width="1.3" fill="none" stroke-linecap="round"/></g>'''


def Ratel (aPose, aX, aY, aScale):
    """Ratel, placed."""
    return '<g transform="translate(' + str (aX) + ' ' + str (aY) + ') scale(' + str (aScale) + ')">' + aPose + '</g>'
# end Ratel


def Quill (aX, aY, aScale, aOneLeg = False, aLookUp = False):
    """Quill standing, placed. One leg tucked up, or eyes to the sky, when a joke needs it."""
    pose = QUILL_STAND.replace ('{legfar}', '' if aOneLeg else '<use href="#qu-legfar"/>')
    pose = pose.replace ('{eyey}', '41.5' if aLookUp else '44.5').replace ('{glinty}', '40' if aLookUp else '43')
    return '<g transform="translate(' + str (aX) + ' ' + str (aY) + ') scale(' + str (aScale) + ')">' + pose + '</g>'
# end Quill


def JokeFrame (aBody, aBackground):
    """A margin drawing's frame: 300 x 200, soft studio paper with an accent rule."""
    return ('<rect width="300" height="200" rx="10" fill="' + aBackground + '"/>'
            + '<rect x="4" y="4" width="292" height="192" rx="8" fill="none" stroke="' + ACC + '" stroke-opacity=".35" stroke-width="2"/>'
            + aBody)
# end JokeFrame


# ---- lesson 1: tone, diction and intention (L1) ---------------------------------

def OpenTone ():
    body = '<rect width="680" height="300" fill="' + PAPER + '"/>'
    body += Card (40, 30, 360, 220)
    # a pupil's post on a made-up app: avatar, name, lines of text
    body += '<circle cx="70" cy="62" r="14" fill="' + ACC_SOFT + '"/>' + Text (92, 58, '@naledi.writes', 13, INK, MONO, '600') + Text (92, 74, 'Spill - Discover', 11, '#6b7080', MONO)
    widths = [300, 280, 310, 250, 295, 270, 180]
    line = 0
    while line < len (widths):
        body += '<rect x="60" y="' + str (96 + line * 20) + '" width="' + str (widths[line]) + '" height="8" rx="4" fill="#c9ccd6"/>'
        line += 1
    # end while lines
    # the tracing sheet, taped over the right of the card
    body += '<rect x="210" y="20" width="250" height="250" fill="#eef2ff" fill-opacity=".55" stroke="' + ACC + '" stroke-opacity=".25"/>'
    body += Tape (230, 12, -6) + Tape (400, 12, 5) + Tape (230, 262, 4) + Tape (400, 262, -5)
    body += '<rect x="226" y="90" width="92" height="20" rx="3" fill="none" stroke="' + ACC + '" stroke-width="1.6"/>'
    body += '<rect x="292" y="130" width="78" height="20" rx="3" fill="none" stroke="' + ACC + '" stroke-width="1.6"/>'
    body += '<path d="M60 222H300" stroke="' + RED + '" stroke-width="3" stroke-linecap="round"/>'
    # leaders to callouts
    body += '<path d="M318 100H500" stroke="' + ACC + '" stroke-width="1.4" stroke-dasharray="4 3"/>' + Badge (510, 100, 1) + Text (528, 105, 'tone', 18, INK, SERIF, '400', 'start', 'italic')
    body += '<path d="M370 140H500" stroke="' + ACC + '" stroke-width="1.4" stroke-dasharray="4 3"/>' + Badge (510, 140, 2) + Text (528, 145, 'diction', 18, INK, SERIF, '400', 'start', 'italic')
    body += '<path d="M300 222H500" stroke="' + ACC + '" stroke-width="1.4" stroke-dasharray="4 3"/>' + Badge (510, 222, 3) + Text (528, 227, 'intention', 18, INK, SERIF, '400', 'start', 'italic')
    body += Text (40, 284, 'Reading for tone, diction and intention', 22, INK, SERIF, '400', 'start', 'italic')
    return Svg (680, 300, 'A post on a made-up app with a sheet of tracing paper taped over it. Words are outlined in blue and joined to three labels: tone, diction and intention. One red line runs under the key idea.', body)
# end OpenTone


def TraceTone ():
    body = '<rect width="680" height="360" fill="' + PAPER + '"/>'
    body += Card (24, 24, 410, 312)
    lines = [
        'Breaking news, apparently: my',
        'generation\'s brains have melted. A',
        'parenting account with 400 000',
        'followers says so, in a video that',
        'is - wait for it - forty seconds',
        'long. We can\'t read a book, can\'t',
        'sit through a film ... Teenagers',
        'now have "the attention span of a',
        'goldfish". Poor goldfish. Nobody',
        'asked it.',
    ]
    size = 14
    charWidth = size * 0.6          # a monospace face, so a word's place can be worked out
    left = 40
    row = 0
    while row < len (lines):
        body += Text (left, 56 + row * 28, lines[row], size, INK, MONO)
        row += 1
    # end while lines
    body += '<rect x="20" y="16" width="420" height="330" fill="#eef2ff" fill-opacity=".35"/>'
    body += Tape (40, 8, -5) + Tape (370, 8, 6)

    def Outline (aRow, aWords, aEnd = None):
        """Outlines aWords on line aRow (to aEnd, if the outline runs on); gives the right edge and middle."""
        first = lines[aRow].index (aWords)
        last = first + len (aWords) if aEnd is None else len (lines[aRow])
        x = left + first * charWidth - 3
        width = (last - first) * charWidth + 6
        y = 56 + aRow * 28 - 15
        return ('<rect x="%.1f" y="%d" width="%.1f" height="21" rx="3" fill="none" stroke="%s" stroke-width="1.6"/>' % (x, y, width, ACC)), x + width, y + 10
    # end Outline

    marks = [(0, 'apparently', 1), (4, 'wait for it', 2), (8, 'Poor goldfish.', 3)]
    for row, words, number in marks:
        shape, rightEdge, middle = Outline (row, words)
        body += shape
        body += '<path d="M%.1f %dH452" stroke="%s" stroke-width="1.3" stroke-dasharray="4 3"/>' % (rightEdge, middle, ACC) + Badge (462, middle, number)
    # end for each mark
    body += Text (480, 51, '"apparently"', 14, INK, MONO, '600') + Text (480, 69, 'she doubts the claim', 13, '#44495a')
    body += Text (480, 163, '"wait for it"', 14, INK, MONO, '600') + Text (480, 181, 'mock suspense', 13, '#44495a')
    body += Text (480, 275, '"Poor goldfish."', 14, INK, MONO, '600') + Text (480, 293, 'pretend sympathy', 13, '#44495a')
    body += '<path d="M480 232H650" stroke="' + RED + '" stroke-width="3" stroke-linecap="round"/>'
    body += Text (480, 222, 'TONE: mocking', 15, RED, MONO, '700')
    return Svg (680, 360, 'Paragraph 1 of the article under a tracing sheet. Three phrases are outlined and numbered: apparently, wait for it, and Poor goldfish. A red line names the tone: mocking.', body)
# end TraceTone


def HushAd ():
    body = '<rect width="520" height="620" rx="18" fill="#17123a"/>'
    body += '<rect x="14" y="14" width="492" height="592" rx="12" fill="none" stroke="#3a3270" stroke-width="2"/>'
    body += Text (260, 78, 'THEY BUILT IT', 40, '#ffffff', SANS, '800', 'middle') + Text (260, 124, 'TO HOOK YOU.', 40, '#ff6b9a', SANS, '800', 'middle')
    # a phone as a slot machine
    body += '<rect x="150" y="160" width="220" height="300" rx="26" fill="#2b2466" stroke="#8f86ff" stroke-width="3"/>'
    body += '<rect x="170" y="200" width="180" height="96" rx="8" fill="#0d0a24"/>'
    body += '<rect x="178" y="208" width="50" height="80" rx="4" fill="#f4f1ff"/><rect x="235" y="208" width="50" height="80" rx="4" fill="#f4f1ff"/><rect x="292" y="208" width="50" height="80" rx="4" fill="#f4f1ff"/>'
    body += '<path d="M203 260c-14-10-14-24-4-26 5-1 4 4 4 4s0-5 5-4c10 2 10 16-5 26z" fill="#ff4f7a"/>'
    body += '<path d="M260 270c-12-4-12-20 0-32 2 10 10 10 8 20 4-2 4-8 4-8 6 10 0 22-12 20z" fill="#ff8a3d"/>'
    body += '<circle cx="317" cy="248" r="16" fill="#ff2d2d"/>' + Text (317, 254, '3', 17, '#ffffff', SANS, '800', 'middle')
    body += '<rect x="186" y="318" width="148" height="34" rx="17" fill="#8f86ff"/>' + Text (260, 341, 'SPIN AGAIN', 15, '#17123a', SANS, '800', 'middle')
    body += '<rect x="190" y="372" width="140" height="8" rx="4" fill="#4a4290"/><rect x="190" y="390" width="110" height="8" rx="4" fill="#4a4290"/>'
    body += '<rect x="230" y="430" width="60" height="6" rx="3" fill="#8f86ff"/>'
    # the lever
    body += '<path d="M370 300h34v-90" stroke="#c9c4ff" stroke-width="10" stroke-linecap="round" fill="none"/><circle cx="404" cy="200" r="16" fill="#ff4f7a"/>'
    body += Text (260, 508, 'Your attention is what they sell.', 21, '#ffffff', SANS, '600', 'middle')
    body += Text (260, 536, 'Take it back.', 21, '#ffffff', SANS, '800', 'middle')
    body += Text (260, 560, 'Hush locks your scroll-traps for 25 minutes. Free for students.', 12.5, '#b9b3ee', SANS, '400', 'middle')
    # the made-up logo: a crescent and the word hush
    body += '<path d="M224 598a14 14 0 1 0 14-20a11 11 0 1 1-14 20z" fill="#ffd36b"/>' + Text (250, 596, 'hush', 22, '#ffd36b', SANS, '800')
    return Svg (520, 620, 'Text B, an in-app advert for a made-up focus app called Hush. A phone is drawn as a slot machine whose reels show a heart, a flame and a red notification dot with the number 3; a lever sticks out of its side and a button says SPIN AGAIN. The headline reads: THEY BUILT IT TO HOOK YOU. Below: Your attention is what they sell. Take it back. Small print: Hush locks your scroll-traps for 25 minutes. Free for students.', body)
# end HushAd


def JokeTone ():
    body = '<circle cx="216" cy="122" r="58" fill="#e6f1ff" stroke="' + ACC + '" stroke-width="2.5"/>'
    body += '<path d="M162 112h108" stroke="' + ACC + '" stroke-opacity=".4" stroke-width="2"/>'
    body += '<path d="M200 132c10-14 34-14 42 0c-8 14-32 14-42 0z" fill="#ff8a3d"/><path d="M242 132l14-10v20z" fill="#ff8a3d"/><circle cx="212" cy="129" r="2.4" fill="' + INK + '"/>'
    body += '<circle cx="262" cy="100" r="4" fill="none" stroke="' + ACC + '" stroke-width="1.5"/><circle cx="270" cy="86" r="3" fill="none" stroke="' + ACC + '" stroke-width="1.5"/>'
    body += '<path d="M190 70c10-6 24-6 32 0" stroke="' + RED + '" stroke-width="2.5" fill="none" stroke-linecap="round"/>'
    body += Text (206, 60, 'circular?', 14, RED, HAND, '700', 'middle')
    body += Ratel (RATEL_POINT, 6, 30, 0.62)
    return Svg (300, 200, 'Ratel the honey badger points a red pencil at a goldfish in a round bowl; the word circular? is written above the bowl in red.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jt')
# end JokeTone


# ---- lesson 2: the unseen poem ('Invictus') -----------------------------------------

def OpenUnseen ():
    body = '<rect width="680" height="300" fill="#0e1124"/>'
    stars = [(60, 40), (120, 80), (200, 30), (290, 60), (360, 26), (430, 90), (520, 44), (600, 70), (640, 30), (90, 140), (330, 120), (560, 130)]
    for starX, starY in stars:
        body += '<circle cx="' + str (starX) + '" cy="' + str (starY) + '" r="1.4" fill="#cfd6ff"/>'
    # end for each star
    body += Star (566, 82, 18, '#e2b33c')
    # the strait gate: an iron arch with bars
    body += '<path d="M250 260V150a90 90 0 0 1 180 0V260" fill="none" stroke="#5b6386" stroke-width="10"/>'
    bar = 270
    while bar <= 410:
        body += '<path d="M' + str (bar) + ' 260V' + ('118' if 300 <= bar <= 380 else '150') + '" stroke="#5b6386" stroke-width="5"/>'
        bar += 20
    # end while bars
    body += '<path d="M250 200H430" stroke="#5b6386" stroke-width="5"/>'
    body += '<rect x="0" y="260" width="680" height="40" fill="#07091a"/>'
    body += Progress (528, 18, 1, '#e2b33c', '#2d3352')
    body += Text (36, 236, 'The unseen poem', 34, '#f1e6c8', SERIF, '400', 'start', 'italic')
    body += Text (36, 262, '\'Invictus\' - W. E. Henley, 1875', 14, '#b8b2a0', MONO)
    return Svg (680, 300, 'Night: a black sky with small stars and one large gold star. An iron gate stands in the middle. The title reads The unseen poem, with Invictus by W. E. Henley, 1875, under it.', body)
# end OpenUnseen


def TraceSteps ():
    body = '<rect width="680" height="230" fill="' + PAPER + '"/>'
    steps = [('T', 'Title', 'What does it', 'promise?'), ('R', 'Read twice', 'once for sense,', 'once with a pencil'),
             ('A', 'Ask', 'who speaks, where,', 'to whom, about what?'), ('C', 'Change', 'where does the', 'poem turn?'),
             ('E', 'Effect', 'what does each', 'device DO?')]
    column = 0
    while column < len (steps):
        letter, name, lineOne, lineTwo = steps[column]
        left = 20 + column * 130
        body += Card (left, 30, 120, 170)
        body += Text (left + 60, 92, letter, 48, ACC, SERIF, '400', 'middle', 'italic')
        body += Text (left + 60, 124, name, 15, INK, SANS, '700', 'middle')
        body += Text (left + 60, 150, lineOne, 11.5, '#44495a', SANS, '400', 'middle') + Text (left + 60, 166, lineTwo, 11.5, '#44495a', SANS, '400', 'middle')
        if column < len (steps) - 1:
            body += '<path d="M' + str (left + 120) + ' 115h10" stroke="' + ACC + '" stroke-width="2"/>'
        # end if not the last step
        column += 1
    # end while steps
    body += '<path d="M20 214H660" stroke="' + RED + '" stroke-width="3" stroke-linecap="round"/>'
    return Svg (680, 230, 'The TRACE method in five cards: T for Title, R for Read twice, A for Ask who speaks, C for Change (where the poem turns), E for Effect (what each device does).', body)
# end TraceSteps


def JokeUnseen ():
    body = Ratel (RATEL_WAVE, 10, 26, 0.62)
    body += '<g transform="rotate(-12 86 58)"><rect x="58" y="50" width="56" height="14" rx="4" fill="#fdf3e1" stroke="#c9b48a" stroke-width="1.2"/><path d="M80 52v10M92 52v10" stroke="#e57b6c" stroke-width="1.5"/></g>'
    body += '<rect x="186" y="44" width="92" height="104" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>'
    body += '<rect x="186" y="44" width="92" height="26" rx="6" fill="' + ACC + '"/>' + Text (232, 62, 'TUESDAY', 13, '#ffffff', MONO, '700', 'middle')
    body += Text (232, 120, '14', 38, INK, SERIF, '400', 'middle', 'italic')
    return Svg (300, 200, 'Ratel waves cheerfully with a plaster stuck across its head, next to a calendar page that says Tuesday.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'ju')
# end JokeUnseen


# ---- lesson 3: Romeo and Juliet, Act 1 (Verona fresco) ----------------------------------

FRESCO_WALL = '#d9a76c'
FRESCO_DEEP = '#b5643e'
FRESCO_SKY = '#a9bfcc'
FRESCO_INK = '#4a2a1c'


def OpenRomeo ():
    body = '<rect width="680" height="300" fill="' + FRESCO_SKY + '"/>'
    body += '<rect y="150" width="680" height="150" fill="' + FRESCO_WALL + '"/>'
    # plaster cracks
    body += '<path d="M40 170l20 16-6 18M600 160l-14 22 8 20M320 280l18-14 12 10" stroke="#9b6b45" stroke-width="1.2" fill="none" opacity=".6"/>'
    # a Romanesque arch with a balcony
    body += '<path d="M380 300V170a80 80 0 0 1 160 0V300" fill="' + FRESCO_DEEP + '"/><path d="M400 300V176a60 60 0 0 1 120 0V300" fill="#3b2a3a"/>'
    body += '<rect x="370" y="214" width="180" height="12" fill="#e8c99a"/>'
    baluster = 382
    while baluster <= 538:
        body += '<rect x="' + str (baluster) + '" y="226" width="6" height="26" fill="#e8c99a"/>'
        baluster += 14
    # end while balusters
    body += '<rect x="370" y="252" width="180" height="8" fill="#e8c99a"/>'
    # two banners: Montague (left), Capulet (right)
    body += '<path d="M290 60h50v100l-25-16-25 16z" fill="#4f6d8c"/>' + Text (315, 98, 'M', 30, '#f1e6c8', SERIF, '400', 'middle', 'italic')
    body += '<path d="M580 60h50v100l-25-16-25 16z" fill="#a8322d"/>' + Text (605, 98, 'C', 30, '#f1e6c8', SERIF, '400', 'middle', 'italic')
    # two stars that cross
    body += Star (438, 64, 16, '#e9c46a', 12) + Star (482, 64, 16, '#e9c46a', -12)
    body += '<path d="M420 86L500 42M420 42L500 86" stroke="#e9c46a" stroke-width="2" opacity=".7"/>'
    body += Progress (40, 22, 2, FRESCO_DEEP, '#e8dccb')
    body += Text (30, 270, 'Romeo and Juliet', 32, FRESCO_INK, SERIF, '400', 'start', 'italic')
    body += Text (30, 290, 'The Prologue and Act 1', 13, FRESCO_INK, MONO)
    return Svg (680, 300, 'A faded Verona fresco: a terracotta wall with an arched balcony, a blue-grey Montague banner on the left, a red Capulet banner on the right and two gold stars crossing in the sky above.', body)
# end OpenRomeo


def RomeoHouses ():
    body = '<rect width="680" height="380" fill="#f3e6d2"/>'
    body += '<rect x="20" y="20" width="200" height="340" rx="8" fill="#e3ebf2" stroke="#4f6d8c" stroke-width="2"/>'
    body += '<rect x="460" y="20" width="200" height="340" rx="8" fill="#f6dfd9" stroke="#a8322d" stroke-width="2"/>'
    body += '<rect x="240" y="40" width="200" height="300" rx="8" fill="#fbf4e8" stroke="#b08a5a" stroke-width="1.5" stroke-dasharray="5 4"/>'
    body += Text (120, 50, 'House of Montague', 17, '#2f4a66', SERIF, '400', 'middle', 'italic')
    body += Text (560, 50, 'House of Capulet', 17, '#7a1f1b', SERIF, '400', 'middle', 'italic')
    body += Text (340, 66, 'Verona', 17, FRESCO_INK, SERIF, '400', 'middle', 'italic')
    montague = [('Lord and Lady Montague', 'Romeo\'s parents'), ('Romeo', 'their only son'), ('Benvolio', 'Romeo\'s cousin, a peacemaker'), ('Abram, Balthasar', 'servants')]
    capulet = [('Lord and Lady Capulet', 'Juliet\'s parents'), ('Juliet', 'their only daughter, 13'), ('Tybalt', 'Juliet\'s cousin, a fighter'), ('The Nurse', 'raised Juliet'), ('Sampson, Gregory', 'servants')]
    verona = [('Prince Escalus', 'rules Verona'), ('Mercutio', 'the Prince\'s kinsman,'), ('', 'Romeo\'s friend'), ('Count Paris', 'the Prince\'s kinsman,'), ('', 'wants to marry Juliet'), ('Friar Laurence', 'a priest, Romeo\'s adviser')]
    row = 0
    while row < len (montague):
        name, note = montague[row]
        body += Text (36, 92 + row * 50, name, 14, INK, SANS, '700') + Text (36, 110 + row * 50, note, 12, '#44495a')
        row += 1
    # end while Montagues
    row = 0
    while row < len (capulet):
        name, note = capulet[row]
        body += Text (476, 92 + row * 50, name, 14, INK, SANS, '700') + Text (476, 110 + row * 50, note, 12, '#44495a')
        row += 1
    # end while Capulets
    row = 0
    while row < len (verona):
        name, note = verona[row]
        top = 98 + row * 34
        if name != '':
            body += Text (256, top, name, 14, INK, SANS, '700')
        # end if a name on this row
        body += Text (256, top + 16 if name != '' else top - 2, note, 12, '#44495a')
        row += 1
    # end while Verona
    # the feud and the love
    body += '<path d="M220 350H460" stroke="#a8322d" stroke-width="3"/>' + Text (340, 372, 'the ancient grudge', 12, '#a8322d', MONO, '600', 'middle')
    return Svg (680, 380, 'Who is who in Romeo and Juliet: the House of Montague on the left (Lord and Lady Montague, Romeo, Benvolio, the servants Abram and Balthasar), the House of Capulet on the right (Lord and Lady Capulet, Juliet, Tybalt, the Nurse, the servants Sampson and Gregory), and Verona in the middle (Prince Escalus, Mercutio, Count Paris, Friar Laurence). A red line marks the ancient grudge between the two houses.', body)
# end RomeoHouses


def JokeRomeo ():
    body = Ratel (RATEL_POINT, 6, 30, 0.62)
    body += '<rect x="170" y="40" width="112" height="120" rx="6" fill="#fff8ec" stroke="' + FRESCO_DEEP + '" stroke-width="2"/>'
    body += Text (226, 66, 'PROLOGUE', 12, FRESCO_INK, MONO, '700', 'middle') + Text (226, 82, 'review', 12, FRESCO_INK, HAND, '700', 'middle')
    body += Star (206, 118, 16, '#e9c46a', 14) + Star (246, 118, 16, '#e9c46a', -14)
    body += '<path d="M192 132L262 104M192 104L262 132" stroke="' + RED + '" stroke-width="2"/>'
    return Svg (300, 200, 'Ratel points a red pencil at a review card for the Prologue that shows two crossed gold stars.', JokeFrame (body, '#fbf3e6'), RatelDefs (), 'jr')
# end JokeRomeo


# ---- lesson 4: the argumentative essay (W1) ------------------------------------------------

def Sheet (aX, aY, aWidth, aHeight, aTab, aTabX):
    """A draft sheet with its version tab."""
    return ('<rect x="' + str (aTabX) + '" y="' + str (aY - 16) + '" width="34" height="18" rx="4" fill="' + ACC + '"/>'
            + Text (aTabX + 17, aY - 3, aTab, 11, '#ffffff', MONO, '700', 'middle')
            + Card (aX, aY, aWidth, aHeight))
# end Sheet


def OpenArgue ():
    body = '<rect width="680" height="300" fill="' + PAPER + '"/>'
    body += Sheet (70, 50, 300, 200, 'v1', 80) + Sheet (55, 66, 300, 200, 'v2', 130)
    body += Sheet (40, 82, 300, 196, 'v3', 180)
    # the essay laid out as blocks with construction lines
    blocks = [(100, 'INTRO + STANCE'), (130, 'REASON 1'), (160, 'REASON 2'), (190, 'REASON 3'), (220, 'REBUTTAL'), (250, 'CONCLUSION')]
    for top, label in blocks:
        body += '<rect x="60" y="' + str (top) + '" width="200" height="22" rx="3" fill="#f2f4fc" stroke="' + ACC + '" stroke-width="1.3"/>'
        body += Text (70, top + 15, label, 11, ACC, MONO, '600')
    # end for each block
    body += '<path d="M272 100V272M266 100h12M266 272h12" stroke="' + ACC + '" stroke-width="1.2"/>'
    # proof-reader's marks
    body += '<path d="M228 140l6-10 6 10" stroke="' + RED + '" stroke-width="2" fill="none"/>' + Text (234, 126, 'because', 12, RED, HAND, '700', 'middle')
    body += Text (400, 128, 'One side.', 30, INK, SERIF, '400', 'start', 'italic') + Text (400, 166, 'Well defended.', 30, INK, SERIF, '400', 'start', 'italic')
    body += Chip (400, 194, 'thesis  ' + DOT + '  PEEL  ' + DOT + '  rebuttal', 250)
    body += Text (400, 72, 'The argumentative essay', 20, INK, SERIF, '400', 'start', 'italic')
    return Svg (680, 300, 'A drafting table: three stacked drafts with tabs v1, v2 and v3. The top draft shows the essay as blocks: intro and stance, three reasons, a rebuttal and a conclusion, with a red caret adding the word because. A chip reads: thesis, PEEL, rebuttal.', body)
# end OpenArgue


def ArgueLayout ():
    body = '<rect width="680" height="440" fill="' + PAPER + '"/>'
    body += Card (20, 20, 640, 400)
    rows = [
        (40, 'INTRODUCTION', 'hook  ' + DOT + '  the issue  ' + DOT + '  your stance in one sentence (the thesis)', '~50 words'),
        (100, 'BODY 1', 'P point  ' + DOT + '  E evidence  ' + DOT + '  E explain  ' + DOT + '  L link back to the thesis', '~70 words'),
        (160, 'BODY 2', 'a second reason - a different one, not the first in new words', '~70 words'),
        (220, 'BODY 3', 'your strongest reason, saved for last', '~70 words'),
        (280, 'REBUTTAL', 'the other side\'s best point  ' + DOT + '  why it does not change your mind', '~50 words'),
        (340, 'CONCLUSION', 'stance again in new words  ' + DOT + '  a strong last line  ' + DOT + '  no new points', '~40 words'),
    ]
    for top, label, note, words in rows:
        body += '<rect x="40" y="' + str (top) + '" width="128" height="44" rx="4" fill="' + ACC + '"/>'
        body += Text (104, top + 27, label, 12.5, '#ffffff', MONO, '700', 'middle')
        body += '<rect x="176" y="' + str (top) + '" width="380" height="44" rx="4" fill="#f2f4fc" stroke="' + ACC_SOFT + '" stroke-width="1.2"/>'
        body += Text (188, top + 27, note, 12.5, INK, SANS)
        body += Text (566, top + 27, words, 12, ACC, MONO, '600')
    # end for each row
    body += '<path d="M176 89c-40 60-40 210 0 270" stroke="' + RED + '" stroke-width="2.5" fill="none"/>'
    body += Text (34, 412, 'the thesis runs through every paragraph', 12, RED, MONO, '700')
    body += Chip (420, 392, 'one side, all the way', 226)
    return Svg (680, 440, 'The plan of an argumentative essay drawn as a layout: introduction with the thesis, three body paragraphs built Point, Evidence, Explain, Link, a rebuttal and a conclusion, with rough word counts. A red line shows the thesis running through every paragraph.', body)
# end ArgueLayout


def JokeArgue ():
    body = Quill (-10, 6, 0.74, True)
    body += '<rect x="176" y="50" width="108" height="64" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2.4"/>'
    body += Text (230, 78, 'ONE SIDE', 15, INK, MONO, '800', 'middle') + Text (230, 100, 'ONLY', 15, RED, MONO, '800', 'middle')
    body += '<path d="M200 114v60" stroke="#8a6b45" stroke-width="5"/>'
    return Svg (300, 200, 'Quill the secretary bird stands on one leg beside a sign that says ONE SIDE ONLY.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'ja')
# end JokeArgue


# ---- lesson 5: the prepared speech (W1) ---------------------------------------------------------

def CueCard (aX, aY, anAngle, aNumber, aLines):
    """A small cue card with a number and keyword lines."""
    card = ('<g transform="rotate(' + str (anAngle) + ' ' + str (aX + 75) + ' ' + str (aY + 50) + ')">'
            + '<rect x="' + str (aX) + '" y="' + str (aY) + '" width="150" height="100" rx="6" fill="#ffffff" stroke="' + ACC_SOFT + '" stroke-width="1.5"/>'
            + '<circle cx="' + str (aX + 18) + '" cy="' + str (aY + 18) + '" r="10" fill="' + ACC + '"/>' + Text (aX + 18, aY + 22.5, str (aNumber), 12, '#ffffff', MONO, '700', 'middle'))
    row = 0
    while row < len (aLines):
        card += Text (aX + 36, aY + 24 + row * 22, aLines[row], 12.5, INK, SANS, '600')
        row += 1
    # end while lines
    return card + '</g>'
# end CueCard


def OpenSpeech ():
    body = '<rect width="680" height="300" fill="' + PAPER + '"/>'
    # a lectern and a microphone
    body += '<path d="M520 280l20-120h100l20 120z" fill="#e5e8f4" stroke="' + ACC + '" stroke-width="2"/>'
    body += '<rect x="530" y="150" width="120" height="14" rx="3" fill="' + ACC + '"/>'
    body += '<path d="M588 150c0-30 10-50 30-60" stroke="' + INK + '" stroke-width="3" fill="none"/><rect x="612" y="74" width="16" height="26" rx="8" fill="' + INK + '" transform="rotate(30 620 87)"/>'
    body += CueCard (24, 80, -6, 1, ['HOOK: two', 'hours - gone?', 'PAUSE']) + CueCard (184, 96, -1, 2, ['Point 1:', 'the red dot', 'look up']) + CueCard (344, 112, 4, 3, ['Point 2:', 'no-scroll day', '"Ninety."'])
    body += Chip (420, 252, 'hook  ' + DOT + '  points  ' + DOT + '  last line', 240)
    body += Text (40, 40, 'The prepared speech', 22, INK, SERIF, '400', 'start', 'italic')
    return Svg (680, 300, 'Three numbered cue cards fanned out on a drafting table, each with a few keywords, next to a lectern with a microphone. A chip reads: hook, points, last line.', body)
# end OpenSpeech


def CueCards ():
    body = '<rect width="680" height="300" fill="' + PAPER + '"/>'
    # not like this: a card crammed with sentences, crossed out
    body += Card (30, 50, 290, 200)
    body += Text (175, 36, 'Not like this', 16, RED, SANS, '700', 'middle')
    lines = ['Good morning everyone, today I am going to', 'talk to you about something that affects all', 'of us, which is the way that apps are designed', 'to keep us scrolling for hours and hours and', 'how this can make us feel tired and anxious', 'and also how we can do something about it if', 'we decide to try a no-scroll day like my...']
    row = 0
    while row < len (lines):
        body += Text (44, 78 + row * 22, lines[row], 11, '#44495a', SANS)
        row += 1
    # end while lines
    body += '<path d="M40 60L310 240M310 60L40 240" stroke="' + RED + '" stroke-width="3" stroke-linecap="round"/>'
    # like this
    body += Card (360, 50, 290, 200)
    body += Text (505, 36, 'Like this', 16, ACC, SANS, '700', 'middle')
    body += '<circle cx="384" cy="74" r="12" fill="' + ACC + '"/>' + Text (384, 79, '2', 13, '#ffffff', MONO, '700', 'middle')
    body += Text (406, 80, 'POINT 1: the red dot', 15, INK, SANS, '700')
    body += Text (380, 112, '- built to grab you', 13.5, INK, SANS) + Text (380, 136, '- 2 hours gone: my story', 13.5, INK, SANS)
    body += Text (380, 168, '"something happened!"', 13.5, INK, SERIF, '400', 'start', 'italic')
    body += Text (380, 204, 'PAUSE  ' + DOT + '  LOOK UP', 13, ACC, MONO, '700')
    body += Text (380, 232, 'next: no-scroll Sunday', 12, '#6b7080', SANS)
    return Svg (680, 300, 'Two cue cards compared. Not like this: a card crammed with full sentences, crossed out in red. Like this: a numbered card with a heading, two short keyword lines, one quotation written in full, a delivery note PAUSE and LOOK UP in blue, and a reminder of the next point.', body)
# end CueCards


def JokeSpeech ():
    body = '<path d="M150 20v18" stroke="#9aa3ae" stroke-width="2"/><path d="M134 38h32l-6 14h-20z" fill="#ffd36b" stroke="#c99a1a" stroke-width="1.5"/>'
    body += '<path d="M138 60l-10 10M162 60l10 10M150 62v14" stroke="#ffd36b" stroke-width="2" stroke-linecap="round"/>'
    body += Quill (4, 14, 0.7, False, True)
    body += '<rect x="186" y="108" width="98" height="62" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>'
    body += '<circle cx="200" cy="122" r="8" fill="' + ACC + '"/>' + Text (200, 126, '1', 10, '#ffffff', MONO, '700', 'middle')
    body += Text (236, 150, 'LOOK UP', 15, INK, MONO, '800', 'middle')
    return Svg (300, 200, 'Quill the secretary bird gazes up at a ceiling lamp, holding a cue card that says LOOK UP.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'js')
# end JokeSpeech


# ---- rework, 11 October 2026 (Chris's review): more margin jokes ---------------------
# Each drawing gets its own id prefix (the last argument of Svg()), so no two drawings on
# one page share a pattern or mascot id.

def Phone (aX, aY, aWidth, aHeight):
    """A plain phone outline with its screen."""
    return ('<rect x="' + str (aX) + '" y="' + str (aY) + '" width="' + str (aWidth) + '" height="' + str (aHeight) + '" rx="14" fill="#2b2f3a"/>'
            + '<rect x="' + str (aX + 7) + '" y="' + str (aY + 14) + '" width="' + str (aWidth - 14) + '" height="' + str (aHeight - 28) + '" rx="6" fill="#ffffff"/>')
# end Phone


def JokeGenius ():
    body = Ratel (RATEL_POINT, 0, 34, 0.6)
    body += Phone (176, 26, 104, 150)
    body += '<circle cx="196" cy="62" r="9" fill="' + ACC_SOFT + '"/>' + Text (210, 58, '@someone', 9.5, '#6b7080', MONO)
    body += '<rect x="188" y="76" width="82" height="46" rx="8" fill="#eef1fb"/>'
    body += Text (229, 96, 'Great job,', 13, INK, SANS, '700', 'middle') + Text (229, 113, 'genius', 13, INK, SANS, '700', 'middle')
    body += '<path d="M200 140l6 6 12-14" stroke="#9aa3ae" stroke-width="2" fill="none"/>'
    body += Text (262, 152, '?!', 22, RED, HAND, '700', 'middle')
    return Svg (300, 200, 'Ratel frowns at a phone showing the comment Great job, genius, with a red ?! beside it.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jg')
# end JokeGenius


def JokeSlim ():
    body = Ratel (RATEL_POINT, 0, 34, 0.6)
    body += '<g transform="rotate(-4 228 66)"><rect x="180" y="40" width="98" height="52" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>'
    body += Text (229, 64, 'SLIM', 17, INK, MONO, '800', 'middle') + '<path d="M218 74q11 9 22 0" stroke="#1d7a3e" stroke-width="2.4" fill="none" stroke-linecap="round"/></g>'
    body += '<g transform="rotate(5 228 136)"><rect x="180" y="110" width="98" height="52" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>'
    body += Text (229, 134, 'SKINNY', 17, INK, MONO, '800', 'middle') + '<path d="M218 150q11 -8 22 0" stroke="' + RED + '" stroke-width="2.4" fill="none" stroke-linecap="round"/></g>'
    return Svg (300, 200, 'Ratel points at two word cards: SLIM with a smile under it and SKINNY with a frown.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jsl')
# end JokeSlim


def JokeAdvert ():
    body = Ratel (RATEL_POINT, 0, 34, 0.6)
    body += '<rect x="184" y="30" width="86" height="130" rx="16" fill="#2b2466" stroke="#8f86ff" stroke-width="2.5"/>'
    body += '<rect x="196" y="52" width="62" height="34" rx="5" fill="#0d0a24"/>'
    body += '<rect x="200" y="56" width="16" height="26" rx="2" fill="#f4f1ff"/><rect x="219" y="56" width="16" height="26" rx="2" fill="#f4f1ff"/><rect x="238" y="56" width="16" height="26" rx="2" fill="#f4f1ff"/>'
    body += '<circle cx="246" cy="69" r="5" fill="#ff2d2d"/>'
    body += '<rect x="206" y="100" width="42" height="6" rx="3" fill="#0d0a24"/>' + Text (227, 126, 'INSERT', 9, '#c9c4ff', MONO, '700', 'middle')
    body += '<path d="M270 90h12v-40" stroke="#c9c4ff" stroke-width="6" stroke-linecap="round" fill="none"/><circle cx="282" cy="46" r="8" fill="#ff4f7a"/>'
    body += '<circle cx="227" cy="178" r="13" fill="#e2b33c" stroke="#a87d16" stroke-width="2"/>' + Text (227, 183, 'R5', 11, '#5a3f05', MONO, '800', 'middle')
    body += '<path d="M227 162v-50" stroke="#a87d16" stroke-width="1.5" stroke-dasharray="3 3"/>'
    return Svg (300, 200, 'Ratel points at a phone drawn as a slot machine; a five-rand coin is about to go into its slot.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jad')
# end JokeAdvert


def JokeRosaline ():
    body = Ratel (RATEL_POINT, 0, 34, 0.6)
    body += '<path d="M232 182c-46-30-62-56-52-80 8-18 34-20 52 2 18-22 44-20 52-2 10 24-6 50-52 80z" fill="#f6dfd9" stroke="#a8322d" stroke-width="2.5"/>'
    body += Text (232, 136, 'Rosaline', 17, FRESCO_INK, SERIF, '400', 'middle', 'italic')
    body += '<path d="M196 132h72" stroke="' + RED + '" stroke-width="3" stroke-linecap="round"/>'
    body += Text (232, 62, 'Juliet', 20, RED, HAND, '700', 'middle')
    body += '<path d="M232 70v42M226 106l6 8 6-8" stroke="' + RED + '" stroke-width="2" fill="none" stroke-linecap="round"/>'
    return Svg (300, 200, 'Ratel points a red pencil at a heart: the name Rosaline is crossed out and Juliet is written above it in red.', JokeFrame (body, '#fbf3e6'), RatelDefs (), 'jro')
# end JokeRosaline


def JokeThumb ():
    body = '<path d="M40 160h220" stroke="' + FRESCO_DEEP + '" stroke-opacity=".35" stroke-width="2"/>'
    body += '<rect x="110" y="96" width="78" height="64" rx="18" fill="#f0c9a4" stroke="' + FRESCO_INK + '" stroke-width="2.5"/>'
    body += '<path d="M118 112h62M118 128h62M118 144h62" stroke="' + FRESCO_INK + '" stroke-opacity=".4" stroke-width="1.6"/>'
    body += '<path d="M128 98c-6-26-2-52 12-60 12-6 22 4 20 18l-4 44" fill="#f0c9a4" stroke="' + FRESCO_INK + '" stroke-width="2.5" stroke-linejoin="round"/>'
    body += '<path d="M136 46l4 5 4-5 4 5 4-5" stroke="' + RED + '" stroke-width="2" fill="none"/>'
    body += '<path d="M60 70l-14-8M58 50l-16 0M64 32l-12-10" stroke="' + FRESCO_DEEP + '" stroke-width="2.5" stroke-linecap="round"/>'
    body += '<path d="M200 60h60v26h-40l-10 10v-10h-10z" fill="#ffffff" stroke="' + FRESCO_DEEP + '" stroke-width="1.8"/>' + Text (230, 78, 'Sir?!', 14, FRESCO_INK, HAND, '700', 'middle')
    body += '<path d="M40 30h26v40l-13-8-13 8z" fill="#4f6d8c"/><path d="M234 120h26v40l-13-8-13 8z" fill="#a8322d"/>'
    return Svg (300, 200, 'A hand with its thumb up and small red bite marks on the thumb, between a blue Montague banner and a red Capulet banner; a speech bubble says Sir?!', JokeFrame (body, '#fbf3e6'), '', 'jth')
# end JokeThumb


def JokeMask ():
    body = Ratel (RATEL_WAVE, 0, 34, 0.6)
    body += '<path d="M180 92c10-22 34-26 50-10 16-16 40-12 50 10-6 22-30 28-50 14-20 14-44 8-50-14z" fill="#a8322d" stroke="' + FRESCO_INK + '" stroke-width="2"/>'
    body += '<ellipse cx="208" cy="92" rx="11" ry="7" fill="#fbf3e6"/><ellipse cx="252" cy="92" rx="11" ry="7" fill="#fbf3e6"/>'
    body += '<path d="M230 78c-4-14 2-28 14-34" stroke="#e9c46a" stroke-width="3" fill="none"/><circle cx="246" cy="42" r="4" fill="#e9c46a"/>'
    body += '<path d="M206 112l-14 70" stroke="#8a6b45" stroke-width="5" stroke-linecap="round"/>'
    body += '<path d="M226 128h62v30h-36l-10 10v-10h-16z" fill="#ffffff" stroke="' + FRESCO_DEEP + '" stroke-width="1.8"/>' + Text (257, 148, 'Hi, Tybalt!', 12, FRESCO_INK, HAND, '700', 'middle')
    return Svg (300, 200, 'Ratel waves beside a red carnival mask on a stick; a speech bubble from the mask says Hi, Tybalt!', JokeFrame (body, '#fbf3e6'), RatelDefs (), 'jma')
# end JokeMask


def JokePeel ():
    body = Quill (-14, 8, 0.72)
    body += '<path d="M176 168c20-6 40-2 52 6M228 174c10-14 26-20 44-16M228 174c4 8 2 14-6 18M228 174c-14 2-26 0-34-8" stroke="#c99a1a" stroke-width="9" stroke-linecap="round" fill="none"/>'
    body += '<path d="M176 168c20-6 40-2 52 6M228 174c10-14 26-20 44-16" stroke="#ffd36b" stroke-width="5" stroke-linecap="round" fill="none"/>'
    body += '<rect x="200" y="56" width="80" height="58" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>'
    body += Text (240, 80, 'P E _ L', 16, INK, MONO, '800', 'middle') + Text (240, 102, 'evidence?', 13, RED, HAND, '700', 'middle')
    return Svg (300, 200, 'Quill the secretary bird stands near a banana peel on the floor, beside a card that reads P E _ L with the word evidence? in red.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'jpe')
# end JokePeel


def JokeRebuttal ():
    body = Quill (-14, 8, 0.72)
    body += '<path d="M290 112h-44" stroke="#8a93a6" stroke-width="10" stroke-linecap="round"/>'
    body += '<path d="M248 92c-26-6-46 4-48 22-2 18 16 28 40 22l8-4z" fill="' + RED + '" stroke="#8f2a1c" stroke-width="2"/>'
    body += '<path d="M216 102c6-4 14-4 20 0" stroke="#ffffff" stroke-opacity=".6" stroke-width="2" fill="none"/>'
    body += '<path d="M176 60l10 14 6-18 8 16 12-12-2 18 16-4-12 12" stroke="' + ACC + '" stroke-width="2" fill="none" stroke-linejoin="round"/>'
    body += Text (214, 50, 'MISSED!', 14, ACC, MONO, '800', 'middle')
    return Svg (300, 200, 'Quill the secretary bird leans away from a red boxing glove punching past it; the word MISSED! is written above.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'jre')
# end JokeRebuttal


def JokeStamp ():
    body = Quill (-14, 4, 0.72, True)
    body += '<path d="M150 154c20-14 40 10 60-4s40 10 60-4" stroke="#7a8a5a" stroke-width="16" stroke-linecap="round" fill="none"/>'
    body += '<circle cx="268" cy="148" r="3" fill="#1d1e22"/>'
    body += Text (214, 182, 'at the end of the day', 12, INK, HAND, '700', 'middle')
    body += '<path d="M176 134l18 22M194 134l-18 22" stroke="' + RED + '" stroke-width="3.5" stroke-linecap="round"/>'
    body += '<rect x="184" y="40" width="96" height="40" rx="6" fill="#ffffff" stroke="' + ACC + '" stroke-width="2"/>' + Text (232, 66, 'CLICH' + chr (0xC9) + '!', 15, RED, MONO, '800', 'middle')
    return Svg (300, 200, 'Quill the secretary bird stands on one leg above a snake labelled at the end of the day, with a red cross stamped on it and a sign that says CLICH' + chr (0xC9) + '!', JokeFrame (body, '#eef3fb'), QuillDefs (), 'jst')
# end JokeStamp


def JokeTrace ():
    body = Ratel (RATEL_POINT, 0, 34, 0.6)
    body += '<rect x="178" y="30" width="102" height="140" rx="6" fill="#ffffff" stroke="' + ACC_SOFT + '" stroke-width="2"/>'
    letters = ['T', 'R', 'A', 'C', 'E']
    row = 0
    while row < len (letters):
        body += Text (194, 56 + row * 24, letters[row], 16, ACC, SERIF, '400', 'middle', 'italic')
        body += '<rect x="206" y="' + str (47 + row * 24) + '" width="' + str (60 - row * 6) + '" height="7" rx="3" fill="#c9ccd6"/>'
        row += 1
    # end while letters
    body += '<path d="M182 48l6 6 10-12" stroke="#1d7a3e" stroke-width="2.4" fill="none"/>'
    body += Star (266, 40, 9, '#e2b33c')
    return Svg (300, 200, 'Ratel points a red pencil at a checklist down a page: T, R, A, C, E, the first one ticked, with a small gold star in the corner.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jtr')
# end JokeTrace


def JokeCaptain ():
    body = Ratel (RATEL_WAVE, 0, 34, 0.6)
    body += '<path d="M58 60c4-16 18-24 34-24s30 8 34 24z" fill="#1f2a44"/><rect x="52" y="58" width="80" height="8" rx="4" fill="#111827"/>'
    body += '<circle cx="92" cy="48" r="5" fill="#e2b33c"/>'
    body += '<rect x="214" y="70" width="40" height="96" rx="12" fill="#2b2f3a"/>'
    body += '<circle cx="234" cy="88" r="7" fill="#c0392b"/><circle cx="226" cy="110" r="4" fill="#8a93a6"/><circle cx="242" cy="110" r="4" fill="#8a93a6"/>'
    body += '<circle cx="226" cy="124" r="4" fill="#8a93a6"/><circle cx="242" cy="124" r="4" fill="#8a93a6"/><circle cx="226" cy="138" r="4" fill="#8a93a6"/><circle cx="242" cy="138" r="4" fill="#8a93a6"/>'
    body += Text (264, 64, '?', 30, RED, HAND, '700', 'middle')
    return Svg (300, 200, 'Ratel waves, wearing a navy captain\'s cap with a gold badge, next to a TV remote with a red question mark above it.', JokeFrame (body, '#fbf7ec'), RatelDefs (), 'jca')
# end JokeCaptain


def JokeSpeedo ():
    body = Quill (-14, 8, 0.72)
    body += '<path d="M180 150a52 52 0 0 1 104 0" fill="#ffffff" stroke="' + ACC + '" stroke-width="3"/>'
    body += '<path d="M262 116a52 52 0 0 1 22 34" stroke="' + RED + '" stroke-width="6" fill="none"/>'
    body += '<path d="M232 150l40-26" stroke="' + INK + '" stroke-width="3" stroke-linecap="round"/><circle cx="232" cy="150" r="5" fill="' + INK + '"/>'
    body += Text (190, 168, '130', 10, '#44495a', MONO, '600', 'middle') + Text (276, 168, '260', 10, RED, MONO, '800', 'middle')
    body += Text (232, 186, 'WORDS / MINUTE', 9.5, ACC, MONO, '700', 'middle')
    body += '<path d="M200 70l-14-6M204 54l-14-10M214 42l-8-12" stroke="#8a93a6" stroke-width="2" stroke-linecap="round"/>'
    return Svg (300, 200, 'Quill the secretary bird stands beside a speedometer labelled words per minute; the needle is in the red at 260, far past 130.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'jsp')
# end JokeSpeedo


def JokeDropped ():
    body = Quill (-14, 8, 0.72)
    cards = [(168, 150, -18, 3), (204, 160, 8, 1), (240, 146, -6, 4), (186, 120, 14, 2)]
    for cardX, cardY, angle, number in cards:
        body += ('<g transform="rotate(' + str (angle) + ' ' + str (cardX + 26) + ' ' + str (cardY + 16) + ')">'
                 + '<rect x="' + str (cardX) + '" y="' + str (cardY) + '" width="52" height="32" rx="4" fill="#ffffff" stroke="' + ACC_SOFT + '" stroke-width="1.6"/>'
                 + '<circle cx="' + str (cardX + 11) + '" cy="' + str (cardY + 11) + '" r="7" fill="' + ACC + '"/>'
                 + Text (cardX + 11, cardY + 14.5, str (number), 9, '#ffffff', MONO, '700', 'middle')
                 + '<rect x="' + str (cardX + 22) + '" y="' + str (cardY + 8) + '" width="22" height="4" rx="2" fill="#c9ccd6"/></g>')
    # end for each card
    body += Text (232, 66, 'oops', 18, RED, HAND, '700', 'middle')
    return Svg (300, 200, 'Quill the secretary bird looks down at four numbered cue cards scattered on the floor: 3, 1, 4 and 2.', JokeFrame (body, '#eef3fb'), QuillDefs (), 'jdr')
# end JokeDropped


DRAWINGS = {
    'eng10-open-tone': OpenTone,
    'eng10-trace-tone': TraceTone,
    'eng10-hush-ad': HushAd,
    'eng10-joke-tone': JokeTone,
    'eng10-open-unseen': OpenUnseen,
    'eng10-trace-steps': TraceSteps,
    'eng10-joke-unseen': JokeUnseen,
    'eng10-open-rj': OpenRomeo,
    'eng10-rj-houses': RomeoHouses,
    'eng10-joke-rj': JokeRomeo,
    'eng10-open-argue': OpenArgue,
    'eng10-argue-layout': ArgueLayout,
    'eng10-joke-argue': JokeArgue,
    'eng10-open-speech': OpenSpeech,
    'eng10-cue-cards': CueCards,
    'eng10-joke-speech': JokeSpeech,
    # the rework's margin jokes (11 October 2026)
    'eng10-joke-genius': JokeGenius,
    'eng10-joke-slim': JokeSlim,
    'eng10-joke-advert': JokeAdvert,
    'eng10-joke-rosaline': JokeRosaline,
    'eng10-joke-thumb': JokeThumb,
    'eng10-joke-mask': JokeMask,
    'eng10-joke-peel': JokePeel,
    'eng10-joke-rebuttal': JokeRebuttal,
    'eng10-joke-stamp': JokeStamp,
    'eng10-joke-trace': JokeTrace,
    'eng10-joke-captain': JokeCaptain,
    'eng10-joke-speedo': JokeSpeedo,
    'eng10-joke-dropped': JokeDropped,
}


def Main ():
    """Writes every drawing, or only the ones named after the folder."""
    outDir = sys.argv[1] if len (sys.argv) > 1 else os.path.join (HERE, '..', '..', '..', 'AIPascalCourse', 'public', 'assets', 'doodles')
    names = sys.argv[2:] if len (sys.argv) > 2 else list (DRAWINGS.keys ())
    os.makedirs (outDir, exist_ok = True)
    for name in names:
        draw = DRAWINGS[name]
        with open (os.path.join (outDir, name + '.svg'), 'w', encoding = 'utf-8', newline = '\n') as target:
            target.write (draw ().replace ('GRIDID', name + '-grid'))
        # end with
        print ('wrote', name)
    # end for each drawing
# end Main


if __name__ == '__main__':
    Main ()
# end if run as a script
