# Re-using the IT Theory course for CAT theory

**Asked for:** 27 September 2026 - how much of the IT Theory course can be
modified and re-used for CAT theory, measured against the CAT requirements in
[course-plan.md](course-plan.md), [caps.md](caps.md) and [sags.md](sags.md).

**What was read:** `Dropbox/Projects/AIResources/courses/theory-course.md`
(142 080 bytes, the whole file: Chris's ten decisions, the sources, the
board comparison, the table of built lessons, the lesson-1 content rules, the
chapter outline for all three grades, the question rules and the platform
work). **Nothing in the IT course was changed** - this is a read-only
comparison. The judgements below are about the *content* of each IT lesson as
the plan describes it; the lesson files themselves were not opened, so a
"lift" may still turn up detail that has to go.

> **Overtaken in part, 27 September 2026.** Chris decided that Solution
> Development leaves the CAT theory course and becomes five courses of its
> own - Word, Excel, Access, PowerPoint and HTML - with screenshots,
> simulations and uploaded work ([course-plan.md](course-plan.md) §3.0).
> That answers questions 17 and 18 below and changes the shape of §3's
> table, though not its arithmetic: the 79 lessons with an IT source are
> still exactly the ones that stay in the theory courses, and the 52 with no
> source are the ones that left. Build order is **Grade 10 end to end**, not
> the theory chapters across all three grades.

**The short answer:** **77 of the 106 built IT lessons (73%) hold CAT content
worth taking** - 58 of them almost whole. But they cover only **79 of CAT's
146 lessons (54%)**, because CAT's other half is the application packages,
which IT Theory has nothing on at all. So the saving is real and large on the
theory side, and zero on the practical-theory side.

---

## 1. The two courses side by side

| | IT Theory | CAT Theory (planned) |
|---|---|---|
| Courses | 3, one per grade, each including the ones below | the same |
| Built lessons | **106** (Gr 10: 45, Gr 11: 34, Gr 12: 27) | 146 planned (53 / 47 / 46) |
| Chapters | Basic concepts, Hardware, Software, Information management, Networks and communication, The Internet and the Web, Security, Social implications, Theory for practical work, Exam guides | the same seven up to Social implications, then **Information management** (a different subject - see §4), **Word processing, Spreadsheets, Databases, Presentations, HTML**, Exam guides, The PAT |
| Depth | technical - registers, buses, packets, paging | CAPS: *"deal with hardware and software at a non-technical level"* ([caps.md](caps.md) §2.2) |
| Theory paper | 150: systems 25, communications 25, data 25, solution development 25, short 20, scenario 30 (CAPS) | 150: systems 25, Internet and network 15, information management 10, social 10, solution development 15, short 25, two scenarios 50 (CAPS) |
| Biggest written part | 6-10 marks (algorithms, class diagrams) | **3 marks, and nothing over 2 in 2025** ([caps-exam-analysis.md](caps-exam-analysis.md) §11b) |

Two of these differences drive everything below. The **depth** difference
means an IT lesson is usually right in subject and too deep in treatment: the
work is cutting, not writing. The **mark-size** difference means the
*questions* travel worse than the prose - see §6.

---

## 2. Lesson-by-lesson verdict

Four verdicts:

- **A - lift with light edits.** Same subject, same grade or one grade over.
  Cut the depth CAT does not examine, re-point the examples, keep the prose.
- **B - harvest part.** CAT wants a paragraph or a third of what is there.
- **C - shell only.** The lesson's shape, scenario and question pattern are
  worth copying; the content is new.
- **D - not for CAT.** Nothing in the CAT syllabus asks for it.

| | A | B | C | D | Total |
|---|---|---|---|---|---|
| Grade 10 | 28 | 8 | 2 | 7 | 45 |
| Grade 11 | 14 | 8 | 1 | 11 | 34 |
| Grade 12 | 16 | 3 | 2 | 6 | 27 |
| **Total** | **58 (55%)** | **19 (18%)** | **5 (5%)** | **24 (23%)** | **106** |

### 2.1 Grade 10 (45 lessons)

