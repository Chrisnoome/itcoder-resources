# BestLessons running costs (hosting + AI), and tax

Researched 3 October 2026 for commercialisation planning. Every price page was
checked on 3 Oct 2026 unless the text says otherwise. **UNVERIFIED** marks a
figure that only a secondary source gave, or that the official page did not
show. The tax section is research, not advice: **an accountant must confirm it
before any decision.**

Exchange rate used throughout: **R16.734 per US$** (ECB rate of 2 Oct 2026, via
https://api.frankfurter.dev/v1/latest?base=USD&symbols=ZAR, the same source the
site's `UsdToZar()` uses). Sensitivity: ±15% is R14.22 to R19.24 per US$.

"School month" = 200 school days / 12 = **16.67 days**. "Every day" = 365 / 12 =
**30.42 days**.

---

## 1. Summary

**Per subscriber per month (school month), at R16.734/US$:**

| Usage level | AI | All-in cost (2,000 subscribers) | Price must clear (after ~3.3% + R1.15 Paystack fee) |
|---|---|---|---|
| Typical (real data since Sonnet 5.5 marking) | R3.53 | R4.15 | **R5.48** |
| Heavy real user (busiest real pupil-day, every school day) | R24.12 | R24.75 | **R26.79** |
| Maximum at today's cap (100 counted + 100 uncounted calls a day) | R430 | R431 | **R447** |
| Maximum at a cap of 20 counted / 40 total | R86 | R86.50 | **R90.70** |

- Real AI use is cheap: about **R0.21 per active pupil per day** (US$0.01265).
- The cap, not real use, sets the worst case. At today's cap one pupil can cost
  **R430 a school month, R784 a month every day, R5,154 a school year** (200 days).
- **The current site-wide AI budget (US$5 a day, about R84) will switch AI off
  at around 400 typical pupils a day.** It must be raised before launch
  (section 3.6).
- Hosting is small next to AI: the current box (R236 a month) has plenty of
  headroom. Plan a split around 2,000 subscribers (about R1,100 a month) and
  about R3,500 a month at 10,000.
- If VAT registered, add 15% on top of these floors, then income tax on profit.

**Monthly running cost by subscriber count (ZAR, school month):**

| Subscribers | Hosting | Email | AI typical | AI heavy (every user heavy) | AI max (cap 100, every user maxed) | Payment fees at R100/month price (3.335% + R1.15) | **Total typical** (excl fees) | **Total heavy** (excl fees) |
|---|---|---|---|---|---|---|---|---|
| 100 | 236 | 0 | 353 | 2,412 | 42,951 | 449 | **589** (R5.89 each) | **2,648** (R26.48 each) |
| 500 | 236 | 0 | 1,764 | 12,062 | 214,753 | 2,243 | **2,000** (R4.00 each) | **12,298** (R24.60 each) |
| 2,000 | 1,100 | 151 | 7,056 | 48,250 | 859,012 | 8,970 | **8,307** (R4.15 each) | **49,501** (R24.75 each) |
| 10,000 | 3,500 | ~420 (UNVERIFIED) | 35,281 | 241,249 | 4,295,060 | 44,850 | **39,201** (R3.92 each) | **245,169** (R24.52 each) |

Arithmetic: AI typical = subscribers × US$0.01265 × 16.67 days × 16.734 (100 ×
0.01265 × 16.67 × 16.734 = R353). AI heavy uses US$0.0865 a day; AI max uses
US$1.540 a day (section 3). Fees: R100 × 2.9% + R1 = R3.90, × 1.15 VAT = R4.49
per subscriber per month (payments-research.md, Paystack).

The "AI max" column is a ceiling, not a forecast: it assumes every subscriber
uses the whole cap every school day. It shows why the cap must fit the price.

---

## 2. Current baseline (real data)

### 2.1 Where the numbers come from

Read-only aggregate queries on the live database
(`/var/www/itcoder/data/course.sqlite`, opened `SQLITE_OPEN_READONLY` as
www-data), run 3 Oct 2026 21:15 UTC. No names or per-person rows were read.

- **Period:** 24 Sep 2026 11:45 to 3 Oct 2026 21:15 UTC (10 days; `aiUsage`
  only exists since 24 Sep).
- **Total:** 1,407 calls, US$5.398, 157 people (156 pupils, 1 teacher).
- **One-off admin re-mark on 1 Oct:** 547 `remark` calls (Sonnet 5) + 279
  `rulesremark` (Haiku) = 826 calls, US$3.314. This was Chris re-marking old
  answers, not pupils. It is left out of "organic" use below, but re-marks after
  a rubric change are a real, occasional cost.
- **Organic use (everything else):** 581 calls, US$2.084, 129 pupils, 228
  pupil-days.
- 164 accounts, 151 seen in the last 7 days. Mostly De La Salle pupils (free
  through the school domain). No paid plans or subscriptions exist yet (the
  `plans` and `subscriptions` tables are empty).

### 2.2 Cost per active pupil

| Measure | Value |
|---|---|
| Organic: average per active pupil-day | 2.55 calls, **US$0.00914** (R0.15) |
| Organic: busiest pupil-day | 14 calls, US$0.0657 |
| All kinds: busiest pupil-day | 36 calls, **US$0.0865** (R1.45) |
| Since marking moved to Sonnet 5.5 (1-3 Oct, organic) | US$1.2773 / 101 pupil-days = **US$0.01265** (R0.21) |
| Pupil-days by spend (all kinds, 340) | 101 under $0.005; 153 at $0.005-0.02; 65 at $0.02-0.05; 21 at $0.05-0.10; none above $0.10 |
| Daily marking-cap counter (`apiUsage`) | average 2.29, highest 14, never reached 30 |

The Sonnet 5.5 figure is used as "typical" because that is today's set-up.

**Per subscriber per month:**
- Typical: US$0.01265 × 16.67 = US$0.211 = **R3.53** (every school day active,
  which is generous: real pupils were active 1.77 of 10 days).
- Heavy real: US$0.0865 × 16.67 = US$1.442 = **R24.12**.

### 2.3 By kind and model

From `aiUsage`, whole period. Cost per call is what the site recorded.

| Kind | Model | Calls | Avg input tok | Avg output tok | Avg cache write / read | US$ total | US$ per call | Counts against the daily cap? |
|---|---|---|---|---|---|---|---|---|
| remark (admin, one-off) | claude-sonnet-5 | 547 | 2,788 | 436 | 68 / 2,549 | 2.945 | 0.00538 | No (admin script) |
| marking (written answers) | **claude-sonnet-5-5** | 68 | 3,642 | 432 | 3,098 / 243 | 0.865 | **0.01272** | Yes |
| marking (before 1 Oct) | claude-haiku-4-5 | 260 | 1,996 | 156 | 0 / 0 | 0.722 | 0.00278 | Yes |
| rulesremark (admin, one-off) | haiku-4-5 | 279 | 815 | 101 | 0 / 0 | 0.369 | 0.00132 | No |
| review (lesson summary) | haiku-4-5 | 93 | 1,533 | 288 | 0 / 0 | 0.277 | 0.00297 | Yes |
| analysis (console) | haiku-4-5 | 11 | 3,702 | 417 | 0 / 0 | 0.064 | 0.00579 | Yes |
| whyhint | haiku-4-5 | 82 | 520 | 41 | 0 / 0 | 0.060 | 0.00073 | No |
| rulesmark (typed answers) | haiku-4-5 | 27 | 819 | 88 | 0 / 0 | 0.034 | 0.00126 | No |
| codecheck | haiku-4-5 | 31 | 639 | 87 | 0 / 0 | 0.033 | 0.00107 | No |
| style | haiku-4-5 | 7 | 1,653 | 205 | 0 / 0 | 0.019 | 0.00268 | No |
| termcheck | haiku-4-5 | 1 | 703 | 87 | 0 / 0 | 0.001 | 0.00114 | No |
| sqlcheck, taskreview | haiku-4-5 | 0 | - | - | - | - | - | sqlcheck no; taskreview yes (weight 10) |

By course: AI course US$4.09 (134 pupils, most of it the re-mark), Pascal
US$1.29 (35 pupils), Theory 10/11 US$0.02.

### 2.4 Which model does what (from the code)

- `config.php` on live: `anthropicModel` = `claude-haiku-4-5-20251001`;
  `markingModel` is not set, so `bin/markqueue.php` line 603 uses its default
  **`claude-sonnet-5-5`** for written-answer marking (Chris, 1 Oct 2026).
- Every other kind uses `anthropicModel` (Haiku 4.5): review (`lib/review.php`,
  max 1,500 output tokens), analysis (`lib/analyse.php`, 900), whyhint
  (`lib/whywrong.php`, 160), style (`lib/compile.php`, 500), SQL check
  (`lib/sql.php`, 400 + 80 per clause), task review (`lib/tasks.php`, 4,000),
  content checks (`lib/content.php`, 200-600).
- Written marking: `max_tokens` 3,000 with criteria, 2,000 without;
  structured JSON output; one `cache_control` breakpoint on the question +
  rubric block (`markqueue.php` line 631).
- **Jev (TypeSafe)** judges typed-answer marking points first; Claude marks only
  the unsure ones (`lib/jev.php`, key set on live). Jev's cost is **not** in
  `aiUsage` and was not researched: **UNVERIFIED, add its bill.**
- Speech practice uses whisper.cpp on the server: no API cost.
- **Batch API: not used.** All calls are synchronous (`CallClaude()`), though
  marking already runs from a queue (`bin/markqueue.php`, cron every minute).
- **Prompt caching:** used only on marking. It does not pay today (section 3.3).

### 2.5 The caps (live values)

- `maxApiCallsPerPupilPerDay` = **100** on live (the sample config says 30; a
  plan's `aiDailyCap` overrides it, but no plans exist). Counts marking,
  reviews, analyses (1 each) and task reviews (10 each).
- `aiCallsPerPupilPerDayMax` = not set, so **200** (all kinds, including the
  uncounted ones: code/term/SQL checks, why-hints, style).
- `aiDailyBudgetUsd` = not set, so **US$5 a day for the whole site**.

### 2.6 Current hosting

- Box: Absolute Hosting VPS "GnomeMedia", AMD EPYC 7763, 4 vCPU, 3,921 MB RAM,
  2 GB swap, 77 GB disk (7.2 GB used).
- Closest current plan: **Budget EPYC VPS Osmium, R236.00 a month** (4 vCPU,
  4 GB, 80 GB NVMe, unlimited traffic, EPYC 7752), from
  https://client.absolutehosting.co.za/store/budget-vps-servers (checked 3 Oct
  2026). **UNVERIFIED:** that this is the plan Chris is on (the CPU model
  differs: 7763 vs 7752) and whether R236 includes VAT (the page does not say;
  a secondary listing says Absolute's Ryzen prices exclude VAT). Check the
  invoice. The www.absolutehosting.co.za pages return 403 to scripts; the
  client-area store pages were read instead.
- Other current Absolute plans: Ryzen VPS Palladium 4 vCPU / 8 GB DDR5 / 100 GB
  NVMe **R399** (shown "0 Available"); EPYC Turin VPS Palladium 4 vCPU / 8 GB /
  100 GB **R419** (hosted at "DPA Samrand", Gauteng); Budget EPYC Iridium 6 vCPU /
  6 GB / 120 GB **R354** (https://client.absolutehosting.co.za/store/amd-vps-boxed-deals,
  .../amd-ryzen-vps).

---

## 3. AI cost at maximum use

### 3.1 Anthropic prices (official)

From https://platform.claude.com/docs/en/about-claude/pricing (redirected from
docs.anthropic.com; checked 3 Oct 2026). US$ per million tokens:

| Model | Input | 5-min cache write | Cache read | Output | Batch input / output |
|---|---|---|---|---|---|
| Haiku 4.5 | 1.00 | 1.25 | 0.10 | 5.00 | 0.50 / 2.50 |
| Sonnet 5 | 2.00 | 2.50 | 0.20 | 10.00 | 1.00 / 5.00 |
| Sonnet 5.5 | 2.00 | 2.50 | 0.20 | 10.00 | 1.00 / 5.00 |
| Opus 5.5 | 4.00 | 5.00 | 0.20 | 20.00 | 2.00 / 10.00 |

- Cache write is 1.25× input (5 min) or 2× (1 hour); a cache read is 0.1×.
- Batch API: **50% off** input and output; stacks with caching.
- Sonnet 5's US$2/US$10 price, first "introductory", is now the standard price
  (the planned rise to US$3/US$15 on 1 Sep 2026 "will not occur").
- Minimum cacheable prompt: **4,096 tokens on Haiku 4.5**; 512 on Sonnet 5.5
  (Anthropic's prompt-caching table, as bundled in the Claude API skill, cached
  25 Sep 2026; the skill itself says to check the docs for Sonnet 5.5).
- The site's own price table (`AiPriceTable()` in `lib/billing.php`) matches
  these prices, so the recorded costs above are right.

### 3.2 Worst case per subscriber (today's caps)

Per call (real averages): Sonnet 5.5 marking **US$0.01272**; the dearest
uncounted kind, style, **US$0.00268**.

Check of the marking figure: (301 uncached × $2 + 3,098 cache-written × $2.50 +
243 cache-read × $0.20 + 432 output × $10) / 1,000,000 = US$0.01272.

Worst day = 100 counted Sonnet markings + 100 uncounted calls (the 200 all-kinds
limit): 100 × 0.01272 + 100 × 0.00268 = **US$1.540 = R25.77**.

| Period | US$ | ZAR at 16.734 | ZAR at 14.22 (−15%) | ZAR at 19.24 (+15%) |
|---|---|---|---|---|
| One day | 1.540 | 25.77 | 21.90 | 29.63 |
| School month (16.67 days) | 25.67 | **430** | 365 | 494 |
| Every day (30.42 days) | 46.84 | **784** | 666 | 901 |
| School year (200 days) | 308.0 | **5,154** | 4,381 | 5,927 |
| Every day for a year | 562.1 | **9,406** | 7,995 | 10,817 |

Counted calls alone (100 markings, no uncounted kinds): US$1.272 a day, R355 a
school month, R4,257 a school year.

Task reviews (weight 10) cannot beat this: a 10-weight review would need to cost
over US$0.127 to be dearer than ten markings; at Haiku prices and 4,000 output
tokens maximum it costs at most about US$0.02 plus input (estimate; no real
task reviews yet).

### 3.3 Ways to cut it

All figures are a maxed pupil-day at cap 100 + 100 uncounted, then the school
month at R16.734.

| Option | Per maxed day | School month | Saving | Trade-off |
|---|---|---|---|---|
| Today | US$1.540 | R430 | - | - |
| Drop the cache marker on marking | US$1.428 | R398 | 7% | None today: caching costs more than it saves (below) |
| Shorter marking feedback (432 → 250 output tokens) | about US$1.358 | about R379 | 12% | Shorter feedback |
| Batch API for written marking (50%) | US$0.904 | R252 | 41% | Results can take up to 24 h (usually much less; UNVERIFIED typical time). Fine for re-marks, reviews, task reviews; risky for marking pupils wait for |
| Haiku 4.5 for marking (US$0.00278 a call) | US$0.546 | R152 | 65% | Chris moved marking to Sonnet because Haiku ignored rubrics (1 Oct 2026) |
| Cap 30 counted / 60 total | US$0.462 | R129 | 70% | Real pupils never passed 14 counted calls a day |
| Cap 20 counted / 40 total | US$0.308 | R86 | 80% | As above |
| Cap 10 counted / 30 total | US$0.181 | R50 | 88% | May bite keen pupils before exams |

**Caching today loses money.** Marking writes 3,098 tokens to the cache per call
but reads back only 243 on average. A write costs 1.25×, so each call pays
US$0.01272 instead of US$0.01160 without caching (+9.6%). The cache lasts 5
minutes and is per question, so it only pays when a class answers the same
question together. With a perfect hit rate, a call would cost about US$0.0055
(3,400 tokens read at US$0.20/M, 242 uncached, 432 output), so caching is worth
keeping only if the shared part (system prompt + rubric) is put first and many
pupils mark the same question within 5 minutes. Otherwise remove the marker.

**Caching cannot help Haiku calls:** none reaches Haiku 4.5's 4,096-token
minimum (the largest average is 3,702).

**Recommendation for pricing:** set the cap per plan (`plans.aiDailyCap`) and
also lower `aiCallsPerPupilPerDayMax`, because the uncounted kinds otherwise add
up to 100 extra calls a day. A cap of 20 counted / 40 total bounds the worst
case at about **R86 a school month** while sitting well above any real use seen.

### 3.4 Exchange-rate sensitivity

All AI costs scale with the rate. At ±15% the typical subscriber costs R3.00 to
R4.06 a school month (R3.53 × 0.85 / × 1.15) and the cap-20 worst case R73 to
R99.

### 3.5 Other AI cost items

- Admin re-marks: the 1 Oct re-mark cost US$3.31 (R55) for 826 calls. Budget
  for one after each big rubric change; use the Batch API for these (50% off).
- Jev: not costed (UNVERIFIED).

### 3.6 The site-wide budget will block growth

`aiDailyBudgetUsd` defaults to US$5 a day (R84). On 1 Oct the site spent
US$3.76 (most of it the re-mark). Typical use is US$0.01265 per active
pupil-day, so the budget stops all AI at about **395 active pupils in a day**
(5 / 0.01265). At 2,000 subscribers a typical day is about US$25. Raise it in
step with paid subscribers, for example to 3× the expected daily spend, and
keep the per-person limits as the real guard.

---

## 4. Hosting

### 4.1 What the current box does today

Read-only checks on 3 Oct 2026 (`uptime`, `free -m`, `df -h`, `nproc`, `sar`,
nginx logs):

- Load average 0.12; CPU about 99% idle across the last five days (sar). The
  highest 1-minute load seen was 0.50.
- RAM: 1,087 MB used, 2,833 MB available, swap unused. Highest memory use in
  five days: 15.8% (sar).
- Disk: 7.2 GB of 77 GB. Database 6.6 MB; backups 53 MB.
- Busiest minute: **803 requests** (2 Oct 08:03, a class); 36,894 requests that
  day, 70 pupils seen.
- PHP-FPM: `pm.max_children = 40`, each about 36 MB, so up to about 1.4 GB.
- Live console: `MAX_SESSIONS` 60; pupils' slice capped at 1.5 GB (about 20
  Java programs at once); compiles queue in 4 slots.
