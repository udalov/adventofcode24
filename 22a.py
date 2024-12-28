# python 22a.py

import sys

mod = 16777216

def solve(n):
    x = n
    for it in range(0, 2000):
        x = (x ^ (x << 6)) % mod
        x = (x ^ (x >> 5)) % mod
        x = (x ^ (x << 11)) % mod
    return x

def main():
    lines = sys.stdin.readlines()
    ans = 0
    for line in lines:
        ans += solve(int(line))
    print(ans)

main()
