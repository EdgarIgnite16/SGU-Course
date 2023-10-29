#include <bits/stdc++.h>

using namespace std;

#define MAX 50
// bat dau tu dinh 0 la dinh 1
#define START 0

/*
 * a: do thi input
 * c: luu duong di
 * d: kiem tra da tham chưa
 * e: luu duong di tot nhat de in ra
 * */
int a[MAX][MAX], c[MAX], d[MAX], e[MAX], n, cost = 0, best_cost = 1e9;

void read_file() {
  ifstream fin;
  // duong dan file
  fin.open("./Testcase/tsp_20vertex.txt");

  fin >> n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      fin >> a[i][j];
    }
    d[i] = 0;
  }
  c[0] = START;
  d[START] = 1;
}

void update() {
  if (cost + a[c[n - 1]][START] < best_cost) {
    best_cost = cost + a[c[n - 1]][START];
    for (int i = 0; i < n; i++) {
      e[i] = c[i];
    }
  }
}

void tsp(int idx) {
  if (cost > best_cost)
    return;

  for (int i = 0; i < n; i++) {
    if (d[i] == 0 && a[c[idx - 1]][i] > 0) {
      c[idx] = i;
      d[i] = 1;

      cost += a[c[idx - 1]][i];

      if (idx == n - 1) {
        update();
      } else {
        tsp(idx + 1);
      }

      d[i] = 0;
      cost -= a[c[idx - 1]][i];
    }
  }
}

int main() {
    read_file();

    clock_t start, end;
    double time_use;
    start = clock();

    tsp(1);
    cout << "Cost: " << best_cost << endl;

    end = clock();
    time_use = (double)(end - start) / CLOCKS_PER_SEC;
    cout<<"Time running: "<<time_use<<"s";

    return 0;
}
