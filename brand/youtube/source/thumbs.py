"""YouTube video thumbnails (1280 x 720) for all eight channels, in one style with each channel's colours
(the CHANNELS table; brand/youtube/README.md, "Video thumbnails"). Montserrat for words, JetBrains Mono for
the tag and code. One HTML file per video, rendered to PNG with headless Chrome.

  python thumbs.py [--channel FOLDER] [id ...]   specs from thumbs.json (codesinger) or thumbs-FOLDER.json
  python thumbs.py --card [--channel FOLDER] [id ...]   the opening title card: same picture, 1920 x 1080
                                                  -> FOLDER/cards/<id>.png
  python thumbs.py --samples                      one sample per channel -> source/samples/FOLDER.png

A spec: id, tag, title (list of lines; *word* = accent colour), and either a frame from the video in
FOLDER/frames/<id>.jpg (right side, fading into the background; pos = CSS background-position) or code
(list of lines in a card; strike = index of a line drawn struck through). Output: FOLDER/thumbs/<id>.png."""
import html, json, os, re, subprocess, sys, urllib.parse

HERE = os.path.dirname (os.path.abspath (__file__))
ROOT = os.path.join (HERE, '..')
CHROME = 'C:/Program Files/Google/Chrome/Application/chrome.exe'
USER_FONTS = 'file:///C:/Users/chris/AppData/Local/Microsoft/Windows/Fonts/'
WIN_FONTS = 'file:///C:/Windows/Fonts/'

# bg: background, accent: *words*, tag and pill, muted: the channel name at the bottom,
# line: the BestLessons blue rising line under the name (the School SA family and Computer Skills SA).
CHANNELS = {
 'codesinger':  dict (name='Pascal Code Singer', bg='#141414', accent='#ffcc33', muted='#9a9a9a', line=False),
 'pascal':      dict (name='Pascal School SA',   bg='#12355b', accent='#2ec4b6', muted='#a9bdd6', line=True),
 'java':        dict (name='Java School SA',     bg='#2b1a12', accent='#f28c28', muted='#c9b4a2', line=True),
 'sql':         dict (name='SQL School SA',      bg='#0e3b2a', accent='#6fe3a5', muted='#a3c9b6', line=True),
 'cat':         dict (name='CAT School SA',      bg='#1b2233', accent='#ff6a4d', muted='#aab3c7', line=True),
 'skills':      dict (name='Computer Skills SA', bg='#4a1240', accent='#ff8fd1', muted='#d7b3cd', line=True),
 'ai4all':      dict (name='AI 4 All',           bg='#2d2a8c', accent='#ffd166', muted='#c9b8ff', line=False),
 'ai4teachers': dict (name='AI for Teachers',    bg='#c8372d', accent='#ffd166', muted='#f6d2cd', line=False),
}

NOTE = ('<g fill="#ffffff"><ellipse cx="0" cy="0" rx="30" ry="22" transform="rotate(-20)"/>'
        '<rect x="21" y="-108" width="11" height="108"/>'
        '<path d="M29 -108 C54 -96 70 -84 64 -54 C60 -70 50 -78 29 -80 Z"/></g>')

def rgba (hexc, a):
    h = hexc.lstrip ('#')
    return 'rgba(%d,%d,%d,%s)' % (int (h[0:2], 16), int (h[2:4], 16), int (h[4:6], 16), a)

def fileurl (path):
    return 'file:///' + urllib.parse.quote (os.path.abspath (path).replace (os.sep, '/'))

def accent (line):
    """*word* -> accent span; everything else escaped."""
    parts = re.split (r'(\*[^*]+\*)', line)
    return ''.join ('<span class="g">%s</span>' % html.escape (p[1:-1]) if p.startswith ('*')
                    else html.escape (p) for p in parts)

def mark (folder, c):
    """The small mark before the channel name: the note and ; for the songs, else the channel avatar."""
    if folder == 'codesinger':
        return ('<svg width="40" height="48" viewBox="-40 -120 120 150">%s<text x="62" y="10" font-family="JM" '
                'font-size="90" fill="%s">;</text></svg>' % (NOTE, c['accent']))
    return '<img class="av" src="%s">' % fileurl (os.path.join (ROOT, folder, 'avatar.png'))

