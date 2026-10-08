# Uploaded work, marked - design (CAT practical courses)

**Status (8 October 2026): phase 1 built, not committed or published** - the
`upload` block, consent, keeping/opening/log/delete, the year-end job,
.docx/.xlsx/.pptx/.html reading (.accdb too, the same day), exact and Jev
checks with Claude when Jev is unsure, the teacher's view, and the worked
examples "Format the notice" at the end of the CAT pilot's Word lesson and
"The chess club's table" at the end of its Access lesson. How it works: platform.md, "Uploaded
work, marked"; the rule format: lib/uploadmark.php. Still open: the consent
question below, the cron line for `bin/upload-retention.php` on the server,
and what is "Not in the first build".

Chris, 8 October 2026: build uploads before the CAT practical courses ("Build
uploads first"), from decisions 3, 7 and 17 in [cat-course.md](cat-course.md)
section 3.0 and section 4 item 1. Same day: files are **kept until the end of
the school year**, and **the pupil and their teachers** may open them, every
opening logged. Jev first in the marking (content-voice-and-pedagogy.md 4b).

## What a pupil sees

In a lesson, an `upload` block: the task ("Open Notice.docx, apply Heading 1
to the title, centre the date, save, and upload it here"), the file(s) to
start from (a download), what will be checked (the checklist, as a pupil
rubric), and an upload box. After uploading: within seconds, a mark per check
and feedback built from the checks, as with a written answer. One upload
counts for marks; a pupil may upload again until the teacher's or the
block's limit (default 2 tries: like simulations, the better mark stands).

## Consent first (decision 17)

Before the first upload, the pupil sees why the file is kept, for how long,
who can open it, and how to delete it, and is asked to agree. **Refused: no
upload and no marking for that pupil, and the block says why** - the rest of
the lesson works as normal. The agreement is stored once per pupil
(`pupils.uploadConsentAt`, and who gave it). For a pupil under 18 the wording
asks for the parent's or guardian's agreement ("My parent or guardian and I
agree ..."). **Open for Chris** (popia-checklist.md, "Children"): whether a
school's own agreement covers its pupils, or a parent must confirm separately.
The gate is one function, so the rule can change without touching the blocks.

## Keeping, opening, deleting

- **Stored outside the web root**, `data/uploads/<pupilId>/<courseId>/<lessonId>/<blockId>-<n>.<ext>`,
  served only through a PHP endpoint that checks who is asking.
- **Allowed types per block** (`.docx`, `.xlsx`, `.pptx`, `.html`/`.htm`,
  `.accdb`), a 10 MB cap, and a content check (a .docx must be a real ZIP
  with `word/document.xml`; an .accdb must be a real Access file).
- **Who may open it:** the pupil; teachers of a class the pupil is in;
  admins only through a "support" action that asks for a reason. **Every
  opening is logged** (who, when, which file, why for admins), and the pupil
  can see the log for their own files.
- **Kept until 31 December of the school year it was uploaded in**, then
  deleted by a daily job. The mark and the check results stay; the file goes.
- **The pupil can delete a file sooner** - the mark stays, and the evidence
  for a query goes with the file (the delete button says so).

## Marking: inspect, Jev, then Claude

1. **Extract** (PHP, no external library): `.docx`, `.xlsx`, `.pptx` are ZIPs
   of XML - read them with ZipArchive and DOMDocument. Pull out only what the
   block's checks ask for: a paragraph's style, alignment, font and size; a
   run's bold or colour; page breaks, section breaks, orientation, margins;
   headers and footers; tables; a cell's formula (`<f>`), value and number
   format; conditional formatting; charts; sheet names; slide count, layouts,
   transitions; HTML's tags and attributes.
2. **Each check** in the block is one of:
   - **exact** - code decides from the extracted values (style of the first
     paragraph is Heading1; cell F2's formula, normalised, is `SUM(B2:E2)`);
   - **Jev** - a Noul on extracted values when the rule needs judgement
     ("does `formula` add up B2 to E2?" - accepts `=B2+C2+D2+E2`); sure,
     Jev decides; unsure, the check goes to Claude with the same extract.
   The file itself never goes to an AI - only the extracted values.
3. **Mark and feedback** per check, in the site's feedback shape ("Marks for
   ...", "Where you lost marks: ..."), shown at once (inspection and Jev take
   well under a second; a Claude check goes through the queue and appears
   when done, like a written answer).

## Teachers

The class results show the mark; "Open the file" (logged) and the check
results per pupil; a teacher may change a mark with a reason, as for written
answers. The existing `taskreview` machinery (lib/tasks.php, task-upload.php)
is the starting point for storage and the queue.

**Access, built 8 October 2026** (Chris: "build the access marker now";
mdbtools installed on the server the same day): `lib/accdb.php` reads tables,
field properties, primary keys, relationships, queries (from MSysQueries)
and data; a query is marked by **what it returns** - the pupil's query and
the model answer are run on the pupil's own data (in-memory SQLite) and
compared; what cannot be re-run goes to Jev. platform.md, "Access (.accdb)".
The example: "The chess club's table" in the CAT pilot's Access lesson.

## Not in the first build

Whole-document judgements by Sonnet ("is the layout sensible"), and the PAT
pre-check for CAT.
