"""The six YouTube channels' art as outlined SVG, rendered to PNG (Chris, 3 October 2026: "use all svg
for now. make svg parts for the rest"). Design board: https://claude.ai/artifact/LtgVBNvwsQKPhcxTb9feYz

Per channel, in brand/youtube/<folder>/:
  avatar.svg/.png       800 x 800, full-bleed square (YouTube crops it to a circle)
  banner.svg/.png       2560 x 1440, name and logo inside the 1546 x 423 middle every device shows
  watermark.svg/.png    150 x 150, the round avatar on a clear background
  endcard-bg.svg/.png   1920 x 1080, quiet left and middle for YouTube's end-screen elements

Run with a Python that has fontTools and Pillow (ComfyUI's):  python build.py
Fonts: Montserrat from the user fonts folder, JetBrains Mono NL from C:/Windows/Fonts. The letters are
outlines, so the SVGs need no font. PNGs are rendered with headless Chrome, as in brand/bestlessons."""
import os, subprocess, tempfile
from fontTools.ttLib import TTFont
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen
from PIL import Image

HERE = os.path.dirname (os.path.abspath (__file__))
YT = os.path.dirname (HERE)
CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
USER_FONTS = 'C:/Users/chris/AppData/Local/Microsoft/Windows/Fonts/'
WIN_FONTS = 'C:/Windows/Fonts/'
SITE_BLUE = '#7ea6ff'   # the BestLessons light blue (brand/bestlessons/README.md)


class Face:
    def __init__ (self, path):
        self.font = TTFont (path)
        self.glyphs = self.font.getGlyphSet ()
        self.cmap = self.font.getBestCmap ()
        self.upm = self.font['head'].unitsPerEm

    def width (self, text, size):
        return sum (self.font['hmtx'][self.cmap[ord (c)]][0] for c in text) * size / self.upm

    def path (self, text, x, baseline, size, anchor='start'):
        """SVG path data for text, letters as outlines; anchor start, middle or end."""
        w = self.width (text, size)
        x -= {'start': 0, 'middle': w / 2, 'end': w}[anchor]
        s = size / self.upm
        pen = SVGPathPen (self.glyphs)
        for c in text:
            n = self.cmap[ord (c)]
            self.glyphs[n].draw (TransformPen (pen, (s, 0, 0, -s, x, baseline)))
            x += self.font['hmtx'][n][0] * s
        return pen.getCommands ()


BLACK = Face (USER_FONTS + 'Montserrat-Black.ttf')
EXTRA = Face (USER_FONTS + 'Montserrat-ExtraBold.ttf')
BOLD = Face (USER_FONTS + 'Montserrat-Bold.ttf')
MONO = Face (WIN_FONTS + 'JetBrainsMonoNL-ExtraBold.ttf')


def text (face, s, x, y, size, fill, anchor='start', opacity=None):
    op = f' opacity="{opacity}"' if opacity is not None else ''
    return f'<path d="{face.path (s, x, y, size, anchor)}" fill="{fill}"{op}/>'


def fit (face, s, size, maxw):
    """The font size that keeps s within maxw."""
    return min (size, size * maxw / face.width (s, size))


# ---- the marks, drawn on a 240 x 240 square (the board's coordinates) ----

SPARK = 'M{x} {t} C{a} {b} {c} {d} {r} {y} C{c} {e} {a} {f} {x} {bt} C{g} {f} {h} {e} {l} {y} C{h} {d} {g} {b} {x} {t} Z'


def spark (cx, cy, r):
    """A four-point star."""
    k = r * 0.1
    return SPARK.format (x=cx, t=cy - r, bt=cy + r, l=cx - r, r=cx + r, y=cy, a=cx + k, b=cy - r * 0.35,
                         c=cx + r * 0.35, d=cy - k, e=cy + k, f=cy + r * 0.35, g=cx - k, h=cx - r * 0.35)


def line_mark (colour):
    """The BestLessons rising blue line: the School SA channels carry it."""
    return f'<path d="M78 208 Q120 196 166 194" fill="none" stroke="{colour}" stroke-width="8" stroke-linecap="round"/>'


def pascal_mark ():
    return (text (MONO, 'begin', 58, 90, 40, '#ffffff') +
            '<rect x="86" y="102" width="22" height="32" rx="2" fill="#2ec4b6"/>' +
            text (MONO, 'end.', 58, 172, 40, '#2ec4b6') + line_mark (SITE_BLUE))


