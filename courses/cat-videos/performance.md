# CAT 12 lesson 2: What really affects performance - videos

Lesson: `content/cattheory12/performance.php`. Two videos: finding the
bottleneck (with Task Manager on a real screen), and why a computer slows
down and what to do about it, ending with upgrade or buy new (an IEB section,
taught to all). Board in the CAT marker style with Clicky
(brand/cat-art-style.md); yellow highlighter on any words on screen being
talked about. Screen recordings in the video VM, Windows 11. Everything below
is in the lesson text.

## cat12-02.1 Finding the bottleneck (about 8 min)

**Goes:** after section `#findIt` - the comment after `w2BothaCpu`.
**The pupil can afterwards:** say which upgrades a user would feel and which not, and find the bottleneck for a job on Task Manager's Performance page.
**Thumbnail:** tag `CAT · HARDWARE`, title "R14 000 or *R600*?"

### Scenes

1. **Hook (0:00-0:50).** Hi, and welcome to BestLessons. Month-end at Botha's Bakery: every click freezes the laptop for five seconds. The salesman says: a faster processor, R14 000. Lerato opens Task Manager: CPU 20%, memory 95%. A R600 stick of RAM fixes it. The miracle processor was waiting.
   > Board: Mr Botha at the laptop with a spinning wheel; a price tag "R14 000" and a small one "R600"; Clicky pointing at the small one.
2. **You feel only how long you wait (0:50-3:00).** The lesson's table, row by row: HDD to SSD (everyone feels it); 8 to 16 GB (only if it was full); 4 to 8 cores (exports, not typing); 4.2 to 4.6 GHz (about 10% - hardly felt); a graphics card (games, not Word); a faster network card on a 50 Mbps line (nothing). The rule: a change is felt only if that part was the bottleneck for that job.
   > Board: the render-wait doodle; the table drawn as six rows, a big tick or a shrug beside each "what you feel"; highlighter on "bottleneck".
3. **Finding it, step by step (3:00-5:00).** Ctrl + Shift + Esc, Performance page; do the slow job; watch which graph climbs to the top and stays; that is the bottleneck. Each Disk graph says SSD or HDD.
   > Screen: in the VM, Ctrl+Shift+Esc, the Performance page; click CPU, Memory, Disk 0, Wi-Fi/Ethernet, GPU in turn; yellow highlighter on each graph's percentage, on "Active time" and on the SSD or HDD label. Open several programs and watch Memory climb.
4. **What each full graph means (5:00-6:20).** CPU near 100%; Memory nearly full; Disk at 100% active time; GPU; Wi-Fi or Ethernet flat at the line's speed - and what helps each one. The tip: full Memory makes the Disk busy too - look at Memory first.
   > Board: the five-row table; the perf-data-path drawing for the hard drive row.
5. **Lerato's old laptop (6:20-7:50).** The stepper: the complaint; CPU 15% - not it; memory 5 of 8 GB - not it; Disk 0 HDD at 100% - the bottleneck; the SSD; then the video export makes the CPU the next bottleneck, and a laptop's processor cannot be upgraded.
   > Board: performance-hdd-1 to performance-hdd-6 in turn, Clicky crossing off each part that is not the bottleneck.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Mr Botha, the salesman, Lerato and Task Manager | Start here |
| you feel only the wait; the six changes; the rule | `#felt` |
| the four steps; the five full graphs and what helps; SSD or HDD on the Disk graph; Memory first | `#findIt` |
| Lerato's old laptop, step by step | `#findIt` (Try this: find the bottleneck) |

## cat12-02.2 Why it is slow, and what to do about it (about 8 min)

**Goes:** after section `#slower` - the comment after `s2Slower` (the IEB section on upgrading follows it, and its last scene covers that section).
**The pupil can afterwards:** compare an SSD with a hard drive beyond speed, say what defragmenting does and does not do, explain why a computer slows down over time and what the free fixes are, and decide between upgrading and buying new.
**Thumbnail:** tag `CAT · HARDWARE`, title "It was *fast* last year"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Thabo's laptop was fast two years ago. No part has worn out. So why is it slow?
   > Board: two Thabos, "2024" and "2026", the same laptop; Clicky tapping its foot.
2. **SSD or hard drive - more than speed (0:30-2:10).** The Learn/Memorise table: speed, robustness, noise and heat, power, price per GB, biggest sizes, best for. The best of both. SATA and NVMe SSDs - few people feel the difference.
   > Board: the table built row by row, the two columns as two drawn drives; highlighter on "robustness".
3. **Defragmenting (2:10-3:30).** Pieces of a file scattered across a hard drive; defragmenting gathers them. Windows does it weekly. It frees no space - nothing is deleted. Never on an SSD. Keep a tenth of any drive free.
   > Board: the defrag-pieces drawing; big marker "0 MB freed" with highlighter.
   > Screen: Start, type "defragment", open Defragment and Optimize Drives; highlighter on the scheduled (weekly) setting being on. Do not run it.
4. **Why it slows down (3:30-5:00).** Startup programs; tabs; bigger software; a full drive; dust and throttling; malware working in secret. Not worn parts: a processor keeps its GHz.
   > Board: the dust-fan doodle; six sticky notes around Thabo's laptop.
5. **The free fixes (5:00-6:10).** Close programs and tabs; disable startup apps; uninstall; Disk Clean-up and move old files; updates and a malware scan; clean the vents; restart.
   > Screen: Task Manager, Startup apps page, right-click an app, Disable; Settings, Apps, Installed apps shown briefly.
6. **Upgrade or buy new (6:10-7:40).** Find the bottleneck; can it be upgraded (desktop, laptop, phone); will it fit (DDR4 or DDR5, the socket); compare the cost; decide. The table: upgrade when it is the drive or RAM and the rest is good; buy new when a laptop's processor is the bottleneck, parts will not fit, it costs over about half a new one, or no more security updates.
   > Board: the upgrade-same doodle; a five-step staircase; the two-column table, highlighter on "about half".
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the HDD/SSD table; the best of both; SATA and NVMe | `#drives` |
| defragmenting; Defragment and Optimize Drives; no space freed; never an SSD; keep a tenth free | `#drives` (Optimising a drive) |
| why a computer slows down; malware | `#slower` |
| the free fixes | `#slower` (The free fixes) |
| the five steps; upgrade or buy new; the right upgrade for the job | `#upgrade` (IEB section) |

Not in either video (in the text only, on purpose - short and best read):
cache size and caching (`#cacheSize`), RAM amount against speed
(`#ramSpeed`) and what the numbers on the box do not say (`#box`).
