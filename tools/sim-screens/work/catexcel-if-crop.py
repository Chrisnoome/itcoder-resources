"""Crops the catexcel-if.ps1 screens (catexcel Grade 11 lesson 13, The IF
function - 9 October 2026, writer B) and copies them to the site, then
prints every place in per cent of the cropped picture - the numbers the
lesson's 'click' and 'at' boxes use. Every crop starts below the title bar
(it shows the signed-in account's initials) and stops at x 1180, left of
the VM's Add-ins and Claude ribbon groups (x 1335 on). Its own file, as
catexcel-crop.py's table is shared by the other catexcel scripts.

    C:/Python314/python.exe work/catexcel-if-crop.py
"""
import json, os
from PIL import Image

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-if'
TITLE_BAR = 56
BOX = (0, TITLE_BAR, 1180, 792)
KEEP = ['i-0', 'i-1', 'i-2', 'i-3', 'i-4', 'c-1', 'c-2', 'f-1', 'f-2', 'f-3', 'f-4t', 'f-5', 'n-1', 'n-2', 'x-0', 'x-1', 'x-2', 'o-0', 'o-1', 'o-3']

marks = json.load(open(os.path.join(HERE, 'out', APP + '.json'), encoding='utf-8-sig'))['marks']
for short in KEEP:
    path = os.path.join(HERE, 'out', f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB').crop(BOX)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

w, h = BOX[2] - BOX[0], BOX[3] - BOX[1]
print('-- places in per cent')
for key, value in marks.items():
    if isinstance(value, list) and len(value) == 4:
        x, y, bw, bh = value
        print(f"   {key:18} [{(x - BOX[0]) / w * 100:.1f}, {(y - BOX[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
