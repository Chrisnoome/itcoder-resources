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


def phisher(tx, ty, s):
    return f'''<g transform="translate({tx} {ty}) scale({s})">
<path d="M14 168 q0 -70 40 -82 q40 12 40 82 z" fill="#2a2a2a"/>
<circle cx="54" cy="66" r="24" fill="#2a2a2a"/>
<ellipse cx="54" cy="46" rx="44" ry="8" fill="#1b1b1b"/>
<path d="M34 46 q4 -28 20 -28 q16 0 20 28 z" fill="#1b1b1b"/>
<ellipse cx="45" cy="68" rx="5.5" ry="3" fill="#fff"/><ellipse cx="63" cy="68" rx="5.5" ry="3" fill="#fff"/>
<path d="M44 80 q10 6 20 0" fill="none" stroke="#fff" stroke-width="2.2" stroke-linecap="round"/>
</g>'''


def folder(h, tab):
    return f'''<path d="M10 40 v-22 q0-8 8-8 h222 q7 0 10 7 l10 23 z" fill="#c99f62"/>
<rect x="10" y="36" width="660" height="{h - 44}" rx="6" fill="#d6b277"/>
<text x="26" y="30" {SE} font-size="13" fill="#3b2a14">{tab}</text>'''


def card(x, y, w, tilt, title, lines, pin=True):
    h = 30 + 17 * len(lines) + 8
    s = [f'<g transform="rotate({tilt} {x + w / 2} {y + h / 2})"><rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#f6efdc"/>',
         f'<text x="{x + 24}" y="{y + 24}" {SE} font-size="14.5" fill="{INK}">{title}</text>']
    for k, line in enumerate(lines):
        s.append(f'<text x="{x + 24}" y="{y + 44 + k * 17}" {SE} font-size="12.5" fill="{INK}">{line}</text>')
    s.append('</g>')
    if pin:
        s.append(f'<circle cx="{x + 12}" cy="{y + 18}" r="6" fill="{RED}"/>')
    return '\n'.join(s)


def string(x1, y1, x2, y2):
    mx = (x1 + x2) / 2
    return f'<path d="M{x1} {y1} Q{mx} {min(y1, y2) - 10} {x2} {y2}" fill="none" stroke="{RED}" stroke-width="2.2"/>'


def phone(x, y, w, h, tilt, header, body):
    return f'''<g transform="rotate({tilt} {x + w / 2} {y + h / 2})">
<rect x="{x - 14}" y="{y - 14}" width="{w + 28}" height="{h + 62}" fill="#fbf8f0" stroke="#bfb39c"/>
<rect x="{x}" y="{y}" width="{w}" height="{h}" fill="#2b2f36"/>
<text x="{x + 12}" y="{y + 22}" {CP} font-size="11" fill="#d7dbe2">{header}</text>
{body}
</g>'''


files = {}

# ===== Lesson 5: the torch app's permissions
perm_rows = [("Camera flash", "the light itself", True), ("Location", "always", False), ("Contacts", "read all", False),
             ("Microphone", "record audio", False), ("Photos", "all photos", False)]
rows = []
for i, (name, what, ok) in enumerate(perm_rows):
    yy = 128 + i * 40
    rows.append(f'<rect x="88" y="{yy - 18}" width="176" height="32" rx="6" fill="#e9eaee"/>')
    rows.append(f'<text x="98" y="{yy}" {CP} font-size="12" font-weight="700" fill="#1d1f24">{name}</text>')
    rows.append(f'<text x="98" y="{yy + 11}" {CP} font-size="9.5" fill="#555">{what}</text>')
    rows.append(f'<rect x="226" y="{yy - 10}" width="30" height="16" rx="8" fill="{GREEN if ok else RED}"/>')
