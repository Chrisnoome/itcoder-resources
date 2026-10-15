#!/usr/bin/env python
"""Tasks from open-items.md for the control centre (control-centre-design.md).

  python tasks.py                    list tasks (id, section, tag, title)
  python tasks.py --json             the same as JSON
  python tasks.py --apply-proposal   add the tags in tag-proposal.md to open-items.md

A task is a top-level bullet ("- " at column 0) in open-items.md. It runs on
over indented lines and blank lines until the next top-level bullet, heading or
unindented line. Its tag is a trailing `{area: x; p: 1; status: open}` on one
of its lines (normally the last text line). Untagged tasks are area "inbox".

Every write re-reads the file, finds the task by id, checks its lines still
match what the caller saw (when `expect` is given), changes only those lines
and checks the file did not change in between. It never rewrites the file from
a model: other chats edit open-items.md too (CLAUDE.md rule 5).
"""
import hashlib, json, os, re, sys, tempfile, time

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(os.path.dirname(HERE))
OPEN_ITEMS = os.environ.get("CONTROL_CENTRE_OPEN_ITEMS") or os.path.join(ROOT, "open-items.md")  # override for tests
PROPOSAL = os.path.join(HERE, "tag-proposal.md")

AREAS = ["commercialisation", "marking", "content", "teacher", "pupil", "testing", "fun", "admin"]
STATUSES = ["open", "queued", "running", "done"]
TAG_RE = re.compile(r"\s*\{((?:area|p|status|session)\s*:[^{}]*)\}\s*$")


class Conflict(Exception):
    """The file changed under us; nothing was written."""


class NotFound(Exception):
    pass


# ---------- reading ----------

def read_raw(path=OPEN_ITEMS):
    with open(path, "rb") as f:
        return f.read()


def split_lines(raw):
    """Lines keep their own endings, so a write changes only what it touches."""
    return raw.decode("utf-8").splitlines(keepends=True)


def strip_eol(s):
    return s.rstrip("\r\n")


def parse_tag(text):
    m = TAG_RE.search(text)
    if not m:
        return None, text
    tag = {}
    for part in m.group(1).split(";"):
        if ":" in part:
            k, v = part.split(":", 1)
            tag[k.strip()] = v.strip()
    return tag, text[: m.start()]


def format_tag(tag):
    keys = ["area", "p", "status", "session"]
    parts = ["%s: %s" % (k, tag[k]) for k in keys if tag.get(k) not in (None, "")]
    return "{" + "; ".join(parts) + "}"


def task_id(first_line):
    _, text = parse_tag(strip_eol(first_line))
    return hashlib.sha1(text.strip().encode("utf-8")).hexdigest()[:10]


def lines_hash(lines):
    return hashlib.sha1("".join(strip_eol(l) + "\n" for l in lines).encode("utf-8")).hexdigest()[:12]


def make_title(first_text):
    t = first_text[2:].strip()
    m = re.match(r"\*\*(.+?)\*\*", t)
    if m:
        t = m.group(1)
    elif t.startswith("**"):  # bold runs on to the next line
        t = re.split(r"\s-\s|\s\(", t[2:], maxsplit=1)[0]
    else:
        t = re.split(r"(?<=[.!?])\s|\s\(", t, maxsplit=1)[0]
    t = re.sub(r"\[([^\]]+)\]\([^)]*\)", r"\1", t).replace("`", "").strip(" .:-")
    return t if len(t) <= 110 else t[:107].rstrip() + "..."


