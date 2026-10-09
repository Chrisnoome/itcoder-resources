import os, sys
out = sys.argv[1]
BG, SLAB, PINK, CYAN, RED, WHITE = "#151026", "#221a3d", "#ff4fa3", "#3ee8ff", "#ff3b3b", "#f3eefe"
BU = "font-family=\"Bungee, Impact, sans-serif\""
MONO = "font-family=\"'IBM Plex Mono', 'Courier New', monospace\""
glow = f'<defs><filter id="g" x="-30%" y="-30%" width="160%" height="160%"><feGaussianBlur stdDeviation="3" result="b"/><feMerge><feMergeNode in="b"/><feMergeNode in="SourceGraphic"/></feMerge></filter></defs>'

def heart(cx, cy, s, fill):
    return f'<path transform="translate({cx} {cy}) scale({s})" d="M0 -6 c-14 -18 -36 -4 -26 14 l26 24 l26 -24 c10 -18 -12 -32 -26 -14 z" fill="{fill}"/>'

def label(x, y, text, colour, anchor="start", size=13):
    return f'<text x="{x}" y="{y}" text-anchor="{anchor}" {BU} font-size="{size}" fill="{colour}">{text}</text>'

def callout(x1, y1, x2, y2, colour):
    return f'<path d="M{x1} {y1} L{x2} {y2}" stroke="{colour}" stroke-width="2" stroke-dasharray="5 4"/><circle cx="{x2}" cy="{y2}" r="4" fill="{colour}"/>'

files = {}

