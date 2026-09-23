# Course: Programming in Pascal (`pascal`)

**Kept by the Pascal chat (AIPascalCourse).** Seeded on 11 September 2026 from
that chat's own notes, so other chats - marking in particular - can see its
decisions. That chat keeps this current; when a decision here changes, change it
here, not only in chat memory.

**Where it lives:** `Projects/AIPascalCourse/content/pascal/`. Status `open`.

**For:** IEB Information Technology, Grades 10-12. Syllabus:
[../sags-topic4-syllabus.md](../sags-topic4-syllabus.md). Code conventions:
[../pascal-house-style.md](../pascal-house-style.md). Voice:
[../content-voice-and-pedagogy.md](../content-voice-and-pedagogy.md), built on
[../writing-style.md](../writing-style.md).

## Lessons

1. **What you learn when you learn programming** - programming is computational
   thinking (SAGs 10.4.1), not syntax. "The computer is stupid and must be told
   everything" (jam-sandwich reveal). Selection is the same idea in Pascal,
   Python and JavaScript, just different syntax. Languages are built for a
   purpose - Pascal was built purely to teach. Feynman quote.
2. **Proof of Life / Output - WriteLn and Write** - output as proof a program
   ran (SAGs 10.4.1, IPO's "O"), the Program/Begin/End. shell, naming rules,
   Write vs Writeln, reading real compiler errors, the `:width:decimals`
   trick, the doubled apostrophe and `#9`. Two live `code` blocks compiled by
   real `fpc`.
3. **Making it pretty** - enrichment, not SAGs content, will never be tested,
   and carries no marks anywhere in it (Chris, 13 September 2026 - every
   `quiz`/`typed`/`reveal` question was removed on request, so it is pure
   prose, examples and runnable `code` blocks). Units/libraries as an idea
   every language has, under a different name each time, taught via Pascal's
   `Uses` clause; then the `Crt` unit's `ClrScr`, `TextColor`/
   `TextBackground`, `GotoXY`, `WhereX`/`WhereY` and `Delay`. Newton
   "shoulders of giants" portrait quote, plus an anonymous "first
   impressions" quote before the Crt section framing text-mode UI (greet the
   pupil, clear prompts, a goodbye message, make it beautiful). Three
   runnable `code` playgrounds (colour, GotoXY, and a closing one combining
   all five commands) - real `fpc` compiling into the virtual-terminal
   display (platform.md decision 15, the Crt auto-detection). `Delay`
   carries an explicit note that its pause never shows on this site, since a
   `code` block only ever displays a finished run, not a live one - it only
   shows in Lazarus, locally.
