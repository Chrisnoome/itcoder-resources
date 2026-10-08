# CAT 11 lesson 2: What makes a computer fast - videos

Lesson: `content/cattheory11/performance11.php`. Two videos; the second is
inside the IEB section (booting) and says so in its first line. Board in the
CAT marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words on screen being talked about. Video 1 has a short screen recording
in the VM (Settings, Apps, Startup). Everything below is in the lesson text.

## cat11-02.1 What makes a computer fast (about 9 min)

**Goes:** after section `#running` - the comment before `m2Fix`.
**The pupil can afterwards:** name the performance factors, say what each one does for speed, and pick the factor most likely to be slowing a computer for a given complaint.
**Thumbnail:** tag `CAT · HARDWARE`, title "Same GHz. Why is *his* faster?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Thabo and Sipho bought laptops in the same week, both "up to 4.2 GHz". Thabo's is ready in 15 seconds; Sipho's takes two minutes, and freezes with Word, Excel and Chrome open.
   > Board: two laptops side by side, a stopwatch over each.
2. **The bottleneck (0:40-1:40).** Data travels a chain - storage, RAM, CPU and back - so a computer is only as fast as its slowest part for the job. A two-litre bottle pours only as fast as its neck. Five factors: cores, clock speed, cache, RAM, the drive - plus how many programs are running.
   > Board: the perf-bottleneck doodle; the five factors listed on a sticky note.
3. **Cores (1:40-2:50).** A core is a complete processor. More cores: many programs at once, or a big job split up, like a video export. No help to typing a letter. A till queue: more tills, more customers - but a full trolley still takes as long.
   > Board: the two-brains doodle; four tills, one with a huge trolley.
4. **Clock speed (2:50-4:00).** Ticks a second in GHz; more work every second. "Up to" is a boost while the CPU is cool - a thin laptop may lose it after a minute. A new 3 GHz CPU can beat an old 4 GHz one: compare GHz only within the same family and age.
   > Board: a ticking clock; a thermometer rising and the speed dropping. Yellow highlighter on "up to".
5. **Cache (4:00-5:20).** A tiny, very fast memory on the CPU chip with copies of what it uses most. Look in the cache first; found it, no wait; not there, fetch from RAM and keep a copy. Found over 90% of the time. Salt on the table, the cupboard, the shop. Megabytes of cache, gigabytes of RAM, terabytes of storage.
   > Board: the kitchen-cache doodle; the four steps as arrows.
6. **RAM (5:20-6:40).** RAM full: the OS moves parts of programs to the slow drive and back - freezing, a spinning pointer. More RAM: everything fits. 8 GB the least, 16 GB comfortable, 32 GB for video. "Extended RAM" on a phone box is storage, not RAM.
   > Board: RAM as a table overflowing onto the floor; the ram-plus-box drawing.
7. **The drive and what is running (6:40-8:30).** Starting, opening programs and files all wait for the drive; an SSD reads many times faster than a hard drive - the best upgrade for an old laptop, about R600 for 512 GB. Every program running uses CPU time and RAM, including startup apps, notification-area icons and old tabs. Close what you do not use; switch off startup apps; restart now and then.
   > Board: the perf-ssd-swap doodle.
   > Screen: in the VM, Settings, Apps, Startup - switch one app off. Yellow highlighter on "Startup".
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Thabo and Sipho | the lesson opening (Start here) |
| the bottleneck, the factors | `#chain` |
| cores, the till queue | `#cores` |
| GHz, up to, boost, same family | `#clock` |
| cache, the four steps, salt | `#cache` |
| full RAM, how much, extended RAM | `#ram` |
| HDD vs SSD, the R600 upgrade | `#drive` |
| programs running, the three steps, the summary table | `#running` |

## cat11-02.2 Booting, step by step (about 6 min)

**Goes:** after `w2Restart`, at the end of the IEB section `#booting`.
**The pupil can afterwards:** put the steps of booting in order, tell a cold boot from a warm boot, and explain why a restart fixes so much.
**Thumbnail:** tag `CAT · HARDWARE`, title "What happens when you press *power*?"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. This one is for IEB pupils - but everyone presses a power button. What happens in those first seconds?
   > Board: a finger on a power button; the bootstraps doodle.
2. **The six steps (0:30-3:00).** Power on: fans, black screen, RAM empty. The BIOS starts from the ROM chip. The POST - power-on self-test - checks CPU, RAM, graphics and drives behind the maker's logo. The boot order: the BIOS tries the drives in turn. The operating system is copied into RAM - spinning dots. Windows starts drivers and background programs; the log-in screen.
   > Board: six panels like a comic strip; yellow highlighter on "POST" and "boot order".
3. **Cold and warm (3:00-4:00).** Cold boot from power off, with the full POST. Warm boot: Restart, without cutting the power, quicker. A restart empties RAM and loads everything fresh - that is why it fixes so much.
   > Board: the bios-alarm doodle; RAM wiped clean.
4. **When it will not boot (4:00-5:20).** Beeps and a black screen: the POST found a fault, often loose RAM. "No bootable device": no operating system in the boot order - a flash drive left in can cause it. Restarting over and over: often a broken update; Windows offers to repair itself.
   > Board: a flash drive glowing in a USB port; a "No bootable device" message.
5. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the six steps, POST, boot order | `#booting` |
| cold and warm boot, why a restart fixes things, when it will not boot | `#booting` (the block after the try-it) |
