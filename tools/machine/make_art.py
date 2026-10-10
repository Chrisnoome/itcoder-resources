"""Draws the Inside the machine course's art (brand/machine-art-style.md).

Two kinds of picture:
- THE CITY MAP (doodles/machine-*.svg): the motherboard seen from above as a
  city - CPU Downtown, RAM Row, the Warehouse, the City Gates, the Harbour -
  in board green and copper, Oswald labels, with a red "you are here" pin
  that moves each lesson; Volt (a spark) and Dr Ndlovu (on the radio from
  outside) in the margins.
- ACCURATE PARTS (lessons/machine/part-*.svg): each component drawn true to
  its real shape and proportions (Chris, 10 October 2026: "we need more
  accurate svgs of components when they are discussed - as inline images"),
  flat and clean on white, with no labels, so the same drawing serves the
  text and the hotspot / label-the-picture questions. The labelled
  motherboard is a separate file.

  python -X utf8 tools/machine/make_art.py
"""
import os, math

ROOT = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets'
DOODLES = os.path.join(ROOT, 'doodles')
PARTS = os.path.join(ROOT, 'lessons', 'machine')

BOARD, BOARD_DK, COPPER, CREAM, PIN, INK = '#0f5132', '#0b3d26', '#c99a1a', '#e7efe4', '#d9542c', '#10261b'
VOLT, VOLT_DK, SKIN, COAT = '#ffd34d', '#c48a00', '#8d5a3b', '#ffffff'
LABEL = "'Oswald', 'Arial Narrow', sans-serif"
TEXT = "'Inter Tight', 'Segoe UI', sans-serif"
# accurate parts
PCB, PCB_DK, GOLD, GOLD_DK, CHIP, METAL, METAL_DK, PLASTIC, PLASTIC_DK = '#1f5e3a', '#174a2d', '#d4af37', '#a88a24', '#1c1c1e', '#c9ced3', '#8e969d', '#2b2d31', '#16171a'


def esc(t):
    return t.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


