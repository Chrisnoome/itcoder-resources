# Remediation - flaw log, diagnosis, remedies

Chris, 1 October 2026: "identify weaknesses that pupils have ... each time
written work is marked add entries for these errors linked to the question
number. this is NOT shown to the pupil ... use this record to diagnose and
suggest remedial actions following common good practice."

**Status: the remedies below are a draft for Chris to edit.
Built: all of it - the reset (below), the reading options, the spelling
concession, the colour-blindness fixes, colour-safe colours, the colour vision
check, and the flaw log with its diagnosis ("Habits" on the pupil's work
page; platform.md). The remedies below are live as drafts: change them here
AND in lib/flaws.php FlawCodes().**

**Manual checks for Chris:** [remediation-checklist.md](remediation-checklist.md).

## Decided (1 October 2026)

- **Tagged:** written answers (the AI marker returns flaw codes in the same
  marking call), code (compiler, tests, the naming and layout checks) and
  automatic signals (time on the question, answer length, attempts).
- **Staff only.** POPIA gives a pupil or parent the right to ask for it, so
  every note is factual and professional. Anything about dyslexia is
  special personal information: teacher and admin only, never in emails.
- **A pattern:** a flaw in at least 25% of the questions where it *could*
  occur, across at least 2 lessons, in a rolling window (the last 6 weeks,
  to start with). A one-off is not a pattern.
- **Remedies are suggested to the teacher**, who assigns them. Nothing is
  assigned to the pupil automatically.
- **Resets archive, never delete** (`resetAnswers`, lib/questionreset.php):
  the flaw entries of an archived answer stay in the log.
- **Dyslexia:** any pupil may choose a reading font, larger text, 1.5 line
  spacing, a tinted background and read-aloud (My settings); only the
  teacher sets a spelling concession (spelling ignored in theory answers,
  never in keywords or identifiers - code must compile). **1 October:**
  spelling must count in language courses (later) unless the pupil has
  the concession; the concession also keeps spelling out of the marker's
  feedback and accepts near-miss typed word answers in every course; the
  pupil sees it quietly in My settings.
- **Colour blindness:** never colour alone (WCAG 1.4.1: a tick/cross and a
  word beside every red/green), Okabe-Ito palette for charts, a colour-safe
  editor theme; audit every page with a deuteranopia/protanopia/tritanopia
  simulation.

## Sources

