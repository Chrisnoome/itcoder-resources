<?php
/**
 * The home page (Chris, 1 October 2026: "we need to revamp the site home
 * page" - visitors see a landing page, signed-in people a dashboard). The
 * landing page is built from SubjectIndex() and CourseIndex(), so a new
 * subject shows by itself: first as coming soon, then with its courses.
 *
 * Also "Tell me when it opens": a signed-in person can wait for a coming-soon
 * subject, and gets a notification when its first course opens.
 */

require_once __DIR__ . '/course.php';
require_once __DIR__ . '/content.php';
require_once __DIR__ . '/notifications.php';


/**
 * The subjects as a visitor sees them, open ones first, each:
 *   ['title', 'summary', 'extras', 'open' (course titles), 'soon' (count),
 *    'grades' (the grade numbers its courses are for),
 *    'courses' (courseId => title, summary, grades, gradeList, free, lessons)]
 * Draft and hidden courses never show.
 */
function HomeSubjects () : array
{
    $subjects = [];

    foreach (SubjectIndex () as $subjectId => $subject)
    {
        $subjects[$subjectId] = ['title' => $subject['title'], 'summary' => $subject['summary'], 'extras' => $subject['extras'] ?? [],
                                 'open' => [], 'soon' => 0, 'grades' => [], 'courses' => []];
    } // foreach subject

    foreach (CourseIndex () as $courseId => $course)
    {
        $subjectId = $course['subject'] ?? 'gc';
        $status    = $course['status'] ?? 'open';

        if (!isset ($subjects[$subjectId]) || ($status !== 'open' && $status !== 'soon')) { continue; }

        // A course the admin hid (Manage courses) is theirs alone.
        if (($course['visibility'] ?? 'live') === 'hidden') { continue; }

        if ($status === 'open')
        {
            $subjects[$subjectId]['open'][] = $course['title'];
            $subjects[$subjectId]['courses'][(string) $courseId] = [
                'title'     => $course['title'],
                'summary'   => (string) ($course['summary'] ?? ''),
                'grades'    => (string) ($course['grades'] ?? ''),
                'gradeList' => HomeGrades ((string) ($course['grades'] ?? '')),
                'free'      => IsFreeCourse ((string) $courseId),
                'lessons'   => HomeLessonList ((string) $courseId),
                'size'      => CourseSizeText ((string) $courseId),   // '25 lessons + 10 guides' (lib/content.php)
            ];
        } // if open
        else
        {
            $subjects[$subjectId]['soon']++;
        } // else on the way

        $subjects[$subjectId]['grades'] = array_values (array_unique (array_merge ($subjects[$subjectId]['grades'], HomeGrades ((string) ($course['grades'] ?? '')))));
    } // foreach course

    // Open subjects first, then those with courses on the way, then the rest - each group in SubjectIndex() order.
    $order = array_flip (array_keys ($subjects));
    uksort ($subjects, function ($a, $b) use ($subjects, $order) {
        $rank = fn ($s) => (count ($s['open']) > 0) ? 0 : (($s['soon'] > 0) ? 1 : 2);
        return [$rank ($subjects[$a]), $order[$a]] <=> [$rank ($subjects[$b]), $order[$b]];
    });

    return $subjects;
} // HomeSubjects


/** How many lessons a home page course card lists; the rest show only when a search finds them. */
const HOME_LESSONS_SHOWN = 5;


/** A course's written lessons, in teaching order: [['label' => '1' or 'CAPS', 'title' => ...], ...]. */
function HomeLessonList (string $aCourseId) : array
{
    $lessons = [];

    foreach (LessonIndex ($aCourseId) as $lessonId => $lesson)
    {
        if (!LessonExists ($aCourseId, (string) $lessonId)) { continue; }

        $title = (string) ($lesson['title'] ?? '');

        // The SQL course has lessons 8-17 once per database: say which (site review, 3 October 2026).
        if (isset ($lesson['dialect']))
        {
            require_once __DIR__ . '/sql.php';   // SqlDialects()
            $title .= ' - ' . (SqlDialects ()[(string) $lesson['dialect']] ?? (string) $lesson['dialect']);
        } // if one database's copy

        $lessons[] = ['label' => LessonNumberLabel ($lesson), 'title' => $title];
    } // foreach lesson

    return $lessons;
} // HomeLessonList


