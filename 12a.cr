# crystal 12a.cr

dx = [1, 0, -1, 0]
dy = [0, 1, 0, -1]

a = STDIN.gets_to_end.chomp.split "\n"
n = a.size
m = a[0].size

ans = 0

b = Array(Array(Bool)).new(n) { Array(Bool).new(m, false) }
(0...n).each do |x0|
    (0...m).each do |y0|
        if b[x0][y0]
            next
        end

        b[x0][y0] = true
        q = [{x0, y0}]
        qb = 0
        p = 0
        while qb < q.size
            v = q[qb]
            qb += 1
            x = v[0]
            y = v[1]

            (0...4).each do |d|
                xx = x + dx[d]
                yy = y + dy[d]
                if 0 <= xx && xx < n && 0 <= yy && yy < m && a[xx][yy] == a[x][y]
                    if !b[xx][yy]
                        b[xx][yy] = true
                        q.push({xx, yy})
                    end
                else
                    p += 1
                end
            end
        end

        ans += q.size * p
    end
end

puts ans