def java_mark ():
    cream = '#f6eadb'
    return (text (MONO, '{', 58, 160, 120, '#f28c28', 'middle') + text (MONO, '}', 182, 160, 120, '#f28c28', 'middle') +
            f'<path d="M94 114 H146 V138 A26 22 0 0 1 94 138 Z" fill="{cream}"/>'
            f'<path d="M146 120 A12 12 0 0 1 146 144" fill="none" stroke="{cream}" stroke-width="7"/>'
            f'<path d="M108 104 C100 94 116 88 108 76 M122 104 C114 94 130 88 122 76 M136 104 C128 94 144 88 136 76" '
            f'fill="none" stroke="{cream}" stroke-width="6" stroke-linecap="round"/>' + line_mark (SITE_BLUE))


def sql_mark ():
    return ('<path d="M64 72 V156 A56 18 0 0 0 176 156 V72 Z" fill="#6fe3a5"/>'
            '<path d="M64 100 A56 18 0 0 0 176 100 M64 128 A56 18 0 0 0 176 128" fill="none" stroke="#0e3b2a" stroke-width="6"/>'
            '<ellipse cx="120" cy="72" rx="56" ry="18" fill="#c4f7da" stroke="#0e3b2a" stroke-width="4"/>' + line_mark (SITE_BLUE))


def cat_mark ():
    w = '#ffffff'
    return ('<rect x="62" y="56" width="54" height="54" rx="12" fill="#4f7cff"/>'
            f'<path d="M76 74 H102 M76 84 H102 M76 94 H94" stroke="{w}" stroke-width="5" stroke-linecap="round"/>'
            '<rect x="124" y="56" width="54" height="54" rx="12" fill="#27b36b"/>'
            f'<path d="M136 70 H166 V98 H136 Z M136 84 H166 M151 70 V98" fill="none" stroke="{w}" stroke-width="4"/>'
            '<rect x="62" y="118" width="54" height="54" rx="12" fill="#ff6a4d"/>'
            f'<path d="M82 134 L72 145 L82 156 M96 134 L106 145 L96 156" fill="none" stroke="{w}" stroke-width="5" '
            'stroke-linecap="round" stroke-linejoin="round"/>'
            '<rect x="124" y="118" width="54" height="54" rx="12" fill="#1fb5c9"/>'
            f'<ellipse cx="151" cy="133" rx="15" ry="5" fill="none" stroke="{w}" stroke-width="4"/>'
            f'<path d="M136 133 V157 A15 5 0 0 0 166 157 V133" fill="none" stroke="{w}" stroke-width="4"/>' + line_mark (SITE_BLUE))


def ai_mark ():
    dots = ''.join (f'<circle cx="{x}" cy="{y}" r="15" fill="#ffd166"/>'
                    for x, y in ((150, 50), (60, 150), (184, 150), (150, 196), (150, 150)))
    return ('<path d="M150 50 L60 150 L184 150 M150 50 L150 196" fill="none" stroke="#c9b8ff" stroke-width="12" '
            'stroke-linecap="round" stroke-linejoin="round"/>' + dots)


def teachers_mark ():
    return ('<path d="M120 96 C100 80 62 84 60 124 C58 164 92 200 120 190 C148 200 182 164 180 124 C178 84 140 80 120 96 Z" fill="#ffffff"/>'
            '<path d="M120 96 C120 84 122 76 126 68" fill="none" stroke="#ffffff" stroke-width="7" stroke-linecap="round"/>'
            f'<path d="{spark (152, 62, 20)}" fill="#ffd166"/>')


# ---- the side decoration of banners and end cards ----

def code_lines (lines, x, y, size, colour, anchor, gap=1.75):
    return ''.join (text (MONO, s, x, y + i * size * gap, size, colour, anchor, 0.28) for i, s in enumerate (lines) if s.strip ())


CODE = {
    'pascal': (['program Hello;', 'begin', "  writeln('Hi');", '  x := 42;', 'end.'],
               ['for i := 1 to 10 do', '  total := total + i;', 'if total > 50 then', "  writeln('Done');", 'readln;']),
    'java':   (['public class Hello {', '  public static void', '    main(String[] a) {', '    int x = 42;', '  }'],
               ['for (int i = 1; i <= 10; i++) {', '  total += i;', '}', 'System.out.println(total);', '}']),
    'sql':    (['SELECT name, mark', 'FROM tblLearners', 'WHERE mark >= 50', 'ORDER BY mark DESC;'],
               ['SELECT grade, AVG(mark)', 'FROM tblLearners', 'GROUP BY grade', 'HAVING AVG(mark) > 60;']),
}


def tiles (spots):
    colours = ['#4f7cff', '#27b36b', '#ff6a4d', '#1fb5c9']
    return ''.join (f'<rect x="{x}" y="{y}" width="{s}" height="{s}" rx="{s * 0.2:.0f}" fill="{colours[i % 4]}" opacity="0.4"/>'
                    for i, (x, y, s) in enumerate (spots))


