# julia 04a.jl

dx = [1, 1, 0, -1, -1, -1, 0, 1]
dy = [0, 1, 1, 1, 0, -1, -1, -1]

function main()
    a = []
    while !eof(stdin)
        line = readline()
        push!(a, line)
    end
    n = length(a)
    m = length(a[1])
    ans = 0
    for x0 = 1:n
        for y0 = 1:m
            for d = 1:8
                good = true
                x = x0
                y = y0
                for i = 1:4
                    if !(1 <= x <= n && 1 <= y <= m && a[x][y] == "XMAS"[i])
                        good = false
                        break
                    end
                    x += dx[d]
                    y += dy[d]
                end
                if (good)
                    ans += 1
                end
            end
        end
    end
    println(ans)
end

main()
