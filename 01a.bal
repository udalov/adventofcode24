// d=$(mktemp -d) && pushd $d >/dev/null && bal new app && popd >/dev/null && cp 01a.bal $d/app/main.bal && bal run $d/app

import ballerina/io;
import ballerina/regex;

public function main() {
    int[] a = [];
    int[] b = [];
    int n = 0;
    while n < 1000 {
        string line = io:readln();
        string[] ab = regex:split(line, " +");
        int|error aa = int:fromString(ab[0]);
        int|error bb = int:fromString(ab[1]);
        if (aa is error || bb is error) { continue; }
        a.push(aa);
        b.push(bb);
        n += 1;
    }
    int[] ac = a.sort();
    int[] bc = b.sort();
    int ans = 0;
    int i = 0;
    while i < n {
        ans += (ac[i] - bc[i]).abs();
        i += 1;
    }
    io:println(ans);
}
