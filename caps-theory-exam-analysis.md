# CAPS (DBE) IT theory exam (Paper 2) - analysis for question writing

Built 25 September 2026 from every DBE NSC Information Technology Paper 2
and memo in `CAPS/past papers/` (`NSC_IT_<year>_<session>_P2.pdf`,
`..._P2_Memo.pdf`): **23 papers** - Feb/Mar, May/Jun and Nov 2016-2018,
May/Jun and Nov 2019, Nov 2020, May/Jun and Nov 2021-2025, May/Jun 2026.
All readable (`pdftotext -layout`; pictures checked on rendered pages).
For the theory courses' questions ([courses/theory-course.md](courses/theory-course.md));
official format in [caps-2024.md](caps-2024.md) §4.2 and §4.6; twin of
[ieb-theory-exam-analysis.md](ieb-theory-exam-analysis.md). **Counts:**
Sections B-F hold 1 747 marked parts (3 079 marks), each given one format
from its wording; Section A counted item by item. Close, not exact.

**Old CAPS and the 2024 amendment.** All 23 papers keep the six sections
and their names, 150 marks, 3 hours. To May/Jun 2023 the original weighting
holds (A 15, F 34-41). **Nov 2023** is the first in the amendment's shape
(A 20, F 33); May/Jun 2024 falls back (15/41); **every paper from Nov 2024
follows it**: A 20 = 10 multiple choice + 5 give-the-term + 5 modified
true/false, F 28-33. Matching left Section A after Nov 2023. Question styles
in B-F did not change. caps-2024.md gives no start date for the amendment.

## 1. The paper at a glance

| Papers | A Short | B Systems | C Comms and networks | D Data | E Solution dev. | F Integrated |
|---|---|---|---|---|---|---|
| Feb/Mar 2016 - May/Jun 2023 (17) | 15 (16 once) | 23-27 | 20-30 | 20-27 | 20-29 | 34-41 |
| Nov 2023 | 20 | 25 | 30 | 20 | 22 | 33 |
| May/Jun 2024 | 15 | 25 | 25 | 22 | 22 | 41 |
| Nov 2024 - May/Jun 2026 (4) | 20 | 25-30 | 25-26 | 20-25 | 20-30 | 28-33 |
| CAPS 2024 target | ~20 | ~25 | ~25 | ~25 | ~25 | ~30 |

Five papers (Nov 2019 - May/Jun 2023) are exactly 15-25-30-20-20-40. Two
covers disagree with the totals inside (May/Jun 2017, Nov 2022); the table
uses the inside ones. **One question per section**, written in an answer
book with the paper's numbering. The cover instruction to teach, in every
paper: "The mark allocation generally gives an indication of the number of
facts/reasons required."

**Section A** (1 mark an item; eight 2-mark multiple choice items on code or
test data, 2018-2023):

| Papers | Multiple choice | Give the term | Matching | Modified true/false |
|---|---|---|---|---|
| Feb/Mar 2016 - May/Jun 2019 (10) | 5 (10 once) | 8-10 (5 once) | - | - |
| Nov 2019 - Nov 2023 (8) | 4-5 (none once) | 5 in two papers | 9-10 | - |
| May/Jun 2024 | 10 | 5 | - | - |
| Nov 2024 - May/Jun 2026 (4) | 10 | 5 | - | 5 |

- **Scenarios.** CAPS: no overarching scenario, each question may have its
  own. **Section F always has a boxed scenario** of 20-80 words (an
  exhibition, a restaurant chain, a mall, a marathon, a wildlife lodge, a
  computer shop). B, C and D open with a one- to three-line lead-in in
  17-18 of 23 papers; **E usually has none** (6 papers, none since Nov
  2021). Each numbered stem adds one fact. Four papers in 2016-2017 set one
  scenario for the whole paper; since Nov 2022 most keep a loose theme
  across B, C, D and F (e-waste, a school, a marathon, home security).
- **Section F** mixes systems, Internet, security, emerging technology and
  social issues, a little data, almost no programming - the B-D question
  styles, not a case study; its memos rarely need the scenario (section 3).
- **Code:** pseudocode with arrows until May/Jun 2017; Delphi in nearly
  every paper since Nov 2017 (`:=`, `DIV`, `MOD`, `Ceil`, `copy`,
  `AssignFile`, a StringGrid, class headings).

## 2. Question formats

