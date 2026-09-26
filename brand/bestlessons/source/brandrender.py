"""PNG sizes and favicon.ico from the brand SVGs (headless Chrome renders, Pillow packs the .ico).
Run with ComfyUI's Python (it has Pillow)."""
import os, re, subprocess, sys, tempfile
from PIL import Image

BRAND = sys.argv[1]
CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
TMP = tempfile.mkdtemp ()

def render (svg_name, png_name, w, h, background=None):
    svg = open (os.path.join (BRAND, svg_name), encoding='utf-8').read ()
    svg = re.sub (r'width="\d+" height="\d+"', f'width="{w}" height="{h}"', svg, count=1)
    page = os.path.join (TMP, png_name + '.html')
    bg = background or 'transparent'
    open (page, 'w', encoding='utf-8').write (f'<!doctype html><html><body style="margin:0;background:{bg}">{svg}</body></html>')
    out = os.path.join (BRAND, png_name)
    subprocess.run ([CHROME, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--default-background-color=00000000',
                     '--force-device-scale-factor=1', f'--window-size={w},{h}', f'--screenshot={out}',
                     'file:///' + page.replace ('\\', '/')], capture_output=True, timeout=60)
    im = Image.open (out).convert ('RGBA').crop ((0, 0, w, h))
    im.save (out)
    return out

# the wordmark
render ('bestlessons-logo.svg', 'bestlessons-logo.png', 1886, 1704)
render ('bestlessons-logo.svg', 'bestlessons-logo-small.png', 472, 426)
render ('bestlessons-logo-on-dark.svg', 'bestlessons-logo-on-dark.png', 1886, 1704)
# the main icon (white tile) and the favicon sizes
for s in (512, 192, 48, 32, 16):
    render ('bestlessons-icon.svg', f'icon-{s}.png', s, s)
# phones: full-bleed black squares - iOS and Android round the corners themselves
render ('bestlessons-icon-phone-square.svg', 'apple-touch-icon.png', 180, 180)
render ('bestlessons-icon-phone-square.svg', 'icon-512-maskable.png', 512, 512)
render ('bestlessons-icon-phone.svg', 'icon-phone-512.png', 512, 512)

ico = [Image.open (os.path.join (BRAND, f'icon-{s}.png')) for s in (16, 32, 48)]
ico[2].save (os.path.join (BRAND, 'favicon.ico'), sizes=[(16, 16), (32, 32), (48, 48)], append_images=ico[:2])
for s in (48,):
    os.remove (os.path.join (BRAND, f'icon-{s}.png'))   # only needed inside the .ico
os.replace (os.path.join (BRAND, 'icon-32.png'), os.path.join (BRAND, 'favicon-32.png'))
os.replace (os.path.join (BRAND, 'icon-16.png'), os.path.join (BRAND, 'favicon-16.png'))
print ('\n'.join (sorted (os.listdir (BRAND))))
