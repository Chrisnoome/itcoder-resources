"""Draws the Fact or fake course's art (brand/factfake-art-style.md).

Two worlds, as Chris chose on 10 October 2026 ("A + F"):
- THE GROUP CHAT - where rumours arrive: the made-up chat app "Chatter",
  bubbles, "Forwarded many times", voice notes, link previews, and the class's
  fact-check replies in green. Echo the parrot lives here.
- THE LENS SCANNER - how they get checked: a phone camera view with corner
  brackets, a scan line, clues circled in magenta and a cyan checklist. Lens
  the magnifying glass is the scanner.
Everything is made up: apps, accounts, names, posts, links (.example).
Writes AIPascalCourse/public/assets/doodles/factfake-*.svg and the pictures
for the find-it questions in public/assets/lessons/factfake/.

  python -X utf8 tools/factfake/make_art.py
"""
import os, math

ROOT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets'
DOODLES = os.path.join(ROOT, 'doodles')
PICS = os.path.join(ROOT, 'lessons', 'factfake')

CHAT_BG, CHAT_BAR, BUBBLE, MINE, INK, GREY, LINK = '#e9f3ee', '#1f9d63', '#ffffff', '#d6f5e3', '#10231a', '#7a8a82', '#2a6fd6'
SCAN_BG, CYAN, MAGENTA, GOLD, SCAN_INK = '#0b0f14', '#3df2ff', '#ff2bd6', '#ffd23f', '#e6fbff'
PARROT, PARROT_DK, BEAK_RED = '#9aa3ad', '#4a525b', '#e5484d'
CHATFONT = "'Nunito', 'Segoe UI', sans-serif"
SCANFONT = "'VT323', 'Consolas', monospace"


