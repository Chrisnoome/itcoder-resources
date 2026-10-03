# Pricing suggestions - IT and CAT

Written 3 October 2026 from [costs-research.md](costs-research.md),
[market-research.md](market-research.md) and
[payments-research.md](payments-research.md). **Nothing is decided.** Every
figure below traces to those three files; check their "unverified" lists
before a price goes public.

## The short version

- Lessons and self-marked questions stay free. **People pay for AI marking,
  analysis and teacher tools.** So the paid tier competes with "help beyond
  the textbook" (e-books R70-R345 a subject a year, The Answer Series
  R299-R599, Khanmigo about R713, tutors R300-R500 an hour), not with the
  free Siyavula and DBE books.
- **One consumer price list for everyone**, CAPS and IEB alike - the content is
  the same, and asking a parent which board they write before quoting a price
  feels wrong. Charge more where the money really differs: **school licences**,
  priced by school type.
- **Suggested headline: R349 a year for a whole subject (IT or CAT), R39 a
  month, R149 a year for one course.** About a third of a print textbook set,
  less than one tutor hour a term.
- **The caps must change before any price is safe.** At today's caps one
  pupil can burn R430 of AI in a school month. Typical use is R3.53. Give
  every paid plan a monthly AI budget in rand (below), not just a call count.

## 1. What a subscriber costs

From costs-research.md (real usage 24 Sep - 3 Oct 2026, 157 people,
R16.73 to the dollar, a "school month" = 16.67 school days):

| | Per subscriber per month |
|---|---|
| AI, typical (Sonnet 5.5 marking) | R3.53 |
| AI, busiest real pupil-day every day | R24.12 |
| AI, today's caps fully used | R430 (R784 using it every day) |
| AI, a 20 / 40 cap | R86 |
| Hosting share at 2,000 subscribers | about R1 |
| Paystack | about 3.3% + R1.15 per payment |
| **Floor, typical use** | **R5.48** |
| **Floor, heavy use** | **R26.79** |

Add 15% to the floor once VAT registered (compulsory at R2.3m turnover).

## 2. Fair use: a rand budget per plan

A call count cannot tell a cheap Haiku check from a Sonnet re-mark. `aiUsage`
already records every call's cost in rand, so `Entitlements()` can read
**rand used this month** against the plan's budget:

| Plan | AI budget a month | Past the budget |
|---|---|---|
| One course | R10 | marking moves to the Batch API (half price, answer within hours, not seconds) |
| One subject | R15 | the same |
| School licence | R4 per pupil, pooled across the school | the same; the school's admin sees the pool |

- No hard stop mid-term: a pupil past the budget still gets marked, just
  slower and at half the cost. A second, hard limit (2x the budget) stops
  abuse.
- Typical use (R3.53) is about a quarter of the subject budget; the busiest
  real pupil (R24 a month) would move to batch marking for the last third of
  the month.
- Why so low: a budget must sit well under the price. R349 a year is about
  R35 a school month; a R40 budget (the first draft) lets one pupil cost more
  than they pay. With R15, a subject plan stays profitable even if **every**
  subscriber uses the whole budget (section 5).
- Also in costs-research.md: caching on marking costs 9.6% more than it saves
  today (3,098 tokens written, 243 read); fix it or switch it off.

## 3. Suggested consumer prices (parents and pupils)

Prices include VAT "if applicable" - see section 6.

### IT

| Plan | Covers | Year | Month |
|---|---|---|---|
| Programming course | Pascal **or** Java, Grades 10-12 | R149 | R19 |
| SQL course | SQL and databases, Grades 10-12 | R99 | R15 |
| Theory course | one grade (theory10, 11 or 12) | R99 | R15 |
| **IT subject** | every IT course, every grade | **R349** | **R39** |

### CAT

| Plan | Covers | Year | Month |
|---|---|---|---|
| CAT theory course | one grade | R99 | R15 |
| **CAT subject** | every CAT course, every grade | **R299** | **R35** |

CAT is a little cheaper: its practical paper (25% of the mark) cannot be AI
marked, so there is less to sell. Revisit once the HTML and spreadsheet
engines exist (cat-course.md).

### Extras

| Plan | Price | Why |
|---|---|---|
| **Grade 12 exam pass** | R250, July - November (Chris) | the season parents most want to spend in; less than one tutor hour |
| Both subjects | R549 a year | rare (pupils take IT or CAT) but cheap to offer |
| Sibling discount | 10% off the second child | standard in SA school fees |
| Term | R119 a term per subject | for parents who budget by term |

