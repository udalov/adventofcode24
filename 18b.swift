// swift 18b.swift

import Foundation

let N = 71
let INF = 1_000_000_000
let DX = [1, 0, -1, 0]
let DY = [0, 1, 0, -1]

func main() {
    var board = Array(repeating: Array(repeating: false, count: N), count: N)
    var a = Array(repeating: Array(repeating: INF, count: N), count: N)
    while (true) {
        var ans: String? = nil
        if let line = readLine() {
            let xy = line.components(separatedBy: ",")
            let x = Int(xy[0])!
            let y = Int(xy[1])!
            board[x][y] = true
            ans = line
        } else {
            break
        }

        for x in 0..<N {
            for y in 0..<N {
                if board[x][y] {
                    a[x][y] = -1
                } else {
                    a[x][y] = INF
                }
            }
        }

        var qx = [0]
        var qy = [0]
        var qb = 0
        a[0][0] = 0
        while qb < qx.count {
            let x = qx[qb]
            let y = qy[qb]
            qb += 1
            for d in 0..<4 {
                let xx = x + DX[d]
                let yy = y + DY[d]
                if 0 <= xx && xx < N && 0 <= yy && yy < N && a[xx][yy] == INF {
                    a[xx][yy] = a[x][y] + 1
                    qx.append(xx)
                    qy.append(yy)
                }
            }
        }

        if a[N - 1][N - 1] == INF {
            print(ans!)
            break
        }
    }
}

main()
