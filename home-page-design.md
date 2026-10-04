# The selling home page - design

Written 4 October 2026 from Chris's brief ("we need to look at the main
site ... show what they are getting") and the commercialisation research
([pricing-suggestions.md](pricing-suggestions.md),
[competitor-review.md](competitor-review.md),
[market-research.md](market-research.md)). **A plan to discuss, then mock
up, then build - nothing is built.** The rules already in platform.md
("Home page", 1 Oct 2026) stay unless this file says otherwise.

## The idea in one line

A textbook that does what a textbook never could. Every section says what
the visitor *gets*, in their own words, and never names a competitor.

## Order of sections

| # | Section | For | The promise |
|---|---|---|---|
| 1 | **Hero: the flipping textbook** | everyone | two cards, Pupils and Teachers, each flipping through its promises |
| 2 | **In every lesson** | everyone | the rotating promises again, one by one, each with a picture or a short animation |
| 3 | **Home schooling** | parents | be a real teacher: time worked, work done, marks |
| 4 | **Teachers** | teachers | everything a parent gets, plus the year plan on your calendar, every answer and mark, each pupil's habits |
| 5 | **Schools** | heads of department, schools | a class of 35 at a class price, then so much per extra pupil; several teachers per grade; "what we give you vs the old way" |
| 6 | **Sign in** | everyone | Google sign-in, one account per person, no shared accounts |
| 7 | **Subjects and prices** | everyone | a course or a subject bundle at a discount; earlier grades always included |
| 8 | Footer | | privacy, terms, contact - **no "built by"** |

Each section is short on the home page and links to its own page where it
needs more (platform.md: `features.php` exists already - it becomes the
"In every lesson" long form, or splits into pupils / parents / teachers /
schools pages).

## 1. The hero - the flipping textbook

Two cards side by side (stacked on a phone), each shaped like a book cover.
Every few seconds a card flips (3-D flip on the vertical axis, or a spin)
to its next promise; a visitor can also tap through. Respects
`prefers-reduced-motion` (then a fade).

**Pupils' card - "A textbook that ..."**

1. teaches you - short lessons that ask as they explain
2. checks your progress - and tells you when you are behind
3. marks your work - written answers and code, in seconds, with the reason
4. helps you revise - weak spots, a revision list, your own notes
5. plans your year - the school calendar, what is due this week
6. lets you play to practise - word games, quests, badges, collectables
7. runs your code on the web - Pascal, Java and SQL, nothing to install
8. costs less than three tutor sessions (section 7 proves it)

**Teachers' card - "A textbook that ..."**

1. does your year planning for you - on your school's calendar
2. watches every pupil's progress - who is behind, who is ahead
3. marks for you - every written answer and program, with feedback
4. shows you each pupil's weaknesses - rushing, misreading, misconceptions, careless slips
5. gives you term marks - which lessons count, weighted as you choose
6. lets you drill down - every answer, every mark, every question
7. works for a whole grade - several teachers, one plan

Under the cards: **Start free** (Google sign-in) and **See what it costs**.

## 2. In every lesson

The same promises, one row each, alternating picture left / text right.
Pictures are real screenshots or short animated GIFs from the site:
marking appearing under an answer; the console running a program; a badge
being earned; a collectable revealed from the mist; the progress check's
"3 behind"; the revision list; a note on a question; the year plan.
**Screenshots come from the local test site with the test pupil - never a
real pupil's name, work or marks.**

Keep the three things Google's OAuth review reads: the sign-in
explanation, who gets AI marking, the privacy link.

## 3. Home schooling - be a real teacher

- See how long your child worked today and this week (time spent).
- See exactly what they did: every lesson, every answer, every mark.
- Their marks per lesson and per course; the progress check.
- Their weak spots and their habits (the flaw log, in parent's words).
- The year plan on the calendar you choose; you set the pace.
- Self-serve: Set up your classes, approved by the admin (schools-design.md).

## 4. Teachers

Everything in 3, plus:

- Year planning that matches your school's calendar (terms, exams, days
  off) - the plan is made for you; you adjust it.
- Class results: drill down to every pupil's answer and mark for every
  question; reset a question; flag pasted work.
- Individual reports on each pupil's weaknesses: reading the question,
  completeness, knowledge, care and accuracy, effort (lib/flaws.php's
  five groups) - with what to do about each.
- Term marks: tick which lessons count, set the weighting, export to Excel.
- Messages: a pupil's "Message my teacher" with a picture of their work.

## 5. Schools

