import os, sys
out = sys.argv[1]
SE = "font-family=\"'Special Elite', 'Courier New', monospace\""
CP = "font-family=\"'Courier Prime', 'Courier New', monospace\""
CV = "font-family=\"Caveat, 'Comic Sans MS', cursive\""
BO = "font-family=\"'Black Ops One', Impact, sans-serif\""
INK = "#2a2116"
RED = "#b3141c"
files = {}


def folder(h, tab):
    return f'''<path d="M10 40 v-22 q0-8 8-8 h222 q7 0 10 7 l10 23 z" fill="#c99f62"/>
<rect x="10" y="36" width="660" height="{h - 44}" rx="6" fill="#d6b277"/>
<text x="26" y="30" {SE} font-size="13" fill="#3b2a14">{tab}</text>'''


# ---- Figure: the scam SMS on the incident board
files['safety-case01-sms.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" width="680" height="420">
{folder(420, "CASE 01 · THE LOCKED ACCOUNT")}
<g transform="rotate(-3 175 220)">
<rect x="60" y="62" width="230" height="318" fill="#fbf8f0" stroke="#bfb39c"/>
<rect x="75" y="77" width="200" height="248" fill="#2b2f36"/>
<text x="90" y="100" {CP} font-size="11" fill="#d7dbe2">+27 63 555 0192</text>
<rect x="88" y="112" width="178" height="124" rx="10" fill="#e9eaee"/>
<g {CP} font-size="11.5" fill="#1d1f24">
<text x="96" y="132">KasiBank: Your account</text>
<text x="96" y="149">has been LOCKED.</text>
<text x="96" y="166">Verify within 24 hrs</text>
<text x="96" y="183">or lose access:</text>
<text x="96" y="210" fill="#1f5fd1" text-decoration="underline">kasibank-verify.co/login</text>
</g>
<text x="80" y="356" {CV} font-size="20" fill="#3b3326">Exhibit A · received 07:42</text>
<circle cx="175" cy="68" r="7" fill="{RED}"/>
</g>
<g fill="none" stroke="{RED}" stroke-width="2.2">
<path d="M422 82 Q300 60 190 100"/><path d="M422 190 Q300 170 168 150"/><path d="M422 296 Q320 300 230 214"/>
</g>
<g {SE} fill="{INK}">
<g transform="rotate(1.5 525 100)"><rect x="410" y="62" width="235" height="76" fill="#f6efdc"/>
<text x="430" y="86" font-size="15">CLUE 1: WHO SENT IT?</text>
<text x="430" y="106" font-size="12.5">A cell number, not</text>
<text x="430" y="122" font-size="12.5">the bank's short code.</text></g>
<g transform="rotate(-1.5 525 205)"><rect x="410" y="168" width="235" height="76" fill="#f6efdc"/>
<text x="430" y="192" font-size="15">CLUE 2: THE RUSH</text>
<text x="430" y="212" font-size="12.5">Locked! 24 hours! The</text>
<text x="430" y="228" font-size="12.5">rush stops you checking.</text></g>
<g transform="rotate(1 525 310)"><rect x="410" y="274" width="235" height="76" fill="#f6efdc"/>
<text x="430" y="298" font-size="15">CLUE 3: THE ADDRESS</text>
<text x="430" y="318" font-size="12.5">kasibank-verify.co is</text>
<text x="430" y="334" font-size="12.5">not kasibank.co.za</text></g>
</g>
<g fill="{RED}"><circle cx="422" cy="80" r="6"/><circle cx="422" cy="188" r="6"/><circle cx="422" cy="294" r="6"/></g>
<g transform="rotate(-10 560 382)" opacity=".88">
<rect x="478" y="358" width="164" height="48" rx="4" fill="none" stroke="{RED}" stroke-width="4"/>
<text x="560" y="394" text-anchor="middle" {BO} font-size="30" fill="{RED}">SUSPECT</text>
</g>
</svg>
'''


# ---- Figure: who owns the address
def addr(y, tilt, label, pre, owner, post, cx, rx, ring):
    return f'''<g transform="rotate({tilt} 340 {y + 50})">
<rect x="40" y="{y}" width="600" height="104" fill="#fbf8f0" stroke="#bfb39c"/>
<text x="58" y="{y + 26}" {CV} font-size="20" fill="#3b3326">{label}</text>
<rect x="56" y="{y + 38}" width="568" height="40" rx="20" fill="#eceef2" stroke="#9aa0aa"/>
<ellipse cx="{cx}" cy="{y + 58}" rx="{rx}" ry="19" fill="none" stroke="{ring}" stroke-width="3"/>
<text x="78" y="{y + 64}" {CP} font-size="18" fill="#6a6f78">{pre}<tspan fill="#1d1f24" font-weight="700">{owner}</tspan>{post}</text>
</g>'''


files['safety-address-parts.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 400" width="680" height="400">
{folder(400, "CASE 01 · WHO OWNS THE ADDRESS?")}
{addr(56, -1, "Exhibit B · the real bank", "https://www.", "kasibank.co.za", "/login", 284, 92, "#1f7a3a")}
{addr(192, 1, "Exhibit C · the link in the SMS", "https://", "kasibank-verify.co", "/login", 261, 112, RED)}
<g transform="rotate(-1.5 520 346)"><rect x="372" y="312" width="280" height="66" fill="#f6efdc"/>
<text x="388" y="338" {SE} font-size="14" fill="{INK}">CLUE: THE OWNER'S NAME ENDS</text>
<text x="388" y="360" {SE} font-size="14" fill="{INK}">RIGHT BEFORE THE FIRST /</text></g>
<path d="M386 316 Q330 300 300 272" fill="none" stroke="{RED}" stroke-width="2.2"/>
<circle cx="386" cy="316" r="6" fill="{RED}"/>
<g transform="rotate(-8 165 348)" opacity=".88">
<rect x="56" y="324" width="218" height="46" rx="4" fill="none" stroke="{RED}" stroke-width="4"/>
<text x="165" y="357" text-anchor="middle" {BO} font-size="25" fill="{RED}">NOT THE BANK</text>
</g>
</svg>
'''

# ---- Figure: the findings form
files['safety-findings-form.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 400" width="680" height="400">
{folder(400, "CASE 01 · FINDINGS")}
<g transform="rotate(-0.8 340 210)">
<rect x="44" y="58" width="592" height="300" fill="#fbf8f0" stroke="#bfb39c"/>
<text x="66" y="92" {SE} font-size="22" fill="{INK}">FINDINGS FORM</text>
<text x="614" y="92" text-anchor="end" {SE} font-size="13" fill="#6b5a40">EXHIBIT A</text>
<g stroke="{INK}"><line x1="66" y1="104" x2="614" y2="104" stroke-width="2"/>
<line x1="66" y1="140" x2="614" y2="140" stroke-opacity=".5"/><line x1="66" y1="186" x2="614" y2="186" stroke-opacity=".25"/>
<line x1="66" y1="232" x2="614" y2="232" stroke-opacity=".25"/><line x1="66" y1="278" x2="614" y2="278" stroke-opacity=".5"/></g>
<g {SE} font-size="14" fill="{INK}"><text x="66" y="128">CHECK</text><text x="196" y="128">WHAT WE FOUND</text><text x="614" y="128" text-anchor="end">FLAG</text></g>
<g {SE} font-size="16" fill="{INK}"><text x="66" y="169">1. Sender</text><text x="66" y="215">2. Tone</text><text x="66" y="261">3. Link</text></g>
<g {CV} font-size="21" fill="#23345a"><text x="196" y="170">a cell number, not a short code</text>
<text x="196" y="216">LOCKED! 24 hours! - a threat and a deadline</text><text x="196" y="262">kasibank-verify.co - a look-alike</text></g>
<g fill="{RED}"><rect x="588" y="152" width="24" height="24"/><rect x="588" y="198" width="24" height="24"/><rect x="588" y="244" width="24" height="24"/></g>
<g stroke="#fbf8f0" stroke-width="3.2" stroke-linecap="round"><path d="M593 157 l14 14 M607 157 l-14 14"/><path d="M593 203 l14 14 M607 203 l-14 14"/><path d="M593 249 l14 14 M607 249 l-14 14"/></g>
<text x="66" y="314" {SE} font-size="16" fill="{INK}">VERDICT:</text>
<text x="156" y="316" {CV} font-size="24" font-weight="700" fill="{RED}">scam - don't click, don't reply</text>
</g>
<g transform="rotate(-9 548 352)" opacity=".88">
<rect x="456" y="326" width="186" height="52" rx="4" fill="none" stroke="{RED}" stroke-width="4"/>
<text x="549" y="350" text-anchor="middle" {BO} font-size="18" fill="{RED}">3 OF 3 RED FLAGS</text>
<text x="549" y="370" text-anchor="middle" {SE} font-size="13" fill="{RED}">VERDICT: SCAM</text>
</g>
</svg>
'''


# ---- Sniff's head (the board's drawing), in a 240 x 240 box, placed and scaled
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


files['safety-sniff-sniffing.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<g transform="rotate(-4 176 128)">
<rect x="128" y="98" width="96" height="62" rx="3" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3"/>
<path d="M128 100 l48 32 l48 -32" fill="none" stroke="{INK}" stroke-width="3" stroke-linejoin="round"/>
<text x="176" y="152" text-anchor="middle" {BO} font-size="12" fill="{RED}">URGENT!!</text>
</g>
<g fill="none" stroke="{INK}" stroke-width="2.6" stroke-linecap="round">
<path d="M156 88 q-8 -10 2 -18 q10 -8 2 -18"/><path d="M178 84 q-8 -10 2 -18 q10 -8 2 -18"/><path d="M200 88 q-8 -10 2 -18 q10 -8 2 -18"/>
</g>
{sniff(-6, 4, 0.66)}
</svg>
'''

files['safety-phisher-bait.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<g stroke-linecap="round" stroke-linejoin="round">
<path d="M90 64 Q150 24 196 14" fill="none" stroke="{INK}" stroke-width="4"/>
<path d="M196 14 v72" stroke="{INK}" stroke-width="1.6"/>
<path d="M196 86 q0 12 -10 10" fill="none" stroke="{INK}" stroke-width="3"/>
<path d="M150 96 h80 a8 8 0 0 1 8 8 v26 a8 8 0 0 1 -8 8 h-56 l-12 12 v-12 h-12 a8 8 0 0 1 -8 -8 v-26 a8 8 0 0 1 8 -8 z" style="fill: var(--doodle-paper, #fff)" stroke="{INK}" stroke-width="3"/>
<text x="190" y="116" text-anchor="middle" {BO} font-size="12" fill="{RED}">YOU WON</text>
<text x="190" y="132" text-anchor="middle" {BO} font-size="12" fill="{RED}">R10 000!</text>
<path d="M14 168 q0 -70 40 -82 q40 12 40 82 z" fill="#2a2a2a"/>
<circle cx="54" cy="66" r="24" fill="#2a2a2a"/>
<ellipse cx="54" cy="46" rx="44" ry="8" fill="#1b1b1b"/>
<path d="M34 46 q4 -28 20 -28 q16 0 20 28 z" fill="#1b1b1b"/>
<ellipse cx="45" cy="68" rx="5.5" ry="3" fill="#fff"/><ellipse cx="63" cy="68" rx="5.5" ry="3" fill="#fff"/>
<path d="M44 80 q10 6 20 0" fill="none" stroke="#fff" stroke-width="2.2"/>
<line x1="90" y1="64" x2="80" y2="124" stroke="#1b1b1b" stroke-width="5"/>
</g>
</svg>
'''

files['safety-clock-panic.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">
<g stroke="{INK}" stroke-width="3.2">
<path d="M76 46 l-16 -16 M144 46 l16 -16" fill="none"/>
<circle cx="58" cy="26" r="16" fill="{RED}"/><circle cx="162" cy="26" r="16" fill="{RED}"/>
<path d="M80 150 l-10 14 M140 150 l10 14" fill="none"/>
<circle cx="110" cy="96" r="58" style="fill: var(--doodle-paper, #fff)"/>
<path d="M110 96 v-34 M110 96 l22 12" fill="none" stroke-width="4"/>
<circle cx="110" cy="96" r="4" fill="{INK}"/>
</g>
<g fill="none" stroke="{INK}" stroke-width="2.4"><path d="M34 62 l-14 -6 M30 92 h-16 M34 120 l-14 8 M186 62 l14 -6 M190 92 h16 M186 120 l14 8"/></g>
<text x="110" y="136" text-anchor="middle" {BO} font-size="13" fill="{RED}">24 HRS!!!</text>
</svg>
'''

files['safety-sniff-pointing.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<g transform="rotate(3 178 60)">
<rect x="122" y="22" width="112" height="76" fill="#f6efdc" stroke="{INK}" stroke-width="2.4"/>
<text x="178" y="54" text-anchor="middle" {CP} font-size="18" font-weight="700" fill="{RED}">.co</text>
<path d="M150 66 h56" stroke="{INK}" stroke-width="1.5" stroke-dasharray="3 4"/>
<text x="178" y="88" text-anchor="middle" {CP} font-size="18" font-weight="700" fill="#1f7a3a">.co.za</text>
<circle cx="178" cy="26" r="5" fill="{RED}"/>
</g>
{sniff(-4, 28, 0.58)}
</svg>
'''

files['safety-sniff-cleared.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
{sniff(-10, 8, 0.64)}
<g transform="rotate(-10 182 92)">
<rect x="132" y="72" width="100" height="40" rx="4" style="fill: var(--doodle-paper, #fff)" stroke="#1f7a3a" stroke-width="4"/>
<text x="182" y="100" text-anchor="middle" {BO} font-size="19" fill="#1f7a3a">CLEARED</text>
</g>
<g fill="none" stroke="{INK}" stroke-width="2.4" stroke-linecap="round"><path d="M180 44 l4 -12 M198 50 l10 -8 M162 44 l-2 -12"/></g>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files), 'files')
