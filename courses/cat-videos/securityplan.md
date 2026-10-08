# CAT 12 lesson 17: Keeping data safe - a checklist - videos

Lesson: `content/cattheory12/securityplan.php`. Two videos: the checklist as
a whole (prevent, detect, recover), and backups that work. Board in the CAT
marker style with Clicky (brand/cat-art-style.md); yellow highlighter on any
words on screen being talked about. Everything below is in the lesson text.

## cat12-17.1 The security checklist - prevent, detect, recover (about 8 min)

**Goes:** after section `#incident` - the comment after `o17Incident`.
**The pupil can afterwards:** sort a measure by its job (prevent, detect, recover), name the ten measures on the checklist with what each protects against, and recommend one with a reason.
**Thumbnail:** tag `CAT · SECURITY`, title "What did he do *before* Saturday?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Saturday night, Centurion: someone breaks the back window of Botha's Bakery and takes the laptop. On Monday Mr Botha asks: what have I lost? The answer depends on what he did before Saturday.
   > Board: a broken window, an empty desk, Clicky looking under the desk.
2. **Three jobs (0:40-1:50).** Burglar bars prevent, the alarm detects, insurance helps you recover. A security plan for data works the same way. The classic mistake: a measure for the wrong job - a backup does not stop ransomware getting in.
   > Board: the secplan-house drawing; three labels PREVENT, DETECT, RECOVER, highlighter on each in turn.
3. **Keeping people out (1:50-3:40).** Physical security (locks, a cable lock, nothing left in the car); strong, different passwords and two-step verification - a stolen password alone is not enough; change default passwords; screen locks; access rights - each person only what their work needs, standard accounts, close an account on the last day.
   > Board: a padlock, then a phone showing a code, then a ladder of accounts (administrator at the top, standard below); highlighter on "two-step verification" and "access rights".
4. **Keeping malware out (3:40-4:50).** Anti-malware that updates itself daily; automatic updates close security holes before criminals use them (WannaCry, 2017); the firewall on the computer and router; https and the padlock - private connection, not an honest website.
   > Board: a hole in a wall being patched; a guard at a gate with a list; the padlock-thief doodle; highlighter on "https".
5. **When it gets through anyway (4:50-6:30).** Encryption - a stolen laptop costs the device, not the data; backups (the next video); the UPS - minutes to save and shut down, a surge protector stops spikes only; user training - check the link, the spelling and the tone, never share an OTP.
   > Board: a laptop with scrambled text on its screen; a UPS box with a battery inside; Clicky hovering over a link to show its real address.
6. **The incident plan (6:30-7:20).** Disconnect, tell, change passwords, restore, report (the Information Regulator if personal information was stolen), learn.
   > Board: six numbered steps appearing one by one, highlighter on "Disconnect".
7. **Defending a recommendation (7:20-8:00).** Name the measure exactly, link it to a threat in the scenario, say how it helps, make it fit the place. Weak: "anti-virus, because it is safer". Strong: "back up the bookings every night to cloud storage, so that if the laptop is stolen they can be restored".
   > Board: the weak and strong answers side by side, a cross and two ticks.
8. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| prevent, detect, recover; the wrong-job warning | `#plan` |
| physical security | `#physical` |
| passwords, two-step verification, default passwords, screen locks | `#passwords` |
| access rights; own accounts; standard accounts; the last day | `#access` |
| anti-malware, automatic updates, WannaCry | `#updates` |
| firewall; SSL, https and the padlock | `#firewall` |
| encryption | `#encryption` |
| UPS and surge protector | `#power` |
| user training | `#people` |
| the incident plan's six steps | `#incident` |
| defending a recommendation, weak and strong | `#checklist` |

## cat12-17.2 Backups that work - the 3-2-1 rule (about 6 min)

**Goes:** after section `#backups` - the comment before `q17Rule321`.
**The pupil can afterwards:** state the 3-2-1 rule, plan a cheap backup for a small business, list what makes a backup work, and explain why syncing is not a backup.
**Thumbnail:** tag `CAT · SECURITY`, title "Three copies. *Two* kinds. One far away."

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Theft, a dead drive, a fire, ransomware, the wrong folder deleted. One day something gets through - and then only one measure matters.
   > Board: the ransom-drawer doodle; Clicky holding a backup drive.
2. **What a backup is (0:30-1:00).** A second copy, kept apart from the originals, so that you can restore them.
   > Board: two folders, one going into a drawer; highlighter on "kept apart".
3. **The 3-2-1 rule (1:00-2:30).** Three copies; two different kinds of storage; one off-site - another building or the cloud.
   > Board: the backup-321 drawing built up number by number; highlighter on "off-site".
4. **Botha's Bakery, the cheap way (2:30-3:40).** Copy 1 on the laptop; copy 2 - every Friday to a 1 TB external drive (about R1 000), unplugged afterwards; copy 3 - every night to cloud storage (about R40 a month for 100 GB). The laptop is stolen; on Monday he restores everything.
   > Board: three boxes labelled with the prices; a new laptop filling up from the cloud.
5. **What makes it work (3:40-4:50).** Off-site; automatic; unplugged or offline (ransomware locks every drive it can reach); tested - restore one file now and then; fit for purpose - capacity and robustness.
   > Board: five ticks down a list; highlighter on "tested".
6. **Sync is not a backup (4:50-5:40).** Syncing keeps the same file everywhere - so a deleted, damaged or locked file is copied everywhere within seconds. Version history helps; a separate backup is the real answer.
   > Board: the sync-not-backup drawing - the scrambled file racing to the cloud and the phone, the drive in the drawer still smiling.
7. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| what a backup is | `#backups` |
| the 3-2-1 rule | `#backups` (The 3-2-1 rule) |
| the bakery's three copies and their prices | `#backups` (Worked example) |
| off-site, automatic, unplugged, tested, fit for purpose | `#backups` (What makes a backup work) |
| sync is not a backup; version history | `#backups` (Sync is not a backup) |