/**
 * A course's own look on the subjects strip (Chris, 1 October 2026: "each course should get a
 * professional looking icon - vary colours per course"): two gradient colours and a line icon.
 * A course not listed gets colours picked from its id, and its subject's icon. When ComfyUI art
 * exists (public/assets/course-art/<courseId>.png - later, once the GPU is ready) it replaces the icon.
 */
function HomeCourseLook (string $aCourseId, string $aSubjectId) : array
{
    $looks = [
        'ai'        => ['#7b5cff', '#3d22b8', '<path d="M12 3l1.8 4.7L18.5 9.5l-4.7 1.8L12 16l-1.8-4.7L5.5 9.5l4.7-1.8z"/><path d="M18.5 15l.9 2.1 2.1.9-2.1.9-.9 2.1-.9-2.1-2.1-.9 2.1-.9z"/><path d="M5 16.5l.6 1.4 1.4.6-1.4.6-.6 1.4-.6-1.4L3 18.5l1.4-.6z"/>'],
        'safety'    => ['#d6463c', '#8a1a14', '<rect x="5" y="10.5" width="14" height="10" rx="2"/><path d="M8 10.5V7.5a4 4 0 0 1 8 0v3"/><circle cx="12" cy="15" r="1.4"/><line x1="12" y1="16.4" x2="12" y2="18"/>'],
        'socialmedia' => ['#ff4fa3', '#7b1fa2', '<path d="M6 16v-5a6 6 0 0 1 12 0v5l1.5 2h-15z"/><path d="M10 20a2 2 0 0 0 4 0"/><circle cx="18.5" cy="5.5" r="2.5"/>'],
        'sql9'      => ['#3f6b48', '#16201a', '<ellipse cx="12" cy="5.5" rx="7.5" ry="2.8"/><path d="M4.5 5.5v13c0 1.6 3.4 2.8 7.5 2.8s7.5-1.2 7.5-2.8v-13"/><circle cx="16.5" cy="13" r="3"/><line x1="18.6" y1="15.1" x2="21" y2="17.5"/>'],
        'clubweb'   => ['#ff4f7a', '#2f6fde', '<path d="M8 6L3 12l5 6"/><path d="M16 6l5 6-5 6"/><line x1="13.5" y1="5" x2="10.5" y2="19"/>'],
        'factfake'  => ['#1f9d63', '#0b0f14', '<circle cx="10.5" cy="10.5" r="6.5"/><line x1="15.3" y1="15.3" x2="21" y2="21"/><path d="M7.5 10.5l2 2 3.5-4"/>'],
        'botmaze'   => ['#c0392b', '#6e4c2a', '<path d="M3 3h18v18H3z"/><path d="M3 9h8M15 3v8M9 15h12M9 15v6"/><circle cx="6" cy="6" r="1.6"/><path d="M18 18l2 2"/>'],
        'machine'   => ['#0f5132', '#c99a1a', '<rect x="6" y="6" width="12" height="12" rx="1.5"/><path d="M9 2.5v3.5M12 2.5v3.5M15 2.5v3.5M9 18v3.5M12 18v3.5M15 18v3.5M2.5 9h3.5M2.5 12h3.5M2.5 15h3.5M18 9h3.5M18 12h3.5M18 15h3.5"/>'],
        'tuckshop'  => ['#e8483b', '#10301d', '<path d="M3.5 11.5V3.5h8l9 9-8 8z"/><circle cx="7.8" cy="7.8" r="1.6"/><line x1="10" y1="14" x2="14" y2="10"/>'],
        'mlit10'    => ['#f7c948', '#e63b2e', '<rect x="3" y="5" width="18" height="11" rx="1.5"/><path d="M7 16v4M17 16v4"/><text x="12" y="13.6" text-anchor="middle" font-size="7" font-weight="700" stroke="none" fill="currentColor" font-family="Bungee, sans-serif">R</text>'],
        'pascal9'   => ['#29366f', '#1d1832', '<rect x="9" y="8" width="6" height="8" rx="1"/><rect x="2.5" y="7" width="5" height="10"/><rect x="16.5" y="7" width="5" height="10"/><line x1="7.5" y1="12" x2="9" y2="12"/><line x1="15" y1="12" x2="16.5" y2="12"/><line x1="12" y1="8" x2="12" y2="5"/><circle cx="12" cy="4" r="1"/>'],
        'pascal'    => ['#14a3b8', '#0b5f78', '<rect x="2.5" y="4" width="19" height="16" rx="2.5"/><polyline points="6.5 9.5 9.5 12 6.5 14.5"/><line x1="11.5" y1="15" x2="16.5" y2="15"/>'],
        'java'      => ['#ff8a3d', '#c2410c', '<path d="M4 10h12v4.5a5.5 5.5 0 0 1-5.5 5.5h-1A5.5 5.5 0 0 1 4 14.5z"/><path d="M16 11.5h1.5a2.5 2.5 0 0 1 0 5H16"/><path d="M8 3.5c-1 1 1 2 0 3M12 3.5c-1 1 1 2 0 3"/>'],
        'sql'       => ['#3b8bff', '#1a4fb5', '<ellipse cx="12" cy="5.5" rx="7.5" ry="2.8"/><path d="M4.5 5.5v13c0 1.6 3.4 2.8 7.5 2.8s7.5-1.2 7.5-2.8v-13"/><path d="M4.5 12c0 1.6 3.4 2.8 7.5 2.8s7.5-1.2 7.5-2.8"/>'],
        'theory10'  => ['#2fbf7f', '#11704a', '<rect x="2.5" y="3.5" width="19" height="13" rx="2"/><line x1="8" y1="20.5" x2="16" y2="20.5"/><line x1="12" y1="16.5" x2="12" y2="20.5"/><path d="M6.5 12.5l3-3 2.5 2 4.5-4.5"/>'],
        'theory11'  => ['#e2559b', '#9b1c5e', '<rect x="6" y="6" width="12" height="12" rx="1.5"/><rect x="9.5" y="9.5" width="5" height="5"/><path d="M9 2.5v3.5M15 2.5v3.5M9 18v3.5M15 18v3.5M2.5 9h3.5M2.5 15h3.5M18 9h3.5M18 15h3.5"/>'],
        'theory12'  => ['#f2b32e', '#b5650b', '<circle cx="12" cy="12" r="9"/><path d="M3 12h18"/><path d="M12 3a14 14 0 0 1 0 18a14 14 0 0 1 0-18"/>'],
        'catword'   => ['#4f7cff', '#2846b8', '<path d="M6 3h8l4 4v14H6z"/><path d="M14 3v4h4"/><line x1="9" y1="12" x2="15" y2="12"/><line x1="9" y1="16" x2="15" y2="16"/>'],
        'catsheets' => ['#27b36b', '#136b3e', '<rect x="3.5" y="3.5" width="17" height="17" rx="2"/><path d="M3.5 9h17M3.5 14.5h17M9 3.5v17"/>'],
        'cathtml'   => ['#ff6a4d', '#b8321a', '<polyline points="8 7 3 12 8 17"/><polyline points="16 7 21 12 16 17"/><line x1="13.5" y1="5" x2="10.5" y2="19"/>'],
        'catexcel'  => ['#27b36b', '#136b3e', '<rect x="3.5" y="3.5" width="17" height="17" rx="2"/><path d="M3.5 9h17M3.5 14.5h17M9 3.5v17"/>'],
        'catpowerpoint' => ['#22b8a0', '#0f6e60', '<rect x="3" y="4" width="18" height="12" rx="1.5"/><line x1="12" y1="16" x2="12" y2="20.5"/><line x1="8.5" y1="20.5" x2="15.5" y2="20.5"/><path d="M7.5 13v-3M11 13V8M14.5 13v-2"/>'],
        'cattheory10' => ['#9b6bff', '#5a2fc2', '<rect x="4" y="3" width="16" height="18" rx="2"/><line x1="8" y1="8" x2="16" y2="8"/><line x1="8" y1="12" x2="16" y2="12"/><line x1="8" y1="16" x2="13" y2="16"/>'],
        'cattheory11' => ['#5b7cfa', '#2c3fb0', '<rect x="4" y="3" width="16" height="18" rx="2"/><line x1="8" y1="8" x2="16" y2="8"/><line x1="8" y1="12" x2="16" y2="12"/><line x1="8" y1="16" x2="13" y2="16"/>'],
        'cattheory12' => ['#c55cf0', '#7b23a8', '<rect x="4" y="3" width="16" height="18" rx="2"/><line x1="8" y1="8" x2="16" y2="8"/><line x1="8" y1="12" x2="16" y2="12"/><line x1="8" y1="16" x2="13" y2="16"/>'],
        'cattheory' => ['#9b6bff', '#5a2fc2', '<rect x="4" y="3" width="16" height="18" rx="2"/><line x1="8" y1="8" x2="16" y2="8"/><line x1="8" y1="12" x2="16" y2="12"/><line x1="8" y1="16" x2="13" y2="16"/>'],
        'catdb'     => ['#1fb5c9', '#0d6a86', '<ellipse cx="12" cy="6" rx="7" ry="2.6"/><path d="M5 6v12c0 1.4 3.1 2.6 7 2.6s7-1.2 7-2.6V6"/><path d="M5 12c0 1.4 3.1 2.6 7 2.6s7-1.2 7-2.6"/>'],
    ];
    $spare = [['#ff7a59', '#b53a1c'], ['#5b7cfa', '#2c3fb0'], ['#22b8a0', '#0f6e60'], ['#c55cf0', '#7b23a8'], ['#f5a524', '#a8600a']];

    [$from, $to, $paths] = $looks[$aCourseId] ?? array_merge ($spare[crc32 ($aCourseId) % count ($spare)], ['']);
    $art = '/assets/course-art/' . $aCourseId . '.png';

    if (is_file (dirname (__DIR__) . '/public' . $art))
    {
        $icon = '<img src="' . H ($art) . '" alt="">';
    } // if ComfyUI art exists
    else
    {
        $icon = ($paths !== '') ? '<svg viewBox="0 0 24 24" aria-hidden="true">' . $paths . '</svg>' : HomeSubjectIcon ($aSubjectId);
    } // else the line icon

    return ['from' => $from, 'to' => $to, 'icon' => $icon];
} // HomeCourseLook