def page (spec, folder):
    c = CHANNELS[folder]
    lines = spec['title']
    longest = max (len (re.sub (r'\*', '', l)) for l in lines)
    frame = os.path.join (ROOT, folder, 'frames', spec['id'] + '.jpg')
    has_frame = os.path.exists (frame)
    has_code = bool (spec.get ('code')) and not has_frame
    width = 600 if has_frame else 640 if has_code else 1150
    size = min (170, int (width / (0.6 * max (longest, 4))), int (430 / len (lines) / 1.02))
    code = shot = deco = ''
    if has_code:
        rows = []
        for i, line in enumerate (spec['code']):
            cls = ' class="x"' if spec.get ('strike') == i else ''
            rows.append ('<div%s>%s</div>' % (cls, html.escape (line) or '&nbsp;'))
        longc = max (len (line) for line in spec['code'])
        csize = min (44, int (420 / (0.6 * max (longc, 8))))
        code = '<div class="code" style="font-size:%dpx">%s</div>' % (csize, ''.join (rows))
    if has_frame:
        shot = ('<div class="shot" style="background-image:url(%s);background-position:%s"></div>'
                '<div class="fade"></div>' % (fileurl (frame), spec.get ('pos', '50% 25%')))
    elif folder == 'codesinger':   # staff lines and three notes, bottom right
        note = NOTE.replace ('#ffffff', c['accent'])
        deco = ('<g stroke="#fff" stroke-width="2" opacity=".14">%s</g>%s' % (
            ''.join ('<path d="M760 %d H1280"/>' % y for y in range (590, 700, 26)),
            ''.join ('<g transform="translate(%d %d) scale(0.5)" opacity="0.5">%s</g>' % (x, y, note)
                     for x, y in ((880, 650), (960, 620), (1040, 640)))))
    line = '<svg class="line" width="300" height="16"><path d="M2 13 C90 13 200 9 298 2" stroke="#7ea6ff" stroke-width="5" fill="none" stroke-linecap="round"/></svg>' if c['line'] else ''
    return '''<!doctype html><html><head><meta charset="utf-8"><style>
@font-face {font-family:MB; src:url('%(uf)sMontserrat-Black.ttf');}
@font-face {font-family:MBold; src:url('%(uf)sMontserrat-Bold.ttf');}
@font-face {font-family:JM; src:url('%(wf)sJetBrainsMono-ExtraBold.ttf');}
html,body {margin:0; width:1280px; height:720px; overflow:hidden; background:%(bg)s;}
.tag {position:absolute; left:64px; top:52px; font:30px JM; color:%(ac)s; letter-spacing:2px;
      border:3px solid %(ac)s; border-radius:40px; padding:8px 26px;}
.title {position:absolute; left:64px; top:150px; height:430px; width:%(tw)dpx; display:flex;
        align-items:center; font-family:MB; white-space:nowrap; color:#fff; line-height:1.02; letter-spacing:-1px;
        font-size:%(size)dpx;}
.g {color:%(ac)s;}
.code {position:absolute; right:56px; top:170px; width:420px; background:rgba(0,0,0,.35); border:3px solid rgba(255,255,255,.12);
       border-radius:22px; padding:30px 34px; font-family:JM; color:#eee; line-height:1.45;
       transform:rotate(2deg); box-shadow:0 20px 50px rgba(0,0,0,.5); white-space:pre;}
.code .x {color:#ff6b6b; text-decoration:line-through; text-decoration-thickness:3px; opacity:.85;}
.brand {position:absolute; left:64px; bottom:42px; font:32px MBold; color:%(mu)s; display:flex;
        align-items:center; gap:16px;}
.av {width:48px; height:48px; border-radius:50%%;}
.line {position:absolute; left:64px; bottom:24px; z-index:2;}
svg.bg {position:absolute; left:0; top:0;}
.shot {position:absolute; left:470px; top:0; width:810px; height:720px; background-size:auto 116%%;
       background-repeat:no-repeat;}
.fade {position:absolute; left:470px; top:0; width:810px; height:720px;
       background:linear-gradient(to right,%(bg)s 0%%,%(f85)s 14%%,%(f0)s 42%%),
                  linear-gradient(to top,%(f70)s 0%%,%(f0)s 22%%);}
.title, .tag, .brand {z-index:2;}
.title {text-shadow:0 4px 18px rgba(0,0,0,.6);}
</style></head><body>
<svg class="bg" width="1280" height="720">%(deco)s</svg>
<div class="tag">%(tag)s</div>
<div class="title"><div>%(title)s</div></div>
%(code)s%(shot)s
<div class="brand">%(mark)s%(name)s</div>%(line)s
<script>
document.fonts.ready.then(()=>{const box=document.querySelector('.title'), inner=box.firstElementChild; let f=parseFloat(getComputedStyle(box).fontSize);
while ((inner.scrollWidth>box.clientWidth || inner.scrollHeight>box.clientHeight) && f>40) { f-=2; box.style.fontSize=f+'px'; }});
</script></body></html>''' % dict (uf=USER_FONTS, wf=WIN_FONTS, tw=width, size=size, code=code, shot=shot,
                         title='<br>'.join (accent (l) for l in lines), tag=html.escape (spec['tag']),
                         deco=deco, mark=mark (folder, c), name=html.escape (c['name']), line=line,
                         bg=c['bg'], ac=c['accent'], mu=c['muted'],
                         f85=rgba (c['bg'], .85), f70=rgba (c['bg'], .7), f0=rgba (c['bg'], 0))