- A year is about **9x the month** (R349 vs R39), rewarding the annual buy
  without punishing monthly payers. A school year is 10 months, so monthly
  payers pay R390.
- Bursary codes (already built) for pupils who cannot pay.

## 4. Teachers and schools

| Plan | Price | Compare |
|---|---|---|
| **Teacher** (tools + AI marking for their groups, one subject) | R1,500 a year, up to 40 pupils; R30 a pupil after that | Siyavula R2,050 a teacher and subject (ex VAT) |
| **Public school licence** (CAPS) | R60 a pupil a year, minimum R3,000 | Snapplify Engage R250 a user; e-book R70-R345 |
| **Independent school licence** (IEB / ISASA) | R150 a pupil a year, minimum R6,000 | fits inside a tech levy; IEB IT books alone are R755-R1,000 a year |

- Schools pay by invoice and EFT, annually (already built in Admin >
  Billing). Offer 10% off a multi-year commitment.
- The independent price is where the IEB anchors in market-research.md (R100 -
  R350 a pupil) belong. Ask the school, never the parent.

## 5. What the numbers look like

Per IT subject year at R349 (paid annually, Paystack card):

| | Rand |
|---|---|
| Price | 349.00 |
| Paystack (2.9% + R1, plus VAT on the fee) | -12.79 |
| AI, typical, 10 months | -35.30 |
| Hosting share | -10.00 |
| **Left before income tax** | **290.91** |
| Heavy user (R26.79 a month floor, 10 months) | 81.10 left |

Revenue at a few sizes (consumer subjects only, R349 a year, no schools):

| Subscribers | Year | Month (average) |
|---|---|---|
| 100 | R34,900 | R2,908 |
| 500 | R174,500 | R14,542 |
| 2,000 | R698,000 | R58,167 |
| 10,000 | R3.49m | R290,833 |

At about 6,600 subject subscribers turnover passes R2.3m and **VAT
registration becomes compulsory** - plan for it earlier, not on the day.

### 5.1 Margin after tax, by number of enrolments

One enrolment = one subject year at R349, paid annually by card. Worked in
`margin.py` (scratchpad, 3 October 2026). **Assumptions - change any and the
numbers move:**

- **AI** from costs-research.md: typical R42 a subscriber a year (US$0.01265 a
  day x 200 school days x R16.73); heavy R290. Plus 15% imported-services VAT
  on AI while not VAT registered (the cautious reading of costs-research 5.3).
- **Mix** = 85% typical, 15% heavy users (an assumption - no paid users yet).
- **Fixed costs** a year: hosting R2,832 up to 1,500 subscribers, R13,200 at
  2,000, about R24,000 at 5,000 (interpolated), R42,000 at 10,000; Brevo from
  1,000 subscribers; **R12,000 for an accountant** (assumed).
- **Paystack** 2.9% + R1 per payment, plus VAT on the fee while unregistered.
- **VAT** registered only above R2.3m turnover (the 10,000 row): 13.04% of
  every sale goes to SARS.
- **Sole proprietor:** income tax is the extra tax on top of Chris's other
  income - **R450,000 salary + about R300,000 textbook royalties = R750,000**
  (Chris, 3 October 2026). That puts every BestLessons rand at **39%, then
  41%** from R887,000 (2027 brackets).
- **Company:** 27% company tax, then 20% dividends tax when paid out (41.6%).
- Leaves out your own time, marketing, refunds, bad debt and school licences.

**Realistic mix (85% typical, 15% heavy), kept after tax as a sole
proprietor, at 1x to 4x the price** (per year; per enrolment in brackets):

| Enrolments | x1: R349 | x2: R698 | x3: R1,047 | x4: R1,396 |
|---|---|---|---|---|
| 100 | R5,891 (R59) | R26,470 (R265) | R47,049 (R470) | R67,628 (R676) |
| 250 | R28,298 (R113) | R79,745 (R319) | R129,632 (R519) | R179,392 (R718) |
| 500 | R65,643 (R131) | R165,753 (R332) | R265,274 (R531) | R364,795 (R730) |
| 1,000 | R137,942 (R138) | R336,985 (R337) | R536,028 (R536) | R730,565 (R731) |
| 2,000 | R275,771 (R138) | R673,501 (R337) | R1,044,598 (R522) | R1,235,347* (R618) |
| 5,000 | R699,546 (R140) | R1,418,438* (R284) | R2,225,171* (R445) | R3,031,903* (R606) |
| 10,000 | R1,186,615* (R119) | R2,800,080* (R280) | R4,413,545* (R441) | R6,027,010* (R603) |

