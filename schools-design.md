# Schools, cohorts and classes - the agreed design

Chris, 3 October 2026 (his brief, in full in the design doc): "we need a
logical structure here - a school can have multiple teachers teaching a
cohort ... think about how to make the onboarding process as simple and pain
free as possible". The design doc, reviewed and every question answered by
Chris on 3 October 2026:
https://claude.ai/code/artifact/6dea2b45-17ce-41b7-95a4-3f1b96b2ddd8

This file is the rule as it now stands. It replaces the roadmap's "no school
level yet" (platform-roadmap.md Q2, 24 Sep 2026) and "a group is one class in
one course" (platform.md, teacher groups). Build status: see open-items.md.

**Built (phase 1, 3 Oct 2026; live the same day):** the tables (schools with kind, town, domains,
approvedAt; schoolTeachers; teacherTeaches; cohorts; cohortCourses;
teachingGroups.cohortId), today's groups moved across on every setup.php run
(`MigrateGroupsToCohorts()`, only groups with no cohort; De La Salle made from
config's schoolEmailDomains; a teacher with a personal address gets "School of
<name>" with no domains for the admin; a group with no grade anywhere stays as
it is and is named in setup's output), the teaching link through the views
(`MakeTeachingViews()`), the weighting (`MarkWeighting()`, 70 : 30, every
weighted mark and the dial's explanation). After an independent review the
same day: the TIC sees every class's work and marks, but messages, mark
queries, "the pupil's teacher" (year plan), days off and teacher-plan seats
stay with each class's own teachers; a TIC who no longer teaches a class of
the cohort hands it on; the privacy policy, invitation and My account say
so. Code: lib/schools.php, bin/check-schools.php (52 checks).

**Built (phase 2, 3 Oct 2026; live the same day):** Set up classes,
`public/teach.php` - the six steps (who: teacher or parent; school: the one
the staff address belongs to in one tap, a new school, or a home school "The
<surname> family"; subjects x grades; each grade: join the school's cohort in
one tap or tick its courses, board and language, "one class / several
classes"; class names; class codes and links, the calendar one tap when
nobody at the school has one, else copied from a colleague). Anyone signed in
may start it (`TeacherSignUpRefusal()`: never a school's pupil address, nor a
pupils' domain by its name); `BecomeTeacher()` makes the account a teacher
(teacherGrantedAt, so Admin > Not a teacher undoes it) and tells the admins
(a bell); a new school or home school is live at once, the admins told, and
waits on Admin > Teachers and groups > Schools ("Looks right" approves, "Undo"
archives). **Staff and pupil addresses are told apart** (schools.domains =
staff, schools.pupilDomains = pupils; De La Salle split by name:
students.dlshcch.co.za pupils, dlshcch.co.za staff - `SplitSchoolDomains()` on
setup). **Class codes**: six letters/digits without I, L, O, 0, 1
(teachingGroups.joinCode); `public/join.php` (sign in first, then back) shows
the class, its teachers and courses and who will see the work, then Join -
typing the code is the pupil's yes, even after leaving; the class page shows
the code and link with New code / Turn the code off; a class made in the
wizard or on My groups gets one (and is placed in its cohort at once). **At
once for the school's own pupils**: a teacher on an *approved* school's staff,
signed in with its staff address, joins its pupil addresses without Join
(`SchoolJoinsAtOnce()`, besides the admin-approved teacher domains), and sees
them to tick on the class page. Joining a class - code, invitation or at once
- enrols the pupil in every course of its cohort (`EnrolInClass()`). The
first-visit redirect and the menu go to Set up classes (the old Setup guide
page stays, unlinked); Join a class is in every pupil's menu and on My
account; Features offers both, home schooling self-serve. Code: lib/schools.php
(phase 2 section), bin/check-schools.php.

**Who sees pupils' work (Chris, 3 October 2026, after the review of phase 2
and POPIA - popia-checklist.md: "See work only after approval"):** a teacher
an admin made, or one signed in with an approved school's staff address, sees
the work of their classes' pupils at once. Anyone else who sets up (a personal
address, a new school, a parent) has classes and codes at once and pupils can
join, but sees no pupil's work, name or address, may not delete accounts, gets
no instant joins and no free paid courses until an admin approves them
(Admin > Teachers and groups > Waiting for approval; a teacher checked on
SACE). A parent ticks "I am the parent or legal guardian" when setting up; a
teacher "I will add only pupils I teach". "Not a teacher" stops them setting
up again, turns their codes off and hands their grades on; undoing a school
archives its grades and classes. One rule for all of it: `TrustedTeacherSql()`
/ `IsTrustedTeacher()` (lib/schools.php) - the teaching link's view, Class
results (`TeacherWorkGroups()`), access (`IsStaffAccount()`,
`IsSchoolLinked()`) and `DeletePupilForTeacher()` all ask it. bin/check-schools.php
(107 checks).

**Built (phase 3, 3 Oct 2026; live the same day):** **Term marks**
(`public/term-marks.php`, menu Teacher > Term marks, and "Term view" on Class
results for a class in a grade): one grade and one term - the year plan's
lessons for that term from every course of the grade, grouped by course, each
pupil's weighted mark per lesson and the **term mark** (the parts of every
ticked lesson added up, then weighted with the grade's weighting). A tick under
each lesson: ticked at first for this grade's own work (a lesson revisited from
an earlier grade, or optional, starts unticked); only the TIC (trusted) or an
admin changes the ticks (table `termTicks`) and the weighting (written 0-100%
in steps of 5); other teachers see both "set by" the TIC. A teacher sees their
own classes; the TIC every class and "Whole grade" - and Class results now
lists the TIC's other classes too (the weekly nudge stays their own). Excel
downloads the term. Pupils see their grade's term marks on My progress and My
marks. The terms follow the TIC's calendar (else a class teacher's) until
cohorts have their own (phase 4); **a pupil in a grade follows the same plan**
(the grade's board, the TIC's calendar and lesson order - PupilPlanOptions()).
**What a term mark counts (Chris, 3 Oct 2026, after the review):** while the
term runs, the work marked so far, with how much is done beside it ("74% so
far - 3 of 12 lessons done"); once the term is over, a question still open
(not tried, or a written answer never handed in) counts as 0. A term that was
over before the grade was set up here has no term mark (a class made in
October 2026 has only Term 4). A tick belongs to its lesson whatever term a
calendar change moves it to; a page left open on a term the plan no longer
has saves nothing. Class results gives the TIC "Whole grade" too. Code:
lib/termmarks.php, bin/check-termmarks.php (33 checks).

**Built (phase 4, 3 Oct 2026; live the same day):** **one calendar
per school** (schools.planCalendar, planDates, daysOff): the school's admin
(schools.adminTeacherId - who set the school up, else the TIC of its oldest
grade, else its first teacher; handed on in Teacher settings, and when its
admin stops teaching) or a site admin sets it in Teacher settings part 1, with
the school's days off; the others see it read-only. A teacher's own days off
(part 4) count for their own classes. `PlanCalendarHolder()` makes every
calendar reader follow the teacher's school once it has a calendar (until then
their own). **Each grade's year plan**: cohorts.dialect, cohorts.planRevision
and the table cohortPlanOrders, set by its trusted TIC (Teacher settings part
2, the Year planner, "Edit the grade's Year planner"); the planner opens on the
teacher's grades as tabs (nothing to enter), "Another grade" is the free
planner, saving nothing for a teacher at a school; pupils, the Term view and the
countdown follow the grade (`CohortCalendarHolder()`, `CohortPlannerOptions()`).
A 2026 grade shows on the 2027 calendar (the first full year the site has).
**Completion dates in a grade**: progressRules.cohortId, one per course for the
whole grade, only its TIC; a class in a grade gets none of its own. **Next
year**: December to March, "Set up <year>" on Class results, My groups and the
planner opens the setup wizard with last year's grades ticked and each grade as
last year's; a new grade copies last year's weighting, database, revision
weeks, order and term ticks (`StartCohortPlan()`). Setup brings existing
schools and grades across (`MigrateSchoolPlans()`, once). After an
independent review the same day (13 findings, all fixed):
- a grade's completion date replaces its classes' own for that course, so a
  pupil gets one plan and one reminder a week, and only from the rule that
  decides their plan;
