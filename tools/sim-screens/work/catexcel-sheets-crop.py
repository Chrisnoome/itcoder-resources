"""Crops the catexcel-sheets.ps1, -sheets2.ps1 and -sheets3.ps1 screens (catexcel
Grade 11 lesson 15, Working with sheets and windows - 9 October 2026, writer
B) and copies them to the site as catexcel-sheets-<n>.png, then prints every
place in per cent of each crop - the numbers the lesson's 'click' and 'at'
boxes use. Every crop starts below the title bar (it shows the signed-in
account's initials). Home-tab pictures stop before the VM's Add-ins and
Claude ribbon groups (painted out where the Format menu needs the width);
View-tab pictures keep the Window group (1460 wide); the two windows side by
side (w-5) keep both, with the right window's Add-ins and Claude painted out.
Its own file, as catexcel-crop.py's table is shared by the other scripts.

    C:/Python314/python.exe work/catexcel-sheets-crop.py
"""
import json, os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
TOP = 56
NARROW = (0, TOP, 1180, 792)
HOME = (0, TOP, 1350, 792)          # the Format menu reaches x 1341
VIEW = (0, TOP, 1460, 792)          # the Window group and the Freeze Panes menu (and the Review tab's Protect group)
# picture -> (script, crop box)
PICTURES = {
    'h-1': ('catexcel-sheets3', HOME), 'h-2': ('catexcel-sheets3', HOME), 'h-3': ('catexcel-sheets3', HOME),
    'h-3b': ('catexcel-sheets3', HOME), 'h-4': ('catexcel-sheets3', HOME), 'h-5': ('catexcel-sheets3', HOME),
    'l-1': ('catexcel-sheets', NARROW), 'l-2': ('catexcel-sheets', NARROW), 'l-3': ('catexcel-sheets', NARROW),
    'l-4': ('catexcel-sheets', NARROW), 'l-5': ('catexcel-sheets', NARROW), 'l-6': ('catexcel-sheets', NARROW),
    'l-7': ('catexcel-sheets', NARROW),
    'z-0': ('catexcel-sheets', NARROW), 'z-1': ('catexcel-sheets', NARROW), 'z-2': ('catexcel-sheets', VIEW),
    'z-3': ('catexcel-sheets', VIEW), 'z-4': ('catexcel-sheets', VIEW),
    'sp-1': ('catexcel-sheets', VIEW), 'cv-1': ('catexcel-sheets', VIEW),
    'w-1': ('catexcel-sheets2', VIEW), 'w-2a': ('catexcel-sheets', VIEW), 'w-2': ('catexcel-sheets2', VIEW),
    'w-3': ('catexcel-sheets2', VIEW), 'w-4': ('catexcel-sheets2', VIEW), 'w-5': ('catexcel-sheets', None),
    'p-1': ('catexcel-sheets3', VIEW), 'p-2': ('catexcel-sheets3', VIEW), 'p-3': ('catexcel-sheets3', VIEW),
    'p-4': ('catexcel-sheets3', VIEW), 'p-4b': ('catexcel-sheets3', VIEW), 'p-5': ('catexcel-sheets3', VIEW),
}
ADDINS_HOME = (1333, 100, 1352, 222)    # the edge of the Add-ins group inside the HOME crop

for short, (script, box) in PICTURES.items():
    path = os.path.join(HERE, 'out', f'{script}-{short[:-1] if short == "w-2a" else short}.png')   # w-2a: the first run's w-2 (the new window on its Home tab)
    if not os.path.exists(path):
        print('-- missing', script, short)
        continue
    picture = Image.open(path).convert('RGB')
    draw = ImageDraw.Draw(picture)
    if box is None:                      # two windows side by side: whole width, the right one's Add-ins and Claude out
        w = picture.width
        draw.rectangle((w - 250, 100, w - 95, 222), fill=picture.getpixel((w - 252, 140)))
        box = (0, TOP, w, picture.height)
    elif short == 'w-2a':                # the new window opens on the Home tab: its Add-ins and Claude groups out
        draw.rectangle((1333, 100, 1460, 222), fill=picture.getpixel((1325, 140)))
    elif box is HOME:
        draw.rectangle(ADDINS_HOME, fill=picture.getpixel((1325, 140)))
    picture = picture.crop(box)
    picture.save(os.path.join(SITE, f'catexcel-sheets-{short}.png'), optimize=True)
    print(short, script, picture.size)

for script in ('catexcel-sheets', 'catexcel-sheets2', 'catexcel-sheets3'):
    f = os.path.join(HERE, 'out', script + '.json')
    if not os.path.exists(f):
        continue
    marks = json.load(open(f, encoding='utf-8-sig'))['marks']
    for name, box in (('narrow', NARROW), ('home', HOME), ('view', VIEW)):
        w, h = box[2] - box[0], box[3] - box[1]
        print(f'-- {script}: places in the {name} crop')
        for key, value in marks.items():
            if isinstance(value, list) and len(value) == 4:
                x, y, bw, bh = value
                print(f"   {key:22} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
