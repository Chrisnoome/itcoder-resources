"""Small ops-room margin doodles for the Grade 9 SQL course (AIResources/brand/sql9-art-style.md):
the jokes and asides beside the lessons, not data figures (those are make_figs.py).
Run: python make_doodles.py <out dir>   (writes sql9-*.svg into AIPascalCourse/public/assets/doodles/)
Written 10 October 2026 for the margin extras (content-voice-and-pedagogy.md section 5b)."""
import os, sys

out = sys.argv[1]
BG, GRID, GREEN, DIM, AMBER, DARK, CONTOUR = '#16201a', '#24342a', '#9fe870', '#5fae5a', '#f2b33d', '#0e1611', '#3f6b48'
MONO = "font-family=\"'IBM Plex Mono', 'Courier New', monospace\""


def esc(s):
    return str(s).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


def frame(w, h):
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}">',
         f'<rect width="{w}" height="{h}" rx="8" fill="{BG}"/>']
    for x in range(20, w, 40):
        s.append(f'<line x1="{x}" y1="0" x2="{x}" y2="{h}" stroke="{GRID}"/>')
    for y in range(20, h, 40):
        s.append(f'<line x1="0" y1="{y}" x2="{w}" y2="{y}" stroke="{GRID}"/>')
    s.append(f'<rect x="8" y="8" width="{w - 16}" height="{h - 16}" rx="4" fill="{DARK}" stroke="{CONTOUR}"/>')
    return s


def text(x, y, t, fill=GREEN, size=13, bold=False, anchor='start'):
    weight = ' font-weight="600"' if bold else ''
    return (f'<text x="{x}" y="{y}" {MONO} font-size="{size}"{weight} fill="{fill}" '
            f'text-anchor="{anchor}" xml:space="preserve">{esc(t)}</text>')


def bar(x, y, w, t, size=13):
    """The one amber bar of a figure, dark text on it."""
    return [f'<rect x="{x}" y="{y - 16}" width="{w}" height="23" fill="{AMBER}"/>', text(x + 6, y, t, BG, size, True)]


def save(name, s):
    s.append('</svg>')
    open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n').write('\n'.join(s))


# 1. Nine collars pinging, one silent (collar.php).
s = frame(240, 160)
for d in ['M14 120 C60 96 100 132 150 108 S210 92 228 104', 'M14 84 C50 64 96 96 140 72 S200 56 228 66',
          'M14 46 C56 30 92 58 136 40 S196 26 228 34']:
    s.append(f'<path d="{d}" fill="none" stroke="{CONTOUR}" stroke-width="1.5"/>')
for (x, y) in [(36, 58), (62, 100), (84, 70), (110, 124), (122, 52), (146, 92), (168, 60), (58, 132), (96, 96)]:
    s.append(f'<circle cx="{x}" cy="{y}" r="9" fill="none" stroke="{DIM}" stroke-width="1"/>')
    s.append(f'<circle cx="{x}" cy="{y}" r="4" fill="{GREEN}"/>')
s.append(f'<circle cx="202" cy="94" r="15" fill="none" stroke="{AMBER}" stroke-width="2" stroke-dasharray="4 4"/>')
s.append(text(202, 99, '?', AMBER, 15, True, 'middle'))
s.append(text(20, 28, 'COLLARS 9/10', DIM, 12))
s.append(text(220, 140, 'C-07 SILENT', AMBER, 12, True, 'end'))
save('sql9-ping.svg', s)

# 2. Asking in English (where.php).
s = frame(260, 130)
s.append(text(22, 38, '> WHERE is Tumelo?'))
s.append(text(22, 66, "! ERROR near 'is'", AMBER, 13, True))
s.append(text(22, 96, 'try: WHERE RhinoID = ...', DIM, 12))
save('sql9-where-is.svg', s)

# 3. A thermal camera at night: a warm rhino glows (traps.php).
s = frame(240, 160)
s.insert(1, '<defs><radialGradient id="sql9heat" cx="50%" cy="45%" r="60%">'
            f'<stop offset="0" stop-color="#fff1c2"/><stop offset="0.45" stop-color="{AMBER}"/>'
            '<stop offset="1" stop-color="#c2410c"/></radialGradient></defs>')
s.append(f'<g fill="url(#sql9heat)">'
         '<ellipse cx="128" cy="92" rx="46" ry="25"/>'
         '<polygon points="88,80 56,90 50,106 84,108"/>'
         '<polygon points="58,92 48,72 66,90"/>'
         '<polygon points="84,80 88,66 94,80"/>'
         '<rect x="94" y="104" width="10" height="22" rx="3"/><rect x="108" y="106" width="10" height="20" rx="3"/>'
         '<rect x="140" y="106" width="10" height="20" rx="3"/><rect x="154" y="104" width="10" height="22" rx="3"/>'
         '</g>')
for d in ['M120 18 V40', 'M120 144 V128', 'M16 80 H34', 'M224 80 H206']:
    s.append(f'<path d="{d}" stroke="{DIM}" stroke-width="1.5"/>')
s.append(text(20, 30, 'THERMAL', DIM, 12))
s.append(text(220, 30, 'NIGHT', DIM, 12, anchor='end'))
s.append(text(220, 144, 'WARM BODY', AMBER, 12, True, 'end'))
save('sql9-thermal.svg', s)

# 4. The night shift's favourite query (gate.php).
s = frame(260, 150)
s.append(text(22, 36, '> SELECT Tea FROM tblKettle'))
s.append(text(22, 56, '  ORDER BY Strength DESC'))
s.append(text(22, 76, '  LIMIT 1;'))
s += bar(18, 108, 224, 'Rooibos, extra strong')
s.append(text(22, 132, '1 row · 0.001 s', DIM, 12))
save('sql9-tea.svg', s)

# 5. Counting the rhinos (pattern.php).
s = frame(240, 150)
s.append(text(22, 36, '> SELECT COUNT(*)'))
s.append(text(22, 56, '  FROM tblRhinos;'))
s.append(text(22, 84, 'COUNT(*)', DIM, 13))
s += bar(18, 110, 204, '10')
s.append(text(22, 134, '1 row · 1 crash', DIM, 12))
save('sql9-crash.svg', s)

# 6. Can I JOIN you? (connect.php).
s = frame(260, 160)
s.append(text(22, 36, '> Can I JOIN you?'))
for x0, name in [(22, 'tblPeople'), (150, 'tblVehicles')]:
    s.append(text(x0, 74, name, DIM, 12))
    s.append(f'<rect x="{x0}" y="84" width="88" height="54" fill="none" stroke="{GREEN}" stroke-width="1.5"/>')
    for y in (102, 120):
        s.append(f'<line x1="{x0}" y1="{y}" x2="{x0 + 88}" y2="{y}" stroke="{CONTOUR}"/>')
    s.append(f'<line x1="{x0 + 34}" y1="84" x2="{x0 + 34}" y2="138" stroke="{CONTOUR}"/>')
s.append(f'<path d="M110 111 H150" stroke="{AMBER}" stroke-width="2.5" stroke-dasharray="5 4"/>')
s.append(text(130, 104, 'ON', AMBER, 12, True, 'middle'))
save('sql9-join-bar.svg', s)

# 7. Case closed (nextnight.php).
s = frame(240, 130)
s.append(text(22, 38, '> COMMIT;'))
s += bar(18, 74, 204, 'CASE CLOSED')
s.append(text(22, 104, '1 rhino safe · 0 lost', DIM, 12))
save('sql9-commit.svg', s)
