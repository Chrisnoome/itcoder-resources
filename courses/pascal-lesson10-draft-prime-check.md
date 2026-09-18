**CONSUMED, 18 September 2026 - lesson 10 (`content/pascal/lesson10.php`) now
exists.** Its brief below (Trunc(Sqrt(n)), don't just reskin the 3-check
version) was followed exactly - see `pascal-course.md`'s lesson 10 entry for
what actually shipped. The content below was NOT reused verbatim; kept here
as a historical record of why lesson 9 only has two algorithm blocks, not as
an open TODO.

# Draft: prime-check algorithm, held for Lesson 10 (Loops)

**Moved out of lesson 9 (Division), 18 September 2026, Chris: "prime needs
a loop take it out for now - will use in loop lesson (lesson 10). don't
discard."** This file is that content, preserved verbatim so the loop
lesson doesn't have to rebuild it from scratch. Lesson 9 (`lesson09.php`)
now covers only odd/even and factor-checking - see its own docblock and
`courses/pascal-course.md`'s lesson 9 entry for what stayed.

## Why it was cut

The version below checks primality with three chained `If`s (`Mod 2`,
`Mod 3`, `Mod 5`) rather than a real loop, because lesson 9 comes before
looping is taught (`For`/`While`/`Repeat` are SAGs 4.8, not yet covered by
lesson 9). That shortcut only works for whole numbers from 6 to 48
(verified against fpc), and wrongly calls 2, 3 and 5 themselves non-prime,
since each divides itself - both stated as an honest, explained limitation
inside the content itself, not hidden.

**For lesson 10, this needs rebuilding as a real loop-based check** - test
every whole number from 2 up to (at least) `n Div 2`, or better, up to
`Trunc (Sqrt (n))` for a genuinely general algorithm, stopping early the
moment a factor is found (a flag variable, or a `while`/`repeat` condition
that checks the flag). That also fixes the 2/3/5-divides-itself edge case
for free, if the loop naturally never tests a number against itself. Don't
just reskin the 3-check version with a `For` around it and call it done -
the whole point of a loop lesson is that this algorithm can finally handle
*any* whole number, not just 6-48.

The flowchart and pseudocode below will also need redrawing for a real
loop (a loop-back arrow instead of three separate diamonds) - the
right-angle diamond-and-merge SVG technique used here (see
`platform.md`/`lesson09.php`'s own notes on the odd/even and factor
flowcharts) is worth reusing for the loop version's connectors, but the
overall shape changes completely once there's an actual loop to draw.

## The content, verbatim (was `content/pascal/lesson09.php`, the `algPrime`
section - one `algorithm` block, one `code` block, three questions)

