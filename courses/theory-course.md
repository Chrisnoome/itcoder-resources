# Course: IT Theory (`theory10`, `theory11`, `theory12`) - PLAN

**Status: structure decided by Chris (25 September 2026); nothing built
yet.** Placeholder today: `ittheory` in `CourseIndex()` (status `soon`, no
pupil data under it) - replaced by the three courses below. Lesson prose
follows [../writing-style.md](../writing-style.md) and
[../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md) like
every course (README, "One look for every course").

## Chris's decisions (25 September 2026)

1. **Three courses, one per grade**: IT Theory Grade 10, 11 and 12.
   **A course includes the grades below it**: joining Grade 12 gives Grades
   10 and 11 too; joining Grade 11 gives Grade 10. Higher grades **link
   back** to earlier grades' lessons instead of repeating them.
2. **Chapters by topic, not by term** - Hardware, Software, Networks and so
   on, subdivided into lessons, related content kept together. The CAPS
   term plan does not decide the order.
3. **Lesson size follows the content, like a textbook** - not a period.
4. **One course for both boards. Everyone is taught everything.** Content
   for one board only sits in a **flagged, collapsible section** in the
   lesson ("IEB only" / "CAPS only"). It starts **open for that board's
   pupils and folded for the other board's**; its questions **count for
   that board and are optional for the other** (left out of their totals).
   Pupils on `both` or `none`, and staff, see every section open. This is
   an exception to platform.md decision 28, which must say so when built.
5. **Database theory lives in the SQL course** ([sql-course.md](sql-course.md)):
   DBMS, keys, relationships, ERDs, normalisation, warehousing, mining, big
   data, NoSQL. The theory courses give a short summary and link there.
6. **One chapter per course, "Theory for practical work"**, notes and
   discusses the programming concepts the theory papers ask about (trace
   tables, flowcharts, OOP theory...), linking to the Pascal and Java
   courses.
7. **Chris's old textbook is the source for Grade 10** (see "Sources").
   **Cover all of it; where the original has more detail than the syllabus,
   keep the detail** - better understanding is the aim. Material outside
   today's syllabus stays as **Good to Know** (plum, not examined); dated
   parts (old screenshots, old interfaces) are updated.
8. **Images from the old site are usable** (bought stock); they may later be
   replaced with images made for the course, as in Pascal and AI. The
   margin gets the same treatment as the other courses: "Did you know?",
   jokes, illustrations, doodles (content-voice-and-pedagogy.md §5b).
9. **Ask Chris rather than guess.**

