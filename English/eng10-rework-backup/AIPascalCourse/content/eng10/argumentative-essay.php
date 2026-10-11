<?php
/**
 * Lesson 42 : The argumentative essay - one side, well defended. What makes an
 * essay argumentative (not discursive), the thesis, planning, the PEEL body
 * paragraph and the rebuttal, then a full essay marked on each board's rubric.
 * About 30 minutes for the lesson; the full essay is a task on top.
 * Writing strand, W1 Drafting table, Quill. Term 2 W1 (CAPS ref §1.4:
 * argumentative = one-sided). Prepares CAPS Task 5 and P3 Sec A (essay 50,
 * Gr 10 300-350 words, App C: content and planning 30, language, style and
 * editing 15, structure 5); IEB SBA extended writing (Gr 10 proposal 400-500
 * words; marked out of at least 30 - SAG §1.6; criteria from the SAG's D16
 * argumentative-essay rubric: introduction, quality of argument, structure
 * and register. The mark split 6 / 16 / 8 is the course's proposal - check it
 * against the revised 2026 SAG).
 * The two full essays have no 'points' but carry 'jevChecks' (Chris, 11 October
 * 2026): Jev answers the yes/no checks, then Claude marks the band rubric with
 * Jev's answers in front of it (Jev's points suit short answers, not 50-mark essays).
 * English Home Language Grade 10 (AIResources/English/eng10-lessons.md).
 * Sample lesson, written 11 October 2026. Not progress gated (Chris, 11 October 2026).
 */

