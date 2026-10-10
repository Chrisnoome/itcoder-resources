"""Turns the club's pictures into PNGs and photographs every model page.

1. pics/*.svg (drawn by make_art.py) -> public/assets/practical/html/robotics/*.png -
   the folder an HTML block with 'images' => 'robotics' takes a pupil's
   <img src="boxy.png"> from.
2. Each page in content/clubweb/pages/ is opened in real Chrome at 800 px wide,
   with those pictures beside it, photographed, and framed in a plain browser
   window -> public/assets/lessons/clubweb/<page>.png. Real screenshots, never
   drawn (brand/clubweb-art-style.md).

  python -X utf8 tools/clubweb/shots.py
"""
import os, shutil, tempfile, pathlib
from playwright.sync_api import sync_playwright

HERE = os.path.dirname(os.path.abspath(__file__))
SITE = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse'
PAGES = os.path.join(SITE, 'content', 'clubweb', 'pages')
PICS_OUT = os.path.join(SITE, 'public', 'assets', 'practical', 'html', 'robotics')
SHOTS_OUT = os.path.join(SITE, 'public', 'assets', 'lessons', 'clubweb')

FRAME = '''<!doctype html><html><head><style>
body {{ margin: 0; padding: 14px; background: #ffffff; font-family: 'Segoe UI', sans-serif; }}
.win {{ width: 800px; border: 3px solid #111; border-radius: 10px; overflow: hidden; box-shadow: 5px 6px 0 #111; }}
.bar {{ display: flex; align-items: center; gap: 8px; background: #e9ecf3; border-bottom: 3px solid #111; padding: 8px 12px; }}
.dot {{ width: 12px; height: 12px; border-radius: 50%; border: 2px solid #111; }}
.addr {{ flex: 1; margin-left: 10px; background: #fff; border: 2px solid #111; border-radius: 14px; padding: 3px 12px; font-size: 13px; color: #333; }}
img {{ display: block; width: 800px; }}
</style></head><body><div class="win"><div class="bar"><span class="dot" style="background:#ff5f57"></span><span class="dot" style="background:#febc2e"></span><span class="dot" style="background:#28c840"></span>
<span class="addr">robotics.ridgeview.example</span></div><img src="{shot}"></div></body></html>'''


def main():
    os.makedirs(PICS_OUT, exist_ok=True)
    os.makedirs(SHOTS_OUT, exist_ok=True)
    work = tempfile.mkdtemp(prefix='clubweb-')
    with sync_playwright() as p:
        browser = p.chromium.launch(channel='chrome')
        page = browser.new_page(viewport={'width': 800, 'height': 600}, device_scale_factor=1)
        # 1. the club's pictures
        for svg in sorted(os.listdir(os.path.join(HERE, 'pics'))):
            if not svg.endswith('.svg'):
                continue
            page.goto(pathlib.Path(os.path.join(HERE, 'pics', svg)).as_uri())
            page.set_viewport_size({'width': 400, 'height': 300})
            out = os.path.join(PICS_OUT, svg[:-4] + '.png')
            page.screenshot(path=out, clip={'x': 0, 'y': 0, 'width': 400, 'height': 300})
            shutil.copy(out, work)
            print('picture', os.path.basename(out))
        # 2. each model page, then its frame
        page.set_viewport_size({'width': 800, 'height': 600})
        for name in sorted(os.listdir(PAGES)):
            if not name.endswith('.html'):
                continue
            shutil.copy(os.path.join(PAGES, name), work)
            page.goto(pathlib.Path(os.path.join(work, name)).as_uri())
            page.wait_for_timeout(200)
            raw = os.path.join(work, name[:-5] + '-raw.png')
            page.screenshot(path=raw, full_page=True)
            frame = os.path.join(work, name[:-5] + '-frame.html')
            with open(frame, 'w', encoding='utf-8') as f:
                f.write(FRAME.format(shot=os.path.basename(raw)))
            page.set_viewport_size({'width': 840, 'height': 400})
            page.goto(pathlib.Path(frame).as_uri())
            page.wait_for_timeout(150)
            page.locator('.win').screenshot(path=os.path.join(SHOTS_OUT, name[:-5] + '.png'))
            page.set_viewport_size({'width': 800, 'height': 600})
            print('shot', name[:-5] + '.png')
        browser.close()
    shutil.rmtree(work, ignore_errors=True)


main()
