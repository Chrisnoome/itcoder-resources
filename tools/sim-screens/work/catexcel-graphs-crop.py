"""Crops the catexcel-graphs.ps1 screens (catexcel lesson 17, More charts, and
linking them - 9 October 2026) and copies them to the site, then prints every
place in per cent of each crop - the numbers the lesson's 'click' and 'at'
boxes use. Every crop starts below the title bar (it shows the signed-in
account's initials). Excel's pictures keep 1590 px across (the Chart Design
tab's Move Chart button sits at about x 1480); Word's (1750 px window) are cut
to the ribbon and the page. The VM's Add-ins and Claude ribbon groups are
painted out where a Home-tab picture shows them. (Its own file: catexcel-crop.py
and cat-crop.py are shared.)

    C:/Python314/python.exe work/catexcel-graphs-crop.py
"""
import json, os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-graphs'
TITLE_BAR = 56
WIDE = (0, TITLE_BAR, 1590, 790)
WORD = (0, TITLE_BAR, 1590, 790)
BOXES = {name: WIDE for name in (
    'el-1', 'el-2', 'el-3', 'el-4', 'el-5', 'el-6', 'sw-2', 'sd-1', 'sd-2', 'sd-3', 'ty-1', 'ty-2', 'ty-3',
    'mv-1', 'mv-2', 'mv-3', 'mv-4', 'op-1', 'op-2', 'op-3', 'kd-1', 'kd-2', 'kd-3', 'kd-4', 'wd-0x',
    'el-1b', 'el-4b', 'el-5b')}
BOXES.update({name: WORD for name in ('wd-0', 'wd-1', 'wd-2', 'wd-3', 'wd-4')})
# window pixels to paint over (the colour just right of the box): [x1, y1, x2, y2]
ADDINS = (1335, 100, 1490, 222)   # Excel's Home tab: the Add-ins and Claude groups
PAINT = {}
HOME_TAB = set()                  # pictures that show Excel's Home tab (none used)

def shows_addins(picture):
    """True when the Home tab is the open tab (its green underline) and its Claude group shows (an orange icon)."""
    if not any(picture.getpixel((x, y))[1] > 90 and picture.getpixel((x, y))[0] < 90 for x in (100, 115, 130) for y in (93, 94, 95)):
        return False
    for x in range(1425, 1475, 2):
        for y in range(108, 145, 2):
            r, g, b = picture.getpixel((x, y))[:3]
            if r > 200 and 80 < g < 160 and b < 110:
                return True
    return False


marks = json.load(open(os.path.join(HERE, 'out', APP + '.json'), encoding='utf-8-sig'))['marks']
for short, box in sorted(BOXES.items()):
    path = os.path.join(HERE, 'out', f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    if shows_addins(picture):
        ImageDraw.Draw(picture).rectangle((1335, 100, 1490, 222), fill=picture.getpixel((1494, 102)))
        print('  painted the Add-ins and Claude groups:', short)
    draw = ImageDraw.Draw(picture)
    boxes = list(PAINT.get(short, []))
    if short in HOME_TAB:
        boxes.append(ADDINS)
    for key, value in marks.items():
        if key.startswith('private') and isinstance(value, list):
            x, y, w, h = value
            boxes.append((x, y, x + w, y + h))
    for x1, y1, x2, y2 in boxes:
        draw.rectangle((x1, y1, x2, y2), fill=picture.getpixel((min(picture.width - 1, x2 + 4), y1 + 2)))
    picture = picture.crop(box)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

for name, box in (('excel (1590)', WIDE), ('word (1740)', WORD)):
    w, h = box[2] - box[0], box[3] - box[1]
    print(f'-- places in the {name} crop')
    for key, value in marks.items():
        if isinstance(value, list) and len(value) == 4:
            x, y, bw, bh = value
            print(f"   {key:22} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
