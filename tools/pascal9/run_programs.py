"""Compile and run every Station Kestrel program with local Free Pascal.

The programs live in AIPascalCourse/content/pascal9/programs/*.pas (the lessons
load them from there, so what a lesson shows is what was run). Each one is
compiled with the site's own flags (-Mdelphi -O1) and run with the inputs in
RUNS below. Outputs go to tools/pascal9/out/<name>-<n>.txt; the compiler's
messages for the broken ones go to out/<name>-compile.txt.

  python -X utf8 tools/pascal9/run_programs.py            every program
  python -X utf8 tools/pascal9/run_programs.py l5-oxygen  just one

Crt programs run here too, but Windows' Crt writes to the console, not the
pipe - their screens are captured on the server by capture_screens.py.
"""
import os, sys, subprocess, shutil, tempfile

sys.dont_write_bytecode = True
HERE = os.path.dirname(os.path.abspath(__file__))
PROGRAMS = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\content\pascal9\programs'
FPC = r'C:\lazarus\fpc\3.2.2\bin\x86_64-win64\fpc.exe'
OUT = os.path.join(HERE, 'out')

# The inputs each program is run with - one run per string ('' = no input).
RUNS = {
    'l1-hello': [''], 'l1-twolines': [''], 'l1-boot': [''], 'l1-boot-start': [''],
    'l2-write': [''], 'l2-apostrophe': [''], 'l2-numbers': [''], 'l2-patch': [''], 'l2-patch-start': [''],
    'l4-lockers': [''], 'l4-readln': ['Thandi\n'],
    'l4-checkin': ['Sipho\nbotanist\n', 'Lena\npilot\n'], 'l4-checkin-start': ['Sipho\nbotanist\n'],
    'l5-types': [''], 'l5-maths': [''],
    'l5-oxygen': ['6\n18000\n', '4\n10000\n', '3\n5000\n'], 'l5-oxygen-start': ['6\n18000\n'],
    'l6-divmod': [''], 'l6-round': [''],
    'l6-rations': ['125\n6\n2000\n', '40\n6\n75\n', '60\n5\n59\n'], 'l6-rations-start': ['125\n6\n2000\n'],
    'l7-const': [''], 'l7-meteor': [''],
    'l7-burn': ['1500\n6\n', '900\n4\n', '1000\n3\n'], 'l7-burn-start': ['1500\n6\n'],
    'l8-ifelse': ['101\n', '80\n'],
    'l9-andor': ['101\nY\n', '101\nN\n'], 'l9-elseif': ['75\n', '30\n', '5\n'],
    'l9-status': ['22\n600\n', '28\n600\n', '22\n2500\n', '12\n1500\n', '18\n999\n', '30\n1000\n'],
    'l9-status-start': ['22\n600\n'],
    'l10-case': ['2\n', '7\n'], 'l10-case-ranges': ['55\ny\n', '120\nq\n'],
    'l10-console': ['1\n', '2\n6\n18000\n', '3\n2000\n', '4\n80\n', '9\n'],
    'l10-console-start': ['1\n', '2\n6\n18000\n'],
    'l11-docking': ['300\n1.5\n500\n', '300\n2.5\n500\n', '900\n1\n500\n', '200\n2\n80\n'],
    'l11-docking-start': ['300\n1.5\n500\n'],
}
BROKEN = ['l1-typo', 'l1-err-quote', 'l1-err-semicolon']
CRT = ['l3-colour', 'l3-background', 'l3-gotoxy', 'l3-delay', 'l3-alert', 'l3-alert-start', 'l8-airlock',
       'l8-airlock-start', 'l12-docking']


def compile_one(name, folder):
    """Compile programs/<name>.pas in folder; give back (ok, messages, exe)."""
    pas = os.path.join(folder, name.replace('-', '_') + '.pas')
    shutil.copy(os.path.join(PROGRAMS, name + '.pas'), pas)
    r = subprocess.run([FPC, '-Mdelphi', '-O1', os.path.basename(pas)], cwd=folder,
                       capture_output=True, text=True)
    lines = [l for l in r.stdout.splitlines() if ('Error' in l or 'Fatal' in l or 'Warning' in l or 'Note' in l)]
    return r.returncode == 0, '\n'.join(lines), pas[:-4] + '.exe'


def main():
    only = sys.argv[1:]
    os.makedirs(OUT, exist_ok=True)
    folder = tempfile.mkdtemp(prefix='kestrel-')
    names = sorted(n[:-4] for n in os.listdir(PROGRAMS) if n.endswith('.pas'))
    bad = 0
    for name in names:
        if only and name not in only:
            continue
        ok, messages, exe = compile_one(name, folder)
        if name in BROKEN:
            open(os.path.join(OUT, name + '-compile.txt'), 'w', encoding='utf-8').write(messages + '\n')
            print(f'{name:22} broken on purpose: {messages.splitlines()[0] if messages else "COMPILED?!"}')
            if ok:
                bad += 1
            continue
        if not ok:
            print(f'{name:22} COMPILE FAILED\n{messages}')
            bad += 1
            continue
        if messages:
            print(f'{name:22} compiler says: {messages}')
        if name in CRT:
            print(f'{name:22} compiled (Crt - screen captured on the server)')
            continue
        for index, given in enumerate(RUNS.get(name, [''])):
            r = subprocess.run([exe], input=given, capture_output=True, text=True, timeout=10)
            out = r.stdout.replace('\r\n', '\n')
            open(os.path.join(OUT, f'{name}-{index + 1}.txt'), 'w', encoding='utf-8').write(out)
            print(f'--- {name} run {index + 1} input {given!r}')
            print(out.rstrip())
    shutil.rmtree(folder, ignore_errors=True)
    print('problems:', bad)
    sys.exit(1 if bad else 0)


main()
