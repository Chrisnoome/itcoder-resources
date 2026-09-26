import os
HERE = os.path.dirname(os.path.abspath(__file__))
lines = [line.rstrip('\r\n') for line in open(os.path.join(HERE, 'masktable.txt'), encoding='utf-8') if line.strip()]
rows = '\n'.join(lines).rstrip(',')
assert all(32 <= ord(c) < 127 or c == '\n' for c in rows), 'odd characters'
head = """// Run: node public/assets/java-tryit-ui.test.js
// Checks javaMaskLab's model against real runs: keys typed one at a time into
// a JFormattedTextField with a MaskFormatter, placeholder '_' (JDK 21,
// scratchpad l24/test/MaskTable.java, 25 September 2026). Each row: the mask,
// setValueContainsLiteralCharacters, the keys, what the box showed, and
// getValue() after commitEdit() (null when it threw a ParseException).
var model = require ('./java-tryit-ui.js');
var failures = 0;

var RUNS = [
"""
tail = """
];

RUNS.forEach (function (run) {
    var r = model.TypeIntoMask (run[0], run[1], run[2]);
    if (r.text !== run[3] || r.value !== run[4]) {
        failures++;
        console.log ('FAIL ' + run[0] + ' / ' + run[2] + ': got [' + r.text + '] ' + r.value + ', Java gave [' + run[3] + '] ' + run[4]);
    }
});

if (failures > 0) { console.log (failures + ' failed'); process.exit (1); }
console.log ('javaMaskLab: all ' + RUNS.length + ' MaskFormatter runs match');
"""
out = r'D:\DB Sync\Dropbox\Projects\AIPascalCourse\public\assets\java-tryit-ui.test.js'
open(out, 'w', encoding='utf-8', newline='\n').write(head + rows + tail)
print('written', len(lines), 'runs')
