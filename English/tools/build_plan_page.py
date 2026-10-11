"""Build the data for English/english-plan-page.html from the plan files.

Reads english-courses-plan.md and eng10/11/12-lessons.md, parses the lesson
tables, assessment maps, exam-format table and open points into one JSON
object, checks the pupil-path counts against the counts the md files state,
and writes the JSON into the page between the plan-data script tags.

Run from anywhere:
    python "D:\\DB Sync\\Dropbox\\Projects\\AIResources\\English\\tools\\build_plan_page.py"

Add --json to print the JSON instead of writing the page.
"""
import itertools
import json
import re
import sys
from pathlib import Path

ENG = Path(__file__).resolve().parent.parent
PAGE = ENG / "english-plan-page.html"
PLAN = ENG / "english-courses-plan.md"
LESSON_FILES = {10: ENG / "eng10-lessons.md", 11: ENG / "eng11-lessons.md", 12: ENG / "eng12-lessons.md"}

# Pickable set texts. Any other text tag (poetry sets, anthologies, film:school)
# is part of every path for the pupil's stream.
TEXTS = {
    10: {
        "romeo-juliet": ("drama", "Romeo and Juliet"),
        "midsummer": ("drama", "A Midsummer Night's Dream"),
        "animal-farm": ("novel", "Animal Farm"),
        "jekyll-hyde": ("novel", "Dr Jekyll and Mr Hyde"),
    },
    11: {
        "macbeth": ("drama", "Macbeth"),
        "julius-caesar": ("drama", "Julius Caesar"),
        "frankenstein": ("novel", "Frankenstein"),
        "splendid-suns": ("novel", "A Thousand Splendid Suns"),
    },
    12: {
        "hamlet": ("drama", "Hamlet"),
        "othello": ("drama", "Othello"),
        "crucible": ("drama", "The Crucible"),
        "life-of-pi": ("novel", "Life of Pi"),
        "dorian-gray": ("novel", "The Picture of Dorian Gray"),
        "brave-new-world": ("novel", "Brave New World"),
        "white-tiger": ("novel", "The White Tiger"),
    },
}

# Pupil-path counts stated in the md files: (CAPS, IEB).
EXPECTED_PATHS = {10: (99, 102), 11: (100, 104), 12: (96, 103)}
EXPECTED_ENTRIES = {10: 153, 11: 163, 12: 214}
# Open points per file, so a change in a source list is noticed.
EXPECTED_OPEN_POINTS = {10: 11, 11: 12, 12: 13}

STRANDS = {"L": "Language", "W": "Writing", "Lit": "Literature", "Oral": "Orals", "Film": "Film", "Exam": "Exam"}

warnings = []


def warn(msg):
    warnings.append(msg)


def cells(line):
    line = line.strip()
    if line.startswith("|"):
        line = line[1:]
    if line.endswith("|"):
        line = line[:-1]
    return [c.strip() for c in line.split("|")]


def is_sep(line):
    return bool(re.match(r"^\s*\|[\s|:-]+\|\s*$", line))


def untick(s):
    return s.replace("`", "").strip()


def read_tables(lines):
    """Yield (start_index, header, rows) for every markdown table."""
    i = 0
    while i < len(lines):
        if lines[i].strip().startswith("|") and i + 1 < len(lines) and is_sep(lines[i + 1]):
            header = cells(lines[i])
            rows = []
            j = i + 2
            while j < len(lines) and lines[j].strip().startswith("|"):
                rows.append((j, cells(lines[j])))
                j += 1
            yield i, header, rows
            i = j
        else:
            i += 1


# ---------------------------------------------------------------- lessons

