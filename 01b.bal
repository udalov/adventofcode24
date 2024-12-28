// d=$(mktemp -d) && pushd $d >/dev/null && bal new app && popd >/dev/null && cp 01b.bal $d/app/main.bal && bal run $d/app

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
    int ans = 0;
    int i = 0;
    while i < n {
        int count = 0;
        int j = 0;
        while j < n {
            if (a[i] == b[j]) { count += 1; }
            j += 1;
        }
        ans += a[i] * count;
        i += 1;
    }
    io:println(ans);
}