### 2a. Section A - auto-markable (10-13% of the paper)

| Format | Papers | Items | How it looks and is marked |
|---|---|---|---|
| Multiple choice | 22 | ~140 | Four options A-D, letter only. Stems: a description ending "... is known as", "Which ONE ... NOT", the value of a Delphi expression (`MOD`, `DIV`, `Ceil`) or of a variable after a loop (1-4 per paper in 20 papers), a conversion, an icon, CC/BCC, memory speeds in order. Near-miss distractors (POP3/SMTP/FTP). |
| Give the term | 17 | ~125 | A one-line description; the pupil writes the term. Slash alternatives, acronym or full name (Patch/Hotfix, SEO). |
| Matching columns | 8 (Nov 2019 - Nov 2023) | 79 | 9-10 descriptions against 16-20 lettered terms, a mark per line; an ambiguous line may accept two letters. Twice inside B and C too (4 lines). |
| Modified true/false | 4 (since Nov 2024) | 20 | 1-2 of 5 true; a false one is corrected by replacing the underlined word: "NO marks will be awarded for FALSE without the correct term"; adding "not" is refused. |

Plain true/false or correct/incorrect items sit in D and E of six papers
(2017-2023); Nov 2025 wants a reason with each (2 marks). **Choose TWO
from a list** is in 6 papers; **arrange in order** twice (four mobile
standards, 2 marks: outer pair 1, inner pair 1).

### 2b. Written answers (about 75% of Sections B-F)

| Format | Parts | B-F marks | Size | Wording (paraphrased) and marking |
|---|---|---|---|---|
| Name / state / give / list / identify | 292 | 14% | 1 per item | "State TWO ...", "Name ONE ...", "Which device ...?"; "Any TWO" from a longer memo list; bare nouns score. |
| Define / what is / explain the term | 215 | 10% | 1-2 | "Define X", "Briefly explain what X is". 2 marks = two concepts (what it is + what it does). Expanding the acronym earns nothing. |
| Explain how or why / describe | 180 | 11% | 2 (3-4 for a process) | Memo: a model sentence, then "Concepts:", a tick each; a process (SSL, DDoS, virtual memory) is a step per mark. |
| Advantages / disadvantages / benefits | 151 | 9% | 2 | "State TWO advantages of X (rather than Y)": 105 plain lists, 21 explain, ~20 against an alternative; both in one part only twice. |
| Motivate / justify / give reasons | 178 | 10% | 1-2 | "Motivate why X suits Y", "Give TWO reasons why ...". **Choose and motivate** ~25 parts ("X or Y? Motivate your answer"; "(a) which drive (b) TWO reasons"): choice 1 + reason 1; one memo gives the choice mark only with a correct reason. |
| Suggest / recommend | 123 | 7% | 1-2 | "Suggest TWO ways to ..."; a workable measure per mark. |
| Compare / differentiate | 78 (21 papers) | 5% | 2 | One fact per side. |
| Discuss / critically discuss / evaluate | 20 (12 papers) | 2% | 2-4 | A point + elaboration per 2 marks; a 4 may be define 1 + why it matters 2 + example 1. |

**Fences** ("Apart from / Besides X, give TWO other ...") in 40 parts, 19
papers: the fenced item scores nothing. "Briefly" is common (64 parts, 22
papers). Memos accept a suitable example in place of an explanation where
the question allows.

### 2c. Solution development on paper (about 23% of Sections B-F)

