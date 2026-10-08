# CAT 12 lesson 8: Sharing, permissions and passwords - videos

Lesson file: `AIPascalCourse/content/cattheory12/sharing.php`. Three videos,
mostly screen recordings. Everything said or shown here is also in the
lesson text (anchors in the tables below).

**Screen recordings:** two VMs on one virtual network if possible (named
`BAKERY-LAPTOP` and `TILL`), Windows 11, Microsoft 365 with a test OneDrive
account, and 7-Zip installed. Before recording, make `Documents\Orders`
with a few spreadsheets, `Price list.xlsx` in OneDrive, `Recipes.docx`, a
folder `Invoices` with about ten PDFs, and - for 08.2 - a self-extracting
archive `Data2026.exe` made with 7-Zip (Create SFX archive, password
`Bake#26`). Turn on File History to a second virtual drive a day before
08.3, and save `Essay.docx` several times so that previous versions exist.
Use only test accounts and made-up names; never show a real e-mail address.

## cat12-08.1 Sharing a folder - who, and read or edit (about 8 min)

**Goes:** after the written question `wShareSettings`, at the end of section
`#cloud` (the comment `// VIDEO cat12-08.1`), before `#passwords`.
**The pupil can afterwards:** share a folder on a network with Read or
Read/Write; open it by its network path; choose read or edit by the
lowest-level rule; share from OneDrive with specific people or a link, and
say why "anyone with the link can edit" is risky.
**Thumbnail:** tag `CAT · FILES`, title "Who may *change* your files?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. Mr Botha shares the
   price list with his cashiers. Saturday morning: a birthday cake for R2.
   The link said "Anyone with the link can edit" - and it was forwarded.
   > Board: a cake with a R2 price tag; Clicky following a link that splits
   > into many arrows.
2. **Sharing a folder on a network (0:40-2:40).** Recap: access rights
   from Grade 11. Right-click > Properties > Sharing > Share > add a person
   or Everyone > Read or Read/Write > Share > Done. The network path
   \\BAKERY-LAPTOP\Orders; open it from the till by the address bar or
   Network; map it as a drive. The laptop must be on, the network Private,
   file and printer sharing on. Advanced Sharing: Read, Change, Full
   Control.
   > Screen: VM BAKERY-LAPTOP, share Orders with Read/Write. VM TILL: type
   > \\BAKERY-LAPTOP\Orders in the address bar; highlighter on the path.
   > Then switch BAKERY-LAPTOP off and show the till's error.
3. **Read or edit (2:40-4:30).** Two levels with three sets of names
   (Windows, OneDrive, Google). What each may and may not do. A copy is
   always possible. The rule: the lowest level that does the job -
   cashiers read, the manager edits. Why not edit for all: mistakes,
   mischief, trust in the data, malware.
   > Board: the read / edit table drawn column by column; yellow
   > highlighter on "lowest level that does the job".
4. **Sharing from OneDrive (4:30-6:40).** Share > people or link > Can view
   / Can edit > Send or Copy link. Specific people vs anyone with the link
   (forwarding). Expiry date, password on the link, block download (some
   accounts). Manage access, Stop sharing. Sharing is not a copy.
   > Screen: VM, OneDrive in the browser. Share Price list.xlsx with a
   > test address, Can view; open the link settings and show "Anyone" and
   > "Specific people"; Manage access > Stop sharing.
5. **The fix at the bakery (6:40-7:30).** Specific people, can view for the
   cashiers, edit for the manager.
   > Board: the bakery's three cashiers with an eye icon, the manager with a
   > pencil.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the R2 cake and the forwarded link | Start here |
| shared folder; the five steps; network path; Network and mapping; on, Private, sharing on; Advanced Sharing | `#network` |
| permissions; the read / edit table; a copy is always possible; lowest level; four reasons | `#permissions` |
| OneDrive steps; Google's names; specific people vs anyone; expiry, password, block download, Manage access; not a copy | `#cloud` |

## cat12-08.2 Locking files - passwords, 7-Zip and the .exe (about 9 min)

**Goes:** after the CAPS box `#exe` (the comment `// VIDEO cat12-08.2`),
before the IEB box `#versions`.
**The pupil can afterwards:** choose between Encrypt with Password, a
password to modify and Restrict Editing; set each; lock a compressed file
with 7-Zip; extract a password-protected .exe and delete it; say why the
password travels separately and why an unexpected .exe is dangerous.
**Thumbnail:** tag `CAT · FILES`, title "Lock it - *properly*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Thabo: "I put a
   password on my notes - now nobody can read them." Can they?
   > Board: Thabo's notes with a small padlock; Clicky peeking over the top.
