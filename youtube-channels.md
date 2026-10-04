# YouTube channels

All are Brand Accounts under chris.noome@gmail.com, created 3 October 2026
(Chris clicks Create; Claude fills in names, handles and descriptions in
YouTube Studio). Descriptions carry no personal name (Chris, 3 Oct 2026).
Logos, banners, watermarks and end cards: the Art chat, files in
`brand/youtube/<folder>/` (avatar.png 800, banner.png 2560x1440 with text
inside 1546x423, watermark.png 150 transparent, endcard-bg.png 1920x1080).

| Channel | Handle | Channel ID | Ties to the site | Art folder |
|---|---|---|---|---|
| AI 4 All | @AI4AllSA | UCThqggjlsU6ob8hKuPbqndA | no | ai4all |
| AI for Teachers | @AIforTeachersSA | UCp1gqgeYZK4-NC_CqXS9_mA | no | ai4teachers |
| Pascal School SA | @PascalSchoolSA | UCIvtXgauB3KHJ0O-DAe0H5A | yes - Pascal course | pascal |
| Java School SA | @JavaSchoolSA | UCj1ScpNorZzpltULQVJQZrw | yes - Java course | java |
| SQL School SA | @SQLSchoolSA | UCEu6IetqpdDqt-Io9PRJqmA | yes - SQL course | sql |
| CAT School SA | @CATSchoolSA | UCWNaBSXRLWj2FwXyaQ0-Tuw | yes - CAT course | cat |
| Computer Skills SA | @ComputerSkillsSA | UCMxJJhzHqCdlOLl4GmAtAkQ | link only - general tool how-tos (install videos 10-17) | skills |

Older channels: **Pascal Code Singer** (@PascalCodeSinger,
UCb24pUo8CSo__XW2vB4q88Q, the songs; new art from `brand/youtube/codesinger/`
uploaded 3 Oct 2026 - white note and gold semicolon on black, outside the
School SA look; the old claymation-style picture was
`yt3.ggpht.com/u-TA2eUVI8S5uUwenJSk3dMbsoWJrG65CeehqlKy2RDnJmA6kySAI6WUB2I7uPB8fsnbhg8h`)
and The Code Singer (@ClaudeSuno), left as it is.

Pascal Code Singer's 14 videos got new thumbnails, titles ("Song - topic (IT song)") and
descriptions on 3 Oct 2026, after Chris approved each on
https://claude.ai/artifact/Xa9Q8k67a4x1AfmEvNCP2g. Source: `brand/youtube/source/thumbs.json` +
`thumbs.py` (frames from the videos in `brand/youtube/codesinger/frames/`); the old titles and
descriptions are in `brand/youtube/codesinger/old-titles-descriptions.md`. New song videos should get
the same treatment: add an entry to thumbs.json and run thumbs.py.

Pascal Code Singer's public contact email (Chris's address) was removed on
3 Oct 2026 (Chris). None of the channels has a contact email.

Pascal Code Singer's description before 3 Oct 2026 (replaced with a
songs-only one, Chris):

> Coding is magic. Coding is a passion. Coding is fun.
> The aim of this channel is to help you learn all about programming in
> Pascal (Delphi / Lazarus). The content is for anyone just starting
> programming - and for anyone who is also looking for some more advanced
> tricks and techniques. The IEB (Independent Examinations Board) SAG
> syllabus and the DOE (South African Department of Education) CAPS syllabus
> are covered in both Theory and Practical.
> Playlists include: Songs that help you remember important programming and
> IT theory concepts; IT theory content; Pascal programming beginner's tips;
> Pascal programming for Matric pupils; GUI tips; Longer sample projects for
> PATs. Or, if you are not a South African school pupil, just learn
> programming and have fun!

@AI4All and @AIforTeachers were taken, hence the SA suffix.

## BestLessons: one channel, playlists per subject (4 October 2026)

YouTube verifies only two channels a year per phone number, and custom thumbnails need a verified
channel, so Chris chose one main channel (4 Oct 2026). It is also better for monetisation, because the
Partner Program counts watch hours and subscribers per channel.

- **Pascal Code Singer was renamed BestLessons, @BestLessonsSA** (UCb24pUo8CSo__XW2vB4q88Q), with a
  new all-subjects description. Every new video goes here.
- The seven channels in the table above are **parked, empty**: they keep their art, but get no uploads.
- AI 4 All and AI for Teachers are playlists now, not channels.
- All 166 old playlists were set to **private** (none deleted). The new public playlists:

| Playlist | ID | Cover (`brand/youtube/playlists/`) |
|---|---|---|
| IT songs (13 songs) | PLRm72f41crCs | it-songs.png - set |
| Pascal | PLNZqbWxbF8ds | pascal.png - set |
| Java | PLQvVbWwEQGXM | java.png - after its first video |
| SQL and databases | PLHccRW6P5DZg | sql.png - after its first video |
| CAT | PLKVWwt37_Zh8 | cat.png - after its first video |
| Computer skills | PLDaS9R_GFhx0 | computer-skills.png - after its first video |
| AI 4 All | PLfnu74dR9LIc | ai-4-all.png - after its first video |
| AI for Teachers | PLBS4vk8yfEiM | ai-for-teachers.png - after its first video |

Covers come from `thumbs.py --playlists`, in the same style and colours as the videos. **YouTube
offers no cover for an empty playlist**, so a cover goes on with the playlist's first video: on
youtube.com/playlist?list=ID, hover over the cover, click the pencil (Edit Thumbnail), upload, Done.
On thumbnails and title cards, the channel name is BestLessons for every subject.

## What each channel is for

- **AI 4 All** - interesting and useful ways to use AI for everyday people,
  not AI experts.
