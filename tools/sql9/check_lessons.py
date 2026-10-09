import re, json, sqlite3
data = json.load(open('reserve.json', encoding='utf-8'))
db = sqlite3.connect(':memory:')
for name, t in data.items():
    db.execute(f'CREATE TABLE {name} (' + ', '.join(t['columns']) + ')')
    db.executemany(f'INSERT INTO {name} VALUES (' + ','.join('?' * len(t['columns'])) + ')', t['rows'])
pat = re.compile(r"""'(answer|sql)'\s*=>\s*("(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*')""")
import sys
LESSONS = sys.argv[1] if len(sys.argv) > 1 else 'lessons'
order = ['collar', 'where', 'traps', 'gate', 'pattern', 'duty', 'connect', 'nextnight']
bad = 0
for les in order:
    src = open(f'{LESSONS}/{les}.php', encoding='utf-8').read()
    for kind, lit in pat.findall(src):
        body = lit[1:-1]
        if body.strip() == "":
            continue   # an empty guided try-it box: its answer is checked instead
        if lit[0] == '"':
            body = body.replace('\\n', '\n').replace('\\"', '"')
        else:
            body = body.replace("\\'", "'")
        try:
            rows = db.execute(body.rstrip(';')).fetchall()
            print(f'{les:10} {kind:6} {len(rows):3} rows  {str(rows[:3])[:110]}')
        except Exception as e:
            bad += 1
            print('ERROR', les, kind, e, body)
print('errors:', bad)
