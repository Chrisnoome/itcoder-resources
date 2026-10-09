import os, sys
sys.path.insert(0, os.path.dirname(__file__))
out = sys.argv[1]
CP = "font-family=\"'Courier Prime', 'Courier New', monospace\""
CV = "font-family=\"Caveat, 'Comic Sans MS', cursive\""
BO = "font-family=\"'Black Ops One', Impact, sans-serif\""
INK, RED = "#2a2116", "#b3141c"


def sniff(tx, ty, s):
    return f'''<g transform="translate({tx} {ty}) scale({s})" stroke="{INK}" stroke-linecap="round" stroke-linejoin="round">
<ellipse cx="120" cy="122" rx="56" ry="64" fill="#c98b4f" stroke-width="5"/>
<path d="M70 92 q-34 30 -20 92 q20 10 34 -8 q-8 -50 2 -76 z" fill="#8a5a2e" stroke-width="5"/>
<path d="M170 92 q34 30 20 92 q-20 10 -34 -8 q8 -50 -2 -76 z" fill="#8a5a2e" stroke-width="5"/>
<ellipse cx="120" cy="158" rx="34" ry="24" fill="#e0b07c" stroke-width="4"/>
<ellipse cx="120" cy="146" rx="15" ry="10" fill="{INK}"/>
<path d="M98 108 q8 -6 16 0 M126 108 q8 -6 16 0" fill="none" stroke-width="4"/>
<circle cx="106" cy="116" r="5.5" fill="{INK}" stroke="none"/><circle cx="134" cy="116" r="5.5" fill="{INK}" stroke="none"/>
<path d="M110 168 q10 8 20 0" fill="none" stroke-width="4"/>
<path d="M84 186 q36 14 72 0" fill="none" stroke="{RED}" stroke-width="9"/>
<circle cx="120" cy="204" r="11" fill="#e8c35a" stroke-width="4"/>
</g>'''


def phisher(tx, ty, s):
    return f'''<g transform="translate({tx} {ty}) scale({s})">
<path d="M14 168 q0 -70 40 -82 q40 12 40 82 z" fill="#2a2a2a"/>
<circle cx="54" cy="66" r="24" fill="#2a2a2a"/>
<ellipse cx="54" cy="46" rx="44" ry="8" fill="#1b1b1b"/>
<path d="M34 46 q4 -28 20 -28 q16 0 20 28 z" fill="#1b1b1b"/>
<ellipse cx="45" cy="68" rx="5.5" ry="3" fill="#fff"/><ellipse cx="63" cy="68" rx="5.5" ry="3" fill="#fff"/>
<path d="M44 80 q10 6 20 0" fill="none" stroke="#fff" stroke-width="2.2" stroke-linecap="round"/>
</g>'''


files = {}
# The Phisher reading his list of common passwords
files['safety-phisher-list.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
{phisher(-4, 0, 1)}
<g transform="rotate(4 168 90)">
<path d="M112 14 h96 v136 l-8 -6 l-8 6 l-8 -6 l-8 6 l-8 -6 l-8 6 l-8 -6 l-8 6 l-8 -6 l-8 6 l-8 -6 l-8 6 z" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="2.6" stroke-linejoin="round"/>
<text x="122" y="34" {BO} font-size="11" fill="{RED}">TRY FIRST</text>
<g {CP} font-size="12" fill="{INK}">
<text x="122" y="54">123456</text><text x="122" y="70">password</text><text x="122" y="86">qwerty</text>
<text x="122" y="102">iloveyou</text><text x="122" y="118">football</text><text x="122" y="134">...</text>
</g>
</g>
</svg>
'''
# A password on a sticky note on a screen
files['safety-sticky-note.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<rect x="20" y="14" width="190" height="120" rx="8" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3.2"/>
<rect x="32" y="26" width="166" height="96" rx="3" fill="#dfe6ee" stroke="{INK}" stroke-width="2"/>
<path d="M100 134 l-8 22 h48 l-8 -22" fill="none" stroke="{INK}" stroke-width="3.2"/>
<path d="M78 158 h76" stroke="{INK}" stroke-width="3.2"/>
<g transform="rotate(7 170 64)">
<rect x="132" y="30" width="80" height="70" fill="#fff27a" stroke="{INK}" stroke-width="2.2"/>
<text x="140" y="54" {CV} font-size="16" fill="{INK}">password:</text>
<text x="140" y="76" {CV} font-size="19" font-weight="700" fill="{RED}">sipho2010</text>
</g>
<text x="60" y="78" {CP} font-size="12" fill="{INK}">Log in</text>
<rect x="56" y="86" width="64" height="12" rx="2" fill="#fff" stroke="{INK}" stroke-width="1.5"/>
</svg>
'''
# Sniff guarding a safe full of keys - the password manager
files['safety-sniff-safe.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<rect x="128" y="40" width="100" height="112" rx="6" fill="#7d8a96" stroke="{INK}" stroke-width="3.2"/>
<rect x="140" y="52" width="76" height="88" rx="4" fill="#9aa6b1" stroke="{INK}" stroke-width="2"/>
<circle cx="178" cy="96" r="18" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3"/>
<path d="M178 82 v8 M178 102 v8 M164 96 h8 M184 96 h8" stroke="{INK}" stroke-width="2.4"/>
<circle cx="178" cy="96" r="4" fill="{INK}"/>
<path d="M140 152 v10 M216 152 v10" stroke="{INK}" stroke-width="3.2"/>
<g transform="rotate(-20 176 26)"><circle cx="160" cy="26" r="8" fill="#e8c35a" stroke="{INK}" stroke-width="2.4"/><path d="M168 26 h24 M186 26 v6 M192 26 v6" fill="none" stroke="{INK}" stroke-width="2.4"/></g>
{sniff(-12, 20, 0.6)}
</svg>
'''
for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files))
