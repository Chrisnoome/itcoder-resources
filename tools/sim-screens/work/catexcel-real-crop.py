"""Crops pictures made with work/catexcel-real-kit.ps1 (RealSnap: the screen
inside Excel's window, menus over it included) and copies them to the site,
then prints the script's marks in per cent of the cropped picture - the
numbers a simulation step's 'click', 'at' and 'drag' boxes use. 9 October
2026 ("complete simulations and marking").

    C:/Python314/python.exe work/catexcel-real-crop.py <script> <picture regex> <left> <top> <right> <bottom> [--marks <regex>] [--name <prefix>] [--nopaint]

<picture regex> is matched against the part after "<script>-" (e.g. 'rc-\\d').
The box is in window pixels (the window sits at 0,0 in RealFront, so these
are screen pixels too). The top must be below the title bar (58): it shows
the signed-in account's initials. The VM's Add-ins and Claude ribbon groups
are painted out wherever the Home tab shows them. --name saves the pictures
under another prefix on the site (default: the script's name).
"""
import json, os, re, sys
from PIL import Image, ImageDraw

HERE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SITE = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/sims/catexcel'
TITLE_BAR = 58


def paint_addins(picture):
    """The Add-ins and Claude groups sit at the right of the Home tab's ribbon: Claude's orange mark is
    found, and the two groups (Add-ins just left of it) are painted over with the ribbon's own colour."""
    w = picture.size[0]
    xs = []
    for x in range(0, w, 2):
        for y in range(104, 176, 3):
            r, g, b = picture.getpixel((x, y))[:3]
            if r > 200 and 80 < g < 150 and b < 120:
                xs.append(x)
                break
    if not xs:
        return False
    right = max(xs)
    if len([x for x in xs if x >= right - 40]) < 4:
        return False
    x1, x2 = right - 140, right + 34
    draw = ImageDraw.Draw(picture)
    colour = picture.getpixel((max(0, x1 - 8), 140))
    draw.rectangle((x1, 98, x2, 224), fill=colour)
    return True


def main(args):
    marks_re, prefix, paint = r'.', None, True
    if '--nopaint' in args:   # a tab whose own icons are orange (Formulas, Page Layout): nothing to paint
        args.remove('--nopaint'); paint = False
    if '--marks' in args:
        i = args.index('--marks'); marks_re = args[i + 1]; del args[i:i + 2]
    if '--name' in args:
        i = args.index('--name'); prefix = args[i + 1]; del args[i:i + 2]
    script, pattern = args[0], args[1]
    box = tuple(int(v) for v in args[2:6])
    assert box[1] >= TITLE_BAR, 'the crop would keep the title bar (it shows the account)'
    out = os.path.join(HERE, 'out')
    names = sorted(n for n in os.listdir(out) if n.startswith(script + '-') and n.endswith('.png')
                   and re.fullmatch(pattern, n[len(script) + 1:-4]))
    os.makedirs(SITE, exist_ok=True)
    size = None
    for name in names:
        picture = Image.open(os.path.join(out, name)).convert('RGB')
        painted = paint_addins(picture) if paint else False
        picture = picture.crop(box)
        target = name if not prefix else prefix + name[len(script):]
        picture.save(os.path.join(SITE, target), optimize=True)
        size = picture.size
        print(target, picture.size, '(add-ins painted out)' if painted else '')
    if size is None:
        print('no pictures match', pattern)
        return
    marks_file = os.path.join(out, script + '.json')
    if not os.path.exists(marks_file):
        return
    marks = json.load(open(marks_file, encoding='utf-8-sig')).get('marks', {})
    w, h = size
    for key, value in marks.items():
        if not re.search(marks_re, key) or not isinstance(value, list) or len(value) != 4:
            continue
        x, y, bw, bh = value
        print(f"   {key:18} [{(x - box[0]) / w * 100:.1f}, {(y - box[1]) / h * 100:.1f}, {bw / w * 100:.1f}, {bh / h * 100:.1f}]")


if __name__ == '__main__':
    main(sys.argv[1:])