2. **Three locks (0:30-3:00).** Recap Encrypt with Password (Grade 11).
   Password to modify: Save As > Tools > General Options. Restrict Editing:
   Review > Restrict Editing > Filling in forms > Start Enforcing
   Protection. Only encryption keeps a file private.
   > Screen: VM, Word, Recipes.docx: Save As > Tools > General Options >
   > Password to modify; reopen - the Read Only button. Then Review >
   > Restrict Editing on a form. Highlighter on each menu name.
   > Board: the three-locks table; a big "can still READ it" stamp on two.
3. **A good file password (3:00-3:40).** Strong; sent separately (e-mail
   the file, SMS the password); kept safe.
   > Board: an envelope and a phone going different ways, Clicky waving.
4. **A password on a compressed file (3:40-6:00).** Why: one password for
   many files of any type; one smaller file. Windows' Compress to ZIP has
   no password. 7-Zip: Add to archive > zip or 7z > password twice >
   AES-256 > (7z) Encrypt file names > OK. Extract: 7-Zip > Extract Here,
   type the password. A .zip still shows file names.
   > Screen: VM, select the Invoices folder > Show more options > 7-Zip >
   > Add to archive; fill in the box (highlighter on Encryption). Open the
   > .zip in 7-Zip to show the file names visible; repeat as .7z with
   > Encrypt file names.
5. **CAPS: extracting a password-protected .exe (6:00-8:00).** A
   self-extracting archive. Double-click > check Extract to > Extract >
   Show password > type it exactly > OK > check the files > delete the
   .exe (rename the folder if told to). A Windows warning: in an exam, ask
   the invigilator. Never an unexpected .exe from an e-mail.
   > Screen: VM, double-click Data2026.exe; tick Show password, type
   > Bake#26 slowly (highlighter on # and capitals); open the folder; delete
   > the .exe.
   > Board: "photos.exe" in an e-mail with Clicky shaking its head.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Encrypt with Password recap; the three-locks table; password to modify steps; Restrict Editing steps; only encryption keeps it private | `#passwords` |
| a good file password, sent separately | `#passwords` (A good file password) |
| why lock a compressed file; Windows cannot; 7-Zip steps; extracting; .zip shows names | `#zip` |
| self-extracting archive; the six steps; Windows warning; an .exe is a program | `#exe` (CAPS box) |

## cat12-08.3 Getting an old version back (about 5 min)

**Goes:** after the IEB box `#versions` (the comment `// VIDEO cat12-08.3`),
before the scenario.
**The pupil can afterwards:** restore a previous version from the Previous
Versions tab; say why the list can be empty; use version history in
OneDrive and Word; say why previous versions are not a full backup.
**Thumbnail:** tag `CAT · FILES`, title "Saved over it? Get it *back*"

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. Thabo saved over
   his essay and closed Word. Undo is gone.
   > Board: Thabo, a closed laptop, an Undo arrow crossed out.
2. **The Previous Versions tab (0:30-2:20).** Properties > Previous
   Versions; the list with dates; Open, Copy, Restore - what each does.
   Needs File History or restore points; otherwise "There are no previous
   versions available."
   > Screen: VM, Essay.docx > Properties > Previous Versions; Open one;
   > Copy one to the desktop; Restore. Then a file on a drive with no File
   > History: the empty message, highlighted.
3. **Version history in the cloud (2:20-4:00).** OneDrive: right-click >
   Version history; Word: File > Info > Version History; Google Docs: File
   > Version history. When and who. The bakery's price list: Friday's
   version restored, and the account that changed it. Group work.
   > Screen: VM, OneDrive, Price list.xlsx > Version history; restore the
   > earlier version; show the name of who changed it.
4. **Not a full backup (4:00-4:40).** A dead drive or ransomware takes the
   versions with it. Keep a backup somewhere else.
   > Board: a cracked drive with its versions falling in; a separate backup
   > drive safe on a shelf.
5. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Undo is gone once saved and closed | `#versions` |
| the tab; Open, Copy, Restore; File History; the empty message | `#versions` (In Windows) |
| OneDrive, Word and Google Docs version history; the price list fixed; group work | `#versions` (In the cloud) |
| not a full backup | `#versions` (the note) |
