"""Crops the catexcel-printoptions.ps1 screens (catexcel lesson 16, Print
options - 9 October 2026) and copies them to the site, then prints every place
in per cent of the crop - the numbers the lesson's 'click' boxes use. Every
picture is cut below the title bar (it shows the signed-in account's
initials) and keeps 1590 px across: the Page Layout tab's Arrange group and
File > Print's preview reach the right-hand side. The VM's Add-ins and Claude
ribbon groups are painted out on the Home-tab pictures. (Its own file:
catexcel-crop.py and cat-crop.py are shared.)

    C:/Python314/python.exe work/catexcel-printoptions-crop.py
"""
import json, os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-printoptions'
BOX = (0, 56, 1590, 790)
NAMES = ['rc-0', 'pb-1', 'fp-0', 'fp-1', 'fp-2', 'fp-3', 'pw-1', 'pw-2', 'sc-1', 'sc-2', 'sc-3',
         'so-2', 'so-3', 'so-4', 'br-0', 'br-1', 'br-2', 'pa-0', 'pa-1', 'pa-2', 'pa-3', 'pt-1',
         'ar-1', 'ar-2', 'ar-3', 'ar-4', 'ar-5']
ADDINS = (1335, 100, 1490, 222)   # the Home tab's Add-ins and Claude groups
HOME_TAB = {'rc-0', 'pb-1'}

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
for short in NAMES:
    path = os.path.join(HERE, 'out', f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    if shows_addins(picture):
        ImageDraw.Draw(picture).rectangle((1335, 100, 1490, 222), fill=picture.getpixel((1494, 102)))
        print('  painted the Add-ins and Claude groups:', short)
    if short in HOME_TAB:
        x1, y1, x2, y2 = ADDINS
        ImageDraw.Draw(picture).rectangle(ADDINS, fill=picture.getpixel((x2 + 4, y1 + 2)))
    picture = picture.crop(BOX)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

w, h = BOX[2] - BOX[0], BOX[3] - BOX[1]
print('-- places in the crop')
for key, value in marks.items():
    if isinstance(value, list) and len(value) == 4:
        x, y, bw, bh = value
        print(f"   {key:22} [{(x - BOX[0]) / w * 100:.1f}, {(y - BOX[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
