<?php
/**
 * Lesson 34 : Romeo and Juliet, reading guide 1 - the Prologue (shown in
 * full) and Act 1, scene by scene: the feud, Rosaline, Paris's offer, the
 * Nurse, Queen Mab and the feast, ending with the shared sonnet and the
 * discovery. Then a short literary-essay paragraph, and each board's practice
 * (CAPS contextual questions on an extract; IEB a critical view to agree or
 * disagree with). About 30 minutes.
 * Literature strand, text:romeo-juliet; the play's own look (a Verona fresco);
 * Ratel helps with evidence, Quill with the paragraph. Term 1 drama unit
 * Part 1 (CAPS ref §1.3: plot, dialogue, the sonnet in 1.5). Prepares CAPS P2
 * Sec C; IEB P2 Q1.
 * The play is public domain (Shakespeare, d. 1616); quotations follow the
 * public-domain Project Gutenberg / MIT texts, glosses are our own. The
 * "critical view" in the IEB section is written for the course and labelled
 * as such (plan: never invent attributions).
 * English Home Language Grade 10 (AIResources/English/eng10-lessons.md).
 * Sample lesson, written 11 October 2026. Not progress gated (Chris, 11 October 2026).
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => DesignFigure ('eng10-open-rj', 'Romeo and Juliet, reading guide 1: the Prologue and Act 1.')
    . <<<'HTML'
<p>Imagine a film that starts by telling you exactly how it ends: two teenagers fall in love, and both of
them die. Would you still watch? Shakespeare bet that you would - and four hundred years later, people
still do.</p>
<p>This lesson takes you through the <strong>Prologue</strong> and <strong>Act 1</strong> of
<strong><em>Romeo and Juliet</em></strong>, scene by scene. Read the act in your own copy of the play
alongside it. By the end you will know who is who, what happens at the Capulets' feast, and why the
Prologue gives the ending away on purpose.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'This lesson has five parts:',
    'items' => [
        ['anchor' => 'prologue',  'label' => 'The Prologue',       'note' => 'fourteen lines, the whole plot'],
        ['anchor' => 'who',       'label' => 'Who is who',         'note' => 'two houses and a city'],
        ['anchor' => 'act1',      'label' => 'Act 1, scene by scene', 'note' => 'from the brawl to the feast'],
        ['anchor' => 'sonnet',    'label' => 'The meeting',        'note' => 'a sonnet for two voices'],
        ['anchor' => 'paragraph', 'label' => 'Your paragraph',     'note' => 'and the board practice'],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'prologue',
    'title'  => 'The Prologue: the whole plot in fourteen lines',
    'html'   => MarginNote ('Shakespeare did not invent the story. He took it from a long English poem by Arthur Brooke, printed in 1562 - and made the lovers younger and the action faster.')
    . <<<'HTML'
<p>Before the play begins, an actor called the Chorus steps out and speaks a
HTML
    . ' ' . Gloss ('sonnet', 'A poem of fourteen lines with a fixed rhyme pattern. A Shakespearean sonnet has three groups of four lines and a rhyming couplet at the end.')
    . <<<'HTML'
 to the audience:</p>
<div class="poem">
<p>Two households, both alike in dignity,<br>
In fair Verona, where we lay our scene,<br>
From ancient grudge break to new mutiny,<br>
Where civil blood makes civil hands unclean.<br>
From forth the fatal loins of these two foes<br>
A pair of star-cross'd lovers take their life;<br>
Whose misadventured piteous overthrows<br>
Do with their death bury their parents' strife.<br>
The fearful passage of their death-mark'd love,<br>
And the continuance of their parents' rage,<br>
Which, but their children's end, nought could remove,<br>
Is now the two hours' traffic of our stage;<br>
The which if you with patient ears attend,<br>
What here shall miss, our toil shall strive to mend.</p>
</div>
<p>In plain words: two equally important families in Verona have an old feud, and it has broken out
again. A child from each family - two lovers doomed by the stars - will die, and only their deaths
will end their parents' hatred. The play will take about two hours.</p>
<p>A <strong>star-crossed</strong> lover is one whose stars - their fate - are against them. In
Shakespeare's time many people believed the position of the stars at your birth shaped your life.</p>
HTML,
],

[
    'type'    => 'quiz',
    'id'      => 'q34Prologue',
    'marks'   => 1,
    'prompt'  => 'Read the Prologue again.' . "\n\n" . 'What does the Prologue tell the audience before the play begins?',
    'options' => [
        'a' => 'The lovers will die, and their deaths will end the feud.',
        'b' => 'The lovers will run away and live happily far from Verona.',
        'c' => 'The Prince will end the feud by punishing both families.',
        'd' => 'Only Romeo will die; Juliet will marry Paris.',
    ],
    'answer'  => 'a',
    'why'     => [
        'b' => 'Read line 8: "Do with their death bury their parents\' strife."',
        'c' => 'Line 11 says only one thing could remove the parents\' rage. What is it?',
        'd' => 'The Prologue speaks of "their death" - whose?',
    ],
    'explain' => 'The lovers "take their life" from the two families and "with their death bury their parents\' strife". Line 11 adds that nothing "but their children\'s end" could stop the rage.',
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't34StarCrossed',
    'marks'   => 1,
    'prompt'  => 'Line 6 of the Prologue uses a two-part word that means "doomed by fate, unlucky in the stars".' . "\n\n" . 'Write that word.',
    'answer'  => ['star-cross\'d', 'star-crossed', 'starcrossed', 'star crossed', 'star-cross’d'],
    'explain' => '<strong>Star-cross\'d</strong> (star-crossed): their stars - their fate - are crossed against them. The word has been used for unlucky lovers ever since.',
],

[
    'type'     => 'reveal',
    'id'       => 'rv34Spoiler',
    'prompt'   => '<p>Why would Shakespeare give the ending away before the play starts? Think about what it does to an audience watching the lovers meet, knowing what you know. Say it in your own words, then check.</p>',
    'ownWords' => [
        'the audience knows the ending, so they watch how and why it happens rather than what happens',
        'knowing they will die creates tension, dread or sadness at every happy or hasty moment',
    ],
    'hints'    => [
        'If you know the ending, what question is left to watch for?',
        'How does a happy scene feel when you know how the story ends?',
    ],
    'explain'  => '<p>Giving the ending away creates '
    . Gloss ('dramatic irony', 'When the audience knows something a character does not, so the character\'s words or actions mean more to us than to them.')
    . '. The audience stops asking <em>what</em> will happen and watches <em>how</em> and <em>why</em> it happens. Every happy moment hurts a little, because we know where it leads. When Romeo and Juliet make plans for the future, we feel the dread they cannot.</p>',
],

[
    'type'   => 'prose',
    'anchor' => 'who',
    'title'  => 'Who is who',
    'html'   => <<<'HTML'
<p>Act 1 throws a lot of names at you fast. Most belong to one of two houses - the Montagues and the
Capulets - and the rest to Verona itself, ruled by its Prince. Keep this map open while you read.</p>
HTML
    . DesignFigure ('eng10-rj-houses', 'Two houses and a city: who belongs where in Romeo and Juliet.'),
],

[
    'type'   => 'prose',
    'anchor' => 'act1',
    'title'  => 'Act 1, scene by scene',
    'html'   => Doodle ('eng10-joke-rj', 'Ratel gave the Prologue one star. Well - two, crossed.')
    . <<<'HTML'
<p><strong>Scene 1: a street brawl.</strong> Two Capulet servants, Sampson and Gregory, pick a fight with
two Montague servants by biting a thumb at them (a rude gesture). Benvolio, a Montague, tries to keep the
peace; Tybalt, a Capulet, arrives spoiling for a fight: "What, drawn, and talk of peace! I hate the word,
/ As I hate hell, all Montagues, and thee." Citizens join in, then the heads of both families. Prince
Escalus stops the riot with a warning: "If ever you disturb our streets again, / Your lives shall pay the
forfeit of the peace." Afterwards we meet Romeo - not at the fight, but moping, in love with a girl called
Rosaline who will not love him back. He speaks in contradictions, each one an
HTML
    . ' ' . Gloss ('oxymoron', 'Two words with opposite meanings put side by side, such as "loving hate".')
    . <<<'HTML'
: "O brawling love! O loving hate!"</p>
<p><strong>Scene 2: an offer for Juliet.</strong> Count Paris asks Lord Capulet for his daughter's hand.
Capulet says she is too young - "My child is yet a stranger in the world; / She hath not seen the change
of fourteen years" - but invites Paris to woo her at his feast that night. A servant who cannot read
asks Romeo for help with the guest list; Benvolio persuades Romeo to go to the feast in a mask, so he can
compare Rosaline with other beauties.</p>
<p><strong>Scene 3: Juliet, her mother and the Nurse.</strong> Lady Capulet tells Juliet that Paris wants
to marry her. The Nurse, who raised Juliet, chatters about Juliet as a baby. Juliet answers carefully:
"It is an honour that I dream not of," and agrees only to look at Paris.</p>
<p><strong>Scene 4: on the way to the feast.</strong> Romeo's witty friend Mercutio teases him with a long,
wild speech about Queen Mab, a tiny fairy who brings people dreams. But Romeo feels uneasy: "my mind
misgives / Some consequence yet hanging in the stars" - he fears that tonight will start something that
ends in his death.</p>
<p><strong>Scene 5: the feast.</strong> Romeo sees Juliet and forgets Rosaline at once: "O, she doth teach
the torches to burn bright!" Tybalt recognises Romeo's voice and wants to fight him, but Capulet orders
him to leave Romeo alone. Romeo and Juliet meet, talk and kiss. Only afterwards does each learn who the
other is. Juliet: "My only love sprung from my only hate! / Too early seen unknown, and known too late!"</p>
HTML,
],

[
    'type'    => 'order',
    'id'      => 'o34Events',
    'marks'   => 1,
    'prompt'  => 'Put these events of Act 1 in the order they happen.',
    'items'   => [
        'Servants of the two houses start a brawl in the street',
        'The Prince warns that the next fight will be punished by death',
        'Paris asks Capulet if he may marry Juliet',
        'Benvolio persuades Romeo to go to the Capulets\' feast',
        'Mercutio teases Romeo with the Queen Mab speech',
        'Tybalt recognises Romeo at the feast',
        'Juliet learns that Romeo is a Montague',
    ],
    'why'     => 'The street, the offer, the walk to the feast, then the feast itself - scenes 1 to 5.',
    'explain' => 'Scene 1: the brawl and the Prince\'s warning. Scene 2: Paris\'s offer and the invitation. Scene 4: Queen Mab. Scene 5: Tybalt, then the discovery.',
],

[
    'type'    => 'match',
    'id'      => 'm34WhoSaid',
    'marks'   => 1,
    'prompt'  => 'Who said it? Match each line to its speaker.',
    'pairs'   => [
        '"I hate the word, / As I hate hell, all Montagues, and thee."' => 'Tybalt',
        '"Your lives shall pay the forfeit of the peace."'              => 'Prince Escalus',
        '"It is an honour that I dream not of."'                        => 'Juliet',
        '"O, she doth teach the torches to burn bright!"'                => 'Romeo',
    ],
    'explain' => 'Tybalt hates peace and Montagues; the Prince threatens death for the next brawl; Juliet answers her mother about marriage; Romeo sees Juliet for the first time.',
],

[
    'type'   => 'prose',
    'anchor' => 'sonnet',
    'title'  => 'The meeting: a sonnet for two voices',
    'html'   => MarginNote ('In Shakespeare\'s theatre every part was played by a man or a boy. The first Juliet was a boy actor, probably a teenager himself.')
    . <<<'HTML'
<p>When Romeo and Juliet first speak, their lines rhyme together and make a sonnet - the same form as the
Prologue, now shared by two people. It begins:</p>
<div class="poem">
<p>ROMEO: If I profane with my unworthiest hand<br>
This holy shrine, the gentle sin is this:<br>
My lips, two blushing pilgrims, ready stand<br>
To smooth that rough touch with a tender kiss.</p>
<p>JULIET: Good pilgrim, you do wrong your hand too much,<br>
Which mannerly devotion shows in this;<br>
For saints have hands that pilgrims' hands do touch,<br>
And palm to palm is holy palmers' kiss.</p>
</div>
<p>Romeo plays the part of a pilgrim visiting a holy statue (Juliet's hand). Juliet plays along, and
quietly teases him: pilgrims touch hands with saints, so a handshake is kiss enough. It is flirting, in
the language of worship.</p>
HTML,
],

[
    'type'     => 'markwords',
    'id'       => 'mw34Religion',
    'language' => 'text',
    'marks'    => 1,
    'prompt'   => 'Romeo borrows words from religion to speak about Juliet. Mark the FIVE words in his four lines that come from the language of religion or worship.',
    'code'     => "If I [[profane]] with my unworthiest hand\nThis [[holy]] [[shrine]], the gentle [[sin]] is this:\nMy lips, two blushing [[pilgrims]], ready stand\nTo smooth that rough touch with a tender kiss.",
    'why'      => [
        'missed' => 'Look for words you might hear in a church, a temple or a story about saints.',
        'wrong'  => '"Kiss", "hand" and "lips" are about the body, not about worship.',
    ],
    'explain'  => '<strong>Profane</strong> (to treat something holy without respect), <strong>holy</strong>, <strong>shrine</strong>, <strong>sin</strong> and <strong>pilgrims</strong>. Speaking of Juliet as a saint makes his love sound pure and worshipful - and makes the kiss a "gentle sin".',
],

[
    'type'   => 'prose',
    'anchor' => 'paragraph',
    'title'  => 'Your paragraph',
    'html'   => <<<'HTML'
<p>A literary essay is built from paragraphs like the one you will write now. Each one makes a single
point and proves it. Use four moves - <strong>P</strong>oint, <strong>Q</strong>uote,
<strong>E</strong>xplain, <strong>L</strong>ink:</p>
<ul>
<li><strong>Point</strong>: one sentence that answers the topic.</li>
<li><strong>Quote</strong>: a few words from the play, woven into your own sentence.</li>
<li><strong>Explain</strong>: what the words show, and how.</li>
<li><strong>Link</strong>: tie it back to the topic in your last sentence.</li>
</ul>
<p>Write about the play in the present tense ("Romeo says", not "Romeo said"), and keep quotations short.</p>
HTML,
],

[
    'type'         => 'written',
    'id'           => 'w34Paragraph',
    'markMax'      => 8,
    'prompt'       => '<p class="prompt-setup">Topic: "In Act 1, Shakespeare shows that love and hate are tangled together from the very start."</p><p class="prompt-ask">Write ONE analytical paragraph (about 120 to 150 words) that responds to this topic.</p><ul><li>Open with a point that answers the topic directly.</li><li>Support it with at least two short quotations from the Prologue or Act 1, woven into your sentences.</li><li>Explain how each quotation shows love and hate tangled together.</li><li>End by linking back to the topic. Use the present tense.</li></ul>',
    'rubric'       => "- 2 marks: a clear point that answers the topic\n- 2 marks: at least two short, well-chosen quotations woven into sentences\n- 2 marks: explanation of how the quotations show love and hate tangled together\n- 2 marks: a closing link to the topic, in the present tense and a formal register",
    'markerRubric' => "Point (2): answers the topic directly (2); vague or only retells (1). Quotations (2): two or more short, accurate, embedded quotations (2); one, or long/dropped-in quotations (1). Useful: \"O brawling love! O loving hate!\" (oxymorons), \"My only love sprung from my only hate!\", \"star-cross'd lovers\" born from \"fatal loins of these two foes\", \"death-mark'd love\", the feast where Tybalt wants to fight while Romeo falls in love. Explanation (2): shows how love and hate are mixed - Romeo's oxymorons, the lovers come from hate, love found at an enemy's house, Tybalt's anger in the same scene as the kiss (2); explanation only partly linked (1). Link and style (2): ends by tying back to the topic, present tense, formal (2); one of these missing (1). Do not penalise a stance that partly disagrees if argued.",
    'points'       => [
        ['marks' => 2, 'any' => ['the paragraph opens with a clear point that answers the topic about love and hate being tangled together']],
        ['marks' => 2, 'any' => ['at least two short quotations from the Prologue or Act 1 are woven into the sentences']],
        ['marks' => 2, 'any' => ['it explains how the quotations mix love and hate, for example Romeo\'s oxymorons or Juliet\'s my only love sprung from my only hate']],
        ['marks' => 2, 'any' => ['it ends by linking back to the topic, written in the present tense and a formal register']],
    ],
],

...BoardSection ('caps', 'CAPS: contextual questions on an extract', [
    [
        'type' => 'prose',
        'html' => <<<'HTML'
<p>CAPS Paper 2 gives you an extract from the play and short questions on it. Read this one from Act 1,
Scene 5, then answer.</p>
<div class="poem">
<p>TYBALT: This, by his voice, should be a Montague.<br>
Fetch me my rapier, boy. [...]<br>
CAPULET: Content thee, gentle coz, let him alone;<br>
He bears him like a portly gentleman;<br>
And, to say truth, Verona brags of him<br>
To be a virtuous and well-govern'd youth:<br>
I would not for the wealth of all the town<br>
Here in my house do him disparagement: [...]<br>
TYBALT: I will withdraw: but this intrusion shall<br>
Now seeming sweet convert to bitter gall.</p>
</div>
HTML,
    ],
    [
        'type'         => 'written',
        'id'           => 'w34CapsTybalt',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Refer to Tybalt\'s first two lines.</p><p class="prompt-ask">Explain why Tybalt is so angry when he recognises Romeo. (2)</p>',
        'rubric'       => "- 1 mark: who Romeo is to Tybalt\n- 1 mark: why his being here is an insult",
        'markerRubric' => "1 mark: Romeo is a Montague, the Capulets' enemy (Tybalt hates all Montagues). 1 mark: he has come uninvited, in a mask, to the Capulet feast - Tybalt sees it as mocking or insulting the family.",
        'points'       => [
            ['marks' => 1, 'any' => ['Romeo is a Montague, an enemy of the Capulets']],
            ['marks' => 1, 'any' => ['he has come uninvited and masked to the Capulet feast, which Tybalt sees as an insult']],
        ],
    ],
    [
        'type'         => 'written',
        'id'           => 'w34CapsGall',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Refer to Tybalt\'s last two lines: "this intrusion shall / Now seeming sweet convert to bitter gall."</p><p class="prompt-ask">What do these lines suggest might happen later in the play? Refer to the Prologue in your answer. (2)</p>',
        'rubric'       => "- 1 mark: what Tybalt threatens\n- 1 mark: a link to what the Prologue has told us",
        'markerRubric' => "1 mark: Tybalt will take revenge / the sweetness of tonight will turn to bitterness - violence will follow. 1 mark: the Prologue has said the feud breaks out again ('new mutiny') and the lovers will die, so his threat warns of the deaths to come (foreshadowing).",
        'points'       => [
            ['marks' => 1, 'any' => ['Tybalt means to take revenge, so tonight\'s sweetness will turn to bitterness and violence']],
            ['marks' => 1, 'any' => ['the Prologue says the feud will break out again and the lovers will die, so the lines foreshadow the deaths to come']],
        ],
    ],
]),

...BoardSection ('ieb', 'IEB: answering a critical view', [
    [
        'type' => 'prose',
        'html' => '<p>The IEB Shakespeare question is an essay that responds to a critic\'s statement. You agree, disagree or - often best - agree only partly, and prove it from the play. The statement below is written for this course, as a "critical view" to practise on.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w34IebView',
        'markMax'      => 4,
        'prompt'       => '<p class="prompt-setup">A critical view (written for this course): "In Act 1, Romeo is in love with love, not with Juliet."</p><p class="prompt-ask">To what extent do you agree with this view? Write a short response of about 80 to 100 words.</p><ul><li>State your position in the first sentence.</li><li>Use evidence from both Scene 1 (Rosaline) and Scene 5 (Juliet).</li><li>Weigh both sides before you end.</li></ul>',
        'rubric'       => "- 1 mark: a clear position\n- 1 mark: evidence from Scene 1\n- 1 mark: evidence from Scene 5\n- 1 mark: both sides weighed in a judgement",
        'markerRubric' => "Relational answer links position, evidence and judgement. For the view: in 1.1 Romeo is lovesick over Rosaline and speaks in clichéd oxymorons (\"O brawling love! O loving hate!\"); in 1.5 he forgets her the moment he sees Juliet (\"O, she doth teach the torches to burn bright!\") - fickle, in love with being in love. Against: with Juliet he speaks in a shared sonnet, she answers him, the love is returned; his language changes from complaint to wonder. Accept agree, disagree or partly agree if supported from both scenes. Cap at 2 if only one scene is used.",
        'points'       => [
            ['marks' => 1, 'any' => ['a clear position of agreeing, disagreeing or partly agreeing is stated at the start']],
            ['marks' => 1, 'any' => ['in Scene 1 Romeo is lovesick over Rosaline and speaks in oxymorons such as O brawling love']],
            ['marks' => 1, 'any' => ['in Scene 5 he forgets Rosaline at once when he sees Juliet, or he shares a sonnet with Juliet who loves him back']],
            ['marks' => 1, 'any' => ['both sides are weighed: he seems fickle, yet the love for Juliet is returned and his language changes']],
        ],
    ],
]),

[
    'type'   => 'prose',
    'title'  => 'Next time',
    'html'   => <<<'HTML'
<p>Act 1 ends with a love that is "too early seen unknown, and known too late". In Act 2 Romeo climbs a
wall into the Capulets' orchard, and Juliet comes out onto her balcony, not knowing he can hear every
word.</p>
HTML,
],

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'Romeo and Juliet: the Prologue and Act 1.',
    'sections' => [
        [
            'heading' => 'The Prologue',
            'points'  => [
                'A **sonnet** spoken by the Chorus: two families, an ancient grudge, two **star-crossed** lovers whose deaths end the feud.',
                'Telling the ending creates **dramatic irony**: we watch how and why, and every happy moment carries dread.',
            ],
        ],
        [
            'heading' => 'Act 1',
            'points'  => [
                'Scene 1: the street brawl; Tybalt "I hate the word" (peace); the Prince threatens death; Romeo pines for Rosaline in **oxymorons**.',
                'Scene 2: Paris asks for Juliet; Capulet says she is not yet fourteen; Romeo is persuaded to go to the feast.',
                'Scene 3: Lady Capulet and the Nurse raise marriage; Juliet: "It is an honour that I dream not of."',
                'Scene 4: Mercutio\'s Queen Mab speech; Romeo fears "some consequence yet hanging in the stars".',
                'Scene 5: Romeo sees Juliet; Tybalt is held back by Capulet; the shared sonnet; "My only love sprung from my only hate!"',
            ],
        ],
        [
            'heading' => 'Writing about it',
            'points'  => [
                'A literary paragraph: **Point, Quote, Explain, Link**. Present tense; short quotations woven in.',
            ],
        ],
    ],
    'keyTerms' => [
        'prologue'       => 'An opening speech before the action of a play begins.',
        'star-crossed'   => 'Doomed by fate; unlucky, as if the stars were against you.',
        'dramatic irony' => 'When the audience knows something a character does not.',
        'oxymoron'       => 'Two opposite words put side by side, such as "loving hate".',
    ],
],

];
