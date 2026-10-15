"""Hand a queued control-centre task to the manager session (Chris, 15 Oct 2026).

Run in the control centre only queues. Chris pastes "manager run <id>" into the
manager session, which runs this script, then starts the task with start_session
at the printed model and effort. The script prints the queue entry as JSON,
drops it from the queue and tags the task running.

    python tools/control-centre/handoff.py <id>
"""
import json
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import tasks as T  # noqa: E402

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
RUN_QUEUE = os.path.join(ROOT, "logs", "run-queue.json")


def main():
    if len(sys.argv) != 2:
        sys.exit("usage: handoff.py <task id>")
    tid = sys.argv[1]
    try:
        with open(RUN_QUEUE, encoding="utf-8") as f:
            q = json.load(f)
    except (OSError, ValueError):
        q = []
    entry = next((e for e in q if e.get("id") == tid), None)
    if not entry:
        sys.exit("task %s is not in the run queue" % tid)
    with open(RUN_QUEUE, "w", encoding="utf-8") as f:
        json.dump([e for e in q if e.get("id") != tid], f, indent=1)
    T.set_tag(tid, {"status": "running", "session": "manager"})
    print(json.dumps(entry, indent=1, ensure_ascii=False))


if __name__ == "__main__":
    main()