def esc(t):
    return t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, w, h, label, bg=None):
        self.w, self.h, self.label, self.parts = w, h, label, []
        if bg:
            self.add(f'<rect width="{w}" height="{h}" rx="10" fill="{bg}"/>')

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=INK, anchor='start', weight=700, font=CHATFONT):
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" font-weight="{weight}" fill="{fill}" text-anchor="{anchor}">{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self, folder, name):
        os.makedirs(folder, exist_ok=True)
        with open(os.path.join(folder, name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print(name + '.svg')


# ------------------------------------------------------------- mascots ----

def echo(s, cx, cy, sc=1.0, phone=False):
    o = lambda v: v * sc
    s.add(f'<ellipse cx="{cx}" cy="{cy + o(40)}" rx="{o(40)}" ry="{o(48)}" fill="{PARROT}" stroke="{PARROT_DK}" stroke-width="{o(3)}"/>')
    s.add(f'<path d="M{cx - o(22)} {cy + o(80)} q{o(22)} {o(22)} {o(44)} 0 l{o(-6)} {o(20)} h{o(-32)}z" fill="{BEAK_RED}" stroke="{PARROT_DK}" stroke-width="{o(3)}"/>')
    s.add(f'<circle cx="{cx}" cy="{cy}" r="{o(30)}" fill="#b5bdc6" stroke="{PARROT_DK}" stroke-width="{o(3)}"/>')
    s.add(f'<path d="M{cx + o(20)} {cy - o(2)} q{o(22)} {o(4)} {o(18)} {o(22)} q{o(-10)} {o(-6)} {o(-20)} {o(-4)}z" fill="#2b2b2b"/>')
    s.add(f'<circle cx="{cx + o(4)}" cy="{cy - o(8)}" r="{o(7)}" fill="#fff" stroke="{PARROT_DK}" stroke-width="{o(2)}"/><circle cx="{cx + o(6)}" cy="{cy - o(8)}" r="{o(3)}" fill="#222"/>')
    if phone:
        s.add(f'<rect x="{cx + o(44)}" y="{cy + o(24)}" width="{o(30)}" height="{o(52)}" rx="{o(6)}" fill="#1b1b22"/><rect x="{cx + o(48)}" y="{cy + o(30)}" width="{o(22)}" height="{o(38)}" rx="{o(3)}" fill="#26f0d0"/>')


def lens(s, cx, cy, sc=1.0, mood='look'):
    o = lambda v: v * sc
    s.add(f'<path d="M{cx + o(34)} {cy + o(34)} l{o(42)} {o(42)}" stroke="#8a5a2b" stroke-width="{o(16)}" stroke-linecap="round"/>')
    s.add(f'<circle cx="{cx}" cy="{cy}" r="{o(46)}" fill="#e6f4ff" stroke="#1b1b22" stroke-width="{o(7)}"/>')
    s.add(f'<circle cx="{cx - o(14)}" cy="{cy - o(6)}" r="{o(6)}" fill="#222"/><circle cx="{cx + o(14)}" cy="{cy - o(6)}" r="{o(6)}" fill="#222"/>')
    if mood == 'happy':
        s.add(f'<path d="M{cx - o(12)} {cy + o(14)} q{o(12)} {o(10)} {o(24)} 0" stroke="#222" stroke-width="{o(3)}" fill="none" stroke-linecap="round"/>')
    else:
        s.add(f'<path d="M{cx - o(10)} {cy + o(16)} q{o(10)} {o(6)} {o(20)} 0" stroke="#222" stroke-width="{o(3)}" fill="none" stroke-linecap="round"/>')
        s.add(f'<path d="M{cx - o(24)} {cy - o(20)} l{o(18)} {o(-4)} M{cx + o(6)} {cy - o(24)} l{o(18)} {o(4)}" stroke="#222" stroke-width="{o(3)}" stroke-linecap="round"/>')


# --------------------------------------------------------------- chat ----

def chat_frame(s, x, y, w, h, title):
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="14" fill="{CHAT_BG}" stroke="#c7ddd1" stroke-width="2"/>')
    s.add(f'<path d="M{x} {y + 14} a14 14 0 0 1 14 -14 h{w - 28} a14 14 0 0 1 14 14 v26 h-{w} z" fill="{CHAT_BAR}"/>')
    s.add(f'<circle cx="{x + 22}" cy="{y + 20}" r="10" fill="#bfe8d3"/>')
    s.text(x + 40, y + 25, title, 14, '#ffffff', weight=900)


def bubble(s, x, y, w, lines, who=None, fwd=False, mine=False, link=None, size=13):
    h = 14 + len(lines) * (size + 5) + (14 if fwd else 0) + (14 if who else 0) + (18 if link else 0)
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="12" fill="{MINE if mine else BUBBLE}"/>')
    yy = y + 4
    if fwd:
        yy += 12
        s.text(x + 12, yy, '↪ Forwarded many times', 10, GREY, weight=700)
    if who:
        yy += 14
        s.text(x + 12, yy, who, 11, CHAT_BAR if mine else '#c2410c', weight=900)
    for line in lines:
        yy += size + 5
        s.text(x + 12, yy, line, size, INK, weight=700)
    if link:
        yy += 18
        s.text(x + 12, yy, link, 12, LINK, weight=700)
    return y + h


def voice_note(s, x, y, w, label):
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="40" rx="12" fill="{BUBBLE}"/>')
    s.add(f'<circle cx="{x + 22}" cy="{y + 20}" r="11" fill="{CHAT_BAR}"/><path d="M{x + 19} {y + 14} l9 6 l-9 6z" fill="#fff"/>')
    hs = [8, 16, 10, 20, 8, 14, 6, 16, 10, 6, 12, 18, 8]
    for i, hh in enumerate(hs):
        s.add(f'<rect x="{x + 40 + i * 6}" y="{y + 20 - hh / 2}" width="3" height="{hh}" fill="{GREY}"/>')
    s.text(x + 126, y + 25, label, 11, GREY, weight=700)
    return y + 40


OPENERS = {
    1: ('Gr 8 Squad (34)', [('voice', '0:42  "school is cancelled tomorrow"'), ('msg', ['is this true??'], 'Zinhle'), ('msg', ['my sister said the same', 'cancelled for sure'], 'Kabelo')],
        ['Search before you believe.', 'Echo already shared it twice.']),
    2: ('Gr 8 Squad (34)', [('fwd', ['FREE 50GB DATA for all', 'Ridgeview students!!'], 'claim-free-data.example'), ('msg', ['it works!! I got mine'], 'Lwazi')],
        ['Who made this? Look at the', 'link before anyone taps it.']),
    3: ('Gr 8 Squad (34)', [('pic', 'flooded mall, shark'), ('msg', ['THIS IS THE MALL RIGHT NOW', 'stay home!!'], 'Ayanda')],
        ['A real photo - but from', 'when, and from where?']),
    4: ('Gr 8 Squad (34)', [('pic', 'the principal with a giant trophy'), ('msg', ['Mr Govender won the lotto??'], 'Naledi')],
        ['Look at the hands. And the', 'writing on the trophy.']),
    5: ('Gr 8 Squad (34)', [('fwd', ['SHARE THIS TO 10 PEOPLE', 'OR YOUR ACCOUNT CLOSES'], None), ('msg', ['sent to everyone just in case'], 'Echo')],
        ['Why do fakes spread faster', 'than the truth? Feelings.']),
    6: ('Fact-check team', [('msg', ['New one in. Check it like', 'a pro - every step.'], 'Ms Pillay'), ('msg', ['On it.'], 'You')],
        ['Your turn. Every check,', 'then the verdict.']),
}


def opener(n):
    title, items, says = OPENERS[n]
    s = Svg(560, 300, f'Lesson {n}: the day\'s viral message in the class group chat, with Echo the parrot and Lens the magnifying glass', '#f4f7f5')
    chat_frame(s, 16, 16, 330, 268, title)
    y = 68
    for kind, *rest in items:
        if kind == 'voice':
            y = voice_note(s, 28, y, 290, rest[0]) + 10
        elif kind == 'fwd':
            y = bubble(s, 28, y, 296, rest[0], fwd=True, link=rest[1]) + 10
        elif kind == 'pic':
            s.add(f'<rect x="28" y="{y}" width="200" height="96" rx="10" fill="{BUBBLE}"/><rect x="34" y="{y + 6}" width="188" height="70" rx="6" fill="#9db7c9"/>')
            s.text(40, y + 90, rest[0], 10, GREY, weight=700)
            y += 106
        else:
            y = bubble(s, 28, y, 240, rest[0], who=rest[1], mine=(rest[1] == 'You')) + 10
    echo(s, 420, 70, 0.62, phone=True)
    lens(s, 470, 210, 0.6)
    s.add(f'<rect x="356" y="250" width="190" height="40" rx="10" fill="#ffffff" stroke="{INK}" stroke-width="1.5"/>')
    s.text(366, 266, says[0], 11, INK, weight=700)
    s.text(366, 282, says[1], 11, INK, weight=700)
    s.save(DOODLES, f'factfake-chat-{n:02d}')


# ------------------------------------------------------------ scanner ----

def scan_frame(s, x, y, w, h):
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" rx="16" fill="#141b24" stroke="{CYAN}" stroke-width="2"/>')
    for (px, py, dx, dy) in ((x + 14, y + 34, 1, 1), (x + w - 14, y + 34, -1, 1), (x + 14, y + h - 14, 1, -1), (x + w - 14, y + h - 14, -1, -1)):
        s.add(f'<path d="M{px} {py + 20 * dy} v{-20 * dy} h{20 * dx}" stroke="{CYAN}" stroke-width="4" fill="none"/>')


def checklist(s, x, y, title, rows, verdict=None, vcol=GOLD):
    s.text(x, y, title, 26, CYAN, weight=400, font=SCANFONT)
    for i, (mark, words, col) in enumerate(rows):
        s.text(x, y + 30 + i * 24, f'{mark} {words}', 20, col, weight=400, font=SCANFONT)
    if verdict:
        s.text(x, y + 40 + len(rows) * 24, verdict, 24, vcol, weight=400, font=SCANFONT)


def scanner_search():
    s = Svg(560, 280, 'Lens scans a search: the made-up search engine Seekr with two results - an advert at the top, and the school\'s own website', SCAN_BG)
    scan_frame(s, 16, 16, 300, 248)
    s.add(f'<rect x="34" y="50" width="264" height="30" rx="15" fill="#ffffff"/>')
    s.text(48, 70, 'ridgeview high school closed tomorrow', 11, '#333', weight=700)
    s.add(f'<rect x="34" y="92" width="264" height="58" rx="6" fill="#1d2633"/>')
    s.text(44, 110, 'Sponsored', 10, GOLD, weight=700); s.text(44, 128, 'School closure? Click for news!!', 12, SCAN_INK, weight=700); s.text(44, 144, 'best-news-ads.example', 10, '#8aa', weight=700)
    s.add(f'<rect x="34" y="160" width="264" height="58" rx="6" fill="#1d2633"/>')
    s.text(44, 178, 'ridgeview.example/news', 10, '#8aa', weight=700); s.text(44, 196, 'School open as normal on Friday', 12, SCAN_INK, weight=700); s.text(44, 212, 'Posted by the school office, today', 10, '#8aa', weight=700)
    s.add(f'<rect x="30" y="156" width="272" height="66" rx="8" fill="none" stroke="{MAGENTA}" stroke-width="3"/>')
    checklist(s, 332, 58, 'LENS: SEARCH', [('✓', 'skip the ads', SCAN_INK), ('✓', 'find the source', SCAN_INK), ('✓', 'check the date', SCAN_INK)], 'SCHOOL IS OPEN')
    s.save(DOODLES, 'factfake-scan-search')


def scanner_reverse():
    s = Svg(560, 280, 'Lens runs a reverse image search on the shark photo: the same picture found on a website from 2018, as an edited joke', SCAN_BG)
    scan_frame(s, 16, 16, 300, 248)
    s.add(f'<rect x="40" y="56" width="120" height="90" rx="6" fill="#9db7c9"/><path d="M60 120 q30 -28 70 -6 l14 -10 l-3 18 q-40 22 -81 -2z" fill="#4b5d6e"/>')
    s.text(40, 166, 'your photo', 11, '#8aa', weight=700)
    s.add(f'<path d="M168 100 h28" stroke="{CYAN}" stroke-width="3"/><path d="M192 92 l10 8 l-10 8z" fill="{CYAN}"/>')
    for i, (site, yr) in enumerate((('jokes-pics.example', '2018'), ('memes-daily.example', '2019'), ('weather-hoax.example', '2021'))):
        y = 52 + i * 62
        s.add(f'<rect x="210" y="{y}" width="92" height="54" rx="6" fill="#1d2633"/><rect x="216" y="{y + 6}" width="34" height="26" rx="3" fill="#9db7c9"/>')
        s.text(256, y + 22, yr, 13, GOLD if i == 0 else SCAN_INK, weight=700)
        s.text(216, y + 46, site[:14], 9, '#8aa', weight=700)
    checklist(s, 332, 58, 'LENS: PHOTO', [('✓', 'first seen: 2018', SCAN_INK), ('!', 'edited - a joke site', MAGENTA), ('!', 'not this week', MAGENTA)], 'OLD + EDITED')
    s.save(DOODLES, 'factfake-scan-reverse')


def ai_portrait(name, clues_marked):
    """The made-up AI picture of 'the principal with a trophy', with the usual AI mistakes:
    six fingers, an earring on one ear only, a warped window frame, nonsense writing on the trophy."""
    s = Svg(480, 400, 'A picture of a smiling man in a suit holding a big gold trophy in an office' + (', with the AI mistakes circled' if clues_marked else ''), '#ffffff')
    s.add(f'<rect x="0" y="0" width="480" height="400" rx="10" fill="#e8e2d6"/>')
    # warped window
    s.add(f'<path d="M300 40 h140 v150 h-140 z" fill="#bcd7ea" stroke="#8a7a62" stroke-width="6"/>')
    s.add(f'<path d="M370 40 q8 40 -6 80 q-10 40 6 70" stroke="#8a7a62" stroke-width="6" fill="none"/><path d="M300 115 q70 -16 140 6" stroke="#8a7a62" stroke-width="6" fill="none"/>')
    # body
    s.add(f'<path d="M110 400 q0 -130 110 -140 q110 10 110 140z" fill="#2d3e50"/>')
    s.add(f'<path d="M200 262 l20 50 l20 -50z" fill="#ffffff"/><path d="M214 268 l6 40 l6 -40z" fill="#b3261e"/>')
    # head
    s.add(f'<circle cx="220" cy="190" r="58" fill="#8d5a3b"/>')
    s.add(f'<path d="M166 176 q54 -70 110 0 q-2 -50 -56 -56 q-52 4 -54 56z" fill="#1c1c1c"/>')
    s.add(f'<circle cx="200" cy="190" r="6" fill="#1c1c1c"/><circle cx="240" cy="190" r="6" fill="#1c1c1c"/><path d="M196 218 q24 18 48 0" stroke="#3a1f10" stroke-width="5" fill="none" stroke-linecap="round"/>')
    s.add(f'<ellipse cx="162" cy="196" rx="8" ry="14" fill="#7a4d32"/><ellipse cx="278" cy="196" rx="8" ry="14" fill="#7a4d32"/>')
    s.add(f'<circle cx="160" cy="214" r="5" fill="{GOLD}" stroke="#a5600a" stroke-width="1.5"/>')
    # trophy
    s.add(f'<path d="M300 250 h90 q0 60 -45 70 q-45 -10 -45 -70z" fill="#e3b341" stroke="#a5600a" stroke-width="3"/>')
    s.add(f'<path d="M300 262 q-26 0 -24 22 q4 18 26 18 M390 262 q26 0 24 22 q-4 18 -26 18" stroke="#a5600a" stroke-width="5" fill="none"/>')
    s.add(f'<rect x="330" y="318" width="30" height="30" fill="#e3b341" stroke="#a5600a" stroke-width="3"/><rect x="314" y="346" width="62" height="16" fill="#8a5a2b"/>')
    s.text(364, 290, 'CHAMPWN', 11, '#7a4a10', 'middle', 900)
    s.text(364, 304, 'LOTTTRY 2O2', 8, '#7a4a10', 'middle', 900)
    # hand on trophy with six fingers
    s.add(f'<ellipse cx="300" cy="300" rx="20" ry="16" fill="#8d5a3b"/>')
    for i in range(6):
        s.add(f'<rect x="{280 + i * 6.5:.1f}" y="{276 - (i % 2) * 2}" width="6" height="22" rx="3" fill="#8d5a3b" stroke="#6b4329" stroke-width="1"/>')
    if clues_marked:
        for (cx, cy, r) in ((300, 288, 34), (160, 210, 22), (364, 296, 34), (370, 100, 60)):
            s.add(f'<circle cx="{cx}" cy="{cy}" r="{r}" fill="none" stroke="{MAGENTA}" stroke-width="4"/>')
    s.save(PICS if not clues_marked else DOODLES, 'pic-ai-trophy' if not clues_marked else 'factfake-ai-trophy-marked')


def lookalike():
    s = Svg(560, 200, 'Two web addresses side by side: the school\'s real one, and a lookalike with a changed letter and an extra word', '#ffffff')
    for i, (addr, ok) in enumerate((('ridgeview.example', True), ('ridgevlew-school-free.example', False))):
        y = 30 + i * 80
        s.add(f'<rect x="20" y="{y}" width="520" height="54" rx="27" fill="#f1f3f5" stroke="{"#2bb673" if ok else BEAK_RED}" stroke-width="3"/>')
        s.add(f'<rect x="38" y="{y + 18}" width="14" height="14" rx="3" fill="{"#2bb673" if ok else BEAK_RED}"/>')
        s.text(66, y + 34, addr, 20, '#1b1b22', weight=800)
        s.text(520, y + 34, 'the real one' if ok else 'a lookalike', 14, '#2bb673' if ok else BEAK_RED, 'end', 800)
    s.add(f'<circle cx="138" cy="{30 + 80 + 26}" r="14" fill="none" stroke="{MAGENTA}" stroke-width="3"/>')
    s.save(DOODLES, 'factfake-lookalike')


def sift():
    s = Svg(560, 170, 'The four moves: Stop, Investigate the source, Find better coverage, Trace it back to the original', '#ffffff')
    steps = [('S', 'Stop', 'pause before you share'), ('I', 'Investigate', 'who made it?'), ('F', 'Find', 'who else says so?'), ('T', 'Trace', 'back to the original')]
    for i, (letter, word, sub) in enumerate(steps):
        x = 20 + i * 135
        s.add(f'<rect x="{x}" y="20" width="120" height="130" rx="14" fill="{SCAN_BG}"/>')
        s.text(x + 60, 74, letter, 46, CYAN, 'middle', 400, SCANFONT)
        s.text(x + 60, 104, word.upper(), 20, SCAN_INK, 'middle', 400, SCANFONT)
        s.text(x + 60, 128, sub, 11, '#9fb3c0', 'middle', 700)
    s.save(DOODLES, 'factfake-sift')


def feelings():
    s = Svg(320, 200, 'Echo shares a scary message straight away; the shares multiply like arrows', None)
    echo(s, 90, 60, 0.9, phone=True)
    for i in range(6):
        a = math.radians(-60 + i * 22)
        s.add(f'<path d="M180 110 l{90 * math.cos(a):.1f} {90 * math.sin(a):.1f}" stroke="#ff3b6b" stroke-width="3"/>')
        s.add(f'<circle cx="{180 + 96 * math.cos(a):.1f}" cy="{110 + 96 * math.sin(a):.1f}" r="7" fill="#ff3b6b"/>')
    s.save(DOODLES, 'factfake-echo-shares')


def pair():
    s = Svg(320, 190, 'Echo the parrot, who shares everything, and Lens the magnifying glass, who checks everything', None)
    echo(s, 90, 60, 0.85, phone=True)
    lens(s, 240, 90, 0.85, 'happy')
    s.save(DOODLES, 'factfake-pair')


def lens_doodle():
    s = Svg(220, 200, 'Lens the magnifying glass, looking closely', None)
    lens(s, 100, 90, 1.1)
    s.save(DOODLES, 'factfake-lens')


def main():
    for n in range(1, 7):
        opener(n)
    scanner_search(); scanner_reverse(); ai_portrait('', False); ai_portrait('', True)
    lookalike(); sift(); feelings(); pair(); lens_doodle()


if __name__ == '__main__':
    main()
