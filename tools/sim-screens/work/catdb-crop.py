"""Crops the catdb screen scripts' pictures (catdb-<lesson>.ps1: Access 365 in the
CAT VM, a 1280 x 900 window at 100% scaling) and copies them to the site, then
prints every marked place in per cent of the cropped picture - the numbers a
simulation's 'click' and 'at' boxes use. The crop starts below the title bar
(it shows the Office account's initials and the file's path) and keeps the
window's whole width.

    C:/Python314/python.exe work/catdb-crop.py catdb-whatfor [x y w h ...]

Extra numbers: window-pixel boxes to turn into per cent as well (places read
off the pictures - Access's grids are not visible to UI Automation).
"""
import json, os, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catdb'
BOX = (9, 60, 1271, 891)
# window pixels to paint over, per picture: [x1, y1, x2, y2, colour]
PAINT = {}

app = sys.argv[1]
os.makedirs(SITE, exist_ok=True)
for name in sorted(os.listdir(os.path.join(HERE, 'out'))):
    if not (name.startswith(app + '-') and name.endswith('.png')):
        continue
    short = name[len(app) + 1:-4]
    picture = Image.open(os.path.join(HERE, 'out', name)).convert('RGB')
    draw = ImageDraw.Draw(picture)
    for x1, y1, x2, y2, colour in PAINT.get(app, {}).get(short, []):
        draw.rectangle((x1, y1, x2, y2), fill=colour)
    picture = picture.crop(BOX)
    picture.save(os.path.join(SITE, name), optimize=True)
    print(name, picture.size)

w, h = BOX[2] - BOX[0], BOX[3] - BOX[1]
def pct(x, y, bw, bh):
    return f"[{(x - BOX[0]) / w * 100:.1f}, {(y - BOX[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]"

marks_file = os.path.join(HERE, 'out', app + '.json')
if os.path.exists(marks_file):
    marks = json.load(open(marks_file, encoding='utf-8-sig'))['marks']
    for key, value in marks.items():
        if isinstance(value, list) and len(value) == 4:
            print(f"{key:28} {pct(*value)}")
extra = [int(v) for v in sys.argv[2:]]
for i in range(0, len(extra) - 3, 4):
    print('read off', extra[i:i + 4], pct(*extra[i:i + 4]))