/** A line icon for a subject's tile (inline SVG, drawn with currentColor); a book for any other. */
function HomeSubjectIcon (string $aSubjectId) : string
{
    $paths = [
        'it'     => '<polyline points="8 6 2 12 8 18"/><polyline points="16 6 22 12 16 18"/><line x1="14" y1="4" x2="10" y2="20"/>',
        'gc'     => '<rect x="5" y="5" width="14" height="14" rx="2"/><rect x="9" y="9" width="6" height="6"/><path d="M9 2v3M15 2v3M9 19v3M15 19v3M2 9h3M2 15h3M19 9h3M19 15h3"/>',
        'cat'    => '<rect x="3" y="4" width="18" height="16" rx="2"/><path d="M3 10h18M3 15h18M9 4v16M15 4v16"/>',
        'maths'  => '<path d="M18 4H6l6 8-6 8h12"/>',
        'mlit'   => '<path d="M3 20h18"/><rect x="5" y="11" width="3" height="7"/><rect x="10.5" y="7" width="3" height="11"/><rect x="16" y="4" width="3" height="14"/>',
        'physci' => '<circle cx="12" cy="12" r="1.6"/><ellipse cx="12" cy="12" rx="10" ry="4"/><ellipse cx="12" cy="12" rx="10" ry="4" transform="rotate(60 12 12)"/><ellipse cx="12" cy="12" rx="10" ry="4" transform="rotate(120 12 12)"/>',
    ];

    return '<svg viewBox="0 0 24 24" aria-hidden="true">' . ($paths[$aSubjectId] ?? '<path d="M4 4h7a3 3 0 0 1 3 3v13a2 2 0 0 0-2-2H4z"/><path d="M20 4h-7a3 3 0 0 0-3 3v13a2 2 0 0 1 2-2h8z"/>') . '</svg>';
} // HomeSubjectIcon


