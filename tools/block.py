#!/usr/bin/env python
"""Read and replace ONE numbered block of a lesson (block-sections-design.md,
"Correction flow"; Phase 3, 15 Oct 2026). A correction session reads ~1 KB
instead of a whole lesson file.

    python tools/block.py list <course> <lesson>
    python tools/block.py get  <course> <lesson> <n> [--out FILE]
    python tools/block.py put  <course> <lesson> <n> FILE [--dry] [--split]
    python tools/block.py status <live|test|local> <request id> <running|done|dropped> [commit]

The parsing is PHP's own tokenizer: bin/block-tool.php in AIPascalCourse (the
same as bin/block-number.php). get prints that block's exact source and the
titles of the blocks around it, and writes the source to a file to edit; put
writes it back and refuses when the lesson changed since get, when 'n' or any
question 'id' changed, when php -l fails, or when any other block of the loaded
lesson came out different. --dry runs every check and writes nothing.

put --split replaces the block with 2 or more prose blocks (a long block split
at a sub-heading; only when a correction touches it, Chris 15 Oct 2026). The
first part keeps n; the later parts must carry 'n' => blocks-next,
blocks-next+1, ... in order (the tool CHECKS these, it does not fill them in;
the lesson's `// blocks-next` line is raised for you). Question ids, every
other block, php -l and the get hash are checked as for put; also the parts'
text (headings and tags stripped) must equal the old block's and every
Doodle/Gloss/Figure call must be kept. Give each part a 'title' (<= 55 chars).

status sets a correction request's status on a site (keys from env vars:
tools/control-centre/corrections.py). Never prints a key.

Env: BLOCK_PHP (default D:\\xampp\\php\\php.exe), BLOCK_CODE_ROOT (default
../AIPascalCourse next to this folder).
"""
import json, os, subprocess, sys

sys.dont_write_bytecode = True
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
PHP = os.environ.get("BLOCK_PHP") or r"D:\xampp\php\php.exe"
CODE = os.environ.get("BLOCK_CODE_ROOT") or os.path.normpath(os.path.join(ROOT, "..", "AIPascalCourse"))
TOOL = os.path.join(CODE, "bin", "block-tool.php")


def php(args):
    """Run block-tool.php; returns (exit code, parsed JSON)."""
    p = subprocess.run([PHP, TOOL] + args, cwd=CODE, capture_output=True, text=True, encoding="utf-8", errors="replace")
    try:
        data = json.loads(p.stdout)
    except ValueError:
        data = {"error": (p.stdout + p.stderr).strip()[-600:] or "block-tool.php gave no answer"}
    return p.returncode, data


def near(b):
    if not b:
        return "(none)"
    return "#%s %s%s" % (b["n"], b.get("type") or "?", (" - " + b["title"]) if b.get("title") else "")


def main(argv):
    if len(argv) < 1 or argv[0] in ("-h", "--help"):
        print(__doc__)
        return 2
    cmd, rest = argv[0], argv[1:]

    if cmd == "status":
        if len(rest) < 3:
            print("usage: block.py status <site> <request id> <running|done|dropped> [commit]", file=sys.stderr)
            return 2
        sys.path.insert(0, os.path.join(HERE, "control-centre"))
        import corrections as C
        err = C.set_status(rest[0], rest[1], rest[2], rest[3] if len(rest) > 3 else None)
        if err:
            print("Not set: " + err, file=sys.stderr)
            return 1
        print("Request %s on %s is now %s." % (rest[1], rest[0], rest[2]))
        return 0

    out = None
    if "--out" in rest:
        i = rest.index("--out")
        if i + 1 >= len(rest):
            print("--out needs a file", file=sys.stderr)
            return 2
        out = os.path.abspath(rest[i + 1])
        rest = rest[:i] + rest[i + 2:]
    args = [a for a in rest if not a.startswith("--")]
    flags = [a for a in rest if a.startswith("--")]

    if cmd == "list" and len(args) == 2:
        code, d = php(["list"] + args)
        if code:
            print(d.get("error"), file=sys.stderr)
            return 1
        print("%s  (%d blocks)" % (d["file"], len(d["blocks"])))
        for b in d["blocks"]:
            print("#%-4s %-12s %-8s %6d B  %s" % (b["n"], b.get("type") or "?", b["kind"], b["bytes"], b.get("title") or ""))
        return 0

    if cmd == "get" and len(args) == 3:
        code, d = php(["get"] + args + (["--out=" + out] if out else []))
        if code:
            print(d.get("error"), file=sys.stderr)
            return 1
        print("Block #%s of %s/%s: %s%s (%s, %d bytes)" % (d["n"], args[0], args[1], d.get("type") or "?",
              (" - " + d["title"]) if d.get("title") else "", d["kind"], d["bytes"]))
        print("Before: " + near(d.get("before")))
        print("After:  " + near(d.get("after")))
        print("Edit this file, then put it back: " + d["out"])
        print("-" * 60)
        print(d["source"])
        return 0

    if cmd == "put" and len(args) == 4:
        code, d = php(["put"] + args[:3] + [os.path.abspath(args[3])] + [f for f in ("--dry", "--split") if f in flags])
        if code or not d.get("ok"):
            print("Refused: " + str(d.get("error")), file=sys.stderr)
            return 1
        if not d.get("changed"):
            print("No change: " + d.get("note", ""))
        elif d.get("dry"):
            print("Dry run: block #%s passes every check (%d -> %d bytes%s). Nothing written." % (d["n"], d["bytesBefore"], d["bytesAfter"], ", %d parts" % d["parts"] if d.get("parts", 1) > 1 else ""))
        else:
            print("Block #%s written (%d -> %d bytes%s): %s" % (d["n"], d["bytesBefore"], d["bytesAfter"],
                  ", split into %d parts" % d["parts"] if d.get("parts", 1) > 1 else "", d["file"]))
        return 0

    print(__doc__, file=sys.stderr)
    return 2


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
