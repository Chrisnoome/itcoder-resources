# CAT 11 lesson 21: Protecting yourself online - videos

Lesson: `content/cattheory11/protecting.php`. Three videos: anti-malware,
updates and firewalls; two kinds of proof and the padlock; backups. Board in
the CAT marker style with Clicky (brand/cat-art-style.md); yellow
highlighter on any words on screen being talked about. Two short screen
recordings in the video VM (Windows 11): Windows Security, and an https
address with its padlock. Everything below is in the lesson text.

## cat11-21.1 Anti-malware, updates and firewalls (about 7 min)

**Goes:** after the IEB section `#firewall` - the comment after it.
**The pupil can afterwards:** say what anti-malware does and how it finds malware, explain why it must be updated, and say what a firewall can and can't do.
**Thumbnail:** tag `CAT · SECURITY`, title "Is your anti-virus *asleep*?"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. After the ransomware at Botha's Bakery, Lerato writes a list on a serviette. "Which one is the most important?" "All of them - each one stops something the others miss." Like a house: a gate, burglar bars, an alarm, a dog, insurance.
   > Board: the serviette list; then the protecting-layers drawing, ring by ring.
2. **What anti-malware is (0:40-1:40).** Software that finds, blocks and removes malware and warns you. Anti-virus is the old name; anti-spyware looks for spyware; anti-malware is all of it. Windows has Microsoft Defender built in.
   > Screen: Windows 11 in the VM - Start, type "Windows Security", open it, click **Virus & threat protection**; yellow highlighter on "No current threats" and on the protection updates line.
3. **How it works (1:40-3:30).** Five steps: a list of known malware with a fingerprint for each (signatures); it checks every file as it arrives (real-time protection); scheduled scans; it watches what programs do - something scrambling hundreds of files is stopped; a suspect file goes into quarantine and you are warned.
   > Board: a file walking up to Clicky the security guard, who checks it against a clipboard of fingerprints; a suspicious file locked in a cage labelled QUARANTINE.
4. **Why update (3:30-4:40).** New malware every day; it only knows the fingerprints on its list. Old anti-malware still shows its icon but misses everything new. The free trial on a new laptop stops updating when it ends - pay for it or remove it so Defender switches on. Windows and app updates close the holes (lesson 5).
   > Board: the clipboard with a fresh page being added every day; a dusty, asleep guard labelled "trial ended".
5. **Firewalls (4:40-6:30).** Checks data going in and out, like a bouncer with a list. Hardware firewall in the router for the whole network; software firewall on each computer, even on the mall's Wi-Fi. It can block outside connections and stop spyware "phoning home". It can't stop a phishing e-mail, malware on a flash drive, or remove malware.
   > Board: a bouncer at the router's door; then a second, smaller bouncer on a laptop at a mall; three things walking past him untouched - an e-mail, a flash drive, a bug already inside.
   > Screen: Windows Security, **Firewall & network protection** - highlighter on "Firewall is on".
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| Lerato's list; layers like a house | Start here, `#layers` |
| anti-malware, anti-virus, anti-spyware; Microsoft Defender | `#antiMalware` |
| how it works, quarantine | `#antiMalware` (How it works) |
| why it must be updated; the trial | `#antiMalware` (Why it must be updated) |
| firewalls: two kinds, can and can't | `#firewall` (IEB section) |

## cat11-21.2 Two kinds of proof, and what the padlock means (about 8 min)

**Goes:** after section `#https` - the comment after `w21Https`.
**The pupil can afterwards:** explain multi-step verification and the ways to give a second proof, say why SMS OTPs are weaker, decide which app permissions to allow, and say what https and the padlock do and don't mean.
**Thumbnail:** tag `CAT · SECURITY`, title "The padlock *doesn't* mean safe"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. A keylogger recorded Thabo's e-mail password. The criminal typed it in - and still couldn't get in. Why?
   > Board: a keylogger plug; a login screen with a password typed; a second box "Enter the code from your app" with a big padlock.
2. **Two kinds of proof (0:40-2:40).** Recap: something you know, have, are. Multi-step verification - two-step verification, 2FA, all the same thing. Four ways to give the second proof: an SMS OTP (weak against a SIM swap and a vishing caller); approving in the bank's app; an authenticator app with a new code every 30 seconds; a fingerprint or face. Switch it on for e-mail first - it resets everything else - then banking, WhatsApp, social media.
   > Board: the protecting-mfa drawing; then four numbered sticky notes, the SMS one with a small warning triangle.
