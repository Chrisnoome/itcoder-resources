"""Ops-room figures for the Grade 9 SQL course, drawn from the real query results
(AIResources/brand/sql9-art-style.md). Run: python make_figs.py <out dir>"""
import json, os, sqlite3, sys

out = sys.argv[1]
data = json.load(open('reserve.json', encoding='utf-8'))
db = sqlite3.connect(':memory:')
for name, t in data.items():
    db.execute(f'CREATE TABLE {name} (' + ', '.join(t['columns']) + ')')
    db.executemany(f'INSERT INTO {name} VALUES (' + ','.join('?' * len(t['columns'])) + ')', t['rows'])

BG, GRID, GREEN, DIM, AMBER, DARK, CONTOUR = '#16201a', '#24342a', '#9fe870', '#5fae5a', '#f2b33d', '#0e1611', '#3f6b48'
MONO = "font-family=\"'IBM Plex Mono', 'Courier New', monospace\""

def esc(s):
    return str(s).replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')

def screen(name, sql_lines, sql, highlight=lambda row: False, alert=None, width=680, maxrows=10, note=None):
    cur = db.execute(sql)
    cols = [d[0] for d in cur.description]
    rows = cur.fetchall()
    shown = rows[:maxrows]
    widths = [max(len(str(c)), *(len(str(r[i])) for r in shown)) if shown else len(c) for i, c in enumerate(cols)]
    def line(vals):
        return '  '.join(str(v).ljust(widths[i]) for i, v in enumerate(vals))
    char = 7.9   # IBM Plex Mono at 13 px
    textw = max(len(line(cols)), *(len(l) for l in sql_lines)) * char + 40
    w = max(width, int(textw) + 32)
    y0 = 40 + 20 * len(sql_lines)
    h = y0 + 34 + 26 * len(shown) + (26 if len(rows) > maxrows else 0) + 60 + (24 if alert else 0)
    s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}">',
         f'<rect width="{w}" height="{h}" fill="{BG}"/>']
    for x in range(20, w, 40):
        s.append(f'<line x1="{x}" y1="0" x2="{x}" y2="{h}" stroke="{GRID}"/>')
    for y in range(20, h, 40):
        s.append(f'<line x1="0" y1="{y}" x2="{w}" y2="{y}" stroke="{GRID}"/>')
    s.append(f'<rect x="12" y="12" width="{w - 24}" height="{h - 24}" fill="{DARK}" stroke="{CONTOUR}"/>')
    for i, l in enumerate(sql_lines):
        s.append(f'<text x="28" y="{40 + 20 * i}" {MONO} font-size="13" fill="{GREEN}" xml:space="preserve">{"&gt; " if i == 0 else "  "}{esc(l)}</text>')
    y = y0 + 20
    s.append(f'<text x="28" y="{y}" {MONO} font-size="13" fill="{DIM}" xml:space="preserve">{esc(line(cols))}</text>')
    for r in shown:
        y += 26
        if highlight(r):
            s.append(f'<rect x="22" y="{y - 17}" width="{w - 44}" height="24" fill="{AMBER}"/>')
            s.append(f'<text x="28" y="{y}" {MONO} font-size="13" font-weight="600" fill="{BG}" xml:space="preserve">{esc(line(r))}</text>')
        else:
            s.append(f'<text x="28" y="{y}" {MONO} font-size="13" fill="{GREEN}" xml:space="preserve">{esc(line(r))}</text>')
    if len(rows) > maxrows:
        y += 26
        s.append(f'<text x="28" y="{y}" {MONO} font-size="13" fill="{DIM}">... {len(rows) - maxrows} more rows</text>')
    y += 34
    s.append(f'<text x="28" y="{y}" {MONO} font-size="12" fill="{DIM}">{len(rows)} row{"s" if len(rows) != 1 else ""} · 0.00{1 + len(rows) % 7} s</text>')
    if alert:
        y += 24
        s.append(f'<text x="28" y="{y}" {MONO} font-size="13" font-weight="600" fill="{AMBER}">! {esc(alert)}</text>')
    s.append('</svg>')
    open(os.path.join(out, name), 'w', encoding='utf-8', newline='\n').write('\n'.join(s))
    return rows

figs = {}
figs['sql9-rhinos'] = screen('sql9-rhinos.svg', ['SELECT RhinoName, LastSeenDate, LastSeenTime, Zone', 'FROM tblRhinos;'],
    'SELECT RhinoName, LastSeenDate, LastSeenTime, Zone FROM tblRhinos', lambda r: r[0] == 'Tumelo', 'COLLAR C-07 SILENT SINCE 12 MARCH')
figs['sql9-tumelo-sightings'] = screen('sql9-tumelo-sightings.svg', ['SELECT SightDate, SightTime, Zone, RangerID', 'FROM tblSightings', 'WHERE RhinoID = 2;'],
    'SELECT SightDate, SightTime, Zone, RangerID FROM tblSightings WHERE RhinoID = 2', lambda r: r[1] == '17:40', 'NO SIGHTING AFTER 17:40 ON 12 MARCH')
figs['sql9-k7-traps'] = screen('sql9-k7-traps.svg', ['SELECT TrapID, SnapDate, SnapTime, WhatSeen, Notes', 'FROM tblCameraTraps',
    "WHERE Zone = 'K7' AND (WhatSeen = 'Vehicle' OR WhatSeen = 'Person');"],
    "SELECT TrapID, SnapDate, SnapTime, WhatSeen, Notes FROM tblCameraTraps WHERE Zone = 'K7' AND (WhatSeen = 'Vehicle' OR WhatSeen = 'Person')",
    lambda r: 'BX' in r[4], 'PLATE STARTS WITH BX')