| IT lesson | Verdict | Goes to (CAT) | Note |
|---|---|---|---|
| 1 `ict` | **A** | Gr 10 Basic concepts 1 and 4 | The closest match in the course. CAPS Gr 10 T1 asks for exactly this - ICT defined, a general ICT model, a point-of-sale and a cellphone example, the information processing cycle, economic reasons. Split into two CAT lessons. |
| 2 `kindsofcomputers` | **A** | Gr 10 Basic concepts 2 | Move supercomputers, mainframes and data centres to Gr 11 (CAPS Gr 11 T1 is where CAT categorises by processing power). Keep convergence - CAPS names it in Gr 10. |
| 3 `hardwaresoftware` | **A** | Gr 10 Hardware 1 / Software 1 | |
| 4 `datainfo` | **A** | Gr 10 Basic concepts 3 | CAT adds knowledge -> conclusion/decision in Gr 12; leave a hook. |
| 5 `insidecase` | **A** | Gr 10 Hardware 1 | |
| 6 `processing` | **B** | Gr 10 Hardware 1 | Take CPU, cores, GPU, RAM, memory-vs-storage. **Drop ALU, CU and registers** - they appear in CAT only as a wrong option in an IEB matching list ([ieb-exam-analysis.md](ieb-exam-analysis.md)). |
| 7 `storage` | **A** | Gr 10 Hardware 7 | **One reversal:** IT demoted CD/DVD/Blu-ray to Good to Know (Chris, 27 Sep 2026). CAT cannot - the IEB SAGs list optical drives under Grade 10 storage and CAPS lists optical media under Gr 10 file types. Restore it as taught content. |
| 8 `inputkeyboards` | **A** | Gr 10 Hardware 2 | |
| 9 `inputother` | **A** | Gr 10 Hardware 3 and 4 | CAT splits it: pointing/scanning/reading (bar code, QR, RFID, magnetic stripe, OCR) and cameras/microphones/biometrics. |
| 10 `output` | **A** | Gr 10 Hardware 5 and 6 | Split monitors/projectors from printers. |
| 11 `ports` | **A** | Gr 10 Hardware 8 | |
| 12 `commsdevices` | **A** | Gr 10 Networks 3 | |
| 13 `hwcare` | **B** | Gr 11 Software 1 | CAT has no maintenance topic in Gr 10; the troubleshooting parts belong in CAPS Gr 11 T2/T3. |
| 14 `systemsoftware` | **B** | Gr 10 Software 2 | Drop APIs and source-vs-executable. Keep the OS's four jobs, interfaces, utilities, drivers. |
| 15 `appsoftware` | **A** | Gr 10 Software 3 | |
| 16 `softwareowning` | **A** | Gr 10 Software 4 | Near-exact: CAPS Gr 10 T2 is proprietary/open source, EULA, site licence, Creative Commons, piracy. |
| 17 `computercare` | **B** | Gr 11 Software 1, Gr 12 Software 2 | Right content, wrong grade for CAT - clean-up, updates, backup, install/uninstall and scheduling sit in CAPS Gr 11 T3 and Gr 12 T3. |
| 18 `storingdata` | **D** | - | |
| 19 `bitsbytes` | **B** | Gr 10 Hardware 7 | **Keep only the multiples** (KB, MB, GB, TB, and PB/EB for the IEB). Drop bit, nibble and the combinations-vs-bits section. |
| 20 `binary` | **D** | - | |
| 21 `hexoctal` | **D** | - | |
| 22 `characters` | **D** | - | |
| 23 `primitives` | **D** | - | |
| 24 `files` | **A** | Gr 10 Managing files 1-4 | **CAT needs more than IT here, not less**: the IEB practical paper has a named 20-mark file-and-folder-management section every year, and the SAGs list Windows Settings screen by screen. One IT lesson becomes four. |
| 25 `databasesintro` | **C** | Gr 11 Databases 1 | IT summarises and links to the SQL course. CAT teaches Access properly - six lessons in Gr 11, four in Gr 12. |
| 26 `whynetworks` | **A** | Gr 10 Networks 1 | |
| 27 `networktypes` | **B** | Gr 10 Networks 2, Gr 11 Networks 1, Gr 12 Networks 1 | CAT spreads this over three grades: PAN/HAN/LAN in Gr 10, WLAN in Gr 11, WAN in Gr 12. Topologies are IEB Gr 11 only. |
| 28 `media` | **B** | Gr 10 Networks 3, Gr 11 Networks 2 | Keep copper, fibre, radio, Wi-Fi, Bluetooth, NFC. Microwave and infrared are IT-only. |
| 29 `email` | **A** | Gr 10 Internet 4, Gr 11 Internet | Managing e-mail (folders, rules, distribution lists) is CAT Gr 11 - split it out. |
| 30 `chatvoip` | **A** | Gr 10 Internet 5, Gr 11 Internet 2 | VoIP and video conferencing are Gr 11 in CAT. |
| 31 `socialmedia` | **A** | Gr 11 Internet, Gr 12 Social | |
| 32 `netiquette` | **A** | Gr 10 Internet 4 | Near-exact - CAPS Gr 10 T3 lists the same rules. |
| 33 `internet` | **A** | Gr 10 Internet 1 | |
| 34 `urls` | **B** | Gr 10 Internet 2 | Keep the URL anatomy and shorteners. **Drop DNS** - not in CAT. IP address is one sentence, IEB Gr 11. |
| 35 `www` | **A** | Gr 10 Internet 2 | |
| 36 `searching` | **A** | Gr 10 Internet 3 | |
| 37 `judgingsites` | **A** | Gr 10 Information management 2 | Strong match both ways - CAPS Gr 10 wants readability, navigation, consistency, layout and typography; the SAGs give the seven website criteria. |
| 38 `webpages` | **C** | Gr 10-12 HTML (8 lessons) | IT treats HTML as Good to Know. **CAT examines hand-written HTML for 20 marks of every practical paper.** The shell is worth having; the content is new. |
| 39 `w3cicann` | **D** | - | Good to Know in IT; absent from CAT. |
| 40 `malware` | **A** | Gr 10 Security 1, Gr 11 Security, Gr 12 Security | A big lesson that feeds three CAT grades. POPIA is already flagged CAPS-only, which is right for CAT too. |
| 41 `society` | **A** | Gr 10 Social 1 | |
| 42 `digitaldivide` | **A** | Gr 10 Social 1 | Flag **I**: the digital divide is named in the IEB SAGs Gr 10; CAPS carries it under "ICT influence on life and lifestyles". |
| 43 `bodyplanet` | **A** | Gr 10 Social 2 | Near-exact. |
| 44 `plagiarism` | **A** | Gr 10 Social 3 | |
| 45 `practicaltheory10` | **D** | - | Algorithms, flowcharts, trace tables, Polya, truth tables, test data. **Harvest two things only:** the IPO table (into Gr 10 Basic concepts 1) and the UI principles (into Gr 12 - CAPS Gr 12 T1 has user-centred design). |

