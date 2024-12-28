// d=$(mktemp -d) && cp 06a.hx $d/Solution.hx && haxe -C $d --main Solution --interp

using StringTools;

var dx = [1, 0, -1, 0];
var dy = [0, 1, 0, -1];

class Solution {
    public static function main() {
        var a = Sys.stdin().readAll().toString().trim().split("\n");
        var n = a.length;
        var m = a[0].length;

        var x = 0;
        var y = 0;
        while (true) {
            if (a[x].charAt(y) == '^') break;
            if (++y == m) {
                x++;
                y = 0;
            }
        }

        var b = [for (i in 0...n) [for (j in 0...m) false]];
        var d = 2;
        while (true) {
            b[x][y] = true;
            var xx = x + dx[d];
            if (!(0 <= xx && xx < n)) break;
            var yy = y + dy[d];
            if (!(0 <= yy && yy < m)) break;
            if (a[xx].charAt(yy) == '#') {
                d = (d + 3) % 4;
            } else {
                x = xx;
                y = yy;
            }
        }

        var ans = 0;
        for (i in 0...n) {
            for (j in 0...n) {
                if (b[i][j]) ans++;
            }
        }
        Sys.println(ans);
    }
}
