"""Crops the catexcel-absolute.ps1 screens (catexcel Grade 11 - 9 October 2026)
and copies them to the site, then prints every place in per cent of the
cropped picture - the numbers the lesson's 'click' and 'at' boxes use. Every
crop starts below the title bar (it shows the signed-in account's initials).
Most pictures are cut 1180 wide (the sheet and the ribbon groups used - the
VM's Add-ins and Claude groups, from x 1335, are left outside); the ones
named in WIDE_ONES keep 1380 and have those groups painted out in the
ribbon's white. (Its own file, as catexcel-crop.py's table is shared.)

    C:/Python314/python.exe work/catexcel-absolute-crop.py [folder with the run's pictures]
"""
import json, os, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-absolute'
SRC = sys.argv[1] if len(sys.argv) > 1 else os.path.join(HERE, 'out')
TITLE_BAR = 56
NARROW = (0, TITLE_BAR, 1180, 790)
WIDE = (0, TITLE_BAR, 1380, 790)
WIDE_ONES = set()
KEEP = {'p-1', 'p-2', 'v-1', 'v-2', 'v-3', 'v-4', 'v-5', 'n-1', 'n-1c', 'n-2', 'n-4', 'nm-1', 's-1', 's-2', 's-3', 's-4', 's-6', 's-7'}
ADDINS = (1335, 100, 1380, 222)

marks = json.load(open(os.path.join(SRC, APP + '.json'), encoding='utf-8-sig'))['marks']
for short in sorted(KEEP):
    path = os.path.join(SRC, f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    box = WIDE if short in WIDE_ONES else NARROW
    if box is WIDE:
        ImageDraw.Draw(picture).rectangle(ADDINS, fill=(255, 255, 255))
    picture = picture.crop(box)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

for name, box in (('narrow', NARROW), ('wide', WIDE)):
    w, h = box[2] - box[0], box[3] - box[1]
    print(f'-- places in the {name} crop')
    for key, value in marks.items():
        if isinstance(value, list) and len(value) == 4:
            x, y, bw, bh = value
            print(f"   {key:22} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
