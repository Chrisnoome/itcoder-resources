<?php
/**
 * CAT Grade 10 - Lesson 1: What a computer is, and the IPO model
 *
 * Source: written from the syllabuses and the papers - the CAT textbook PDF
 * was not available when this was written. CAPS Grade 10 Term 1
 * ("Introduction to Concepts of Computing": what a computer is, a general
 * model in relation to the information processing cycle; main components;
 * ICTs in everyday life) and the IEB SAGs Appendix L, System Technologies
 * Grade 10 (main components; the generic model - IPO; the information
 * processing cycle; introduce algorithms using pseudocode or simple
 * English). See cat-caps.md and cat-sags.md.
 *
 * Board sections: the algorithms section is IEB only. The SAGs introduce
 * algorithms in Grade 10 and Paper II Question 5 examines Input, Processing
 * and Output every year; CAPS has no algorithm content at all. Per Chris
 * (27 September 2026, decision 16) it is TAUGHT to everyone and only the
 * questions are flagged, so a CAPS pupil reads it and skips the marks.
 *
 * Kept out on purpose: types of computing device (lesson 2), data vs
 * information in full (lesson 3), the till and the cellphone as worked ICT
 * systems (lesson 4). This lesson only needs enough of each to make the
 * model make sense.
 *
 * Marks: 22 for a CAPS pupil, 26 for an IEB pupil - both even (decision 8).
 * No written part is worth more than 4, and the 2-mark ones ask for TWO
 * things, which is how both boards' papers are built (cat-caps-exam-
 * analysis.md section 11b: 223 written parts, none over 3 marks).
 *
 * Drawings: gigo-salt (drawn for this lesson, checked in headless Chromium).
 * The ipo-cycle figure is inline SVG with colour tokens - it must stay
 * inline, because an external .svg in an <img> cannot see var(--ink) and
 * renders invisibly.
 *
 * Quote: Donald Knuth, from the TeX documentation. No portrait yet.
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => <<<'HTML'
<div class="quote-card">
    <blockquote class="quote">Computers are good at following instructions, but not at reading your mind.<cite>- Donald Knuth, computer scientist</cite></blockquote>
</div>

<p>Your phone woke you up this morning. The traffic lights on the way to school decided when to change. The till at the shop worked out your change. A machine somewhere marked your last test.</p>

<p>Every one of those is a computer, and every one of them did the same three things in the same order.</p>

<p>This lesson is about those three things. Once you can see them, you can look at any system - a till, an ATM, a school register, an app - and say exactly what it takes in, what it does, and what it gives back. That skill is worth marks in every paper you will write for this subject, and it is the frame the whole course hangs on.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'What a computer is, and the model that describes every one of them:',
    'items' => [
        ['anchor' => 'computer', 'label' => 'What a computer is',        'note' => 'a definition that holds'],
        ['anchor' => 'ipo',      'label' => 'The IPO model',             'note' => 'input, processing, output'],
        ['anchor' => 'storage',  'label' => 'Storage and communication', 'note' => 'the other two'],
        ['anchor' => 'gigo',     'label' => 'Garbage in, garbage out',   'note' => 'why input matters'],
        ['anchor' => 'algorithms', 'label' => 'Writing the steps down',  'note' => 'IEB'],
        ['anchor' => 'why',      'label' => 'Why we use computers',      'note' => 'and what they cost us'],
    ],
],

// ------------------------------------------------------------------ computer

[
    'type'  => 'prose',
    'title' => 'What a computer is',
    'html'  => <<<'HTML'
<span class="block-anchor" id="computer"></span>

<p>Ask ten people what a computer is and you will get ten answers, most of them a list of things they have seen: a laptop, a desktop, a tablet.</p>

<p>A list is not a definition. Here is one that holds:</p>

<p>
HTML
    . Gloss ('A computer', 'An electronic device that accepts data as input, processes it according to stored instructions, and produces information as output.')
    . <<<'HTML'
 is an <strong>electronic device that accepts data, processes it according to instructions it has been given, and produces information as output</strong>.</p>

<p>Read that again and notice what it does not say. It does not say "has a screen". It does not say "has a keyboard". It does not say how big it is or what it costs. It describes what a thing <strong>does</strong>, not what it looks like - which is why it still fits a device nobody has invented yet.</p>

<p>Test it on something that is not obviously a computer. A modern washing machine takes in your choice of cycle, the weight of the load and the water temperature; it follows a stored program; it produces washed clothing and a beep. It fits the definition. That is why we say a washing machine contains an <strong>embedded computer</strong> - a computer built to do one job, inside something that is not called a computer.</p>
HTML
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't1Computer',
    'marks'   => 1,
    'prompt'  => 'Give the term for a computer that is built into another device to do one specific job - like the one inside a washing machine.',
    'answer'  => ['embedded computer', 'embedded', 'an embedded computer', 'embedded system'],
    'explain' => 'An embedded computer. It still takes input, processes and produces output - it just does one job, and you never see a desktop.',
],

[
    'type'   => 'reveal',
    'prompt' => '<p>A basic pocket calculator: you press 7, then &times;, then 8, then =, and 56 appears.</p><p>Is a pocket calculator a computer? Decide before you press the button.</p>',
    'explain' => '<p><strong>For the exam: no.</strong> A calculator does not store a program you can change, and it cannot do anything except arithmetic. Both boards expect you to say a basic calculator is not a computer.</p><p><strong>In reality it is more interesting.</strong> There is a chip inside it that accepts input, follows instructions and produces output - a one-job embedded computer. What the calculator lacks is not processing; it is the ability to be given <em>different</em> instructions.</p><p>Learn the exam answer. Understand the real one. They are not in conflict - "computer" is one of those words people use slightly differently, so read each question the way it means it.</p>',
],

// ------------------------------------------------------------------ ipo

[
    'type'  => 'prose',
    'title' => 'The IPO model',
    'html'  => <<<'HTML'
<span class="block-anchor" id="ipo"></span>
HTML
    . MarginNote ('IPO is older than computers. Factories were drawn this way - raw materials in, work done, product out - long before anything was electronic. The model was borrowed, not invented.')
    . <<<'HTML'

<p>Every computer, from the cheapest phone to the machine that runs the SARS website, follows the same three steps. We call it the <strong>IPO model</strong>.</p>

<ul>
<li><strong>Input</strong> - data goes in. You type it, scan it, tap it, speak it, or a sensor measures it.</li>
<li><strong>Processing</strong> - the computer works on that data: sorting, calculating, comparing, searching.</li>
<li><strong>Output</strong> - information comes out: on a screen, on paper, through a speaker, as a message.</li>
</ul>

<p>Notice the change in the words. <strong>Data</strong> goes in; <strong>information</strong> comes out. That difference is the whole of lesson 3, so for now just hold on to the shape of it: raw things in, useful things out.</p>
HTML
    . <<<'HTML'
<figure class="figure"><div class="figure-box">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 300" width="640" height="300" fill="none" font-family="system-ui, sans-serif" style="max-width: 100%; height: auto">
<rect x="24" y="86" width="140" height="64" rx="8" fill="var(--card)" stroke="var(--ink)" stroke-width="2"/>
<text x="94" y="124" text-anchor="middle" fill="var(--ink)" font-size="19" font-weight="600">Input</text>
<rect x="250" y="86" width="140" height="64" rx="8" fill="var(--card)" stroke="var(--heat)" stroke-width="3"/>
<text x="320" y="118" text-anchor="middle" fill="var(--ink)" font-size="19" font-weight="600">Processing</text>
<text x="320" y="138" text-anchor="middle" fill="var(--ink)" font-size="13" opacity="0.75">the computer works</text>
<rect x="476" y="86" width="140" height="64" rx="8" fill="var(--card)" stroke="var(--ink)" stroke-width="2"/>
<text x="546" y="124" text-anchor="middle" fill="var(--ink)" font-size="19" font-weight="600">Output</text>
<path d="M172 118 L242 118" stroke="var(--ink)" stroke-width="2"/>
<path d="M232 112 l10 6 l-10 6" stroke="var(--ink)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M398 118 L468 118" stroke="var(--ink)" stroke-width="2"/>
<path d="M458 112 l10 6 l-10 6" stroke="var(--ink)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<rect x="250" y="212" width="140" height="56" rx="8" fill="var(--card)" stroke="var(--ink)" stroke-width="2" stroke-dasharray="6 4"/>
<text x="320" y="246" text-anchor="middle" fill="var(--ink)" font-size="17" font-weight="600">Storage</text>
<path d="M320 152 L320 206" stroke="var(--ink)" stroke-width="2"/>
<path d="M314 196 l6 10 l6 -10" stroke="var(--ink)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<path d="M314 162 l6 -10 l6 10" stroke="var(--ink)" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
<rect x="24" y="212" width="140" height="56" rx="8" fill="var(--card)" stroke="var(--ink)" stroke-width="2" stroke-dasharray="6 4"/>
<text x="94" y="246" text-anchor="middle" fill="var(--ink)" font-size="14" font-weight="600">Communication</text>
<path d="M164 240 L242 240" stroke="var(--ink)" stroke-width="2" stroke-dasharray="6 4"/>
<text x="320" y="46" text-anchor="middle" fill="var(--ink)" font-size="15" opacity="0.75">Data goes in, information comes out</text>
</svg>
</div><figcaption>The information processing cycle. Input, processing and output are the three steps every computer takes; storage and communication sit alongside them.</figcaption></figure>
HTML
],

[
    'type'    => 'quiz',
    'id'      => 'q1Processing',
    'marks'   => 1,
    'prompt'  => 'A school system takes every pupil\'s marks and works out each class\'s average. Which step of the IPO model is the working out?',
    'options' => [
        'a' => 'Input',
        'b' => 'Processing',
        'c' => 'Output',
        'd' => 'Storage',
    ],
    'answer'  => 'b',
    'explain' => 'Processing. The marks going in are input; the averages coming out are output; the calculating in between is processing.',
],

// ------------------------------------------------------------------ storage

[
    'type'  => 'prose',
    'title' => 'Storage and communication',
    'html'  => <<<'HTML'
<span class="block-anchor" id="storage"></span>

<p>Three steps describe what a computer does. They do not quite describe what a computer <strong>is</strong>, because two more things have to happen for any of it to be useful.</p>

<ul>
<li><strong>Storage</strong> - keeping data and information so it is still there tomorrow. Without storage, your work would vanish the moment you closed the lid, and the computer would have to be told what to do again every time you switched it on.</li>
<li><strong>Communication</strong> - moving data between computers. Sending the file, loading the page, syncing the photo.</li>
</ul>

<p>Put all five together and you have the <strong>information processing cycle</strong>: input, processing, output, storage and communication. That is the phrase CAPS uses, and it is worth knowing both names - the three-step IPO model, and the five-part cycle it sits inside.</p>

<p>Storage is drawn with arrows going <em>both</em> ways in the figure above, and that is deliberate. A computer writes to storage (saving your document) and reads from it (opening it again). It is not a one-way street like input and output.</p>
HTML
],

[
    'type'    => 'match',
    'id'      => 'm1Cycle',
    'marks'   => 1,
    'prompt'  => 'Match each part of a school\'s online homework system to the part of the information processing cycle it belongs to.',
    'pairs'   => [
        'Input'         => 'A pupil types an answer into the box',
        'Processing'    => 'The system compares the answer to the memo',
        'Output'        => 'The mark and a comment appear on the screen',
        'Storage'       => 'The mark is kept so the teacher can see it next week',
        'Communication' => 'The answer travels from the pupil\'s phone to the school\'s server',
    ],
    'explain' => 'Typing is input, comparing is processing, showing the mark is output, keeping it is storage, and moving it across the network is communication. Every system you meet in this subject can be broken down this way.',
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't1Cycle',
    'marks'   => 1,
    'prompt'  => 'Give the name of the complete five-part cycle: input, processing, output, storage and communication.',
    'answer'  => ['information processing cycle', 'the information processing cycle', 'information processing'],
    'explain' => 'The information processing cycle. The IPO model is the first three steps of it.',
],

[
    'type'         => 'written',
    'id'           => 'w1Atm',
    'markMax'      => 2,
    'prompt'       => '<p>Think about an ATM drawing cash.</p><p>Give TWO examples of <strong>input</strong> at an ATM.</p>',
    'rubric'       => "- 1 mark each, for any TWO correct inputs",
    'markerRubric' => "- 1 mark each for any TWO of: the bank card (inserted or tapped); the PIN typed in; the amount chosen; the choice of account (cheque / savings); the menu option pressed; a fingerprint where the ATM uses one; the answer to \"do you want a slip?\".\n- Do NOT credit outputs (the cash, the slip, the screen message, the beep) or processing (checking the PIN, checking the balance).\n- Do NOT credit the parts themselves (\"the keypad\", \"the card reader\") - those are input DEVICES, not input. The question asks what goes in.\n- \"Money\" earns nothing at an ATM that dispenses cash; money is the output.",
],

// ------------------------------------------------------------------ gigo

[
    'type'  => 'prose',
    'title' => 'Garbage in, garbage out',
    'html'  => <<<'HTML'
<span class="block-anchor" id="gigo"></span>
HTML
    . Doodle ('gigo-salt', 'Garbage in, garbage out. The recipe was perfect. The salt was not sugar.')
    . <<<'HTML'

<p>Here is the part of the model people forget, and it is the part that gets tested.</p>

<p>A computer does not check whether the data you gave it makes sense. It processes what it is given, exactly as instructed, at enormous speed - and then presents the result in a neat table that looks completely official.</p>

<p>Programmers have a name for this:
HTML
    . ' ' . Gloss ('GIGO', 'Garbage in, garbage out - if the data going into a system is wrong, the information coming out will be wrong too, no matter how good the program is.')
    . <<<'HTML'
 - <strong>garbage in, garbage out</strong>. Wrong data in means wrong information out, however good the program is.</p>

<p>A clerk types a pupil's mark as 37 instead of 73. The system averages it correctly, ranks the class correctly, prints the report correctly - and every one of those correct steps is built on a wrong number. Nothing in the computer noticed.</p>
HTML
    . MarginNote ('In 1999 NASA lost a spacecraft on its way to Mars. One team had worked in pounds, another in newtons, and nobody converted. The arithmetic was perfect all the way down.')
    . <<<'HTML'

<p>This is why so much of this subject is about getting data in <strong>correctly</strong>: drop-down lists instead of typing, checks that refuse a date of birth in the future, a second person checking the capture. You will meet those properly in Grade 11.</p>
HTML
],

[
    'type'         => 'written',
    'id'           => 'w1Gigo',
    'markMax'      => 2,
    'prompt'       => '<p>A clinic\'s system works out how much medicine each patient should get, based on the patient\'s weight typed in by a nurse.</p><p>Explain what GIGO means, and say why it matters especially here.</p>',
    'rubric'       => "- 1 mark: what GIGO means\n- 1 mark: why it matters in this situation",
    'markerRubric' => "- 1 mark: garbage in, garbage out - if the data entered is wrong / inaccurate, the information (or result) produced will be wrong too, however correct the program is. \"Garbage in, garbage out\" written out with no explanation of what it means earns nothing.\n- 1 mark: a consequence tied to THIS situation - a wrong weight gives a wrong dose, which could harm or kill the patient; the computer will not notice because it only follows instructions.\n- A general answer (\"you get wrong answers\") with no link to the clinic earns only the first mark.",
],

// ------------------------------------------------------------------ algorithms (IEB)

...BoardSection ('ieb', 'Writing the steps down', [

[
    'type'  => 'prose',
    'title' => 'From a model to a method',
    'html'  => <<<'HTML'
<span class="block-anchor" id="algorithms"></span>

<p>The IPO model tells you a computer processes data. It does not tell you <strong>how</strong>. That is decided by whoever wrote the instructions - and instructions written as an ordered list of steps have a name.</p>

<p>
HTML
    . Gloss ('An algorithm', 'A clear, ordered list of steps that solves a problem or completes a task.')
    . <<<'HTML'
 is a <strong>clear, ordered list of steps that solves a problem</strong>. You do not need a programming language to write one. Plain English is enough, as long as each step is unambiguous and they are in the right order.</p>

<p>Working out a pupil's average from three test marks:</p>

<ol>
<li>Get the three marks.</li>
<li>Add them together.</li>
<li>Divide the total by 3.</li>
<li>Show the answer.</li>
</ol>

<p>Line up those steps against the model and the fit is exact: step 1 is <strong>input</strong>, steps 2 and 3 are <strong>processing</strong>, step 4 is <strong>output</strong>. That is the shape an examiner is looking for.</p>

<p>Two rules worth having now, because they are where marks go:</p>

<ul>
<li><strong>Order matters.</strong> Divide before you add and the answer is nonsense. A computer will do it anyway.</li>
<li><strong>No step may assume anything.</strong> "Work out the average" is not a step - it is the whole problem restated. Break it down until each line is one thing to do.</li>
</ul>
HTML
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't1Algorithm',
    'marks'   => 1,
    'prompt'  => 'Give the term for a clear, ordered list of steps that solves a problem.',
    'answer'  => ['algorithm', 'an algorithm'],
    'explain' => 'An algorithm. Ordered, unambiguous, and it must actually finish.',
],

[
    'type'    => 'select',
    'id'      => 's1Steps',
    'marks'   => 1,
    'prompt'  => 'Tick every line below that is a PROCESSING step.',
    'options' => [
        'a' => 'Ask the user for the length and the width',
        'b' => 'Multiply the length by the width',
        'c' => 'Display the area on the screen',
        'd' => 'Subtract the discount from the price',
        'e' => 'Read the temperature from the sensor',
        'f' => 'Save the result to the file',
    ],
    'answer'  => ['b', 'd'],
    'explain' => 'Multiplying and subtracting are processing - the computer working something out. Asking and reading are input, displaying is output, and saving is storage.',
],

[
    'type'         => 'written',
    'id'           => 'w1Algorithm',
    'markMax'      => 2,
    'prompt'       => '<p>A spaza shop wants a system that works out the total cost of a customer\'s basket and the change from the money handed over.</p><p>Write the <strong>input</strong> and the <strong>output</strong> for this system.</p>',
    'rubric'       => "- 1 mark: the input\n- 1 mark: the output",
    'markerRubric' => "- 1 mark: input - the price (and quantity) of each item bought, and the amount of money handed over. Both halves are needed; the money alone, or the prices alone, does not earn it.\n- 1 mark: output - the total cost and the change due. Either one named clearly earns the mark; \"the answer\" does not.\n- Do not credit processing (adding up, subtracting) in either box - the question did not ask for it.",
],

], 'The IEB introduces algorithms in Grade 10 and examines input, processing and output in Paper II every year. CAPS does not. It is taught to everyone because it is a useful way to think, but only IEB pupils are marked on it.'),

// ------------------------------------------------------------------ why

[
    'type'  => 'prose',
    'title' => 'Why we use computers',
    'html'  => <<<'HTML'
<span class="block-anchor" id="why"></span>

<p>Computers took over almost every kind of work in about fifty years. They did it for reasons you can list, and an exam will ask you to.</p>

<ul>
<li><strong>Speed</strong> - a payroll that took a clerk a week takes a server a few seconds.</li>
<li><strong>Accuracy</strong> - a computer does not get bored on the four-hundredth invoice and make a mistake.</li>
<li><strong>Reliability</strong> - it does the same job the same way every time, at three in the morning if needed.</li>
<li><strong>Storage</strong> - a filing room fits on a drive you can hold.</li>
<li><strong>Communication</strong> - a document reaches Cape Town in under a second.</li>
<li><strong>Cost</strong> - after the machine is paid for, the work costs far less in paper, postage and hours.</li>
</ul>

<p>Be careful with accuracy, though. A computer is accurate at <strong>following instructions</strong>. It is not accurate about the world - that depends entirely on the data it was given, which is what the last section was about.</p>

<p>And there is a cost on the other side:</p>

<ul>
<li>Jobs that used to be done by people are done by machines, and not everyone can move to the new work.</li>
<li>When the system is down - a power cut, a network fault, a crash - the work stops completely, in a way it never did with paper.</li>
<li>Data about you is collected, kept and sometimes lost by people you never chose to trust.</li>
<li>Screens, e-waste and the electricity to run it all have a real cost to health and to the planet.</li>
</ul>

<p>You will meet each of those properly later in the course. For now, notice that the honest answer to "are computers good?" is "good at what, and for whom?" - and that an exam answer which only lists advantages is only half an answer.</p>
HTML
],

[
    'type'    => 'select',
    'id'      => 's1Costs',
    'marks'   => 1,
    'prompt'  => 'Tick every item below that is a DISADVANTAGE of a business moving its work onto computers.',
    'options' => [
        'a' => 'Work stops completely during a power cut',
        'b' => 'The same job is done the same way every time',
        'c' => 'Staff have to be trained before they can use the system',
        'd' => 'A document reaches another city in under a second',
        'e' => 'Customers\' personal details could be stolen by hackers',
        'f' => 'A filing room fits onto one drive',
    ],
    'answer'  => ['a', 'c', 'e'],
    'explain' => 'Depending on power, the cost of training and the risk to personal data are all real costs of going digital. Reliability, speed of communication and saving space are advantages.',
],

[
    'type'         => 'written',
    'id'           => 'w1Advantages',
    'markMax'      => 4,
    'prompt'       => '<p>A doctor\'s practice in Polokwane still keeps every patient\'s file on paper in a cabinet.</p><p>Give TWO advantages the practice would gain by moving those records onto a computer, and TWO problems it would have to plan for.</p>',
    'rubric'       => "- 1 mark each for TWO advantages\n- 1 mark each for TWO problems",
    'markerRubric' => "Advantages - 1 mark each for any TWO of: files are found in seconds instead of searched for; many staff can see a record at once; records take almost no physical space; they can be backed up, so a fire or flood does not destroy them; they can be searched (every patient on a given medicine); they can be sent to a specialist or hospital instantly; handwriting problems disappear.\nProblems - 1 mark each for any TWO of: the practice stops working during a power cut or network failure; the cost of computers, software and training; staff have to be trained and may resist; patient data is private and must be protected against hackers and theft (POPI); data could be lost if backups are not made; capturing the existing paper files takes a long time and mistakes creep in.\n- A bare adjective (\"faster\", \"cheaper\", \"safer\") with no reason earns nothing - this is how both boards mark it.\n- An advantage repeated as its own opposite (\"fast\" and \"not slow\") counts once.",
],

// ------------------------------------------------------------------ scenario

...Scenario ('Phumlani Secondary\'s absentee messages', <<<'HTML'
<p>Phumlani Secondary in Soweto has a system that tells parents when their child is not at school.</p>

<p>Every morning each teacher takes the register on a tablet, tapping the name of any pupil who is not there. At 09:00 the system collects the morning's registers, finds every pupil marked absent, looks up the parent's cellphone number and sends one message to each: <em>"Thandeka was marked absent at Phumlani Secondary today."</em></p>

<p>The registers are kept for three years, because the Department can ask for them.</p>
HTML, [
    [
        'type'    => 'typed',
        'kind'    => 'exact',
        'id'      => 't1PhumOutput',
        'marks'   => 1,
        'prompt'  => 'Give the ONE word for the part of the information processing cycle that the SMS to the parent belongs to.',
        'answer'  => ['output'],
        'explain' => 'Output. The message is what the system produces for a person to use.',
    ],
    [
        'type'         => 'written',
        'id'           => 'w1PhumIpo',
        'markMax'      => 2,
        'prompt'       => '<p>Give the <strong>input</strong> and the <strong>processing</strong> for this system.</p>',
        'rubric'       => "- 1 mark: the input\n- 1 mark: the processing",
        'markerRubric' => "- 1 mark: input - the teacher tapping / marking which pupils are absent on the tablet (accept \"the register\", \"which pupils are absent\").\n- 1 mark: processing - collecting the registers and working out / finding which pupils are absent, and looking up each one's parent's number. Any one of those two actions earns the mark.\n- \"The tablet\" is an input device, not the input. \"Sending the SMS\" is output, not processing.",
    ],
    [
        'type'         => 'written',
        'id'           => 'w1PhumStorage',
        'markMax'      => 2,
        'prompt'       => '<p>Name the part of the cycle that keeping the registers for three years belongs to, and give ONE reason the school needs it.</p>',
        'rubric'       => "- 1 mark: the part of the cycle\n- 1 mark: a reason",
        'markerRubric' => "- 1 mark: storage.\n- 1 mark: a reason - the Department can ask for the registers / it is a legal requirement; the school can check an attendance dispute with a parent later; patterns of absence can be looked at over time; the data would be lost when the tablet is switched off otherwise.\n- \"To keep it safe\" with nothing further earns nothing.",
    ],
    [
        'type'         => 'written',
        'id'           => 'w1PhumGigo',
        'markMax'      => 4,
        'prompt'       => '<p>One morning a teacher taps the wrong name. Thandeka is at school, but her mother gets the message anyway.</p><p>Explain what went wrong, using what you know about GIGO - and suggest TWO things the school could do so that it happens less often.</p>',
        'rubric'       => "- 2 marks: what went wrong, explained with GIGO\n- 1 mark each for TWO sensible suggestions",
        'markerRubric' => "What went wrong - 2 marks:\n- 1 mark: the input was wrong (the teacher marked the wrong pupil).\n- 1 mark: the system then did everything else correctly - it found the \"absent\" pupil, looked up the right parent and sent the message - so a correct process produced wrong information. Garbage in, garbage out; the computer cannot tell that the register was wrong.\nSuggestions - 1 mark each for any TWO of: show the teacher a confirmation list of everyone marked absent before sending; show the pupil's photograph next to the name; send the message later in the day so a mistake can be fixed first; let a second person (the office) check the list; let a parent reply to report an error; make the pupil's name and surname both show, so similar names are not confused; delay the message until a second period's register agrees.\n- \"Be more careful\" earns nothing - it is not something the school can build.\n- A suggestion that only repeats the problem (\"do not tap the wrong name\") earns nothing.",
    ],
]),

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'What a computer is, the three steps every computer takes, the two that go with them, and why wrong data matters. You must be able to take a system you have never seen and break it into its parts.',

    'sections' => [
        [
            'heading' => 'What a computer is',
            'points'  => [
                'A computer is an **electronic device that accepts data as input, processes it according to instructions, and produces information as output**. The definition says what it *does*, not what it looks like.',
                'An **embedded computer** is built into another device to do one job (a washing machine, a traffic light, a microwave).',
                'For the exam, a basic pocket calculator is **not** a computer - it cannot be given different instructions.',
            ],
        ],
        [
            'heading' => 'The IPO model and the information processing cycle',
            'points'  => [
                '**Input** - data goes in (typed, scanned, tapped, spoken, measured).',
                '**Processing** - the computer works on the data (sorting, calculating, comparing, searching).',
                '**Output** - information comes out (screen, printout, sound, message).',
                '**Storage** - keeping data and information for later. Two-way: the computer both writes and reads.',
                '**Communication** - moving data between computers.',
                'All five together are the **information processing cycle**. The first three are the **IPO model**.',
                'Watch the words: **data** goes in, **information** comes out.',
                'An input *device* (a keyboard, a scanner) is not the same thing as the input (what actually goes in). Exams take marks for this.',
            ],
        ],
        [
            'heading' => 'Garbage in, garbage out',
            'points'  => [
                '**GIGO** - if the data going in is wrong, the information coming out is wrong, however good the program is.',
                'The computer does not notice. It processes wrong data correctly and presents the result as though it were true.',
                'This is why so much of the subject is about getting data in correctly.',
            ],
        ],
        [
            'heading' => 'Why we use computers',
            'points'  => [
                'Speed, accuracy, reliability, storage, communication and cost.',
                '**Accuracy means accurate at following instructions** - not accurate about the world. That depends on the data.',
                'Against them: job losses, total dependence when the system is down, privacy, and health and environmental costs.',
                'An answer that lists only advantages is half an answer.',
            ],
        ],
    ],

    'keyTerms' => [
        'computer'                     => 'An electronic device that accepts data, processes it according to instructions and produces information.',
        'embedded computer'            => 'A computer built into another device to do one specific job.',
        'input'                        => 'Data going into a computer.',
        'processing'                   => 'The computer working on data - sorting, calculating, comparing, searching.',
        'output'                       => 'Information a computer produces for a person to use.',
        'storage'                      => 'Keeping data and information so it is available later.',
        'communication'                => 'Moving data between computers.',
        'information processing cycle' => 'Input, processing, output, storage and communication together.',
        'GIGO'                         => 'Garbage in, garbage out - wrong data in means wrong information out.',
    ],
],

];
