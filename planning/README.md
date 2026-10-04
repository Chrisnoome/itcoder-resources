# Year planning - which lessons in which week (2027)

Built 27 September 2026 for Chris: "for all grade 10 & up courses look at
general planning for both 3 and 4 term schools ... create a guideline for
which lessons should be completed in which term to meet the syllabus
requirements ... a calendar format and spreadsheet that they can easily upload
to google calendar / ical / outlook". The rules are in
[../platform.md](../platform.md), "Year planner" and "Progress and ticks".

- **Teachers:** https://bestlessons.co.za/planner.php (Teacher options - Year
  planner): any board, grade, language, SQL dialect and calendar, or their own
  dates; downloads .ics, Google CSV and a spreadsheet CSV.
- **Pupils:** My progress in each Grade 10+ course (`progress.php?c=`), from
  their grade and school calendar (asked once on the course page).
- **Ready-made files:** `2027/<calendar>/` - `dbe2027` (public schools, four
  terms), `isasa3` and `isasa4` (ISASA's three- and four-term guidelines);
  CAPS with Pascal, IEB with Pascal and with Java, Grades 10-12; each as
  `.ics`, `-google.csv` and `.csv`. Made by
  `php bin/planner-export.php "D:/DB Sync/Dropbox/Projects/AIResources/planning/2027"`
  - run it again after lessons or their caps.php/sags.php lines change.

## The calendars (`lib/plannercalendars.php`, researched 27 September 2026)

Term dates are from the sources below; **every exam window is typical**
(nothing for 2027 was published) and says so on the page.

| Calendar | Terms 2027 | Source |
|---|---|---|
| Public school (DBE) | 13 Jan-19 Mar, 6 Apr-25 Jun, 20 Jul-22 Sep, 5 Oct-8 Dec; 26 Apr off | Government Gazette 52178, Notice 5902 (25 Feb 2025) - https://www.gov.za/sites/default/files/gcis_document/202502/52178gon5902.pdf (the gov.za summary page disagrees for terms 3-4; the gazette's 197 days add up) |
| ISASA three-term guideline | 13 Jan-9 Apr, 5 May-6 Aug, 7 Sep-3 Dec; half-terms 19-22 Feb, 28 Jun-2 Jul, 22-25 Oct | ISASA Central Region 2027 - https://www.isasa.org/isasa-term-dates/ |
| ISASA four-term guideline | 13 Jan-19 Mar, 13 Apr-25 Jun, 20 Jul-17 Sep, 5 Oct-1 Dec | same |
| St John's College | as the guideline, term 2 from 4 May; off 23-25 Mar | https://www.stjohnscollege.co.za/college/calendar |
| St Stithians College | as the guideline | https://www.stithian.com/uploads/files/Calendars/St-Stithians-College-Calendar-2027_ApprovedNov2025.pdf |
| St Mary's, Waverley | as the guideline, ends 1 Dec | https://www.stmarysschool.co.za/uploads/files/St-Marys-Academic-Calendar-2027.pdf |
| Brescia House | as the guideline | https://www.brescia.co.za/uploads/files/Calendars/2027.Brescia.School.Calendar.pdf |
| St David's Marist Inanda | term 2 from 4 May, ends 30 Nov; off 23-25 Mar | https://www.stdavids.co.za/uploads/files/2026/Updates/FINAL-St-Davids-Marist-Inanda-2027-Calendar.pdf |
| St Andrew's College and DSG | 14 Jan-24 Mar, 21 Apr-4 Aug, 1 Sep-1 Dec | https://www.sacschool.com/2027-term-dates/ |
| Kingswood College | 13 Jan-24 Mar, 20 Apr-4 Aug, 31 Aug-1 Dec | https://kingswoodcollege.com/wp-content/uploads/2026/05/Kingswood-College-Term-Dates-2027.pdf |
| Bishops | 13 Jan-19 Mar, 6 Apr-15 Jun, 13 Jul-17 Sep, 5 Oct-1 Dec | https://bishopsdev.blob.core.windows.net/college-static-files/Documents/X_2027_BishopsTermDates.pdf |
| Herschel | 13 Jan-19 Mar, 6 Apr-24 Jun, 20 Jul-17 Sep, 4 Oct-1 Dec | https://www.herschel.org.za/admissions/term-dates-2027/ |
| Kearsney | 12 Jan-19 Mar, 13 Apr-25 Jun, 20 Jul-24 Sep, 12 Oct-26 Nov; half-terms | https://www.kearsney.com/college/events-and-calendars/ |
| St Anne's | 12 Jan-19 Mar, 12 Apr-25 Jun, 19 Jul-23 Sep, 5 Oct-26 Nov; half-terms | https://stannes.co.za/calendar-and-dates/ |
| Uplands | 13 Jan-19 Mar, 13 Apr-25 Jun, 20 Jul-17 Sep, 5 Oct-1 Dec | https://uplands.co.za/2027-term-dates/ |

**De La Salle Holy Cross College** (`dlshcch`, added 27 September 2026): the
ISASA three-term guideline (Chris: "dlshcch is a standard isasa 3 term
school").

### What is left of 2026 (`PlannerCalendars2026()`, researched 27 September 2026)

For the term countdown and the Monday nudge only, until the 2027 calendars
start. Three-term schools: term 3; four-term schools: terms 3 and 4.

| Calendar | 2026 | Source |
|---|---|---|
| DBE | 21 Jul-23 Sep, 6 Oct-9 Dec | https://www.education.gov.za/portals/0/documents/publications/2025/Published%202026%20School%20Calendar.pdf (Gazette 52177) |
| ISASA three-term | 9 Sep-4 Dec; off 24-25 Sep, half-term 22 Oct (noon)-26 Oct | https://www.isasa.org/download/central-region-calendar-2026/ |
| De La Salle Holy Cross | as ISASA three-term; exams Gr 11 from 31 Oct, Gr 7-10 from 2 Nov | Chris, 27 Sep 2026 |
| ISASA four-term | 21 Jul-23 Sep, 13 Oct-2 Dec | same PDF |
| St John's | 9 Sep-4 Dec; off 24-25 Sep, 22-26 Oct | https://www.stjohnscollege.co.za/college/calendar |
| St Stithians | 7 Sep-4 Dec; off 24-25 Sep, 22 Oct (noon)-26 Oct | https://www.stithian.com/uploads/files/St_Stithians_College_Calendar_2026_-_Approved_March_2025.pdf |
| St Mary's, Waverley | 2 Sep-2 Dec; off 24-25 Sep, 22-26 Oct | https://www.stmarysschool.co.za/uploads/files/St-Marys-Academic-Calendar-2026-version-2-1.pdf |
| Brescia House | 7 Sep-4 Dec; off 24-25 Sep, 22 Oct (early)-26 Oct | https://www.brescia.co.za/uploads/files/Calendars/2026.School.Calendar.pdf |
| St David's Marist | 7 Sep-30 Nov; off 24-25 Sep, 22 Oct (noon)-26 Oct | https://www.stdavids.co.za/uploads/files/2026/UPDATED-FINAL-St-Davids-Marist-Inanda-2026-Calendar.pdf |
| St Andrew's / DSG | 2 Sep-1 Dec; half-term 7-12 Oct (Balloon Weekend 2-6 Oct left as school days - unclear) | https://www.sacschool.com/wp-content/uploads/sites/6/2025/04/SAC-DSG-Prep_2026-Term-Dates_A4.pdf |
| Kingswood | 1 Sep-2 Dec; half-term 12 Oct (14:00)-18 Oct | https://kingswoodcollege.com/wp-content/uploads/2025/07/Kingswood-College-Term-Dates-2026-1.pdf |
| Bishops | 21 Jul-23 Sep, 7 Oct-2 Dec | https://bishopsdev.blob.core.windows.net/college-static-files/Documents/2026TermDates.pdf |
| Herschel (senior) | 21 Jul-18 Sep, 5 Oct-2 Dec | https://www.herschel.org.za/admissions/term-dates-2026/ |
| Kearsney | 21 Jul-18 Sep, 6 Oct-27 Nov; Gr 8-11 exams from 9 Nov | https://www.kearsney.com/college/wp-content/uploads/2026/09/term-4-Calendar-print-version.pdf |
| St Anne's | 21 Jul-23 Sep, 7 Oct-27 Nov; half-term 29 Oct-2 Nov (day girls: the day after the boarders' return) | https://stannes.co.za/wp-content/uploads/2025/11/2026-2027-Term-Dates.pdf |
| Uplands | 21 Jul-23 Sep, 7 Oct-27 Nov | https://uplands.co.za/wp-content/uploads/2025/10/Uplands-Term-Dates-2026.pdf |

Grade 12 finals 2026: NSC and IEB both from 13 October (NSC timetable Feb
2026; IEB Circular 38 of 2026). Grade 10-11 finals where a school gave none:
four weeks before its last day (typical, as the 2027 presets).

Left out (only 2026 dates published): Roedean, St Andrew's School for Girls,
Hilton, Michaelhouse, Reddam House - add them when their 2027 dates appear.
No source gives the share of ISASA schools on three vs four terms; the
three-term schools found are all in Gauteng and Makhanda, the KZN, Western
Cape and Mpumalanga ones checked are on four.

**Public holidays 2027** (gazette): 1 Jan, 22 Mar (Human Rights Day
observed), 26 Mar, 29 Mar, 27 Apr, 16 Jun, 9 Aug, 24 Sep, 16 Dec, 27 Dec.

**Exam windows (typical, `PlannerCalendar()`):**
- Grade 12 finals from 12 October. IEB and NSC finals both began on 13 October
  2026 (IEB IT P1 15 Oct, P2 22 Oct; NSC IT P1 14 Oct, P2 21 Oct). Kingswood
  gives 14 October 2027 as provisional.
- Grade 10-11 finals four weeks before the year's last day.
- Mid-year exams:
  - three-term schools: 7-24 June, before the winter half-term;
  - four-term schools: the last three weeks of term 2;
  - DBE: 1-18 June.
- Grade 12 prelims:
  - DBE: 23 Aug-17 Sep. In 2026 the Western Cape ran 26 Aug-23 Sep and Gauteng 25 Aug-18 Sep.
  - Four-term independent schools: the last four weeks of term 3 (Bishops 24 Aug-18 Sep, Kearsney 10 Aug-7 Sep in 2026).
  - Three-term schools: the last three weeks of term 2 (July-August). This is an inference, not a source: no three-term school publishes trial dates.
- CAPS Grade 12 PAT:
  - Phase 1 a week before the mid-year exams.
  - Phase 2 in the last week of term 3 (DBE 2026 PAT guidelines).
- The IEB IT SAGs sets no PAT dates ("per circulars"). The only fixed IEB date is the request for an alternate language, by 28 February of the matric year.
