"""Crops the catexcel-*.ps1 screens (CAT Spreadsheets, Grade 10 lessons 1-4 -
8 October 2026) and copies them to the site, then prints every place in per
cent of each cropped picture - the numbers the lessons' 'click', 'at' and
hotspot boxes use. cat-crop.py does one crop per script; these scripts mix
the main window (two widths) with dialogs, so each group of pictures has its
own box here. Every main-window crop starts below the title bar (it shows
the signed-in account's initials). Ribbon groups an ordinary Excel does not
have (the VM's Add-ins and Claude groups) are painted out where a crop
reaches them.

    C:/Python314/python.exe work/catexcel-crop.py catexcel-start [...]
"""
import json, os, re, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
TITLE_BAR = 52

# script: [(picture names (regex on the part after "<script>-"), crop box in window pixels, mark keys (regex) to print for it)]
GROUPS = {
    'catexcel-practice': [
        (r'[123]', (0, TITLE_BAR, 900, 490), r'.'),
    ],
    'catexcel-start': [
        (r'win', (0, TITLE_BAR, 1150, 720), r'^w-', [(897, 100, 1046, 222)]),   # the window is narrower here: the add-ins sit further left
        (r'[1234]', (0, TITLE_BAR, 900, 620), r'^(A1|B3|D20|colC|row3|nameBox|formulaBar|selectAll)$'),
        (r'[5678]|s-1|s-5', (0, TITLE_BAR, 1060, 720), r'^(sheet|tab|gridlines|formulaBarBox|headingsBox|pageLayout|normalView)'),
        (r's-[234]', None, r'^d-', [(14, 142, 192, 268)]),   # the dialog's Quick access list: other writers' folders
    ],
    'catexcel-entering': [
        (r'types', (0, 270, 350, 492), r'^$'),
        (r'(fix|num)-\d', (0, TITLE_BAR, 900, 560), r'^(A1|A2|A3|A8|C4|B5|fillA3)$'),
        (r'ins-\d|ins-2r', (0, TITLE_BAR, 1330, 560), r'^(row5|insert|insertSplit|menuInsert|B5|A1)$'),
        (r'cp-\d', (0, TITLE_BAR, 1060, 720), r'^(sheet|A1|E1|copy|paste)'),
    ],
    'catexcel-formulas': [
        (r'[fcbr]-\d', (0, TITLE_BAR, 900, 560), r'^(A1|B2|D\d|fillD2|formulaBar|nameBox)$'),
        (r's-\d', (0, TITLE_BAR, 1330, 560), r'^(tabFormulas|showFormulas)$'),
    ],
    'catexcel-formatting': [
        (r'[thn]-\d|d-[145]', (0, TITLE_BAR, 1060, 500), r'^(?!fc)'),
        (r'd-[23]', None, r'^fc'),
    ],
}

# Window pixels of ribbon groups to paint out (the VM's Add-ins and Claude add-ins), [x1, y1, x2, y2].
PAINT = [(1484, 100, 1650, 222)]


def crop(app):
    marks = json.load(open(os.path.join(HERE, 'out', app + '.json'), encoding='utf-8-sig'))['marks']
    names = sorted(n for n in os.listdir(os.path.join(HERE, 'out')) if n.startswith(app + '-') and n.endswith('.png'))
    os.makedirs(SITE, exist_ok=True)
    for entry in GROUPS[app]:
        pattern, box, keys = entry[:3]
        own = entry[3] if len(entry) > 3 else []
        group = [n for n in names if re.fullmatch(pattern, n[len(app) + 1:-4])]
        if not group:
            print(f'-- {pattern}: no pictures')
            continue
        size = None
        for name in group:
            picture = Image.open(os.path.join(HERE, 'out', name)).convert('RGB')
            if box is None:
                cut = (0, 0) + picture.size
            else:
                assert box[1] >= TITLE_BAR, 'the crop would keep the title bar'
                cut = box
                draw = ImageDraw.Draw(picture)
                for x1, y1, x2, y2 in PAINT:
                    if x1 < cut[2] and picture.size[0] > x1:
                        colour = picture.getpixel((x1 - 6, 140))
                        draw.rectangle((x1, y1, x2, y2), fill=colour)
            draw = ImageDraw.Draw(picture)
            for x1, y1, x2, y2 in own:
                draw.rectangle((x1, y1, x2, y2), fill=picture.getpixel((x1 + 4, y2 + 4)))
            picture = picture.crop(cut)
            picture.save(os.path.join(SITE, name), optimize=True)
            size = picture.size
            print(name, picture.size)
        w, h = size
        ox, oy = (box[0], box[1]) if box else (0, 0)
        for key, value in marks.items():
            if not re.search(keys, key) or not isinstance(value, list) or len(value) != 4:
                continue
            x, y, bw, bh = value
            print(f"   {key:16} [{(x - ox) / w * 100:.1f}, {(y - oy) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")


for app in sys.argv[1:]:
    crop(app)
