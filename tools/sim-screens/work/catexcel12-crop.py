"""Crops the catexcel Grade 12 screens (catexcel-nestedif.ps1 ... -scenario.ps1,
9 October 2026) and copies them to the site, then prints every place in per
cent of each cropped picture - the numbers the lessons' 'click' and 'at'
boxes use. Every crop starts below the title bar (it shows the signed-in
account's initials). The VM's Add-ins and Claude ribbon groups are painted
out wherever a crop reaches them (their place is found per picture: the
window's width decides it). Same idea as catexcel-crop.py (Grade 10).

    C:/Python314/python.exe work/catexcel12-crop.py catexcel-nestedif [...]
"""
import json, os, re, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
TITLE_BAR = 58

# script: [(picture names (regex on the part after "<script>-"), crop box in window pixels, mark keys (regex) to print)]
GROUPS = {
    'catexcel-nestedif': [
        (r'[naoefc]-\d', (0, TITLE_BAR, 1000, 760), r'.'),
    ],
    'catexcel-countifs': [
        (r'[cri]-\d', (0, TITLE_BAR, 1000, 800), r'.'),
    ],
    'catexcel-lookups': [
        (r'[vhnxma]-[0-9a-z]', (0, TITLE_BAR, 1150, 800), r'.'),
    ],
    'catexcel-text': [
        (r'[lfjs]-\d', (0, TITLE_BAR, 1060, 800), r'.'),
    ],
    'catexcel-dates': [
        (r'[dtwe]-\d', (0, TITLE_BAR, 1060, 800), r'.'),
    ],
    'catexcel-summaries': [
        (r'[sgbpc]-\d', (0, TITLE_BAR, 1850, 820), r'.'),
    ],
    'catexcel-datatools': [
        (r'[vrkp]-\d\w?', (0, TITLE_BAR, 1460, 820), r'.'),
        (r'm-\d', (0, TITLE_BAR, 1850, 820), r'^btnMacros$'),
    ],
    'catexcel-charts12': [
        (r'[asptck]-\d', (0, TITLE_BAR, 1850, 820), r'.'),
    ],
    'catexcel-scenario': [
        (r'[tef]-\d', (0, TITLE_BAR, 1400, 820), r'.'),
    ],
}


def paint_addins(picture, cut):
    """Paints out the Add-ins and Claude groups (only the Home tab has them): Claude's orange mark is
    found in the ribbon, and the two groups around it (Add-ins is the one to its left) are painted over."""
    w = picture.size[0]
    r, g, b = picture.getpixel((117, 95))[:3]
    if not (g > 90 and r < 60 and b < 90):   # the Home tab's green underline: only the Home tab has the add-ins
        return
    xs = []
    for x in range(0, w, 2):
        for y in range(108, 172, 3):
            r, g, b = picture.getpixel((x, y))[:3]
            if r > 200 and 80 < g < 150 and b < 120:
                xs.append(x)
                break
    if not xs:
        return
    right = max(xs)
    if len([x for x in xs if x >= right - 40]) < 4:   # Claude's mark is a cluster at the right of the ribbon
        return
    x1, x2 = right - 140, right + 30
    if x1 >= cut[2]:
        return
    draw = ImageDraw.Draw(picture)
    colour = picture.getpixel((max(0, x1 - 6), 140))
    draw.rectangle((x1, 100, x2, 222), fill=colour)


def crop(app, only=None):
    marks = json.load(open(os.path.join(HERE, 'out', app + '.json'), encoding='utf-8-sig'))['marks']
    names = sorted(n for n in os.listdir(os.path.join(HERE, 'out')) if n.startswith(app + '-') and n.endswith('.png'))
    os.makedirs(SITE, exist_ok=True)
    for pattern, box, keys in GROUPS[app]:
        group = [n for n in names if re.fullmatch(pattern, n[len(app) + 1:-4])]
        if only:
            group = [n for n in group if re.fullmatch(only, n[len(app) + 1:-4])]
        if not group:
            print(f'-- {pattern}: no pictures')
            continue
        size = None
        for name in group:
            picture = Image.open(os.path.join(HERE, 'out', name)).convert('RGB')
            assert box[1] >= TITLE_BAR, 'the crop would keep the title bar'
            paint_addins(picture, box)
            picture = picture.crop(box)
            picture.save(os.path.join(SITE, name), optimize=True)
            size = picture.size
            print(name, picture.size)
        w, h = size
        ox, oy = box[0], box[1]
        for key, value in marks.items():
            if not re.search(keys, key) or not isinstance(value, list) or len(value) != 4:
                continue
            x, y, bw, bh = value
            print(f"   {key:16} [{(x - ox) / w * 100:.1f}, {(y - oy) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")


if __name__ == '__main__':
    args = sys.argv[1:]
    only = None
    if '--only' in args:
        i = args.index('--only'); only = args[i + 1]; del args[i:i + 2]
    for app in args:
        crop(app, only)
