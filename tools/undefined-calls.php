<?php
// Lists calls to functions that no file in the tree defines and PHP does not have:
// a commit that took a hunk calling another chat's uncommitted function.
// php undefined_calls.php TREE
$tree = rtrim ($argv[1], '/');
$files = [];
foreach (['lib', 'public', 'bin', 'content'] as $dir) {
    $it = new RecursiveIteratorIterator (new RecursiveDirectoryIterator ("$tree/$dir", FilesystemIterator::SKIP_DOTS));
    foreach ($it as $f) { if (str_ends_with ($f->getFilename (), '.php')) { $files[] = $f->getPathname (); } }
}
$defined = []; $calls = [];
foreach ($files as $file) {
    $tokens = token_get_all (file_get_contents ($file));
    $n = count ($tokens);
    for ($i = 0; $i < $n; $i++) {
        $t = $tokens[$i];
        if (!is_array ($t) || $t[0] !== T_STRING) { continue; }
        // previous meaningful token
        $p = $i - 1; while ($p >= 0 && is_array ($tokens[$p]) && in_array ($tokens[$p][0], [T_WHITESPACE, T_COMMENT, T_DOC_COMMENT], true)) { $p--; }
        $prev = $p >= 0 ? $tokens[$p] : null;
        $q = $i + 1; while ($q < $n && is_array ($tokens[$q]) && in_array ($tokens[$q][0], [T_WHITESPACE, T_COMMENT, T_DOC_COMMENT], true)) { $q++; }
        $next = $q < $n ? $tokens[$q] : null;
        if (is_array ($prev) && $prev[0] === T_FUNCTION) { $defined[strtolower ($t[1])] = true; continue; }
        if ($next !== '(') { continue; }
        if (is_array ($prev) && in_array ($prev[0], [T_OBJECT_OPERATOR, T_DOUBLE_COLON, T_NEW, T_NULLSAFE_OBJECT_OPERATOR, T_FUNCTION], true)) { continue; }
        if ($prev === '&' ) { $pp = $p - 1; while ($pp >= 0 && is_array ($tokens[$pp]) && $tokens[$pp][0] === T_WHITESPACE) { $pp--; } if ($pp >= 0 && is_array ($tokens[$pp]) && $tokens[$pp][0] === T_FUNCTION) { $defined[strtolower ($t[1])] = true; continue; } }
        $calls[strtolower ($t[1])][] = substr ($file, strlen ($tree) + 1) . ':' . $t[2];
    }
}
$missing = 0;
foreach ($calls as $name => $where) {
    if (isset ($defined[$name]) || function_exists ($name) || in_array ($name, ['list', 'array', 'isset', 'empty', 'unset', 'eval', 'exit', 'die', 'match', 'fn'], true)) { continue; }
    echo $name, ': ', implode (', ', array_slice (array_unique ($where), 0, 4)), (count ($where) > 4 ? ' ...' : ''), "\n";
    $missing++;
}
echo $missing === 0 ? "OK - every function called is defined.\n" : "$missing function(s) called but not defined.\n";