def render (spec, folder, png, scale=1):
    os.makedirs (os.path.dirname (png), exist_ok=True)
    h = png[:-4] + '.html'
    open (h, 'w', encoding='utf-8').write (page (spec, folder))
    subprocess.run ([CHROME, '--headless=new', '--disable-gpu', '--hide-scrollbars',
                     '--allow-file-access-from-files', '--window-size=1280,720', '--virtual-time-budget=4000',
                     '--force-device-scale-factor=%s' % scale,
                     '--screenshot=' + png, 'file:///' + h.replace ('\\', '/')],
                    check=True, capture_output=True)

SAMPLES = {   # one made-up video per channel, for the style record in README.md
 'pascal': dict (id='sample', tag='PASCAL · ARRAYS', title=['Sorting', 'an *Array*'], code=['For i := 1 To n - 1 Do', '  If a[i] > a[i+1] Then', '    Swap (a[i], a[i+1]);']),
 'java': dict (id='sample', tag='JAVA · CLASSES', title=['Your First', '*Class*'], code=['public class Pupil {', '  private String name;', '}']),
 'sql': dict (id='sample', tag='SQL · JOINS', title=['INNER', '*JOIN*'], code=['SELECT p.name, c.mark', 'FROM tblPupils p', 'JOIN tblCodes c', '  ON p.id = c.pupilId;']),
 'cat': dict (id='sample', tag='CAT · SPREADSHEETS', title=['VLOOKUP', 'in *5 Minutes*'], code=['=VLOOKUP(A2;', '  Prices!A:B;', '  2;FALSE)']),
 'skills': dict (id='sample', tag='HOW-TO · FILES', title=['Zip a', '*Folder*'], code=['Right-click', '> Send to', '> Compressed (zipped)']),
 'ai4all': dict (id='sample', tag='AI · EVERYDAY', title=['Write a', '*Tricky Email*'], code=['"Help me say no', ' politely to my', ' neighbour..."']),
 'ai4teachers': dict (id='sample', tag='ADMIN · REPORTS', title=['Report Comments', 'in *Minutes*'], code=['"Write a 2-line', ' comment for a', ' Grade 10 pupil..."']),
}

def main ():
    args = sys.argv[1:]
    if args[:1] == ['--samples']:
        for folder, spec in SAMPLES.items ():
            render (spec, folder, os.path.join (HERE, 'samples', folder + '.png'))
            print ('ok', folder)
        return
    card = False
    if args[:1] == ['--card']:   # the video's opening title card: the same picture at 1920 x 1080
        card, args = True, args[1:]
    folder = 'codesinger'
    if args[:1] == ['--channel']:
        folder, args = args[1], args[2:]
    name = 'thumbs.json' if folder == 'codesinger' else 'thumbs-%s.json' % folder
    specs = json.load (open (os.path.join (HERE, name), encoding='utf-8'))
    want = set (args)
    for s in specs:
        if want and s['id'] not in want:
            continue
        if card:
            render (s, folder, os.path.join (ROOT, folder, 'cards', s['id'] + '.png'), 1.5)
        else:
            render (s, folder, os.path.join (ROOT, folder, 'thumbs', s['id'] + '.png'))
        print ('ok', s['id'])

if __name__ == '__main__':
    main ()
