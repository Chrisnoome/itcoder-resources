import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from safety_art2 import sniff, phisher, CP, CV, BO, INK, RED  # noqa: E402  (re-running art2 is harmless)

out = sys.argv[1]
SE = "font-family=\"'Special Elite', 'Courier New', monospace\""
GREEN = "#1f7a3a"


def folder(h, tab):
    return f'''<path d="M10 40 v-22 q0-8 8-8 h222 q7 0 10 7 l10 23 z" fill="#c99f62"/>
<rect x="10" y="36" width="660" height="{h - 44}" rx="6" fill="#d6b277"/>
<text x="26" y="30" {SE} font-size="13" fill="#3b2a14">{tab}</text>'''


def card(x, y, w, h, tilt, title, lines, pin=None):
    s = [f'<g transform="rotate({tilt} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#f6efdc"/>',
         f'<text x="{x + 24}" y="{y + 24}" {SE} font-size="15" fill="{INK}">{title}</text>']
    for k, line in enumerate(lines):
        s.append(f'<text x="{x + 24}" y="{y + 46 + k * 17}" {SE} font-size="12.5" fill="{INK}">{line}</text>')
    s.append('</g>')
    if pin:
        s.append(f'<circle cx="{pin[0]}" cy="{pin[1]}" r="6" fill="{RED}"/>')
    return '\n'.join(s)


files = {}