/** The grade numbers in a course's grades tag: 'Grades 10-12' -> [10, 11, 12], 'Grade 9' -> [9]; no tag is every grade. */
function HomeGrades (string $aGrades) : array
{
    if (trim ($aGrades) === '') { return range (8, 12); }

    if (preg_match ('/(\d+)\s*-\s*(\d+)/', $aGrades, $range)) { return range ((int) $range[1], (int) $range[2]); }

    preg_match_all ('/\d+/', $aGrades, $numbers);

    return array_map ('intval', $numbers[0]);
} // HomeGrades


/** True when a subject has a course anyone can join. */
function SubjectIsOpen (string $aSubjectId) : bool
{
    foreach (CourseIndex () as $course)
    {
        if (($course['subject'] ?? 'gc') === $aSubjectId && ($course['status'] ?? 'open') === 'open') { return true; }
    } // foreach course

    return false;
} // SubjectIsOpen


/* ---- "Tell me when it opens" ---------------------------------------------- */

/** The subjects this person is waiting for (not yet told): [subjectId, ...]. */
function WatchedSubjects (int $aPupilId) : array
{
    $statement = Db ()->prepare ('SELECT subjectId FROM subjectWatch WHERE pupilId = ? AND notifiedAt IS NULL');
    $statement->execute ([$aPupilId]);

    return $statement->fetchAll (PDO::FETCH_COLUMN);
} // WatchedSubjects


