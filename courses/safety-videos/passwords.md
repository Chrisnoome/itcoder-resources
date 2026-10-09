# Safety lesson 2: Case 02 - The line-up - videos

Lesson file: `AIPascalCourse/content/safety/passwords.php`. Two videos. Every crack time comes
from the crackTimer try-it (`public/assets/safety-tryit.js`, checked by
`tests/crack-timer.test.js`) - use only these numbers.

## safety-02.1 How long would YOUR password last? (about 7 min)

**Goes:** after the order question `o2Lineup` (section `#lineup`).
**The pupil can afterwards:** explain how passwords are cracked, and why length beats funny
characters.
**Thumbnail:** tag `SAFETY · CASE 02`, title "Cracked in *2 seconds*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. The Phisher couldn't trick you. So
   now he'll guess. Hopeless? Not if your password is the kind most people choose.
   > Board: The Phisher with his "TRY FIRST" receipt: 123456, password, qwerty, iloveyou.
2. **Two ways to guess (0:40-1:50).** At the login page - slow, and you get locked out.
   From a stolen list - the dangerous one. The list is scrambled (a hash), but he scrambles
   his guesses the same way. No lockout: a gaming PC tries about 10 billion guesses a second.
   > Board: a login box with a padlock "3 tries"; then a stolen list and a PC with a counter
   > spinning "10 000 000 000 / s".
3. **The cracker's order (1:50-2:50).** Common passwords first; then names and words with
   numbers (sipho2010); then look-alike swaps (P@ssw0rd); then everything else.
   > Board: four index cards in order, pinned left to right.
4. **The PIN (2:50-3:40).** Four digits: 10 x 10 x 10 x 10 = 10 000. One more digit: not 10
   more - ten times as many, 100 000. Every extra character multiplies the work.
   > Board: four boxes of 0-9 multiplying; a fifth box drops in and the number jumps.
5. **The line-up (3:40-5:30).** Six suspects, each as tall as the time to crack: 123456
   instantly; sipho2010 about 2 seconds; Tr0ub4dor&3 instantly; kH7#qzP about 2 hours;
   "purple taxi river mango" about 6 months; add "braai" - about 10 000 years.
   > Board: the line-up figure built suspect by suspect, the height lines (a second, an hour,
   > a year, a thousand years) drawn first; each card's time written in Caveat as the
   > silhouette grows.
6. **Length beats funny characters (5:30-6:40).** 8 random characters of every kind - about 8
   days. 16 small letters - about 100 000 years. Funny characters make each place a little
   harder; extra places multiply the whole lot. A site demands a symbol? Add it - but make it
   long.
   > Board: two cards side by side, "8 days" in red and "100 000 years" in green.
7. **Sign-off.** Try the crack timer in the lesson - with made-up passwords only.

### In the text

| Video point | Lesson anchor |
|---|---|
| login page vs stolen list, hash, 10 billion a second, the cracker's order | `#guessing` |
| the PIN, 10 000 and 100 000 | `t2PinCount`, reveal `r2OneMore` |
| the six suspects and their times | `#lineup` |
| 8 days vs 100 000 years | `#length` |

## safety-02.2 One phrase, every site - and password managers (about 7 min)

**Goes:** after the match `m2ManagerSides` (section `#managers`).
**The pupil can afterwards:** make a passphrase, keep a different password for each site, and
weigh up a password manager.
**Thumbnail:** tag `SAFETY · CASE 02`, title "correct horse battery *staple*"

### Scenes

1. **Hook (0:00-0:40).** Hi, and welcome to BestLessons. One of the most famous comics on the
   internet is about passwords: xkcd number 936, "Password Strength", by Randall Munroe. The
   link is in the description - read it, then come back.
   > Board: a blank comic frame with "xkcd 936 - link below" written in it. Do not show the
   > comic.
2. **The comic's point (0:40-2:00).** Tr0ub4dor&3: hard for you to remember, easy for a
   computer. correct horse battery staple: four random words, easy to picture, hard to guess.
   Its numbers imagine a slow attack at a website; ours a stolen list - but the order is the
   same. That's a passphrase. Two rules: the words must be random (not a song, a team, "i love
   my dog bruno"), and use at least four - five for important accounts.
   > Board: a horse saying "correct!" to a battery stapled to the wall, drawn in the case
   > style; two index cards with the rules.
3. **The biggest mistake (2:00-3:10).** The same password everywhere: one key for your house,
   bike, locker and gran's door. One site's list is stolen, and scammers try it everywhere.
   > Board: the one-key doodle - three doors, one key "fits all!".
4. **One phrase, changed for each site (3:10-4:30).** Keep one secret phrase - purple taxi
   river mango - and add a part for each site that reminds you of it: "envelope stamp" for
   email, "dragon cave" for a game. One phrase and a picture per site. Warning: not the site's
   name - "...gmail" lets anyone who sees one leak guess the rest.
   > Board: the base phrase on a card; three site cards hung from it on red string, each with
   > its added words; a red X over "purple taxi river mango gmail".
5. **Password managers (4:30-6:20).** An app with a locked vault and one master password. For:
   long, random, different passwords for every site; it remembers them; it only fills in on
   the real site, so it stays quiet on kasibank-verify.co; leak warnings; phone and computer.
   Against: all your eggs in one basket - so a strong master password and a second lock (Case
   03); forget it and you may be locked out; you must trust the company; some cost money
   (built-in ones are free); a shared family computer. For most people the good side wins.
   Master password on paper, safe at home - not a sticky note on the screen.
   > Board: Sniff guarding the safe; two columns of cards, FOR and AGAINST. Then the sticky-note
   > doodle with a big red X.
   > Screen (VM, Edge): Settings > Passwords, showing the built-in password manager's list and
   > its "suggest a strong password" option on a sign-up form. Use a test profile; no real
   > passwords visible.
6. **Sign-off.** The lesson's written question asks you to advise Lerato. Over to you.

### In the text

| Video point | Lesson anchor |
|---|---|
| xkcd 936, passphrase, the two rules | `#horse` |
| one key, every door; one phrase + a part per site; not the site's name | `#perSite` |
| password managers for and against; the master password on paper | `#managers` |
