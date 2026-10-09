"""Crops the catexcel-importing.ps1 screens (catexcel lesson 18, Importing,
exporting, and advanced sorting and filtering - 9 October 2026) and copies
them to the site, then prints every place in per cent of each crop - the
numbers the lesson's 'click' and 'at' boxes use.

Excel's title bar shows the signed-in account's initials, so it never stays:
most pictures are cut below it (y 56). The file dialogs and the CSV preview
reach up into it, so those pictures (and the other pictures of the same
simulation, to keep one size) are cut from the top and the title bar is
painted out wherever no dialog covers it. The Save As box's navigation pane
names the account's OneDrive and its Authors box the account's owner: both
painted out. (Its own file: catexcel-crop.py and cat-crop.py are shared.)

    C:/Python314/python.exe work/catexcel-importing-crop.py
"""
import json, os
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
APP = 'catexcel-importing'
LOW = (0, 56, 1180, 790)       # below the title bar
LOW_WIDE = (0, 56, 1590, 790)
TALL = (0, 0, 1590, 790)       # from the top: the title bar painted
TITLE = (0, 0, 1600, 56)
DIALOG = (17, 0, 961, 56)      # a file dialog's own title bar, which stays
PREVIEW = (390, 20, 1484, 56)  # the CSV preview window's top
CROPS = {
    'im-1': TALL, 'im-2': TALL, 'im-3': TALL, 'im-4': TALL,             # simImportCsv
    'im-0': TALL, 'ex-0': TALL, 'ex-1': TALL, 'ex-3': TALL,             # simExportPdf
    'gd-2': LOW_WIDE, 'op-1': LOW_WIDE, 'ex-2': LOW_WIDE, 'sv-2': TALL, 'sv-3': TALL,
    'as-0': LOW, 'as-1': LOW, 'as-2': LOW, 'as-3': LOW, 'as-3b': LOW, 'as-4': LOW, 'as-5': LOW,
    'as-6': LOW, 'as-7': LOW, 'as-8': LOW, 'as-9': LOW,
    'tf-1': LOW, 'af-0': LOW, 'af-1': LOW, 'af-1b': LOW, 'af-1c': LOW, 'af-1d': LOW, 'af-3': LOW,
}
# what of the title bar stays (a dialog over it); the rest of it is painted
KEEP_TOP = {'im-2': DIALOG, 'ex-3': DIALOG, 'sv-2': DIALOG, 'sv-3': DIALOG, 'im-3': PREVIEW}
# window pixels to paint over: the Save As box's OneDrive entry and author
PAINT = {
    'sv-2': [(55, 240, 174, 265)],
    'sv-3': [(55, 240, 196, 265), (180, 472, 450, 496)],
    'op-1': [(1335, 100, 1490, 222)],   # the VM's Add-ins and Claude groups on the Home tab
}


def paint(picture, box, fill=(240, 240, 240)):
    """Paints a rectangle: the title bar's grey by default, or the colour just right of it."""
    x1, y1, x2, y2 = box
    if x2 <= x1 or y2 <= y1:
        return
    if fill is None:
        fill = picture.getpixel((min(picture.width - 1, x2 + 3), min(picture.height - 1, y1 + 2)))
    ImageDraw.Draw(picture).rectangle((x1, y1, x2 - 1, y2 - 1), fill=fill)


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
for short, box in sorted(CROPS.items()):
    path = os.path.join(HERE, 'out', f'{APP}-{short}.png')
    if not os.path.exists(path):
        print('-- missing', short)
        continue
    picture = Image.open(path).convert('RGB')
    if shows_addins(picture):
        ImageDraw.Draw(picture).rectangle((1335, 100, 1490, 222), fill=picture.getpixel((1494, 102)))
        print('  painted the Add-ins and Claude groups:', short)
    if box[1] == 0:
        keep = KEEP_TOP.get(short)
        if keep is None:
            paint(picture, TITLE)
        else:
            kx1, ky1, kx2, ky2 = keep
            paint(picture, (0, 0, 1600, ky1))
            paint(picture, (0, ky1, kx1, 56))
            paint(picture, (kx2, ky1, 1600, 56))
            paint(picture, (0, 56, 10, 790), (255, 255, 255))   # Excel's left edge, drawn black beside a dialog
    for rect in PAINT.get(short, []):
        paint(picture, rect, None)
    picture = picture.crop(box)
    picture.save(os.path.join(SITE, f'{APP}-{short}.png'), optimize=True)
    print(short, picture.size)

for name, box in (('low (1180)', LOW), ('tall (1590 x 790)', TALL)):
    w, h = box[2] - box[0], box[3] - box[1]
    print(f'-- places in the {name} crop')
    for key, value in marks.items():
        if isinstance(value, list) and len(value) == 4:
            x, y, bw, bh = value
            print(f"   {key:22} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
