# Merge instructions - CAT cloud session, 27 September 2026

**For a local chat with AIResources open.** This folder holds the output of a
cloud session that planned Computer Applications Technology and, along the
way, designed one new platform structure. The cloud session could not see
AIResources, so nothing has been merged - that is this job.

**Read this whole file before touching anything.**

---

## The one rule: append, never rewrite

`platform.md` and `history.md` were both written at **17:01 on 27 September
2026**, while this session was still running. Other chats are live in them.

- **Add** new sections, rows and entries.
- **Never** rewrite, reorder or reflow a section you did not add.
- If a section you were going to add already exists with different content,
  **stop and ask Chris** rather than reconciling it yourself.
- Check each target file's modified time before and after your edit. If it
  changed underneath you, re-read and redo the append.

## What is in this folder

| File here | Goes to | New or append |
|---|---|---|
| `cat-caps.md` | `AIResources/cat-caps.md` | **New file** |
| `cat-sags.md` | `AIResources/cat-sags.md` | **New file** |
| `cat-caps-exam-analysis.md` | `AIResources/cat-caps-exam-analysis.md` | **New file** |
| `cat-ieb-exam-analysis.md` | `AIResources/cat-ieb-exam-analysis.md` | **New file** |
| `cat-it-theory-reuse.md` | `AIResources/cat-it-theory-reuse.md` | **New file** |
| `courses/cat-course.md` | `AIResources/courses/cat-course.md` | **New file** |
| `bundle-design.md` | `AIResources/bundle-design.md` | **New file** |
| `appends/platform.md` | `AIResources/platform.md` | **Append** a new section |
| `appends/platform-roadmap.md` | `AIResources/platform-roadmap.md` | **Append** items |
| `appends/history.md` | `AIResources/history.md` | **Append** a dated entry |
| `appends/open-items.md` | `AIResources/open-items.md` | **Append** one open item |

The seven new files are drops - copy them in, no merging needed. The four
`appends/` files are fragments: paste each into the named file, in the place
its own header tells you.

**`pilot/` is not in that table, on purpose.** It holds one CAT lesson
written as a sample - `computer.php` plus four doodles - for Chris to read
and decide about. **Do not copy any of it into `content/` or
`public/assets/`.** `pilot/README.md` says what was checked, and lists the
seven things that were not. The first of those matters to a platform chat:
the lesson uses `BoardSection()` with a signature taken from a two-day-old
snapshot of `platform.md`, because no real lesson file using it was
available to copy from. Check it against `lib/content.php`.

### Why the `cat-` prefix

The root already holds **IT's** `caps-2024.md`, `sags-2025.md`,
`caps-practical-exam-analysis.md`, `caps-theory-exam-analysis.md`,
`ieb-practical-exam-analysis.md` and `ieb-theory-exam-analysis.md`. CAT's
files cover the same ground for a different subject and would collide, so
every one of them carries a `cat-` prefix. **Do not rename IT's files** -
other chats are using them under the names they have.

CAT has one analysis file per board covering both that board's papers, where
IT has one per paper. That is deliberate: CAT's practical and theory papers
are described as Part One and Part Two of the same file.

## Order to do it in

1. **The seven new files first.** They touch nothing that exists, so they
   cannot conflict.
2. **`open-items.md`**, then **`platform-roadmap.md`** - small, low traffic.
3. **`platform.md`** - one new section. Read the file first and put it where
   sections about courses and enrolment already live; do not guess from this
   document, which was written against the 25 September snapshot in the
   course-development kit and is out of date on structure.
4. **`history.md`** last, as the record that the merge happened.

## What is *not* here, and should not be invented

- **No code.** `bundle-design.md` is a design, not an implementation. Nothing
  in `Projects/AIPascalCourse` has been touched.
- **No lessons in `content/`.** The one lesson that exists is the pilot, and
  it is not to be merged. Chris's instruction on 27 September was "don't do
  work yet, we are still planning".
- **No pricing.** Deferred: the courses go up free for De La Salle pupils
  while AI costs are tracked, and prices are set from those figures.
- **No textbook.** A CAT textbook PDF is to be sourced; the course must
  differ substantially from it and be written in Chris's voice, since its
  chapters are other authors' work. Planning went ahead without it.

## The three things a platform chat needs to know

Everything else here is CAT content. These are not.

1. **The bundle is new structure** (`bundle-design.md`). A grade-aware set of
   courses a pupil joins once. It is **not** `includes`, which is vertical -
   a grade chaining to the grades below it. IT needs one as much as CAT does.
2. **Upload-and-mark is new** and it is the largest piece of work in the CAT
   plan. `.docx`, `.xlsx` and `.pptx` are Office Open XML - a ZIP of XML
   parts that PHP reads with `ZipArchive` and `SimpleXML`, no library and no
   shell-out. Marking extracts the values and sends **those** to the model
   against a rubric; the file itself never goes to the API. `.accdb` is the
   exception - proprietary binary, read with `mdbtools`.
3. **Chapters need a grade.** A `'grade' => 10` key beside the existing
   `'chapter' => '...'`, shown when its grade is at or below the pupil's. It
   is what lets one Word course serve Grades 10, 11 and 12, and it is the
   same rule `includes` already applies between courses.

One smaller thing, learnt the hard way while drawing the pilot's figure:
**a `Figure()` diagram must be inline SVG.** An external `.svg` loaded
through `<img src>` is an isolated document, so `var(--ink)` never reaches
it and every stroke resolves to nothing - the figure renders as an empty box,
with no error anywhere to tell you why.

## When you are done

Delete this folder, and delete
`AIResources/course-development/subjects/cat/` - an earlier, partly stale
copy of the same six CAT files from the middle of the session. **This folder
is the authoritative one.** Then tell Chris which files you added and which
you appended to, and whether anything had moved underneath you.
