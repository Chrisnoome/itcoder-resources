"""Margin doodles for the online safety course, batch 2 (Chris, 10 October 2026:
"don't forget sidebar images, asides and factoids / jokes").

Same case-file style as safety_art2.py / safety_art58.py (brand/safety-art-style.md):
Sniff the bloodhound and The Phisher, ink #2a2116, red #b3141c, Caveat for
handwriting, Special Elite typed, Courier Prime for screen text, Black Ops One
stamps. Every doodle is 240 x 170; shapes in front are backed with
var(--doodle-paper) so nothing shows through.

Run:  python safety_art_margin.py "D:/DB Sync/Dropbox/Projects/AIPascalCourse/public/assets/doodles"
"""
import os, sys

out = sys.argv[1]
SE = "font-family=\"'Special Elite', 'Courier New', monospace\""
CP = "font-family=\"'Courier Prime', 'Courier New', monospace\""
CV = "font-family=\"Caveat, 'Comic Sans MS', cursive\""
BO = "font-family=\"'Black Ops One', Impact, sans-serif\""
INK, RED, GOLD = "#2a2116", "#b3141c", "#e8c35a"
PAPER = 'style="fill: var(--doodle-paper, #fff)"'
HEAD = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170" stroke-linecap="round" stroke-linejoin="round">'


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
<circle cx="120" cy="204" r="11" fill="{GOLD}" stroke-width="4"/>
</g>'''


def phisher(tx, ty, s, eyes='slit'):
    if eyes == 'round':
        face = ('<circle cx="45" cy="67" r="5" fill="#fff"/><circle cx="63" cy="67" r="5" fill="#fff"/>'
                '<ellipse cx="54" cy="84" rx="5" ry="6" fill="#fff"/>')
    else:
        face = ('<ellipse cx="45" cy="68" rx="5.5" ry="3" fill="#fff"/><ellipse cx="63" cy="68" rx="5.5" ry="3" fill="#fff"/>'
                '<path d="M44 80 q10 6 20 0" fill="none" stroke="#fff" stroke-width="2.2" stroke-linecap="round"/>')
    return f'''<g transform="translate({tx} {ty}) scale({s})">