def network (points, links):
    lines = ''.join (f'<path d="M{points[a][0]} {points[a][1]} L{points[b][0]} {points[b][1]}"/>' for a, b in links)
    dots = ''.join (f'<circle cx="{x}" cy="{y}" r="10"/>' for x, y in points)
    return (f'<g stroke="#c9b8ff" stroke-width="3" opacity="0.35" fill="none">{lines}</g>'
            f'<g fill="#ffd166" opacity="0.5">{dots}</g>')


def mirror (points, width):
    return [(width - x, y) for x, y in points]


NET = [(80, 560), (260, 680), (110, 860), (420, 600), (450, 820), (230, 500)]
NET_LINKS = [(0, 1), (1, 2), (1, 3), (3, 4), (3, 5), (5, 0), (1, 4)]


def sheets_and_sparks (spots):
    out = ''
    for kind, x, y, s in spots:
        if kind == 'spark':
            out += f'<path d="{spark (x, y, s)}" fill="#ffd166" opacity="0.55"/>'
        else:
            out += (f'<g fill="none" stroke="#ffffff" stroke-width="4" opacity="0.3"><rect x="{x}" y="{y}" width="{s}" height="{s * 1.3:.0f}" rx="10"/>'
                    f'<path d="M{x + s * 0.2:.0f} {y + s * 0.3:.0f} H{x + s * 0.8:.0f} M{x + s * 0.2:.0f} {y + s * 0.55:.0f} H{x + s * 0.8:.0f} '
                    f'M{x + s * 0.2:.0f} {y + s * 0.8:.0f} H{x + s * 0.6:.0f}"/></g>')
    return out


def banner_sides (key, accent):
    if key in CODE:
        left, right = CODE[key]
        return code_lines (left, 90, 590, 34, accent, 'start') + code_lines (right, 2470, 590, 34, accent, 'end')
    if key == 'cat':
        return tiles ([(90, 560, 110), (240, 690, 84), (110, 800, 70), (330, 540, 64), (2360, 560, 110), (2230, 700, 84), (2380, 810, 70), (2140, 560, 64)])
    if key == 'ai4all':
        return network (NET, NET_LINKS) + network (mirror (NET, 2560), NET_LINKS)
    return sheets_and_sparks ([('sheet', 120, 600, 110), ('spark', 340, 560, 34), ('spark', 380, 860, 22), ('spark', 90, 520, 18),
                               ('sheet', 2330, 620, 110), ('spark', 2210, 580, 34), ('spark', 2180, 870, 22), ('spark', 2470, 530, 18)])


def endcard_sides (key, accent):
    if key in CODE:
        return code_lines (CODE[key][1], 1840, 760, 30, accent, 'end')
    if key == 'cat':
        return tiles ([(1700, 700, 100), (1580, 860, 76), (1760, 880, 70), (80, 960, 60), (1820, 620, 54)])
    if key == 'ai4all':
        pts = [(1820, 640), (1680, 760), (1840, 880), (1560, 940), (1740, 1010), (1880, 760)]
        return network (pts, [(0, 1), (1, 2), (1, 3), (2, 4), (3, 4), (0, 5), (5, 2)])
    return sheets_and_sparks ([('sheet', 1700, 760, 110), ('spark', 1620, 700, 30), ('spark', 1860, 680, 20), ('spark', 1640, 990, 22), ('spark', 110, 990, 18)])


# ---- the channels ----

CHANNELS = [
    dict (key='pascal', name=('Pascal ', 'School SA'), bg='#12355b', accent='#2ec4b6', ring='#2ec4b6', mark=pascal_mark,
          tagline='Pascal for the IT syllabus, one line at a time.', site=True, next='Keep going'),
    dict (key='java', name=('Java ', 'School SA'), bg='#2b1a12', accent='#f28c28', ring='#f28c28', mark=java_mark,
          tagline='Java for the IT syllabus, made clear.', site=True, next='Keep going'),
    dict (key='sql', name=('SQL ', 'School SA'), bg='#0e3b2a', accent='#6fe3a5', ring='#6fe3a5', mark=sql_mark,
          tagline='Databases and SQL for the IT syllabus.', site=True, next='Keep going'),
    dict (key='cat', name=('CAT ', 'School SA'), bg='#1b2233', accent=SITE_BLUE, ring=SITE_BLUE, mark=cat_mark,
          tagline='Computer Applications Technology, IEB and CAPS.', site=True, next='Keep going'),
    dict (key='ai4all', name=('AI 4 All', ''), bg='#2d2a8c', accent='#ffd166', ring='#ffd166', mark=ai_mark,
          tagline='Everyday AI, explained for everyone.', sub='No jargon. No experts needed.', subcolour='#c9b8ff', site=False, next='Watch next'),
    dict (key='ai4teachers', name=('AI for Teachers', ''), bg='#c8372d', accent='#ffd166', ring='#ffd166', mark=teachers_mark,
          tagline='Less admin, better resources, with free AI tools.', sub='Easy steps for busy teachers.', subcolour='#ffffff', site=False, next='Watch next'),
]


