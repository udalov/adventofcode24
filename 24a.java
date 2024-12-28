// java 24a.java

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.Map;

class Solution {
    enum Op {
        AND, OR, XOR;
    }

    record Gate(String first, Op op, String second) {}

    static int solve(String v, Map<String, Integer> a, Map<String, Gate> g) {
        var ans = a.get(v);
        if (ans != null) return ans;

        var t = g.get(v);
        var x = solve(t.first, a, g);
        var y = solve(t.second, a, g);
        ans = switch (t.op()) {
            case AND -> x & y;
            case OR -> x | y;
            case XOR -> x ^ y;
        };
        a.put(v, ans);
        return ans;
    }

    public static void main(String[] args) throws Exception {
        var br = new BufferedReader(new InputStreamReader(System.in));
        var a = new HashMap<String, Integer>();
        var g = new HashMap<String, Gate>();
        while (true) {
            var line = br.readLine();
            if (line.isEmpty()) break;
            var vd = line.split(": ");
            a.computeIfAbsent(vd[0], key -> Integer.parseInt(vd[1]));
        }
        while (true) {
            var line = br.readLine();
            if (line == null) break;
            var parts = line.split(" ");
            var op = parts[1].equals("AND") ? Op.AND : parts[1].equals("OR") ? Op.OR : Op.XOR;
            if (g.containsKey(parts[4])) throw new AssertionError(line);
            g.put(parts[4], new Gate(parts[0], op, parts[2]));
        }
        var ans = 0L;
        for (int i = 0; i < 100; i++) {
            var s = String.format("z%02d", i);
            if (!g.containsKey(s)) break;
            ans += ((long) solve(s, a, g)) << i;
        }
        System.out.println(ans);
    }
}
