"""Tests for tools/block.py put refusals (block-sections-design.md, Phase 3).

Run: python tools/test_block.py
Uses the real lesson pascal9/wakeup, block #4 (the quiz q1Exactly), and never
writes it: every put here is refused, a --dry run, or the same source. Each
test checks the lesson file's bytes are unchanged afterwards. Temp files go
in AIPascalCourse/data/block-tool (gitignored, on D:).
"""
import hashlib, os, shutil, subprocess, sys, tempfile, unittest

sys.dont_write_bytecode = True
HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import block as B  # noqa: E402

COURSE, LESSON, N = "pascal9", "wakeup", "4"
LESSON_FILE = os.path.join(B.CODE, "content", COURSE, LESSON + ".php")
STATE = os.path.join(B.CODE, "data", "block-tool")


def sha(path):
    with open(path, "rb") as f:
        return hashlib.sha256(f.read()).hexdigest()


def run(*args):
    p = subprocess.run([sys.executable, os.path.join(HERE, "block.py")] + list(args), capture_output=True,
                       text=True, encoding="utf-8", errors="replace")
    return p.returncode, p.stdout + p.stderr


class PutRefusals(unittest.TestCase):
    def setUp(self):
        os.makedirs(STATE, exist_ok=True)
        self.tmp = tempfile.mkdtemp(dir=STATE, prefix="test-")
        self.before = sha(LESSON_FILE)
        self.edit = os.path.join(self.tmp, "block.php")
        code, out = run("get", COURSE, LESSON, N, "--out", self.edit)
        self.assertEqual(code, 0, out)
        with open(self.edit, encoding="utf-8", newline="") as f:
            self.source = f.read()
        self.assertIn("'n' => 4", self.source)
        self.assertIn("q1Exactly", self.source)

    def tearDown(self):
        self.assertEqual(sha(LESSON_FILE), self.before, "the lesson file must not change")
        shutil.rmtree(self.tmp, ignore_errors=True)

    def put(self, text, *flags):
        with open(self.edit, "w", encoding="utf-8", newline="") as f:
            f.write(text)
        return run("put", COURSE, LESSON, N, self.edit, *flags)

    def state_file(self):
        return os.path.join(STATE, "%s.%s.%s.sha256" % (COURSE, LESSON, N))

    def test_without_get(self):
        os.remove(self.state_file())
        code, out = self.put(self.source)
        self.assertEqual(code, 1)
        self.assertIn("Run get", out)

    def test_changed_since_get(self):
        with open(self.state_file(), "w") as f:
            f.write("0" * 64)
        code, out = self.put(self.source.replace("Programs have to be exact.", "Programs must be exact."))
        self.assertEqual(code, 1)
        self.assertIn("changed since get", out)

    def test_n_changed(self):
        code, out = self.put(self.source.replace("'n' => 4", "'n' => 99"))
        self.assertEqual(code, 1)
        self.assertIn("number changed", out)

    def test_n_removed(self):
        code, out = self.put(self.source.replace("'n' => 4, ", ""))
        self.assertEqual(code, 1)
        self.assertIn("number changed", out)

    def test_id_changed(self):
        code, out = self.put(self.source.replace("q1Exactly", "q1Renamed"))
        self.assertEqual(code, 1)
        self.assertIn("question id", out)

    def test_lint_fails(self):
        code, out = self.put(self.source.replace("'marks'   => 1,", "'marks'   => 1,,"))
        self.assertEqual(code, 1)
        self.assertIn("php -l failed", out)

    def test_two_blocks(self):
        code, out = self.put(self.source + ",\n['n' => 4, 'type' => 'prose', 'html' => '<p>x</p>']")
        self.assertEqual(code, 1)
        self.assertIn("exactly one block", out)

    def test_form_changed(self):
        code, out = self.put("NumberedBlock (4, " + self.source + ")")
        self.assertEqual(code, 1)
        self.assertIn("form", out)

    def test_empty(self):
        code, out = self.put("   \n")
        self.assertEqual(code, 1)
        self.assertIn("empty", out)

    def test_same_source_is_no_change(self):
        code, out = self.put(self.source + "\n")
        self.assertEqual(code, 0, out)
        self.assertIn("No change", out)

    def test_dry_run_of_a_real_edit_passes(self):
        code, out = self.put(self.source.replace("Programs have to be exact.", "Programs must be exact."), "--dry")
        self.assertEqual(code, 0, out)
        self.assertIn("passes every check", out)


if __name__ == "__main__":
    unittest.main(verbosity=2)
