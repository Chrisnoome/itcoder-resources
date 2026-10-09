import os, sys
out = sys.argv[1]
SE = "font-family=\"'Special Elite', 'Courier New', monospace\""
CP = "font-family=\"'Courier Prime', 'Courier New', monospace\""
CV = "font-family=\"Caveat, 'Comic Sans MS', cursive\""
BO = "font-family=\"'Black Ops One', Impact, sans-serif\""
INK, RED, GREEN = "#2a2116", "#b3141c", "#1f7a3a"


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


def folder(h, tab):
    return f'''<path d="M10 40 v-22 q0-8 8-8 h222 q7 0 10 7 l10 23 z" fill="#c99f62"/>
<rect x="10" y="36" width="660" height="{h - 44}" rx="6" fill="#d6b277"/>
<text x="26" y="30" {SE} font-size="13" fill="#3b2a14">{tab}</text>'''


files = {}

# ---- Figure: the leaked list, and where the same password opens doors
rows = [("thandi.m@mail.co.za", "f7#Qp...", False), ("lerato@mail.co.za", "lerato2012", True),
        ("sipho.k@mail.co.za", "Kz9!rt...", False), ("ayanda@mail.co.za", "hungry z...", False)]
table = []
for i, (email, pw, hot) in enumerate(rows):
    y = 128 + i * 34
    table.append(f'<line x1="56" y1="{y + 10}" x2="318" y2="{y + 10}" stroke="#bfb39c"/>')
    table.append(f'<text x="62" y="{y}" {CP} font-size="12" fill="#1d1f24">{email}</text>')
    table.append(f'<text x="232" y="{y}" {CP} font-size="12" font-weight="{700 if hot else 400}" fill="#1d1f24">{pw}</text>')
doors = [("EMAIL", "same password", "OPEN", RED, 70), ("SCHOOL LOGIN", "same password", "OPEN", RED, 172), ("BANK APP", "different password", "SHUT", GREEN, 274)]
door_svg = []
for name, note, state, colour, y in doors:
    door_svg.append(f'''<g transform="rotate({1 if y != 172 else -1} 520 {y + 38})"><rect x="420" y="{y}" width="230" height="78" fill="#f6efdc"/>
<text x="448" y="{y + 26}" {SE} font-size="15" fill="{INK}">{name}</text>
<text x="448" y="{y + 48}" {SE} font-size="12.5" fill="{INK}">{note}</text>
<text x="634" y="{y + 66}" text-anchor="end" {BO} font-size="18" fill="{colour}">{state}</text></g>''')
files['safety-leak-list.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" width="680" height="420">
{folder(420, "CASE 04 · THE LEAK")}
<g transform="rotate(-1.5 190 220)">
<rect x="40" y="60" width="300" height="300" fill="#fbf8f0" stroke="#bfb39c"/>
<text x="56" y="88" {SE} font-size="15" fill="{INK}">GAMEZONE - STOLEN LIST</text>
<text x="62" y="108" {SE} font-size="11" fill="#6b5a40">EMAIL</text><text x="232" y="108" {SE} font-size="11" fill="#6b5a40">PASSWORD</text>
{chr(10).join(table)}
<text x="62" y="270" {CP} font-size="12" fill="#6b5a40">... 2 million more rows</text>
<ellipse cx="190" cy="158" rx="140" ry="17" fill="none" stroke="{RED}" stroke-width="3"/>
<text x="56" y="336" {CV} font-size="20" fill="#3b3326">Exhibit A · found for sale online</text>
</g>
<g fill="none" stroke="{RED}" stroke-width="2.2"><path d="M432 92 Q380 110 330 156"/><path d="M432 196 Q380 190 330 162"/></g>
<path d="M432 300 Q380 260 330 168" fill="none" stroke="#7a6a50" stroke-width="2" stroke-dasharray="6 5"/>
{chr(10).join(door_svg)}
<g fill="{RED}"><circle cx="432" cy="92" r="6"/><circle cx="432" cy="196" r="6"/></g><circle cx="432" cy="300" r="6" fill="#7a6a50"/>
<text x="650" y="396" text-anchor="end" {CV} font-size="18" fill="#3b3326">Same password = one key for every door</text>
</svg>
'''

# ---- Doodle: a bucket that leaks paper
files['safety-leaky-bucket.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<path d="M50 40 h120 l-14 104 h-92 z" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3.2"/>
<ellipse cx="110" cy="40" rx="60" ry="10" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3.2"/>
<path d="M56 40 q54 -40 108 0" fill="none" stroke="{INK}" stroke-width="2.6"/>
<text x="110" y="96" text-anchor="middle" {BO} font-size="13" fill="{INK}">DATA</text>
<g fill="{INK}"><circle cx="84" cy="122" r="4"/><circle cx="132" cy="114" r="4"/><circle cx="104" cy="136" r="4"/></g>
<g transform="rotate(-18 190 120)"><rect x="176" y="104" width="34" height="24" fill="#fff27a" stroke="{INK}" stroke-width="2"/><path d="M181 112 h22 M181 119 h16" stroke="{INK}" stroke-width="1.6"/></g>
<g transform="rotate(14 46 150)"><rect x="30" y="138" width="34" height="24" fill="#fff27a" stroke="{INK}" stroke-width="2"/><path d="M35 146 h22 M35 153 h16" stroke="{INK}" stroke-width="1.6"/></g>
<g transform="rotate(30 150 158)"><rect x="140" y="146" width="30" height="20" fill="#fff27a" stroke="{INK}" stroke-width="2"/></g>
<path d="M132 118 q10 10 30 0 M84 126 q-10 12 -30 16" fill="none" stroke="#8fd3ff" stroke-width="2.4"/>
</svg>
'''

# ---- Doodle: Sniff reads the newspaper
files['safety-sniff-newspaper.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{sniff(-12, 22, 0.6)}
<g transform="rotate(6 178 82)">
<rect x="122" y="24" width="112" height="120" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="2.6"/>
<text x="130" y="46" {BO} font-size="12" fill="{RED}">2 MILLION</text>
<text x="130" y="62" {BO} font-size="12" fill="{RED}">PASSWORDS</text>
<text x="130" y="78" {BO} font-size="12" fill="{RED}">LEAKED!</text>
<path d="M130 92 h94 M130 102 h94 M130 112 h80 M130 122 h90 M130 132 h70" stroke="{INK}" stroke-width="1.6" opacity=".6"/>
</g>
</svg>
'''

# ---- Doodle: one key, many doors
files['safety-one-key.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<g stroke="{INK}" stroke-width="2.6">
<rect x="20" y="20" width="54" height="96" fill="#8a5a2e"/><rect x="92" y="20" width="54" height="96" fill="#8a5a2e"/><rect x="164" y="20" width="54" height="96" fill="#8a5a2e"/>
</g>
<g fill="#e8c35a" stroke="{INK}" stroke-width="2"><circle cx="64" cy="70" r="5"/><circle cx="136" cy="70" r="5"/><circle cx="208" cy="70" r="5"/></g>
<g transform="rotate(-10 120 146)">
<circle cx="84" cy="146" r="12" fill="#e8c35a" stroke="{INK}" stroke-width="3"/>
<path d="M96 146 h70 M154 146 v10 M164 146 v8" fill="none" stroke="{INK}" stroke-width="3.2"/>
</g>
<text x="176" y="138" {CV} font-size="18" font-weight="700" fill="{RED}">fits all!</text>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files), 'lesson 4 files')