def svg (w, h, body):
    return f'<svg xmlns="http://www.w3.org/2000/svg" width="{w}" height="{h}" viewBox="0 0 {w} {h}">{body}</svg>\n'


def placed_mark (c, x, y, size, ring=False):
    """The round avatar at (x, y), size across."""
    k = size / 240
    edge = f' stroke="{c["ring"]}" stroke-width="4"' if ring else ''
    return (f'<g transform="translate({x:.1f} {y:.1f}) scale({k:.4f})"><circle cx="120" cy="120" r="{118 if ring else 120}" '
            f'fill="{c["bg"]}"{edge}/>{c["mark"] ()}</g>')


def avatar (c):
    return svg (800, 800, f'<rect width="800" height="800" fill="{c["bg"]}"/>'
                          f'<g transform="scale({800 / 240:.4f})">{c["mark"] ()}</g>')


def watermark (c):
    return svg (150, 150, placed_mark (c, 0, 0, 150))


def banner (c):
    W, H, mark, gap, maxw = 2560, 1440, 300, 64, 1120
    first, second = c['name']
    size = fit (BLACK, first + second, 116, maxw)
    tag = fit (EXTRA, c['tagline'], 44, maxw)
    sub = 'Lessons and practice at bestlessons.co.za' if c['site'] else c['sub']
    subsize = fit (BOLD, sub, 34, maxw)
    textw = max (BLACK.width (first + second, size), EXTRA.width (c['tagline'], tag), BOLD.width (sub, subsize))
    x0 = (W - (mark + gap + textw)) / 2
    tx = x0 + mark + gap
    name = text (BLACK, first, tx, 700, size, '#ffffff')
    if second:
        name += text (BLACK, second, tx + BLACK.width (first, size), 700, size, c['accent'])
    tagcolour = '#ffffff' if c['site'] else c['accent']
    subcolour = SITE_BLUE if c['site'] else c['subcolour']
    body = (f'<rect width="{W}" height="{H}" fill="{c["bg"]}"/>' + banner_sides (c['key'], c['accent']) +
            placed_mark (c, x0, 720 - mark / 2, mark, ring=True) + name +
            text (EXTRA, c['tagline'], tx, 776, tag, tagcolour) + text (BOLD, sub, tx, 840, subsize, subcolour))
    return svg (W, H, body)


def endcard (c):
    body = (f'<rect width="1920" height="1080" fill="{c["bg"]}"/>' + endcard_sides (c['key'], c['accent']) +
            text (BLACK, c['next'], 120, 170, 72, '#ffffff') +
            placed_mark (c, 1680, 70, 140))
    if c['site']:
        body += text (BOLD, 'bestlessons.co.za', 1820, 1020, 34, SITE_BLUE, 'end')
    return svg (1920, 1080, body)


TMP = tempfile.mkdtemp ()


def render (svg_path, png_path, w, h):
    page = os.path.join (TMP, os.path.basename (png_path) + '.html')
    content = open (svg_path, encoding='utf-8').read ()
    open (page, 'w', encoding='utf-8').write (f'<!doctype html><html><body style="margin:0;background:transparent">{content}</body></html>')
    subprocess.run ([CHROME, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--default-background-color=00000000',
                     '--force-device-scale-factor=1', f'--window-size={w},{h}', f'--screenshot={png_path}',
                     'file:///' + page.replace ('\\', '/')], capture_output=True, timeout=120)
    im = Image.open (png_path).convert ('RGBA').crop ((0, 0, w, h))
    if w != 150:
        im = im.convert ('RGB')   # only the watermark needs its clear background
    im.save (png_path, optimize=True)


for c in CHANNELS:
    out = os.path.join (YT, c['key'])
    os.makedirs (out, exist_ok=True)
    for name, make, w, h in (('avatar', avatar, 800, 800), ('banner', banner, 2560, 1440),
                             ('watermark', watermark, 150, 150), ('endcard-bg', endcard, 1920, 1080)):
        sp = os.path.join (out, name + '.svg')
        open (sp, 'w', encoding='utf-8').write (make (c))
        render (sp, os.path.join (out, name + '.png'), w, h)
    print (c['key'], ' '.join (f'{f} {os.path.getsize (os.path.join (out, f)) // 1024}KB' for f in sorted (os.listdir (out)) if f.endswith ('.png')))
