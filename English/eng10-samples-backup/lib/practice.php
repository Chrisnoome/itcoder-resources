<?php
/**
 * Practice: word games made from a course's glossary (Chris, 25 September
 * 2026: "a fun practice section after the glossary ... crossword, word
 * search, hangman, flash cards that self generate from the glossary (single
 * words only). each round is 20 words. score is kept and a leader board is
 * shown. ranks, gamification ... a username (bad words filtered and icon
 * chooseable in the user settings) ... don't want self uploaded icons").
 *
 * - WORDS: single-word glossary terms (letters only, 3 to 14), each with its
 *   definition as the clue - the word itself blanked out of the clue.
 * - ROUNDS: the server picks the 20 words and hands out a one-time token
 *   (practiceRounds); the page plays the game and sends back how many it got
 *   right. The score is capped at the round's words, a round needs a
 *   believable minimum time, and a token finishes once - enough to keep a
 *   school leaderboard honest without pretending a browser can be trusted.
 * - XP: points per word right, a bonus for a perfect round, double for the
 *   daily challenge (the same 20 words for everyone, once a day).
 * - RANKS: nine per course (PracticeRanks(): programming, SQL, theory, AI;
 *   others Bit to Petabyte). BADGES for milestones. A STREAK of days played in a row.
 * - SPACED REPETITION: every word a pupil meets gets a Leitner box
 *   (practiceWords); a round picks words that are due first, then new ones,
 *   so the words a pupil misses come back soon and the ones they know come
 *   back rarely.
 * - SPEED MATCH: a fifth game - five words, five meanings, match them against
 *   the clock, four sets.
 * - CLASSES: a weekly class-against-class board (XP per member of the class),
 *   and the teacher's page shows each pupil's practice and the words a class
 *   misses most.
 * - PROFILE: a display name (checked against PracticeBadWords(), unique) and
 *   an emoji icon on a colour, chosen on My account - never an upload, never
 *   the pupil's real name on a leaderboard. A pupil can leave the
 *   leaderboard entirely.
 */

require_once __DIR__ . '/db.php';
require_once __DIR__ . '/glossary.php';
require_once __DIR__ . '/convertdrill.php';   // the conversion drill (IT Theory, 28 September 2026)
require_once __DIR__ . '/ordering.php';       // Put in order (IT Theory, Pascal, Java - 28 September 2026)

const PRACTICE_ROUND_WORDS = 20;

/**
 * The games, id => [title, icon, blurb, XP per word, least believable seconds
 * per word, par seconds per word (the speed bonus)], and optionally: 'courses'
 * (only these courses - PracticeGamesFor()), 'unit' (what one scores - word,
 * pair, question), 'daily' false (not in today's challenge), 'noBoxes' (no
 * spaced repetition: the questions are made up each round), 'words' (a
 * round's words when not PRACTICE_ROUND_WORDS).
 */
function PracticeGames () : array
{
    return [
        'flashcards' => ['title' => 'Flash cards', 'icon' => '🃏', 'blurb' => 'Read the meaning and say the word out loud - the computer listens. Only spoken words earn XP; with no microphone you can still flip and practise.', 'xp' => 1, 'minSeconds' => 1, 'par' => 8],
        'hangman'    => ['title' => 'Hangman',     'icon' => '🪢', 'blurb' => 'Guess the word from its meaning, one letter at a time, before you run out of lives.', 'xp' => 3, 'minSeconds' => 2, 'par' => 25],
        'wordsearch' => ['title' => 'Word search', 'icon' => '🔎', 'blurb' => 'Find the words hidden in the grid - each one shows what it means when you find it.', 'xp' => 2, 'minSeconds' => 1, 'par' => 12],
        'crossword'  => ['title' => 'Crossword',   'icon' => '✏️', 'blurb' => 'Fill the grid from the clues. Every clue is a glossary definition.', 'xp' => 4, 'minSeconds' => 2, 'par' => 25],
        'speedmatch' => ['title' => 'Speed match', 'icon' => '⚡', 'blurb' => 'Five words, five meanings - match them before the clock runs out. Four sets.', 'xp' => 2, 'minSeconds' => 1, 'par' => 7],
        'memory'     => ['title' => 'Memory match', 'icon' => '🧠', 'blurb' => 'Turn over two cards at a time: pair each word with its picture, code or meaning. 10, 20 or 30 pairs from the lessons you have done.', 'xp' => 2, 'minSeconds' => 1, 'par' => 10, 'unit' => 'pair', 'daily' => false],
        // Chris, 28 September 2026: a timed conversion drill, IT Theory only (lib/convertdrill.php).
        'convert'    => ['title' => 'Conversion drill', 'icon' => '🔢', 'blurb' => 'Binary, decimal, hex, octal and storage units - 20 conversions against the clock. Type the answer or use the keypad.', 'xp' => 2, 'minSeconds' => 2, 'par' => 15,
                         'unit' => 'question', 'courses' => CONVERT_COURSES, 'noBoxes' => true],
        // Chris, 28 September 2026: picture ordering - processes as cards, and Parsons puzzles for Pascal and Java (lib/ordering.php).
        'ordering'   => ['title' => 'Put in order', 'icon' => '🧩', 'blurb' => 'Put the steps of a process - or the shuffled lines of a program - back in the right order. Puzzles from the lessons you have done.', 'xp' => 5, 'minSeconds' => 4, 'par' => 40,
                         'unit' => 'puzzle', 'daily' => false, 'noBoxes' => true, 'courses' => ORDERING_COURSES],
        // Chris, 6 October 2026: "Practice games: the glossary word games accept your own words for a definition,
        // judged by Jev". The pupil types what a term means; api/practice-explain.php asks Jev at once. 10 words
        // a round ('words' - typing takes longer); not in today's challenge (every answer is a Jev call).
        'explain'    => ['title' => 'Say what it means', 'icon' => '💬', 'blurb' => 'See a word and type what it means in your own words - it is checked straight away. 10 words a round.', 'xp' => 4, 'minSeconds' => 4, 'par' => 30,
                         'unit' => 'word', 'words' => 10, 'daily' => false],
    ];
} // PracticeGames


/** The games a course offers: every game without a 'courses' list, and those that name it. */
function PracticeGamesFor (string $aCourseId) : array
{
    return array_filter (PracticeGames (), fn ($aGame) => !isset ($aGame['courses']) || in_array ($aCourseId, $aGame['courses'], true));
} // PracticeGamesFor


/**
 * Which set of level names a course uses (Chris, 1 October 2026: "all level
 * names change per course to suit the subject and content ... programming for
 * java and pascal can share. sql needs its own, theory needs its own"; and he
 * chose each set). A course not listed keeps Bit to Petabyte.
 */
function RankFamily (string $aCourseId) : string
{
    if (in_array ($aCourseId, ['pascal', 'java'], true)) { return 'programming'; }
    if ($aCourseId === 'sql')                            { return 'sql'; }
    if (str_starts_with ($aCourseId, 'theory'))          { return 'theory'; }
    if ($aCourseId === 'ai')                             { return 'ai'; }
    if ($aCourseId === 'mlit10')                         { return 'mlit10'; }   // SA money, 10c to R200 (Chris, 10 October 2026)
    if (in_array ($aCourseId, ['safety', 'socialmedia', 'sql9', 'pascal9', 'clubweb', 'tuckshop', 'machine', 'factfake', 'botmaze'], true)) { return $aCourseId; }
    if (in_array ($aCourseId, ['cattheory10', 'cattheory11', 'cattheory12', 'catpilot'], true)) { return 'cattheory'; }   // the CAT courses' own (Chris, 10 October 2026)
    if (in_array ($aCourseId, ['catword', 'catexcel', 'catpowerpoint', 'cathtml', 'catdb'], true)) { return $aCourseId; }   // each new General Computing course its own (Chris, 10 October 2026: "each course must get its own level names")

    return 'data';
} // RankFamily


