// dart 03b.dart

import 'dart:convert';
import 'dart:io';

void main() {
    var ans = 0;
    var enabled = true;
    while (true) {
        var line = stdin.readLineSync(encoding: utf8);
        if (line == null) break;
        var re = RegExp(r"mul\((\d+),(\d+)\)|do(n't)?\(\)");
        for (var m in re.allMatches(line)) {
            if (m[3] != null) {
                enabled = false;
            } else if (m[0]![0] == 'd') {
                enabled = true;
            } else if (enabled) {
                ans += int.parse(m[1]!) * int.parse(m[2]!);
            }
        }
    }
    print(ans);
}
