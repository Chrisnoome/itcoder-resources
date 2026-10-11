<?php
/**
 * The course catalogue and enrolment.
 *
 * Courses are defined here in code, the same way lessons are plain PHP files.
 * Adding a course is: a row in CourseIndex(), a content/<id>/ directory with an
 * index.php lesson map, and (if its written answers need a different marking
 * voice) a branch in CourseMarkStyle().
 *
 * Every course belongs to one subject (SubjectIndex() below) - the top layer
 * of the site since 21 September 2026: subjects, then courses, then lessons.
 */

require_once __DIR__ . '/auth.php';


/**
 * Every subject, in the order the site shows them (Chris, 21 September 2026).
 * A subject is only a heading: it holds courses, and a subject with no
 * courses yet still shows, as "coming soon".
 *
 *   title   - shown on the subjects page, in the menu and above its courses
 *   summary - one line under the title (may be empty)
 *   extras  - (optional) what this subject adds to every lesson's basics, for
 *             the home page's "What each subject adds": [[title, one line], ...]
 */
function SubjectIndex () : array
{
    return [
        'gc'     => ['title' => 'General Computing',
                     'summary' => 'How the technology everyone uses actually works.',
                     'extras'  => [['Try it yourself', 'Count the tokens in a sentence, size a model for a graphics card and price a question - small working models of the real thing.']]],
        'it'     => ['title' => 'Information Technology',
                     'summary' => 'Programming, databases and IT theory for IEB and CAPS Information Technology.',
                     'extras'  => [['A real console', 'Pascal and Java compile and run on the server, and SQL runs on a real database - from any browser, even a phone.'],
                                   ['Songs that stick', 'Music videos for the hard ideas, with questions that pop up while you watch.']]],
        'cat'    => ['title' => 'Computer Applications Technology',
                     'summary' => 'Word processing, spreadsheets, databases, HTML and CAT theory.'],
        'maths'  => ['title' => 'Mathematics',        'summary' => ''],
        'mlit'   => ['title' => 'Maths Literacy',     'summary' => ''],
        'physci' => ['title' => 'Physical Science',   'summary' => ''],
    ];
} // SubjectIndex


/**
 * Every course on the platform, in the order the catalogue shows them.
 *
 *   subject - the SubjectIndex() key it belongs to
 *   title   - shown in the catalogue and as the course heading
 *   summary - one line under the title
 *   grades  - who it is aimed at, shown as a tag
 *   status  - 'open' (in the catalogue), 'draft' (hidden from pupils,
 *             still reachable by a teacher for review) or 'soon' (listed
 *             for everyone as coming soon, but has no content and cannot
 *             be joined or opened)
 *   pilot   - true: only on the test site and the testbed, never live
 *   sequential - true: lesson N opens only once lesson N-1 is complete -
 *             every step gate solved, every marked question answered
 *             (Chris, 9 October 2026: sql9 and pascal9 - lib/sequence.php;
 *             10 October 2026: "these should all be progress gated" - safety
 *             and socialmedia too, and new General Computing courses).
 *             Teachers skip the locks, and can open a lesson for a pupil.
 *
 * The array key is a database key (enrolments, quizResponses, ...) - never
 * rename one once pupils have used it.
 */
