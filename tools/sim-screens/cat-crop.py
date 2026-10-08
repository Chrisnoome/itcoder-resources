"""Crops the CAT pilot's simulation screens (cat-excel.ps1, cat-word.ps1,
cat-access.ps1) and copies them to the site, then prints every target in per
cent of the cropped picture - the numbers the lesson's 'click' and 'at' boxes
use. Every crop starts below the title bar, which shows the signed-in Office
account's initials (and, in Access, the file's path) - never keep it.

    C:/Python314/python.exe cat-crop.py cat-excel|cat-word|cat-access
"""
import json, os, sys
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims'
TITLE_BAR = 52

# app: (site folder, crop box in window pixels)
CROPS = {
    'cat-excel':  ('excel',  (0, TITLE_BAR, 720, 500)),
    'cat-word':   ('word',   (0, TITLE_BAR, 1290, 700)),
    'cat-access': ('access', (0, TITLE_BAR, 1150, 965)),
    # catexcel lessons 5-8 (the CAT VM, 100% scaling, title bar 0-57): columns A-F and the ribbon's left half.
    'catexcel-functions': ('catexcel', (0, 58, 760, 690)),
    'catexcel-more':      ('catexcel', (0, 58, 760, 690)),
    'catexcel-charts':    ('catexcel', (0, 58, 940, 720)),      # the chart, and the Insert tab's galleries
    'catexcel-printing':  ('catexcel', (0, 58, 1180, 760)),     # the Page Setup dialog and Backstage reach further
    # catexcel lessons 1-4: only the practice screens fit one box; the other scripts mix window widths
    # and dialogs - work/catexcel-crop.py crops those (and paints out the VM's Add-ins and Claude groups).
    'catexcel-practice':  ('catexcel', (0, TITLE_BAR, 900, 490)),
    # catpowerpoint lessons 1-6 (the CAT VM, an 1800 x 880 window - the ribbon unfolded; title bar 0-60):
    # the whole window inside its frame, the status bar kept (its view buttons are taught).
    # After cropping by hand (see catpowerpoint-text.ps1 and courses/cat-practical-notes/catpowerpoint.md): text ol-1..3
    # (a 1010-high window: box (9, 58, 1791, 1001)), start lay-2 (from catpowerpoint-startlay), and slideshow pdf-4
    # (the OneDrive account name in the Save dialog's folder list painted over with "OneDrive").
    'catpowerpoint-start':     ('catpowerpoint', (9, 58, 1791, 871)),
    'catpowerpoint-text':      ('catpowerpoint', (9, 58, 1791, 871)),
    'catpowerpoint-objects':   ('catpowerpoint', (9, 58, 1791, 871)),
    'catpowerpoint-animation': ('catpowerpoint', (9, 58, 1791, 871)),
    'catpowerpoint-slideshow': ('catpowerpoint', (9, 58, 1791, 871)),
    'catpowerpoint-pat':       ('catpowerpoint', (9, 58, 1791, 871)),
}

# Places on Access's own grids, which UI Automation can't see - read off the pictures (window pixels).
READ_OFF = {
    'cat-access': {
        'viewTop':      [34, 103, 52, 52],    # the top half of View: switches view (the bottom half is its menu)
        'emptyField':   [248, 391, 239, 22],  # the first empty Field Name box, below Joined
        'gradeName':    [248, 345, 239, 22],  # Grade's Field Name box
        'validRule':    [403, 800, 390, 18],  # the Validation Rule box in Field Properties
        'gradeCrit':    [593, 777, 143, 18],  # the Criteria box under Grade
        'runTop':       [88, 104, 52, 56],
    },
    'catexcel-functions': {
        'nameBox':      [20, 236, 128, 26],   # the Name Box (UI Automation gives it no name)
    },
    'catexcel-more': {
        'nameBox':      [20, 236, 128, 26],
    },
}

app = sys.argv[1]
folder, box = CROPS[app]
assert box[1] >= TITLE_BAR, 'the crop would keep the title bar'
dest = os.path.join(SITE, folder)
os.makedirs(dest, exist_ok=True)

for name in sorted(os.listdir(os.path.join(HERE, 'out'))):
    if name.startswith(app + '-') and name.endswith('.png'):
        picture = Image.open(os.path.join(HERE, 'out', name)).crop(box)
        picture.save(os.path.join(dest, name), optimize=True)
        print(name, picture.size)

marks = json.load(open(os.path.join(HERE, 'out', app + '.json'), encoding='utf-8-sig'))['marks']
marks.update(READ_OFF.get(app, {}))
w, h = box[2] - box[0], box[3] - box[1]
for key, (x, y, bw, bh) in marks.items():
    print(f"{key:12} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")