/** A course's ranks, lowest first: [name, XP needed, what it means]. The XP steps are the same in every course. */
function PracticeRanks (string $aCourseId = '') : array
{
    $xp    = [0, 50, 150, 350, 700, 1200, 2000, 3200, 5000];
    $names = [
        'programming' => [
            ['Typo',           'Everyone starts with one - it is how you learn to read an error'],
            ['Syntax Error',   'You have met the compiler, and it has opinions'],
            ['Bug Hunter',     'You go looking for what is wrong instead of hoping'],
            ['Debugger',       'You watch the program think, one step at a time'],
            ['Problem Solver', 'You break a task into steps before you type'],
            ['Code Crafter',   'Neat, named and commented - code others can read'],
            ['Algorithm Ace',  'Sorting, searching and loops inside loops hold no fear'],
            ['System Builder', 'Classes, files and forms working together'],
            ['Code Master',    'The top rank'],
        ],
        'sql' => [
            ['Value',          'One piece of data - everyone starts here'],
            ['Field',          'A column with a name and a type'],
            ['Record',         'A whole row about one thing'],
            ['Table',          'Records with the same fields, together'],
            ['Key',            'Every record found by its own value'],
            ['Query',          'Asking the data a question in SQL'],
            ['Join',           'Two tables answering one question'],
            ['Database',       'Tables, keys and queries designed as one'],
            ['Data Warehouse', 'Years of data from everywhere - the top rank'],
        ],
        'theory' => [
            ['Abacus',         'Counting with beads - everyone starts here'],
            ['Valve',          'The first electronic computers filled whole rooms'],
            ['Transistor',     'A tiny switch that changed everything'],
            ['Microchip',      'Millions of transistors on one chip'],
            ['PC',             'A computer on every desk'],
            ['Laptop',         'The computer goes where you go'],
            ['Smartphone',     'A computer in your pocket'],
            ['Cloud',          'Computing as a service, from anywhere'],
            ['Supercomputer',  'The fastest there is - the top rank'],
        ],
        'ai' => [
            ['Curious',        'Wondering how it really works - everyone starts here'],
            ['Prompter',       'You know how to ask'],
            ['Questioner',     'You ask what it runs on, and who pays'],
            ['Fact-checker',   'You check what it tells you'],
            ['Tinkerer',       'You have tried things for yourself'],
            ['Builder',        'You can explain the machine behind the chat'],
            ['Trainer',        'You know how a model learns'],
            ['Researcher',     'You weigh the evidence against the hype'],
            ['AI Expert',      'The top rank'],
        ],
        'safety' => [
            ['Witness',          'You saw something odd - everyone starts here'],
            ['Rookie',           'Your first case'],
            ['Lookout',          'You notice when something is off'],
            ['Spotter',          'You spot a scam before it spots you'],
            ['Tracker',          'You follow the clues back to the source'],
            ['Detective',        'You can say why it is a fake'],
            ['Inspector',        'You check settings, passwords and apps'],
            ['Chief Inspector',  'You help others stay safe'],
            ['Case Closer',      'The top rank'],
        ],
        'socialmedia' => [
            ['Scroller',         'Thumb on the screen - everyone starts here'],
            ['Tapper',           'You know where the buttons are'],
            ['Noticer',          'You notice the pull to keep scrolling'],
            ['Pauser',           'You stop before you share'],
            ['Questioner',       'You ask who pays and why'],
            ['Fact-checker',     'You check before you believe'],
            ['Settings Tweaker', 'You switch the machine down'],
            ['Time Keeper',      'Your time, your rules'],
            ['Attention Master', 'The top rank'],
        ],
        'sql9' => [
            ['Visitor',          'Through the gate - everyone starts here'],
            ['Volunteer',        'Helping out at the reserve'],
            ['Spotter',          'You find the rows that matter'],
            ['Tracker',          'You follow the trail through the tables'],
            ['Field Ranger',     'WHERE, AND and LIKE in the field'],
            ['Data Ranger',      'Counting and grouping the evidence'],
            ['Section Ranger',   'Joining tables to connect the dots'],
            ['Head Ranger',      'You can run the whole case'],
            ['Reserve Warden',   'The top rank'],
        ],
        'pascal9' => [
            ['Trainee',          'First day at the ground station - everyone starts here'],
            ['Cadet',            'Your first program runs'],
            ['Comms Officer',    'Clear output, clear messages'],
            ['Systems Tech',     'Colours, boxes and screens'],
            ['Engineer',         'Variables and calculations'],
            ['Flight Controller', 'Your programs decide'],
            ['Pilot',            'You test every path'],
            ['Commander',        'Whole systems, working'],
            ['Mission Director', 'The top rank'],
        ],
        'clubweb' => [
            ['Blank Page',      'Nothing on it yet - everyone starts here'],
            ['Tag',             'Your first tag, opened and closed'],
            ['Heading',         'Big, bold and on top'],
            ['Paragraph',       'The words that fill the page'],
            ['List',            'Bullets and numbers in their place'],
            ['Link',            'Your page joins the web'],
            ['Page',            'A whole page that works'],
            ['Website',         'Pages that people visit'],
            ['Webmaster',       'The top rank'],
        ],
        'botmaze' => [
            ['Lost Bolt',        'Lost in the tunnels - everyone starts here'],
            ['First Step',       'One square at a time'],
            ['Turner',           'Left, right - and you know whose left'],
            ['Bug Hunter',       'Glitch cannot hide from you'],
            ['Looper',           'Why say it eight times? Repeat'],
            ['Sensor',           'Bolt looks before it moves'],
            ['Wall Follower',    'One hand on the wall, all the way out'],
            ['Tunnel Master',    'Every maze, every battery'],
            ['Chief Programmer', 'The top rank'],
        ],
        'factfake' => [
            ['Scroller',        'Just reading - everyone starts here'],
            ['Pauser',          'You stop before you share'],
            ['Searcher',        'The right words, the right site'],
            ['Source Seeker',   'You ask who made it'],
            ['Sideways Reader', 'You leave the page to check'],
            ['Image Tracer',    'Old photos never fool you'],
            ['AI Spotter',      'Six fingers? Not on your watch'],
            ['Fact-checker',    'Evidence first, verdict second'],
            ['Truth Keeper',    'The top rank'],
        ],
        'machine' => [
            ['Dust Speck',     'Shrunk and lost - everyone starts here'],
            ['Spark',          'Moving along the copper roads'],
            ['Bit',            'A 0 or a 1, and proud of it'],
            ['Byte',           'Eight bits, working together'],
            ['Circuit Runner', 'You know the roads of the city'],
            ['Chip Explorer',  'Downtown holds no secrets'],
            ['Board Mapper',   'Every part, found and named'],
            ['Technician',     'You find faults and fix them'],
            ['Master Engineer', 'The top rank'],
        ],
        'tuckshop' => [
            ['Shop Helper',      'Behind the counter - everyone starts here'],
            ['Price Writer',     'The price list, cell by cell'],
            ['Stock Counter',    'Every packet counted'],
            ['Till Keeper',      'The till adds up'],
            ['Cash-up Captain',  'Every rand accounted for'],
            ['Profit Finder',    'You know what the shop really makes'],
            ['Shop Manager',     'The whole shop runs on your sheets'],
            ['Business Boss',    'Plans, budgets and charts'],
            ['Tuck-shop Tycoon', 'The top rank'],
        ],
        'mlit10' => [
            ['10c',  'Small change - everyone starts here'],
            ['50c',  'You can read a till slip without panicking'],
            ['R1',   'Up, down or off - and you know which'],
            ['R5',   'Ratios and rates come naturally'],
            ['R10',  'Bills and tariffs hold no secrets'],
            ['R20',  'You measure twice and convert once'],
            ['R50',  'Maps, plans and scale make sense'],
            ['R100', 'Every step shown, every unit given'],
            ['R200', 'The top rank'],
        ],
        'cattheory' => [
            ['Power Button',       'Switched on - everyone starts here'],
            ['Desktop',            'You know your way round the screen'],
            ['File',               'Saved, named and found again'],
            ['Folder',             'Everything in its place'],
            ['Network',            'Computers talking to each other'],
            ['Cloud',              'Your work, anywhere'],
            ['Firewall',           'Keeping the bad stuff out'],
            ['Tech Support',       'You fix it for others'],
            ['IT Manager',         'The top rank'],
        ],
        'catword' => [
            ['Blank Doc',          'An empty page - everyone starts here'],
            ['Typist',             'Words on the page'],
            ['Formatter',          'Bold, italics and fonts in their place'],
            ['Styler',             'Styles that keep a document consistent'],
            ['Tabulator',          'Tabs and tables lined up'],
            ['Layout Artist',      'Columns, margins and breaks'],
            ['Mail Merger',        'One letter, a hundred names'],
            ['Editor',             'Tracked changes and comments'],
            ['Publisher',          'The top rank'],
        ],
        'catexcel' => [
            ['Cell',               'One box on the grid - everyone starts here'],
            ['Range',              'Many cells at once'],
            ['Formula',            'The sheet does the sums'],
            ['Function',           'SUM, AVERAGE and friends'],
            ['Chart',              'Numbers as pictures'],
            ['Lookup',             'Finding the right value in a table'],
            ['Pivot',              'Summing it up any way you like'],
            ['Analyst',            'The story in the numbers'],
            ['Spreadsheet Wizard', 'The top rank'],
        ],
        'catpowerpoint' => [
            ['Blank Slide',        'Nothing yet - everyone starts here'],
            ['Bullet',             'Points, short and clear'],
            ['Layout',             'Everything in its place on the slide'],
            ['Picture',            'Images that help the message'],
            ['Transition',         'From one slide to the next'],
            ['Animator',           'Movement with a purpose'],
            ['Storyteller',        'Slides that tell a story'],
            ['Speaker',            'You and your slides together'],
            ['Keynote Star',       'The top rank'],
        ],
        'cathtml' => [
            ['Plain Text',         'Words with no tags - everyone starts here'],
            ['Tag',                'Your first tags, opened and closed'],
            ['Attribute',          'Tags with details'],
            ['Table',              'Rows and cells in their place'],
            ['Hyperlink',          'Pages joined together'],
            ['Layout',             'A page that is easy to read'],
            ['Web Page',           'A whole page that works'],
            ['Website',            'Pages that work together'],
            ['Web Designer',       'The top rank'],
        ],
        'catdb' => [
            ['Field',              'One fact - everyone starts here'],
            ['Record',             'Everything about one thing'],
            ['Table',              'Records with the same fields'],
            ['Key',                'Every record found by its own value'],
            ['Query',              'Asking the data a question'],
            ['Form',               'Easy ways to put data in'],
            ['Report',             'Data printed and summed up'],
            ['Relationship',       'Tables linked by their keys'],
            ['Database Designer',  'The top rank'],
        ],
        'data' => [
            ['Bit',            'A single 0 or 1 - everyone starts here'],
            ['Nibble',         'Four bits - half a byte'],
            ['Byte',           'Eight bits - enough for one character'],
            ['Word',           'What a CPU handles in one go'],
            ['Kilobyte',       'About a thousand bytes'],
            ['Megabyte',       'About a million bytes'],
            ['Gigabyte',       'About a billion bytes'],
            ['Terabyte',       'A whole hard drive'],
            ['Petabyte',       'A data centre - the top rank'],
        ],
    ];

    return array_map (fn ($aName, $aXp) => [$aName[0], $aXp, $aName[1]], $names[RankFamily ($aCourseId)], $xp);
} // PracticeRanks


