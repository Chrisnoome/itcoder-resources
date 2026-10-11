<?php
/**
 * Lesson 105 : The prepared speech - a topic with substance, a structure a
 * listener can follow, 4-5 minutes, cue cards and delivery; a written speech
 * script, then self-assessment of a recorded run-through against each board's
 * prepared-speech marks. About 30 minutes, plus practice at home.
 * Orals strand (speech writing: W1 Drafting table, Quill). Term 3 W2-11
 * (CAPS ref §1.2: prepared speech 4-5 minutes; IEB SAG §1.7: a meaningful
 * topic, formal register, at most 5 minutes, talk to the audience, cue cards
 * only, reading from a text heavily penalised; rubric D5, 7 levels).
 * Prepares CAPS Task 9 (prepared speech, 10); IEB oral: prepared speech (20).
 * The self-assessment checklists are the course's own, built from what both
 * boards say a prepared speech is judged on; the schools' real rubrics (CAPS
 * oral rubric, IEB D5 - being revised in 2026) are what the teacher marks with.
 * Recording: pupils record themselves on their own phones (the platform has no
 * audio upload yet - plan, "Marking").
 * English Home Language Grade 10 (AIResources/English/eng10-lessons.md).
 * Sample lesson, written 11 October 2026. Not progress gated (Chris, 11 October 2026).
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => DesignFigure ('eng10-open-speech', 'Orals: the prepared speech.')
    . <<<'HTML'
<p>Think of the best talk you have ever sat through - a teacher, a coach, someone at a funeral, a streamer
who kept you watching for an hour. They probably did not read a single word. They looked at you, they
paused at the right moments, and you could follow them without trying.</p>
<p>None of that is a talent you are born with. It is preparation. This lesson walks you through
preparing a speech of four to five minutes: choosing a topic worth the time, shaping it for a listener,
putting it on cue cards, and delivering it. Then you write part of one, record it, and mark yourself.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'This lesson has five parts:',
    'items' => [
        ['anchor' => 'topic',    'label' => 'A topic with substance', 'note' => 'worth five minutes'],
        ['anchor' => 'shape',    'label' => 'A shape for listeners',  'note' => 'hook to last line'],
        ['anchor' => 'cards',    'label' => 'Cue cards',              'note' => 'keywords, not sentences'],
        ['anchor' => 'delivery', 'label' => 'Delivery',               'note' => 'talk to them, not at them'],
        ['anchor' => 'script',   'label' => 'Script and self-check',  'note' => 'write it, record it, mark it'],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'topic',
    'title'  => 'A topic with substance',
    'html'   => MarginNote ('In 1964, at the Rivonia Trial, Nelson Mandela spoke from the dock for about three hours. He ended with the words "it is an ideal for which I am prepared to die."')
    . <<<'HTML'
<p>Both boards want a topic with <strong>substance</strong>: something that matters, that you can say
something real about, and that an audience of your classmates would care to hear. "My favourite food"
runs out after forty seconds. "Why we should stop wasting the school's food" has a problem, evidence and
an argument in it.</p>
<p>A good test: can you state your speech's <strong>purpose</strong> in one sentence that starts with "I
want my audience to..."? "I want my audience to switch off autoplay tonight" is a purpose. "I want to
talk about phones" is not - it is only a subject.</p>
HTML,
],

[
    'type'    => 'quiz',
    'id'      => 'q105Topic',
    'marks'   => 1,
    'prompt'  => 'Your teacher asks for a prepared speech of four to five minutes for a Grade 10 audience.' . "\n\n" . 'Which topic has the most substance?',
    'options' => [
        'a' => 'My favourite colour and why I like it',
        'b' => 'Why our school should switch off the class group chats at 9 p.m.',
        'c' => 'Everything about every planet in the solar system',
        'd' => 'The plot of the last series I watched',
    ],
    'answer'  => 'b',
    'why'     => [
        'a' => 'Could you fill four minutes - and would your audience care?',
        'c' => 'There is plenty to say, but can you cover it in five minutes, and what is your point?',
        'd' => 'A retold plot has no argument or purpose. What would your audience do with it?',
    ],
    'explain' => 'Option b has a <strong>problem, a stance and a purpose</strong>, and it matters to the people listening. Option c has too much to cover and no point to make; a and d run out of things to say.',
],

[
    'type'   => 'prose',
    'anchor' => 'shape',
    'title'  => 'A shape for listeners',
    'html'   => <<<'HTML'
<p>A reader can flip back a page. A listener can't. So a speech needs a shape that is easier to follow
than an essay:</p>
<ul>
<li><strong>Hook</strong> - grab attention in the first ten seconds: a question, a surprising fact, a
short story.</li>
<li><strong>Purpose</strong> - say what the speech is about and where it is going: "Tonight I want to
convince you of three things."</li>
<li><strong>Main points</strong> - usually three, each with an example. Signpost them out loud:
"My second reason..."</li>
<li><strong>Conclusion</strong> - sum up in a sentence, then end with a line they will remember. Coming
back to your hook works well.</li>
</ul>
<p>How long is four to five minutes on paper? Most people speak at roughly 120 to 150 words a minute.
Use 130 as a working figure, then time yourself.</p>
HTML,
],

[
    'type'    => 'typed',
    'kind'    => 'calc',
    'id'      => 't105Words',
    'marks'   => 1,
    'prompt'  => 'You speak at about 130 words a minute, and your speech must last at least 4 minutes.' . "\n\n" . 'About how many words should your speech script have, at least?',
    'answer'  => ['520', 'num:520'],
    'explain' => '4 minutes x 130 words = <strong>520 words</strong>. For five minutes it is 650. Pauses take time too, so a 520-word script fills four minutes comfortably.',
],

[
    'type'    => 'order',
    'id'      => 'o105Shape',
    'marks'   => 1,
    'prompt'  => 'Put the parts of a prepared speech in order.',
    'items'   => [
        'A hook that grabs attention',
        'The purpose: what the speech will do',
        'The main points, each with an example',
        'A one-sentence summary',
        'A memorable last line',
    ],
    'why'     => 'Grab them, tell them where you are going, take them there, remind them, then leave them with something.',
    'explain' => 'Hook, purpose, main points, summary, memorable ending.',
],

[
    'type'   => 'prose',
    'anchor' => 'cards',
    'title'  => 'Cue cards: keywords, not sentences',
    'html'   => Doodle ('eng10-joke-speech', 'Quill\'s first cue card said "Look up." Quill spent the whole speech admiring the ceiling.')
    . <<<'HTML'
<p>You may use <strong>cue cards</strong> - small cards with notes - but never a written speech. Reading
aloud from a page is heavily penalised, because your eyes are on the paper instead of your audience. A cue
card is a reminder, not a script.</p>
<ul>
<li><strong>One card, one point.</strong> Number every card.</li>
<li><strong>Keywords</strong>, not sentences: enough to remind you, not enough to read.</li>
<li>Write a <strong>quotation or a statistic in full</strong> - that is the one thing you must get exactly right.</li>
<li>Add <strong>delivery notes</strong> in another colour: PAUSE, LOOK UP, SLOW.</li>
</ul>
HTML
    . DesignFigure ('eng10-cue-cards', 'Two cue cards: a script squeezed onto a card, and a real cue card.'),
],

[
    'type'    => 'select',
    'id'      => 's105Cards',
    'marks'   => 1,
    'prompt'  => 'Which THREE are good cue-card habits?',
    'options' => [
        'a' => 'Number every card',
        'b' => 'Write keywords instead of full sentences',
        'c' => 'Write a quotation out in full',
        'd' => 'Squeeze the whole speech onto the cards in small writing',
        'e' => 'Put three or four points on each card to save cards',
    ],
    'answer'  => ['a', 'b', 'c'],
    'why'     => [
        'd' => 'Then you would read it - and reading is heavily penalised.',
        'e' => 'One card, one point. What happens when you lose your place on a crowded card?',
    ],
    'explain' => '<strong>Number</strong> the cards, write <strong>keywords</strong>, and write a <strong>quotation in full</strong> so you get it exactly right. A whole speech on cards turns into reading, and crowded cards make you lose your place.',
],

[
    'type'   => 'prose',
    'title'  => 'Try this: one paragraph onto one card',
    'html'   => MarginNote ('One card, one point. Number your cards: if you drop them, you can still put them in order in five seconds.', 'Layout rule')
    . <<<'HTML'
<p>Here is one paragraph from a speech script. Turn it into ONE cue card: a heading, two or three keyword
lines, anything that must be exact, and one delivery note. Do it on paper, then compare.</p>
<p><em>"Here's the first thing you should know: the little red dot on your apps is not there by accident.
It was designed to make you feel that something important has happened, so that you open the app. Last
term I counted. In one evening, I opened my phone forty-one times, and thirty of those were because of a
red dot."</em></p>
HTML,
],

[
    'type'    => 'reveal',
    'prompt'  => '<p>Your card done? Then compare it with this one.</p>',
    'explain' => <<<'HTML'
<p>One way to do it:</p>
<ul>
<li><strong>Card 2 - POINT 1: the red dot</strong></li>
<li>designed - "something happened!"</li>
<li>my count: <strong>41 opens, 30 = red dot</strong> (exact - written in full)</li>
<li><em>PAUSE after "thirty" - LOOK UP</em></li>
</ul>
<p>About twelve words for a paragraph of sixty. The numbers are written exactly, because a speaker who
says "about forty, or thirty-something" loses the audience's trust. Everything else you will say in your
own words - which is why it will sound like talking, not reading.</p>
HTML,
],

[
    'type'   => 'prose',
    'anchor' => 'delivery',
    'title'  => 'Delivery: talk to them, not at them',
    'html'   => <<<'HTML'
<p>The IEB puts it in five words: talk <strong>to</strong> your audience, not <strong>at</strong> them. The
same skills earn the marks on both boards:</p>
<ul>
<li><strong>Eye contact</strong> - look up from your cards often, and at different parts of the room.</li>
<li><strong>Pace</strong> - slower than feels natural. Nerves speed everyone up.</li>
<li><strong>Pause</strong> - before and after your most important line. Silence makes people listen.</li>
<li><strong>Projection</strong> - loud enough for the back row, without shouting.</li>
<li><strong>Tone and emphasis</strong> - lean on the words that matter; let your voice rise and fall.</li>
<li><strong>Gesture and stance</strong> - stand still and steady; use your hands only when they help.</li>
</ul>
<p>And watch the clock. A CAPS prepared speech is four to five minutes; the IEB sets five minutes as the
most you may take.</p>
HTML,
],

[
    'type'    => 'match',
    'id'      => 'm105Delivery',
    'marks'   => 1,
    'prompt'  => 'Match each delivery skill to what it means.',
    'pairs'   => [
        'Pace'        => 'how fast you speak',
        'Pause'       => 'a short silence that lets a point sink in',
        'Projection'  => 'speaking loudly enough for the back row to hear',
        'Eye contact' => 'looking at your audience instead of your cards',
    ],
    'explain' => 'Pace is speed, a pause is a deliberate silence, projection is volume that carries, and eye contact keeps you talking to people rather than to paper.',
],

[
    'type'   => 'prose',
    'anchor' => 'script',
    'title'  => 'Script and self-check',
    'html'   => <<<'HTML'
<p>Most good speakers write a script first, then cut it down to cue cards. Writing it makes you find
your words; the cards make you let go of them. Now write the first part of a speech of your own.</p>
HTML,
],

...BoardSection ('caps', 'CAPS: write the script (10 marks)', [
    [
        'type' => 'prose',
        'html' => '<p>Your CAPS prepared speech is Task 9, worth 10 marks of your Paper 4 orals, and runs four to five minutes. A CAPS oral rubric rewards content and research, structure, language and register, and delivery - so the script has to give you all of that to work with.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w105CapsScript',
        'markMax'      => 10,
        'showRubric'   => true,
        'prompt'       => '<p class="prompt-setup">You will give a prepared speech of four to five minutes to your Grade 10 class on a topic with substance (choose your own, or use: "Our school should switch off class group chats at 9 p.m.").</p><p class="prompt-ask">Write the script for the opening and your first main point: about 250 to 300 words, written to be heard.</p><ul><li>Start with a hook and state your purpose.</li><li>Signpost your first point out loud, and support it with an example or a fact you found.</li><li>Write for a listener: short sentences, direct address ("you"), one or two places marked [PAUSE].</li></ul>',
        'rubric'       => "Content and research (4 marks)\n- 4: a topic that matters, a clear purpose and a convincing first point backed by a researched fact or strong example\n- 3: a clear purpose and a sound point with an example\n- 2: a topic and a point, but thin or vague\n- 0-1: no clear purpose\n\nStructure (3 marks)\n- 3: a hook that grabs attention, a stated purpose and a spoken signpost\n- 2: two of these three\n- 0-1: reads like an essay, not a speech\n\nLanguage and register (3 marks)\n- 3: short, varied sentences, direct address, pauses marked, a register that suits a class audience\n- 2: mostly suited to speaking, with some long or stiff sentences\n- 0-1: hard to say aloud, or slang throughout",
        'markerRubric' => "CAPS Grade 10 prepared speech script (opening + first point, 250-300 words), out of 10. Content and research (4): topic with substance, purpose explicit ('I want you to...'), first point developed with a concrete example or researched fact (credit a plausible fact; do not check figures). Structure (3): hook in the first lines (question, fact, anecdote), purpose stated, a spoken signpost ('My first reason...'). Language and register (3): written for the ear - short sentences, 'you', rhetorical questions or repetition, [PAUSE] marked, a register suited to a class audience (no slang). Do not penalise the choice of topic. Feedback: the band for each area and one change that would help it sound better aloud.",
        'points'       => [
            ['marks' => 2, 'any' => ['the topic has substance and the purpose of the speech is stated clearly']],
            ['marks' => 2, 'any' => ['the first main point is supported by a concrete example or a fact']],
            ['marks' => 2, 'any' => ['the script opens with a hook such as a question, a surprising fact or a short story']],
            ['marks' => 1, 'any' => ['the first point is signposted out loud, for example my first reason']],
            ['marks' => 3, 'any' => ['the language is written to be heard: short sentences, direct address and pauses marked']],
        ],
    ],
]),

...BoardSection ('ieb', 'IEB: write the script (20 marks)', [
    [
        'type' => 'prose',
        'html' => '<p>Your IEB prepared speech is worth 20 of your 100 oral marks and may last no more than five minutes. The IEB wants a meaningful topic with substance, a formal register, and a speaker who talks to the audience, not at them. The script is where the substance and the register are built; the delivery comes when you cut it to cue cards.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w105IebScript',
        'markMax'      => 20,
        'showRubric'   => true,
        'prompt'       => '<p class="prompt-setup">You will give a prepared speech of no more than five minutes to your Grade 10 class on a meaningful topic with substance (choose your own, or use: "Our school should switch off class group chats at 9 p.m.").</p><p class="prompt-ask">Write the script for the opening and your first main point: about 300 to 350 words, written to be heard.</p><ul><li>Open with a hook and make your position or purpose clear.</li><li>Develop your first point with depth: an example, a reason and what it means for your audience.</li><li>Keep a formal register while speaking directly to your listeners; mark one or two [PAUSE] places.</li></ul>',
        'rubric'       => "Content and substance (8 marks)\n- 7-8: a meaningful topic, a clear position, and a first point developed with real depth and insight\n- 5-6: a clear position and a sound, developed point\n- 3-4: a point that is stated but thin or general\n- 0-2: no clear purpose or substance\n\nStructure for a listener (6 marks)\n- 5-6: a compelling hook, a clear purpose and a spoken signpost that guide the listener\n- 3-4: a clear opening, but one element is weak\n- 0-2: reads like an essay, not a speech\n\nLanguage and register (6 marks)\n- 5-6: a formal but engaging register, varied sentences built for the ear, direct address, pauses marked\n- 3-4: mostly formal and speakable, with lapses\n- 0-2: too casual, or too stiff to say aloud",
        'markerRubric' => "IEB Grade 10 prepared speech script (opening + first point, 300-350 words), out of 20, judged holistically per area. Content and substance (8): a meaningful topic (not trivial), a clear position or purpose, and a first point developed beyond assertion - example, reasoning and its significance for the audience; reward insight. Structure (6): a hook that earns attention, purpose made clear early, a spoken signpost. Language and register (6): a formal register (no slang) that still speaks to the audience ('you', rhetorical questions), sentences built for the ear, [PAUSE] marked. Do not penalise the choice of topic. Feedback: the level for each area in IEB terms and one change that would lift the script to the next level.",
        'points'       => [
            ['marks' => 3, 'any' => ['the topic is meaningful and the position or purpose of the speech is clear']],
            ['marks' => 5, 'any' => ['the first point is developed with depth: an example, a reason and why it matters to the audience']],
            ['marks' => 3, 'any' => ['the script opens with a hook such as a question, a striking fact or a short story']],
            ['marks' => 3, 'any' => ['the first point is signposted out loud']],
            ['marks' => 6, 'any' => ['the register is formal but speaks directly to the audience, with sentences written to be heard and pauses marked']],
        ],
    ],
]),
[
    'type'   => 'prose',
    'html'   => <<<'HTML'
<p>Now turn your script into cue cards, and record yourself giving it - a phone propped against a pile of
books is enough. Watch it once with the sound off (what does your body do?) and once with your eyes closed
(how does your voice sound?). Then mark yourself the way your teacher will, using your board's marks
below.</p>
HTML,
],

...BoardSection ('caps', 'CAPS: check your recording (out of 10)', [
    [
        'type' => 'prose',
        'html' => <<<'HTML'
<p>The CAPS prepared speech is worth <strong>10 marks</strong> (Task 9, part of your Paper 4 orals). Your
teacher marks your real speech on the school's rubric. To check your recording, use this course
checklist, which looks at the same things:</p>
<ul>
<li><strong>Content</strong> (3): a topic with substance, a clear purpose, points backed by examples.</li>
<li><strong>Structure</strong> (2): hook, purpose, signposted points, a strong ending.</li>
<li><strong>Delivery</strong> (3): eye contact, pace, pauses, projection.</li>
<li><strong>Language and cue cards</strong> (2): a suitable register; cards used as reminders, not read.</li>
</ul>
HTML,
    ],
    [
        'type'         => 'written',
        'id'           => 'w105CapsSelf',
        'markMax'      => 4,
        'prompt'       => '<p class="prompt-setup">Watch your recording and score it on the four areas of the CAPS checklist above (out of 3, 2, 3 and 2).</p><p class="prompt-ask">Write your score for each area with one piece of evidence from your recording, then name the ONE change that would raise your mark most.</p>',
        'rubric'       => "- 1 mark: a score for each of the four areas\n- 1 mark: evidence from the recording for the scores\n- 1 mark: the scores are honest and match the evidence\n- 1 mark: one specific, practical change",
        'markerRubric' => "Self-assessment, not the speech itself. 1: all four areas scored within their maxima (content /3, structure /2, delivery /3, language and cue cards /2). 1: each score backed by something observable ('I looked down for most of point 2', 'I signposted all three points'). 1: scores consistent with the evidence given (not full marks with problems described). 1: one specific change ('pause after my statistic', 'cut card 3 to keywords') - not 'be more confident'.",
        'points'       => [
            ['marks' => 1, 'any' => ['a score is given for content, structure, delivery and language and cue cards']],
            ['marks' => 1, 'any' => ['each score is backed by something seen or heard in the recording']],
            ['marks' => 1, 'any' => ['the scores match the evidence and are honest']],
            ['marks' => 1, 'any' => ['one specific, practical change is named, such as pausing after the statistic or cutting a card to keywords']],
        ],
    ],
]),

...BoardSection ('ieb', 'IEB: check your recording (out of 20)', [
    [
        'type' => 'prose',
        'html' => <<<'HTML'
<p>The IEB prepared speech is worth <strong>20 marks</strong> of your 100-mark oral, and it may last no more
than five minutes. Your teacher marks the real speech on the IEB rubric, which places it on one of seven
levels. To check your recording, use this course checklist of the same areas:</p>
<ul>
<li><strong>Content and substance</strong> (6): a meaningful topic, a clear purpose, depth and examples.</li>
<li><strong>Structure</strong> (4): a hook, a clear route through the points, an ending that lands.</li>
<li><strong>Delivery and audience contact</strong> (6): talking to the audience, not at them; eye contact, pace, pause, voice.</li>
<li><strong>Language and register</strong> (4): a formal register; cue cards only, never read from a text.</li>
</ul>
HTML,
    ],
    [
        'type'         => 'written',
        'id'           => 'w105IebSelf',
        'markMax'      => 4,
        'prompt'       => '<p class="prompt-setup">Watch your recording and score it on the four areas of the IEB checklist above (out of 6, 4, 6 and 4).</p><p class="prompt-ask">Write your score for each area with one piece of evidence from your recording, then name the ONE change that would raise your mark most.</p>',
        'rubric'       => "- 1 mark: a score for each of the four areas\n- 1 mark: evidence from the recording for the scores\n- 1 mark: the scores are honest and match the evidence\n- 1 mark: one specific, practical change",
        'markerRubric' => "Self-assessment, not the speech itself. 1: all four areas scored within their maxima (content /6, structure /4, delivery and audience contact /6, language and register /4). 1: each score backed by something observable. 1: scores consistent with the evidence. 1: one specific change ('look at the left side of the room too', 'cut the script lines from card 2') - not 'be more confident'. Mention the 5-minute limit if the pupil says the recording ran over.",
        'points'       => [
            ['marks' => 1, 'any' => ['a score is given for content, structure, delivery and audience contact, and language and register']],
            ['marks' => 1, 'any' => ['each score is backed by something seen or heard in the recording']],
            ['marks' => 1, 'any' => ['the scores match the evidence and are honest']],
            ['marks' => 1, 'any' => ['one specific, practical change is named, such as looking at the whole room or cutting a card to keywords']],
        ],
    ],
]),

[
    'type'   => 'prose',
    'title'  => 'Next time',
    'html'   => <<<'HTML'
<p>Practise the whole speech at least three times aloud before the day - once to the mirror, once to
someone at home, once timed. Next: the rehearsal lesson, where you record, review and record again.</p>
HTML,
],

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'The prepared speech.',
    'sections' => [
        [
            'heading' => 'Preparing',
            'points'  => [
                'A topic with **substance**, and a **purpose** you can state: "I want my audience to...".',
                'Shape: **hook**, **purpose**, three signposted **points** with examples, summary, memorable **last line**.',
                'Length: 4-5 minutes (CAPS); at most 5 minutes (IEB). At about 130 words a minute, 4 minutes is about 520 words.',
            ],
        ],
        [
            'heading' => 'Cue cards and delivery',
            'points'  => [
                '**Cue cards**: one point per card, numbered, keywords only; quotations and numbers in full; delivery notes.',
                'Never read a written speech - it is heavily penalised.',
                'Talk **to** the audience: eye contact, slow pace, pauses, projection, emphasis, steady stance.',
                'Marks: CAPS prepared speech 10; IEB prepared speech 20.',
            ],
        ],
    ],
    'keyTerms' => [
        'cue card'   => 'A small card with keyword notes that reminds a speaker of the next point.',
        'hook'       => 'An opening that grabs the audience\'s attention.',
        'signpost'   => 'Words that tell listeners where the speech is going, such as "my second reason".',
        'projection' => 'Speaking loudly and clearly enough for everyone in the room to hear.',
    ],
],

];