/** Starts or stops waiting for a coming-soon subject. Only a real subject that has not opened yet. */
function SetSubjectWatch (int $aPupilId, string $aSubjectId, bool $anOn) : void
{
    if (!isset (SubjectIndex ()[$aSubjectId]) || SubjectIsOpen ($aSubjectId)) { return; }

    if ($anOn)
    {
        Db ()->prepare ('INSERT INTO subjectWatch (pupilId, subjectId, createdAt) VALUES (?, ?, ?)
                         ON CONFLICT (pupilId, subjectId) DO UPDATE SET notifiedAt = NULL')
             ->execute ([$aPupilId, $aSubjectId, Now ()]);
    }
    else
    {
        Db ()->prepare ('DELETE FROM subjectWatch WHERE pupilId = ? AND subjectId = ?')->execute ([$aPupilId, $aSubjectId]);
    } // on or off
} // SetSubjectWatch


/**
 * Tells everyone waiting for a subject that has now opened, once. Cheap when
 * nobody is waiting (one small query), so the pages people open often call it.
 */
function NotifySubjectWatchers () : void
{
    $waiting = Db ()->query ('SELECT DISTINCT subjectId FROM subjectWatch WHERE notifiedAt IS NULL')->fetchAll (PDO::FETCH_COLUMN);

    foreach ($waiting as $subjectId)
    {
        if (!isset (SubjectIndex ()[$subjectId]) || !SubjectIsOpen ($subjectId)) { continue; }

        $title  = SubjectIndex ()[$subjectId]['title'];
        $people = Db ()->prepare ('SELECT pupilId FROM subjectWatch WHERE subjectId = ? AND notifiedAt IS NULL');
        $people->execute ([$subjectId]);

        foreach ($people->fetchAll (PDO::FETCH_COLUMN) as $pupilId)
        {
            Notify ((int) $pupilId, 'subject', $title . ' has opened - its first course is ready to join.', '/subjects.php?s=' . rawurlencode ($subjectId), 'subject-open:' . $subjectId);
        } // foreach person waiting

        Db ()->prepare ('UPDATE subjectWatch SET notifiedAt = ? WHERE subjectId = ? AND notifiedAt IS NULL')->execute ([Now (), $subjectId]);
    } // foreach subject someone is waiting for
} // NotifySubjectWatchers


/** The "Tell me when it opens" button for a coming-soon subject (a form, so it works without JavaScript). */
function SubjectWatchButtonHtml (string $aSubjectId, bool $aWatching, string $aBackTo) : string
{
    return '<form class="subject-watch" method="post" action="/subject-watch.php">'
         . FormTokenInput ('subjects')   // subject-watch.php takes it (lib/auth.php, 2 October 2026)
         . '<input type="hidden" name="s" value="' . H ($aSubjectId) . '">'
         . '<input type="hidden" name="on" value="' . ($aWatching ? '0' : '1') . '">'
         . '<input type="hidden" name="back" value="' . H ($aBackTo) . '">'
         . '<button type="submit" class="' . ($aWatching ? 'is-on' : '') . '" aria-pressed="' . ($aWatching ? 'true' : 'false') . '">'
         . ($aWatching ? 'You will be told when it opens - undo' : 'Tell me when it opens') . '</button></form>';
} // SubjectWatchButtonHtml


/* ---- the signed-in dashboard ---------------------------------------------- */

/** Good morning / afternoon / evening, by South African time. */
function HomeGreeting () : string
{
    $hour = (int) (new DateTime ('now', new DateTimeZone ('Africa/Johannesburg')))->format ('G');

    return ($hour < 12) ? 'Good morning' : (($hour < 17) ? 'Good afternoon' : 'Good evening');
} // HomeGreeting


/**
 * Where to carry on: the lesson this person last read in a course they are
 * still on (lessonPositions, as on the subjects page), or null:
 * ['courseId', 'lessonId', 'course', 'lesson', 'href'].
 */
function HomeCarryOn (int $aPupilId, array $anEnrolled) : ?array
{
    $recent = Db ()->prepare ('SELECT courseId, lessonId FROM lessonPositions WHERE pupilId = ? ORDER BY updatedAt DESC LIMIT 5');
    $recent->execute ([$aPupilId]);

    foreach ($recent->fetchAll () as $place)
    {
        if (in_array ($place['courseId'], $anEnrolled, true) && CourseExists ($place['courseId']) && LessonExists ($place['courseId'], $place['lessonId']))
        {
            return [
                'courseId' => $place['courseId'],
                'lessonId' => $place['lessonId'],
                'course'   => CourseTitle ($place['courseId']),
                'lesson'   => LessonName ($place['courseId'], $place['lessonId']),
                'href'     => LessonUrl ($place['courseId'], $place['lessonId']),
            ];
        } // if that place is still there
    } // foreach recent place

    return null;
} // HomeCarryOn


/**
 * The one button at the top of a course's lesson list (site review, Chris, 3
 * October 2026: pupils had to work out that a lesson's name opens it):
 *   - the lesson they last read here, if it is not finished: "Continue";
 *   - else the first open lesson not finished: "Start" if they have not
 *     begun the course, "Next";
 *   - null when every lesson is done.
 * ['verb', 'label' ("Lesson 3: Inside a model file"), 'href']. The lesson
 * page itself offers to jump to where they were (lessonPositions).
 */
function CourseNextLesson (array $aPupil, string $aCourseId) : ?array
{
    require_once __DIR__ . '/access.php';     // AccessMode()
    require_once __DIR__ . '/progress.php';   // LessonState()
    require_once __DIR__ . '/syllabus.php';   // LessonShownTo()
    require_once __DIR__ . '/sequence.php';   // LessonOpenInSequence()

    $lessons = LessonIndex ($aCourseId);
    $choice = fn (string $aVerb, string $anId) : array => ['verb' => $aVerb, 'href' => LessonUrl ($aCourseId, $anId),
                                                            'label' => LessonLabel ($lessons[$anId]) . ': ' . (string) ($lessons[$anId]['title'] ?? '')];

    $usable = function (string $anId, array $aLesson) use ($aPupil, $aCourseId) : bool
    {
        if (!LessonExists ($aCourseId, $anId) || !LessonShownTo ($aPupil, $aLesson)) { return false; }
        if (isset ($aLesson['dialect']) && !BlockCounts (['dialect' => (string) $aLesson['dialect']], CountKey ($aPupil, $aCourseId))) { return false; }

        // A sequential course: never the way in to a lesson whose turn has not come (lib/sequence.php, 9 October 2026).
        return AccessMode ($aPupil, $aCourseId, $anId) !== ACCESS_LOCKED && LessonOpenInSequence ($aPupil, $aCourseId, $anId);
    };

    $last = HomeCarryOn ((int) $aPupil['id'], [$aCourseId]);

    if ($last !== null && isset ($lessons[$last['lessonId']]) && LessonState ($aPupil, $aCourseId, $last['lessonId'])['state'] !== 'done')
    {
        return $choice ('Continue', (string) $last['lessonId']);
    } // if the lesson they were in is unfinished

    $begun = $last !== null;

    foreach ($lessons as $lessonId => $lesson)
    {
        if (!$usable ((string) $lessonId, $lesson)) { continue; }

        $state = LessonState ($aPupil, $aCourseId, (string) $lessonId)['state'];
        $begun = $begun || $state === 'done' || $state === 'partial';

        if ($state !== 'done' && $state !== 'none') { return $choice ($begun ? 'Next' : 'Start', (string) $lessonId); }
    } // foreach lesson, in order

    return null;
} // CourseNextLesson


/**
 * One course's figures for the dashboard: the plan's lessons when the pupil
 * has a plan (the same figures as My progress), else every lesson in the course.
 *   ['bars' (as PupilProgress), 'lessons' (lessonId => title, number, due, state, counts),
 *    'hasPlan', 'weighted' (?int), 'written' (?int), 'other' (?int)]
 */
function HomeCourseFigures (array $aPupil, string $aCourseId) : array
{
    $options = PupilPlanOptions ($aPupil, $aCourseId);

    if ($options !== null)
    {
        $progress = PupilProgress ($aPupil, $aCourseId, $options);
        $bars     = $progress['bars'];
        $lessons  = $progress['lessons'];
    }
    else
    {
        // Every lesson with questions - the same count as My progress without a plan (CourseProgress(), 2 October 2026).
        $progress = CourseProgress ($aPupil, $aCourseId);
        $bars     = $progress['bars'];
        $lessons  = array_filter ($progress['lessons'], fn ($aLesson) => $aLesson['counts']);
    } // with a plan or without

    $percent = fn ($anEarned, $aMax) => ($aMax > 0) ? (int) round (100 * $anEarned / $aMax) : null;

    return ['bars' => $bars, 'lessons' => $lessons, 'hasPlan' => ($options !== null),
            'weighted' => WeightedPercent ($bars['otherEarned'], $bars['otherMax'], $bars['writtenEarned'], $bars['writtenMax'], MarkWeighting ((int) $aPupil['id'], $aCourseId)['written']),
            'weighting' => MarkWeighting ((int) $aPupil['id'], $aCourseId),   // what the weighted dial explains (3 October 2026)
            'written'  => $percent ($bars['writtenEarned'], $bars['writtenMax']),
            'other'    => $percent ($bars['otherEarned'], $bars['otherMax'])];
} // HomeCourseFigures


/**
 * The lessons still to finish in a planned course, soonest first, at most
 * $aMax: [['title', 'number', 'href', 'when' (Behind / a day / a date), 'tone' (behind | soon | later)]].
 */
function HomeDueLessons (string $aCourseId, array $aFigures, int $aMax = 4) : array
{
    if (!$aFigures['hasPlan']) { return []; }

    $today  = PlannerToday ();
    $friday = (new DateTime ($today))->modify ('friday this week')->format ('Y-m-d');
    $open   = array_filter ($aFigures['lessons'], fn ($aLesson) => $aLesson['counts'] && $aLesson['state'] !== 'done');

    uasort ($open, fn ($a, $b) => strcmp ((string) $a['due'], (string) $b['due']));

    $list = [];
    foreach (array_slice ($open, 0, $aMax, true) as $lessonId => $lesson)
    {
        $due  = (string) $lesson['due'];
        $tone = ($due < $today) ? 'behind' : (($due <= $friday) ? 'soon' : 'later');
        $when = ($tone === 'behind') ? 'Behind' : DayText ($due, ($tone === 'soon') ? 'l' : 'j M');

        $list[] = ['title' => $lesson['title'], 'number' => $lesson['number'], 'when' => $when, 'tone' => $tone,
                   'href' => LessonUrl ($aCourseId, (string) $lessonId)];
    } // foreach lesson still open

    return $list;
} // HomeDueLessons


/**
 * The teacher's start page, at the top of the signed-in home page (site review,
 * Chris, 3 October 2026: eight teacher tools, each on its own page - a busy
 * teacher wants one place that says what waits). Queries and messages waiting,
 * the term countdown, and the way into class results, the progress check and
 * inviting pupils. Only counts that are cheap to make; who is behind is one
 * click away (the progress check works it out per class).
 */
function TeacherHomeHtml (array $aTeacher) : string
{
    require_once __DIR__ . '/queries.php';         // OpenQueryCount()
    require_once __DIR__ . '/messages.php';        // StaffMessageCounts()
    require_once __DIR__ . '/classprogress.php';   // TermCountdownHtml()

    try { $queries = OpenQueryCount ($aTeacher); } catch (Throwable $problem) { $queries = 0; }   // before setup.php has made the table
    $messages = StaffMessageCounts ($aTeacher)['waiting'];

    $card = fn (string $aHref, string $aTitle, string $aLine, int $aCount = -1) : string =>
        '<a class="dash-card teacher-home-card' . (($aCount > 0) ? ' is-waiting' : '') . '" href="' . H ($aHref) . '">'
        . (($aCount >= 0) ? '<span class="teacher-home-count">' . $aCount . '</span>' : '')
        . '<h2>' . H ($aTitle) . '</h2><span class="dash-small">' . H ($aLine) . '</span></a>';

    return '<section class="teacher-home" aria-label="Your classes"><h2 class="teacher-home-title">Your classes</h2>'
         . TermCountdownHtml ($aTeacher)
         . '<div class="dash-row teacher-home-row">'
         . $card ('/teacher-queries.php', 'Pupil queries', ($queries === 1) ? 'A pupil asks you to look at a mark' : 'Pupils asking you to look at a mark', $queries)
         . $card ('/teacher-messages.php', 'Pupil messages', ($messages > 0) ? 'Waiting for your reply' : 'Nothing waiting', $messages)
         . $card ('/progress-check.php', 'Who is behind', 'Pupils falling behind, and the top achievers')
         . $card ('/teacher.php', 'Class results', 'Marks, time on the site and practice, class by class')
         . $card ('/invite.php', 'Invite pupils', 'Add pupils to a class by email, or give them the class code')
         . $card ('/planner.php', 'Year planner', 'Which lessons fall in which week')
         . '</div></section>';
} // TeacherHomeHtml