3. **App permissions (2:40-4:10).** Each thing an app asks to use is a permission. One question: does the job need it? A torch app needs the flashlight, not your contacts, location, microphone or SMS - and an app that reads SMS can read your OTPs. Allow only while using; ask every time; deny. Check the permission manager in Settings now and then.
   > Board: the priv-torch-app drawing; Clicky tapping Deny four times and Allow once (on the flashlight).
4. **https and SSL (4:10-5:30).** Your card number travels through many computers. SSL (now TLS) scrambles it on the way. The signs: https:// with the s for secure, and the padlock. A site without it says Not secure.
   > Board: the http-https-wifi drawing - the same password readable on http, nonsense on https; highlighter on the s.
   > Screen: Edge in the VM at `https://www.bestlessons.co.za` - click the icon beside the address and show "Connection is secure".
5. **What the padlock does NOT mean (5:30-7:00).** It doesn't mean the site is honest or real - a scam site can have a padlock too. Gogo's SMS link had a padlock: her password went, privately, straight to the criminal. Before you pay: typed the address yourself; the real address; https and padlock; no warning; approve the payment yourself, and tell nobody the OTP.
   > Board: the keys-padlock-honest drawing (bank-secure-l0gin.co with a padlock) - highlighter on the zero in l0gin; then the five-step checklist.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| the keylogger and the second proof | `#mfa`, `w21Mfa` |
| the four ways to give a second proof; where to switch it on | `#mfa` |
| app permissions: does the job need it; the choices; checking them | `#permissions` (CAPS section) |
| SSL, https, the padlock, Not secure | `#https` |
| what the padlock does not mean; Gogo's SMS link | `#https` (table), `r21Padlock` |
| the checklist before paying | `#https` (Before you type your card details) |

## cat11-21.3 Backups that work - the 3-2-1 rule (about 6 min)

**Goes:** after section `#backups` - the comment after `w21Sync`.
**The pupil can afterwards:** say what to back up and how often, apply the 3-2-1 rule, compare an external drive with a cloud backup, and keep a backup out of ransomware's reach.
**Thumbnail:** tag `CAT · SECURITY`, title "3 copies. 2 kinds. *1* away."

### Scenes

1. **Hook (0:00-0:30).** Hi, and welcome to BestLessons. A deleted folder, a stolen laptop, a dead drive, a fire, ransomware. Five different disasters - one protection that helps against all of them.
   > Board: five little disaster drawings around one backup drive, each joined to it by an arrow.
2. **What and how often (0:30-1:30).** Back up your own files - documents, projects, photos, the bakery's records - not the programs, which can be installed again. As often as you can't afford to lose the work.
   > Board: a folder labelled MY FILES going into a drive; a program box with "reinstall" written beside it.
3. **The 3-2-1 rule (1:30-3:00).** Three copies: the original and two backups. Two kinds of storage: the laptop's drive and an external drive. One copy off-site: at home or in the cloud.
   > Board: the backup-321 drawing, built number by number, each number highlighted.
4. **Drive or cloud (3:00-4:00).** External drive: pay once, about R1 200 for 2 TB, fast - but lost with the laptop if kept in the same place. Cloud: off-site and safer from ransomware with version history - but a monthly fee and slower. Many people use both. A flash drive is small and easy to lose.
   > Board: the two-column table, row by row.
5. **Out of ransomware's reach (4:00-5:30).** Unplug the drive after each backup. Use version history. Syncing is not a backup - a deletion or a scrambled file is copied everywhere in seconds. Make it automatic, and test a restore now and then: a backup never restored is only a hope.
   > Board: the sync-not-backup drawing; then a plug being pulled out of a drive, and Clicky restoring one file with a tick.
6. **Sign-off.**

### In the text

| Video point | Lesson anchor |
|---|---|
| one protection against almost every threat | `#backups` |
| what to back up, how often | `#backups` (What to back up) |
| the 3-2-1 rule; off-site | `#backups` (The 3-2-1 rule) |
| external drive or cloud | `#backups` (Which storage?) |
| unplug, version history, syncing is not a backup | `#backups` (Backups that ransomware can't reach), `w21Sync` |
| automatic, test a restore | `#backups` (Make it automatic - and test it) |