def parse_lessons(grade, text):
    lines = text.splitlines()
    heads = []  # (line index, level, title)
    for i, ln in enumerate(lines):
        m = re.match(r"^(#{1,4})\s+(.*)$", ln)
        if m:
            heads.append((i, len(m.group(1)), m.group(2).strip()))

    def context(idx):
        term, pool, section, in_list = None, None, None, False
        for i, lvl, title in heads:
            if i > idx:
                break
            t = re.match(r"^Term (\d)\b", title)
            if t:
                term, pool = int(t.group(1)), None
                section = title
                continue
            u = re.match(r"^(Drama|Novel) units\b", title)
            if u:
                term, pool = None, u.group(1).lower()
                section = title
                continue
            if lvl <= 2 and not t:
                # a new H2 that is not a term ends term context (Assessment map etc.)
                if not re.search(r"lesson list", title, re.I):
                    term, pool = None, None
                section = title
                continue
            section = title
        return term, pool, section

    entries, order = [], []
    for start, header, rows in read_tables(lines):
        if len(header) < 8 or header[0] != "#" or header[1] != "id":
            continue
        term, pool, section = context(start)
        if term is None and pool is None:
            warn(f"Gr {grade}: lesson table at line {start + 1} has no term")
        for ln, c in rows:
            if len(c) != 8:
                warn(f"Gr {grade} line {ln + 1}: {len(c)} cells, expected 8: {c[:3]}")
                c = (c + [""] * 8)[:8]
            num, lid, title, strand, stream, txt, covers, prep = c
            lid = untick(lid)
            txt = untick(txt)
            if txt in ("—", "-", ""):
                txt = ""
            stream = stream.strip().lower()
            if strand not in STRANDS:
                warn(f"Gr {grade} line {ln + 1}: unknown strand '{strand}'")
            if lid == "slot":
                m = re.search(r"\*\*([DN])(\d+)(?:-[DN]?(\d+))?\*\*", title)
                if not m:
                    warn(f"Gr {grade} line {ln + 1}: slot row without D/N codes")
                    continue
                kind, a, b = m.group(1), int(m.group(2)), int(m.group(3) or m.group(2))
                order.append({"slot": [f"{kind}{k}" for k in range(a, b + 1)],
                              "kind": "drama" if kind == "D" else "novel",
                              "term": term, "title": title, "section": section})
                continue
            try:
                n = int(num)
            except ValueError:
                warn(f"Gr {grade} line {ln + 1}: lesson number '{num}' is not a number")
                n = None
            if stream not in ("shared", "caps", "ieb"):
                warn(f"Gr {grade} line {ln + 1}: unknown stream '{stream}'")
            code = None
            mc = re.match(r"^([DN]\d+) · ", title)
            if mc:
                code = mc.group(1)
            e = {"n": n, "id": lid, "title": title, "strand": strand, "stream": stream,
                 "text": txt, "covers": covers, "prep": prep, "term": term,
                 "section": section, "code": code, "pool": pool}
            entries.append(e)
            if pool is None:
                order.append({"entry": len(entries) - 1})

    # checks
    nums = [e["n"] for e in entries if e["n"] is not None]
    if len(entries) != EXPECTED_ENTRIES[grade]:
        warn(f"Gr {grade}: parsed {len(entries)} entries, the file says {EXPECTED_ENTRIES[grade]}")
    dupes = sorted({x for x in nums if nums.count(x) > 1})
    if dupes:
        warn(f"Gr {grade}: duplicate lesson numbers {dupes}")
    missing = sorted(set(range(1, max(nums) + 1)) - set(nums))
    if missing:
        warn(f"Gr {grade}: missing lesson numbers {missing}")
    ids = [e["id"] for e in entries]
    dup_ids = sorted({x for x in ids if ids.count(x) > 1})
    if dup_ids:
        warn(f"Gr {grade}: duplicate ids {dup_ids}")
    for e in entries:
        t = e["text"].replace("text:", "")
        if e["text"].startswith("text:") and t not in TEXTS[grade] and not t.startswith(("poems", "imagined", "clusters")):
            warn(f"Gr {grade}: unknown text tag {e['text']} on {e['id']}")
    return entries, order


def text_key(tag):
    return tag[5:] if tag.startswith("text:") else None


def path(grade, entries, order, board, chosen):
    """Return [(term, entry index)] for a pupil on `board` with `chosen` texts."""
    def visible(e):
        if e["stream"] not in ("shared", board):
            return False
        k = text_key(e["text"])
        if k and k in TEXTS[grade]:
            return k in chosen
        return True

    out = []
    for o in order:
        if "entry" in o:
            e = entries[o["entry"]]
            if visible(e):
                out.append((e["term"], o["entry"]))
        else:
            for code in o["slot"]:
                for i, e in enumerate(entries):
                    if e["pool"] and e["code"] == code and visible(e):
                        out.append((o["term"], i))
    return out


