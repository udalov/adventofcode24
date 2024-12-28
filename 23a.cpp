// c++ -std=c++23 -O2 23a.cpp

#include <iostream>
#include <sstream>
#include <unordered_map>
#include <unordered_set>

using namespace std;

int main() {
    unordered_map<string, unordered_set<string>> a;
    string line;
    while (cin >> line) {
        istringstream ss(line);
        string u, v;
        getline(ss, u, '-');
        getline(ss, v);
        a[u].insert(v);
        a[v].insert(u);
    }

    int ans = 0;
    for (auto& [x, v] : a) {
        for (auto& y : v) {
            for (auto& [z, _] : a) {
                if (z != x && z != y && a[x].find(z) != a[x].end() && a[y].find(z) != a[y].end() &&
                    (x[0] == 't' || y[0] == 't' || z[0] == 't')) {
                    ans++;
                }
            }
        }
    }
    cout << ans / 6 << endl;

    return 0;
}