### 2.2 Grade 11 (34 lessons)

| IT lesson | Verdict | Goes to (CAT) | Note |
|---|---|---|---|
| 1 `motherboard11` | **B** | Gr 11 Hardware 1 | CAT wants four sentences: the motherboard houses, the CPU processes, RAM holds during execution, ROM stores start-up instructions. Everything about data flow goes. |
| 2 `busesclock` | **D** | - | IEB-IT only. |
| 3 `caching` | **B** | Gr 12 Hardware 2 | CAPS Gr 12 lists caching and cache size among performance factors - a paragraph, not a lesson. |
| 4 `multitasking` | **A** | Gr 12 Software 1 | Good match to CAPS Gr 12 T3: single vs multiple users, multitasking, Task Manager. Re-grade to 12. |
| 5 `startup` | **B** | Gr 11 Hardware 2 | The SAGs want an "overview and basic concepts of the start-up process (booting)". Keep one paragraph; drop UEFI, CMOS and interrupts. |
| 6 `storagecompared` | **A** | Gr 11 Hardware 4 | |
| 7 `oscompared` | **B** | Gr 10 Software 2 | CAT does this in Gr 10 and lightly - desktop, mobile and embedded, with Windows/macOS/Linux/Android/iOS as examples. |
| 8 `virtualmemory` | **D** | - | |
| 9 `virtualisation` | **D** | - | CAPS-IT only; absent from CAT. |
| 10 `translators` | **D** | - | |
| 11 `fixedbits` | **D** | - | |
| 12 `dataerrors` | **A** | Gr 11 Social 4 | Strong: GIGO, human and computer error, verification vs validation, input methods and checks are CAPS Gr 11 T3 and the SAGs' Gr 11 Data block. Drop parity. |
| 13 `dbms11` | **C** | Gr 11 Databases 1 | As Gr 10 lesson 25. |
| 14 `networkhardware` | **A** | Gr 11 Networks 1 and 2 | |
| 15 `addressing` | **D** | - | Packets and frames are absent from CAT; the IP address is one sentence in Gr 10 lesson 34's replacement. |
| 16 `protocolswan` | **B** | Gr 12 Networks 1 | Keep the WAN half. Protocols by name are not in CAT. |
| 17 `mobilewireless` | **A** | Gr 11 Internet 1 | Hotspots, Bluetooth, NFC, 4G/5G, phone-as-router - CAPS Gr 11 T3 exactly. |
| 18 `vpn` | **A** | Gr 11 Networks, Gr 12 Networks | SAGs Gr 11 names the VPN; CAPS reaches it in Gr 12 under utilities and remote access. |
| 19 `streaming` | **A** | Gr 12 Networks 2 | CAPS Gr 12 T2 wants streaming vs downloading compared; the SAGs put streaming and torrenting in Gr 11. File compression is a separate, practical matter in CAT (Gr 10). |
| 20 `webgrewup` | **B** | Gr 11 Internet, Gr 12 Software 3 | Harvest **cookies** (SAGs Gr 11) and **web-based vs installed applications** (CAPS Gr 12 T1). Drop Web 1.0-4.0, scripting, PHP, XML and AJAX. |
| 21 `expertsearch` | **A** | Gr 11 Information management 2, Gr 12 Internet 2 | |
| 22 `iotbigdata` | **A** | Gr 11 Internet 3 and 4, Gr 11 Social 3 | Strong - CAPS Gr 11 T2 has big data, T3 has IoT and 4IR with VR and AR. Split into the CAT lessons. |
| 23 `threats` | **A** | Gr 11 Security 1 | |
| 24 `protecting` | **B** | Gr 11 Security 3 | Keep anti-malware, MFA/OTP, SSL and https, backups. Drop RAID and TKIP. |
| 25 `compcrime` | **A** | Gr 11 Security 2, Gr 12 Security 1 | |
| 26 `blockchain` | **B** | Gr 12 Social 4 | **Harvest the cryptocurrency part only** - the SAGs name Bitcoin in Gr 10 and the impact of cryptocurrencies in Gr 12. Blockchain itself is not in CAT. |
| 27 `digitalwork` | **A** | Gr 11 Social 1 | One of the best matches in the course: AUP and BYOD (CAPS Gr 11 T2), remote office and office automation (T3), the gig economy (T3, named), careers (Gr 11 T1), drones (SAGs Gr 12). |
| 28 `iotpeople` | **A** | Gr 11 Social 3 | |
| 29 `arraystheory` | **D** | - | |
| 30 `classes11` | **D** | - | |
| 31 `textfiles` | **D** | - | |
| 32 `methods11` | **D** | - | |
| 33 `testing11` | **D** | - | The name is a trap: CAT's "validation" is an Access field property, not program test data. |
| 34 `guidesign` | **A** | Gr 12 Software, Gr 11 Databases 4 | CAPS Gr 12 T1 asks for user-centred design in a website, a database form and a document - re-grade and re-point at those three. |

