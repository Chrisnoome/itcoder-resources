<?php
/**
 * Lesson 15 : Reading for tone, diction and the writer's intention - a feature
 * post on a made-up short-video app (Text A, about 550 words) and an in-app
 * advert (Text B), with questions on tone, diction, intention and one
 * cross-text question, in both boards' styles. About 30 minutes.
 * Language strand, L1 Tracing overlay, Ratel. Term 1 (ATP T1 R&V; CAPS ref
 * §1.3 critical language awareness; IEB SAG §1.4 Q1). Prepares CAPS Task 4 and
 * P1 Q1; IEB P1 Q1.
 * English Home Language Grade 10 (AIResources/English/eng10-lessons.md).
 * Sample lesson, written 11 October 2026. Not progress gated (Chris, 11
 * October 2026: "lessons are not progress gated").
 * Texts A and B are written for the course: the apps (Spill, Hush), the
 * account and the people are made up.
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => DesignFigure ('eng10-open-tone', 'Language: reading for tone, diction and intention.')
    . <<<'HTML'
<p>Somebody posts "Great job, genius" under your video. Is that praise? You don't need a dictionary to
answer. You hear the <em>way</em> it is said. That way of saying things is <strong>tone</strong>, and you
read it all day long without trying.</p>
<p>In an exam you have to do it on purpose, slowly, and prove it with words from the text. This lesson
gives you the three tools every comprehension paper asks for: <strong>tone</strong>,
<strong>diction</strong> and the writer's <strong>intention</strong>. You will use them on a post from
a short-video app and an advert that answers it.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'This lesson has five parts:',
    'items' => [
        ['anchor' => 'texta',     'label' => 'Text A',                 'note' => 'a post on Spill'],
        ['anchor' => 'tone',      'label' => 'Tone',                   'note' => 'how it sounds'],
        ['anchor' => 'diction',   'label' => 'Diction',                'note' => 'the words chosen'],
        ['anchor' => 'intention', 'label' => 'Intention',              'note' => 'what the writer wants'],
        ['anchor' => 'textb',     'label' => 'Text B and both texts',  'note' => 'the cross-text question'],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'texta',
    'title'  => 'Text A: a post on Spill',
    'html'   => MarginNote ('Read the whole text once before you look at a single question. Then read each question, and go back to the paragraph it names. The paragraph numbers are there to save you time.', 'Examiner\'s eye')
    . <<<'HTML'
<p>Read Text A once, all the way through. It was posted on the Discover page of <strong>Spill</strong>, a
short-video app. (Spill, the account and everyone in it are made up for this course.)</p>
<p><strong>Five seconds? Try five hours.</strong><br>by @kaya.makes</p>
<ol class="text-paragraphs">
<li>Breaking news, apparently: my generation's brains have melted. A parenting account with 400 000
followers says so, in a video that is - wait for it - forty seconds long. We can't read a book, can't sit
through a film, can't finish a sentence without checking our phones. Teenagers, the post says, now have
"the attention span of a goldfish". Poor goldfish. Nobody asked it.</li>
<li>I'm sixteen. I have spent more hours on short-video apps than I'd like my mother to know. I am also the person who once watched a three-hour film about penguins
without blinking. So let me be the goldfish who answers back.</li>
<li>Last month I watched my little brother, Sizwe, spend five hours building a working railway in a
block game. Five hours. He drew plans on the back of a maths worksheet. He failed eleven times and
started again eleven times. When the game crashed and wiped an hour of work, he groaned, ate a sandwich
and rebuilt the bridge from memory. Nobody had to bribe him, nag him or confiscate anything. That isn't a boy
who can't concentrate. That's a boy who can concentrate fiercely on the things he has chosen.</li>
<li>Here is what the panic gets wrong. Attention is not a tank that empties; it is a spotlight that we
point. When adults say we "can't focus", they usually mean we won't focus on what they've chosen for us:
the textbook chapter, the family lunch, the sermon. That's a fair complaint - some of those things
matter - but it is a different complaint. Calling it a disease just lets everyone off the hook.</li>
<li>I'm not saying the apps are innocent. They're not. Every swipe is designed by people who are paid to
keep my thumb moving. The autoplay, the endless feed, the little red dot that screams "something
happened!" - none of that is an accident. Some nights I look up and two hours have vanished like water
down a drain, and I couldn't tell you one thing I watched. That's not a lack of attention. That's
attention being kidnapped and held hostage.</li>
<li>So stop telling us we're broken. Broken things can't fix themselves. Tell us instead how the trap
works, and trust us to climb out. Show us
the autoplay switch. Teach us to turn off the red dots. Explain why the feed never ends. My friends and I tried a "no-scroll Sunday" last term. The first hour
was horrible - I kept reaching for a phone that was locked in a drawer, like a smoker reaching for a
cigarette. By the afternoon I had read ninety pages of a novel. Ninety. The goldfish was swimming
laps.</li>
<li>Adults, I know you mean well. But every time you call us the "five-second generation", you hand us
an excuse. Why try to read a whole chapter if everyone has already decided you can't? My cousin Lerato says her teacher has stopped
setting whole novels because "you lot won't read them anyway". So she doesn't. Expect less, and
you'll get less.</li>
<li>We're not goldfish. We're more like sprinters who've been given a track with no finish line. Show
us where the line is, and watch what we can do.</li>
</ol>
HTML,
],

[
    'type'   => 'prose',
    'anchor' => 'tone',
    'title'  => 'Tone: how it sounds',
    'html'   => Doodle ('eng10-joke-tone', 'The goldfish asked Ratel for feedback. Ratel said: "Lovely tone. Shame about the circular argument."')
    . <<<'HTML'
<p><strong>Tone</strong> is the writer's attitude, heard in the writing - the voice you would use if you
read it aloud. Tone words are adjectives: <em>mocking, sarcastic, earnest, defiant, bitter, playful,
urgent, pleading, scornful, hopeful</em>. "Happy" and "sad" are too vague to earn marks. Pick the exact
word.</p>
<p>Tone hides in small things: a word like "apparently", a pause made with dashes, a joke that is not
quite a joke. And tone can <strong>change</strong> inside one text. A writer may start by mocking and end
by pleading. When a question asks about tone, it is asking about one paragraph unless it says
otherwise.</p>
HTML,
],

[
    'type'    => 'quiz',
    'id'      => 'q15Tone',
    'marks'   => 1,
    'prompt'  => 'Read paragraph 1 of Text A again.' . "\n\n" . 'Which word best describes the writer\'s tone in paragraph 1?',
    'options' => [
        'a' => 'Mocking',
        'b' => 'Anxious',
        'c' => 'Neutral',
        'd' => 'Admiring',
    ],
    'answer'  => 'a',
    'why'     => [
        'b' => 'Is she worried that the claim is true - or making fun of it? Look at "Poor goldfish."',
        'c' => 'A neutral writer reports without taking sides. Does "wait for it" sound like that?',
        'd' => 'Who would she be admiring? The parenting account she is laughing at?',
    ],
    'explain' => 'The tone is <strong>mocking</strong>. "Apparently" shows she doubts the claim, "wait for it" builds fake suspense, and "Poor goldfish. Nobody asked it." pretends to feel sorry for the fish. All three make fun of the parenting account.',
],

[
    'type'  => 'prose',
    'title' => 'How a marker traces it',
    'html'  => <<<'HTML'
<p>Here is paragraph 1 taken apart. A sheet of tracing paper goes over the text, the clues are outlined and
numbered, and one red line says what they add up to.</p>
HTML
    . DesignFigure ('eng10-trace-tone', 'Paragraph 1 under the tracing sheet: three clues, one tone.'),
],

[
    'type'   => 'prose',
    'title'  => 'Try this: trace the tone of paragraph 5',
    'html'   => <<<'HTML'
<p>Do what the tracing sheet did, for paragraph 5. Work in three steps:</p>
<ul>
<li>Find two or three clues - single words or short phrases - that carry the writer's feeling.</li>
<li>Say in a few words what each clue shows.</li>
<li>Choose ONE exact tone word that all the clues add up to.</li>
</ul>
<p>Jot your answer on paper or in your head before you open the answer below.</p>
HTML,
],

[
    'type'    => 'reveal',
    'prompt'  => '<p>Paragraph 5 starts "I\'m not saying the apps are innocent." What is the tone of this paragraph, and which clues show it?</p>',
    'explain' => <<<'HTML'
<p>The tone has changed. The joking is gone: paragraph 5 is <strong>serious and accusing</strong> (you
could also say <em>indignant</em> or <em>angry</em>).</p>
<ul>
<li>"They're not." - short and blunt, a flat verdict.</li>
<li>"paid to keep my thumb moving" and "none of that is an accident" - she says the apps hook people on purpose.</li>
<li>"kidnapped and held hostage" - crime words that turn the apps into criminals.</li>
</ul>
<p>Notice how much the tone moves in one text: mocking in paragraph 1, accusing in paragraph 5. That is
why tone questions name a paragraph.</p>
HTML,
],

[
    'type'   => 'prose',
    'anchor' => 'diction',
    'title'  => 'Diction: the words chosen',
    'html'   => MarginNote ('Goldfish are not forgetful. In experiments they have learnt to push a lever or swim to a sound for food, and remembered the trick for months.')
    . <<<'HTML'
<p><strong>Diction</strong> means word choice. Every word a writer uses was picked over others that mean
nearly the same. Change one word and the sentence feels different:</p>
<ul>
<li>"Two hours have <em>passed</em>" - just a fact.</li>
<li>"Two hours have <em>vanished</em>" - they were lost, maybe stolen, and she didn't notice.</li>
</ul>
<p>The difference is <strong>connotation</strong>: the feelings and ideas a word carries on top of its
dictionary meaning. "Slim" and "skinny" both mean thin, but one is a compliment and the other often isn't.</p>
<p>A diction question usually asks why the writer chose a word, or what it shows about their attitude.
The answer always has two halves: what the word suggests, and how that fits the writer's point.</p>
HTML,
],

[
    'type'     => 'markwords',
    'id'       => 'mw15Crime',
    'language' => 'text',
    'marks'    => 1,
    'prompt'   => 'In the last sentence of paragraph 5 the writer uses words about crime to describe what the apps do. Mark the TWO crime words.',
    'code'     => "Some nights I look up and two hours have vanished like water down a drain, and I couldn't tell you one thing I watched. That's not a lack of attention. That's attention being [[kidnapped]] and held [[hostage]].",
    'why'      => [
        'missed' => 'Look for the words that describe what a criminal does to a victim.',
        'wrong'  => '"Vanished" is about losing time, not about a crime. Which words would you read in a story about a kidnapping?',
    ],
    'explain'  => '<strong>Kidnapped</strong> and <strong>hostage</strong>. They turn the apps into criminals and the user into a victim. That is the point of paragraph 5: the problem is not that teenagers can\'t concentrate, but that their attention is taken from them.',
],

[
    'type'    => 'typed',
    'kind'    => 'exact',
    'id'      => 't15Ninety',
    'marks'   => 1,
    'prompt'  => 'In paragraph 6 the writer repeats one word on its own, as a whole sentence, to stress how surprised and proud she is.' . "\n\n" . 'Quote that ONE word.',
    'answer'  => ['Ninety', 'Ninety.', '"Ninety"', '"Ninety."'],
    'explain' => '"<strong>Ninety.</strong>" A one-word sentence makes the reader stop, just as the writer stopped in surprise. Paragraph 3 does the same with "Five hours."',
],

[
    'type'   => 'prose',
    'anchor' => 'intention',
    'title'  => 'Intention: what the writer wants',
    'html'   => <<<'HTML'
<p>The writer's <strong>intention</strong> (or purpose) is what the text is trying to <em>do</em> to its
reader: inform, persuade, entertain, warn, criticise, comfort. Most texts do more than one. The question
is which job matters most.</p>
<p>Work it out like a detective:</p>
<ul>
<li><strong>Who is it for?</strong> Who does the writer speak to directly? Look for "you".</li>
<li><strong>What does she want them to think, feel or do</strong> by the last line?</li>
<li><strong>How does she try?</strong> A personal story, a comparison, a rhetorical question, humour.</li>
</ul>
<p>A strong answer about intention names the purpose AND the means: "She wants to persuade adults to ...,
and she does it by ..."</p>
HTML,
],

[
    'type'    => 'select',
    'id'      => 's15Techniques',
    'marks'   => 1,
    'prompt'  => 'Read paragraph 6 again.' . "\n\n" . 'Which TWO techniques does the writer use in paragraph 6 to persuade her reader?',
    'options' => [
        'a' => 'A personal story (the no-scroll Sunday)',
        'b' => 'A simile (like a smoker reaching for a cigarette)',
        'c' => 'Figures from a scientific study',
        'd' => 'The words of an expert',
        'e' => 'A rhetorical question',
    ],
    'answer'  => ['a', 'b'],
    'why'     => [
        'c' => 'Is there a single study or percentage in paragraph 6? "Ninety pages" is her own story.',
        'd' => 'Who is quoted in paragraph 6? Only the writer herself.',
        'e' => 'The rhetorical question comes in paragraph 7, not 6.',
    ],
    'explain' => 'Paragraph 6 uses a <strong>personal story</strong> (the no-scroll Sunday, and the ninety pages) and a <strong>simile</strong> (reaching for the phone "like a smoker reaching for a cigarette"). The rhetorical question - "Why try to read a whole chapter...?" - is in paragraph 7.',
],

[
    'type'     => 'reveal',
    'id'       => 'rv15Intention',
    'prompt'   => '<p>What is the writer\'s main intention in Text A? Say it in your own words: what does she want her reader to think, and how does she go about it?</p>',
    'ownWords' => [
        'she wants to persuade adults (or readers) that teenagers can concentrate and are not broken',
        'she does it with personal stories, humour or by blaming the way apps are designed',
    ],
    'hints'    => [
        'Who does she speak to in paragraph 7, and what does she want them to stop saying?',
        'Think of Sizwe, the no-scroll Sunday and the goldfish jokes. What are they for?',
    ],
    'explain'  => '<p>She wants to <strong>persuade adults</strong> to stop calling teenagers the "five-second generation", because teenagers can concentrate on what they choose, and the real problem is apps built to grab attention. She uses <strong>personal stories</strong> (Sizwe, the no-scroll Sunday), <strong>humour</strong> (the goldfish) and a direct <strong>appeal</strong> to adults in paragraph 7: "Expect less, and you\'ll get less."</p>',
],

...BoardSection ('caps', 'CAPS-style questions on Text A', [
    [
        'type' => 'prose',
        'html' => '<p>A CAPS paper asks short questions, each with its mark in brackets. Two marks usually means two parts: the point, and the evidence or the reason. A question that asks for your opinion ("Do you think...?") always needs a reason.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w15Spotlight',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Refer to paragraph 4: "Attention is not a tank that empties; it is a spotlight that we point."</p><p class="prompt-ask">Explain why the writer compares attention to a spotlight rather than a tank. (2)</p>',
        'rubric'       => "- 1 mark: what the tank comparison suggests\n- 1 mark: what the spotlight comparison suggests, linked to her argument",
        'markerRubric' => "1 mark: a tank empties or runs out - the adults' view that teenagers' attention has been used up / is gone.\n1 mark: a spotlight is pointed where we choose - teenagers still have attention but choose what to focus on (as Sizwe does), so the problem is what they focus on, not how much attention they have.",
        'points'       => [
            ['marks' => 1, 'any' => ['a tank empties, so it suggests attention runs out or is used up']],
            ['marks' => 1, 'any' => ['a spotlight can be pointed wherever we choose, so teenagers still have attention and choose what to focus on']],
        ],
    ],
    [
        'type'         => 'written',
        'id'           => 'w15Conclusion',
        'markMax'      => 2,
        'prompt'       => '<p class="prompt-setup">Read paragraph 8, the last paragraph of Text A.</p><p class="prompt-ask">Do you think paragraph 8 is an effective conclusion to the text? Give a reason for your answer. (2)</p>',
        'rubric'       => "- 1 mark: a clear view (yes or no)\n- 1 mark: a reason from the text that supports it",
        'markerRubric' => "Award 0 for yes/no with no reason. Yes: it returns to the goldfish image from paragraph 1 and turns it round / the sprinter image sums up her argument (attention is there, but needs a goal) / it ends on a hopeful challenge to adults. No (credit if reasoned): it adds a new image (the sprinter) instead of summing up / it is too short to round off the argument. 1 mark for the view, 1 for a valid reason linked to the text.",
        'points'       => [
            ['marks' => 1, 'any' => ['it is effective because it returns to the goldfish image from the opening', 'it is effective because the sprinter image sums up her point that teenagers need a goal', 'it is effective because it ends with a hopeful challenge to adults']],
            ['marks' => 1, 'any' => ['the view is backed by a reason that refers to what paragraph 8 says or does']],
        ],
    ],
]),

...BoardSection ('ieb', 'IEB-style questions on Text A', [
    [
        'type' => 'prose',
        'html' => '<p>An IEB paper often gives you a definition or a quotation to use as a lens, then asks you to apply it to the text. The marks reward thinking that connects ideas: a 4-mark answer links the definition, the evidence and a judgement, instead of listing points.</p>',
    ],
    [
        'type'         => 'written',
        'id'           => 'w15StrawMan',
        'markMax'      => 4,
        'prompt'       => '<p class="prompt-setup">A <strong>straw man</strong> is an argument that attacks a weaker, exaggerated version of what the other side said, because that version is easier to knock down.</p><p class="prompt-ask">Using this definition, discuss whether the writer is fair to the adults she criticises in paragraphs 1 and 4. (4)</p><ul><li>Say what the adults claim and how she presents it.</li><li>Use short quotations from both paragraphs.</li><li>End with your own judgement: fair, unfair, or partly fair.</li></ul>',
        'rubric'       => "- 1 mark: the adults' claim and how she presents it\n- 1 mark: evidence from paragraph 1\n- 1 mark: evidence from paragraph 4\n- 1 mark: a reasoned judgement that uses the definition",
        'markerRubric' => "Generic descriptors: a 4-mark answer is relational - it links definition, evidence and judgement. Possible content: in paragraph 1 she exaggerates and mocks the claim (\"my generation's brains have melted\", \"can't finish a sentence\") - close to a straw man; but in paragraph 4 she states the adults' real complaint fairly (\"we won't focus on what they've chosen for us\", \"That's a fair complaint\") and admits some of it is right. Accept a judgement of unfair, fair or partly fair if supported. Cap at 2 if only one paragraph is discussed. Cap at 2 if the definition is not used.",
        'points'       => [
            ['marks' => 1, 'any' => ['the adults claim teenagers cannot concentrate, and in paragraph 1 she exaggerates it so it sounds silly']],
            ['marks' => 1, 'any' => ['paragraph 1 uses mocking exaggeration such as brains that have melted or not finishing a sentence']],
            ['marks' => 1, 'any' => ['in paragraph 4 she states the real complaint fairly and admits it is a fair complaint']],
            ['marks' => 1, 'any' => ['she is partly fair: paragraph 1 is close to a straw man but paragraph 4 answers the real argument', 'a clear judgement of fair or unfair that is backed by the definition']],
        ],
    ],
]),

[
    'type'   => 'prose',
    'anchor' => 'textb',
    'title'  => 'Text B, and both texts together',
    'html'   => <<<'HTML'
<p>Text B is an advert that pops up inside a short-video app. It is for <strong>Hush</strong>, a made-up
app that blocks other apps for a while.</p>
HTML
    . DesignFigure ('eng10-hush-ad', 'Text B: an in-app advert for Hush, a made-up focus app.')
    . <<<'HTML'
<p>What you see in Text B, in words:</p>
<ul>
<li>A phone drawn as a <strong>slot machine</strong>: three reels show a heart, a flame and a red
notification dot with "3", and a lever sticks out of its side. Its button says <strong>SPIN AGAIN</strong>.</li>
<li>The headline, in big capitals: <strong>THEY BUILT IT TO HOOK YOU.</strong></li>
<li>Under the phone: <strong>Your attention is what they sell. Take it back.</strong></li>
<li>Small print: Hush locks your scroll-traps for 25 minutes. Free for students.</li>
</ul>
<p>Every paper ends its comprehension with a question on <strong>both texts</strong>. It is never "write
about A, then write about B". It asks how they <em>compare</em>: where they agree, where they differ, and
why. Use a linking word (both, whereas, while, however) in your first sentence, so the marker sees the
comparison at once.</p>
HTML,
],

[
    'type'         => 'written',
    'id'           => 'w15CrossText',
    'markMax'      => 4,
    'prompt'       => '<p class="prompt-setup">Text A is the post by @kaya.makes; Text B is the Hush advert.</p><p class="prompt-ask">Compare how Text A and Text B present the part that apps play in teenagers\' attention. (4)</p><ul><li>Say where the two texts agree.</li><li>Say where they differ - think about whose fault it is, and what the teenager can do.</li><li>Refer to both texts (a short quotation or a detail of the picture).</li></ul>',
    'rubric'       => "- 1 mark: where the texts agree\n- 1 mark: a difference\n- 1 mark: evidence from Text A\n- 1 mark: evidence from Text B",
    'markerRubric' => "Agree: both say apps are designed on purpose to grab attention (A: \"designed by people who are paid to keep my thumb moving\", \"none of that is an accident\"; B: \"THEY BUILT IT TO HOOK YOU\", the slot machine). Differ: A says teenagers can still concentrate and can climb out themselves (the no-scroll Sunday, trust us); B suggests the user is hooked like a gambler and needs another app (Hush) to take attention back - and B is selling something, so it has its own interest in the problem. Cap at 2 if only one text is discussed. Credit valid alternatives.",
    'points'       => [
        ['marks' => 1, 'any' => ['both texts say apps are deliberately designed to grab and keep attention']],
        ['marks' => 1, 'any' => ['Text A says teenagers can still concentrate and free themselves, while Text B suggests users are hooked and need another app to help', 'Text B is selling an app, so it gains from making the problem sound bad, while Text A is a personal opinion']],
        ['marks' => 1, 'any' => ['a detail or quotation from Text A, such as paid to keep my thumb moving, kidnapped, or the no-scroll Sunday']],
        ['marks' => 1, 'any' => ['a detail or quotation from Text B, such as the slot machine, SPIN AGAIN, or they built it to hook you']],
    ],
],

[
    'type'   => 'prose',
    'title'  => 'Next time',
    'html'   => <<<'HTML'
<p>Ratel's checklist for any tone, diction or intention question:</p>
<ul>
<li>Name an <strong>exact</strong> tone word, never just "happy" or "negative".</li>
<li>Quote <strong>short</strong>: one to four words, in quotation marks.</li>
<li>Say what the word <strong>suggests</strong>, then how that serves the writer's point.</li>
<li>In a cross-text answer, <strong>compare</strong> in your first sentence.</li>
</ul>
<p>Next: figures of speech, and why the "why" matters more than the name.</p>
HTML,
],

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'Tone, diction, intention and the cross-text question.',
    'sections' => [
        [
            'heading' => 'Tone',
            'points'  => [
                '**Tone** is the writer\'s attitude, heard in the writing. Use an exact adjective: mocking, sarcastic, earnest, defiant, urgent.',
                'Tone can **change** inside a text, so read the paragraph the question names.',
                'Prove a tone with two or three short clues, then name the one tone they add up to.',
            ],
        ],
        [
            'heading' => 'Diction and intention',
            'points'  => [
                '**Diction** is word choice. Ask what a word **suggests** (its **connotation**) and why the writer picked it over a plainer word.',
                'The **intention** is what the text tries to do to its reader: persuade, inform, warn, entertain, criticise.',
                'A full intention answer names the purpose AND the means: "She wants to persuade ..., and she does it by ...".',
            ],
        ],
        [
            'heading' => 'Two texts',
            'points'  => [
                'A cross-text question asks you to **compare**: where the texts agree, where they differ, with evidence from both.',
                'One text only usually caps your mark at half.',
            ],
        ],
    ],
    'keyTerms' => [
        'tone'        => 'The writer\'s attitude to the subject or reader, as it comes through in the writing.',
        'diction'     => 'The writer\'s choice of words.',
        'connotation' => 'The feelings and ideas a word suggests on top of its dictionary meaning.',
        'intention'   => 'What the writer wants the text to do to its reader - the purpose.',
    ],
],

];
