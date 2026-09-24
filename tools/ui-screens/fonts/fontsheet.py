# Renders a sample of each standard Windows 11 font family (Microsoft's
# "Font List Windows 11") to a PNG, for lesson 23's font list.
import os, re, json
from PIL import Image, ImageDraw, ImageFont

F = r'C:\Windows\Fonts'
OUT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\lessons\pascal\fonts'
HERE = os.path.dirname(os.path.abspath(__file__))

groups = [
 ('Sans-serif - for forms and screens', [('Arial','arial.ttf'),('Bahnschrift','bahnschrift.ttf'),('Calibri','calibri.ttf'),('Candara','Candara.ttf'),('Corbel','corbel.ttf'),('Franklin Gothic Medium','framd.ttf'),('Lucida Sans Unicode','l_10646.ttf'),('Microsoft Sans Serif','micross.ttf'),('Segoe UI','segoeui.ttf'),('Segoe UI Variable','SegUIVar.ttf'),('Tahoma','tahoma.ttf'),('Trebuchet MS','trebuc.ttf'),('Verdana','verdana.ttf')]),
 ('Serif - for printed pages and long reading', [('Cambria','cambria.ttc'),('Constantia','constan.ttf'),('Georgia','georgia.ttf'),('Palatino Linotype','pala.ttf'),('Sitka','SitkaVF.ttf'),('Sylfaen','sylfaen.ttf'),('Times New Roman','times.ttf')]),
 ('Monospace - for code and columns of figures', [('Cascadia Code','CascadiaCode.ttf'),('Cascadia Mono','CascadiaMono.ttf'),('Consolas','consola.ttf'),('Courier New','cour.ttf'),('Lucida Console','lucon.ttf')]),
 ('Display and handwriting - titles and fun, never a whole form', [('Arial Black','ariblk.ttf'),('Comic Sans MS','comic.ttf'),('Gabriola','Gabriola.ttf'),('Impact','impact.ttf'),('Ink Free','Inkfree.ttf'),('MV Boli','mvboli.ttf'),('Segoe Print','segoepr.ttf'),('Segoe Script','segoesc.ttf')]),
 ('Other languages - they have Latin letters too', [('Ebrima','ebrima.ttf'),('Gadugi','gadugi.ttf'),('Javanese Text','javatext.ttf'),('Leelawadee UI','LeelawUI.ttf'),('Malgun Gothic','malgun.ttf'),('Microsoft Himalaya','himalaya.ttf'),('Microsoft JhengHei','msjh.ttc'),('Microsoft New Tai Lue','ntailu.ttf'),('Microsoft PhagsPa','phagspa.ttf'),('Microsoft Tai Le','taile.ttf'),('Microsoft YaHei','msyh.ttc'),('Microsoft Yi Baiti','msyi.ttf'),('MingLiU-ExtB','mingliub.ttc'),('Mongolian Baiti','monbaiti.ttf'),('MS Gothic','msgothic.ttc'),('Myanmar Text','mmrtext.ttf'),('Nirmala UI','Nirmala.ttc'),('Segoe UI Historic','seguihis.ttf'),('SimSun','simsun.ttc'),('Yu Gothic','YuGothR.ttc')]),
 ('Symbols and icons - pictures, not letters', [('Cambria Math','cambria.ttc'),('Marlett','marlett.ttf'),('Segoe Fluent Icons','SegoeIcons.ttf'),('Segoe MDL2 Assets','segmdl2.ttf'),('Segoe UI Emoji','seguiemj.ttf'),('Segoe UI Symbol','seguisym.ttf'),('Symbol','symbol.ttf'),('Webdings','webdings.ttf'),('Wingdings','wingding.ttf')]),
]

SAMPLE = 'Book seats for the school play - R150, 0123456789'
ICONS = '  '.join(chr(c) for c in [0xE70F, 0xE710, 0xE711, 0xE72C, 0xE74D, 0xE749, 0xE721, 0xE713, 0xE80F, 0xE77B, 0xE715])
SYMB = lambda s: ''.join(chr(0xF000 + ord(c)) for c in s)   # symbol fonts live at U+F020..U+F0FF
special = {
    'Cambria Math':       ('\u2211 x\u00b2 + y\u00b2 \u2264 \u221az   \u03c0 \u2248 3.14   \u221e', 1),
    'Marlett':            (SYMB('0 1 2 3 4 5 6 r s t u v w'), 0),
    'Segoe Fluent Icons': (ICONS, 0),
    'Segoe MDL2 Assets':  (ICONS, 0),
    'Segoe UI Emoji':     ('\U0001F600 \U0001F44D \U0001F3AD \U0001F39F \U0001F4C5 \U0001F5A8 \U0001F5D1 \u2714', 0),
    'Segoe UI Symbol':    ('\u2605 \u260e \u2709 \u26a0 \u2714 \u2718 \u266b \u2600 \u231a \u263a', 0),
    'Symbol':             (SYMB('a b g d e p q l m S W'), 0),
    'Webdings':           (SYMB('! " # $ % & ( ) * + 0 1 2 3 4 5 6 7 8 9'), 0),
    'Wingdings':          (SYMB('! " # $ % & ( ) * + 0 1 2 3 4 5 6 7 8 9'), 0),
}

data = []
for gname, fonts in groups:
    rows = []
    for name, file in fonts:
        text, index = special.get(name, (SAMPLE, 0))
        emoji = name == 'Segoe UI Emoji'
        try:
            font = ImageFont.truetype(os.path.join(F, file), 34 if not emoji else 32, index=index)
            im = Image.new('RGBA', (2400, 140), (255, 255, 255, 0))
            ImageDraw.Draw(im).text((10, 24), text, font=font, fill=(20, 20, 20, 255), embedded_color=emoji)
        except OSError as problem:
            try:
                font = ImageFont.truetype(os.path.join(F, file), 34, index=index, layout_engine=ImageFont.Layout.BASIC)
                im = Image.new('RGBA', (2400, 140), (255, 255, 255, 0))
                ImageDraw.Draw(im).text((10, 24), text, font=font, fill=(20, 20, 20, 255))
            except OSError as again:
                print('FAILED', name, again)
                continue
        box = im.getbbox()
        im = im.crop((max(0, box[0] - 6), max(0, box[1] - 6), box[2] + 6, box[3] + 6))
        bg = Image.new('RGB', im.size, 'white')
        bg.paste(im, mask=im.split()[3])
        slug = re.sub('[^a-z0-9]+', '-', name.lower()).strip('-')
        bg.save(os.path.join(OUT, slug + '.png'), optimize=True)
        rows.append([name, slug])
    data.append([gname, rows])

json.dump(data, open(os.path.join(HERE, 'fonts.json'), 'w'), indent=1)
ims = [Image.open(os.path.join(OUT, s + '.png')) for g in data for n, s in g[1]]
W = max(i.width for i in ims) // 2 + 10
H = sum(i.height // 2 + 4 for i in ims)
sheet = Image.new('RGB', (W, H), 'white'); y = 0
for i in ims:
    j = i.resize((i.width // 2, i.height // 2)); sheet.paste(j, (5, y)); y += j.height + 4
sheet.save(os.path.join(HERE, 'fonts.png'))
print('done', sum(len(g[1]) for g in data))