/** A rank's ComfyUI emblem (public/assets/rank-art/<family>/<index>.png), or '' while it has not been made. */
function PracticeRankArtUrl (int $anIndex, string $aCourseId) : string
{
    $path = '/assets/rank-art/' . RankFamily ($aCourseId) . '/' . $anIndex . '.png';

    return is_file (dirname (__DIR__) . '/public' . $path) ? AssetUrl ($path) : '';
} // PracticeRankArtUrl


/**
 * A rank's emblem (Chris, 25 September 2026: "for the levels have some image
 * that morphs / grow as level gets higher"): a chip of lit bits that grows
 * with the rank - Bit is one bit, Nibble 2x2, Byte ... Petabyte 9x9 - inside
 * a frame that turns from a circle to a hexagon, an octagon and a starburst,
 * in colours from slate to gold, glowing and (from Terabyte) orbited.
 * Drawn here as SVG so the lobby, the ladder and the rank-up banner match.
 */
function PracticeRankEmblem (int $aIndex, int $aSize = 64, string $aCourseId = '') : string
{
    $i       = max (0, min (8, $aIndex));

    // The course's own emblem, once ComfyUI has made it (1 October 2026); until then the drawn one below.
    $art = PracticeRankArtUrl ($i, $aCourseId);
    if ($art !== '') { return '<img class="rank-art" src="' . H ($art) . '" width="' . $aSize . '" height="' . $aSize . '" alt="' . H (PracticeRanks ($aCourseId)[$i][0]) . '">'; }

    $colours = [['#e2e8f0', '#64748b'], ['#99f6e4', '#0f766e'], ['#bbf7d0', '#15803d'], ['#fde68a', '#b45309'], ['#fed7aa', '#c2410c'],
                ['#fecdd3', '#be123c'], ['#ddd6fe', '#6d28d9'], ['#bae6fd', '#0369a1'], ['#fef08a', '#a16207']];
    [$light, $dark] = $colours[$i];
    $name    = PracticeRanks ($aCourseId)[$i][0];
    $id      = 'emb' . $i . '-' . $aSize;
    $r       = 32 + $i * 2;                              // the frame grows
    $sides   = [0, 0, 6, 6, 8, 8, 10, 12, 16][$i];

    if ($sides === 0)
    {
        $frame = '<circle cx="50" cy="50" r="' . $r . '"';
    }
    else
    {
        $points = [];
        $star   = $i >= 6;                                // a starburst for the top ranks
        for ($p = 0; $p < $sides * ($star ? 2 : 1); $p++)
        {
            $angle    = -M_PI / 2 + $p * M_PI / ($star ? $sides : $sides / 2);
            $radius   = ($star && $p % 2 === 1) ? $r * 0.84 : $r;
            $points[] = round (50 + $radius * cos ($angle), 1) . ',' . round (50 + $radius * sin ($angle), 1);
        } // for each corner
        $frame = '<polygon points="' . implode (' ', $points) . '"';
    } // if a circle or a polygon

    $svg = '<svg class="rank-emblem tier-' . $i . '" width="' . $aSize . '" height="' . $aSize . '" viewBox="0 0 100 100" role="img" aria-label="' . H ($name) . '">'
         . '<defs><radialGradient id="' . $id . '" cx="35%" cy="30%" r="75%"><stop offset="0" stop-color="' . $light . '"/><stop offset="1" stop-color="' . $dark . '"/></radialGradient></defs>';

    if ($i >= 7) { $svg .= '<circle class="orbit" cx="50" cy="50" r="' . ($r + 4) . '" fill="none" stroke="' . $light . '" stroke-width="2" stroke-dasharray="3 7"/>'; }

    $svg .= $frame . ' fill="url(#' . $id . ')" stroke="' . $dark . '" stroke-width="3" stroke-linejoin="round"/>'
          . '<ellipse cx="42" cy="30" rx="' . round ($r * 0.55) . '" ry="' . round ($r * 0.22) . '" fill="#fff" opacity="0.25"/>';

    // The bits: k x k, lit.
    $k    = $i + 1;
    $area = 18 + $i * 4.4;
    $cell = $area / $k;
    $gap  = $cell * 0.2;
    $x0   = 50 - $area / 2;

    $svg .= '<rect x="' . round ($x0 - 3, 1) . '" y="' . round ($x0 - 3, 1) . '" width="' . round ($area + 6, 1) . '" height="' . round ($area + 6, 1) . '" rx="4" fill="#0f172a" opacity="0.55"/>';

    for ($y = 0; $y < $k; $y++)
    {
        for ($x = 0; $x < $k; $x++)
        {
            $svg .= '<rect class="bit" style="--d:' . (($x * 7 + $y * 3) % 9) * 0.25 . 's" x="' . round ($x0 + $x * $cell + $gap / 2, 2) . '" y="' . round ($x0 + $y * $cell + $gap / 2, 2)
                  . '" width="' . round ($cell - $gap, 2) . '" height="' . round ($cell - $gap, 2) . '" rx="' . round (($cell - $gap) * 0.25, 2) . '" fill="' . $light . '"/>';
        } // for each column
    } // for each row

    if ($i === 8) { $svg .= '<text x="50" y="16" text-anchor="middle" font-size="16">👑</text>'; }

    return $svg . '</svg>';
} // PracticeRankEmblem


