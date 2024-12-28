# raku 10a.raku

my @dx = 1, 0, -1, 0;
my @dy = 0, 1, 0, -1;

my @a = lines();
my $n = @a.elems;
my $m = @a[0].chars;

my $b = [[False xx $m] xx $n];
my $q = [Pair.new(0, 0) xx $n * $m];
my $ans = 0;
for 0..^$n -> $x0 {
    for 0..^$m -> $y0 {
        next if substr(@a[$x0], $y0, 1) !eq "0";

        for 0..^$n -> $i {
            for 0..^$m -> $j {
                $b[$i][$j] = False;
            }
        }

        my $qb = 0;
        my $qe = 0;
        $q[$qe++] = Pair.new($x0, $y0);
        $b[$x0][$y0] = True;
        while $qb < $qe {
            my $z = $q[$qb++];
            my $x = $z.key;
            my $y = $z.value;
            my $c = substr(@a[$x], $y, 1);
            for 0..^4 -> $d {
                my $xx = $x + @dx[$d];
                my $yy = $y + @dy[$d];
                if 0 <= $xx and $xx < $n and 0 <= $yy and $yy < $m and
                    not $b[$xx][$yy] and
                    ord(substr(@a[$xx], $yy, 1)) == ord($c) + 1 {
                    $q[$qe++] = Pair.new($xx, $yy);
                    $b[$xx][$yy] = True;
                }
            }
        }

        my $cur = 0;
        for 0..^$n -> $x {
            for 0..^$n -> $y {
                $cur++ if substr(@a[$x], $y, 1) eq "9" and $b[$x][$y];
            }
        }
        $ans += $cur;
    }
}
say $ans;
