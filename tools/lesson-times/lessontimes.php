<?php
// Lesson length per persona (site review, 4 October 2026). Run from AIPascalCourse/public.
// The minutes come from LessonTimeMinutes() (AIPascalCourse/lib/lessontime.php); this script adds the
// words, video and question counts for AIResources/lesson-times.html.
// Reads every lesson's blocks, keeps one exam board's sections and one SQL database's
// copies, and times reading, videos and every exercise for three pupils.
require '../lib/course.php';
require_once '../lib/content.php';
require_once '../lib/lessontime.php';   // the times themselves come from the platform, so the report and the course page agree

$videoSeconds = [];
foreach (file ('' . __DIR__ . '/vidlen.txt') as $line)
{
    [$id, $s] = array_pad (preg_split ('/\s+/', trim ($line)), 2, '?');
    if (ctype_digit ($s)) { $videoSeconds[$id] = (int) $s; }
}

// Seconds per unit for each persona: Thandi (quick, Gr 11), Lerato (typical), Sipho (slow reader, Gr 9).
$P = [
    'fast' => ['wpm' => 230, 'codeWpm' => 120, 'quiz' => 20, 'select' => 35, 'typed' => 30, 'order' => 50, 'matchLine' => 12, 'item' => 12,
               'zone' => 12, 'cell' => 15, 'writtenMark' => 60, 'code' => 240, 'sqlquery' => 150, 'sql' => 45, 'reveal' => 25, 'videoX' => 1.0,
               'dilemmaScene' => 40, 'step' => 25, 'retry' => 0.10, 'overhead' => 60],
    'mid'  => ['wpm' => 160, 'codeWpm' => 80,  'quiz' => 35, 'select' => 60, 'typed' => 55, 'order' => 90, 'matchLine' => 22, 'item' => 22,
               'zone' => 22, 'cell' => 28, 'writtenMark' => 110, 'code' => 480, 'sqlquery' => 300, 'sql' => 75, 'reveal' => 40, 'videoX' => 1.15,
               'dilemmaScene' => 60, 'step' => 40, 'retry' => 0.25, 'overhead' => 120],
    'slow' => ['wpm' => 105, 'codeWpm' => 50,  'quiz' => 55, 'select' => 95, 'typed' => 90, 'order' => 150, 'matchLine' => 35, 'item' => 35,
               'zone' => 35, 'cell' => 45, 'writtenMark' => 180, 'code' => 840, 'sqlquery' => 480, 'sql' => 110, 'reveal' => 60, 'videoX' => 1.4,
               'dilemmaScene' => 90, 'step' => 60, 'retry' => 0.45, 'overhead' => 180],
];

function Words (string $aHtml) : int
{
    $text = html_entity_decode (strip_tags (preg_replace ('/<(br|p|li|td|th|div|h\d)[^>]*>/i', ' ', $aHtml)), ENT_QUOTES);
    return count (preg_split ('/\s+/u', trim ($text), -1, PREG_SPLIT_NO_EMPTY));
}

function TextOf ($aValue) : string
{
    if (is_string ($aValue)) { return $aValue; }
    if (is_array ($aValue)) { return implode (' ', array_map ('TextOf', $aValue)); }
    return '';
}

$rows = [];