Reason's error types (slips, lapses, mistakes); Hattie & Timperley's feedback
levels (task, process, self-regulation); Biggs' SOLO taxonomy (depth of an
answer); Black & Wiliam, assessment for learning; the EEF guidance on
metacognition; novice-programmer misconception catalogues (du Boulay, Sorva,
Altadmri & Brown's Blackbox study); the DBE NSC Diagnostic Reports and IEB
examiner reports for IT and CAT; the British Dyslexia Association style guide.

## The flaw codes and their remedies (draft)

A remedy names the teacher's move first, then what the pupil practises.

### A - Reading the question

| Code | Flaw | Remedy |
|---|---|---|
| A1 | Misreads the question, answers a different one | "Read twice, answer once": the pupil rewrites the question in their own words before answering, for the next 5 written questions. Teacher: go through one wrong answer with the pupil and ask "what was the question asking?" |
| A2 | Ignores the command word | A command-word card (state, describe, explain, compare, evaluate, justify) and short drills: the same topic asked with three different command words. Box the command word before answering. |
| A3 | Ignores the context or scenario | "Name the scenario": every point must mention something from the case (the school, the shop, the user). Practise turning a generic answer into a contextual one. |
| A4 | Answers only part of a question | Tick-list the parts before writing (a, b, "and why"); check each off at the end. |

### B - Completeness and depth

| Code | Flaw | Remedy |
|---|---|---|
| B1 | Leaves the question out | Find out why first: time, can't start, or avoidance. Can't start: sentence starters and a worked example. Time: see E1. |
| B2 | Too little detail for the marks | "A mark = a point": count the marks, write that many separate points, number them. Model a full-marks answer next to theirs. |
| B3 | Lists without explaining | "Point - because - so what": every point gets a reason and a consequence. SOLO: move from "several points" to "related". |
| B4 | No example when one is needed | "For example ..." after every explanation for a week; a bank of everyday examples per topic. |
| B5 | Pads with irrelevant or repeated points | Cross out what does not answer the question in a model answer; quality over length. |

### C - Knowledge

| Code | Flaw | Remedy |
|---|---|---|
| C1 | Factual error | Short reteach of that fact and spaced retrieval (flash cards, the memory match) over the next two weeks. |
| C2 | Misconception | Confront it: a question that makes the wrong model predict the wrong result, then the right model. Note which misconception (its tag) - if several pupils share it, reteach the class. |
| C3 | Confuses two terms | Side-by-side comparison table of the pair, then sorting exercises (which one is this?). |
| C4 | Vague, everyday language | The glossary words for the topic; rewrite one of their answers with the subject terms. |

### D - Care and accuracy

| Code | Flaw | Remedy |
|---|---|---|
| D1 | Syntax slips | Compile early and often (after every few lines); a personal "my usual slips" list. |
| D2 | Careless language | Read the answer aloud (or with read-aloud) before handing in. Rule out dyslexia patterns first (see below). |
| D3 | Off-by-one, boundary slips | Trace tables at the boundaries (first, last, empty); test with 0, 1 and the maximum. |
| D4 | Doesn't check the work | A check routine before Hand in: re-read the question, check every part answered, run the code once more. Use the second attempt properly: what changed and why. |
| D5 | Naming and layout rules broken | The existing checks already stop the run; repeat offenders get the style sheet and one tidy-up exercise. |

### E - Effort and behaviour

| Code | Flaw | Remedy |
|---|---|---|
| E1 | Rushed (short and fast against the class median) | A conversation first - rushing hides boredom, anxiety or not knowing. Then a minimum planning step (jot the points before writing). |
| E2 | Guessing on fixed-choice questions | Ask for the reason with the choice for a while ("why b?"); eliminate wrong options aloud. |
| E3 | Second attempt unused or unchanged | Teach what the second attempt is for; show how much it would have earned. |
| E4 | Copy-paste, or answer copied from the question | Conversation; the typing check already flags pasting. Rephrasing practice for "copied from the question". |

### F - Problem solving (code)

| Code | Flaw | Remedy |
|---|---|---|
| F1 | Can't start | Decompose together: input - process - output, then pseudocode, then code. Parsons problems (put the lines in order) before blank-page tasks. |
| F2 | Logic error | Trace tables and predicting output before running; rubber-duck the code line by line. |
| F3 | No decomposition (one giant block) | Rewrite one of their programs with procedures together; "one job per procedure". |
| F4 | Trial-and-error coding | Before each run, say what you expect to happen; read the error message out (the Read and think lesson). |

### G - Theory and CAT answers

| Code | Flaw | Remedy |
|---|---|---|
| G1 | Brand names instead of the general term ("Google" for a search engine, "WhatsApp" for instant messaging) | Rewrite with the general term; a brand-to-term list for the topic. |
| G2 | Unqualified "faster", "cheaper", "easier" | "Faster than what? Why does it matter?" - every advantage needs a comparison and a reason. |
| G3 | The same point reused across parts of a question | Plan all parts first so each gets its own point; cross out a repeat. |
| G4 | Opinion or personal experience instead of the subject | Separate "what I think" from "what the theory says"; answer with the theory. |
| G5 | Wrong or missing units, no working in calculations (storage, transfer time, number systems) | Show every step and the unit; a units ladder (bit - byte - KB ...) on hand. |
| G6 | Wrong software feature or tool named for the task (CAT) | Match task to feature exercises; screenshot-based "which tool does this?" |

## Signs to flag (never a diagnosis)

The platform cannot diagnose. It may suggest the teacher considers a referral
when it sees, over several weeks: many spelling errors and letter reversals
(b/d, p/q in identifiers) while the understanding is sound; very slow reading
time with good marks; answers much weaker in writing than in fixed-choice
questions on the same topic.

## The reset (built 1 October 2026)

- Pupil queries has a third answer, **Reset the question**, beside "The
  mark is correct" and "Change the mark". The question goes back to "not
  done", the pupil gets a bell and an email with the reply.
- Every reset (that one and "Reset this question" on the pupil's work page)
  copies the answer row into `resetAnswers` first (staff only).
- The reset query shows the archived answer; once the pupil answers again,
  the new mark can be queried (the old query moves into the archive).
