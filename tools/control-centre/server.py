#!/usr/bin/env python
"""Control centre server (control-centre-design.md). Python stdlib only.

  python tools/control-centre/server.py          serve http://127.0.0.1:8787

Binds to 127.0.0.1 only and refuses other Host headers (DNS rebinding) and
non-JSON writes (cross-site form posts). Tasks live in open-items.md
(tasks.py); the run queue in logs/run-queue.json (gitignored).

Secrets: the platform status key comes from the env var BESTLESSONS_STATUS_KEY
(user env var on Windows is read from the registry if the shell lacks it). It is
never logged or returned.
"""
import concurrent.futures, glob, hashlib, json, os, re, subprocess, sys, threading, time
import urllib.error, urllib.request
from datetime import datetime, timezone
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer

HERE = os.path.dirname(os.path.abspath(__file__))
sys.dont_write_bytecode = True  # no __pycache__ in the repo
sys.path.insert(0, HERE)
import tasks as T  # noqa: E402

ROOT = T.ROOT
PLATFORM_REPO = os.path.normpath(os.path.join(ROOT, "..", "AIPascalCourse"))
LOGS = os.environ.get("CONTROL_CENTRE_LOGS") or os.path.join(ROOT, "logs")  # override for tests
RUN_QUEUE = os.path.join(LOGS, "run-queue.json")
ROUTE_CACHE = os.path.join(LOGS, "control-centre-routes.json")
JEV_ROUTE = os.path.join(ROOT, "tools", "jev-route.py")
JEV_LOG = os.path.join(ROOT, "logs", "jev-route.jsonl")
SCHEDULED = os.path.join(os.path.expanduser("~"), ".claude", "scheduled-tasks")
COMFY_DIR = os.path.join(ROOT, "comfyui-queue")
VBOX = [r"C:\Program Files\Oracle\VirtualBox\VBoxManage.exe", "VBoxManage"]
PLATFORM_URL = "https://bestlessons.co.za/admin/status.json.php"
SITES = [("live", "https://bestlessons.co.za/"), ("test", "http://102.214.9.207:8082/")]

HOST, PORT = "127.0.0.1", int(os.environ.get("CONTROL_CENTRE_PORT") or 8787)
ALLOWED_HOSTS = {"127.0.0.1:%d" % PORT, "localhost:%d" % PORT}
NO_WINDOW = 0x08000000 if os.name == "nt" else 0
WRITE_LOCK = threading.Lock()
CACHE = {}
CACHE_LOCK = threading.Lock()


def now_iso():
    return datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")


def cached(key, ttl, fn):
    with CACHE_LOCK:
        hit = CACHE.get(key)
        if hit and time.time() - hit[0] < ttl:
            return hit[1]
    val = fn()
    with CACHE_LOCK:
        CACHE[key] = (time.time(), val)
    return val


def run(cmd, cwd=None, timeout=15, stdin=None):
    p = subprocess.run(cmd, cwd=cwd, input=stdin, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=timeout, creationflags=NO_WINDOW)
    return p.returncode, p.stdout.strip(), p.stderr.strip()


def read_json(path, default):
    try:
        with open(path, encoding="utf-8") as f:
            return json.load(f)
    except (OSError, ValueError):
        return default


def write_json(path, data):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=1, ensure_ascii=False)
    os.replace(tmp, path)


def env_secret(name):
    val = os.environ.get(name)
    if not val and os.name == "nt":
        try:
            import winreg
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, "Environment") as k:
                val = winreg.QueryValueEx(k, name)[0]
        except OSError:
            val = None
    return (val or "").strip()


def unavailable(reason):
    return {"available": False, "reason": reason, "updated": now_iso()}


# ---------------- tasks ----------------

def tasks_payload():
    tasks, sections = T.load()
    return {"tasks": [T.public(t) for t in tasks], "sections": [s["name"] for s in sections],
            "areas": T.AREAS, "updated": now_iso()}


def find_task(tid):
    for t in T.load()[0]:
        if t["id"] == tid:
            return t
    raise T.NotFound(tid)


def default_section(area):
    names = [s["name"] for s in T.load()[1]]
    want = {"content": "Content", "admin": "Operations", "fun": "Content"}.get(area, "Platform")
    return next((n for n in names if n.startswith(want)), names[-1] if names else "Platform")


def add_task(body):
    area = (body.get("area") or "").strip()
    p = body.get("p") or ""
    section = body.get("section") or default_section(area)
    with WRITE_LOCK:
        tid = T.add_task(section, body.get("title", ""), body.get("brief", ""), area=area, p=p)
    return T.public(find_task(tid))