foreach (ActiveCourses () as $courseId => $course)
{
    foreach (LessonIndex ($courseId) as $lessonId => $lesson)
    {
        if (!LessonExists ($courseId, (string) $lessonId)) { continue; }

        $blocks  = LoadLesson ($courseId, (string) $lessonId);
        $dialect = null;
        foreach ($blocks as $b) { if (isset ($b['dialect'])) { $dialect = (string) $b['dialect']; break; } }
        $boards  = [];
        foreach ($blocks as $b) { if (($b['type'] ?? '') === 'board') { $boards[(string) $b['board']] = true; } }
        $boardRuns = count ($boards) > 0 ? array_keys ($boards) : [''];

        $perBoard = [];

        foreach ($boardRuns as $myBoard)
        {
            $c = ['words' => 0, 'codeWords' => 0, 'video' => 0, 'videoUnknown' => 0, 'q' => 0];
            $t = array_fill_keys (array_keys ($P), 0.0);
            $inBoard = null;

            foreach ($blocks as $b)
            {
                $type = $b['type'] ?? '';
                if ($type === 'board')    { $inBoard = (string) $b['board']; continue; }
                if ($type === 'boardend') { $inBoard = null; continue; }
                if ($inBoard !== null && $inBoard !== $myBoard) { continue; }
                if (isset ($b['board']) && $myBoard !== '' && (string) $b['board'] !== $myBoard) { continue; }
                if (isset ($b['dialect']) && (string) $b['dialect'] !== $dialect) { continue; }

                $read = 0; $code = 0;
                $do = array_fill_keys (array_keys ($P), 0.0);
                $isQ = false;

                switch ($type)
                {
                    case 'prose': case 'goodtoknow': case 'algorithm': case 'important': case 'errors': case 'enrichment':
                        $read = Words (TextOf ($b['html'] ?? '') . ' ' . TextOf ($b['intro'] ?? '') . ' ' . TextOf ($b['items'] ?? '') . ' ' . TextOf ($b['title'] ?? ''));
                        break;
                    case 'scenario':
                        $read = Words (TextOf ($b['html'] ?? '') . ' ' . TextOf ($b['stimulus'] ?? ''));
                        break;
                    case 'study':
                        $read = Words (TextOf ($b['intro'] ?? '') . ' ' . TextOf ($b['sections'] ?? '') . ' ' . TextOf ($b['keyTerms'] ?? ''));
                        break;
                    case 'reveal':
                        $read = Words (TextOf ($b['prompt'] ?? '') . ' ' . TextOf ($b['explain'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $p['reveal']; }
                        break;
                    case 'video':
                        $len = $videoSeconds[$b['youtubeId'] ?? ''] ?? null;
                        if (isset ($b['start']) || isset ($b['end'])) { $len = (int) ($b['end'] ?? ($len ?? 300)) - (int) ($b['start'] ?? 0); }
                        if ($len === null) { $len = 300; $c['videoUnknown']++; }
                        $c['video'] += $len;
                        $read = Words (TextOf ($b['watchFor'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $len * $p['videoX']; }
                        break;
                    case 'quiz': case 'select': case 'typed': case 'order':
                        $isQ = true;
                        $read = Words (TextOf ($b['prompt'] ?? '') . ' ' . TextOf ($b['options'] ?? '') . ' ' . TextOf ($b['items'] ?? ''));
                        $code = Words (TextOf ($b['code'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $p[$type]; }
                        break;
                    case 'match':
                        $isQ = true;
                        $lines = count ((array) ($b['pairs'] ?? []));
                        $read = Words (TextOf ($b['prompt'] ?? '') . ' ' . TextOf ($b['pairs'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $lines * $p['matchLine']; }
                        break;
                    case 'dragwords': case 'markwords': case 'labelcode': case 'labeloutput':
                        $isQ = true;
                        $read = Words (TextOf ($b['prompt'] ?? ''));
                        $code = Words (TextOf ($b['code'] ?? '') . ' ' . TextOf ($b['output'] ?? ''));
                        $items = max (3, substr_count (TextOf ($b['code'] ?? ''), '[[') + count ((array) ($b['extras'] ?? [])) + count ((array) ($b['output'] ?? [])));
                        foreach ($P as $k => $p) { $do[$k] = $items * $p['item']; }
                        break;
                    case 'labelpic': case 'hotspot':
                        $isQ = true;
                        $zones = count ((array) ($b['zones'] ?? []));
                        $read = Words (TextOf ($b['prompt'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $zones * $p['zone']; }
                        break;
                    case 'gridtyped':
                        $isQ = true;
                        $cells = 0; foreach ((array) ($b['answers'] ?? []) as $row) { $cells += is_array ($row) ? count ($row) : 1; }
                        $read = Words (TextOf ($b['prompt'] ?? '') . ' ' . TextOf ($b['rows'] ?? '') . ' ' . TextOf ($b['headers'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = max (1, $cells) * $p['cell']; }
                        break;
                    case 'written':
                        $isQ = true;
                        $read = Words (TextOf ($b['prompt'] ?? ''));
                        $marks = max (2, (int) ($b['markMax'] ?? 2));
                        // Up to 10 marks at the full rate, the rest at half: a long essay is planned once.
                        foreach ($P as $k => $p) { $do[$k] = (min ($marks, 10) + max (0, $marks - 10) / 2) * $p['writtenMark']; }
                        break;
                    case 'code':
                        $isQ = true;
                        $read = Words (TextOf ($b['prompt'] ?? '') . ' ' . TextOf ($b['hint'] ?? ''));
                        $code = Words (TextOf ($b['starter'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $p['code']; }
                        break;
                    case 'sqlquery':
                        $isQ = true;
                        $read = Words (TextOf ($b['prompt'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $p['sqlquery']; }
                        break;
                    case 'sql':
                        $read = Words (TextOf ($b['prompt'] ?? ''));
                        $code = Words (TextOf ($b['sql'] ?? ''));
                        foreach ($P as $k => $p) { $do[$k] = $p['sql']; }
                        break;
                    case 'dilemma':
                        $isQ = true;
                        $read = Words (TextOf ($b['intro'] ?? ''));
                        $scenes = count ((array) ($b['scenes'] ?? []));
                        foreach ($P as $k => $p) { $do[$k] = max (3, $scenes) * $p['dilemmaScene']; }
                        break;
                    case 'activity':
                        $isQ = true;
                        $read = Words (TextOf ($b['intro'] ?? ''));
                        $steps = count ((array) ($b['steps'] ?? []));
                        foreach ($P as $k => $p) { $do[$k] = max (3, $steps) * $p['step']; }
                        break;
                    default:
                        break;
                } // which block

                // Code inside prose is read slower than words.
                if (in_array ($type, ['prose', 'goodtoknow', 'algorithm', 'important'], true))
                {
                    preg_match_all ('/<pre[^>]*>(.*?)<\/pre>/is', TextOf ($b['html'] ?? ''), $pres);
                    $code += Words (implode (' ', $pres[1]));
                    $read = max (0, $read - Words (implode (' ', $pres[1])));
                }

                $c['words'] += $read;
                $c['codeWords'] += $code;
                if ($isQ) { $c['q']++; }

                if (getenv ('DBG') === $courseId . '/' . $lessonId && $myBoard === $boardRuns[0]) { fprintf (STDERR, "%-12s read %5d code %5d do %6.0f
", $type, $read, $code, $do['fast']); }
                foreach ($P as $k => $p)
                {
                    // A long listing is read closely for its first 200 words, then skimmed (four times as fast).
                    $codeSeconds = (min ($code, 200) + max (0, $code - 200) / 4) / $p['codeWpm'] * 60;
                    $seconds = $read / $p['wpm'] * 60 + $codeSeconds + $do[$k];
                    if ($isQ) { $seconds *= 1 + $p['retry'] * 0.6; }   // a second try costs about 60% of the first
                    $t[$k] += $seconds;
                }
            } // foreach block

            foreach ($P as $k => $p) { $t[$k] += $p['overhead']; }   // opening, scrolling, the result reveal
            $perBoard[$myBoard] = ['c' => $c, 't' => $t];
        } // foreach board

        // The range across boards: the quickest board for the fast pupil, the longest for the slow one.
        $fast = min (array_map (fn ($r) => $r['t']['fast'], $perBoard));
        $slow = max (array_map (fn ($r) => $r['t']['slow'], $perBoard));
        $mid  = array_sum (array_map (fn ($r) => $r['t']['mid'], $perBoard)) / count ($perBoard);
        $first = reset ($perBoard)['c'];

        $rows[] = [
            'course' => $courseId, 'courseTitle' => $course['title'], 'lesson' => (string) $lessonId,
            'label' => LessonLabel ($lesson), 'title' => (string) ($lesson['title'] ?? ''),
            'words' => $first['words'], 'codeWords' => $first['codeWords'], 'videoMin' => round ($first['video'] / 60, 1),
            'videoUnknown' => $first['videoUnknown'], 'questions' => $first['q'], 'boards' => implode ('/', array_filter (array_keys ($perBoard))),
        ] + LessonTimeMinutes ($courseId, (string) $lessonId) + [
        ];
    } // foreach lesson
} // foreach course

file_put_contents (__DIR__ . '/lessontimes.json', json_encode ($rows, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
echo count ($rows), " lessons\n";
