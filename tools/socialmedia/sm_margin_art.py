"""Margin doodles for the Grade 9 social media course (Chris, 10 October 2026:
"don't forget sidebar images, asides and factoids / jokes").

Same neon look as sm_art.py (brand/socialmedia-art-style.md), 240 x 170, no
background and no filters (doodles are inlined, so no ids). Writes only the
new sm-*.svg files listed here; sm_art.py keeps its own.

    python sm_margin_art.py <AIPascalCourse>/public/assets/doodles
"""
import os, sys

out = sys.argv[1]
SLAB, PINK, CYAN, RED, WHITE, GOLD, GREY, DARK, PURPLE = "#221a3d", "#ff4fa3", "#3ee8ff", "#ff3b3b", "#f3eefe", "#f2c94c", "#8a82a8", "#0f0b1d", "#8b6cff"
BU = 'font-family="Bungee, Impact, sans-serif"'
HEAD = '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">'


def heart(cx, cy, s, fill):
    return f'<path transform="translate({cx} {cy}) scale({s})" d="M0 -6 c-14 -18 -36 -4 -26 14 l26 24 l26 -24 c10 -18 -12 -32 -26 -14 z" fill="{fill}"/>'


files = {}

# whopays: popcorn for the film
puffs = ''.join(f'<circle cx="{x}" cy="{y}" r="13" fill="{WHITE}" stroke="{GOLD}" stroke-width="2"/>'
                for x, y in [(92, 52), (114, 40), (136, 44), (152, 56), (104, 60), (128, 58)])
files['sm-popcorn.svg'] = f'''{HEAD}
{puffs}
<path d="M82 62 L158 62 L146 156 L94 156 Z" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<g stroke="{CYAN}" stroke-width="3" stroke-linecap="round"><path d="M104 70 L108 148 M120 70 V148 M136 70 L132 148"/></g>
<rect x="88" y="94" width="64" height="24" rx="5" fill="{RED}"/>
<text x="120" y="112" text-anchor="middle" {BU} font-size="13" fill="#fff">FILM</text>
</svg>
'''

# design: pull to refresh = the lever
files['sm-pull-refresh.svg'] = f'''{HEAD}
<path d="M156 104 H184 V44" fill="none" stroke="{PINK}" stroke-width="7" stroke-linecap="round" stroke-linejoin="round"/>
<circle cx="184" cy="38" r="11" fill="{RED}"/>
<rect x="76" y="14" width="84" height="142" rx="13" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<path d="M118 26 V40 M111 34 L118 41 L125 34" fill="none" stroke="{CYAN}" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M136 76 A18 18 0 1 1 131 63" fill="none" stroke="{PINK}" stroke-width="4" stroke-linecap="round"/>
<path d="M124 56 L133 62 L127 70" fill="none" stroke="{PINK}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
<text x="118" y="136" text-anchor="middle" {BU} font-size="26" fill="{CYAN}">?</text>
</svg>
'''

# design: Skinner's pigeon and the button that pays out "maybe"
files['sm-pigeon.svg'] = f'''{HEAD}
<path d="M20 152 H226" stroke="{GREY}" stroke-width="3" stroke-linecap="round"/>
<path d="M58 96 L22 84 L32 112 Z" fill="{SLAB}" stroke="{CYAN}" stroke-width="4" stroke-linejoin="round"/>
<g stroke="{PINK}" stroke-width="3" stroke-linecap="round"><path d="M88 128 V150 M108 128 V150 M82 150 H94 M102 150 H114"/></g>
<ellipse cx="98" cy="104" rx="46" ry="28" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<path d="M78 98 q18 14 40 2" fill="none" stroke="{CYAN}" stroke-width="3" stroke-linecap="round"/>
<circle cx="148" cy="98" r="16" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<circle cx="151" cy="93" r="3.5" fill="{WHITE}"/>
<path d="M162 100 L178 108 L161 111 Z" fill="{GOLD}"/>
<rect x="182" y="96" width="40" height="56" rx="6" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<circle cx="202" cy="112" r="8" fill="{RED}"/>
<text x="196" y="72" text-anchor="middle" {BU} font-size="28" fill="{PINK}">?</text>
<text x="220" y="56" text-anchor="middle" {BU} font-size="18" fill="{GOLD}">?</text>
</svg>
'''

