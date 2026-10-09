import math, sys, os
out = sys.argv[1]
SE = "font-family=\"'Special Elite', 'Courier New', monospace\""
CP = "font-family=\"'Courier Prime', 'Courier New', monospace\""
CV = "font-family=\"Caveat, 'Comic Sans MS', cursive\""
BO = "font-family=\"'Black Ops One', Impact, sans-serif\""
INK, RED = "#2a2116", "#b3141c"

# seconds from crackTimer (safety-tryit.js), 10 billion guesses a second
suspects = [
    (["123456"], 1e-8, "instantly"),
    (["sipho2010"], 2, "2 seconds"),
    (["Tr0ub4dor&3"], 0.26, "instantly"),
    (["kH7#qzP"], 6.98e3, "2 hours"),
    (["purple taxi", "river mango"], 1.6e7, "6 months"),
    (["purple taxi", "river mango", "braai"], 3.2e11, "10 000 years"),
]
FLOOR, BASE, PER = 286, 34, 15


def y_of(seconds):
    return FLOOR - BASE - PER * math.log10(max(seconds, 1))


parts = []
parts.append('<path d="M10 40 v-22 q0-8 8-8 h222 q7 0 10 7 l10 23 z" fill="#c99f62"/>')
parts.append('<rect x="10" y="36" width="660" height="446" rx="6" fill="#d6b277"/>')
parts.append(f'<text x="26" y="30" {SE} font-size="13" fill="#3b2a14">CASE 02 · THE LINE-UP</text>')
# the photo
parts.append('<g transform="rotate(-0.6 340 180)">')
parts.append('<rect x="28" y="50" width="624" height="262" fill="#fbf8f0" stroke="#bfb39c"/>')
parts.append(f'<rect x="40" y="62" width="600" height="{FLOOR - 62}" fill="#dcd8cc"/>')
parts.append(f'<rect x="40" y="{FLOOR}" width="600" height="14" fill="#b9b3a3"/>')
for label, s in [("1 second", 1), ("1 hour", 3600), ("1 year", 3.15e7), ("1 000 years", 3.15e10)]:
    y = y_of(s)
    parts.append(f'<line x1="40" y1="{y:.1f}" x2="640" y2="{y:.1f}" stroke="#8f8878" stroke-width="1.2"/>')
    parts.append(f'<text x="46" y="{y - 4:.1f}" {CP} font-size="11" fill="#5a5446">{label}</text>')
for i, (words, s, said) in enumerate(suspects):
    cx = 150 + i * 92
    top = y_of(s)
    h = FLOOR - top
    r = max(7, min(16, h * 0.12))
    w = r * 2.6
    parts.append(f'<circle cx="{cx}" cy="{top + r:.1f}" r="{r:.1f}" fill="#2a2a2a"/>')
    parts.append(f'<rect x="{cx - w / 2:.1f}" y="{top + 2 * r + 1:.1f}" width="{w:.1f}" height="{FLOOR - top - 2 * r - 1:.1f}" rx="{r * 0.8:.1f}" fill="#2a2a2a"/>')
    # the numbered placard at the feet
    parts.append(f'<rect x="{cx - 11}" y="{FLOOR - 1}" width="22" height="16" fill="#fff" stroke="#111"/>')
    parts.append(f'<text x="{cx}" y="{FLOOR + 12}" text-anchor="middle" {SE} font-size="12" fill="#111">{i + 1}</text>')
parts.append('</g>')
# the cards
for i, (words, s, said) in enumerate(suspects):
    x = 20 + i * 108
    tilt = (-1.5, 1, -0.8, 1.4, -1.2, 0.8)[i]
    g = [f'<g transform="rotate({tilt} {x + 50} 390)">',
         f'<rect x="{x}" y="326" width="100" height="140" fill="#f6efdc"/>',
         f'<text x="{x + 8}" y="345" {SE} font-size="12" fill="{INK}">SUSPECT {i + 1}</text>']
    for k, wline in enumerate(words):
        g.append(f'<text x="{x + 8}" y="{366 + k * 16}" {CP} font-size="12.5" font-weight="700" fill="#1d1f24">{wline.replace("&", "&amp;")}</text>')
    g.append(f'<text x="{x + 8}" y="428" {CV} font-size="17" fill="#23345a">cracked in</text>')
    colour = RED if s < 3600 * 24 * 365 else "#1f7a3a"
    g.append(f'<text x="{x + 8}" y="452" {CV} font-size="18" font-weight="700" fill="{colour}">{said}</text>')
    g.append('</g>')
    parts += g

svg = ('<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 680 490" width="680" height="490">\n'
       + '\n'.join(parts) + '\n</svg>\n')
with open(os.path.join(out, 'safety-lineup.svg'), 'w', encoding='utf-8', newline='\n') as f:
    f.write(svg)
print('ok')
