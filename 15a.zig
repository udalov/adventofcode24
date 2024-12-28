// zig run 15a.zig

const std = @import("std");

const stdin = std.io.getStdIn().reader();
const print = std.debug.print;
const assert = std.debug.assert;

const N = 51;
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
    var n: usize = 0;
    var x: usize = 0;
    var y: usize = 0;
    while (try stdin.readUntilDelimiterOrEof(&a[n], '\n')) |line| {
        if (line.len == 0) break;
        for (line, 0..) |c, j| {
            if (c == '@') {
                x = n;
                y = j;
                line[j] = '.';
            }
        }
        n += 1;
    }

    var steps = [_]u8{0} ** M;
    var m: usize = 0;
    while (try stdin.readUntilDelimiterOrEof(steps[m..], '\n')) |line| {
        m += line.len;
    }

    for (0..m) |it| {
        const d = dirIndex(steps[it]);
        var xx = x;
        var yy = y;
        while (true) {
            xx = move(xx, DX[d]);
            yy = move(yy, DY[d]);
            if (a[xx][yy] != 'O') break;
        }
        if (a[xx][yy] == '#') continue;
        while (true) {
            const nx = move(xx, -DX[d]);
            const ny = move(yy, -DY[d]);
            a[xx][yy] = a[nx][ny];
            xx = nx;
            yy = ny;
            if (xx == x and yy == y) break;
        }
        a[x][y] = '.';
        x = move(x, DX[d]);
        y = move(y, DY[d]);
    }

    var ans: usize = 0;
    for (0..n) |xx| {
        for (0..n) |yy| {
            if (a[xx][yy] == 'O') {
                ans += 100 * xx + yy;
            }
        }
    }

    print("{}\n", .{ans});
}
