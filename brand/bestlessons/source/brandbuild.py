"""The final bestlessons.co.za logo and icons as outlined SVG (Chris, 26 September 2026: wordmark E;
icon 2 on white as the main icon and favicon, icon 2 on black for phones). Run with a Python that has
fontTools (ComfyUI's). Montserrat comes from the user fonts folder."""
import os, sys
from fontTools.ttLib import TTFont
from fontTools.pens.svgPathPen import SVGPathPen
from fontTools.pens.transformPen import TransformPen

OUT = sys.argv[1]
os.makedirs (OUT, exist_ok=True)
FONTS = 'C:/Users/chris/AppData/Local/Microsoft/Windows/Fonts/'
INK, BLUE, LIGHT = '#111111', '#1a55e3', '#7ea6ff'


class Face:
    def __init__ (self, file):
        self.font = TTFont (FONTS + file)
        self.glyphs = self.font.getGlyphSet ()
        self.cmap = self.font.getBestCmap ()
        self.upm = self.font['head'].unitsPerEm
        kern = {}
        # pair kerning from GPOS PairPos format 1 (enough for these few letters)
        try:
            for lookup in self.font['GPOS'].table.LookupList.Lookup:
                for st in lookup.SubTable:
                    st = getattr (st, 'ExtSubTable', st)
                    if getattr (st, 'Format', None) == 1 and hasattr (st, 'PairSet'):
                        for first, pset in zip (st.Coverage.glyphs, st.PairSet):
                            for rec in pset.PairValueRecord:
                                v = getattr (rec.Value1, 'XAdvance', 0) or 0
                                if v:
                                    kern[(first, rec.SecondGlyph)] = v
        except Exception:
            pass
        self.kern = kern

    def layout (self, text, size, tracking=0.0):
        """Glyph names with x offsets (font units), and the total advance, at scale size/upm."""
        names = [self.cmap[ord (c)] for c in text]
        x, placed = 0, []
        for i, n in enumerate (names):
            placed.append ((n, x))
            x += self.font['hmtx'][n][0] + tracking * self.upm
            if i + 1 < len (names):
                x += self.kern.get ((n, names[i + 1]), 0)
        width = x - tracking * self.upm
        return placed, width

    def path (self, text, x0, baseline, size, tracking=0.0, width=None, anchor='start'):
        placed, natural = self.layout (text, size, tracking)
        scale = size / self.upm
        if width is not None:
            scale = width / natural   # size the word to an exact width, keeping its proportions
        total = natural * scale
        if anchor == 'end':
            x0 -= total
        elif anchor == 'middle':
            x0 -= total / 2
        pen = SVGPathPen (self.glyphs)
        for name, x in placed:
            tp = TransformPen (pen, (scale, 0, 0, -scale, x0 + x * scale, baseline))
            self.glyphs[name].draw (tp)
        return pen.getCommands (), total, scale


EXTRA = Face ('Montserrat-ExtraBold.ttf')
BOLD = Face ('Montserrat-Bold.ttf')
BLACK = Face ('Montserrat-Black.ttf')


def save (name, w, h, body, view=None):
    view = view or f'0 0 {w} {h}'
    open (os.path.join (OUT, name), 'w', encoding='utf-8', newline='\n').write (
        f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="{view}" width="{w}" height="{h}">{body}</svg>\n')


# ---- the wordmark (E): best / lessons at one width, the line, .co.za under its right end -------------
def wordmark (ink, pen):
    best, _, s1 = EXTRA.path ('best', 0, 330, 400, tracking=-0.03, width=920)
    lessons, _, s2 = EXTRA.path ('lessons', 2, 625, 272, tracking=-0.02, width=918)
    tld, _, _ = BOLD.path ('.co.za', 900, 836, 66, tracking=0.01, anchor='end')
    return (f'<path fill="{ink}" d="{best}"/><path fill="{ink}" d="{lessons}"/>'
            f'<path d="M24 752 C250 700 620 686 900 718" stroke="{pen}" stroke-width="22" stroke-linecap="round" fill="none"/>'
            f'<path fill="{pen}" d="{tld}"/>')

for name, ink, pen in (('bestlessons-logo.svg', INK, BLUE), ('bestlessons-logo-on-dark.svg', '#ffffff', LIGHT)):
    save (name, 943, 852, wordmark (ink, pen), '-7 5 943 852')   # 20 units clear of the ink all round


# ---- icon 2: bl and the line --------------------------------------------------------------------------------
def icon (bg, fg, pen, rounded=True, border=False):
    bl, _, _ = BLACK.path ('bl', 50, 66, 64, tracking=-0.03, width=56, anchor='middle')
    tile = (f'<rect width="100" height="100" rx="{23 if rounded else 0}" fill="{bg}"'
            + (' stroke="#dfe3ea" stroke-width="1.5"' if border else '') + '/>')
    return (tile + f'<path fill="{fg}" d="{bl}"/>'
            f'<path d="M20 82 C38 76 62 74.4 80 78" stroke="{pen}" stroke-width="6" stroke-linecap="round" fill="none"/>')

save ('bestlessons-icon.svg', 512, 512, icon ('#ffffff', INK, BLUE, border=True), '0 0 100 100')          # main icon, favicon
save ('bestlessons-icon-phone.svg', 512, 512, icon (INK, '#ffffff', LIGHT), '0 0 100 100')               # phone, rounded
save ('bestlessons-icon-phone-square.svg', 512, 512, icon (INK, '#ffffff', LIGHT, rounded=False), '0 0 100 100')  # iOS / Android mask it themselves
print ('\n'.join (sorted (os.listdir (OUT))))
