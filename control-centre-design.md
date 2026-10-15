# Control centre: design

Agreed with Chris on 15 October 2026. The control centre is a local web page where Chris manages
course work by area, picks a task to run, and watches the platform and the Claude setup.

## Why a web page and not a mod panel

The Claude desktop app's mod API (build 2.1.295) can't add a left panel or a section to the
right-hand panel. Its one panel docks wherever the app puts it, and a mod can't start a session.
A local page has no such limits on layout. Only the manager session can start sessions (with
`start_session`), so "Run" works as a hand-off through the `bestlessons-bar` mod (see Run flow).

## Layout (light theme only)

Three columns, shown in the app's browser pane beside the chat, at `http://127.0.0.1:8787`.
Below 900 px wide the columns stack.

| Left: Tasks | Middle: Task detail | Right: Monitor |
|---|---|---|
| "+ Add task" (title, area, priority, brief) | Title, area, priority, status, source | Running sessions (task, model, state) |
| Eight collapsible groups with open counts: Commercialisation, Marking, Content, Teacher features, Pupil features, Testing, Fun, Administration | Brief (editable) | Jev router: last picks, redo rate, cost |
| An "Urgent" group pinned at the top | Jev's model and effort pick (asked when the task is opened) | Site: live/test up, last publish, unpublished commits |
| Untagged items in an "Inbox" group to sort | Buttons: Run, Done, Edit, Move area | Platform signals: marking queue, Jev-unsure share, failed marks, pupil queries waiting, sign-ups today, last backup, disk |
| | | Claude: 5-hour and weekly usage, next routines (weekly audit), ComfyUI queue, VM state |

Visual rules: warm off-white background, white cards, one accent colour per area (soft and
light), dark grey text, clear focus states, 8 px spacing grid, system font. There is no dark
mode; the page sets `color-scheme: light`.

## Data

- **Tasks = `open-items.md`.** It stays the one backlog that every chat reads. Each bullet gets
  a trailing tag: `{area: marking; p: 1; status: open}`. `status` is open, queued, running
  (with `session:` id) or done. Done items move to the end of their section, so the history
  stays in git. Untagged bullets show in Inbox. The page writes small, exact line edits and
  never rewrites the file, because other chats edit it too.
- **Run queue:** `logs/run-queue.json`, which is gitignored.
- **Monitoring:** the local server collects data from local sources (git, the Jev log,
  scheduled tasks, the ComfyUI queue file, `VBoxManage list runningvms`). The platform
  signals come from a read-only, admin-key status endpoint on the platform that returns
  counts only, with no pupil names or text. The key is in the platform's `config/config.php`
  and in a local env var, never in the repo. Polling: local data every 30 s, the platform every
  5 minutes.

## Run flow

1. Chris opens a task. The page asks Jev for a model and effort (`tools/jev-route.py`) and
   shows the pick.
2. **Run** adds the task to `logs/run-queue.json` and sets its status to queued.
3. The bar mod sees the queue and shows **Start: <task>**. One click fills the manager's
   prompt with "Start queued task <id>".
4. The manager starts a side session with the task as its brief and the Jev-picked model and
   effort. It records `status: running; session: <id>` and the router outcome when the work
   is checked.

## Pieces

| Piece | Where |
|---|---|
| Local server + page (Python stdlib, binds to 127.0.0.1 only) | `tools/control-centre/` |
| Tag parser and writer for `open-items.md` | `tools/control-centre/tasks.py` |
| Status endpoint (admin key, counts only) | Platform repo `AIPascalCourse`: `public/admin/status.json.php` (not published until Chris approves) |
| Start button | `tools/mods/bestlessons-bar` |
