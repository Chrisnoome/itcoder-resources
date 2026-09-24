# Local side: upload a .pas, run it on the server in a pty, save raw output.
# usage: python crt.py prog.pas keys.json out.ans
import sys, json, base64, os
sys.dont_write_bytecode = True
sys.path.insert(0, r'D:\DB Sync\Dropbox\Projects\AIResources\tools')
import vps
src, keysfile, outfile = sys.argv[1], sys.argv[2], sys.argv[3]
keys = open(keysfile).read() if os.path.exists(keysfile) else keysfile
here = os.path.dirname(os.path.abspath(__file__))
vps.put(os.path.join(here, 'ptyrun.py'), '/tmp/claude-ui/ptyrun.py')
name = os.path.basename(src)
vps.put(os.path.abspath(src), '/tmp/claude-ui/' + name)
code, text = vps.run("cd /tmp/claude-ui && python3 ptyrun.py " + name + " '" + keys.replace("'", "'\''") + "'")
raw = None
snaps = []
for line in text.splitlines():
    if line.startswith('RAW '): raw = base64.b64decode(line[4:])
    elif line.startswith('WARNINGS '): print(line)
    elif line.startswith('SNAPS '): snaps = json.loads(line[6:])
    else: print(line)
if raw is not None:
    open(outfile, 'wb').write(raw)
    print('saved', len(raw), 'bytes')
    for name, n in snaps:
        open(outfile[:-4] + '-' + name + '.ans', 'wb').write(raw[:n]); print('snap', name, n)
