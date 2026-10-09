# Staying safe online - video plans for the video chat

Chris, 9 October 2026: "create scripts for the video producer to create videos for the
course." The course is `safety` (Grade 8, General Computing, eight lessons, each a "case") in
`AIPascalCourse/content/safety/`; its plan is [../safety-course.md](../safety-course.md).

**16 videos, two per lesson, about 1 hour 40 minutes in all, each under 8 minutes.** One file
per lesson. Each video has its place in the lesson (the **Goes** line - add a
`// VIDEO safety-NN.n` comment there when you start it), scenes with draft narration and
`> Board` / `> Screen` directions, and a table showing where every point is in the lesson
text.

## Rules for these videos

- The method and voice of [../tutorial-videos.md](../tutorial-videos.md): Chris's cloned
  voice, narration first, "Hi, and welcome to BestLessons.", the BestLessons sign-off, title
  card and thumbnail, `.srt` captions. Thumbnails from a new `thumbs-safety.json` in
  `brand/youtube/source/`: dark ink `#2a2116` with accent `#b3141c`, kraft `#d6b277` as the
  second colour; tag `SAFETY · CASE NN`.
- **Board scenes in the course's case-file style** - a kraft manila folder, the exhibit pinned
  as a Polaroid, index-card clues tied to it with red string, one rubber stamp, Special Elite
  typewriter labels and Caveat handwriting; **Sniff** the bloodhound as the hero and **The
  Phisher** as the villain ([../../brand/safety-art-style.md](../../brand/safety-art-style.md)).
  Never the IT blue pen or CAT's marker. The lesson figures and doodles are in
  `AIPascalCourse/public/assets/doodles/safety-*.svg` and the scripts that drew them in this
  chat's scratchpad were one-off - redraw scenes in that style, building the figure up clue by
  clue (a card appears, then its string, then the next).
- **Every company is made up**: KasiBank (kasibank.co.za), ShopNow, GameZone, SuperTorch,
  QuizMania, Snapgram. Never show a real bank, shop or app as the scammer or the victim.
- **Phone screens are drawn**, not recorded - the SMS, chat and permission screens on the
  board. The only screen recordings are in the VM (Windows 11, Edge): the Edge password manager
  and Windows privacy settings in safety-02.2 and safety-05.1; check each menu name in the VM
  first.
- **xkcd 936 is described and linked, never shown** (CC BY-NC; the site sells
  subscriptions). Put the link in the YouTube description.
- **Lessons 6 and 7 are awareness level** (Chris, 9 October 2026): red flags, the law in plain
  words, who to tell. No scenario with explicit detail, no dramatised abuse. Keep the tone
  calm; end each of those videos with the help line card (trusted adult, Report button,
  Childline 116).
- **Nothing in a video that is not in the lesson text.** If a video needs a new point, add it
  to the lesson first.
- When a video is on YouTube, the lesson's `// VIDEO` comment becomes a `video` block with its
  id - never before (ids are never invented).
- Finished videos go in the one flat "for upload" folder with their thumbnail, captions and
  YouTube text (tutorial-videos.md).
- The draft narration is a starting point. Make the video straight away; Chris corrects from
  the video.

## The videos

| Video | Title | Min | Plan |
|---|---|---|---|
| safety-01.1 | The SMS that wants your money | 6 | [phishing.md](phishing.md) |
| safety-01.2 | Read a web address like a detective | 6 | [phishing.md](phishing.md) |
| safety-02.1 | How long would YOUR password last? | 7 | [passwords.md](passwords.md) |
| safety-02.2 | One phrase, every site - and password managers | 7 | [passwords.md](passwords.md) |
| safety-03.1 | The second lock | 5 | [secondlock.md](secondlock.md) |
| safety-03.2 | Three tricks to steal your code | 7 | [secondlock.md](secondlock.md) |
| safety-04.1 | One leak, every door | 6 | [leak.md](leak.md) |
| safety-04.2 | Were you in a leak? What to do next | 5 | [leak.md](leak.md) |
| safety-05.1 | Why does a torch want your contacts? | 6 | [apps.md](apps.md) |
| safety-05.2 | If it's free, who pays? | 6 | [apps.md](apps.md) |
| safety-06.1 | The photo that travelled | 6 | [footprint.md](footprint.md) |
| safety-06.2 | What your photo knows | 5 | [footprint.md](footprint.md) |
| safety-07.1 | The fake friend: four clues | 6 | [fakefriend.md](fakefriend.md) |
| safety-07.2 | Cyberbullying, bystanders and back-up | 6 | [fakefriend.md](fakefriend.md) |
| safety-08.1 | The full findings form | 5 | [bigcase.md](bigcase.md) |
| safety-08.2 | The big case, solved | 7 | [bigcase.md](bigcase.md) |