<path d="M14 168 q0 -70 40 -82 q40 12 40 82 z" fill="#2a2a2a"/>
<circle cx="54" cy="66" r="24" fill="#2a2a2a"/>
<ellipse cx="54" cy="46" rx="44" ry="8" fill="#1b1b1b"/>
<path d="M34 46 q4 -28 20 -28 q16 0 20 28 z" fill="#1b1b1b"/>
{face}
</g>'''


files = {}

# ---------------------------------------------------------------- phishing --
# The Phisher holding up a name tag, with more tags behind it
files['safety-phisher-nametag.svg'] = f'''{HEAD}
{phisher(-4, 0, 1)}
<line x1="88" y1="122" x2="122" y2="100" stroke="#1b1b1b" stroke-width="6"/>
<g transform="rotate(-10 180 70)"><rect x="128" y="34" width="96" height="62" rx="6" {PAPER} stroke="{INK}" stroke-width="2.4"/>
<text x="176" y="80" text-anchor="middle" {CV} font-size="18" fill="{INK}">Mom</text></g>
<g transform="rotate(6 180 70)"><rect x="128" y="34" width="96" height="62" rx="6" {PAPER} stroke="{INK}" stroke-width="2.4"/>
<text x="176" y="80" text-anchor="middle" {CV} font-size="18" fill="{INK}">ShopNow</text></g>
<rect x="118" y="62" width="110" height="74" rx="6" {PAPER} stroke="{INK}" stroke-width="2.6"/>
<path d="M118 84 v-16 a6 6 0 0 1 6 -6 h98 a6 6 0 0 1 6 6 v16 z" fill="{RED}"/>
<text x="173" y="80" text-anchor="middle" {BO} font-size="13" fill="#fff">HELLO</text>
<text x="173" y="98" text-anchor="middle" {SE} font-size="10" fill="{INK}">my name is</text>
<text x="173" y="124" text-anchor="middle" {CV} font-size="24" font-weight="700" fill="{INK}">KasiBank</text>
</svg>
'''

# The Phisher with an empty hook and an empty bucket
files['safety-phisher-empty-bucket.svg'] = f'''{HEAD}
{phisher(-4, 0, 1)}
<path d="M88 64 Q140 26 180 18" fill="none" stroke="{INK}" stroke-width="4"/>
<path d="M180 18 v50" stroke="{INK}" stroke-width="1.6"/>
<path d="M180 68 q0 12 -10 10" fill="none" stroke="{INK}" stroke-width="3"/>
<line x1="88" y1="64" x2="78" y2="124" stroke="#1b1b1b" stroke-width="5"/>
<path d="M144 104 h76 l-8 56 h-60 z" {PAPER} stroke="{INK}" stroke-width="3"/>
<ellipse cx="182" cy="104" rx="38" ry="7" fill="#e7e1d2" stroke="{INK}" stroke-width="2.6"/>
<text x="182" y="128" text-anchor="middle" {SE} font-size="10" fill="{INK}">TODAY'S</text>
<text x="182" y="141" text-anchor="middle" {SE} font-size="10" fill="{INK}">CATCH</text>
<text x="182" y="156" text-anchor="middle" {BO} font-size="12" fill="{RED}">0</text>
<path d="M206 88 q4 -6 8 0 q4 -6 8 0" fill="none" stroke="{INK}" stroke-width="1.6"/>
<circle cx="214" cy="90" r="2" fill="{INK}"/>
</svg>
'''

# ---------------------------------------------------------------- passwords --
# The Phisher waiting beside a giant hourglass, with a cobweb on his hat
files['safety-phisher-hourglass.svg'] = f'''{HEAD}
{phisher(0, 0, 1)}
<path d="M10 46 l26 -14 M10 46 l18 4 M10 46 l12 14 M16 43 q4 4 1 9 M22 40 q6 6 2 14" fill="none" stroke="#9a9a9a" stroke-width="1.2"/>
<rect x="132" y="14" width="80" height="10" rx="3" fill="#8a5a2e" stroke="{INK}" stroke-width="2.4"/>
<rect x="132" y="138" width="80" height="10" rx="3" fill="#8a5a2e" stroke="{INK}" stroke-width="2.4"/>
<path d="M142 24 q0 40 28 57 q-28 17 -28 57 h60 q0 -40 -28 -57 q28 -17 28 -57 z" {PAPER} stroke="{INK}" stroke-width="2.6"/>
<path d="M150 30 h44 q-4 22 -22 34 q-18 -12 -22 -34 z" fill="{GOLD}"/>
<path d="M172 86 v40" stroke="{GOLD}" stroke-width="2" stroke-dasharray="2 4"/>
<path d="M162 136 q10 -6 20 0 z" fill="{GOLD}"/>
<text x="172" y="164" text-anchor="middle" {SE} font-size="11" fill="{INK}">10 000 YEARS</text>
</svg>
'''

# --------------------------------------------------------------- secondlock --
# Sniff beside a login prompt, with the No button ringed
files['safety-sniff-tap-no.svg'] = f'''{HEAD}
{sniff(-14, 26, 0.6)}
<rect x="118" y="8" width="104" height="156" rx="12" fill="#3b3f44" stroke="{INK}" stroke-width="3"/>
<rect x="126" y="22" width="88" height="128" rx="4" {PAPER} stroke="{INK}" stroke-width="1.6"/>
<text x="170" y="48" text-anchor="middle" {CP} font-size="11" fill="{INK}">Is this you</text>
<text x="170" y="62" text-anchor="middle" {CP} font-size="11" fill="{INK}">trying to</text>
<text x="170" y="76" text-anchor="middle" {CP} font-size="11" fill="{INK}">log in?</text>
<rect x="134" y="94" width="72" height="18" rx="9" fill="#e3e3e3" stroke="{INK}" stroke-width="1.4"/>
<text x="170" y="107" text-anchor="middle" {CP} font-size="11" fill="#777">Yes</text>
<rect x="134" y="120" width="72" height="18" rx="9" fill="{RED}" stroke="{INK}" stroke-width="1.4"/>
<text x="170" y="133" text-anchor="middle" {CP} font-size="11" font-weight="700" fill="#fff">No</text>
<ellipse cx="170" cy="129" rx="46" ry="16" fill="none" stroke="{RED}" stroke-width="2.2" transform="rotate(-4 170 129)"/>
</svg>
'''

# Sniff holding a key in his mouth
files['safety-sniff-key.svg'] = f'''{HEAD}
{sniff(42, 8, 0.66)}
<g stroke="{INK}" stroke-width="3">
<path d="M70 118 h96" fill="none"/>
<path d="M78 118 v10 M88 118 v7" fill="none"/>
<circle cx="182" cy="118" r="15" fill="{GOLD}"/>
<circle cx="182" cy="118" r="5" {PAPER}/>
</g>
<text x="40" y="40" {CV} font-size="18" fill="{RED}">mine.</text>
</svg>
'''

# Gran's biscuit tin, holding the backup codes
files['safety-biscuit-tin.svg'] = f'''{HEAD}
<g transform="rotate(-8 150 40)">
<rect x="106" y="6" width="98" height="62" fill="#fbf8f0" stroke="{INK}" stroke-width="2.2"/>
<text x="114" y="24" {SE} font-size="10" fill="{INK}">BACKUP CODES</text>
<g {CP} font-size="11" fill="{INK}"><text x="116" y="42">4821 9930</text><text x="116" y="58">7713 0264</text></g>
</g>
<path d="M40 82 v54 q0 18 80 18 q80 0 80 -18 v-54 z" fill="#1d4e89" stroke="{INK}" stroke-width="3"/>
<ellipse cx="120" cy="82" rx="80" ry="18" fill="#2a64a8" stroke="{INK}" stroke-width="3"/>
<path d="M44 122 q76 18 152 0" fill="none" stroke="{GOLD}" stroke-width="3"/>
<text x="120" y="142" text-anchor="middle" {CV} font-size="18" font-weight="700" fill="#fff">butter biscuits</text>
<g transform="rotate(-24 60 58)"><ellipse cx="60" cy="58" rx="58" ry="14" fill="#2a64a8" stroke="{INK}" stroke-width="3"/></g>
<circle cx="200" cy="40" r="7" fill="#d84a8a" stroke="{INK}" stroke-width="2"/>
<path d="M200 47 q6 20 -4 34" fill="none" stroke="#d84a8a" stroke-width="2"/>
<path d="M214 30 l12 -12" stroke="#9a9a9a" stroke-width="2.4"/>
</svg>
'''

# --------------------------------------------------------------------- leak --
# The Phisher with a spear aimed at one fish with a name tag
files['safety-phisher-spear.svg'] = f'''{HEAD}
{phisher(-4, 0, 1)}
<path d="M84 104 L170 66" stroke="#6b4a2a" stroke-width="5"/>
<path d="M170 66 l-4 -10 l20 4 l-10 16 z" fill="#9aa6b1" stroke="{INK}" stroke-width="2.2"/>
<line x1="88" y1="120" x2="104" y2="96" stroke="#1b1b1b" stroke-width="6"/>
<path d="M182 104 q22 -18 44 0 q-22 18 -44 0 z" fill="#f0a64a" stroke="{INK}" stroke-width="2.6"/>
<path d="M226 104 l10 -10 v20 z" fill="#f0a64a" stroke="{INK}" stroke-width="2.4"/>
<circle cx="194" cy="100" r="2.6" fill="{INK}"/>
<path d="M200 112 l-6 14" stroke="{INK}" stroke-width="1.4"/>
<g transform="rotate(-6 196 136)"><rect x="166" y="126" width="58" height="22" rx="3" {PAPER} stroke="{INK}" stroke-width="2"/>
<text x="195" y="142" text-anchor="middle" {SE} font-size="11" fill="{RED}">LERATO</text></g>
<path d="M130 158 q10 -6 20 0 q10 6 20 0 q10 -6 20 0 q10 6 20 0" fill="none" stroke="#5b8fc9" stroke-width="2.4"/>
</svg>
'''

# Sniff with a numbered clipboard: after the leak, in order
files['safety-sniff-checklist.svg'] = f'''{HEAD}
{sniff(-14, 26, 0.6)}
<rect x="122" y="12" width="104" height="148" rx="6" fill="#8a5a2e" stroke="{INK}" stroke-width="3"/>
<rect x="130" y="24" width="88" height="128" {PAPER} stroke="{INK}" stroke-width="1.6"/>
<rect x="156" y="6" width="36" height="14" rx="3" fill="#9aa6b1" stroke="{INK}" stroke-width="2.2"/>
<text x="174" y="42" text-anchor="middle" {SE} font-size="10" fill="{INK}">AFTER A LEAK</text>
<g {SE} font-size="11" fill="{INK}">
<text x="140" y="64">1</text><text x="140" y="84">2</text><text x="140" y="104">3</text><text x="140" y="124">4</text><text x="140" y="144">5</text>
</g>
<g stroke="{INK}" stroke-width="1.4"><path d="M152 60 h42 M152 80 h48 M152 100 h38 M152 120 h46 M152 140 h40"/></g>
<g fill="none" stroke="{RED}" stroke-width="2.6"><path d="M200 58 l4 5 l9 -11"/><path d="M204 78 l4 5 l9 -11"/><path d="M196 98 l4 5 l9 -11"/></g>
</svg>
'''

# --------------------------------------------------------------------- apps --
# SuperTorch: a torch with eyes and very big ears
files['safety-nosy-torch.svg'] = f'''{HEAD}
<path d="M100 40 L52 4 h136 L140 40 z" fill="#fff6b8" opacity="0.9"/>
<path d="M66 82 q-30 -10 -30 18 q0 26 30 16 z" fill="#f2b6a8" stroke="{INK}" stroke-width="3"/>
<path d="M60 92 q-12 0 -12 9 q0 8 12 7" fill="none" stroke="{INK}" stroke-width="2"/>
<path d="M174 82 q30 -10 30 18 q0 26 -30 16 z" fill="#f2b6a8" stroke="{INK}" stroke-width="3"/>
<path d="M180 92 q12 0 12 9 q0 8 -12 7" fill="none" stroke="{INK}" stroke-width="2"/>
<path d="M92 40 h56 l-10 26 h-36 z" fill="#9aa6b1" stroke="{INK}" stroke-width="3"/>
<rect x="96" y="36" width="48" height="8" rx="2" fill="{GOLD}" stroke="{INK}" stroke-width="2.4"/>
<rect x="66" y="66" width="108" height="94" rx="10" fill="#d84a3a" stroke="{INK}" stroke-width="3"/>
<ellipse cx="102" cy="96" rx="12" ry="14" {PAPER} stroke="{INK}" stroke-width="2.4"/>
<ellipse cx="138" cy="96" rx="12" ry="14" {PAPER} stroke="{INK}" stroke-width="2.4"/>
<circle cx="106" cy="98" r="5" fill="{INK}"/><circle cx="142" cy="98" r="5" fill="{INK}"/>
<text x="120" y="140" text-anchor="middle" {SE} font-size="11" fill="#fff">SuperTorch</text>
<text x="120" y="155" text-anchor="middle" font-size="11" fill="{GOLD}">&#9733;&#9733;&#9733;&#9733;&#9733;</text>
</svg>
'''

# A dustbin with forgotten apps falling in
files['safety-app-bin.svg'] = f'''{HEAD}
<g transform="rotate(-14 66 36)"><rect x="46" y="16" width="40" height="40" rx="9" fill="#d84a3a" stroke="{INK}" stroke-width="2.6"/>
<path d="M60 26 h12 l-3 8 h-6 z M63 34 h6 v14 h-6 z" fill="{GOLD}" stroke="{INK}" stroke-width="1.6"/></g>
<g transform="rotate(16 150 22)"><rect x="132" y="4" width="36" height="36" rx="8" fill="#5b8fc9" stroke="{INK}" stroke-width="2.6"/>
<text x="150" y="29" text-anchor="middle" {BO} font-size="16" fill="#fff">?</text></g>
<g transform="rotate(-4 108 64)"><rect x="92" y="48" width="32" height="32" rx="7" fill="#7cb46b" stroke="{INK}" stroke-width="2.6"/>
<text x="108" y="70" text-anchor="middle" {BO} font-size="13" fill="#fff">7x8</text></g>
<path d="M58 92 h124 l-12 74 h-100 z" fill="#7d8a96" stroke="{INK}" stroke-width="3"/>
<rect x="50" y="84" width="140" height="12" rx="4" fill="#9aa6b1" stroke="{INK}" stroke-width="3"/>
<path d="M90 106 l4 50 M120 106 v50 M150 106 l-4 50" stroke="{INK}" stroke-width="2"/>
<path d="M194 46 q12 6 4 18" fill="none" stroke="{INK}" stroke-width="1.6"/>
<text x="206" y="40" {CV} font-size="16" fill="{RED}">bye!</text>
</svg>
'''

# --------------------------------------------------------------- footprint --
# A chat: asking before posting a photo of a friend
files['safety-ask-first.svg'] = f'''{HEAD}
<rect x="54" y="4" width="132" height="162" rx="14" fill="#3b3f44" stroke="{INK}" stroke-width="3"/>
<rect x="62" y="18" width="116" height="134" rx="4" fill="#efe9dc" stroke="{INK}" stroke-width="1.6"/>
<path d="M88 30 h82 a5 5 0 0 1 5 5 v44 a5 5 0 0 1 -5 5 h-82 a5 5 0 0 1 -5 -5 v-44 a5 5 0 0 1 5 -5 z" fill="#d6f2c4" stroke="{INK}" stroke-width="1.6"/>
<text x="90" y="46" {CP} font-size="10" fill="{INK}">Can I post</text>
<text x="90" y="60" {CP} font-size="10" fill="{INK}">that pic of</text>
<text x="90" y="74" {CP} font-size="10" fill="{INK}">you?</text>
<path d="M68 96 h62 a5 5 0 0 1 5 5 v26 a5 5 0 0 1 -5 5 h-62 a5 5 0 0 1 -5 -5 v-26 a5 5 0 0 1 5 -5 z" {PAPER} stroke="{INK}" stroke-width="1.6"/>
<text x="72" y="112" {CP} font-size="10" fill="{INK}">Ja, cool!</text>
<text x="72" y="126" {CP} font-size="10" fill="{INK}">Send it.</text>
<path d="M204 70 q-4 -14 8 -16 l2 12 h12 q6 0 4 8 l-4 16 q-2 6 -8 6 h-16 z" fill="{GOLD}" stroke="{INK}" stroke-width="2.4"/>
<rect x="194" y="70" width="10" height="26" rx="2" fill="{GOLD}" stroke="{INK}" stroke-width="2.4"/>
</svg>
'''

# A tube of toothpaste, squeezed out - with a photo on the label
files['safety-toothpaste.svg'] = f'''{HEAD}
<path d="M20 70 h12 l8 -8 h96 q14 30 0 60 h-96 l-8 -8 h-12 z" fill="#f4f1ea" stroke="{INK}" stroke-width="3"/>
<path d="M20 66 v52" stroke="{INK}" stroke-width="3"/>
<path d="M24 66 v52 M28 66 v52" stroke="{INK}" stroke-width="1.4"/>
<path d="M60 78 h52 v28 h-52 z" fill="#fbf8f0" stroke="{INK}" stroke-width="2"/>
<circle cx="76" cy="90" r="6" fill="#c98b4f" stroke="{INK}" stroke-width="1.6"/>
<path d="M68 104 q8 -10 16 0" fill="#c98b4f" stroke="{INK}" stroke-width="1.6"/>
<text x="98" y="96" text-anchor="middle" {SE} font-size="9" fill="{INK}">PHOTO</text>
<rect x="136" y="78" width="14" height="28" rx="2" fill="#5b8fc9" stroke="{INK}" stroke-width="2.6"/>
<path d="M150 86 q20 -4 26 10 q8 18 26 8 q16 -10 22 8 q-10 16 -28 10 q-18 -8 -24 6 q-10 10 -22 -2 z" fill="#ffffff" stroke="{INK}" stroke-width="2.4"/>
<path d="M162 94 q10 2 14 8 M196 108 q8 -4 14 2" fill="none" stroke="#5b8fc9" stroke-width="2"/>
<text x="168" y="150" text-anchor="middle" {CV} font-size="17" fill="{RED}">now put it back...</text>
</svg>
'''

# --------------------------------------------------------------- fakefriend --
# Sniff with a phone: screenshot saved
files['safety-sniff-screenshot.svg'] = f'''{HEAD}
{sniff(-14, 26, 0.6)}
<rect x="124" y="10" width="96" height="150" rx="12" fill="#3b3f44" stroke="{INK}" stroke-width="3"/>
<rect x="132" y="24" width="80" height="122" rx="4" {PAPER} stroke="{INK}" stroke-width="1.6"/>
<g stroke="{INK}" stroke-width="1.4"><path d="M140 40 h50 M140 52 h40 M150 70 h54 M150 82 h44 M140 100 h48"/></g>
<rect x="128" y="20" width="88" height="130" rx="6" fill="none" stroke="#fff" stroke-width="4" opacity="0.8"/>
<rect x="142" y="114" width="60" height="22" rx="11" fill="{INK}"/>
<text x="172" y="129" text-anchor="middle" {CP} font-size="10" fill="#fff">Saved</text>
<path d="M112 18 l-8 -8 M118 10 v-8 M106 28 h-10" stroke="{GOLD}" stroke-width="3"/>
</svg>
'''

# The Phisher, unmasked: the "14 too!" mask on the floor
files['safety-phisher-unmasked.svg'] = f'''{HEAD}
{phisher(0, 0, 1, eyes='round')}
<path d="M98 30 l8 -10 M104 40 l12 -4 M96 20 l2 -12" stroke="{RED}" stroke-width="3"/>
<g transform="rotate(-70 170 132)">
<ellipse cx="170" cy="132" rx="30" ry="36" {PAPER} stroke="{INK}" stroke-width="3"/>
<circle cx="159" cy="125" r="3.6" fill="{INK}"/><circle cx="181" cy="125" r="3.6" fill="{INK}"/>
<path d="M155 143 q15 14 30 0" fill="none" stroke="{INK}" stroke-width="2.6"/>
</g>
<path d="M118 166 h110" stroke="{INK}" stroke-width="2.4"/>
<text x="180" y="40" text-anchor="middle" {BO} font-size="14" fill="{RED}" transform="rotate(10 180 40)">UNMASKED</text>
</svg>
'''

# ------------------------------------------------------------------ bigcase --
# A pile of case folders, with Sniff peeking over the top
files['safety-case-pile.svg'] = f'''{HEAD}
{sniff(68, -6, 0.5)}
<g stroke="{INK}" stroke-width="2.4">
<g transform="rotate(-3 120 150)"><rect x="40" y="138" width="160" height="22" rx="3" fill="#d6b277"/></g>
<g transform="rotate(2 120 128)"><rect x="44" y="116" width="156" height="22" rx="3" fill="#c99f62"/></g>
<g transform="rotate(-2 120 106)"><rect x="38" y="94" width="160" height="22" rx="3" fill="#d6b277"/></g>
<g transform="rotate(3 120 86)"><rect x="46" y="76" width="152" height="20" rx="3" fill="#c99f62"/></g>
</g>
<g {SE} font-size="10" fill="#3b2a14">
<text x="56" y="154" transform="rotate(-3 120 150)">CASE 01</text>
<text x="60" y="131" transform="rotate(2 120 128)">CASE 03</text>
<text x="54" y="109" transform="rotate(-2 120 106)">CASE 05</text>
<text x="62" y="90" transform="rotate(3 120 86)">CASE 08</text>
</g>
<g transform="rotate(-12 196 40)"><rect x="160" y="22" width="76" height="30" rx="3" fill="none" stroke="{RED}" stroke-width="2.4"/>
<text x="198" y="43" text-anchor="middle" {BO} font-size="13" fill="{RED}">NO PANIC</text></g>
</svg>
'''

# Sniff at a typewriter, writing up the final report
files['safety-sniff-typewriter.svg'] = f'''{HEAD}
{sniff(70, -14, 0.42)}
<rect x="76" y="56" width="90" height="44" fill="#fbf8f0" stroke="{INK}" stroke-width="2"/>
<text x="121" y="74" text-anchor="middle" {SE} font-size="10" fill="{INK}">FINAL REPORT</text>
<path d="M88 84 h62 M88 93 h50" stroke="{INK}" stroke-width="1.4"/>
<rect x="56" y="96" width="130" height="16" rx="6" fill="#4a4f55" stroke="{INK}" stroke-width="2.6"/>
<path d="M42 112 h158 l14 46 h-186 z" fill="#2f3a44" stroke="{INK}" stroke-width="3"/>
<g fill="#f4f1ea" stroke="{INK}" stroke-width="1.4">
<circle cx="64" cy="126" r="5"/><circle cx="84" cy="126" r="5"/><circle cx="104" cy="126" r="5"/><circle cx="124" cy="126" r="5"/><circle cx="144" cy="126" r="5"/><circle cx="164" cy="126" r="5"/><circle cx="184" cy="126" r="5"/>
<circle cx="72" cy="142" r="5"/><circle cx="92" cy="142" r="5"/><circle cx="112" cy="142" r="5"/><circle cx="132" cy="142" r="5"/><circle cx="152" cy="142" r="5"/><circle cx="172" cy="142" r="5"/>
</g>
<text x="214" y="70" text-anchor="middle" {CV} font-size="18" fill="{RED}">ding!</text>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files))
