# Workflow plan: Claude as manager

Agreed with Chris on 15 October 2026, from the RoboNuggets guides plus an audit of the
current setup. Branch: `workflow-setup`.

## Decisions

| Area | Decision |
|---|---|
| Main session | Strict manager on **Opus 5.5, medium effort**. It plans, routes, checks and makes small edits. Bulk reading, builds and bulk edits go to subagents or side sessions. Model is fixed per session because the cache is per model; effort may change mid-task. A `claude://code/new` link cannot set model or effort, and the app ignores `effortLevel` in settings.json, so control-centre Run only queues; the manager starts the session with start_session at Jev's model and effort ("manager run <id>", 15 Oct 2026). |
| Jev routing | **At spawn time.** Before delegating, Jev answers two `choice` questions: model (haiku / sonnet / opus / fable) and effort (low / medium / high / xhigh). Below 0.6 confidence, Claude decides. Every pick is logged with its cost. |
| Jev access | **TypeSafe direct** (api.typesafe.ai), the same provider the platform uses, not OpenRouter. Separate key named "ClaudeDesktop", stored in the user env var `TYPESAFE_ROUTER_KEY`. The key never goes in chat or the repo. If the key is missing or Jev fails, the router stays silent. |
| Helpers | Four pinned subagents in `.claude/agents/`: `helper-haiku`, `helper-sonnet`, `helper-opus`, `helper-fable`. Each ends its reply with a line naming the model that did the work. |
| Warnings | Context meter: **amber at 40%, red at 60%**. Also a cold-cache hold showing the resend cost, 5-hour and weekly usage %, and an off-topic nudge (Jev sees only the new prompt plus a one-line session topic; it skips short replies and slash commands). |
| Always-loaded context | A router `CLAUDE.md` under about 150 lines in AIResources, with a `# Compact instructions` block. The sibling projects import only that file. `platform.md` (235 KB) is read on demand, not loaded every session. |
| Skills/plugins | Archive, don't delete: off-topic skills and duplicates move to `~/.claude/skills-archive`, and unused plugins are disabled for this project. Chris approves the list first. Fix the broken `teach` skill. |
| UI | **Our own mod** (no third-party code): a band above the prompt holding buttons and meters. Buttons cover session hygiene (/compact with the keep-list, /clear, /rewind, /btw, /resume), cost (/usage, /context, /jev status, model and effort), workflow skills (/grilling, /handoff, /skill-audit, /retro, /wait-what) and project actions (/publish, /checklist, /course-status, /open-items). |
| Upkeep | A weekly local routine (Sunday evening, on Sonnet) runs the 10-Skill-Rules audit, router and memory staleness checks and a /usage review. It publishes an OK / Needs-fixing page, and nothing changes until Chris approves. A /skill-audit button runs the same check on demand. |

## Build order

1. Router `CLAUDE.md` + compact instructions; slim the sibling imports.
2. Skill and plugin archive (list approved first). Fix the stale "Trusted repo" in global
   autoMode. Gitignore `.claude/worktrees`.
3. Jev router: a script plus the four helper agents, a spawn rule in `CLAUDE.md`, a log, and
   `/jev status`.
4. Mod: command band, meters, cold-cache hold and off-topic nudge. Test it for one session,
   then install it for every session.
5. The weekly audit routine and the /skill-audit command.

## Session rules (go into CLAUDE.md)

- One task per session. Use `/clear` between unrelated tasks, and `/btw` for side questions.
- After two failed corrections, `/rewind` instead of arguing.
- Compact by hand at a natural break, with a keep-list, before red.
- Before a break of more than an hour, `/compact` or `/clear` (the cache goes cold).
- A subagent gets a scoped brief and returns a summary, never file dumps.
- A rule that must always hold becomes a hook, not prose.