figs['sql9-bx-gate'] = screen('sql9-bx-gate.svg', ['SELECT LogDate, LogTime, Gate, Plate, Direction', 'FROM tblGateLog', "WHERE Plate LIKE 'BX%'", 'ORDER BY LogDate, LogTime;'],
    "SELECT LogDate, LogTime, Gate, Plate, Direction FROM tblGateLog WHERE Plate LIKE 'BX%' ORDER BY LogDate, LogTime",
    lambda r: r[0] in ('2027-03-12', '2027-03-13') and r[3] == 'BX 48 LM GP', 'BX 48 LM GP: IN 22:50, OUT 03:30 - THE NIGHT TUMELO VANISHED', maxrows=18)
figs['sql9-count'] = screen('sql9-count.svg', ["SELECT COUNT(*), MIN(LogTime), MAX(LogTime), SUM(Passengers)", 'FROM tblGateLog', "WHERE Plate = 'BX 48 LM GP' AND Direction = 'In';"],
    "SELECT COUNT(*), MIN(LogTime), MAX(LogTime), SUM(Passengers) FROM tblGateLog WHERE Plate = 'BX 48 LM GP' AND Direction = 'In'",
    lambda r: True, 'FIVE NIGHT VISITS IN TWO WEEKS')
figs['sql9-shifts'] = screen('sql9-shifts.svg', ['SELECT RangerID, COUNT(*)', 'FROM tblShifts', "WHERE Zone = 'K7'", 'GROUP BY RangerID;'],
    "SELECT RangerID, COUNT(*) FROM tblShifts WHERE Zone = 'K7' GROUP BY RangerID", lambda r: r[0] == 4, 'RANGER 4 ON K7 MORE THAN ANYONE')
figs['sql9-join-owner'] = screen('sql9-join-owner.svg', ['SELECT tblVehicles.Plate, tblPeople.PersonName,', '       tblPeople.Role, tblPeople.Phone',
    'FROM tblVehicles JOIN tblPeople', '  ON tblVehicles.OwnerID = tblPeople.PersonID', "WHERE tblVehicles.Plate = 'BX 48 LM GP';"],
    "SELECT tblVehicles.Plate, tblPeople.PersonName, tblPeople.Role, tblPeople.Phone FROM tblVehicles JOIN tblPeople ON tblVehicles.OwnerID = tblPeople.PersonID WHERE tblVehicles.Plate = 'BX 48 LM GP'",
    lambda r: True, 'OWNER FOUND')

# ---- the JOIN picture: two tables, OwnerID 11 -> PersonID 11
veh = db.execute('SELECT Plate, Make, OwnerID FROM tblVehicles LIMIT 4').fetchall()
ppl = db.execute('SELECT PersonID, PersonName, Role FROM tblPeople WHERE PersonID IN (9, 10, 11, 12)').fetchall()
w, h = 680, 330
s = [f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 {w} {h}" width="{w}" height="{h}">', f'<rect width="{w}" height="{h}" fill="{BG}"/>']
def table(x, title, cols, rows, hot):
    s.append(f'<rect x="{x}" y="40" width="318" height="{60 + 30 * len(rows)}" fill="{DARK}" stroke="{CONTOUR}"/>')
    s.append(f'<text x="{x + 14}" y="64" {MONO} font-size="14" font-weight="600" fill="{GREEN}">{title}</text>')
    s.append(f'<text x="{x + 14}" y="88" {MONO} font-size="12" fill="{DIM}" xml:space="preserve">{esc(cols)}</text>')
    for i, r in enumerate(rows):
        y = 116 + 30 * i
        if hot(r):
            s.append(f'<rect x="{x + 6}" y="{y - 18}" width="306" height="26" fill="{AMBER}"/>')
        s.append(f'<text x="{x + 14}" y="{y}" {MONO} font-size="12.5" fill="{BG if hot(r) else GREEN}" xml:space="preserve">{esc(r)}</text>')
table(12, 'tblVehicles', 'Plate        Make            OwnerID', [f'{a:<12} {b[:14]:<14}  {c:>3}' for a, b, c in veh], lambda r: 'BX 48' in r)
table(350, 'tblPeople', 'PersonID  PersonName      Role', [f'{a:>4}      {b[:14]:<14}  {c}' for a, b, c in ppl], lambda r: 'Musa' in r)
s.append(f'<path d="M316 146 C330 146 336 176 352 176" fill="none" stroke="{AMBER}" stroke-width="3"/>')
s.append(f'<path d="M342 170 l10 6 l-10 6" fill="none" stroke="{AMBER}" stroke-width="3"/>')
s.append(f'<text x="20" y="{h - 52}" {MONO} font-size="13" fill="{AMBER}" font-weight="600">OwnerID 11 in tblVehicles  =  PersonID 11 in tblPeople</text>')
s.append(f'<text x="20" y="{h - 28}" {MONO} font-size="12" fill="{DIM}">JOIN ... ON tblVehicles.OwnerID = tblPeople.PersonID pairs every vehicle with its owner</text>')
s.append('</svg>')
open(os.path.join(out, 'sql9-join-link.svg'), 'w', encoding='utf-8', newline='\n').write('\n'.join(s))
print('figures done')
