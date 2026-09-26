# IEB IT theory exam - analysis for question writing

Built 25 September 2026 from every IEB theory paper, memo and analysis grid
in `IEB/theory papers/`: November 2009-2020 (a folder per year) and the
2019 supplementary and May 2021 papers (`Supplementary/`) - **14 papers**,
read in full, pictures included. Nothing later is in the folder. For the
theory courses' questions ([courses/theory-course.md](courses/theory-course.md));
the syllabus source of truth stays [sags-2025.md](sags-2025.md).

**Which paper is theory:** up to May 2021 it was **Paper I** (3 hours, **180
marks**); every file here is that paper. **Since November 2021 it is Paper 2**
(3 hours, **150 marks**: systems 40, Internet and communication 45, social 15,
data and solution development 50; levels 30/40/30). The old grids' strand
targets were 45/55/20/60 of 180 - the same proportions within a percentage
point, so the balance below carries over. No 150-mark paper is in the
folder, so today's Section A size is unknown here.

**Counts:** every numbered part that carries marks (1 164 parts, 2 520 marks)
was given one format; a mixed part counts once, under its main format.
Treat the numbers as close, not exact.

## 1. The paper at a glance

| Years | Layout | Opening (Level 1) | Scenario |
|---|---|---|---|
| 2009-2013 | 7 questions, no sections: terminology, hardware and software, networks, Internet, social, then databases and programming last (20-38) | 20-33 marks: 10 terms x 2 "define / briefly describe"; 2011 adds 13 give-the-term, 2012 10 matching | one box before Q1, whole paper |
| 2014-2016 | **Sections A-E**: A Short questions 20, B Systems, C Internet and communication, D Social, E Data and solution development | Q1 10 multiple choice + Q2 10 give-the-term (2014) or 10 matching (2015-16) | box at the start of Section B (2015: B and C only) |
| 2017-May 2021 | Sections A-E, **answered in the booklet** (26-36 pages): ruled lines, labelled slots ("Reason 1:"), answer tables, class-diagram frames; an appendix or insert with a network diagram or pseudocode (2018-2021) | Q1 5 x 2-mark definitions (2017, 2018, supp 2019, 2021) or 10 x 1 give-the-term (2019, 2020); Q2 10 matching | box at the start of Section B, for the rest of the paper unless a question is general; 2021: B-C only, Section E its own |

Section marks from 2014 (Section A is always 20):

| | 2014 | 2015 | 2016 | 2017 | 2018 | S2019 | 2019 | 2020 | M2021 |
|---|---|---|---|---|---|---|---|---|---|
| B Systems | 46 | 48 | 30 | 38 | 32 | 38 | 40 | 45 | 33 |
| C Internet | 40 | 37 | 51 | 51 | 56 | 53 | 48 | 42 | 55 |
| D Social | 17 | 19 | 18 | 17 | 15 | 17 | 16 | 15 | 19 |
| E Data | 57 | 56 | 61 | 54 | 57 | 52 | 56 | 58 | 53 |

Questions in Sections B-E run 11-56 marks. 2019 (Section C) and 2020
(Sections B and C) split a section into a **"Theory"** question - knowledge
usable without the story; 2020's Section B one is 10 multiple choice - and
an **"Application"** question: decisions and justifications that only make
sense inside the scenario, heavier in Level 3.

**Every paper has a scenario.** A boxed paragraph or two sets up a South
African business or project with a small cast: a non-profit matching casual
labourers with jobs (2009), a children's social network (2010), a bed and
breakfast run by two non-technical owners (2017), a village library (2018),
mobile clinics (2019), a pizza chain's delivery agents (2020), a gaming club
(2021). **Each question then opens with a lead-in paragraph** adding a
stimulus: a **spec sheet or advert** (12 of 14 papers - laptops, tablets, a
server, motherboards, upgrade lists, "option a, b or c"); a **network
diagram** (6); a **table of sample data** for the database questions (all
14) and a field list for OOP; a **news article extract** for social
implications (7 papers since 2011), coming back to the scenario at the end.
Characters recur and are addressed ("explain to Bob ..." six times in 2021).
The scenario was decoration in 2011-2013 (generic memo answers); **from 2014
the memos give marks for linking to it** (section 3).

## 2. Question formats

Marks are out of 2 520; "Papers" = how many of the 14 use the format.

