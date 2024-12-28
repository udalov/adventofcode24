// chpl 02b.chpl

use IO;

var ans = 0;
while true {
    var line: string;
    const more = readLine(line);
    if (!more) { break; }
    const s = line.split(" ");
    const n = s.size;
    var good = false;
    var j = 0;
    while j < n {
        var min = 1000;
        var max = -1000;
        var i = 0;
        while i < n - 2 {
            const k1 = if (i < j) then i else i + 1;
            const k2 = if (i + 1 < j) then i + 1 else i + 2;
            const cur = (s[k2]: int) - (s[k1]: int);
            if (cur < min) { min = cur; }
            if (cur > max) { max = cur; }
            i += 1;
        }
        if (1 <= min && max <= 3 || -3 <= min && max <= -1) { good = true; }
        j += 1;
    }
    if (good) { ans += 1; }
}
writeln(ans);
