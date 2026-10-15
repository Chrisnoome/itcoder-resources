// bestlessons-bar: Chris's workflow band above the prompt (workflow-plan.md, "UI").
// Buttons, meters, a cold-cache hold and a Jev off-topic nudge. See ../README.md.
import type { EngineInterface, PromptOrigin, Register, SessionUsage } from 'claude-code'

// Session values. Module variables: $.state is not reachable on this build
// (2.1.295: the test kit answers `$.state` as undefined), so the band redraws
// through $.ui.invalidate. A hot reload starts them over (cache shows -- until
// the next turn).
type Nudge = { text: string; at: number }
const S = {
  lastTurnAt: 0, // $.clock.now() when the last turn completed; 0 = none yet
  coldWarnedFor: 0, // lastTurnAt of the cold spell already warned about
  topic: '', // first user prompt of the session, cut to 200 characters
  nudge: null as Nudge | null, // last off-topic nudge, until the next prompt
  jevCost: 0, // Jev's spend this session, US dollars
  commands: [] as string[], // slash command names at session start
}

const COLD_MS = 60 * 60 * 1000
const AMBER = 40
const RED = 60
const OFFTOPIC_MIN_CHARS = 40
const OFFTOPIC_MIN_CONF = 0.7
const KEEP_LIST =
  'keep the current task and done-criteria, decisions with Chris, files touched, open questions, pending approvals'

// Buttons. `fill` puts text in the prompt box (Chris presses Enter);
// `run` runs a no-argument command at once, falling back to fill.
type Act = { kind: 'fill'; text: string } | { kind: 'run'; command: string } | { kind: 'jev' }
type Btn = { key: string; label: string; act: Act; needs?: string }
const GROUPS: { name: string; buttons: Btn[] }[] = [
  {
    name: 'Session',
    buttons: [
      { key: 'compact', label: '/compact', act: { kind: 'fill', text: `/compact ${KEEP_LIST}` } },
      { key: 'clear', label: '/clear', act: { kind: 'fill', text: '/clear' } },
      { key: 'rewind', label: '/rewind', act: { kind: 'fill', text: '/rewind' } },
      { key: 'btw', label: '/btw', act: { kind: 'fill', text: '/btw ' } },
      { key: 'resume', label: '/resume', act: { kind: 'fill', text: '/resume' } },
    ],
  },
  {
    name: 'Cost',
    buttons: [
      { key: 'usage', label: '/usage', act: { kind: 'run', command: 'usage' } },
      { key: 'context', label: '/context', act: { kind: 'run', command: 'context' } },
      { key: 'jev', label: '/jev status', act: { kind: 'jev' } },
      { key: 'model', label: '/model', act: { kind: 'fill', text: '/model ' } },
      { key: 'effort', label: 'effort', act: { kind: 'fill', text: '/effort ' } },
    ],
  },
  {
    name: 'Skills',
    buttons: [
      { key: 'grilling', label: '/grilling', act: { kind: 'fill', text: '/grilling ' }, needs: 'grilling' },
      { key: 'handoff', label: '/handoff', act: { kind: 'fill', text: '/handoff ' }, needs: 'handoff' },
      { key: 'skill-audit', label: '/skill-audit', act: { kind: 'fill', text: '/skill-audit' }, needs: 'skill-audit' },
      { key: 'retro', label: '/retro', act: { kind: 'fill', text: '/retro' }, needs: 'retro' },
      { key: 'wait-what', label: '/wait-what', act: { kind: 'fill', text: '/wait-what ' }, needs: 'wait-what' },
    ],
  },
  {
    name: 'Project',
    buttons: [
      { key: 'publish', label: '/publish', act: { kind: 'fill', text: '/publish ' } },
      { key: 'checklist', label: '/checklist', act: { kind: 'fill', text: '/checklist ' } },
      { key: 'course-status', label: '/course-status', act: { kind: 'fill', text: '/course-status ' } },
      { key: 'open-items', label: '/open-items', act: { kind: 'fill', text: '/open-items' } },
    ],
  },
]

const isUser = (o: PromptOrigin) => o.kind === 'composer' || o.kind === 'bridge' || o.kind === 'sdk'

// Transcript positions for Top / Previous / Next. Module variables, rebuilt
// as rows draw.
const userRows: string[] = []
const visible = new Map<string, boolean>()
let cursor = -1

const mins = (ms: number) => Math.max(0, Math.floor(ms / 60000))
const two = (n: number) => String(n).padStart(2, '0')
const resetText = (iso: string | undefined, withDay: boolean) => {
  if (!iso) return ''
  const d = new Date(iso)
  if (Number.isNaN(d.getTime())) return ''
  const day = withDay ? ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][d.getDay()] + ' ' : ''
  return ` (resets ${day}${two(d.getHours())}:${two(d.getMinutes())})`
}