def parse(lines):
    """Returns (tasks, sections). Line numbers are 1-based and inclusive."""
    tasks, sections, ids = [], [], {}
    section, cur = None, None

    def close(end):
        nonlocal cur
        if cur is None:
            return
        while end >= cur["start"] and not strip_eol(lines[end - 1]).strip():
            end -= 1
        cur["end"] = end
        body = [strip_eol(l) for l in lines[cur["start"] - 1:end]]
        tag, tag_line = None, None
        for i, l in enumerate(body):
            t, _ = parse_tag(l)
            if t is not None:
                tag, tag_line = t, cur["start"] + i
        clean = []
        for i, l in enumerate(body):
            if cur["start"] + i == tag_line:
                l = parse_tag(l)[1]
            clean.append(l[2:] if i == 0 else (l[2:] if l.startswith("  ") else l))
        cur["brief"] = "\n".join(clean).strip()
        cur["title"] = make_title(parse_tag(body[0])[1])
        cur["tag_line"] = tag_line
        tag = dict(tag or {})
        cur["tagged"] = bool(tag)
        cur["area"] = tag.get("area") or "inbox"
        try:
            cur["p"] = int(tag["p"]) if tag.get("p") else None
        except ValueError:
            cur["p"] = None
        cur["status"] = tag.get("status") or "open"
        cur["session"] = tag.get("session")
        cur["hash"] = lines_hash(lines[cur["start"] - 1:end])
        tasks.append(cur)
        cur = None

    for n, raw in enumerate(lines, 1):
        l = strip_eol(raw)
        if l.startswith("## "):
            close(n - 1)
            if section:
                section["end"] = n - 1
            section = {"name": l[3:].strip(), "start": n, "end": len(lines)}
            sections.append(section)
            continue
        if l.startswith("- "):
            close(n - 1)
            base = task_id(l)
            k = ids.get(base, 0)
            ids[base] = k + 1
            cur = {"id": base if k == 0 else "%s-%d" % (base, k + 1), "start": n,
                   "section": section["name"] if section else ""}
            continue
        if cur is not None and l.strip() and not l[0].isspace():
            close(n - 1)
    close(len(lines))
    return tasks, sections


def load(path=OPEN_ITEMS):
    return parse(split_lines(read_raw(path)))


def public(t):
    keys = ["id", "title", "brief", "section", "start", "end", "area", "p", "status", "session", "tagged", "hash"]
    return {k: t.get(k) for k in keys}


# ---------- writing ----------

def _write(path, before_raw, new_lines):
    """Writes only if the file still equals before_raw (else Conflict)."""
    if read_raw(path) != before_raw:
        raise Conflict("open-items.md changed while writing; nothing written")
    data = "".join(new_lines).encode("utf-8")
    d = os.path.dirname(os.path.abspath(path))
    fd, tmp = tempfile.mkstemp(prefix=".open-items.", dir=d)
    try:
        with os.fdopen(fd, "wb") as f:
            f.write(data)
        if read_raw(path) != before_raw:
            raise Conflict("open-items.md changed while writing; nothing written")
        for attempt in range(20):  # Dropbox or an editor may hold the file for a moment
            try:
                os.replace(tmp, path)
                break
            except PermissionError:
                if attempt == 19:
                    raise
                time.sleep(0.1)
    except Exception:
        if os.path.exists(tmp):
            os.remove(tmp)
        raise


def _find(lines, tid, expect):
    tasks, sections = parse(lines)
    for t in tasks:
        if t["id"] == tid:
            if expect and t["hash"] != expect:
                raise Conflict("task %s changed since you read it; reload" % tid)
            return t, tasks, sections
    raise NotFound(tid)


def _eol(lines):
    for l in lines:
        if l.endswith("\r\n"):
            return "\r\n"
        if l.endswith("\n"):
            return "\n"
    return "\n"


def _check(field, value):
    if field == "area" and value not in AREAS + ["inbox"]:
        raise ValueError("area must be one of " + ", ".join(AREAS))
    if field == "status" and value not in STATUSES:
        raise ValueError("status must be one of " + ", ".join(STATUSES))
    if field == "p" and value not in (None, "", 1, 2, 3, "1", "2", "3"):
        raise ValueError("p must be 1, 2 or 3")
    if field == "session" and value and not re.match(r"^[A-Za-z0-9_.:-]{1,64}$", str(value)):
        raise ValueError("bad session id")


