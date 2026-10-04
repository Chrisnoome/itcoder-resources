"""BestLessons channel art (Chris, 4 October 2026: one main channel, @BestLessonsSA, renamed from Pascal Code
Singer). Built from the site's own logo files in brand/bestlessons/, so the channel matches the site.

  python bestlessons_art.py   -> brand/youtube/bestlessons/avatar.png (800), banner.png (2560 x 1440),
                                 watermark.png (150, clear background)

The banner keeps the name and subjects inside the 1546 x 423 middle every device shows; the coloured
strip under it uses each playlist's colour from thumbs.py."""
import os, subprocess, tempfile
from urllib.parse import quote
from PIL import Image

HERE = os.path.dirname (os.path.abspath (__file__))
YT = os.path.dirname (HERE)
BRAND = os.path.join (os.path.dirname (YT), 'bestlessons')
OUT = os.path.join (YT, 'bestlessons')
CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
FONTS = 'file:///C:/Users/chris/AppData/Local/Microsoft/Windows/Fonts/'
INK, BLUE = '#111111', '#7ea6ff'
# the playlists' colours (thumbs.py CHANNELS accents), in the order the banner names the subjects
SUBJECTS = [('Pascal', '#2ec4b6'), ('Java', '#f28c28'), ('SQL', '#6fe3a5'), ('CAT', '#ff6a4d'),
            ('Computer skills', '#ff8fd1'), ('IT songs', '#ffcc33'), ('AI', '#ffd166')]


def url (path):
    return 'file:///' + quote (path.replace ('\\', '/'))


def page (w, h, body, bg=INK):
    return f'''<!doctype html><html><head><style>
@font-face{{font-family:M;src:url('{FONTS}Montserrat-ExtraBold.ttf');font-weight:800}}
@font-face{{font-family:M;src:url('{FONTS}Montserrat-Bold.ttf');font-weight:700}}
html,body{{margin:0;width:{w}px;height:{h}px;background:{bg};overflow:hidden;font-family:M}}
</style></head><body>{body}</body></html>'''


def banner ():
    pills = ''.join (f'<span style="color:{c}">{s}</span>' + ('<i>·</i>' if i < len (SUBJECTS) - 1 else '')
                     for i, (s, c) in enumerate (SUBJECTS))
    strip = ''.join (f'<div style="flex:1;background:{c}"></div>' for _, c in SUBJECTS)
    return page (2560, 1440, f'''
<div style="position:absolute;left:567px;top:508px;width:1426px;height:423px;display:flex;align-items:center;gap:60px">
  <img src="{url (os.path.join (BRAND, 'bestlessons-logo-on-dark.svg'))}" style="height:300px">
  <div style="display:flex;flex-direction:column;gap:26px">
    <div style="color:#fff;font-weight:800;font-size:62px;line-height:1.1">Lessons, practice and videos<br>for South African IT and CAT</div>
    <div style="font-weight:800;font-size:34px;display:flex;flex-wrap:nowrap;white-space:nowrap;gap:0 14px">{pills}</div>
    <div style="color:{BLUE};font-weight:700;font-size:36px">bestlessons.co.za</div>
  </div>
</div>
<style>i{{font-style:normal;color:#555}}</style>
<div style="position:absolute;left:567px;width:1426px;top:940px;height:14px;display:flex;gap:10px">{strip}</div>''')


def avatar ():
    return page (800, 800, f'<img src="{url (os.path.join (BRAND, "bestlessons-icon-phone-square.svg"))}" style="width:800px;height:800px;display:block">')


def watermark ():
    return page (150, 150, f'<img src="{url (os.path.join (BRAND, "bestlessons-icon-phone-square.svg"))}" '
                           f'style="width:150px;height:150px;display:block;border-radius:50%">', bg='transparent')


def render (html, png, w, h):
    tmp = os.path.join (tempfile.mkdtemp (), 'p.html')
    open (tmp, 'w', encoding='utf-8').write (html)
    subprocess.run ([CHROME, '--headless=new', '--disable-gpu', '--hide-scrollbars', '--default-background-color=00000000',
                     '--force-device-scale-factor=1', '--virtual-time-budget=3000', f'--window-size={w},{h}',
                     f'--screenshot={png}', url (tmp)], capture_output=True, timeout=120)
    im = Image.open (png).convert ('RGBA').crop ((0, 0, w, h))
    (im if w == 150 else im.convert ('RGB')).save (png, optimize=True)


os.makedirs (OUT, exist_ok=True)
for name, make, w, h in (('avatar', avatar, 800, 800), ('banner', banner, 2560, 1440), ('watermark', watermark, 150, 150)):
    render (make (), os.path.join (OUT, name + '.png'), w, h)
    print ('ok', name)
