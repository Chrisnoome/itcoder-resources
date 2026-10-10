# Grade 7 Inside the machine - video plans for the video chat

Chris, 10 October 2026: "vide requirements to the video queue". The course is `machine`
(`AIPascalCourse/content/machine/`; plan [machine-course.md](machine-course.md)).

There are **7 videos, one per lesson, about 40 minutes in all.** Each **Goes** line gives the
place in the lesson. Add a `// VIDEO machine-NN.n` comment there when you start the video.

## Rules

- **Method and voice:** follow [tutorial-videos.md](tutorial-videos.md).
- **Thumbnails** come from a new `thumbs-machine.json`:
  - background `#0f5132`, accent `#c99a1a`, second colour `#d9542c`;
  - tag `INSIDE · DISTRICT N`.
- **The look** is [../brand/machine-art-style.md](../brand/machine-art-style.md):
  - the circuit-city map, with the pin moving to the lesson's district;
  - Volt in speech bubbles;
  - the accurate part drawings (`lessons/machine/part-*.svg`) whenever a part is named.
- **Real hardware on camera.** Where possible, show the real part beside the drawing.
  - Use a desktop with its side panel off: point to the CPU cooler, the RAM sticks, the
    SSD/HDD, the PSU and its back switch.
  - Never open a live power supply.
- **Never show a marked answer.**
  - Video 4 converts different numbers: 12, 37 and 5, not 6, 22 or 9.
  - Video 5 uses a different size sum: songs on a 1 GB drive.
  - Video 7 shows the technician's method on a different case, not the lab computer's report.
- Nothing goes in a video that is not in the lesson text.

## The videos

| Video | Title | Min | Goes |
|---|---|---|---|
| machine-01.1 | Input, process, output - everywhere | 5 | `cycle` before `o1Atm` |
| machine-02.1 | The CPU: fast, and very literal | 6 | `speed` after `q2Literal` |
| machine-03.1 | RAM, storage, and why you save | 6 | `kinds` after `m3RamStorage` |
| machine-04.1 | Binary with eight light switches | 6 | `write` after `t4Read2` |
| machine-05.1 | KB, MB, GB: how big is a file? | 5 | `fit` after `q5Biggest` |
| machine-06.1 | How a message crosses the internet | 6 | `wires` after `o6WhatsApp` |
| machine-07.1 | Think like a technician | 6 | `board` after `m7Symptoms` |

## What each video covers

Each video:
1. **Hook:** the map and Volt.
2. **The idea:** with the part drawings.
3. **Real hardware**, or a worked example.
4. **Recap.**
5. **Sign-off.**

What each one must show:
- **01.1:** the four jobs, input and output devices, devices that do both, and a sensor.
- **02.1:**
  - the CPU in its socket, with the labelled motherboard and then the real board;
  - the "robot follows instructions literally" sketch;
  - fetch, decode and execute;
  - GHz and cores; heat, the fan and dust.
- **03.1:** RAM as the desk and storage as the filing cabinet. A real RAM stick and its notch.
  The HDD against the SSD (the M.2 stick). Save, then pull the power on a test file.
- **04.1:** eight switches, then 128 down to 1, reading and writing small numbers, 255, and A
  = 65.
- **05.1:** the size table, typical sizes, the "how many fit" sum, and extensions.
- **06.1:**
  - packets drawn on cards, numbered, sent by different routes and put back in order;
  - IP addresses and DNS;
  - wired against wireless, with a real router and an RJ45 plug.
- **07.1:** symptom, then part, then the simplest check first: the PSU switch, a loose cable,
  dust in the fan.
