// tsc 21b.ts && node 21b.js

const UP = 1
const LEFT = 3
const DOWN = 4
const RIGHT = 5
const ACTIVATE = 2

function row(x: number): number {
    return Math.floor(x / 3)
}

function col(x: number): number {
    return x % 3
}

function move(result: number[], cur: number, next: number, board: number, perm: number[]) {
    var start = cur
    var stop = board == 1 ? 9 : 0

    function up() {
        while (row(cur) > row(next)) {
            if (cur - 3 == stop) break
            result.push(UP)
            cur -= 3
        }
    }
    function left() {
        while (col(cur) > col(next)) {
            if (cur - 1 == stop) break
            result.push(LEFT)
            cur -= 1
        }
    }
    function down() {
        while (row(cur) < row(next)) {
            if (cur + 3 == stop) break
            result.push(DOWN)
            cur += 3
        }
    }
    function right() {
        while (col(cur) < col(next)) {
            if (cur + 1 == stop) break
            result.push(RIGHT)
            cur += 1
        }
    }

    var f = [up, left, down, right]
    for (var i = 0; i < 8; i++) {
        f[perm[i % 4]]()
    }

    result.push(ACTIVATE)
    if (cur != next) throw new Error(`${start} -> ${next}: ${cur}`)
}

function key(a: number[], k: number): number {
    var ans = k
    for (let x of a) {
        ans = ans * 29 + x
    }
    return ans
}

function rec(a: number[], k: number, mem: Map<number, number>): number {
    if (k == 0) return a.length

    const prev = mem[key(a, k)]
    if (prev != null) return prev

    var perm = [0, 1, 2, 3]
    var cur = 2
    var ans = 0
    for (var i = 0; i < a.length; i++) {
        var next = a[i]
        var best = -1
        for (var it = 0; it < 100; it++) {
            var b: number[] = []
            move(b, cur, next, 2, perm)
            var res = rec(b, k - 1, mem)
            if (best == -1 || res < best) best = res
            shuffle(perm)
        }
        ans += best
        cur = next
    }

    mem[key(a, k)] = ans
    return ans
}

function shuffle(p: number[]) {
    for (var i = p.length - 1; i >= 0; i--) {
        const j = Math.floor(Math.random() * (i + 1))
        const t = p[i]
        p[i] = p[j]
        p[j] = t
    }
}

function solve(s: String): number {
    var mem = new Map<number, number>()

    var perm = [0, 1, 2, 3]
    var cur = 11
    var ans = 0
    for (var i = 0; i < s.length; i++) {
        const c = s[i]
        var next = '0' <= c && c <= '9' ? [10,6,7,8,3,4,5,0,1,2][+c] : 11
        var best = -1
        for (var it = 0; it < 100; it++) {
            var a: number[] = []
            move(a, cur, next, 1, perm)
            var res = rec(a, 25, mem)
            if (best == -1 || res < best) best = res
            shuffle(perm)
        }
        ans += best
        cur = next
    }
    return ans
}

function main() {
    const input = require("fs").readFileSync(0)
    const lines = input.toString().trim().split("\n")
    var ans = 0
    for (let line of lines) {
        const solution = solve(line)
        console.log(solution)
        const numeric = line.substring(0, 3) * 1
        ans += numeric * solution
    }
    console.log(ans)
}

main()
