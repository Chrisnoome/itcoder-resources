# Grade 7 Inside the machine (`machine`) - how computers work

Chris chose this course from the Grade 7/8 plan ([grade7-8-courses.md](grade7-8-courses.md)) on
10 October 2026. The art is set out in
[../brand/machine-art-style.md](../brand/machine-art-style.md).

| Part | Where |
|---|---|
| Lessons | `AIPascalCourse/content/machine/` |
| Art | `tools/machine/make_art.py` |
| Videos | [machine-videos.md](machine-videos.md) |

The course is **sequential**, and **every key question is gated** (`'gate' => true`). Like
every new course, it has:
- its own level names (`lib/practice.php`, Dust Speck to Master Engineer);
- margin extras in every lesson: facts and a joke;
- its own home page colours.

## The story

Dr Ndlovu's shrink ray goes wrong. The class ends up the size of a speck of dust inside the
broken lab computer.
- **Volt**, a spark of electricity, guides them district by district.
- Dr Ndlovu radios in from outside.

The computer won't start because the power supply's switch at the back is off. The fan is also
clogged with dust, and the storage is full. The class fixes the computer and is un-shrunk.

## The lessons

| # | Id | Title | Gated |
|---|---|---|---|
| 1 | `ipo` | Input, process, output | `m1InOut` (sort the devices), `o1Atm` (the ATM, in order) |
| 2 | `cpu` | The CPU | `hs2Board` (find the CPU, ports and power), `t2Giga` (2 GHz) |
| 3 | `memory` | Memory and storage | `m3RamStorage`, `lp3Board` (label the motherboard) |
| 4 | `binary` | Binary: 0s and 1s | `t4Read1` (6), `t4Read2` (22), `t4Write` (9 = 00001001) |
| 5 | `files` | Files and sizes | `o5Units`, `t5Photos` (2 GB / 4 MB = 500), `m5Types` |
| 6 | `internet` | The internet | `o6WhatsApp` (the steps, in order), `s6Wireless` |
| 7 | `fix` | Fix the computer (final) | `m7Symptoms`, `hs7Board`, and the written `w7Report` (6 marks, Jev) |

File sizes use 1 000 (as phone and drive makers do). A margin note explains 1 024.

## Checks

These were run on 10 October 2026:
- figures, popup spacing, lesson contents, titles, lesson links, glossary, why and pictures:
  all pass.
- Jev raised 4 flags:
  - `t4Write` accepted a 4-bit answer. Now only 8 bits are accepted.
  - The fault-finding method text gave the answers away. It has been reworded.
  - `m1InOut` and `s6Wireless` are flagged as "caption gives it away". These are recall checks
    straight after the teaching, so I've left them.
- In the browser, lesson 2 stays locked until lesson 1 is finished.

## Still to do

- **ComfyUI art** is queued (waiting for the GPU):
  - the course icon;
  - the badges;
  - the level emblems `machine-0` to `machine-8` in `2026-10-10-gc-rank-emblems`.
- **Publish.**
