"""Builds the Grade 9 SQL course's database (the rhino case) as
content/sql/db/reserve.php, and checks every planted clue in SQLite.

Run:  python build_reserve.py <path to content/sql/db/reserve.php>
"""
import random, sqlite3, sys, json

random.seed(2027)
DAYS = [f'2027-03-{d:02d}' for d in range(1, 15)]          # 1-14 March; "today" is 15 March
INSIDER_NIGHTS = ['2027-03-02', '2027-03-05', '2027-03-08', '2027-03-10', '2027-03-12']

def nextday(d):
    n = int(d[-2:]) + 1
    return f'2027-03-{n:02d}'

# ---------------------------------------------------------------- people
people = [  # (name, role, phone)
    ('Thandeka Mokoena', 'Ranger', '082 555 0101'),
    ('Pieter van Wyk',   'Ranger', '082 555 0102'),
    ('Lindiwe Zulu',     'Ranger', '082 555 0103'),
    ('Jabu Nkosi',       'Ranger', '082 555 0104'),   # the inside contact
    ('Kagiso Molefe',    'Ranger', '082 555 0105'),
    ('Ayesha Patel',     'Ranger', '082 555 0106'),
    ('Nomvula Khumalo',  'Guide',  '083 555 0107'),
    ('Ruan Botha',       'Guide',  '083 555 0108'),
    ('Sizwe Ndlovu',     'Guide',  '083 555 0109'),
    ('Grace Mahlangu',   'Contractor', '071 555 0110'),
    ('Musa Dlamini',     'Contractor', '071 555 0111'),  # owns BX 48 LM GP
    ('Johan Smit',       'Contractor', '071 555 0112'),
    ('Fatima Essop',     'Visitor', '084 555 0113'),
    ('Tom Wilson',       'Visitor', '084 555 0114'),
    ('Palesa Sithole',   'Visitor', '084 555 0115'),
    ('Ana Ferreira',     'Visitor', '084 555 0116'),
]
RANGERS = [1, 2, 3, 4, 5, 6]

# ---------------------------------------------------------------- rhinos
rhinos = [  # name, sex, birth year, collar, last date, last time, zone
    ('Themba',  'M', 2012, 'C-01', '2027-03-14', '16:20', 'C3'),
    ('Tumelo',  'F', 2018, 'C-07', '2027-03-12', '17:40', 'K7'),
    ('Naledi',  'F', 2023, 'C-03', '2027-03-14', '09:05', 'C1'),
    ('Bheki',   'M', 2011, 'C-04', '2027-03-13', '18:10', 'D2'),
    ('Lerato',  'F', 2020, 'C-05', '2027-03-14', '07:50', 'C3'),
    ('Sello',   'M', 2016, 'C-06', '2027-03-14', '12:30', 'A2'),
    ('Mpho',    'F', 2015, 'C-02', '2027-03-14', '15:45', 'K5'),
    ('Dumisani','M', 2019, 'C-08', '2027-03-13', '11:00', 'A4'),
    ('Zola',    'F', 2021, 'C-09', '2027-03-14', '10:15', 'D1'),
    ('Kwezi',   'F', 2024, 'C-10', '2027-03-14', '14:00', 'C2'),
]
ZONES = ['A1', 'A2', 'A3', 'A4', 'C1', 'C2', 'C3', 'C4', 'D1', 'D2', 'D3', 'K5', 'K6', 'K7', 'K8']

def t(h, m): return f'{h:02d}:{m:02d}'

# ---------------------------------------------------------------- sightings
sightings = []
for d in DAYS:
    for rid, r in enumerate(rhinos, 1):
        if rid == 2:
            continue
        if d > r[4]:
            continue
        if random.random() < 0.45:
            zone = r[6] if random.random() < 0.7 else random.choice(ZONES)
            if zone == 'K7':
                zone = 'K6'
            sightings.append((rid, d, t(random.randint(6, 17), random.choice([0, 10, 20, 30, 40, 50])), zone, random.choice(RANGERS)))
for d, tm, z, rg in [('2027-03-03', '08:40', 'K6', 3), ('2027-03-06', '15:20', 'K7', 3), ('2027-03-09', '10:10', 'K7', 2),
                     ('2027-03-11', '16:05', 'K7', 3), ('2027-03-12', '09:30', 'K7', 5), ('2027-03-12', '17:40', 'K7', 3)]:
    sightings.append((2, d, tm, z, rg))
sightings.append((7, '2027-03-13', '08:15', 'K7', 1))   # another rhino in K7 after Tumelo vanished
sightings.sort(key=lambda s: (s[1], s[2]))

