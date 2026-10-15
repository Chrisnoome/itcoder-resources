# Tag proposal for open-items.md

Proposed 15 Oct 2026 by the control-centre build. **Not applied.** Chris approves (or edits the
Area / P columns here) first; then run `python tools/control-centre/tasks.py --apply-proposal`.
It tags each bullet by its id (a hash of its first line), so a bullet whose first line changed
since is skipped, and bullets that already have a tag are left alone. Areas: commercialisation, marking, content, teacher, pupil, testing, fun, admin.
P: 1 urgent, 2 soon, 3 later. Every bullet in the Urgent block is p 1.

| Line | Id | Title | Area | P |
|---|---|---|---|---|
| 5 | `f754f60972` | Rotate the secret exposed in the Compiler prep chat | admin | 1 |
| 6 | `11b00ac72f` | Check whether the itcoder-cat VM is still running; stop it if idle | admin | 1 |
| 7 | `69196b3c1a` | The marking daily-limit fix and the limit of 150 are unpublished | marking | 1 |
| 14 | `b974a8ec71` | Commercialisation - before selling | commercialisation | 2 |
| 29 | `6fd86f018a` | Site review fixes | pupil | 2 |
| 93 | `bf6fc45d75` | The server's own names still say itcoder | admin | 3 |
| 101 | `08b8c04efb` | New tables read on every page need a deploy-window guard | admin | 2 |
| 106 | `58ee663a7e` | Committed code calls functions that are not committed | testing | 2 |
| 114 | `139f8545e1` | Weighted mark ratio set by the teacher, per course | teacher | 2 |
| 154 | `40de2f50ab` | Message my teacher, My progress for everyone, the menu, the query page, | pupil | 2 |
| 162 | `16e8910f51` | Live is ahead of git: commit the refactor and the video page | admin | 2 |
| 177 | `2eddeaa1fe` | Publishing over a busy line | admin | 3 |
| 184 | `90acbeadf1` | H5P rollout - Chris's decisions | content | 2 |
| 203 | `19f8ae76d0` | Level emblems: IT Theory 5 and 6 to redo | fun | 3 |
| 207 | `a956abce50` | Lost work and lost second tries - repair after publishing | pupil | 2 |
| 217 | `765bff9666` | Remediation: flaw log, diagnosis, accessibility | pupil | 2 |
| 252 | `acaffcea5f` | Question review | content | 2 |
| 254 | `8b6f7000d4` | Email addresses | admin | 3 |
| 259 | `a41cd56f7c` | H5P-style activities and the memory match | fun | 2 |
| 379 | `e55a3196ff` | Decided 28 Sep (Chris), being built | marking | 2 |
| 395 | `ce65351f47` | H5P rollout | content | 2 |
| 410 | `f9dbe3c626` | Software simulations | content | 3 |
| 414 | `88691a51f9` | Chris's list, 1 Oct 2026 | content | 2 |
| 489 | `4ff9b6323d` | Second-attempt marks under-count - FIXED 28 Sep | marking | 3 |
| 499 | `1e7b22ff0d` | Rebrand to bestlessons.co.za | admin | 3 |
| 510 | `146e33dbdc` | The E look | teacher | 3 |
| 513 | `daa1cb0471` | Fork-bomb / TasksMax= test | testing | 3 |
| 517 | `1adbbff33a` | Readln and ReadKey under --tty | testing | 3 |
| 519 | `a79255ba21` | Server locale unchecked | testing | 3 |
| 522 | `a57733145a` | Failed written answers from before 17 Sep 2026 | marking | 2 |
| 525 | `3b556ce592` | Dev login is on for the public test site | admin | 2 |
| 530 | `01e05ae6c5` | Subscription purchase flow | commercialisation | 2 |
| 531 | `4630356d75` | Google OAuth | admin | 2 |
| 533 | `26144217bd` | API spend limit | admin | 2 |
| 536 | `ae86a04182` | Review voice | marking | 3 |
| 538 | `9d9acbf154` | Marked code questions | marking | 3 |
| 540 | `bc843cc774` | Teacher dashboard: per-question view across a class | teacher | 3 |
| 541 | `08c6290e72` | Confirm ClassList() labels | teacher | 3 |
| 542 | `df0af37573` | Optional: log SQLITE_BUSY if it appears | testing | 3 |
| 543 | `3206e26d30` | PDF icon | pupil | 3 |
| 545 | `c17dd51d99` | Login page still says "itcoder" | pupil | 3 |
| 546 | `0a9eb06aa5` | Per-teacher "gated courses" setting | teacher | 2 |
| 547 | `120ecf8427` | "Login times" heatmap tab | teacher | 3 |
| 548 | `6897dde63a` | Jev-only "Do this" checks | marking | 2 |
| 549 | `cbba872308` | Add Jev calls to the AI usage log | admin | 3 |
| 550 | `e8a0fb9b6a` | Graph block | pupil | 3 |
| 551 | `9d7a75cd00` | Daily-limit fix and per-pupil limit of 150 | marking | 1 |
| 600 | `2f5e6a1538` | Low, together later | admin | 3 |
| 612 | `f1bde4d180` | Find out how commit b116c0b reached live | admin | 1 |
| 613 | `0fd1cde7be` | Rotate the exposed secret | admin | 1 |
| 617 | `2f550baf85` | Java course: open and live | content | 2 |
| 622 | `9fa70e36ae` | WHEN DELPHI IS RUNNING: Delphi GUI lessons, simulations and CAPS GUI | content | 3 |
| 627 | `620003a8c0` | Lazarus formats code - pictures, an IDE run and the video | content | 2 |
| 645 | `e7a61e55fb` | AI lesson 9's isiZulu prompt | content | 2 |
| 649 | `786e0cc44b` | AI course restyle | content | 3 |
| 652 | `dd65ebd6a8` | Pascal lessons 28+ | content | 2 |
| 656 | `8a76d838d9` | For the chat building lesson 18 | content | 3 |
| 659 | `7559ce7b35` | Review and publish the syllabus gap additions | content | 2 |
| 663 | `1e7134cad1` | CAPS PAT lessons | content | 3 |
| 667 | `0cd6be3207` | Theory course | content | 3 |
| 671 | `e2bb6684d8` | IEB theory Paper 2s 2022-2025 | content | 3 |
| 675 | `663124d278` | Anonymous quotes | content | 3 |
| 677 | `272dfcd470` | CAT bundle pricing | commercialisation | 3 |
| 683 | `76b9ff52c7` | Verify mdbtools against a real Grade 12 Access database | testing | 3 |
| 690 | `4edcfb5838` | Check whether Microsoft's terms allow its UI screenshots to be | commercialisation | 2 |
| 694 | `d168c5ece3` | Re-download the DBE's November 2023 CAT Paper 2 memo | content | 3 |
| 699 | `e9d6b66e15` | eng10 voice review | content | 2 |
| 700 | `1eda194d89` | Decide whether the validation-checks table | content | 3 |
| 701 | `c28ad73feb` | Pictures for the other ~60 processSteppers | content | 3 |
| 702 | `ff7f8ee177` | Left Gets Right karaoke video | fun | 3 |
| 703 | `12c02804cf` | Rhino-print ControlNet choice | fun | 3 |
| 707 | `4b92d414f8` | The school calendar cron line on live | admin | 2 |
| 712 | `e5395c4520` | Deploy order: new tables after new code | admin | 2 |
| 716 | `3cdb816728` | Re-point the backup task | admin | 2 |
| 718 | `35944e182d` | Backup encryption | admin | 2 |
| 720 | `d2a71bb189` | AIWebCourse root | admin | 2 |
| 723 | `b9541626ad` | nginx server_tokens off | admin | 3 |
| 724 | `c2da750044` | Test site teardown | admin | 3 |
| 734 | `299ec16a9f` | Video queue resume | content | 3 |
| 735 | `b2ec83c221` | YouTube | admin | 3 |
| 736 | `c0de68ff2e` | Office/Access install video | content | 3 |
| 737 | `7e127d0109` | Business | commercialisation | 2 |
| 738 | `07055fa9a6` | Publish pending commits | admin | 2 |
| 739 | `ecb2ef1e50` | Check in a browser | testing | 2 |

Counts: admin 24, commercialisation 5, content 23, fun 4, marking 8, pupil 7, teacher 6, testing 7