- Measured earlier (vps-access.md, 25 Sep 2026): a Pascal compile about 0.3 s
  (4 slots: about 13 a second); javac + java 0.75 s each, 30 at once 8.3 s and
  about 2.1 GB; SQL runner 30 runs in about 1 s.
- The test site, its runners and MySQL also run on this box.

### 4.2 Capacity of the current box

What runs out first is a burst of pupils pressing Run, not page views:

- **Pascal:** about 13 compiles a second. A class of 30 waits up to about
  2.5 s. Roughly 3-4 classes pressing Run in the same few seconds is the limit
  before waits pass 10 s (estimate).
- **Java:** about 20 programs running at once (1.5 GB slice); 30 compiles at once
  take about 8 s and 2.1 GB.
- **Web/PHP:** 40 workers; at 13 requests a second at peak it is far from full.

Estimate: the box serves **up to about 150 pupils online at once**, or 2-3 full
classes compiling together. At 5-10% of subscribers online in the peak hour,
that is roughly **1,500-3,000 subscribers**, fewer if Java dominates. These are
estimates from the measurements above, not a load test.

### 4.3 Triggers to upgrade

Upgrade or split when any of these happens in school hours:
- swap in use (`free -m`) on more than a few days;
- 1-minute load above 3 for 10 minutes or more;
- compile queue waits above 5 s for a class (compile log);
- "max_children reached" in the PHP-FPM log;
- available RAM below 1 GB at peak;
- disk above 70%.