# ---- Figure: a door with two locks
files['safety-two-locks.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" width="680" height="420">
{folder(420, "CASE 03 · THE SECOND LOCK")}
<g transform="rotate(-2 170 220)">
<rect x="60" y="60" width="230" height="320" fill="#fbf8f0" stroke="#bfb39c"/>
<rect x="88" y="80" width="174" height="250" fill="#8a5a2e" stroke="{INK}" stroke-width="3"/>
<rect x="104" y="98" width="142" height="96" fill="none" stroke="{INK}" stroke-width="2" opacity=".5"/>
<rect x="104" y="214" width="142" height="96" fill="none" stroke="{INK}" stroke-width="2" opacity=".5"/>
<path d="M210 150 v-14 a14 14 0 0 1 28 0 v14" fill="none" stroke="#9aa0aa" stroke-width="6"/>
<rect x="202" y="148" width="44" height="36" rx="5" fill="#e8c35a" stroke="{INK}" stroke-width="2.6"/>
<circle cx="224" cy="164" r="4" fill="{INK}"/>
<path d="M210 236 v-14 a14 14 0 0 1 28 0 v14" fill="none" stroke="#9aa0aa" stroke-width="6"/>
<rect x="202" y="234" width="44" height="36" rx="5" fill="#e8c35a" stroke="{INK}" stroke-width="2.6"/>
<circle cx="224" cy="250" r="4" fill="{INK}"/>
<text x="80" y="358" {CV} font-size="20" fill="#3b3326">Exhibit A · your account's front door</text>
</g>
<g fill="none" stroke="{RED}" stroke-width="2.2"><path d="M384 92 Q300 120 236 160"/><path d="M384 214 Q310 230 238 250"/><path d="M384 330 Q300 300 250 276"/></g>
{card(370, 60, 280, 84, 1.2, "LOCK 1: SOMETHING YOU KNOW", ["Your password or PIN.", "Phished or stolen? It opens."], (384, 92))}
{card(370, 180, 280, 84, -1.2, "LOCK 2: SOMETHING YOU HAVE", ["Your phone, which gets a", "fresh code every time."], (384, 214))}
{card(370, 298, 280, 84, 0.8, "OR: SOMETHING YOU ARE", ["Your fingerprint or face,", "unlocking that phone."], (384, 330))}
</svg>
'''

# ---- Figure: the WhatsApp "sent you a code by mistake" exhibit
files['safety-code-mistake.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 460" width="680" height="460">
{folder(460, "CASE 03 · THE CODE BY MISTAKE")}
<g transform="rotate(-2.5 175 220)">
<rect x="60" y="58" width="230" height="326" fill="#fbf8f0" stroke="#bfb39c"/>
<rect x="75" y="73" width="200" height="256" fill="#e7ddd0"/>
<rect x="82" y="80" width="186" height="46" rx="8" fill="#3a3f47"/>
<text x="90" y="96" font-family="system-ui, sans-serif" font-size="9" fill="#c9ced6">SMS · WhatsApp</text>
<text x="90" y="114" {CP} font-size="10.5" fill="#fff">WhatsApp code: 482-913</text>
<rect x="75" y="134" width="200" height="28" fill="#2f6b5a"/>
<text x="88" y="153" {CP} font-size="12" font-weight="700" fill="#fff">Thabo (school)</text>
<rect x="88" y="172" width="176" height="104" rx="8" fill="#fff"/>
<g {CP} font-size="11" fill="#1d1f24">
<text x="96" y="192">Hey! Sorry, I sent</text><text x="96" y="208">my code to your number</text>
<text x="96" y="224">by mistake. Please send</text><text x="96" y="240">it to me quickly??</text>
<text x="96" y="260">I'm locked out!!</text></g>
<text x="80" y="362" {CV} font-size="20" fill="#3b3326">Exhibit B · 21:14, a school night</text>
<circle cx="175" cy="64" r="7" fill="{RED}"/>
</g>
<g fill="none" stroke="{RED}" stroke-width="2.2"><path d="M384 92 Q320 96 262 106"/><path d="M384 214 Q300 180 236 150"/><path d="M384 330 Q300 300 230 256"/></g>
{card(370, 60, 280, 84, 1.2, "CLUE 1: WHOSE CODE IS IT?", ["WhatsApp sent it by SMS to", "YOUR number. It is yours."], (384, 92))}
{card(370, 180, 280, 84, -1.2, "CLUE 2: A FRIEND'S NAME", ["Thabo's account may already", "be stolen. Phone him."], (384, 214))}
{card(370, 298, 280, 84, 0.8, "CLUE 3: THE RUSH", ["Quickly?? Locked out!!", "Fear and a hurry again."], (384, 330))}
<g transform="rotate(-6 560 420)" opacity=".88">
<rect x="470" y="400" width="180" height="40" rx="4" fill="none" stroke="{RED}" stroke-width="4"/>
<text x="560" y="429" text-anchor="middle" {BO} font-size="22" fill="{RED}">NEVER SEND</text>
</g>
</svg>
'''

# ---- Doodle: The Phisher on the phone
files['safety-phisher-phone.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{phisher(-4, 0, 1)}
<rect x="76" y="58" width="16" height="30" rx="4" fill="#1b1b1b" transform="rotate(20 84 73)"/>
<path d="M118 22 h108 a8 8 0 0 1 8 8 v50 a8 8 0 0 1 -8 8 h-80 l-14 14 v-14 h-14 a8 8 0 0 1 -8 -8 v-50 a8 8 0 0 1 8 -8 z" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="2.6"/>
<text x="124" y="44" {CV} font-size="16" fill="{INK}">Hello, KasiBank</text>
<text x="124" y="62" {CV} font-size="16" fill="{INK}">fraud department.</text>
<text x="124" y="80" {CV} font-size="16" font-weight="700" fill="{RED}">Read me the code...</text>
</svg>
'''

# ---- Doodle: a phone with No service
files['safety-no-service.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<g transform="rotate(-6 120 86)">
<rect x="76" y="12" width="88" height="150" rx="14" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3.2"/>
<rect x="84" y="26" width="72" height="116" rx="4" fill="#dfe6ee" stroke="{INK}" stroke-width="1.8"/>
<g stroke="{INK}" stroke-width="2.4"><path d="M92 40 v-4 M98 40 v-7 M104 40 v-10 M110 40 v-13"/></g>
<path d="M90 26 l24 18" stroke="{RED}" stroke-width="3"/>
<text x="120" y="82" text-anchor="middle" {BO} font-size="11" fill="{RED}">NO</text>
<text x="120" y="98" text-anchor="middle" {BO} font-size="11" fill="{RED}">SERVICE</text>
</g>
<g fill="none" stroke="{INK}" stroke-width="2.4"><path d="M44 40 q-6 10 0 18 q6 -8 0 -18 z" fill="#8fd3ff"/><path d="M196 56 q-6 10 0 18 q6 -8 0 -18 z" fill="#8fd3ff"/></g>
<text x="18" y="130" {CV} font-size="22" font-weight="700" fill="{INK}">?!</text>
</svg>
'''

# ---- Doodle: Sniff with two padlocks
files['safety-sniff-two-locks.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{sniff(-10, 14, 0.62)}
<g transform="rotate(-8 170 60)">
<path d="M150 56 v-12 a12 12 0 0 1 24 0 v12" fill="none" stroke="#9aa0aa" stroke-width="5"/>
<rect x="142" y="54" width="40" height="32" rx="5" fill="#e8c35a" stroke="{INK}" stroke-width="2.6"/>
<circle cx="162" cy="69" r="3.5" fill="{INK}"/>
</g>
<g transform="rotate(10 206 104)">
<path d="M194 102 v-12 a12 12 0 0 1 24 0 v12" fill="none" stroke="#9aa0aa" stroke-width="5"/>
<rect x="186" y="100" width="40" height="32" rx="5" fill="#e8c35a" stroke="{INK}" stroke-width="2.6"/>
<circle cx="206" cy="115" r="3.5" fill="{INK}"/>
</g>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files), 'lesson 3 files')