def check_paths(grade, entries, order):
    texts = TEXTS[grade]
    result = {}
    for bi, board in enumerate(("caps", "ieb")):
        def avail(genre):
            return [k for k, (g, _) in texts.items() if g == genre and any(
                text_key(e["text"]) == k and e["stream"] in ("shared", board) for e in entries)]
        counts = set()
        for d, nv in itertools.product(avail("drama"), avail("novel")):
            counts.add(len(path(grade, entries, order, board, {d, nv})))
        result[board] = sorted(counts)
        exp = EXPECTED_PATHS[grade][bi]
        if counts != {exp}:
            warn(f"Gr {grade} {board.upper()}: path lengths {sorted(counts)}, the file says {exp}")
    return result


# ---------------------------------------------------------------- assessment maps

def parse_assessment(grade, text):
    lines = text.splitlines()
    start = next((i for i, ln in enumerate(lines) if re.match(r"^##\s+(\d+\.\s+)?Assessment map", ln)), None)
    if start is None:
        warn(f"Gr {grade}: no assessment map section")
        return {"caps": [], "ieb": []}
    end = next((i for i in range(start + 1, len(lines)) if re.match(r"^##\s", lines[i])), len(lines))
    out = {"caps": [], "ieb": []}
    board, block = None, None
    i = start + 1
    while i < end:
        ln = lines[i]
        m = re.match(r"^###\s+(.*)$", ln)
        if m:
            board = "caps" if "CAPS" in m.group(1) else "ieb"
            block = {"heading": m.group(1).strip(), "parts": []}
            out[board].append(block)
            i += 1
            continue
        if block is None:
            i += 1
            continue
        if ln.strip().startswith("|") and i + 1 < end and is_sep(lines[i + 1]):
            header = cells(ln)
            rows = []
            j = i + 2
            while j < end and lines[j].strip().startswith("|"):
                rows.append(cells(lines[j]))
                j += 1
            block["parts"].append({"type": "table", "header": header, "rows": rows})
            i = j
            continue
        if ln.strip() and ln.strip() != "---":
            # collect a paragraph / bullet list as note lines
            note = []
            while i < end and lines[i].strip() and not lines[i].strip().startswith("|") and not lines[i].startswith("#"):
                note.append(lines[i].rstrip())
                i += 1
            block["parts"].append({"type": "note", "lines": note})
            continue
        i += 1
    for b in ("caps", "ieb"):
        if not out[b]:
            warn(f"Gr {grade}: no {b.upper()} assessment map")
    return out


# ---------------------------------------------------------------- open points

def parse_open_points(grade, text):
    lines = text.splitlines()
    start = next((i for i, ln in enumerate(lines) if re.match(r"^##\s+(\d+\.\s+)?Open points", ln)), None)
    if start is None:
        warn(f"Gr {grade}: no open points section")
        return []
    items = []
    for ln in lines[start + 1:]:
        if re.match(r"^##\s", ln):
            break
        m = re.match(r"^(\d+)\.\s+(.*)$", ln)
        if m:
            items.append({"n": int(m.group(1)), "text": m.group(2)})
        elif items and ln.strip():
            items[-1]["text"] += " " + ln.strip()
    if len(items) != EXPECTED_OPEN_POINTS[grade]:
        warn(f"Gr {grade}: {len(items)} open points (the merged list was written for "
             f"{EXPECTED_OPEN_POINTS[grade]}); update MERGED_OPEN_POINTS")
    return items


