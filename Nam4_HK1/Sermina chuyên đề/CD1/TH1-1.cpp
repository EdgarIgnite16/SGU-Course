#include <bits/stdc++.h>
using namespace std;

#define INF 1e9
#define ll long long

ll n;
ll dist[25][25];
ll dp[25][1 << 20];

void read_file() {
  ifstream fin;
  fin.open("./testcase/tsp_25vertex.txt");

  fin >> n;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      fin >> dist[i][j];
    }
  }
}

ll tsp(int i, int mask) {
  if (mask == (1 << n) - 1)
    return dist[i][0]; // return trip to starting city
  if (dp[i][mask] != -1)
    return dp[i][mask];

  ll ans = INF;
  for (int j = 0; j < n; j++) {
    if (i != j && !(mask & (1 << j))) {
      ans = min(ans, dist[i][j] + tsp(j, mask | (1 << j)));
    }
  }
  return dp[i][mask] = ans;
}

int main() {
    read_file();
    memset(dp, -1, sizeof dp);

    clock_t start, end;
    double time_use;
    start = clock();

    cout << "Minimum Traveling Salesman Problem cost is " << tsp(0, 1) << "\n";

    end = clock();
    time_use = (double)(end - start) / CLOCKS_PER_SEC;
    cout<<"Time running: "<<time_use<<"s";
    
  return 0;
}
