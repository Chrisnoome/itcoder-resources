import { expect, mock, test } from 'claude-code/testing'

const BAND = {
  component: 'AbovePrompt',
  props: {
    hasSurvey: false,
    isWorking: false,
    maxRows: 12,
    bodyColumns: 120,
    scroll: { offset: 0, bodyRows: 11 },
    view: {},
  },
} as const

function engine(on: any, percent: number) {
  const filled: string[] = []
  const ran: string[] = []
  const clock = mock.clock(on, { now: Date.UTC(2026, 9, 15, 8, 0) })
  on('session.usage', () => ({ value: {
    startedAt: 0,
    context: { tokens: percent * 2000, window: 200000, percent },
    rateLimits: [
      { kind: 'five_hour', percentUsed: 22, resetsAt: '2026-10-15T12:00:00Z' },
      { kind: 'seven_day', percentUsed: 41, resetsAt: '2026-10-19T07:00:00Z' },
    ],
  } }))
  on('command.list', () => ({ value: [{ name: 'grilling', description: '', source: 'skills' }] }))
  on('prompt.fill', (_$: any, e: any) => {
    filled.push(e.text)
    return { isFilled: true }
  })
  on('command.run', (_$: any, e: any) => {
    ran.push(e.command)
    return { text: '' }
  })
  return { filled, ran, clock }
}

test('band draws meters and groups on terminal and desktop', async ($, on) => {
  engine(on, 45)
  for (const surface of ['terminal', 'desktop'] as const) {
    const ui = await $.ui.mount({ plugin: 'bestlessons-bar', surface, ...BAND })
    expect(await ui.find({ type: 'Text', text: /ctx 45%/ })).toBeDefined()
    expect(await ui.find({ type: 'Text', text: /5h 22%/ })).toBeDefined()
    expect(await ui.find({ type: 'Text', text: /week 41%/ })).toBeDefined()
    expect(await ui.find({ key: 'compact' })).toBeDefined()
    expect(await ui.find({ key: 'skill-audit', text: /soon/ })).toBeDefined()
    expect(await ui.find({ key: 'grilling', text: /soon/ })).toBeUndefined()
    expect(await ui.find({ key: 'next' })).toBeDefined()
    await ui.unmount()
  }
})

test('context at 60% says compact now', async ($, on) => {
  engine(on, 63)
  const ui = await $.ui.mount({ plugin: 'bestlessons-bar', surface: 'desktop', ...BAND })
  expect(await ui.find({ type: 'Text', text: /63% compact now/ })).toBeDefined()
})

test('compact fills the keep-list; usage shows numbers without running the terminal dialog', async ($, on) => {
  const { filled, ran } = engine(on, 10)
  const ui = await $.ui.mount({ plugin: 'bestlessons-bar', surface: 'desktop', ...BAND })
  await ui.press({ key: 'compact' })
  expect(filled[0]).toBe(
    '/compact keep the current task and done-criteria, decisions with Chris, files touched, open questions, pending approvals',
  )
  await ui.press({ key: 'usage' })
  expect(ran).toEqual([])
  await ui.press({ key: 'publish' })
  expect(filled[1]).toBe('/publish ')
})
