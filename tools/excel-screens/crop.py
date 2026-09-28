"""Cuts flatfile.ps1's picture down to the name box, formula bar and grid, and
copies it to the site with where each cell is on the cut picture
(public/assets/lessons/sql/<name>.png and .json - the activity circles cells
by address from the .json). Every crop starts below Excel's ribbon, so the
title bar - which shows the signed-in Office account's initials - is never
kept. Taken at 100% scaling, Excel at 100% zoom. Look at the picture."""
from PIL import Image
import json
import os

HERE = os.path.dirname(__file__)
OUT = os.path.join(HERE, 'out')
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/lessons/sql'
TITLE_BAR = 60          # everything above this is the title bar

# picture: (left, top, right, bottom) in the 1400 x 820 capture - the name
# box and formula bar, the column letters, rows 1 to 13 and columns A to K
# (G to K left empty for the activity's notes)
CROPS = {
    'dbwhat-flatfile': (8, 228, 996, 609),
}

for name, box in CROPS.items():
    if box[1] < TITLE_BAR:
        raise SystemExit(f'{name}: the crop keeps the title bar (the Office account)')

    Image.open(os.path.join(OUT, name + '-raw.png')).crop(box).save(os.path.join(SITE, name + '.png'))

    with open(os.path.join(OUT, name + '-raw.json'), encoding='utf-8-sig') as f:
        raw = json.load(f)
    cells = {address: [x - box[0], y - box[1], w, h] for address, (x, y, w, h) in raw['cells'].items()}
    with open(os.path.join(SITE, name + '.json'), 'w', encoding='utf-8') as f:
        json.dump({'width': box[2] - box[0], 'height': box[3] - box[1], 'cells': cells}, f)

    print(name, box[2] - box[0], 'x', box[3] - box[1])
