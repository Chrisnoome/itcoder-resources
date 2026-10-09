"""Crops the catexcel-condformat.ps1 screens (catexcel Grade 11 lesson 12,
Conditional formatting - 9 October 2026) and copies them to the site, then
prints every place in per cent of the cropped picture - the numbers the
lesson's 'click' and 'at' boxes use. Every crop starts below the title bar
(it shows the signed-in account's initials). The pictures are cut 1380 wide:
the Conditional Formatting menu's submenus and galleries reach x 1370. The
VM's Add-ins and Claude ribbon groups (x 1335 on) are painted out in the
ribbon's white. (Its own file, as catexcel-crop.py's table is shared.)

    C:/Python314/python.exe work/catexcel-condformat-crop.py
"""
import json, os, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-condformat'
SRC = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, 'out')
TITLE_BAR = 56
BOX = (0, TITLE_BAR, 1380, 790)
KEEP = {'w-1', 'w-2', 'l-1', 'l-2', 'l-3', 'l-4', 'l-5', 'k-1', 'k-2', 'du-1', 'tb-1', 'tb-3', 'tb-4', 'd-1', 'd-2', 'd-3', 'd-4', 'cs-2', 'cs-3', 'ic-1', 'ic-2', 'm-0', 'm-1', 'm-2', 'm-3', 'm-4', 'm-5', 'cl-1'}
ADDINS = (1335, 100, 1380, 222)   # window pixels: the Add-ins and Claude groups, as far as the crop reaches

marks = json.load(open(os.path.join(SRC, APP + '.json'), encoding='utf-8-sig'))['marks']
for short in sorted(KEEP):
    path = os.path.join(SRC, f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    ImageDraw.Draw(picture).rectangle(ADDINS, fill=(255, 255, 255))
    picture = picture.crop(BOX)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

w, h = BOX[2] - BOX[0], BOX[3] - BOX[1]
print('-- places in the crop')
for key, value in marks.items():
    if isinstance(value, list) and len(value) == 4:
        x, y, bw, bh = value
        print(f"   {key:22} [{(x - BOX[0]) / w * 100:.1f}, {(y - BOX[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