10. **A topic the boards teach in different grades goes in the earlier
    grade** (confirmed by Chris, 25 September 2026), with a grade note ("CAPS:
Grade 11 - IEB: Grade 12"); the later grade's course links back to it. Its
questions count for everyone, since both boards examine it.

## Sources

- **The old textbook** - "Learning Opportunities", Chris's Grade 10 online
  textbook (RapidWeaver): `Projects/LearningOpportunities/`. The exported
  pages with their images in place are `exports/*.php` + `exports/*_files/`;
  the same text as Word files in `AIResources/word documents/` (`bc_`,
  `cm_`, `hw_`, `sw_`, `im_`, `dc_`, `si_`; about 130 000 words, with notes,
  FAQs and video lists). **`cm_` is a later, longer copy of the `bc_`
  pages** - use `cm_`, check `bc_` for anything missing. Images:
  `LearningOpportunities/site_images/` (495 MB, 56 folders) and
  `LearningOpportunities/resources/`. Grades 11 and 12 have no old source.
- **Videos:** `word documents/_ALL_VIDEOS.csv` and `_DEAD_VIDEO_LINKS.csv` -
  only live links; never invent an id (platform.md decision 10).
- **Quotes:** `word documents/_ALL_QUOTES.docx` (the chapter quote pages
  `hw_quotes`, `im_quotes`, `si_quotes` are in it).
- **Syllabus:** [../caps-2024.md](../caps-2024.md),
  [../sags-2025.md](../sags-2025.md),
  [../sags-topic4-syllabus.md](../sags-topic4-syllabus.md).
- **Past theory papers:** CAPS Paper 2 2016-2026 with memos in
  `../CAPS/past papers/`; IEB Paper 2 2009-2020 in `../IEB/theory papers/`
  (none after 2020).

## How the boards compare (for flagging)

About 70% is common. The IEB goes deeper inside things (CPU registers,
clock and buses, machine cycle, UEFI, interrupts, IP/MAC/DNS/DHCP/ARP,
packets and frames, signed and floating-point numbers, RAID, parity). CAPS
alone has careers, the gig economy, AI/VR/AR, virtualisation, data
collection, how web apps are built (PHP, AJAX, XML), POPIA in Grade 10,
digital footprint. The IEB alone has the deep and dark web, laws by name,
digital heritage, thin/fat clients, web page design, judging sources.

Paper 2: CAPS 150 = short questions 20, systems 25, communications 25,
data 25, solution development 25, integrated scenario 30. IEB 150 = systems
40, Internet and communication 45, social 15, data and solution development
50.

Topics in different grades (placed in the earlier grade):

| Topic | CAPS | IEB | Goes in |
|---|---|---|---|
| BIOS chip, ROM | 11 | 10 | 10 |
| Spam, phishing, pharming, spoofing | 10 | 11 | 10 |
| Judging websites | - | 11 | 10 (the textbook has it) |
| Internet of Things, location-based services, GPS | 11 | 12 | 11 |
| VPN, blockchain, big data | 11 | 12 | 11 |
| Virtualisation | 11, 12 | - | 11 |
| Cookies, client/server scripting | 12 | 11 | 11 |
| Computer criminals, kinds of computer theft | 12 (11 in part) | 11 | 11 |

## Built lessons

| Grade | # | lessonId | Title | Notes |
|---|---|---|---|---|
| 10 | 1 | `ict` | ICT and ICT systems | Built 25 Sep 2026 from `cm_define_ict` (all of it except types of computers - lesson 2). IPO model (IEB) and information processing cycle (CAPS) taught once with both names; CAPS sections for digital technologies/IT and the ICT-system model; school admin, POS, cellphone billing, ATM (Chris's old flowchart); a spaza-shop multipart and a POS identify; Weiser quote. Two slips in the original fixed (IPO = Input; "advantages" heading on the disadvantages list). Reviewed with Chris 26 Sep 2026 (see "Content rules" below): VAT, POS price lookup, prepaid, billing, real-time reports, modern spaza POS, calculator note, both sides of disadvantages. On test and live 26 Sep 2026. |
| 10 | 2 | `kindsofcomputers` | Kinds of computers | Built 26 Sep 2026 from the "Types of Computers" part of `cm_define_ict` (every type and detail) plus a summary of the old "Types of OS" (`sw_systems`; the Software chapter teaches it fully). IEB sections: smart wear, single-board computers (Raspberry Pi, Arduino - Commons photos, credited), stand-alone and network applications, and a Raspberry Pi identify question. Classification table, OS per kind, data transfer vs syncing; Bongani's Bakkie Deliveries multipart; Olsen quote. Reviewed with Chris 26 Sep 2026: phablets dropped, netbooks as history, laptop vs desktop for heavy work, mainframes modernised (z13 photo), data centres as the cloud (South African regions), AI training and Lengau, desktop (IEB) = stand-alone (CAPS) operating systems, the phone as most South Africans' main computer, cloud servers, apps that are both, Wi-Fi-only syncing. Pictures reviewed 26 Sep 2026: supercomputer, data centre, server, desktop, phone, Arduino and the Raspberry Pi identify photo kept; a new laptop (Eagle) and tablet (site_images ipad.jpg); the car's embedded computers redrawn (`car-embedded`) and an `embedded-devices` figure added (microcontrollers vs boards that run an OS); doodles `os-manager` and `sync-cloud` added. |
| 10 | 3 | `hardwaresoftware` | Hardware and software | Built 26 Sep 2026 from `cm_hw_sw` (every panel and FAQ). Hardware sorted by job (input, processing, memory, storage, output, communication - NIC, modem, router), software (system, application with a table of kinds, embedded, firmware), distribution models (proprietary, shareware, freeware, open source, SaaS, adware; freemium as an IEB section), hardware vs software table, interdependence. Fixed from the original: GHz is clock ticks, only RAM is volatile, the modem/DTE jargon, chip makers updated. Nomsa's-laptop multipart and a lettered desk identify (`identify-l3`). Bob Taylor quote; margin quotes Feynman, Dave Barry, Torvalds. Reviewed with Chris 26 Sep 2026: ad-supported software (adware is malware only); fibre and LTE first, ADSL on its way out; chip makers kept and updated (on the yearly list); two main kinds of software for exams, embedded software and firmware as Good to Know; every other name for memory (primary/active memory, primary storage) and storage (secondary memory/storage, long-term memory/storage) given once, then memory and storage used; optical storage fading; AI now helps write code. Pictures: `hardware-jobs` drawing (redrawn from the old banners), current OS logos from Commons; doodles and identify drawing kept. |
| 10 | 4 | `datainfo` | Data, information and knowledge | Built 26 Sep 2026 from `cm_data_info` (+ bc's 73/90/200). The 73 followed from data to information to knowledge (a bursary needing 80%, not the old site's pass mark); wisdom and DIKW as Good to Know; `dikw-steps` figure. Four characteristics of good information taught with CAPS's five quality words side by side (CAPS Gr 11 T3 placed here). New section: how organisations use information (CAPS). Hilltop High tuck-shop multipart. Arthur C. Clarke quote; margin quotes Cameron ("not everything that counts", usually credited to Einstein) and Larry Page. Reviewed with Chris 26 Sep 2026: Grade 10 subjects added as a teen-sized big decision before the pension; operational/tactical/strategic decisions as Good to Know; timeliness and currency in one row with the difference said; information overload named (Kapor quote). Pictures: `decisions-three` drawing replaced the old Decisions picture; the rest kept. |
| 10 | 5 | `insidecase` | Inside the case | Built 26 Sep 2026 from `hw_inside_case` (all of it). System unit (not "the CPU"), the case and airflow (`case-airflow`), the motherboard (`motherboard-map`; what plugs in, what is built on), CPU/RAM/graphics card in outline, the power supply (230 V - the page said 220 V - watts, a PSU sum reveal, never force a connector, UPS), storage bays (M.2, SATA), inside a laptop and a phone. Sipho's-gaming-PC multipart; a motherboard identify. Clive Thompson quote. Reviewed with Chris 26 Sep 2026: pictures all kept. |
| 10 | 6 | `processing` | Processing and memory | Built 26 Sep 2026 from `hw_processing` (all panels and FAQs). CPU vs SoC (storage is a separate chip), NPUs, cores (updated counts), fetch-decode-execute and GHz (`fetch-execute`), inside the CPU (ALU, CU, registers - IEB section, `cpu-inside`), RAM (DIMMs, soldered RAM, DDR4/5, LPDDR, ECC, how much), is RAM expensive (reveal), ROM and the BIOS with POST and booting (IEB Gr 10 / CAPS Gr 11 - grade note; `boot-steps`), memory vs storage table, the graphics card. Hyper-threading and Optane as Good to Know. Aisha's-laptop multipart with a spec table; a RAM identify. Steve Jobs quote. Reviewed with Chris 26 Sep 2026: "more cores usually win"; Chris's current computer in the RAM aside (Lenovo, 24-core i9, 64 GB, RTX 3080 Ti); Optane dropped; pictures all kept. |
| 10 | 7 | `storage` | Storage | Built 26 Sep 2026 from `hw_storage` (all panels and FAQs; syncing linked to lesson 2). Hard drives (`hdd-anatomy`, head crash, sizes, external), solid state (memory cards, flash drives and their dangers, SSDs - M.2 NVMe and SATA, hybrid drives), optical (fading), cloud storage, a comparison table (CAPS: capacity, portability, technology). Kagiso's-wedding-photos multipart; a hard-drive identify. Anonymous backup saying. Reviewed with Chris 26 Sep 2026: the comparison table keeps words for capacity, with a note that "small" moved from 64/128 GB to 256 GB; head-crash doodle redrawn. |
| 10 | 8 | `inputkeyboards` | Input - keyboards and pointing devices | Built 26 Sep 2026 from the first part of `hw_input` (to the digitising tablet) plus touchscreens. Instructions vs commands, before the keyboard (punched card photo), layouts and kinds of keyboard (IEB), special keys (`keyboard-map`), shortcuts as Good to Know, the mouse (history fixed: 1964; Windows 3.0/3.1; wireless is not Wi-Fi), other pointing devices, digitising tablets and pens, touchscreens and gestures (`gestures`). Mbali's-design-studio multipart; a trackball identify. Julian Treasure quote. Cameras, scanners, sound, sensors, game controllers and accessibility are lesson 9. Reviewed with Chris 26 Sep 2026: instructions vs commands kept, with "some people use the words differently" and the `words-exasperated` doodle; pictures all kept. Lessons 1-8: "power cut" with load shedding as one example. |
| 10 | 9 | `inputother` | Input - cameras, scanners, sound and sensors | Built 26 Sep 2026 from the rest of `hw_input`. Cameras (phones, mirrorless replacing DSLRs, security), camera specs (megapixels worked out, ISO, JPEG vs RAW, optical vs digital zoom, geotagging and metadata), computer vision (deepfakes), barcodes and QR codes, scanners and OCR, RFID and NFC (`rfid-induction`), sound and voice recognition, sensors (`phone-sensors`), biometrics, game controllers, accessibility. Protecting-the-rhinos multipart; a barcode-scanner identify. Steve Jobs quote. Reviewed with Chris 26 Sep 2026: no content changes; pictures all kept. |
| 10 | 10 | `output` | Output | Built 26 Sep 2026 from `hw_output`. Screens (LCD/LED/OLED, resolution table with pixel sums, size, aspect ratio, refresh rate; `screen-specs`), projectors (lumens, DLP), printers (inkjet, ink tank, laser, thermal, dot matrix, MFPs), choosing a printer, 3-D printing, sound, haptics, VR/AR, output with no human (IoT, robots). Printing-at-Riverside multipart; a 3-D printer identify. Bill Gates quote; Chris's three monitors in an aside. Reviewed with Chris 26 Sep 2026: dot matrix kept only for carbon copies (out of the cost advice and the comparison table); interactive flat panels added after projectors; Chris's three monitors still current; the VR icon replaced by a photo (Wikimedia Commons, public domain). |
| 10 | 11 | `ports` | Ports and connectors | Built 26 Sep 2026 from `hw_ports`. Port vs connector vs standard, USB (speeds table with a worked copy time, connector shapes `usb-connectors`), USB-C only a shape (`usb-c-labels`), Thunderbolt and docks, video (HDMI, DisplayPort, VGA, adapters), network (RJ-45) and audio; ports of the past as Good to Know. New-presentation-room multipart; a motherboard-ports identify. Tanenbaum standards quote. Reviewed with Chris 26 Sep 2026: the older USB 3.0 / 3.1 / 3.2 Gen names added ("some people and exam papers still use..."); pictures all kept. |
| 10 | 12 | `commsdevices` | Communication devices | Built 26 Sep 2026 from `hw_communications`. The hardware (NIC wired/wireless, Wi-Fi, Bluetooth, cellular with SIM/eSIM, NFC, antennas, dongles), phones vs laptops vs desktops, getting online (ISP, medium, router + ONT; `home-internet`; SA fibre network vs ISP; hotspot, MiFi), and - ending the Hardware chapter - a desktop vs smartphone table (CAPS). Guesthouse-in-Clarens multipart; a router identify. Steven Levy quote; Guy Almes and Vint Cerf margin quotes. Reviewed with Chris 26 Sep 2026: notes that exams call the home router an "ADSL router", desktop RAM is usually (not always) upgradeable, and phones can take a USB-C network adapter; the Bluetooth dongle photo replaced (the old one was an audio receiver). |
| 10 | 13 | `hwcare` | Looking after hardware | Built 26 Sep 2026 from `hw_maintenance` (all of it). Phones and tablets (case, tempered glass, cloth, charging port, water resistance, updates), laptops (cleaning, carrying), desktops (cleaning the inside, the steps as an order question), heat (`laptop-airflow`, thermal throttling), power (surges, surge protectors, UPS), batteries (lithium-ion care), spills and drops (Apple's rice warning), good habits; software care named and left to lesson 17. Summerfield High lab multipart; a dusty-computer identify. Benjamin Franklin quote (new portrait, public domain). Reviewed with Chris 26 Sep 2026: content kept (Franklin's ounce and pound explained); the UPS photo replaced by a cutaway drawing (`ups-inside`: mains, charger, battery, inverter); other pictures kept. |
| 10 | 14 | `systemsoftware` | System software | Built 26 Sep 2026 from `sw_types` and `sw_systems` (all of both). What system software is, the OS's general jobs (`os-layers`), user interfaces (CLI, GUI, touch, voice and sensors), I/O, memory, file, disk and process management (`file-pieces`, `time-slices`, a Task Manager reveal), kinds of OS incl. real-time, the six OSs to know (table), standards and APIs, utilities (built in and third party), device drivers and plug and play (`driver-translate`); IEB section: source code, compilers, interpreters, executables, bytecode, IDEs. Ayanda's-second-hand-laptop multipart; a command-line identify (`cli-window`). Jef Raskin quote; Rheingold, Nadella and "driver error" margin quotes. Reviewed with Chris 26 Sep 2026: Linux kept as a suggestion for an old laptop; the driver doodle redrawn as a translator (OS, driver, printer); other drawings kept. |
| 10 | 15 | `appsoftware` | Application software | Built 26 Sep 2026 from `sw_applications` (every panel). What application software does, office software (word processing, spreadsheets, presentations, suites, working together in the cloud), communication, databases, DTP and web design, graphics (bitmap bit depths, lossy and lossless, vector - `bitmap-vector`, 3-D and rendering), video, sound and animation, CAD, business, maps and GIS, learning, games, AI tools; file types as Good to Know; choosing software and its hardware. Lerato's-bakery multipart; a spreadsheet identify (`spreadsheet-window`). Douglas Adams quote; Koblin and Gleick margin quotes. Reviewed with Chris 26 Sep 2026: the AI tools section kept as a taught section; drawings kept. |
| 10 | 16 | `softwareowning` | Getting and owning software | Built 26 Sep 2026 from `sw_distribution` and `si_licensing` (all of both). How software reaches you, perpetual licences (updates vs upgrades, product keys; commercial vs proprietary "some people use the words differently"), shareware and trials, subscriptions and SaaS (pros and cons), freeware, ad-supported, in-app purchases, open source (Git vs GitHub fixed; the xz back door), copyright (SA 50 years, public domain, fair dealing), EULAs (the old site's strange clauses), copyleft and Creative Commons (`licence-spectrum`, `cc-elements`), piracy; DRM and right to repair as Good to Know. Karabo's-T-shirt-business multipart; a CC badge identify (`cc-badge-q`). Richard Stallman quote (new portrait, CC BY-SA); Jim Warren and Daniel Ek margin quotes. Reviewed with Chris 26 Sep 2026: DRM and the right to repair stay Good to Know; the Creative Commons NC icon uses the official $ (what pupils meet online and in exams); drawings kept. |

The glossary is started (`content/theory10/glossary.php`, 299 terms after lesson 16).

**Pictures from Wikimedia Commons** are credited in the figure caption and
the lesson's doc comment (licence and author), as quote portraits are.

**Chris's Eagle image library** is a picture source too (Chris, 26 September
2026): `R:\Eagle\Eagle Image Library.library`, searchable through Eagle's
local API while Eagle runs (`http://localhost:41595/api/item/list?keyword=...`
or `&tags=...`; most items are named or tagged). Offer Chris a numbered
contact sheet of candidates and let him choose.

## Content rules from the lesson 1 review (Chris, 26 September 2026)

Chris reviewed lesson 1 point by point; these apply to every theory lesson.
The old textbook is the base, but **its facts are checked for today and for
South Africa before they go in** - fix what is wrong or dated, and say so in
the lesson's doc comment.

- **South African and current:** shelf prices already include VAT (the till
  adds nothing; the slip shows the VAT part); about four in five cellphone
  users are prepaid (contract and debit order second); per-second billing is
  the norm; bills are e-mailed or in an app; a non-payer's account and SIM
  are suspended (a phone is blacklisted only when stolen); small shops use a
  POS app on a tablet with a card reader; chains send sales to head office
  as they happen; SA-SAMS runs most public schools' admin; Telkom is
  switching off copper landlines. Use apps pupils use (WhatsApp, TikTok),
  not their parents' (Facebook).
- **Say how systems really work**, not a simplified version that is wrong
  (a POS stores the selling price when stock is loaded; the till looks it
  up).
- **Keep the exam's definitions, and add a note where reality is more
  complicated** (a basic calculator is not a computer, but the chip inside
  it is a one-job embedded computer).
- **Advantages and disadvantages:** learn the general list, then apply it
  to the situation given - not "true for all computers, in all situations".
  Where a point is debated (digital divide, job losses, AI "thinking"), give
  the other side in a line.
- Small accuracy: storage is its own part in the CAPS model, not a kind of
  output; say "a petrol car" when exhaust gas is the output.
- **Say "power cut", with load shedding as one example** (Chris, 26
  September 2026) - load shedding has been rare since 2024, so it is not the
  only way power is lost (a storm, a tripped switch).
- **Where people use a word differently, say so** (Chris, 26 September
  2026: "as always, some people say...") - give the course's meaning, note
  the other use, and tell pupils to read a question the way it means it.
- **Facts that date go on the yearly list** (Chris, 26 September 2026):
  brands, products, statistics and "most people" claims stay in the lesson
  (exams ask for some, such as CPU makers) and get a line in
  [theory-yearly-update.md](theory-yearly-update.md), checked every January.

## Chapters and lessons (draft)

The same chapter names in every grade, so a topic can be followed up the
years: **Basic concepts** (Grade 10 only), **Hardware**, **Software**,
**Information management**, **Networks and communication**, **The Internet
and the Web**, **Security**, **Social implications**, **Theory for
practical work**; Grade 12 ends with the two **theory exam guides**.
Security is its own chapter (the textbook had cybercrime under social
implications) because Grades 11-12 make it large and technical.

Flags: **B** both boards; **I** / **C** = an IEB-only / CAPS-only section
inside the lesson; **GtK** = Good to Know (not examined). Source = the old
textbook page.

### Grade 10

| Chapter | Lesson | Covers | Flags | Source |
|---|---|---|---|---|
| Basic concepts | ICT and ICT systems | ICT, ICT systems (till, cellphone), the IPO model with storage and communication, the information processing cycle, pros and cons of computers, economic reasons | B | cm_define_ict |
| | Kinds of computers | Supercomputers, mainframes, data centres, servers, desktops, laptops, tablets, phones, embedded; smart wear, single-board (Raspberry Pi, Arduino) I; classifying; which OS on which; syncing | B, I | cm_define_ict |
| | Hardware and software | To touch or not to touch; how each needs the other; the FAQs | B | cm_hw_sw |
| | Data, information and knowledge | The difference, why information is useful, what makes it good, how an organisation uses it | B | cm_data_info |
| Hardware | Inside the case | Case, motherboard, what lives where | B | hw_inside_case |
| | Processing and memory | CPU, cores, GPU, RAM, memory vs storage, "is RAM expensive?"; ALU, CU, registers, ROM and BIOS I | B, I | hw_processing |
| | Storage | HDD, SSD, hybrid, flash, SD, optical; capacity and speed; syncing vs portable storage | B | hw_storage |
| | Input (2 lessons: keyboards and pointing; cameras, scanners, sound, sensors, biometrics) | Everything in hw_input; keyboard shortcuts as GtK | B, GtK | hw_input |
| | Output | Screens, OLED, projectors, printers (ink, laser, thermal, 3-D), sound, touch, output without humans | B | hw_output |
| | Ports and connectors | USB to USB-C and Thunderbolt, HDMI, network port | B | hw_ports_connectors |
| | Communication devices | NIC, modem, router at the hardware level | B | hw_communications |
| | Looking after hardware | Maintenance | B | hw_maintenance |
| Software | System software | The three kinds, the OS and its jobs (file, disk, memory, process), interfaces (command line, GUI, touch, voice), utilities, drivers, APIs; OS types; source vs executable I | B, I | sw_types, sw_systems |
| | Application software | Office, web, DTP, graphics (bitmap vs vector), video, audio; file types as GtK | B, GtK | sw_applications |
| | Getting and owning software | Distribution: proprietary, shareware, freeware, freemium I, open source, SaaS; EULAs, copyright, copyleft, Creative Commons, piracy | B, I | sw_distribution, si_licensing |
| | Looking after a computer | Clean-up, updates, backup and archive, compressing, installing and uninstalling (keys, activation), scheduling, firewall, anti-malware, regional settings, sharing and permissions | B | new (CAPS 10 T3, SAGs 10.1.7) |
| Information management | How computers store data | Switches, 01010000 is a number | B | im_data_representation |
| | Bits and bytes | Bit, nibble, byte, multiples; combinations vs bits I | B, I | im_bits |
| | Number systems (2 lessons: binary; hexadecimal and octal) | Counting, all conversions (IEB adds binary <-> hex), where each is used; octal GtK | B, I, GtK | im_number_systems |
| | Characters | ASCII, Unicode, UTF-8 | B | im_ascii |
| | Primitive data types | Integer, real, char, Boolean, string and their storage | B | im_primitives |
| | Storing data and managing files | Persistence, secondary memory; drives, paths, names, extensions, the folder tree, file managers, associations, compressed files | B | im_data_storage, im_file_management |
| | Databases - a first look | Short summary; links to the SQL course | B | new |
| Networks and communication | Why networks | What a network is, reasons, advantages and disadvantages | B | dc_adv_networks, dc_disadv_networks |
| | Types of networks | PAN, HAN, LAN, WLAN, WAN, MAN, GAN; Bluetooth; topologies; client-server vs peer-to-peer (setting each up as GtK); NOS, access control C | B, C, GtK | dc_types_of_networks, dc_template |
| | Communications media | Copper, dial-up, ADSL/VDSL, fibre (undersea cables), radio; microwave I, infrared C; the home router's jobs I | B, I, C | dc_communications_media |
| | E-communication (3 lessons: e-mail; chat, IM, VoIP and video; social media, blogs, vlogs, podcasts) | Everything in dc_e-comms; the Gmail step-by-step guides as GtK, refreshed; calendars and collaboration I | B, I, GtK | dc_e-comms |
| | Netiquette | Netiquette, e-mail best practice | B | dc_netiquette |
| The Internet and the Web | The Internet | What it is, how much it carries, connecting (African undersea cables, routers), the cloud | B | dc_internet |
| | URLs, IP addresses and DNS | Anatomy of a URL, domain names, how DNS works | B | dc_internet |
| | The World Wide Web | Early web, types of sites, wikis, web apps, blogs, web page vs site, appification; dark sites (link forward to Grade 12) | B | dc_www |
| | Browsing and searching | Browsers, search engines, search techniques, Boolean searches | B | dc_browsing |
| | Judging a website | Why and how; the criteria (IEB 11.3.1) | B | dc_evaluating_sites |
| | Making web pages | HTML, CSS, JavaScript (GtK); web page design and usability I | GtK, I | dc_web_development |
| | Who runs the Web | W3C and ICANN | GtK | dc_w3c_icann |
| Security | Malware and cybercrime | Hackers, crackers, script kiddies, the hats; viruses, worms, Trojans, phishing, scams, spyware, adware, ransomware, pharming, clickjacking, spoofing, hoaxes, fake news, spam; safe habits; POPIA basics C | B, C | si_cyber_crime |
| Social implications | Computers and our society | How society is changing | B | si_intro |
| | The digital divide | Haves and have-nots, causes, solutions, who is left out; digital citizenship and footprint C | B, C | si_digital_divide |
| | Your body and the planet | Ergonomics, RSI, eye strain, carpal tunnel; green computing, e-waste, vampire power | B | si_green_computing + new |
| | Plagiarism | What it is, how to avoid it | B | si_plagiarism |
| Theory for practical work | (one or more lessons) | Algorithms, IPO tables, flowcharts, trace tables; Polya and computational thinking (both names); data types; Boolean logic and truth tables; test data and error types; user stories and noun-verb analysis C; UI principles | B, C | new, links to Pascal/Java |

### Grade 11 (no old source)

| Chapter | Lessons | Flags |
|---|---|---|
| Hardware | The motherboard and data flow; the clock and the buses I; memory and caching; doing many things at once (+ machine cycle I); starting up - UEFI, CMOS, interrupts I; primary vs secondary storage compared | B, I |
| Software | Operating systems compared C; virtual memory (paging and swapping I); virtualisation and virtual machines C; compilers, interpreters, assemblers | B, I, C |
| Information management | Numbers in a fixed number of bits (signed, unsigned, overflow, floating point, colour depth) I; when data goes wrong - GIGO, errors, verification vs validation, input methods, checks, parity I; databases and the DBMS (summary, link to SQL) | B, I |
| Networks and communication | Network hardware and topologies; addresses, packets and frames I; protocols and wide area networks; mobile and wireless (intranet/extranet C); VPN | B, I, C |
| The Internet and the Web | Streaming and compression; how the Web grew up (static/dynamic, Web 1.0-4.0 I, scripting, cookies, web apps, mobile apps; PHP, XML, AJAX C); searching like an expert I; IoT, 4IR and 5IR, location-based services and GPS, big data | B, I, C |
| Security | Threats to a system; protecting a system (RAID, TKIP I; MFA, OTP C); computer crime and social engineering; blockchain | B, I, C |
| Social implications | Work in a digital world (AUP, remote work, robots, AI, drones; gig economy, careers, online identity C); what IoT and big data do to people | B, C |
| Theory for practical work | Arrays, searching and sorting on paper; classes, objects and class diagrams; text files; validation and testing; parameters; GUI principles | B |

### Grade 12 (no old source)

| Chapter | Lessons | Flags |
|---|---|---|
| Hardware | What makes a computer fast (co-processors, register size, clock multiplication I); choosing a computer for a job, mobile constraints | B, I |
| Software | Cloud computing and SaaS; AI, VR, AR and MR C (the IEB's "latest technology") | B, C |
| Information management | Collecting and caring for data C; warehousing, mining and big data (summary, link to SQL) | B, C |
| Networks and communication | Centralised and distributed processing, thin/fat/smart clients I; sharing and remote access (BitTorrent, FTP vs WebDAV I, TeamViewer, VPN); connecting a home or school C | B, I, C |
| The Internet and the Web | SEO, semantic and mediated search C; the deep and dark web, Tor I | B, I, C |
| Security | Keys, SSL and certificates; cryptocurrency; cybercrime in depth; evaluating and recommending security | B |
| Social implications | Privacy, rights and the law (POPI, ECT, Sexual Offences, Harassment Acts, cyberbullying, digital heritage I; GUIDs C); computers and the big problems; green computing I; case studies | B, I, C |
| Theory for practical work | Inheritance and polymorphism; dynamic arrays and JSON I; 4-variable truth tables I; efficiency | B, I |
| Exam guides | Theory exam guide - IEB; Theory exam guide - CAPS | I, C |

## Questions (Chris, 25 September 2026)

- **All questions are new** - the old site's quizzes are not reused.
- **Modelled on the theory papers** - read
  [../ieb-theory-exam-analysis.md](../ieb-theory-exam-analysis.md) and
  [../caps-theory-exam-analysis.md](../caps-theory-exam-analysis.md)
  (section 7 of each: which platform type fits which exam format).
  **More written questions than the other courses** (about 75-90% of both
  papers is written answers); auto-marked types for recall - give the term
  (`typed`), multiple choice (`quiz`), choose TWO (`select`), matching
  (`match`, more options than rows), modified true/false (`typed`).
- **Multipart** (built 25 Sep 2026): `...Scenario ('Title', $stemHtml,
  [parts], Figure (...))`. A South African scenario (a school, shop, lodge,
  event; named people), one stimulus at most (spec list, small table,
  diagram, screenshot); 3-6 parts, 8-16 marks; recall first, then explain
  and apply, then judge (CAPS 40/40/20, IEB 30/40/30); at least one part
  that needs the scenario.
- **Identify** (built 25 Sep 2026): `...Identify ('Title', Figure (...),
  [parts])`. The papers rarely do this - it is the course's own recall type,
  strongest in Grade 10 hardware. Usual parts: what is it (`typed`, every
  accepted name), what is it used for (written 2: what it does + where or
  why, not the name spelled out), then written 2s - advantages over a named
  alternative, a disadvantage, would it suit a given case. **The picture's
  alt text, caption and file name must not give the answer away.**
- **Marks:** written parts are **2 or 4** (decision 8); a 1-mark recall part
  is auto-marked (doubled to 2). Rubrics mark as the memos do: one mark per
  distinct valid point; "any N" lists longer than N; nothing for an acronym
  only, "faster/cheaper" with no reason, mirror-image opposites, a bare
  yes/no, or the question's own example repeated.

## Platform work

**Built 25 September 2026** (local only, not published; rules in
platform.md, "Grades, chapters and board sections"): the three courses
(`draft`) with `includes`, the `Enrol()` cascade and plans covering included
courses; chapter headings; `BoardSection()` with per-board totals everywhere
and decision 28's exception; the shared glossary (`glossaryFrom`); the
`theory` marking voice; `content/theory10/index.php` with all 45 Grade 10
lessons as stubs, and empty `sags.php`/`caps.php`. Checked on the testbed
with a throwaway lesson and pupil (both removed).

The **multipart** and **identify** types were built the same day
(`Scenario()`, `Identify()`; platform.md "Block types") and checked on the
testbed the same way.

Still to build:

1. Images copied from the old site into `public/assets/lessons/theory/` -
   only those used, resized - as each lesson is written.
2. The glossary file (`content/theory10/glossary.php`) - started with the
   first lesson.
