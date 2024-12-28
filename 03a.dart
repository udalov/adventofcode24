// dart 03a.dart

import 'dart:convert';
import 'dart:io';

void main() {
    var ans = 0;
    while (true) {
        var line = stdin.readLineSync(encoding: utf8);
        if (line == null) break;
        var re = RegExp(r'mul\((\d+),(\d+)\)');
        for (var m in re.allMatches(line)) {
            ans += int.parse(m[1]!) * int.parse(m[2]!);
        }
    }
    print(ans);
}
