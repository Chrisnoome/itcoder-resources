"""Block correction requests from the sites (block-sections-design.md, "Correction flow";
Phase 3, 15 Oct 2026). Used by server.py (the Corrections card, Run) and tools/block.py
(status), handoff.py (marks a request running).

Each site's endpoint is <base>/admin/block-requests.json.php with the header
X-Block-Requests-Key. Base URLs and keys come from Windows user env vars, never the repo:

  BESTLESSONS_BLOCKS_KEY_LIVE / _TEST / _LOCAL   the key per site (set-block-requests-key.ps1)
  BESTLESSONS_LIVE_URL / _TEST_URL / _LOCAL_URL  base URL; live and test default to the
                                                 addresses server.py already pings, local
                                                 (http://localhost:8081/) is used only when set
A key is never logged, printed or returned.
"""
import json, os, re, urllib.error, urllib.request

SITES = ("live", "test", "local")
DEFAULT_URLS = {"live": "https://bestlessons.co.za/", "test": "http://102.214.9.207:8082/"}
ENDPOINT = "admin/block-requests.json.php"
FIELDS = ("id", "courseId", "lessonId", "lessonTitle", "n", "note", "status", "createdAt", "blockExists")
STATUSES = ("running", "done", "dropped")


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


def site_config(site):
    """(base url, key) for a site; either may be ''."""
    up = site.upper()
    url = env_secret("BESTLESSONS_%s_URL" % up) or DEFAULT_URLS.get(site, "")
    if url and not url.endswith("/"):
        url += "/"
    return url, env_secret("BESTLESSONS_BLOCKS_KEY_%s" % up)


def configured_sites():
    """live and test always (to say what is missing); local only when its URL is set."""
    return [s for s in SITES if s != "local" or env_secret("BESTLESSONS_LOCAL_URL")]


def _call(site, method, body=None, timeout=8):
    url, key = site_config(site)
    if not url:
        return None, "no base URL (set BESTLESSONS_%s_URL)" % site.upper()
    if not key:
        return None, "no key (set BESTLESSONS_BLOCKS_KEY_%s with set-block-requests-key.ps1)" % site.upper()
    data = json.dumps(body).encode("utf-8") if body is not None else None
    headers = {"X-Block-Requests-Key": key, "User-Agent": "control-centre", "Accept": "application/json"}
    if data is not None:
        headers["Content-Type"] = "application/json"
    req = urllib.request.Request(url + ENDPOINT, data=data, method=method, headers=headers)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            return json.loads(r.read(1 << 20).decode("utf-8") or "{}"), None
    except urllib.error.HTTPError as e:
        if e.code == 403:
            return None, "the site refused the key (403): not set there yet, or a different key"
        try:
            err = json.loads(e.read(4096).decode("utf-8")).get("error")
        except Exception:  # noqa: BLE001
            err = None
        return None, err or ("the site answered %d" % e.code)
    except Exception as e:  # noqa: BLE001
        return None, "unreachable (%s)" % type(e).__name__


def clean(r):
    return {k: r.get(k) for k in FIELDS}


def fetch(site):
    """{site, available, reason?, requests: [...]} - never raises."""
    d, err = _call(site, "GET")
    if err:
        return {"site": site, "available": False, "reason": err, "requests": []}
    reqs = d.get("requests") if isinstance(d, dict) else None
    if not isinstance(reqs, list):
        return {"site": site, "available": False, "reason": "the site returned no list", "requests": []}
    return {"site": site, "available": True, "generated": d.get("generated"),
            "requests": [clean(r) for r in reqs if isinstance(r, dict)]}


def set_status(site, rid, status, commit=None):
    """Returns '' or what went wrong."""
    if status not in STATUSES:
        return "status must be one of " + ", ".join(STATUSES)
    if status == "done" and not re.fullmatch(r"[0-9a-f]{7,40}", commit or ""):
        return "done needs the commit hash"
    body = {"id": int(rid), "status": status}
    if commit:
        body["doneCommit"] = commit
    d, err = _call(site, "POST", body)
    if err:
        return err
    return "" if isinstance(d, dict) and d.get("ok") else "the site did not say ok"


def brief(site, r):
    """The handoff brief for one request (a Run session reads it)."""
    c, l, n, rid = r["courseId"], r["lessonId"], r["n"], r["id"]
    return (
        "Correction request %(rid)s on the %(site)s site: course %(c)s, lesson %(l)s, block #%(n)s.\n"
        "Chris's note: %(note)s\n\n"
        "Code: D:\\DB Sync\\Dropbox\\Projects\\AIPascalCourse (content/%(c)s/%(l)s.php). Edit ONLY block #%(n)s.\n"
        "1. python tools/block.py get %(c)s %(l)s %(n)s  - prints just that block and the file to edit.\n"
        "2. Edit that file only. Keep 'n' and every question 'id' exactly; follow writing-style.md and\n"
        "   content-voice-and-pedagogy.md (South African English, no code in hints).\n"
        "3. python tools/block.py put %(c)s %(l)s %(n)s <that file>  - refuses if the lesson changed since get,\n"
        "   if n or an id changed, if php -l fails, or if any other block came out different.\n"
        "4. The lesson's checks, in AIPascalCourse: php bin/check-blocks.php %(c)s; php bin/check-html.php %(c)s;\n"
        "   php bin/check-lesson-contents.php; php bin/check-titles.php; php bin/check-popup-spacing.php if a\n"
        "   Gloss()/Aside() changed; php bin/check-jev.php %(c)s %(l)s if a question changed.\n"
        "5. Commit only content/%(c)s/%(l)s.php (git commit -- <path>), message naming block #%(n)s and request %(rid)s.\n"
        "6. python tools/block.py status %(site)s %(rid)s done <commit>  - the dot goes; Chris publishes as usual.\n"
        "Do not publish. If the note is unclear or needs more than this block, ask Chris instead of guessing."
    ) % {"rid": rid, "site": site, "c": c, "l": l, "n": n, "note": r.get("note") or ""}