### 4.4 Tiered plan

| Subscribers | Set-up | Monthly (ZAR) |
|---|---|---|
| 100 and 500 | Current box. Remove the test site and its runners from live (open-items.md teardown) | **236** |
| 2,000 | Split: web + database box, and a separate compile/run box (live console, compile queue, SQL runner). Two 4 vCPU / 8 GB servers | **about 1,100** (xneelo 2 × (R402 + 80 GB NVMe R144) = R1,092, VAT incl.) or about R800-840 at Absolute (2 × R399/R419; VAT status unverified, Ryzen sold out) |
| 10,000 | Web: 8 vCPU / 32 GB + 200 GB. Two run boxes 8 vCPU / 16 GB + 50 GB each. Consider moving from SQLite to MySQL/Postgres (one writer at a time) | **about 3,500** (xneelo: 1,278 + 360 + 2 × (803 + 90) = R3,424, plus offsite backups) |

The compile/run box is the part to scale sideways: add a second one when the
first hits the triggers.

### 4.5 Providers compared

| Provider | Where | 4 vCPU / 8 GB class | 8 vCPU / 16-32 GB class | Latency from SA (measured) | Source |
|---|---|---|---|---|---|
| Absolute Hosting | Samrand, Gauteng | R399-419 (8 GB) | Not listed | 32 ms ping to current box | client.absolutehosting.co.za store pages |
| xneelo (cloud, VAT incl.) | SA | R402 + storage | R803 (8/16), R1,278 (8/32) + storage | Not measured (SA) | https://xneelo.co.za/cloud/ |
| Afrihost (self-managed cloud) | SA (mentions Cape Town) | Platinum 4 vCPU / 8 GB / 500 GB **R1,130** | Silver Pro 8 vCPU / 16 GB / 3 TB **R1,600** | Not measured | https://www.afrihost.com/cloud-hosting (VAT treatment not stated: UNVERIFIED) |
| AWS af-south-1 (Cape Town), on-demand Linux, ex VAT | Cape Town | c6i.xlarge (4/8) US$0.228/h = US$166 = **R2,785**; t3.xlarge (4/16) US$0.217/h = R2,651 | c6i.2xlarge (8/16) US$0.456/h = **R5,570**; m6i.2xlarge (8/32) US$0.508/h = R6,206 | ~64 ms TCP connect | AWS price data published 25 Sep 2026 (b0.p.awsstatic.com, the pricing page's own feed). Excludes disk (EBS), traffic out and VAT |
| DigitalOcean | No SA region | Basic 8 GB / 4 vCPU **US$48** (R803); dedicated 16 GB / 4 vCPU US$126 | Basic 16 GB / 8 vCPU US$96; dedicated 32 GB / 8 vCPU US$252 | ~200 ms TCP connect (Amsterdam/London) | https://www.digitalocean.com/pricing/droplets |
| Hetzner | No SA location: Germany, Finland, USA, Singapore | Prices did not render on the official page (UNVERIFIED) | - | 224 ms ping (Falkenstein), 245 ms (Helsinki) | https://www.hetzner.com/cloud/ |

Notes:
- "Hetzner South Africa": Hetzner's own cloud has no SA site (official page).
  xneelo is the SA company once called Hetzner South Africa (UNVERIFIED from a
  primary source).
- Latency was measured from Chris's PC on 3 Oct 2026 (location not recorded).
  Europe adds about 200 ms to every request and every console keystroke round
  trip; for a live console used in class, an SA host is clearly better.
- AWS is 3-5 times dearer than SA VPS hosts for the same size, before disk and
  traffic. Its only gain is managed services; not worth it at these sizes.

### 4.6 POPIA and where data lives

- POPIA does not require data to stay in South Africa. Section 72 allows a
  transfer abroad if, among other grounds, the recipient is bound by law or
  contract giving adequate protection, or the person consents
  (https://www.gov.za/sites/default/files/gcis_document/201409/3706726-11act4of2013popi.pdf,
  s72; my summary, not a legal opinion).
- Pupils are children, so parental consent (s34-35) already matters
  (payments-research.md).
- Pupil answers already go to Anthropic (US-run API) for marking. The privacy
  notice must say so, whatever the host.
- Keeping the database in SA (Absolute, xneelo, Afrihost, AWS Cape Town) is the
  simplest answer for schools that ask.

### 4.7 Backups and offsite storage

- Today: 14 daily + 12 monthly snapshots on the server (53 MB) and pulls to
  Chris's PC (backups.md). Cost R0.
- At 10,000 subscribers: the database grows at about 40 KB per pupil today
  (6.6 MB / 164), so about 0.4 GB, plus uploads. 26 snapshots × 0.4 GB = about
  10 GB. At xneelo's standard volume price, R1.20 per GB a month (VAT incl.,
  https://xneelo.co.za/cloud/), that is about **R12 a month**. Any offsite store
  costs well under R50 a month at this size.

### 4.8 Email (Brevo)

From https://www.brevo.com/pricing/ (checked 3 Oct 2026):
- Free: up to **300 emails a day**.
- Starter: **US$9 a month** (US$8.08 a month billed yearly) for 5,000 emails a
  month. Prices for higher volumes sit behind a slider that could not be read:
  **UNVERIFIED** above 5,000.

Estimate: about 2 emails per subscriber a month (weekly reminders to pupils
behind, renewal notices, invitations).
- 100 and 500 subscribers: 200-1,000 a month. Free.
- 2,000: about 4,000 a month, but reminders go out on weekday mornings and
  could pass 300 in a day. Starter: US$9 = **R151**.
- 10,000: about 20,000 a month. Starter at that volume: about US$25 = **R420**
  (UNVERIFIED estimate).

---

## 5. Tax (sole proprietor vs (Pty) Ltd)

Primary sources only (sars.gov.za), checked 3 Oct 2026. **An accountant must
confirm all of this before Chris acts on it.**

### 5.1 Income tax

**Sole proprietor:** profit is added to Chris's other income (for example a
teaching salary) and taxed at his marginal rate. 2027 tax year (1 Mar 2026 - 28
Feb 2027), https://www.sars.gov.za/tax-rates/income-tax/rates-of-tax-for-individuals/:

| Taxable income (R) | Tax |
|---|---|
| 1 - 245,100 | 18% |
| 245,101 - 383,100 | 44,118 + 26% above 245,100 |
| 383,101 - 530,200 | 79,998 + 31% above 383,100 |
| 530,201 - 695,800 | 125,599 + 36% above 530,200 |
| 695,801 - 887,000 | 185,215 + 39% above 695,800 |
| 887,001 - 1,878,600 | 259,783 + 41% above 887,000 |
| 1,878,601 and above | 666,339 + 45% above 1,878,600 |

Primary rebate R17,820; tax threshold under 65 R99,000.

**Company:** 27% on taxable income (years ending 1 Apr 2026 - 31 Mar 2027).
Profits paid out as dividends also pay **20% dividends tax**
(https://www.sars.gov.za/types-of-tax/dividends-tax/). Combined on a paid-out
rand: 1 − (0.73 × 0.80) = **41.6%**.

**Small business corporation (SBC)**, years ending 1 Apr 2026 - 31 Mar 2027
(https://www.sars.gov.za/tax-rates/income-tax/companies-trusts-and-small-business-corporations-sbc/):

| Taxable income (R) | Tax |
|---|---|
| 1 - 99,000 | 0% |
| 99,001 - 365,000 | 7% above 99,000 |
| 365,001 - 550,000 | 18,620 + 21% above 365,000 |
| 550,001 and above | 57,470 + 27% above 550,000 |

SBC conditions (for example shareholders who are natural persons, turnover
limit, limits on investment income and personal services) were not checked
here: **UNVERIFIED, accountant to confirm.** Dividends tax still applies when
profit is paid out.

**Turnover tax (micro businesses)**
(https://www.sars.gov.za/types-of-tax/turnover-tax/,
https://www.sars.gov.za/tax-rates/turnover-tax/):
- From 1 April 2026: turnover up to **R2.3 million** (was R1 million);
  first R600,000 tax-free. Rates for 2027: 0% to R600,000; 1% of the amount
  above R600,000 to R950,000; R3,500 + 2% above R950,000 to R1,400,000; R12,500
  + 3% above R1,400,000.
- Paid in two interim payments (end August, end February) plus the annual
  TT03 return.
- **Turnover tax does not stop VAT registration.** A turnover-tax business "can
  ... elect to remain in the VAT system".
- **Probably not available to BestLessons.** SARS's FAQ excludes a natural
  person if more than 20% of receipts come from a "professional service", and
  lists **education** (and information technology) among them
  (https://www.sars.gov.za/faq/faq-what-are-the-requirements-for-a-micro-business-to-qualify-for-turnover-tax/;
  that FAQ page still says R1 million, the turnover-tax page says R2.3 million
  from 1 Apr 2026). Whether selling online courses counts as a service "in the
  field of education" is for the accountant.

**Provisional tax** (https://www.sars.gov.za/types-of-tax/provisional-tax/):
a sole proprietor with income other than salary, and every company, is a
provisional taxpayer. Two payments a year (end of August, end of February),
optional third. Underestimating leads to penalties and interest.

### 5.2 VAT

(https://www.sars.gov.za/types-of-tax/value-added-tax/register-for-vat/, page
updated 19 Aug 2026; https://www.sars.gov.za/faq/what-is-the-new-threshold-for-vat-registration/)

- **Compulsory** when taxable supplies in any 12 months exceed, or are likely to
  exceed, **R2.3 million** (from 1 April 2026; was R1 million). Apply within 21
  business days.
- **Voluntary** from **R120,000** in 12 months (or more than R4,200 a month on
  average in the months before applying).
- Rate 15%.
- **Not exempt as education.** Section 12(h) exempts "certain educational
  services supplied by recognised educational institutions such as primary and
  secondary schools, technical colleges and universities" (SARS, FAQs: Supplies
  of Electronic Services, Issue 4, Q18 and Q16). An online course seller is not
  such an institution, so if registered, sales are standard-rated at 15%.
  Confirmed in principle; accountant to confirm for this business.
- **Effect on prices:** consumer prices must be shown VAT-inclusive. Once
  registered, 15/115 of every sale (13.04%) goes to SARS, so either prices rise
  15% or net income falls 13%. In return, VAT on local costs (gateway fees,
  local hosting) can be claimed back.
- Sales to buyers abroad may be zero-rated (VAT Act s11(2)(l), services to a
  non-resident outside SA): **UNVERIFIED here.**

### 5.3 VAT on Anthropic and foreign hosting ("imported services")

From SARS FAQs: Supplies of Electronic Services, Issue 4 (2025,
https://www.sars.gov.za/lapd-vat-g16-vat-faqs-supplies-of-electronic-services/), Q70-72:

- "Imported services" are services from a non-resident "used or consumed in
  South Africa, **otherwise than for the purposes of making taxable supplies**".
- **While not VAT registered:** BestLessons makes no taxable supplies, so
  foreign services (Anthropic, Brevo, any foreign host) can be imported
  services. A non-vendor must declare and pay 15% on each invoice over **R100**
  on form VAT215 within 60 days (invoices from 24 Dec 2024).
- **Unless** the foreign supplier is registered in SA as an electronic-services
  vendor and charges SA VAT itself; then it is not an imported service. Since
  1 Apr 2025 a foreign supplier that sells only to VAT vendors need not register,
  but one that sells to non-vendors too must (Q6).
- **Check:** does Anthropic's invoice show 15% SA VAT? Anthropic says the
  billing address sets the tax treatment and a VAT ID can be added in the Console
  (https://support.anthropic.com/en/articles/9889428). Whether it charges SA VAT
  is **UNVERIFIED**. If it does not, the imported-services rule may apply to
  past invoices over R100. Ask the accountant.
- **Once VAT registered** and the services are used to make taxable supplies,
  imported-services VAT does not arise. If a foreign supplier charges SA VAT, it
  can be claimed as input tax with a valid tax invoice.

### 5.4 Selling to buyers abroad through a processor

A processor (Paystack, Peach, PayPal) makes BestLessons the seller, so foreign
consumer VAT is BestLessons' duty (payments-research.md):
- **UK:** a non-UK business selling digital services to UK consumers must
  register for UK VAT; the guidance shows no threshold, and lists an "online
  course consisting of pre-recorded videos and downloadable PDFs" as a digital
  service (a course with a live tutor is not). If sold through a platform that
  accounts for VAT, the platform does it
  (https://www.gov.uk/guidance/the-vat-rules-if-you-supply-digital-services-to-private-consumers,
  updated 28 Mar 2022).
- **EU:** a business outside the EU can use the non-Union One Stop Shop. The
  EUR 10,000 threshold needs establishment in one member state, so it does not
  help a non-EU seller: VAT is due from the first euro
  (https://vat-one-stop-shop.ec.europa.eu/one-stop-shop_en).
- **Other countries:** many have similar rules (not researched).
- Practical choice: block or limit consumer sales abroad, or sell abroad through
  a merchant of record (Paddle, Polar, Lemon Squeezy) that takes on this duty
  for a higher fee (payments-research.md).

### 5.5 Worked example: what Chris keeps

Paystack card fee 2.9% + R1 (ex VAT). Not VAT registered: the 15% VAT on the
fee is a cost. Registered: the sticker price includes VAT and the fee's VAT is
claimed back. Running costs (AI, hosting) are left out to keep it simple; they
come off before tax.

**R100 sale**
- Fee: R100 × 2.9% + R1 = R3.90; × 1.15 = R4.49.
- Not registered: 100 − 4.49 = **R95.52** before income tax.
- Registered: VAT = 100 × 15/115 = R13.04; 100 − 13.04 − 3.90 = **R83.06**.

**R1,000 sale**
- Fee: R1,000 × 2.9% + R1 = R30.00; × 1.15 = R34.50.
- Not registered: 1,000 − 34.50 = **R965.50**.
- Registered: VAT = R130.43; 1,000 − 130.43 − 30.00 = **R839.57**.

**After income tax (marginal rate on the last rand):**

| Who | Rate | R100, not registered | R100, registered | R1,000, not registered | R1,000, registered |
|---|---|---|---|---|---|
| Sole proprietor | 18% | 78.32 | 68.11 | 791.71 | 688.44 |
| Sole proprietor | 31% | 65.91 | 57.31 | 666.20 | 579.30 |
| Sole proprietor | 41% | 56.35 | 49.00 | 569.65 | 495.34 |
| SBC | 7% | 88.83 | 77.24 | 897.92 | 780.80 |
| SBC | 21% | 75.46 | 65.61 | 762.75 | 663.26 |
| Company, kept in company | 27% | 69.73 | 60.63 | 704.82 | 612.88 |
| Company, paid out as dividend | 41.6% | 55.78 | 48.51 | 563.85 | 490.31 |

Example: R100 × (1 − 0.31) after the fee = 95.52 × 0.69 = R65.91. If Chris
has a salary, his marginal rate is likely 31% or more, not 18%. Company and SBC
figures before dividends tax are only what stays in the company.

---

## 6. Unverified / to check

1. Which Absolute Hosting plan GnomeMedia is on, its exact price, and whether
   Absolute's prices include VAT (check the invoice).
2. Jev (TypeSafe) pricing and monthly bill: not in `aiUsage`.
3. Whether Anthropic (and Brevo) charge SA VAT on invoices; if not, possible
   imported-services VAT on past invoices over R100 (accountant).
4. Brevo prices above 5,000 emails a month.
5. Hetzner prices (official page did not render them) and the Hetzner South
   Africa / xneelo name history.
6. Afrihost: whether prices include VAT.
7. AWS: EBS disk, traffic-out and VAT not included.
8. Batch API typical turnaround (Anthropic says up to 24 h).
9. Capacity in section 4.2 is an estimate from earlier measurements, not a load
   test.
10. Typical AI cost rests on 10 days of mostly free school pupils and three
    days of Sonnet 5.5 marking. Paying users and courses with more written
    answers may use more. Re-run the queries after a month of paid use.
11. Tax: SBC conditions, whether online courses are an "education" professional
    service for turnover tax, zero-rating of exports (s11(2)(l)), and all of
    section 5: **accountant to confirm.**

## 7. How to re-run the usage numbers

The read-only queries are in the session scratchpad scripts `costq.py` and
`costq2.py` (not kept in the repo). They open the live database with
`PDO::SQLITE_OPEN_READONLY` as www-data and print only sums, counts and averages
per kind, model, day and pupil-day.
