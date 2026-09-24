# Server side: compile a Pascal file and run it in an 80x25 pty, typing keys.
# usage: python3 ptyrun.py prog.pas '[[0.5,"1"],[0.5,"Thabo\r"]]'
import os, pty, sys, time, json, select, struct, fcntl, termios, subprocess, base64
src, keys = sys.argv[1], json.loads(sys.argv[2])
os.chdir(os.path.dirname(os.path.abspath(src)))
r = subprocess.run(['fpc', '-Mobjfpc', '-O1', os.path.basename(src)], capture_output=True, text=True)
exe = os.path.abspath(src[:-4])
if r.returncode != 0 or not os.path.exists(exe):
    print('COMPILE FAILED'); print(r.stdout[-3000:]); sys.exit(1)
warn = [l for l in r.stdout.splitlines() if 'Warning' in l or 'Note' in l or 'Hint' in l]
pid, fd = pty.fork()
if pid == 0:
    fcntl.ioctl(0, termios.TIOCSWINSZ, struct.pack('HHHH', 25, 80, 0, 0))
    os.environ.update({'TERM': 'xterm', 'LANG': 'C.UTF-8', 'HOME': '/tmp'})
    os.execv(exe, [exe])
out = b''
import re
def cursor(data):
    row = col = 0
    i = 0
    while i < len(data):
        m = re.match(rb'\[([0-9;?]*)([A-Za-z])', data[i:])
        if m:
            nums = [int(x) for x in m.group(1).split(b';') if x.isdigit()]
            f = m.group(2)
            if f in (b'H', b'f'):
                row = (nums[0] if len(nums) > 0 else 1) - 1; col = (nums[1] if len(nums) > 1 else 1) - 1
            elif f == b'A': row = max(0, row - (nums[0] if nums else 1))
            elif f == b'B': row = min(24, row + (nums[0] if nums else 1))
            elif f == b'C': col = min(79, col + (nums[0] if nums else 1))
            elif f == b'D': col = max(0, col - (nums[0] if nums else 1))
            elif f == b'J' and nums and nums[0] == 2: row = col = 0
            i += len(m.group(0)); continue
        c = data[i]
        if c == 10: row = min(24, row + 1)
        elif c == 13: col = 0
        elif c == 8: col = max(0, col - 1)
        elif c >= 32 and c != 127 and (c < 128 or c >= 192):
            if col >= 80: col = 0; row = min(24, row + 1)
            col += 1
        i += 1
    return row, min(col, 79)
answered = 0
def pump(seconds):
    global out, answered
    end = time.time() + seconds
    while True:
        left = end - time.time()
        if left <= 0: return True
        rl, _, _ = select.select([fd], [], [], left)
        if rl:
            try: data = os.read(fd, 65536)
            except OSError: return False
            if not data: return False
            out += data
            while out.count(b'[6n') > answered:
                cut = out.find(b'[6n'); n = answered
                pos = -1
                for _ in range(n + 1): pos = out.find(b'[6n', pos + 1)
                r_, c_ = cursor(out[:pos])
                os.write(fd, ('[%d;%dR' % (r_ + 1, c_ + 1)).encode())
                answered += 1
snaps = []
for delay, text in keys:
    if not pump(delay): break
    if text.startswith('@@SNAP:'):
        snaps.append((text[7:], len(out))); continue
    os.write(fd, text.encode('latin-1'))
pump(2.0)
try: os.kill(pid, 9)
except Exception: pass
print('WARNINGS', json.dumps(warn))
print('SNAPS', json.dumps(snaps))
print('RAW', base64.b64encode(out).decode())