function CourseIndex (bool $aWithRemoved = false) : array
{
    static $courses = null;
    static $shown   = null;

    // A course the admin removed (Admin > Courses and billing > Courses, Chris, 11 October 2026: "no option to delete
    // courses on the courses page") is left out everywhere - lists, pages, menus, joining - and its pupils' work is
    // kept; only the admin's Removed courses list asks for it, to restore it. Its lessons stay in the code.
    if ($courses !== null) { return $aWithRemoved ? $courses : $shown; }

    $courses = [
        'ai' => [
            'subject' => 'gc',
            'title'   => 'How AI really works',
            'summary' => 'What AI is, what it runs on, what it costs, and who is paying for it.',
            'grades'  => 'Grade 9',
            // Opened by Chris, 13 September 2026. It was draft for two reasons:
            // the six activities were not ported, and the lessons were still
            // v1's copy rather than restyled to the Pascal course's
            // conventions. The first is done - all six run in app.js. The
            // second is not, and Chris opened it anyway: the lessons work,
            // they just look like v1. The restyle is still on the backlog
            // (AIResources/open-items.md), it is simply no longer a gate.
            'status'  => 'open',
        ],
        // Planned and written 9 October 2026, all eight lessons; opened by
        // Chris the same day ("complete the course ... and publish live").
        // AIResources/courses/safety-course.md; its art is
        // AIResources/brand/safety-art-style.md.
        'safety' => [
            'subject' => 'gc',
            'title'   => 'Staying safe online',
            'summary' => 'Spot the scam, lock your accounts and find out what your apps know about you.',
            'grades'  => 'Grade 8',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // Grade 9 term 1, shared: social media first, then the SQL rhino case
        // (Chris, 9 October 2026). AIResources/courses/socialmedia-course.md and
        // sql9-course.md. Open from the start - no draft (platform.md).
        'socialmedia' => [
            'subject' => 'gc',
            'title'   => 'Social media and The Social Dilemma',
            'summary' => 'How free apps make money from your attention, the slot machine in your pocket, and what to do about it.',
            'grades'  => 'Grade 9',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // The SQL runner and marking of the SQL course, with its own database
        // (content/sql/db/reserve.php) and no dialects - so every question counts.
        'sql9' => [
            'subject' => 'gc',
            'title'   => 'The rhino case: intro to SQL',
            'summary' => 'A collared rhino goes silent. Learn SQL one clue at a time and track down the poaching gang.',
            'grades'  => 'Grade 9',
            'status'  => 'open',
            'sequential' => true,   // each lesson complete before the next, each step solved before the rest (Chris, 9 October 2026 - lib/sequence.php)
        ],
        // Grade 9 term 2 (Chris, 9 October 2026: "a similar themed interactive
        // pascal course for grd 9 term 2 - console only"). Station Kestrel: each
        // lesson a mission program the site runs and checks (lib/mission.php).
        // AIResources/courses/pascal9-course.md; art brand/pascal9-art-style.md.
        // Open from the start - no draft (platform.md).
        'pascal9' => [
            'subject' => 'gc',
            'title'   => 'Station Kestrel: learn to code in Pascal',
            'summary' => 'A solar storm wiped a space station\'s computers. Write the programs that bring it back, one system at a time.',
            'grades'  => 'Grade 9',
            'status'  => 'open',
            'sequential' => true,   // Chris, 9 October 2026: "the pascal course must also be sequential" (lib/sequence.php)
        ],
        // Grade 8, the first of the Grade 7/8 short courses (Chris, 10 October 2026 -
        // AIResources/courses/clubweb-course.md and grade7-8-courses.md). Build steps are
        // gated HTML blocks; art brand/clubweb-art-style.md.
        'clubweb' => [
            'subject' => 'gc',
            'title'   => 'Club website: your first HTML',
            'summary' => 'The Robotics Club needs a website for the Club Expo. Build it in HTML, one tag at a time.',
            'grades'  => 'Grade 8',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // Grade 7 (Chris, 10 October 2026 - AIResources/courses/tuckshop-course.md and
        // grade7-8-courses.md): the class runs the school tuck shop for a term. Every
        // step a gated spreadsheet block; art brand/tuckshop-art-style.md.
        'tuckshop' => [
            'subject' => 'gc',
            'title'   => 'Tuck-shop tycoon: spreadsheets',
            'summary' => 'Your class runs the school tuck shop for a term. Use a spreadsheet to price it, add up the takings, find the profit and plan the fundraiser.',
            'grades'  => 'Grade 7',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // Grade 7 (Chris, 10 October 2026 - AIResources/courses/machine-course.md and
        // grade7-8-courses.md): how computers work, as a shrunken class travels through
        // a broken computer. Gated questions; art brand/machine-art-style.md.
        'machine' => [
            'subject' => 'gc',
            'title'   => 'Inside the machine: how computers work',
            'summary' => 'A shrink ray goes wrong, and your class is stuck inside the school computer. Learn every part of it - and fix it - to get home.',
            'grades'  => 'Grade 7',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // Grade 8 (Chris, 10 October 2026 - AIResources/courses/factfake-course.md and
        // grade7-8-courses.md): the class runs the school's fact-check team, checking what
        // goes viral in the group chats. Gated questions; art brand/factfake-art-style.md.
        'factfake' => [
            'subject' => 'gc',
            'title'   => 'Fact or fake: checking what you see online',
            'summary' => 'Something goes viral in the Grade 8 group chat every day. Join the fact-check team and learn to check it before it spreads.',
            'grades'  => 'Grade 8',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        // Grade 7 (Chris, 11 October 2026 - AIResources/courses/botmaze-course.md and
        // grade7-8-courses.md): algorithms and robotics. Bolt, lost in Station Kestrel's
        // tunnels, programmed with blocks in the robot block (lib/robot.php). Gated; art
        // brand/botmaze-art-style.md.
        'botmaze' => [
            'subject' => 'gc',
            'title'   => 'Bolt\'s maze: algorithms and robotics',
            'summary' => 'Bolt the robot is lost in the space station\'s tunnels. Program it with blocks - steps, turns, loops and ifs - to bring it home.',
            'grades'  => 'Grade 7',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: "these should all be progress gated" (lib/sequence.php)
        ],
        'pascal' => [
            'subject' => 'it',
            'title'   => 'Programming in Pascal',
            'summary' => 'Object Pascal for IEB and CAPS Information Technology.',
            'grades'  => 'Grades 10-12',
            'status'  => 'open',    // joinable; content still being written
        ],

        // The Pascal course converted to Java, IEB only (Chris, 25 September
        // 2026 - AIResources/courses/java-course.md). Opened by Chris, 26
        // September 2026, with all 31 lessons written.
        'java' => [
            'subject' => 'it',
            'title'   => 'Programming in Java',
            'summary' => 'Java for IEB Information Technology.',
            'grades'  => 'Grades 10-12',
            'status'  => 'open',
        ],

        // Coming soon - listed, not yet written (Chris, 21 September 2026).
        // Draft while it was written (26 September 2026); opened by Chris,
        // 27 September 2026. AIResources/courses/sql-course.md.
        'sql' => [
            'subject' => 'it',
            'title'   => 'SQL and databases',
            'summary' => 'Designing databases and asking them questions with SQL.',
            'grades'  => 'Grades 10-12',
            'status'  => 'open',
            // Its SQL lessons come in dialects; each pupil's marks come from one
            // (Chris, 25 September 2026 - PupilSqlDialect(), lib/sql.php).
            'dialects' => true,
        ],
        // IT Theory, one course per grade for CAPS and IEB together (Chris,
        // 25 September 2026 - AIResources/courses/theory-course.md). They
        // replace the 'ittheory' placeholder, which never had pupils.
        // 'includes': joining a grade also joins the grades below it
        // (Enrol()), and a plan for it covers them (EntitledToMarking()).
        // 'glossaryFrom': the three share theory10's glossary, so Practice
        // in Grade 12 draws on all three years. Draft while they were written;
        // opened by Chris, 27 September 2026.
        // 'citeTool': the Harvard reference builder (public/cite.php) is
        // listed in the course contents (Chris, 27 September 2026).
        'theory10' => [
            'subject' => 'it',
            'title'   => 'IT Theory - Grade 10',
            'summary' => 'Hardware, software, data, networks, the Internet, security and the social side of computing.',
            'grades'  => 'Grade 10',
            'status'  => 'open',
            'citeTool' => true,
        ],
        'theory11' => [
            'subject'      => 'it',
            'title'        => 'IT Theory - Grade 11',
            'summary'      => 'Inside the machine, networks in depth, the growing Web, and keeping systems safe.',
            'grades'       => 'Grade 11',
            'status'       => 'open',
            'includes'     => ['theory10'],
            'glossaryFrom' => 'theory10',
            'citeTool'     => true,
        ],
        'theory12' => [
            'subject'      => 'it',
            'title'        => 'IT Theory - Grade 12',
            'summary'      => 'Performance, the cloud, security and privacy, and preparing for the theory exam.',
            'grades'       => 'Grade 12',
            'status'       => 'open',
            'includes'     => ['theory10', 'theory11'],
            'glossaryFrom' => 'theory10',
            'citeTool'     => true,
        ],
        // Maths Literacy Grade 10, CAPS and IEB together (Chris, 10 October 2026 -
        // AIResources/courses/mlit10-course.md): the year as 12 scenario batches, each
        // its own story and look; written batch by batch. Art brand/mlit10-art-style.md.
        'mlit10' => [
            'subject' => 'mlit',
            'title'   => 'Maths Literacy - Grade 10',
            'summary' => 'Run a food truck, pick the cheapest phone plan, bake to a recipe, find your seat at the stadium - the maths of real life, one job at a time.',
            'grades'  => 'Grade 10',
            'status'  => 'open',
            'sequential' => true,   // Chris, 10 October 2026: new courses are progress gated (lib/sequence.php)
        ],
        // CAT Theory, one course per grade for CAPS and IEB together, named
        // and built as the IT Theory courses are (Chris, 6 October 2026: "new
        // full courses named by grade as for it"; plan in
        // AIResources/courses/cat-course.md). A draft while it is written -
        // teachers and admins only; open since 9 October 2026, when the
        // old 'soon' placeholders (catword, catsheets, cathtml, cattheory)
        // were removed (Chris: "the draft and coming soon should not be there").
        'cattheory10' => [
            'subject' => 'cat',
            'title'   => 'CAT Theory - Grade 10',
            'summary' => 'What computers are, hardware, software, files, networks, the Internet, staying safe, and computers in society - step by step.',
            'grades'  => 'Grade 10',
            'status'  => 'open',
            'citeTool' => true,
        ],
        'cattheory11' => [
            'subject'      => 'cat',
            'title'        => 'CAT Theory - Grade 11',
            'summary'      => 'Inside the machine, networks and the mobile Internet, staying safe, AI and the digital workplace - step by step.',
            'grades'       => 'Grade 11',
            'status'       => 'open',
            'includes'     => ['cattheory10'],
            'glossaryFrom' => 'cattheory10',
            'citeTool'     => true,
        ],
        'cattheory12' => [
            'subject'      => 'cat',
            'title'        => 'CAT Theory - Grade 12',
            'summary'      => 'Choosing systems, the Internet and its services, security, the law and society, reports - and the exam guides.',
            'grades'       => 'Grade 12',
            'status'       => 'open',
            'includes'     => ['cattheory10', 'cattheory11'],
            'glossaryFrom' => 'cattheory10',
            'citeTool'     => true,
        ],
        // The CAT application courses (Chris, 8 October 2026: "do the cat
        // practical courses"): one course per program, its chapters by grade
        // (AIResources/courses/cat-course.md 3.3 - the 'grade' key on each
        // lesson in index.php). Real Office screens from the CAT VM, software
        // simulations, uploaded work marked; the glossary is CAT Theory's.
        'catword' => [
            'subject'      => 'cat',
            'title'        => 'Word Processing',
            'summary'      => 'Microsoft Word step by step: typing and editing, formatting, page layout, lists, tables, pictures and finishing a document - on real Word screens, then in Word itself.',
            'grades'       => 'Grades 10-12',
            'status'       => 'open',
            'glossaryFrom' => 'cattheory10',
        ],
        'catexcel' => [
            'subject'      => 'cat',
            'title'        => 'Spreadsheets',
            'summary'      => 'Microsoft Excel step by step: cells and sheets, formulas, formatting, functions and charts - on real Excel screens, then in Excel itself.',
            'grades'       => 'Grades 10-12',
            'status'       => 'open',
            'glossaryFrom' => 'cattheory10',
        ],
        'catpowerpoint' => [
            'subject'      => 'cat',
            'title'        => 'Presentations',
            'summary'      => 'Microsoft PowerPoint for the PAT: slides and designs, text, tables and charts, animation and the slide show.',
            'grades'       => 'Grade 10',
            'status'       => 'open',
            'glossaryFrom' => 'cattheory10',
        ],
        'cathtml' => [
            'subject'      => 'cat',
            'title'        => 'Web Design (HTML)',
            'summary'      => 'Writing web pages in HTML: tags, headings, text, lists, tables, pictures and links - typed and checked with a live preview.',
            'grades'       => 'Grades 10-12',
            'status'       => 'open',
            'glossaryFrom' => 'cattheory10',
        ],
        'catdb' => [
            'subject'      => 'cat',
            'title'        => 'Databases',
            'summary'      => 'Microsoft Access step by step: tables, fields and properties, forms, queries and reports, then designing a database for a scenario - on real Access screens, then in Access itself.',
            'grades'       => 'Grades 11-12',
            'status'       => 'open',
            'glossaryFrom' => 'cattheory10',
        ],
        // A sample lesson from the CAT planning session, kept apart from the
        // CAT courses for Chris to judge (27 September 2026: "i need the pilot
        // on the test server separate from the rest of the course"). The plan
        // is AIResources/courses/cat-course.md section 7. On live too since 4
        // October 2026 (Chris: "show it on live too") - still a draft, so only
        // teachers and admins see it; Admin > course settings can hide it.
        // Retired 9 October 2026 when the real CAT courses opened (Chris:
        // "the draft and coming soon should not be there"): off every course
        // list, its lessons kept for the checks that use them.
        'catpilot' => [
            'retired' => true,
            'subject' => 'cat',
            'title'   => 'CAT pilot - sample lessons',
            'summary' => 'Samples for review, not the course: theory lesson 1, and one lesson each in Word, Excel and Access done on real software screens.',
            'grades'  => 'Grades 10-11',
            'status'  => 'draft',
        ],
    ];

    // The admin's settings (lib/access.php, 28 September 2026): free or
    // subscription, live / pilot / hidden, the order, grades, a year plan.
    require_once __DIR__ . '/access.php';
    $courses = ApplyCourseSettings ($courses);

    // A 'pilot' course exists only on the test site and the testbed, never
    // live: the live site is the folder named itcoder (/var/www/itcoder).
    if (basename (dirname (__DIR__)) === 'itcoder')
    {
        $courses = array_filter ($courses, fn ($course) => empty ($course['pilot']));
    } // if this is the live site

    $shown = array_filter ($courses, fn ($course) => ($course['visibility'] ?? 'live') !== 'removed');

    return $aWithRemoved ? $courses : $shown;
} // CourseIndex


/** Courses with content - everything except 'soon'. What class results,
 *  admin and the checkers work over. */
function ActiveCourses () : array
{
    return array_filter (CourseIndex (), function ($course) {
        return ($course['status'] ?? 'draft') !== 'soon';
    });
} // ActiveCourses


/** True for a course that is listed but not written yet. */
function CourseIsSoon (string $aCourseId) : bool
{
    return (CourseIndex ()[$aCourseId]['status'] ?? '') === 'soon';
} // CourseIsSoon


/**
 * The course the person is in now, for this browser session (Chris, 28
 * September 2026: class marks "automatically defaults to the AI course - make
 * it set to the currently selected course instead"). SiteMenuHtml() notes it
 * on every page that belongs to a course; teacher pages that pick a course
 * start on it (TeacherCourseDefault(), lib/groups.php).
 */
function NoteCurrentCourse (string $aCourseId) : void
{
    if (session_status () === PHP_SESSION_ACTIVE && CourseExists ($aCourseId)) { $_SESSION['currentCourse'] = $aCourseId; }
} // NoteCurrentCourse


/** The course NoteCurrentCourse() last noted, or ''. */
function CurrentCourse () : string
{
    return (session_status () === PHP_SESSION_ACTIVE) ? (string) ($_SESSION['currentCourse'] ?? '') : '';
} // CurrentCourse


function CourseExists (string $aCourseId) : bool
{
    return array_key_exists ($aCourseId, CourseIndex ());
} // CourseExists


/** A course's title - "Programming in Pascal" - or its id when there is no such course (1 October 2026: looked up by hand in some twenty places). */
function CourseTitle (string $aCourseId) : string
{
    return (string) (CourseIndex ()[$aCourseId]['title'] ?? $aCourseId);
} // CourseTitle


/** The courses a pupil can see: 'open' and 'soon' ones, plus 'draft' ones
 *  a teacher is allowed to preview. Only 'open' and 'draft' can be joined -
 *  see CourseIsSoon(). */
function VisibleCourses (array $aPupil) : array
{
    $isTeacher = ((int) ($aPupil['isTeacher'] ?? 0) === 1);
    $isAdmin   = IsAdmin ($aPupil);

    return array_filter (CourseIndex (), function ($course) use ($isTeacher, $isAdmin) {
        $status = $course['status'] ?? 'draft';

        // A course the admin hid (Manage courses, 28 September 2026) is theirs alone.
        if (($course['visibility'] ?? 'live') === 'hidden' && !$isAdmin) { return false; }
        // A retired course (the CAT pilot) is on nobody's list.
        if (!empty ($course['retired'])) { return false; }

        return $isTeacher || $status === 'open' || $status === 'soon';
    });
} // VisibleCourses


/** A pupil's visible courses, grouped by subject in SubjectIndex() order:
 *  subjectId => [courseId => course]. Subjects with no courses are included,
 *  with an empty list. */
function VisibleCoursesBySubject (array $aPupil) : array
{
    $grouped = array_fill_keys (array_keys (SubjectIndex ()), []);

    foreach (VisibleCourses ($aPupil) as $courseId => $course)
    {
        $grouped[$course['subject'] ?? 'gc'][$courseId] = $course;
    } // foreach visible course

    return $grouped;
} // VisibleCoursesBySubject


/** Which marking voice bin/markqueue.php uses for a course's written answers. */
function CourseMarkStyle (string $aCourseId) : string
{
    switch ($aCourseId)
    {
        case 'ai':     return 'ai';
        case 'pascal':
        case 'pascal9': return 'pascal';   // the Grade 9 course writes the same Pascal (9 October 2026)
        case 'java':   return 'java';
        case 'theory10':
        case 'theory11':
        case 'theory12': return 'theory';
        case 'cattheory10':
        case 'cattheory11':
        case 'cattheory12':
        case 'catword':
        case 'catexcel':
        case 'catpowerpoint':
        case 'cathtml':
        case 'catdb':       return 'cat';
        default:       return 'generic';
    } // switch course
} // CourseMarkStyle


/**
 * The programming language a course teaches and its console runs - 'pascal',
 * 'java' - or null for a course with no code (the AI course). Everything that
 * compiles, colours, checks the layout of or marks code asks this.
 */
function CourseLanguage (string $aCourseId) : ?string
{
    $style = CourseMarkStyle ($aCourseId);

    return in_array ($style, ['pascal', 'java'], true) ? $style : null;
} // CourseLanguage


/**
 * The language a course's typed code answers are in, for CodeLanguage():
 * its CourseLanguage(), 'sql' for the SQL course (the one with dialects), or
 * 'pascal' for everything else.
 */
function CourseCodeLanguage (string $aCourseId) : string
{
    return CourseLanguage ($aCourseId)
        ?? (!empty (CourseIndex ()[$aCourseId]['dialects']) ? 'sql' : 'pascal');
} // CourseCodeLanguage


/** The language's name as a pupil reads it: "Pascal", "Java". */
function LanguageName (?string $aLanguage) : string
{
    return ($aLanguage === 'java') ? 'Java' : 'Pascal';
} // LanguageName


/* -------------------------------------------------------------- enrolment --- */

function IsEnrolled (int $aPupilId, string $aCourseId) : bool
{
    $statement = Db ()->prepare (
        'SELECT 1 FROM enrolments WHERE pupilId = ? AND courseId = ?'
    );
    $statement->execute ([$aPupilId, $aCourseId]);

    return $statement->fetchColumn () !== false;
} // IsEnrolled


/**
 * Joins a course - and every course it includes (a theory grade includes the
 * grades below it), as real enrolments, so class results, Practice and
 * "carry on" treat them like any other joined course.
 */
function Enrol (int $aPupilId, string $aCourseId) : void
{
    $statement = Db ()->prepare (
        'INSERT INTO enrolments (pupilId, courseId, enrolledAt) VALUES (?, ?, ?)
         ON CONFLICT (pupilId, courseId) DO NOTHING'
    );

    foreach (array_merge ([$aCourseId], CourseIncludes ($aCourseId)) as $courseId)
    {
        $statement->execute ([$aPupilId, $courseId, Now ()]);
    } // foreach course joined
} // Enrol


/**
 * A pupil presses Join on a course list (courses.php, subjects.php): joined
 * only if the course is real, visible to them and not 'soon'. True when they
 * joined (1 October 2026: the check was written out on both pages). Not a
 * course locked through and through (CourseJoinable(), 3 October 2026) - an
 * invitation enrols with Enrol() and is not stopped by this.
 */
function JoinCourse (array $aPupil, string $aCourseId) : bool
{
    if (!CourseExists ($aCourseId) || !isset (VisibleCourses ($aPupil)[$aCourseId]) || CourseIsSoon ($aCourseId)) { return false; }

    require_once __DIR__ . '/access.php';
    if (!CourseJoinable ($aPupil, $aCourseId)) { return false; }

    Enrol ((int) $aPupil['id'], $aCourseId);

    return true;
} // JoinCourse


/** The courses a course brings with it: theory12 -> theory10, theory11. */
function CourseIncludes (string $aCourseId) : array
{
    return CourseIndex ()[$aCourseId]['includes'] ?? [];
} // CourseIncludes


/** Course ids this pupil has joined. */
function EnrolledCourseIds (int $aPupilId) : array
{
    $statement = Db ()->prepare (
        'SELECT courseId FROM enrolments WHERE pupilId = ?'
    );
    $statement->execute ([$aPupilId]);

    return $statement->fetchAll (PDO::FETCH_COLUMN);
} // EnrolledCourseIds


/**
 * Guard for every page that lives inside a course. Signed in, the course is
 * real, and this pupil has joined it - otherwise back to the catalogue.
 */
function RequireEnrolment (string $aCourseId) : array
{
    $pupil = RequirePupil ();

    if (!CourseExists ($aCourseId))
    {
        http_response_code (404);
        exit ('No such course.');
    } // if the course id is not one of ours

    if (CourseIsSoon ($aCourseId))
    {
        header ('Location: /courses.php');
        exit;
    } // if the course is not written yet

    if (!IsEnrolled ((int) $pupil['id'], $aCourseId))
    {
        // A teacher may look at a draft course without enrolling - one the site trusts (lib/access.php, 3 October 2026).
        require_once __DIR__ . '/access.php';

        if (IsStaffAccount ($pupil))
        {
            return $pupil;
        } // if a teacher previewing

        header ('Location: /courses.php');
        exit;
    } // if not enrolled

    return $pupil;
} // RequireEnrolment
