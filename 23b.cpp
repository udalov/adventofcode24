// c++ -std=c++23 -O2 23b.cpp

#include <algorithm>
#include <iostream>
#include <iterator>
#include <set>
#include <sstream>
#include <unordered_map>

using namespace std;

typedef set<string> uss;
typedef unordered_map<string, uss> graph;

uss ans;

uss intersect(graph& a, uss& s, const string& v) {
    uss r;
    set_intersection(s.begin(), s.end(), a[v].begin(), a[v].end(), inserter(r, r.end()));
    return r;
}

void rec(graph& a, uss& r, uss& p, uss& x) {
    if (p.empty() && x.empty()) {
        if (r.size() > ans.size()) ans = r;
        return;
    }
    uss rr(r), pp(p), xx(x);
    for (auto& v : p) {
        rr.insert(v);
        uss p2 = intersect(a, pp, v);
        uss x2 = intersect(a, xx, v);
        rec(a, rr, p2, x2);
        rr.erase(v);
        pp.erase(v);
        xx.insert(v);
    }
}

int main() {
    graph a;
    string line;
    while (cin >> line) {
        istringstream ss(line);
        string u, v;
        getline(ss, u, '-');
        getline(ss, v);
        a[u].insert(v);
        a[v].insert(u);
    }

    uss r, p, x;
    for (auto& [v, _] : a) {
        p.insert(v);
    }
    rec(a, r, p, x);

    auto first = true;
    for (auto& x : ans) {
        if (first) {
            first = false;
        } else {
            cout << ",";
        }
        cout << x;
    }
    cout << endl;
    return 0;
}
