#!/usr/bin/env python
"""Jev spawn-time router (workflow-plan.md, decision "Jev routing").

  python tools/jev-route.py "<job brief>"      route a brief (or brief on stdin)
  python tools/jev-route.py --outcome <id> <model> ok|redo
  python tools/jev-route.py --status
  python tools/jev-route.py --test

Asks Jev (TypeSafe System One, api.typesafe.ai/v1/systemone) two `choice`
questions: smallest model, and effort. Key: env var TYPESAFE_ROUTER_KEY (never
printed). Any failure prints "JEV: unavailable - manager decides" and exits 0.
Log: logs/jev-route.jsonl (gitignored; holds brief snippets).
"""
import json, os, sys, time, uuid, urllib.request
from datetime import datetime, timezone

URL = "https://api.typesafe.ai/v1/systemone"
MODEL = "jev-1.13.0"
PRICE_PER_M = 0.042
MIN_CONF = 0.6
TIMEOUT = 5
LOG = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "logs", "jev-route.jsonl")

QUESTIONS = {
    "model": {
        "type": "choice",
        "instructions": "What is the smallest Claude model that would do the job described in `brief` well? Pick the cheapest tier whose description fits; step up only when the job needs it.",
        "criteria": {
            "haiku": "Lookup, rename, file listing, one mechanical edit in one file, summarising one or two short files. No judgment, no check loop, no writing for pupils.",
            "sonnet": "Well-defined build or edit with clear done-criteria, edits plus a check script, research digests, reading many files into a table, bulk mechanical edits across many files.",
            "opus": "Multi-step or ambiguous work, designing a feature, page or tool, debugging, writing lesson content, anything that ships to pupils or changes how marking/privacy works.",
            "fable": "Business or architecture strategy (hosting moves, pricing, platform direction), or a job where a wrong call is very expensive or irreversible. Rare.",
        },
    },
    "effort": {
        "type": "choice",
        "instructions": "How much reasoning effort should the model spend on the job described in `brief`?",
        "criteria": {
            "low": "Trivial, near-mechanical work with an obvious answer.",
            "medium": "The default: ordinary work with clear steps, including bulk reading and digests.",
            "high": "The result ships to pupils or the live site, or has several interacting parts to get right.",
            "xhigh": "Only for hard reasoning: subtle design, tricky debugging, security or privacy analysis.",
        },
    },
}

TESTS = [
    "list the files in courses/",
    "rename the variable aCount to anItemCount in lib/helpers.php",
    "summarise the three files courses/ai.md, courses/pascal.md and courses/java.md in five lines each",
    "add the missing glossary entries listed in open-items.md to content/sql/glossary.php and run bin/check-glossary.php until it passes",
    "read all 40 lesson files in content/eng10 and make a table of which ones lack a margin doodle",
    "find out why pupils' Pascal submissions time out in the compile sandbox only on the live server",
    "write the next three English HL Grade 10 lessons for the pupils, in the established voice",
    "design the Year planner so teachers can move a whole term and keep dependent lessons in order",
    "decide whether to move the platform from one VPS to a multi-region setup, weighing cost, POPIA and risk to paying schools",
    "redesign the marking pipeline's privacy model so no pupil text reaches an outside provider unredacted",
]


def now():
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def get_key():
    key = os.environ.get("TYPESAFE_ROUTER_KEY")
    if key is None and os.name == "nt":  # user env var not inherited by this shell
        try:
            import winreg
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, "Environment") as k:
                key = winreg.QueryValueEx(k, "TYPESAFE_ROUTER_KEY")[0]
        except Exception:
            key = None
    return (key or "").strip()