function redraw($: EngineInterface) {
  $.ui.invalidate('ui.render')
}

async function fill($: EngineInterface, text: string) {
  const r = await $.prompt.fill({ text, mode: 'replace' })
  if (!r.isFilled) $.ui.toast(`Type ${text.trim()} in the prompt (the box could not be filled here).`)
}

async function press($: EngineInterface, b: Btn) {
  if (b.act.kind === 'fill') return fill($, b.act.text)
  if (b.act.kind === 'run') {
    // /usage and /context are terminal dialogs that the desktop Code tab does not run,
    // so the button shows the same numbers from the session's own usage data.
    try {
      const u = await $.session.usage()
      const c = u.context
      const ctx = `Context: ${c.percent ?? '?'}% of ${Math.round((c.window || 0) / 1000)}k` +
        (c.tokens ? ` (${Math.round(c.tokens / 1000)}k tokens)` : '')
      const lim = u.rateLimits.map(r => `${r.kind === 'five_hour' ? '5-hour' : r.kind === 'seven_day' ? 'Week' : r.kind}: ${r.percentUsed}%${resetText(r.resetsAt, r.kind !== 'five_hour')}`)
      const msg = b.act.command === 'context' ? ctx : [ctx, ...lim].join(' | ')
      $.ui.toast(msg, { timeoutMs: 12000 })
    } catch {
      await fill($, `/${b.act.command}`)
    }
    return
  }
  // /jev status: the command if the router step installed one, else the script.
  const names = S.commands
  if (names.includes('jev')) return fill($, '/jev status')
  try {
    const script = `${$.plugin.root}/../../jev-route.py`
    const r = await $.process.run(['python', script, '--status'], { timeoutMs: 10000 })
    $.ui.log(`Jev status:\n${(r.stdout || r.stderr).trim() || 'no output'}`)
  } catch {
    $.ui.toast('Jev status is not available (tools/jev-route.py did not run).')
  }
}

async function scrollTo($: EngineInterface, where: 'top' | 'prev' | 'next') {
  if (userRows.length === 0) return $.ui.toast('No messages to scroll to yet.')
  const shown = userRows.map((id, i) => (visible.get(id) ? i : -1)).filter(i => i >= 0)
  let i: number
  if (where === 'top') i = 0
  else if (where === 'prev') i = (shown.length ? shown[0]! : cursor < 0 ? userRows.length : cursor) - 1
  else i = (shown.length ? shown[shown.length - 1]! : cursor) + 1
  i = Math.max(0, Math.min(userRows.length - 1, i))
  cursor = i
  const r = await $.ui.scroll({ to: { requestId: userRows[i]! }, block: 'start' })
  if ('deny' in r && r.deny) $.ui.toast(`Scroll not possible here: ${r.deny}`)
}

async function checkTopic($: EngineInterface, first: string, text: string) {
  try {
    const script = `${$.plugin.root}/offtopic.py`
    const r = await $.process.run(['python', script], {
      stdin: JSON.stringify({ topic: first, prompt: text }),
      timeoutMs: 3000,
    })
    const a = JSON.parse(r.stdout || '{}') as { choice?: string; confidence?: number; cost?: number }
    if (typeof a.cost === 'number') {
      S.jevCost += a.cost
    }
    if (a.choice === 'new_task' && (a.confidence ?? 0) >= OFFTOPIC_MIN_CONF) {
      const msg = 'Looks like a new task: /clear or new session?'
      S.nudge = { text: msg, at: Date.now() }
      redraw($)
      $.ui.toast(msg, { timeoutMs: 8000 })
    }
  } catch {
    // Silent on error and timeout: the nudge never blocks.
  }
}