def patch_task(tid, body):
    expect = body.get("expect")
    with WRITE_LOCK:
        if "brief" in body:
            tid = T.edit_brief(tid, body["brief"], expect=expect)
            expect = None
        changes = {k: body[k] for k in ("status", "area", "p", "session") if k in body}
        if changes:
            T.set_tag(tid, changes, expect=expect)
        if changes.get("status") in ("open", "running", "done"):  # picked up or dropped: leave the queue
            q = read_json(RUN_QUEUE, [])
            if isinstance(q, list) and any(e.get("id") == tid for e in q):
                write_json(RUN_QUEUE, [e for e in q if e.get("id") != tid])
    return T.public(find_task(tid))


ROUTE_RE = re.compile(r"model=(\w+) \(([\d.]+)\) effort=(\w+) \(([\d.]+)\) cost=\$([\d.]+)(.*?)(?: id=(\w+))?$")


def route_task(tid, refresh=False):
    t = find_task(tid)
    bh = hashlib.sha1(t["brief"].encode("utf-8")).hexdigest()[:12]
    cache = read_json(ROUTE_CACHE, {})
    hit = cache.get(tid)
    if hit and hit.get("brief_hash") == bh and not refresh:
        return dict(hit, cached=True)
    try:
        code, out, _ = run([sys.executable, JEV_ROUTE], cwd=ROOT, timeout=20, stdin=t["title"] + "\n\n" + t["brief"])
    except Exception as e:  # noqa: BLE001
        return {"available": False, "reason": "jev-route.py failed: %s" % type(e).__name__}
    m = ROUTE_RE.search(out.splitlines()[-1] if out else "")
    if not m:
        return {"available": False, "reason": "Jev unavailable - manager decides", "raw": out[-200:]}
    mc, ec = float(m.group(2)), float(m.group(4))
    res = {"available": True, "model": m.group(1), "model_conf": mc, "effort": m.group(3), "effort_conf": ec,
           "cost": float(m.group(5)), "route_id": m.group(7), "manager_decides": min(mc, ec) < T_MIN_CONF,
           "brief_hash": bh, "at": now_iso()}
    with WRITE_LOCK:
        cache = read_json(ROUTE_CACHE, {})
        cache[tid] = res
        write_json(ROUTE_CACHE, cache)
    return dict(res, cached=False)


T_MIN_CONF = 0.6


def queue_task(tid):
    t = find_task(tid)
    pick = read_json(ROUTE_CACHE, {}).get(tid) or {}
    with WRITE_LOCK:
        q = read_json(RUN_QUEUE, [])
        if not isinstance(q, list):
            q = []
        if not any(e.get("id") == tid for e in q):
            q.append({"id": tid, "title": t["title"], "brief": t["brief"], "area": t["area"], "p": t["p"],
                      "model": pick.get("model"), "effort": pick.get("effort"),
                      "manager_decides": pick.get("manager_decides", True), "queued": now_iso()})
            write_json(RUN_QUEUE, q)
        T.set_tag(tid, {"status": "queued"})
    return {"queued": True, "queue_length": len(q), "task": T.public(find_task(tid))}


# ---------------- monitor ----------------

def git_info(name, path):
    if not os.path.isdir(os.path.join(path, ".git")) and not os.path.isfile(os.path.join(path, ".git")):
        return {"name": name, "available": False, "reason": "not a git repo"}
    _, branch, _ = run(["git", "-C", path, "rev-parse", "--abbrev-ref", "HEAD"])
    code, ahead, err = run(["git", "-C", path, "rev-list", "--count", "origin/main..HEAD"])
    _, last, _ = run(["git", "-C", path, "log", "-1", "--format=%cI%x09%h %s"])
    when, _, subject = last.partition("\t")
    return {"name": name, "available": True, "branch": branch, "unpublished": int(ahead) if code == 0 and ahead.isdigit() else None,
            "last_commit": subject[:90], "last_commit_at": when}


def site_up(url):
    req = urllib.request.Request(url, method="HEAD", headers={"User-Agent": "control-centre"})
    t0 = time.time()
    try:
        with urllib.request.urlopen(req, timeout=6) as r:
            code = r.status
    except urllib.error.HTTPError as e:
        code = e.code
    except Exception as e:  # noqa: BLE001
        return {"up": False, "reason": type(e).__name__}
    return {"up": code < 500, "code": code, "ms": int((time.time() - t0) * 1000)}


def site_card():
    out = {"available": True, "updated": now_iso()}
    out["sites"] = {n: cached("site:" + n, 120, lambda u=u: site_up(u)) for n, u in SITES}
    out["repos"] = [git_info("AIResources", ROOT), git_info("AIPascalCourse", PLATFORM_REPO)]
    out["last_publish"] = None  # publish-test.py / deploy-live.py write no local log (checked 15 Oct 2026)
    return out