```php
[
    'type'  => 'algorithm',
    'title' => 'Is a number prime?',
    'html'  => <<<HTML
<span class="block-anchor" id="algPrime"></span>

<p><strong>The problem:</strong> decide whether a whole number is a</p>
HTML
    . Gloss ('prime number', 'A whole number greater than 1 with exactly two factors: 1 and itself. 17 is prime - nothing between 2 and 16 divides into it exactly. 21 is not - it has 3 and 7 as factors too.')
    . <<<HTML
&#32;- a number whose ONLY factors are 1 and itself.</p>

<p>A full version of this algorithm checks every possible factor from 2 up
to the number itself, using a loop - and you haven't met Pascal's way of
repeating a check yet, so that full version is coming in a later lesson. For
now, here's a shortcut that works correctly for any whole number
<strong>bigger than 5 and smaller than 49</strong>: just check whether 2, 3
or 5 divides in exactly. If none of them do, nothing smaller could either,
so the number must be prime.</p>

<div class="algorithm-flowchart">
<svg viewBox="0 0 420 580" width="100%" style="max-width:400px">
<defs>
<marker id="arrowP" viewBox="0 0 10 10" refX="9" refY="5" markerWidth="7" markerHeight="7" orient="auto-start-reverse">
<path d="M0,0 L10,5 L0,10 z" fill="var(--ink)"></path>
</marker>
</defs>

<rect x="100" y="6" width="100" height="34" rx="17" fill="var(--card)" stroke="var(--ink)" stroke-width="2"></rect>
<text x="150" y="28" text-anchor="middle" font-size="13" fill="var(--ink)">Start</text>
<line x1="150" y1="40" x2="150" y2="60" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>

<rect x="30" y="62" width="240" height="46" rx="4" fill="var(--card)" stroke="var(--ink)" stroke-width="2"></rect>
<text x="150" y="82" text-anchor="middle" font-size="12" fill="var(--ink)">Read n</text>
<text x="150" y="99" text-anchor="middle" font-size="12" fill="var(--ink)">Set isPrime to True</text>
<line x1="150" y1="108" x2="150" y2="130" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>

<!-- Diamond 1: n Mod 2 -->
<polygon points="150,130 225,175 150,220 75,175" fill="var(--card)" stroke="var(--ink)" stroke-width="2"></polygon>
<text x="150" y="171" text-anchor="middle" font-size="13" fill="var(--ink)">n Mod 2</text>
<text x="150" y="187" text-anchor="middle" font-size="13" fill="var(--ink)">= 0 ?</text>
<line x1="225" y1="175" x2="266" y2="175" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<text x="235" y="168" font-size="12" fill="var(--good)">Yes</text>
<rect x="270" y="157" width="120" height="36" rx="4" fill="var(--card)" stroke="var(--good)" stroke-width="2"></rect>
<text x="330" y="180" text-anchor="middle" font-size="12" fill="var(--ink)">isPrime := False</text>
<line x1="150" y1="220" x2="150" y2="236" stroke="var(--ink)" stroke-width="2"></line>
<text x="158" y="233" font-size="12" fill="var(--bad)">No</text>
<line x1="330" y1="193" x2="330" y2="240" stroke="var(--ink)" stroke-width="2"></line>
<line x1="330" y1="240" x2="154" y2="240" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<line x1="150" y1="240" x2="150" y2="270" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>

<!-- Diamond 2: n Mod 3 -->
<polygon points="150,270 225,315 150,360 75,315" fill="var(--card)" stroke="var(--ink)" stroke-width="2"></polygon>
<text x="150" y="311" text-anchor="middle" font-size="13" fill="var(--ink)">n Mod 3</text>
<text x="150" y="327" text-anchor="middle" font-size="13" fill="var(--ink)">= 0 ?</text>
<line x1="225" y1="315" x2="266" y2="315" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<text x="235" y="308" font-size="12" fill="var(--good)">Yes</text>
<rect x="270" y="297" width="120" height="36" rx="4" fill="var(--card)" stroke="var(--good)" stroke-width="2"></rect>
<text x="330" y="320" text-anchor="middle" font-size="12" fill="var(--ink)">isPrime := False</text>
<line x1="150" y1="360" x2="150" y2="376" stroke="var(--ink)" stroke-width="2"></line>
<text x="158" y="373" font-size="12" fill="var(--bad)">No</text>
<line x1="330" y1="333" x2="330" y2="380" stroke="var(--ink)" stroke-width="2"></line>
<line x1="330" y1="380" x2="154" y2="380" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<line x1="150" y1="380" x2="150" y2="410" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>

<!-- Diamond 3: n Mod 5 -->
<polygon points="150,410 225,455 150,500 75,455" fill="var(--card)" stroke="var(--ink)" stroke-width="2"></polygon>
<text x="150" y="451" text-anchor="middle" font-size="13" fill="var(--ink)">n Mod 5</text>
<text x="150" y="467" text-anchor="middle" font-size="13" fill="var(--ink)">= 0 ?</text>
<line x1="225" y1="455" x2="266" y2="455" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<text x="235" y="448" font-size="12" fill="var(--good)">Yes</text>
<rect x="270" y="437" width="120" height="36" rx="4" fill="var(--card)" stroke="var(--good)" stroke-width="2"></rect>
<text x="330" y="460" text-anchor="middle" font-size="12" fill="var(--ink)">isPrime := False</text>
<line x1="150" y1="500" x2="150" y2="516" stroke="var(--ink)" stroke-width="2"></line>
<text x="158" y="513" font-size="12" fill="var(--bad)">No</text>
<line x1="330" y1="473" x2="330" y2="520" stroke="var(--ink)" stroke-width="2"></line>
<line x1="330" y1="520" x2="154" y2="520" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<line x1="150" y1="520" x2="150" y2="550" stroke="var(--ink)" stroke-width="2" marker-end="url(#arrowP)"></line>
<text x="150" y="570" text-anchor="middle" font-size="12" fill="var(--ink-soft)">(continues below)</text>
</svg>
</div>

<p><em>(Every path through the diagram above - whichever of the three
checks caught a factor, or none of them did - lands back on the same
single line down the middle, which continues to one last step not drawn
above: printing <code>isPrime</code>. Left off only to keep the diagram
from getting too tall to read comfortably.)</em></p>

<p class="eyebrow">Pseudocode</p>
<pre class="algorithm-pseudocode">START
  GET n                       { a whole number, more than 5 and less than 49 }
  SET isPrime to TRUE
  IF n MOD 2 equals 0 THEN SET isPrime to FALSE
  IF n MOD 3 equals 0 THEN SET isPrime to FALSE
  IF n MOD 5 equals 0 THEN SET isPrime to FALSE
  PRINT isPrime
END</pre>

<div class="callout"><strong>Every algorithm has assumptions - knowing where
one stops working is part of understanding it, not a flaw to hide.</strong>
This one gets 2, 3 and 5 themselves WRONG - each divides itself,
so the checks above wrongly set <code>isPrime</code> to <code>False</code>
for all three, even though all three are actually prime. A complete version
needs an extra check for "is n one of the numbers I'm testing with," or a
loop that stops once a number has been checked against everything up to its
own square root - both are for a later lesson. For any whole number from 6
up to 48, though, this shortcut is completely correct, checked
against fpc for 17, 21, 29, 33, 41, 44 and 47.</div>
HTML
],

[
    'type'    => 'code',
    'id'      => 'c3IsItPrime',
    'prompt'  => <<<HTML
<p>Complete the program below so it declares a whole number between 6 and
48, and a Boolean, then prints whether the number is prime - using exactly
the three-check algorithm above.</p>
HTML
    ,
    'hint'    => "Three separate If statements, one for Mod 2, one for Mod 3, one for Mod 5 - each sets isPrime to False if it finds a factor. Finish with Writeln (isPrime); after all three.",
    'starter' => "Program IsItPrime;\nVar\n  n       : Integer;\n  isPrime : Boolean;\nBegin\n  n := 29;\n  isPrime := True;\n\n\nEnd.\n",
],

[
    'type'    => 'quiz',
    'id'      => 'q5PrimeCheck41',
    'marks'   => 1,
    'prompt'  => 'Using the prime-check algorithm, is 41 prime?',
    'options' => [
        'a' => 'Yes - 41 Mod 2, Mod 3 and Mod 5 are all non-zero',
        'b' => 'No - 41 is too big for the algorithm',
        'c' => 'No - 41 Mod 5 is 0',
        'd' => "It can't be decided with just three checks",
    ],
    'answer'  => 'a',
    'explain' => "41 Mod 2 is 1, 41 Mod 3 is 2, and 41 Mod 5 is 1 - none of them are 0, so isPrime stays True the whole way through. 41 is prime, and it's under 49, so the shortcut applies correctly.",
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't6PrimeCheck33',
    'marks'   => 1,
    'prompt'  => 'Using the prime-check algorithm, what does it print for n = 33? (capitals, exactly as Writeln prints a Boolean)',
    'answer'  => 'FALSE',
    'explain' => "33 Mod 3 is 0 (33 = 3 x 11), so isPrime gets set to False at the second check and stays that way. 33 is not prime.",
],

[
    'type'    => 'quiz',
    'id'      => 'q6PrimeLimitation',
    'marks'   => 1,
    'prompt'  => 'Why does the algorithm above wrongly say that 5 is NOT prime, even though 5 really is prime?',
    'options' => [
        'a' => 'It only works on even numbers',
        'b' => "5 Mod 5 is 0, because 5 divides itself exactly - the algorithm has no way to tell \"divides itself\" apart from \"has a real factor\"",
        'c' => "It's a bug that hasn't been fixed yet, unrelated to how the algorithm works",
        'd' => '5 is too small for Div and Mod to work on',
    ],
    'answer'  => 'b',
    'explain' => "Every number divides exactly into itself, including prime numbers - so checking \"does n Mod 5 equal 0\" when n itself IS 5 always says yes, wrongly flagging it. That's exactly the stated limitation: this shortcut only applies to numbers from 6 to 48, not to 2, 3 or 5 themselves.",
],
```

## Ids, if reused as-is

`algPrime` (anchor), `c3IsItPrime`, `q5PrimeCheck41`, `t6PrimeCheck33`,
`q6PrimeLimitation` are all free again in lesson 9 (removed from there
18 September 2026) - safe to reuse in lesson 10 if convenient, or rename
to fit lesson 10's own id scheme. They are not live anywhere and carry no
pupil data.
