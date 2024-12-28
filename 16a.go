// go run 16a.go

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

	var vert = [4][N][N]*Vertex{}
	for d := 0; d < 4; d++ {
		for x := 0; x < n; x++ {
			for y := 0; y < n; y++ {
				vert[d][x][y] = &Vertex{ x: x, y: y, dir: d, dist: INF }
			}
		}
	}

	var q = make(PriorityQueue, 0)
	heap.Push(&q, vert[1][sx][sy])
	vert[1][sx][sy].dist = 0

	for q.Len() > 0 {
		var u = heap.Pop(&q).(*Vertex)
		if u.x == ex && u.y == ey {
			return u.dist
		}

		for _, d := range []int{(u.dir + 1) % 4, (u.dir + 3) % 4} {
			q.update(vert[d][u.x][u.y], u.dist + TURN)
		}

		var xx = u.x + DX[u.dir]
		var yy = u.y + DY[u.dir]
		if a[xx][yy] == '#' { continue }
		q.update(vert[u.dir][xx][yy], u.dist + MOVE)
	}

	return -1
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