class Svg:
    def __init__(self, w, h, label, bg=None):
        self.w, self.h, self.label, self.parts = w, h, label, []
        if bg:
            self.add(f'<rect width="{w}" height="{h}" rx="8" fill="{bg}"/>')

    def add(self, s):
        self.parts.append(s)

    def text(self, x, y, words, size, fill=CREAM, anchor='start', weight=600, font=LABEL, extra=''):
        self.add(f'<text x="{x}" y="{y}" font-family="{font}" font-size="{size}" font-weight="{weight}" fill="{fill}" text-anchor="{anchor}"{extra}>{esc(words)}</text>')

    def svg(self):
        return (f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {self.w} {self.h}" role="img" aria-label="{esc(self.label)}">'
                + ''.join(self.parts) + '</svg>\n')

    def save(self, folder, name):
        os.makedirs(folder, exist_ok=True)
        with open(os.path.join(folder, name + '.svg'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(self.svg())
        print(name + '.svg')


# ============================================================ accurate parts ==

def contacts(s, x, y, w, h, n, gap_at=None, gap=6):
    """A row of gold edge contacts, with an optional key notch."""
    s.add(f'<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="{GOLD}"/>')
    step = w / n
    for i in range(1, n):
        px = x + i * step
        s.add(f'<line x1="{px:.1f}" y1="{y + 1}" x2="{px:.1f}" y2="{y + h}" stroke="{GOLD_DK}" stroke-width="0.8"/>')
    if gap_at is not None:
        s.add(f'<rect x="{gap_at - gap / 2}" y="{y - 1}" width="{gap}" height="{h + 2}" fill="#ffffff"/>')


def part_cpu():
    """A desktop CPU from above: green substrate, nickel heat-spreader lid, gold corner triangle - and from below, the pads."""
    s = Svg(420, 220, 'A computer processor (CPU), from above and from below', '#ffffff')
    # top
    s.add(f'<rect x="30" y="30" width="160" height="160" rx="6" fill="{PCB}"/>')
    s.add(f'<path d="M64 54 h92 a10 10 0 0 1 10 10 v14 h10 v64 h-10 v14 a10 10 0 0 1 -10 10 h-92 a10 10 0 0 1 -10 -10 v-14 h-10 v-64 h10 v-14 a10 10 0 0 1 10 -10z" fill="{METAL}" stroke="{METAL_DK}" stroke-width="1.5"/>')
    s.add(f'<path d="M36 184 l0 -16 l16 16z" fill="{GOLD}"/>')
    for (x, y) in ((40, 40), (176, 40), (40, 176), (176, 176)):
        s.add(f'<rect x="{x - 4}" y="{y - 2}" width="8" height="4" fill="{GOLD_DK}"/>')
    # bottom: a grid of pads
    s.add(f'<rect x="230" y="30" width="160" height="160" rx="6" fill="{PCB}"/>')
    for r in range(15):
        for c in range(15):
            if 5 <= r <= 9 and 5 <= c <= 9:
                continue
            s.add(f'<circle cx="{240 + c * 10:.0f}" cy="{40 + r * 10:.0f}" r="2.6" fill="{GOLD}"/>')
    s.add(f'<rect x="288" y="88" width="44" height="44" fill="{PCB_DK}"/>')
    for i in range(3):
        for j in range(3):
            s.add(f'<rect x="{292 + i * 13}" y="{92 + j * 13}" width="9" height="9" fill="#9a7a2a"/>')
    s.add(f'<path d="M384 184 l0 -16 l-16 16z" fill="{GOLD}"/>')
    s.save(PARTS, 'part-cpu')


def part_ram():
    """A desktop RAM stick (DIMM): long board, eight memory chips, gold contacts with an off-centre notch, notches at both ends."""
    s = Svg(560, 150, 'A stick of RAM: a long thin circuit board with eight black memory chips and a row of gold contacts along the bottom edge', '#ffffff')
    x, y, w, h = 20, 24, 520, 98
    s.add(f'<path d="M{x} {y} h{w} v{h - 20} h-4 v-8 a5 5 0 0 0 -10 0 v8 h-{w - 28} v-8 a5 5 0 0 0 -10 0 v8 h-{4} z" fill="{PCB}"/>')
    s.add(f'<rect x="{x}" y="{y + h - 20}" width="{w}" height="20" fill="{PCB}"/>')
    contacts(s, x + 10, y + h - 14, w - 20, 14, 72, gap_at=x + 10 + (w - 20) * 0.55)
    for i in range(8):
        cx = x + 22 + i * 61
        s.add(f'<rect x="{cx}" y="{y + 14}" width="46" height="40" rx="2" fill="{CHIP}"/>')
        s.add(f'<circle cx="{cx + 6}" cy="{y + 20}" r="1.8" fill="#55575c"/>')
    s.add(f'<rect x="{x + 230}" y="{y + 60}" width="40" height="10" rx="1" fill="#e9e9e9"/>')
    for i in range(14):
        s.add(f'<rect x="{x + 24 + i * 34}" y="{y + 62}" width="10" height="5" fill="#b8865a"/>')
    s.save(PARTS, 'part-ram')


def part_m2():
    """An M.2 SSD: a narrow board, controller and two flash chips, a screw half-moon at one end, a keyed gold connector at the other."""
    s = Svg(560, 140, 'An M.2 SSD: a narrow circuit board the length of a finger, with a few black chips, a gold connector at one end and a screw notch at the other', '#ffffff')
    x, y, w, h = 30, 40, 480, 64
    s.add(f'<path d="M{x} {y} h{w} v{h} h-{w} z" fill="{PCB}"/>')
    s.add(f'<circle cx="{x + w}" cy="{y + h / 2}" r="12" fill="#ffffff"/>')
    s.add(f'<rect x="{x - 28}" y="{y + 6}" width="28" height="{h - 12}" fill="{PCB}"/>')
    s.add(f'<rect x="{x - 28}" y="{y + 6}" width="22" height="{h - 12}" fill="{GOLD}"/>')
    for i in range(1, 14):
        yy = y + 6 + i * (h - 12) / 14
        s.add(f'<line x1="{x - 28}" y1="{yy:.1f}" x2="{x - 6}" y2="{yy:.1f}" stroke="{GOLD_DK}" stroke-width="0.8"/>')
    s.add(f'<rect x="{x - 30}" y="{y + 40}" width="24" height="6" fill="#ffffff"/>')
    s.add(f'<rect x="{x + 22}" y="{y + 12}" width="62" height="40" rx="2" fill="{CHIP}"/>')
    s.add(f'<rect x="{x + 120}" y="{y + 8}" width="120" height="48" rx="2" fill="{CHIP}"/>')
    s.add(f'<rect x="{x + 260}" y="{y + 8}" width="120" height="48" rx="2" fill="{CHIP}"/>')
    s.add(f'<rect x="{x + 400}" y="{y + 18}" width="18" height="10" fill="#b8865a"/><rect x="{x + 400}" y="{y + 36}" width="18" height="10" fill="#b8865a"/>')
    s.add(f'<rect x="{x + 96}" y="{y + 22}" width="12" height="20" fill="#e9e9e9"/>')
    s.save(PARTS, 'part-m2')


def part_hdd():
    """A hard drive with its lid off: shiny platter, spindle, the arm with the read/write head, the actuator magnet."""
    s = Svg(360, 460, 'A hard drive with its lid off: a shiny round disk, a metal arm reaching across it, and the case around them', '#ffffff')
    s.add(f'<rect x="20" y="20" width="320" height="420" rx="14" fill="{METAL_DK}"/>')
    s.add(f'<rect x="32" y="32" width="296" height="396" rx="10" fill="{METAL}"/>')
    s.add('<defs><radialGradient id="platter" cx=".42" cy=".38" r=".7"><stop offset="0" stop-color="#ffffff"/><stop offset=".55" stop-color="#cfd5db"/><stop offset="1" stop-color="#8e969d"/></radialGradient></defs>')
    s.add(f'<circle cx="176" cy="168" r="132" fill="url(#platter)" stroke="{METAL_DK}" stroke-width="2"/>')
    s.add(f'<circle cx="176" cy="168" r="30" fill="{METAL}" stroke="{METAL_DK}" stroke-width="2"/>')
    for a in range(0, 360, 60):
        r = math.radians(a)
        s.add(f'<circle cx="{176 + 18 * math.cos(r):.1f}" cy="{168 + 18 * math.sin(r):.1f}" r="3" fill="{METAL_DK}"/>')
    # actuator
    s.add(f'<path d="M232 372 l70 -30 l18 40 l-60 36 z" fill="#3a3d42"/>')
    s.add(f'<circle cx="262" cy="350" r="18" fill="{METAL}" stroke="{METAL_DK}" stroke-width="2"/>')
    s.add(f'<path d="M256 338 L150 200 L140 206 L246 356 z" fill="#b0b7be" stroke="{METAL_DK}" stroke-width="1.5"/>')
    s.add(f'<rect x="136" y="192" width="14" height="10" rx="2" fill="#3a3d42" transform="rotate(-38 143 197)"/>')
    for (x, y) in ((44, 44), (316, 44), (44, 416), (316, 416), (44, 230), (316, 230)):
        s.add(f'<circle cx="{x}" cy="{y}" r="5" fill="{METAL_DK}"/>')
    s.save(PARTS, 'part-hdd')


def part_ssd25():
    """A 2.5 inch SATA SSD: a flat metal box, with the SATA data and power connectors on its end."""
    s = Svg(460, 300, 'A 2.5 inch SSD: a flat rectangular metal box, with two connectors on one end - a short one for data and a longer one for power', '#ffffff')
    s.add(f'<rect x="40" y="30" width="300" height="230" rx="8" fill="{PLASTIC}"/>')
    s.add(f'<rect x="52" y="42" width="276" height="206" rx="5" fill="#3a3d42"/>')
    s.add(f'<rect x="90" y="110" width="200" height="70" rx="4" fill="#4b4f56"/>')
    for (x, y) in ((56, 46), (324, 46), (56, 244), (324, 244)):
        s.add(f'<circle cx="{x}" cy="{y}" r="4" fill="{METAL_DK}"/>')
    # end connectors seen from the side, drawn at the right edge
    s.add(f'<rect x="340" y="70" width="20" height="54" fill="{PLASTIC_DK}"/>')
    s.add(f'<rect x="344" y="76" width="8" height="42" fill="{GOLD}"/>')
    s.add(f'<rect x="340" y="140" width="20" height="96" fill="{PLASTIC_DK}"/>')
    s.add(f'<rect x="344" y="146" width="8" height="84" fill="{GOLD}"/>')
    s.add(f'<path d="M360 70 h6 v10 h-6 M360 226 h6 v10 h-6" stroke="{PLASTIC_DK}" stroke-width="3" fill="none"/>')
    s.save(PARTS, 'part-ssd25')


def part_psu():
    """A power supply: a metal box with a round fan grille, the power switch and socket on the back, and a bundle of cables."""
    s = Svg(460, 280, 'A power supply unit: a metal box with a round fan grille, a socket and switch for the wall cable, and a bundle of cables coming out', '#ffffff')
    s.add(f'<rect x="30" y="40" width="300" height="200" rx="6" fill="{PLASTIC}"/>')
    s.add(f'<circle cx="180" cy="140" r="82" fill="#3a3d42"/>')
    for r in (20, 36, 52, 68, 80):
        s.add(f'<circle cx="180" cy="140" r="{r}" fill="none" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<path d="M180 60 V220 M100 140 H260" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<circle cx="180" cy="140" r="12" fill="#8e969d"/>')
    s.add(f'<rect x="44" y="56" width="34" height="26" rx="3" fill="{PLASTIC_DK}"/><rect x="52" y="62" width="18" height="14" fill="#55575c"/>')
    s.add(f'<rect x="46" y="94" width="22" height="14" rx="2" fill="#d9542c"/>')
    colours = ['#1c1c1e', '#d9542c', '#f2c94c', '#1c1c1e', '#1c1c1e', '#d9542c', '#f2c94c']
    for i, c in enumerate(colours):
        y = 120 + i * 9
        s.add(f'<path d="M330 {y} C370 {y} 380 {150 + i * 14} 430 {160 + i * 14}" stroke="{c}" stroke-width="5" fill="none"/>')
    s.add(f'<rect x="420" y="150" width="26" height="70" rx="3" fill="{PLASTIC_DK}"/>')
    s.save(PARTS, 'part-psu')


def motherboard(name, labelled, pad=0):
    """A desktop motherboard from above (ATX layout): CPU socket, four RAM slots, PCIe slots, M.2 slot, SATA ports,
    the 24-pin power socket, the chipset, the back-panel ports, the BIOS battery."""
    s = Svg(560 + 2 * pad, 600, 'A computer motherboard seen from above' + ('' if labelled else ' with no labels'), '#ffffff')
    if pad:
        s.add(f'<g transform="translate({pad} 0)">')
    s.add(f'<rect x="20" y="20" width="520" height="560" rx="6" fill="{PCB}"/>')
    for (x, y) in ((34, 34), (526, 34), (34, 300), (526, 300), (34, 566), (526, 566)):
        s.add(f'<circle cx="{x}" cy="{y}" r="5" fill="#ffffff" stroke="{GOLD}" stroke-width="1.5"/>')
    # traces
    for i in range(8):
        s.add(f'<path d="M{240 + i * 6} {250} V{330 + i * 4} H{170}" stroke="{PCB_DK}" stroke-width="2" fill="none"/>')
        s.add(f'<path d="M{300} {150 + i * 8} H{370 + i * 5}" stroke="{PCB_DK}" stroke-width="2" fill="none"/>')
    # back panel ports (left edge, top)
    s.add(f'<rect x="20" y="40" width="70" height="210" fill="{METAL}" stroke="{METAL_DK}"/>')
    for i in range(4):
        s.add(f'<rect x="34" y="{56 + i * 22}" width="22" height="12" rx="1" fill="#2f6fde"/>')
    s.add(f'<rect x="34" y="150" width="30" height="22" rx="2" fill="{PLASTIC_DK}"/>')
    s.add(f'<rect x="38" y="154" width="22" height="12" fill="#55575c"/>')
    for i in range(3):
        s.add(f'<circle cx="{40 + i * 14}" cy="200" r="5" fill="{["#7bc96f", "#ff8fa3", "#7fd3ff"][i]}"/>')
    s.add(f'<rect x="34" y="216" width="40" height="18" rx="2" fill="{PLASTIC_DK}"/>')
    # CPU socket with lever
    s.add(f'<rect x="170" y="90" width="130" height="130" rx="4" fill="{METAL}" stroke="{METAL_DK}" stroke-width="2"/>')
    s.add(f'<rect x="190" y="110" width="90" height="90" fill="{PLASTIC}"/>')
    s.add(f'<path d="M168 230 h120" stroke="{METAL_DK}" stroke-width="4" stroke-linecap="round"/>')
    # VRM heatsinks
    s.add(f'<rect x="110" y="60" width="44" height="170" rx="3" fill="#4b4f56"/><rect x="170" y="44" width="130" height="34" rx="3" fill="#4b4f56"/>')
    # RAM slots
    for i in range(4):
        x = 330 + i * 22
        s.add(f'<rect x="{x}" y="60" width="12" height="250" rx="2" fill="{PLASTIC_DK}"/>')
        s.add(f'<rect x="{x + 3}" y="64" width="6" height="242" fill="#55575c"/>')
        s.add(f'<rect x="{x - 1}" y="54" width="14" height="10" rx="2" fill="#8e969d"/>')
    # 24-pin power
    s.add(f'<rect x="440" y="140" width="30" height="110" rx="2" fill="#f2f2f2" stroke="{METAL_DK}"/>')
    for r in range(12):
        for c in range(2):
            s.add(f'<rect x="{445 + c * 12}" y="{144 + r * 8.8:.1f}" width="8" height="6" fill="#cfcfcf"/>')
    # 8-pin CPU power
    s.add(f'<rect x="100" y="34" width="44" height="22" rx="2" fill="#f2f2f2" stroke="{METAL_DK}"/>')
    # M.2 slot with an SSD in it
    s.add(f'<rect x="150" y="300" width="200" height="22" rx="2" fill="{PCB_DK}"/>')
    s.add(f'<rect x="150" y="302" width="14" height="18" fill="{PLASTIC_DK}"/>')
    s.add(f'<rect x="164" y="304" width="180" height="14" fill="#1c1c1e"/><circle cx="342" cy="311" r="3" fill="{METAL}"/>')
    # PCIe x16 and x1 slots
    s.add(f'<rect x="110" y="360" width="300" height="16" rx="2" fill="{PLASTIC_DK}"/><rect x="114" y="365" width="292" height="6" fill="#55575c"/>')
    s.add(f'<rect x="110" y="420" width="90" height="14" rx="2" fill="{PLASTIC_DK}"/>')
    s.add(f'<rect x="110" y="480" width="300" height="16" rx="2" fill="{PLASTIC_DK}"/><rect x="114" y="485" width="292" height="6" fill="#55575c"/>')
    # chipset
    s.add(f'<rect x="420" y="400" width="80" height="80" rx="4" fill="#4b4f56"/>')
    # SATA ports
    for i in range(2):
        for j in range(2):
            s.add(f'<rect x="{500 + j * 0}" y="{300 + i * 26 + j * 0}" width="26" height="16" rx="2" fill="#1c1c1e"/>')
    s.add(f'<rect x="500" y="352" width="26" height="16" rx="2" fill="#1c1c1e"/><rect x="500" y="378" width="26" height="16" rx="2" fill="#1c1c1e"/>')
    # CMOS battery
    s.add(f'<circle cx="270" cy="440" r="20" fill="{METAL}" stroke="{METAL_DK}" stroke-width="2"/>')
    s.add(f'<text x="270" y="445" font-family="{TEXT}" font-size="11" font-weight="700" fill="{METAL_DK}" text-anchor="middle">+</text>')
    # front-panel pins
    s.add(f'<rect x="440" y="540" width="60" height="18" fill="{PLASTIC_DK}"/>')
    if labelled:
        tags = [
            ('CPU socket', 235, 155, 250, 268, 'middle'),
            ('RAM slots', 362, 330, 362, 346, 'middle'),
            ('Power from the PSU', 455, 260, 455, 276, 'middle'),
            ('Ports at the back', 55, 260, 26, 276, 'start'),
            ('M.2 slot (SSD)', 250, 311, 250, 344, 'middle'),
            ('Graphics card slot', 260, 376, 260, 404, 'middle'),
            ('Chipset', 460, 440, 460, 500, 'middle'),
            ('SATA ports', 513, 394, 500, 420, 'end'),
            ('BIOS battery', 270, 460, 270, 534, 'middle'),
        ]
        for words, px, py, tx, ty, anchor in tags:
            w = len(words) * 6.6 + 12
            bx = tx - w / 2 if anchor == 'middle' else (tx if anchor == 'start' else tx - w)
            s.add(f'<line x1="{px}" y1="{py}" x2="{bx + w / 2:.1f}" y2="{ty - 12}" stroke="#ffffff" stroke-width="1.5" stroke-dasharray="3 2"/>')
            s.add(f'<rect x="{bx:.1f}" y="{ty - 14}" width="{w:.1f}" height="19" rx="3" fill="#ffffff" stroke="{INK}" stroke-width="1.2"/>')
            s.text(bx + w / 2, ty, words, 12, INK, 'middle', 600, TEXT)
    if pad:
        s.add('</g>')
    s.save(PARTS, name)


def part_keyboard():
    s = Svg(560, 190, 'A computer keyboard seen from above', '#ffffff')
    s.add(f'<rect x="10" y="20" width="540" height="160" rx="10" fill="#d4d7db" stroke="#8e969d" stroke-width="2"/>')
    rows = [(14, 1.0), (14, 1.0), (13, 1.08), (12, 1.17), (11, 1.27)]
    y = 34
    for n, scale in rows[:4]:
        x = 24
        kw = (512 - (n - 1) * 4) / n
        for i in range(n):
            s.add(f'<rect x="{x:.1f}" y="{y}" width="{kw:.1f}" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/>')
            x += kw + 4
        y += 28
    s.add(f'<rect x="24" y="{y}" width="60" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/><rect x="90" y="{y}" width="60" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/>')
    s.add(f'<rect x="156" y="{y}" width="240" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/>')
    s.add(f'<rect x="402" y="{y}" width="60" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/><rect x="468" y="{y}" width="68" height="24" rx="3" fill="#ffffff" stroke="#9aa1a8"/>')
    s.save(PARTS, 'part-keyboard')


def part_mouse():
    s = Svg(200, 260, 'A computer mouse seen from above, with two buttons and a scroll wheel', '#ffffff')
    s.add(f'<path d="M100 20 C150 20 168 70 168 130 C168 200 140 240 100 240 C60 240 32 200 32 130 C32 70 50 20 100 20 Z" fill="#d4d7db" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<path d="M100 20 V110 M34 110 H166" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<rect x="92" y="44" width="16" height="34" rx="8" fill="#55575c"/>')
    s.add(f'<path d="M100 20 C100 6 108 0 120 0" stroke="#55575c" stroke-width="3" fill="none"/>')
    s.save(PARTS, 'part-mouse')


def part_monitor():
    s = Svg(420, 320, 'A computer monitor (screen) on a stand', '#ffffff')
    s.add(f'<rect x="20" y="20" width="380" height="230" rx="8" fill="{PLASTIC}"/>')
    s.add(f'<rect x="32" y="32" width="356" height="200" rx="2" fill="#5b8fd6"/>')
    s.add(f'<path d="M32 180 l80 -60 l70 50 l90 -80 l116 70 v72 h-356z" fill="#7bc96f" opacity=".7"/>')
    s.add(f'<rect x="190" y="250" width="40" height="40" fill="{PLASTIC_DK}"/><rect x="130" y="288" width="160" height="14" rx="6" fill="{PLASTIC}"/>')
    s.save(PARTS, 'part-monitor')


def part_printer():
    s = Svg(360, 260, 'An inkjet printer with paper coming out of the front', '#ffffff')
    s.add(f'<rect x="30" y="80" width="300" height="120" rx="12" fill="#d4d7db" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<path d="M90 80 l20 -60 h140 l20 60z" fill="#ffffff" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<rect x="80" y="150" width="200" height="12" rx="3" fill="#55575c"/>')
    s.add(f'<path d="M100 156 h160 l14 84 h-188z" fill="#ffffff" stroke="#8e969d" stroke-width="2"/>')
    s.add(f'<g stroke="#9aa1a8" stroke-width="3"><line x1="114" y1="180" x2="240" y2="180"/><line x1="114" y1="196" x2="246" y2="196"/><line x1="114" y1="212" x2="220" y2="212"/></g>')
    s.add(f'<circle cx="300" cy="104" r="6" fill="#7bc96f"/>')
    s.save(PARTS, 'part-printer')


def part_router():
    s = Svg(420, 260, 'A wireless router: a flat box with antennas, lights on the front and network ports at the back', '#ffffff')
    for x, a in ((90, -14), (170, -4), (250, 4), (330, 14)):
        s.add(f'<rect x="{x - 7}" y="20" width="14" height="110" rx="7" fill="{PLASTIC}" transform="rotate({a} {x} 130)"/>')
    s.add(f'<rect x="40" y="120" width="340" height="90" rx="14" fill="{PLASTIC}"/>')
    for i in range(6):
        s.add(f'<circle cx="{90 + i * 32}" cy="190" r="5" fill="{"#7bc96f" if i != 3 else "#f2c94c"}"/>')
    for i in range(4):
        s.add(f'<rect x="{110 + i * 52}" y="136" width="36" height="26" rx="2" fill="{PLASTIC_DK}"/><rect x="{118 + i * 52}" y="142" width="20" height="14" fill="#55575c"/>')
    s.add(f'<rect x="330" y="136" width="36" height="26" rx="2" fill="#f2c94c"/>')
    s.save(PARTS, 'part-router')


def part_rj45():
    s = Svg(320, 160, 'A network (Ethernet) cable plug, see-through, with eight gold contacts and a clip', '#ffffff')
    s.add(f'<path d="M20 70 h120" stroke="#2f6fde" stroke-width="30" stroke-linecap="round"/>')
    s.add(f'<rect x="120" y="40" width="40" height="60" rx="4" fill="#2f6fde"/>')
    s.add(f'<rect x="160" y="36" width="130" height="68" rx="4" fill="#e6eef5" stroke="#9aa1a8" stroke-width="2"/>')
    for i in range(8):
        s.add(f'<rect x="{270}" y="{42 + i * 7.5:.1f}" width="16" height="4" fill="{GOLD}"/>')
        s.add(f'<line x1="170" y1="{44 + i * 7.5:.1f}" x2="270" y2="{44 + i * 7.5:.1f}" stroke="{["#f2994a", "#ffffff", "#7bc96f", "#2f6fde", "#ffffff", "#7bc96f", "#a0522d", "#ffffff"][i]}" stroke-width="3"/>')
    s.add(f'<path d="M170 36 l90 -22 l8 6 l-74 16" fill="#e6eef5" stroke="#9aa1a8" stroke-width="2"/>')
    s.save(PARTS, 'part-rj45')


# ================================================================ the city ==

DISTRICTS = {  # lesson: (pin x, pin y, name)
    1: (84, 140, 'City Gates'),
    2: (300, 150, 'CPU Downtown'),
    3: (436, 110, 'RAM Row'),
    4: (300, 150, 'The Switch Yard'),
    5: (180, 330, 'The Warehouse'),
    6: (84, 330, 'The Harbour'),
    7: (470, 330, 'The Power Station'),
}
SAYS = {
    1: ['Everything comes in and goes out', 'through the City Gates. Follow me!'],
    2: ['Downtown: the CPU. Billions of', 'instructions a second - and not one idea.'],
    3: ['RAM Row is the desk. The Warehouse', 'is the filing cabinet. Remember that.'],
    4: ['Inside every chip: switches.', 'Off is 0. On is 1. That is all.'],
    5: ['Every file in the Warehouse is', 'counted in bytes. Millions of them.'],
    6: ['The Harbour: messages leave in', 'little packets and find their own way.'],
    7: ['The city is dark. Find what broke,', 'and we can all go home.'],
}


def volt(s, cx, cy, sc=1.0, mood='happy'):
    o = lambda v: v * sc
    s.add(f'<path d="M{cx + o(10)} {cy - o(62)} L{cx - o(34)} {cy + o(10)} H{cx - o(2)} L{cx - o(18)} {cy + o(70)} L{cx + o(38)} {cy - o(12)} H{cx + o(4)} L{cx + o(24)} {cy - o(62)} Z" fill="{VOLT}" stroke="{VOLT_DK}" stroke-width="{o(3.5)}" stroke-linejoin="round"/>')
    s.add(f'<circle cx="{cx - o(6)}" cy="{cy - o(6)}" r="{o(4.5)}" fill="{INK}"/><circle cx="{cx + o(10)}" cy="{cy - o(6)}" r="{o(4.5)}" fill="{INK}"/>')
    if mood == 'oh':
        s.add(f'<ellipse cx="{cx + o(2)}" cy="{cy + o(10)}" rx="{o(4)}" ry="{o(5)}" fill="{INK}"/>')
    else:
        s.add(f'<path d="M{cx - o(8)} {cy + o(8)} q{o(10)} {o(9)} {o(20)} 0" stroke="{INK}" stroke-width="{o(3)}" fill="none" stroke-linecap="round"/>')
    for a, d in ((-150, 50), (-30, 52), (160, 46)):
        r = math.radians(a)
        s.add(f'<line x1="{cx + o(d) * math.cos(r):.1f}" y1="{cy + o(d) * math.sin(r):.1f}" x2="{cx + o(d + 12) * math.cos(r):.1f}" y2="{cy + o(d + 12) * math.sin(r):.1f}" stroke="{VOLT}" stroke-width="{o(3)}" stroke-linecap="round"/>')


def ndlovu(s, cx, cy, sc=1.0):
    """Dr Ndlovu on the radio: her face in a round radio screen."""
    o = lambda v: v * sc
    s.add(f'<circle cx="{cx}" cy="{cy}" r="{o(40)}" fill="#e6eef5" stroke="{INK}" stroke-width="{o(3)}"/>')
    s.add(f'<path d="M{cx - o(22)} {cy - o(4)} q{o(22)} {o(-34)} {o(44)} 0 q{o(4)} {o(-24)} {o(-22)} {o(-26)} q{o(-26)} {o(2)} {o(-22)} {o(26)}z" fill="#2b2b2b"/>')
    s.add(f'<circle cx="{cx}" cy="{cy + o(6)}" r="{o(19)}" fill="{SKIN}"/>')
    s.add(f'<rect x="{cx - o(17)}" y="{cy}" width="{o(14)}" height="{o(9)}" rx="{o(3)}" fill="none" stroke="#2a7d8c" stroke-width="{o(2.2)}"/><rect x="{cx + o(3)}" y="{cy}" width="{o(14)}" height="{o(9)}" rx="{o(3)}" fill="none" stroke="#2a7d8c" stroke-width="{o(2.2)}"/>')
    s.add(f'<path d="M{cx - o(6)} {cy + o(16)} q{o(6)} {o(5)} {o(12)} 0" stroke="#3a1f10" stroke-width="{o(2.2)}" fill="none" stroke-linecap="round"/>')
    s.add(f'<path d="M{cx - o(30)} {cy + o(40)} q{o(30)} {o(-16)} {o(60)} 0" fill="{COAT}" stroke="{INK}" stroke-width="{o(2)}"/>')
    for i, r in enumerate((48, 56)):
        s.add(f'<path d="M{cx + o(r) * 0.7:.1f} {cy - o(r) * 0.7:.1f} a{o(r)} {o(r)} 0 0 1 {o(r) * 0.3:.1f} {o(r) * 0.4:.1f}" stroke="{PIN}" stroke-width="{o(2.5)}" fill="none"/>')


def city(svg, here, done):
    """The motherboard city: districts, copper roads, labels; the pin at district `here`."""
    s = svg
    s.add(f'<rect x="10" y="10" width="540" height="390" rx="10" fill="{BOARD}"/>')
    roads = ['M84 140 H300', 'M300 150 H436', 'M300 150 V330 H180', 'M180 330 H84', 'M300 330 H470', 'M436 110 V60 H520', 'M84 140 V60', 'M470 330 V390']
    for d in roads:
        s.add(f'<path d="{d}" stroke="{COPPER}" stroke-width="7" fill="none" stroke-linecap="round" stroke-linejoin="round"/>')
        s.add(f'<path d="{d}" stroke="#e8c66a" stroke-width="1.5" fill="none" stroke-dasharray="6 6"/>')
    # districts
    s.add(f'<rect x="34" y="70" width="86" height="130" rx="4" fill="{METAL}" stroke="{CREAM}" stroke-width="2"/>')
    for i in range(4):
        s.add(f'<rect x="46" y="{84 + i * 24}" width="30" height="14" rx="2" fill="#2f6fde"/>')
    s.add(f'<rect x="240" y="96" width="120" height="110" rx="4" fill="#1e2b26" stroke="{CREAM}" stroke-width="2"/>')
    s.add(f'<rect x="262" y="116" width="76" height="70" fill="{METAL}"/>')
    for i in range(4):
        s.add(f'<rect x="{392 + i * 22}" y="54" width="12" height="150" rx="2" fill="{BOARD_DK}" stroke="{CREAM}" stroke-width="1.2"/>')
    s.add(f'<rect x="130" y="306" width="110" height="46" rx="4" fill="#1c1c1e" stroke="{CREAM}" stroke-width="2"/>')
    s.add(f'<rect x="40" y="300" width="70" height="60" rx="4" fill="#2a6b4a" stroke="{CREAM}" stroke-width="2"/>')
    s.add(f'<path d="M50 352 q25 -14 50 0" stroke="{CREAM}" stroke-width="2" fill="none"/>')
    s.add(f'<rect x="420" y="290" width="104" height="80" rx="4" fill="{PLASTIC}" stroke="{CREAM}" stroke-width="2"/>')
    s.add(f'<circle cx="472" cy="330" r="26" fill="none" stroke="#8e969d" stroke-width="3"/>')
    for n, (px, py, name) in DISTRICTS.items():
        if n == 4:
            continue
        lx, ly = {1: (77, 222), 2: (300, 226), 3: (436, 222), 5: (185, 374), 6: (75, 382), 7: (472, 388)}[n]
        fill = CREAM if (n == here or (n == 2 and here == 4)) else '#b9cdbd'
        s.text(lx, ly, name.upper(), 13, fill, 'middle', 700)
    if here == 4:
        s.text(300, 244, 'THE SWITCH YARD', 11, PIN, 'middle', 700)
    # ticks on districts done
    for n in done:
        px, py, _ = DISTRICTS[n]
        s.add(f'<circle cx="{px + 30}" cy="{py - 40}" r="10" fill="{CREAM}"/><path d="M{px + 25} {py - 40} l4 4 l7 -8" stroke="{BOARD}" stroke-width="2.5" fill="none" stroke-linecap="round"/>')
    px, py, _ = DISTRICTS[here]
    s.add(f'<g transform="translate({px} {py})"><ellipse cx="0" cy="2" rx="9" ry="3" fill="#000" opacity=".3"/><path d="M0 0 c-16 -16 -22 -26 -22 -36 a22 22 0 1 1 44 0 c0 10 -6 20 -22 36z" fill="{PIN}" stroke="{INK}" stroke-width="2"/><circle cx="0" cy="-36" r="8" fill="#fff"/></g>')


def map_opener(n):
    s = Svg(560, 520, f'The motherboard city map, with the pin at {DISTRICTS[n][2]}; Volt the spark explains', '#e7efe4')
    city(s, n, [k for k in range(1, n) if k != 4])
    volt(s, 70, 456, 0.62)
    lines = SAYS[n]
    s.add(f'<path d="M112 452 l-14 -4 l12 -10" fill="#ffffff" stroke="{INK}" stroke-width="2" stroke-linejoin="round"/>')
    s.add(f'<rect x="108" y="418" width="430" height="64" rx="12" fill="#ffffff" stroke="{INK}" stroke-width="2"/>')
    s.add(f'<path d="M108 445 v-8" stroke="#ffffff" stroke-width="4"/>')
    for i, line in enumerate(lines):
        s.text(126, 444 + i * 22, line, 15, INK, 'start', 500, TEXT)
    s.save(DOODLES, f'machine-map-{n:02d}')


# ============================================================= doodles ==

def d_volt_wave():
    s = Svg(240, 200, 'Volt, a spark of electricity, waving', None)
    volt(s, 120, 100, 1.2)
    s.save(DOODLES, 'machine-volt')


def d_radio():
    s = Svg(260, 200, 'Dr Ndlovu talking on the radio from outside the computer', None)
    ndlovu(s, 110, 96, 1.5)
    s.save(DOODLES, 'machine-radio')


def d_ipo():
    s = Svg(560, 220, 'Input, process, output, with storage underneath: a key press goes in, the CPU works on it, a letter appears on the screen', '#ffffff')
    boxes = [('INPUT', 'keyboard, mouse, mic, camera', '#2f6fde', 20), ('PROCESS', 'the CPU works on it', PIN, 205), ('OUTPUT', 'screen, speakers, printer', '#1f8a5b', 390)]
    for title, sub, col, x in boxes:
        s.add(f'<rect x="{x}" y="30" width="150" height="90" rx="10" fill="{col}"/>')
        s.text(x + 75, 70, title, 22, '#ffffff', 'middle', 700)
        s.text(x + 75, 98, sub, 11, '#ffffff', 'middle', 500, TEXT)
    for x in (172, 357):
        s.add(f'<path d="M{x} 75 h26" stroke="{INK}" stroke-width="4"/><path d="M{x + 24} 66 l10 9 l-10 9z" fill="{INK}"/>')
    s.add(f'<rect x="205" y="150" width="150" height="56" rx="10" fill="{COPPER}"/>')
    s.text(280, 176, 'STORAGE', 18, '#ffffff', 'middle', 700)
    s.text(280, 196, 'keeps it for later', 11, '#ffffff', 'middle', 500, TEXT)
    s.add(f'<path d="M270 120 v28 M290 148 v-28" stroke="{INK}" stroke-width="3"/><path d="M264 140 l6 8 l6 -8M284 128 l6 -8 l6 8" stroke="{INK}" stroke-width="3" fill="none"/>')
    s.save(DOODLES, 'machine-ipo')


def d_ram_desk():
    s = Svg(560, 240, 'RAM is the desk you work on - fast, but cleared when the power goes; storage is the filing cabinet - slower, but it keeps everything', '#ffffff')
    s.add(f'<rect x="30" y="110" width="260" height="16" rx="3" fill="#a0723f"/><rect x="44" y="126" width="12" height="90" fill="#7d5730"/><rect x="264" y="126" width="12" height="90" fill="#7d5730"/>')
    for i, (x, r) in enumerate(((70, -6), (130, 4), (190, -3))):
        s.add(f'<rect x="{x}" y="70" width="50" height="40" fill="#ffffff" stroke="#9aa1a8" stroke-width="2" transform="rotate({r} {x + 25} 90)"/>')
    s.text(160, 40, 'RAM = the desk', 20, INK, 'middle', 700)
    s.text(160, 60, 'fast - but cleared when the power goes', 12, INK, 'middle', 500, TEXT)
    s.add(f'<rect x="370" y="60" width="130" height="160" rx="4" fill="#8e969d" stroke="#55575c" stroke-width="2"/>')
    for i in range(3):
        s.add(f'<rect x="382" y="{72 + i * 50}" width="106" height="40" rx="3" fill="#c9ced3" stroke="#55575c"/><rect x="420" y="{86 + i * 50}" width="30" height="8" rx="3" fill="#55575c"/>')
    s.text(435, 40, 'Storage = the filing cabinet', 20, INK, 'middle', 700)
    s.text(435, 236, 'slower - but it keeps everything', 12, INK, 'middle', 500, TEXT)
    s.save(DOODLES, 'machine-ram-desk')


def d_switches():
    s = Svg(560, 200, 'Eight light switches make one byte: off, off, off, off, one, one, off, one is 0 0 0 0 1 1 0 1, which is 13', '#ffffff')
    bits = [0, 0, 0, 0, 1, 1, 0, 1]
    vals = [128, 64, 32, 16, 8, 4, 2, 1]
    for i, (b, v) in enumerate(zip(bits, vals)):
        x = 30 + i * 64
        s.add(f'<rect x="{x}" y="40" width="50" height="80" rx="8" fill="#f1f2ee" stroke="{INK}" stroke-width="2"/>')
        s.add(f'<rect x="{x + 15}" y="{50 if b else 80}" width="20" height="30" rx="4" fill="{VOLT if b else "#9aa1a8"}" stroke="{INK}" stroke-width="2"/>')
        s.text(x + 25, 146, str(b), 24, INK, 'middle', 700)
        s.text(x + 25, 172, str(v), 14, '#2a7d8c' if b else '#9aa1a8', 'middle', 600, TEXT)
    s.text(280, 26, 'ON = 1   OFF = 0', 16, INK, 'middle', 700)
    s.text(280, 194, '8 + 4 + 1 = 13', 14, PIN, 'middle', 700, TEXT)
    s.save(DOODLES, 'machine-switches')


def d_sizes():
    s = Svg(560, 250, 'File sizes, smallest to biggest: a text message about 1 KB, a photo about 3 MB, a song about 5 MB, a film about 2 GB', '#ffffff')
    items = [('a text message', '1 KB', 6), ('a photo', '3 MB', 22), ('a song (4 min)', '5 MB', 30), ('a film (2 h)', '2 GB', 150)]
    x = 30
    for name, size, h in items:
        s.add(f'<rect x="{x}" y="{200 - h}" width="90" height="{h}" rx="4" fill="#2a7d8c"/>')
        s.text(x + 45, 220, name, 12, INK, 'middle', 500, TEXT)
        s.text(x + 45, 192 - h, size, 16, INK, 'middle', 700)
        x += 130
    s.add(f'<line x1="20" y1="200" x2="540" y2="200" stroke="{INK}" stroke-width="2"/>')
    s.text(280, 246, 'not to scale - the film would be 600 times taller than the photo', 11, '#5a5e5b', 'middle', 500, TEXT)
    s.save(DOODLES, 'machine-sizes')


def d_packets():
    s = Svg(560, 240, 'A message is cut into numbered packets; they take different roads through routers and are put back in order at the other end', '#ffffff')
    s.add(f'<rect x="20" y="90" width="80" height="60" rx="8" fill="#2f6fde"/>')
    s.text(60, 126, 'Lindi', 14, '#ffffff', 'middle', 700)
    s.add(f'<rect x="460" y="90" width="80" height="60" rx="8" fill="#1f8a5b"/>')
    s.text(500, 126, 'Sipho', 14, '#ffffff', 'middle', 700)
    routers = [(190, 50), (190, 190), (300, 120), (380, 50), (380, 190)]
    links = [(100, 120, 190, 50), (100, 120, 190, 190), (190, 50, 300, 120), (190, 190, 300, 120), (190, 50, 380, 50), (300, 120, 380, 50), (300, 120, 380, 190), (190, 190, 380, 190), (380, 50, 460, 120), (380, 190, 460, 120)]
    for a, b, c, d in links:
        s.add(f'<line x1="{a}" y1="{b}" x2="{c}" y2="{d}" stroke="#9aa1a8" stroke-width="3"/>')
    for x, y in routers:
        s.add(f'<rect x="{x - 22}" y="{y - 14}" width="44" height="28" rx="6" fill="{PLASTIC}"/><circle cx="{x - 8}" cy="{y + 4}" r="3" fill="#7bc96f"/><circle cx="{x + 4}" cy="{y + 4}" r="3" fill="#7bc96f"/>')
    for (x, y, n) in ((146, 82, 1), (246, 92, 2), (246, 160, 3), (420, 82, 4)):
        s.add(f'<rect x="{x - 14}" y="{y - 11}" width="28" height="22" rx="4" fill="{VOLT}" stroke="{INK}" stroke-width="2"/>')
        s.text(x, y + 6, str(n), 14, INK, 'middle', 700)
    s.text(280, 232, 'Each packet finds its own way. They are put back in order at the end.', 12, INK, 'middle', 500, TEXT)
    s.save(DOODLES, 'machine-packets')


def d_fetch():
    s = Svg(400, 300, 'The CPU\'s cycle: fetch the next instruction, decode it, execute it - billions of times a second', '#ffffff')
    cx, cy, r = 200, 160, 96
    for i, (word, col) in enumerate((('FETCH', '#2f6fde'), ('DECODE', PIN), ('EXECUTE', '#1f8a5b'))):
        a = math.radians(-90 + i * 120)
        x, y = cx + r * math.cos(a), cy + r * math.sin(a)
        s.add(f'<circle cx="{x:.1f}" cy="{y:.1f}" r="48" fill="{col}"/>')
        s.text(x, y + 6, word, 16, '#ffffff', 'middle', 700)
    s.add(f'<path d="M{cx + 54} {cy - 70} a96 96 0 0 1 36 60" stroke="{INK}" stroke-width="3" fill="none"/>')
    s.add(f'<path d="M{cx + 40} {cy + 92} a96 96 0 0 1 -80 0" stroke="{INK}" stroke-width="3" fill="none"/>')
    s.add(f'<path d="M{cx - 90} {cy - 10} a96 96 0 0 1 36 -60" stroke="{INK}" stroke-width="3" fill="none"/>')
    s.text(200, 22, 'Billions of times a second', 14, INK, 'middle', 700)
    s.save(DOODLES, 'machine-fetch')


def d_dust():
    s = Svg(300, 200, 'A dusty CPU cooler: the fan clogged with grey fluff, getting too hot', '#ffffff')
    s.add(f'<rect x="60" y="30" width="180" height="150" rx="8" fill="{PLASTIC}"/>')
    s.add(f'<circle cx="150" cy="105" r="62" fill="#3a3d42"/>')
    for a in range(0, 360, 45):
        r = math.radians(a)
        s.add(f'<path d="M150 105 q{40 * math.cos(r):.1f} {40 * math.sin(r):.1f} {58 * math.cos(r + 0.4):.1f} {58 * math.sin(r + 0.4):.1f}" stroke="#8e969d" stroke-width="10" fill="none" stroke-linecap="round"/>')
    for (x, y, rr) in ((110, 70, 18), (180, 80, 22), (130, 140, 20), (190, 140, 16), (150, 100, 14)):
        s.add(f'<circle cx="{x}" cy="{y}" r="{rr}" fill="#b9bdc4" opacity=".9"/>')
    s.text(258, 40, 'HOT!', 18, PIN, 'start', 700)
    s.save(DOODLES, 'machine-dust')


def main():
    part_cpu(); part_ram(); part_m2(); part_hdd(); part_ssd25(); part_psu()
    motherboard('part-motherboard', False); motherboard('part-motherboard-labelled', True); motherboard('part-motherboard-quiz', False, 150)
    part_keyboard(); part_mouse(); part_monitor(); part_printer(); part_router(); part_rj45()
    for n in range(1, 8):
        map_opener(n)
    d_volt_wave(); d_radio(); d_ipo(); d_ram_desk(); d_switches(); d_sizes(); d_packets(); d_fetch(); d_dust()


if __name__ == '__main__':
    main()
