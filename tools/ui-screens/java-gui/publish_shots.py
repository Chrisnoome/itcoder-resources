"""Copy lesson 24's screenshots into the course, and cut one picture of each
component for the naming table out of them (using the .txt boxes the
drivers wrote)."""
import glob, os, shutil
from PIL import Image

HERE = os.path.dirname(os.path.abspath(__file__))
TARGET = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\lessons\java'
os.makedirs(TARGET, exist_ok=True)

shots = {}
for folder in ['build/out', 'build2/out', 'build3/out']:
    for path in glob.glob(os.path.join(HERE, folder, 'lesson24-*.png')):
        name = os.path.basename(path)
        shutil.copy(path, os.path.join(TARGET, name))
        shots[name[9:-4]] = path
print('copied', len(shots), 'screenshots')


def boxes(shot):
    found = {}
    path = os.path.join(HERE, 'build', 'out', 'lesson24-' + shot + '.txt')
    for line in open(path, encoding='utf-8'):
        key, value = line.strip().split('=')
        found[key] = [int(v) for v in value.split(',')]
    return found


def cut(shot, key, out_name, pad=4, box=None):
    image = Image.open(shots[shot])
    x, y, w, h = box or boxes(shot)[key]
    region = image.crop((max(0, x - pad), max(0, y - pad), min(image.width, x + w + pad), min(image.height, y + h + pad)))
    region.save(os.path.join(TARGET, 'lesson24-comp-' + out_name + '.png'))


cut('swing-good-empty', None, 'frame', 0, [0, 0, 330, 38])
cut('swing-good-empty', 'totalLabel', 'label', 6)
cut('swing-good-empty', 'nameField', 'field')
cut('swing-text', 'cellField', 'formatted')
cut('swing-text', 'passwordField', 'password')
cut('swing-text', 'notesArea', 'area')
cut('swing-good-empty', 'bookButton', 'button')
cut('swing-choose', 'busCheck', 'check')
cut('swing-good-empty', 'vipRadio', 'radio')
cut('swing-choose', 'provinceCombo', 'combo')
cut('swing-choose', 'bookingsList', 'list')
cut('swing-good-empty', 'ticketsSpinner', 'spinner')
cut('swing-numbers', 'volumeSlider', 'slider')
cut('swing-containers', 'top', 'panel', 0)
cut('swing-containers', 'contact', 'titled')
cut('swing-containers', 'tabs', 'tabs', 2)
cut('swing-containers', 'table', 'table', 2)
cut('swing-containers', 'menus', 'menu', 0)
cut('swing-good-empty', 'statusLabel', 'status', 2)
print('cut', len(glob.glob(os.path.join(TARGET, 'lesson24-comp-*.png'))), 'component pictures')
