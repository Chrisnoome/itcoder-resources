# Questions to review (found 28 September 2026)

While writing the why-wrong hints (platform.md, "Why-wrong hints"), the
agents listed questions that look wrong or arguable. None was changed. Fix
each in its lesson file (and the Java twin where one exists), then delete it
here.

## Wrong answer key or explain (fix first)

- **pascal lesson11 q8CentredWidthInvariant** - the answer key is wrong:
  (rows - row) + ((2 * row) - 1) = rows + row - 1, which grows each row (5, 6,
  7, 8, 9 for 5 rows, as the lesson's own table shows). Option b is right; the
  explain is wrong too. What is fixed is 2 x spaceCount + starCount. No hints
  were added to this block.
- **pascal lesson11 q11WhyStopAtHalf** - the explain (and the prose above it)
  is garbled: the smallest divisor apart from 1 is 2, which gives the biggest
  partner, half the number.
- **java lesson07 DivideThenMultiply reveal** - says 1 is what you'd get if
  division came first; division first gives 25. Needs a different example
  (e.g. 12 / 4 * 3) or a corrected sentence.
- **java lesson12 q8CentredWidthInvariant** - the same wrong key as Pascal's
  (option b is right); option b has no hint yet, option a will need one once
  the key is fixed.
- **pascal lesson13 q15WhyFlags** (and **java lesson14 q15WhyFlags**) - says the
  three Booleans all start False and change inside the loop; longEnough is set
  once before the loop.
- **java lesson14 q12LeftAlign** - the explain says a 0 in front "only fills
  numbers with zeros"; `%012s` probably throws FormatFlagsConversionMismatchException
  (check on a machine with Java).
- **theory11 classes11 q30PrivateOutside** - in Delphi, code in the same unit
  sees private members (the lesson says so); the keyed "syntax error" needs
  "in its own unit".
- **theory11 fixedbits q11ByteWrap** - in Java `b = b + 1` does not compile
  and `b + 1` gives 128; only `b++` / `b += 1` / a cast wrap to -128. Name
  `b++` in the prompt.

- **pascal lesson17 q5WhichCreate** - option a says "the one with three
  parameters" but the first constructor has four (aName, aSurname,
  aClassCode, aMark).

## Arguable (a careful pupil could defend another option)

- pascal lesson18 q6Uniqueness and capspat10 q1UserStory say "learner"
  (probably the official term there - decide); capspat12 s1Musts (10%) and
  lesson27 q3Borrowed (20%) give different limits for borrowed code (CAPS vs
  IEB PAT - both right, may confuse).

- pascal lesson02 q21ConstSign - `vatRate : Real = 0.15;` is a valid typed
  constant in Free Pascal.
- pascal lesson08 q12ChooseIfScenario - Case with ranges (0..49, 50..100)
  would work; the explain's "no way to write >= 50" is not the whole story.
- pascal lesson10 q3WhatCounterIs - the explain cites "lesson09's bus
  example", which has no loop.
- pascal lesson10 q8WhatOffByOneMeans - option d (counter from 0) is a real
  cause of off-by-one errors.
- pascal lesson15 q9TotalStart - total is a main-program variable, which Free
  Pascal sets to 0; the danger needs a local variable.
- pascal lesson16 m2FieldOrMethod - `IsBatteryLow : Boolean` reads like a
  field.
- java lesson11 q15WhyLoopBeatsThreeCheck - option a and the explain refer to
  a fixed-candidates prime check the Java lesson never shows (Pascal carry-over).
- java lesson24 q7InputType - option c probably compiles (boxed int as the
  message); still wrong, but not for the reason a pupil might think.
- java examieb s1LoseMarks option e - the lesson says unasked-for validation
  "earns nothing", not that it loses marks.
- sql dbkeys m1Relationships - "a country and its capital" as one-to-one;
  South Africa has three capitals.
- sql shared/b01 m1Rules (SQLite) - VARCHAR(40) matched to "up to 40
  characters", but the lesson says SQLite ignores the 40.
- sql shared/b04 q1Join (SQLite) - CONCAT exists from SQLite 3.44; the server
  runs 3.53, so option c may work too.
- sql shared/b07 q1NoWhere (MySQL) - Workbench safe update mode stops the
  UPDATE (error 1175), so option a is what a pupil may see.
- theory10 inputother m9Sensors - screen rotation is mostly the accelerometer
  (the lesson's sensor table says gyroscope - change both).
- theory10 whynetworks m26Reasons - editing one shared spreadsheet could be
  "sharing resources" as well as productivity.
- theory10 bodyplanet o43Waste, media m28Choose, malware q40Worm (option d is
  not malware), computercare q17DateFormat (odd distractor), ports
  s11PictureUsb (label C) - minor.
- theory11 dbms11 q13Composite - "test marks": PupilID + SubjectID is not
  unique with more than one test.
- theory11 protocolswan m16Protocols - asks about FTP before the lesson's FTP
  section.
- theory11 mobilewireless q17Earbuds and q17LindiweEarbuds ask the same thing.
- theory11 testing11 s33Catches option e - a uniqueness check would catch it.
- theory11 guidesign s34ForceValid option c - a date picker still allows 2090.
- theory11 streaming s19Lossy option e - MP4 is a container (minor).

- theory12 warehousemining o7MiningSteps - "analyses the data" and "finds
  trends" are one step; the order is arguable.
- theory12 sharingremote m9Protocols - "match each job to the best way" but
  the left items are the ways (back to front).
- theory12 cybercrime12 m16DependentEnabled - opening store accounts with a
  stolen ID also fits cyber-enabled.
- theory12 securityplan m17Groups - two right-hand answers repeat
  (Housekeeping, Data integrity) - check the match widget copes.

## Voice (house-style tells in question text)

- ai lesson01 q1RulesVsLearned says "learners" (use "pupils"); w1ExplainToGogo
  uses "gogo" (isiZulu - writing-style.md says not to).
- ai course: em dashes in options and explains (lesson02 q2Quantisation b,
  lesson03 q1WeightsAlone b, lesson04 q2WhatYouPayFor b, lesson05 q2Heat a,
  lesson07 q2WhoPays, q3Bubble a, and several explains) - use hyphens.

- java lesson08 q1WhyIntToStrNeeded explain: "Java insists on a real String".
- java lesson11 q4bBeginEndStillNeeded prompt: "Java happily compiles this".
- java lesson11 q13WhyTwoVariables option b: "Java refuses to make a second counter".
- java lesson09 q11NoMatchNoElseCase explain starts "Tested:".
- java lesson12 q16NoLimitNesting option d "Java refuses to compile"; lesson17
  q6WhyPrivate option c "Java refuses public fields".