- a grade's rule counts the school's days off, never the TIC's own;
- joining a school never makes its admin (only setting it up does, then
  `HandOnSchoolAdmin()`'s order);
- every new grade, however it is made, starts its plan at once, and a deploy
  never overwrites a grade's own choices (a pre-phase-4 grade takes its TIC's
  old settings, never last year's), and a school's calendar is copied from a
  teacher only when it first gets its admin;
- a pupil in a grade plans on the grade's board (CAPS when none is chosen),
  its school's calendar and days off (a teacher at two schools brings none of
  the other's), and each stream's order from its own board;
- Stop shows only where it works;
- "Set up <year>" is per school and stops once the teacher has set up that
  school's coming year.

Code: lib/schoolplan.php, bin/check-schoolplan.php (74 checks).

**Built (phase 5, 3 Oct 2026; live the same day):** **Admin >
Schools** (public/admin-schools.php, site admins only): every school with its
counts; one school's page changes:
- its details: name, town, kind, staff and pupil email domains - never a
  personal domain such as Gmail, never another school's;
- its staff: add a teacher by email; take one off once they teach none of its
  classes, their roles passing on;
- its admin, its calendar and its days off;
- its grades: the teacher in charge (one of the grade's own class teachers),
  board, language and courses (a course the page does not offer stays); merge
  a grade into a twin of the same grade and year; archive a grade with its
  classes;
- its classes: rename, add or remove teachers (a class keeps one, and an
  owner), move to another grade of the school, archive, and move pupils one by
  one to another class of the school;
- merging the whole school into another.

Nothing is deleted. Archived and merged things are archived, and pupils keep
their accounts and work.

After an independent review the same day (8 findings, all fixed):
- a school merge keeps either school's approval, and an unapproved school's
  domains never come along (they would trust its self-made teachers);
- an admin never moves a pupil into a class they said no to or were taken out
  of, and the pupil is told. The privacy policy and popia-checklist.md say so;
  the attorney question is in the checklist;
- a class archived, or moved into a grade, stops its own completion dates (and
  an archived class's rule covers nobody, whichever page archived it);
- a class moved into a grade with nobody in charge brings its teacher.

Approving schools and teachers stays on Teachers and groups. Code:
lib/schooladmin.php, bin/check-schooladmin.php (53 checks).

## The structure

- **School** - a school, or a home school (one family). Holds name, town,
  staff and pupil email domains, the school calendar (terms, exams), timetable
  cycle, days off, the school's database, the licence. **One calendar per
  school**, shared by all its teachers; a teacher's own days off stay theirs.
- **Teacher** - an account teaching at a school, with the subjects and grades
  they teach there.
- **Subject x grade -> courses** - the fixed list of courses that can make up
  a subject in a grade (IT Gr 11: Pascal, Java, SQL, IT Theory 11; CAT Gr 11:
  CAT Theory 11, Word, Excel, Access, HTML); a course covering several grades
  is listed under each. Built from the course list.
- **Cohort** - one school's grade in one subject for one year. Holds the
  courses ticked from that list, **one exam board and one language** (a school
  with IEB and CAPS pupils in a grade has two cohorts), the **TIC** (teacher in
  charge), the **weighting** (written : other, default 70 : 30, steps of 5%),
  and the lessons that count for each term. One cohort per school, grade,
  subject and year: a second teacher joins it and adds their class.
- **Class** - a named part of a cohort ('11 R', 'Key X'), its teacher(s) and
  pupils. A cohort taught as one class has one. A pupil in a class is joined to
  every course of the cohort.

## Who does what

- **Only the TIC sees every class in the cohort** (class name shown); other
  teachers see their own classes. A teacher alone in a cohort is its TIC.
- The TIC (or admin) sets the courses, board, language, weighting and the term
  ticks; other teachers see them read-only ("Set by <TIC>"). The TIC can hand
  the role on.
- Admin fixes anything: merge schools or cohorts, move classes or pupils,
  change a class's teacher or the TIC, edit a cohort, archive a class.
- **New teachers go straight in** (no admin approval first): a teacher at a
  known school domain is live at once; a new school is live too, the admin is
  told and can undo it.
- **Pupils join a class** by a class link or code they use themselves (that is
  their "yes"), by email invitation, or at once for the school's own domain.
- **Home schooling is self-serve** (replaces the 1 Oct 2026 "contact us"): a
  parent goes through the teacher wizard as "I'm a parent", gets a home school
  named after the family, is TIC of every cohort; each child is a class's pupil.
- **Individual pupils change nothing**: no school, class or cohort is asked;
  default 70 : 30 weighting.

## Marks

- Class results lists only the teacher's classes (the TIC also "Whole
  cohort"). Two views per class: **Course** (every lesson of one course) and
  **Term** (Term 1-4: the year plan's lessons for that term from all the
  cohort's courses, in plan order, grouped by course, then the term mark).
- A tick under each lesson in the Term view = counts for the term mark;
  starts ticked for the plan's lessons of that term; only the TIC changes it.
- **Term mark** = the weighted mark over the ticked lessons. Shown in the Term
  view, the Excel export, and **to pupils** (My marks, My progress).
- **The weighting** is the cohort's and replaces the fixed 50 : 50 everywhere
  a weighted mark is shown (dials, My progress, dashboard, Class results,
  Excel, lesson badge tiers). Not in a cohort: 70 : 30. **The weighted dial
  says the ratio** and who set it.

## Year planner

**Phase 4 decisions (Chris, 3 October 2026):**
- **School calendar** (terms, exam dates, school days off): set once per
  school, by **the school's own admin**, so a growing site does not wait on
  the site admins ("schools must have a designated admin capable of doing
  this - if the site grows i won't be able to keep up"). Site admins can
  still change it. Other teachers see it read-only. A teacher's own days off
  stay theirs.
- **The grade's year plan** (database, revision weeks, the order of topics):
  set by the grade's TIC (or an admin). Other teachers see it read-only.
- **Completion dates** for classes in a grade: one per course for the whole
  grade, set by the TIC. A class's existing date stays until it is changed.
- **Next year:** from December, teachers see "Set up <next year>". One tap
  copies last year's grades and courses. They name the new classes, and
  pupils join with new codes. Last year's grades stay readable.
- **Term marks:** a three-term school never shows a Term 4.

One plan per cohort for its subject, from its own choices (board, language,
database, courses) and its school's calendar - never re-entered on the planner
page. IT as today underneath (three streams); a one-course subject has one
stream; CAT the same way once its courses and term maps exist. Pupils follow
their cohort's plan. The plan year becomes the cohort's year (not the fixed
2027).

## Sign-up wizard (teachers and parents)

Six steps, mostly taps: who are you (teacher / parent) - your school
(suggested from the email domain) - subjects and grades - each cohort (join
the existing one in one tap, or tick courses, board, language, and say if
others teach it / several classes) - name the classes - add pupils (class
link or code, paste or upload, tick the school's pupils). The calendar is
never asked if the school has one; the first teacher gets one tap. The rest
(reminders, days off, completion dates) is in Settings with defaults.

## Today's data

De La Salle becomes the first school (its domains, its teachers' calendar).
Every group becomes a class; groups of the same school, grade, subject and
year become one cohort (TIC = owner of the oldest group); members stay
accepted; groups with no grade are matched by name or pupils' class, the rest
listed for the admin. Planner orders, completion dates and progress rules
move to the cohort. **The De La Salle class picker retires** once its classes
exist. Licences: linked to the school only; what a licence unlocks comes later
with billing.

## Build order

1. Foundations: tables, migration, the teaching link, the cohort weighting
   (70 : 30) and its dial text.
2. Sign-up wizard, class links and codes, joining a cohort, home schools.
3. Marks: class lists, Course and Term views, term ticks, term marks
   (pupils too), Excel.
4. Year planner per cohort.
5. Admin Schools page.
