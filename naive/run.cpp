#include<bits/stdc++.h>

using namespace std;
#define N 1000
#define offset 500

class p2d {
    int x, y;
    static const int stx[9], sty[9];
    static int U, D, L, R, range_x, range_y;
    static bool grid[N][N], adj[N][N];
    friend ostream &operator<<(ostream &os, const p2d obj) {
        os << obj.x << ' ' << obj.y << endl;
        return os;
    }

    int go_x(int k) {
        int ret = x + stx[k];
        if (ret > R) ret = L;
        if (ret < L) ret = R;
        return ret;
    }

    int go_y(int k) {
        int ret = y + sty[k];
        if (ret > U)ret = D;
        if (ret < D)ret = U;
        return ret;
    }

    void set() {
        grid[x][y]=1;
        for (int k = 0; k < 9; ++k)adj[go_x(k)][go_y(k)] = 1;
    }

    bool check_adjacent() {
        return adj[x][y];
    }

public:
    static void init() {
        p2d O;
        O.x = O.y = offset;
        O.set();
        cout << O;
    }

    static void set_range(int rx, int ry) {
        range_x = rx, range_y = ry;
        L = offset - range_x / 2, R = offset + range_x / 2 - 1;
        D = offset - range_y / 2, U = offset + range_y / 2 - 1;
    }

    void walk() {
        int k = rand() % 8;
        x = go_x(k), y = go_y(k);
    }

    void gen() {
        do {
            x = rand() % range_x + L;
            y = rand() % range_x + D;
        } while (grid[x][y]);
        while (!check_adjacent()) {
            walk();
        }
        set();
    }
};

const int p2d::stx[9] = {-1, -1, -1, 0, 0, 1, 1, 1, 0};
const int p2d::sty[9] = {-1, 0, 1, -1, 1, -1, 0, 1, 0};
int p2d::U, p2d::D, p2d::L, p2d::R, p2d::range_x, p2d::range_y;
bool p2d::grid[N][N], p2d::adj[N][N];

int main() {
    freopen("output.txt", "w", stdout);
    srand(time(0));
    cerr << "stage1" << endl;
    p2d::set_range(200, 200);
    p2d::init();
    p2d tmp;
    for (int i = 1; i <= 1000; ++i) {
        tmp.gen();
        cout << tmp;
    }
    cerr << "stage2" << endl;
    p2d::set_range(400, 400);
    for (int i = 1; i <= 1000; ++i) {
        tmp.gen();
        cout << tmp;
    }
    cerr << "stage3" << endl;
    p2d::set_range(500, 500);
    for (int i = 1; i <= 3000; ++i) {
        tmp.gen();
        cout << tmp;
    }
    cerr << "stage4" << endl;
    p2d::set_range(600, 600);
    for (int i = 1; i <= 3000; ++i) {
        tmp.gen();
        cout << tmp;
    }
    cerr << "stage5" << endl;
    p2d::set_range(700, 700);
    for (int i = 1; i <= 5000; ++i) {
        tmp.gen();
        cout << tmp;
    }
    cerr << "stage6" << endl;
    p2d::set_range(900, 900);
    for (int i = 1; i <= 5000; ++i) {
        tmp.gen();
        cout << tmp;
    }

    return 0;
}