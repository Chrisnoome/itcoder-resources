"""Cuts shots.ps1's pictures down to what each lesson needs and copies them to
the site (public/assets/lessons/sql/). Every crop starts below Access's title
bar, which shows the signed-in Office account (initials) - never keep it.
Pictures are at the screen's 125% scaling; lessons show them at 80%."""
from PIL import Image
import os

OUT = os.path.join(os.path.dirname(__file__), 'out')
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/lessons/sql'
TITLE_BAR = 58          # everything above this is the title bar

# picture: (left, top, right, bottom) in the 1500 x 950 capture
CROPS = {
    'access00-open':        (0, 58, 800, 440),
    'access00-products':    (225, 262, 960, 918),
    'access00-design':      (225, 262, 1000, 578),
    'access00-sales':       (225, 262, 850, 918),
    'access00-create':      (0, 58, 520, 222),
    'access00-querydesign': (840, 262, 1500, 945),
    'access00-sqlview':     (0, 58, 700, 330),
    'access00-result':      (225, 262, 960, 918),
    # lesson B1 (shots01.ps1)
    'access01-tabledesign': (0, 58, 760, 590),
    'access01-design-name': (225, 262, 800, 905),
    'access01-design-city': (225, 262, 800, 905),
    'access01-sheet':       (225, 262, 960, 337),      # not the new-record row: its default shows with the SQL's quotes
    # lesson B2 (shots02.ps1)
    'access02-grid':           (225, 262, 1000, 880),
    'access02-grid-sql':       (0, 58, 900, 340),
    'access02-grid-result':    (225, 262, 700, 390),
    'access02-grid-or':        (225, 640, 800, 770),
    'access02-grid-andor':     (225, 640, 800, 770),
    # lesson B3 (shots03.ps1)
    'access03-like':        (225, 640, 800, 770),
    'access03-like-result': (225, 262, 700, 340),
    'access03-isnull':      (225, 640, 800, 770),
    'access03-between':     (225, 640, 800, 770),
    'access03-in':          (225, 640, 800, 770),
    'access03-top':         (660, 100, 1060, 222),
    # lesson B4 (shots04.ps1)
    'access04-calc':        (225, 640, 1000, 770),
    'access04-calc-result': (225, 262, 700, 360),
    'access04-expr':        (225, 640, 1000, 770),
    'access04-expr-result': (225, 262, 600, 360),
}

os.makedirs(SITE, exist_ok=True)
for name, box in CROPS.items():
    assert box[1] >= TITLE_BAR, name + ' would keep the title bar'
    source = os.path.join(OUT, name + '.png')
    if not os.path.exists(source):
        print('missing', name)
        continue
    picture = Image.open(source).crop(box)
    picture.save(os.path.join(SITE, name + '.png'), optimize=True)
    print(name, picture.size)
