// d=$(mktemp -d) && cp 06b.hx $d/Solution.hx && haxe -C $d --main Solution --interp

using StringTools;

var dx = [1, 0, -1, 0];
var dy = [0, 1, 0, -1];

class Solution {
    public static function main() {
        var a = Sys.stdin().readAll().toString().trim().split("\n");
        var n = a.length;
        var m = a[0].length;
        var limit = n * m * 5;

        var sx = 0;
        var sy = 0;
        while (true) {
            if (a[sx].charAt(sy) == '^') break;
            if (++sy == m) {
                sx++;
                sy = 0;
            }
        }

        var ans = 0;
        for (x0 in 0...n) {
            for (y0 in 0...m) {
                if (x0 == sx && y0 == sy) continue;
                var x = sx;
                var y = sy;
                var d = 2;
                var steps = 0;
                while (steps < limit) {
                    var xx = x + dx[d];
                    if (!(0 <= xx && xx < n)) break;
                    var yy = y + dy[d];
                    if (!(0 <= yy && yy < m)) break;
                    if (a[xx].charAt(yy) == '#' || (xx == x0 && yy == y0)) {
                        d = (d + 3) % 4;
                    } else {
                        x = xx;
                        y = yy;
                        steps++;
                    }
                }
                if (steps == limit) ans++;
            }
        }
        Sys.println(ans);
    }
}