def _tag_target(lines, t):
    """The line that carries the tag: its existing line, else the last line of
    the bullet that is not an indented code line (4+ spaces past the text)."""
    if t["tag_line"]:
        return t["tag_line"]
    for n in range(t["end"], t["start"] - 1, -1):
        l = strip_eol(lines[n - 1])
        if l.strip() and (n == t["start"] or len(l) - len(l.lstrip(" ")) < 6):
            return n
    return t["start"]


def set_tag(tid, changes, expect=None, path=OPEN_ITEMS):
    """Adds or updates the task's tag. changes: dict of area/p/status/session.
    Setting status to done also moves the bullet to the end of its section."""
    for k, v in changes.items():
        if k not in ("area", "p", "status", "session"):
            raise ValueError("unknown field " + k)
        _check(k, v)
    raw = read_raw(path)
    lines = split_lines(raw)
    t, tasks, sections = _find(lines, tid, expect)
    n = _tag_target(lines, t)
    line = lines[n - 1]
    body, eol = strip_eol(line), line[len(strip_eol(line)):]
    tag, text = parse_tag(body)
    tag = dict(tag or {})
    if not tag:
        tag = {"area": t["area"] if t["area"] != "inbox" else "", "p": "", "status": "open"}
    for k, v in changes.items():
        tag[k] = "" if v is None else str(v)
    if tag.get("status") != "running":
        tag.pop("session", None)
    if not tag.get("area") or tag.get("area") == "inbox":
        tag.pop("area", None)
    lines[n - 1] = text.rstrip() + " " + format_tag(tag) + (eol or "")
    if changes.get("status") == "done" and t["status"] != "done":
        lines = _move_to_section_end(lines, t, sections)
    _write(path, raw, lines)
    return tid


def _move_to_section_end(lines, t, sections):
    sec = next((s for s in sections if s["start"] < t["start"] <= s["end"]), None)
    if sec is None:
        return lines
    block = lines[t["start"] - 1:t["end"]]
    end = sec["end"]
    while end > t["end"] and not strip_eol(lines[end - 1]).strip():
        end -= 1
    if end == t["end"]:
        return lines  # already last
    eol = _eol(lines)
    if not block[-1].endswith(("\n", "\r")):
        block[-1] += eol
    rest = lines[:t["start"] - 1] + lines[t["end"]:]
    # drop one blank line left behind if the bullet was set off by blanks
    i = t["start"] - 1
    if i < len(rest) and not strip_eol(rest[i]).strip() and i > 0 and not strip_eol(rest[i - 1]).strip():
        rest.pop(i)
    shift = len(lines) - len(rest)
    insert_at = end - shift
    sep = [eol] if not strip_eol(rest[insert_at - 1]).startswith(("- ", "  ")) and strip_eol(rest[insert_at - 1]).strip() else []
    if strip_eol(block[0]).startswith("- ") and _bullets_spaced(lines, sec):
        sep = [eol]
    return rest[:insert_at] + sep + block + rest[insert_at:]


def _bullets_spaced(lines, sec):
    """True when the section separates its bullets with blank lines."""
    starts = [n for n in range(sec["start"] + 1, sec["end"] + 1) if strip_eol(lines[n - 1]).startswith("- ")]
    later = starts[1:]
    if not later:
        return False
    spaced = sum(1 for n in later if not strip_eol(lines[n - 2]).strip())
    return spaced * 2 > len(later)


def _bullet_lines(text, eol):
    text = text.replace("\r\n", "\n").replace("\r", "\n").strip()
    if not text:
        raise ValueError("empty text")
    # continuation lines are indented below, so "- " or "## " cannot split the bullet
    out = []
    for i, l in enumerate(text.split("\n")):
        if i == 0:
            out.append("- " + l.strip())
        elif not l.strip():
            out.append("")
        else:
            out.append("  " + l.rstrip())
    return [l + eol for l in out]


