# Append to: AIResources/platform-roadmap.md

Add these as roadmap items, largest first, in whatever shape the file
already uses. All of them come out of the CAT plan
(`courses/cat-course.md` §4) but only the first five are CAT-specific in
their *timing* - every one of them is platform work.

---

## From the CAT plan (27 September 2026)

1. **Upload and mark.** Pupils do the task in the real application and hand
   in the file. Four parts: an upload block (check `taskreview` first - the
   IEB IT PAT pre-check already takes an uploaded document); an inspector
   (`.docx`/`.xlsx`/`.pptx` are Office Open XML, read with `ZipArchive` and
   `SimpleXML` - no library, no shell-out); `mdbtools` for `.accdb`; and the
   marking route - extracted values plus a rubric to Haiku 4.5, escalating
   to Sonnet 5 only for whole-document judgement. **The file never goes to
   the API.** Largest item in the CAT plan.
2. **The spreadsheet grid and formula evaluator.** A grid the pupil types
   into and an evaluator for the ~58 functions the CAT syllabuses name.
   Bounded, because that list is closed and printed in `cat-caps.md` and
   `cat-sags.md`. The same evaluator reads a pupil's `<f>` element out of an
   uploaded `.xlsx`, so it is one build serving both.
3. **Simulations.** Three tiers: a hotspot on a screenshot (small, no more
   machinery than `match`); a guided sequence of hotspots with a hint on a
   wrong click (medium, best value); a working fake dialog with state
   (large, first to break when the ribbon moves - worth it for perhaps
   three dialogs).
4. **Bundles.** `BundleIndex()`, `EnrolBundle()` fanning out through the
   existing `Enrol()`, `scope = 'bundle'` in `plans`, and a catalogue card.
   See [bundle-design.md](bundle-design.md). **IT needs this too.**
5. **Grade-tagged chapters.** A `'grade' => 10` key beside the existing
   `'chapter' => '...'`, shown when its grade is at or below the pupil's.
   Lets one Word course serve all three grades. Small.
6. **The HTML block.** An editable HTML box with a live sandboxed preview
   and a tag-and-attribute marker. No server, no compile queue - the browser
   is the runtime, and both boards examine a fixed printed list of about 20
   tags, so the answer space is closed. Covers 15-24 marks of every CAT
   practical paper.
7. **Screenshots of Office and Windows.** Not code, but the largest content
   cost and the one that decays: Microsoft 365 updates monthly. Needs a
   capture recipe at a fixed window size (the Pascal course's
   `tools/ui-screens/` is the model), a naming convention, a callout style,
   and a **termly** re-shoot list rather than a yearly one.