# The slot machine: persuasive design, labelled
files['sm-slot-machine.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 420" width="680" height="420">{glow}
<rect width="680" height="420" fill="{BG}"/>
<g filter="url(#g)">
<rect x="230" y="40" width="220" height="330" rx="26" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<rect x="252" y="96" width="176" height="150" rx="10" fill="#0f0b1d" stroke="{CYAN}" stroke-width="3"/>
<line x1="311" y1="96" x2="311" y2="246" stroke="{CYAN}" stroke-width="2"/><line x1="369" y1="96" x2="369" y2="246" stroke="{CYAN}" stroke-width="2"/>
{heart(281, 140, 0.8, PINK)}{heart(340, 176, 0.8, PINK)}{heart(398, 212, 0.8, PINK)}
<rect x="270" y="56" width="140" height="28" rx="6" fill="{RED}"/>
{label(340, 76, "JACKPOT", WHITE, "middle", 14)}
<path d="M450 140 h40 v-70" fill="none" stroke="{PINK}" stroke-width="7" stroke-linecap="round"/>
<circle cx="490" cy="62" r="14" fill="{RED}"/>
<rect x="276" y="270" width="128" height="30" rx="8" fill="#0f0b1d" stroke="{PINK}" stroke-width="2"/>
<g fill="#f2c94c"><circle cx="300" cy="330" r="10"/><circle cx="330" cy="342" r="10"/><circle cx="360" cy="332" r="10"/></g>
</g>
{callout(504, 62, 522, 62, CYAN)}{label(530, 58, "LEVER", CYAN)}<text x="530" y="76" {MONO} font-size="12" fill="{WHITE}">pull to refresh</text>
{callout(252, 170, 150, 170, CYAN)}{label(30, 166, "REELS", CYAN)}<text x="30" y="184" {MONO} font-size="12" fill="{WHITE}">endless scrolling</text>
{callout(270, 70, 150, 70, PINK)}{label(30, 66, "JACKPOT", PINK)}<text x="30" y="84" {MONO} font-size="12" fill="{WHITE}">likes, maybe this time</text>
{callout(300, 332, 150, 340, PINK)}{label(30, 336, "COINS", PINK)}<text x="30" y="354" {MONO} font-size="12" fill="{WHITE}">notifications, any moment</text>
{callout(404, 285, 522, 300, CYAN)}{label(530, 296, "AUTOPLAY", CYAN)}<text x="530" y="314" {MONO} font-size="12" fill="{WHITE}">next video starts</text>
</svg>
'''

# You are the product
files['sm-product.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 360" width="680" height="360">{glow}
<rect width="680" height="360" fill="{BG}"/>
<g filter="url(#g)">
<circle cx="110" cy="150" r="34" fill="none" stroke="{CYAN}" stroke-width="4"/><path d="M60 250 q50 -70 100 0" fill="none" stroke="{CYAN}" stroke-width="4"/>
<rect x="250" y="90" width="140" height="190" rx="18" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/>
<rect x="500" y="110" width="150" height="150" rx="10" fill="{SLAB}" stroke="#f2c94c" stroke-width="4"/>
</g>
{label(110, 300, "YOU", CYAN, "middle", 16)}<text x="110" y="322" text-anchor="middle" {MONO} font-size="12" fill="{WHITE}">time and attention</text>
{label(320, 130, "FREE APP", PINK, "middle", 13)}
<g {MONO} font-size="12" fill="{WHITE}"><text x="270" y="170">what you watch</text><text x="270" y="192">how long you pause</text><text x="270" y="214">where you are</text><text x="270" y="236">who you know</text></g>
{label(575, 150, "ADVERTISERS", "#f2c94c", "middle", 12)}
<text x="575" y="196" text-anchor="middle" {BU} font-size="34" fill="#f2c94c">R</text>
<text x="575" y="236" text-anchor="middle" {MONO} font-size="12" fill="{WHITE}">pay for your eyes</text>
<path d="M150 160 h90" stroke="{CYAN}" stroke-width="3"/><path d="M232 152 l10 8 l-10 8" fill="none" stroke="{CYAN}" stroke-width="3"/>
<path d="M394 170 h96" stroke="#f2c94c" stroke-width="3"/><path d="M482 162 l10 8 l-10 8" fill="none" stroke="#f2c94c" stroke-width="3"/>
<text x="340" y="40" text-anchor="middle" {BU} font-size="18" fill="{PINK}">IF IT'S FREE, YOU ARE THE PRODUCT</text>
</svg>
'''

# The feed funnel
posts = ''.join(f'<rect x="{40 + (i % 10) * 24}" y="{70 + (i // 10) * 20}" width="18" height="14" rx="3" fill="{SLAB}" stroke="{CYAN}" stroke-width="1.2"/>' for i in range(60))
top = ''.join(f'<rect x="560" y="{80 + i * 34}" width="90" height="26" rx="5" fill="{SLAB}" stroke="{PINK}" stroke-width="2"/><text x="570" y="{98 + i * 34}" {MONO} font-size="11" fill="{WHITE}">post #{i + 1}</text>' for i in range(6))
files['sm-feed-funnel.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 320" width="680" height="320">{glow}
<rect width="680" height="320" fill="{BG}"/>
{posts}
<text x="40" y="58" {BU} font-size="13" fill="{CYAN}">THOUSANDS OF POSTS</text>
<g filter="url(#g)"><path d="M300 70 h180 l-60 110 v70 h-60 v-70 z" fill="{SLAB}" stroke="{PINK}" stroke-width="4"/></g>
<text x="390" y="108" text-anchor="middle" {BU} font-size="13" fill="{PINK}">THE ALGORITHM</text>
<text x="390" y="132" text-anchor="middle" {MONO} font-size="11" fill="{WHITE}">will you stop</text>
<text x="390" y="148" text-anchor="middle" {MONO} font-size="11" fill="{WHITE}">and look?</text>
{top}
<text x="560" y="62" {BU} font-size="13" fill="{PINK}">YOUR FEED</text>
<path d="M276 130 h20 M486 130 h60" stroke="{CYAN}" stroke-width="3"/>
</svg>
'''

# Is the film fair? Scales
files['sm-fair-scales.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 320" width="680" height="320">{glow}
<rect width="680" height="320" fill="{BG}"/>
<g filter="url(#g)" stroke-width="4" fill="none">
<path d="M340 60 v200 M260 270 h160" stroke="{WHITE}"/>
<path d="M170 90 L510 110" stroke="{WHITE}"/>
<path d="M170 90 l-50 80 h100 z" stroke="{CYAN}"/><path d="M510 110 l-50 80 h100 z" stroke="{PINK}"/>
</g>
{label(170, 200, "EVIDENCE", CYAN, "middle", 14)}<g {MONO} font-size="12" fill="{WHITE}" text-anchor="middle"><text x="170" y="222">studies, numbers,</text><text x="170" y="238">insiders' experience</text></g>
{label(510, 220, "DRAMA", PINK, "middle", 14)}<g {MONO} font-size="12" fill="{WHITE}" text-anchor="middle"><text x="510" y="242">acted family story,</text><text x="510" y="258">music, worst cases</text></g>
<text x="340" y="40" text-anchor="middle" {BU} font-size="18" fill="{WHITE}">WEIGH IT UP</text>
</svg>
'''

# My feed, my rules: controls
rows = [("Notifications", "only people"), ("Daily limit", "1 hour"), ("Autoplay", "off"), ("Phone at night", "out of bedroom"), ("Grayscale", "on")]
ctl = ''.join(f'<text x="250" y="{100 + i * 42}" {MONO} font-size="14" fill="{WHITE}">{n}</text><text x="250" y="{116 + i * 42}" {MONO} font-size="11" fill="#9b93b8">{v}</text><rect x="410" y="{88 + i * 42}" width="44" height="22" rx="11" fill="{CYAN}"/><circle cx="443" cy="{99 + i * 42}" r="8" fill="{BG}"/>' for i, (n, v) in enumerate(rows))
files['sm-my-rules.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 340" width="680" height="340">{glow}
<rect width="680" height="340" fill="{BG}"/>
<g filter="url(#g)"><rect x="220" y="40" width="260" height="280" rx="22" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/></g>
<text x="350" y="70" text-anchor="middle" {BU} font-size="15" fill="{CYAN}">MY FEED, MY RULES</text>
{ctl}
</svg>
'''

# Doodles (240 x 170)
files['sm-bell-99.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<path d="M80 120 q0 -60 40 -70 q40 10 40 70 l12 14 h-104 z" fill="{SLAB}" stroke="{PINK}" stroke-width="4" stroke-linejoin="round"/>
<circle cx="120" cy="146" r="10" fill="{PINK}"/>
<circle cx="168" cy="50" r="22" fill="{RED}"/><text x="168" y="57" text-anchor="middle" {BU} font-size="15" fill="#fff">99+</text>
<g stroke="{CYAN}" stroke-width="3" stroke-linecap="round"><path d="M50 70 l-14 -8 M46 100 h-18 M196 100 h18"/></g>
</svg>
'''
files['sm-heart-hook.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<path d="M120 0 v60" stroke="{CYAN}" stroke-width="3"/>
<path d="M120 60 q0 20 -16 20 q-14 0 -14 -14" fill="none" stroke="{CYAN}" stroke-width="4" stroke-linecap="round"/>
{heart(120, 112, 1.3, PINK)}
<text x="186" y="120" {BU} font-size="16" fill="{PINK}">+1</text>
</svg>
'''
files['sm-phone-sleep.svg'] = f'''<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 240 170" width="240" height="170">
<rect x="86" y="20" width="68" height="128" rx="12" fill="{SLAB}" stroke="{CYAN}" stroke-width="4"/>
<path d="M120 60 a22 22 0 1 0 18 36 a18 18 0 1 1 -18 -36 z" fill="#f2c94c"/>
<text x="166" y="50" {BU} font-size="18" fill="{CYAN}">z</text><text x="182" y="34" {BU} font-size="22" fill="{CYAN}">z</text>
<text x="120" y="166" text-anchor="middle" {BU} font-size="12" fill="{PINK}">00:47</text>
</svg>
'''
for name, svg in files.items():
    with open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n') as f:
        f.write(svg)
print(len(files))
