# julia 04b.jl

dx = [1, -1, -1, 1]
dy = [1, 1, -1, -1]

function main()
    a = []
    while !eof(stdin)
        line = readline()
        push!(a, line)
    end
    n = length(a)
    m = length(a[1])
    ans = 0
    for x = 2:n - 1
        for y = 2:m - 1
            if a[x][y] != 'A' continue end
            c = []
            for d = 1:4
                push!(c, a[x + dx[d]][y + dy[d]])
            end
            c = join(c)
            if (c == "MMSS" || c == "SSMM" || c == "SMMS" || c == "MSSM") ans += 1 end
        end
    end
    println(ans)
end

main()