def jev_card():
    try:
        _, status, _ = run([sys.executable, JEV_ROUTE, "--status"], cwd=ROOT, timeout=10)
    except Exception as e:  # noqa: BLE001
        status = "jev-route.py --status failed: %s" % type(e).__name__
    rows = []
    try:
        with open(JEV_LOG, encoding="utf-8") as f:
            for ln in f:
                try:
                    rows.append(json.loads(ln))
                except ValueError:
                    pass
    except OSError:
        pass
    if not rows and not status:
        return unavailable("no Jev log yet")
    ok = sum(1 for r in rows if r.get("outcome") == "ok")
    redo = sum(1 for r in rows if r.get("outcome") == "redo")
    last = [{"at": r.get("ts"), "brief": (r.get("brief") or "")[:70], "model": r.get("model"),
             "effort": r.get("effort"), "conf": min(r.get("model_conf", 0), r.get("effort_conf", 0)),
             "outcome": r.get("outcome")} for r in rows[-5:]][::-1]
    return {"available": True, "updated": now_iso(), "status": status, "routings": len(rows), "ok": ok, "redo": redo,
            "redo_rate": (redo / (ok + redo)) if ok + redo else None,
            "cost": sum(r.get("cost") or 0 for r in rows), "last": last}


def scheduled_tasks():
    out = []
    for p in sorted(glob.glob(os.path.join(SCHEDULED, "*", "SKILL.md"))):
        name, cron, desc = os.path.basename(os.path.dirname(p)), None, ""
        try:
            with open(p, encoding="utf-8") as f:
                head = f.read(4000)
            fm = head.split("---", 2)[1] if head.startswith("---") else ""
            for ln in fm.splitlines():
                k, _, v = ln.partition(":")
                k = k.strip().lower()
                if k in ("cron", "schedule", "cronexpression"):
                    cron = v.strip().strip("'\"")
                elif k == "name":
                    name = v.strip() or name
                elif k == "description":
                    desc = v.strip()
        except OSError:
            pass
        out.append({"name": name, "cron": cron, "description": desc[:120]})
    return out


def comfy_queue():
    files = glob.glob(os.path.join(COMFY_DIR, "requests", "*.json"))
    if not files and not os.path.exists(os.path.join(COMFY_DIR, "README.md")):
        return None
    counts = {}
    for p in files:
        st = (read_json(p, {}) or {}).get("status", "unknown")
        counts[st] = counts.get(st, 0) + 1
    return {"waiting": counts.get("waiting", 0), "made": counts.get("made", 0), "total": len(files), "by_status": counts}


def running_vms():
    for exe in VBOX:
        if exe.endswith(".exe") and not os.path.exists(exe):
            continue
        try:
            code, out, _ = run([exe, "list", "runningvms"], timeout=10)
        except Exception:  # noqa: BLE001
            continue
        if code == 0:
            return [m.group(1) for m in re.finditer(r'^"(.+?)"', out, re.M)]
    return None


def sessions_card():
    tasks = T.load()[0]
    q = read_json(RUN_QUEUE, [])
    return {"available": True, "updated": now_iso(),
            "queue": [{k: e.get(k) for k in ("id", "title", "model", "effort", "queued")} for e in (q if isinstance(q, list) else [])],
            "running": [{"id": t["id"], "title": t["title"], "session": t["session"]} for t in tasks if t["status"] == "running"],
            "queued_in_file": sum(1 for t in tasks if t["status"] == "queued")}


def claude_card():
    vms = running_vms()
    return {"available": True, "updated": now_iso(), "usage": None,
            "usage_reason": "5-hour and weekly usage are only in the app (/usage); no local file to read",
            "scheduled": scheduled_tasks(), "comfyui": comfy_queue(), "vms": vms,
            "vms_reason": None if vms is not None else "VBoxManage not found"}


def monitor():
    def safe(fn):
        try:
            return fn()
        except Exception as e:  # noqa: BLE001
            return unavailable("%s: %s" % (type(e).__name__, str(e)[:120]))
    parts = {"sessions": sessions_card, "jev": jev_card, "site": site_card, "claude": claude_card}
    with concurrent.futures.ThreadPoolExecutor(4) as ex:
        futs = {k: ex.submit(safe, f) for k, f in parts.items()}
        return {k: f.result() for k, f in futs.items()}


# ---------------- platform ----------------

PLATFORM_SHAPE = {"marking": ["queue", "failedToday", "jevUnsurePct7d"], "queries": ["waiting"], "signups": ["today"],
                  "backup": ["last", "ok"], "server": ["diskFreePct"]}


