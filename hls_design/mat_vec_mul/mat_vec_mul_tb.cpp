#include <iostream>
#include "mat_vec_mul.h"
using namespace std;

int main(int argc, char **argv)
{
    int errcnt = 0;
    MAT mat_in[4][4] = {
        {1,2,3,4},
        {5,6,7,8},
        {9,10,11,12},
        {13,14,15,16}
    };
    VEC vec_in[4] = {
        1,2,3,4
    };

    VEC vec_out[4] = {
        0,0,0,0
    };

    VEC vec_out_ref[4] = {
        30,70,110,150
    };

    mat_vec_multiply(mat_in, vec_in, vec_out);

    for (int i = 0; i < N; i++) {
        if (vec_out[i] == vec_out_ref[i]) {
            cout << "Element " << i << " is right!";
        }
        else {
            errcnt++;
        }
    }

    if (errcnt > 0) {
        return 1;
    }
    else {
        return 0;
    }

}