# The merged, de-duplicated list. Sources are "file #point". Points Chris has
# ruled on (english-courses-plan.md, "Chris's rulings") are left out:
#   June exam in Gr 10/11 (G10 #2, G11 #2); IEB Gr 10/11 lengths (G10 #3, G11 #3);
#   IEB first person (G12 #4); IEB summary cut-off (G12 #5); critics' quotations
#   (G10 #6); copyright outside SA / US hosting (G10 #7, G11 #7: the server is in SA).
# G11 #12 is a counting note, not an open point.
MERGED_OPEN_POINTS = [
    # Needs Chris
    ("chris", "Gr 10 CAPS P2 has no novel in the real provincial paper",
     "The real Gr 10 end-of-year P2 is poetry plus drama only. Our Gr 12 format adds a novel. "
     "Should `caps-p2-final` also offer the drama-only version for schools that write the provincial paper?",
     ["G10 #1"]),
    ("chris", "Gr 11 set-text order",
     "The drama runs in Terms 1-2 and the novel in Term 3, mirroring the Gr 12 outline and the ATP's "
     "Term 3 novel. Novel-first is the alternative. Confirm.",
     ["G11 #1"]),
    ("chris", "De La Salle's texts",
     "Not received yet. Each needs a copyright check and a unit in the grade's unit shape "
     "(14 entries in Gr 10, 16 in Gr 11). *A Thousand Splendid Suns* has a Gr 11 unit but none in Gr 10. "
     "A different Gr 11 poetry set would replace `text:poems11` in the same slots.",
     ["G10 #9", "G11 #11"]),
    ("chris", "Films for IEB film study",
     "Which film(s), their age rating, and how pupils watch them (we can't host films). "
     "Gr 10 and Gr 11 use one film; Gr 12 needs the school's two.",
     ["G11 #5", "G12 #8"]),
    ("chris", "Path load",
     "Gr 12 Term 2 is heavy: 29 lessons (CAPS) and 33 (IEB) in 7 teaching weeks. Option: move the "
     "novel's U6-U7 into Term 3 W1 (Task 9 then falls a week later). The Gr 10 IEB path is 102 lessons; "
     "if it needs trimming, `ieb-cat-speech` could merge into `prepared-speech`.",
     ["G12 #13", "G10 #11"]),
    ("chris", "Gr 11 CAPS P3: speech and obituary added",
     "The Gr 11 ATP transactional list has no speech or obituary. They were added "
     "(`tt-speech-obituary`) because the Gr 12 P3 format (Category C) applies. Accept?",
     ["G11 #8"]),
    # Needs a source
    ("source", "CAPS Gr 12 list for Nov 2027",
     "Circular E11/2024 covers exams only up to June 2027. A new DBE circular is needed; the plan "
     "assumes the same five texts and 12 *Imagined Worlds* poems carry over (the units are interchangeable).",
     ["G12 #1", "Plan Q3"]),
    ("source", "The IEB SBA changes in 2026",
     "Extended writing (SBA Sections A and B) is to become a \"writing process task\" with revised "
     "rubrics. The SAG online is still March 2021. The `ieb-extended-*` / `ext-writing*-ieb` lessons "
     "and the Gr 11 SBA shape may need reshaping.",
     ["G10 #4", "G11 #4", "G12 #2", "Plan Q4"]),
    ("source", "The IEB CAT theme",
     "The 2027 theme arrives in the March delivery. The Gr 12 `ieb-cat` and the Gr 10/11 rehearsals "
     "copy the 2026 poetry format. If the 2027 CAT is not a poetry task, they need rewriting.",
     ["G12 #3", "G10 #5", "G11 #4"]),
    ("source", "CAPS Gr 10-11 per-paper weighting",
     "The per-paper split under the 40:60 SBA:exam rule is not in the sources. `caps-exam-map` leaves "
     "the percentage out until it is confirmed.",
     ["G10 #10", "G11 #9"]),
    ("source", "The Gr 12 anthologies",
     "*Imagined Worlds* and *Clusters* are not in the sources. Poems with generic lesson titles "
     "(Dickinson, Schreiner, Press; Kassam, Dowling, Gray, Mann, Karibo, Afrika) get their real focus "
     "from the anthology. Also confirm which Dickinson poem is 'The Shipwreck'.",
     ["G12 #9"]),
    ("source", "Copyright checks before showing anything in full",
     "Recently public domain in SA: Huxley, Plath, Pound, Plomer, Dylan Thomas. Translations "
     "(Jonker's) are in copyright. SA terms (life + 50) decide, as the server is in SA.",
     ["G12 #10"]),
    ("source", "Editions",
     "*Frankenstein*: 1818 or 1831 (the IEB list doesn't say; the unit uses continuous chapter "
     "numbering). *A Thousand Splendid Suns*: check the Part and chapter ranges against the school's edition.",
     ["G11 #6"]),
    # Platform work
    ("platform", "\"My set works\": the per-pupil text choice",
     "Like `pupils.syllabus`. Needed before units can be filtered. Gr 10/11 also need the teacher's "
     "class text picker and the \"request a text\" flow that notifies Chris.",
     ["G12 #11", "Plan decisions"]),
    ("platform", "\"Our films\" setting",
     "A school setting so the film lessons (Gr 12 `film-06` to `film-09`) can name the school's films.",
     ["G12 #8"]),
    ("platform", "CAPS Task 9 route (Gr 12)",
     "Task 9 can be the literature assignment or contextual + essay; both are built "
     "(`caps-lit-assignment`, novel U14). A teacher setting may be needed to pick one. "
     "(Task 8 can be an exam or a test; the full P1 + P2 practice covers both.)",
     ["G12 #7", "G12 #6"]),
    ("platform", "Audio upload for orals",
     "The course coaches orals and the teacher marks them. Whether the platform can take a pupil's "
     "recording is still to be checked.",
     ["G10 #8", "G11 #10", "G12 #12"]),
]