# algorithms: a filter bubble
inside = heart(84, 52, 0.4, PINK) + heart(158, 58, 0.4, PINK) + heart(150, 118, 0.35, PINK) + heart(88, 116, 0.35, PINK)
outside = ''.join(f'<rect x="{x}" y="{y}" width="30" height="20" rx="6" fill="none" stroke="{GREY}" stroke-width="2" stroke-dasharray="4 3"/><text x="{x + 15}" y="{y + 15}" text-anchor="middle" {BU} font-size="12" fill="{GREY}">?</text>'
                  for x, y in [(4, 10), (204, 16), (2, 136), (206, 132)])
files['sm-filter-bubble.svg'] = f'''{HEAD}
{outside}
<circle cx="120" cy="86" r="66" fill="none" stroke="{CYAN}" stroke-width="4"/>
{inside}
<g stroke="{PURPLE}" stroke-width="4" stroke-linecap="round" fill="none"><path d="M120 92 V122 M120 100 L104 88 M120 100 L136 88 M120 122 L108 140 M120 122 L132 140"/></g>
<circle cx="120" cy="76" r="13" fill="{SLAB}" stroke="{PURPLE}" stroke-width="4"/>
</svg>
'''

# algorithms: down the rabbit hole
files['sm-rabbit-hole.svg'] = f'''{HEAD}
<ellipse cx="120" cy="132" rx="84" ry="22" fill="{DARK}" stroke="{CYAN}" stroke-width="4"/>
<path d="M78 132 a42 10 0 0 1 84 0 M96 132 a24 6 0 0 1 48 0" fill="none" stroke="{CYAN}" stroke-width="2" opacity="0.6"/>
<g stroke="{PINK}" stroke-width="10" stroke-linecap="round" fill="none"><path d="M106 116 Q96 84 76 66 M134 116 Q144 84 164 66"/></g>
<ellipse cx="72" cy="62" rx="12" ry="7" fill="{PINK}" transform="rotate(-35 72 62)"/>
<ellipse cx="168" cy="62" rx="12" ry="7" fill="{PINK}" transform="rotate(35 168 62)"/>
<path d="M88 132 A32 30 0 0 1 152 132 Z" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<circle cx="120" cy="102" r="12" fill="{WHITE}" stroke="{PINK}" stroke-width="3"/>
<path d="M36 132 a84 22 0 0 0 168 0" fill="none" stroke="{CYAN}" stroke-width="4"/>
<path d="M190 26 l14 8 l-14 8 z M40 30 l12 7 l-12 7 z" fill="{CYAN}"/>
</svg>
'''

# effects: a forwarded message (calm - no joke)
files['sm-forwarded.svg'] = f'''{HEAD}
<rect x="62" y="22" width="140" height="72" rx="14" fill="{SLAB}" stroke="{GREY}" stroke-width="3"/>
<rect x="50" y="36" width="140" height="72" rx="14" fill="{SLAB}" stroke="{GREY}" stroke-width="3"/>
<path d="M54 118 L44 140 L76 120 Z" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<rect x="38" y="50" width="140" height="74" rx="14" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<path d="M50 68 l8 -6 l-8 -6 M58 68 l8 -6 l-8 -6" fill="none" stroke="{PINK}" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" transform="translate(0 4)"/>
<text x="74" y="72" {BU} font-size="11" fill="{PINK}">FORWARDED</text>
<g stroke="{WHITE}" stroke-width="4" stroke-linecap="round"><path d="M52 90 H160 M52 106 H128"/></g>
<circle cx="190" cy="132" r="22" fill="{CYAN}"/>
<text x="190" y="142" text-anchor="middle" {BU} font-size="26" fill="{DARK}">?</text>
</svg>
'''

# fair: a clapperboard
stripes = ''.join(f'<path d="M{70 + i * 24} 68 L{84 + i * 24} 44" stroke="{WHITE}" stroke-width="8"/>' for i in range(5))
files['sm-clapper.svg'] = f'''{HEAD}
<g transform="rotate(-14 62 70)">
<rect x="60" y="44" width="124" height="24" rx="3" fill="{PINK}"/>
{stripes}
</g>
<rect x="60" y="70" width="124" height="84" rx="6" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<circle cx="62" cy="70" r="6" fill="{GOLD}"/>
<path d="M60 96 H184" stroke="{GREY}" stroke-width="2"/>
<text x="122" y="90" text-anchor="middle" {BU} font-size="13" fill="{CYAN}">TAKE 1</text>
<text x="122" y="122" text-anchor="middle" {BU} font-size="13" fill="{PINK}">SCENE:</text>
<text x="122" y="142" text-anchor="middle" {BU} font-size="13" fill="{PINK}">DRAMA</text>
</svg>
'''