### 2.3 Grade 12 (27 built of 28 planned)

| IT lesson | Verdict | Goes to (CAT) | Note |
|---|---|---|---|
| 1 `performance` | **A** | Gr 12 Hardware 2 | |
| 2 `choosingcomputer` | **A** | Gr 12 Hardware 1 and 3 | Very strong - CAPS Gr 12 T1 is buying decisions, interpreting adverts and recommending for a home/SOHO/power/mobile user and a user with a disability. |
| 3 `cloudcomputing` | **A** | Gr 11 Hardware 4, Gr 12 Networks 2 | CAT meets cloud storage as SaaS in Gr 11 (CAPS Gr 11 T2) and grid/cloud computing in Gr 12 (T2). |
| 4 `ai12` | **A** | Gr 11 Social 2, Gr 11 IM 2, Gr 12 Social | **CAT needs more of this than IT does.** The 2024 CAPS amendment runs AI as a theme - impact on education (Gr 11 T2), AI as an information source to be judged (Gr 11 T2), ethical use and academic integrity (Gr 11 T3, Gr 12 T2), AI in education again (Gr 12 T1). Flag **C**: the IEB names AI once, in Gr 12. |
| 5 `vrarmr` | **A** | Gr 11 Internet 4 | Re-grade to 11 - CAPS puts VR and AR inside 4IR in Gr 11 T3. |
| 6 `datacollection` | **B** | Gr 12 Information management 1 | Overlaps, but IT's subject is data quality and privacy; CAT's is running a questionnaire and managing volumes of information. |
| 7 `warehousemining` | **D** | - | Big data is in CAT; warehousing and mining are not. |
| 8 `distributed` | **B** | Gr 12 Social 3 | Keep distributed computing power (CAPS Gr 12 T2, SAGs Gr 12). Thin and fat clients are IEB-IT only. |
| 9 `sharingremote` | **A** | Gr 12 Networks 2, Gr 12 Social | File sharing (CAPS Gr 12 T2) and remote access enabling e-commuting and e-learning (T3). |
| 10 `connecthome` | **A** | Gr 12 Networks 3 | Very strong - CAPS Gr 12 T2 is modem/router, connection types, ISP, throttling, shaping, fair use, coverage, mbps, cap and bundle. |
| 11 `seo` | **A** | Gr 12 Internet 2 | Flag **I**: the SAGs name Search Engine Optimization in Gr 12; CAPS does not name it. |
| 13 `deepdark` | **A** | Gr 12 Internet 3 | Already flagged IEB-only in IT, which is right for CAT too (SAGs Gr 12). |
| 14 `encryption` | **A** | Gr 11 Security 3 | Re-grade to 11 - SAGs Gr 11 has encryption, SSL, certificates and signatures; CAPS Gr 11 T4 has SSL and https. |
| 15 `cryptocurrency` | **A** | Gr 12 Social 4 | Flag **I**. |
| 16 `cybercrime12` | **A** | Gr 12 Security 1 | Strong - CAPS Gr 12 T2 lists the thefts, fraud scams, DDoS, bots and zombies. |
| 17 `securityplan` | **A** | Gr 12 Security 3 | CAPS Gr 12 T2 carries a list of "solutions that keep data safe" that reads like this lesson's checklist. |
| 18 `privacylaw` | **B** | Gr 12 Social 2 | **CAT names only POPI** (CAPS Gr 10 T3, extended in T4). The ECT, Sexual Offences and Harassment Acts, and digital heritage, are IT-only. Keep cyberbullying, identity theft and copyright. |
| 19 `bigproblems` | **A** | Gr 12 Social 3 | |
| 20 `socialnetworking` | **A** | Gr 12 Social 1 | Strong. |
| 21 `green12` | **A** | Gr 10 Social 2, Gr 12 Social | CAT starts green computing in Gr 10 and returns to environmental issues in Gr 12 T1. |
| 22 `oop12` | **D** | - | |
| 23 `arrays2d` | **D** | - | |
| 24 `dynamicjson` | **D** | - | |
| 25 `truthtables4` | **D** | - | |
| 26 `efficiency` | **D** | - | |
| 27 `examieb` | **C** | Gr 12 Exam guides 3 and 4 | The shape is worth copying exactly; every fact in it is different. CAT needs four guides, not two, because both boards set a practical paper as well. |
| 28 `examcaps` | **C** | Gr 12 Exam guides 1 and 2 | As above. |

