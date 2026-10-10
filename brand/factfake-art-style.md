# Grade 8 Fact or fake (`factfake`) art style: the group chat and the Lens scanner, Echo and Lens

Chris chose these on 10 October 2026, from the board
(https://claude.ai/artifact/TL7ugm2NHkWrEbgDadvfpr, version 2, source
`brand/factfake-art-board.html`).

He turned down the first board, which was newspapers and TV news: *"kids dont read newspapers or
watch tv news - try again"*. **Rule for this course and others: draw pupils' own media world**
(group chats, short-video apps, games, memes and streams), not adults' media.

From the second board he chose:
- **"A + F"**: the group chat together with the Lens scanner;
- **Echo and Lens** as the mascots.

No other course uses this look.

## The group chat (where rumours arrive)

- **The app:** a made-up chat app called "Chatter".
- **Colours:** a green bar `#1f9d63` and a pale green background `#e9f3ee`.
- **Bubbles:**
  - white bubbles for other people's messages, with sender names in orange `#c2410c`;
  - the class's fact-check replies in mint `#d6f5e3`.
- **Details:** an italic "Forwarded many times" label, voice-note waveforms, and link previews in
  blue.
- **Type:** Nunito (700 to 900).
- **Uses:**
  - every lesson opener: `doodles/factfake-chat-NN.svg`, the day's viral message, with Echo
    and Lens beside it;
  - `FactChat()` (`content/factfake/helpers.php`), which draws chat messages inside the lesson
    text.

## The Lens scanner (how they get checked)

- **The view:** a phone camera with cyan `#3df2ff` corner brackets, a magenta `#ff2bd6` scan line,
  and clues circled in magenta.
- **The checklist:** in VT323, on near-black `#0b0f14`, with the verdict in gold `#ffd23f`.
- **Used for:** search results, reverse image search, and the circled AI clues.

## Echo and Lens

- **Echo** is a grey parrot holding a phone. Echo shares everything instantly and always too
  early. Echo's arc across the course is learning to pause.
- **Lens** is a magnifying glass with a face. Lens looks closer: who made it, when, and where it
  came from.

The running joke: Echo shares and Lens checks, and the lesson is the gap between them.

## Rules

- **Everything is made up:** the apps, accounts, people, posts and links. Links end in
  `.example`, and the school is Ridgeview High.
- **No real brands, posts or people.** Real places are not used for fake events.
- The AI picture for the find-the-clues question (`lessons/factfake/pic-ai-trophy.svg`) is
  drawn by us, with the typical AI mistakes put in on purpose.
- The art is drawn by `AIResources/tools/factfake/make_art.py`. ComfyUI is used only for the
  icon, badges and emblems in the queue.
