#include "mat_vec_mul.h"

void mat_vec_multiply(MAT mat_in [N][N], VEC vec_in [N], VEC accumulator[N]) {
	//return  VEC vec_out [N]

	MAT dot_prod[N][N];


	// calculating the dot-product of matrix and extended vector

	dot_prod_row: for (int i = 0; i < N; i++) {
		dot_prod_column: for (int j = 0; j < N; j++) {
			dot_prod[i][j] = mat_in[i][j] * vec_in[j];
		}
	}

	// selecting the diagonal elements and add them up to accumulator
	diagonal_vec_loop: for (int i = 0; i < N; i++) {
		element_process_loop: for (int j = 0; j < N; j++) {
			accumulator[j] += dot_prod[j][i + j < N ? i + j : i + j - N];
		}
	}

}