*(Grade 12 lesson 12 is absent from the built-lessons table - the numbering
runs 11, 13. Not a CAT matter, but worth a look.)*

---

## 3. What this covers of CAT, and what it does not

Turning it round: of CAT's 146 planned lessons, how many have an IT lesson
behind them?

| CAT chapter | Gr 10 | Gr 11 | Gr 12 | Total | Source in IT Theory |
|---|---|---|---|---|---|
| Basic concepts | 4 | - | - | 4 | **Yes** |
| Hardware | 8 | 4 | 3 | 15 | **Yes** |
| Software and the operating system | 4 | 3 | 3 | 10 | **Yes** |
| Managing files and devices | 4 | 2 | 2 | 8 | **Partly** - one IT lesson for eight CAT ones |
| Networks | 3 | 4 | 3 | 10 | **Yes** |
| The Internet and the Web | 5 | 5 | 3 | 13 | **Yes** |
| Security and safety | 2 | 3 | 3 | 8 | **Yes** |
| Social implications | 3 | 4 | 4 | 11 | **Yes** |
| **Subtotal with a source** | **33** | **25** | **21** | **79** | |
| Information management | 3 | 3 | 3 | 9 | **Barely** - see §4 |
| Word processing | 7 | 5 | 4 | 16 | **No** |
| Spreadsheets | 5 | 5 | 6 | 16 | **No** |
| Databases | - | 6 | 4 | 10 | **No** (the SQL course is not a substitute) |
| Presentations | 2 | - | - | 2 | **No** |
| HTML and web design | 3 | 3 | 2 | 8 | **No** |
| Exam guides | - | - | 4 | 4 | Shell only |
| The PAT | - | - | 2 | 2 | **No** |
| **Total** | **53** | **47** | **46** | **146** | |

