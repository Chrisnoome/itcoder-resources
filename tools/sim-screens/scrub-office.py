"""Takes the Office account's name out of Office files - the CAT VM's Office
is signed in as Chris, and Word, Excel and PowerPoint write that name into
every file they save (docProps/core.xml creator / lastModifiedBy, and on
tracked changes and comments). Found 9 October 2026 in 75 starter and test
files; setting a local user name in the VM does not stop it. Run it on every
folder of files that came out of the VM, before they are committed:

    python scrub-office.py <folder or file> ... [--fix]

Without --fix it only lists the files that still carry the name.
"""
import os, re, sys, zipfile

NAMES = [b'Chris Noome', b'Noome', b'chris.noome']

def files(paths):
    for p in paths:
        if os.path.isdir(p):
            for d, _, fs in os.walk(p):
                for f in fs:
                    yield os.path.join(d, f)
        else:
            yield p

def has_name(data):
    low = data.lower()
    return any(n.lower() in low for n in NAMES)

def scrub(path, fix):
    try:
        z = zipfile.ZipFile(path)
    except zipfile.BadZipFile:
        return False
    with z:
        bad = [i.filename for i in z.infolist() if has_name(z.read(i.filename))]
    if bad and fix:
        tmp = path + '.tmp'
        with zipfile.ZipFile(path) as zin, zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as zout:
            for i in zin.infolist():
                data = zin.read(i.filename)
                if i.filename in bad:
                    data = re.sub(rb'(<dc:creator>|<cp:lastModifiedBy>)[^<]*(</)', rb'\1BestLessons\2', data)
                    for n in NAMES:
                        data = re.sub(re.escape(n), b'BestLessons', data, flags=re.I)
                zout.writestr(i, data)
        os.replace(tmp, path)
    return bool(bad)

fix = '--fix' in sys.argv
found = [p for p in files(a for a in sys.argv[1:] if a != '--fix')
         if re.search(r'\.(docx|docm|xlsx|xlsm|pptx|pptm)$', p, re.I) and scrub(p, fix)]
for p in found:
    print(('fixed  ' if fix else 'NAME   ') + p)
print(len(found), 'file(s)', 'fixed' if fix else 'with the name')
sys.exit(1 if found and not fix else 0)