/** The rank for an XP total, and the next one: ['rank' => [...], 'next' => [...]|null, 'progress' => 0..100]. */
function PracticeRankFor (int $anXp, string $aCourseId = '') : array
{
    $ranks = PracticeRanks ($aCourseId);
    $index = 0;

    foreach ($ranks as $i => $rank) { if ($anXp >= $rank[1]) { $index = $i; } }

    $next     = $ranks[$index + 1] ?? null;
    $progress = ($next === null) ? 100 : (int) floor (100 * ($anXp - $ranks[$index][1]) / max (1, $next[1] - $ranks[$index][1]));

    return ['rank' => $ranks[$index], 'next' => $next, 'progress' => $progress, 'index' => $index];
} // PracticeRankFor


/** The icons a pupil may choose - emoji, drawn by their own device: no uploads, nothing to moderate. */
function PracticeIcons () : array
{
    return ['🦁', '🐘', '🦒', '🦓', '🐆', '🦏', '🐧', '🦉', '🐙', '🦈', '🐢', '🐝', '🦋', '🐉', '🦊', '🐼',
            '🐸', '🦄', '🐬', '🦜', '🚀', '🛰️', '🌍', '⭐', '🌙', '☄️', '⚡', '🔥', '💻', '⌨️', '🖱️', '💾',
            '🧠', '🤖', '👾', '🎮', '🧩', '🔭', '🏉', '⚽', '🏏', '🎸', '🎨', '🍕', '🌵', '🌈'];
} // PracticeIcons


/** The background colours for an icon, name => CSS colour. */
function PracticeColours () : array
{
    return ['teal' => '#0f5c6b', 'amber' => '#b8730c', 'green' => '#1d6b45', 'red' => '#9c2f2f',
            'cobalt' => '#274690', 'plum' => '#5b4380', 'slate' => '#4a5c66', 'pink' => '#b03a6f'];
} // PracticeColours


/**
 * Words that may not appear in a display name - English, Afrikaans and South
 * African slurs - matched after PracticeNormalise() (so "5h1t" and "s.h.i.t"
 * are caught). 'anywhere' words are refused inside any name; 'word' words
 * only as a whole word of the name, because they hide inside innocent ones
 * (skill, Dickens, analyst, grape, Cassius, the Afrikaans fokus). Broad on
 * purpose: a false alarm costs a pupil one more try; a miss puts a slur on a
 * school leaderboard. Add to it when something gets through.
 */
function PracticeBadWords () : array
{
    return [
        'anywhere' => [
            'fuck', 'shit', 'bitch', 'bastard', 'cunt', 'pussy', 'penis', 'vagina', 'whore', 'slut', 'wank', 'twat',
            'asshole', 'arsehole', 'porn', 'nigger', 'nigga', 'retard', 'dildo', 'nazi', 'hitler', 'suicide',
            'fokken', 'fokof', 'kaffir', 'kaffer', 'hotnot', 'boesman', 'houtkop', 'kwerekwere',
            'admin', 'teacher', 'itcoder', 'bestlessons', 'moderator', 'noome',
        ],
        'word' => [
            'ass', 'arse', 'sex', 'cum', 'anal', 'tits', 'boob', 'nude', 'cock', 'dick', 'prick', 'fag', 'rape', 'kill',
            'damn', 'crap', 'piss', 'bollock', 'bugger', 'milf', 'horny', 'paki', 'chink', 'spastic', 'fuk', 'fck',
            'poes', 'fok', 'kak', 'naai', 'doos', 'piel', 'moer', 'hoer', 'drol', 'gat', 'tiet', 'coolie', 'koelie',
        ],
    ];
} // PracticeBadWords


/** A name reduced for matching: lower case, look-alike digits and symbols turned into letters, only letters left, repeats squeezed. */
function PracticeNormalise (string $aText) : string
{
    $text = strtr (mb_strtolower ($aText), ['0' => 'o', '1' => 'i', '3' => 'e', '4' => 'a', '5' => 's', '7' => 't', '8' => 'b', '@' => 'a', '$' => 's', '!' => 'i', '|' => 'i', '+' => 't']);
    $text = preg_replace ('/[^a-z]/', '', $text);

    return preg_replace ('/(.)\1+/', '$1', $text);
} // PracticeNormalise


/**
 * What is wrong with a display name, or null if it may be used (see
 * PracticeBadWords() for which words are refused where).
 */
function PracticeNameProblem (string $aName, int $aPupilId) : ?string
{
    $name = trim (preg_replace ('/\s+/', ' ', $aName));

    if (mb_strlen ($name) < 3 || mb_strlen ($name) > 20) { return 'A name must be 3 to 20 characters long.'; }
    if (!preg_match ('/^[\p{L}\p{N} _\-]+$/u', $name))    { return 'Use only letters, numbers, spaces, - and _.'; }

    $squeezed = PracticeNormalise ($name);
    $words    = array_map ('PracticeNormalise', preg_split ('/[\s_\-]+/', $name));

    foreach (PracticeBadWords ()['anywhere'] as $bad)
    {
        if (str_contains ($squeezed, PracticeNormalise ($bad))) { return 'That name is not allowed. Choose another.'; }
    } // foreach word refused anywhere

    foreach (PracticeBadWords ()['word'] as $bad)
    {
        if (in_array (PracticeNormalise ($bad), $words, true)) { return 'That name is not allowed. Choose another.'; }
    } // foreach word refused as a whole word

    $taken = Db ()->prepare ('SELECT COUNT(*) FROM pupils WHERE LOWER(displayName) = LOWER(?) AND id <> ?');
    $taken->execute ([$name, $aPupilId]);

    if ((int) $taken->fetchColumn () > 0) { return 'Somebody already has that name. Choose another.'; }

    return null;
} // PracticeNameProblem


/** How a pupil appears on a leaderboard: their chosen name and icon - never their real name. */
function PracticeIdentity (array $aRow) : array
{
    $icons   = PracticeIcons ();
    $colours = PracticeColours ();
    $icon    = in_array ((string) ($aRow['avatar'] ?? ''), $icons, true) ? $aRow['avatar'] : $icons[((int) $aRow['id']) % count ($icons)];
    $colour  = $colours[(string) ($aRow['avatarColour'] ?? '')] ?? array_values ($colours)[((int) $aRow['id']) % count ($colours)];
    $name    = trim ((string) ($aRow['displayName'] ?? '')) !== '' ? $aRow['displayName'] : 'Coder ' . (1000 + (int) $aRow['id']);

    return ['name' => $name, 'icon' => $icon, 'colour' => $colour];
} // PracticeIdentity


/**
 * The name a pupil goes by on EVERY leaderboard - Practice's boards and the
 * course leaderboard on Achievements (Chris, 2 October 2026: one setting,
 * "Shown unless they opt out"; the course board was opt-in with
 * pupils.leaderboardOptIn until then, which is no longer read): their practice
 * name (PracticeIdentity ()), never their real name - or null for a pupil who
 * left the leaderboards (pupils.practiceHidden, My settings). The boards'
 * queries leave those pupils out with LeaderboardShownSql (), the same rule.
 */
function LeaderboardName (array $aPupil) : ?string
{
    return !empty ($aPupil['practiceHidden']) ? null : PracticeIdentity ($aPupil)['name'];
} // LeaderboardName


/** LeaderboardName ()'s rule in a board's query: only pupils who have not left the leaderboards ($anAlias: the pupils table's). */
function LeaderboardShownSql (string $anAlias) : string
{
    return 'COALESCE(' . $anAlias . '.practiceHidden, 0) = 0';
} // LeaderboardShownSql


function PracticeAvatarHtml (array $anIdentity, string $aSize = '') : string
{
    return '<span class="practice-avatar' . ($aSize !== '' ? ' is-' . $aSize : '') . '" style="background:' . H ($anIdentity['colour']) . '" aria-hidden="true">'
         . H ($anIdentity['icon']) . '</span>';
} // PracticeAvatarHtml


/**
 * The grade whose words a pupil plays (Chris, 25 September 2026: "allow them
 * to choose their grade - words should only be drawn from their grade's
 * glossary"): the one they chose, else the grade in their class ("Gr 11"),
 * else null - the page then asks. A round uses the words TAUGHT UP TO that
 * grade: a Grade 10 pupil never meets a Grade 11 word, and Grade 12's own
 * single words (nine) could not fill a round - its exam covers all three.
 */
function PracticeGrade (array $aPupil) : ?int
{
    $grade = (int) ($aPupil['practiceGrade'] ?? 0);
    if (in_array ($grade, [10, 11, 12], true)) { return $grade; }

    if (preg_match ('/^Gr\s*(10|11|12)$/i', trim ((string) ($aPupil['className'] ?? '')), $match)) { return (int) $match[1]; }

    return null;
} // PracticeGrade