# fair: two sides and a magnifying glass
files['sm-two-sides.svg'] = f'''{HEAD}
<rect x="10" y="20" width="90" height="50" rx="12" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<path d="M30 70 L24 88 L46 70" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<path d="M30 70 H46" stroke="{SLAB}" stroke-width="5"/>
<text x="55" y="51" text-anchor="middle" {BU} font-size="14" fill="{PINK}">FILM</text>
<rect x="140" y="20" width="90" height="50" rx="12" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<path d="M194 70 L216 88 L210 70" fill="{SLAB}" stroke="{CYAN}" stroke-width="4" stroke-linejoin="round"/>
<path d="M194 70 H210" stroke="{SLAB}" stroke-width="5"/>
<text x="185" y="51" text-anchor="middle" {BU} font-size="14" fill="{CYAN}">APP</text>
<path d="M138 140 L166 162" stroke="{GOLD}" stroke-width="10" stroke-linecap="round"/>
<circle cx="120" cy="120" r="28" style="fill: var(--doodle-paper, #fff)" stroke="{GOLD}" stroke-width="5"/>
<text x="120" y="130" text-anchor="middle" {BU} font-size="26" fill="{GOLD}">?</text>
</svg>
'''

# myrules: grayscale switches the colour off
def phone(x, accent, badge, hearts):
    return (f'<rect x="{x}" y="22" width="72" height="128" rx="12" fill="{SLAB}" stroke="{accent}" stroke-width="4"/>'
            + heart(x + 36, 70, 0.7, hearts)
            + f'<circle cx="{x + 64}" cy="30" r="13" fill="{badge}"/><text x="{x + 64}" y="35" text-anchor="middle" {BU} font-size="11" fill="#fff">9</text>'
            + f'<rect x="{x + 14}" y="108" width="44" height="12" rx="4" fill="{hearts}"/><rect x="{x + 14}" y="126" width="30" height="10" rx="4" fill="{hearts}" opacity="0.6"/>')
files['sm-grayscale.svg'] = f'''{HEAD}
{phone(14, PINK, RED, PINK)}
{phone(150, GREY, "#6d6787", GREY)}
<path d="M98 86 H138 M128 76 L140 86 L128 96" fill="none" stroke="{CYAN}" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
</svg>
'''

# myrules: the phone sleeps in the kitchen
files['sm-charger.svg'] = f'''{HEAD}
<path d="M10 142 H230" stroke="{GREY}" stroke-width="4" stroke-linecap="round"/>
<path d="M30 140 V100 q0 -14 14 -14 h32 q14 0 14 14 V140 Z" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<path d="M90 104 q16 0 16 18" fill="none" stroke="{PINK}" stroke-width="4" stroke-linecap="round"/>
<path d="M48 86 V78 H72 V86" fill="none" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<path d="M148 140 C148 158 214 156 204 108" fill="none" stroke="{CYAN}" stroke-width="3" stroke-linecap="round"/>
<rect x="194" y="86" width="22" height="24" rx="4" fill="{SLAB}" stroke="{CYAN}" stroke-width="3"/>
<circle cx="201" cy="98" r="2.5" fill="{CYAN}"/><circle cx="209" cy="98" r="2.5" fill="{CYAN}"/>
<rect x="120" y="46" width="56" height="96" rx="10" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<rect x="134" y="80" width="28" height="16" rx="3" fill="none" stroke="{CYAN}" stroke-width="2.5"/>
<rect x="137" y="83" width="16" height="10" fill="{CYAN}"/>
<path d="M162 85 V91" stroke="{CYAN}" stroke-width="3"/>
<path d="M118 22 a14 14 0 1 0 12 22 a11 11 0 1 1 -12 -22 z" fill="{GOLD}"/>
<text x="20" y="30" {BU} font-size="12" fill="{PINK}">KITCHEN</text>
</svg>
'''

for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files))