### 2a. Recall - auto-markable (8% of marks; Section A is 11%)

| Format | Papers | Marks | Each | How it looks and is marked |
|---|---|---|---|---|
| Give the term | 14 (a block of 10-13 in 2011, 2014, 2019, 2020) | 71 | 1 | A one-line description; the pupil writes the term. Slash alternatives accepted (botnet/zombie army); product names sometimes. |
| Matching columns | 9 (Section A 2012, 2015-2021) | 93 | 1 per line | 10 terms against 13-22 descriptions; letter only. Near-miss distractors: compiler/interpreter, BIOS/CMOS, AUP/EULA, repeater/bridge, a fake acronym expansion. |
| Multiple choice | 4 as a 10-item block (2014-2016, 2020) + 3 odd items | 46 | 1 | Four options; bold negative stems (NOT, FALSE, least); "all of the above" occurs. 2017: "choose a, b or c" per spec factor, marked with its justification. |
| True/false | 3 | 4 | 1 | Rare. |

### 2b. Written answers (71% of marks)

| Format | Papers | Marks | Part | Wording (paraphrased) and marking |
|---|---|---|---|---|
| Define / what is / briefly describe | 14 | 386 (15%) | 2 (1 in a scenario) | "Supply a concise definition". **Two elements**: what it is + what it does or its distinguishing feature. Expanding the acronym earns nothing (said in 6 papers). |
| Name / give / list / state | 14 | 309 (12%) | 1 per item, usually TWO or THREE | Any N from a longer memo list; bare nouns do; points must be distinct. Brand names only when an example is asked for. |
| Explain / describe how or why | 14 | 341 (14%) | 2 (3-6 for a process) | Cause + effect, or a fact + its application. A process (CSMA/CD, SSL, virtual memory, plug and play) is a mark per step, sometimes in sequence. |
| Reason / justify a stance | 14 | 271 (11%) | 2-4 | "Do you believe ...? Justify." Stance 0-1, then a mark per reason. **A bare yes/no scores 0**; the reason must match the stance. Either side usually scores; a few memos fix the answer (a factually wrong stance gets nothing). |
| Apply to the scenario | 14 | 137 (5%) | 2-6 | "Using the scenario, suggest / give an example." The mark needs a scenario fact. |
| Advantages / disadvantages | 14 | 149 (6%) | 2-4 | **Not opposites**; "faster" or "cheaper" alone rejected. |
| Compare / distinguish | 13 | 104 (4%) | 2-4 | "Explain the difference", or a table with a factor for each side. One fact per side; a table cell is 1 mark. |
| Recommend / choose + justify | 12 | 99 (4%) | 2-5 | Choice (often 1) + a mark per reason from the spec or scenario; an unusual choice scores if justified; "because it is the fastest" does not. |
| Discuss / evaluate | few | (above) | 4 | Both sides, or marked in levels (2011, 2014): a bare statement earns 1 of 4. |

### 2c. Solution development on paper (18% of marks)

| Format | Papers | Marks | Size | How it looks and is marked |
|---|---|---|---|---|
| Keys, anomalies, normalisation | 14 | 140 | 2-10 | Keys and anomalies **from the given table**; 2NF/3NF relations, primary keys underlined. Marked per table, fields, PK and FK. |
| Class diagram | 13 (9-10 marks every paper 2016-2021) | 100 | 2-11 | Complete a frame from a field list. Checklist: name, private typed fields, public methods, constructor with parameters, accessors, mutators, toString. Older papers: draw an inheritance hierarchy from attribute lists. |
| Algorithm | 11 (not 2009, 2010, 2012) | 104 | 6-12 | Write, complete or correct pseudocode; 2019: order lettered strips, distractors included (10). Marked per element: initialise, loop, condition, assignment, output or return. **Pseudocode, not Java/Delphi** (2 marks off in 2014, 2017, supp 2019); any correct method. |
| SQL on paper | 9 | 56 | 2-8 | Mostly reading: what a query does, its result table, WHERE vs HAVING, a faulty UPDATE; short queries written in 2009, 2012, 2014, 2018. Per clause. |
| Trace table | 4 (2015, 2018-2020) | 29 | 8-10 | First rows filled in; marked by column or pattern, **with follow-through**. |
| Code reading | 6 | 26 | 1-3 | The line with the error, a fix, typed or void, what a method does. 2016 asked for real Java or Delphi code. |