/**
 * Whether a course's practice asks for a grade: only when its glossary spans
 * more than one grade (Pascal: 10 to 12). A one-grade course - the Grade 9
 * AI course (Chris, 25 September 2026: "no grade selection - all words for
 * everyone") - plays every word, with one daily challenge for all.
 */
function PracticeUsesGrades (string $aCourseId) : bool
{
    return count (GlossaryGrades ($aCourseId)) > 1;
} // PracticeUsesGrades


/** The grade whose words a pupil plays in a course: null = every word. */
function PracticeCourseGrade (array $aPupil, string $aCourseId) : ?int
{
    return PracticeUsesGrades ($aCourseId) ? PracticeGrade ($aPupil) : null;
} // PracticeCourseGrade


/** The symbols drifting behind the lobby's title - each course its own. */
function PracticeHeroGlyphs (string $aCourseId) : array
{
    return [
        'pascal' => [':=', '{ }', '01', ';', 'If', '<>', 'For', '[ ]', 'Div', 'Mod'],
        'java'   => ['{ }', '++', '==', ';', 'if', '&&', 'new', '[ ]', '->', '%'],
        'ai'     => ['GPU', '7B', '0.7', 'MW', 'VRAM', '4-bit', 'R', 'tok', '?', '$'],
        'sql'    => ['SELECT', '*', 'FROM', ';', 'WHERE', '%', 'tbl', '=', 'COUNT', '#'],
        'mlit10' => ['R', '%', '1:3', '½', 'kg', '≈', 'm²', '÷', '15%', '°C'],
    ][$aCourseId] ?? ['01', '{ }', '?', ';', 'A', '<>', 'B', '[ ]', '*', '#'];
} // PracticeHeroGlyphs


// -------------------------------------------------------------- the words ---

/** Every usable word: single words of letters only, 3 to 14 long, with a clue that does not give it away. */
function PracticeWords (string $aCourseId, ?int $aGrade = null) : array
{
    $words = [];

    foreach (GlossaryEntries ($aCourseId) as $entry)
    {
        $word = (string) $entry['term'];

        if (!preg_match ('/^[A-Za-z]{3,14}$/', $word)) { continue; }
        if ($aGrade !== null && (int) $entry['grade'] > $aGrade) { continue; }

        // Blank the word, and other spellings of it in 'also' (plurals, -ing
        // forms - names that start like it), out of its own clue. Other
        // 'also' names are related words, not the answer, and stay.
        $clue = (string) $entry['definition'];
        $stem = substr ($word, 0, min (4, strlen ($word)));

        foreach (array_merge ([$word], (array) ($entry['also'] ?? [])) as $name)
        {
            if (preg_match ('/^[A-Za-z]+$/', (string) $name) && stripos ((string) $name, $stem) === 0)
            {
                $clue = preg_replace ('/\b' . preg_quote ((string) $name, '/') . '\b/i', '____', $clue);
            } // if a single word
        } // foreach name

        $words[strtoupper ($word)] = ['word' => strtoupper ($word), 'display' => $word, 'clue' => $clue, 'meaning' => (string) $entry['definition'], 'grade' => (int) $entry['grade']];
    } // foreach glossary entry

    return $words;
} // PracticeWords


/** Days until a word in each Leitner box is asked again. */
const PRACTICE_BOX_DAYS = [0, 1, 3, 7, 14, 30];

/** Boxes from here up count as known ("mastered"). */
const PRACTICE_MASTERED_BOX = 4;

/**
 * The words for a round ($aCount: 20, or the game's 'words'). The day's
 * challenge is the same for everyone, seeded by the date. Any other round is
 * spaced repetition: up to 12 words in 20 that are due (lowest box and most
 * missed first), then words never met, then the rest - shuffled together.
 */
function PracticePickWords (string $aCourseId, bool $aDaily, ?int $aGrade = null, int $aPupilId = 0, int $aCount = PRACTICE_ROUND_WORDS) : array
{
    $words = PracticeWords ($aCourseId, $aGrade);
    $mostDue = (int) round ($aCount * 0.6);   // 12 of 20, 6 of 10 (6 October 2026: Say what it means plays 10)

    if ($aDaily)
    {
        $words = array_values ($words);
        mt_srand (crc32 ('daily-' . $aCourseId . '-' . (int) $aGrade . '-' . SaToday ()));   // the South African day (1 October 2026: was UTC)
        for ($i = count ($words) - 1; $i > 0; $i--) { $j = mt_rand (0, $i); [$words[$i], $words[$j]] = [$words[$j], $words[$i]]; }
        mt_srand ();
        return array_slice ($words, 0, $aCount);
    } // if the daily challenge

    $known = PracticeWordBoxes ($aPupilId, $aCourseId);
    $due   = [];
    $new   = [];
    $rest  = [];
    $today = SaToday ();

    foreach ($words as $key => $word)
    {
        if (!isset ($known[$key]))                 { $new[]  = $word; }
        elseif ($known[$key]['due'] <= $today)     { $due[]  = $word + ['sort' => [$known[$key]['box'], -$known[$key]['missed']]]; }
        else                                       { $rest[] = $word; }
    } // foreach word

    shuffle ($due);
    usort ($due, fn ($a, $b) => $a['sort'] <=> $b['sort']);
    shuffle ($new);
    shuffle ($rest);

    $round = array_slice ($due, 0, $mostDue);
    $round = array_merge ($round, array_slice ($new, 0, $aCount - count ($round)));
    $round = array_merge ($round, array_slice (array_merge (array_slice ($due, $mostDue), $rest), 0, $aCount - count ($round)));
    shuffle ($round);

    return array_map (function ($w) { unset ($w['sort']); return $w; }, $round);
} // PracticePickWords


/** A pupil's words so far: WORD => [box, due, asked, missed]. */
function PracticeWordBoxes (int $aPupilId, string $aCourseId) : array
{
    $statement = Db ()->prepare ('SELECT word, box, due, asked, missed FROM practiceWords WHERE pupilId = ? AND courseId = ?');
    $statement->execute ([$aPupilId, $aCourseId]);

    $boxes = [];
    foreach ($statement->fetchAll () as $row) { $boxes[$row['word']] = ['box' => (int) $row['box'], 'due' => $row['due'], 'asked' => (int) $row['asked'], 'missed' => (int) $row['missed']]; }

    return $boxes;
} // PracticeWordBoxes


/** Moves each word of a finished round up a box (right) or back to box 0 (missed). */
function PracticeUpdateBoxes (int $aPupilId, string $aCourseId, array $aWords, array $aCorrect) : void
{
    $known  = PracticeWordBoxes ($aPupilId, $aCourseId);
    $right  = array_flip ($aCorrect);
    $upsert = Db ()->prepare (
        'INSERT INTO practiceWords (pupilId, courseId, word, box, due, asked, missed, lastSeenAt) VALUES (?, ?, ?, ?, ?, 1, ?, ?)
         ON CONFLICT (pupilId, courseId, word) DO UPDATE SET box = excluded.box, due = excluded.due,
             asked = asked + 1, missed = missed + excluded.missed, lastSeenAt = excluded.lastSeenAt'
    );

    foreach ($aWords as $word)
    {
        $gotIt = isset ($right[$word]);
        $box   = $gotIt ? min (5, ($known[$word]['box'] ?? 0) + 1) : 0;
        $due   = SaToday (PRACTICE_BOX_DAYS[$box]);

        $upsert->execute ([$aPupilId, $aCourseId, $word, $box, $due, $gotIt ? 0 : 1, Now ()]);
    } // foreach word in the round
} // PracticeUpdateBoxes


/** How far a pupil has got with the words: ['due' => n, 'learning' => n, 'mastered' => n, 'new' => n]. */
function PracticeWordProgress (int $aPupilId, string $aCourseId, ?int $aGrade = null) : array
{
    $all   = PracticeWords ($aCourseId, $aGrade);
    $known = array_intersect_key (PracticeWordBoxes ($aPupilId, $aCourseId), $all);
    $today = SaToday ();

    return [
        'due'      => count (array_filter ($known, fn ($w) => $w['due'] <= $today)),
        'mastered' => count (array_filter ($known, fn ($w) => $w['box'] >= PRACTICE_MASTERED_BOX)),
        'learning' => count (array_filter ($known, fn ($w) => $w['box'] < PRACTICE_MASTERED_BOX)),
        'new'      => count ($all) - count ($known),
    ];
} // PracticeWordProgress