- **Enrol as a teacher with a class of 35** at the class price (R6,000 a
  year); every pupil after that at R120.
- **Disadvantaged schools can contact us for sponsored pricing** (Chris,
  4 Oct 2026) - one line with a contact link, no price.
- Several teachers can share a grade (cohorts); one calendar per school;
  the teacher in charge sets the grade's plan.
- The school's own admin manages staff, classes and the calendar.
- A **"What you get vs the old way"** table - no competitor named:
  textbook only / tutor / BestLessons, rows for marking, planning, progress,
  weaknesses, code on the web, cost per pupil a year.
- Invoice and EFT; the school licence in Admin > Billing (built).

## 6. Sign in - no shared accounts

Google sign-in only, one account per person; a class account or a shared
login is against the terms (a pupil's marks, notes and habits are theirs).
Say it plainly here and in the terms.

## 7. Subjects and prices

**Built around 3x the research price (Chris, 4 Oct 2026), easy to change:**
every price on the page is read from `plans` and `bundles` (platform.md:
"never typed by hand into the page") - so changing a price is editing a
plan in Admin > Billing, and the page follows. No multiplier in code.

| Plan | 1x (research) | **3x (launch)** |
|---|---|---|
| Subject bundle - IT, every course, every grade | R349 / R39 a month | **R1,047 a year / R117 a month** |
| Subject bundle - CAT | R299 / R35 | **R897 / R105** |
| One course (Pascal or Java, all grades) | R149 / R19 | **R447 / R57** |
| One course (SQL; a theory grade; a CAT theory grade) | R99 / R15 | **R297 / R45** |
| Grade 12 exam pass (July - November) | R250 | **R750** |
| Teacher: a class of 35, one subject | R1,500 for 40 | **R6,000 a year**, then **R120 a pupil** |
| School licence, per pupil a year (public / independent) | R60 / R150 | **R180 / R450** |

- **Earlier grades always included**: buy IT Theory 11 and Theory 10 comes
  with it; buy Theory 12 and 10 and 11 come too. A subject bundle has every
  grade, so a pupil who wants to jump ahead buys the bundle.
  (Implementation: a plan's scope `bundle:<id>` already covers a list of
  courses - make one bundle per grade that includes the grades below.)
- The bundle discount is visible: "three courses bought one at a time
  R1,341 - the subject R1,047".
- "Less than three tutor sessions": R1,047 against R300-R500 an hour
  (competitor-review.md section 1) - say "about three tutor hours".
- Sibling discount 10%, bursary codes, De La Salle free (decided).
- Prices in rand, VAT "where applicable".

**Per-plan AI budgets at 3x** (pricing-suggestions.md section 2 was sized
for 1x): raise to R30 a course, R45 a subject, R12 a pupil for schools.
Still far under the price; typical use is R3.53.

## Graphics and motion

- Hero flip: CSS 3-D transform, 4-6 s per face, pause on hover, dots to
  tap. Mock up first as an artifact page (Chris: "do mockups of animation
  before building").
- Section pictures: screenshots at 2x from the local site, cropped tight;
  animated GIFs (3-5 s, under 1 MB each) for marking, a badge, a
  collectable, Run in the console. Made with the built-in browser against
  the local site (`.claude/launch.json`), test pupil only.
- Course art and icons as today (`HomeCourseLook()`).

## What changes in the code (once agreed)

- `public/index.php` + `lib/home.php` + `assets/home.css`: the sections
  above; prices from `plans`/`bundles`; "built by" removed (also in
  `features.php`).
- `public/features.php` -> the long forms, or pupils / parents / teachers /
  schools pages, each linked from its home section.
- `lib/access.php` bundles: one per grade including the grades below.
- Admin > Billing: the 3x plans and bundles entered (not code).
- Terms: one account per person.

## Decided (Chris, 4 October 2026)

- **One course** = a stream for all grades (Pascal, Java or SQL, Grades
  10-12, R447); a theory grade (R297) includes the grades below it; the
  subject bundle has everything.
- **Teacher class plan**: R6,000 a year for a class of 35, then R120 a
  pupil. Disadvantaged schools contact us for sponsored pricing.
- **Grade 12 exam pass**: R750.
- **First mock-up**: the hero flip cards.

## Still open

- **Q4** Your name and background on the page (roadmap Q24)? "Built by" goes;
  does the About page keep it?
- **Q5** A demo lesson that works without signing in (roadmap Q22)?
- **Q6** Which pictures first: marking, console, badge, collectable,
  progress check, revision list, year plan - all, or a shortlist?