4. **Every box needs a label** - variables and data types (SAGs 10.4.3). Wirth
   quote, a type-mismatch compile error, `Div` vs `/`, Y2K aside, the
   ID-number-as-a-string written question. **Constants added 23 September
   2026** (Chris: "check if constants are in the variables lesson. if not, add
   them. update title and sags"): a "Constants: values that never change"
   section after calculations (anchor `memConst`) - `Const` above `Var`, `=` not
   `:=`, no type, camelCase names; TuckShopVat (`vatRate = 0.15`, VAT 3.75,
   total 28.75) and SchoolWeek, both compiled; the real errors
   `Variable identifier expected` (assigning a constant) and
   `Syntax error, "=" expected but ":=" found`; whiteboard vs painted sign; a
   Learn / Memorise box; four questions (`q20ConstOrVar`, `s1ConstOrVarWhich`,
   `q21ConstSign`, `t20ConstError`) and a `code` exercise. Title is now "How to
   remember - Variables and constants"; the course-page syllabus line lists
   constants versus variables. Lesson 15 now refers back to it.
5. **Getting input - Readln, Read, ReadKey and KeyPressed** (SAGs 10.4.1,
   IPO's "I") - new 13 September 2026. Four commands, same underlying shape
   pair-wise: `Readln`/`Read` are ordinary Pascal I/O and the exact same
   relationship as `Write`/`Writeln` on the way out (`Read` leaves the rest of
   the line for whatever reads next; `Readln` throws it away) - a deliberate
   callback, not a new idea dressed up as one. `ReadKey`/`KeyPressed` are
   Crt's single-keypress pair from lesson 3: `ReadKey` waits for one key and
   never echoes it, `KeyPressed` only checks whether one is waiting, without
   blocking or consuming it - so one is for "stop and ask", the other for
   "keep going unless interrupted". Julian Treasure quote ("we will just talk
   to our computers... why would we not?") framing the keyboard as one input
   method among others, not the only one there will ever be.

   **Only `Readln` is exam content (Chris, 13 September 2026).** An `important`
   block says so explicitly, early in the lesson, before any of the four are
   taught in depth: for tests, exams and almost everything a pupil writes in
   this course, `Readln` is the one to actually know - `Read`/`ReadKey`/
   `KeyPressed` are real, useful commands for later projects, not syllabus
   content, and the lesson's own depth follows that split (Readln gets the
   crash-examples table and the bulk of the questions; the other three get a
   lighter, "know it exists" treatment). The **"What to study" summary
   mirrors this on purpose** - it does not re-teach Read/ReadKey/KeyPressed at
   revision depth, only names them as tools that exist for tasks and projects,
   because a revision sheet should reflect what is actually examined, not
   everything a lesson happened to mention. Apply the same split to any later
   lesson that teaches both syllabus and enrichment material side by side.

   **A `Readln`'s variable does two jobs, and typing the wrong type crashes it
   - taught with a genuine crash-examples table**, every row copied from an
   actual run against real fpc 3.2.2 (not invented): `Integer` + letters or a
   decimal both crash with `Runtime error 106`; `Integer` + an empty line does
   NOT crash, it silently leaves the variable at 0; `String` never crashes,
   whatever is typed. This is the same discipline as the compile subsystem's
   own rule (compile-subsystem-design.md) applied to a runtime result instead
   of a compiler one - verify a genuine behaviour before teaching it as fact.
   Ends with a
   `markMax => 10`, band-rubric written question asking when each of the four
   is the right choice - the capstone Chris asked for.

6. **Processing - basic maths.** File `lesson06.php`. BODMAS, real division
   vs `Div`/`Mod`, `Round`/`Trunc`, and `Abs`/`Sqr`/`Sqrt`/`Power`/`Min`/`Max`
   (the `Math` unit). Built 13 September 2026 - see the file's own docblock
   for the genuine `fpc` gotchas found while writing it (`Div`/`Mod`
   truncate toward zero on negatives; `Round` is round-half-to-even).
7. **Type conversion.** File `lesson07.php`. New 13 September 2026, first
   content for "lesson 6 onward" (open-items.md); rewritten the same day
   after Chris's own voice/pedagogy edit pass. Covers all four SAGs 4.3
   conversion pairs: `IntToStr`/`StrToInt` (String<->Integer, new),
   `Chr`/`Ord` (Char<->Integer, new), Char->String (free, new) vs
   String->Char (taught directly via `word1[1]` indexing, not deferred),
   and Real<->Integer (a refresher of lesson 6's `Round`/`Trunc` and lesson
   4's free Integer-into-Real, not re-taught from scratch). The throughline:
   Pascal never silently converts a value's type except a genuinely free
   assignment; everything else needs an explicit, named function - which is
   also why `Round`/`Trunc` exist, tying back to lesson 6.
   **"Widening"/"narrowing" and "crossing" are deliberately not used as
   terms anywhere in the pupil-facing text** (Chris, 13 September 2026 -
   too technical for a 15-year-old newbie, and lesson 4 never used the word
   "widening" either); the lesson says "fits in with no fuss" / "needs a
   function" / "conversion" instead. Every paragraph was also split down to
   one idea each after Chris flagged the first draft as too dense.
   **`FloatToStr`/`StrToFloat`/`Format` are taught as genuinely
   locale-dependent** (confirmed comma-decimal on the Windows testbed; the
   server's locale is still unverified), paired with the actual fix Chris
   asked for: copying `DefaultFormatSettings` into a `TFormatSettings`
   variable, overriding `DecimalSeparator`, and passing it to those three
   functions - verified genuinely forcing a point on the same comma-locale
   machine. Flagged as relevant again once a dates lesson exists, since
   `TFormatSettings` controls date formatting too. Every other
   genuine-output claim was compiled for real against `fpc` 3.2.2 first,
   including the `StrToInt` crash (`EConvertError`, not `Runtime error 106`
   - a different failure mode worth knowing about) and the
   `String`-into-`Char` compile error.
8. **Decisions / Branching.** File `lesson08.php`, added 17 September 2026.
   Comparison operators, why a comparison IS a Boolean, `If`/`Then`/`Else`,
   chained `Else If`, combining conditions with `And`/`Or`/`Not` (taught
   with clickable AND/OR/NOT logic-gate circuit diagrams), `Case ... Of`,
   and a rule for choosing between `If` and `Case`. Looping (`For`/`While`/
   `Repeat`) is deliberately NOT this lesson's job - SAGs 4.8 lists it
   separately, and it isn't taught anywhere in the course yet (still true as
   of lesson 9 below). Quote: James Gleick, portrait via Wikimedia Commons.
9. **Division - Div, Mod, Trunc and Round.** File `lesson09.php`, added 17
   September 2026. Not a re-teach of lesson 6's mechanics - it recaps them
   briefly, then covers the one thing lesson 6 left alone: `Div`/`Mod`
   only becoming useful once paired with an `If` from lesson 8 (the "how
   many buses" worked example: plain `Div` under-counts, `If pupils Mod
   busCapacity > 0` fixes it). Builds two named algorithms this way -
   odd/even and factor-checking. Quote: Donald Knuth ("An algorithm must
   be seen to be believed," verified on Wikiquote), portrait via Wikimedia
   Commons (CC BY-SA 2.5, cropped from a Jacob Appelbaum Flickr photo). 50
   marks exactly - not padded past the minimum Chris asked for.

   **Two things cut after first shipping, both the same week, neither
   discarded outright:**
   - **Integer overflow** - cut 18 September 2026 (Chris: not needed for
     this lesson), right after platform.md decision 24's `-Mobjfpc`
     compile-pipeline fix required rebuilding the example for a 32-bit
     `Integer` (`50000 * 50000` wrapping to `-1794967296`). Genuinely
     discarded, not saved anywhere - the Integer range fact itself is
     unaffected and still taught in lesson 4 (`lesson02.php`).
   - **Prime-checking, the third algorithm** - cut 18 September 2026
     (Chris: "prime needs a loop take it out for now - will use in loop
     lesson (lesson 10). don't discard"). Unlike the overflow cut, this
     one is preserved verbatim -
     [pascal-lesson10-draft-prime-check.md](pascal-lesson10-draft-prime-check.md)
     has the full `algorithm` block, its `code` block and all three
     questions, plus a note on what has to change to make it a genuine
     loop-based check (test every factor up to `Trunc (Sqrt (n))`, not
     just 2/3/5) once lesson 10 exists. Whoever builds lesson 10: read
     that file before writing a prime-check algorithm from scratch.
   - Between the two cuts, six marks needed replacing to hold the lesson
     at 50: a real-division-type question (`q0RecapRealDivisionType`), a
     fourth `divBuses` prediction (`t4BusesPredict59`), a second factor
     check (`t5bFactorCheck12of96`), a chained Div-then-Mod digit question
     (`t7bSecondDigit`) and a checkerboard-pattern question
     (`q7CheckerboardRow`) - five 2-mark questions for the six marks two
     cut questions and one cut question each carried, since the overflow
     cut cost 4 and the prime cut cost 6, ten total, replaced by five new
     ones at 2 marks each.

   **New block type: `algorithm`** (lib/content.php needs no dedicated
   builder for it - a plain `['type' => 'algorithm', 'title' => ...,
   'html' => ...]` block, same shape as `important`/`study`). Rendered by
   `public/lesson.php`'s `case 'algorithm':`, styled in
   `public/assets/style.css` (teal, matching video/reveal/code's bar
   colour - this is worked teaching material, not a warning or a revision
   summary), icon at `public/assets/block-icons/algorithm.svg` - an SVG,
   not a PNG like every other block icon, since no image-generation tool
   was available that session; a matching PNG could replace it later
   without any code change. Holds the problem statement, an inline SVG
   flowchart and a pseudocode panel; the runnable, partially-completed
   Pascal program that follows is a SEPARATE, ordinary `code` block placed
   right after (not nested), so it keeps the compile subsystem for free and
   stays out of `LessonAutoMarkedQuestions()` like every other `code`
   block. A flowchart/pseudocode pair must show the SAME method the
   runnable code actually implements - the odd/even and factor blocks that
   shipped in lesson 9 both follow this; the prime-check block that
   originally shipped alongside them, showing a 3-check version (not a
   general loop, since loops weren't taught yet), was cut the same day -
   see lesson 9's entry above and lesson 10's entry below. Don't let a
   lesson's diagram and its code disagree.

10. **Repeating instructions the easy and efficient way - For loops.** File
    `lesson10.php`, added 18 September 2026. SAGs 4.8's counting-loop half
    of "for vs while" - `For`/`Downto` only; `While`/`Repeat` (condition
    loops) are deliberately left for a later lesson, the same way lesson 8
    held looping back for lesson 9 to teach Div/Mod first. Covers: basic
    counting and `Downto`; the inclusive-endpoints trap (`5 To 10` runs SIX
    times, and both a backwards `To` range and a wrong-direction `Downto`
    run ZERO); why `Illegal assignment to for-loop variable` is a genuine
    compile error and what it implies (no built-in step-by-2); accumulators
    (running totals and counts, an `If`+`Mod` combination lifted from
    lesson 9); nested loops with independent counters (SAGs 4.8's own
    phrase), including a real 4x4 checkerboard built from
    `(row + column) Mod 2` - lesson 9's `divEverywhere` section only ever
    described this idea for a single row, never built it in two dimensions.
    Quote: Larry Wall ("...laziness, impatience, and hubris," Programming
    Perl, 1996), portrait via Wikimedia Commons (CC BY-SA 2.0, Randal
    Schwartz). 100 marks, at Chris's own ask for this lesson (roughly double
    lesson 9's 50).

    **Delivers the prime-check algorithm lesson 9 couldn't finish, but
    NOT as a "lesson 9 left this unfinished" callback to the pupil** -
    lesson 9's three-check version was cut the same day it was drafted,
    17-18 September 2026, before it ever reached a real pupil (see lesson
    9's entry above and `pascal-lesson10-draft-prime-check.md`), so a pupil
    reading both lessons in order never actually saw a prime-checking
    attempt before this one. Lesson 10's `algIsPrime` block is written as a
    fresh problem, framed as the natural next question after lesson 9's
    real factor-checking algorithm (which pupils DID see): factor-checking
    answers one candidate at a time, prime-checking needs every candidate
    checked, which is exactly the repeated job a loop is for. Only the
    lesson's own internal docblock and this file reference the cut/draft
    history - keep it that way if this lesson is touched again.

    **Followed the draft file's brief, not a straight reskin.** The draft
    explicitly warned against "just reskin[ning] the 3-check version with a
    For around it" and asked for the loop to test up to (at least)
    `n Div 2`, or better, `Trunc (Sqrt (n))`. Lesson 10 uses
    `Trunc (Sqrt (number))` (a separate `upperBound` variable, matching the
    house style's "introduce extra variables" rule) - confirmed against
    real fpc to correctly handle 2, 3, 5 and 49 (= 7 x 7, which the old
    6-to-48 shortcut could never have caught) with no special-case code
    anywhere, exactly as the draft predicted. It still has ONE honestly-
    disclosed limitation of its own: `number := 1` gives `Trunc (Sqrt (1))
    = 1`, so the loop range `2 To 1` runs zero laps and `numberIsPrime`
    wrongly stays `True`. The loop never stops early once it finds a
    factor - this course's own `Break` ban (`pascal-house-style.md` §5) has
    never actually been taught to a pupil in any lesson so far, so lesson
    10 does NOT frame "no early stop" as "because of the Break rule" to the
    pupil; it is framed purely as a speed-vs-correctness question a pupil
    can reason through directly (nothing in the loop body can ever set
    `numberIsPrime` back to `True`, so extra laps cost time, not
    correctness).

    `pascal-lesson10-draft-prime-check.md` has now been consumed - its
    content was NOT reused verbatim (the whole point was to stop reskinning
    the 3-check version and build a real loop instead), but its brief was
    followed exactly. Leave the draft file in place as a historical record
    of why lesson 9 only has two algorithm blocks; don't delete it.

11. **Looped algorithms - totals, averages and shapes.** File `lesson11.php`,
    added 18 September 2026. Chris's brief, verbatim: "total, average,
    repeated input, drawing triangle, drawing square, complex triangle where
    point is in the top middle, (all in text mode), and any other common for
    loop algorithms - no string handling yet this one is about using a loop
    as a problem solving tool. that's what the introduction should say" -
    the opening prose section says exactly this. Teaches **almost no new
    Pascal** (only `Length (text)`) - every idea reuses lesson10's own For loop, just aimed
    at real problems: a new algorithm block for total-and-average built on
    repeated input (`Readln` inside a loop, with the loop's own upper bound
    read from input before the loop starts - `howMany`/`customerCount`),
    then three shapes built from nested loops in plain text mode - a square
    (fixed range both loops, from lesson10), a right-angled triangle, and a
    centred ("point on top") triangle.

    **The one genuinely new idea: an inner loop's range depending on the
    OUTER loop's own counter** (`For column := 1 To row Do`), rather than a
    fixed range every time. Lesson10's own written-capstone rubric
    (`w1YourOwnCountingLoop`, `markerRubric`) had already named this
    explicitly as "the one new idea beyond what the lesson showed
    directly", without teaching it - this lesson is where it is actually
    taught, in the right-angled-triangle section, not framed as "finishing"
    anything from lesson10 (the same "introduced fresh, not as a callback"
    discipline lesson10 itself used for the prime-check algorithm it
    inherited from lesson9's cut draft).

    **No string handling** (Chris's explicit brief) - every shape is printed
    by writing characters directly inside a loop, one at a time, exactly as
    lesson10's TimesTable/Checkerboard did; no `String` concatenation to
    build a row first. One deliberate exception, asked for by Chris on 18
    September 2026: the typewriter example indexes a String
    (`message[position]`, lesson 7) and uses `Length`/`Delay` (lesson 3). Chris
    (19 September 2026) said the old "the pause never shows on this site" note is
    no longer true, so lesson 11 does not carry it; lesson 3's callout and the
    lesson 3 entry above still do and need the same check.

    **Added 18 September 2026 (Chris):** typewriter output, a times table
    for any number, factors of a number (looping only to `number Div 2`, then printing the number itself - shown by first running the full range and tabulating the wasted checks), Fibonacci, factorial (keep the
    number at 12 or lower - 13! verified to wrap to 1932053504, and the
    lesson says so) and largest-of-many; a "Nested loops, as a concept"
    section before the shapes (explicitly: no limit to nesting); the square
    now asks for its side length (the first draft wrongly claimed shapes
    take no input), plus a hollow box and a rectangle the pupil writes from
    scratch. **The word is "repetition", never "lap"** in this lesson -
    lesson10 was changed to "repetition" too on 19 September 2026 (Chris), so no lesson says "lap" now.

    The centred triangle's two formulas - `spacesInRow := rows - row` and
    `starsInRow := (2 * row) - 1` - need no special case for the final row:
    `rows - row` reaches `0` there, and `For spaceColumn := 1 To 0 Do`
    already runs zero times under lesson10's own backward-range rule, the
    same discipline lesson10's prime-check algorithm relied on for its own
    small numbers. One question uses the identity that the first `n` odd
    numbers always sum to `n` squared (a 6-row centred triangle prints 36
    stars in total) - checked by hand for n = 5 and n = 6, not just assumed
    from the general identity.

    Quote: Alfred North Whitehead ("Civilization advances by extending the
    number of important operations which we can perform without thinking
    about them," *An Introduction to Mathematics*, 1911, ch. 5) - verified
    on Wikiquote before use. Portrait: Wikimedia Commons, the Wellcome
    Collection's photograph of Whitehead, CC BY 4.0, downloaded via
    Special:FilePath (byte-for-byte match against the page's own listed
    size, 502573 bytes) and cropped to a 256px square face portrait, saved
    to `public/assets/quotes/whitehead.png` and this folder's "Quote
    images". No fixed marks target was set for this lesson the way Chris
    asked for 50 (lesson9) and 100 (lesson10) - it came out to 108 auto-marked
    (`LessonAutoMarkedMax ('pascal', 'lesson11')`, checked directly) plus a
    12-mark written capstone, 120 total, following from the content actually
    needed rather than padding toward a round number.

12. **Flexible loops - While and Repeat.** File `lesson12.php`, added 18
    September 2026. Chris's brief: "while loops and repeat loops. things to
    look out for, infinite loops (point out apple address), user controlled
    input, when to use, multiple quotes, check writing styles, 50 marks
    minimum, quote images". The condition-loop half that lesson10 left
    open (SAGs 4.8's counting vs condition loop, pre-check vs post-check).
    Covers: why a counting loop is not enough; `While` (pre-check, can run
    zero times, and the three things a While loop needs that For did for
    you - a start value, a condition, a change inside); `Repeat ... Until`
    (post-check, at least once, the condition flipped, no `Begin ... End`,
    closing line commented `// repeat`); a side-by-side flowchart and a
    predict-first `reveal` (`countdown := 0`: While prints nothing, Repeat
    prints 0); infinite loops (forgetting the change, changing it the wrong
    way, stepping over an exact value tested with `<>`/`=`), with a
    `code` block that is stopped by the site's 5-second limit and the flag
    idea for loops that are meant to go on; loops the user controls (a stop
    value that could never be real data, checking input with `Repeat` and a
    Boolean, play-again, a limited number of tries with `And`); two new
    `algorithm` blocks - total until a stop value (priming read, `While`,
    guarded average) and sum of the digits (`Mod 10` / `Div 10`, lesson 9's
    tools inside a `While`); and a For/While/Repeat decision rule.

    **Apple's address is a visible callout, not a popup** (Chris asked for it
    to be pointed out): 1 Infinite Loop, Cupertino - the street is a loop,
    named after the programming term; Apple's head office 1997-2017, still an
    Apple site (Wikipedia, "Apple Infinite Loop campus", checked 18 September
    2026).

    **Three quotes, each verified.** Robert Frost, "...it goes on" (top;
    Wikiquote lists it as *attributed*, from Ray Josephs, 1959, so the cite
    says "as reported in 1959"; portrait already in the platform). The
    "insanity is doing the same thing over and over" line, shown with the
    **anonymous placeholder and no face**, because it is wrongly credited to
    Einstein - earliest known print is a 1981 newspaper report of an Al-Anon
    meeting (Quote Investigator). Never put Einstein's portrait next to it.
    Douglas Adams, *Mostly Harmless* (1992), on foolproofing - for the
    input-checking section. **New portrait:** Wikimedia Commons,
    `File:Douglas_adams_portrait_cropped.jpg`, Michael Hughes via Flickr,
    CC BY-SA 2.0, 32915 bytes (matched to the file page), cropped to a 256px
    square, saved to `public/assets/quotes/douglas_adams.png` and this
    folder's "Quote images".

    **Marks:** 96 auto-marked plus an 8-mark written capstone (a per-idea
    rubric, since it is under 10) - 104, from a brief of 50 minimum. The
    written question lets the pupil pick a stop-value till or a 3-tries
    password check and accepts any loop they can justify. The word is
    "repetition", never "lap" (lesson11's decision).

    **Code blocks:** every example compiled and run with fpc 3.2.2
    (`-Mobjfpc -O1`), input piped in where a program reads any. A nested
    `Else If` with no `Begin ... End` trips `lib/codestyle.php`'s indent
    check (it counts `Begin`/`Repeat` depth only), so the guessing game wraps
    its inner `If` in `Begin ... End; // else` - which is also what the
    course teaches. A new shared flowchart builder (`$whileFlowchart`, a
    closure at the top of the lesson file) draws the two algorithm diagrams
    so they keep the 20px-gap rule without hand-placing coordinates.

13. **Working with text - String handling.** File `lesson13.php`, added 18
    September 2026, built and checked locally, then **published to the test
    site and to live the same day** (both runs ALL STEPS OK). Chris's brief: "all intricacies of
    strings - including processing with for loops, reversing, encryption, case
    insensitive comparison, replacing parts of a text, parsing into separate
    vars (delimiters), the format command, outputting columnised displays, and
    any other common algorithm examples. quotes, pictures, 70 marks minimum.
    lots of practical exercises." Covers, in order: a String as a row of Chars
    numbered from 1 (with a picture); the three loop patterns over a string
    (count, build a new string, count words); **underlining a string** (added
    19 September 2026 at Chris's ask: write the string, then a loop writes one
    underline character per character on the next line - a `Write` loop
    then a plain `Writeln;`, a `Length + 2` variant, a user-chosen character,
    over-and-under, and a skip-the-spaces challenge; `StringOfChar` in the
    columns section is pointed back to it as the one-line version); reversing (a new `algorithm`
    block, `DownTo`) and palindromes; upper/lower case and case-insensitive
    comparison (`UpCase`, `UpperCase`, `LowerCase`, `SameText`, and why
    `'Zulu' < 'apple'` is True); a Caesar cipher (`Ord`/`Chr`/`Mod 26`, its
    `algorithm` block, the negative-`Mod` trap from lessons 6 and 9, brute-force
    cracking, and an optional keyword-cipher challenge); the toolbox (`Copy`,
    `Pos`, `Delete`, `Insert`, `Trim`); replacing (once, all, `StringReplace`,
    by index); splitting at a delimiter (`algorithm` block; `Pos` + `Copy` +
    `Delete` in a `While`); `Format`; columns (width on `Write`, `%-12s`,
    `StringOfChar`, a till slip and a times grid); and four more algorithms
    (password strength with Boolean flags, South African ID number details,
    initials/title case with a start-of-word flag, run-length squashing).
    "Which tool for which job?" (the toolbox table and the count/build/split
    patterns) is a `goodtoknow` box, "Good to Know - Which tool?" (19 September
    2026, Chris) - reference, not examined. Nothing else new is needed from the
    platform.

    **Marks and exercises:** 136 auto-marked (59 questions) plus a 12-mark
    written capstone (banded rubric, `showRubric`, `codeAnswer` - parse a
    `surname,first name,mark` line, tidy the names, print in two columns) = 148,
    against a minimum of 70. 40 `code` blocks are the practical exercises, all
    unmarked. If it needs trimming, the questions are safe to cut freely; only
    keep every mark total even.

    **Free Pascal facts found by compiling, all in the lesson:** `%05d` in
    `Format` does NOT zero-pad (it pads with spaces) - `%.5d` does; a wrong
    `Format` specifier or too few values all crash with the misleading
    `EConvertError: Invalid argument index in format`; `Pos` is case-sensitive
    and gives 0 for "not found"; deleting-and-inserting in place to replace
    every match runs for ever when the replacement contains the search text
    (`cat` -> `cats`); `Copy` past the end is forgiven; `%f` follows the
    computer's decimal setting (lesson 7), so column examples use
    `:width:decimals`, which always prints a point. The `Case` layout bug
    found while building it is under Decisions below.

    **Four quotes, each verified, each with a portrait** (Wikimedia Commons,
    all saved to `public/assets/quotes/` and "Quote images"): Wittgenstein,
    "The limits of my language mean the limits of my world" (*Tractatus* 5.6;
    photo Moritz Nahr, public domain); Mark Twain, the lightning-bug line (letter
    to George Bainton, 15 October 1888; A.F. Bradley, public domain);
    Suetonius on Caesar's cipher (Alexander Thomson's translation, Wikisource;
    the portrait is the Vatican Museum marble bust, public domain); Bruce
    Schneier, "Anyone... can create an algorithm that he himself can't break"
    (Cryptogram, 15 October 1998; `Bruce_Schneier_1.jpg` by sfllaw, CC BY-SA
    2.0, 528509 bytes matched). File names: `wittgenstein.png`, `twain.png`,
    `julius_caesar.png`, `schneier.png`.

    **Deliberately not done:** no `TStringList`/arrays (house style: first
    principles only, and arrays are not taught yet), so nothing counts letter
    frequencies or splits into a list; the Luhn check digit of an ID number is
    mentioned, not built. Both are good material for a later lesson. The two
    flowchart closures at the top of the lesson file (`$loopFlowchart`, a copy of
    lesson 12's `$whileFlowchart`; `$stringPicture`; `$mirrorPicture`) are local
    to the file.

14. **Making your own commands - procedures, functions, parameters and
    units.** File `lesson14.php`, added 22 September 2026, built and checked
    locally, **not yet published**. Chris's brief: start with "Keeping it DRY"
    (a loop handles repetition in one place; steps repeated in different
    places go into a procedure or function); procedures do work and send
    nothing back, functions always send an answer back and have a type; both
    add commands to Pascal and make a program easier to read, debug and
    maintain (decomposition); examples in the main program first, then units
    for teamwork and reuse; one job each, no input or output, only parameters
    for input; a comment above each (what it does, each parameter, what comes
    back); **no Const/Var parameters in the lesson** - a "Good to Know" at the
    end explains Var parameters and says plainly they are not needed for
    exams; a `MyUtils` unit with `WriteHeading`, `CountVowels`,
    `RemoveVowels` (vowels to `*`), `DrawBox` (hollow, left/top/width/height/
    text colour/background) and more (`IsVowel`, `ReverseText`, `IsPrime`,
    `RandomBetween`); quotes with images; 50 marks minimum.

    Covers, in order: DRY (WetSlip vs DrySlip); decomposition (braai
    analogy, a structure chart SVG); first procedure (program starts at the
    main Begin, must be written above its call, local variables);
    parameters (count/type/order, three real mismatch errors, argument vs
    parameter, `a` prefix, same-type sharing `(aLeft, aTop : Integer)`);
    functions (`Result`, called where a value goes, `Length`/`Round` etc. as
    functions and `Writeln`/`ClrScr` as procedures, three mistakes: unset
    Result is only a *warning*, an answer thrown away, type mismatch); the
    rules; a whole decomposed program (MarkSlip: `WriteHeading`,
    `Percentage`, `Symbol` via `Case` ranges); units (Interface = menu,
    Implementation = kitchen, file name = unit name, `Can't find unit`, off
    the menu = `Identifier not found`); the full MyUtils unit and a test
    program; procedure-or-function rule; Var parameters as Good to Know.

    **Layout decision: procedures and functions go ABOVE the main program's
    `Var`**, so they cannot see the main program's variables (a real
    `Identifier not found`) - the compiler then enforces "everything comes in
    through a parameter". Every later lesson should keep this order.

    **Open for Chris - "no output inside" vs the brief's own examples.**
    `WriteHeading` and `DrawBox` exist only to write to the screen, and
    `pascal-house-style.md` §5 says "Procedures must not produce output
    directly". The lesson teaches: never `Readln` inside; a function never
    writes; a procedure writes only when writing is its one job. If Chris
    wants §5 kept strictly, `WriteHeading`/`DrawBox` need rethinking (e.g. a
    function giving back the underline string); if not, §5 should be reworded
    to match the lesson.

    **Marks:** 104 auto-marked (38 questions, `LessonAutoMarkedMax` checked)
    plus a 4-mark fix-the-code written question (`w1FixTooManyJobs`,
    per-idea) and a 12-mark banded capstone (`w2TemperatureProgram`, two
    functions and a procedure) = 120, against a minimum of 50. 9 `code`
    exercises, unmarked.

    **Quotes, each checked:** Descartes, Discourse on the Method (1637), Part
    II, second rule (Veitch translation, Gutenberg #59), portrait after Frans
    Hals (public domain); Hunt and Thomas's DRY statement (no portrait);
    Martin Fowler, Refactoring (1999) p. 15, portrait Webysther Nunes CC BY-SA
    4.0; Dijkstra, EWD249 (1970) - shortened to "The art of programming is the
    art of organizing complexity." - portrait Hamilton Richards CC BY-SA 3.0.
    Files `descartes.png`, `fowler.png`, `dijkstra.png` (256px crops, Commons
    byte counts matched), in `public/assets/quotes/` and "Quote images".

    **Changed 22 September 2026 (Chris's review):** the tuck-shop program is
    `TillSlip` (was WetSlip); the four definitions at the top and the "four
    things" list are Learn / Memorise boxes; the first-procedure box says
    local variables exist only inside the procedure, with a compiled
    `Identifier not found "position"` example and a scrap-paper analogy; the
    Hunt and Thomas quote has both portraits (`hunt.png`, Kittie Rue, CC BY-SA
    3.0; `thomas.png`, Augie De Blieck, CC BY 2.0, Commons
    `Dave_Thomas_(programmer,_2014,_cropped).jpg`); a Note gives what an unset
    Result came back as, compiled and run on the testbed and the server:
    Integer 21418212 / 4394040 (7 without -O1), Boolean TRUE, Char random,
    Real 0.00 and String empty by luck.

    **Second review, 22 September 2026:** blank lines between program
    sections in every listing (TooLate's error moved to `toolate.pas(4,3)`,
    recompiled); "DRY: Don't Repeat Yourself." on a line of its own
    (`.big-rule`); algorithm blocks with flowchart and pseudocode for
    WriteHeading (a PROCEDURE), CountVowels (with a 'Bok bok' trace table)
    and RemoveVowels (FUNCTION ... RETURNS); a call diagram (call / back
    arrows) and three "Try this" interactives - call stepper, DrawLine
    machine, function machine. Comments in the dark code theme are now blue
    `#82aaff` (5.5:1 on the editor's #333), in console.css and style.css.

    **Found while building it:** `Double` is a type name, so a function
    called `Double` silently became a type conversion - examples use `Twice`.
    DrawBox's drawing was checked on the server under `script` (Crt output
    cannot be captured down a pipe on Windows, and the local console has no
    runner). Two tool fixes, below under Decisions.

15. **Remembering a whole list - Arrays.** File `lesson15.php`, added 22-23
    September 2026, built and checked locally, **not yet published**. Chris's
    brief: what an array is, how data is stored and accessed, the definition "a
    finite collection of elements of the same type" with every part explained,
    an animated step-by-step interactive demo, why arrays (data no longer
    vanishes, one name replaces many variables), arrays are rarely full so a
    `noOfElements` counter always goes with one, For loops over arrays, sum,
    average, biggest, smallest, quotes, flowcharts and pseudocode, selection and
    bubble sort, sorting text is NOT case-sensitive, searching to produce a
    list, sequential and binary search giving back an index (-1 if not found),
    and any other array concepts in the syllabus.

    Covers, in order: VanishingMarks (why), the definition as a table (lockers
    analogy), declaring and how it is stored (side by side, one sum finds any
    element), using one element, out of range, For loops (RememberedMarks
    answers the opening question), not full (`noOfElements`, and `Const`
    - taught in lesson 4 since 23 September 2026 - as `maxElements`), sum/average and
    biggest/smallest `algorithm` blocks, parallel arrays (keep the index,
    `bestAt`), search to a list (a `foundOne` flag), sequential search, binary
    search (trace table, 10/1000/1000000 comparison), swapping (BadSwap reveal,
    holder), selection sort, improved selection sort, bubble sort, bubble sort
    with a flag (`Repeat ... Until Not swapped`), sorting text with `UpperCase`
    and swapping parallel arrays together, insert/delete (why insert runs
    `DownTo`) and remove duplicates; two Good to Know boxes (an array passed to
    a function via a `Type` - Grade 12; dynamic arrays - theory only).

    **Rules the lesson states:** every loop that visits every element is a
    For; a loop that may stop early (the two searches) is a While with a
    condition, never `Break`. Arrays start at 1. The variable is written
    `noOfElements` (Chris wrote NoOfElements; variables are camelCase).

    **Interactive demos (new, reusable):** `public/assets/array-demo.js`, any
    `<div class="array-demo" data-demo="explorer|total|biggest|sequential|
    binary|selection|bubble" data-values="..." data-target="...">`. The
    explorer stores/looks up by index (and says what an out-of-range index
    does); the others record frames and step Back/Next/Play through them with
    the Pascal line being run highlighted and the variables shown. Logic tested
    with `node public/assets/array-demo.test.js` (300 random arrays: sorts end
    sorted, searches agree with indexOf). Styles `.array-demo` in `style.css`.
    No `<pre>` inside the widget on purpose (app.js colours every `<pre>`).

    **Free Pascal facts found by compiling:** an out-of-range FIXED index is
    only a *warning* ("range check error while evaluating constants") and the
    program still runs; a VARIABLE index gives no message at all (the site does
    not compile with `-Cr`), so the lesson says checking the index is your job
    and promises nothing about what gets overwritten. **Checked 23 September
    2026 at Chris's ask ("pascal programs crash when referring to elements
    outside the array bounds"), on the testbed and the server, same on both:**
    a small overrun (`marks[6]` of 5) runs silently; a far one
    (`marks[100000000]`) crashes with `Runtime error 216`; with range checking
    on (`-Cr` or `{$R+}`), `marks[6]` stops at once with `Runtime error 201`.
    The lesson now says all three, recommends switching range checking on in
    Lazarus/Delphi while testing, and asks for 201 (`t4bRangeCheckError`).
    Added the same day: a Good to Know on any index range (`[2015..2024]`,
    `[-10..0]`, `Low`/`High`/`Length`, and why the course keeps to 1). Lesson
    15 is now 144 auto-marked + 16 written = 160. "Linked arrays" is taught as another name for parallel arrays (Chris: "often used interchangeably"; `t10bLinkedArrays`). `Writeln (marks)` is
    "Can't read or write variables of this type". A program may not share its
    name with a variable (`Program Rainfall` with `rainfall` - Duplicate
    identifier; caught in a quiz's code field, which `check-code-blocks.php`
    does not compile - only `<pre>` listings).

    **Quotes:** Wirth's book title (wirth.png), Torvalds (git mailing list,
    2006; `torvalds.png`, Krd, CC BY-SA), Knuth (TAOCP vol. 3 preface; knuth.png),
    Obama at Google 2007 on bubble sort (`obama.png`, Pete Souza, public domain,
    1276121 bytes matched). **Marks:** 140 auto-marked plus a 4-mark
    fix-the-bubble-sort written question and a 12-mark banded capstone (class
    results: read until XXX, average, top/lowest, sort descending) = 156. No
    minimum was set. 10 `code` exercises, unmarked. Two `video` blocks left
    blank for Chris to vet.

    **Lesson 11 got a biggest-and-smallest `algorithm` block the same day**
    (Chris: "add biggest and smallest to ... loop algorithms"): anchor
    `algBiggestSmallest`, hand-drawn flowchart, pseudocode, FindBiggestSmallest,
    and two new questions (`t18bSmallestOfFour`, `q14bSmallestStartsAtZero`) -
    lesson 11 is now 112 auto-marked + 12 written. Needs publishing with lesson 15.

16. **Smart data - Classes and objects.** File `lesson16.php`, added 23
    September 2026, built and checked locally, **not yet published**. Chris's
    brief: what a class is, encapsulation, access modifiers, fields
    (attributes, properties) and methods (behaviours), an object as a smart
    structure that knows how to work with its own data, constructor,
    destructor, getters (accessors) and setters (mutators), dot notation,
    toString (the IEB prefers it), overloading ("catering for every option"),
    no input or output in methods, illustrations and activities, UML class
    diagrams only, static fields and methods, anything else in the syllabus -
    **no overriding, inheritance or polymorphism** (a later lesson) - and
    point out what must be known for theory.

    Covers, in order: lunchbox vs prepaid electricity meter (Chris: vending machines are not common in SA); class vs object (housing
    estate plan: a blueprint-to-houses figure, then a class-to-objects figure); declare / instantiate / instance; fields and
    methods; TPupil line by line (Type, `Class (TObject)`, private/public,
    `TPupil.GetMark` bodies, comment blocks on the declarations); dot notation
    (a typed method in output, condition, assignment) and a Common errors
    block; encapsulation (capsule figure, access modifier table); constructors
    (`Inherited Create` first, fields through the setters, Runtime error 216
    before Create); getters/setters with validation and a private helper;
    ToString (and a `#`-separated cousin); the no-input/output rule
    (frontend/backend, restaurant); overloaded constructors; static
    (`Class Var`, `Class Function`, a constant field); destructors (`Free`,
    `Destructor Destroy; Override;`); a "Try this" widget; UML class diagrams
    (figure drawn by a local `$classDiagram` closure); an array of objects vs
    parallel arrays (lesson 15 promised it); scope and lifetime; a theory
    summary (advantages of OOP, why the standard methods exist).

    **Theory is marked in the lesson:** every "Learn / Memorise this - theory"
    box (a local `$theory` closure, same look as Learn / Memorise) is what the
    pupil must be able to explain in words.

    **The no-I/O rule is strict for classes:** a class's methods never read
    or write; ToString gives text back. This matches pascal-house-style.md
    section 5 and is stricter than lesson 14 (still open for procedures).

    **Free Pascal facts found by compiling (all quoted in the lesson):**
    `Function ToString : String;` warns "An inherited method is hidden by
    "ToString:ShortString;"" and runs; adding `Override` is an error without
    `{$H+}`, so the lesson keeps the warning and explains it. Pascal's
    `private` does NOT protect a field from code in the same file
    (`thabo.mark := 99` compiled); `strict private`, or the class in its own
    unit, gives "identifier idents no member". A field declared below
    `Class Var` is shared too (67/82 printed 82 82). `Destructor Destroy;`
    without `Override` only warns, and Free never calls it (2 2 2).
    `Overload` is optional in -Mobjfpc but written everywhere (Delphi needs
    it). Using an object never created: warning, then Runtime error 216
    (checked on the testbed only, not the server).

    **Quotes:** Steve Jobs, "Objects are like people..." (Rolling Stone, Jeff
    Goodell, 1994; `jobs.png`); Alan Kay, "I made up the term
    'object-oriented'..." (OOPSLA 1997, Wikiquote; `kay.png`, Commons
    `Alan_Kay_(3097597186)_(cropped).jpg`, Marcin Wichary, CC BY 2.0, 364129
    bytes matched).

    **Marks:** 178 auto-marked plus three written questions - a 4-mark
    fix-the-I/O (`w1FixInAndOut`), a 6-mark theory answer on encapsulation
    (`w2ExplainEncapsulation`) and a 12-mark banded TTaxi capstone
    (`w3TaxiClass`, model answer compiled) = 200. No minimum was set. 7 `code`
    exercises (TPlayer, TTaxi, TDataBundle from a diagram, a team sheet array
    of objects), unmarked. Two `video` blocks left blank for Chris to vet.
    New widget: `objectFactory` in `public/assets/pascal-tryit.js`.

17. **Persistence - Text files.** File `lesson17.php`, added 23 September
    2026, built and checked locally, **not yet published**. Chris's brief: what
    persistence is and why text files; reading; CSV and delimiters; parsing;
    the parser in the class as `Create (aLine : String)`; loading an array of
    objects; a `StringForFile` method giving back the line for the file;
    Rewrite; Append and when to use it; flushing and CloseFile; anything else
    in the syllabus for text files.

    Covers, in order: persistence (RAM volatile, waiter's head vs notepad);
    why text files (advantages/disadvantages, sequential access); the file
    variable and four steps (AssignFile, open, use, CloseFile; Assign/Close
    named as the old forms); reading with `While Not Eof`; CSV, record, field,
    delimiter, header lines; parsing inline (lesson 13); the parser moved into
    TPupil as an overloaded constructor; loading an array of objects (a
    `maxPupils` check in the loop); StringForFile vs ToString; Rewrite (load,
    change, save everything); Append (log, new record) with a Reset/Rewrite/
    Append table; buffer and CloseFile (minibus-taxi analogy); a Try this
    widget; FileExists and Try ... Except; messy data (Trim, blank lines, a bad
    value caught per line); a file with different kinds of line (C/P codes);
    a Common errors block (2, 102-105, EConvertError); theory; a Good to Know
    on JSON (Grade 12 theory). Three algorithm blocks: read every line, load
    into an array of objects, save an array of objects.

    **Free Pascal facts found by compiling (quoted in the lesson, listed in
    its docblock):** no CloseFile after Rewrite + two Writelns leaves an EMPTY
    file with no error; 1000 Writelns without CloseFile kept 987 lines, cut
    mid-word; Flush then Writeln kept only the flushed line; Append onto a
    file with no final end-of-line joins the lines (`Aisha,10B,91Lwazi,...`);
    a blank last line crashes a parse with `EConvertError: "" is an invalid
    integer`; Reset/Rewrite/Append on an open file closes it first (buffer
    saved); Readln past the end gives '', no error. Runtime errors 2/102/103/
    104/105 become `EInOutError` messages with SysUtils. **Checked on the
    Windows testbed only** - run NoClose/BigWrite on the server once.

    **Layout check fixed the same day:** `lib/codestyle.php` did not know
    `Try ... Except/Finally ... End` and refused every line inside a Try. It
    now nests like Begin, with Except/Finally lined up with Try; three tests
    added to `bin/check-codestyle.php` (all pass). **Needs publishing with
    lesson 17.**

    **Quotes:** "The palest ink is better than the best memory" (Chinese
    proverb) and "I/O, I/O, it's off to disk I go" (author unknown, from
    `_ALL_QUOTES.docx`) - no portraits.

    **Marks:** 66 auto-marked (27 questions) plus a 4-mark fix-the-save
    (`w1FixTheSave`: Rewrite to Append, add CloseFile), a 6-mark theory answer
    (`w2ExplainTextFiles`) and a 12-mark banded tuck-shop capstone
    (`w3TuckShop`, model answer compiled and run twice) = 88. 5 `code`
    exercises, unmarked; each makes its own file first, because a file a
    program writes lasts only for that run. No video blocks (Chris removed them, 23 September 2026).
    New widget: `fileModes` in its own file, `public/assets/pascal-tryit-files.js`
    (loaded by `public/lesson.php`), so it does not collide with
    `pascal-tryit-more.js`.

**Mid-lesson quotes added to lessons 1, 3, 4, 5 and 7 (Chris, 18 September
2026).** Each opens the section it fits, as its own quote card: lesson 1, Steve
Jobs on simple instructions at huge speed (before the CPU video; verified on
Wikiquote, *Playboy* interview, February 1985); lesson 3, Bill Gates on
artistry and engineering (top of "Meet the Crt unit"); lesson 4 (`lesson02.php`),
Gates's "640 KB" line (top of "Memory is one huge, featureless space"),
labelled as attributed and denied by Gates - Wikiquote lists it as disputed,
and the lesson text says so; lesson 5, Douglas Adams on the computer terminal
(*Mostly Harmless*; "The other half of IPO"); lesson 7, Adams on "turn numbers
into letters with ASCII" (top of "Chr and Ord"). **Sourcing caveats:** the Adams
ASCII line and the Gates "artistry" line are NOT on Wikiquote - both are
widely repeated but only secondary sources were found (Wikiquote's talk page
notes the Adams line is a condensed form of a longer passage in *The Salmon of
Doubt*), and the Adams terminal line was confirmed only through quote
databases, not the book. Swap them if a primary source turns up. Portraits:
`gates.png` (DFID, CC BY 2.0, `Bill_Gates_July_2014.jpg`, size matched to the
Commons record), `douglas_adams.png` (Michael Hughes, CC BY-SA 2.0, made for
lesson 12), `jobs.png` (Matthew Yohe, CC BY-SA 3.0, from the AI course).

**Numbering settled 13 September 2026 (Chris, definite): "Proof of life" is
lesson 2, "Making it pretty" is a new lesson 3, "Every box needs a label"
moved from 3 to 4, and "Getting input" is the new lesson 5.** None of these
are drafts.

**The file names deliberately do not match the numbers.** `proofoflife.php` is
lesson 2, `lesson03.php` is lesson 3, `lesson02.php` is lesson 4, and the new
`lesson05.php` is lesson 5 - none of them should be renamed to match. The
array key in
`content/pascal/index.php` is the lessonId, and that id is a database key in
six tables - `quizResponses`, `writtenAnswers`, `codeSubmissions`,
`activityState`, `lessonPositions` and `performanceReviews`. Renaming the
files would orphan every answer, mark and bookmark stored against the old
ids, and it would do it silently: nothing errors, pupils just find their work
gone. The number is a label, the id is an identity, and they are allowed to
disagree.

Content, as built:
- **Core thesis, meant to recur across later lessons, not just this one:**
  your program must produce output or you have no way of knowing it did
  anything - this is *why* Hello World is the traditional first program.
  Watch for natural callbacks to this in lessons 3+.
- Terry Pratchett quote ("It doesn't stop being magic..."), portrait extracted
  from `_ALL_QUOTES.docx` itself.
- Planning order (Input → Processing → Output) vs. learning order (Output →
  ... → Input), taught as a deliberate reversal - see decisions below for why
  Input moved later than first planned.
- Hello World; `Write` vs `Writeln` (newline vs none); a full "Naming things
  in Pascal" section (can't start with a number, no spaces, no special
  characters, PascalCase explained, can't reuse a taught keyword - stated as a
  rule that applies to naming anything, not just a program); a "you're
  responsible for every space and mark in your own output" callout, right
  where commas first combine multiple items in one `Writeln`.
- A full set of `Writeln` tricks beyond one bare string: comma-separated
  arguments mixing text/numbers/calculations, the `:width:decimals` trick for
  real numbers, escaping an apostrophe with a doubled quote (`''`), and `#9`/
  the Tab character - each backed by genuine compiled FPC 3.2.2 output, never
  invented.
- Reading real compiler errors as an explicit, taught skill - several
  deliberately-broken snippets (missing semicolon, missing `End.`, an
  unknown identifier), each paired with genuine `fpc` output, plus a
  `match`-type question pairing error messages to causes.
- Two `code` blocks (`c1HelloWorld`, `c2FixTheErrors`) - the first real use of
  the compile subsystem, genuinely compiling and running pupil Pascal on the
  server; see the compile-subsystem decision below.
- Roughly a dozen short one-line-answer `typed` questions ("what does this
  print?" / "write the instruction that prints this"), one pair per `Writeln`
  trick, each compiled for real before being written.
- Three AI-marked "fix the code" `written` questions (pre-filled with broken
  code via the new `starterText` field, 2-4 planted errors each, 1 mark per
  error) and two "explain the error message" `written` questions (fresh
  genuine errors, testing transfer rather than the ones already covered
  above) - see the rubric-wording decisions below.
- `Readln`/Input is **not** taught in this lesson - see decisions below for
  why it moved later.
- Formal program structure, taught here for the first time: `Program Name;`
  and one `Begin … End.` block (`../pascal-house-style.md` §1).
- This is also the first lesson where a formatting/layout mark applies (see
  the rubric-wording decision below) - but only against what it actually
  teaches: indentation, program structure. No variables yet, so no variable-
  naming check here, and comments aren't taught here either.

**Course-wide pass, 22-23 September 2026 (Chris's review of lesson 14):**
- Every Pascal listing is coloured like the console (content-voice §7c); an
  exercise starter was unreadable (`console.css` gave `pre.code-starter` a
  white background over the dark theme) - fixed, and every lesson measured
  at 4.5:1 or better. Lesson 1's JavaScript and Scheme listings are marked
  `not-pascal`.
- Common errors blocks (content-voice §7d): lesson 4's type-mismatch table,
  lesson 5's Readln crash table, lesson 14's call/function/unit errors, and
  new recaps in lessons 2 (the three errors met), 8 (semicolon before Else,
  missing brackets) and 13 (Format). **Lesson 13 was wrong:** it said three
  Format mistakes all print `Invalid argument index in format "%d"`; each
  message quotes its own pattern - corrected from real runs.
- Algorithm audit (content-voice §7e): 19 new algorithm blocks in lessons
  9-13, all drawn with `lib/flowchart.php`. Lesson 10's "counts multiples of
  3 between 1 and 30" line now says to change the 20 to 30 as well.
- 14 new "Try this" widgets across lessons 2-13 (content-voice §5).

## Decisions

- **Every illustration is in a box, with a caption under it** (Chris, 23
  September 2026, all lessons and all courses) - `Figure ()`,
  content-voice-and-pedagogy.md section 5a, checked by
  `php bin/check-figures.php`. Algorithm flowcharts are captioned
  "Flowchart: ..."; the string and array pictures (lessons 13 and 15) no longer
  draw a caption inside the SVG. Lesson 8's question diagrams, circuits and
  shape legend are deliberately left as they were.
- **Every lesson has its SAGs coverage - a requirement, like `contents`**
  (Chris, 22 September 2026, after lesson 14 shipped without one). An entry
  in `content/pascal/sags.php` (grade, topic, what) or `'enrichment' => true`;
  it shows under the lesson on the course page. `php bin/check-sags.php`
  fails if any lesson is missing, names a topic not in the list, or a grade
  other than 10-12. A new lesson is not finished until it passes. Lesson 14's
  entry added topic 4.6 ("Passing data between methods") to the list.
- **Every Pascal listing is coloured like the console's editor, automatically**
  (Chris, 22 September 2026) - content-voice-and-pedagogy.md §7c.
- **Every lesson has exactly one `contents` block - this is a rule, not a
  convention** (Chris, 13 September 2026). It renders the in-page jump-list
  AND feeds the masthead's "Lesson contents" dropdown, from the same
  `items` array - see content-voice-and-pedagogy.md §7 for the full shape
  (`anchor`/`label`/`note` per item, plus the generic `'anchor' => '...'`
  field any block can carry for the ones with no `html` field to hand-write
  a span into). Run `php bin/check-lesson-contents.php` after touching any
  lesson's `contents` block or its anchors - it fails loudly if a lesson has
  none, has more than one, or a bookmark points at a dead anchor or a block
  with no heading. Every Pascal lesson through lesson 6 has one and passes;
  keep it that way for every lesson after.
- **Code compiles and runs on the server, with real `fpc`** (settled 11 September
  2026). The lessons teach reading genuine compiler errors, so the text must be
  real `fpc` output - which rules out a browser-side compiler. It means a `code`
  block type, a compile queue shaped like `bin/markqueue.php`, a sandboxed worker
  and an API endpoint. Chris chose to build it now rather than later.
  **Built 12 September 2026 and not yet deployed** - see
  [../compile-subsystem-design.md](../compile-subsystem-design.md) for what
  exists, what was found while building it, and the commands to put it up. The
  first two `code` blocks are in `proofoflife.php` (`c1HelloWorld`,
  `c2FixTheErrors`).
- **Code answers are marked strictly, and the marker sees the broken original**
  (Chris, 12 September 2026, after a fix-the-code answer that changed nothing
  came back 2 out of 4 with both marks confidently explained). `temperature` is
  now 0 for all marking, `starterText` is sent to the marker as the original to
  compare against, and code questions get a prompt that says punctuation is the
  answer rather than the "never deduct for punctuation" line written for
  essays. Any new "write a program" question must set `'codeAnswer' => true`;
  fix-the-code questions get it automatically from `starterText`. Full account
  in [../platform.md](../platform.md), decision 17.
- **A `code` block shows its output in a virtual DOS terminal** when the
  program uses Crt's screen routines (`GotoXY`, `WhereX`, `WhereY`,
  `TextColor`, `TextBackground`, `Delay`, `ClrScr`), prints more than a
  screenful, or the block sets `'terminal' => true` (Chris, 12 September 2026).
  80x25, scrollable, real DOS colours. Everything else keeps the plain output
  panel, which suits the one-line answers most exercises produce. Colour only
  works because the program is run under a pseudo-terminal - down a plain pipe
  Free Pascal's Crt silently ignores every visual call. Detail in
  [../compile-subsystem-design.md](../compile-subsystem-design.md).
- **A `code` block checks layout before it will compile anything** (Chris, 12
  September 2026). Wrong indentation, a tab, two instructions on one line or a
  missing `Program` header are listed in plain words and the program is
  refused - it never reaches the compiler. Two constraints keep this from
  fighting the lesson it serves: it only ever flags things `fpc` would happily
  compile (a missing `End.` stays the compiler's to report, because reading
  real compiler errors is the point), and it only checks what the course has
  already taught, per block. Capitalising reserved words is implemented but
  off until a lesson actually teaches it. Detail in
  [../compile-subsystem-design.md](../compile-subsystem-design.md).
- **The layout check understands `Case ... Of` (fixed 18 September 2026,
  found while building lesson 13).** `lib/codestyle.php` counted a `Case`'s
  closing `End;` but never counted the `Case` opening, so every correct `Case`
  program - lesson 8's own exercise included - was refused for "wrong
  indentation". A `Case ... Of` now opens a level exactly like `Begin`, and a
  Case's own `Else` is accepted either lined up with the `Case` (lesson 8's
  style) or lined up with its labels. Compared old and new checker over every
  prose program and starter in all Pascal lessons: only false refusals went
  away, nothing new appeared. **Published to live with lesson 13, 18
  September 2026.** Still open, known and unchanged: a
  nested `Else If` with no `Begin ... End` trips the indent check (lesson 8's
  `GradeBand` example, lesson 12's guessing game workaround).
- **The layout check allows semicolons inside brackets (fixed 22 September
  2026, found building lesson 14).** `lib/codestyle.php`'s
  one-instruction-per-line rule refused every procedure or function heading
  with two parameters (`(aLength : Integer; aCharacter : Char)`), in the
  console and in exercises. Brackets are now emptied before looking for code
  after a semicolon; two regression tests added to `bin/check-codestyle.php`
  (all pass). Same day: `bin/check-code-blocks.php --compile` now compiles
  with `-Mobjfpc` like the real pipeline (without it every `Result` was
  "Identifier not found"), checks a unit listing with the console's unit
  rules, and saves a unit under its own name so a program listed after it
  can use it. **Needs publishing** with lesson 14 - until then live refuses
  lesson 14's parameter headings.
- **A `code` block carries no marks** (12 September 2026). It is a practice box
  for reading real compiler output, not an assessment, and it is deliberately
  kept out of `LessonAutoMarkedQuestions()` so no lesson reports an "out of" a
  pupil cannot actually reach. Marked code questions are a later, separate
  layer, and there are two different shapes of them - see the design file.
- **Compiling is open to everyone signed in and enrolled** (Chris, 12 September
  2026) - not gated like AI marking, because it spends this server's own CPU
  rather than Anthropic tokens. A pupil may have only one compile in flight at
  a time, which is what keeps the Run button from being leaned on.
- **The testbed compiles without a sandbox; the server compiles inside one**,
  chosen by `$isLocal` in `config.php` (Chris, 12 September 2026). Windows has
  no systemd. So local testing proves the block, the endpoints and the UI, but
  **cannot** prove the isolation - every change to `bin/compile-sandbox.sh` has
  to be checked on the server.
- **The testbed also compiles in the request, not through the queue**
  (`'compileInRequest' => $isLocal`). Windows has no cron either, so a queued
  row would sit there forever - which is exactly what happened the first time
  Chris tried it. Both machines run the same `ProcessCodeSubmission()`, so the
  result is identical; only who calls it differs. The cron worker itself is
  therefore another thing local testing cannot prove.
- **FPC 3.2.2 everywhere.** Locally with Lazarus; on the server apt installs
  exactly 3.2.2 (`fp-compiler`, not `fpc`). Every worked example and every
  deliberately broken one is compiled for real, so the output in the lesson is
  genuine.
- **Code questions are marked against house style as well as correctness**, from
  the first lesson. The house-style penalty is **a flat 1 mark, once per
  question**, never per violation - and the feedback always names the violation.
  What counts as house style grows with what has been taught. **Never say
  "house style" or "convention" to a pupil** (Chris, 13 September 2026) -
  `content-voice-and-pedagogy.md` §1 has the required replacement wording.
  These internal docs, and rubrics meant for the marker only, can keep using
  the real terms.
- **`Readln`/Input moved out of "Proof of life" entirely** (Chris, 13
  September 2026): `Readln` needs a variable to store what's typed into, and
  this lesson comes before variables are taught at all (lesson 2, "Every box
  needs a label") - an example here would ask pupils to use a box that
  doesn't exist yet. Input now waits until after lesson 2. In its place,
  "Proof of life" goes deeper on Output itself (see the content list above).
- **A rubric shown to a pupil must never spell out the literal expected
  answer** (Chris, 13 September 2026, `content-voice-and-pedagogy.md` §4) -
  use the new **`markerRubric`** field for exact/technical marking detail
  instead; `bin/markqueue.php` sends it to the AI marker when present,
  falling back to `rubric` otherwise. `rubric` (what `showRubric` displays)
  stays a short, vague, pupil-safe summary. `proofoflife.php`'s
  `w2FirstProgram` is the model: pupils see "1 mark for formatting, 13 for
  correct code, -1 per error"; the AI marker gets the full 14-item checklist.
- **`written` questions can pre-fill the answer box** with `starterText`
  (`lib/content.php`, `public/lesson.php`, added 13 September 2026) - used
  for "fix the broken code" questions, where the pupil edits what's already
  there rather than starting from nothing. A prior saved answer always wins
  over `starterText`, so a pupil's own edits are never overwritten.
- **All pupil-facing text must read as newbie-friendly** - written for an
  actual 15-year-old who has never programmed before, not a teacher or
  developer (Chris, 13 September 2026, caught after a rubric line read "a
  mechanical, syntax-level checklist, not a holistic judgement") - see
  `content-voice-and-pedagogy.md` §1. Applies to marking language too
  ("holistic", "criterion", "band") as much as to the lesson prose itself.
- **Every programming lesson opens with the "programming is not a study
  subject" notice** (Chris, 13 September 2026) - the amber `important` block,
  first thing, before the quote card. Lesson 1 carries the full argument
  (sport, baking, singing; type it out yourself; sit with the error); lessons
  after it carry the two-line reminder, `PracticalSubjectNotice (true)`. The
  wording lives in `lib/content.php`, not in the lesson files, so a change to
  it lands in every lesson at once. It is the whole pedagogy of the course in
  one box: change it thoughtfully, and only there.
- **Every lesson in this course ends with a "what to study" block** and a
  downloadable PDF of the same summary (Chris, 13 September 2026 - asked for
  lessons 1 and 2 first, then for all of them; platform.md decision 18).
  All three written lessons have one. **A new Pascal lesson is not finished
  until it has one** - it is not optional here the way it is in other courses.
  The "evaluate my performance" panel below it needs nothing authored: it
  appears on every lesson with questions, automatically.
- **In a "Learn / Memorise this" block, every instruction is shown in full -
  with its parameters and what it gives back** (Chris, 17 September 2026).
  Never a bare `Round` or `ReadKey`: write `Round (x)` gives back an Integer
  (`Round (2.6)` is `3`), `choice := ReadKey;` gives back a Char,
  `Readln (name);` gives nothing back itself but fills `name`. Applies to the
  Gloss() term text inside the block too (`Gloss ('Ord (c)', ...)`). All
  existing blocks in lessons 2-7 were brought into line that day.
- **A question about code shows a whole, formatted program** (Chris,
  17 September 2026). Any question asking what code prints, holds or does, or
  whether it compiles, puts the complete program (`Program` line, `Uses`/`Var`
  if needed, `Begin ... End.`, house-style layout) in the question's `'code'`
  field, which shows as a code panel. `'prompt'` holds only the question. Compile
  and run every one with real fpc before it goes in. This came from lesson 7,
  where a one-line fragment (`Var total : Integer; ... average := total;`)
  expected "Yes", but as shown it could not compile. All 31 such questions in
  lessons 2 and 4-7 were rewritten that day, with their ids kept because the
  answers were unchanged.
- **Every lesson shows which parts of the SAGs it covers** (Chris,
  21 September 2026), under its summary on the course page. The lines live in
  `content/pascal/sags.php` - lessonId => [grade, subtopic, what], with the
  subtopic names in the same file - and `LessonSyllabus()` in
  `lib/content.php` builds them into "Gr 10 · 4.3 Data and data structures -
  ...". Lesson 3 is marked `'enrichment' => true` and says so instead. A new
  lesson needs a `sags.php` entry, checked against
  [../sags-topic4-syllabus.md](../sags-topic4-syllabus.md).
- **No question totals an odd number of marks** (see platform.md, decision 8).
- **Run `php bin/check-popup-spacing.php`** after touching any `Gloss()` or
  `Aside()`.
- **A `code` block can now simulate keyboard input** (13 September 2026, built
  for lesson 5): `'takesInput' => true` adds a second box - "What will you
  type when this runs?" - fed to the compiled program's own stdin, so a real
  `Readln`/`Read` reads back exactly what the pupil typed there. Proven
  against real fpc locally; the sandboxed (server) path's framing is written
  but **not yet re-tested on the actual server** - see
  [../compile-subsystem-design.md](../compile-subsystem-design.md), "Simulated
  input for Readln/Read", before trusting it live. `ReadKey`/`KeyPressed`
  deliberately do NOT get a live `takesInput` demo yet - whether a simulated
  keypress can reach a Crt call expecting a real terminal is still an open
  question there, so lesson 5 teaches those two through quiz/typed/reveal
  instead, the way lesson 3 taught `Delay`/`Sound` honestly as "compiles and
  runs here, but you cannot observe the real effect on this site."

- **Initialise every variable, and say so (Chris, 23 September 2026: "must
  always be done").** Lesson 4 has an NB block after Inc/Dec: a variable
  starts with whatever is in that piece of memory. Proved with fpc: a main
  program's variables happened to start at 0 (with a warning), but a
  procedure's local variable picked up 1234 left by an earlier call and a
  sum printed 1240 instead of 6 - on Windows and on the server. Every
  listing sets a starting value before use.
- **Lesson 10: a For loop's counter is never changed inside the loop, and
  never a single letter (Chris, 23 September 2026).** Both are NB blocks.
  The earlier note wrongly suggested the counter need not be declared; it is
  declared in `Var` like any other variable.
- **Repeat in lesson 12 prints 0, not -1 (23 September 2026).** Chris asked
  whether the repeat loop should print -1. Checked with fpc: counting down
  from 0, a Repeat loop prints 0 once (its body always runs), and afterwards
  `countdown` holds -1. The `whileVsRepeat` try-it now shows the value left
  in `countdown` after each loop.

## Resolved

- **House-style scope** (was an open question, resolved 11 September 2026):
  [../marking-house-style.md](../marking-house-style.md) (formal IEB practical
  exam marking, summative) and this course's own 1-mark deduction (formative
  in-course practice) cover different things on purpose - each file now says so
  in its own scope note.