// ------------------------------------------------------------- the rounds ---

/** Starts a round: stores it and returns [token, words]. */
function PracticeStartRound (int $aPupilId, string $aCourseId, string $aGame, bool $aDaily, ?int $aGrade) : array
{
    $words = PracticePickWords ($aCourseId, $aDaily, $aGrade, $aPupilId, (int) (PracticeGames ()[$aGame]['words'] ?? PRACTICE_ROUND_WORDS));
    $token = bin2hex (random_bytes (16));

    Db ()->prepare (
        'INSERT INTO practiceRounds (pupilId, courseId, game, daily, token, words, startedAt, grade) VALUES (?, ?, ?, ?, ?, ?, ?, ?)'
    )->execute ([$aPupilId, $aCourseId, $aGame, $aDaily ? 1 : 0, $token, json_encode (array_column ($words, 'word')), Now (), $aGrade]);

    return [$token, $words];
} // PracticeStartRound


/**
 * Finishes a round. $aCorrect is the list of words the page says were got
 * right; only words that were really in the round count. $aPlayed, when
 * given, is the words the game could use - a crossword or word search may
 * not fit all 20 - and the round is scored out of those. Returns the result
 * for the page, or an error.
 *
 * $aPlayedTrusted (Say what it means, 6 October 2026): $aPlayed is the
 * server's own list - the round's words less those Jev could not check - so
 * it is used however short (an unchecked word is skipped, never missed), and
 * a round of fewer than 5 such words earns no perfect-round bonus.
 */
function PracticeFinishRound (int $aPupilId, string $aToken, array $aCorrect, ?array $aPlayed = null, array $aHinted = [], ?array $anEarning = null, bool $aPlayedTrusted = false) : array
{
    $pdo   = Db ();
    $round = $pdo->prepare ('SELECT * FROM practiceRounds WHERE token = ? AND pupilId = ?');
    $round->execute ([$aToken, $aPupilId]);
    $round = $round->fetch ();

    if ($round === false)                  { return ['error' => 'That round was not found. Start a new one.']; }
    if ($round['finishedAt'] !== null)     { return ['error' => 'That round is already finished.']; }

    $game    = PracticeGames ()[$round['game']] ?? null;
    $words   = (array) json_decode ((string) $round['words'], true);

    if ($aPlayed !== null)
    {
        $played = array_values (array_intersect ($words, array_map (fn ($w) => strtoupper ((string) $w), $aPlayed)));
        if (count ($played) >= 5 || $aPlayedTrusted) { $words = $played; }
    } // if the game used only some of the words
    $correct = array_values (array_intersect ($words, array_unique (array_map (fn ($w) => strtoupper ((string) $w), $aCorrect))));
    $seconds = time () - strtotime ((string) $round['startedAt']);

    if ($game === null) { return ['error' => 'Unknown game.']; }

    // Faster than anyone could really play: count nothing, but say why.
    if ($seconds < count ($correct) * $game['minSeconds'])
    {
        $pdo->prepare ('UPDATE practiceRounds SET finishedAt = ?, correct = 0, xp = 0 WHERE id = ?')->execute ([Now (), $round['id']]);
        return ['error' => 'That was faster than anyone could play - the round did not count.'];
    } // if impossibly fast

    // A word got with a hint (the crossword's) earns half; a perfect round
    // needs no hints. Hinted words count as missed for spaced repetition.
    $hinted = array_values (array_intersect ($correct, array_map (fn ($w) => strtoupper ((string) $w), $aHinted)));
    // $anEarning: the words that may earn XP (flash cards: the ones spoken -
    // api/practice-finish.php); null = every word got right.
    $earned = ($anEarning === null) ? $correct : array_values (array_intersect ($correct, array_map (fn ($w) => strtoupper ((string) $w), $anEarning)));
    $hinted = array_values (array_intersect ($hinted, $earned));
    $xp     = (count ($earned) - count ($hinted)) * $game['xp'] + count ($hinted) * intdiv ($game['xp'], 2);
    if (count ($earned) === count ($words) && count ($words) > 0 && count ($hinted) === 0 && (!$aPlayedTrusted || count ($words) >= 5)) { $xp += 10; }   // a perfect round
    // The speed bonus (Chris, 25 September 2026: "add a multiplier for time -
    // shorter time = more experience"): against par seconds for each word
    // got right, from x1 at par up to x1.5 for (impossibly) no time at all.
    $par   = $game['par'] * max (1, count ($correct));
    $speed = count ($earned) > 0 ? round (min (1.5, max (1.0, 1 + 0.5 * (1 - $seconds / $par))), 2) : 1.0;
    $xp    = (int) round ($xp * $speed);

    if ((int) $round['daily'] === 1) { $xp *= 2; }

    $before = PracticeStats ($aPupilId, $round['courseId']);

    $pdo->prepare ('UPDATE practiceRounds SET finishedAt = ?, correct = ?, total = ?, seconds = ?, xp = ? WHERE id = ?')
        ->execute ([Now (), count ($correct), count ($words), $seconds, $xp, $round['id']]);

    if (empty ($game['noBoxes'])) { PracticeUpdateBoxes ($aPupilId, $round['courseId'], $words, array_values (array_diff ($correct, $hinted))); }

    $after = PracticeStats ($aPupilId, $round['courseId']);

    return [
        'correct'   => count ($correct),
        'total'     => count ($words),
        'xp'        => $xp,
        'totalXp'   => $after['xp'],
        'rank'      => $after['rank']['rank'][0],
        'emblem'    => PracticeRankEmblem ($after['rank']['index'], 110, $round['courseId']),
        'rankUp'    => $after['rank']['rank'][0] !== $before['rank']['rank'][0],
        'newBadges' => array_values (array_diff_key ($after['badges'], $before['badges'])),
        'streak'    => $after['streak'],
        'hinted'    => count ($hinted),
        'unearned'  => count ($correct) - count ($earned),   // right, but earned no XP (flash cards not spoken)
        'speed'     => $speed,
        'seconds'   => $seconds,
    ];
} // PracticeFinishRound


