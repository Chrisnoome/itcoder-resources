# bestlessons-bar

Chris's own Claude Code mod (workflow-plan.md, decision "UI"; built 15 Oct 2026 on
Claude Code 2.1.295). No third-party code. Its one network call is `offtopic.py` to
TypeSafe (Jev).

## What it does

A band above the prompt (terminal and the desktop Code tab):

- **Meters:** context fill (amber at 40%, red at 60% with "compact now"), 5-hour and
  weekly usage % with reset time (subscription only), cache age ("warm 12m", "cold"
  after 60 min), and Jev's spend this session.
- **Buttons:** Session (/compact with the keep-list, /clear + resume (runs /clear, then sends "manager continue" so the manager picks up its linked sessions and the run queue), /rewind, /btw, /resume),
  Cost (/usage and /context run at once; /jev status; /model and effort fill the
  prompt), Skills (/grilling, /handoff, /skill-audit, /retro, /wait-what, dimmed
  "(soon)" until the command exists), Project (/publish, /checklist, /course-status,
  /open-items: placeholders that fill the prompt). Every other button only fills the
  prompt. Nothing is sent until you press Enter.
- **Scroll:** Top, Previous message, Next message jump between your own prompts.
- **Cold-cache hold:** after 60 min idle, the first prompt you send is held once,
  with "Cache is cold (N min idle, about Nk tokens resent uncached): /compact or
  /clear first?". Press Enter again to send it anyway.
- **Off-topic nudge:** for a prompt over 40 characters (not a slash command), Jev
  compares it with the session's first prompt (cut to 200 characters). Only those two
  strings are sent. When Jev says "new task" with confidence 0.7 or more, a toast and a
  band line say "Looks like a new task: /clear or new session?". It never blocks, and
  it says nothing on an error or after 3 s. Key: user env var `TYPESAFE_ROUTER_KEY`
  (set with `tools/set-jev-router-key.ps1`), never printed.

Needs `python` on PATH (for `offtopic.py` and `/jev status`).

## Try it for one session

In a terminal:

```powershell
claude --plugin-dir "D:\DB Sync\Dropbox\Projects\AIResources\tools\mods\bestlessons-bar"
```

The desktop app cannot take that flag. It reads the folder from `CLAUDE_CODE_PLUGIN_DIRS`
in the `env` block of `C:\Users\chris\.claude\settings.json`, which applies to every new
session until you remove it:

```json
"env": { "CLAUDE_CODE_PLUGIN_DIRS": "D:\\DB Sync\\Dropbox\\Projects\\AIResources\\tools\\mods\\bestlessons-bar" }
```

## Install for every session

```powershell
claude plugin marketplace add "D:\DB Sync\Dropbox\Projects\AIResources\tools\mods\bestlessons-bar"; claude plugin install bestlessons-bar@bestlessons
```

It is read from this folder, so after an edit run `/reload-plugins`.

## Turn it off

- For now: collapse the band with its `[-]` (ctrl+x ctrl+a in a terminal).
- Off: `claude plugin disable bestlessons-bar@bestlessons` (on again: `enable`).
- Gone: `claude plugin uninstall bestlessons-bar@bestlessons`, or remove the
  `CLAUDE_CODE_PLUGIN_DIRS` line.

## Develop

```powershell
claude plugin validate "D:\DB Sync\Dropbox\Projects\AIResources\tools\mods\bestlessons-bar"; claude plugin test "D:\DB Sync\Dropbox\Projects\AIResources\tools\mods\bestlessons-bar"
```

Values live in module variables, not `$.state`. On this build `$.state` comes back
undefined, and the skill's `atom`/`update` helpers fail validation. So a hot reload
resets the cache clock and the topic.