\* VAT registered (turnover over R2.3m): 13% of every sale goes to SARS.
VAT becomes compulsory at about **6,590 enrolments at x1, 3,295 at x2, 2,197
at x3 and 1,648 at x4.**

The same enrolments are used in every column to show the arithmetic. **In
reality a higher price sells fewer enrolments.** The question is how many
fewer:

| To keep what x1 gives at... | x2 needs | x3 needs | x4 needs |
|---|---|---|---|
| 1,000 enrolments (R137,942) | 420 | 266 | 195 |
| 2,000 enrolments (R275,771) | 822 | 521 | 380 |

So doubling the price pays if it loses fewer than about **58%** of buyers;
quadrupling it, fewer than about **80%**.

Where each price sits against the market (market-research.md):

- **x1 R349** - about the price of one e-book set; below The Answer Series'
  top (R599). An easy yes for most parents.
- **x2 R698** - about Khanmigo (about R713) and an IEB pupil's IT books for a
  year (R755-R1,000). Fine for IEB families, a stretch for many CAPS ones.
- **x3 R1,047** - the price of a full print textbook set; about 2-3 tutor
  hours.
- **x4 R1,396** - above any SA self-study product found; still about a fifth
  of Brainline's R6,500-R7,850 a subject, and under the cheapest
  international coding platforms (R2,300+).

**At x1, if every user used the whole R15 budget** (the worst the budget
allows): R9 kept per enrolment at 100, about R82-R92 from 500 to 5,000 -
still positive. **Without a budget, if every user were heavy:** a loss at
every size (R5-R145 per enrolment). That is why section 2 matters.

**Company instead of sole proprietor:** at your 39-41% rate, a company that
**pays everything out** (27% + 20% dividends tax = 41.6%) keeps about the same.
A company that **keeps the profit inside** (27%, or less on SBC rates) keeps
noticeably more - worth asking the accountant about once profit passes about
R100,000 a year.

What the table says:

- Most of the margin is price, not volume: at x1 you keep about R138 an
  enrolment; at x2 about R337; at x4 about R730.
- The first 100 enrolments mostly pay the fixed costs at x1; at x2 and up
  they are already profitable.
- The per-enrolment figure drops when VAT registration starts (13% of every
  sale). Registering voluntarily earlier, with prices set VAT-inclusive from
  day one, avoids a step.

## 6. Tax and VAT in the price

- Not VAT registered today. Show prices as "incl. VAT where applicable" from
  day one, so registering later means keeping the price and absorbing 13% of
  it (R349 holds R45.52 of VAT) rather than putting the price up mid-year.
- Or set prices now with VAT room in them and register voluntarily (from R120k
  turnover) to claim input VAT back on Anthropic, Brevo and hosting.
  costs-research.md: while unregistered, foreign invoices over R100 may
  attract 15% imported-services VAT anyway.
- Turnover tax probably does not apply ("education" is a professional
  service). Selling to the UK or EU through Paystack means registering there
  with no threshold - so **sell in rand to SA buyers only at first**, and use
  a merchant of record (Paddle) if overseas demand appears.
- **An accountant must confirm all of this** before launch, and whether to
  trade as a sole proprietor or a (Pty) Ltd.

## 7. Before launch (from the three research files)

1. Raise the site-wide AI budget: it is still the default US$5 a day and
   switches AI off at about 395 active pupils in a day.
2. Per-plan rand budgets in `Entitlements()` (section 2); lower the
   all-kinds limit of 200 calls a day.
3. Fix or switch off prompt caching on marking.
4. Annual consumer plans need an expiry notice 40-80 business days before the
   end (CPA s14); the 30- and 7-day reminders are too late.
5. Accountant: VAT, entity, imported services, foreign sales.
6. Confirm the unverified prices in market-research.md before any comparison
   appears on the landing page.

## Decided (Chris, 3 October 2026)

- **One consumer price for CAPS and IEB.** The extra IEB money comes from the
  independent school licence.
- **Headline: R349 a year / R39 a month per subject.**
- **Grade 12 exam pass: R250** (July - November), not R149.
- **Free AI-marking trial** - length or number of marks still to set.
- **Sibling discount 10%.**
- **De La Salle pupils free** while Chris teaches there.