/** A pupil's totals in a course: XP, rank, streak, badges, best per game. */
function PracticeStats (int $aPupilId, string $aCourseId) : array
{
    $rows = Db ()->prepare ('SELECT game, daily, correct, total, xp, finishedAt FROM practiceRounds
                             WHERE pupilId = ? AND courseId = ? AND finishedAt IS NOT NULL ORDER BY finishedAt');
    $rows->execute ([$aPupilId, $aCourseId]);
    $rows = $rows->fetchAll ();

    $xp = 0; $best = []; $days = []; $perfect = false; $games = []; $daily = 0; $words = 0;

    foreach ($rows as $row)
    {
        $xp    += (int) $row['xp'];
        $words += (int) $row['correct'];
        $best[$row['game']] = max ($best[$row['game']] ?? 0, (int) $row['correct']);
        $days[SaFormat ((string) $row['finishedAt'], 'Y-m-d')] = true;   // South African days (1 October 2026: were UTC)
        if ((int) $row['total'] > 0 && (int) $row['correct'] === (int) $row['total']) { $perfect = true; }
        if ((int) $row['correct'] > 0) { $games[$row['game']] = true; }
        if ((int) $row['daily'] === 1) { $daily++; }
    } // foreach finished round

    // The streak: days in a row, ending today or yesterday - South African
    // days, counted back from SaToday () (1 October 2026; a round played
    // between midnight and 02:00 counted for the day before).
    $streak = 0;
    $back   = 0;
    if (!isset ($days[SaToday ()])) { $back = -1; }
    while (isset ($days[SaToday ($back)])) { $streak++; $back--; }

    $badges = [];
    if (count ($rows) >= 1)  { $badges['first']    = ['🎉', 'First round', 'Played your first round']; }
    if ($perfect)            { $badges['perfect']  = ['💯', 'Perfect round', 'Got all 20 words in a round']; }
    if (count ($games) >= count (PracticeGamesFor ($aCourseId))) { $badges['allgames'] = ['🎲', 'All-rounder', 'Scored in every game']; }
    if ($streak >= 3 || count ($days) >= 3) { $badges['streak3'] = ['🔥', 'On fire', 'Played on three days']; }
    if ($streak >= 7)        { $badges['streak7']  = ['🗓️', 'A whole week', 'Played seven days in a row']; }
    if ($daily >= 5)         { $badges['daily5']   = ['☀️', 'Daily regular', 'Did five daily challenges']; }
    if ($words >= 100)       { $badges['words100'] = ['📚', 'Century', '100 words right']; }
    if ($words >= 500)       { $badges['words500'] = ['🏆', 'Word master', '500 words right']; }

    $mastered = PracticeWordProgress ($aPupilId, $aCourseId)['mastered'];
    if ($mastered >= 25)     { $badges['mastered25'] = ['🧠', 'Sharp memory', '25 words mastered']; }
    if ($mastered >= 100)    { $badges['mastered100'] = ['🎓', 'Walking glossary', '100 words mastered']; }

    return ['xp' => $xp, 'rank' => PracticeRankFor ($xp, $aCourseId), 'streak' => $streak, 'badges' => $badges, 'best' => $best, 'rounds' => count ($rows), 'words' => $words];
} // PracticeStats


/**
 * A leaderboard: 'week' (XP since Monday), 'all' (all XP) or 'daily'
 * (today's challenge, best round each). Pupils who left the leaderboards are
 * not listed (LeaderboardShownSql ()). Returns rows with identity, xp and position.
 */
function PracticeLeaderboard (string $aCourseId, string $aKind, int $aLimit = 20, ?int $aGrade = null) : array
{
    $where = 'r.courseId = ? AND r.finishedAt IS NOT NULL AND ' . LeaderboardShownSql ('p');
    $args  = [$aCourseId];

    // This week: since Monday, South African time, as the other boards count it (1 October 2026: was the last 7 days).
    if ($aKind === 'week')  { $where .= ' AND r.finishedAt >= ?'; $args[] = SaDayStartUtc (SaWeekStart ()); }
    // Today's challenge: rounds finished on this South African day (1 October 2026: was the UTC date).
    if ($aKind === 'daily') { $where .= ' AND r.daily = 1 AND r.finishedAt >= ? AND r.finishedAt < ? AND r.grade IS ?'; array_push ($args, SaDayStartUtc (SaToday ()), SaDayStartUtc (SaToday (1)), $aGrade); }   // each grade has its own challenge

    $score = ($aKind === 'daily') ? 'MAX(r.xp)' : 'SUM(r.xp)';
    $args[] = $aLimit;

    $statement = Db ()->prepare (
        "SELECT p.id, p.displayName, p.avatar, p.avatarColour, {$score} AS score
         FROM practiceRounds r JOIN pupils p ON p.id = r.pupilId
         WHERE {$where}
         GROUP BY p.id HAVING score > 0 ORDER BY score DESC, MIN(r.finishedAt) LIMIT ?"
    );
    $statement->execute ($args);

    $rows = [];
    foreach ($statement->fetchAll () as $i => $row)
    {
        $rows[] = ['position' => $i + 1, 'id' => (int) $row['id'], 'score' => (int) $row['score'], 'identity' => PracticeIdentity ($row)];
    } // foreach row

    return $rows;
} // PracticeLeaderboard


/**
 * This week's class-against-class board: XP since Monday per class,
 * divided by the class's members in the course, so a small class that plays
 * hard beats a big one that barely plays. School classes only (the class
 * chosen at sign-in, not Staff or Other) - by class name and year.
 */
function PracticeClassBoard (string $aCourseId) : array
{
    $since     = SaDayStartUtc (SaWeekStart ());   // this week, since Monday (1 October 2026: was the last 7 days)
    $statement = Db ()->prepare (
        "SELECT p.className, p.classYear, COUNT(DISTINCT p.id) AS members,
                COUNT(DISTINCT r.pupilId) AS players, COALESCE(SUM(r.xp), 0) AS xp
         FROM pupils p JOIN enrolments e ON e.pupilId = p.id AND e.courseId = ?
         LEFT JOIN practiceRounds r ON r.pupilId = p.id AND r.courseId = e.courseId AND r.finishedAt >= ?
         WHERE p.className IS NOT NULL AND p.className NOT IN ('Staff', 'Other') AND COALESCE(p.isTeacher, 0) = 0
         GROUP BY p.className, p.classYear"
    );
    $statement->execute ([$aCourseId, $since]);

    $rows = [];
    foreach ($statement->fetchAll () as $row)
    {
        if ((int) $row['xp'] <= 0) { continue; }
        $rows[] = ['name' => $row['className'] . ($row['classYear'] ? ' (' . $row['classYear'] . ')' : ''), 'members' => (int) $row['members'],
                   'players' => (int) $row['players'], 'xp' => (int) $row['xp'], 'average' => (int) round ((int) $row['xp'] / max (1, (int) $row['members']))];
    } // foreach class

    usort ($rows, fn ($a, $b) => $b['average'] <=> $a['average']);
    foreach ($rows as $i => &$row) { $row['position'] = $i + 1; }

    return $rows;
} // PracticeClassBoard


/**
 * Practice for the teacher's page: each pupil's XP (week and all), rounds and
 * last round, and the words these pupils miss most (at least 3 asks).
 */
function PracticeTeacherReport (string $aCourseId, array $aPupilIds) : array
{
    if (count ($aPupilIds) === 0) { return ['pupils' => [], 'words' => []]; }

    $in    = implode (',', array_fill (0, count ($aPupilIds), '?'));
    $since = SaDayStartUtc (SaWeekStart ());   // this week, since Monday (1 October 2026: was the last 7 days)
    $pdo   = Db ();

    $statement = $pdo->prepare (
        "SELECT r.pupilId, p.displayName, p.avatar, p.avatarColour, COUNT(*) AS rounds, SUM(r.xp) AS xp,
                SUM(CASE WHEN r.finishedAt >= ? THEN r.xp ELSE 0 END) AS week, MAX(r.finishedAt) AS last
         FROM practiceRounds r JOIN pupils p ON p.id = r.pupilId
         WHERE r.courseId = ? AND r.finishedAt IS NOT NULL AND r.pupilId IN ($in) GROUP BY r.pupilId"
    );
    $statement->execute (array_merge ([$since, $aCourseId], $aPupilIds));

    $pupils = [];
    foreach ($statement->fetchAll () as $row) { $pupils[(int) $row['pupilId']] = $row; }

    $statement = $pdo->prepare (
        "SELECT word, SUM(asked) AS asked, SUM(missed) AS missed, COUNT(*) AS pupils
         FROM practiceWords WHERE courseId = ? AND pupilId IN ($in)
         GROUP BY word HAVING SUM(asked) >= 3 AND SUM(missed) > 0
         ORDER BY 1.0 * SUM(missed) / SUM(asked) DESC, SUM(missed) DESC LIMIT 25"
    );
    $statement->execute (array_merge ([$aCourseId], $aPupilIds));

    $all   = PracticeWords ($aCourseId);
    $words = [];
    foreach ($statement->fetchAll () as $row)
    {
        if (!isset ($all[$row['word']])) { continue; }   // no longer in the glossary
        $words[] = ['word' => $all[$row['word']]['display'], 'meaning' => $all[$row['word']]['meaning'], 'asked' => (int) $row['asked'],
                    'missed' => (int) $row['missed'], 'pupils' => (int) $row['pupils'], 'percent' => (int) round (100 * $row['missed'] / max (1, $row['asked']))];
    } // foreach word

    return ['pupils' => $pupils, 'words' => $words];
} // PracticeTeacherReport


// ------------------------------------------------------------ speech ---
//
// Flash cards can listen (Chris, 25 September 2026): the pupil says the word,
// whisper.cpp on this server writes down what it heard, and it counts if it
// sounds like the answer. Nothing leaves the server and the audio is deleted
// the moment it is transcribed. The browser records and sends 16 kHz mono
// 16-bit WAV (so the server needs no ffmpeg); the round's words go to
// Whisper as its prompt, which is what lets it spell IntToStr and Readln.
// Measured on the VPS (4 vCPU EPYC, base.en, -ac 384): about 0.7 s a word.

const PRACTICE_SPEECH_SLOTS = 2;   // words transcribed at once; the compiler shares these cores

function PracticeSpeechPaths () : array
{
    $config = function_exists ('LoadConfig') ? LoadConfig () : [];

    return [
        'cli'   => (string) ($config['whisperCli']   ?? '/opt/whisper.cpp/build/bin/whisper-cli'),
        'model' => (string) ($config['whisperModel'] ?? '/opt/whisper.cpp/models/ggml-base.en.bin'),
    ];
} // PracticeSpeechPaths


function PracticeSpeechAvailable () : bool
{
    $paths = PracticeSpeechPaths ();

    return is_file ($paths['cli']) && is_executable ($paths['cli']) && is_file ($paths['model']);
} // PracticeSpeechAvailable


/** Null if the bytes are a short 16 kHz mono 16-bit PCM WAV, else what is wrong. */
function PracticeWavProblem (string $aBytes) : ?string
{
    if (strlen ($aBytes) < 44 || strlen ($aBytes) > 16000 * 2 * 6 + 1024) { return 'The recording was empty or too long.'; }
    if (substr ($aBytes, 0, 4) !== 'RIFF' || substr ($aBytes, 8, 4) !== 'WAVE' || substr ($aBytes, 12, 4) !== 'fmt ') { return 'That is not a WAV recording.'; }

    $format = unpack ('vcode/vchannels/Vrate/Vbytes/valign/vbits', substr ($aBytes, 20, 16));

    if ($format['code'] !== 1 || $format['channels'] !== 1 || $format['rate'] !== 16000 || $format['bits'] !== 16) { return 'The recording must be 16 kHz mono.'; }

    return null;
} // PracticeWavProblem


/** What Whisper heard in a WAV file, with the round's words as its prompt; null if it could not run. */
function PracticeTranscribe (string $aWavPath, array $aPromptWords) : ?string
{
    $paths = PracticeSpeechPaths ();

    // One of a few slots, so a class speaking at once queues instead of
    // starting thirty copies of the model.
    $lock = null;
    for ($wait = 0; $wait < 100 && $lock === null; $wait++)
    {
        for ($slot = 0; $slot < PRACTICE_SPEECH_SLOTS && $lock === null; $slot++)
        {
            $handle = fopen (sys_get_temp_dir () . '/bestlessons-whisper-' . $slot . '.lock', 'c');
            if ($handle !== false && flock ($handle, LOCK_EX | LOCK_NB)) { $lock = $handle; }
            elseif ($handle !== false) { fclose ($handle); }
        } // for each slot
        if ($lock === null) { usleep (100000); }
    } // until a slot is free, for up to 10 seconds

    if ($lock === null) { return null; }

    $prompt  = implode (', ', array_map (fn ($aWord) => preg_replace ('/[^A-Za-z]/', '', (string) $aWord), $aPromptWords));
    $command = [$paths['cli'], '-m', $paths['model'], '-f', $aWavPath, '-nt', '-np', '-l', 'en', '-t', '2', '-ac', '384', '--prompt', $prompt];
    $process = proc_open ($command, [0 => ['pipe', 'r'], 1 => ['pipe', 'w'], 2 => ['file', '/dev/null', 'w']], $pipes, sys_get_temp_dir ());

    if (!is_resource ($process)) { flock ($lock, LOCK_UN); fclose ($lock); return null; }

    fclose ($pipes[0]);
    stream_set_blocking ($pipes[1], false);
    $output = '';
    $until  = microtime (true) + 15;

    while (microtime (true) < $until)
    {
        $output .= (string) stream_get_contents ($pipes[1]);
        if (!proc_get_status ($process)['running']) { break; }
        usleep (20000);
    } // while it runs, for up to 15 seconds

    $output .= (string) stream_get_contents ($pipes[1]);
    if (proc_get_status ($process)['running']) { proc_terminate ($process, 9); }
    fclose ($pipes[1]);
    proc_close ($process);
    flock ($lock, LOCK_UN);
    fclose ($lock);

    return trim (preg_replace ('/\s+/', ' ', $output));
} // PracticeTranscribe


/**
 * Whether what was heard is the word: letters only, lower case, compared
 * with the word and with how it is said aloud (IntToStr: "int to string",
 * Readln: "read line", SQLite: "sequel lite"), allowing a slip of about one
 * letter in four, a sound-alike (metaphone), or the word inside a longer
 * answer ("it's a variable").
 */
function PracticeSpokenMatches (string $aHeard, string $aWord) : bool
{
    $heard = strtolower (preg_replace ('/[^A-Za-z]/', '', $aHeard));
    if ($heard === '') { return false; }

    $spoken = preg_replace ('/([a-z])([A-Z])/', '$1 $2', $aWord);
    $parts  = preg_split ('/\s+/', strtolower ($spoken));
    $aloud  = ['str' => 'string', 'int' => 'integer', 'ln' => 'line', 'sql' => 'sequel', 'char' => 'character', 'bool' => 'boolean',
               'dec' => 'decrement', 'inc' => 'increment', 'val' => 'value', 'eof' => 'endoffile', 'eoln' => 'endofline',
               'avg' => 'average', 'rnd' => 'random', 'ucase' => 'uppercase', 'popia' => 'popeye', 'gigo' => 'guygo'];   // SQL

    $forms = [strtolower (preg_replace ('/[^A-Za-z]/', '', $aWord)), implode ('', array_map (fn ($p) => $aloud[$p] ?? $p, $parts))];
    if (strcasecmp ($aWord, 'SQLite') === 0)  { array_push ($forms, 'sequellite', 'sequellight', 'esquelite', 'esqulite', 'esquellite'); }
    elseif (stripos ($aWord, 'sql') === 0)     { $forms[] = 'sequel' . strtolower (substr ($aWord, 3)); $forms[] = 'esquel' . strtolower (substr ($aWord, 3)); }
    if (preg_match ('/ln$/i', $aWord)) { $forms[] = strtolower (substr ($aWord, 0, -2)) . 'line'; $forms[] = strtolower (substr ($aWord, 0, -2)) . 'ln'; }

    foreach (array_unique ($forms) as $form)
    {
        $slack = max (1, intdiv (strlen ($form), 4));

        if (str_contains ($heard, $form))                                         { return true; }
        if (levenshtein ($heard, $form) <= $slack)                                 { return true; }
        if (strlen ($form) >= 4 && metaphone ($heard) === metaphone ($form))       { return true; }
    } // foreach way of saying it

    return false;
} // PracticeSpokenMatches


/** The practice pages' form token - the profile form and practice.js's posts (data-token). */
function PracticeToken () : string
{
    return FormToken ('practice');   // lib/auth.php
} // PracticeToken


/** The name-and-icon form for My account. */
function PracticeProfileFormHtml (array $aPupil, string $aBack = '') : string
{
    $identity = PracticeIdentity ($aPupil);
    $html     = '<form method="post" action="/practice-profile.php" class="practice-profile">'
              . FormTokenInput ('practice') . ($aBack !== '' ? '<input type="hidden" name="back" value="' . H ($aBack) . '">' : '')
              . '<p class="practice-profile-preview">' . PracticeAvatarHtml ($identity, 'big') . ' <strong>' . H ($identity['name']) . '</strong></p>'
              . '<label>Display name <input name="displayName" maxlength="20" value="' . H ((string) ($aPupil['displayName'] ?? '')) . '" placeholder="' . H ($identity['name']) . '"></label>'
              . '<fieldset class="practice-icons"><legend>Icon</legend>';

    foreach (PracticeIcons () as $icon)
    {
        $html .= '<label class="practice-icon-choice"><input type="radio" name="avatar" value="' . H ($icon) . '"'
               . ($icon === $identity['icon'] ? ' checked' : '') . '><span>' . H ($icon) . '</span></label>';
    } // foreach icon

    $html .= '</fieldset><fieldset class="practice-colours"><legend>Colour</legend>';

    foreach (PracticeColours () as $name => $colour)
    {
        $html .= '<label class="practice-colour-choice" title="' . H ($name) . '"><input type="radio" name="avatarColour" value="' . H ($name) . '"'
               . ($colour === $identity['colour'] ? ' checked' : '') . '><span style="background:' . H ($colour) . '"></span></label>';
    } // foreach colour

    return $html . '</fieldset>'
         . '<label class="practice-hide"><input type="checkbox" name="practiceHidden" value="1"' . (!empty ($aPupil['practiceHidden']) ? ' checked' : '') . '> Leave me off every leaderboard (Practice and Achievements)</label>'
         . '<button type="submit">Save</button></form>';
} // PracticeProfileFormHtml
