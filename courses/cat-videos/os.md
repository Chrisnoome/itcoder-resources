# CAT 10 lesson 14: The operating system - videos

Lesson file: `AIPascalCourse/content/cattheory10/os.php`. Three videos; the
third is for the IEB section but useful to all. Everything said or shown here
is also in the lesson text (anchors in the tables below).

## cat10-14.1 What the operating system does all day (about 7 min)

**Goes:** after the quiz `q14Lock`, at the end of section `#startUp`.
**The pupil can afterwards:** say what an OS is, give its five jobs, describe
switching on and logging on, and choose between lock, sign out and switch
user.
**Thumbnail:** tag `CAT · SOFTWARE`, title "The *manager* you never see"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. It is 06:45 at
   Botha's Bakery. Mr Botha switches on the laptop: a logo, a lock screen,
   his PIN, the desktop, the Wi-Fi, the printer found. He hasn't opened a
   single program. So who did all that?
   > Board: the bakery counter, a laptop; each event pops up as a sticky
   > note; Clicky shrugs.
2. **The manager (0:40-1:50).** The OS is the system software that manages all
   the hardware and software. The restaurant: customers (you), chefs
   (applications), kitchen (hardware), the manager (the OS) who sends orders
   to the right chef and stops two chefs grabbing the same pot.
   > Board: the restaurant drawn in marker; yellow band on MANAGER.
3. **The layers (1:50-2:40).** Click Print in Word; Word asks the OS; the OS
   hands it to the printer's driver; the driver tells the printer. Word never
   talks to the printer itself.
   > Board: the os-layers stack redrawn; an arrow runs down the layers and a
   > page comes out of the printer.
4. **The five jobs (2:40-4:10).** User interface; loads and runs programs;
   manages the hardware (the print queue - three people print at once);
   manages files and folders; keeps the computer secure. One example each.
   > Board: five boxes filled one at a time, each with a tiny drawing; pink
   > highlighter on the job names.
5. **Switching on (4:10-5:10).** The six steps: power; the ROM start-up
   program checks the hardware; the OS is loaded from storage into RAM; the
   lock screen; log on; the desktop.
   > Board: a numbered strip of six frames, drawn left to right.
6. **Logging on (5:10-6:00).** Username says who you claim to be; a
   password, PIN, pattern, fingerprint or face proves it - authentication.
   Access control lets in only those allowed; each person gets a user
   account.
   > Board: a lock screen with the five ways around it; Clicky holding a key.
7. **Leaving the computer (6:00-6:50).** Lock (Windows key + L) - programs
   stay open; sign out - everything closes; switch user - someone else logs
   on while you stay logged on; sleep, shut down, restart. Thabo at the
   school computer: lock.
   > Screen: VM, Start > account picture > Lock, Sign out; then Windows key +
   > L shown as a key-press overlay.
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Mr Botha's morning | Start here |
| what an OS is, the restaurant, the print example through the layers | `#whatOs` |
| the five jobs (Learn / Memorise table), the print queue | `#jobs` |
| the six start-up steps, log on, authentication, access control, user account, lock / sign out / switch user / sleep | `#startUp` |

## cat10-14.2 Drivers, plug and play and updates (about 6 min)

**Goes:** after the typed question `t14HotSwap`, at the end of section
`#drivers` (before `#updates`).
**The pupil can afterwards:** say what a driver is and why a device needs
one, give the steps of plug and play, explain hot-swappable, and give
reasons to install updates.
**Thumbnail:** tag `CAT · SOFTWARE`, title "Why your printer needs a *translator*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Mr Botha's new
   printer is plugged in, switched on - and prints nothing.
   > Board: the printer with a sad face; Clicky pressing Print again and again.
2. **The driver (0:30-1:40).** Thousands of devices, each different; Windows
   cannot know them all. A driver is a small program that translates between
   the OS and one device - and passes messages back ("out of paper").
   > Board: the driver-translate drawing: the OS speaking one language,
   > each printer's driver turning it into that printer's own.
3. **Plug and play (1:40-2:50).** The five steps: plug in; the OS recognises
   it; finds a driver (has one or downloads one); installs it and sets it up;
   "ready to use". If it can't find one: the maker's website, your exact
   model.
   > Screen: VM, Settings > Bluetooth & devices > Printers & scanners, the
   > Add device button and the list (no real device needed - show the page
   > only).
4. **Hot-swappable (2:50-3:40).** Plug in or unplug while the computer is on:
   flash drives, mice, keyboards, external drives. Eject a flash drive
   first, or a file being saved can be damaged.
   > Board: a flash drive leaving a laptop mid-save, a torn file. Then:
   > Screen: File Explorer, right-click a drive > Eject (any drive the VM
   > shows; if none, the board only).
5. **Updates (3:40-5:20).** An update is a free download from the maker that
   changes software you have: closes security holes (the main reason), fixes
   bugs, brings new drivers, adds improvements. The costs: a restart at a bad
   time, data (use Wi-Fi), now and then a new problem. Active hours. When
   updates stop: Windows 10 ended on 14 October 2025 (home users could get
   one more year of security updates, to October 2026); an old device becomes an easy
   target.
   > Screen: Settings > Windows Update; then Advanced options > Active hours.
   > Board: a fence with a hole; an update patching it.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| driver, translator, plug and play steps, manual install, hot-swappable, eject | `#drivers` |
| updates, their reasons and costs, active hours, end of support | `#updates` |

## cat10-14.3 A tour of Windows Settings (about 6 min, IEB)

**Goes:** after the IEB section's typed question `t14Narrator` (section
`#settings`).
**The pupil can afterwards:** find the main Settings categories and say what
is changed in each.
**Thumbnail:** tag `CAT · WINDOWS`, title "Where is *that* setting?"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Gogo finds the text on
   her new laptop too small. Almost everything about how Windows looks and
   works lives in one app.
   > Board: Gogo squinting at a laptop; Clicky with a magnifying glass.
2. **Opening Settings (0:30-0:50).** Start menu, or Windows key + I. The
   categories down the left; Windows 11 renamed some (Devices is now
   Bluetooth & devices; Ease of Access is now Accessibility).
   > Screen: VM, press Windows key + I; yellow band down the category list.
3. **System (0:50-1:50).** Display (brightness, text size, resolution),
   Notifications, Power (sleep, battery saver). The worked example: System >
   Display > Scale 125%.
   > Screen: exactly those clicks; set Scale to 125%, then back to 100%.
4. **Bluetooth & devices (1:50-2:40).** Pair Bluetooth devices; add a printer
   and choose the default printer; mouse and touchpad.
   > Screen: open the page; open Mouse; show the scrolling setting.
5. **Personalization (2:40-3:30).** Background, lock screen, colours, light
   and dark mode, themes, Start and taskbar.
   > Screen: change the background to a built-in picture, then back.
6. **Time & language (3:30-4:10).** Date and time, time zone, region (South
   Africa: currency and date format), languages, speech.
   > Screen: open Date & time and Language & region; no changes.
7. **Gaming (4:10-4:50).** Game Bar (Windows key + G), Captures (Windows 10's
   Game DVR), Game Mode.
   > Screen: open each page.
8. **Accessibility (4:50-5:40).** Narrator reads the screen aloud;
   Magnifier enlarges; contrast themes (high contrast).
   > Screen: open Narrator's page (do not switch it on - it talks over the
   > narration); open Magnifier; show Contrast themes.
9. **Sign-off.**

> Note: record in the VM. Leave every setting as it was.

### In the text

| Video point | Lesson anchor |
|---|---|
| Windows key + I, the categories and their old names, the table of what each holds, Gogo's 125% example | `#settings` |
