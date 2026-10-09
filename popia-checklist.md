# POPIA checklist - for an attorney

Drafted 3 October 2026 at Chris's request ("what would our legal obligations
be? would we need to verify school credentials? for parents would we need to
verify the relationship? how? popia?"), when teachers and home-schooling
parents became able to set themselves up (schools-design.md, phase 2). **Not
legal advice** - a list of what the site does today and the questions to put
to an attorney before self-sign-up is opened to the public.

## What the site holds

From the privacy policy (public/privacy.php) and the code: name and Google
email; class and year; answers, marks and AI feedback; time on the site and
sign-ins; typing records of written answers; messages to teachers with their
pictures; notifications; for teachers, their classes, school, subjects and
calendar. No ID numbers, addresses, phone numbers, photos of people or ages.

## Who is who (sections 1, 20, 21)

- **Individual users and home schools:** BestLessons (Chris) is the
  **responsible party**.
- **Schools:** the school is normally the responsible party for its pupils and
  BestLessons its **operator**. Section 21 needs a **written contract** between them
  requiring the security measures of section 19, and the operator must tell the
  school at once of any unauthorised access. **To do:** an operator agreement
  template for schools - De La Salle first.

## Children (section 35)

A child's personal information may be processed only with the **prior consent
of a competent person** (a parent or guardian), or on another ground in s35(1)
(e.g. necessary for a right or obligation in law). A child pressing Join is not
that consent. Where the site stands:

| Who | Consent today | Gap |
|---|---|---|
| A school's pupils | The school (enrolment), once there is an operator agreement | The agreement itself |
| A home school's children | The parent ticks "I am the parent or legal guardian ... and I agree to [the site] keeping their work and marks" when setting up (pupils.teacherSelfServeRole, teacherSelfServeAt) | Ask: is that declaration enough, and should it name the purposes? |
| Pupils of a private tutor or a teacher with a personal address | None from a parent; the admin approves the teacher before any work is shown | Ask: must the site collect a parent's consent for these pupils (e.g. a parent's email confirmation)? |
| Individual sign-ups under 18 (no teacher) | None | Ask: what consent step is needed at sign-up? |

**Uploaded files (CAT, 9 October 2026):** Chris approved the upload consent
screen as built ("upload consent ok"): before the first upload the pupil
agrees, and a pupil under 18 names the parent or guardian agreeing with them;
refused means no upload and no marking. Files are kept until 31 December,
opened only by the pupil, their class teachers and (with a reason) an admin,
every opening logged (courses/cat-uploads-design.md).

## Showing a child's work to an adult (section 19)

Reasonable measures against unauthorised access. What the site does (Chris, 3
October 2026: "see work only after approval"):

- A teacher an admin made, or one signed in with an **approved school's staff
  address** (the school controls who has one), sees their own classes' pupils
  at once.
- Anyone else who sets up (a personal address, a new school, a parent) sees
  **no pupil's work, names or addresses** until an admin approves them. The
  admin checks a teacher on SACE's public educator status page (ID or SACE
  number, "in good standing"). A parent's relationship cannot be checked
  against a register: home-education registration (Schools Act s51, as amended
  by the BELA Act) does not apply after Grade 9 or age 15, and most pupils here
  are in Grades 10-12. So: the declaration, the child's own join, and the
  admin's look.
- Until approved: no deleting accounts, no instant joining of a school's
  pupils, no free paid courses. "Not a teacher" stops them setting up again.
- Each pupil joins a class themselves (a code, a link or an accepted
  invitation), and can leave it on My account. The one exception (phase 5,
  3 October 2026): the site's administrator can move a pupil from one class
  of their school to another (a timetable change). The pupil is told, and
  never moved into a class they said no to or were taken out of. The
  privacy policy says so.
- **Ask:** is an administrator's move between a school's classes covered by
  the pupil's first "yes" to the school, or does it need the pupil's own yes
  each time?
- **Ask:** is this "reasonable"? Should the admin's check be written down
  (what was checked, when)?

## Standing obligations

- **Information Officer** (sections 55-56): register with the Information
  Regulator (Chris, or a deputy).
- **Privacy notice** (section 18): public/privacy.php - check it names every
  recipient and purpose below.
- **Security compromises** (section 22): a written procedure for telling the
  Regulator and the people affected; the operator's duty to tell a school.
- **Retention** (section 14): how long work is kept after a pupil leaves a
  school or stops using the site.
- **Rights** (sections 23-25): see, correct, delete - privacy.php offers them;
  a parent for a child under 18.
- **PAIA:** ask whether a PAIA manual is needed.

## Information leaving South Africa (section 72)

- **AI marking:** the question, the rubric and the pupil's answer go to
  Anthropic (USA), never the name or email - but an answer may contain
  personal information.
- **AI judgements:** lib/jev.php calls TypeSafe (api.typesafe.ai) - check what
  it sends.
- **Email:** Brevo sends the site's emails (addresses and message text).
- **Videos:** YouTube embeds load from youtube-nocookie.com.
- **The server:** confirm its country (vps-access.md does not say).
- **Ask:** does each need consent or an adequate-protection basis under s72?

## Questions for the attorney

1. For self-serve teachers and parents, is admin approval plus the declaration
   enough, or must a parent's own consent be collected for every child outside
   a school?
2. The operator agreement for schools: a template, and what it must say.
3. Consent wording for under-18 sign-ups without a teacher or school.
4. Cross-border transfers (AI marking, TypeSafe, Brevo, the server).
5. Information Officer registration and a PAIA manual.
6. How long to keep a pupil's work, and what a teacher's "delete pupil" may
   remove.