body = chr(10).join(rows)
files['safety-permissions.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 430" width="680" height="430">
{folder(430, "CASE 05 · THE NOSY TORCH")}
{phone(80, 70, 196, 248, -2, "SuperTorch (free) wants:", body)}
<text x="76" y="378" {CV} font-size="20" fill="#3b3326" transform="rotate(-2 180 370)">Exhibit A · a free torch app</text>
{string(392, 82, 262, 168)}
{string(392, 196, 262, 210)}
{string(392, 312, 262, 290)}
{card(380, 64, 270, 1.2, "CLUE 1: WHAT IS IT FOR?", ["A torch needs the flash.", "Nothing else."])}
{card(380, 178, 270, -1.2, "CLUE 2: LOCATION, ALWAYS", ["Where you live, sleep and", "go to school - all day."])}
{card(380, 294, 270, 0.8, "CLUE 3: IT'S FREE", ["So who pays? Whoever buys", "what it collects."])}
</svg>
'''

files['safety-free-cheese.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<rect x="30" y="112" width="180" height="22" rx="3" fill="#c98b4f" stroke="{INK}" stroke-width="3"/>
<path d="M60 112 v-46 a40 40 0 0 1 80 0 v46" fill="none" stroke="#9aa0aa" stroke-width="5"/>
<path d="M130 112 l40 -30" stroke="#9aa0aa" stroke-width="4"/>
<path d="M86 112 l40 -34 l30 34 z" fill="#ffd94d" stroke="{INK}" stroke-width="3"/>
<g fill="#e8b830"><circle cx="112" cy="100" r="4"/><circle cx="128" cy="104" r="3"/><circle cx="120" cy="92" r="2.5"/></g>
<g transform="rotate(-8 92 52)"><rect x="54" y="36" width="78" height="28" fill="#fff" stroke="{INK}" stroke-width="2.4"/>
<text x="93" y="56" text-anchor="middle" {BO} font-size="14" fill="{RED}">FREE APP</text></g>
</svg>
'''

files['safety-location-trail.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<path d="M20 150 Q70 120 90 136 T160 100 T220 40" fill="none" stroke="{INK}" stroke-width="2.4" stroke-dasharray="6 6"/>
<g fill="{RED}" stroke="{INK}" stroke-width="2.2">
<path d="M40 136 c-10 -14 -10 -26 0 -30 c10 4 10 16 0 30 z"/><path d="M110 120 c-10 -14 -10 -26 0 -30 c10 4 10 16 0 30 z"/>
<path d="M170 86 c-10 -14 -10 -26 0 -30 c10 4 10 16 0 30 z"/></g>
<g {CV} font-size="15" fill="{INK}"><text x="20" y="100">home</text><text x="90" y="84">school</text><text x="150" y="50">gran</text></g>
<g stroke="{INK}" stroke-width="3" fill="none"><circle cx="214" cy="30" r="8" style="fill: var(--doodle-paper, #fff)"/><path d="M214 38 v24 M214 46 l-10 8 M214 46 l10 8 M214 62 l-8 14 M214 62 l8 14"/></g>
</svg>
'''

# ===== Lesson 6: the photo that travelled
nodes = [(70, 120, "You", "1 friend"), (210, 120, "Friend", "screenshot"), (350, 120, "Group", "40 people"), (490, 120, "Shared", "?? people")]
travel = []
for i, (x, y, name, note) in enumerate(nodes):
    travel.append(f'<g transform="rotate({(-2, 1.5, -1, 2)[i]} {x + 50} {y + 50})"><rect x="{x}" y="{y}" width="100" height="112" fill="#fbf8f0" stroke="#bfb39c"/>'
                  f'<rect x="{x + 10}" y="{y + 10}" width="80" height="62" fill="#9fc3d6"/>'
                  f'<circle cx="{x + 50}" cy="{y + 36}" r="12" fill="#e0b07c" stroke="{INK}" stroke-width="2"/>'
                  f'<path d="M{x + 30} {y + 72} q20 -24 40 0" fill="#3a6ea5" stroke="{INK}" stroke-width="2"/>'
                  f'<text x="{x + 50}" y="{y + 92}" text-anchor="middle" {SE} font-size="13" fill="{INK}">{name}</text>'
                  f'<text x="{x + 50}" y="{y + 106}" text-anchor="middle" {CV} font-size="15" fill="{RED}">{note}</text></g>')
    if i < 3:
        travel.append(f'<path d="M{x + 104} {y + 50} h32" stroke="{RED}" stroke-width="3"/><path d="M{x + 128} {y + 42} l10 8 l-10 8" fill="none" stroke="{RED}" stroke-width="3"/>')
files['safety-photo-travel.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 430" width="680" height="430">
{folder(430, "CASE 06 · THE PHOTO THAT TRAVELLED")}
<text x="40" y="92" {CV} font-size="21" fill="#3b3326">Exhibit A · one photo, sent once, on a Friday night</text>
{chr(10).join(travel)}
{card(40, 286, 290, -1, "CLUE 1: DELETE DOESN'T REACH", ["Deleting your copy can't touch", "the screenshots and forwards."])}
{card(360, 286, 290, 1, "CLUE 2: THE PHOTO KNOWS", ["A photo file can hold where and", "when it was taken - its metadata."])}
<g transform="rotate(-8 560 404)" opacity=".88"><rect x="470" y="388" width="180" height="34" rx="4" fill="none" stroke="{RED}" stroke-width="4"/>
<text x="560" y="412" text-anchor="middle" {BO} font-size="18" fill="{RED}">CAN'T UNSEND</text></g>
</svg>
'''

files['safety-footprints.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<g fill="{INK}">
<ellipse cx="30" cy="150" rx="9" ry="14" transform="rotate(-20 30 150)"/><ellipse cx="70" cy="128" rx="9" ry="14" transform="rotate(20 70 128)"/>
<ellipse cx="104" cy="104" rx="9" ry="14" transform="rotate(-20 104 104)"/><ellipse cx="146" cy="82" rx="9" ry="14" transform="rotate(20 146 82)"/>
<ellipse cx="180" cy="56" rx="9" ry="14" transform="rotate(-20 180 56)"/></g>
<g {CV} font-size="15" fill="{RED}"><text x="44" y="164">like</text><text x="84" y="142">post</text><text x="118" y="118">tag</text><text x="160" y="98">pic</text><text x="194" y="70">comment</text></g>
<text x="200" y="26" {CV} font-size="20" font-weight="700" fill="{INK}">...forever</text>
</svg>
'''

files['safety-sniff-camera.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{sniff(-10, 18, 0.62)}
<rect x="136" y="52" width="92" height="62" rx="8" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3"/>
<rect x="152" y="42" width="26" height="12" rx="3" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="2.6"/>
<circle cx="182" cy="83" r="20" fill="#9fc3d6" stroke="{INK}" stroke-width="3"/><circle cx="182" cy="83" r="8" fill="{INK}"/>
<text x="150" y="140" {CV} font-size="16" fill="{RED}">think, then click</text>
</svg>
'''

# ===== Lesson 7: the fake profile
profile = f'''<g transform="rotate(-2 180 220)">
<rect x="56" y="58" width="250" height="300" fill="#fbf8f0" stroke="#bfb39c"/>
<rect x="72" y="74" width="218" height="232" fill="#ffffff" stroke="#d8d3c6"/>
<circle cx="118" cy="122" r="30" fill="#9fc3d6" stroke="{INK}" stroke-width="2"/>
<circle cx="118" cy="114" r="11" fill="#e0b07c" stroke="{INK}" stroke-width="2"/><path d="M98 146 q20 -26 40 0" fill="#3a6ea5" stroke="{INK}" stroke-width="2"/>
<text x="160" y="112" {CP} font-size="13" font-weight="700" fill="#1d1f24">Kayla, 14</text>
<text x="160" y="130" {CP} font-size="11" fill="#555">Joined 3 days ago</text>
<text x="160" y="146" {CP} font-size="11" fill="#555">2 posts · 0 mutuals</text>
<rect x="84" y="166" width="194" height="70" rx="8" fill="#e9eaee"/>
<g {CP} font-size="11" fill="#1d1f24"><text x="92" y="184">u r so mature for ur age</text><text x="92" y="200">lets chat on Snapgram, its</text><text x="92" y="216">more private. dont tell ur</text><text x="92" y="232">mom, she wont get it x</text></g>
<rect x="84" y="250" width="194" height="40" rx="8" fill="#e9eaee"/>
<g {CP} font-size="11" fill="#1d1f24"><text x="92" y="268">I can get u free airtime</text><text x="92" y="283">if u send a pic :)</text></g>
<text x="66" y="340" {CV} font-size="20" fill="#3b3326">Exhibit A · a new "friend"</text>
</g>'''
files['safety-fake-profile.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 430" width="680" height="430">
{folder(430, "CASE 07 · THE FAKE FRIEND")}
{string(370, 76, 270, 128)}
{string(370, 176, 240, 196)}
{string(370, 268, 230, 222)}
{string(370, 356, 250, 276)}
{profile}
{card(358, 58, 292, 1.2, "CLUE 1: A BRAND-NEW PROFILE", ["Days old, two posts, no friends", "in common. The photo may be stolen."])}
{card(358, 158, 292, -1, "CLUE 2: TOO MUCH, TOO FAST", ["Compliments, &quot;so mature&quot; -", "flattery to build trust quickly."])}
{card(358, 250, 292, 1, "CLUE 3: SECRETS", ["&quot;Somewhere private.&quot; &quot;Don't tell", "your mom.&quot; The biggest red flag."])}
{card(358, 340, 292, -0.8, "CLUE 4: GIFTS FOR PICTURES", ["Airtime, data, money - in", "exchange for a photo. Never."])}
</svg>
'''

files['safety-phisher-mask.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{phisher(0, 0, 1)}
<line x1="96" y1="120" x2="130" y2="94" stroke="#1b1b1b" stroke-width="6"/>
<ellipse cx="168" cy="72" rx="44" ry="52" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3"/>
<circle cx="152" cy="62" r="5" fill="{INK}"/><circle cx="184" cy="62" r="5" fill="{INK}"/>
<path d="M146 88 q22 20 44 0" fill="none" stroke="{INK}" stroke-width="3"/>
<path d="M140 52 q12 -8 20 0 M176 52 q12 -8 20 0" fill="none" stroke="{INK}" stroke-width="2.4"/>
<text x="168" y="152" text-anchor="middle" {CV} font-size="17" fill="{RED}">"hi, I'm 14 too!"</text>
</svg>
'''

files['safety-sniff-tell.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{sniff(-12, 22, 0.6)}
<path d="M128 18 h100 a8 8 0 0 1 8 8 v58 a8 8 0 0 1 -8 8 h-70 l-16 16 v-16 h-14 a8 8 0 0 1 -8 -8 v-58 a8 8 0 0 1 8 -8 z" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="2.6"/>
<text x="178" y="44" text-anchor="middle" {CV} font-size="17" fill="{INK}">Tell someone</text>
<text x="178" y="64" text-anchor="middle" {CV} font-size="17" fill="{INK}">you trust.</text>
<text x="178" y="84" text-anchor="middle" {CV} font-size="17" font-weight="700" fill="{RED}">Today.</text>
</svg>
'''

# ===== Lesson 8: the case wall
ex = [(40, 64, "EXHIBIT A", ["An SMS: \"KasiBank:", "verify your card\""]), (250, 64, "EXHIBIT B", ["A login page at", "kasibank.co.za.web.net"]),
      (460, 64, "EXHIBIT C", ["A quiz app that wants", "contacts + location"]), (40, 230, "EXHIBIT D", ["A friend request:", "new profile, 0 mutuals"])]
exs = []
for i, (x, y, t, lines) in enumerate(ex):
    exs.append(card(x, y, 180, (-1.5, 1, -1, 1.5)[i], t, [l.replace('"', '&quot;') for l in lines]))
files['safety-case-wall.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 430" width="680" height="430">
{folder(430, "CASE 08 · THE BIG CASE")}
{string(140, 110, 300, 260)}
{string(340, 110, 330, 286)}
{string(550, 110, 360, 312)}
{string(130, 270, 290, 338)}
{chr(10).join(exs)}
<g transform="rotate(0.8 470 310)"><rect x="250" y="200" width="400" height="200" fill="#fbf8f0" stroke="#bfb39c"/>
<text x="268" y="230" {SE} font-size="18" fill="{INK}">FINDINGS FORM</text>
<line x1="268" y1="240" x2="632" y2="240" stroke="{INK}" stroke-width="2"/>
<g {SE} font-size="13" fill="{INK}"><text x="268" y="264">1. Sender / who</text><text x="268" y="290">2. Tone</text><text x="268" y="316">3. Link / address</text><text x="268" y="342">4. What does it ask for?</text><text x="268" y="380">VERDICT:</text></g>
<g fill="{RED}"><rect x="606" y="252" width="16" height="16"/><rect x="606" y="278" width="16" height="16"/><rect x="606" y="304" width="16" height="16"/><rect x="606" y="330" width="16" height="16"/></g>
<text x="350" y="382" {CV} font-size="21" fill="{RED}">?</text></g>
<g fill="{RED}"><circle cx="300" cy="260" r="5"/><circle cx="330" cy="286" r="5"/><circle cx="360" cy="312" r="5"/><circle cx="290" cy="338" r="5"/></g>
</svg>
'''

files['safety-phisher-caught.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{phisher(60, 0, 1)}
<g stroke="{INK}" stroke-width="5"><path d="M60 10 v156 M92 10 v156 M124 10 v156 M156 10 v156 M188 10 v156"/></g>
<rect x="52" y="6" width="144" height="10" fill="{INK}"/><rect x="52" y="160" width="144" height="10" fill="{INK}"/>
<text x="206" y="94" {CV} font-size="17" font-weight="700" fill="{RED}">case</text><text x="206" y="112" {CV} font-size="17" font-weight="700" fill="{RED}">closed</text>
</svg>
'''

files['safety-sniff-badge.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
{sniff(-8, 14, 0.62)}
<path d="M178 40 l12 24 l26 4 l-19 18 l5 26 l-24 -12 l-24 12 l5 -26 l-19 -18 l26 -4 z" fill="#e8c35a" stroke="{INK}" stroke-width="3"/>
<text x="178" y="88" text-anchor="middle" {BO} font-size="10" fill="{INK}">DETECTIVE</text>
<text x="160" y="146" {CV} font-size="16" fill="{INK}">You earned it.</text>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files), 'files')