def platform_fetch():
    key = env_secret("BESTLESSONS_STATUS_KEY")
    if not key:
        return unavailable("BESTLESSONS_STATUS_KEY is not set")
    req = urllib.request.Request(PLATFORM_URL, headers={"X-Status-Key": key, "User-Agent": "control-centre",
                                                        "Accept": "application/json"})
    try:
        with urllib.request.urlopen(req, timeout=8) as r:
            d = json.loads(r.read(65536).decode("utf-8"))
    except urllib.error.HTTPError as e:
        return unavailable("status endpoint answered %d" % e.code)
    except Exception as e:  # noqa: BLE001
        return unavailable("status endpoint unreachable (%s)" % type(e).__name__)
    if not isinstance(d, dict):
        return unavailable("status endpoint returned no object")
    out = {"available": True, "updated": now_iso(), "generated": d.get("generated")}
    for grp, keys in PLATFORM_SHAPE.items():  # counts only: pass nothing else through
        src = d.get(grp) if isinstance(d.get(grp), dict) else {}
        out[grp] = {k: src.get(k) for k in keys if isinstance(src.get(k), (int, float, bool, str))}
    return out


def platform(refresh=False):
    if refresh:
        with CACHE_LOCK:
            CACHE.pop("platform", None)
    return cached("platform", 300, platform_fetch)


# ---------------- http ----------------

class Handler(BaseHTTPRequestHandler):
    server_version = "ControlCentre/1"

    def log_message(self, fmt, *args):  # quiet; errors go to stderr below
        pass

    def send(self, code, body, ctype="application/json; charset=utf-8"):
        data = body if isinstance(body, bytes) else json.dumps(body, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(data)))
        self.send_header("Cache-Control", "no-store")
        self.send_header("X-Content-Type-Options", "nosniff")
        self.send_header("Referrer-Policy", "no-referrer")
        self.end_headers()
        self.wfile.write(data)

    def guard(self, write):
        if self.headers.get("Host", "") not in ALLOWED_HOSTS:
            self.send(403, {"error": "bad host"})
            return False
        if write:
            if not (self.headers.get("Content-Type") or "").startswith("application/json"):
                self.send(415, {"error": "JSON only"})
                return False
            origin = self.headers.get("Origin")
            if origin and origin.split("//", 1)[-1] not in ALLOWED_HOSTS:
                self.send(403, {"error": "bad origin"})
                return False
        return True

    def body(self):
        n = int(self.headers.get("Content-Length") or 0)
        if n > 200000:
            raise ValueError("body too large")
        raw = self.rfile.read(n) if n else b"{}"
        d = json.loads(raw.decode("utf-8") or "{}")
        if not isinstance(d, dict):
            raise ValueError("JSON object expected")
        return d

    def handle_api(self, method):
        path, _, query = self.path.partition("?")
        parts = [p for p in path.split("/") if p]
        try:
            if method == "GET" and path in ("/", "/index.html"):
                with open(os.path.join(HERE, "index.html"), "rb") as f:
                    return self.send(200, f.read(), "text/html; charset=utf-8")
            if not parts or parts[0] != "api":
                return self.send(404, {"error": "not found"})
            if method == "GET" and parts == ["api", "tasks"]:
                return self.send(200, tasks_payload())
            if method == "POST" and parts == ["api", "tasks"]:
                return self.send(201, add_task(self.body()))
            if len(parts) == 3 and parts[1] == "tasks" and method == "PATCH":
                return self.send(200, patch_task(parts[2], self.body()))
            if len(parts) == 4 and parts[1] == "tasks" and method == "POST" and parts[3] == "route":
                b = self.body()
                return self.send(200, route_task(parts[2], refresh=bool(b.get("refresh"))))
            if len(parts) == 4 and parts[1] == "tasks" and method == "POST" and parts[3] == "run":
                self.body()
                return self.send(200, queue_task(parts[2]))
            if method == "GET" and parts == ["api", "monitor"]:
                return self.send(200, cached("monitor", 20, monitor) if "refresh" not in query else monitor())
            if method == "GET" and parts == ["api", "platform"]:
                return self.send(200, platform(refresh="refresh" in query))
            return self.send(404, {"error": "not found"})
        except T.Conflict as e:
            return self.send(409, {"error": str(e)})
        except T.NotFound as e:
            return self.send(404, {"error": "no such task or section: %s" % e})
        except ValueError as e:
            return self.send(400, {"error": str(e)})
        except Exception as e:  # noqa: BLE001
            sys.stderr.write("%s %s: %r\n" % (method, self.path, e))
            return self.send(500, {"error": "%s: %s" % (type(e).__name__, str(e)[:200])})

    def do_GET(self):
        if self.guard(False):
            self.handle_api("GET")

    def do_POST(self):
        if self.guard(True):
            self.handle_api("POST")

    def do_PATCH(self):
        if self.guard(True):
            self.handle_api("PATCH")


def main():
    srv = ThreadingHTTPServer((HOST, PORT), Handler)
    srv.daemon_threads = True
    print("control centre on http://%s:%d" % (HOST, PORT), flush=True)
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