### 2d. Pictures, diagrams and calculations (2% of marks)

- **No paper asks "what is this component?" from a photo.** Device photos
  sit beside spec sheets (2013, 2016, supp 2019, 2020) as context. With a
  picture pupils: name the device at a letter in a network diagram
  (2019, 1); spot a mislabelled device and say why (a "modem" that is a
  router, 2014; a hub that should be a switch, 2020); label a north/south
  bridge diagram (2012, 5 x 1); redraw a wrong one (2010, 4); pick the best
  technology per lettered link (2010, 8, a mark per cell); explain a
  screenshot (four CPUs in Task Manager, 2012; SafeSearch, 2020); judge
  which of two web pages is reliable (2009, 5). About 40 marks in 14 papers.
- **Drawing:** a topology sketch (2009 - unlabelled scores 0). **Calculations
  are nearly absent:** MB to GB (2011), 2^64 and bytes to bits (2017), a RAID
  drive count (supp 2019), screen PPI from a given formula (2020) - 12 marks
  in all, and **no binary or hex conversion, storage-size or transfer-time
  problem**, though every cover says "show all working".

## 3. Sub-question structure and marking

- **Numbering:** Question N [total] -> N.1 -> N.1.1 -> (a), (b); marks in
  brackets on every part. Parts average 2.2 marks; apart from Section A's
  1-mark items **2 marks is the commonest size**. Parts over 4 marks are
  almost only tables, algorithms, class diagrams, normalisation and traces.
- **A block runs:** lead-in fact -> short recall (what is X, name one; 1-2)
  -> explain or justify using the scenario (2-3). Recurring pairs:
  - what is X (1-2) -> why does this business need it / how would it help here (2);
  - yes/no or which (1) -> justify (1-2);
  - list TWO causes (2) -> explain the effect of each on the scenario (2);
  - choose an option per factor (1 each) -> justify each (1 each), marked together;
  - name and explain TWO (4 = 2 x (1 + 1));
  - tables: Yes/No + explanation per row (12 marks in 2021), feature +
    explanation, a 2 x 2 advantage/disadvantage grid.
- **Linked parts** are marked on consistency with the pupil's earlier answer.
- **Marks per point:** one per valid, distinct point; the mark is the number
  of points (papers say "ONE fact per mark"; 2018-2020 booklets label each
  slot). "Any N" lists are longer than N; "accept other correct answers" is
  common. **No half marks in any memo.**
