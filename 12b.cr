# crystal 12b.cr

DX = [1, 0, -1, 0]
DY = [0, 1, 0, -1]

a = STDIN.gets_to_end.chomp.split "\n"
n = a.size

ans = 0

cur = 0
b = Array(Array(Int32)).new(n) { Array(Int32).new(n, 0) }

def is_good(b, x, y)
    0 <= x && x < b.size && 0 <= y && y < b.size
end

def is_border(b, cur, x, y, d)
    xx = x + DX[d]
    yy = y + DY[d]
    b[x][y] == cur && (!is_good(b, xx, yy) || b[xx][yy] != cur)
end

(0...n).each do |x0|
    (0...n).each do |y0|
        if b[x0][y0] != 0
            next
        end

        cur += 1
        b[x0][y0] = cur
        q = [{x0, y0}]
        qb = 0
        while qb < q.size
            v = q[qb]
            qb += 1
            x = v[0]
            y = v[1]

            (0...4).each do |d|
                xx = x + DX[d]
                yy = y + DY[d]
                if is_good(a, xx, yy) && a[xx][yy] == a[x][y]
                    if b[xx][yy] == 0
                        b[xx][yy] = cur
                        q.push({xx, yy})
                    end
                end
            end
        end

        p = 0
        (0...4).each do |d|
            (0...n).each do |l|
                x = d == 0 ? 0 : d == 2 ? n - 1 : l
                y = d == 1 ? 0 : d == 3 ? n - 1 : l
                left = (d + 1) % 4
                while is_good(b, x, y)
                    while is_good(b, x, y) && !is_border(b, cur, x, y, left)
                        x += DX[d]
                        y += DY[d]
                    end
                    if !is_good(b, x, y)
                        break
                    end
                    xx = x
                    yy = y
                    while is_good(b, xx, yy) && is_border(b, cur, xx, yy, left)
                        xx += DX[d]
                        yy += DY[d]
                    end
                    p += 1
                    x = xx
                    y = yy
                end
            end
        end

        ans += q.size * p
    end
end

puts ans
