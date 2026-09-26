"""Write l24/part1b.php: every Java source of lesson 24 as a PHP nowdoc,
exactly as compiled (src, src2, src2fx)."""
import os
HERE = os.path.dirname(os.path.abspath(__file__))
FILES = [
    ('bookingJava', 'src/Booking.java'),
    ('mainFormJava', 'src/MainForm.java'),
    ('mainAppJava', 'src/MainApp.java'),
    ('notesFormJava', 'src/NotesForm.java'),
    ('notesAppJava', 'src/NotesApp.java'),
    ('tuckShopFormJava', 'src/TuckShopForm.java'),
    ('tuckShopAppJava', 'src/TuckShopApp.java'),
    ('formsMainJava', 'src2/MainForm.java'),
    ('detailsDialogJava', 'src2/DetailsDialog.java'),
    ('seatsFormJava', 'src2/SeatsForm.java'),
    ('fxMainJava', 'src2fx/MainApp.java'),
    ('detailsWindowJava', 'src2fx/DetailsWindow.java'),
    ('seatsWindowJava', 'src2fx/SeatsWindow.java'),
]
out = ['', '/* The programs of this lesson, exactly as they were compiled (JDK 21 and',
       '   OpenJFX 21) and run for the screenshots. */']
for var, path in FILES:
    text = open(os.path.join(HERE, path), encoding='utf-8').read().rstrip('\n')
    assert '\nJAVA' not in text
    out.append('$%s = <<<\'JAVA\'\n%s\nJAVA;\n' % (var, text))
open(os.path.join(HERE, 'part1b.php'), 'w', encoding='utf-8', newline='\n').write('\n'.join(out))
print('ok', len(FILES))