| Format | Papers | Size | How it looks and is marked |
|---|---|---|---|
| Write or complete an algorithm | 17 | 4-10 | Pseudocode (sometimes Delphi) from given first lines: arrays (insert and shift, 2-D totals), strings (reverse, palindrome, star patterns), number puzzles (HCF, Fibonacci), a text file into parallel arrays. A mark per concept (loop and bounds, initialise, condition, assignment, increment, output); any language-neutral form. |
| Trace table | 13 | 4-8 (6 usual) | From pseudocode, Delphi or a flowchart (only 2016 N, 2020 N, 2023 MJ); columns and first row given, "add rows". Per column, or ticks halved (12 = 6). |
| Code reading | 17 | 1-2 | Value or output, loop count, error type of a line (syntax, runtime, logic), data type of an expression, fix a line, the range of `Random(8) + 5`, Reset/Rewrite/Append. |
| Boolean expressions | 5 | 1-4 | Given values; "Show ALL steps"; a mark per step. |
| OOP and class diagrams | 20 | 1-7 | Read a UML diagram (+ and -, which method is an accessor, mutator or auxiliary, find errors, write a method heading (3), why calling a private method fails); draw one from a description (4-7, three papers). One class, never inheritance. |
| Database design | 19 | 1-6 | From a given table: keys, relationship type, a redundant (derived) field, a better data type (text for cellphone numbers), a field holding two values, anomalies. Draw an ERD (3-4) or split a table into two with keys (6), three papers each. |
| SQL | 8 (to May/Jun 2018) | 2-7 | Write SELECT, UPDATE, DELETE, INSERT; say what a statement does or give a GROUP BY query's output (5). Per clause. **Since Nov 2018 SQL is Paper 1 Question 2**; Paper 2 asks only about SQL injection (6 papers) and a keyword in Section A. |
| GUI critique | 11 | 1-4 | A form picture: poorly chosen components, better ones and why; layout; which component forces valid input. Component 1 + reason 1. |
| Number systems and units | 6 | 1-2 | Binary or hex to decimal (as multiple choice or true/false), hex digits, TB to GB, bits in a byte. |

**Never asked:** IPO tables and use case diagrams (both CAPS tools, §4.6),
truth tables, storage or transfer-time calculations, binary arithmetic.

### 2d. Pictures, screenshots and diagrams

Every paper has visual stimulus: spec sheets, most with a product photo (9
papers), GUI forms (11), network diagrams (about 10), screenshots (Task
Manager, settings, a certificate, error messages), data tables, graphs.
**Naming what is pictured is rare** - about 20 marks in 23 papers: "What is
this type of image called?" (a QR code on a ticket, 2024 N, 1, then two
benefits); the device at a label in a network diagram (2017 MJ, 2025 N);
processing techniques or the machine cycle drawn as diagrams (2018 FM, 2019
MJ, 2020 N); the network-drive icon (2017 FM); missing labels in a diagram.
Photos of laptops, a VR headset or wearables are context: the parts ask
what 144 Hz means, which spec is the GPU, what firmware is.

## 3. Sub-question structure and marking

- **Numbering:** Question N -> N.1 (a one- or two-sentence stem, no marks)
  -> N.1.1 -> (a), (b) -> rarely (i); marks in brackets on every part.
  About six N.x stems of ~4 marks per section.
- **Part sizes (B-F):** 1 mark = 42% of parts (24% of marks); **2 marks =
  49% of parts (56% of marks)**; 3-4 marks 7%; 5-10 marks 2% (algorithms,
  traces, SQL, class diagrams, table designs). "TWO" is in 340 parts (23%
  of marks), "ONE" in 133, "THREE" in 12.
- **A block runs** stem fact -> short part (name, define, which; 1) ->
  explain, motivate or advantages (2); about five such pairs per paper.
  Shapes: what is X -> why would this business use it; (a) which option
  (1) -> (b) TWO reasons (2); X or Y? Motivate (1 + 1); name TWO and
  motivate each (4 = 2 x (1 + 1): devices, problems and fixes, threats and
  measures); TWO advantages of X over Y; three terms at 1 each; a 2 x 2
  table to complete (4).
- **Marks per point:** "Any TWO" (380 memo lines, every memo), "Any ONE"
  (294), over longer lists; "accept any other relevant answer" in 14 memos;
  concept lists, a mark per concept (22 memos). No half marks except halved
  trace-table ticks.
