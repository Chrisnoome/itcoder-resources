"""Unit tests for tasks.py. Run: python test_tasks.py  (works on temp copies only)."""
import difflib, os, shutil, sys, tempfile, unittest

sys.dont_write_bytecode = True
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tasks as T

SAMPLE = """# Open items

## Urgent

- Rotate the secret.
- Stop the VM.

Some prose that is not a task.

## Platform

- **First item** (date). More words
  on a second line.
  1. a sub point
  2. another

- **Second item** - short.

- **Teardown** - only if needed:

      rm -rf /var/www/x
      nginx -t

## Content

- Tagged one {area: content; p: 2; status: open}
- Another one
"""


def diff(a, b):
    return [l for l in difflib.unified_diff(a.splitlines(), b.splitlines(), lineterm="", n=0)
            if l[:1] in "+-" and not l.startswith(("+++", "---"))]


class Base(unittest.TestCase):
    def setUp(self):
        self.dir = tempfile.mkdtemp()
        self.path = os.path.join(self.dir, "open-items.md")
        self.write(SAMPLE)

    def tearDown(self):
        shutil.rmtree(self.dir)

    def write(self, s, nl="\n"):
        with open(self.path, "wb") as f:
            f.write(s.replace("\n", nl).encode("utf-8"))

    def text(self):
        with open(self.path, "rb") as f:
            return f.read().decode("utf-8")

    def tasks(self):
        return T.load(self.path)[0]

    def find(self, title):
        return next(t for t in self.tasks() if t["title"].startswith(title))


class ParseTests(Base):
    def test_bullets_and_ranges(self):
        ts = self.tasks()
        self.assertEqual([t["title"] for t in ts],
                         ["Rotate the secret", "Stop the VM", "First item", "Second item", "Teardown", "Tagged one", "Another one"])
        first = ts[2]
        self.assertEqual((first["start"], first["end"]), (12, 15))
        self.assertIn("1. a sub point", first["brief"])
        self.assertEqual(ts[4]["end"], 22)
        self.assertEqual(ts[0]["section"], "Urgent")

    def test_tags_and_inbox(self):
        t = self.find("Tagged one")
        self.assertEqual((t["area"], t["p"], t["status"], t["tagged"]), ("content", 2, "open", True))
        self.assertNotIn("{", t["brief"])
        self.assertEqual(self.find("Another")["area"], "inbox")

    def test_ids_stable_when_tagged(self):
        before = self.find("Another")["id"]
        T.set_tag(before, {"area": "fun", "p": 3}, path=self.path)
        self.assertEqual(self.find("Another")["id"], before)

    def test_real_file_parses(self):
        ts = T.load()[0]
        self.assertGreater(len(ts), 50)
        self.assertEqual(len({t["id"] for t in ts}), len(ts))


