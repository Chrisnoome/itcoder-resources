# CAT 12 lesson 4: What the operating system does all day - videos

Lesson: `content/cattheory12/osallday.php`. Three videos: the operating
system's jobs with multitasking and memory, the two CAPS ideas (spooling;
single-user and multi-user), and Task Manager on a real screen. Board in the
CAT marker style with Clicky (brand/cat-art-style.md); yellow highlighter on
any words on screen being talked about. Screen recordings in the video VM
(Windows 11). Everything below is in the lesson text.

## cat12-04.1 What the operating system does all day (about 7 min)

**Goes:** after section `#memory` - the comment after `wOsCloseApps`.
**The pupil can afterwards:** name the seven jobs of the OS, explain multitasking as short turns on the processor, and explain why too many open programs slow a computer down.
**Thumbnail:** tag `CAT · SOFTWARE`, title "200 programs, *4* cores?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Sunday, 21:40. Thabo has Word, twelve tabs, music, WhatsApp and a game update all open. Word turns pale: Not Responding. Who was running all of that at once?
   > Board: Thabo's laptop with five windows piled up; Clicky on the power button, Lerato's hand stopping it.
2. **Seven jobs (0:40-2:00).** The Grade 10 restaurant manager, split into seven: starting the computer, the user interface, managing programs, memory, files, devices, users and security. For each, when you notice it - usually when something goes wrong.
   > Board: the os-manager drawing; the lesson's seven-job table built row by row; highlighter on each job name.
3. **Multitasking (2:00-4:00).** One core does one thing at a time. The OS gives the music, the download and Word very short turns, round and round, hundreds of times a second - the juggler, three balls, one in the hand. 4 or 8 cores, but more than 200 processes, so they still take turns. Most of them are waiting and need almost no turns.
   > Board: the juggler doodle; a clock face split into tiny slices, each coloured for a program; highlighter on "short turns".
4. **In front and behind; phones (4:00-4:50).** Typing goes to the window in front; the rest carry on behind. Phones pause apps you are not looking at, and close them when they need the memory.
   > Board: a front window with a cursor, faded windows behind; a phone with apps greying out.
5. **Good, bad, and a limitation (4:50-5:40).** Advantages: several programs at once, background jobs, copy and paste between them. Disadvantages: shared processor, RAM per program, one hog slows the rest. The limitation: it cannot make the computer more powerful.
   > Board: two columns, ticks and crosses; a separate box labelled "limitation"; highlighter on "limitation".
6. **Managing memory (5:40-6:50).** RAM is the kitchen counter, storage the cupboard. The OS gives each program space, keeps the spaces apart, takes the space back. When the counter is full: virtual memory - parts of programs go to the drive, far slower. The signs, and what helps: close programs and tabs, restart, start-up apps, more RAM.
   > Board: a counter filling up with pots; the overflow carried to a cupboard by Clicky; highlighter on "virtual memory".
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Thabo's Sunday night | Start here |
| the seven jobs, when you notice them | `#allDay` |
| short turns, the juggler, 200 processes on 4 cores | `#multitask` |
| front and behind; phones pause apps | `#multitask` |
| advantages, disadvantages, the limitation | `#multitask` |
| the counter and cupboard; virtual memory; what helps | `#memory` |

## cat12-04.2 Spooling, and single-user or multi-user (about 5 min, CAPS)

**Goes:** after the CAPS section `#users` - the comment after the BoardSection.
**The pupil can afterwards:** explain spooling step by step and why it matters, and tell a single-user from a multi-user OS with examples.
**Thumbnail:** tag `CAT · SOFTWARE`, title "Print it - and *keep typing*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Ms Naidoo sends a 60-page test to the staffroom printer and carries straight on typing. The printer manages 30 pages a minute. How is Word free at once?
   > Board: a fast computer and a slow printer, a snail on the printer; Clicky tapping its foot.
2. **Spooling, step by step (0:30-2:30).** Print; Word hands the pages to the OS; the OS saves the job quickly to a temporary file on the drive and adds it to the print queue; Word is free; the OS feeds the printer in the background; the next job starts. Why it matters: you keep working, many share one printer, jobs can be paused or cancelled. Coordinating a fast part and a slow part.
   > Board: the queue doodle (the tuck-shop queue) relabelled as print jobs; numbered arrows for the six steps; highlighter on "spool".
3. **Single-user (2:30-3:30).** One person at a time - who can still run many programs. Phones, a home laptop, a Chromebook. Thabo and Lerato have two accounts, but only one sits at the keyboard.
   > Board: one chair at one laptop; two account icons, one greyed out.
4. **Multi-user (3:30-4:40).** Many people at the same time, usually over a network: the school server with thirty pupils, a bank serving thousands of ATMs, servers behind websites. Three extra jobs: keep users apart, share fairly, control access. The note: some books call Windows multi-user - give the meanings.
   > Board: one server with thirty lines out to a lab; three numbered jobs; highlighter on "at the same time".
5. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the slow printer; six steps; why it matters; coordinating tasks | `#spooling` |
| single-user, with examples | `#users` |
| multi-user, examples, the three extra jobs, the note on words | `#users` |

## cat12-04.3 Task Manager, step by step (about 6 min)

**Goes:** after section `#endTask` - the comment after `wOsEndTaskCare`.
**The pupil can afterwards:** open Task Manager three ways, use the Processes, Performance, Startup apps and Users pages, and end a frozen program safely.
**Thumbnail:** tag `CAT · SOFTWARE`, title "Not Responding? *Don't* pull the plug"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Lerato shouted "Open Task Manager!" Here is why.
   > Screen: Word with "(Not Responding)" in the title bar, the window pale. Highlighter on "(Not Responding)".
2. **Opening it (0:30-1:20).** Ctrl + Shift + Esc; right-click Start or the taskbar; Ctrl + Alt + Delete, then Task Manager - often works when the screen seems stuck.
   > Screen: each of the three ways, in the VM. Highlighter on the keys as they are pressed (shown as key caps).
3. **The pages (1:20-3:20).** The three lines to show the page names. Processes: CPU, memory, disk, network per program. Performance: the graphs, and the hardware - processor name, speed and cores, RAM size, each drive's size and type. Startup apps: disable, which does not uninstall. Users: who is signed in.
   > Screen: each page in turn; highlighter on "Cores", "Memory 8.0 GB", "SSD", "Disabled". Note: use the VM's own hardware, whatever it shows.
4. **What is slowing you down (3:20-4:10).** Sort by CPU, then by Memory. A browser with 40 tabs at the top is normal; a program you closed an hour ago is not. An unknown program working hard while you do nothing can be malware.
   > Screen: clicking the CPU and Memory headings; highlighter on the top row.
5. **Ending a frozen program (4:10-5:30).** Busy or stuck. Wait half a minute; Ctrl + Shift + Esc; find it under Apps; click once; End task; reopen and look for the recovered document. Unsaved work is lost - Word saves recovery information every 10 minutes, but save with Ctrl + S. Check the name twice; leave Windows processes alone; the power button is the last resort, held for about 10 seconds.
   > Screen: a test document in Word, frozen with a huge paste; End task; Word reopening with Document Recovery. Highlighter on "End task".
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what Task Manager is for; three ways to open it | `#taskManager` |
| Processes, Performance, Startup apps, Users | `#taskManager` |
| sorting by CPU and Memory; unknown programs | `#taskManager` |
| busy or stuck; the six steps; the warning; three more rules | `#endTask` |