- **Rejected** (31 notes in 13 memos): stock words without a mechanism
  ("Do not accept only faster"; "saves space" or "easy to use" without an
  example; cost, cheaper, reliable); the stem's own example; an answer that
  fits any device when this one was asked about; an acronym only expanded
  ("No marks for only expanding the abbreviation"); a neighbouring concept
  (a device for a technology, an example for a definition); extras ("Only
  mark the first answer"; one memo takes a mark off per wrong extra).
- **Accepted:** term or acronym, slash alternatives, any correct pseudocode
  or Delphi (one memo also Java), other field names, an explanation or a
  suitable example.
- **The scenario rarely scores.** Memo lists are generic, even in Section
  F; about five notes demand a link ("a feature of a tablet relating to
  placing orders"). The scenario or given data counts only when the
  question says so ("use the RaceTime field").

## 4. Command verbs

| Verb (first command word) | Parts (papers) | Marks | What the memo wants |
|---|---|---|---|
| Explain, describe (often "briefly") | 314 + 31 (23) | 2 | two concepts: fact + why or how, cause + effect; a process = a step per mark |
| State / give / name / identify | 216 / 134 / 104 / 29 (23) | 1 per item | any N from a list, distinct points; identify = from the given code, table or diagram |
| What / which / why / how (no verb) | 222 / 32 / 37 / 33 | 1-2 | the implied verb; "which" = a name |
| Suggest | 53 (19) | 1-2 | a measure that would work |
| Motivate / justify | 50 (16) | 1-2 | a reason tied to the choice or case |
| Define | 45 (16) | 1-2 | what it is + what it does |
| Discuss / critically / evaluate / analyse | 46 (15) | 2-4 | a point + elaboration per 2 marks; a judgement with its reason |
| Differentiate / distinguish / compare | 28 (18) | 2 | one fact per side |
| Write / complete / redraw / copy / rewrite | 53 (23) | 1-10 | code, pseudocode, SQL, traces: a concept or column per mark |
| Expand / indicate / draw / design / arrange | 19 (13) | 1-4 | exact answer or a checklist |

## 5. Topics that recur

Papers (of 23) whose questions name the topic.

| CAPS topic | In nearly every paper | Often (10-17) | Rare (2-9) |
|---|---|---|---|
| Systems | SSD vs HDD, flash (22); mobile devices and their limits (20) | cache 16, virtual memory 12, motherboard, slots, ports 17, cloud 17, SaaS 13, virtualisation 11, open source and licences 16, updates and firmware 17, GPU 14, cores 12, multitasking/-processing/-threading 10, utilities 12 | BIOS 9, drivers 9, buses and clock 8, compilers 6, CMOS 4, RAID 4, UPS 3 |
| Communications and networks | named protocols (23); malware (19); NIC, switch, router, access point (18); remote work and remote desktop (18) | e-mail 17, Wi-Fi 16, streaming 15, encryption and SSL 15, firewall 14, network types 14, search and SEO 14, RFID 14, BitTorrent 13, DDoS and botnets 13, apps 13, web languages 12, static vs dynamic 11, VPN 11, VoIP 11, GPS 11, topology 10 | phishing and spoofing 9, bandwidth 9, IP address 8, cookies 7, Web 2.0/3.0 7, hotspots 6, biometrics 6, MFA 3, NFC 2 |
| Data and information management | relationships and ERDs (19) | primary key 16, DBMS 15, transactions and rollback 14, distributed databases 13, integrity 13, validation vs verification 13, warehouse, mining, big data 12, foreign key 10, anomalies 10 | normalisation 9, redundancy 9, database careers 8, audit trails 7, record locking 7, SQL injection 6, invisible data capture 5 |
| Solution development | loops (22), DIV/MOD and maths functions (21), algorithms (20), data types (20), Boolean expressions (20) | arrays 17, private/public 17, procedures and parameters 17, accessors and mutators 14, error types 14, trace tables 13, class diagrams 13, text files 13, GUI components 11 | 2-D arrays 6, sorting 5, searching (binary needs sorted data) 4, flowcharts 4, defensive programming 2 |
| Social, ethical, emerging | - | 4IR and automation 14, social media 14, careers and freelancing 10 | privacy and ethics 9, VR/AR 9, AI and expert systems 8, IoT 8, fake news and information overload 8, copyright and piracy 8, e-waste and green computing 7, health 7, AUP 7, drones 5, blockchain 4, digital divide 3 |

**In every paper:** storage, named protocols, security threats and their
counters, network hardware, database design from a given table, programming
basics, and a scenario section mixing them. Social implications never get
a section (as CAPS says); they come inside the scenario questions.

## 6. Exam technique to teach (from the memos)

- **Marks = points.** Two marks, two different facts; "State TWO" means
  two - extras are ignored, and one memo took marks off for wrong extras.
- **Say how or why, not "faster", "cheaper", "easier"** - give the
  mechanism or the comparison ("cache is on the CPU, so fewer trips to
  RAM"). **A definition has two parts** (what it is, what it does); never
  just expand the acronym or reword the question.
- **Obey the fence** - after "apart from X", X scores nothing; don't repeat
  the stem's example. **Never leave a choice bare** - "X or Y?" wants the
  choice and an agreeing reason. **Differentiate** = a fact about each side.
- **Use the given material when asked** (a table's field, the spec sheet's
  figure); otherwise the standard answer scores.
- **Modified true/false:** write the replacement word; "false" alone scores
  nothing.
- **Traces:** a row per change, keep going (columns marked separately).
  **Algorithms:** initialise, loop with the right bounds, condition,
  assignment, output - half-right earns most marks. **Boolean expressions:**
  show every step. **Class diagrams:** - private, + public, typed fields,
  constructor parameters, get/set.
- **Time:** 1.2 minutes a mark; a 2-mark part is two sentences.

## 7. Implications for the course's question types

Section A and the single-term parts of B-F (about 160 "what is it called /
which device" parts) make **about 16% of the paper auto-markable**, twice
the IEB's share; about 75% is short written answers, mostly 2 marks; the
rest is algorithms, traces and designs, practised in the Pascal, Java and
SQL courses. **Even marks (platform.md decision 8):** a 1-mark recall part
becomes auto-marked (the engine doubles it to 2); 2-mark parts stay 2; a
3-mark part becomes 4 (weight the hardest concept 2 and say why) or splits
2 + 2; "name TWO and motivate each" stays 4.

### (a) "multipart" - a scenario and numbered parts

- **Stem:** a boxed scenario of 25-80 words naming a South African
  organisation (a school, a shop, a lodge, an event), plus at most one
  stimulus: a spec list, a small data table, a labelled diagram or a
  screenshot. A part may add one fact in a lead-in line, as the papers do.
- **Parts:** 3-6, numbered N.1, N.1.1, (a), each with its marks, 8-16 in
  all. Recall first (a term, name ONE, define), then 2-mark written parts:
  why this organisation would use X, TWO advantages of X over Y, X or Y -
  motivate, a fenced "apart from ..." list; a 4-mark "name TWO and motivate
  each" where it fits. About 40% recall, 40% explain and apply, 20% judge
  (CAPS §4.2). Auto-marked parts inside: a term (`typed`), which option
  (`quiz`), TWO from a list (`select`).
- **Marking per part** (per-concept `markerRubric`): a mark per valid,
  distinct point; "any N" lists longer than N; concept lists for
  explanations; section 3's reject list; a scenario mark only where the
  part asks for it; points beyond N ignored; no half marks.

### (b) "identify" - a picture, then name, use, pros and cons

- **Evidence:** CAPS names a pictured thing about ten times in 23 papers
  and uses device photos as context, so "identify" is the course's own
  recall type (strongest in Grade 10 hardware) with CAPS-style follow-ups.
- **Spec:** one image - a photo of a component, device, port or connector,
  a labelled diagram, or a screenshot. Parts: (1) What is it? - `typed`,
  alternatives listed (1 -> 2). (2) What is it used for? - written 2: what
  it does + where or why, not the name expanded. (3) As asked - written, 2
  each: TWO advantages over a named alternative, ONE disadvantage, what a
  spec figure means, or "would it suit [one-line case]? Motivate" (1 + 1).
  Total 4-8.
- **Variants from the papers:** the device at each label of a network
  diagram (`typed` per label, or `match`); name a diagrammed process, then
  explain it; a spec sheet (read a value - `typed` or `select`; explain a
  figure - written 2); a screenshot (which setting saves power - `select`;
  what caused this error - written 2).

### (c) Platform types for each exam format

| Exam format | Platform type |
|---|---|
| Multiple choice, including a Delphi value or a loop count | `quiz` |
| Give the term; conversions | `typed` (term and acronym both listed) |
| Matching columns | `match` - more options than rows, near-miss distractors; per line like the exam |
| Modified true/false | `typed`: "type TRUE, or the word that should replace the underlined one" |
| Choose TWO from a list | `select` |
| Arrange in order (speeds, standards, steps) | `order` |
| Name / state / give TWO, define, explain, motivate, differentiate, suggest, discuss | `written` (even `markMax`, per-concept rubric) or a `multipart` part |
| A short Delphi line (a method heading) | `checkedcode` or `typed` |
| Trace tables, tables to complete | `gridtyped` |
| Algorithms, class diagrams, ERDs, table designs | `written` with a checklist rubric; practice in the Pascal, Java and SQL courses ("Theory for practical work") |
| A section's scenario questions | `multipart` |
| A picture, labelled diagram or screenshot to name and explain | `identify` |
