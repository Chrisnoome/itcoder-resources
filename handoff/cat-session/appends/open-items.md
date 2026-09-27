# Append to: AIResources/open-items.md

Four items, in whatever shape the file already uses.

---

- **CAT bundle pricing.** Grade 12 carries three years of content and Grade
  10 one, so the three CAT bundles need different prices. Deferred on
  purpose: the courses go up free for De La Salle pupils while real AI costs
  are tracked (`aiUsage`, Admin > Billing's per-person figures and monthly
  CSV), and prices are set from those. The `plans` rows wait on a number
  from Chris. (`courses/cat-course.md` §5 q33.)
- **Verify `mdbtools` against a real Grade 12 Access database** before the
  upload marker is built. It read the boards' own `.accdb` files cleanly
  during the CAT analysis - `mdb-tables` and `mdb-schema` both - but only
  the schema read is proven. Test queries, calculated fields and a
  relationship. `.mdb` is the documented fallback, at the cost of four data
  types the SAGs names (Large Number, Rich Text, Attachment, Calculated
  Field).
- **Check whether Microsoft's terms allow its UI screenshots to be
  redistributed in a paid course.** The five CAT application courses need
  3-10 screenshots a lesson. Worth settling before the first capture rather
  than after 500 of them.
- **Re-download the DBE's November 2023 CAT Paper 2 memo.** The file
  published under that name on the DBE site is a second copy of the 2023
  Paper 1 memo - different bytes, identical extracted text, both headed
  "P1", both carrying the P1 totals. The 2023 Paper 2 analysis in
  `cat-caps-exam-analysis.md` therefore rests on the question paper alone.
