<?php
// Drafts content/java/glossary.php from every Gloss() popup and every study
// block's key terms in the Java lessons, in teaching order. The first place a
// term is taught wins. Grade and examined come from the Pascal glossary when
// it has the same term, otherwise from the lesson's SAGs lines.
$root = 'D:/DB Sync/Dropbox/Projects/AIPascalCourse';
require $root . '/lib/db.php';
require $root . '/lib/content.php';

$index = require $root . '/content/java/index.php';
uasort ($index, fn ($a, $b) => $a['number'] <=> $b['number']);
$sags = (require $root . '/content/java/sags.php')['lessons'];

$pascal = [];
foreach ((require $root . '/content/pascal/glossary.php') as $row) { $pascal[mb_strtolower ($row[0])] = $row; }

// The grade of a lesson: its lowest SAGs grade, or the last one seen for enrichment.
$lessonGrade = [];
$lastGrade = 10;
foreach ($index as $lessonId => $lesson)
{
    $lines = $sags[$lessonId] ?? [];
    if (isset ($lines['enrichment']) || $lines === []) { $lessonGrade[$lessonId] = [$lastGrade, false]; continue; }
    $grade = min (array_map (fn ($l) => $l[0], $lines));
    $lessonGrade[$lessonId] = [$grade, true];
    $lastGrade = $grade;
}

// Named anchors in a file, with their byte offsets.
function Anchors (string $aText) : array
{
    $found = [];
    preg_match_all ('/<span class="block-anchor" id="(\w+)"/', $aText, $m, PREG_OFFSET_CAPTURE);
    foreach ($m[1] as $hit) { $found[$hit[1]] = $hit[0]; }
    preg_match_all ("/^    'anchor'\s*=>\s*'(\w+)'/m", $aText, $m, PREG_OFFSET_CAPTURE);
    foreach ($m[1] as $hit) { $found[$hit[1]] = $hit[0]; }
    ksort ($found);
    return $found;
}

function AnchorBefore (array $aAnchors, int $anOffset) : string
{
    $anchor = '';
    foreach ($aAnchors as $offset => $name) { if ($offset < $anOffset) { $anchor = $name; } }
    return $anchor;
}

$all = [];     // lowercased term => every occurrence, in teaching order
foreach ($index as $lessonId => $lesson)
{
    $file = $root . '/content/java/' . $lessonId . '.php';
    $text = file_get_contents ($file);
    $anchors = Anchors ($text);
    $tokens = token_get_all ($text);
    $offset = 0;
    $positions = [];
    foreach ($tokens as $token) { $positions[] = $offset; $offset += strlen (is_array ($token) ? $token[1] : $token); }

    $count = count ($tokens);
    for ($i = 0; $i < $count; $i++)
    {
        if (!is_array ($tokens[$i]) || $tokens[$i][0] !== T_STRING || $tokens[$i][1] !== 'Gloss') { continue; }
        $args = [];
        for ($j = $i + 1; $j < $count && count ($args) < 2; $j++)
        {
            if (is_array ($tokens[$j]) && $tokens[$j][0] === T_CONSTANT_ENCAPSED_STRING) { $args[] = eval ('return ' . $tokens[$j][1] . ';'); }
            elseif (!is_array ($tokens[$j]) && $tokens[$j] === ')') { break; }
        }
        if (count ($args) < 2) { continue; }
        [$term, $definition] = $args;
        $key = mb_strtolower (trim ($term));
        $all[$key][] = [trim ($term), $lessonId, AnchorBefore ($anchors, $positions[$i]), trim (preg_replace ('#</?[a-zA-Z][^>]*>#', '', $definition))];
    }

    // Key terms of the study block that no popup has taught yet
    foreach (LoadLesson ('java', $lessonId) as $block)
    {
        if (($block['type'] ?? '') !== 'study') { continue; }
        foreach (($block['keyTerms'] ?? []) as $term => $definition)
        {
            $key = mb_strtolower (trim ($term));
            $at = stripos ($text, $term, (int) strpos ($text, 'return ['));
            $anchor = $at === false ? '' : AnchorBefore ($anchors, $at);
            $all[$key][] = [trim ($term), $lessonId, $anchor, trim (preg_replace ('#</?[a-zA-Z][^>]*>#', '', $definition))];
        }
    }
}

