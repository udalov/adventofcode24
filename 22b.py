# python 22b.py

import sys

mod = 16777216

def enc(a, b, c, d, e):
    ab = a - b + 10
    bc = b - c + 10
    cd = c - d + 10
    de = d - e + 10
    return (((((ab << 5) + bc) << 5) + cd) << 5) + de

def solve(n):
    a = [n % 10]
    r = {}
    x = n
    for it in range(0, 2000):
        x = (x ^ (x << 6)) % mod
        x = (x ^ (x >> 5)) % mod
        x = (x ^ (x << 11)) % mod
        a.append(x % 10)
        if len(a) >= 5:
            k = enc(a[-1], a[-2], a[-3], a[-4], a[-5])
            if not k in r.keys():
                r[k] = x % 10
    return r

def main():
    lines = sys.stdin.readlines()
    w = {}
    for line in lines:
        r = solve(int(line))
        for key, value in r.items():
            w[key] = w.get(key, 0) + value
    ans = 0
    for key, value in w.items():
        ans = max(ans, value)
    print(ans)

main()
