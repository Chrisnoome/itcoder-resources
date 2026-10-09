# Course: Staying safe online (`safety`) - PLAN

Grade 8, eight lessons, General Computing. **Draft** (teachers only) in `CourseIndex()`
(`AIPascalCourse/lib/course.php`, 9 October 2026). Content in `content/safety/`.
**Written:** lessons 1-4 - `phishing`, `passwords`, `secondlock`, `leak` (9 October 2026),
each checked on the local testbed and by `check-jev.php` (no flags). Lessons 5-8 not yet
written. Lessons 1-3 were pushed for Chris to publish (9 October); lesson 4 is committed after
that push.

**Local only (9 October 2026):** `lib/course.php` has `'status' => 'open'` for Chris's review
on localhost, uncommitted. It must go back to `'draft'` before any publish - otherwise four of
eight lessons go live to pupils.

Platform: the course's body class `course-safety` (lesson.php) gives its doodle captions
Caveat (design-e.css); its fonts load with the others (design.php, lesson.php). Figures and
doodles are `public/assets/doodles/safety-*.svg`, made by a script (the board's drawings).

Art: the case file, Sniff and The Phisher - [../brand/safety-art-style.md](../brand/safety-art-style.md).
Every figure and doodle in this course follows it, never the blue pen.

## Purpose

Every lesson is a case. By lesson 8 every pupil can take any suspicious message, login,
app or friend request and work through the same findings form to a verdict, and knows what to do
next: who to tell, what to change, where to report.

Shape: spot the trick -> lock your accounts -> know what you give away -> people, not just
machines -> the big case.

## Lessons (draft - each earns the next)

1. **Case 01: The locked account** - phishing by SMS, WhatsApp and email. The three checks
   (sender, tone, link) and the findings form, introduced on the board's scam SMS. Look-alike
   addresses (`kasibank-verify.co` vs `kasibank.co.za`). The case load is the **`scamSpotter`**
   activity (`public/assets/scam-spotter.js`, built 9 October 2026): six messages from the
   block's `'messages'`, each worked through the findings form (sender, tone, link: red flag or
   not) before a verdict; the form fills in with a note per check and the message is stamped
   SCAM or CLEARED. Unmarked; the score is saved as activity state (only for enrolled pupils -
   a teacher previewing the draft gets a 403 from api/activity.php, which is expected).
2. **Case 02: The line-up** - how passwords are cracked (login page vs a stolen list of
   hashes; common list, name + numbers, look-alike swaps, everything), **length beats funny
   characters**, passphrases with a link to **xkcd 936** (linked, not copied - CC BY-NC and the
   site sells subscriptions), **one secret phrase plus a different part for each site**, and
   **password managers, for and against** (Chris, 9 October 2026 - managers moved here from
   lesson 3). Try-it **`crackTimer`** (`public/assets/safety-tryit.js`): the cheapest of four
   attacks at 10 billion guesses a second. Every time in the lesson and in the line-up figure
   (`doodles/safety-lineup.svg`, drawn by a script from the same numbers) is checked by
   `node tests/crack-timer.test.js` - change one, change all three.
3. **Case 03: The second lock** - know / have / are, two-step verification (2FA); OTPs by
   SMS, authenticator app or an "Is this you?" tap (passkeys as a margin note); three code
   tricks - the "bank fraud department" call (spoofing), the WhatsApp "code sent by mistake",
   the SIM swap; switch it on (email first, WhatsApp's PIN, the password manager), backup
   codes. The case load is `scamSpotter` again with five code messages.
4. **Case 04: The leak** - data breaches and what leaks; POPIA's rule that the company must
   tell you; credential stuffing (one key, every door); spear phishing with leaked details;
   checking on Have I Been Pwned (linked; email only, with an adult); five steps after a leak.
   The case load is `scamSpotter` with four after-the-leak messages.
5. **Case 05: What your apps know** - permissions, location, contacts, cookies and trackers,
   "free" apps paid for with data. POPIA in Grade 8 words: what a company may keep about you
   and what you can ask for. Activity `permissionAudit`: an app asks for permissions, pupil
   allows or denies each, with the reason.
6. **Case 06: The photo that travelled** - the digital footprint, screenshots last for ever,
   location in photos, what happens to a shared picture, and the law in plain words.
7. **Case 07: The fake friend** - social engineering, fake profiles, cyberbullying, the red
   flags of someone grooming a child online, and who to tell (a trusted adult, the platform,
   Childline 116).
8. **Case 08: The big case** - one case file with several exhibits (a message, a login page,
   an app, a friend request), each worked through the findings form; the final assessment
   (markMax 30, banded rubric, on the AI course's model).

## Course rules

- **Fictional names for banks, shops and apps** in every exhibit (KasiBank, as on the board), so
  no figure imitates a real company. Real services are named only in prose where a pupil needs
  them (how to turn on two-step verification in WhatsApp, say).
- **Dated facts** (scam types in the news, laws, app settings) go in a yearly-update list,
  as for the AI course, checked every January.
- Marking: Jev first, Claude for the unsure (as in every course).
- Written questions markMax 4; lesson 8's capstone 30.

- **Lessons 6 and 7: awareness and who to tell** (Chris, 9 October 2026). Red flags, the law
  in plain words, and where to get help (a trusted adult, the platform's report button,
  Childline 116). No scenario with explicit detail.

## Questions for Chris

- Does the school have counsellor wording for lessons 6 and 7 to follow?
- Should parents get a short take-home page per lesson (the findings form, the settings to check)?
- Glossary and Practice on the AI course's model (every word for every pupil)?
- Videos: any you already use for online safety?