- **What memos reject** (the same list since 2013):
  - an acronym expanded, or the question reworded, as a definition;
  - stock words with no mechanism: faster, cheaper, easy to use,
    convenient, less bulky, more powerful, "a lot of devices";
  - an advantage and its mirror-image disadvantage;
  - a bare yes/no or choice, or a reason that contradicts it (2018: "If no
    justification, NO MARKS for decision");
  - an answer to a neighbouring question: backup as ransomware
    *prevention*, the e-book reader for the e-book, reasons already given
    in the article or the example row;
  - a brand where the concept is asked (Gmail, "Google", BitTorrent for P2P
    sharing), or a near term (hub for switch, "certificate" for digital
    certificate);
  - general uses where the scenario's own case was asked about.
- **Second-mark keywords:** a 2-mark definition often needs one named idea
  (a helper method is *private*; RAID guards against *hardware failure*).
- **Opinion items:** 3 = stance + two reasons; 4 = two arguments + two
  justifications, or levels.
- **Memos:** per-point ticks are visible only in 2020; several memos have
  slips (a wrong RAID level, a class diagram that contradicts its question).

## 4. Command verbs

| Verb | Use | What the memo wanted |
|---|---|---|
| **Explain** (why, how, the difference, "explain to [character]") | the commonest verb in every paper | 2 = cause + consequence, or a fact + its application; a process = a step per mark |
| **Define**, what is (meant by), supply a concise definition, briefly describe | Section A; the first part of most blocks | 2 = category + distinguishing function; 1 = one key fact |
| **Give, name, list, state, provide, identify** | parts of 1-3 marks | 1 per item, any N, distinct |
| **Justify** (dominant from 2017), **motivate** (to 2016), substantiate | after a stance or choice | a reason per mark, matching the stance and using the scenario |
| **Suggest, recommend, advise, choose**, which would you | spec and scenario decisions | choice + reasons; the choice alone earns little or nothing |
| **Compare, distinguish, differentiate**, how does X differ | pairs of technologies | both sides, one fact each; not opposites |
| **Discuss, critically discuss, evaluate** | social and ethical items; rare after 2016 | both sides, justified; levels |
| **Complete, draw, write, normalise, arrange** | tables, diagrams, relations, algorithms | criterion checklists |
| No verb: what / which / why / how / would / do you believe | very common | as the implied verb |

"Briefly" disappears after 2015. The 2014 grid's taxonomy counts **explain
and describe as Level 1**; Level 3 is recommending in a scenario that needs
in-depth thinking, judging against criteria, an opinion substantiated with
facts, and improving an algorithm.

## 5. Topics that recur

| Strand | In (nearly) every paper | Often |
|---|---|---|
| Systems | CPU performance (cores, cache, clock, hyperthreading, clock multiplier, overclocking) 13/14; choosing a computer from a spec sheet 12/14; cloud, SaaS, virtualisation 13/14 | RAM/ROM/cache/virtual memory; SSD vs HDD; chipset, buses, north/south bridge; OS functions, interrupts, drivers, plug and play; open source vs proprietary; backup, RAID, UPS; mobile devices and battery life |
| Internet and communication | network devices (switch vs hub, router, modem, access point, firewall, proxy) and media/topology (UTP, fibre, wireless, star) 14/14 | TCP/IP, UDP, HTTP(S), IP vs MAC, IPv4/6; SSL, encryption, keys, digital certificates; VPN and remote access; Web 2.0, wikis, blogs, static vs dynamic, scripting, cookies, SEO; P2P and BitTorrent; judging a website; GPS and location-based services |
| Social | malware, cybercrime and protection (phishing, spyware, Trojans, ransomware, DDoS, botnets, social engineering, identity theft) 14/14 | privacy and personal data; copyright, fair use, plagiarism; AUP; e-waste and green computing (2009-2014); social media, cyberbullying, misinformation; RSI; information overload |
| Data and solution development | keys, anomalies, dependencies, normalisation 14/14; OOP theory (encapsulation, access modifiers, constructors, accessors, mutators, overloading, inheritance, polymorphism) 14/14; class diagram 13/14; algorithm 11/14 | SQL read and explained 9/14; validation, integrity, audit trails; sorting and searching (bubble sort with a flag, linear search, find the largest); trace tables (since 2015) |

**Levels (grids):** 2009-2013 used four Bloom-style levels (2009 was 54%
recall); from 2014 three levels at 30/40/30, met within two marks in
2017-2021. Section A is all Level 1. **Level 3 sits mostly in Section E** (a
third to three quarters of its marks) and in justify and recommend parts;
where a part is split, naming is Level 1-2 and the justification Level 3.
Section D is 15-19 marks, but the grids count social items elsewhere too
(the strand totals 16-24).

## 6. Exam technique to teach (from the memos and grids)

- **Marks = points.** Two marks, two distinct facts; a different idea in
  every labelled slot. **No opposites** ("cheap" and "not expensive" are one).
- **Definitions have two parts** - what it is, what it does. Never just
  expand the acronym or reword the question. Use the exact term (switch,
  digital certificate, private, composite key).
- **Say how, not just "faster"** - give the mechanism ("more cache, so fewer
  trips to RAM").
- **Never leave a yes/no or a choice bare**; make the reason agree with it.
  Either side usually scores.
- **Read the stimulus first and use the scenario's facts** (load shedding,
  300 m between buildings, three guest rooms) whenever the question points
  to the scenario, spec sheet or diagram - a generic answer loses that mark.
- **Obey the fences in the stem** ("besides ...", "not the reasons in the
  article", "do not repeat (b)") and answer the thing asked: prevention is
  not recovery.
- **Brand names only when an example is asked for.**
- **Algorithms in pseudocode**, with the question's names: initialise, loop,
  condition, output or return - half-right earns most of the marks. **Trace
  tables**: keep going; later columns follow through.
- **Class diagrams**: -/+ visibility, typed fields, constructor parameters,
  accessors, mutators, toString. **Relations**: every field kept, primary
  keys underlined, foreign keys marked. **Label every diagram.**
- **Multiple choice and matching**: watch bold NOT/FALSE/least. **Time:**
  the old paper was a mark a minute; 150 marks in 3 hours allow about 70
  seconds a mark.

## 7. Implications for the course's question types

About 90% of the marks need a written answer, table or diagram; recall a
machine can mark is 8%. So the theory courses need many written, mostly
scenario-based questions, with auto-marked types for terms.

### (a) "multipart" - a scenario and numbered parts

- **Stem:** a boxed scenario of 60-150 words - a South African business or
  project, one to three named people - plus, where it helps, one stimulus
  written for the course: a spec list, a lettered network diagram, a small
  data table or a short article summary. It holds for every part; a part
  may add one fact in a lead-in line, as the papers do.
- **Parts:** 3-6, numbered N.1, N.1.1 ..., each with its own marks, 8-16 in
  all. Open with short recall, then at least one part that only makes sense
  inside the scenario: why this business needs X, choose-and-justify,
  stance-and-justify, or an advantage and disadvantage (not opposites). Mix
  the levels like the paper (about a third recall).
- **Answer frame:** labelled slots ("Reason 1:") as in the 2018-2020
  booklets - it teaches that marks equal points.
- **Marking per part** (per-idea rubric in `markerRubric`): a mark per
  valid, distinct point; an "any N of" list longer than N; the keyword for a
  definition's second mark; section 3's reject list (acronym only, stock
  words, opposites, a bare yes/no, a brand for a concept); a mark that
  needs a scenario fact where the stem asks for one; follow-through from
  the pupil's earlier choice; no half marks.
- **Even marks (platform.md decision 8):** exam parts are often 1 or 3.
  Build written parts as **2 or 4**, the commonest constructed-answer
  sizes: name + reason (2), stance + one reason (2), choice + two reasons at
  2 each (4 - the bare choice earns nothing, as in the memos; the rubric
  says why). A 1-mark recall part (a term, one choice) becomes an
  auto-marked part, which the engine doubles; a 3-row table becomes 6.
- **Auto-marked parts inside:** the papers put them in scenario questions
  (classify each use as SaaS, PaaS or IaaS; pick option a, b or c), so a
  multipart should allow typed, quiz and select parts.

### (b) "identify" - a picture, then name, use, pros and cons

- **Evidence:** the IEB never asks for a component's name from a photo, so
  this is the course's own recall type, strongest in Grade 10 hardware. Its
  later parts follow the IEB's patterns: name, explain, then advantage and
  disadvantage or a scenario judgement.
- **Spec:** one image - a photo of a component, device or connector, a
  lettered diagram, or a screenshot. Parts:
  1. What is it? - typed, with alternatives (auto-marked, 1 -> 2).
  2. What is it used for? - written, 2: what it does + where or why (not
     the name expanded).
  3. As asked - written, 2 each: one advantage and one disadvantage (not
     opposites); how it differs from a named alternative; or "would it suit
     [one-line scenario]? Justify". Total 4-6.
- **Variants from the papers:** name the device at letter B (typed, or match
  per letter); "the device labelled X is wrong - what should it be, and
  why?" (name 2 auto-marked, reason 2); label a block diagram (match, a line
  per label); a technology per lettered link (gridtyped or match). Images:
  the old site's bought stock (theory-course.md decision 8).

### (c) Platform types for each exam format

| Exam format | Platform type |
|---|---|
| Give the term | `typed` (alternatives listed; case-folded) |
| Matching columns | `match` - more options than rows, near-miss distractors; scored per line like the exam |
| Multiple choice, including NOT/least stems | `quiz` |
| Name TWO/THREE from a closed set; "which of these does a firewall stop?"; tick tables | `select` |
| Steps in order (machine cycle, SSL, plug and play, development cycle, a priority ranking); the strips algorithm | `order` - the 2019 strips had unused distractors; check `order` can hold spares |
| Definitions, explain, justify, compare, recommend, discuss | `written` (even `markMax`, per-idea rubric; bands from 10 marks) or a `multipart` part |
| Trace tables, data-type tables, per-cell comparison tables | `gridtyped` |
| Relations in 3NF, algorithms, class diagrams | `written` with a checklist rubric; the practice itself is in the SQL, Pascal and Java courses ("Theory for practical work") |
| Scenario questions (Sections B-E) | `multipart` |
| Pictures, diagrams, screenshots | `identify` |
| The rare calculations | `typed` |