# ---------------------------------------------------------------- plan tables

def parse_plan(text):
    lines = text.splitlines()

    def table_after(pattern):
        idx = next((i for i, ln in enumerate(lines) if re.search(pattern, ln)), None)
        if idx is None:
            warn(f"plan: heading '{pattern}' not found")
            return None
        for start, header, rows in read_tables([l.strip() for l in lines[idx:]]):
            return {"header": header, "rows": [r for _, r in rows]}
        warn(f"plan: no table after '{pattern}'")
        return None

    formats = table_after(r"^## What each board examines")
    if formats:
        keep = []
        for r in formats["rows"]:
            k = r[0].replace("*", "").strip()
            if k in ("P1", "P2", "P3", "Orals", "SBA"):
                keep.append([k] + r[1:])
        if len(keep) != 5:
            warn(f"plan: exam-format table has {len(keep)} of the 5 rows P1, P2, P3, Orals, SBA")
        formats["rows"] = keep
    lengths = table_after(r"IEB Gr 10/11 lengths, accepted")
    return formats, lengths


# ---------------------------------------------------------------- build

def build():
    data = {"grades": {}, "strands": STRANDS}
    for g, f in LESSON_FILES.items():
        text = f.read_text(encoding="utf-8")
        entries, order = parse_lessons(g, text)
        counts = check_paths(g, entries, order)
        data["grades"][str(g)] = {
            "entries": entries,
            "order": order,
            "texts": {k: {"genre": v[0], "title": v[1]} for k, v in TEXTS[g].items()},
            "pathCounts": counts,
            "assessment": parse_assessment(g, text),
            "openPointsRaw": parse_open_points(g, text),
        }
    formats, lengths = parse_plan(PLAN.read_text(encoding="utf-8"))
    data["examFormats"] = formats
    data["iebLengths"] = lengths
    data["openPoints"] = [{"group": g, "title": t, "body": b, "sources": s} for g, t, b, s in MERGED_OPEN_POINTS]
    data["warnings"] = warnings
    return data


def main():
    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass
    data = build()
    js = json.dumps(data, ensure_ascii=False, separators=(",", ":")).replace("</", "<\\/")
    if "--json" in sys.argv:
        print(json.dumps(data, ensure_ascii=False, indent=1))
        return
    page = PAGE.read_text(encoding="utf-8")
    pat = re.compile(r'(<script id="plan-data" type="application/json">)(.*?)(</script>)', re.S)
    if not pat.search(page):
        sys.exit("plan-data script tag not found in the page")
    page = pat.sub(lambda m: m.group(1) + js + m.group(3), page, count=1)
    PAGE.write_text(page, encoding="utf-8")
    for g, d in data["grades"].items():
        print(f"Gr {g}: {len(d['entries'])} entries; paths CAPS {d['pathCounts']['caps']}, IEB {d['pathCounts']['ieb']}")
    print(f"Wrote {PAGE} ({PAGE.stat().st_size:,} bytes)")
    if warnings:
        print("WARNINGS:")
        for w in warnings:
            print(" -", w)
    else:
        print("No parse warnings.")


if __name__ == "__main__":
    main()
