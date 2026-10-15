#!/usr/bin/env python
"""Off-topic check for the bestlessons-bar mod (workflow-plan.md, "Warnings").

  stdin:  {"topic": "<first prompt, <=200 chars>", "prompt": "<new prompt>"}
  stdout: {"choice": "same_task"|"new_task", "confidence": 0.0-1.0, "cost": usd}
          or {} on any failure (the mod then stays silent).

Asks Jev (TypeSafe System One) one `choice` question, the same way
tools/jev-route.py does. Only the two strings are sent. Key: env var
TYPESAFE_ROUTER_KEY (falls back to the user registry value); never printed.
"""
import json, os, sys, urllib.request

URL = "https://api.typesafe.ai/v1/systemone"
MODEL = "jev-1.13.0"
PRICE_PER_M = 0.042
TIMEOUT = 2.5

QUESTION = {
    "type": "choice",
    "instructions": "`topic` is the first request of a working session with an AI assistant. "
                    "Does `prompt` continue that same piece of work (a follow-up, correction, "
                    "next step, answer or related detail), or start a new, unrelated task?",
    "criteria": {
        "same_task": "Continues, refines, answers or follows up the work in `topic`, or is a short reply.",
        "new_task": "Asks for different work on a different subject that does not build on `topic`.",
    },
}


def get_key():
    key = os.environ.get("TYPESAFE_ROUTER_KEY")
    if not key and os.name == "nt":
        try:
            import winreg
            with winreg.OpenKey(winreg.HKEY_CURRENT_USER, "Environment") as k:
                key = winreg.QueryValueEx(k, "TYPESAFE_ROUTER_KEY")[0]
        except Exception:
            key = None
    return (key or "").strip()


def main():
    try:
        data = json.loads(sys.stdin.read() or "{}")
        topic = str(data.get("topic", ""))[:200]
        prompt = str(data.get("prompt", ""))[:2000]
        key = get_key()
        if not (key and topic and prompt):
            print("{}")
            return
        body = json.dumps({"state": {"topic": topic, "prompt": prompt}, "model": MODEL,
                           "questions": {"task": QUESTION}}).encode()
        req = urllib.request.Request(URL, body, {"Authorization": "Bearer " + key,
                                                 "Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=TIMEOUT) as r:
            d = json.loads(r.read().decode())
        a = d["answers"]["task"]
        tokens = (d.get("usage") or {}).get("input_tokens") or (len(body) // 4)
        print(json.dumps({"choice": a["choice"], "confidence": float(a["confidence"]),
                          "cost": tokens * PRICE_PER_M / 1e6}))
    except Exception:
        print("{}")


if __name__ == "__main__":
    main()