return [

[
    'type'  => 'prose',
    'title' => 'Start here',
    'html'  => DesignFigure ('eng10-open-argue', 'Writing: the argumentative essay.')
    . <<<'HTML'
<p>You already argue well. You have talked a parent into a later curfew, or talked a friend out of a bad
haircut. You picked a side, gave reasons, and answered "but what about..." before it was even said.</p>
<p>An argumentative essay is that, on paper, with the volume turned down and the reasons turned up. This
lesson shows you how to plan one, how to build each paragraph, and how to deal with the other side
without switching to it. Then you write one.</p>
HTML
],

[
    'type'  => 'contents',
    'intro' => 'This lesson has five parts:',
    'items' => [
        ['anchor' => 'what',     'label' => 'One side, defended',  'note' => 'argumentative or discursive?'],
        ['anchor' => 'thesis',   'label' => 'The thesis',          'note' => 'your stance in one sentence'],
        ['anchor' => 'plan',     'label' => 'The plan',            'note' => 'the essay\'s layout'],
        ['anchor' => 'peel',     'label' => 'Building a paragraph', 'note' => 'PEEL and the rebuttal'],
        ['anchor' => 'essay',    'label' => 'Your essay',          'note' => 'one for your board'],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'what',
    'title'  => 'One side, defended',
    'html'   => Doodle ('eng10-joke-argue', 'Quill\'s argumentative essays are like Quill\'s favourite pose: firmly on one side.')
    . <<<'HTML'
<p>An <strong>argumentative essay</strong> takes <strong>one side</strong> of a debatable statement and
defends it from the first paragraph to the last. Its cousin, the <strong>discursive essay</strong>, is
different: it gives both sides a fair hearing and only gives the writer's view at the end.</p>
<ul>
<li><strong>Argumentative</strong> - like a lawyer in court: everything you say serves your side.</li>
<li><strong>Discursive</strong> - like a judge: you weigh both sides before you decide.</li>
</ul>
<p>A one-sided essay still mentions the other side - once, on purpose, so that it can answer it. That
paragraph is called the <strong>rebuttal</strong>. Without it, your essay sounds as if you never heard the
other side; with it, you sound like someone who heard it and still disagrees.</p>
HTML,
],

[
    'type'    => 'select',
    'id'      => 's42Features',
    'marks'   => 1,
    'prompt'  => 'Which THREE of these belong in an argumentative essay?',
    'options' => [
        'a' => 'It takes one side from the first paragraph.',
        'b' => 'It gives both sides equal space and decides only at the end.',
        'c' => 'It answers the other side\'s best point and shows why it fails.',
        'd' => 'It tells one long personal story instead of giving reasons.',
        'e' => 'Every body paragraph supports the writer\'s stance.',
    ],
    'answer'  => ['a', 'c', 'e'],
    'why'     => [
        'b' => 'That is the judge, not the lawyer - which kind of essay weighs both sides equally?',
        'd' => 'A personal example can be evidence for a reason. Can it replace the reasons?',
    ],
    'explain' => 'An argumentative essay takes <strong>one side</strong> from the start, keeps <strong>every paragraph</strong> on that side, and includes a <strong>rebuttal</strong> of the other side\'s best point. Weighing both sides equally is what a discursive essay does.',
],

[
    'type'    => 'typed',
    'kind'    => 'blank',
    'id'      => 't42Rebuttal',
    'marks'   => 1,
    'prompt'  => 'Fill in the missing letters: the paragraph in which you answer the other side\'s best point.',
    'display' => 'r _ b _ t t _ l',
    'answer'  => 'rebuttal',
    'explain' => 'The <strong>rebuttal</strong>: you state the strongest point against you, fairly, then show why it does not change your mind.',
],

[
    'type'   => 'prose',
    'anchor' => 'thesis',
    'title'  => 'The thesis: your stance in one sentence',
    'html'   => MarginNote ('The word "argument" comes from the Latin arguere, which meant "to make clear" or "to prove" - not to shout.')
    . <<<'HTML'
<p>Your <strong>thesis</strong> is one sentence, near the end of your introduction, that states your side
and - ideally - the reasons you will give. Everything else in the essay proves it. A thesis is not:</p>
<ul>
<li>an announcement: "In this essay I will discuss group chats." (Which side?)</li>
<li>a plain fact: "Many teenagers use group chats." (Nobody can disagree, so there is nothing to argue.)</li>
<li>a question: "Are group chats good or bad?" (Questions ask; a thesis answers.)</li>
</ul>
<p>Practise on this topic, which runs through the rest of the lesson: <strong>"School group chats do more
harm than good."</strong> You may agree or disagree - either side can win.</p>
HTML,
],

[
    'type'    => 'quiz',
    'id'      => 'q42Thesis',
    'marks'   => 1,
    'prompt'  => 'Topic: "School group chats do more harm than good."' . "\n\n" . 'Which sentence is the strongest thesis for an argumentative essay on this topic?',
    'options' => [
        'a' => 'In this essay I am going to talk about school group chats and what I think of them.',
        'b' => 'Group chats are used by almost every class at our school.',
        'c' => 'School group chats do more harm than good, because they never switch off, they spread rumours fast and they stop pupils asking teachers for help.',
        'd' => 'Are school group chats really as helpful as everyone says they are?',
    ],
    'answer'  => 'c',
    'why'     => [
        'a' => 'This announces a topic. Which side does the writer take?',
        'b' => 'This is a fact. Could anyone argue against it?',
        'd' => 'A question asks. What does a thesis have to do?',
    ],
    'explain' => 'Option c takes a side ("do more harm than good") and names three reasons, so it is a map of the whole essay. The others announce, state a fact or ask a question.',
],

[
    'type'   => 'prose',
    'anchor' => 'plan',
    'title'  => 'The plan: the essay\'s layout',
    'html'   => MarginNote ('One paragraph, one reason. If a paragraph needs two topic sentences, it is two paragraphs.', 'Layout rule')
    . <<<'HTML'
<p>Plan before you write - five minutes in a timed essay, longer at home. A mind-map is good for finding
ideas; this layout is good for ordering them. Put your best reason <strong>last</strong>, so the
reader finishes on your strongest point.</p>
HTML
    . DesignFigure ('eng10-argue-layout', 'The layout of an argumentative essay, with the thesis running through it.')
    . <<<'HTML'
<p>The lengths depend on your board. CAPS essays in Grade 10 are <strong>300 to 350 words</strong>. The IEB
extended-writing piece is longer - this course uses <strong>400 to 500 words</strong> in Grade 10 - and it
is written as a process: a plan, a draft, then a second, better draft.</p>
HTML,
],

[
    'type'   => 'prose',
    'anchor' => 'peel',
    'title'  => 'Building a paragraph: PEEL',
    'html'   => <<<'HTML'
<p>Each body paragraph does one job: it proves one reason. <strong>PEEL</strong> gives it a shape:</p>
<ul>
<li><strong>P - Point.</strong> The topic sentence: the reason, in one sentence.</li>
<li><strong>E - Evidence.</strong> An example, a fact, an experience - something concrete.</li>
<li><strong>E - Explain.</strong> How the evidence proves the point. This is where marks are won.</li>
<li><strong>L - Link.</strong> Tie the paragraph back to the thesis.</li>
</ul>
<p>The paragraph below has been cut up. Put it back together.</p>
HTML,
],

[
    'type'    => 'order',
    'id'      => 'o42Peel',
    'marks'   => 1,
    'prompt'  => 'Put the four sentences of this body paragraph in PEEL order: point, evidence, explain, link.',
    'items'   => [
        'The first problem is that a school group chat never switches off.',
        'In my class chat, messages about the next day\'s test were still arriving after midnight, and every one got a dozen replies.',
        'When the chat follows you to bed, school stops having an end, and pupils arrive tired and anxious instead of ready to learn.',
        'A tool that steals sleep from a whole class is doing more harm than good.',
    ],
    'why'     => 'Which sentence states the reason? Which one is the example? Which one says what the example proves? Which one goes back to the thesis?',
    'explain' => '<strong>Point</strong>: the chat never switches off. <strong>Evidence</strong>: messages after midnight. <strong>Explain</strong>: school never ends, so pupils arrive tired. <strong>Link</strong>: it does more harm than good.',
],

[
    'type'     => 'reveal',
    'id'       => 'rv42Rebuttal',
    'prompt'   => '<p>If an argumentative essay is one-sided, why should it give the other side a whole paragraph? Say it in your own words before you open the answer.</p>',
    'ownWords' => [
        'it shows the writer knows and understands the other side',
        'answering the objection makes the argument stronger or more convincing, because the reader\'s doubt has been dealt with',
    ],
    'hints'    => [
        'What does a reader think of a writer who seems never to have heard the other side?',
        'If the reader is already thinking "but what about...", what happens when you answer it first?',
    ],
    'explain'  => '<p>A rebuttal shows you <strong>know the other side</strong> - and that you are not hiding from it. It also takes the reader\'s strongest doubt and <strong>answers it before they can use it</strong>, so your argument ends stronger. Shape: "Some say group chats help pupils share homework. That is true, but a homework chat could be muted after 9 p.m.; the problem is the chat that never stops."</p>',
],

[
    'type'         => 'written',
    'id'           => 'w42Paragraph',
    'markMax'      => 4,
    'prompt'       => '<p class="prompt-setup">Topic: "Phones should be allowed in class for learning." Decide whether you agree or disagree.</p><p class="prompt-ask">Write ONE body paragraph (about 70 to 90 words) for an argumentative essay on this topic, in PEEL order.</p><ul><li>Point: one reason, in your topic sentence.</li><li>Evidence: a concrete example.</li><li>Explain: how the example proves the reason.</li><li>Link: back to your stance.</li></ul>',
    'rubric'       => "- 1 mark: a clear point that takes a side\n- 1 mark: concrete evidence\n- 1 mark: an explanation that connects the evidence to the point\n- 1 mark: a link back to the stance",
    'markerRubric' => "Either side is fine. 1: topic sentence states one reason and the side is clear. 1: a specific example, fact or experience (not a vague claim). 1: explanation of HOW the evidence supports the point (not a repeat of the point). 1: final sentence links back to the stance or topic. No mark lost for one extra sentence; deduct the evidence mark if the 'evidence' is only another opinion.",
    'points'       => [
        ['marks' => 1, 'any' => ['the paragraph opens with a topic sentence that gives one reason and takes a side']],
        ['marks' => 1, 'any' => ['it gives a concrete example, fact or experience as evidence']],
        ['marks' => 1, 'any' => ['it explains how the example supports the reason']],
        ['marks' => 1, 'any' => ['it ends by linking back to the stance on phones in class']],
    ],
],

[
    'type'   => 'prose',
    'anchor' => 'essay',
    'title'  => 'Your essay',
    'html'   => <<<'HTML'
<p>Now the whole thing. Choose <strong>one</strong> of these topics and argue one side:</p>
<ul>
<li>School group chats do more harm than good.</li>
<li>Every Grade 10 pupil should spend one school day a week with no phone at all.</li>
<li>Video games deserve a place on the school sports list.</li>
</ul>
<p>Plan first, using the layout above. Then write the essay for <strong>your board</strong> below - the
two boards ask for different lengths and mark it on different rubrics. Read the rubric before you start:
it tells you exactly what the marks are for.</p>
HTML,
],

...BoardSection ('caps', 'CAPS: the essay (50 marks)', [
    [
        'type'         => 'written',
        'id'           => 'w42CapsEssay',
        'markMax'      => 50,
        'showRubric'   => true,
        'prompt'       => '<p class="prompt-setup">Write an argumentative essay of 300 to 350 words on ONE of the three topics above. Give your essay a title, and write the number of the topic you chose at the top.</p><p class="prompt-ask">Argue one side clearly, with a thesis, three reasons in PEEL paragraphs, a rebuttal and a strong conclusion.</p><ul><li>Plan first - your plan is not marked, but your structure is.</li><li>Keep to 300-350 words.</li><li>Check your spelling, punctuation and paragraphing before you hand it in.</li></ul>',
        'rubric'       => "Content and planning (30 marks)\n- 25-30: a clear, original stance argued all the way through; strong, well-chosen reasons and evidence; a convincing rebuttal\n- 19-24: a clear stance; good reasons with evidence; a rebuttal that mostly works\n- 13-18: a stance, but some reasons are thin, repeated or not explained\n- 7-12: the stance wobbles or switches sides; reasons are vague\n- 0-6: no clear stance, or the essay is off the topic\n\nLanguage, style and editing (15 marks)\n- 13-15: precise, varied language in a formal register; almost no errors\n- 10-12: clear language and a suitable register; a few errors\n- 7-9: understandable, but plain or repetitive, with errors that distract\n- 4-6: frequent errors; slang or a chatty register\n- 0-3: errors make the meaning hard to follow\n\nStructure (5 marks)\n- 5: introduction with thesis, PEEL paragraphs, rebuttal and conclusion; smooth links; 300-350 words\n- 4: well organised, with one weak link or paragraph\n- 3: paragraphs present but some do more than one job\n- 2: little paragraphing or order\n- 0-1: no clear structure",
        'markerRubric' => "Mark on CAPS Appendix C (Gr 10 essay, 50): content and planning 30, language, style and editing 15, structure 5. Use the pupil-facing bands as the band boundaries (Exceptional 25-30 / 13-15 / 5; Skilful 19-24 / 10-12 / 4; Moderate 13-18 / 7-9 / 3; Elementary 7-12 / 4-6 / 2; Inadequate 0-6 / 0-3 / 0-1), placing high or low within a band. Argumentative = one-sided: a discursive essay (both sides weighed equally) cannot go above Moderate for content. A rebuttal is expected for Skilful and above. Length: 300-350 words; the rubric carries the length - an essay well under 300 words cannot reach Exceptional for content or structure; no separate penalty. A creative story instead of an argument: content at most Elementary. Feedback names the band for each criterion and one thing to improve.",
        'jevChecks'    => [
            'Does the essay take ONE side of the topic and keep to it to the end (not weigh both sides equally)?',
            'Does the introduction contain a thesis sentence that states the side the writer takes?',
            'Does each body paragraph open with a point that supports the thesis?',
            'Is each reason backed by evidence or an example, and then explained?',
            'Does the essay answer the other side at least once (a rebuttal) and show why it is weaker?',
            'Does the conclusion restate the stance without adding a new argument?',
            'Is the register formal throughout (no slang or chat language)?',
            'Is the essay roughly 300 to 350 words long?',
        ],
    ],
]),

...BoardSection ('ieb', 'IEB: extended writing (30 marks)', [
    [
        'type'         => 'written',
        'id'           => 'w42IebEssay',
        'markMax'      => 30,
        'showRubric'   => true,
        'prompt'       => '<p class="prompt-setup">Write an argumentative piece of 400 to 500 words on ONE of the three topics above, as a piece of extended writing. Give it a title.</p><p class="prompt-ask">Build an argument a thoughtful reader would find convincing: a clear stance from the introduction, developed reasons, a fair rebuttal and a conclusion that lands.</p><ul><li>Work as a process: plan, write a first draft, then improve it into this final version. Only the final version is marked.</li><li>Keep a formal register: no slang, no "you guys".</li><li>Use real, specific evidence - your own experience counts if you explain what it proves.</li></ul>',
        'rubric'       => "Introduction and stance (6 marks)\n- 6: an engaging opening and a precise thesis that sets up the whole argument\n- 4-5: a clear opening and stance\n- 2-3: a stance, but the opening is flat or the thesis vague\n- 0-1: no clear stance\n\nQuality of argument (16 marks)\n- 14-16: reasons that build on each other, explained in depth, with telling evidence and a rebuttal that strengthens the case\n- 10-13: sound reasons with evidence and explanation; a fair rebuttal\n- 6-9: some reasons are listed rather than developed; evidence is general\n- 0-5: little argument; opinion without support\n\nStructure and register (8 marks)\n- 7-8: logical order, one idea per paragraph, smooth links; a confident formal register; very few errors\n- 5-6: clear paragraphs and a suitable register; some errors\n- 3-4: order is loose or the register slips; errors distract\n- 0-2: hard to follow",
        'markerRubric' => "IEB extended writing, Gr 10 (course proposal: 400-500 words, 30 marks; the SAG says marked out of at least 30). Criteria from the SAG's D16 argumentative-essay rubric: introduction / quality of argument / structure, register. Mark globally first (place the piece from its first and last paragraphs, read it all), then confirm against the bands. One-sided argument expected; a balanced discursive piece caps quality of argument at 9. No separate length penalty, but an undeveloped short piece cannot reach the top bands. Feedback names the band for each criterion and one thing to improve in the next draft.",
        'jevChecks'    => [
            'Does the opening engage the reader and state a precise thesis that takes one side?',
            'Does the argument stay on one side to the end (not a balanced, discursive weighing of both sides)?',
            'Are the reasons developed and explained in depth, rather than listed?',
            'Is the evidence specific (a concrete example, detail or experience explained), rather than general claims?',
            'Does the piece answer the strongest opposing view (a rebuttal) and use it to strengthen the case?',
            'Is each paragraph about one idea, with links between paragraphs?',
            'Is the register formal throughout (no slang such as "you guys")?',
            'Is the piece roughly 400 to 500 words long?',
        ],
    ],
]),

[
    'type'   => 'prose',
    'title'  => 'Next time',
    'html'   => <<<'HTML'
<p>Quill's last check before you hand in:</p>
<ul>
<li>Does your thesis take ONE side?</li>
<li>Does every paragraph start with a point that serves that side?</li>
<li>Did you answer the other side once - and win?</li>
<li>Have you cut "at the end of the day", "in today's society" and every other cliché? Quill stamps on them.</li>
</ul>
<p>Next: picture prompts - finding the essay hiding inside an image.</p>
HTML,
],

[
    'type'  => 'study',
    'title' => 'What to study',
    'intro' => 'The argumentative essay.',
    'sections' => [
        [
            'heading' => 'What it is',
            'points'  => [
                '**Argumentative**: one side, defended all the way. **Discursive**: both sides weighed, the view at the end.',
                'The **thesis** is one sentence that takes a side and names the reasons. Not an announcement, a fact or a question.',
            ],
        ],
        [
            'heading' => 'How it is built',
            'points'  => [
                'Introduction (hook, issue, thesis); three body paragraphs; a **rebuttal**; a conclusion with no new points.',
                'Body paragraphs follow **PEEL**: point, evidence, explain, link. One reason per paragraph.',
                'Save the strongest reason for last.',
                'Lengths in Grade 10: CAPS 300-350 words; IEB extended writing 400-500 words (this course).',
            ],
        ],
    ],
    'keyTerms' => [
        'argumentative essay' => 'An essay that argues for one side of a debatable statement.',
        'discursive essay'    => 'An essay that weighs both sides fairly and gives the writer\'s view at the end.',
        'thesis'              => 'The one-sentence statement of the writer\'s position that the essay proves.',
        'rebuttal'            => 'The paragraph that answers the other side\'s strongest point.',
    ],
],

];
