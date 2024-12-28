// zig run 15b.zig

const std = @import("std");

const stdin = std.io.getStdIn().reader();
const print = std.debug.print;
const assert = std.debug.assert;

const N = 101;
const M = 20001;
const DX = [_]i8{ 1, 0, -1, 0 };
const DY = [_]i8{ 0, 1, 0, -1 };

fn dirIndex(needle: u8) usize {
    for ("v>^<", 0..) |c, i| {
        if (c == needle) return i;
    }
    unreachable;
}

fn move(x: usize, shift: isize) usize {
    return @as(usize, @intCast(@as(isize, @intCast(x)) + shift));
}

pub fn main() !void {
    var a = [_][N]u8{[_]u8{0} ** N} ** N;
    var buf = [_]u8{0} ** N;
    var n: usize = 0;
    var cx: usize = 0;
    var cy: usize = 0;
    while (try stdin.readUntilDelimiterOrEof(&buf, '\n')) |line| {
        if (line.len == 0) break;
        for (line, 0..) |c, j| {
            switch (c) {
                '#' => {
                    a[n][j*2] = '#';
                    a[n][j*2+1] = '#';
                },
                'O' => {
                    a[n][j*2] = '[';
                    a[n][j*2+1] = ']';
                },
                '.' => {
                    a[n][j*2] = '.';
                    a[n][j*2+1] = '.';
                },
                '@' => {
                    cx = n;
                    cy = j*2;
                    a[n][j*2] = '.';
                    a[n][j*2+1] = '.';
                },
                else => unreachable
            }
        }
        n += 1;
    }

    var steps = [_]u8{0} ** M;
    var m: usize = 0;
    while (try stdin.readUntilDelimiterOrEof(steps[m..], '\n')) |line| {
        m += line.len;
    }

    var qx = [_]usize{0} ** N;
    var qy = [_]usize{0} ** N;
    var used = [_][N]bool{[_]bool{false} ** N} ** N;

    for (0..m) |it| {
        const d = dirIndex(steps[it]);

        for (0..n) |i| {
            @memset(&used[i], false);
        }

        const cxx = move(cx, DX[d]);
        const cyy = move(cy, DY[d]);
        switch (a[cxx][cyy]) {
            '#' => continue,
            '.' => {
                cx = cxx;
                cy = cyy;
                continue;
            },
            else => {}
        }

        var blocked = false;
        var qb: usize = 0;
        qx[0] = cxx;
        qy[0] = if (a[cxx][cyy] == ']') cyy - 1 else cyy;
        var qe: usize = 1;
        used[qx[0]][qy[0]] = true;
        while (qb < qe) {
            const x = qx[qb];
            const y = qy[qb];
            qb += 1;
            const xx = move(x, DX[d]);
            const yy = move(y, DY[d]);
            if (a[xx][yy] == '#' or a[xx][yy + 1] == '#') {
                blocked = true;
                break;
            }
            if (a[xx][yy] == '[' and !used[xx][yy]) {
                used[xx][yy] = true;
                qx[qe] = xx;
                qy[qe] = yy;
                qe += 1;
            }
            if (a[xx][yy] == ']' and !used[xx][yy - 1]) {
                used[xx][yy - 1] = true;
                qx[qe] = xx;
                qy[qe] = yy - 1;
                qe += 1;
            }
            if (a[xx][yy + 1] == '[' and !used[xx][yy + 1]) {
                used[xx][yy + 1] = true;
                qx[qe] = xx;
                qy[qe] = yy + 1;
                qe += 1;
            }
        }

        if (blocked) continue;

        var i: usize = qe;
        while (i > 0) {
            i -= 1;
            const x = qx[i];
            const y = qy[i];
            const xx = move(x, DX[d]);
            const yy = move(y, DY[d]);
            if (d == 1) {
                a[xx][yy + 1] = a[x][y + 1];
                a[xx][yy] = a[x][y];
            } else {
                a[xx][yy] = a[x][y];
                a[xx][yy + 1] = a[x][y + 1];
            }
            if (d != 3) a[x][y] = '.';
            if (d != 1) a[x][y + 1] = '.';
        }

        cx = cxx;
        cy = cyy;
    }

    var ans: usize = 0;
    for (0..n) |xx| {
        for (0..n*2) |yy| {
            if (a[xx][yy] == '[') {
                ans += 100 * xx + yy;
            }
        }
    }

    print("{}\n", .{ans});
}