// Choose one occurrence per term: the first whose definition stands on its own.
$dirty = '/\b(this lesson|in this lesson|lesson \d+|below|above|so far|here:)\b/i';
$terms = [];
$also = [];
foreach ($all as $key => $list)
{
    $chosen = $list[0];
    foreach ($list as $one) { if (!preg_match ($dirty, $one[3])) { $chosen = $one; break; } }
    // A plural or singular of a term already in: the same entry
    foreach ([$key . 's', preg_replace ('/s$/', '', $key), $key . 'es', preg_replace ('/es$/', '', $key)] as $twin)
    {
        if ($twin !== $key && isset ($terms[$twin])) { $also[$twin][] = $chosen[0]; continue 2; }
    }
    $terms[$key] = $chosen;
}
$codeWords = '/[.()=\/<>_]|^(println|print|printf|javac|java|jar|jdeps|jpackage|ij|camelCase|javaw|null|this|super|new|static|void|final|private|public|protected|extends|instanceof|abstract|true|false|int|double|boolean|char|long|float|byte|short|var|args|main|equals|compareTo|toString|length|charAt|split|substring|indexOf|trim|repeat|next|nextLine|nextInt|hasNextLine|parseInt|parseDouble|valueOf|getMessage|throws|throw|try|catch|finally|switch|case|default|break|continue|return|import|package|class|interface|enum|while|for|do|if|else|args)$/';
foreach ($terms as $key => $row)
{
    if (preg_match ('/^[a-z]/', $row[0]) && !preg_match ($codeWords, $row[0]) && !preg_match ('/[A-Z]/', $row[0]))
    {
        $terms[$key][0] = ucfirst ($row[0]);
    }
}

// Hand edits (26 September 2026): duplicates become 'also' names of one term,
// context-bound wording fixed, and a few examined flags.
$mergeInto = [
    '2-d array' => 'two-dimensional array', 'colour palette' => 'palette', '\u001b[k' => 'clear to the end of the line',
    'declare' => 'declaring', 'garbage collector' => 'garbage collection', 'stop value' => 'sentinel value',
    '%' => 'remainder operator', 'if / else' => 'if', 'decision making / branching / selection' => 'branching',
    'keyword' => 'reserved word',
];
foreach ($mergeInto as $from => $to)
{
    if (isset ($terms[$from]) && isset ($terms[$to])) { $also[$to][] = $terms[$from][0]; unset ($terms[$from]); }
}
unset ($terms['tui / gui / cli'], $terms['&& / || / !']);
$define = [
    'ibm' => 'International Business Machines - one of the oldest computing companies still operating. It made Fortran and SQL, and a long line of mainframe computers.',
    'wora' => 'Write Once, Run Anywhere - Java\'s slogan: one program runs on any device that has a Java Virtual Machine.',
    'reserved word' => 'A word the language itself uses for something specific, so it cannot be used as a name of your own - class, public, static and void, for example. Java calls them keywords.',
];
foreach ($define as $key => $text) { if (isset ($terms[$key])) { $terms[$key][3] = $text; } }
$flags = ['hubris' => [10, false], 'sql injection' => [11, true], 'database' => [10, true], 'sqlite' => [11, false]];

// Teaching order: by the lesson that teaches each term
$order = array_flip (array_keys ($index));
uasort ($terms, fn ($a, $b) => $order[$a[1]] <=> $order[$b[1]]);

// Write it, grouped by lesson in teaching order
$out = [];
$current = '';
foreach ($terms as $key => [$term, $lessonId, $anchor, $definition])
{
    [$grade, $examined] = $lessonGrade[$lessonId];
    $extras = '';
    if (isset ($pascal[$key])) { $grade = $pascal[$key][1]; $examined = $examined && $pascal[$key][2]; }
    if (isset ($flags[$key])) { [$grade, $examined] = $flags[$key]; }
    if ($lessonId !== $current)
    {
        $current = $lessonId;
        $title = $index[$lessonId]['title'];
        $label = ctype_digit (substr ($lessonId, -2)) && str_starts_with ($lessonId, 'lesson') ? 'Lesson ' . (int) substr ($lessonId, 6) : 'IEB';
        $out[] = '';
        $out[] = '    // ---- ' . $label . ' - ' . $title . ' ' . str_repeat ('-', max (3, 60 - strlen ($label . $title)));
    }
    $extra = isset ($also[$key]) ? ", ['also' => " . var_export (array_values (array_unique ($also[$key])), true) . ']' : '';
    $extra = str_replace (["array (
  0 => ", "
  1 => ", "
  2 => ", ",
)"], ['[', ', ', ', ', ']'], $extra);
    $out[] = '    [' . var_export ($term, true) . ', ' . $grade . ', ' . ($examined ? 'true' : 'false') . ', ' . var_export ($lessonId, true) . ', '
           . var_export ($anchor, true) . ', ' . var_export ($definition, true) . $extra . '],';
}
file_put_contents ($argv[1], implode ("\n", $out) . "\n");
echo count ($terms), " terms\n";
