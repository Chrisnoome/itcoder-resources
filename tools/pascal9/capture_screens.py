"""Capture the Station Kestrel screens from real runs on the server.

Each screen is a program from AIPascalCourse/content/pascal9/programs/ compiled
and run in an 80x25 pty on the VPS by tools/ui-screens/crt/crt.py (the same
tool as Pascal lesson 22), with the keys typed below. The raw output is saved
as content/pascal9/screens/<screen>.ans; the lessons draw it with
TerminalScreen() (KestrelScreen() in content/pascal9/helpers.php). Typed input
is echoed by the terminal, so the screens show what the pupil would type.

  python -X utf8 tools/pascal9/capture_screens.py           every screen
  python -X utf8 tools/pascal9/capture_screens.py l8-open   just one
"""
import os, sys, json, subprocess

sys.dont_write_bytecode = True
HERE = os.path.dirname(os.path.abspath(__file__))
CRT = os.path.join(HERE, '..', 'ui-screens', 'crt', 'crt.py')
PROGRAMS = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\content\pascal9\programs'
SCREENS = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\content\pascal9\screens'


def typed(*answers):
    """Keys for crt.py: each answer typed after a short pause, then Enter."""
    return json.dumps([[0.6, answer + '\r'] for answer in answers] + [[0.6, '']])


# screen name: (program, keys)
SCREEN_LIST = {
    'l1-boot':        ('l1-boot', typed()),
    'l2-patch':       ('l2-patch', typed()),
    'l3-colour':      ('l3-colour', typed()),
    'l3-background':  ('l3-background', typed()),
    'l3-gotoxy':      ('l3-gotoxy', typed()),
    'l3-delay':       ('l3-delay', json.dumps([[2.5, '']])),
    'l3-alert':       ('l3-alert', typed()),
    'l4-readln':      ('l4-readln', typed('Thandi')),
    'l4-checkin':     ('l4-checkin', typed('Sipho', 'botanist')),
    'l5-oxygen':      ('l5-oxygen', typed('6', '18000')),
    'l6-rations':     ('l6-rations', typed('125', '6', '2000')),
    'l7-burn':        ('l7-burn', typed('1500', '6')),
    'l8-open':        ('l8-airlock', typed('101')),
    'l8-locked':      ('l8-airlock', typed('80')),
    'l8-high':        ('l8-airlock', typed('120')),
    'l9-clear':       ('l9-status', typed('22', '600')),
    'l9-alarm':       ('l9-status', typed('12', '1500')),
    'l10-console':    ('l10-console', typed('2', '6', '18000')),
    'l11-docking':    ('l11-docking', typed('300', '1.5', '500')),
    'l12-dock':       ('l12-docking', typed('300', '1.5', '500')),
    'l12-slow':       ('l12-docking', typed('300', '2.5', '500')),
    'l12-abort':      ('l12-docking', typed('900', '1', '500')),
}


def main():
    only = sys.argv[1:]
    os.makedirs(SCREENS, exist_ok=True)
    sys.path.insert(0, os.path.join(HERE, '..'))
    import vps
    vps.run('mkdir -p /tmp/claude-ui')   # crt.py's folder on the server; /tmp is emptied on reboot
    for screen, (program, keys) in SCREEN_LIST.items():
        if only and screen not in only:
            continue
        # crt.py names the file on the server after the source: one name per program.
        source = os.path.join(HERE, 'out', program.replace('-', '_') + '.pas')
        os.makedirs(os.path.dirname(source), exist_ok=True)
        with open(os.path.join(PROGRAMS, program + '.pas'), encoding='utf-8') as f:
            text = f.read()
        with open(source, 'w', encoding='utf-8', newline='\n') as f:
            f.write(text)
        target = os.path.join(SCREENS, screen + '.ans')
        r = subprocess.run([sys.executable, '-X', 'utf8', CRT, source, keys, target], capture_output=True, text=True)
        print(f'{screen:14} {r.stdout.strip().splitlines()[-1] if r.stdout.strip() else r.stderr.strip()[-300:]}')


main()