**79 of 146 (54%) have an IT lesson behind them. 52 lessons - the whole
Solution Development half - have nothing**, and they are the ones that carry
the marks: Solution Development is 60% of CAT's teaching time, 20% of the IEB
theory paper and 15 marks plus part of the two scenarios in the CAPS one, on
top of the entire practical paper.

---

## 4. Three traps

**1. "Information management" means different things in the two subjects.**
In IT Theory it is the chapter holding data representation - bits, binary,
hexadecimal, ASCII, primitive types. **None of that is in CAT**: "binary",
"hexadecimal", "ASCII" and "Unicode" appear nowhere in the CAPS document, the
SAGs, or any of the six papers analysed. In CAT, Information Management is
asking good questions, finding and judging sources, processing data and
writing the report - the PAT's theory. The two chapters share a name and
nothing else. Anyone lifting "the Information management chapter" wholesale
would import six lessons of off-syllabus content and still have CAT's nine to
write.

**2. CAT's depth ceiling is low, and CAPS says so.** *"Deal with hardware and
software at a non-technical level"*. Lifting an IT lesson unedited teaches
past the syllabus, which is not harmful in itself - IT already has Good to
Know for that - but in CAT it would swamp the lesson, because the examinable
core underneath is three or four sentences. The edit is a real edit, not a
tidy-up: on lessons like `motherboard11` or `startup`, nine-tenths goes.

**3. "Algorithms" in CAT is not algorithms.** The IEB SAGs do say
"Input, Processing and Output (Algorithms)", and Paper 2 Question 5 asks for
it every year - but what it asks for is the input, the processing and the
output of a named system **in three one-mark boxes**
([ieb-exam-analysis.md](ieb-exam-analysis.md)). No pseudocode, no flowchart,
no trace table. CAPS CAT has no algorithm content at all. IT's whole "Theory
for practical work" chapter (12 lessons across the three grades) is therefore
out, apart from the IPO table and the UI principles.

---

## 5. What travels better than the lessons

Three things in the IT course are worth taking whole, and they are not
content:

- **The eight decisions and the chapter scheme.** Three courses with
  `includes`, one course for both boards with flagged `BoardSection()`s that
  open for one board and fold for the other, a topic taught in different
  grades placed in the earlier grade with a grade note, the same chapter
  names in every grade. [course-plan.md](course-plan.md) §1.4 already
  recommends the same for CAT; the IT course is the proof it works, and the
  platform work is done.
- **The lesson-1 content rules** (26-27 September 2026). Every one of them
  applies to CAT unchanged: South African and current, prices include VAT,
  "power cut" with load shedding as one example, decimals with a full stop,
  KB = 1 000, size examples that start at SA budget devices, a named person
  is the same person across lessons, `bestlessons.co.za` as the example
  address, facts that date go on the yearly list. CAT should adopt them by
  reference rather than restate them.
- **`Scenario()` and `Identify()`.** Both already built. `Identify()` in
  particular is strongest on Grade 10 hardware, which is the part of CAT that
  looks most like IT.

---

## 6. Questions travel worst

The lessons can be lifted; **the question banks mostly cannot**, for one
reason: mark size.

IT's rule is that written parts are 2 or 4 marks, modelled on a paper that
runs 6-10-mark algorithm and class-diagram questions. CAT's papers do not go
there. Across the three CAPS papers analysed, **223 written parts, none worth
more than 3 marks, and nothing over 2 in 2025**; 63% are 2-mark parts, and a
2-mark part nearly always means "give TWO of something". The IEB is the same
shape - 86% of 384 mark slots are worth one mark.

