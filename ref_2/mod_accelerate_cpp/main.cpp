#include<iostream>
#include<cmath>
#include<cstdlib>
#include<ctime>

using namespace std;
typedef uint64_t NUM;

NUM mod(NUM a, NUM p) {
	return a - NUM(floor(double(a)/p))*p;
}

NUM mod_opt(NUM a, NUM p, NUM m, NUM k) {
	NUM q = a * m >> k;
	NUM r = a - p * q;
	return r;
}

int main() {

	NUM a = 64829742;
	// 65536 = 2^16
	NUM p = 65535;
	NUM k = 32;
	NUM kk = static_cast<NUM>(1) << k;
	NUM m = floor(kk / double(p));

	NUM r_opt;
	NUM r;

	clock_t start1 = clock();

	for (int i = 0; i < 1000000; i++) {
		r = mod(a, p);
	}

	clock_t end1 = clock();
	double TotalTime1 = (double)(end1 - start1) / CLOCKS_PER_SEC;
	cout << "Many times original mod needs " << TotalTime1*1000 << " ms" << endl;

	clock_t start2 = clock();

	for (int i = 0; i < 1000000; i++) {
		r = mod_opt(a, p, m, k);
	}

	clock_t end2 = clock();
	double TotalTime2 = (double)(end2 - start2) / CLOCKS_PER_SEC;
	cout << "Many times optimized mod needs " << TotalTime2*1000 << " ms" << endl;

	return 0;
}