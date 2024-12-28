// dmd 08a.d

module solution;

import std.array;
import std.stdio;
import std.string;
import std.typecons;

void main() {
    auto a = stdin.byLineCopy(Yes.keepTerminator).join().strip().split("\n");
    auto n = a.length;
    auto m = a[0].length;
    bool[][] b = new bool[][n];
    foreach(x; 0..n) {
        b[x] = new bool[m];
    }
    foreach(x1; 0..n) foreach(y1; 0..m) {
        if (a[x1][y1] == '.') continue;
        foreach(x2; 0..n) foreach(y2; 0..m) {
            if (x1 == x2 && y1 == y2) continue;
            if (a[x2][y2] != a[x1][y1]) continue;
            auto dx = x2 - x1;
            auto dy = y2 - y1;

            auto x = x1 - dx;
            auto y = y1 - dy;
            if (0 <= x && x < n && 0 <= y && y < m) b[x][y] = true;
            x = x2 + dx;
            y = y2 + dy;
            if (0 <= x && x < n && 0 <= y && y < m) b[x][y] = true;
        }
    }
    auto ans = 0;
    foreach(x; 0..n) {
        foreach(y; 0..m) {
            if (b[x][y]) ans++;
        }
    }
    writeln(ans);
}
