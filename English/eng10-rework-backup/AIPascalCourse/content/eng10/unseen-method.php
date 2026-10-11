<?php
/**
 * Lesson 52 : The unseen poem - a method, not a panic. A five-step method
 * (TRACE: title, read twice, ask, change, effect) worked on 'Invictus' by
 * W. E. Henley (died 1903; public domain, shown in full), with a short
 * analytical response, then each board's unseen-poem question. About 30 minutes.
 * Literature strand; the poem's own look (midnight iron and one gold star);
 * Ratel helps with evidence. Term 2 (ATP T2 W4-5 unseen poems; IEB ref §4
 * "Process not panic"). Prepares CAPS P2 Q5 (unseen, 10); IEB P1 Q4 (15).
 * 'Invictus' is poem 7 of library poetry set A, so pupils meet it again in
 * poem-invictus.
 * English Home Language Grade 10 (AIResources/English/eng10-lessons.md).
 * Sample lesson, written 11 October 2026. Not progress gated (Chris, 11 October 2026).
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => DesignFigure ('eng10-open-unseen', 'Literature: the unseen poem.')
    . <<<'HTML'
<p>You turn the page in the exam and there it is: a poem you have never seen, by someone you have never
heard of. Your heart rate goes up. That is normal - and it is the only part of the question you can't
practise away.</p>
<p>Everything else you can. An unseen poem is not a test of whether you "get" poetry. It is a test of
whether you have a <strong>method</strong>: a set of steps you follow every time, so that you are busy
working instead of panicking. This lesson gives you one, and you will use it on a poem written in a
hospital bed in 1875.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'This lesson has four parts:',
    'items' => [
        ['anchor' => 'method', 'label' => 'The method',        'note' => 'five steps: TRACE'],
        ['anchor' => 'poem',   'label' => 'The poem',          'note' => '\'Invictus\''],
        ['anchor' => 'steps',  'label' => 'TRACE, step by step', 'note' => 'from title to effect'],
        ['anchor' => 'answer', 'label' => 'Writing the answer', 'note' => 'and each board\'s question'],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'method',
    'title'  => 'The method: TRACE',
    'html'   => MarginNote ('Most marks on an unseen poem are lost by naming a device without its effect. "Repetition" on its own earns nothing; "the repeated \'I am\' sounds like a vow" does.', 'Examiner\'s eye')
    . <<<'HTML'
<p>Five steps, in this order, every time. The first letters spell <strong>TRACE</strong>:</p>
<ul>
<li><strong>T - Title.</strong> Read it slowly. What does it promise? A title is the only line the poet
writes for you before the poem starts.</li>
<li><strong>R - Read twice.</strong> Once straight through for the sense, without stopping. Then again
with a pencil, marking anything that strikes you.</li>
<li><strong>A - Ask</strong> who is speaking, where, to whom, and about what. Say the poem's situation in
one plain sentence.</li>
<li><strong>C - Change.</strong> Find where the poem <em>turns</em>: a new feeling, a "but" or "yet", a
shift from past to future. Most poems move somewhere.</li>
<li><strong>E - Effect.</strong> Only now look at devices - imagery, sound, repetition, structure - and
for each one, ask what it <em>does</em> to the reader.</li>
</ul>
HTML
    . DesignFigure ('eng10-trace-steps', 'TRACE: five steps for any poem you have never seen.'),
],

[
    'type'    => 'order',
    'id'      => 'o52Trace',
    'marks'   => 1,
    'prompt'  => 'Put the five steps of the unseen-poem method in order, first to last.',
    'items'   => [
        'Think about what the title promises',
        'Read the poem twice: once for sense, once with a pencil',
        'Ask who is speaking, where, to whom and about what',
        'Find where the poem changes or turns',
        'Look at the devices and what each one does',
    ],
    'why'     => 'Devices come last: you can\'t say what a device does until you know what the poem is about.',
    'explain' => 'Title, Read twice, Ask, Change, Effect - TRACE. The order matters: a device only has an effect once you know the situation it serves.',
],

[
    'type'   => 'prose',
    'anchor' => 'poem',
    'title'  => 'The poem: \'Invictus\'',
    'html'   => MarginNote ('W. E. Henley wrote this poem in 1875, in an Edinburgh hospital, after tuberculosis of the bone had already cost him a leg. It was printed in 1888 with no title; an editor gave it the name \'Invictus\' later.')
    . <<<'HTML'
<p>Before you read: the title is Latin. Hold that thought - the next step is about it. Then read the poem
twice, the TRACE way.</p>
<div class="poem">
<p><strong>Invictus</strong><br><em>W. E. Henley</em></p>
<p>Out of the night that covers me,<br>
&nbsp;&nbsp;&nbsp;&nbsp;Black as the pit from pole to pole,<br>
I thank whatever gods may be<br>
&nbsp;&nbsp;&nbsp;&nbsp;For my unconquerable soul.</p>
<p>In the fell clutch of circumstance<br>
&nbsp;&nbsp;&nbsp;&nbsp;I have not winced nor cried aloud.<br>
Under the bludgeonings of chance<br>
&nbsp;&nbsp;&nbsp;&nbsp;My head is bloody, but unbowed.</p>
<p>Beyond this place of wrath and tears<br>
&nbsp;&nbsp;&nbsp;&nbsp;Looms but the Horror of the shade,<br>
And yet the menace of the years<br>
&nbsp;&nbsp;&nbsp;&nbsp;Finds and shall find me unafraid.</p>
<p>It matters not how strait the gate,<br>
&nbsp;&nbsp;&nbsp;&nbsp;How charged with punishments the scroll,<br>
I am the master of my fate,<br>
&nbsp;&nbsp;&nbsp;&nbsp;I am the captain of my soul.</p>
</div>
HTML,
],

[
    'type'   => 'reveal',
    'prompt' => '<p><strong>T - Title.</strong> "Invictus" is a Latin word. You probably know English words that grow from the same root: <em>invincible</em>, <em>victory</em>. Guess what "Invictus" means, and what that promises about the poem. Then check.</p>',
    'explain'=> '<p><strong>Invictus</strong> means <strong>unconquered</strong> (in-, "not", and victus, "conquered"). So before line 1 the poem promises a speaker who has been attacked but not beaten. Every stanza keeps that promise.</p>',
],

[
    'type'   => 'prose',
    'anchor' => 'steps',
    'title'  => 'TRACE, step by step',
    'html'   => Doodle ('eng10-joke-unseen', 'Ratel read \'Invictus\' and shrugged: "Head bloody but unbowed? That\'s just a Tuesday."')
    . <<<'HTML'
<p><strong>R - Read twice.</strong> On the second reading, a pencil helps with the old words. Poems from
the 1800s use words that have changed or dropped out of use. Don't skip them: they usually carry the
poem's sharpest meaning.</p>
HTML,
],

[
    'type'    => 'match',
    'id'      => 'm52Words',
    'marks'   => 1,
    'prompt'  => 'Match each old word from the poem to its meaning here.',
    'pairs'   => [
        'fell (line 5)'          => 'cruel, deadly',
        'bludgeonings (line 7)'  => 'heavy, crushing blows',
        'strait (line 13)'       => 'narrow, hard to pass through',
        'scroll (line 14)'       => 'a written list (of crimes and punishments)',
    ],
    'explain' => '"Fell" here is an adjective meaning cruel or deadly, not the past tense of fall. "Strait" means narrow (as in a strait of water, or a straitjacket). The scroll is the list of a person\'s wrongs - the old picture of a judge reading out what you have done.',
],

[
    'type'   => 'prose',
    'html'   => <<<'HTML'
<p><strong>A - Ask.</strong> Four quick questions: who speaks, where, to whom, and about what? Answer
them from stanzas 1 and 2, then try to say the poem's situation in one plain sentence. The question
below checks your sentence.</p>
HTML,
],

[
    'type'    => 'quiz',
    'id'      => 'q52Situation',
    'marks'   => 1,
    'prompt'  => 'Read stanzas 1 and 2 again.' . "\n\n" . 'Which sentence best describes the speaker\'s situation and response?',
    'options' => [
        'a' => 'He is suffering badly, but he refuses to give in or complain.',
        'b' => 'He has escaped from his troubles and is now at peace.',
        'c' => 'He is crying out to the gods to rescue him.',
        'd' => 'He is angry with the people who hurt him and wants revenge.',
    ],
    'answer'  => 'a',
    'why'     => [
        'b' => 'Is the night over? "My head is bloody" - is that peace?',
        'c' => 'He thanks "whatever gods may be" for his soul. Does he ask them for anything?',
        'd' => 'Who hurts him? "Circumstance" and "chance" - not people.',
    ],
    'explain' => 'An "I" speaks about himself, in darkness, under attack. He is suffering ("my head is bloody") but has "not winced nor cried aloud" - his head is "unbowed". The attackers are not people but "circumstance" and "chance": life itself. One plain sentence: <em>a man in terrible circumstances says that nothing can break his spirit</em>.',
],

[
    'type'     => 'markwords',
    'id'       => 'mw52Attack',
    'language' => 'text',
    'marks'    => 1,
    'prompt'   => 'In stanza 2, circumstance and chance are described as if they were attackers. Mark the TWO nouns that show what they do to the speaker.',
    'code'     => "In the fell [[clutch]] of circumstance\n    I have not winced nor cried aloud.\nUnder the [[bludgeonings]] of chance\n    My head is bloody, but unbowed.",
    'why'      => [
        'missed' => 'Look for the things an attacker does with its hands or a weapon.',
        'wrong'  => '"Bloody" is the result, and it is an adjective. Which two nouns are actions done TO him?',
    ],
    'explain'  => 'The <strong>clutch</strong> of circumstance (a grip that holds him) and the <strong>bludgeonings</strong> of chance (blows with a club). The poet turns bad luck into a violent attacker, so the speaker\'s calm looks braver.',
],

[
    'type'   => 'prose',
    'html'   => <<<'HTML'
<p><strong>C - Change.</strong> Look for the turn. Stanzas 1 to 3 describe what is done to the speaker:
night, the clutch, the blows, the "Horror of the shade" (death) waiting ahead. Then "And yet" in line 11
starts to push back - "Finds and shall find me unafraid". By stanza 4 the speaker is no longer the
victim of anything: "It matters not". The poem moves from <em>suffering</em> to <em>control</em>.</p>
<p><strong>E - Effect.</strong> Now, and only now, the devices. The last two lines are the most famous
in the poem. What is the poet doing in them, and why?</p>
HTML,
],

[
    'type'    => 'select',
    'id'      => 's52Devices',
    'marks'   => 1,
    'prompt'  => '"I am the master of my fate, / I am the captain of my soul."' . "\n\n" . 'Which TWO devices does the poet use in these two lines?',
    'options' => [
        'a' => 'Repetition of "I am the ... of my ..."',
        'b' => 'Metaphor: the speaker is a master and a captain',
        'c' => 'Onomatopoeia',
        'd' => 'Simile',
    ],
    'answer'  => ['a', 'b'],
    'why'     => [
        'c' => 'Is there a word that imitates a sound?',
        'd' => 'Is there a "like" or an "as"? Or does he say he IS the captain?',
    ],
    'explain' => 'The lines <strong>repeat</strong> the same shape ("I am the ... of my ..."), and each is a <strong>metaphor</strong>: he does not say he is <em>like</em> a captain, he says he <em>is</em> one. There is no "like" or "as", so no simile.',
],

[
    'type'     => 'reveal',
    'id'       => 'rv52Effect',
    'prompt'   => '<p>Now the important half: the effect. Why does the poet end with these two repeated metaphors? What do they make the reader feel or understand? Say it in your own words before you open the answer.</p>',
    'ownWords' => [
        'the speaker is in control of his own life or spirit, even though he cannot control what happens to him',
        'the repetition sounds strong, certain or like a vow or chant, so the ending feels defiant',
    ],
    'hints'    => [
        'What does a captain do with a ship that a passenger cannot?',
        'Read the two lines aloud. How does saying the same pattern twice sound?',
    ],
    'explain'  => '<p>A master controls; a captain steers. The speaker cannot stop the blows, but he decides how he meets them, so his <strong>spirit stays in his own command</strong>. Repeating the pattern makes the lines sound like a <strong>vow</strong> or a chant: certain, defiant, easy to remember. That is why people in hard places have learnt these two lines by heart.</p>',
],

[
    'type'   => 'prose',
    'anchor' => 'answer',
    'title'  => 'Writing the answer',
    'html'   => MarginNote ('Nelson Mandela is said to have recited \'Invictus\' to fellow prisoners on Robben Island. The poem\'s last two lines are quoted on posters, in speeches and at graduations all over the world.')
    . <<<'HTML'
<p>TRACE gives you notes. The answer turns them into sentences. For each point, use the same three moves:</p>
<ul>
<li><strong>Say</strong> what the poet does (the device or the choice), in a full sentence.</li>
<li><strong>Show</strong> it with a short quotation - two to five words, in quotation marks.</li>
<li><strong>Explain</strong> the effect: what it makes the reader see, feel or understand.</li>
</ul>
<p>Weak: <em>"The poet uses repetition. This is effective."</em> It names a device and stops.</p>
<p>Strong: <em>"The poet ends by repeating 'I am the', which makes the last lines sound like a vow; the
speaker is not hoping to be strong, he is declaring that he already is."</em></p>
HTML,
],

[
    'type'         => 'written',
    'id'           => 'w52Paragraph',
    'markMax'      => 4,
    'prompt'       => '<p class="prompt-setup">You have traced the whole poem. Now write a short paragraph (about 80 to 100 words).</p><p class="prompt-ask">How does the poet show that the speaker\'s spirit is not defeated by suffering?</p><ul><li>Make two points about choices the poet makes (images, words, the turn, the ending).</li><li>Support each point with a short quotation.</li><li>Explain the effect of each, not just its name.</li></ul>',
    'rubric'       => "- 1 mark: a first point with a short quotation\n- 1 mark: the effect of the first point explained\n- 1 mark: a second point with a short quotation\n- 1 mark: the effect of the second point explained",
    'markerRubric' => "Any two valid points, each with a quotation (1) and its effect (1). Possible points: violent images of suffering (\"fell clutch\", \"bludgeonings\") contrasted with his response (\"not winced nor cried aloud\", \"bloody, but unbowed\") - the contrast makes his courage stand out; \"unbowed\"/\"unafraid\"/\"unconquerable\" - the un- words deny defeat; the turn at \"And yet\" - the speaker pushes back against death; \"It matters not\" - he dismisses punishment; the repeated metaphors \"master of my fate\"/\"captain of my soul\" - control of his spirit, a vow. No mark for a device named without effect. Quotations must be from the poem.",
    'points'       => [
        ['marks' => 1, 'any' => ['a first point about a choice the poet makes, supported by a short quotation from the poem']],
        ['marks' => 1, 'any' => ['the effect of the first point is explained, for example that the contrast between the violent images and his calm response makes his courage stand out']],
        ['marks' => 1, 'any' => ['a second, different point supported by a short quotation from the poem']],
        ['marks' => 1, 'any' => ['the effect of the second point is explained, for example that the repeated metaphors make the ending sound like a confident vow of control']],
    ],
],

...BoardSection ('caps', 'The CAPS unseen poem (10 marks)', [
    [
        'type' => 'prose',
        'html' => '<p>In CAPS Paper 2 the unseen poem is compulsory and worth 10 marks, set as short contextual questions of 2 or 3 marks. Each mark wants a separate idea, so a 2-mark question needs two: usually the point and its effect.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w52CapsBlack',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Refer to lines 1 and 2: "Out of the night that covers me, / Black as the pit from pole to pole,".</p><p class="prompt-ask">Explain what this image suggests about the speaker\'s situation. (2)</p>',
        'rubric'       => "- 1 mark: what the darkness suggests\n- 1 mark: how far it reaches, or what it says about his suffering",
        'markerRubric' => "1 mark: the night/black pit suggests despair, suffering, hopelessness or a fearful, hellish place. 1 mark: \"from pole to pole\" - the darkness covers everything, there is no escape / his suffering is total. Accept an answer linking it to illness or hardship.",
        'points'       => [
            ['marks' => 1, 'any' => ['the black night or pit suggests despair, suffering or a hellish place']],
            ['marks' => 1, 'any' => ['from pole to pole means the darkness covers everything, so his suffering is total and there is no escape']],
        ],
    ],
    [
        'type'         => 'written',
        'id'           => 'w52CapsTone',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Read stanza 4.</p><p class="prompt-ask">Describe the speaker\'s tone in stanza 4 and quote ONE phrase to support your answer. (2)</p>',
        'rubric'       => "- 1 mark: a fitting tone word\n- 1 mark: a supporting quotation",
        'markerRubric' => "1 mark: defiant / confident / determined / triumphant / proud (not just 'happy' or 'positive'). 1 mark: a supporting quotation from stanza 4 - \"It matters not\", \"I am the master of my fate\", \"I am the captain of my soul\".",
        'points'       => [
            ['marks' => 1, 'any' => ['the tone is defiant, confident, determined or triumphant']],
            ['marks' => 1, 'any' => ['a quotation from stanza 4 such as it matters not, master of my fate or captain of my soul']],
        ],
    ],
]),

...BoardSection ('ieb', 'The IEB unseen poem (15 marks)', [
    [
        'type' => 'prose',
        'html' => '<p>The IEB unseen question is worth 15 marks, and it usually pairs the unseen poem with a poem you have studied, or with a short quotation to think through. The last part asks you to bring the two together - so practise saying how a new text connects to the poem.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w52IebAgency',
        'markMax'      => 4,
        'prompt'       => '<p class="prompt-setup">Here is a statement about suffering, written for this course: "We cannot choose what happens to us. We can only choose how we answer it."</p><p class="prompt-ask">Critically discuss how far \'Invictus\' agrees with this statement. (4)</p><ul><li>Refer closely to the poem, with short quotations.</li><li>Consider whether the speaker really has as much control as he claims.</li></ul>',
        'rubric'       => "- 1 mark: the poem agrees that he cannot choose what happens\n- 1 mark: the poem agrees that he chooses his answer\n- 1 mark: close reference to the poem\n- 1 mark: a critical judgement - is his claim of control convincing?",
        'markerRubric' => "Relational answer (4 marks) links statement, evidence and judgement. Agrees: what happens is outside his control - \"circumstance\", \"chance\", \"the menace of the years\"; his answer is his own - \"not winced nor cried aloud\", \"unbowed\", \"unafraid\". Critical edge: in the last stanza he goes further than the statement - \"master of my fate\" claims control of fate itself, which the first three stanzas show he does not have; or the claim is a brave vow rather than a fact. Cap at 2 if there is no judgement. Credit valid alternatives.",
        'points'       => [
            ['marks' => 1, 'any' => ['the poem agrees that what happens is out of his control, for example circumstance and chance attack him']],
            ['marks' => 1, 'any' => ['the poem agrees that he chooses how he answers, for example he has not winced or cried aloud and is unbowed']],
            ['marks' => 1, 'any' => ['the answer refers closely to the poem with short quotations']],
            ['marks' => 1, 'any' => ['the last stanza goes further than the statement by claiming he is master of his fate, which the earlier stanzas show he is not', 'his claim of control is a brave vow or act of will rather than a fact']],
        ],
    ],
]),

[
    'type'   => 'prose',
    'title'  => 'Next time',
    'html'   => <<<'HTML'
<p>On the day, TRACE takes about five minutes. Spend them. A pupil who traces first and writes second
finishes the question; a pupil who starts writing at once usually runs out of things to say.</p>
<p>Next: the unseen poem under exam conditions, one board at a time.</p>
HTML,
],

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'The unseen-poem method, on \'Invictus\'.',
    'sections' => [
        [
            'heading' => 'TRACE',
            'points'  => [
                '**T - Title**: what does it promise? (\'Invictus\' = unconquered.)',
                '**R - Read twice**: once for sense, once with a pencil. Look up the old words in context.',
                '**A - Ask**: who speaks, where, to whom, about what - one plain sentence.',
                '**C - Change**: where the poem turns (\'Invictus\': "And yet", from suffering to control).',
                '**E - Effect**: each device, and what it DOES to the reader.',
            ],
        ],
        [
            'heading' => 'Writing about a poem',
            'points'  => [
                'Say what the poet does, show it with a short quotation, explain the effect.',
                'A device named without its effect earns nothing.',
                'Tone needs an exact word: defiant, confident, bitter, wistful - never just "positive".',
            ],
        ],
    ],
    'keyTerms' => [
        'unseen poem' => 'A poem you have not studied before, given in an exam to test how you read poetry.',
        'turn'        => 'The place where a poem changes direction - a new feeling, idea or time. In a sonnet it is called the volta.',
        'metaphor'    => 'Saying one thing IS another, without "like" or "as": "I am the captain of my soul".',
        'imagery'     => 'Words that make a picture, sound or feeling in the reader\'s mind.',
    ],
],

];
