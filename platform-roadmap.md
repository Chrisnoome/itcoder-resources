# Platform roadmap - teachers, subscriptions, landing page

**Status: all 25 questions answered 24 September 2026 (see the end). Steps 1, 2 and 3 BUILT the same day** - see platform.md, "Access is decided by Entitlements()", "Billing", "Teacher groups" and "Notifications". Next in the order below: step 4, the landing page and About. The IEB / CAPS / neither choice (Q23) is BUILT 24 September 2026 - see platform.md, "Syllabus boxes". (drafted 24 September 2026 from Chris's brief of
the same day). Answer the questions marked **Q** and this file becomes the
spec; once a part is built, move its rules into platform.md and delete them
here. Facts about outside services (gateways, fees, VAT) were NOT checked
online - verify each before relying on it.

## 1. Teachers, classes and invitations

### What Chris asked for

- Admin assigns the **teacher role** and links a teacher to **classes** and
  **email domains**.
- A teacher sees marks only for **their** pupils and courses.
- A teacher without a school domain **uploads a list of email addresses**.
- The list shows, per address: on the system? enrolled in the class?
- **No automatic enrolment**: a listed pupil who is on the system gets a
  notification - accept or reject. Buttons and tick boxes to **re-invite**.
- A way to **email** listed pupils who are not on the system - without it
  becoming a spam tool.

### Today

`pupils.isTeacher` (on/off, set by hand), `className` + `classYear` picked by
the pupil at sign-in, `IsPupilAccount()` = a `students.dlshcch.co.za` address.
Every teacher sees every school pupil (`teacher.php`, `pupil-work.php`). There
is no email sending of any kind, and no notification store.

### Proposed data

| Table | Holds |
|---|---|
| `teachingGroups` | id, name ("10A IT 2027"), courseId(s), year, ownerTeacherId, createdAt, archivedAt |
| `groupTeachers` | groupId, teacherId, role (owner / co-teacher) |
| `groupMembers` | groupId, pupilId, status (invited / accepted / rejected / removed), invitedAt, answeredAt, invitedBy |
| `groupInviteList` | groupId, email (lower-cased), addedAt, lastInvitedAt, inviteCount, pupilId when matched |
| `teacherDomains` | teacherId, domain (e.g. `students.stjohns.co.za`), approvedBy, approvedAt |
| `notifications` | id, pupilId, kind, text, link, createdAt, readAt, actionTaken |
| `emailLog` | id, toEmail, kind, sentAt, byTeacherId, providerId, status (every email, for abuse checks) |

A teacher's pupils = accepted `groupMembers` of their groups, **plus** (if Chris
wants it, Q1) anyone whose address is in one of their approved
`teacherDomains`. Every teacher page filters by that set - one function,
`TeacherCanSee (teacher, pupil)`, used everywhere.

### Flows

1. **Admin > Users**: make teacher / remove teacher; approve a domain for a
   teacher (only an admin, because a domain claims a whole school).
2. **Teacher > Groups**: create a group for a course; paste or upload a list
   of addresses (CSV or one per line, de-duplicated, validated).
3. The list page shows each address: *not on itcoder* / *on itcoder, invited*
   / *accepted* / *rejected*, with tick boxes and **Invite again** / **Remove**.
4. An address that is already on itcoder: the pupil gets a **notification**
   (bell in the masthead, and on their next sign-in): "Ms X wants to add you
   to 10A IT 2027 - Accept / Reject". Accepting enrols them in the course too.
5. An address not on itcoder: the teacher may send **one invitation email**
   (see anti-spam). When that person later signs in with that address, the
   invitation is waiting as a notification - still accept/reject.

### Keeping email from becoming a spam tool

- Only **invitations** - fixed wording written by us, the teacher's name and
  school, one link to itcoder. No free text from the teacher (Q3).
- Only to addresses on the teacher's **own list**, and at most **one email per
  address per 7 days**, **3 ever**, per teacher.
