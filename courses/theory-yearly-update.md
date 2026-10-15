# IT Theory - yearly update checklist

**Why this exists** (Chris, 26 September 2026): theory lessons state facts
that go stale - brand names, "most people", "South Africa has", typical
sizes. Exams still ask for some of them (naming CPU makers, for example), so
they stay in the lessons, and **this list is checked once a year** (before
the new school year starts, in January). Programming courses do not need
one; the AI course has its own ([ai-yearly-update.md](ai-yearly-update.md)).

**The rule:** when a theory lesson states a fact that will date - a brand, a
product, a price, a statistic, "the newest", "most", "now" - add a line here
in the same session. Historical facts with a date ("in 1956...") do not need
a line.

**How to check a line:** search for current South African and world sources,
fix the lesson (and its glossary line or study block if they repeat it),
update "Last checked", and note any change in [../history.md](../history.md).

Lesson files are `AIPascalCourse/content/theory10/<lessonId>.php`; the
anchor is the section (`#anchor`). The CAT Theory lessons
(`cattheory10`, `cattheory11`, `cattheory12`) have their own section at the
end, [CAT Theory](#cat-theory).

## Grade 10

### Lesson 1 - ICT and ICT systems (`ict`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#pos`, study | South African VAT is 15%; shelf prices include it | The VAT rate (Budget speech each February) | 2026-09-26 |
| `#pos` | Small shops use a POS app on a tablet with a card reader; chains send sales to head office as they happen | Still how small and large retailers work | 2026-09-26 |
| `#cellBilling`, study | About four in five South African cellphone users are prepaid; per-second billing; bills e-mailed or in an app; non-payers suspended | ICASA / network figures; billing practice | 2026-09-26 |
| `#cellBilling` | Zero-rated data on some sites and apps | Still offered by SA networks | 2026-09-26 |
| `#schoolAdmin`, study | SA-SAMS runs most public schools' admin | Whether the DBE has replaced SA-SAMS | 2026-09-26 |
| `#ictMeaning` | Telkom is switching off copper landlines | Progress of the copper switch-off | 2026-09-26 |
| `#ictMeaning` | WhatsApp, TikTok and Uber as everyday examples | Still the apps pupils use | 2026-09-26 |
| `#prosCons`, study | AI can write, draw and compose; whether that is thinking or creating is debated | How AI is described now | 2026-09-26 |

### Lesson 2 - Kinds of computers (`kindsofcomputers`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#bigOnes` | Lengau at the CHPC in Cape Town is South Africa's supercomputer | Whether Lengau has been replaced or joined | 2026-09-26 |
| `#bigOnes` margin | Every one of the Top500 supercomputers has run Linux since November 2017 | The latest Top500 list | 2026-09-26 |
| `#bigOnes` | Supercomputers train the biggest AI models | Still true | 2026-09-26 |
| `#bigOnes` | Several big SA banks process card payments on mainframes | Still true | 2026-09-26 |
| `#bigOnes` | SA cloud data centres: Microsoft (Johannesburg, Cape Town, 2019), Amazon (Cape Town, 2020), Google (Johannesburg, 2024) | New regions opened since | 2026-09-26 |
| `#personal` | Laptops outsell desktops worldwide; netbooks are gone; ultrabooks, 2-in-1s, Chromebooks | Sales figures; the laptop names in use | 2026-09-26 |
| `#mobile` | For most South Africans the smartphone is the main (often only) computer | Stats SA / GSMA figures | 2026-09-26 |
| `#mobile`, `#classifying` | Tablets are 7 inches or bigger; a flagship phone beats many budget laptops | Still true | 2026-09-26 |
| `#osPerKind` | OS names: Windows, macOS, Linux, ChromeOS; Android, iOS | New or renamed operating systems | 2026-09-26 |
| `#syncing` | Google Drive, OneDrive, iCloud as sync services | Still the main services | 2026-09-26 |

### Lesson 3 - Hardware and software (`hardwaresoftware`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#processing` | **CPU makers** (exams ask for them): Intel, AMD (desktops, laptops, servers; AMD GPUs); Nvidia (GPUs, AI chips); Apple (iPhone, iPad, Macs since 2020); Qualcomm Snapdragon (Android phones, some Windows laptops); MediaTek (budget and mid-range Android); Samsung Exynos (some Galaxy phones); Broadcom (Raspberry Pi) | Market changes - who makes what | 2026-09-26 |
| `#processing` | A processor ticks several billion times a second (GHz); AI is trained on GPUs | Still true | 2026-09-26 |
| `#processing` | A laptop might have 16 GB of RAM and 512 GB of storage | Typical new-laptop sizes | 2026-09-26 |
| `#storage` | Most new computers have no optical drive; almost every new laptop has an SSD; hard drives are cheapest per GB | Still true (SSD vs HDD prices) | 2026-09-26 |
| `#comms` | Fibre (ONT), LTE/5G routers; ADSL on its way out as Telkom switches off copper | Whether ADSL is gone; 6G | 2026-09-26 |
| `#software` | Application examples: Word, Google Docs, LibreOffice, Excel, Sheets, PowerPoint, Slides, Canva, Access, MySQL, Photoshop, GIMP, Inkscape, Blender, Sage Pastel, Xero, AutoCAD, SketchUp, WhatsApp, Gmail, Teams | Products renamed or gone | 2026-09-26 |
| `#distribution` | Examples: Windows and Office bought once (proprietary); WinRAR (shareware); WhatsApp, Chrome, Acrobat Reader (freeware); Linux, LibreOffice, Firefox, VLC, GIMP (open source); Microsoft 365, Adobe Creative Cloud (subscription); free phone games (ad-supported) | Licence models change (a freeware product going subscription, Office no longer sold once) | 2026-09-26 |
| `#distribution` (IEB) | Freemium: Spotify, Canva, free-to-play games | Still freemium | 2026-09-26 |
| `#processing`, questions | Power cuts, with load shedding named as one kind | Whether load shedding is still part of pupils' lives | 2026-09-26 |

### Lesson 4 - Data, information and knowledge (`datainfo`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#organisations` | Shops collect data through loyalty cards; banks block unusual card payments; tax and VAT records go to SARS | Still true | 2026-09-26 |

### Lesson 5 - Inside the case (`insidecase`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#motherboard` | Boards for the newest CPUs and fastest RAM cost several thousand rand | SA prices | 2026-09-26 |
| `#psu` | Many South Africans put a desktop on a UPS for load shedding | Still how people cope with outages | 2026-09-26 |
| `#laptopPhone` margin | EU law (2023): user-replaceable phone batteries from 2027 | Whether it came into force as planned | 2026-09-26 |

### Lesson 6 - Processing and memory (`processing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whoWorks` | Newer phones and laptops have an NPU for AI | Still the name and the trend | 2026-09-26 |
| `#cpuSoc` | SoCs in Apple's M-series Macs (since 2020) and Snapdragon Windows laptops; Arm licenses to Apple, Qualcomm, Samsung, MediaTek | Market changes | 2026-09-26 |
| `#cores` | Phones 8 cores; PCs about 4 to 24; a server chip up to 192 | Current core counts | 2026-09-26 |
| `#ram` | DDR4 and DDR5 sold today; LPDDR in phones; a guide of 8 / 16 / 32 GB; Chris's own computer (Lenovo, 24-core i9, 64 GB RAM, 20 TB, RTX 3080 Ti; ComfyUI, LM Studio, Claude, Lazarus, Eagle, 100+ tabs) | DDR6? typical RAM sizes | 2026-09-26 |
| `#ramCost` | Shops to price RAM: Takealot, Evetech, Wootware; RAM costs many times more per GB than an SSD | Shops still trading; the price ratio | 2026-09-26 |
| `#gpu` | Gaming cards 8-32 GB VRAM, the fastest cost tens of thousands of rand; Nvidia, AMD, Intel; CUDA for 3-D and AI; eGPUs not on Apple's newer Macs; Nvidia briefly the world's most valuable company in 2024 (margin) | Card memory and prices; makers | 2026-09-26 |

### Lesson 7 - Storage (`storage`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#hdd` | A desktop hard drive holds 20 TB or more; 5 400 / 7 200 rpm; most new laptops have SSDs | Capacities | 2026-09-26 |
| `#compare` | "Small" used to mean 64 or 128 GB; most computers now start at 256 GB, regarded as small | The smallest common size | 2026-09-26 |
| `#solidState` | Memory cards up to 1 TB and more; CFexpress replacing CompactFlash; SSDs cost several times more per GB than hard drives; M.2 NVMe in almost every new laptop; hybrid drives rare | Prices and formats | 2026-09-26 |
| `#optical` | Optical storage fading - still used for films, some consoles, archives | Whether consoles still take discs | 2026-09-26 |
| `#cloud` | Google Drive, OneDrive, iCloud Drive, Dropbox | Still the main services | 2026-09-26 |

### Lesson 8 - Input - keyboards and pointing devices (`inputkeyboards`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#keyboard` | South Africa uses the US English layout | Still true | 2026-09-26 |
| `#specialKeys` | In Windows 11, Print Screen opens the Snipping Tool; Mouse Keys is in Accessibility; Excel uses Scroll Lock | Windows changes | 2026-09-26 |
| `#pointing` | ThinkPads still have a track stick; Apple's Magic Trackpad; Wacom the biggest name; Apple Pencil, S Pen, Surface pen | Products | 2026-09-26 |

### Lesson 9 - Input - cameras, scanners, sound and sensors (`inputother`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cameras` | Makers have stopped designing new DSLRs; professionals use mirrorless; phones film 4K and 240 fps slow motion; margin: 28 Years Later (2025) shot on iPhones | Camera market | 2026-09-26 |
| `#cameraSpecs` | Better phones have 3x or 5x optical telephoto lenses; HEIC on iPhones | Phone camera specs | 2026-09-26 |
| `#vision` | Google Lens as the object-identification example | Product name | 2026-09-26 |
| `#codes` | Paying by QR with SnapScan, Zapper or a bank app | Still the SA apps | 2026-09-26 |
| `#rfid` | e-tags at toll plazas; Apple only starting to open iPhone NFC to other apps | e-tolls still running; Apple's NFC policy | 2026-09-26 |
| `#sound` | Voice assistants: Siri, Google's assistant (now Gemini), Alexa | Names | 2026-09-26 |
| `#biometrics` | Banks and Home Affairs check fingerprints or faces | Still true | 2026-09-26 |
| `#accessibility` | Windows calls bounce keys "filter keys"; Shift five times turns on sticky keys | Windows changes | 2026-09-26 |

### Lesson 10 - Output (`output`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#screens` | Resolution table (Full HD most common; QHD; 4K; 5K/8K rare); refresh rates 60 / 120 / 144 Hz; Chris's three monitors (two 27" QHD, one 27" 4K) | Common resolutions; Chris's setup | 2026-09-26 |
| `#projectors` | Many older school projectors are VGA at 1024 x 768; DLP newer; many classrooms now have interactive flat panels | School projectors and panels | 2026-09-26 |
| `#printers` | Ink tank printers popular in SA homes and small offices; dot matrix bought only for multi-part forms | Still true | 2026-09-26 |
| `#printing3d` | Hobby 3-D printers cost about as much as a good phone; many schools have one | Prices | 2026-09-26 |
| `#soundTouch` | The VR photo is a Meta Quest 3 (named in its caption) | Still a current headset | 2026-09-26 |

### Lesson 11 - Ports and connectors (`ports`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#usb` | USB speed table up to USB4 (40, v2 80 Gb/s) | New USB versions | 2026-09-26 |
| `#usbC` | EU requires USB-C on new phones (2024); iPhone 15 switched (2023); PD up to 240 W | New rules | 2026-09-26 |
| `#thunderbolt` | Thunderbolt 5 (2023) at 80 Gb/s; every Mac has Thunderbolt | Versions | 2026-09-26 |
| `#video` | HDMI cable classes up to Ultra High Speed (4K at 120 Hz, 8K) | New HDMI versions | 2026-09-26 |

### Lesson 12 - Communication devices (`commsdevices`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#commsHardware` | Wi-Fi 5, 6, 7; 4G LTE and 5G; eSIMs | Newest Wi-Fi and cellular generations | 2026-09-26 |
| `#perDevice` | Many desktops now have Wi-Fi and Bluetooth built in | Still true | 2026-09-26 |
| `#online` | ADSL on its way out; fibre networks Openserve, Vumatel, Frogfoot; ISPs Afrihost, Webafrica, Vox (also in the ISP popup) | Companies still trading; ADSL gone? | 2026-09-26 |

### Lesson 13 - Looking after hardware (`hwcare`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#phones` | iPhones get updates for many years; the best Android phones up to seven years, cheaper ones one or two | Makers' update promises | 2026-09-26 |
| `#batteries` | Many phones and laptops can stop charging at 80% | Still a common setting | 2026-09-26 |
| `#power` | Surges when power returns after a power cut (load shedding as one kind) | Whether load shedding is back | 2026-09-26 |
| `#spills` | Apple warns against putting a wet phone in rice | Still Apple's advice | 2026-09-26 |
| `#habits` | Windows lets you pull out most flash drives without ejecting; a Mac needs ejecting | Windows and macOS changes | 2026-09-26 |

### Lesson 14 - System software (`systemsoftware`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#interfaces` | Voice assistants and AI chatbots as interfaces; brain-signal and muscle sensors | New interfaces | 2026-09-26 |
| `#examples` | Windows 11 current (Windows 10's support ended 14 October 2025; home users' extended security updates run to 12 October 2027), on Arm too; Macs on Apple's Arm chips since 2020; iPadOS since 2019, with mouse and trackpad; ChromeOS runs Android and Linux apps; Samsung One UI; every top-500 supercomputer runs Linux; Ubuntu from Canonical (Mark Shuttleworth); the Nadella/Ballmer margin note | New versions; Google merging ChromeOS and Android? | 2026-09-27 |
| `#utilities` | Windows tools by name (Disk Clean-up, Storage Sense, Defragment and Optimise Drives, Device Manager, Disk Management, Task Scheduler, Windows Security / Microsoft Defender, File History, Windows Backup, the Windows Tools folder); the Mac Utilities folder; 7-Zip, WinRAR | Renamed or removed tools | 2026-09-26 |
| scenario | Ayanda's laptop no longer gets Windows 10 updates; the rubric accepts Microsoft's extended security updates, which run to October 2027 for home users | Whether ESU still exists; its end date | 2026-09-27 |

### Lesson 15 - Application software (`appsoftware`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#office` | Word, Google Docs, LibreOffice, Pages; Excel, Sheets, Calc, Numbers; PowerPoint, Slides, Canva, Keynote, Impress; Microsoft 365, Google Workspace | Product names | 2026-09-26 |
| `#communication` | Chrome, Edge, Safari, Firefox; Gmail, Outlook; WhatsApp; Teams, Zoom, Meet; TikTok, Instagram, YouTube | What pupils use | 2026-09-26 |
| `#publishing` | InDesign, Affinity (owned by Canva), Scribus, Canva; Microsoft Publisher retired from October 2026; VS Code, Wix, Squarespace, WordPress | Products; drop the Publisher note once it is history | 2026-09-26 |
| `#graphics` | Photoshop, GIMP, Affinity, Photopea; Illustrator, Inkscape, CorelDRAW; Blender, Maya, 3ds Max, Cinema 4D | Products | 2026-09-26 |
| `#media` | Premiere Pro, DaVinci Resolve, Final Cut Pro, CapCut, Clipchamp, iMovie, OBS Studio; Audacity, Audition, GarageBand, Logic Pro, FL Studio (amapiano margin note); MuseScore; Toon Boom Harmony, Moho, Pencil2D, Synfig | Products | 2026-09-26 |
| `#cad`, `#business` | AutoCAD, SolidWorks, Fusion, SketchUp, FreeCAD; Sage Pastel, Xero; Google Maps, Waze, Apple Maps, Uber, Bolt; Google Classroom, Teams, Khan Academy | Products | 2026-09-26 |
| `#ai` | AI tools "since 2022": ChatGPT, Gemini, Copilot, Claude; AI in Word, Docs, Photoshop, Canva | Names; the "since" year still right | 2026-09-26 |
| `#choosing` | Video, 3-D and CAD want 16 GB of RAM or more | Typical RAM | 2026-09-26 |

### Lesson 16 - Getting and owning software (`softwareowning`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#getting` | Google Play, App Store, Microsoft Store, Mac App Store | Store names | 2026-09-26 |
| `#subscription`, `#free` | Microsoft 365, Adobe Creative Cloud; freeware WhatsApp, Chrome, Acrobat Reader; Google, TikTok and Meta earn from adverts | Still true | 2026-09-26 |
| `#openSource` | GitHub owned by Microsoft; the 2024 xz back door; examples Linux, LibreOffice, Firefox, VLC, GIMP, Blender, Apache, nginx | Ownership; a newer example? | 2026-09-26 |
| `#copyright` | South Africa: usually 50 years after the author's death (Copyright Act 98 of 1978); USA 70; fair dealing | The Copyright Amendment Bill - if it becomes law, check fair dealing and terms | 2026-09-26 |
| DRM Good to Know | Right to repair laws in the EU and several US states | New laws | 2026-09-26 |

### Lesson 17 - Looking after a computer (`computercare`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#updates` | WannaCry (May 2017): more than 200 000 computers in about 150 countries, British hospitals; Microsoft's patch two months earlier | Stable history | 2026-09-26 |
| `#updates` | Windows Update, a Mac's Software Update; active hours; pausing for a few weeks; metered connections; phones update at night | Windows and phone setting names | 2026-09-26 |
| `#updates` | Windows 10 end of support October 2025 (14 October; lesson 14 has the extended updates) | Still the example to use | 2026-09-27 |
| `#installing` | Google Play, App Store, Microsoft Store; the "allow this app to make changes" prompt; Windows 11 digital licence linked to hardware and Microsoft account; uninstall via Settings, Apps, Installed apps (three dots); iPhone "Remove App" | Names and steps | 2026-09-26 |
| `#cleanup` | Storage Sense (deletes Recycle Bin files after 30 days), Disk Clean-up still present; Task Manager "Startup apps"; "Recently deleted" photos 30 days or more (Google Photos 60); Android Files app; iPhone offload apps; WhatsApp Manage storage; Windows defragments hard drives weekly (Optimise Drives) | Tool names; Disk Clean-up retired? (not yet deprecated, 2026) | 2026-09-27 |
| `#backup` | File History hourly; Windows Backup to OneDrive; Time Machine hourly; Google One backup, iCloud Backup, Google Photos, iCloud Photos; WhatsApp chat backup; cloud services keep deleted files about 30 days; SARS: business records kept five years | Tool names; SARS rule | 2026-09-26 |
| `#backup` | Toy Story 2 nearly lost in 1998, saved by a copy at a technical director's home | Stable history | 2026-09-26 |
| `#compress` | E-mail attachments limited to about 20 or 25 MB; 7-Zip (.7z) and RAR; Windows 11 opens .7z and .rar itself and makes .7z (24H2); a .docx is a zip file | Attachment limits; Windows archive formats | 2026-09-27 |
| `#security` | Windows Defender Firewall on by default (still its name in Windows 11's Control Panel, 2026); private and public networks; Microsoft Defender Antivirus in Windows Security; Google Play Protect; iPhones in South Africa install only from the App Store | Names; whether iPhone app stores open up in South Africa (as in the EU) | 2026-09-26 |
| `#regional` | Windows English (South Africa): decimal comma, space grouping, yyyy/MM/dd short date, 24-hour time; English (US) M/d/yyyy; Settings, Time and language; Control Panel, Region, Additional settings; Delphi's "'3.5' is not a valid floating point value"; many South African till slips print R49.99 | Windows format defaults; Delphi message | 2026-09-26 |
| `#sharing` | Google Drive, OneDrive, iCloud: specific people vs anyone with the link; viewer, commenter, editor; a "Shared" list; link expiry and blocking downloads | Share options and names | 2026-09-26 |

### Lesson 18 - How computers store data (`storingdata`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#number` | ENIAC (1945) stored each digit in a ring of ten circuits | Stable history | 2026-09-26 |
| `#codes` | On Intel and AMD processors the byte 01010000 (hex 50) is an instruction (push a register) | Stable | 2026-09-26 |
| `#everything` | 😀 is 128 512 in Unicode; CD music sampled 44 100 times a second; video usually 24, 30 or 60 frames a second | Stable | 2026-09-26 |
| `#whereBits` | DRAM refreshed about every 64 ms (about 16 times a second); SRAM cells about six transistors; today's flash stores three or four bits per cell; most of today's flash traps charge in an insulating layer (charge trap), not a floating gate | Flash moving to five bits per cell? | 2026-09-27 |

### Lesson 19 - Bits and bytes (`bitsbytes`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#bit` | "Bit": John Tukey 1947, first printed by Claude Shannon 1948 | Stable history | 2026-09-26 |
| `#byte` | Werner Buchholz named the byte at IBM in 1956; 8 bits since the IBM System/360 (1964) | Stable history | 2026-09-26 |
| `#smallest` | Default cluster 4 KB on Windows (NTFS), macOS (APFS) and Linux (ext4); tiny files (a few hundred bytes) show 0 bytes on disk (kept in the NTFS index) | File-system defaults | 2026-09-27 |
| `#multiples` | Ronna and quetta prefixes named in 2022; the world's data counted in zettabytes | Still zettabytes? | 2026-09-26 |
| `#thousand` | IEC ruling 1998 (KiB, MiB); drive makers and macOS use 1 000; Windows counts in 1 024 but writes KB/GB (1 TB shows as 931 GB); a memo accepted 1 500 - 1 536 GB for 1.5 TB (CAPS 2019) | Windows labels; memo practice | 2026-09-26 |
| `#converting` | Data bundles sold in MB and GB; speeds in Mb/s; 100 Mb/s fibre = 12.5 MB/s | Stable | 2026-09-26 |
| `#howBig` | A page of plain text 3 KB; a phone photo 2 to 5 MB; an MP3 song 4 to 10 MB; an hour of streamed HD video 1 to 3 GB; a big game 50 to 150 GB; phone storage 64 to 512 GB; laptop SSD 256 GB to 2 TB (lower ends = SA budget devices, Chris 27 Sep 2026); an emoji 4 bytes | Typical sizes (phones, games and SSDs grow) | 2026-09-27 |
| `#combinations` | IPv4 32 bits (about 4.3 billion addresses), IPv6 128 bits | Stable | 2026-09-26 |

### Lesson 20 - Binary (`binary`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#bases` | French 80 = quatre-vingts (counting in twenties) | Stable | 2026-09-26 |
| `#counting` | "The odometer in an older car, or the water meter at your gate" (rolling number wheels) | Do pupils still know them? | 2026-09-27 |
| `#notation` | Java, Python and C# write binary as 0b; Delphi from version 11 as %1010 | Delphi versions in schools | 2026-09-27 |
| `#whereUsed` | Ten fingers as ten bits count to 1 023 | Stable (maths) | 2026-09-26 |

### Lesson 21 - Hexadecimal and octal (`hexoctal`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#decToHex` | The Windows Calculator has a Programmer mode showing hex, decimal, octal and binary (margin note) | Still in Windows' Calculator | 2026-09-26 |
| `#whereHex` | A failed Windows Update can show 0x80070005 ("access denied"); IPv6 addresses are written in hex; every PDF starts with 25 50 44 46 | Still a common Windows error code to use as the example | 2026-09-26 |

### Lesson 22 - Characters - ASCII and Unicode (`characters`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#unicode` | Unicode has more than 150 000 characters (room for 1 114 112); new emoji are added every year | The latest Unicode version's count | 2026-09-26 |
| `#utf8` | About 98% of websites use UTF-8; Windows, Java and Delphi use UTF-16 inside | W3Techs' figure | 2026-09-26 |
| `#mojibake` | Notepad and Excel offer "UTF-8" when saving | Save dialogs | 2026-09-26 |
| `#saLanguages` | Twelve official languages: eleven written ones and South African Sign Language (since 2023); Alt+0234 / Alt+0235 for ê / ë, long-press on phones | Any change to official languages | 2026-09-26 |

### Lesson 23 - Primitive data types (`primitives`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#sizes` | Delphi: Real = Double (8 bytes), Char 2 bytes (UTF-16); Lazarus/Free Pascal Char 1 byte; Java sizes; JavaScript one number type for almost everything; Python's integers grow as needed | New Delphi/Lazarus/Java versions | 2026-09-26 |
| `#sizes` | Gangnam Style passed a 32-bit view counter in 2014 (margin note) | - (history) | 2026-09-26 |
| `#choosing` | SA ID numbers start with the date of birth - those born 2000-2009 start with 0; Pretoria postal codes start with 0; Delphi Currency and Java BigDecimal for money | Home Affairs ID format | 2026-09-26 |
| `#ranges` | The year-2038 problem (32-bit seconds since 1970) | Drop or reword after 2038 | 2026-09-26 |

### Lesson 24 - Storing data and managing files (`files`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#persistence` | A business must keep financial records for five years for SARS | SARS record-keeping rule | 2026-09-26 |
| `#filesFolders` | Cloud drives (OneDrive, Google Drive, iCloud Drive, Dropbox) show as folders and download files on demand | Products | 2026-09-26 |
| `#extensions` | Windows hides known extensions by default; View > Show > File name extensions in Windows 11 | Windows 11 menus | 2026-09-26 |
| `#fileTypes` | .heic for iPhone photos; .apk for Android apps; a .docx is a zip package (margin note) | Formats | 2026-09-26 |
| `#fileManagers` | Windows 11 File Explorer: command bar, Home, OneDrive, tabs (the `explorer-window` drawing); Files by Google, Samsung My Files, GNOME Files | Windows and phone updates | 2026-09-26 |
| `#manipulating` | Windows: drag on the same drive moves, to another drive copies; deletions from flash, memory card and network drives skip the Recycle Bin; cloud bins keep files about 30 days | Windows behaviour; cloud retention | 2026-09-26 |
| `#manipulating` | On an SSD, TRIM usually clears deleted files' space soon after emptying the bin, so recovery often fails (not guaranteed) | Still true of SSDs and phones? | 2026-09-27 |
| `#saveAs` | Microsoft 365 shows "Save a Copy" instead of Save As when AutoSave is on; Google Docs File > Download; PDF an open standard since 2008 | Office and Google menus | 2026-09-26 |
| `#fileSystems` | FAT32's 4 GB file limit; exFAT on flash drives and cards; APFS since 2017; a Mac reads NTFS but cannot write it without extra software | - | 2026-09-26 |
| `#programFiles` | SQLite, MySQL and PostgreSQL are free | Licences | 2026-09-26 |

### Lesson 29 - E-mail (`email`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatEmail` | Surveys of office workers find e-mail takes two hours or more of their day | Recent workplace surveys | 2026-09-26 |
| `#account` | Free independent accounts: Gmail (Google) and Outlook.com (Microsoft); Google accounts from age 13 in South Africa, younger children through a parent | Services still free; Google's age rules for South Africa | 2026-09-26 |
| `#account` | Passphrase and two-step verification advice | Current security advice | 2026-09-26 |
| `#addresses` | Gmail ignores dots in user names; capitals don't matter on almost every system; .co.za, .ac.za, .gov.za | Still true | 2026-09-26 |
| `#webmailApps` | E-mail apps: Outlook, Apple Mail, Thunderbird, the Gmail app; set up by signing in | Apps still current | 2026-09-26 |
| `#writing` | Gmail's Undo send (a few seconds) | Still offered | 2026-09-26 |
| `#attachments`, study, scenario | Message size limits about 20-25 MB (Gmail 25 MB; bigger files become a Google Drive link); Office blocks macros in downloaded files; VirusTotal | Providers' limits; Office macro policy | 2026-09-26 |
| `#replyForward` | Fact-checking sites Africa Check and Snopes | Still running | 2026-09-26 |
| `#spam` | Phishing examples (banks, SARS, couriers); banks never ask for an OTP by e-mail | Current South African scams | 2026-09-26 |
| Good to Know - Gmail | The Gmail steps: Create account on gmail.com; Compose top left (pencil bottom right in the app); Cc/Bcc at the end of the To line; paperclip; Send bottom left with Undo; Reply, Reply all, Forward under the message; filters from the search bar | Gmail's current layout | 2026-09-26 |
| Good to Know - protocols | Most accounts use IMAP | Still true | 2026-09-26 |
| IEB section `#iebTools` | Google Workspace (Calendar, Drive, Docs, Keep, Tasks) and Microsoft 365 (Outlook, OneDrive, OneNote, To Do, Planner, Teams); calendar sharing levels; viewer, commenter, editor; Suggesting and Track Changes | Product names and features | 2026-09-26 |

### Lesson 30 - Chat, instant messaging, VoIP and video (`chatvoip`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | A video call abroad costs a few rand of data | Data prices | 2026-09-26 |
| `#chatRooms` | Today's chat rooms: Discord, game chat, Twitch/YouTube Live chat; IRC still exists, mostly for programmers | Platforms still current | 2026-09-26 |
| `#sms`, study, `#im` table | An SMS costs about 50c on prepaid without a bundle; 160 characters; M-Pesa in Kenya; RCS where phones and networks support it | Network out-of-bundle rates (Vodacom, MTN); RCS in South Africa | 2026-09-26 |
| `#im` | WhatsApp is by far the most used IM app in South Africa; Telegram, Signal, iMessage, Messenger, Snapchat, WeChat; WhatsApp groups hold 1 024 people; communities, channels, status | Usage surveys; WhatsApp's limits and features | 2026-09-26 |
| `#encryption` | WhatsApp, Signal, iMessage and Messenger are end-to-end encrypted by default; Telegram only in secret chats; SMS not at all | Apps' encryption policies | 2026-09-26 |
| `#dataCosts`, reveal, study | A normal prepaid call about R1-R2 a minute out of bundle; a 1 GB bundle about R85-R150 (about 10c a MB); social bundles; zero-rated education and job sites | Network prices | 2026-09-26 |
| `#dataCosts`, `g30Data`, compare table | Data use: WhatsApp voice call about 0,5 MB a minute, video call about 5 MB a minute; a minute of voice note well under 1 MB | Current app data use | 2026-09-26 |
| `#voiceNotes` | Voice notes can be played faster and turned into text | App features | 2026-09-26 |
| `#voip` | Skype closed in 2025 (users moved to Teams); WhatsApp, FaceTime, Teams, Zoom, Google Meet, Signal make calls; South African landline numbers moving to VoIP as Telkom switches off copper | Apps; Telkom copper switch-off | 2026-09-26 |
| `#video`, identify | Teams, Zoom and Google Meet; features (breakout rooms, live captions, background blur, waiting rooms) | Products and features | 2026-09-26 |

### Lesson 31 - Social media, blogs, vlogs and podcasts (`socialmedia`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#platforms`, `m31Platforms`, study | What each platform is for: TikTok, Instagram (Reels, stories), YouTube (Shorts), Snapchat (map, streaks), X / Threads / Bluesky, Facebook (most South African users, mostly older), LinkedIn, Pinterest, Reddit; WhatsApp Channels | Platform features; South African usage surveys | 2026-09-26 |
| `#platforms` | Facebook Marketplace, Gumtree, Bob Shop (once bidorbuy); crowdfunding sites BackaBuddy, Thundafund, Kickstarter | Companies still trading, names | 2026-09-26 |
| `#microblogs`, `q31Microblog` | X allows 280 characters for most accounts (paying users more); Threads and Bluesky | X's limits; newer microblogs | 2026-09-26 |
| `#blogs` | WordPress.com and Blogger free; blogs as e-mail newsletters; streaming services Netflix, DStv Stream, Spotify, YouTube (Showmax closed on 30 April 2026) | Services still running | 2026-09-27 |
| `#vlogs` | YouTube shares advert money once a channel has enough subscribers and viewing hours | YouTube Partner Programme rules | 2026-09-26 |
| `#podcasts` | Podcasts played in Spotify, Apple Podcasts, YouTube; many filmed; South African radio shows as podcasts | Apps and practice | 2026-09-26 |
| `#wikis` | Wikipedia in hundreds of languages including Afrikaans and isiZulu; vandalism undone quickly | Still true | 2026-09-26 |
| `#privacy` | Australia's ban on social media accounts for under-16s (from December 2025); other countries debating it | Laws in Australia, South Africa and elsewhere | 2026-09-26 |
| `#privacy` | Minimum age 13 for TikTok, Instagram, Snapchat, X, Facebook, Discord; 16 for LinkedIn; Snapchat Ghost Mode | Platforms' age rules and settings | 2026-09-26 |
| `#influencers`, scenario | South African advertising rules require paid posts to be recognisable as adverts (#ad, #sponsored, "Paid partnership") | Advertising Regulatory Board code | 2026-09-26 |
| `#responsible` | Screen time tools: Digital Wellbeing (Android), Screen Time (iPhone) | Names of the settings | 2026-09-26 |
| Good to Know - RSS | Feedly: sign-up, Follow, folders, Today | Feedly still running; its layout | 2026-09-26 |

### Lesson 33 - The Internet (`internet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#howMuch` | About 6 billion people (three in four) online in 2025, 2.2 billion offline | ITU Facts and Figures (latest year) | 2026-09-26 |
| `#howMuch` | South Africa: about 52 million people online, roughly four in five, end of 2025 (DataReportal: 51.7 million, 79.6%) | DataReportal Digital (South Africa) | 2026-09-26 |
| `#howMuch` + reveal | Google: more than 5 trillion searches a year (about 158 000 a second) | Google's latest published figure | 2026-09-26 |
| `#howMuch` | Mobile networks carried about 146 EB a month at the end of 2025 (about 18 GB per person); about three quarters is video | Ericsson Mobility Report (November) | 2026-09-26 |
| `#howMuch` | Internet traffic grows by about a fifth a year (Cloudflare: 19% in 2025) | Cloudflare Radar Year in Review | 2026-09-26 |
| `#services` table, match | Streaming examples YouTube, Spotify, Netflix, DStv Stream (Showmax closed on 30 April 2026); the match uses Netflix | Services still running in South Africa | 2026-09-27 |
| `#connectingSa` + `sa-cables` drawing | Landing stations and cables: Yzerfontein (WACS, 2Africa), Duynefontein (ACE, 2Africa), Melkbosstrand (SAT-3, SAFE, Equiano), Gqeberha (2Africa), Amanzimtoti (METISS, 2Africa), Mtunzini (SEACOM, EASSy, SAFE) | submarinenetworks.com / TeleGeography cable map - new or retired cables | 2026-09-26 |
| `#connectingSa` | NAPAfrica (Teraco) one of the biggest exchange points in Africa; Netflix and Google keep copies of popular content in South Africa | Still true | 2026-09-26 |
| `#isps` | Mobile networks named: Vodacom, MTN, Cell C, Telkom, rain; fibre networks Vumatel, Openserve, Frogfoot; ISPs Afrihost, Webafrica, Vox, Cool Ideas | Names, mergers | 2026-09-26 |
| `#isps` | Most home fibre is uncapped with a fair use policy; mobile bundles expire; 1 Gbps home fibre common in cities | Package norms | 2026-09-26 |
| `#connections` | Telkom switching off copper (ADSL/VDSL) | Finished? Shorten the ADSL line when it is gone | 2026-09-26 |
| `#connections` | 5G in SA cities since 2020, "hundreds of Mbps"; 4G "tens of Mbps"; 2G/3G switch-off target end of 2027 | Speeds; the switch-off date | 2026-09-26 |
| `#connections` | Starlink: satellites about 500 km up (being lowered from about 550 to about 480 km during 2026); works in many African countries; not licensed in South Africa in 2026 | ICASA licensing; Starlink's height (agree with `media` and Grades 11-12) | 2026-09-27 |
| `#cloud` | SA cloud regions: Microsoft (Johannesburg and Cape Town, 2019), Amazon (Cape Town, 2020), Oracle (Johannesburg, 2022), Google (Johannesburg, 2024); Huawei also named | New regions | 2026-09-26 |
| `#cloud` | Netflix's apps on AWS, its videos from its own servers inside ISPs (Open Connect) | Still true | 2026-09-26 |
| GtK IaaS, PaaS and SaaS | AWS (2006) earns most of Amazon's profit but far less of its sales | Amazon annual report | 2026-09-26 |
| GtK net neutrality | Zero-rated WhatsApp and networks' own video apps in South Africa | Still offered? | 2026-09-26 |

### Lesson 34 - URLs, IP addresses and DNS (`urls`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| IPv6 block | About half of Google's users reach it over IPv6 in 2026 | Google IPv6 statistics | 2026-09-26 |
| reveal (IPv4) | The central pool of IPv4 addresses ran out in 2011 | Stable history | 2026-09-26 |
| `#domainNames` | ZADNA manages .za; the ZA Central Registry runs .co.za, .org.za, .net.za, .web.za and .africa, .joburg, .capetown, .durban; .school.za for schools | Registry arrangements | 2026-09-26 |
| `#domainNames` | More than 1.2 million .co.za names registered | ZACR's figures | 2026-09-26 |
| `#domainNames` | A .co.za name costs about R100 a year | Registrar prices | 2026-09-26 |
| `#domainNames` (margin) | voice.com sold for 30 million US dollars in 2019 (about R420 million then) | Stable history | 2026-09-26 |
| `#dns` | Public DNS servers: Google 8.8.8.8, Cloudflare 1.1.1.1 | Still running | 2026-09-26 |
| `#https` | Almost every website uses HTTPS; certificates are free; browsers mark HTTP pages "Not secure" | Browser wording | 2026-09-26 |

### Lesson 35 - The World Wide Web (`www`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#pagesSites` | Web hosting often costs less than R100 a month | Hosting prices | 2026-09-26 |
| `#earlyWeb` | info.cern.ch still online; CERN's line-mode browser simulation online; more than a billion websites, most never updated | Still online; Netcraft figure | 2026-09-26 |
| `#kindsOfSites` table | Examples: Takealot, Checkers Sixty60, Superbalist; TikTok, Instagram, LinkedIn; News24, Daily Maverick, Google News; gov.za; SARS eFiling; Home Affairs online booking of smart ID/passport appointments; Siyavula, Khan Academy; YouTube, Netflix, DStv Stream, Spotify (Showmax closed on 30 April 2026); Shutterstock, Pixabay, Wikimedia Commons | Names still current (Superbalist, DStv Stream) | 2026-09-27 |
| `#wikisBlogs` | Wikipedia in more than 300 languages, including Afrikaans, isiZulu and isiXhosa; blogging platforms WordPress, Blogger, Substack | Numbers, platforms | 2026-09-26 |
| `#webApps` | Microsoft 365 on the web (Word, Excel, PowerPoint in a browser); ChromeOS runs Android apps | Product names | 2026-09-26 |
| `#appification` | Uber, Mr D and banks push their apps; Checkers Sixty60 works only as an app | Sixty60 still app-only? | 2026-09-26 |

### Lesson 37 - Judging a website (`judgingsites`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#why` | Search results start with adverts marked "Sponsored" or "Ad"; TikTok, Instagram and YouTube feeds reward clicks; some sites are filled with AI-written articles | Search engines' labels; the apps pupils use | 2026-09-26 |
| `#fakeNews`, margin | The 2018 MIT study of Twitter: false news spread faster and further than true news, mostly by people | Still the study to cite (Twitter is now X) | 2026-09-26 |
| `#fakeNews` | Many apps label AI-made pictures and videos, but not all, and labels can be removed | Platform and legal labelling rules | 2026-09-26 |
| `#objectivity` | Influencers should mark paid posts (#ad, "Paid partnership"); fake and AI-written reviews | Platform labels; South African advertising rules | 2026-09-26 |
| `#currency` | The Internet Archive has saved hundreds of billions of pages since 1996; the Wayback Machine | Still running and free | 2026-09-26 |
| `#address` | Only government bodies get .gov.za; .ac.za for universities; Chrome shows a settings icon instead of the padlock (since 2023); almost every scam site has a padlock | ZADNA rules; browser address-bar icons | 2026-09-26 |
| `#crossCheck` | Africa Check (Johannesburg, since 2012), Real411, AFP Fact Check, Snopes; Google Lens, TinEye, Bing Visual Search; WhatsApp's "Forwarded many times" label | Still running, same names | 2026-09-26 |
| Good to Know - AI answers | Search engines show AI summaries; chatbots make up facts and sources | How AI search works now | 2026-09-26 |
| scenario (`w37AyeshaOld` marker note) | Site B last updated 2012 - "after 14 years" | Update the number of years | 2026-09-26 |

### Lesson 38 - Making web pages (`webpages`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#pageParts` | Image files usually .jpg, .png, .webp or .svg; video .mp4 or .webm; sound .mp3, .m4a or .ogg | Common web formats | 2026-09-26 |
| `#javascript` (Good to Know) | Google Docs, WhatsApp Web and online banking are mostly JavaScript; this site's marks come from a program on its server | Still true | 2026-09-26 |
| `#tools` | Visual Studio Code is free and used by most web developers; Adobe Dreamweaver "was the best known"; Wix, Squarespace, Google Sites; WordPress runs more than four in ten websites; AI site builders | Developer surveys; W3Techs' CMS share | 2026-09-26 |
| `#tools` | South African hosting companies xneelo and Afrihost; a builder's free address (thandiscakes.wixsite.com) | Company names; builders' free domains | 2026-09-26 |
| `#usability` (IEB section) | About one man in twelve is colour-blind | Stable figure | 2026-09-26 |
| `#usability` (IEB section) | Most South Africans reach the Web on a phone | Mobile share of South African web traffic (StatCounter) | 2026-09-26 |
| scenario | A website builder at R250 a month (R3 000 a year in the marker note) | Builders' South African prices | 2026-09-26 |

### Lesson 26 - Why networks (`whynetworks`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#disadvantages` | A home router often comes "free" (to use, while you pay for the line) from the ISP | Still how SA fibre and LTE ISPs supply routers | 2026-09-26 |
| `#disadvantages` | Today's bandwidth hogs: 100 GB game updates, 4K streaming, phones backing every video up to the cloud (doodle: a 140 GB game update) | Still the big users? | 2026-09-27 |
| `#whatIs` | Examples of shared devices: network storage, smart TVs; WhatsApp and TikTok as everyday network use | Still the apps pupils use | 2026-09-26 |

### Lesson 27 - Types of networks (`networktypes`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#control` | Phone-to-phone sharing is called AirDrop (Apple) and Quick Share (Android, Windows) | Names (Quick Share was Nearby Share until 2024) | 2026-09-26 |
| `#roles` | Minecraft's "Open to LAN" makes the host both server and client; schools use Microsoft 365 or Google Workspace accounts | Names still current | 2026-09-26 |
| `#access` (margin) | "123456" has been the most common password for years | NordPass (or similar) yearly list | 2026-09-26 |
| CAPS section (NOS) | Examples: Windows Server with Active Directory; Ubuntu Server and Red Hat Enterprise Linux | Product names | 2026-09-26 |
| Good to Know - peer-to-peer setup | Windows 11 paths: Settings > Network & internet > network properties > Private network; Advanced network settings > Advanced sharing settings (Network discovery, File and printer sharing); folder Properties > Sharing > Share...; Printers & scanners > Printer properties > Sharing | Paths in the current Windows version | 2026-09-26 |
| Good to Know - client-server setup | Windows 11 Pro/Education (not Home) join a domain: Settings > Accounts > Access work or school > Connect > Join this device to a local Active Directory domain; or Microsoft Entra ID; Chromebooks and Google Workspace | Paths and names (Entra ID was Azure AD until 2023) | 2026-09-26 |

### Lesson 28 - Communications media (`media`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#bandwidth` + reveal | Speed test at fast.com; typical latency 5-30 ms on fibre, over 500 ms through a high-orbit satellite | Site still up; typical figures | 2026-09-26 |
| `#copper` (margin) | Copper theft is one of the reasons Telkom is replacing copper with fibre | Telkom's copper switch-off news | 2026-09-26 |
| `#copper` | Ethernet categories: Cat 5e most homes and offices, Cat 6 new installations, Cat 6a businesses; the speed tip names Wi-Fi 5 or newer | Current cabling and Wi-Fi generations | 2026-09-26 |
| `#phoneLines` | Dial-up at 56 kb/s is "about a thousand times slower than a basic fibre line" (a basic line of about 50 Mb/s) | Entry-level SA fibre speed | 2026-09-26 |
| `#phoneLines` | ADSL gave about 10-20 Mb/s in SA; VDSL up to about 100 Mb/s; Telkom is switching off copper and moving customers to fibre, or to fixed LTE where there is no fibre | Telkom's copper migration - finished? | 2026-09-26 |
| `#fibre` | Fibre is spreading into townships and smaller towns; remote farms use 4G/5G, fixed wireless or satellite | Fibre roll-out news | 2026-09-26 |
| `#undersea` | About 99% of data between continents goes through undersea cables; a modern cable has about 16-24 fibre pairs and carries well over 100 Tb/s | TeleGeography | 2026-09-26 |
| `#undersea` | "About nine" cables land in SA: SAT-3/WASC (2002), SAFE (2002), SEACOM (2009), EASSy (2010), WACS (2012), ACE (to SA 2021), METISS (2021), Equiano (Google, 2022), 2Africa (Meta and partners, SA service 2025, about 45 000 km, the longest ever laid) | submarinenetworks.com / TeleGeography cable map - new or retired cables (SAT-3 is past 20 years old) | 2026-09-26 |
| `#undersea` (margin) | Antarctica is the only continent with no undersea cable | TeleGeography | 2026-09-26 |
| `#radio` | 4G (LTE) covers most of SA; 5G is spreading through the cities; 3G is being switched off (MTN by the end of 2026; Vodacom phased; no government deadline since July 2025) | ICASA State of the ICT Sector; operators' news | 2026-09-26 |
| `#radio` | Wi-Fi 6E and 7 add the 6 GHz band | Current Wi-Fi generations | 2026-09-26 |
| `#satellite`, `w28Latency` rubric, study, glossary (Low-orbit satellite) | Low-orbit satellites a few hundred kilometres up - Starlink's about 500 km (being lowered from about 550 to about 480 km during 2026; The Register, 2 January 2026); Starlink works in Mozambique and Botswana but was not licensed in SA in 2026 (the ownership rule; SpaceX had not applied by June 2026; the December 2025 policy on equity-equivalent investment programmes); using unlicensed equipment is illegal; in May 2026 ICASA said the equity-equivalent route needs a change to the law (lesson updated 27 Sep 2026) | ICASA and news - licensed yet? Starlink's height | 2026-09-27 |
| `#satellite` | Amazon Leo (formerly Project Kuiper) has a deal with Vodacom | Launched in SA? | 2026-09-26 |
| CAPS section (infrared) | Some phones have an infrared light to act as a remote | Still true of some Android phones | 2026-09-26 |

### Lesson 39 - Who runs the Web (`w3cicann`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#nobody` | ICASA regulates South Africa's networks; undersea cables owned by groups of phone and tech companies | Still true | 2026-09-26 |
| `#w3c` | The W3C is an independent non-profit since 2023; Berners-Lee no longer runs it; HTML is a WHATWG "living standard"; JavaScript's standard from Ecma International | W3C governance; who writes HTML | 2026-09-26 |
| `#ietf` | More than nine thousand RFCs | The latest RFC number | 2026-09-26 |
| `#icann` | ICANN in Los Angeles; 13 root servers run by 12 organisations, copies in more than a thousand places, several in South Africa; more than a thousand top-level domains; US oversight ended 2016 | root-servers.org; IANA's root zone | 2026-09-26 |
| `#rir` | Every region has all but run out of IPv4, Africa last; AFRINIC's troubles: court battle since 2020, frozen accounts, a receiver from 2023, the June 2025 election annulled (police investigating), a new board in September 2025, Mike Silber CEO from January 2027 | AFRINIC news - the story was still going on in 2026 | 2026-09-26 |
| `#za` | ZADNA looks after .za; examples woolworths.co.za, cansa.org.za, sars.gov.za, wits.ac.za; .joburg, .capetown, .durban, .africa exist; ZADNA settles disputes | ZADNA; the examples still work | 2026-09-26 |

### Grade 11 lesson 1 - The motherboard and data flow (`motherboard11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#mbParts`, study | Intel calls the chipset the PCH; the northbridge's job has moved into the CPU | Still how current Intel and AMD boards are built | 2026-09-27 |
| `#mbParts` | A 16 GB laptop with integrated graphics may show about 14 GB available | Typical graphics memory reserved from RAM | 2026-09-27 |
| `#buses`, study | The CPU has its own links to the RAM, the graphics card (PCIe x16) and one M.2 NVMe SSD (x4); everything else goes through the chipset | Current desktop platform layouts | 2026-09-27 |
| `#cards` | Sound, network, Wi-Fi, Bluetooth and USB are onboard on most boards; laptops have no expansion slots | Still true | 2026-09-27 |
| `#modular` | Desktop and laptop RAM sticks differ in size (desktops take DDR5 sticks); most Windows laptops still take a replaceable M.2 SSD, and some have RAM slots; many thin ones have soldered RAM | Current laptop designs | 2026-09-27 |
| `#modular` (margin) | The Fairphone lets users replace its battery, screen, cameras and charging port | Still sold, still modular | 2026-09-27 |
| `#dataFlow` | Apple's M-series chips use unified memory | Still true of Apple's chips | 2026-09-27 |
| `#dataFlow` (margin) | A 4K screen at 60 frames a second: about 500 million pixels a second | Arithmetic - only if screens change | 2026-09-27 |

### Grade 11 lesson 2 - The clock and the buses (`busesclock`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#clock`, reveal | Processors have a base and a boost speed; Task Manager shows Speed and Base speed; Macs do not show the clock speed | Current CPUs, Task Manager and Activity Monitor | 2026-09-27 |
| `#clockTricks`, study | The base clock is about 100 MHz; unlocked CPUs are Intel's K models and most AMD Ryzen desktop CPUs; RAM uses XMP/EXPO profiles | Current Intel and AMD platforms | 2026-09-27 |
| `#clockTricks` (margin) | Overclockers cool with liquid nitrogen (about -196 °C); the records past 9 GHz used liquid helium (about -269 °C) | The current record | 2026-09-27 |
| `#busWidth` | Real 64-bit CPUs use fewer than 64 address lines | Still true | 2026-09-27 |
| `#busWidth` reveal, scenario | DDR5-6000: 64-bit channels, 48 GB/s each; two channels usual | Current RAM (DDR5 or DDR6) | 2026-09-27 |
| `#externalBuses`, study | PCIe about 2 GB/s per lane (4.0) and 4 GB/s (5.0); a PCIe 4.0 x4 NVMe SSD about 7 000 MB/s; SATA 6 Gb/s, about 550 MB/s; USB 2 about 40 MB/s, 5 Gb/s about 450 MB/s, 10 Gb/s about 1 000 MB/s; USB up to 80 Gb/s (USB4 version 2) | Current PCIe generation in PCs, SSD and USB speeds | 2026-09-27 |
| `#systemBus` (margin) | A modern CPU has well over a thousand contacts | Still true | 2026-09-27 |

### Grade 11 lesson 3 - Memory and caching (`caching`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#memSystem` figure, reveal, study | Typical sizes and times: registers a few hundred bytes, under 1 ns; cache KB to a few hundred MB, 1-15 ns; RAM 8-64 GB, about 80 ns; SSD 256 GB-4 TB, about 0.05 ms; hard drive 1-30 TB, about 10 ms; cloud 20-200 ms | Current typical PCs and drives | 2026-09-27 |
| `#cpuCache`, study | L1 tens of KB per core, L2 up to a few MB, L3 about 8 to over 100 MB shared; hit rates over 90%; 64-byte cache lines | Current CPUs | 2026-09-27 |
| `#cpuCache` (margin) | Some AMD gaming processors (X3D) stack an extra layer of cache onto the processor chip, for about 96 MB of L3 | Current AMD X3D models (the newest put the extra cache under the chip) | 2026-09-27 |
| `#sramDram` | DRAM is refreshed at least every 64 ms; SRAM about six transistors a bit | Still true | 2026-09-27 |
| `#diskCache` | Task Manager shows "Cached" memory; Windows turns write caching off for flash drives (quick removal); hard drives have 64-512 MB of cache; SSDs slow down when their fast cache fills | Current Windows and drives | 2026-09-27 |
| `#diskCache` | Hybrid drives (SSHDs) are rare now that SSDs are cheap (as Grade 10 `storage` says) | Still true | 2026-09-27 |
| `#webCache`, study | Most websites use HTTPS, which limits proxy caching; CDN copies of videos are served from Johannesburg or Cape Town | Still true | 2026-09-27 |
| `#webCache` | Hard refresh: Ctrl+F5 / Ctrl+Shift+R, Cmd+Shift+R on a Mac; "Cached images and files" in the browser's settings | Current browsers | 2026-09-27 |
| Good to Know | Android: Clear cache / Clear storage; iPhone: iPhone Storage, Offload App | Current Android and iOS | 2026-09-27 |

### Grade 11 lesson 4 - Doing many things at once (`multitasking`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#multitasking` | Mobile operating systems pause background apps and close them when they need the RAM | Still how Android and iOS behave | 2026-09-27 |
| `#multithreading`, reveal | A typical Windows PC runs about 200-300 processes and several thousand threads; Task Manager shows Processes and Threads; Activity Monitor has a Threads column | Current Windows and macOS | 2026-09-27 |
| `#multithreading` | Chrome runs each website in its own process | Still true of Chrome | 2026-09-27 |
| `#multiprocessing`, study | Phones have 8 cores; servers have several chips with dozens of cores each; phones and laptops mix performance and efficiency cores | Current phones, PCs and servers | 2026-09-27 |
| `#hyperThreading`, study | Hyper-threading gains about 15-30%; Apple's M-series and most phone chips leave it out; Intel's laptop and desktop chips have had none since 2024 (Core Ultra 200 and later), to save power and chip space - Intel says it will bring it back | Whether newer Intel and AMD chips have it | 2026-09-27 |
| scenario | TikTok Live streaming; 6-core and 12-core desktop processors with 32 and 64 MB of L3 | Still typical | 2026-09-27 |

### Grade 11 lesson 7 - Operating systems compared (`oscompared`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#osCost` | A Windows 11 Home licence on its own costs roughly R2 200 to R3 300; Pro costs more | SA prices (Microsoft Store South Africa, Takealot, Wootware) | 2026-09-27 |
| `#osCost`, study | Windows Server Standard is priced per core - about R20 000 for 16 cores - plus a client access licence per user or device | Microsoft's Windows Server pricing, in rand | 2026-09-27 |
| `#osCost` | Red Hat Enterprise Linux and Ubuntu Pro are sold as support subscriptions | Still sold that way | 2026-09-27 |
| `#osCost`, `#osHardware`, study, rubric | Windows 10 support ended on 14 October 2025; home users' extended security updates run to 12 October 2027 (extended in June 2026; businesses can pay to October 2028) | Microsoft lifecycle; whether extended updates are still offered | 2026-09-27 |
| `#osCost` | Samsung and Google promise seven years of updates for their top phones; cheaper phones get fewer | Makers' current update promises | 2026-09-27 |
| `#osSize`, study | FreeRTOS core about 10 KB; a router's Linux about 16 MB; a phone OS 10 to 20 GB; Ubuntu 4 GB RAM and 25 GB; Mint and Lubuntu 2 GB RAM; Windows 11 4 GB RAM and 64 GB, about 30 GB installed; Android Go for cheap phones | Current system requirements | 2026-09-27 |
| `#osHardware`, study | Windows 11 needs a processor on Microsoft's list (Intel 8th generation or AMD Ryzen 2000 and newer), TPM 2.0, UEFI with Secure Boot | Microsoft's requirements; any newer Windows | 2026-09-27 |
| `#osHardware` | macOS 26 (2025) is the last macOS for Intel Macs | Apple | 2026-09-27 |
| `#osHardware`, `#osChoosing` | ChromeOS Flex is free and needs 4 GB RAM; Chromebooks get up to ten years of updates | Google | 2026-09-27 |
| `#osHardware` | Android phones cost from under R1 000 | SA prices | 2026-09-27 |
| `#osPlatform` | Windows runs on Arm laptops too, common since 2024; Macs, phones and tablets use Arm | Processor market | 2026-09-27 |
| `#osPlatform` | The Delphi IDE runs on Windows; most PC games are made for Windows; the Steam Deck runs SteamOS (Linux) with Proton | Still true | 2026-09-27 |
| `#osPlatform` | About seven in ten desktops and laptops run Windows; about seven in ten phones worldwide, and about three in four in South Africa (StatCounter, August 2026), run Android | StatCounter (world and South Africa) - recheck the desktop share in January | 2026-09-27 |
| `#osChoosing` | VxWorks runs NASA's Mars rovers; QNX runs systems in hundreds of millions of cars | Still true | 2026-09-27 |
| Good to Know | Google is combining ChromeOS and Android; iPads open apps in windows; WSL; Macs run iPhone apps | What Google, Apple and Microsoft have done since | 2026-09-27 |

### Grade 11 lesson 8 - Virtual memory (`virtualmemory`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#ramFull` | A laptop has 8 or 16 GB of RAM and 256 GB or more of storage | Typical new laptops | 2026-09-27 |
| `#whatIs` | Windows' page file is pagefile.sys and Windows sizes it itself; Linux and macOS call it swap | Still so | 2026-09-27 |
| `#howWorks` (reveal) | Task Manager shows In use and Committed under Performance, Memory; Activity Monitor shows Swap Used | Current Windows and macOS screens | 2026-09-27 |
| `#speed`, study | RAM about 100 ns; NVMe SSD about 0.1 ms; hard drive about 10 ms (SSD about 1 000 times, HDD about 100 000 times slower) | Typical access times | 2026-09-27 |
| `#paging` | Pages are usually 4 KB | Page sizes in current OSs (Apple silicon uses 16 KB) | 2026-09-27 |
| `#phones`, study | Phones compress memory and close background apps; Android makers sell "RAM Plus", "extended RAM", "virtual RAM" (8 GB + 8 GB) | Current phone marketing | 2026-09-27 |
| Good to Know | Windows and macOS compress memory before paging it out; Linux has zram | Still so | 2026-09-27 |

### Grade 11 lesson 9 - Virtualisation and virtual machines (`virtualisation`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatIs` | Windows runs Linux in a small VM (WSL); Android Studio tests apps on a virtual phone | Still so | 2026-09-27 |
| `#hypervisors`, study | Type 1: Hyper-V, VMware ESXi, KVM, Proxmox; type 2: VirtualBox and VMware Workstation (both free - Workstation since November 2024), Parallels Desktop | Products still current and named so (VMware under Broadcom) | 2026-09-27 |
| `#hypervisors` | Intel VT-x and AMD-V, switched on in the UEFI settings | Still so | 2026-09-27 |
| `#uses` | Windows Pro has Windows Sandbox built in | Still in Windows | 2026-09-27 |
| `#uses` | Amazon Web Services, Microsoft Azure and Google Cloud all have data centres in South Africa | Cloud regions in SA | 2026-09-27 |
| Good to Know | Docker is the best-known container tool | Still so | 2026-09-27 |

### Grade 11 lesson 10 - Compilers, interpreters and assemblers (`translators`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#levels` | Examples of high-level languages: Delphi, Java, Python, C#, JavaScript | Still the common ones | 2026-09-27 |
| `#compilers` | Delphi: F9 compiles and runs; Project1.exe appears in a Win32\Debug folder inside the project's folder | Current Delphi | 2026-09-27 |
| `#interpreters`, study | Python is usually interpreted; JavaScript in browsers (with JIT) | Still so | 2026-09-27 |
| `#bytecode` | C# works like Java (intermediate code and a runtime); Python compiles to its own bytecode before interpreting | Still so | 2026-09-27 |
| `#whyTranslate` | IDE examples: Delphi, NetBeans, IntelliJ | The IDEs schools use | 2026-09-27 |
| Identify | Delphi's 32-bit Windows compiler is dcc32; message format "[dcc32 Error] Unit1.pas(34): E2003 ..." | Current Delphi (and whether schools compile for Win64) | 2026-09-27 |

### Grade 11 lesson 11 - Numbers in a fixed number of bits (`fixedbits`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#wordSize`, study | Today's PCs, laptops and phones have 64-bit processors; the classic Arduino Uno (R3) is 8-bit (the Uno R4, 2023, is 32-bit) | Still so | 2026-09-27 |
| `#overflow` | Java wraps silently (Math.addExact throws); Delphi wraps unless {$Q+} | Current Java and Delphi | 2026-09-27 |
| `#overflow` | Old embedded devices may still use 32-bit time before 2038 | Progress on the 2038 problem | 2026-09-27 |
| `#applied` | The central pool of IPv4 addresses ran out in 2011; homes share one public address through the router | Still so; IPv6 take-up | 2026-09-27 |
| `#applied` | HDR screens use 10 bits per colour (30-bit colour) | Current screens | 2026-09-27 |

### Grade 11 lesson 29 - Arrays, searching and sorting on paper (`arraystheory`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#arrays` | Delphi 11 and later switch range checking on in a new project's Debug build (older versions and Release builds read past the array with no error) | Current Delphi defaults | 2026-09-27 |
| `#onPaper` | CAPS papers show Delphi code rather than pseudocode since November 2017; IEB papers still use pseudocode, and IEB memos take marks off for code where pseudocode is asked | New papers and memos of both boards | 2026-09-27 |
| `#aggregates` | A real division by 0 gives INF or NaN, with no error, in Delphi 12 (floating-point exceptions masked) as in Java | Current Delphi | 2026-09-27 |

### Grade 11 lesson 30 - Classes, objects and class diagrams (`classes11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#classDiagrams` | CAPS papers draw diagrams in Delphi's words (TPlayer, fName, `+ <<constructor>> Create(...)` or, in 2025-2026, `+ constructor Create(...)`); IEB memos 2016-2021 mix type-first and name : type and write the constructor `+ Constructor(...)` or with the class name; the lesson shows Player both ways | Each new CAPS and IEB memo | 2026-09-27 |

### Grade 11 lesson 31 - Text files (`textfiles`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#fileNames` | Delphi (since XE2) builds the .exe in Win32\Debug, so a file with no path must sit there, not in the project folder | Current Delphi | 2026-09-27 |

### Grade 11 lesson 32 - Methods and parameters (`methods11`)

none

### Grade 11 lesson 33 - Validation and testing (`testing11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Debugging | F5 sets a breakpoint in Delphi; F8 steps over and F7 steps into in Delphi, NetBeans and IntelliJ | The current versions' default keyboard shortcuts | 2026-09-26 |
| `#testData` | The CAPS PAT guidelines (2026) call the kinds of test data "typical, erroneous and boundary" | The newest PAT guidelines | 2026-09-27 |
| `#errorTypes` | Delphi 12 masks floating-point exceptions: a real division by 0 gives INF or NaN (as Java's double does); DIV by 0 still raises EDivByZero, so the error-kinds row uses DIV | Current Delphi | 2026-09-27 |

### Grade 11 lesson 34 - Designing a good interface (`guidesign`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Accessibility (margin) | About one man in 12 of European descent is colour-blind (mostly red-green), and about one black South African boy in 24 (4.2% in a Durban schools study - Mashige and Van Staden, BMC Research Notes, 2019) | Still the usual estimates | 2026-09-27 |
| Choosing the right component | Java: JavaFX has a DatePicker; Swing has none (a JSpinner with dates is used); JavaFX windows are Stages (show / showAndWait) | Still true of the current JDK and JavaFX | 2026-09-27 |

### Grade 12 lesson 18 - Privacy, rights and the law (`privacylaw`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Available is not the same as allowed | Experian leak, 2020: a fraudster posing as a client got data on about 24 million South Africans and almost 800 000 businesses | Stable history - keep unless a bigger or newer SA example is better | 2026-09-26 |
| Right to know vs privacy | Matric results: 2022 court case, published by exam number only; the Regulator's R5 million fine on the DBE (December 2024) and its enforcement notice set aside by the High Court (full bench) on 12 December 2025; leave to appeal refused 3 June 2026; the Regulator then petitioned the SCA (July-August 2026); results still published by exam number | The SCA's answer, or a change in how results are published | 2026-09-27 |
| Right to know vs privacy | RICA: every SIM registered; interception needs a judge; Constitutional Court (amaBhungane, 2021) found it did not protect privacy enough and ordered Parliament to fix it | Whether the RICA Amendment has been passed; update the wording if so | 2026-09-26 |
| POPIA | POPIA signed 2013; most of it in force 1 July 2020; compliance by 1 July 2021 | Stable | 2026-09-26 |
| POPIA | Direct marketing by SMS, e-mail, WhatsApp or phone call (the Regulator's Guidance Note on Direct Marketing, December 2024, counts ordinary sales calls) needs opt-in (except existing customers), with an opt-out in every message | Amendments or Regulator guidance; the NCC's national opt-out registry (CPA regulations of 15 April 2026) | 2026-09-27 |
| Regulator | Fines up to R10 million; serious offences up to 10 years in prison; first fine R5 million, Department of Justice, July 2023 (ransomware in 2021, antivirus and intrusion-detection licences lapsed) | New fines or changed limits | 2026-09-26 |
| Cookies | Safari and Firefox block third-party cookies by default; Chrome still allows them by default after Google dropped its phase-out (July 2024 / April 2025) | Browser defaults change often | 2026-09-26 |
| Anonymity | #GuptaLeaks (2017) came from whistle-blowers who stayed anonymous for years | Stable history | 2026-09-26 |
| GUIDs (CAPS) | Melissa virus (1999) author traced partly by the GUID in Word documents; Pentium III serial number (1999) dropped after protests; iPhone apps must ask before tracking since 2021 | Stable history; check the advertising-ID settings wording | 2026-09-26 |
| Sharing files, films and music | Streaming services named: Netflix, Spotify, YouTube Music (Showmax dropped - it closed on 30 April 2026) | Services still available in South Africa | 2026-09-27 |
| Cyberbullying | Childline South Africa: 116, free, 24 hours | Number and hours | 2026-09-26 |
| IEB laws | ECT Act 2002 (cooling-off usually 7 days, spam opt-out, take-down); Sexual Offences Act 2007; Protection from Harassment Act 2011, in force 27 April 2013 (a child may apply without a parent; court can order a provider to reveal an anonymous harasser) | Amendments | 2026-09-26 |
| Good to Know | Cybercrimes Act 19 of 2020, most of it in force 1 December 2021; intimate-image offence up to three years | Remaining sections' commencement | 2026-09-26 |
| Digital heritage | Google deletes personal accounts inactive for two years; tools: Inactive Account Manager, Apple Legacy Contact, Facebook/Instagram memorialisation and legacy contacts | Company policies change (recheck Instagram's legacy contacts) | 2026-09-26 |
| Digital heritage | South Africa has no law written specifically for digital assets | Any new law or court ruling | 2026-09-26 |

### Grade 12 lesson 19 - Computers and the big problems (`bigproblems`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Pooling computing power | SETI@home 1999-2020; Folding@home passed an exaflop with about a million volunteers' computers in March-April 2020; CERN's grid spans more than 40 countries | Stable history; CERN grid size | 2026-09-27 |
| Earthquakes | Early-warning systems in Japan, Mexico and the US west coast; Android phones form one; Council for Geoscience runs SA's sensor network | New systems | 2026-09-27 |
| Tsunamis | 2004 Indian Ocean tsunami: about 230 000 dead in more than ten countries; warning system since | Stable | 2026-09-27 |
| Storms and floods | SAWS impact-based colour-coded warnings; AI weather models since 2023; April 2022 KZN floods killed more than 400 people; CSIR's Advanced Fire Information System | SAWS warning scheme; AI models now in operational use | 2026-09-27 |
| Health | Beta found late 2020; Omicron reported to the WHO on 24 November 2021 by NGS-SA; AlphaFold, Nobel Prize in Chemistry 2024, about 200 million protein structures | Stable history | 2026-09-27 |
| Crime | SABRIC; number-plate camera networks in Johannesburg suburbs; Bell Pottinger campaign 2016-2017, firm collapsed 2017 | Stable history | 2026-09-27 |
| Big data | SKA: nearly 200 dishes near Carnarvon (133 SKA-Mid + 64 MeerKAT), more than 130 000 antennas in Australia, 700+ PB archived a year, supercomputers in Cape Town and Perth; MeerKAT working since 2018 | SKA construction progress, first science | 2026-09-27 |
| Big data | Census 2022: first digital census; about 31% undercount | Stats SA's next census or corrections | 2026-09-27 |
| Society | July 2021 unrest; Cape Town Day Zero 2017-2018 (water map, dam levels) | Stable history | 2026-09-27 |
| Errors | Therac-25 (1985-1987, six accidents, at least three deaths); 737 MAX (346 died, grounded about 20 months); Uber 2018; Kabul drone strike 2021 (ten civilians); CrowdStrike July 2024 (about 8.5 million computers) | Stable history; add a newer case if one fits better | 2026-09-27 |
| IoT | Mirai 2016; Jeep hack 2015 (1.4 million recalled); Strava heat map 2018; UK ban on default passwords since 2024; EU security rules for connected products | New laws (EU Cyber Resilience Act dates) | 2026-09-27 |

### Grade 12 lesson 20 - Social networking and its effects (`socialnetworking`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | About 29 million South Africans use social media; South Africans spend more than nine hours a day online (DataReportal Digital 2026: 29.1 million in October 2025; 9 h 27 min) | New DataReportal report each year | 2026-09-27 |
| How it grew (CAPS) | SixDegrees 1997; MySpace, LinkedIn 2003; Facebook 2004; YouTube 2005; Twitter 2006, renamed X 2023; WhatsApp 2009; Instagram 2010; Snapchat 2011; TikTok worldwide 2017-2018; MXit (Stellenbosch) closed 2016 | Add a new platform if one becomes big among pupils | 2026-09-27 |
| Benefits and risks | Australia banned social media accounts for under-16s from 10 December 2025 | Other countries' age rules; South African proposals (in September 2026 South Africa said it has no plan for an under-16 ban) | 2026-09-27 |
| Findable | Ordinary WhatsApp groups show every member's phone number to all members; WhatsApp usernames (rolled out in waves from April 2026) let people hide it once they set one | How far usernames have rolled out | 2026-09-27 |
| Social engineering | WhatsApp code-theft and "Hi Mom" scams common in South Africa; two-step verification protects | Current common scams | 2026-09-27 |
| Effects | #FeesMustFall 2015-2016; #AmINext 2019; July 2021 unrest; iNaturalist city challenge | Stable history | 2026-09-27 |
| Global culture | Jerusalema dance challenge 2020; amapiano; Tyla's "Water" (2023), first Grammy for Best African Music Performance (2024) | Swap for a newer South African example if one is bigger | 2026-09-27 |
| Wikis | Wikipedia (2001): millions of English articles, editions in more than 300 languages, Afrikaans among them; first wiki 1995 | Stable | 2026-09-27 |

### Lesson 36 - Browsing and searching (`searching`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#browsers` | Chrome about two in three pages viewed worldwide; Safari second; Edge comes with Windows; Firefox non-profit and open source; Samsung Internet, Opera, Brave | StatCounter | 2026-09-26 |
| `#browsers` | Edge, Opera, Brave and Samsung Internet built on Chromium; Safari and Firefox have their own engines | Still true | 2026-09-26 |
| `#browserTools` | Ctrl+H history, Ctrl+J downloads; Edge calls bookmarks favourites | Shortcuts and names | 2026-09-26 |
| `#privateBrowsing` (margin) | Google's 2024 settlement to delete Incognito browsing records (USA) | Stable history | 2026-09-26 |
| `#extras` | Flash switched off at the end of 2020; Jobs' "Thoughts on Flash" (2010) | Stable history | 2026-09-26 |
| `#searchEngines` | Google about nine in ten searches worldwide; Bing supplies Yahoo's and much of DuckDuckGo's results; Ecosia plants trees; Brave Search; voice assistants Siri, Gemini, Alexa | StatCounter; partnerships; assistant names | 2026-09-26 |
| `#aiAnswers` | AI Overviews in South Africa since 2024, now also in Afrikaans, isiZulu, Sesotho and Setswana; AI Mode (2025); Copilot in Bing; ChatGPT and Gemini search the Web | Product names, languages | 2026-09-26 |
| `#aiAnswers` (margin) | The "glue on pizza" AI Overview, May 2024 | Stable history | 2026-09-26 |
| `#techniques` | Operators that work: " ", -, site:, filetype:, OR; image search "Usage rights - Creative Commons licences" | Google's "Refine searches" help page | 2026-09-26 |
| GtK more search tricks | before:/after: work; the number range (..) and wildcard (*) unreliable; related: and cache: removed; Google Lens, Bing Visual Search, hum to search | Google's help page | 2026-09-26 |
| `#boolean` | Bing accepts AND, OR, NOT in capitals; Google: space = AND, OR, minus | Still true | 2026-09-26 |

### Grade 11 lesson 12 - When data goes wrong (`dataerrors`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#sources` | Some computers in South Africa use a decimal comma, others a point; SA writes dates day/month/year | Windows' South African regional settings | 2026-09-27 |
| `#verifyValidate` | Banks check ID numbers against the Department of Home Affairs; one-time PINs by SMS | Still how SA banks verify | 2026-09-27 |
| `#inputTech` | RFID toll tags and access cards; OCR of ID documents and number plates | Still in use | 2026-09-27 |
| `#checkDigit`, study | SA ID number layout: YYMMDD, SSSS (0000-4999 female, 5000-9999 male), C (0 citizen, 1 permanent resident), A (usually 8), Z (Luhn check digit) | Home Affairs has discussed changing the ID number (the gender digits); check the format is unchanged | 2026-09-27 |
| `#parity` | Ethernet frames end with a CRC; download pages show SHA-256 hashes | Still so | 2026-09-27 |
| Good to Know | A QR code can be read with up to about 30% damaged | QR error-correction levels | 2026-09-27 |

### Grade 11 lesson 14 - Network hardware and topologies (`networkhardware`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#bounded`, study | UTP: 100 m; Cat 5e and Cat 6 carry 1 Gbps, Cat 6a 10 Gbps | Still the cable categories sold and installed | 2026-09-27 |
| `#unbounded`, study | Starlink's satellites fly about 500 km up (being lowered from about 550 to about 480 km during 2026); geostationary 36 000 km | Starlink still the example of low-orbit Internet; its height | 2026-09-27 |
| `#limits` (margin) | Telkom is replacing its copper lines; thieves sometimes cut fibre thinking it is copper | Copper switch-off still under way | 2026-09-27 |
| `#limits` (reveal) | 20 TB hard drives | Largest common drive size (the sum still works) | 2026-09-27 |
| `#devices` | Hubs are no longer sold | Still true | 2026-09-27 |
| `#wlan` | Wi-Fi 5, 6, 6E and now Wi-Fi 7; bands 2.4, 5 and 6 GHz; WPA2/WPA3 | Newest Wi-Fi generation and security standard | 2026-09-27 |
| `#compare` | Home Internet packages often 25 to 100 Mbps; LANs 1 Gbps per desk, 10 Gbps backbone | Typical South African packages and LAN speeds | 2026-09-27 |
| `#compare` (margin) | The WACS cable lands at Yzerfontein and is about 14 500 km long | Stable fact | 2026-09-27 |

### Grade 11 lesson 15 - Addresses, packets and frames (`addressing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#ipv6` | Over 8 billion people; the central IPv4 pool ran out in 2011; AFRINIC was the last registry to run low | Population figure | 2026-09-27 |
| `#ipv6` | Roughly half of Google's users reach it over IPv6 (passed 50% in March 2026) | Google's IPv6 statistics page | 2026-09-27 |
| `#mac` (margin) | Phones show each Wi-Fi network a random (private) MAC address | Still the default on Android and iPhone | 2026-09-27 |
| `#helpers` | Public DNS servers: Google 8.8.8.8, Cloudflare 1.1.1.1; home DHCP leases often a day | Still offered | 2026-09-27 |

### Grade 11 lesson 16 - Protocols and wide area networks (`protocolswan`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#udp` (IEB) | Many big websites and apps (Google and YouTube among them) send pages over HTTP/3, which runs on UDP (QUIC) - a note beside the exam's TCP/UDP table | HTTP/3's spread | 2026-09-27 |
| `#web` | Nearly every website uses HTTPS; browsers mark plain HTTP "Not secure"; TLS is often still called SSL | Still true | 2026-09-27 |
| `#email` | Almost everyone keeps mail on the server; mail apps use IMAP; webmail and Gmail's and Outlook's own apps use HTTPS; mail servers use SMTP between them | Still true | 2026-09-27 |
| `#files` | Most people never use FTP today | Still true | 2026-09-27 |
| `#webdav` (IEB) | Windows can still map a WebDAV folder as a network drive, though Microsoft deprecated that client in 2023 and may remove it; a Mac connects in the Finder | Whether Windows still has its WebDAV client | 2026-09-27 |
| `#voip` (margin) | Microsoft switched Skype off in May 2025 and moved its users to Teams | Historical | 2026-09-27 |
| `#wan` | WAN links rented from Openserve, Liquid, Dark Fibre Africa and the mobile networks | Company names still current | 2026-09-27 |
| `#wanLinks` | Starlink about 500 km up (being lowered from about 550 to about 480 km during 2026); geostationary 36 000 km, delay over half a second | Still the example; Starlink's height | 2026-09-27 |
| `#connections` | 5G still mostly in cities; South Africa's networks switching off 3G; next: 5G Advanced, satellites straight to phones, 6G around 2030 | Coverage and switch-off progress | 2026-09-27 |
| `#connections` | ADSL up to about 20 Mbps in practice (VDSL about 100); fibre packages from 10 Mbps to 1 Gbps and more; Telkom switching off copper | Current packages | 2026-09-27 |
| `#usage` | Data per activity: voice call under 1 MB a minute; video call 0.5-1.5 GB an hour; HD streaming about 3 GB an hour (about 5 Mbps); 4K about 7 GB an hour (15-25 Mbps); a game under 100 MB an hour; game downloads 50-150 GB | Streaming services' published figures | 2026-09-27 |

### Grade 11 lesson 17 - Mobile and wireless communication (`mobilewireless`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | For most South Africans the phone is their main computer; many never use a desktop | Still true | 2026-09-27 |
| `#devices` | A 2 GB app on a 64 GB phone; slow 3G at a taxi rank, 5G in Sandton | Phone storage sizes; 3G switch-off - reword "slow 3G" once 3G is gone (likely by January 2027) | 2026-09-27 |
| `#appBrowser` | Chrome, Safari; Play Store, App Store | Still the main ones | 2026-09-27 |
| `#wireless` | About 30 GPS satellites, run by the US Space Force; Galileo, GLONASS, BeiDou | Still true | 2026-09-27 |
| `#wireless` | Generations: SA's first cellular networks 1994; 3G being switched off (MTN aims to finish by the end of 2026; no national deadline); 5G in South Africa since 2019 and 2020; 6G expected around 2030 | 3G/2G switch-off progress; 6G timing | 2026-09-27 |
| `#speed` | "Uncapped" LTE/5G packages have fair usage policies (example limit 500 GB); many SA fibre packages are uncapped, unshaped and unthrottled | Current ISP practice | 2026-09-27 |
| `#ecomm` | Microblogs X, Threads, Bluesky; IM WhatsApp, Telegram, Signal; video conferencing Teams, Zoom, Google Meet; SMS 160 characters | Names still current | 2026-09-27 |
| `#voip` | Telkom switching off copper, landline numbers moving to VoIP; WhatsApp encrypts calls end to end | Still true | 2026-09-27 |
| `#voip` (margin) | 112 is free from any cellphone in South Africa | Still true | 2026-09-27 |

### Grade 11 lesson 18 - Virtual private networks (`vpn`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#tunnel` | Best-known VPN protocols: WireGuard, OpenVPN, IPsec; PPTP (1999) broken | Still the main ones | 2026-09-27 |
| `#uses` | Remote access normal since the 2020 lockdown; many still work from home part of the week | Still true | 2026-09-27 |
| `#uses` | Almost every website and app uses HTTPS, so a VPN on public Wi-Fi mainly hides which sites you use | Still true | 2026-09-27 |
| `#free` | Hola sold free users' bandwidth (2015); a 2016 study of Android VPN apps found malware signs and missing encryption | Historical | 2026-09-27 |
| `#legal` | VPNs are legal in South Africa; the Cybercrimes Act of 2020; China and Russia allow only approved VPNs or block most | Any change in SA law; country examples | 2026-09-27 |

### Grade 12 lesson 21 - Green computing (`green12`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Life cycle | About three-quarters or more of a smartphone's carbon footprint is in mining, making and shipping (makers' own product reports) | Latest Apple/Samsung/Fairphone product environmental reports | 2026-09-26 |
| Mining | Most of the world's platinum is South African; South Africa the biggest manganese producer; much cobalt from the DRC, some by hand and by children | USGS mineral summaries | 2026-09-26 |
| Energy | Data centres about 1.5% of world electricity (415 TWh) in 2024; more than double (about 945 TWh) by 2030; growing about four times faster than all electricity use (IEA, Energy and AI, April 2025) | New IEA figures (the April 2026 update - 485 TWh in 2025, about 950 TWh by 2030 - agrees) | 2026-09-27 |
| Energy | Most South African electricity from coal | CSIR / Eskom yearly statistics | 2026-09-26 |
| Energy | PUE: big cloud data centres about 1.1; typical company about 1.6; old small server rooms 2.0 or worse | Uptime Institute survey averages | 2026-09-26 |
| Energy | Google (August 2025): median Gemini text prompt 0.24 Wh and about 0.26 mL of water | Newer company figures | 2026-09-26 |
| Energy | Bitcoin uses more electricity than many countries; Ethereum moved to proof of stake in 2022 | Cambridge Bitcoin Electricity Consumption Index | 2026-09-26 |
| Water | A big data centre can use millions of litres a day; Cape Town's 2018 near Day Zero | Stable | 2026-09-26 |
| E-waste | 62 million tonnes in 2022, about 22% documented recycling, about 82 million tonnes by 2030 (Global E-waste Monitor 2024); South Africa about 360 000 to over 500 000 tonnes a year | Next Global E-waste Monitor; SA figures | 2026-09-26 |
| E-waste | South Africa: EPR for electronics since 5 May 2021; e-waste banned from landfill | Changes to the EPR regulations | 2026-09-26 |
| Obsolescence | Apple's 2020 US settlement of up to US$500 million over slowed iPhones; Windows 10 support ended 14 October 2025 | Stable history | 2026-09-26 |
| Right to repair | EU: phones/tablets spare parts 7 years, updates 5 years, repairability label (June 2025); user-replaceable batteries from February 2027; USB-C since December 2024; South Africa has no electronics right-to-repair law | Any South African law; EU exceptions | 2026-09-26 |
| Solutions | More than 8 GW of rooftop solar in South Africa by 2026 - more than one and a half times Medupi (about 4.8 GW) (Eskom's National Transmission Company estimate, mid-2026) | NTCSA / CSIR figures | 2026-09-27 |

### Lesson 25 - Databases - a first look (`databasesintro`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#notSpreadsheet` | Excel's limit of 1 048 576 rows; a big bank records more transactions than that every day (doodle caption) | Excel's limit | 2026-09-26 |
| `#where` | Most public schools run their admin on SA-SAMS; WhatsApp keeps chats on the phone in SQLite; Takealot, TikTok, Instagram, YouTube, Spotify as examples | Whether SA-SAMS is replaced; apps pupils use | 2026-09-26 |
| `#kinds` | Access, LibreOffice Base, SQLite; MySQL, PostgreSQL, SQL Server, Oracle | Products | 2026-09-26 |
| `#sql` | Both exams test SQL in the practical exam | Exam guidelines | 2026-09-26 |

### Lesson 32 - Netiquette (`netiquette`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#hoaxes`, identify | WhatsApp's "Forwarded many times" label (double arrow) and its one-chat-at-a-time forwarding limit (since 2020) | Still how WhatsApp works | 2026-09-26 |
| `#hoaxes` | Common South African hoaxes (WhatsApp charging, fake school closures, fake grants and bursaries); Africa Check | Still circulating; Africa Check still running | 2026-09-26 |
| `#groupChats`, scenario | WhatsApp's "Reply privately" and "Only admins can send messages" settings | Setting names | 2026-09-26 |
| `#tone` | How people read emoji (thumbs-up, slight smile, skull, full stops); common abbreviations | Usage changes quickly | 2026-09-26 |
| `#cyberbullying` | Childline South Africa's free number 116; Cybercrimes Act (2020) and Protection from Harassment Act (2011) as described | Number and laws unchanged | 2026-09-26 |

### Lesson 40 - Malware and cybercrime (`malware`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#cybercrime` | SABRIC 2025: two bank robberies; more than 110 000 digital banking crimes; about R2.4 billion lost, most through banking apps, mostly by tricking customers | SABRIC's annual crime statistics (published about August) | 2026-09-26 |
| `#cybercrime` | Ransomware hit City Power (2019, prepaid sales) and Transnet (2021, Durban's container terminals); the Cybercrimes Act (2020) | Still the best-known South African cases; the Act's sections in force | 2026-09-26 |
| `#malware`, margin | Brain (1986), the first IBM-compatible PC virus, by two brothers in Lahore | Stable | 2026-09-26 |
| `#malware` | Viruses far less common today; worms and Trojans the big problems; Trojans the most common way in | Security reports | 2026-09-26 |
| `#spyware` | Stalkerware on phones | Still a named threat | 2026-09-26 |
| `#ransomware` | Payment usually in cryptocurrency; gangs also steal and threaten to publish (double extortion); many who pay don't get all their files back | Security reports | 2026-09-26 |
| `#tricks` | SARS never sends links or asks for banking details by e-mail or SMS; scam senders such as refunds@sars.co.za; "Hi Mom" WhatsApp scams; fake bank officials, safe accounts, remote-control apps; SIM swap fraud; fake courier SMSs (R25,50 customs fee) | SARS's scams page; SABRIC and bank warnings | 2026-09-26 |
| `#pharming` | Windows checks the hosts file before the DNS; certificate warnings on pharmed sites | Still how Windows and browsers work | 2026-09-26 |
| `#hoaxes`, margin | The "Good Times" virus hoax (1994); WhatsApp charging hoax | Stable | 2026-09-26 |
| `#safe` | WhatsApp's "two-step verification" setting; phones and browsers have built-in password managers | App settings names | 2026-09-26 |
| `#popia` (CAPS) | POPIA 2013, enforced from July 2021; the Information Regulator can fine up to R10 million, and prison for the worst offences; consent for direct marketing | Amendments, new regulations, fine limits | 2026-09-26 |

### Grade 11 lesson 5 - Starting up: BIOS, UEFI, CMOS and interrupts (`startup`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#biosChip`, `#bootSteps` | Setup keys Delete/F2; boot menu keys F12/F8/Esc; Windows Boot Manager and GRUB | Still the usual keys and boot loaders | 2026-09-27 |
| Good to Know | Many boards have debug lights (CPU, DRAM, VGA, BOOT) or a two-digit code display instead of a speaker | Still true | 2026-09-27 |
| Good to Know | Windows Fast Startup is on by default; Restart always starts fresh | Current Windows | 2026-09-27 |
| `#cmosBattery` | The CMOS battery is a 3 V lithium coin cell lasting years | Still true | 2026-09-27 |
| `#uefi`, study | UEFI on almost every new PC since about 2012; most new PCs have dropped the compatibility module; Windows 11 needs UEFI that supports Secure Boot, and a TPM 2.0 (a chip, or built into the processor); the popular Linux versions are signed | Current PCs, Windows and Linux | 2026-09-27 |
| `#irqIo`, reveal | Device Manager > View > Resources by type shows IRQs and I/O ranges; PCIe devices use message interrupts (large numbers) | Current Windows | 2026-09-27 |
| `#polling` | A normal mouse is polled 125 times a second; gaming mice 1 000 or more | Current mice | 2026-09-27 |

### Grade 11 lesson 6 - Primary and secondary storage compared (`storagecompared`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | A phone has 4-16 GB of memory and 64-512 GB of storage (budget to top phones) | Typical phones | 2026-09-27 |
| `#primaryCompared`, study | Registers under 1 ns; cache 1-15 ns, KB to about 100 MB; RAM about 80 ns, 50-100 GB/s, 8-64 GB (phones 4-16 GB) | Current PCs and phones | 2026-09-27 |
| `#secondaryCompared` table, `latency-ruler`, `o6Speed`, study | HDD about 10 ms, 100-250 MB/s, 1-32 TB (over 40 TB in data centres); SATA SSD about 0.1 ms, 550 MB/s, 250 GB-4 TB; NVMe SSD about 0.05 ms, 2 000-7 000 MB/s (newest up to about 15 000), 256 GB-4 TB; flash drives and cards 20-400 MB/s, 16 GB-1 TB; external HDD 100-200 MB/s, 1-6 TB portable; cloud 20-200 ms | Current drives | 2026-09-27 |
| `#secondaryCompared` | Free cloud storage: Google 15 GB, Microsoft and Apple 5 GB; files kept in data centres in Johannesburg and Cape Town, and many overseas | Current plans and regions | 2026-09-27 |
| `#reliability`, `w6Mtbf` | A 1 TB SSD is rated about 600 TBW; server drives quote MTBF of about 2 million hours (across 10 000 drives, about one failure a week) | Current drives | 2026-09-27 |
| `#choosing` | Tape is still used for archives; one cartridge holds tens of terabytes | Current LTO generation | 2026-09-27 |
| scenario, identify | NVMe about 7 000 MB/s; an 8 TB internal hard drive about 250 MB/s; a 4 TB portable drive about 120 MB/s; M.2 SSDs up to about 4 TB | Current drives | 2026-09-27 |

### Grade 11 lesson 13 - Databases and the DBMS (`dbms11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#software`, study | Access (CAPS schools with Delphi), SQL Server (free Express edition), Oracle Database, MySQL (owned by Oracle, free community edition; many IEB schools), MariaDB, PostgreSQL, Java DB (Apache Derby; IEB schools; retired by Apache on 10 October 2025, still works), SQLite (D. Richard Hipp's team; public domain) | Products, owners and editions; what SA schools use | 2026-09-27 |
| `#software` (margin) | SQLite is in every Android phone, every iPhone and every major browser; phones keep contacts and WhatsApp chats in it | Still so | 2026-09-27 |
| `#functions` | Ransomware encrypting company databases; backups kept off the network | Still the main advice | 2026-09-27 |

### Grade 11 lesson 23 - Threats to a system (`threats`)

Lesson file: `content/theory11/threats.php`.

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatThreat` (margin) | About 48 000 new software security holes (CVEs) were published in 2025 - more than 130 a day (48 185, up from 40 009 in 2024) | The CVE count for the latest full year | 2026-09-27 |
| `#physical` | Copper cable theft regularly cuts South African phone lines and networks | Still true as Telkom switches off copper | 2026-09-26 |
| `#hardwareFail` | Big data centres find roughly 1 or 2 in every 100 drives fail each year | Backblaze's latest drive statistics | 2026-09-26 |
| `#malware`, study | Most malware today is a mix; the ways in are phishing, pirated software and fake apps, flash drives, unpatched holes, hacked sites and default passwords | Current threat reports | 2026-09-26 |
| `#ransomware`, study, scenario | South Africa's best-known ransomware cases: City Power (2019), Life Healthcare (2020), Transnet and the Department of Justice (2021), the National Health Laboratory Service (22 June 2024, BlackSuit; backups hit, results phoned through for weeks); gangs steal before they encrypt (double extortion) | Add a newer major South African case if there is one | 2026-09-27 |
| `#dos` | The September-October 2019 DDoS attacks on Cool Ideas, Afrihost, Axxess, Webafrica and the banks as the South African example | A newer, bigger South African DDoS example | 2026-09-26 |
| `#openPorts` | Remote Desktop open to the Internet is one of the commonest ways ransomware gangs get in | Current incident reports | 2026-09-26 |
| `#openPorts` (margin) | Shodan lists millions of devices on open ports | Shodan still running | 2026-09-26 |
| `#wifi`, study | WEP broken, WPA with TKIP weak, WPA2 and WPA3 current; WPS PIN crackable in about 11 000 guesses | Wi-Fi Alliance standards (a WPA4?) | 2026-09-26 |

### Grade 11 lesson 24 - Protecting a system (`protecting`)

Lesson file: `content/theory11/protecting.php`.

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#locks` | Find Hub (Android, the new name since May 2025), Find my device (Windows) and Find My (Apple) locate, lock and wipe lost devices | Product names | 2026-09-27 |
| `#backups` | OneDrive, Google Drive and iCloud as synced folders that are not backups on their own; version history and backups that cannot be changed for a set time | Product names and features | 2026-09-26 |
| `#power` | Many South African homes and businesses installed inverters and batteries during the years of heavy load shedding | Still the usual picture | 2026-09-26 |
| `#passwords`, study, glossary (Strong password) | Password advice: at least 15 characters, better 16 or more (Chris, 27 September 2026); unique; change only when there is a reason (NIST SP 800-63B-4, August 2025) | The current NIST guidance | 2026-09-27 |
| `#passwords` (reveal) | Guessing times at 10 billion guesses a second (8 lowercase about 21 s; 8 of 95 characters about 8 days; 5 words about 90 years; 16 lowercase about 138 000 years) | Current GPU cracking speeds | 2026-09-26 |
| `#mfa` | Many South African banks now ask customers to approve payments in their app instead of (or as well as) SMS OTPs | Bank practice | 2026-09-26 |
| `#mfa` | Microsoft Authenticator and Google Authenticator as authenticator apps | Still the common apps | 2026-09-26 |
| `#encryption` | BitLocker, FileVault, phones encrypting when a PIN is set, WhatsApp end-to-end encryption; BitLocker recovery keys can be saved to a Microsoft account (margin note) | Product names and defaults | 2026-09-27 |
| `#wifiEncryption`, study | WPA3 (2018) strongest; WPA2 most common; TKIP not allowed on new equipment | Wi-Fi Alliance standards | 2026-09-26 |
| `#antiMalware` | Microsoft Defender good enough for most people; Patch Tuesday is the second Tuesday of the month; Windows 10 to 11 as the upgrade example | Windows names and practice | 2026-09-26 |
| `#captcha`, identify | AI solves many picture CAPTCHAs; sites move to invisible checks | Current practice | 2026-09-26 |

### Grade 11 lesson 25 - Computer crime and social engineering (`compcrime`)

Lesson file: `content/theory11/compcrime.php`.

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | SABRIC 2025 (published August 2026): more than 100 000 digital banking crimes (110 074), about 300 a day, R2.4 billion lost; almost all by tricking customers | SABRIC's newest annual crime statistics (usually August/September) | 2026-09-27 |
| `#criminals` (margin) | Google, Microsoft and Apple pay bug bounties | Still true | 2026-09-26 |
| `#criminals` | Ransomware is rented out with a help desk (ransomware as a service); cyber gangs run like businesses | Current threat reports | 2026-09-26 |
| `#phishing` | AI now writes perfectly spelt phishing | Still worth saying | 2026-09-26 |
| `#trojans` | SABRIC names remote-access software (AnyDesk, TeamViewer) as a main tool in digital banking fraud | SABRIC's newest report | 2026-09-26 |
| `#socialMedia` | WhatsApp six-digit code takeovers; WhatsApp's two-step verification setting; SABRIC's first South African voice deepfake cases (2024 report) | WhatsApp's setting name; SABRIC | 2026-09-26 |
| `#simSwap`, study | South African networks check SIM swap requests and many send an SMS; banks hold back OTPs after a SIM swap; SAFPS Protective Registration is free; one free credit report a year from each credit bureau | Network and bank practice; SAFPS; the National Credit Act regulations | 2026-09-26 |
| `#safeguards`, study | The Cybercrimes Act (19 of 2020) is mostly in force from 1 December 2021 | Whether the remaining sections have commenced (section 54 had not, September 2026) | 2026-09-27 |

### Grade 11 lesson 26 - Blockchain (`blockchain`)

Lesson file: `content/theory11/blockchain.php`.

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#distributed` (margin) | A full copy of Bitcoin's blockchain takes hundreds of gigabytes; thousands of computers keep one | Current chain size and node count | 2026-09-26 |
| `#consensus`, study | Bitcoin uses proof of work; Ethereum proof of stake (since 2022) | Still true | 2026-09-26 |
| `#uses` | De Beers' Tracr tracks diamonds from mine to jeweller; food companies trace produce this way | Still running | 2026-09-26 |
| `#uses`, study | SARB Project Khokha (2018) as the South African example; the Reserve Bank said more study was needed | Any newer SARB distributed-ledger work (Khokha 2 and later) worth adding | 2026-09-26 |
| `#uses` | Voting on a blockchain is debated | Still true | 2026-09-26 |
| `#limits`, study | Bitcoin's electricity: well over 100 TWh a year, more than the Netherlands and more than half of South Africa's use; Ethereum's switch cut its use by more than 99.9% | Cambridge (CBECI) estimate; South Africa's electricity use | 2026-09-26 |
| `#limits` | Bitcoin handles a handful of transactions a second, card networks thousands | Still true | 2026-09-26 |
| `#limits` (margin) | The Welsh hard drive with about 8 000 bitcoins is still in the Newport dump; the city has never let him dig for it | Still true (his court case failed in 2025) | 2026-09-27 |

### Grade 12 lesson 1 - What makes a computer fast (`performance`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cpuSpeed` (margin) | The first IBM PC (1981) ran at 4.77 MHz; phones today over 3 GHz with 8 cores | Phone clock speeds and core counts | 2026-09-27 |
| `#cpuSpeed` | Intel calls boosting Turbo Boost, AMD Precision Boost | Still the names | 2026-09-27 |
| `#cache` (margin) | AMD's X3D processors stack extra cache - 96 MB of L3 - and are favourites for gaming | Current AMD X3D models (the Ryzen 9 9950X3D2 has 192 MB; the table's 16-96 MB stays the typical range) | 2026-09-27 |
| `#cache` table | Typical cache sizes: L1 32-80 KB per core, L2 1-3 MB per core, L3 16-96 MB | Current CPUs | 2026-09-27 |
| `#cache` reveal | Times: L1 about 1 ns, L3 12, RAM 100, SSD 50 000, hard drive 5 000 000 | Still typical | 2026-09-27 |
| `#ram` (margin), `#ram` | DDR5-5600 runs at 2 800 MHz; DDR5 faster than DDR4; dual channel | Current RAM generations and speeds | 2026-09-27 |
| `#storage` table | HDD 100-250 MB/s; SATA SSD about 550 MB/s; NVMe 3 000-14 000 MB/s | Current drive speeds | 2026-09-27 |
| `#gpu` (margin), `#gpu` | Nvidia's RTX 5090 (2025) has 21 760 cores; gaming cards have 8-32 GB of VRAM | Current top gaming card | 2026-09-27 |
| `#nic` | Ethernet: 1 Gbps on most computers, 2.5 Gbps on many new boards, 10 Gbps in servers; Wi-Fi 6 and 7 well over 1 Gbps; home fibre lines of 50 or 100 Mbps | Current motherboards and SA fibre packages | 2026-09-27 |
| `#modular` (margin) | Framework (first laptop 2021) sells laptops with almost every part replaceable | Framework still trading | 2026-09-27 |
| `#modular` | PCIe 4.0 and 5.0, each generation doubling lane speed; a drive on USB 2.0 manages about 40 MB/s | Current PCIe generation | 2026-09-27 |
| `#processorTricks` | Hyper-threading gains about 15-30%; Intel's 2024-2026 laptop and desktop chips (Lunar, Arrow and Panther Lake) leave it out, and Intel says it will bring it back | Whether Intel has brought it back | 2026-09-27 |
| `#processorTricks` | Unlocked multipliers: Intel "K" models, most AMD Ryzen; XMP and EXPO profiles | Current naming | 2026-09-27 |
| `#registersBuses` | Windows 11 is 64-bit only; phones 64-bit for over ten years; about 48 address lines (256 TB) | Still true | 2026-09-27 |
| `#upgrades` table | 16 GB of RAM for office work; 32 GB or more for video editing | Typical RAM needs | 2026-09-27 |

### Grade 12 lesson 2 - Choosing a computer for the job (`choosingcomputer`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | A R25 000 gaming laptop; a R6 000 laptop for e-mail | SA laptop prices | 2026-09-27 |
| `#config` table | Processor families (Intel Core Ultra 5/7/9 and Core 3/5/7 - Core i3/i5/i7 on older models; AMD Ryzen 3/5/7/9 and Ryzen AI 5/7/9; Apple M; Qualcomm Snapdragon X); Intel's N series replaced Celeron and Pentium; U, H and HX suffixes | Current processor names | 2026-09-27 |
| `#config` table | RAM 8/16/32 GB, DDR5, LPDDR5X; eMMC 64-128 GB; Wi-Fi 6, 6E, 7; "HD" = 1366 x 768, Full HD = 1920 x 1080; 300 nits for bright rooms | Current laptop specifications | 2026-09-27 |
| `#config` table | Windows 11 S mode can be switched off, free and for good | Still how S mode works | 2026-09-27 |
| `#advert` figure | The made-up advert (`choose-advert`): an Intel N150 laptop at R5 999; the WorkMate 15 (Core Ultra 5, 16 GB, 512 GB) at R14 999; the GameForce 16 (Ryzen 7, 32 GB, RTX 5060) at R31 999 | Still realistic SA prices and parts | 2026-09-27 |
| `#quality` | Consumer Protection Act: faulty goods can be returned within six months | The CPA's implied warranty | 2026-09-27 |
| `#quality` reveal | About R10 000 buys a Core i5/Core Ultra 5 or Ryzen 5, 8 GB of RAM (typical at that price since the 2025-26 memory price rise; 16 GB is worth paying more for), 512 GB SSD, Full HD; batteries 40-70 Wh; shops Takealot, Evetech, Incredible, Wootware | SA prices and shops | 2026-09-27 |
| `#mobile` figure | Phone about 5 W, battery 15-20 Wh; thin laptop 15-30 W, 50-70 Wh; gaming laptop up to 150 W, 80-99 Wh; desktop up to 500 W | Typical power figures | 2026-09-27 |
| `#mobile` (margin) | Airlines need special permission for batteries over 100 Wh | Airline battery rules | 2026-09-27 |
| `#mobile` | Most South Africans pay for data as they go | Prepaid share | 2026-09-27 |
| `#problems` (margin) | Windows Fast Startup: Restart clears more than Shut down | Still how Windows works | 2026-09-27 |
| Good to Know | Windows 11 needs a fairly new processor; older laptops are stuck on Windows 10 | Windows 11 requirements (home users' Windows 10 extended updates end 12 October 2027) | 2026-09-27 |
| Scenario figure | Khanyi's options at R8 999, R15 999 (pen included) and R39 999 (an RTX 5070) in a R16 000 budget | Still realistic | 2026-09-27 |
| `#advert`, `#quality`, `#recommend`, scenario | South African laptop prices rose sharply from late 2025 as memory chips went to AI data centres (RTX 5060 and 5070 laptops from about R28 000 - Evetech, PC International); the lesson's prices were raised on 27 September 2026 (Chris), a Grade 11 pupil's laptop now about R13 000 | Whether memory and laptop prices have settled - re-price the advert, the reveal, the table and the scenario together | 2026-09-27 |

### Grade 12 lesson 3 - Cloud computing (`cloudcomputing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatCloud` | The biggest providers are AWS, Microsoft Azure and Google Cloud; all three have South African data centres | Still the biggest; SA regions | 2026-09-27 |
| `#ownership` | SA cloud regions: Microsoft 2019, Amazon 2020, Google 2024, with others since | New SA regions | 2026-09-27 |
| `#saas` | Google Workspace (Gmail, Docs, Sheets, Slides, Forms, Drive, Meet, Classroom); Microsoft 365 desktop apps on up to five computers; both have free plans for schools | Current plans and names | 2026-09-27 |
| `#saas` (margin) | Google Docs began as Writely, bought by Google in 2006 | Historical | 2026-09-27 |
| `#storage` | Free storage: Google 15 GB, Microsoft and Apple 5 GB, Dropbox 2 GB; deleted files and old versions kept about 30 days | Current free plans | 2026-09-27 |
| `#prosCons` (margin) | March 2024: undersea cables off West Africa damaged; SA traffic sent around the east coast | Historical | 2026-09-27 |
| `#prosCons` | October 2025: an AWS fault in a US region took Snapchat, Fortnite and thousands of apps offline for hours | Historical | 2026-09-27 |
| `#ownership` (margin) | Google deletes personal accounts unused for two years (since December 2023) | Google's inactive-account policy | 2026-09-27 |
| `#ownership` | The big providers' terms: the user keeps ownership and gives the provider a licence; Google Takeout | Current terms | 2026-09-27 |
| `#ownership` | POPIA's rule on sending personal information to other countries | POPIA / Information Regulator guidance | 2026-09-27 |
| `#licensing` | Office Home 2024 as a perpetual licence; Adobe Creative Cloud | Current products | 2026-09-27 |
| `#models` | Amazon EC2, Azure Virtual Machines, Google App Engine, Azure App Service | Current product names | 2026-09-27 |
| `#models` (IEB) | The IEB 2014 memo classes "creating a web page online" as PaaS, where many would call a web-page builder SaaS - the lesson notes both | Newer IEB memos | 2026-09-27 |

### Grade 12 lesson 4 - Artificial intelligence (`ai12`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | ChatGPT (2022); within two years hundreds of millions of people used AI chatbots every week | Current usage | 2026-09-27 |
| `#uses` (margin) | ChatGPT reached about 100 million users two months after its launch | Historical | 2026-09-27 |
| `#genAi` | Chatbots: ChatGPT, Gemini, Copilot, Claude; newer chatbots check the web | Current chatbots | 2026-09-27 |
| `#uses` table | Aerobotics (Cape Town) analyses orchard drone photos; Vodacom's TOBi; Lelapa AI (Johannesburg) builds tools for SA languages; AI screening of chest X-rays for TB | Still operating and used | 2026-09-27 |
| `#limits` | A 2018 study: face-recognition errors up to about a third for darker-skinned women, under 1% for lighter-skinned men | Historical (Gender Shades) | 2026-09-27 |
| `#limits` | Deepfake scam adverts using SA presenters and businesspeople; voice cloning from a few seconds of audio; copyright court cases | Current state | 2026-09-27 |
| `#society` | The world's data centres use about as much electricity as France | IEA figures | 2026-09-27 |
| `#society` | SA's national AI policy framework (2024, for discussion); a draft national AI policy gazetted in April 2026 and withdrawn on 26 April over fictitious references (SAnews), a new draft due for comment in 2027; the EU AI Act (2024); twelve official languages including SASL; SA's large call-centre industry | Whether SA has an AI policy or law now | 2026-09-27 |
| `#society` (margin) | Data labelling by people in Kenya, the Philippines and elsewhere, often for a few dollars an hour | Still reported | 2026-09-27 |
| Good to Know | AGI does not exist; experts disagree about whether and when | Current state | 2026-09-27 |

### Grade 12 lesson 5 - VR, AR and MR (`vrarmr`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#vr` | Standalone headsets: Meta Quest 3 and 3S the best known; PlayStation 5 VR; phone VR has almost disappeared | Current headsets (no new Quest at Meta Connect 2026; its "Meta VR Glasses" go on sale in 2027) | 2026-09-27 |
| `#needs` reveal | Quest 3: 2064 x 2208 pixels per eye at 90 Hz | Current Quest model | 2026-09-27 |
| `#needs` | Horizon OS, visionOS, Unity, Unreal, ARCore, ARKit | Current names | 2026-09-27 |
| `#ar` | Pokemon GO, Snapchat/Instagram/TikTok filters, Google Lens, Google Maps Live View, LiDAR on the iPhone Pro; smart glasses starting to appear | Current apps and devices | 2026-09-27 |
| `#ar` (margin) | Pokemon GO: over 100 million downloads in its first month (July 2016) | Historical | 2026-09-27 |
| `#mr` | Apple Vision Pro (2024); Samsung Galaxy XR (October 2025, Android XR); Quest 3 mixed-reality mode; Microsoft stopped making HoloLens in 2024 | Current MR headsets | 2026-09-27 |
| `#prosCons` | Vision Pro about US$3 500 in the USA, not sold officially in SA; a standalone headset costs about as much as a mid-range phone; minimum ages 10 to 13; batteries two to three hours | Prices, availability, age limits | 2026-09-27 |
| `#prosCons` (margin) | A 2023 study identified one user among more than 50 000 with about 94% accuracy from about 100 seconds of motion | Historical | 2026-09-27 |
| `#uses` (margin) | Pilots can qualify on a new aircraft type almost entirely in simulators | Still true | 2026-09-27 |
| Good to Know | Facebook became Meta in 2021; tens of billions of dollars spent on the metaverse | Current state | 2026-09-27 |

### Grade 12 lesson 23 - Two-dimensional arrays (`arrays2d`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Rows, columns and indexes (margin) | A 12-megapixel phone photo is about 4 000 x 3 000 pixels | Common phone camera resolutions (arithmetic stays true) | 2026-09-26 |
| Rows, columns and indexes | IEB pseudocode often counts from 0 (IEB 2019 and 2020 appendices: for k <- 0 to size - 1); the lesson counts from 1, like Delphi and CAPS | New IEB papers | 2026-09-27 |
| Looping through every element (margin) | VisiCalc, the first spreadsheet, came out in 1979 for the Apple II | Stable history | 2026-09-26 |

### Grade 12 lesson 24 - Dynamic arrays and JSON (`dynamicjson`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Programs swapping data | Today most apps and web services use JSON (rather than XML) to exchange data | Still true of public web APIs | 2026-09-26 |
| Programs swapping data (margin) | JSON became a standard in 2013 (ECMA-404) - more than ten years after programmers first used it (Crockford named it in 2001; it spread with AJAX in the mid-2000s) | Stable history (RFC 8259 is the 2017 IETF standard) | 2026-09-27 |
| Dynamic arrays (margin) | Java's ArrayList grows by making a new array about half as big again | OpenJDK's ArrayList.grow (old + old >> 1) | 2026-09-26 |
| Dynamic arrays | Delphi has TStringList and TList<T>; dynamic arrays with SetLength (Insert/Delete since XE7) | Current Delphi version | 2026-09-26 |
| Dynamic arrays | The IEB practical exam uses static arrays with a count; dynamic arrays are theory/PAT only | IEB SAGs (Topic 4 "not examinable in the practical exam") | 2026-09-26 |
| Reading JSON | Java's standard library has no JSON parser (Gson, Jackson, org.json); Delphi has System.JSON | Current Java SE - still none in JDK 27; JEP 540 (a Simple JSON API, an incubator module) is targeted to JDK 28 (March 2027) - and Delphi | 2026-09-27 |
| Where JSON is used | MongoDB stores records as JSON-like documents | Still MongoDB's model | 2026-09-26 |

### Grade 12 lesson 25 - Bigger truth tables (`truthtables4`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Working it out step by step (margin) | CAPS memos give a mark per correct step in "show all steps" Boolean questions | Latest CAPS Paper 2 memos | 2026-09-26 |
| Building the table (margin) | A modern processor has billions of transistors | Current processors (stays true) | 2026-09-26 |
| The same logic in code, SQL and searches | Most search engines treat a space as AND, accept OR in capitals and a minus sign for NOT | Google and Bing search help | 2026-09-26 |

### Grade 12 lesson 26 - Efficient algorithms (`efficiency`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| What makes an algorithm efficient (margin) | Google searches an index of hundreds of billions of web pages and usually answers in under half a second | Google's "How Search Works" | 2026-09-26 |
| What makes an algorithm efficient | A cloud server is paid for by the second | Cloud providers' billing (AWS, Azure) | 2026-09-26 |
| What makes an algorithm efficient | Computers do billions of steps a second | Stays true | 2026-09-26 |

### Grade 12 lesson 27 - Theory exam guide - IEB (`examieb`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| How the paper is built | Paper 2: 3 hours, 150 marks (counts out of 100); systems 40, Internet and communication 45, social 15, data and solution development 50; levels 30/40/30 | The current SAGs and IEB circulars | 2026-09-26 |
| How the paper is built | Before November 2021 the theory paper was Paper I with 180 marks | Stable history | 2026-09-26 |
| How the paper is built | Recent papers open with short questions, then a section per topic; answer booklets with labelled slots | Look at the newest IEB paper the school has (the analysis only has papers to May 2021) - Section A's size is not known for the 150-mark paper; re-check when Chris adds the 2022-2025 Paper 2s (open-items.md) | 2026-09-26 |
| Scenario / marking | Every paper has a scenario; since 2014 memos give marks for using it | Newer papers | 2026-09-26 |
| Question formats | About 8% recall, 70% written, 18% solution development on paper, 2% pictures and calculations; class diagrams 9-10 marks in every paper 2016-2021 | Re-count if newer papers are added to AIResources/IEB | 2026-09-26 |
| Command words | The levels follow the SAGs' current taxonomy: define, name and state usually knowing; describe, compare and discuss usually applying (Level 2); explain listed at Levels 1 and 3 | The current SAGs | 2026-09-27 |

### Grade 12 lesson 28 - Theory exam guide - CAPS (`examcaps`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| How Paper 2 is built | 3 hours, 150 marks; A 20 (10 + 5 + 5 in all four newest papers); B to E about 25 and F about 30 (the caps-2024.md 4.6 targets - recent papers move a few marks: B 25-30, C 25-26, D 20-25, E 20-30, F 28-33), with November 2025 as the example; levels 40/40/20 | Each new Paper 2 (the analysis covers to May/Jun 2026) | 2026-09-27 |
| How Paper 2 is built | Since November 2024 Section A = 10 multiple choice + 5 give-the-term + 5 modified true/false; matching left Section A after November 2023 | The November paper each year | 2026-09-26 |
| What each section asks | Topics that recur (SSD vs HDD, protocols, database design from a table, loops and DIV/MOD...); Delphi code since 2017; loose theme since 2022 | Re-count when new papers are added to AIResources/CAPS | 2026-09-26 |
| Programming on paper | SQL moved to Paper 1 in November 2018; Paper 2 asks only about SQL injection; never asked: IPO tables, use case diagrams, truth tables, transfer-time sums, binary arithmetic | New papers | 2026-09-26 |
| Question formats | Modified true/false: the papers say write true or false and correct a false one; the memos read "FALSE, <the right word>", so the lesson says write FALSE and the replacement word ("FALSE, switch") | New memos | 2026-09-27 |

### Grade 12 lesson 6 - Collecting and caring for data (`datacollection`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Tags and sensors | Gauteng's e-toll gantries were switched off in 2024; e-tags still pay at toll plazas | Whether e-tags are still used at toll plazas | 2026-09-27 |
| Tags and sensors | Some car insurers use a sensor or phone app to score driving | Still offered in SA | 2026-09-27 |
| Invisible online collection | TikTok and Instagram record watch time, replays, likes, shares and scrolling | Apps pupils use (swap names if TikTok/Instagram fade) | 2026-09-27 |
| Transaction tracking | Loyalty programmes named: Smart Shopper, Xtra Savings, ClubCard, WRewards | Names still current (Pick n Pay, Checkers, Clicks, Woolworths) | 2026-09-27 |
| Forms (margin) | Every SIM must be RICA-registered with ID number and address | RICA amendment (see privacylaw's row) | 2026-09-27 |
| The value of data (margin) | "Data is the new oil" - usually credited to Clive Humby, 2006 | Stable | 2026-09-27 |
| POPIA | Started on 1 July 2020 with a year's grace, so organisations have had to comply since July 2021; opt-in for electronic direct marketing, except existing customers; Information Regulator fines up to R10 million | Amendments, new fine limits | 2026-09-27 |

### Grade 12 lesson 7 - Data warehouses, data mining and big data (`warehousemining`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Data mining at work | SASSA matches grant data with Home Affairs, SARS, UIF, payrolls and banks; the SRD grant (started 2020; runs to March 2027 - 2026 Budget) is checked monthly against bank data | Whether the SRD grant still exists and how it is checked | 2026-09-27 |
| Data mining at work | TikTok, Instagram and YouTube build feeds from watch time, replays, likes, shares and comments | Apps pupils use | 2026-09-27 |
| Data mining at work | A widely reported story of a US chain predicting a pregnancy from shopping (Target, 2012) | Stable history (told as "widely reported") | 2026-09-27 |
| Data mining (process) | A film actor's films per year rose and fell with swimming-pool drownings (Tyler Vigen's spurious correlations) | Stable | 2026-09-27 |
| Big data | MeerKAT in the Karoo produces vast amounts of data | Stable (SKA name may be used instead) | 2026-09-27 |
| What it means for people | Experian South Africa breach, 2020: about 24 million South Africans | Stable history; a newer SA example may be better | 2026-09-27 |
| What it means for people (margin) | Cambridge Analytica, 2018: up to 87 million Facebook users | Stable history | 2026-09-27 |
| Good to Know - data lakes | Amazon, Microsoft and Google have cloud data centres in South Africa | Stable; others may be added | 2026-09-27 |

### Grade 12 lesson 8 - Centralised and distributed processing (`distributed`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Clients you already know | Some South African schools run thin-client labs, often on Linux, some on old PCs | Still common in SA schools | 2026-09-27 |
| Clients you already know | Chromebooks run ChromeOS, keep files in Google Drive, many apps work offline | Stable | 2026-09-27 |
| Clients you already know | Cloud gaming runs games in data centres; how well it works in SA depends on the connection and the nearest gaming data centre | Services available in SA | 2026-09-27 |
| Clients you already know | Virtual desktops such as Windows 365 | Product name | 2026-09-27 |
| Smart clients | WhatsApp, offline Google Docs and Microsoft 365, POS apps on tablets work offline and sync | Stable | 2026-09-27 |
| Distributed computing power | About a million volunteers' computers ran Folding@home on the COVID-19 virus in 2020 | Stable history | 2026-09-27 |
| Distributed computing power | MeerKAT radio telescope in the Karoo | Stable (SKA) | 2026-09-27 |

### Grade 12 lesson 9 - Sharing and remote access (`sharingremote`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Peer-to-peer and BitTorrent | BitTorrent created in 2001; used by Linux distributions (Ubuntu), the Internet Archive and some game makers | Still true | 2026-09-27 |
| Online services | Dropbox, Google Workspace (formerly G Suite), Microsoft 365 (formerly Office 365) - features: link sharing, permission levels, co-editing, version history, syncing | Product names and features | 2026-09-27 |
| Remote access | TeamViewer, AnyDesk, Windows Quick Assist, Chrome Remote Desktop; Windows has Remote Desktop built in | Product names | 2026-09-27 |
| Remote access | An open remote desktop is one of the most common ways ransomware gets into businesses | Still a top entry point in security reports | 2026-09-27 |
| Remote-access scams | SABRIC and the banks warn about "bank official" calls asking victims to install AnyDesk/TeamViewer | Still current; newer versions of the scam | 2026-09-27 |

### Grade 12 lesson 10 - Connecting a home or school (`connecthome`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Connecting to the Internet | Fibre not yet laid in many rural areas and some townships | Fibre roll-out | 2026-09-27 |
| Connecting to the Internet | Wireless ISPs beam connections from towers to farms and small towns | Still common | 2026-09-27 |
| Connecting to the Internet | A DSL modem is for a copper telephone line, and Telkom is switching these off | Copper switch-off progress - agree with Grade 10 `internet` and `media` | 2026-09-27 |
| Satellites: high and low | LEO satellites about 500 km up (Starlink; being lowered from about 550 to about 480 km during 2026 - text, glossary, `farm-satellite` doodle, rubric, study); in 2026 Starlink works in several neighbouring countries but is not licensed in South Africa (no application to ICASA by June 2026) | ICASA licensing - agree with Grade 10 `internet` | 2026-09-27 |
| The all-in-one "router" | Older exam papers call it an "ADSL router" | Stable | 2026-09-27 |
| A home network | WPA2/WPA3 for home Wi-Fi | WPA3 becoming the norm | 2026-09-27 |
| Linking the nodes | UTP runs up to about 100 m | Stable | 2026-09-27 |

### Grade 12 lesson 22 - Objects in depth (`oop12`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Private and public | CAPS projects keep each class in its own unit (such as `clsTaxi_u.pas`) | Still the pattern in the CAPS practical papers and PAT | 2026-09-26 |
| Reading a class diagram | CAPS papers draw class diagrams in Delphi's words: f-prefixed attributes (`- fPrice: Real`), type-letter parameters (`sName`), function/procedure kept, `+ constructor Create(...)` (May/June 2026) | Each new CAPS Paper 2 | 2026-09-27 |
| Accessors, mutators and auxiliary methods | CAPS memos count toString as an auxiliary method (May/June 2025); the IEB lists it on its own | New memos of both boards | 2026-09-27 |
| Writing a method heading (margin) | CAPS papers have given 3 marks for one heading: Function or Procedure, the name, and the parameter with its type (or the return type) | Recent CAPS Paper 2 memos (May/June 2026: 3-mark headings) | 2026-09-27 |

### Grade 12 lesson 11 - Better searching and SEO (`seo`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| How a search engine works | Google's crawler is called Googlebot | Still its name | 2026-09-27 |
| Who comes first? | Google says it uses hundreds of ranking signals and changes its rules thousands of times a year | Google's "How Search works" pages | 2026-09-27 |
| Who comes first? | Adverts ("Sponsored") are how Google makes most of its money | Alphabet's latest annual results | 2026-09-27 |
| Who comes first? | RAM Hand-to-Hand Couriers is the courier company in the "RAM" example | Still trades under that name | 2026-09-27 |
| Semantic search | Search engines use AI language models "since about 2019" (BERT); Google calls its fact database the Knowledge Graph | Still true; name unchanged | 2026-09-27 |
| Semantic search (margin) | Google says about 15% of the searches it sees each day have never been typed before | Google's latest figure | 2026-09-27 |
| Mediated search | Search engines employ thousands of people to rate their results | Still done | 2026-09-27 |
| White-hat SEO | Most searches are on phones; Google looks at the phone version of a page first (mobile-first indexing) | Still true | 2026-09-27 |
| White-hat SEO | HTTPS is a ranking signal and browsers warn about sites without it | Still true | 2026-09-27 |
| White-hat SEO | Google Business Profile is the name of Google's business listing | Name unchanged | 2026-09-27 |
| AI answers in search | Google's AI Overviews in South Africa since late 2024 (the October 2024 expansion), in Afrikaans, isiZulu, Sesotho and Setswana since March 2026; AI Mode in South Africa since August 2025 | Names, availability, languages | 2026-09-27 |
| AI answers in search | ChatGPT, Gemini and Copilot search the Web and answer in their own words | Products current | 2026-09-27 |
| AI answers in search | "GEO" (generative engine optimisation) and "AEO" are the names in use | Still the names used | 2026-09-27 |

### Grade 11 lesson 19 - Streaming and compression (`streaming`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#multimedia` reveal, `#quality` reveal | Netflix sends an HD film using about 3 GB an hour (SD about 1 GB, 4K about 7 GB) | Netflix's help page on data use per hour | 2026-09-26 |
| `#download`, study | HD streaming needs about 5 Mbps; 4K 15-25 Mbps | Netflix and YouTube recommended speeds | 2026-09-26 |
| `#download` | Netflix, YouTube Premium and Spotify offer encrypted downloads that play only in the app | Still offered | 2026-09-26 |
| `#vodLive` | Netflix, YouTube, Disney+ and the DStv app (catch-up; live sport such as Springbok tests) as South African examples | Services still available in South Africa; the DStv app's name | 2026-09-26 |
| `#vodLive` | Live streams usually run 10-30 seconds behind; satellite TV is usually ahead | Typical live-streaming delay | 2026-09-26 |
| `#vodLive` | Netflix and YouTube keep copies of popular videos in South African data centres, some inside ISPs' networks | Still true (Netflix Open Connect, Google caches) | 2026-09-26 |
| `#voipPodcasts`, study | A WhatsApp voice call uses about 30-45 MB an hour; a video call 300-600 MB | Current typical figures | 2026-09-26 |
| `#voipPodcasts` | Businesses moving to VoIP as Telkom switches off copper lines | Progress of the copper switch-off | 2026-09-26 |
| `#voipPodcasts` | Podcast apps: Spotify, Apple Podcasts, YouTube | Still the main podcast apps | 2026-09-26 |
| `#compression` | WhatsApp compresses a photo when it is sent, unless HD is chosen (forwarding re-sends the same file) | Still true | 2026-09-27 |
| `#lossySound` | Spotify's settings run from about 96 kbps ("Normal") to 320 kbps ("Very high"); some services offer lossless (FLAC) | Spotify's quality settings; which services offer lossless in South Africa (Spotify: on Premium Platinum, since November 2025) | 2026-09-27 |
| `#lossySound` | Lossless (FLAC) music is "several times" an MP3's size (about 2.5 times a 320 kbps MP3, 6 times a 128 kbps one) | Typical FLAC bit rates | 2026-09-27 |
| `#lossySound` | Apple Music and YouTube use AAC | Still true | 2026-09-26 |
| `#quality`, study | Data an hour: music 45-145 MB, SD video 0.5-1 GB, HD 2-3 GB, 4K 7 GB or more | Netflix, YouTube and Spotify figures | 2026-09-26 |
| `#quality` | A 1 GB prepaid bundle on the big networks costs roughly R80 to R100 (MTN 1 GB for 30 days R79, Vodacom 1.5 GB R95, September 2026); night data and big bundles cost less per GB; uncapped fibre costs nothing extra | Current Vodacom, MTN, Cell C and Telkom prepaid prices | 2026-09-27 |
| `#quality` | YouTube and Netflix quality/"Save data" settings, WhatsApp "use less data for calls", Spotify's data saver | Settings still exist under these names | 2026-09-26 |
| `#quality`, study | H.264 most common; H.265 about half the data; AV1 used by YouTube and Netflix; many newer phones decode AV1 in hardware (budget chips often cannot) | Codec use and hardware support | 2026-09-27 |

### Grade 11 lesson 20 - How the Web grew up (`webgrewup`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | Checkers Sixty60, phone banking and online school fees as everyday South African examples | Still current | 2026-09-26 |
| `#staticDynamic` | WordPress runs about four in ten of all websites | W3Techs CMS usage figures | 2026-09-26 |
| `#staticDynamic` | Takealot, News24, Wikipedia as dynamic sites | Still current | 2026-09-26 |
| `#versions` | "Web3" much talked about around 2021-2022, used mostly for crypto so far | How Web3 is described now | 2026-09-26 |
| `#versions` | In 2023 the European Union described Web 4.0 as AI, IoT and the digital and real worlds mixed | Newer official descriptions of Web 4.0 | 2026-09-26 |
| `#scripting` | Server-side languages: PHP, Python, Java, C#, JavaScript (Node.js); this course's site runs PHP and JavaScript | Still true | 2026-09-26 |
| `#cookies` | POPIA and the GDPR require consent for non-essential cookies (cookie banners) | Any change in the law or the Information Regulator's guidance | 2026-09-26 |
| `#cookies` | Safari and Firefox block third-party cookies by default; Chrome still allows them (Google dropped its removal plan in July 2024 and the Privacy Sandbox in October 2025) | Browser defaults (agree with Grade 12 `onlineapps` and `privacylaw`) | 2026-09-27 |
| `#webApps` | Gmail, Google Docs, Canva, Microsoft 365, online banking and SARS eFiling as web apps | Still current | 2026-09-26 |
| `#mobileApps` | Native apps in Kotlin (Android) and Swift (iOS); app stores take a cut of up to 30% | Languages; Apple and Google commission rates | 2026-09-26 |
| `#mobileApps` | Flutter and React Native as cross-platform tools | Still the main ones | 2026-09-26 |
| `#plugins` | Adobe ended Flash on 31 December 2020; browsers run no old-style plug-ins | Historical - check only that no plug-ins returned | 2026-09-26 |
| `#plugins` | Extension stores: Chrome Web Store, Firefox Add-ons | Still the names | 2026-09-26 |
| `#http` | Browsers mark HTTP pages "Not secure"; almost every site uses HTTPS; free certificates since 2015; Google ranks HTTPS higher since 2014 | Browser behaviour, HTTPS share | 2026-09-26 |
| `#lbsSites` | Google Maps, Waze, Mr D, Clicks, Uber, Bolt as location-based examples | Still current | 2026-09-26 |
| `#security` (CAPS) | South African banks send SMS OTPs for online card payments and new beneficiaries; many now use in-app approval because of SIM-swap fraud | Current bank practice | 2026-09-26 |
| `#security` (CAPS) | Google and Microsoft Authenticator as authenticator apps; codes change about every 30 seconds | Still current | 2026-09-26 |
| `#careers` (CAPS) | Figma, Photoshop, Illustrator, Canva, After Effects, Blender as tools; WordPress as a CMS | Still the common tools | 2026-09-26 |

### Grade 11 lesson 21 - Searching like an expert (`expertsearch`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#recap` | Search results are ranked by fit, links, freshness, location and history; sponsored results come first | How the big engines rank and show adverts | 2026-09-26 |
| `#operators` (IEB), study | Google's operators: quotes, minus, OR, brackets, site:, filetype:, intitle:, before:/after:, * in quotes; the plus sign was dropped | Google's current operator list (it drops some now and then) | 2026-09-26 |
| `#operators` (IEB) | The Tools menu has a time filter and Verbatim; an Advanced Search page; Google Scholar | Still there under these names | 2026-09-26 |
| `#images` (IEB) | Image filters: size, colour, type, time, usage rights (Creative Commons) | Still offered | 2026-09-26 |
| `#images` (IEB) | Google Lens, Circle to Search on many Android phones, Bing Visual Search, TinEye (sorts oldest first) | Still available and named so | 2026-09-26 |
| `#images` (IEB) | Some websites match people's faces | Face-search services and South African law on them | 2026-09-26 |
| `#sounds` (IEB) | Shazam is owned by Apple and built into iPhones; its database holds tens of millions of songs | Still true | 2026-09-26 |
| `#sounds` (IEB) | Hum to search in the Google app; BirdNET names birds from their calls | Still available | 2026-09-26 |
| `#aiAnswers`, study | AI answers in search: Google's AI Overviews and AI Mode, Copilot in Bing, ChatGPT search, Perplexity | The current AI search products | 2026-09-26 |
| `#aiAnswers` | In 2023 and 2025 South African judges criticised lawyers for citing court cases invented by AI | Historical (Parker v Forsyth, 2023; Mavundla, 2025) - check only for newer, better-known cases | 2026-09-26 |
| `#aiAnswers` | South African driving age 18 (learner's licence 17); many US states 16 | The National Road Traffic Act ages | 2026-09-26 |

### Grade 11 lesson 22 - IoT, 4IR, location and big data (`iotbigdata`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#iotUses` | Prepaid smart meters, car trackers, security cameras, solar inverters with apps, smartwatches as everyday South African IoT | Still common | 2026-09-26 |
| Start here, `#iotUses` | Many municipalities are installing smart prepaid electricity meters, read and switched remotely; most South African homes still have keypad (STS) meters that report nothing | Progress of smart-meter roll-outs (City Power and others) | 2026-09-27 |
| `#iotUses` | The geyser is often the biggest user of electricity in a home | Current household energy figures | 2026-09-26 |
| `#iotUses` | Tracking companies Tracker, Netstar and Cartrack; many thousands of cars recovered | Company names and recovery figures | 2026-09-26 |
| `#iotUses` | Discovery Insure's Vitalitydrive rewards good driving measured by a device or app | Still offered, same name | 2026-09-26 |
| `#iot` | LoRa as a long-range, low-power IoT network | Still the usual example | 2026-09-26 |
| `#industrial` | 4IR popularised by Klaus Schwab (WEF) in 2016; South Africa's Presidential Commission on the 4IR (2019); EU "Industry 5.0" (2021) | Historical - check for a newer SA 4IR plan | 2026-09-26 |
| `#location` | About 30 GPS satellites, about 20 000 km up; Galileo, GLONASS, BeiDou; phones use several | Constellation sizes | 2026-09-26 |
| `#location` | Google and Apple keep databases of Wi-Fi network positions | Still how phones locate indoors | 2026-09-26 |
| `#location` | Google Maps and Waze get traffic from users' phones; users report hazards | Still how they work | 2026-09-26 |
| `#location` | The South African Weather Service issues the warnings weather apps pass on | Still the source | 2026-09-26 |
| `#bigDataUses`, study | Checkers Xtra Savings, Pick n Pay Smart Shopper, Clicks ClubCard as loyalty programmes | Programme names | 2026-09-26 |
| `#bigDataUses`, study | Discovery Vitality rewards steps, workouts, gym visits and healthy food at partner shops | How Vitality works now | 2026-09-26 |
| `#bigDataUses` | Smartwatches can detect an irregular heartbeat | Still true | 2026-09-26 |
| `#bigDataUses` | NICD tracked COVID-19 cases day by day | Historical | 2026-09-26 |
| `#bigDataUses` | Professional rugby players, the Springboks among them, wear GPS trackers | Still true | 2026-09-26 |

### Grade 11 lesson 27 - Work in a digital world (`digitalwork`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#aup` | RICA and POPIA allow an employer to monitor its own systems for business reasons, within limits, with staff agreement; hacking is a crime under the Cybercrimes Act | Changes to RICA (the Constitutional Court ordered amendments), POPIA guidance, the Cybercrimes Act | 2026-09-26 |
| `#decentralised` | South Africa is one of the world's favourite places for contact centres serving Britain, the USA and Australia | Current industry standing | 2026-09-26 |
| `#decentralised` | Since about 2023 many large companies have called staff back to the office; most office work is now a mix | Current trend | 2026-09-26 |
| `#onlineServices` (CAPS) | Most banking is done in apps; many branches have closed; some banks work almost entirely through their app | Current banking practice | 2026-09-26 |
| `#onlineServices` (CAPS) | Home Affairs appointments for smart IDs and passports are booked online | Still offered | 2026-09-26 |
| `#onlineServices` (CAPS) | UNISA, Africa's biggest university, teaches almost entirely at a distance | Still true | 2026-09-26 |
| `#gig` (CAPS) | Uber, Bolt, Mr D, Uber Eats, SweepSouth, Upwork, Fiverr as gig platforms; commission often 20% or more | Platforms still operating in South Africa; commission levels | 2026-09-26 |
| `#gig` (CAPS) | Courts and governments, South Africa's included, still argue whether gig workers are employees | Any South African ruling or law on gig workers | 2026-09-26 |
| `#robotsAi` | Robots weld and paint in car factories in East London, Rosslyn, Kariega and Durban | Plants still operating | 2026-09-26 |
| `#robotsAi` | Drones have delivered blood and medicine to rural clinics in Rwanda since 2016 and in Ghana since 2019 (Zipline) | Historical | 2026-09-27 |
| `#robotsAi` | SACAA rules: work drones need a licensed pilot and an operator's certificate; not near airports or over crowds | Current SACAA Part 101 rules | 2026-09-26 |
| `#careers` (CAPS) | Medical nanobots are still mostly in research; 3-D-printed concrete house walls in some countries | Progress in the field | 2026-09-26 |

### Grade 11 lesson 28 - What location, IoT and big data do to people (`iotpeople`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#goodSide` | Uber and Bolt apps have trip-sharing and an emergency button | Still offered | 2026-09-26 |
| `#privacy`, study | 2013 study: four places and times identified 95% of 1.5 million phone users | Historical (de Montjoye et al., "Unique in the Crowd") | 2026-09-26 |
| `#privacy` | Some apps sell location data to data brokers; smart TVs report what you watch | Current practice and any South African rulings | 2026-09-26 |
| `#privacy` | Google and Apple now keep a phone's location history on the phone (Google Maps Timeline since 2025; Apple's Significant Locations), but still see your location when you search, use maps or find a phone | Company practice | 2026-09-27 |
| `#tracking` | Private camera networks in many Johannesburg suburbs read number plates and alert security companies | Still operating | 2026-09-26 |
| `#tracking` | RICA: every SIM registered to a person with ID number and address | Changes to RICA | 2026-09-26 |
| `#tracking` | Phones warn you when an unknown Bluetooth tracker travels with you | Still true on Android and iPhone | 2026-09-26 |
| `#profiling` | Amazon scrapped a biased hiring tool (2018); a 2018 study found face recognition wrong more often for darker-skinned women | Historical | 2026-09-26 |
| `#profiling`, `#popia` | POPIA section 71: serious decisions may not be based only on automated profiling | Any amendment or Regulator guidance | 2026-09-26 |
| `#iotRisks` | Mirai (2016), the casino fish-tank thermometer (2017), the Jeep hacked from about 16 km away and 1.4 million recalled cars (2015, Wired), Revolv switched off (2016) | Historical - check only for a better-known newer case | 2026-09-27 |
| `#popia` | Information Regulator fines up to R10 million; some offences up to ten years in prison | POPIA penalties | 2026-09-26 |
| `#globalisation` | Tyla won the first Grammy for Best African Music Performance (2024); amapiano's global spread | Historical | 2026-09-26 |
| `#globalisation` | South African clothing factories struggle against cheap imports from overseas online shops | Current state of the industry and import rules | 2026-09-26 |
| `#globalisation` | March 2024 undersea cable breaks off West Africa slowed South Africa's Internet | Historical | 2026-09-26 |
| `#revolutions` | Data centres use as much electricity as a medium-sized country, and AI is making that grow fast | IEA figures | 2026-09-26 |

### Grade 12 lesson 12 - How online applications work (`onlineapps`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, Online applications | Takealot, Checkers Sixty60, Google Docs, Canva and TikTok as everyday online applications | Still current and well known | 2026-09-27 |
| One request (reveal) | A page usually needs "somewhere between 50 and a few hundred" requests; Chrome and Edge open the Network tab with F12 | Typical page weight; the shortcut | 2026-09-27 |
| Storing data | Safari and Firefox block third-party cookies by default; Chrome still allows them (Google dropped its plan to remove them in 2024-2025) | Browser defaults | 2026-09-27 |
| Storing data | MySQL, PostgreSQL and Microsoft SQL Server as popular database systems for websites | Still the common ones | 2026-09-27 |
| Running code | WordPress, written in PHP, runs "a large share of the world's websites" (about two in five sites in 2025); this course runs on PHP | W3Techs; the platform | 2026-09-27 |
| AJAX | Google Maps made AJAX famous in 2005; AJAX now mostly carries JSON | History; practice | 2026-09-27 |
| XML and JSON | A .docx file is XML packed into a zip file; RSS and SVG use XML; most apps use JSON | Still true | 2026-09-27 |

### Grade 12 lesson 13 - The deep web and the dark web (`deepdark`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| The dark web (IEB) | The BBC and some other news organisations run .onion versions of their news sites (The New York Times closed its one in 2025) | The BBC's still online | 2026-09-27 |
| The dark web (IEB, margin) | A .onion address is 56 characters, made from the site's own key (version 3 addresses) | Still the current address format | 2026-09-27 |
| The dark web (IEB) | Police have shut down many of the biggest dark web markets and arrested thousands of users | Still a fair summary | 2026-09-27 |
| Onion routing and Tor (IEB) | Tor uses three relays chosen from thousands of volunteers; run by the non-profit Tor Project; first developed at the US Naval Research Laboratory in the 1990s | Relay count still "thousands" | 2026-09-27 |
| Onion routing and Tor (IEB) | Using Tor (and a VPN) is legal in South Africa | No change in the law | 2026-09-27 |
| VPNs (IEB) | VPNs usually cost a subscription; free ones often sell your data; some "no logs" VPNs were caught keeping logs | Still true | 2026-09-27 |
| Why not to go there (IEB) | In South Africa news and social media are not blocked; the Tor Project offers "bridges" for countries that block Tor | Still true | 2026-09-27 |

### Grade 12 lesson 14 - Keys, SSL and certificates (`encryption`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Two keys | AES keys are 128 or 256 bits; RSA uses keys of 2 048 bits or more | Current recommended sizes | 2026-09-27 |
| SSL, TLS and HTTPS | TLS replaced SSL in 1999; every SSL version is retired; TLS 1.3 (2018) is the newest | A newer TLS version? | 2026-09-27 |
| What the padlock means | Most phishing sites now have a padlock (HTTPS) | Still true | 2026-09-27 |
| What the padlock means (margin) | In 2023 Google's Chrome replaced the padlock with a settings ("tune") icon | Current browser icons | 2026-09-27 |
| Digital certificates | Let's Encrypt has given out free certificates since 2015 and issues more than any other CA; its certificates last 90 days (as in the identify picture and `w14PictureDates`' "about three months") | Let's Encrypt moves to 64 days on 10 February 2027 and 45 days from 16 February 2028 - update `encryption-q-picture.svg` and `w14PictureDates` before February 2027 | 2026-09-27 |
| Digital certificates | Maximum certificate lifetime 200 days since 15 March 2026, 100 days from March 2027, 47 days by 2029 (CA/Browser Forum ballot SC-081) | Schedule unchanged | 2026-09-27 |
| Digital signatures (margin) | The ECT Act (2002) lets an electronic signature count like one on paper; a will still needs ink | Law unchanged | 2026-09-27 |
| Good to Know - quantum computers | The USA's standards body (NIST) published post-quantum encryption standards in 2024; Chrome already uses one beside the old method | Adoption; any quantum break | 2026-09-27 |

### Grade 12 lesson 15 - Cryptocurrency (`cryptocurrency`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| What cryptocurrency is | More than 20 million of the 21 million bitcoins already exist (the 20 millionth was mined on 9 March 2026) | Current supply | 2026-09-27 |
| What cryptocurrency is | USDT and USDC as the main stablecoins; Luno and VALR as South African exchanges | Still the big names | 2026-09-26 |
| What cryptocurrency is | Crypto is legal in South Africa but not legal tender; the Reserve Bank neither issues nor guarantees it | SARB position unchanged | 2026-09-26 |
| Mining and staking | Block reward 3.125 bitcoins since the April 2024 halving (next about 2028) | After the 2028 halving: 1.5625 | 2026-09-26 |
| Mining and staking | Ethereum moved to proof of stake in September 2022, using about 99.9% less energy | History | 2026-09-26 |
| Risks and effects | Bitcoin lost more than half its value within a year in 2018, in 2022 and again from October 2025 to February 2026 (about US$126 000 to about US$60 000) | Add later falls if any | 2026-09-27 |
| Risks and effects | FTX collapsed in 2022, with more than a million customers | History | 2026-09-26 |
| Risks and effects | SARS taxes crypto profits and can get records from South African exchanges (CARF reporting coming) | SARS rules | 2026-09-26 |
| Two South African stories | MTI: Stellenbosch, 2019-2020, about 10% a month, tens of thousands of members in 90+ countries, about 29 000 bitcoin; 2023 SA court ruled it an unlawful Ponzi scheme; a US court ordered its CEO to pay US$1.7 billion restitution | Any new outcome (the CEO was reported to have died in Brazil in April 2024 - not stated in the lesson) | 2026-09-27 |
| Two South African stories | Africrypt: April 2021 "hack" e-mail, liquidation, brothers left SA; early reports R54 billion (US$3.6 billion), later investigations R200 million to R1 billion | Any court findings | 2026-09-26 |
| Crypto and South African law | FSCA declared crypto assets a financial product under FAIS on 19 October 2022; licensing; FSCA list of licensed providers | Rules and list (about 310 providers licensed by 31 March 2026) | 2026-09-27 |
| Crypto and South African law | Crypto businesses accountable institutions under the FIC Act since December 2022 | Still true | 2026-09-26 |
| Crypto and South African law | The FIC's travel rule (Directive 9, in force 30 April 2025): crypto businesses send the sender's and receiver's details with every transfer | Still in force; changes to the directive | 2026-09-27 |
| What cryptocurrency is (margin) | Bitcoin Pizza Day, 22 May 2010, 10 000 bitcoins for two pizzas | History | 2026-09-26 |

### Grade 12 lesson 16 - Cybercrime in depth (`cybercrime12`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Cyber gangs | South African banks warn that criminals recruit money mules at universities and on social media | SABRIC's current warnings | 2026-09-26 |
| Kinds of cybercrime | Ports, hospital laboratories, municipal electricity sales and government departments have been hit in South Africa | Grade 11 threats has the dated cases | 2026-09-26 |
| Internet fraud scams | The table's scams (task scams, fake proof of payment, deepfake calls) are the common ones | Current SAPS/SABRIC scam reports | 2026-09-26 |
| Internet fraud scams | 2024: a Hong Kong office worker paid about US$25 million after a deepfake video call | History | 2026-09-26 |
| Internet attacks | The 2024 xz back door attempt; WannaCry 2017 (in Grade 11) | History | 2026-09-26 |
| Internet attacks | Passkeys and security keys stop session-stealing phishing kits | Still true | 2026-09-26 |
| A botnet's life | Emotet taken over by police from eight countries in 2021 | History | 2026-09-26 |
| Access, privacy and misuse | 2021 Constitutional Court (amaBhungane) ruling: parts of RICA unconstitutional, bulk interception unlawful; RICA amendment | Has RICA been amended? (the amendment bill was sent back in November 2024) | 2026-09-27 |
| The Cybercrimes Act | Act 19 of 2020, mostly in force since 1 December 2021; the 72-hour reporting duty (section 54) not yet in force in 2026 | Has section 54 commenced? | 2026-09-27 |
| The Cybercrimes Act | POPIA: report breaches to the Information Regulator and the people affected | Law unchanged | 2026-09-26 |

### Grade 12 lesson 17 - Evaluating and recommending security (`securityplan`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Five steps | Most successful attacks start with a person (a click, a reused password) | Current breach reports (e.g. Verizon DBIR's "human element") | 2026-09-26 |
| Case study: a bakery | Power cuts "a few times a month" in a Pretoria township; WhatsApp Business two-step verification; POS on a tablet | Power situation; app features | 2026-09-26 |
| Case study: a school | SA-SAMS runs the admin of most public schools; POPIA protects children's information strictly | Still true | 2026-09-26 |
| Case study: a clinic (margin) | POPIA treats health information as special personal information | Law unchanged | 2026-09-26 |

### Lesson 41 - Computers and our society (`society`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#communication` | WhatsApp is the everyday messaging app for most South Africans; voice notes and video calls | DataReportal / GSMA figures for SA app use | 2026-09-26 |
| `#changing` margin | Vodacom and MTN switched on in 1994 | (historical - no check needed) | 2026-09-26 |
| `#communication` | South African Sign Language became the 12th official language in 2023 | Still true (historical) | 2026-09-26 |
| `#work` | Examples of automation (self-checkout, chatbots), jobs shrinking (tellers, call centres) and new jobs; AI now writes, translates and codes | How automation and AI are changing SA jobs | 2026-09-26 |
| `#work` | Remote and hybrid work since the 2020 lockdown; gig work: Uber, Bolt, Mr D, Checkers Sixty60 drivers | The apps and how common remote work still is | 2026-09-26 |
| `#work` | Some countries give workers a legal right to ignore work messages after hours | Whether South Africa has such a law | 2026-09-26 |
| `#money` | Most banked South Africans bank on their phones; PayShap (2023) pays to a cellphone number; tap to pay with phone or watch; cardless ATM withdrawals; banks closing branches | Bank and PayShap news | 2026-09-26 |
| `#money` | Takealot; Checkers Sixty60 and Pick n Pay asap! deliver groceries in about an hour; small businesses sell on WhatsApp and Instagram | The services and their names | 2026-09-26 |
| `#learning` | Google Classroom, Microsoft Teams, Siyavula, past papers online; AI chatbots | Still the tools SA schools use | 2026-09-26 |
| `#learning` margin | UNISA teaches more than 300 000 students, mostly at a distance; the biggest university in Africa | UNISA's enrolment figure | 2026-09-26 |
| `#health` | AI reads chest X-rays for signs of TB in parts of SA; telemedicine; SMS reminders for chronic medicine | Still in use | 2026-09-26 |
| `#health` margin | MomConnect (since 2014) sends messages by SMS and WhatsApp; millions signed up | MomConnect still running | 2026-09-26 |
| `#government`, study | SARS eFiling and auto-assessment (since 2020); online school admissions in Gauteng and the Western Cape; NSFAS and SASSA SRD applications online; Home Affairs appointments booked online, some Smart ID applications at banks; vehicle licences and municipal accounts online | Which services are online; new ones (a digital ID) | 2026-09-26 |
| `#weighingUp` | Whether computers destroy more jobs than they create, and whether social media harms teenagers, are debated | How the research reads now | 2026-09-26 |

### Lesson 42 - The digital divide (`digitaldivide`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatIsIt`, study | About a quarter of the world's people do not use the Internet, most in Africa and South Asia | ITU Facts and Figures (yearly) | 2026-09-26 |
| `#southAfrica`, study | About four in five South Africans used the Internet at the end of 2025 (79.6%); more than 13 million offline | DataReportal "Digital 20xx: South Africa" (each February) | 2026-09-26 |
| `#southAfrica`, study | 4G covers 99.5% of the population, 5G 58%; rural 5G in the Eastern Cape about 7% | ICASA "State of the ICT Sector" report (each March) | 2026-09-26 |
| `#southAfrica`, figure `divide-home-internet`, study | Households 2024: 82.1% any access; 75.6% by cellphone; 17.4% fixed at home (27.2% metros, 2.7% rural); about one in four owns a computer (33.4% metros, 11.2% rural); Western Cape 92.0%, Northern Cape 70.3%, Eastern Cape 70.7% | Stats SA General Household Survey (the newest year) - redraw the bar chart (`digitaldivide_svgs.py`) | 2026-09-26 |
| `#southAfrica` reveal, study | A 1 GB 30-day bundle costs about R85 on the biggest networks; minimum wage R30.23 an hour (March 2026) - almost three hours of work; an hour of YouTube uses about half a GB | Network prices (Vodacom, MTN); the new minimum wage each March | 2026-09-26 |
| `#closing`, study | Smartphones under R2 500 free of the 9% luxury duty since April 2025 | Budget changes | 2026-09-26 |
| `#closing` | SA Connect has connected thousands of schools, clinics and offices and tens of thousands of community Wi-Fi hotspots | What follows SA Connect (phase 2 ended 2025/26) | 2026-09-26 |
| `#closing` | Coding and Robotics is being introduced as a school subject | DBE progress | 2026-09-26 |
| `#closing`, study | Spectrum auctioned in 2022; a 1 GB bundle cost about R149 in 2019 and about R85 now | Current 1 GB price | 2026-09-26 |
| `#closing` | Vodacom ConnectU zero-rates more than a thousand sites; MTN and Vodacom sold 4G smartphones for under R100 to 2G/3G customers | Whether the offers still run | 2026-09-26 |
| `#closing`, study | 2G and 3G to be switched off by the end of 2027 | Switch-off date and progress | 2026-09-26 |
| `#causes` | South Africa has 12 official languages; most of the Internet is in English | Still true | 2026-09-26 |
| identify | Community Wi-Fi at taxi ranks in Tshwane (the caption) | Tshwane free Wi-Fi still running | 2026-09-26 |

### Lesson 43 - Your body and the planet (`bodyplanet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#rsi` | Doctors still argue about how much typing causes carpal tunnel syndrome | Current medical view | 2026-09-26 |
| `#eyes` | Blue light from screens does not damage the eyes; blue-light glasses are not recommended for eye strain | American Academy of Ophthalmology position | 2026-09-26 |
| `#neck` | A 2014 study: head bent at 60 degrees strains the neck like 27 kg | (a published study - no yearly check) | 2026-09-26 |
| `#sleep`, margin | Teenagers need 8-10 hours; Android's Bedtime mode can turn the screen grey | Sleep guidelines; phone features | 2026-09-26 |
| Good to Know | WHO: more than a billion young people risk hearing loss from unsafe listening; the 60/60 rule of thumb | WHO figures | 2026-09-26 |
| `#green`, `#dataCentres` | Most of South Africa's electricity still comes from coal | Eskom's energy mix | 2026-09-26 |
| `#greenUse` | A modern charger with nothing attached uses very little; decoders, consoles and TVs are the bigger standby users | Still true | 2026-09-26 |
| `#greenUse` reveal | Electricity costs about R4 a kWh | Eskom / municipal tariffs (each July) | 2026-09-26 |
| `#eWaste`, study | 62 million tonnes of e-waste in 2022, about a fifth properly recycled; metals worth about US$91 billion | The newest UN Global E-waste Monitor | 2026-09-26 |
| `#eWaste` | South African law has made producers responsible for collecting and recycling electronics since 2021 (extended producer responsibility) | Still in force | 2026-09-26 |
| `#eWaste` | E-waste drop-off bins at many Pick n Pay and Makro stores; Desco takes household e-waste in Johannesburg, Cape Town and Durban | Drop-off points and recyclers | 2026-09-26 |
| `#dataCentres`, study | Data centres used about 415 TWh in 2024 (about 1.5% of world electricity), expected to more than double by 2030, mostly because of AI | The newest IEA figures | 2026-09-26 |
| `#dataCentres` | Google (2025): a typical Gemini text prompt uses about as much energy as less than nine seconds of TV; training a large model uses as much as hundreds or thousands of homes a year | Newer published figures | 2026-09-26 |
| `#dataCentres` margin | Microsoft's undersea data centre test off Scotland, 2018-2020 | (historical - no check needed) | 2026-09-26 |

### Lesson 44 - Plagiarism (`plagiarism`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whyMatters` | University penalties: zero for the task, failing the course, expulsion for repeat offences are common | Current university policies | 2026-09-26 |
| `#copyright` margin | "Blurred Lines" case: 2015 verdict, about US$5 million set in 2018 | (historical - no check needed) | 2026-09-26 |
| `#ai`, study | Chatbots invent facts and references; schools set different AI rules | How reliable chatbots are now; school and exam-board AI rules | 2026-09-26 |
| `#ai`, study | The IEB PAT allows at most 20% borrowed or AI-generated code, referenced | The current IEB PAT guidelines (also in the Pascal course's IEB PAT lesson) | 2026-09-26 |
| `#referencing` | Many South African schools and universities use Harvard style; the patterns for a book, a web page and an AI tool | Still the usual school style | 2026-09-26 |
| `#detecting`, study | Turnitin compares work with web pages, publications and earlier essays; version history in Google Docs and Word online | Still how the tools work | 2026-09-26 |
| `#detecting` margin, study | AI detectors are not reliable; OpenAI withdrew its AI-text classifier in 2023 | Whether detectors have become reliable | 2026-09-26 |

### Lesson 45 - Theory for practical work (`practicaltheory10`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#algorithms` | The IEB wants pseudocode, not Delphi or Java code; any clear form is accepted | The latest IEB and CAPS memos | 2026-09-26 |
| `#ipoTables` | CAPS papers and the CAPS PAT use IPO tables | The current CAPS PAT guidelines | 2026-09-26 |
| `#traceTables` | Exam trace tables give the columns and first row; you add rows | Recent papers | 2026-09-26 |
| `#userInterface` | The IEB's six interface principles; CAPS's HCI points (grouping, panels or tabs) | The current SAGs and CAPS | 2026-09-26 |
| `#testing` | Test data names: normal/standard, extreme/boundary, erroneous/abnormal | What the newest papers call them | 2026-09-26 |

## CAT Theory

The CAT Theory lessons are `AIPascalCourse/content/cattheory10/<lessonId>.php`,
`cattheory11/<lessonId>.php` and `cattheory12/<lessonId>.php`; the anchor is the
section (`#anchor`), and "questions" means the question blocks or scenario after
it. The CAT lessons were written on 6-8 October 2026, most of them from the IT
Theory lessons above, so many claims here (VAT, prepaid, Android's share, free
cloud space, the digital-divide figures, SABRIC, e-waste, Starlink, the AI
policy) are the same facts as an IT row: a fact checked and fixed in an IT row
must be fixed in the CAT lesson too, and the other way round. The rand prices
are round, VAT included, and were set for late 2026; several lessons quote the
same thing (a 2 TB drive, a UPS, a cloud plan), so keep them in step.

### Grade 10

#### Lesson 1 - What a computer is, and the IPO model (`computer`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#storage` (margin), `#why`, questions | Load shedding as the everyday power cut that loses unsaved work and stops a computerised system (the load-shedding-ram doodle; the clinic question's rubric) | Whether load shedding is still the example pupils know; if not, say "a power cut" | 2026-10-09 |

#### Lesson 2 - Kinds of computing devices (`devices`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#multipurpose`, study | For most South Africans the phone is the main computer - often the only one | Stats SA / GSMA figures (as the IT row for `kindsofcomputers` `#mobile`) | 2026-10-09 |

#### Lesson 4 - ICT systems around you (`ictsystems`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#till`, study, glossary (VAT) | VAT is 15% on most goods and services; shelf prices must include it | The VAT rate (Budget speech each February) | 2026-10-09 |
| `#till` (try-it) | Example selling price R16.10, VAT included | Still a believable shop price | 2026-10-09 |
| `#cellphone`, study | Most South Africans are on prepaid; a contract bill adds the monthly fee, extra use and VAT; a WhatsApp voice note comes off the data bundle | ICASA / network figures; billing practice | 2026-10-09 |
| `#whyuse` | Load shedding as one cause of a power cut that stops card payments | As lesson 1 | 2026-10-09 |

#### Lesson 5 - Inside the box (`systemunit`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cpu` | Most laptops and phones run at about 2 to 5 GHz; most phones have 8 cores, most laptops and desktops 4 to 16 | Typical new devices | 2026-10-09 |
| `#ram`, questions | Load shedding loses the paragraph you never saved; the bakery order question and its UPS / inverter answer | As lesson 1 | 2026-10-09 |
| `#memVsStorage` (try-it) | Windows 11 path: Start, Settings, System, About (Processor, Installed RAM), then System, Storage; on a phone Settings, About phone | Still the Windows 11 names | 2026-10-09 |
| `#memVsStorage` questions | Laptop advert: 8 cores up to 4.4 GHz, 16 GB RAM, 512 GB SSD, R12 999 | A believable advert and price | 2026-10-09 |

#### Lesson 6 - Input devices - keyboards and pointing (`input`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#mouse` | Pairing a Bluetooth mouse in Windows: Settings, Bluetooth & devices, Add device | Still the Windows 11 names | 2026-10-09 |

#### Lesson 7 - Scanning and reading devices (`scanning`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#barcode` | Example price: "Brown bread, R19.99" | Still a believable bread price | 2026-10-09 |
| `#qr`, questions, study | Paying by QR code with SnapScan, Zapper or a bank's app; linking WhatsApp to a computer with a QR code | Still the QR payment apps used in South Africa | 2026-10-09 |
| `#scanners` | Most people now scan with their phone | Still true | 2026-10-09 |

#### Lesson 8 - Cameras, microphones and biometrics (`cameras`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cameraSpecs`, questions | Most cheap phones have digital zoom only; a 50-megapixel phone camera as the example | Whether budget phones now have optical zoom; typical megapixels | 2026-10-09 |
| `#webcam` | Most laptops have a webcam above the screen with a light; camera permissions in Settings, Privacy & security, Camera | Still true; the Windows 11 names | 2026-10-09 |

#### Lesson 9 - Output - screens and projectors (`screens`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#resolution`, study | 4K for TVs and expensive monitors; a 24-inch Full HD monitor costs about R2 000 | Prices; whether QHD or 4K has become the normal monitor | 2026-10-09 |
| `#projectors` | A data projector about R8 000 to R12 000; a 65-inch TV about R12 000; an interactive panel R40 000 or more; Windows key + P, Duplicate | Prices; the Windows shortcut | 2026-10-09 |
| `#visualisers` questions, study | R12 000 buys a Full HD projector of 3 600 lumens or a 65-inch TV; the No Signal fix uses Windows key + P | Prices (keep in step with `#projectors`) | 2026-10-09 |

#### Lesson 10 - Output - printers (`printers`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#costs` reveal and doodle | Mr Botha's inkjet cost R900; R7 200 a year on ink | Prices | 2026-10-09 |
| `#inkjet`, `#laser`, `#printing3d`, questions | An inkjet from about R1 200; an ink tank printer about R3 500, popular in South African homes and small offices; a mono laser about R2 500, a colour laser about R5 000; a school 3D printer about R5 000 | Prices (rand, VAT included) | 2026-10-09 |
| `#costs`, questions | Inkjet cartridge R300 for 200 pages (R1.50 a page); laser toner R1 200 for 1 600 pages (75c); ink tank bottle R150 for 4 500 pages (about 3c); "a mono laser (about R2 500) costs about R1 600 more than his R900 inkjet" | Cartridge prices and page yields; keep the R1 600 in step with the printer prices | 2026-10-09 |
| `#printQueue`, questions, study | Windows 11 paths: Settings (Windows key + I), Bluetooth & devices, Printers & scanners, the printer, Open print queue; "Let Windows manage my default printer" | Still the Windows 11 names | 2026-10-09 |

#### Lesson 11 - Storage devices and media (`storage`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#hdd`, `#flash` | A 2 TB external hard drive costs about R1 400; a 64 GB flash drive about R120 | Prices (keep in step with CAT 11 `storagecloud`, `protecting` and CAT 12 `securityplan`) | 2026-10-09 |
| `#optical` | Most new laptops have no optical drive | Still true | 2026-10-09 |
| `#cloud`, study | Google Drive, OneDrive, iCloud and Dropbox; free space: Google 15 GB, OneDrive and iCloud 5 GB; about R40 a month for 100 GB | Free space and prices | 2026-10-09 |
| `#choosing` questions | R1 500 buys a 1 or 2 TB external hard drive for 300 GB of photos | Prices | 2026-10-09 |

#### Lesson 12 - Ports, connectors and peripherals (`ports`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#usb`, study | USB 2 slow, USB 3 fast, USB4 fastest (USB-C only); USB-C is taking over - EU phones since the end of 2024, iPhones since 2023; "one charger now fits almost everything" | New USB versions; how far USB-C has spread | 2026-10-09 |
| `#plugPlay`, study | Adding a wireless printer or Bluetooth mouse: Settings, Bluetooth & devices, Add device (or Printers & scanners, Add device) | Still the Windows 11 names | 2026-10-09 |

#### Lesson 13 - What software is, and the GUI (`software`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#kinds`, `#otherUis`, questions | Windows on most laptops, Android on most phones; Windows 11 as the example OS; WhatsApp as the example app throughout | StatCounter (as the IT row for `oscompared`); still the app pupils use | 2026-10-09 |

#### Lesson 14 - The operating system (`os`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#kinds`, study | Windows 11 is the current version; Windows on most laptops and desktops; Android on about three in four phones in South Africa (StatCounter, August 2026), from under R1 000; iPads run iPadOS | StatCounter; a new Windows version; phone prices | 2026-10-09 |
| `#updates` | Windows 10's support ended on 14 October 2025; home users could sign up for extra security updates, to October 2027 (Microsoft extended them in 2026) | After October 2027 the extra updates are over - reword | 2026-10-09 |
| `#settings` (IEB), questions, study | The Settings app (Windows key + I) and its Windows 11 categories, with the Windows 10 names beside them (Devices - Bluetooth & devices; Ease of Access - Accessibility; Game DVR - Captures); Windows key + L and + G; Display Scale 125% | Windows 11 Settings names | 2026-10-09 |

#### Lesson 15 - Application software and apps (`apps`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatApps`, `#office`, study | Office suites: Microsoft 365 (Word, Excel, PowerPoint, Outlook, Access in some versions), Google Workspace, LibreOffice; Canva for presentations | The suites' names and contents | 2026-10-09 |
| `#moreKinds` | Chrome, Edge, Safari, Firefox; WhatsApp; Teams, Zoom, Google Meet; Canva; Spotify, YouTube, Netflix; AI chatbots (ChatGPT, Gemini, Copilot) "a newer kind of application" | Still the main names; whether chatbots are still "newer" | 2026-10-09 |
| `#basicApps`, questions, study | Print Screen opens the Snipping Tool on an up-to-date Windows 11 (older set-ups copy the screen); Windows key + Shift + S | Windows 11 behaviour | 2026-10-09 |
| `#appStores`, `#universal`, study | Google Play, Apple's App Store (Mac App Store), the Microsoft Store, AppGallery on newer Huawei phones; (IEB) universal apps for Windows 10 and 11 | The stores; whether Microsoft still uses "universal app" | 2026-10-09 |

#### Lesson 16 - Buying and owning software (`licences`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#licence` | A game for R600 | Price | 2026-10-09 |
| `#openSource`, `#freeShare`, `#piracy` questions, study | WhatsApp, Chrome and Acrobat Reader as freeware; Linux, LibreOffice, Firefox, VLC and GIMP as open source; Android built on open-source code | Licences unchanged | 2026-10-09 |
| `#subscription`, study, `#subscription` (margin) | Microsoft 365, Adobe Creative Cloud, Canva Pro and Spotify Premium as subscriptions; the worked example (R2 400 to buy, or R150 a month); "most new software is now sold this way"; the gem-shop doodle's R19.99 | Prices; still sold this way | 2026-10-09 |

#### Lesson 17 - Files, folders, drives and paths (`files`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#drives`, `#tree`, study | Cloud drives: OneDrive, Google Drive, iCloud Drive, Dropbox | Still the main services | 2026-10-09 |
| `#explorer`, questions, study | File Explorer in Windows 11 (the explorer-window figure): command bar, address bar with breadcrumbs, navigation pane with Home, OneDrive, This PC and Network; Windows key + E | Windows 11 File Explorer layout | 2026-10-09 |

#### Lesson 18 - File types and extensions (`filetypes`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#showing`, questions, study | Show extensions: File Explorer, View (command bar) > Show > File name extensions | Windows 11 menus | 2026-10-09 |
| `#saveas` | With AutoSave on, Microsoft 365 calls Save As "Save a Copy"; File > Export > Create PDF/XPS | Office menu names | 2026-10-09 |
| `#media` | .mp4 is the most common video file and the one most phones record; .m4a for Apple Music | Still true | 2026-10-09 |

#### Lesson 19 - Managing files (`managefiles`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#selecting`, `#create`, `#rename`, `#copymove`, `#delete`, `#views`, `#compress`, `#keys`, questions | File Explorer's command bar (New, Rename, Copy, Delete, Restore the selected items, View, Sort, Extract all); View > Show > Item check boxes; Sort > Group by; right-click Compress to > ZIP File (some versions: Compress to ZIP file); OneDrive's own recycle bin | Windows 11 File Explorer names | 2026-10-09 |

#### Lesson 20 - File properties (`properties`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#attributes`, `#columns`, questions, study, glossary (hidden file) | View > Show > Hidden items; View > Details; View > Show > Details pane (Alt + Shift + P) | Windows 11 File Explorer names | 2026-10-09 |

#### Lesson 21 - Why networks exist (`whynetworks`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#advantages` | Thirty small inkjets at about R1 500 each (about R45 000) against one good network laser at about R8 000 | Prices (keep in step with lesson 10) | 2026-10-09 |
| `#disadvantages` | Load shedding as one cause of a network going down | As lesson 1 | 2026-10-09 |

#### Lesson 23 - Network devices and connections (`netdevices`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#pairing`, study | Pairing on a phone or tablet: Settings, Bluetooth | Still the phone menu names | 2026-10-09 |

#### Lesson 24 - The Internet and getting connected (`internet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#isp` | Mobile ISPs: Vodacom, MTN, Cell C, Telkom, rain; fibre ISPs: Afrihost, Webafrica, Vox | Still the main names | 2026-10-09 |
| `#connecting`, study | ADSL on its way out as Telkom switches its copper off; 4G and 5G are today's networks; mobile data is the dearest per GB; LTE/5G routers popular | Progress of the copper switch-off; 6G | 2026-10-09 |
| `#updown` | Most packages give a faster download than upload speed | Still true | 2026-10-09 |
| `#cloud`, `#goodBad`, questions, study | Data centres owned by Google, Microsoft and Apple; Microsoft 365 (once Office 365) and Google Docs as web apps; load shedding (or a fibre fault) as the reason the cloud is out of reach | Names; as lesson 1 | 2026-10-09 |

#### Lesson 25 - The Web, URLs and websites (`web`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#kinds`, questions, study | Facebook, Instagram and TikTok as social networks; vlogs usually on YouTube; Microsoft 365 (once Office 365), Google Drive and OneDrive as web apps; load shedding as the reason a web app cannot be reached | Still the main names | 2026-10-09 |
| `#moreKinds`, questions | News24 and the SABC's site; YouTube, Netflix; Takealot and Checkers Sixty60; Home Affairs smart ID appointments booked online | Still operating; still the best examples | 2026-10-09 |

#### Lesson 26 - Browsing and searching well (`searching`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#keywords` (and doodle) | Load shedding as Thabo's project topic ("millions of pages, mostly schedules") | Whether load shedding is still a live topic | 2026-10-09 |
| `#browsers`, study | Chrome the most used browser; Edge comes with Windows, Safari with Apple devices, Samsung Internet with Samsung phones; Firefox from a non-profit | StatCounter browser share | 2026-10-09 |
| `#features`, questions | Chrome's home page is set under On startup; Edge calls bookmarks favourites | Browser setting names | 2026-10-09 |
| `#engines`, study | More than a billion websites; Google, Bing (built into Windows and Edge) and DuckDuckGo | Still true | 2026-10-09 |
| `#keywords` reveal | SASSA's older persons grant and its December payment dates as the example search | Still the grant's name | 2026-10-09 |

#### Lesson 27 - E-mail (`email`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#attachments`, questions, study | Gmail allows 25 MB per message, attachments included; send a Google Drive or OneDrive link (or YouTube) instead | Gmail's limit | 2026-10-09 |

#### Lesson 28 - Other ways to communicate online (`onlinecomms`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#messaging` | An MMS costs more than an SMS; most people now send photos and videos in a chat app | Still true | 2026-10-09 |
| `#im`, study | WhatsApp is by far the most used IM app in South Africa; Telegram, Signal and Instagram and TikTok messages; a WhatsApp group holds more than a thousand people; IM replaced SMS for most people | Usage figures; WhatsApp's group size | 2026-10-09 |
| `#social`, questions | Facebook (and Marketplace), Instagram, TikTok, X (once Twitter), YouTube and LinkedIn, and what each is used for | Names; whether X has been renamed again | 2026-10-09 |
| `#publishing`, `#location` | Podcasts followed in Spotify; vlogs on YouTube; live location in WhatsApp or Google Maps | Still true | 2026-10-09 |
| `#meetings`, questions, study | Microsoft Teams, Zoom and Google Meet the best known; load shedding cuts you out of a meeting | Names; as lesson 1 | 2026-10-09 |

#### Lesson 29 - Threats online (`threats`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | SABRIC, 2025: two bank robberies; more than 110 000 digital banking crimes; about R2.4 billion lost | The newest SABRIC annual crime statistics (as the IT row for `malware`) | 2026-10-09 |
| `#phishing` | SARS's addresses end in sars.gov.za; SARS never sends links like this | SARS's current advice | 2026-10-09 |

#### Lesson 30 - Staying safe (`safety`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#passwords`, study, glossary (strong password) | 15 characters or more, unique, not personal, changed only for a reason (NIST SP 800-63B, August 2025); computers try billions of guesses a second | NIST guidance (as the IT row for `protecting`) | 2026-10-09 |
| `#popi`, study | The Information Regulator can fine up to R10 million; adverts by SMS, e-mail or WhatsApp only if you agreed (or are a customer) | The POPI Act and its regulations | 2026-10-09 |

#### Lesson 31 - ICTs in everyday life (`ictlife`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#everyday`, `#lifestyle` | Homework on Google Classroom or Teams; buying prepaid electricity on the phone; groceries arrive in an hour; "now most carry one in a pocket" | Still true | 2026-10-09 |
| `#divide`, study | About four in five South Africans online at the end of 2025, mostly on a phone; about one household in six with fixed-line Internet; about one in four owns a computer (Stats SA GHS 2024); zero-rated learning and job sites; free Wi-Fi in libraries | The newest GHS and ICASA figures (as the IT rows) | 2026-10-09 |
| `#crypto`, questions | Bitcoin lost more than half its value between October 2025 and February 2026; not legal tender; a financial product (licensed) since 2022 | Newer swings; the FSCA rules | 2026-10-09 |

#### Lesson 32 - Your body and the planet (`bodyplanet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#greenUse` reveal | Electricity about R4 a unit (kWh); 73 kWh of standby is about R290 a year | Eskom / municipal tariffs (each July) | 2026-10-09 |
| `#ewaste` | About 62 million tonnes of e-waste in 2022, about a fifth properly recycled; e-waste bins at many big stores; since 2021 the law makes sellers help collect and recycle | The newest Global E-waste Monitor; drop-off points (as the IT row for `green`) | 2026-10-09 |
| `#green` (margin) | The upgrade doodle: "same phone, new colour, R20 000" | A flagship phone's price | 2026-10-09 |

#### Lesson 33 - Owning ideas (`ownideas`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#ip`, study | Copyright is automatic; a book is protected until 50 years after its author dies (Copyright Act 98 of 1978) | Whether the Copyright Amendment Bill (which adds fair use) has become law | 2026-10-09 |

#### Lesson 35 - Finding and judging information (`findjudge`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#sifting`, `#notes` questions | "Recent" sources are dated 2024-2026 (a 2025 university study, a 2024 UN report, a 2026 news report in the sift figure); "old" ones 2011-2014 | Move the years on so that the recent ones still read as recent | 2026-10-09 |
| `#wikipedia` | Millions of volunteers write Wikipedia | Still true | 2026-10-09 |

Nothing dated: `datainfo`, `networkkinds`, `questions`, `reports`.

### Grade 11

#### Lesson 1 - Inside the system unit, a step deeper (`insidedeeper`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#specs`, questions | Advert lines: Intel Core Ultra 5 (12 cores, up to 4.5 GHz) with Intel Arc graphics; NVIDIA RTX 5060 8 GB; AMD Ryzen 7 (8 cores, up to 5.1 GHz) | Current processor and graphics card names | 2026-10-09 |
| `#trouble` questions | The supplier's desktop: 6 cores, 16 GB DDR4, 512 GB SSD, integrated graphics, R11 499 | A believable spec and price | 2026-10-09 |

#### Lesson 2 - What makes a computer fast (`performance11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#ram` | 16 GB comfortable for most people; DDR5 faster than DDR4 | Typical new laptops; DDR6 | 2026-10-09 |
| `#drive` | An SSD, about R600 for 512 GB, is usually the best upgrade for an old laptop | Price | 2026-10-09 |
| `#running`, questions | Stop start-up programs in Settings, Apps, Startup | Still the Windows 11 names | 2026-10-09 |
| `#booting` questions | Two laptops at R9 999 and R10 999 | Prices | 2026-10-09 |

#### Lesson 3 - Input and output for everyone (`accessio`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#everyone` | A braille display costs from about R20 000 | Price | 2026-10-09 |
| `#colourDuty`, study | Typical duty cycles: a small home inkjet about 1 000 to 5 000 pages a month, an office laser 50 000 or more | Typical printers | 2026-10-09 |
| `#screens`, `#trouble`, `#sound` (IEB), questions, study | Windows 11 paths: Display settings (Settings, System, Display; Scale 125% or 150%); keyboard layout in Settings, Time & language, Language & region; Settings, System, Sound (output, input level bar, volume mixer); Settings, System, Troubleshoot, Other troubleshooters, Audio; Settings, Privacy & security, Microphone | Still the Windows 11 names (checked against Microsoft's sound help, 9 October 2026) | 2026-10-09 |
| `#sound` questions | Printer quotes: A R2 499, B R6 999; toner 25c against 90c a page | Prices | 2026-10-09 |

#### Lesson 4 - Primary and secondary storage, and the cloud (`storagecloud`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#backup`, `#adverts` | 2 TB external hard drive about R1 400 (advert: 2 TB portable HDD R1 399); 1 TB portable SSD R1 799; 256 GB microSDXC U3 V30 R399; cloud 100 GB for R40 a month or R400 a year; the per-GB sums (70c, R1.80, R4) | Prices (keep in step with CAT 10 `storage`) | 2026-10-09 |
| `#saas` | Gmail, Canva, Spotify; OneDrive, Google Drive, iCloud | Still the examples | 2026-10-09 |
| `#trouble`, study | Settings, System, Storage; Storage Sense; OneDrive's "Free up space"; phones: Settings, Storage (Android) or General, iPhone Storage | Windows 11 and phone menu names | 2026-10-09 |

#### Lesson 5 - Installing, updating and uninstalling (`installing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#where`, questions | A game that costs R900 in the shops | Price | 2026-10-09 |
| `#activation` | Settings, System, Activation; most new laptops come activated with a digital licence; Microsoft 365 and most phone apps activate by signing in | Still true | 2026-10-09 |
| `#updates`, questions, study | WhatsApp 2.26.4 as the version example; Windows 10 and 11 get a monthly bundle instead of service packs; Windows 10 to 11 as the upgrade example; Settings, Windows Update, Check for updates; metered connection in Settings, Network & internet | The WhatsApp version number; Windows' update model | 2026-10-09 |
| `#uninstalling`, `#driversIeb`, questions, study | Settings, Apps, Installed apps (three dots, Uninstall); Settings, Windows Update, Advanced options, Optional updates; the Task Scheduler | Still the Windows 11 names | 2026-10-09 |

#### Lesson 6 - Cloud applications and working together (`cloudapps`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#suites`, `#google`, study | Microsoft 365 (Word, Excel, PowerPoint, Outlook, OneDrive, Teams), the web versions free with a Microsoft account, AutoSave to OneDrive; Google Workspace (Docs, Sheets, Slides, Gmail, Drive, Meet, Classroom); OneDrive 5 GB and Google Drive 15 GB free; Google Docs offline in Chrome | Suite contents and free space (as CAT 10 `storage` `#cloud`) | 2026-10-09 |
| `#sharing`, `#together`, questions | Word for the web and Google Docs: Share, Copy link, Can edit / Can view, Viewer / Commenter / Editor, "Anyone with the link", version history newest first; Teams and Google Classroom as collaboration software | Menu names | 2026-10-09 |

#### Lesson 7 - Software for users with disabilities (`assistive`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#seeing`, `#hearing`, `#moving`, `#settings`, study | Windows 11 shortcuts: Narrator Windows key + Ctrl + Enter; Magnifier Windows key + plus (+ Esc closes); live captions Windows key + Ctrl + L; voice typing Windows key + H; on-screen keyboard Windows key + Ctrl + O; Sticky Keys by pressing Shift five times; Voice access (Windows Speech Recognition removed in 24H2); Read Aloud in Word (Review) and Edge | Still the Windows 11 shortcuts and names | 2026-10-09 |
| `#settings`, questions, study | Settings, Accessibility (Windows 10: Ease of Access) - Vision, Hearing, Interaction; Text size; phones: Settings, Accessibility (TalkBack, Live Caption; VoiceOver, Zoom, Voice Control) | Windows 11 and phone menu names | 2026-10-09 |

#### Lesson 8 - System requirements and a slow computer (`sysreqs`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#compatible` (margin), `#requirements` | Windows 11's own requirements (a recent processor on Microsoft's list, 4 GB RAM, 64 GB storage); Windows 10 support ended on 14 October 2025 | Windows' requirements; a new Windows version | 2026-10-09 |
| `#checking`, `#slow`, `#fixes`, questions, study | Settings, System, About (Windows key + Pause) - Processor, Installed RAM, Edition, Version; Settings, System, Storage; Settings, Apps, Startup; Windows Security, Virus & threat protection, Protection updates; Task Manager (Ctrl + Shift + Esc), Performance; Disk Clean-up; phone Settings, About phone | Still the Windows 11 names | 2026-10-09 |

#### Lesson 9 - Managing files properly (`filesproper`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#setup`, `#group`, `#search`, questions, study | File Explorer: View > Show > File name extensions, Hidden items, Preview pane (Alt + P), Details pane; Sort > Group by > (None); Search options > Advanced options > File contents; date filters | Windows 11 File Explorer names | 2026-10-09 |
| `#import`, `#details` | Office paths: Access External Data > New Data Source > From File > Text File; Word Insert > Object > Text from File; Excel File > Save As (or Save a Copy) > CSV (Comma delimited); File > Info | Office menu names | 2026-10-09 |

#### Lesson 11 - Topologies and cables (`topologies`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cables` (margin) | Copper cable theft is one reason Telkom is replacing its copper lines with fibre | Progress of the copper switch-off | 2026-10-09 |
| `#moreCables` | UTP Cat 5e (1 Gbps) in most homes, schools and offices | Still the usual cable | 2026-10-09 |

#### Lesson 12 - Wired or wireless, and how fast (`wiredwireless`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#adverts`, questions | Fibre up to 100 Mbps (100/50) for R799 a month, month-to-month, free installation; some packages lock you in for 24 months; Advert A fibre 50/50 R699, Advert B 5G up to 300 Mbps R599 | Fibre and 5G prices | 2026-10-09 |
| `#speed` | Home Internet sold as 25, 50 or 100 Mbps; 5G on a phone often 100 Mbps or more | Typical packages | 2026-10-09 |
| `#routerBox`, study | Wi-Fi 6 on the router box (newer than Wi-Fi 5); WPA3 the newest Wi-Fi security | Wi-Fi 7 in ordinary routers; a newer WPA | 2026-10-09 |

#### Lesson 14 - Mobile Internet - hotspots, 4G and 5G (`mobileinternet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#generations`, study | Most of South Africa has 4G; 3G is being switched off; 4G 10 to 50 Mbps, 5G often 100 Mbps or more | 3G switch-off (done?); coverage figures | 2026-10-09 |
| `#fiveG`, questions | 5G built in cities first, small towns and rural areas still on 4G; any smartphone today does 4G | 5G coverage | 2026-10-09 |
| `#wimax` (IEB), study | WiMAX mostly replaced by LTE and 5G | Still true | 2026-10-09 |
| `#dataService`, study | Worked example: 1 GB for R89, 49c a MB out of bundle; app and night bundles; zero-rated sites | Bundle and out-of-bundle prices | 2026-10-09 |
| `#dataUse` | Data per activity (a WhatsApp text a few KB, a photo 0.1 to 0.5 MB, and so on) | Still about right | 2026-10-09 |
| `#personalHotspot`, `#dataUse`, `#savingData`, questions | Phone paths: Settings, Network & internet (Samsung: Connections), Hotspot & tethering; iPhone Settings, Personal Hotspot; Data usage; Data Saver (iPhone: Low Data Mode) | Android and iPhone menu names | 2026-10-09 |

#### Lesson 15 - E-mail at work, VoIP and video calls (`voipvideo`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#signature` | Outlook: Settings > Mail > Compose and reply; Gmail: Settings > General > Signature | Menu names | 2026-10-09 |
| `#voip` (margin), `#voip`, study | Telkom is switching off copper; many landline numbers now run over fibre or wireless as VoIP; WhatsApp, Teams, Zoom, Google Meet, FaceTime calls | Progress of the copper switch-off | 2026-10-09 |
| `#videoConf`, `#goodPractice`, questions, study | Load shedding cuts people out of a meeting; "check the load-shedding schedule"; meet outside load-shedding slots | As CAT 10 lesson 1 | 2026-10-09 |
| `#fileSharing` questions | The e-mail attachment limit is about 25 MB | Still true | 2026-10-09 |
| `#online`, `#online` (margin), study | Takealot, Checkers Sixty60, Woolworths; Mr D, Uber Eats; Facebook Marketplace, Gumtree; SARS eFiling and the SARS app; Home Affairs smart ID bookings; most tax returns sent online; TV licence and voter registration online | Still operating; still the best examples | 2026-10-09 |

#### Lesson 16 - The Internet of Things (`iot`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#goodBad` questions | Load shedding as the scenario (the freezer alert at 02:14; "load shedding is common in her area") | As CAT 10 lesson 1 | 2026-10-09 |
| `#home` | Many homes have solar inverters and batteries "since the years of load shedding"; Google Home and Amazon Alexa | Product names | 2026-10-09 |
| `#meters` | Most South African homes have a prepaid meter with a keypad and a 20-digit token | Still true | 2026-10-09 |
| `#health` | Discovery Vitality rewards steps and workouts | Still running | 2026-10-09 |

#### Lesson 17 - The Fourth Industrial Revolution, VR and AR (`fourir`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#ar` | Most people meet AR on a phone; filters on Snapchat, Instagram and TikTok | Still true | 2026-10-09 |
| `#difference`, `#prosCons` | A good VR headset costs about as much as a mid-range phone; PC VR also needs a gaming computer | Headset prices | 2026-10-09 |

#### Lesson 18 - Judging a website and its usability (`usability`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#mobile` | Most South Africans visit websites on a phone | StatCounter mobile share | 2026-10-09 |
| `#navigation` questions | The breadcrumb example Home > Phones > Samsung > Galaxy A16 | A current phone model | 2026-10-09 |

#### Lesson 19 - Threats to a computer and its data (`threats11`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#whatThreat` | Thabo's laptop cost R8 000 | Price | 2026-10-09 |
| `#misuse`, study | The Cybercrimes Act (2020) makes most of these crimes | Still in force; amendments | 2026-10-09 |
| `#theft`, questions, study | Find Hub on Android (Google's name since May 2025), Find My on Apple devices | The services' names | 2026-10-09 |
| Start here, `#power`, `#powerFix`, `#summary` | Load shedding as a cause of power cuts and the surge after; thousands of homes and businesses put in inverters during the years of heavy load shedding | As CAT 10 lesson 1 | 2026-10-09 |
| `#powerFix` | Rough prices: surge protector R250 to R500; UPS R700 (router) to R3 000; inverter and batteries R15 000 and up; generator R5 000 and up; a UPS lasts minutes, a router UPS hours | Prices (keep in step with CAT 12 `securityplan` `#power`) | 2026-10-09 |

#### Lesson 20 - Social engineering, phishing and pharming (`socialeng`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#phishing`, `#scams`, study | The WhatsApp code takeover as the common scam; two-step verification in WhatsApp's Settings, Account, Two-step verification | WhatsApp's menu names; the commonest scams | 2026-10-09 |
| `#identity`, study | SAFPS Protective Registration is free | Still free | 2026-10-09 |
| `#scams` questions | AnyDesk as the remote-access app in the "bank's fraud department" call | Still the app criminals use | 2026-10-09 |

#### Lesson 21 - Protecting yourself online (`protecting`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#antiMalware`, `#firewall` | Microsoft Defender in the Windows Security app, enough for most people; Firewall & network protection | Still built in | 2026-10-09 |
| `#mfa`, `#permissions`, study | Many South African banks now ask you to approve in the app; WhatsApp: Settings, Account, Two-step verification; the phone's permission manager in Settings | Bank practice; menu names | 2026-10-09 |
| `#https` (margin) | Chrome replaced the padlock with a settings icon in 2023; TLS is the newer SSL | Browser icons | 2026-10-09 |
| `#backups` | An external drive about R1 400 for 2 TB, or a monthly cloud fee; phone backup to Google or iCloud | Price (keep in step with CAT 10 `storage` and `storagecloud`) | 2026-10-09 |
| `#backupDrive` (IEB) | File History: Control Panel > System and Security > File History; Select drive; Turn on; every hour by default; Restore personal files | Still in Windows 11 (checked 9 October 2026) | 2026-10-09 |

#### Lesson 22 - Work in a digital world (`digitalwork`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#gig` | E-hailing (Uber, Bolt) and delivery riders (Mr D, Uber Eats); the app keeps often 20% or more | Names; the platforms' share | 2026-10-09 |
| `#remote` | Load shedding as the example power cut that stops remote work | As CAT 10 lesson 1 | 2026-10-09 |

#### Lesson 23 - Artificial intelligence (`ai`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#meetAi`, `#chatbots` | ChatGPT, Gemini, Copilot and Claude as chatbots; TikTok, YouTube and Instagram feeds; AI reading X-rays for TB | Still the main names (as the IT row for `ai12`) | 2026-10-09 |
| `#honest` (margin) | South Africa's draft national AI policy was withdrawn in April 2026 | Whether a new policy has been published (as the IT row for `ai12` `#society`) | 2026-10-09 |

#### Lesson 24 - Big data (`bigdata`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#who` | Loyalty cards: Checkers Xtra Savings, Pick n Pay Smart Shopper, Clicks ClubCard; TikTok, Instagram, Google; Discovery Vitality | Programme names | 2026-10-09 |

#### Lesson 25 - When computers get it wrong (`whenwrong`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#hardware` (margin) | About 1 or 2 hard drives in every 100 fail each year (Backblaze, 2023-2025) | The newest Backblaze drive report | 2026-10-09 |
| `#validation` | Excel: Data > Data Validation; Access: Validation Rule and Validation Text | Office names | 2026-10-09 |

#### Lesson 27 - Judging sources - and AI as a source (`judgingai`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | The draft national AI policy published and withdrawn in April 2026 | Whether a new policy has been published; reword "In April 2026" as time passes | 2026-10-09 |
| `#hallucinate`, `#aicheck` | South Africa's driving ages: a learner's licence at 17, a driving licence at 18 | Still the law | 2026-10-09 |
| `#aiwhat` | ChatGPT, Gemini, Copilot and Meta AI in WhatsApp | Still the main names | 2026-10-09 |
| `#aihonest` | The Harvard example for a chatbot: OpenAI (2026) ChatGPT, chatgpt.com, accessed 14 May 2026 | The URL; move the year on | 2026-10-09 |

#### Lesson 28 - Processing data in a spreadsheet and a database (`processingdata`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#database` (margin) | An Excel worksheet has 1 048 576 rows and 16 384 columns, unchanged since Excel 2007 | Still the limit | 2026-10-09 |

Nothing dated: `lanwlan`, `netsafety`, `writequestions`.

### Grade 12

#### Lesson 1 - Choosing a computer for a job (`choosing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#sideBySide`, questions | Laptop A R6 499 (Intel N150, 4 cores; 8 GB soldered RAM; 128 GB eMMC; HD 1366 x 768; Windows 11 Home in S mode); Laptop B R13 999 (AMD Ryzen 5, 6 cores); a R14 000 budget; the R7 500 difference | Realistic South African prices and specs (set for late 2026) | 2026-10-09 |
| `#adLines`, study | Intel's N series as budget chips; Windows 11 Home or Pro, macOS, ChromeOS; S mode can be switched off free in Settings; 4K only on expensive screens | Processor names; whether S mode still exists | 2026-10-09 |
| `#smallPrint` | "Free Microsoft 365" often for one year only; a R6 000 laptop replaced after two years against a R12 000 one that lasts five | Offers and prices | 2026-10-09 |
| `#match` questions | Laptops C and D: R14 499 (Intel Core 5, 10 cores, Windows 11 Pro) and R12 999 (AMD Ryzen 5, 6 cores); a R15 000 school budget; a USB-C to HDMI adapter about R250; "find two laptops between R8 000 and R12 000" | Prices and names | 2026-10-09 |

#### Lesson 2 - What really affects performance (`performance`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, questions | A R14 000 laptop with a 4.8 GHz processor; a second stick of RAM about R600; an SSD about R600 to R900; R1 500 for each lab computer | Prices | 2026-10-09 |
| `#cacheSize`, `#ramSpeed` | "Intel Core 5, 10 cores, up to 4.6 GHz, 12 MB cache"; DDR4-3200 and DDR5-5600 | Current names and speeds | 2026-10-09 |
| `#findIt`, `#box`, study | Task Manager's Performance page (CPU Utilization, Memory In use, Disk Active time, SSD or HDD); Power mode in Settings, System, Power & battery (Best power efficiency, Balanced, Best performance) | Windows 11 names | 2026-10-09 |
| `#upgrade` (margin) | The upgrade doodle: "same phone, new colour, R20 000" | A flagship phone's price | 2026-10-09 |

#### Lesson 3 - Recommending a system (`recommending`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#home`, `#soho`, `#power` | A R15 000 laptop special; budgets: home roughly R8 000 to R12 000, a small office R12 000 to R18 000 plus printer and UPS, a video editor R40 000 and up with 32 to 64 GB RAM | Prices; typical RAM | 2026-10-09 |
| `#disability`, `#recommend` (margin) | Windows 11 live captions (Windows key + Ctrl + L, even with no Internet); Narrator, Magnifier, contrast themes, Voice Access built in; NVDA free | Windows features | 2026-10-09 |
| `#soho` | WhatsApp Business for the bakery | Still offered | 2026-10-09 |
| `#recommend` questions | The office computer: Intel Core 3, 4 cores, up to 4.3 GHz | Processor name | 2026-10-09 |

#### Lesson 4 - What the operating system does all day (`osallday`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#taskManager`, `#endTask`, questions, study | Task Manager opens with Ctrl + Shift + Esc (or right-click Start, or Ctrl + Alt + Delete); its pages Processes, Performance, App history, Startup apps, Users, Details, Services; End task | Windows 11 names | 2026-10-09 |

#### Lesson 5 - Utilities, housekeeping and troubleshooting (`utilities`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#space`, study | Storage Sense and Cleanup recommendations in Settings, System, Storage; Disk Clean-up from the Start search, Clean up system files | Windows 11 names | 2026-10-09 |
| `#optimise` | Optimize Drives runs weekly by default and sends TRIM to an SSD instead of defragmenting | Still true | 2026-10-09 |
| `#restore` | Windows Backup to OneDrive; Google One backup and iCloud Backup; WhatsApp backs up its chats separately; Settings, System, Recovery, Reset this PC | Names | 2026-10-09 |
| `#problems`, questions, study | Settings, System, Display (Recommended resolution); Settings, System, Troubleshoot, Other troubleshooters; Windows key + P | Windows 11 names | 2026-10-09 |

#### Lesson 6 - Web-based or installed software (`webvsinstalled`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#choosing` questions | Online accounting R450 a month; a booking and accounts app R250 a month | Prices | 2026-10-09 |
| `#twoKinds`, study | Google Docs; Word, Excel and PowerPoint for the web; Canva; online banking; SARS eFiling | Still the examples | 2026-10-09 |
| `#between`, study | Microsoft 365's installed apps must go online about once a month; Google Docs can work offline in Chrome or Edge | Microsoft's and Google's rules | 2026-10-09 |

#### Lesson 7 - Metadata, converting files and searching (`metadata`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#documents`, `#gps`, `#converting` | Office paths: File > Info (Title, Tags); File > Info > Check for Issues > Inspect Document; File > Save As (or Save a Copy); File > Export > Create PDF/XPS; Word warns when it opens a PDF | Office menu names | 2026-10-09 |
| `#gps`, questions, study | Most social media apps, and WhatsApp's normal photo send, remove the location; a photo sent as a document keeps it; iPhone: Settings > Privacy & Security > Location Services > Camera > Never; iPhone Settings > Camera > Formats > Most Compatible | What the apps strip; iPhone menu names | 2026-10-09 |
| `#search` | Search options on File Explorer's command bar (Windows 10: the Search tab); kind:, size: and datemodified: | Windows 11 names | 2026-10-09 |

#### Lesson 8 - Sharing, permissions and passwords (`sharing`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#network`, study | Sharing a folder: right-click > Properties > Sharing > Share (Read, Read/Write); Advanced Sharing (Read, Change, Full Control) | Windows 11 names | 2026-10-09 |
| `#permissions`, `#cloud`, questions | OneDrive Can view / Can edit; Google Drive Viewer / Commenter / Editor; Share, Send, Copy link | Names | 2026-10-09 |
| `#passwords`, questions | Word: File > Info > Protect Document > Encrypt with Password; File > Save As > Tools > General Options; Review > Restrict Editing | Office menu names | 2026-10-09 |
| `#zip` | 7-Zip > Add to archive (on Windows 11 first Show more options); 7-Zip > Extract Here | Windows 11 right-click menu | 2026-10-09 |
| `#versions`, study | Version history: OneDrive right-click Version history; File > Info > Version History; Google Docs File > Version history > See version history | Names | 2026-10-09 |

#### Lesson 10 - Internet services (`netservices`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#im` (margin), questions | WhatsApp passed three billion users a month in 2025 and is on almost every South African smartphone; WhatsApp Business catalogues | Newer user figures | 2026-10-09 |
| `#voip`, study | Many businesses use VoIP desk phones instead of a Telkom landline, which is being switched off in many areas | Progress of the copper switch-off | 2026-10-09 |
| `#streaming`, study | YouTube, Netflix, Showmax, Spotify and the DStv app; data per hour - music 50 to 150 MB, low-quality video 300 MB to 1 GB, HD 3 GB, 4K 7 GB or more; downloads inside Netflix, Spotify and YouTube Premium | Services still operating; data figures | 2026-10-09 |
| `#cloud` | Amazon, Microsoft and Google all have data centres in South Africa; Google Docs, Microsoft 365, Canva, Gmail | New regions (as the IT row for `kindsofcomputers` `#bigOnes`) | 2026-10-09 |
| `#fileSharing` questions | Many e-mail attachments stop at about 25 MB | Still true | 2026-10-09 |

#### Lesson 11 - Buying Internet access (`buyinginternet`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#connection` (margin), `#connection`, study | Telkom is switching off its copper lines and ADSL with them; 5G mostly in cities and big towns | Progress of the copper switch-off; 5G coverage | 2026-10-09 |
| `#connection` | Low satellites fly about 500 km up; Starlink is the best known, and in 2026 still not licensed in South Africa | ICASA licensing (as the IT Starlink rows) | 2026-10-09 |
| `#caps`, `#fairUse`, study | Most fibre packages are uncapped; a typical fair usage policy: after 300 GB, 2 Mbps until the next month; data per activity (HD video 1.5 to 3 GB an hour, a WhatsApp call 30 to 45 MB an hour) | Typical packages | 2026-10-09 |
| `#compare`, questions | SkyWave LTE R449 a month; BrightLine Fibre R649 a month plus R999 once-off; R100 a month less on a 24-month contract | Prices | 2026-10-09 |

#### Lesson 12 - Browser features worth knowing (`browserfeatures`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#basics`, questions, study | Chrome's home page: three dots, Settings, On startup; Edge: Start, home, and new tabs; Edge calls bookmarks favourites | Browser setting names | 2026-10-09 |
| `#private` (margin), `#private` | Incognito (Ctrl + Shift + N) in Chrome, InPrivate (Ctrl + Shift + P) in Edge, a Private Window in Safari and Firefox | Names and shortcuts | 2026-10-09 |
| `#passwords`, `#extensions` | Signing in to the browser with a Google or Microsoft account; the Chrome Web Store and Edge Add-ons | Names | 2026-10-09 |
| `#padlock` (margin) | Chrome replaced the padlock with a site-settings icon in 2023 | Browser icons | 2026-10-09 |

#### Lesson 13 - Searching better, and SEO (`seo`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#operators`, `#summary`, questions | before: and after: "work on Google today"; "only this year's: add after:2026-01-01"; Mr Botha's reviews "from this year, 2026" | That the operators still work; move the year on | 2026-10-09 |
| `#tools` | Google's Tools filter and the News tab; the margin's "about 15% of searches have never been typed before" | Google's interface; the figure | 2026-10-09 |
| `#images`, questions, study | Reverse image search: right-click, Search with Google Lens; Google Images' camera icon; TinEye; Bing Visual Search | Names | 2026-10-09 |

#### Lesson 15 - Computer crime and the criminals (`compcrime`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#theft`, questions | A stolen laptop costs R9 000 to replace | Price | 2026-10-09 |
| `#scams` | Online fraud is the computer crime most South Africans actually meet; selling on Marketplace | SABRIC / SAPS figures | 2026-10-09 |
| `#scams` questions | The newest iPhone for R6 999 on a scam site, R25 000 everywhere else | The iPhone's price | 2026-10-09 |
| `#victims`, study, glossary (Cybercrimes Act) | Cybercrimes Act 19 of 2020, mostly in force since 1 December 2021 | Still in force; amendments | 2026-10-09 |

#### Lesson 16 - Malware in depth, and the warning signs (`malwaredepth`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cleanup`, study | Windows Security: Virus & threat protection - Scan options - Microsoft Defender Antivirus (offline scan); Settings - Apps; Settings - System - Recovery - Reset this PC; Android: Play Protect, and safe mode by holding Power off | Windows 11 and Android menu names | 2026-10-09 |

#### Lesson 17 - Keeping data safe - a checklist (`securityplan`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here | The laptop itself costs about R9 000 | Price | 2026-10-09 |
| `#physical` | Theft is the most likely threat for most South African homes and small businesses | Crime figures | 2026-10-09 |
| `#backups` | A 1 TB external hard drive about R1 000; cloud storage about R40 a month for 100 GB | Prices (keep in step with CAT 10 `storage` and CAT 11 `storagecloud`) | 2026-10-09 |
| `#power`, questions | A UPS for a router about R800, for a desktop about R1 500; load shedding as the example power cut; a R3 000 budget | Prices (keep in step with CAT 11 `threats11` `#powerFix`) | 2026-10-09 |

#### Lesson 18 - Social media and its consequences (`socialmedia12`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#influence` | TikTok, Instagram and YouTube feeds picked by an algorithm; a WhatsApp Business status | Names | 2026-10-09 |
| `#crowdfunding` | BackaBuddy and Thundafund as South African crowdfunding websites; a laptop and a first month's food for R12 000 | Still operating; price | 2026-10-09 |
| `#fakenews` | WhatsApp marks messages "Forwarded many times" | Still true | 2026-10-09 |
| `#wellbeing` (margin) | Australia's ban on social media accounts for under-16s from 10 December 2025 | Whether other countries (or South Africa) have followed | 2026-10-09 |

#### Lesson 19 - The law and your rights (`lawrights`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#popi` | Direct marketing by SMS, e-mail, WhatsApp or phone only if the person opted in (or is a customer) | POPIA regulations | 2026-10-09 |
| `#regulator`, questions, study | The Information Regulator can fine up to R10 million; the most serious offences up to ten years in prison; complaints on the Regulator's website form | The Act; the Regulator's process | 2026-10-09 |
| `#copyright`, questions, study, glossary (fair dealing) | Copyright lasts until 50 years after the creator dies; fair dealing ("fair use in America") allows a small part for study, review or news; a song from Instagram's own music library is allowed in a reel | Whether the Copyright Amendment Bill (which adds fair use) has become law; Instagram's music licence | 2026-10-09 |
| `#defamation` | Since December 2021 it is a crime to send a message threatening violence or damage to property | Still in force | 2026-10-09 |
| `#identity`, questions | SAFPS protective registration; a new ID from Home Affairs | Still the steps | 2026-10-09 |

#### Lesson 20 - Technology and the world's big problems (`bigproblems`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#divide`, study | ITU 2024: about 38% of people in Africa online, about 91% in Europe; the SRD grant applied for only online since 2020; zero-rated learning and job sites | The newest ITU figures; the SRD grant (as the IT row for `bigproblems`) | 2026-10-09 |
| `#green`, study | Data centres used about 1.5% of the world's electricity in 2024; about 62 million tonnes of e-waste in 2022, less than a quarter recycled; South Africa's power mostly coal; a refurbished laptop from about R4 000; more than 8 GW of rooftop solar by 2026 | The newest IEA, Global E-waste Monitor and rooftop-solar figures; price | 2026-10-09 |
| `#health` (margin) | MomConnect sends free health messages by SMS and WhatsApp | Still running | 2026-10-09 |

#### Lesson 21 - Cryptocurrency, drones and what comes next (`crypto`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#cryptoRecap` | Most South Africans who own crypto buy it with rands on an exchange | Still true | 2026-10-09 |
| `#cryptoPeople`, study | Bitcoin lost more than half its value between October 2025 and February 2026; profits must be declared to SARS | Newer swings; SARS rules | 2026-10-09 |
| `#cryptoSociety`, questions, study | Crypto a financial product since October 2022 (FSCA licence); FIC Act duties since December 2022 | The FSCA and FIC rules (as CAT 10 `ictlife`) | 2026-10-09 |
| `#drones` | A small camera drone from about R6 000 | Price | 2026-10-09 |
| `#droneWork` | Drones have delivered blood and medicine in Rwanda since 2016 and Ghana since 2019 | Still running | 2026-10-09 |
| `#droneRules`, questions, study | SACAA: work drones need a licensed pilot and an operator's certificate; not near airports or over crowds; keep it in sight | The SACAA rules | 2026-10-09 |
| `#chatbots` | ChatGPT, Gemini, Copilot and Claude as AI chatbots; Vodacom's TOBi | Names (as the IT row for `ai12` `#uses`) | 2026-10-09 |

#### Lesson 23 - Writing a professional report (`report`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#fcr` | A 5 000-litre water tank with stand and plumbing about R15 000; a plumber's quote of R2 400 for three toilets | Prices | 2026-10-09 |

#### Lesson 25 - The CAPS practical paper (Paper 1) (`capsp1`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#paper` (margin) and the whole guide | The paper's shape from the November 2023, 2024 and 2025 papers (word processing 45, spreadsheets 40, database 35, HTML 15) | Each new November paper and memo (from November 2026) | 2026-10-09 |

#### Lesson 26 - The CAPS theory paper (Paper 2) (`capsp2`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#paper` (margin), `#twoFacts` (margin) and the whole guide | The same ten questions and marks in 2023, 2024 and 2025; TWO in 96 of the 223 parts of Sections B and C, none worth more than 3 | Each new November paper and memo | 2026-10-09 |

#### Lesson 27 - The IEB practical paper (Paper I) (`iebp1`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#paper` (margin) and the whole guide | Question 7 worth exactly 5 marks in 2023, 2024 and 2025; the papers' shape | Each new November paper and memo | 2026-10-09 |

#### Lesson 28 - The IEB theory paper (Paper II) (`iebp2`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#paper` (margin) and the whole guide | 86% of mark slots worth one mark in 2023-2025, nothing worth more than 5 | Each new November paper and memo | 2026-10-09 |
| `#scenario` | Data packages: Lite 10 GB R149, Home 50 GB R349, Max uncapped R799 | Prices | 2026-10-09 |

#### Lesson 29 - The CAPS PAT: how it works (`patcaps`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| `#what`, questions, study | In Grade 12 the PAT is 25% (as much as each paper; school-based assessment 25%); 20% in Grades 10 and 11 | The current CAPS PAT guidelines | 2026-10-09 |
| `#phases`, `#year`, questions, study | Phase 1 due at the end of Term 1, Phase 2 at the end of Term 2, Phase 3 before the prelim in Term 3 | The year's PAT document | 2026-10-09 |
| `#phases`, `#tool`, study | 2026's marks: Phase 1 32, Phase 2 44, Phase 3 70 + 4 general = 150 | The DBE's CAT Learner Guidelines for PATs, Grade 12, of the new year (education.gov.za, Grade 12 PATs) | 2026-10-09 |
| `#phase1`-`#phase3`, `#evidence`, questions, study | Phase 1: ONE focus question, at least 10 research questions (3 of 4 levels, 3 categories), at least two websites + one other source; Phase 2: one-page questionnaire, at least 5 questions, at least 25 respondents; spreadsheet (survey and other data, 4 function levels, 2 graphs); database not a copy of the spreadsheet (5 fields, 20 records, validation rule, list box, input mask, 3 queries, a grouped report); Phase 3: report (1 600-2 000 words, 6-8 pages, abstract, 3+ findings) AND a website (home page + 2 pages); declaration asks for help received, AI included; moderation by subject advisors and Umalusi; no PAT mark = no CAT result | The new year's DBE learner guidelines (they change yearly) | 2026-10-09 |

#### Lesson 30 - The IEB PAT: how it works (`patieb`)

| Where | The claim | Check | Last checked |
|---|---|---|---|
| Start here, `#what`, `#p1t1`, `#moderation`, study | The rubric is 170 marks converted to 100; at least 15 questions in Phase 1; the moderator checks a 10% sample (at least five) | The current SAGs, Appendix N | 2026-10-09 |

Nothing dated: `wan`, `deepdark`, `reformulating`, `normalising`.