def edit_brief(tid, text, expect=None, path=OPEN_ITEMS):
    """Replaces the bullet's text, keeping its tag. The id changes if the
    first line changes; the new id is returned."""
    raw = read_raw(path)
    lines = split_lines(raw)
    t, _, _ = _find(lines, tid, expect)
    eol = _eol(lines)
    tag, _ = parse_tag(strip_eol(lines[t["tag_line"] - 1])) if t["tag_line"] else (None, None)
    new = _bullet_lines(text, eol)
    if tag:
        k = next((i for i in range(len(new) - 1, -1, -1) if strip_eol(new[i]).strip()
                  and (i == 0 or len(new[i]) - len(new[i].lstrip(" ")) < 6)), 0)
        new[k] = strip_eol(new[k]).rstrip() + " " + format_tag(tag) + eol
    if not lines[t["end"] - 1].endswith(("\n", "\r")):
        new[-1] = strip_eol(new[-1])
    lines[t["start"] - 1:t["end"]] = new
    _write(path, raw, lines)
    return task_id(new[0])


def add_task(section, title, brief="", area="", p="", path=OPEN_ITEMS):
    """Appends a new bullet at the end of a section (by name or name prefix)."""
    _check("area", area or "inbox")
    _check("p", p or None)
    title = " ".join((title or "").split())
    if not title:
        raise ValueError("title is required")
    raw = read_raw(path)
    lines = split_lines(raw)
    tasks, sections = parse(lines)
    sec = next((s for s in sections if s["name"] == section), None) or \
        next((s for s in sections if s["name"].lower().startswith((section or "").lower())), None)
    if sec is None:
        raise NotFound("section " + str(section))
    eol = _eol(lines)
    text = "**%s**" % title.replace("**", "") + (" - " + brief.strip() if brief and brief.strip() else "")
    new = _bullet_lines(text, eol)
    tag = {"status": "open"}
    if area and area != "inbox":
        tag["area"] = area
    if p:
        tag["p"] = str(p)
    new[-1] = strip_eol(new[-1]) + " " + format_tag(tag) + eol
    end = sec["end"]
    while end > sec["start"] and not strip_eol(lines[end - 1]).strip():
        end -= 1
    if not lines[end - 1].endswith(("\n", "\r")):
        lines[end - 1] += eol
    first = new[0]
    if _bullets_spaced(lines, sec):
        new = [eol] + new
    lines[end:end] = new
    _write(path, raw, lines)
    return task_id(first)


# ---------- proposal ----------

def read_proposal(path=PROPOSAL):
    rows = []
    with open(path, encoding="utf-8") as f:
        for l in f:
            m = re.match(r"^\|\s*(\d+)\s*\|\s*`?([0-9a-f-]+)`?\s*\|.*\|\s*([a-z]+)\s*\|\s*(\d)\s*\|\s*$", l)
            if m:
                rows.append({"line": int(m.group(1)), "id": m.group(2), "area": m.group(3), "p": int(m.group(4))})
    return rows


def apply_proposal(path=OPEN_ITEMS, proposal=PROPOSAL):
    rows = read_proposal(proposal)
    done, skipped = 0, []
    for r in rows:
        tasks, _ = load(path)
        t = next((x for x in tasks if x["id"] == r["id"]), None)
        if t is None:
            skipped.append("%s (line %d): not found, the bullet changed" % (r["id"], r["line"]))
            continue
        if t["tagged"]:
            skipped.append("%s: already tagged" % r["id"])
            continue
        set_tag(r["id"], {"area": r["area"], "p": r["p"], "status": "open"}, path=path)
        done += 1
    return done, skipped


def main():
    a = sys.argv[1:]
    if a and a[0] == "--apply-proposal":
        n, skipped = apply_proposal()
        print("tagged %d task(s)" % n)
        for s in skipped:
            print("skipped " + s)
        return
    tasks, _ = load()
    if a and a[0] == "--json":
        print(json.dumps([public(t) for t in tasks], indent=1, ensure_ascii=False))
        return
    for t in tasks:
        print("%-10s %4d-%-4d %-14s %-8s p%s %s" % (t["id"], t["start"], t["end"], t["section"][:14], t["area"], t["p"] or "-", t["title"]))


if __name__ == "__main__":
    main()
