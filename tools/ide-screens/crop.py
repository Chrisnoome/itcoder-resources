"""Cuts lazarus-ide.ps1's picture down to what Pascal lesson 26 (ides) needs and
copies it to the site (public/assets/lessons/pascal/). The crop starts below
Lazarus's title bar, which shows the throwaway folder's path. The capture is
at the screen's 150% scaling, so the 940 pixels kept show at about their real
size in the lesson's 612-pixel column. A plain white band goes on top where
the title bar was: a part's name, shown above it once the question is over,
needs room above the menu bar.

Also prints the hotspot zones for content/pascal/ides.php (hsIdeParts) as
percentages - move a zone here (in picture pixels) and paste the new line."""
from PIL import Image
import os

OUT = os.path.join(os.path.dirname(__file__), 'out')
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/lessons/pascal'

# (left, top, right, bottom) in ide-window-1.png: the window's own 9-pixel
# border off the left, the title bar off the top.
CROP = (9, 37, 949, 649)
BAND = 26               # the white band on top, in pixels

# Each part (x1, y1, x2, y2) in the cut picture, below the band; several boxes for a part in two places.
ZONES = {
    'Run the program':              [(118, 67, 141, 89)],
    'Add a button to the form':     [(350, 28, 940, 92)],
    'List the components on the form': [(8, 184, 440, 338)],
    "Change the form's Caption":    [(8, 412, 440, 612), (8, 385, 86, 411)],   # the rows, and the Properties tab
    'Set what a click does':        [(86, 385, 144, 411)],
    'Move a button on the form':    [(488, 185, 932, 494)],
    'Save the project':             [(5, 4, 32, 24), (255, 4, 308, 24), (118, 30, 172, 56)],   # File, Project, the save icons
    'See the code behind the form': [(485, 159, 545, 183)],
}

cut = Image.open(os.path.join(OUT, 'ide-window-1.png')).convert('RGB').crop(CROP)
picture = Image.new('RGB', (cut.width, cut.height + BAND), 'white')
picture.paste(cut, (0, BAND))
picture.save(os.path.join(SITE, 'pic-lazarus-ide.png'), optimize=True)
width, height = picture.size
print('pic-lazarus-ide.png', width, 'x', height)


def Percent(box):
    x1, y1, x2, y2 = box
    y1, y2 = y1 + BAND, y2 + BAND
    return '[%.2f, %.2f, %.2f, %.2f]' % (x1 * 100 / width, y1 * 100 / height, (x2 - x1) * 100 / width, (y2 - y1) * 100 / height)


for name, boxes in ZONES.items():
    value = Percent(boxes[0]) if len(boxes) == 1 else '[' + ', '.join(Percent(box) for box in boxes) + ']'
    print("        %-34s=> %s," % (('"' + name + '"') if "'" in name else ("'" + name + "'"), value))
