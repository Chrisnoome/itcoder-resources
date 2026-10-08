# CAT 11 lesson 28: Processing data in a spreadsheet and a database - videos

Lesson file: `AIPascalCourse/content/cattheory11/processingdata.php`. Board
drawn in the CAT marker style with Clicky (brand/cat-art-style.md); yellow
highlighter on any words being talked about. Everything below is in the
lesson text. Screen recordings are in the VM, on a workbook and a database
made from the lesson's own numbers (the eight rows, the messy six rows, the
90-answer summary, the late-coming register). The Excel and Access courses
teach the clicks; these videos show what the tools do, not every step.

## cat11-28.1 Clean, sort, filter, count (about 8 min)

**Goes:** after section `#counting` (the comment `// VIDEO cat11-28.1`, after `w28Compare`).
**The pupil can afterwards:** name records and fields, choose data types, clean survey data, sort and filter it, and read a COUNTIF and a SUMIF.
**Thumbnail:** tag `CAT · PAT`, title "90 answers. *Now what?*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. 90 answers, nearly
   a thousand cells - and not one answer yet.
2. **Records, fields, data types (0:30-1:50).** A row is a record, a column
   is a field. Short Text, Long Text, Number, Currency, Date and Time,
   Yes/No, AutoNumber. A phone number is Short Text - as a Number, the 0
   falls off.
   > Screen: Excel with the eight rows; highlight row 5 (a record), then column C (a field).
   > Board: the phone-zero drawing.
3. **Cleaning (1:50-3:40).** The six messy rows: walk / Walking, "35 min",
   "twenty-five", "Gr 8", 600 minutes, a blank. The seven steps: keep a raw
   copy; same spelling; plain numbers; look for impossible values; leave
   blanks blank (a 0 pulls the average down - five 20s average 20, add a 0
   and it is about 17); split tick-all-that-apply; group open answers.
   > Screen: Find and Replace "Walking" with "Walk"; sort Minutes to find the 600.
4. **Sorting (3:40-4:40).** Whole rows move. Minutes, largest first: pupil 4
   (40), then pupil 1 (35). Sort by Transport, then Minutes.
   > Screen: Data > Sort on Minutes, descending; then a two-level sort.
5. **Filtering (4:40-5:50).** Tick only Walk: pupils 1, 4 and 8; the row
   numbers jump. Add Grade 8: pupils 1 and 4. Clear: all eight are back.
   Nothing is deleted. A criterion is the condition.
   > Screen: Data > Filter, the arrow on Transport, tick Walk; the arrow on Grade, tick 8; clear.
6. **COUNTIF and SUMIF (5:50-7:30).** =COUNTIF(C2:C91,"Taxi") - where to
   look, what to count; 3 on the eight rows. ">30" for long trips.
   =SUMIF(C2:C91,"Taxi",E2:E91): R510, average R170. The summary table: 36
   taxi (40%), 27 walk (30%), 9 bus, 9 lift, 9 bicycle or other; divide by
   the 90 who answered. Adding data questions: do walkers feel less safe?
   > Screen: type the COUNTIF and SUMIF on the eight rows and watch 3 and 510 appear.
   > Board: highlighter on the range and the criterion inside the formula.
7. **Sign-off.**

## cat11-28.2 Asking a database a question (about 6 min)

**Goes:** after section `#database` (the comment `// VIDEO cat11-28.2`, after `w28Database`).
**The pupil can afterwards:** say what a form, a query and a report do, read AND, OR and NOT criteria, and choose between a spreadsheet and a database for a job.
**Thumbnail:** tag `CAT · DATA`, title "Ask the *database*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. 600 pupils, a
   table of transport routes, three people in the office at once. That is
   not a job for a spreadsheet.
2. **Forms (0:30-1:20).** One record at a time; each field with its data
   type and rules - Grade 8 to 12, Suburb from a list.
   > Screen: in the VM, an Access form for the Pupils table; try Grade 15 and see it refused.
3. **A query, step by step (1:20-3:20).** Which Grade 8 pupils from Kliptown
   walk? Choose the table; choose the fields (Name, Grade, Suburb, Parent's
   phone); type the criteria; sort by Name; run - fourteen records; save,
   and run again next term.
   > Screen: Query Design on Pupils; criteria on one row; Run; Save.
4. **AND, OR, NOT (3:20-4:30).** AND: every criterion true - shorter list.
   OR: at least one - longer list. NOT: everything except.
   > Board: two overlapping circles (Grade 8, Walk); Clicky colours the middle for AND, both circles for OR, outside Walk for NOT.
5. **Reports, and which tool (4:30-5:40).** Group by suburb; count, sum,
   average, smallest, biggest. Then the Learn / Memorise table: spreadsheet
   for calculating, charts, what-if, one table; database for many records,
   related tables, forms, queries, reports, many users.
   > Board: the buckets drawing; then the two-column table, highlighter on each strength.
6. **Sign-off.**

## cat11-28.3 Charts that fit the data (about 7 min)

**Goes:** after section `#charts` (the comment `// VIDEO cat11-28.3`, after `w28PieTick`).
**The pupil can afterwards:** spot a pattern, a trend and an outlier, choose a chart that fits the shape of the question, make it honest, and put it in a report.
**Thumbnail:** tag `CAT · PAT`, title "Your chart is *lying*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. A chart can mislead
   without one wrong number in it.
2. **Patterns, trends, outliers (0:30-2:20).** Average safety by transport:
   lift 4.5, bus 3.8, taxi 3.1, walk 2.4 - a pattern. Late-coming January to
   June: 40, 45, 52, 48, 66, 75 - a trend, up towards winter, one dip in
   April. The 600-minute outlier. Careful: small groups mislead; going
   together does not prove causing - the area, the dark?
   > Board: the late-coming numbers drawn as a line, Clicky pointing at the April dip.
3. **Fit the chart to the question (2:20-4:30).** One choice: pie (a few
   slices) or column. Tick all that apply: column or bar, never a pie - the
   parts add up to more than 100%. Rating scale: columns in order 1 to 5.
   Numbers: group into ranges first. Two groups: two colours and a legend.
   Over time: line.
   > Screen: Excel; Insert a pie of the 90-answer summary; then a column chart of the tick-all-that-apply counts; then a line chart of the late-coming register.
4. **An honest chart (4:30-6:00).** A title that says what, who and when;
   axis titles; data labels; a legend only when needed; light gridlines;
   the axis from 0 (start it at 25 and 36 against 27 looks three times as
   big); no 3-D; five slices at most.
   > Screen: change the vertical axis minimum to 25 and back to 0; remove the 3-D effect.
5. **Into the report (6:00-6:50).** Paste (embed) - its own copy; paste as a
   link - it updates with the data, keep the files together. A sentence that
   says what the chart shows.
   > Screen: Copy the chart, Paste Special > Paste link in Word; change a number in Excel and watch the Word chart update.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| records, fields, data types, phone numbers as text, cleaning | `#totable` |
| sorting, filtering, criteria | `#sortfilter` |
| COUNTIF, SUMIF, the summary table, percentages, adding data questions | `#counting` |
| forms, queries, AND / OR / NOT, reports, spreadsheet or database | `#database` |
| patterns, trends, outliers, small groups, going together is not causing | `#patterns` |
| which chart for which data, an honest chart, embed or link | `#charts` |