- A daily cap per teacher (e.g. 60), and a hard cap per new teacher until an
  admin trusts them.
- Only teachers an **admin has approved** can send email at all (or only paying
  teacher subscriptions - Q4).
- Every email has a one-click **"don't email me again"** link; that address is
  suppressed for every teacher. Bounces and complaints suppress it too.
- Everything in `emailLog`; admin sees a per-teacher count and can switch a
  teacher's email off.
- Sent through a transactional email service with SPF/DKIM/DMARC on
  itcoder.co.za (Q5), never from the VPS directly.

### Questions

- **Q1** Should a teacher with an approved domain see *every* pupil from that
  domain automatically, or only those who accepted an invitation? (Option A:
  domain = automatic visibility, like De La Salle today. Option B: invitation
  always, the domain only helps match addresses.)
- **Q2** One school with many teachers: should there be a **school** level
  (a head of department sees all the school's groups)? Or teachers only, for now?
- **Q3** May a teacher add a short personal line to the invitation email? (More
  friendly, more spam risk.)
- **Q4** Who may send invitation emails: any teacher an admin approved, or only
  teachers on a paid plan?
- **Q5** Which email service? (Options below, section 2.6.)
- **Q6** What happens to De La Salle's current set-up - convert each class
  (9C, 10A ...) into a group automatically, with its teachers as owners?

## 2. Subscriptions

### 2.1 What can be sold

| Option | Meaning |
|---|---|
| Free | every lesson, every self-marked question, the console; **no AI marking** (as today for non-school accounts) |
| Pupil - per course | AI marking and analysis in one course |
| Pupil - everything | all courses |
| Teacher | teacher tools (groups, invitations, class results) for N pupils |
| School | a domain licence: every pupil and teacher of a school, per year |

- **Q7** Which of these to launch with? (Suggestion: Free, Pupil-everything and
  School first; per-course and Teacher later.)
- **Q8** Billing period: monthly, per term, per year - or a once-off "Grade 12
  year" pass?
- **Q9** Does a teacher's subscription cover their pupils' AI marking (the
  teacher pays for the class), or does each pupil pay?

### 2.2 Access control

One function decides everything: `Entitlements (pupil)` gives back which
courses they may enter, whether AI marking is on (and its daily cap), and
whether teacher tools are on - from their own subscription, their school's
licence, or a group whose teacher pays. Every page and API asks it; nothing else
reads subscription rows. Today's `CanUseMarking()` becomes one of its answers.

### 2.3 Data

| Table | Holds |
|---|---|
| `plans` | id, name, kind (pupil / teacher / school), scope (course id or all), price per currency, period, AI cap per day, seats |
| `subscriptions` | id, plan, owner (pupil or school), status (trial / active / past due / cancelled / expired), startsAt, endsAt, gateway, gatewayRef, autoRenew |
| `payments` | id, subscription, amount, currency, VAT, gateway, gatewayRef, status, paidAt, refundedAt |
| `invoices` | number (sequential, never reused), payment, buyer name/address/VAT number, lines, PDF path |
| `aiUsage` | pupilId, day, calls, input tokens, output tokens, model, cost in rand - per subscriber (today `apiUsage` counts calls only) |

### 2.4 Payment gateways (verify before choosing)

| For | Options to look at | Notes |
|---|---|---|
| South African buyers | PayFast, Yoco, Ozow (instant EFT), Peach Payments, Paystack | Card, instant EFT, sometimes SnapScan/Zapper; payouts to an SA bank account; recurring billing support differs |
| Buyers abroad | A **merchant of record** such as Paddle or Lemon Squeezy | They sell on our behalf and handle foreign VAT/sales tax - much less admin than a plain card processor |

- **Q10** Is itcoder a business (sole proprietor, company), and is it or will it
  be **VAT registered**? (Invoices, VAT on SA sales and the accounting export
  depend on it - an accountant should confirm.)
- **Q11** Do you want recurring debit orders (auto-renew), or pay-per-period
  with a reminder (simpler, fewer failed-payment cases)?
- **Q12** Schools usually pay by invoice and EFT, not by card. Support "invoice
  a school, mark as paid by hand" from Admin?

### 2.5 Accounting records

Sequential invoice numbers, a payments ledger, refunds as their own rows (never
edits), VAT per line, and a monthly CSV export for the bookkeeper (Q13: which
package - Sage, Xero, a spreadsheet?). Gateway fees recorded per payment so the
real income is known. AI cost per subscriber (from `aiUsage`) against what they
paid, so a plan that loses money shows up.

### 2.6 Messages and notifications

- **In the site**: a `notifications` table and a bell in the masthead with a
  count. Kinds: marking done ("Your answer to lesson 16, question 3 has been
  marked" - the link opens the lesson at that question), invitation, payment
  due, subscription ending, a teacher's reset of a question.
- **By email** (only what matters: receipts, subscription ending, invitations,
  optional weekly summary). A transactional service - options to look at:
  Amazon SES, Postmark, Brevo, Resend. **Q5**.
- **Q14** Should pupils also get an email when marking is done, or only the
  in-site notification?

### 2.7 Carry on where you left off

`lessonPositions` already stores the scroll position per lesson, and the
heartbeat already runs. Plan: store the **last lesson and block** with every
heartbeat, and after sign-in offer "Carry on with Lesson 16 - Classes and
objects, at *Constructors*?" on the subjects page. **Q15** Offer it, or jump
straight there?

### 2.8 Other things to decide

- **Q16** Free trial for AI marking (e.g. 10 marked answers, or 14 days)?
- **Q17** Discounts: sibling, whole-class, school-wide, bursary / free for
  pupils who cannot pay?
- **Q18** Refund policy and cancellation (needed in the Terms before taking money).
- **Q19** Under-18s: parents pay. Does a parent need an account of their own
  (to pay and see marks), or just a payment link sent to them?
- **Q20** POPIA: a paid, multi-school platform needs an information officer
  registration, a data-processing agreement for schools, and a privacy policy
  update. Who handles that?
- **Q21** Prices shown in rand only, or rand plus dollars/euros for abroad?

## 3. A new public landing page

Today `index.php` is a sign-in page with a short explanation; it becomes
**About** (`about.php`). The new landing page is for someone who has never
heard of itcoder.

Possible sections, top to bottom:

1. One line: what itcoder is (e.g. "IEB IT programming, taught properly - with
   a live Pascal console and marking in seconds").
2. Three audience cards: **Pupils**, **Teachers**, **Schools** - each with what
   they get and a button.
3. The courses (from `CourseIndex()`), with grades and lesson counts.
4. What makes it different: the live console, AI marking with feedback,
   try-its, the SAGs map, study notes.
5. A short demo: a GIF or video of the console and of marking (Q22).
6. Pricing (from `plans` - never typed by hand into the page).
7. FAQ: is it free, is it IEB, what about CAPS, privacy.
8. Sign in / Start free.

- **Q22** A demo lesson that works **without signing in** (read-only, no
  marking)? It sells the site better than any description.
- **Q23** Is the audience IEB only, or also CAPS (NSC) IT schools?
- **Q24** Your name and teaching background on the page (trust), or the
  itcoder brand only?
- **Q25** Testimonials from De La Salle pupils/teachers (needs their consent)?

## Suggested order of work

1. Entitlements + plans + subscriptions set by hand in Admin (no gateway yet) -
   lets schools be sold to by invoice at once.
2. Teacher groups, the invite list and in-site notifications (no email yet).
3. Marking-done notifications and "carry on where you left off".
4. The landing page and About.
5. The email service, invitation emails with the limits above.
6. A gateway for card payments, receipts, the accounting export.

## Answers so far (Chris, 24 September 2026)

- **Q1** Invitation always. A domain only helps match addresses; no teacher
  sees a pupil who has not accepted.
- **Q2** No school level yet, but store a schoolId on groups and domains so one
  can be added later without changing the data.
- **Q3** Fixed wording only - the teacher's name, school and group are filled
  in, nothing else.
- **Q4** Only teachers an admin has approved may send invitation emails.
- **Q5** Chris wants email handled on the server (the volume is low). Checked the
  same day: the host **blocks outgoing port 25**, and the server's reverse DNS
  is a generic `102-214-9-207.zadns.co.za`, so it can't deliver mail directly.
  Port 587 is open, and itcoder.co.za's SPF already allows Absolute Hosting's
  mail servers (`include:_spf.absolutehosting.joburg`). DMARC is `p=none`; there
  is no MX record. **Decided: Brevo** (free for 300 emails a day; WhatsApp can be
  added in the same account, pay per message, Meta charges about R0.12 + VAT per
  utility message in South Africa from 1 October 2026). **Marked for later** -
  build the in-site notifications first; set up Brevo (SPF/DKIM for
  itcoder.co.za, API key in config.php) when invitation emails are built.
  WhatsApp, if ever: opt-in only, consent for under-18s (POPIA).
- **Q6** Turn De La Salle's classes into groups. Current pupils start as
  accepted, and Chris assigns teachers to the groups.
- **Q7** Launch with all four plans (pupil everything, pupil per course,
  teacher, school). Free may later be limited to sample courses or lessons.
  Prices wait until Chris's pupils have used it long enough to predict the
  real AI costs, so record the AI cost per subscriber from the start.
- **Q8** Yearly billing only.
- **Q9** Whoever pays covers the group: a teacher or school licence turns on
  AI marking for every accepted pupil in their groups (or school), up to the
  seats bought. A pupil's own subscription still counts.
- **Q10** Sole proprietor, not VAT registered. Store VAT fields anyway (0 for
  now) so registering later changes no data.
- **Q11** No automatic renewal: a reminder 30 and 7 days before expiry, with a
  pay link.
- **Q12** Schools can be invoiced from Admin (a PDF), and marked paid when the
  EFT arrives. This works before any card gateway exists.
- **Q13** A monthly CSV export (invoices, payments, refunds, gateway fees).
- **Q14** When marking is done, the pupil sees it in the site (bell, with a
  link back to the question), plus an email they can switch on in settings
  (email comes with Brevo, later).
- **Q15** After signing in, offer to carry on where the pupil was last busy
  (lesson and place). Never jump there without asking.
- **Q16** Trial: decide later. Build plans so a trial can be added.
- **Q17** Bursaries and free codes (admin issues a free or reduced
  subscription), and a general discount-code mechanism. Which discounts to give
  is decided with pricing.
- **Q18** A 7-day cooling-off period: a full refund within 7 days if little AI
  marking was used. After that no refund, and access runs to the end of the
  paid year. Put this in the Terms before taking money (a lawyer or accountant
  to confirm).
- **Q19** Parents pay through a link: the pupil presses "Ask a parent to pay",
  the parent pays without an account, and the receipt goes to the parent.
- **Q20** POPIA: Claude drafts the updated privacy policy, a data-processing
  agreement for schools and the registration checklist; Chris (or a lawyer)
  checks them and submits.
- **Q21** Rand only at launch; store prices per currency so dollars or euros
  can be added later with a foreign gateway.
- **Q22** One or two demo lessons anyone can try without signing in: answers
  are checked but not saved, and the console runs with tight limits.
- **Q23** The site is for anyone. IEB and CAPS notes are extras for South
  Africa. At enrolment, ask **IEB, CAPS or neither**; the syllabus lines shown
  under each lesson follow that choice. BUILT 24 September 2026 (asked on the
  course page rather than at the Join button; teachers and admins may also
  pick both) - platform.md, "Syllabus boxes".
- **Q24/25** The landing page carries Chris's name and teaching background, and
  quotes from De La Salle pupils and teachers (with written consent, no pupil
  surnames).
