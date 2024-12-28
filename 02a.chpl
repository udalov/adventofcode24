// chpl 02a.chpl

use IO;

var ans = 0;
while true {
    var line: string;
    const more = readLine(line);
    if (!more) { break; }
    const s = line.split(" ");
    const n = s.size;
    var min = 1000;
    var max = -1000;
    var i = 0;
    while i < n - 1 {
        const cur = (s[i + 1]: int) - (s[i]: int);
        if (cur < min) { min = cur; }
        if (cur > max) { max = cur; }
        i += 1;
    }
    if (1 <= min && max <= 3 || -3 <= min && max <= -1) { ans += 1; }
}
writeln(ans);