# ---------------------------------------------------------------- camera traps
ANIMALS = ['Kudu', 'Impala', 'Zebra', 'Warthog', 'Hyena', 'Elephant', 'Giraffe', 'Rhino', 'Leopard']
traps = []
for d in DAYS:
    for _ in range(3):
        z = random.choice(ZONES)
        hr = random.choice([1, 3, 5, 6, 19, 21, 23, 7, 12, 16])
        what = random.choice(ANIMALS)
        note = {'Rhino': 'no collar visible', 'Elephant': 'herd of four', 'Leopard': 'drinking'}.get(what, '')
        traps.append((f'{z}-0{random.randint(1, 3)}', z, d, t(hr, random.choice([5, 15, 25, 35, 45, 55])), what, note))
traps += [
    ('K7-03', 'K7', '2027-03-12', '17:38', 'Rhino', 'collared female, heading east'),
    ('K7-01', 'K7', '2027-03-13', '02:14', 'Vehicle', 'headlights, plate partly visible: BX 4?'),
    ('K7-01', 'K7', '2027-03-13', '02:31', 'Person', 'two people on foot, torches'),
    ('K6-02', 'K6', '2027-03-11', '10:20', 'Person', 'ranger patrol'),
    ('C2-01', 'C2', '2027-03-13', '11:45', 'Vehicle', 'game drive, plate CA 330-118'),
    ('K8-02', 'K8', '2027-03-09', '23:10', 'Person', 'ranger patrol'),
    ('K7-02', 'K7', '2027-03-08', '01:50', 'Vehicle', 'too dark, no plate'),
]
traps.sort(key=lambda r: (r[2], r[3]))

# ---------------------------------------------------------------- vehicles
vehicles = [  # plate, make, colour, owner
    ('BX 21 KP GP', 'Toyota Hilux', 'White', 10),
    ('BX 48 LM GP', 'Nissan Navara', 'Grey', 11),
    ('BX 77 TN GP', 'VW Polo', 'Red', 15),
    ('CA 330-118',  'Land Rover Defender', 'Green', 7),
    ('ND 412-905',  'Toyota Land Cruiser', 'Green', 8),
    ('FS 88 RT GP', 'Ford Ranger', 'Blue', 12),
    ('JHB 501 GP',  'Kia Picanto', 'Silver', 13),
    ('CY 74 HD GP', 'Hyundai i20', 'White', 14),
    ('LM 15 XZ GP', 'Isuzu D-Max', 'White', 9),
    ('GP 62 WW GP', 'Renault Kwid', 'Orange', 16),
]

# ---------------------------------------------------------------- gate log
gate = []  # date, time, gate, plate, direction, reason, passengers
day_plates = [('BX 21 KP GP', 'Fence repair', 2), ('FS 88 RT GP', 'Water pump repair', 1), ('CA 330-118', 'Game drive', 7),
              ('ND 412-905', 'Game drive', 8), ('LM 15 XZ GP', 'Game drive', 6), ('JHB 501 GP', 'Day visit', 3),
              ('CY 74 HD GP', 'Day visit', 2), ('GP 62 WW GP', 'Day visit', 4)]
for d in DAYS:
    for plate, reason, pax in random.sample(day_plates, 3):
        h = random.randint(7, 10)
        gate.append((d, t(h, random.choice([0, 15, 30, 45])), 'Main', plate, 'In', reason, pax))
        gate.append((d, t(h + random.randint(4, 7), random.choice([5, 20, 40])), 'Main', plate, 'Out', reason, pax))
gate.append(('2027-03-06', '09:10', 'Main', 'BX 77 TN GP', 'In', 'Day visit', 2))
gate.append(('2027-03-06', '16:45', 'Main', 'BX 77 TN GP', 'Out', 'Day visit', 2))
night_times = {'2027-03-02': ('22:35', '03:10'), '2027-03-05': ('23:05', '03:40'), '2027-03-08': ('22:20', '02:55'),
               '2027-03-10': ('23:25', '04:05'), '2027-03-12': ('22:50', '03:30')}
for d, (tin, tout) in night_times.items():
    gate.append((d, tin, 'East', 'BX 48 LM GP', 'In', 'Fence repair', 3))
    gate.append((nextday(d), tout, 'East', 'BX 48 LM GP', 'Out', 'Fence repair', 3))
gate.append(('2027-03-07', '21:40', 'East', 'FS 88 RT GP', 'In', 'Emergency pump repair', 1))
gate.append(('2027-03-07', '23:15', 'East', 'FS 88 RT GP', 'Out', 'Emergency pump repair', 1))
gate.sort(key=lambda g: (g[0], g[1]))

