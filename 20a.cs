// d=$(mktemp -d) && pushd $d >/dev/null && dotnet new console >/dev/null && popd >/dev/null && cp 20a.cs $d/Program.cs && dotnet run --project $d

class Program {
    static int N = 141;
    static int LIMIT = 100;
    static int INF = 1_000_000_000;
    static int[] DX = {1, 0, -1, 0};
    static int[] DY = {0, 1, 0, -1};

    static int[][] Run(bool[][] a, int n, int sx, int sy) {
        int[][] d = new int[n][];
        for (int x = 0; x < n; x++) {
            d[x] = Enumerable.Repeat(INF, n).ToArray();
        }
        d[sx][sy] = 0;

        int[] qx = new int[N * N];
        int[] qy = new int[N * N];
        var qb = 0;
        var qe = 0;
        qx[qe] = sx;
        qy[qe] = sy;
        qe++;
        while (qb < qe) {
            var x = qx[qb];
            var y = qy[qb];
            qb++;
            for (int dir = 0; dir < 4; dir++) {
                var xx = x + DX[dir];
                var yy = y + DY[dir];
                if (0 <= xx && xx < n && 0 <= yy && yy < n && d[xx][yy] == INF && !a[xx][yy]) {
                    d[xx][yy] = d[x][y] + 1;
                    qx[qe] = xx;
                    qy[qe] = yy;
                    qe++;
                }
            }
        }
        return d;
    }

    static int Solve(bool[][] a, int n, int sx, int sy, int ex, int ey) {
        var ds = Run(a, n, sx, sy);
        var dist = ds[ex][ey];
        var de = Run(a, n, ex, ey);
        var ans = 0;
        for (int x = 0; x < n; x++) {
            for (int y = 0; y < n; y++) {
                if (ds[x][y] == INF) continue;
                for (int xx = x - 2; xx <= x + 2; xx++) {
                    for (int yy = y - 2; yy <= y + 2; yy++) {
                        if (xx == x && yy == y) continue;
                        if (!(0 <= xx && xx < n && 0 <= yy && yy < n)) continue;
                        if (Math.Abs(x - xx) + Math.Abs(y - yy) != 2) continue;
                        var cur = ds[x][y] + 2 + de[xx][yy];
                        var win = dist - cur;
                        if (win >= LIMIT) ans++;
                    }
                }
            }
        }
        return ans;
    }

    static void Main() {
        var a = new bool[N][];
        var n = 0;
        var sx = -1;
        var sy = -1;
        var ex = -1;
        var ey = -1;
        while (true) {
            var line = Console.In.ReadLine();
            if (line == null) break;
            var m = line.Length;
            a[n] = new bool[m];
            for (var y = 0; y < m; y++) {
                a[n][y] = line[y] == '#';
                if (line[y] == 'S') {
                    sx = n;
                    sy = y;
                } else if (line[y] == 'E') {
                    ex = n;
                    ey = y;
                }
            }
            n++;
        }
        Console.WriteLine(Solve(a, n, sx, sy, ex, ey));
    }
}
