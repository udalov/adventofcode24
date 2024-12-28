// tsc 21a.ts && node 21a.js

const UP = 1
const LEFT = 3
const DOWN = 4
const RIGHT = 5
const ACTIVATE = 2

function solve(s: String): number {
    const a: number[][][][] = Array.from({ length: 100 }, () =>
        Array.from({ length: 6 }, () =>
            Array.from({ length: 6 }, () =>
                Array.from({ length: 12 }, () => -1)
            )
        )
    )
    a[0][2][2][11] = 0
    for (let t = 0; t < 99; t++) {
        for (let i = 0; i < 6; i++) {
            for (let j = 0; j < 6; j++) {
                for (let k = 0; k < 12; k++) {
                    if (a[t][i][j][k] < 0) continue
                    if (a[t][i][j][k] == s.length) return t
                    for (let me = 0; me < 6; me++) {
                        let ni = i, nj = j, nk = k
                        var bad = false
                        var v = a[t][i][j][k]
                        if (me == UP && ni >= 4) {
                            ni -= 3
                        } else if (me == DOWN && ni < 3) {
                            ni += 3
                        } else if (me == LEFT && ni % 3 != 0 && ni != 4) {
                            ni--
                        } else if (me == RIGHT && ni % 3 != 2) {
                            ni++
                        } else if (me == ACTIVATE) {
                            if (ni == UP && nj >= 4) {
                                nj -= 3
                            } else if (ni == DOWN && nj < 3) {
                                nj += 3
                            } else if (ni == LEFT && nj % 3 != 0 && nj != 4) {
                                nj--
                            } else if (ni == RIGHT && nj % 3 != 2) {
                                nj++
                            } else if (ni == ACTIVATE) {
                                if (nj == UP && nk >= 3) {
                                    nk -= 3
                                } else if (nj == DOWN && nk < 9 && nk != 6) {
                                    nk += 3
                                } else if (nj == LEFT && nk % 3 != 0 && nk != 10) {
                                    nk--
                                } else if (nj == RIGHT && nk % 3 != 2) {
                                    nk++
                                } else if (nj == ACTIVATE) {
                                    if ("789456123.0A"[nk] == s[v]) {
                                        v++
                                    } else {
                                        bad = true
                                    }
                                }
                            }
                        }
                        if (!bad && a[t+1][ni][nj][nk] < v) {
                            a[t+1][ni][nj][nk] = v
                        }
                    }
                }
            }
        }
    }
    return -1
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
