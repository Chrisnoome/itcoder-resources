# The bundle - a new platform structure

**Decided 27 September 2026** (Chris: "need to do the bundle as new
structure. will need to make one for it as well"). CAT is split across eight
courses and a pupil needs most of them, so one thing they join must enrol the
lot. IT has the same shape already - IT Theory, Pascal, Java, SQL - so the
bundle is **platform work, not CAT work**, and IT gets one too.

*This is a platform design document, not a CAT one. It is written to sit at
the AIResources root beside `sql-runner-design.md`,
`compile-subsystem-design.md` and `live-console-design.md`, which it follows
in shape. It lives in `subjects/cat/` in the course-development repo only
because that is the one folder that repo writes to.*

---

## 1. Why `includes` is not enough

`CourseIndex()` already has `'includes' => ['theory10', 'theory11']`, and
`Enrol()` joins those too with real enrolment rows (`kit/platform.md`,
"Grades, chapters and board sections"). That is a **vertical** relation: a
grade chains to the grades below it, and the included courses are *the same
course, earlier*.

A bundle is **horizontal**: different courses, taken together, at the same
time. Three things break if `includes` is used for it.

- **The wrong thing owns the list.** `cat-theory10` would have to include
  Word, Excel, PowerPoint and HTML - so the theory course claims four
  courses it has nothing to do with, and "Includes ..." on its page reads as
  though it teaches them.
- **Grade 11 cannot be expressed.** Access joins at Grade 11 and the theory
  course for Grade 11 already includes Grade 10's, which already includes
  four application courses. The graph becomes a tangle whose membership
  nobody can read off a single row.
- **Billing is scoped to a course.** A plan's `scope` is *all* or *one
  course* (`Entitlements()`, `lib/billing.php`). Selling "CAT Grade 10" means
  either one plan per course or a plan scoped to a course that quietly
  entitles four others.

The alternative of a **shell course** - a course with `includes` and no
lessons - is worse: it appears in the catalogue with no content, and
`RequireEnrolment()`, progress, "carry on" and class results all have to
special-case it.

## 2. What a bundle is

**A named, grade-aware set of courses that a pupil joins once.** It is not a
course: it has no lessons, no glossary and no progress of its own. Everything
it does is fan-out and grouping.

Proposed shape, alongside `CourseIndex()` and `SubjectIndex()` in
`lib/course.php`:

```
BundleIndex()
  id        'cat10'
  subject   'cat'              // an existing SubjectIndex() key
  title     'CAT Grade 10'
  grade     10
  courses   ['cattheory10', 'word', 'excel', 'powerpoint', 'html']
  status    'open' | 'draft' | 'soon'     // same three as a course
  blurb     one line for the catalogue card
```

**Enrolment.** `EnrolBundle (pupil, bundleId)` calls the existing `Enrol()`
once per course, which already writes real enrolment rows, so class results,
Practice and "carry on" keep working with no change. A course already joined
is left alone. Moving up a grade is another `EnrolBundle()` - it adds what is
new (Access at Grade 11) and touches nothing else.

**Membership is derived, never stored.** The enrolment rows stay the single
source of truth. That is what makes the IT bundle safe to introduce over
pupils who joined Pascal and SQL separately months ago: nothing about them
changes, and the bundle page simply shows the courses they already hold.

**Billing.** Add `scope = 'bundle'` with a `bundleId` to `plans`, so
`Entitlements()` can answer `CanUseMarking (pupil, courseId)` with "yes,
their plan covers a bundle that contains this course". One plan, one price,
one invoice line - which is the point of the exercise.

**What the pupil sees.** One card in the catalogue per bundle rather than
eight, and a bundle page listing its courses with each one's progress. The
existing `courses.php?s=` grouping by subject stays as it is; a bundle is a
narrower thing than a subject, because a subject holds all three grades.

## 3. Decisions (Chris, 27 September 2026)

- **One bundle per grade**, and **a grade carries the ones below it**:
  joining CAT Grade 12 gives Grades 10 and 11 as well. This is the rule the
  theory courses already follow (`kit/theory-course.md` decision 1); the
  bundle inherits it rather than inventing anything. **There is a pricing
  differential** - Grade 12 costs more than Grade 11, which costs more than
  Grade 10, because it carries more.
- **Chapters inside an application course follow the same rule.** A Grade 12
  pupil sees the Grade 10, 11 and 12 chapters of the Word course; a Grade 11
  pupil sees Grade 10 and 11; a Grade 10 pupil sees Grade 10 only. So a
  chapter is grade-tagged and shown when its grade is at or below the
  pupil's - one comparison, and it matches how a course already includes the
  grades beneath it.
- **The IT bundle is board-aware**: IT Theory for the grade, SQL, and the
  language courses - **CAPS gets Pascal, the IEB gets Pascal and Java**. The
  IEB lets the school choose Delphi or Java, so the bundle carries both
  rather than guessing (question 32).
- **A bundle is sold as a plan, and single courses stay on sale too.** A
  pupil who only wants Excel can still buy Excel.

### The bundles

| Bundle | Courses | Note |
|---|---|---|
| `cat10` | CAT Theory 10, Word, Excel, PowerPoint, HTML | No Access - neither board teaches databases before Grade 11. HTML's Grade 10 chapter is CAPS-only. |
| `cat11` | CAT Theory 11, Word, Excel, Access, PowerPoint, HTML | Access joins. PowerPoint stays: it is Grade 10 content, and a Grade 11 pupil carries Grade 10. |
| `cat12` | CAT Theory 12, Word, Excel, Access, PowerPoint, HTML | Everything. |
| `it10` / `it11` / `it12` | IT Theory for the grade, SQL, and the language courses: **CAPS gets Pascal; the IEB gets Pascal and Java** | The IEB lets the school choose Delphi or Java, so the bundle carries both and the pupil uses the one their school teaches. |

The application courses repeat across all three CAT bundles. That is correct
and harmless - `Enrol()` is idempotent, and what differs between a Grade 10
and a Grade 12 pupil inside the Word course is which chapters they see, not
which course they hold.

## 4. Work involved

Largest first. None of it is large next to upload-and-mark or the
spreadsheet evaluator.

1. **`BundleIndex()`, `EnrolBundle()` and the bundle page** - the structure
   above, a catalogue card, and a page listing member courses with progress.
2. **`scope = 'bundle'` in billing** - `plans` gains a `bundleId`,
   `Entitlements()` learns the one extra case, Admin > Billing gains a
   bundle picker where it now picks a course.
3. **Catalogue grouping** - `courses.php` shows a bundle card in place of
   its member courses for a subject that has bundles, with "see all courses"
   still available.
4. **Grade chapters in an application course** - a `'grade' => 10` key
   beside the existing `'chapter' => 'Word processing'`, and one comparison
   against the pupil's grade wherever the course page builds its list. Small,
   and it is the thing that makes one Word course serve all three grades.
5. **The IT bundles** - configuration once question 32 is settled, plus a
   check that existing IT enrolments are untouched.
6. **Board-aware membership** - the IT bundle's language course depends on
   the pupil, so `EnrolBundle()` resolves the list against their board (and
   enrols everything for a pupil on `both` or `none`, as board sections
   already do).

## 5. What this does not change

- `includes` stays exactly as it is, for the grade cascade inside IT Theory
  and CAT Theory. A bundle contains courses that may themselves include
  others; the fan-out is just `Enrol()` called on each, which already
  handles that.
- `glossaryFrom` is unaffected. CAT's eight courses still share one glossary.
- Enrolment rows, class results, Practice, "carry on" and
  `RequireEnrolment()` need no change at all.

## 6. Questions

Numbered on from `course-plan.md` §5, which ends at 27.

Questions 28-31 were answered on the day they were asked; the answers are
§3 above. One follow-up:

**32. Which language course does an IEB pupil get? Answered 27 September
2026: both.** "The board's language" is exact for CAPS - Delphi, which the
Pascal course teaches - but the IEB lets **the school** choose Delphi or
Java, so board alone cannot decide it. **The IEB bundle carries both Pascal
and Java**; a pupil uses the one their school teaches and ignores the other.
No new field, no default to get wrong, and a pupil who changes schools is
already covered.

This is what keeps work item 6 on the list: the CAPS and IEB bundles hold
different courses, so `EnrolBundle()` resolves its list against the pupil's
board, and a pupil on `both` or `none` gets everything - the rule board
sections already follow.

**33. What is the pricing differential?** Grade 12 carries three years of
content, Grade 10 one. The `plans` rows need actual numbers before Admin >
Billing can sell a bundle. Not a structural question - a number from Chris.
