"""Crops the catexcel-sorting.ps1 screens (catexcel lesson 9, Sorting,
filtering and finishing touches - 8 October 2026) and copies them to the
site, then prints every place in per cent of the cropped picture - the
numbers the lesson's 'click' and 'at' boxes use. Every crop starts below the
title bar (it shows the signed-in account's initials). Most pictures are cut
1180 wide (the list, the ribbon groups used, the dialogs); the ones with a
pane or window at the right keep the whole width. The comment card's author
(the VM's Office account) is painted out, and so are the VM's Add-ins and
Claude ribbon groups where a picture reaches them. (Its own file, as
catexcel-crop.py's table is shared by the other catexcel scripts.)

    C:/Python314/python.exe work/catexcel-sorting-crop.py
"""
import json, os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-sorting'
TITLE_BAR = 56
NARROW = (0, TITLE_BAR, 1180, 790)
WIDE = (0, TITLE_BAR, 1590, 790)
WIDE_ONES = {'t-3', 'tr-1', 'p-3'}
KEEP = {'s-1', 's-2', 's-3', 's-4', 'd-1', 'd-2', 'd-3', 'd-4b', 'd-5', 'd-6', 'd-7', 'f-1', 'f-2', 'f-6',
        't-1', 't-2', 't-3', 'tr-1', 'c-1', 'c-2', 'c-3', 'c-4', 'p-1', 'p-1b', 'p-2', 'p-3', 'p-5', 'th-1', 'th-2', 'th-3'}
# window pixels to paint over, with the colour a little to the right of the box: [x1, y1, x2, y2]
PAINT = {
    'c-2': [(580, 577, 860, 617)],
    'c-3': [(580, 577, 860, 617)],
}
ADDINS = (1335, 100, 1490, 222)   # Home tab only

marks = json.load(open(os.path.join(HERE, 'out', APP + '.json'), encoding='utf-8-sig'))['marks']
for short in sorted(KEEP):
    path = os.path.join(HERE, 'out', f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    draw = ImageDraw.Draw(picture)
    boxes = list(PAINT.get(short, []))
    if picture.getpixel((116, 80)) != picture.getpixel((60, 80)) and short in ('s-1', 't-1'):
        boxes.append(ADDINS)
    for x1, y1, x2, y2 in boxes:
        draw.rectangle((x1, y1, x2, y2), fill=picture.getpixel((x2 + 4, y1 + 2)))
    box = WIDE if short in WIDE_ONES else NARROW
    picture = picture.crop(box)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

for name, box in (('narrow', NARROW), ('wide', WIDE)):
    w, h = box[2] - box[0], box[3] - box[1]
    print(f'-- places in the {name} crop')
    for key, value in marks.items():
        if isinstance(value, list) and len(value) == 4:
            x, y, bw, bh = value
            print(f"   {key:18} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