def route(brief):
    """Returns dict(model, mconf, effort, econf, cost) or None."""
    key = get_key()
    if not key:
        return None
    body = json.dumps({"state": {"brief": brief[:4000]}, "model": MODEL, "questions": QUESTIONS}).encode()
    req = urllib.request.Request(URL, body, {"Authorization": "Bearer " + key, "Content-Type": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
            d = json.loads(r.read().decode())
        a = d["answers"]
        tokens = (d.get("usage") or {}).get("input_tokens") or (len(body) // 4)
        return {"model": a["model"]["choice"], "mconf": float(a["model"]["confidence"]),
                "effort": a["effort"]["choice"], "econf": float(a["effort"]["confidence"]),
                "cost": tokens * PRICE_PER_M / 1e6}
    except Exception:
        return None


def line(r):
    s = "JEV: model=%s (%.2f) effort=%s (%.2f) cost=$%.5f" % (r["model"], r["mconf"], r["effort"], r["econf"], r["cost"])
    if r["mconf"] < MIN_CONF or r["econf"] < MIN_CONF:
        s += " -> manager decides"
    return s


def read_log():
    rows = []
    try:
        with open(LOG, encoding="utf-8") as f:
            for ln in f:
                ln = ln.strip()
                if ln:
                    try:
                        rows.append(json.loads(ln))
                    except Exception:
                        pass
    except FileNotFoundError:
        pass
    return rows


def write_log(rows):
    os.makedirs(os.path.dirname(LOG), exist_ok=True)
    with open(LOG, "w", encoding="utf-8") as f:
        for r in rows:
            f.write(json.dumps(r, ensure_ascii=False) + "\n")


def cmd_route(brief):
    r = route(brief)
    if r is None:
        print("JEV: unavailable - manager decides")
        return
    rid = uuid.uuid4().hex[:6]
    os.makedirs(os.path.dirname(LOG), exist_ok=True)
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(json.dumps({"id": rid, "ts": now(), "brief": brief[:120], "model": r["model"], "model_conf": r["mconf"],
                            "effort": r["effort"], "effort_conf": r["econf"], "cost": r["cost"],
                            "used_model": None, "outcome": None}, ensure_ascii=False) + "\n")
    print(line(r) + " id=" + rid)


def cmd_outcome(rid, model, outcome):
    if outcome not in ("ok", "redo"):
        print("outcome must be ok or redo")
        return
    rows = read_log()
    for r in rows:
        if r.get("id") == rid:
            r["used_model"], r["outcome"] = model, outcome
            write_log(rows)
            print("recorded %s: %s %s" % (rid, model, outcome))
            return
    print("no such id: " + rid)


def cmd_status():
    rows = read_log()
    if not rows:
        print("No routings logged yet.")
        return
    n = len(rows)
    for k in ("model", "effort"):
        counts = {}
        for r in rows:
            counts[r[k]] = counts.get(r[k], 0) + 1
        print(k + ": " + ", ".join("%s=%d" % kv for kv in sorted(counts.items())))
    avg = lambda k: sum(r[k] for r in rows) / n
    low = sum(1 for r in rows if r["model_conf"] < MIN_CONF or r["effort_conf"] < MIN_CONF)
    redo = sum(1 for r in rows if r.get("outcome") == "redo")
    ok = sum(1 for r in rows if r.get("outcome") == "ok")
    print("routings=%d  avg confidence: model %.2f effort %.2f" % (n, avg("model_conf"), avg("effort_conf")))
    print("below %.1f (manager decides): %d (%.0f%%)  outcomes: ok=%d redo=%d  total cost=$%.5f" % (MIN_CONF, low, 100.0 * low / n, ok, redo, sum(r["cost"] for r in rows)))


def cmd_test():
    total = 0.0
    print("%-4s %-8s %-6s %-7s %-6s %s" % ("#", "model", "conf", "effort", "conf", "brief"))
    for i, b in enumerate(TESTS, 1):
        r = route(b)
        if r is None:
            print("%-4d unavailable - %s" % (i, b[:60]))
            continue
        total += r["cost"]
        flag = " *" if r["mconf"] < MIN_CONF or r["econf"] < MIN_CONF else ""
        print("%-4d %-8s %-6.2f %-7s %-6.2f %s%s" % (i, r["model"], r["mconf"], r["effort"], r["econf"], b[:70], flag))
    print("test cost=$%.5f  (* = manager decides; not logged)" % total)


def main():
    a = sys.argv[1:]
    try:
        if a and a[0] == "--status":
            cmd_status()
        elif a and a[0] == "--test":
            cmd_test()
        elif a and a[0] == "--outcome" and len(a) == 4:
            cmd_outcome(a[1], a[2], a[3])
        else:
            brief = " ".join(a) if a else (sys.stdin.read() if not sys.stdin.isatty() else "")
            if not brief.strip():
                print("JEV: unavailable - manager decides")
            else:
                cmd_route(brief.strip())
    except Exception:
        print("JEV: unavailable - manager decides")


if __name__ == "__main__":
    main()
