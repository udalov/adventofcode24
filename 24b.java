// java 24b.java

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.*;

class Solution {
    enum Op {
        AND, OR, XOR;
    }

    record Gate(String first, Op op, String second) {}

    static Integer solve(String v, Map<String, Integer> a, Map<String, Gate> g, Set<String> used) {
        var ans = a.get(v);
        if (ans != null) return ans;

        if (!used.add(v)) return null;

        var t = g.get(v);
        if (t == null) throw new AssertionError(v);
        var x = solve(t.first, a, g, used);
        if (x == null) return null;
        var y = solve(t.second, a, g, used);
        if (y == null) return null;
        ans = switch (t.op()) {
            case AND -> x & y;
            case OR -> x | y;
            case XOR -> x ^ y;
        };
        a.put(v, ans);
        return ans;
    }

    static void swap(Map<String, Gate> g, String s1, String s2) {
        var t = g.get(s1);
        g.put(s1, g.get(s2));
        g.put(s2, t);
    }

    static boolean good(Map<String, Gate> g, int n) {
        var a = new HashMap<String, Integer>();
        var x = new int[n];
        var y = new int[n];
        var z = new int[n + 1];
        for (int it = 0; it < 20; it++) {
            a.clear();
            var carry = 0;
            for (int i = 0; i < n; i++) {
                x[i] = Math.random() < 0.5 ? 0 : 1;
                y[i] = Math.random() < 0.5 ? 0 : 1;
                a.put(String.format("x%02d", i), x[i]);
                a.put(String.format("y%02d", i), y[i]);
                var v = x[i] + y[i] + carry;
                z[i] = v % 2;
                carry = v / 2;
            }
            z[n] = carry;

            for (int i = 0; i < n; i++) {
                if (solve(String.format("z%02d", i), a, g, new HashSet<>()) == null) return false;
            }
            if (solve(String.format("z%02d", n), a, g, new HashSet<>()) == null) return false;

            for (int i = 0; i <= n; i++) {
                if (a.get(String.format("z%02d", i)) != z[i]) return false;
            }
        }
        return true;
    }

    public static void main(String[] args) throws Exception {
        var br = new BufferedReader(new InputStreamReader(System.in));
        var g = new HashMap<String, Gate>();
        var n = 0;
        while (true) {
            var line = br.readLine();
            if (line.isEmpty()) break;
            if (line.charAt(0) == 'x') {
                n = Math.max(n, Integer.parseInt(line.substring(1, 3)) + 1);
            }
        }
        while (true) {
            var line = br.readLine();
            if (line == null) break;
            var parts = line.split(" ");
            var op = parts[1].equals("AND") ? Op.AND : parts[1].equals("OR") ? Op.OR : Op.XOR;
            if (g.containsKey(parts[4])) throw new AssertionError(line);
            g.put(parts[4], new Gate(parts[0], op, parts[2]));
        }

        var ans = new ArrayList<String>();
        // Found by looking manually at the input
        ans.addAll(Arrays.asList("z17", "cmv", "z23", "rmj", "z30", "rdg"));
        for (int i = 0; i < ans.size(); i += 2) {
            swap(g, ans.get(i), ans.get(i + 1));
        }

        var all = new ArrayList<>(g.keySet());
        outer: for (var first : all) {
            for (var second : all) {
                swap(g, first, second);
                if (good(g, n)) {
                    ans.add(first);
                    ans.add(second);
                    break outer;
                }
                swap(g, first, second);
            }
        }
        Collections.sort(ans);
        System.out.println(String.join(",", ans));
    }
}
