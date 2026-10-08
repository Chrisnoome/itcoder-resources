"""Lays each ribbon menu and dialog box over its main picture, crops, and
copies the screens of catword lessons 6-10 (catword-pagelayout, -tables,
-illustrations, -proofing, -integration) to the site - then prints every
mark in per cent of each cropped picture: the numbers the lesson's 'click'
and 'at' boxes use.

The scripts save a menu or dialog as its own picture (<n>~1.png, <n>~2.png:
1 is the window in front) with its place in out\\<name>.json, because
PrintWindow draws one window at a time. Here they go back on top of the main
picture where the screen showed them (the black frame PrintWindow paints
round a resizable window is trimmed off). Every crop starts below the title
bar, which shows the signed-in Office account's initials - never keep it.
A file dialog's navigation pane names the OneDrive account: FIXES paints
that label over with the word OneDrive, and may move a dialog to where it
reads better (its marks move with it).

    C:/Python314/python.exe catword-b-crop.py catword-pagelayout
"""
import json, os, re, sys
from PIL import Image, ImageDraw, ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catword'
TITLE_BAR = 62   # the VM's Word: the tabs start at y = 61
BOTTOM = 824     # the status bar starts here (window 860 high)

# script: [(picture names, or '*' for the rest; crop box in window pixels)]
CROPS = {
    'catword-pagelayout':    [(['w-1', 'w-2', 'w-4'], (500, TITLE_BAR, 1750, BOTTOM + 27)), ('*', (0, TITLE_BAR, 1500, BOTTOM + 27))],
    'catword-tables':        [('*', (0, TITLE_BAR, 1650, BOTTOM + 27))],
    'catword-illustrations': [('*', (0, TITLE_BAR, 1550, BOTTOM))],
    'catword-proofing':      [('*', (0, TITLE_BAR, 1740, BOTTOM + 27))],
    'catword-integration':   [('*', (0, TITLE_BAR, 1740, BOTTOM + 27))],
}

# overlay: move to (x, y) in window pixels (with these marks), and labels to paint over (overlay pixels).
FIXES = {
    'catword-illustrations': {
        'p-3~1': {'move': (200, 160), 'marks': ['ewasteFile', 'insertBtn'],
                  'redact': [((13, 238, 183, 263), 'OneDrive')]},
    },
    'catword-integration': {
        # Word's one-time "Pasting is getting smarter" tip and its frame: left out of the picture.
        'x-5~1': {'skip': True}, 'x-5~2': {'skip': True}, 'x-5~3': {'skip': True},
    },
    'catword-pagelayout': {
        # The Watermark gallery opens at the window's right edge, past it; shown inside the window.
        'w-2~1': {'move': (1200, 199)},
    },
}

# Places read off the pictures, for controls UI Automation can't see (Word's dialog boxes) - window pixels.
READ_OFF = {}


def box_for(script, picture):
    for names, box in CROPS[script]:
        if names != '*' and picture in names:
            return box
    for names, box in CROPS[script]:
        if names == '*':
            return box
    raise SystemExit('no crop for ' + picture)


def trim_black(image):
    """Cuts off the near-black frame PrintWindow paints round a resizable window: (image, left offset, top offset)."""
    px = image.load()
    w, h = image.size
    dark = lambda pts: sum(1 for p in pts if sum(px[p]) < 60) > 0.6 * len(pts)
    left, right, top, bottom = 0, w, 0, h
    while right - left > 20 and dark([(left, y) for y in range(top, bottom)]): left += 1
    while right - left > 20 and dark([(right - 1, y) for y in range(top, bottom)]): right -= 1
    while bottom - top > 20 and dark([(x, bottom - 1) for x in range(left, right)]): bottom -= 1
    while bottom - top > 20 and dark([(x, top) for x in range(left, right)]): top += 1
    return image.crop((left, top, right, bottom)), left, top


def main():
    script = sys.argv[1]
    out = os.path.join(HERE, 'out')
    os.makedirs(SITE, exist_ok=True)
    data = json.load(open(os.path.join(out, script + '.json'), encoding='utf-8-sig'))
    marks = data['marks']
    marks.update(READ_OFF.get(script, {}))
    fixes = FIXES.get(script, {})
    for k, fix in fixes.items():
        if 'move' in fix and k in marks:
            dx, dy = fix['move'][0] - marks[k][0], fix['move'][1] - marks[k][1]
            for m in fix.get('marks', []):
                if m in marks:
                    marks[m] = [marks[m][0] + dx, marks[m][1] + dy, marks[m][2], marks[m][3]]
            marks[k] = [fix['move'][0], fix['move'][1], marks[k][2], marks[k][3]]
    try:
        font = ImageFont.truetype('C:/Windows/Fonts/segoeui.ttf', 15)
    except OSError:
        font = ImageFont.load_default()
    boxes = {}

    for name in sorted(os.listdir(out)):
        m = re.fullmatch(re.escape(script) + r'-([a-z]+-\d+)\.png', name)
        if not m:
            continue
        n = m.group(1)
        picture = Image.open(os.path.join(out, name)).convert('RGB')
        overs = sorted((k for k in marks if k.startswith(n + '~')), key=lambda k: -int(k.split('~')[1]))
        for k in overs:   # the window at the back first
            if fixes.get(k, {}).get('skip'):
                continue
            x, y, w, h = marks[k]
            over = Image.open(os.path.join(out, f'{script}-{k}.png')).convert('RGB')
            for (x0, y0, x1, y1), label in fixes.get(k, {}).get('redact', []):
                draw = ImageDraw.Draw(over)
                draw.rectangle((x0, y0, x1, y1), fill=over.getpixel((x0 + 1, y0 + 2)))
                draw.text((x0 + 64, y0 + 3), label, fill=(30, 30, 30), font=font)
            over, left, top = trim_black(over)
            picture.paste(over, (x + left, y + top))
        box = box_for(script, n)
        assert box[1] >= TITLE_BAR, 'the crop would keep the title bar'
        picture.crop(box).save(os.path.join(SITE, name), optimize=True)
        boxes.setdefault(box, []).append(n)
        print(name, picture.crop(box).size, ('+ ' + ', '.join(overs)) if overs else '')

    for box, names in boxes.items():
        w, h = box[2] - box[0], box[3] - box[1]
        print(f"\ncrop {box} - {', '.join(names)}")
        for key, value in marks.items():
            if not isinstance(value, list) or len(value) != 4:
                continue
            x, y, bw, bh = value
            print(f"  {key:14} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")


main()