export const register: Register = on => {
  on('session.start', async ($, e, next) => {
    try {
      const list = await $.command.list()
      S.commands = list.map(c => c.name)
    } catch {}
    $.clock.every(60000, () => redraw($))
    return next(e)
  })

  on('session.end', async ($, e, next) => {
    if (e.reason === 'clear') {
      S.topic = ''
      S.nudge = null
      S.lastTurnAt = 0
    }
    return next(e)
  })

  on('turn.complete', async ($, e, next) => {
    const now = await $.clock.now()
    S.lastTurnAt = now
    redraw($)
    return next(e)
  })

  on('prompt.submit', async ($, e, next) => {
    const text = e.text.trim()
    if (!isUser(e.origin) || text.startsWith('/')) return next(e)

    // Cold-cache hold: once per cold spell, hand the prompt back with a warning.
    const last = S.lastTurnAt
    const now = await $.clock.now()
    if (last > 0 && now - last > COLD_MS && S.coldWarnedFor !== last) {
      S.coldWarnedFor = last
      const { context } = await $.session.usage()
      const k = context.tokens ? `, about ${Math.round(context.tokens / 1000)}k tokens resent uncached` : ''
      $.clock.after(100, () => {
        void $.prompt.read().then(box => (box.text ? undefined : $.prompt.fill({ text: e.text })))
      })
      return {
        drop: `Cache is cold (${mins(now - last)} min idle${k}): /compact or /clear first? Press Enter again to send anyway.`,
      }
    }

    // Off-topic nudge: never blocks; Jev runs after the prompt is on its way.
    S.nudge = null
    const first = S.topic
    if (!first) {
      S.topic = text.slice(0, 200)
    } else if (text.length > OFFTOPIC_MIN_CHARS) {
      $.clock.after(0, () => void checkTopic($, first, text))
    }
    return next(e)
  }).catch(($, e, next) => next(e))

  // Remember where the person's own messages are, for the scroll buttons.
  on('ui.render', { component: 'UserMessage' }, ($, e, next) => {
    if (isUser(e.props.origin)) {
      if (!userRows.includes(e.requestId)) userRows.push(e.requestId)
      if (e.props.onScreen !== undefined) visible.set(e.requestId, e.props.onScreen !== null)
    }
    return next(e)
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    if (e.props.hasSurvey) return next(e)
    const { Box, Text, Button } = $.ui.resolve(e)
    const now = await $.clock.now()
    let usage: SessionUsage = { startedAt: 0, context: { window: 0 }, rateLimits: [] }
    try {
      usage = await $.session.usage()
    } catch {}
    const last = S.lastTurnAt
    const note = S.nudge
    const cost = S.jevCost
    if (S.commands.length === 0) {
      try {
        S.commands = (await $.command.list()).map(c => c.name)
      } catch {}
    }
    const names = S.commands

    const pct = usage.context.percent
    const ctxColor = pct === undefined ? undefined : pct >= RED ? 'error' : pct >= AMBER ? 'warning' : 'success'
    const five = usage.rateLimits.find(r => r.kind === 'five_hour')
    const week = usage.rateLimits.find(r => r.kind === 'seven_day')
    const idle = last > 0 ? now - last : 0
    const isCold = idle > COLD_MS

    return (
      <Box flexDirection="column">
        <Box key="meters" flexDirection="row" flexWrap="wrap" columnGap={2}>
          <Text key="ctx" color={ctxColor}>
            ctx {pct === undefined ? '--' : `${pct}%`}
            {pct !== undefined && pct >= RED ? ' compact now' : ''}
          </Text>
          <Text key="five" dimColor={!five}>
            5h {five ? `${five.percentUsed}%${resetText(five.resetsAt, false)}` : '--'}
          </Text>
          <Text key="week" dimColor={!week}>
            week {week ? `${week.percentUsed}%${resetText(week.resetsAt, true)}` : '--'}
          </Text>
          <Text key="cache" color={isCold ? 'warning' : undefined} dimColor={last === 0}>
            cache {last === 0 ? '--' : isCold ? `cold (${mins(idle)}m)` : `warm ${mins(idle)}m`}
          </Text>
          {cost > 0 ? <Text key="jev" dimColor>Jev ${cost.toFixed(4)}</Text> : null}
        </Box>
        {note ? (
          <Text key="nudge" color="warning">
            {note.text}
          </Text>
        ) : null}
        {GROUPS.map(g => (
          <Box key={`g-${g.name}`} flexDirection="row" flexWrap="wrap" columnGap={1}>
            <Text dimColor>{g.name.padEnd(8)}</Text>
            {g.buttons.map(b =>
              b.needs && names.length > 0 && !names.includes(b.needs) ? (
                <Button key={b.key} label={`${b.label} (soon)`} dimColor onPress={() => press($, b)} />
              ) : (
                <Button key={b.key} label={b.label} onPress={() => press($, b)} />
              ),
            )}
          </Box>
        ))}
        <Box key="g-Scroll" flexDirection="row" columnGap={1}>
          <Text dimColor>{'Scroll'.padEnd(8)}</Text>
          <Button key="top" label="Top" onPress={() => scrollTo($, 'top')} />
          <Button key="prev" label="Previous message" onPress={() => scrollTo($, 'prev')} />
          <Button key="next" label="Next message" onPress={() => scrollTo($, 'next')} />
        </Box>
      </Box>
    )
  })
}
