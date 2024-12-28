<?php
// php 09b.php

$line = trim(fgets(STDIN));
$n = strlen($line);
$a = array();
$m = 0;
$p = 1;
$f = array();
$t = array();
for ($i = 0; $i < $n; $i++) {
    $len = ord($line[$i]) - ord('0');
    for ($j = 0; $j < $len; $j++) {
        $a[$m++] = $i % 2 == 0 ? $p : 0;
    }
    if ($i % 2 == 0) {
        array_push($t, [$m - $len, $len]);
        $p++;
    } else {
        if (!array_key_exists($len, $f)) {
            $f[$len] = array();
        }
        array_push($f[$len], $m - $len);
    }
}

ksort($f);
$t = array_reverse($t);

foreach ($t as [$start, $len]) {
    $found = -1;
    $index = -1;
    for ($l = $len; $l < 10; $l++) {
        if (!array_key_exists($l, $f)) continue;
        if ($index == -1 || $f[$l][0] < $index) {
            $found = $l;
            $index = $f[$l][0];
        }
    }
    if ($found == -1 || $index >= $start) continue;
    unset($f[$found][0]);
    $f[$found] = array_values($f[$found]);
    if (count($f[$found]) == 0) {
        unset($f[$found]);
    }

    for ($i = 0; $i < $len; $i++) {
        $a[$index + $i] = $a[$start + $i];
        $a[$start + $i] = 0;
    }

    $rem = $found - $len;
    if ($rem > 0) {
        if (!array_key_exists($rem, $f)) {
            $f[$rem] = array();
        }
        array_push($f[$rem], $index + $len);
        sort($f[$rem]);
    }
}

$ans = 0;
for ($i = 0; $i < $m; $i++) if ($a[$i] != 0) {
    $ans += ($a[$i] - 1) * $i;
}
print($ans . "\n");
