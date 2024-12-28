<?php
// php 09a.php

$line = trim(fgets(STDIN));
$n = strlen($line);
$a = array();
$m = 0;
$p = 1;
$sum = 0;
for ($i = 0; $i < $n; $i++) {
    $len = ord($line[$i]) - ord('0');
    for ($j = 0; $j < $len; $j++) {
        $a[$m++] = $i % 2 == 0 ? $p : 0;
    }
    if ($i % 2 == 0) {
        $p++;
        $sum += $len;
    }
}

$i = 0;
while ($a[$i] != 0) $i++;
$j = $m - 1;
do {
    $a[$i] = $a[$j];
    $i++;
    while ($i < $m && $a[$i] != 0) $i++;
    $j--;
    while ($a[$j] == 0) $j--;
} while ($i < $j);

$ans = 0;
for ($i = 0; $i < $sum; $i++) {
    $ans += ($a[$i] - 1) * $i;
}
print($ans . "\n");