class WriteTests(Base):
    def test_add_tag_is_one_line(self):
        before = self.text()
        t = self.find("First item")
        T.set_tag(t["id"], {"area": "marking", "p": 1}, expect=t["hash"], path=self.path)
        d = diff(before, self.text())
        self.assertEqual(d, ["-  on a second line.", "+  on a second line.", "-  2. another",
                             "+  2. another {area: marking; p: 1; status: open}"][2:])

    def test_tag_skips_code_lines(self):
        before = self.text()
        T.set_tag(self.find("Teardown")["id"], {"area": "admin", "p": 3}, path=self.path)
        d = diff(before, self.text())
        self.assertEqual(d, ["-- **Teardown** - only if needed:",
                             "+- **Teardown** - only if needed: {area: admin; p: 3; status: open}"])
        self.assertEqual(self.find("Teardown")["area"], "admin")

    def test_replace_tag(self):
        before = self.text()
        t = self.find("Tagged one")
        T.set_tag(t["id"], {"status": "running", "session": "abc123"}, path=self.path)
        self.assertEqual(diff(before, self.text()),
                         ["-- Tagged one {area: content; p: 2; status: open}",
                          "+- Tagged one {area: content; p: 2; status: running; session: abc123}"])
        T.set_tag(t["id"], {"status": "queued"}, path=self.path)
        self.assertIn("- Tagged one {area: content; p: 2; status: queued}\n", self.text())

    def test_add_task_appends_only(self):
        before = self.text()
        tid = T.add_task("Content", "New thing", "Do it well.", area="pupil", p=2, path=self.path)
        d = diff(before, self.text())
        self.assertEqual(d, ["+- **New thing** - Do it well. {area: pupil; p: 2; status: open}"])
        self.assertEqual(self.tasks()[-1]["id"], tid)
        T.add_task("Platform", "Spaced", path=self.path)
        self.assertIn("      nginx -t\n\n- **Spaced** {status: open}\n\n## Content", self.text())

    def test_edit_brief_round_trip_and_change(self):
        before = self.text()
        t = self.find("First item")
        T.edit_brief(t["id"], t["brief"], expect=t["hash"], path=self.path)
        self.assertEqual(before, self.text())
        t = self.find("Teardown")
        T.set_tag(t["id"], {"area": "admin"}, path=self.path)
        t = self.find("Teardown")
        mid = self.text()
        T.edit_brief(t["id"], t["brief"].replace("only if needed", "only when needed"), path=self.path)
        d = diff(mid, self.text())
        self.assertEqual(len(d), 2)
        self.assertIn("{area: admin; status: open}", d[1])

    def test_done_moves_to_section_end(self):
        t = self.find("First item")
        T.set_tag(t["id"], {"status": "done"}, path=self.path)
        ts = [x for x in self.tasks() if x["section"] == "Platform"]
        self.assertEqual([x["title"] for x in ts], ["Second item", "Teardown", "First item"])
        self.assertEqual(ts[-1]["status"], "done")
        self.assertNotIn("\n\n\n", self.text())

    def test_conflict_when_lines_changed(self):
        t = self.find("Second item")
        self.write(SAMPLE.replace("short.", "short and changed."))
        before = self.text()
        with self.assertRaises((T.Conflict, T.NotFound)):
            T.set_tag(t["id"], {"area": "fun"}, expect=t["hash"], path=self.path)
        t2 = self.find("Second item")
        with self.assertRaises(T.Conflict):
            T.set_tag(t2["id"], {"area": "fun"}, expect="stale", path=self.path)
        self.assertEqual(before, self.text())

    def test_bad_values_refused(self):
        t = self.find("Another")
        for ch in ({"area": "nope"}, {"p": 7}, {"status": "later"}, {"colour": "red"}):
            with self.assertRaises(ValueError):
                T.set_tag(t["id"], ch, path=self.path)

    def test_crlf_kept(self):
        self.write(SAMPLE, "\r\n")
        T.set_tag(self.find("Another")["id"], {"area": "fun"}, path=self.path)
        T.add_task("Urgent", "X", path=self.path)
        with open(self.path, "rb") as f:
            raw = f.read()
        self.assertEqual(raw.count(b"\n"), raw.count(b"\r\n"))

    def test_apply_proposal(self):
        prop = os.path.join(self.dir, "prop.md")
        rows = ["| Line | Id | Title | Area | P |", "|---|---|---|---|---|"]
        for t in self.tasks():
            rows.append("| %d | `%s` | %s | %s | %d |" % (t["start"], t["id"], t["title"], "testing", 2))
        with open(prop, "w", encoding="utf-8") as f:
            f.write("\n".join(rows) + "\n")
        n, skipped = T.apply_proposal(self.path, prop)
        self.assertEqual(n, 6)  # "Tagged one" already had a tag
        self.assertEqual(len(skipped), 1)
        self.assertTrue(all(t["tagged"] for t in self.tasks()))

    def test_real_copy_brief_round_trip(self):
        shutil.copy(T.OPEN_ITEMS, self.path)
        before = self.text()
        for t in self.tasks():
            T.edit_brief(t["id"], t["brief"], expect=t["hash"], path=self.path)
        self.assertEqual(diff(before, self.text()), [])

    def test_real_copy_minimal(self):
        shutil.copy(T.OPEN_ITEMS, self.path)
        before = self.text()
        ts = self.tasks()
        T.set_tag(ts[0]["id"], {"area": "admin", "p": 1}, expect=ts[0]["hash"], path=self.path)
        T.add_task("Operations", "Control centre smoke test", "Temp copy only.", area="admin", p=3, path=self.path)
        d = diff(before, self.text())
        self.assertEqual(len(d), 3, d)


if __name__ == "__main__":
    unittest.main(verbosity=1)