# ---------------------------------------------------------------- shifts (night shifts 18:00-06:00, plus the roster ahead)
shifts = []
K_ZONES = ['K5', 'K6', 'K7', 'K8']
for d in DAYS + ['2027-03-15', '2027-03-16']:
    available = [r for r in RANGERS if r != 1]   # Thandeka runs the ops room
    if d in INSIDER_NIGHTS or d == '2027-03-16':
        k7 = 4
    else:
        k7 = random.choice([2, 3, 5, 6])
    others = [r for r in available if r != k7]
    random.shuffle(others)
    for z in K_ZONES:
        rg = k7 if z == 'K7' else others.pop()
        shifts.append((rg, d, z, '18:00', '06:00'))
# Jabu also works some other zones, so he doesn't stand out by count alone
for d in ['2027-03-01', '2027-03-04', '2027-03-11']:
    for i, s in enumerate(shifts):
        if s[1] == d and s[2] == 'K5':
            shifts[i] = (4, d, 'K5', '18:00', '06:00')
            for j, s2 in enumerate(shifts):   # avoid a double booking
                if s2[1] == d and s2[0] == 4 and s2[2] != 'K5':
                    shifts[j] = (5 if s2[0] != 5 else 6, d, s2[2], '18:00', '06:00')

# ---------------------------------------------------------------- phone pings
TOWERS = {'North': ['A1', 'A2', 'A3', 'A4'], 'Central': ['C1', 'C2', 'C3', 'C4'], 'South': ['D1', 'D2', 'D3'], 'East': ['K5', 'K6', 'K7', 'K8']}
pings = []
phones = [p[2] for p in people]
for d in DAYS:
    for _ in range(5):
        ph = random.choice(phones)
        tower = random.choice(list(TOWERS))
        pings.append((ph, d, t(random.randint(6, 20), random.choice([3, 17, 29, 41, 52])), tower, random.choice(TOWERS[tower])))
for d, (tin, tout) in night_times.items():
    nd = nextday(d)
    pings.append(('071 555 0111', nd, '01:5' + str(random.randint(0, 9)), 'East', 'K7'))
    pings.append(('082 555 0104', nd, '01:4' + str(random.randint(0, 9)), 'East', 'K7'))
pings.append(('071 555 0111', '2027-03-13', '02:10', 'East', 'K7'))
pings.append(('082 555 0104', '2027-03-13', '02:12', 'East', 'K7'))
pings.append(('082 555 0103', '2027-03-12', '17:45', 'East', 'K7'))   # Lindiwe, who last saw Tumelo
pings.sort(key=lambda p: (p[1], p[2]))

# ---------------------------------------------------------------- the PHP file
def php(v):
    if v is None: return 'null'
    if isinstance(v, bool): return 'true' if v else 'false'
    if isinstance(v, (int, float)): return repr(v)
    return "'" + str(v).replace("\\", "\\\\").replace("'", "\\'") + "'"

TABLES = [
    ('tblPeople', [("PersonID", 'autonumber'), ("PersonName", 'text', 30), ("Role", 'text', 12), ("Phone", 'text', 14)],
     [(i,) + p for i, p in enumerate(people, 1)]),
    ('tblRhinos', [("RhinoID", 'autonumber'), ("RhinoName", 'text', 20), ("Sex", 'text', 1), ("BirthYear", 'integer'),
                   ("CollarID", 'text', 6), ("LastSeenDate", 'date'), ("LastSeenTime", 'text', 5), ("Zone", 'text', 3)],
     [(i,) + r for i, r in enumerate(rhinos, 1)]),
    ('tblSightings', [("SightingID", 'autonumber'), ("RhinoID", 'integer', 'references', 'tblRhinos'), ("SightDate", 'date'),
                      ("SightTime", 'text', 5), ("Zone", 'text', 3), ("RangerID", 'integer', 'references', 'tblPeople')],
     [(i,) + s for i, s in enumerate(sightings, 1)]),
    ('tblCameraTraps', [("SnapID", 'autonumber'), ("TrapID", 'text', 6), ("Zone", 'text', 3), ("SnapDate", 'date'),
                        ("SnapTime", 'text', 5), ("WhatSeen", 'text', 12), ("Notes", 'text', 50)],
     [(i,) + c for i, c in enumerate(traps, 1)]),
    ('tblVehicles', [("Plate", 'text', 12, 'key'), ("Make", 'text', 24), ("Colour", 'text', 10), ("OwnerID", 'integer', 'references', 'tblPeople')],
     vehicles),
    ('tblGateLog', [("LogID", 'autonumber'), ("LogDate", 'date'), ("LogTime", 'text', 5), ("Gate", 'text', 6),
                    ("Plate", 'text', 12), ("Direction", 'text', 3), ("Reason", 'text', 24), ("Passengers", 'integer')],
     [(i,) + g for i, g in enumerate(gate, 1)]),
    ('tblShifts', [("ShiftID", 'autonumber'), ("RangerID", 'integer', 'references', 'tblPeople'), ("ShiftDate", 'date'),
                   ("Zone", 'text', 3), ("StartTime", 'text', 5), ("EndTime", 'text', 5)],
     [(i,) + s for i, s in enumerate(shifts, 1)]),
    ('tblPhonePings', [("PingID", 'autonumber'), ("Phone", 'text', 14), ("PingDate", 'date'), ("PingTime", 'text', 5),
                       ("Tower", 'text', 8), ("Zone", 'text', 3)],
     [(i,) + p for i, p in enumerate(pings, 1)]),
]