- **AI for Teachers** - two levels: admin, and making resources. Recommends
  AI tools that are free, easy and add value.
- **Pascal / Java / SQL / CAT School SA** - videos that go with the
  bestlessons.co.za courses (install videos, tutorials).
- **Computer Skills SA** - using your computer more effectively and
  efficiently: everyday skills and free tools that save time (install videos
  10-17 and more).

## Working notes

- A new channel's Studio page says "you don't have permission" for a minute
  or so after creation, even after switching to it; wait and reload.
- Switch channel at youtube.com/channel_switcher before opening its Studio.
- Typing into Studio's description box sometimes doesn't take; check the box
  after Publish (reload and read it back).

## Art

Avatar, banner and watermark uploaded to all seven on 3 October 2026 (Chris
chose all-SVG art; sources and `source/build.py` in `brand/youtube/`).
Watermark display time is YouTube's default, **end of video**.
`endcard-bg.png` is not a channel setting - it goes into each video's last
5-20 seconds, with YouTube's end-screen elements over it.

## Cards to other videos

**When a video mentions another video, the chat that makes it writes a
card note for the YouTube chat** (Chris, 4 October 2026): in the video's
`youtube.md`, a "Cards" list - the time in the finished file (title card
included), the words said, and the video to link (title, channel, ID once
known). The YouTube chat adds each card at that time when it uploads.
Times are updated whenever the video is re-rendered.

## Links

The four School SA channels, Computer Skills SA and Pascal Code Singer have one link,
**BestLessons** -> https://bestlessons.co.za (Chris, 3 Oct 2026). The AI
channels have none.

## Thumbnails and title cards

One style for every channel (brand/youtube/README.md, "Video thumbnails"): `brand/youtube/source/thumbs.py`.
Every finished video opens with its thumbnail as a 3-second title card at 1920 x 1080
(`thumbs.py --card`), no separate sound - the video's own sound starts under it (Chris, 3 Oct 2026).

## Still to do

- Install-video sign-off: the scripts (`E:\itcoder-videos\scripts\NN-*.md`)
  now name the new channel; re-voicing the line and changing the on-screen
  "Pascal Code Singer" in `edit\NN-*.json` is with the chat that makes the
  install videos, "Database planning: caps and sags" (handed over 3 Oct 2026).

- Install videos go to each subject's School SA channel (Chris, 3 Oct
  2026); courses/install-videos.md says so.

## Install videos on BestLessons (4 October 2026)

All 19 uploaded, Public, with our title, description, thumbnail (`brand/youtube/<folder>/thumbs/install-NN-*.png`)
and our English (UK) captions (`out/final/NN-*.srt`). Titles and descriptions come from `thumbs-*.json`.

| NN | Video | ID | Playlists |
|---|---|---|---|
| 01 | Lazarus | 9VSHNetcIM8 | Pascal |
| 03 | JDK | h_puRYS0OM4 | Java |
| 04 | jGRASP | RDGT9EaJfsQ | Java |
| 05 | NetBeans | E7IkiLV1vFU | Java, SQL |
| 06 | Java DB | nz4K9FM7bso | SQL |
| 07 | MySQL | zIaeScqkFL8 | SQL |
| 08 | DBeaver | s37LfMjZurM | SQL |
| 09 | Letos (SQLite) | yd0jxc2c-Cg | SQL |
| 10 | File Explorer | ExHmPxC1ZLg | Computer skills, CAT |
| 11 | Notepad++ | Okx8X9cSgr8 | Computer skills |
| 12 | 7-Zip | xfK2mtwWEdc | Computer skills, CAT |
| 13 | draw.io | 0aYZ8aA_Btg | Computer skills, CAT |
| 14 | Git | eegb3tAUr7I | Computer skills |
| 15 | OneDrive | SgvYCFAbrZ4 | Computer skills, CAT |
| 16 | Google Drive | Zv7Ge2_M2yU | Computer skills, CAT |
| 17 | Office and Access | dJRv6DrPOAI | Computer skills, CAT, SQL |
| 18 | Edge | C4sZj8xxeDI | Computer skills |
| 19 | Chrome | B8HY7VQsqRk | Computer skills |
| 20 | Firefox | nUOMxO6h8AQ | Computer skills |

Channel art replaced on 4 Oct 2026 (Chris approved): banner, "bl" profile picture and watermark from the site's
logo files, made by `brand/youtube/source/bestlessons_art.py` -> `brand/youtube/bestlessons/`.
Playlist covers set: IT songs, Pascal, Java, SQL and databases, CAT, Computer skills (AI ones wait for videos).

In the lessons (AIPascalCourse 75e3990 and 60ce4f4, not published yet - Chris: "not yet"): setup-lesson.php
`$setupVideos` (all but Delphi; draw.io and Git in a new step 7 for both Pascal and Java), pascal/ides.php
(Lazarus), java/lesson03.php (JDK, jGRASP, NetBeans), sql/javadbsetup (Java DB, NetBeans, DBeaver),
sql/mysqlsetup (MySQL), sql/sqlitesetup (Letos), sql/access00 (Office and Access).

Cards (links inside the videos) added on 4 Oct 2026 from `out/final/NN-*.youtube.md`: 24 cards on 16 videos - File
Explorer where the voice mentions it, OneDrive and Google Drive 2 s apart where it mentions both. All 19 checked with
our en-GB caption track on the watch page (18's Studio "Catalan" row is not shown to viewers).
How: Studio's own `video_editor/edit_video` with `infoCardEdit.infoCards` [{videoId, teaserStartMs,
videoInfoCard: {videoId}}] replaces a video's whole card list; `creator/list_creator_info_cards` {videoId} reads it.
YouTube auto-dubs and auto-translates titles into many languages; Chris chose to keep it on (4 Oct 2026).