So a lifted 4-mark IT question has to become two 2-mark CAT questions, and
the CAT versions want the house patterns instead: "give TWO", "state ONE
advantage and ONE disadvantage", "difference between X and Y with one box per
side". The cognitive split also differs - CAPS CAT theory is **40/40/20**,
where IT's rules assume 40/40/20 for CAPS and 30/40/30 for the IEB.

Estimate: prose reuse ~55% of the IT course, question reuse well under 20%.

---

## 7. What it saves

Rough, and stated as ranges because it depends on how much of each lifted
lesson survives the depth cut:

| | Lessons | Effort against writing from nothing |
|---|---|---|
| A - lift with light edits | 58 | 25-40% of a new lesson |
| B - harvest part | 19 | 60-75% |
| C - shell only | 5 | 85-95% |
| CAT lessons with no IT source | 67 | 100% |

Against 146 CAT lessons written from nothing, re-using the IT course saves
somewhere near **a quarter to a third of the writing** - concentrated
entirely in Grades 10 and 11 theory, and almost nothing in Grade 12, where
CAT turns to the application packages and the PAT.

The other saving is larger and harder to count: the platform work, the voice,
the board-section machinery, the marking rules and the content rules are all
settled. CAT would start where IT Theory started in late September, not where
it started in the first place.

---

## 8. Questions for Chris

Numbered on from [course-plan.md](course-plan.md) §5, which ends at 14.

15. **Fork or share?** Three ways to do this: (a) **copy** the lifted lessons
    into a separate CAT course and let the two drift apart; (b) **share** the
    common lessons through `includes`, so one lesson serves both subjects and
    a fix lands in both; (c) **share the glossary only**, copy the lessons.
    *Recommendation: (a), copy.* Sharing looks thrifty but the depth ceiling
    fights it - the CAT version of `processing` is not the IT version with a
    section folded away, it is a third of the length. Two of the three
    shared-lesson mechanisms would need a "CAT depth" flag on top of the
    board flags, which is a third axis the platform does not have. The
    glossary is the exception and should be shared.
16. **Does CAT get its own courses, or is it a board section inside IT?**
    *Recommendation: its own three courses.* The overlap is 54% of CAT and
    73% of IT, but a pupil takes one subject or the other, and the two
    diverge on depth in every shared lesson.
17. **Who writes the Solution Development half?** 52 lessons on Word, Excel,
    Access, PowerPoint and HTML, with no existing source anywhere in the
    kit - and, per [course-plan.md](course-plan.md) §2, the part the platform
    fits worst. *Recommendation: settle question 5 (the practical-work
    engine) before any of it is written*, because the answer changes what a
    lesson looks like.
18. **Grade 10 first, or the theory chapters across all three grades first?**
    *Recommendation: the theory chapters across all three grades*, because
    that is exactly the 79 lessons the IT course can feed, and it gets a
    usable CAT course in front of pupils sooner.
19. **Do the IT lessons get re-checked for CAT, or trusted?** The lesson-1
    review found dated and wrong facts in the old textbook. The lifted
    lessons have already had that pass. *Recommendation: trust the facts,
    re-check the examples* - CAT's scenarios are office and admin work, IT's
    lean technical.
20. **Optical storage.** IT put CDs, DVDs and Blu-ray in Good to Know
    (27 September 2026). CAT cannot - both boards still list optical media in
    Grade 10. *Recommendation: restore it as taught content in CAT and leave
    IT as it is*, which is an argument for copying rather than sharing
    (question 15).

---

## 9. What was not checked

- **The lesson files themselves.** This reads the plan's description of each
  lesson, not `content/theory10/*.php`. A lesson may be shorter, longer or
  differently pitched than the table says.
- **The images.** IT's are bought stock from the old site, already sized for
  the platform. Whether they may be re-used in a second course is a licensing
  question for Chris, not one this file can answer.
- **The old textbook itself** (`Projects/LearningOpportunities/`, about
  130 000 words). It is Chris's Grade 10 material and predates the split
  between the two subjects, so parts of it may suit CAT **better** than the
  IT lessons written from it - particularly `cm_`, `dc_` and `si_`. Worth a
  look before any lifted lesson is edited.
- **`theory-yearly-update.md`** (145 723 bytes) and
  **`theory-review-queue.md`** (25 052 bytes). Both would need CAT entries;
  neither was read.
