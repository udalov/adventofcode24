// go run 16b.go

package main

import (
	"container/heap"
    "fmt"
)

const N = 141
const TURN = 1000
const MOVE = 1
const INF = 1_000_000_000

var DX = [...]int{1, 0, -1, 0}
var DY = [...]int{0, 1, 0, -1}

type Vertex struct {
	x int
	y int
	dir int
	dist int
	index int
}

type PriorityQueue []*Vertex

func (q PriorityQueue) Len() int { return len(q) }
func (q PriorityQueue) Less(i, j int) bool { return q[i].dist < q[j].dist }

func (q PriorityQueue) Swap(i, j int) {
	q[i], q[j] = q[j], q[i]
	q[i].index = i
	q[j].index = j
}

func (q *PriorityQueue) Push(x any) {
	var n = len(*q)
	var z = x.(*Vertex)
	z.index = n
	*q = append(*q, z)
}

func (q *PriorityQueue) Pop() any {
	var old = *q
	var n = len(old)
	var z = old[n - 1]
	*q = old[0 : n - 1]
	return z
}

func (q *PriorityQueue) update(z *Vertex, newDist int) {
	if z.dist == INF {
		heap.Push(q, z)
	}
	if newDist < z.dist {
		z.dist = newDist
		heap.Fix(q, z.index)
	}
}

func paths(a []string, sx int, sy int, sd int, invert int) [4][N][N]*Vertex {
	var n = len(a)
	var vert = [4][N][N]*Vertex{}
	for d := 0; d < 4; d++ {
		for x := 0; x < n; x++ {
			for y := 0; y < n; y++ {
				vert[d][x][y] = &Vertex{ x: x, y: y, dir: d, dist: INF }
			}
		}
	}

	var q = make(PriorityQueue, 0)
	var start = vert[sd][sx][sy]
	heap.Push(&q, start)
	start.dist = 0

	for q.Len() > 0 {
		var u = heap.Pop(&q).(*Vertex)
		for _, d := range []int{(u.dir + 1) % 4, (u.dir + 3) % 4} {
			q.update(vert[d][u.x][u.y], u.dist + TURN)
		}

		var xx = u.x + DX[(u.dir + invert) % 4]
		var yy = u.y + DY[(u.dir + invert) % 4]
		if a[xx][yy] == '#' { continue }
		q.update(vert[u.dir][xx][yy], u.dist + MOVE)
	}

	return vert
}

func solve(a []string) int {
	var n = len(a)
	var sx = -1
	var sy = -1
	var ex = -1
	var ey = -1
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			if a[i][j] == 'S' {
				sx = i
				sy = j
			} else if a[i][j] == 'E' {
				ex = i
				ey = j
			}
		}
	}

	var p1 = paths(a, sx, sy, 1, 0)
	var best = INF
	for d := 0; d < 4; d++ {
		best = min(best, p1[d][ex][ey].dist)
	}

	var good = [N][N]bool{}
	for ed := 0; ed < 4; ed++ {
		var p2 = paths(a, ex, ey, ed, 2)
		for d := 0; d < 4; d++ {
			for x := 0; x < n; x++ {
				for y := 0; y < n; y++ {
					if p1[d][x][y].dist + p2[d][x][y].dist == best {
						good[x][y] = true
					}
				}
			}
		}
	}

	var ans = 0
	for x := 0; x < n; x++ {
		for y := 0; y < n; y++ {
			if good[x][y] { ans++ }
		}
	}
	return ans
}

func main() {
    var data = []string{}
    for {
		var line string
        var _, err = fmt.Scanln(&line)
        if err != nil { break }
        data = append(data, line)
    }
    fmt.Println(solve(data))
}