def col_php(c):
    name, typ = c[0], c[1]
    parts = [php(name), php(typ)]
    rest = list(c[2:])
    if rest and isinstance(rest[0], int):
        parts.append(str(rest.pop(0)))
    tail = ''
    if 'references' in rest:
        tail = ", 'references' => " + php(rest[rest.index('references') + 1])
    if 'key' in rest:
        tail += ", 'key' => true"
    return '[' + ', '.join(parts) + tail + ']'

out = ["<?php", "/**",
       " * Sample database: Mabaso Game Reserve - the Grade 9 SQL course's rhino case",
       " * (AIResources/courses/sql9-course.md). Built by a script that plants every clue",
       " * and checks it in SQLite (the build script is kept in AIResources/tools/sql9/).",
       " * Do not edit by hand: change the script and build again.",
       " *",
       " * The clues, in lesson order:",
       " *   1. Tumelo (RhinoID 2, collar C-07) last seen 2027-03-12 17:40 in K7.",
       " *   2. Her sightings stop at 17:40 on 12 March (ranger 3, Lindiwe Zulu).",
       " *   3. Camera trap K7-01: a vehicle at 02:14 on 13 March, 'plate partly visible: BX 4?'.",
       " *   4. Three BX plates in the gate log; BX 48 LM GP in at the East gate 22:50 on 12 March, out 03:30.",
       " *   5. BX 48 LM GP came in at night five times (East gate, 22:20-23:25), 3 passengers each time.",
       " *   6. Night shifts on K7: ranger 4 (Jabu Nkosi) on all five of those nights, and on 16 March.",
       " *   7. JOINs: BX 48 LM GP belongs to Musa Dlamini (contractor, 071 555 0111), whose phone pinged",
       " *      the East tower in K7 at 02:10 on 13 March - two minutes before Jabu's (082 555 0104).",
       " *   8. The final case: Jabu Nkosi is the inside contact; the next strike, 16 March, K7, East gate.",
       " * Times are text 'HH:MM' (the sample format has no time type), so they sort and compare correctly.",
       " */", "", "return [", "    'title'  => 'Mabaso Game Reserve',", "    'tables' => ["]
for name, cols, rows in TABLES:
    out.append(f"        '{name}' => [")
    out.append("            'columns' => [")
    for c in cols:
        out.append('                ' + col_php(c) + ',')
    out.append("            ],")
    out.append("            'rows' => [")
    for r in rows:
        out.append('                [' + ', '.join(php(v) for v in r) + '],')
    out.append("            ],")
    out.append("        ],")
out += ["    ],", "];", ""]
open(sys.argv[1], 'w', encoding='utf-8', newline='\n').write('\n'.join(out))

# ---------------------------------------------------------------- check the clues in SQLite
db = sqlite3.connect(':memory:')
for name, cols, rows in TABLES:
    db.execute(f'CREATE TABLE {name} (' + ', '.join(c[0] for c in cols) + ')')
    db.executemany(f'INSERT INTO {name} VALUES (' + ','.join('?' * len(cols)) + ')', rows)

def q(sql):
    return db.execute(sql).fetchall()

checks = json.load(open(sys.argv[2], encoding='utf-8')) if len(sys.argv) > 2 else {}
fails = 0
for key, (sql, want) in checks.items():
    got = q(sql)
    gotj = json.loads(json.dumps(got))
    if want is not None and gotj != want:
        fails += 1
        print('FAIL', key, '\n  sql:', sql, '\n  got:', gotj[:12], '\n  want:', want)
    else:
        print('ok  ', key, '->', gotj[:6], ('... +%d' % (len(gotj) - 6)) if len(gotj) > 6 else '')
print({n: len(r) for n, _, r in TABLES})
print('FAILS:', fails)

json.dump({name: {'columns': [c[0] for c in cols], 'rows': rows} for name, cols, rows in TABLES},
          open('reserve.json', 'w', encoding='utf-8'))
