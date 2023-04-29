/*
	Author: 66
	Date: 04/17/2023
*/
#include "examples.h"
#include<iostream>
#include<cstdlib>
#include<ctime>
using namespace std;
using namespace seal;

const int vec_len = 64;
const size_t poly_modulus_degree = 8192;
int poly_modulus_degree_power = log2(poly_modulus_degree);



void bfv_toy_example() {

	// ���ɷ����������
	EncryptionParameters parms(scheme_type::bfv);


	//------------------���ò���----------------------//

	// poly_modulus_degree ��ʾ����ʽ����ģ
	size_t poly_modulus_degree = 4096;
	parms.set_poly_modulus_degree(poly_modulus_degree);

	// coeff_modulus ��ʾϵ����ģ ����4096��Ӧ109
	// CoeffModulus::MaxBitCount(poly_modulus_degree) ��ȡ���� poly_modulus_degree �µĶ���ʽ��ϵģ������� bit ����
	// SEAL �еĸ������� CoeffModulus::BFVDefault(poly_modulus_degree) ���ظ��� poly_modulus_degree �µĶ���ʽϵ��ģ
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));

	// plain_modulus ���Ŀռ��ģ
	parms.set_plain_modulus(1024);

	// �������ĺ�����
	SEALContext context(parms);
	print_line(__LINE__); // ��ӡ���д�����к�
	cout << "Parameter validation (success): " << context.parameter_error_message() << endl; // ��� valid ��ʾ������Ч


	//------------------���ɹ�Կ��˽Կ----------------------//

	KeyGenerator keygen(context); //����һ������ �������� PublicKey �� SecretKey
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);


	//------------------���ܺͽ���----------------------//
	Encryptor encryptor(context, public_key);		// ��ʼ�� Encryptor ����
	Evaluator evaluator(context);					// ��ʼ�� Evaluator ����
	Decryptor decryptor(context, secret_key);		// ��ʼ�� Decryptor ����

	uint64_t x = 6;
	Plaintext x_plain(uint64_to_hex_string(x));		// ���� Plaintext ����uint64_to_hex_string���һ��ֵ��Ϊһ��ʮ�����ƴ���ʽ���磺17 --> "11"
	cout << "Express x = " + to_string(x) + " as a plaintext polynomial 0x" + x_plain.to_string() + "." << endl;

	Ciphertext x_encrypted;  						// ���� x=6 ��Ӧ�����Ķ���
	encryptor.encrypt(x_plain, x_encrypted);		// ʹ�� Encryptor ������м��ܣ������浽һ�� Ciphertext ������

	cout << "    + size of freshly encrypted x: " << x_encrypted.size() << endl;  //��������ĵĶ���ʽ����
	cout << "    + noise budget in freshly encrypted x: " << decryptor.invariant_noise_budget(x_encrypted) << " bits" << endl;	//��������Ļ�ʣ�µ�����Ԥ�㣨bit��ʾ��

	Plaintext x_decrypted;							//������ܺ�Ľ��
	decryptor.decrypt(x_encrypted, x_decrypted);	//ʹ�� Decryptor ������ܣ����ѽ�����浽 x_decrypted ������
	cout << "    + decryption of x_encrypted: " << "0x" << x_decrypted.to_string() << endl;	//�������������Ƿ�Ϊ 6

}

void ckks() {
	//������ܲ���
	EncryptionParameters encryptionParameters(scheme_type::ckks);
	size_t poly_modulus_degree = 8192;
	encryptionParameters.set_poly_modulus_degree(poly_modulus_degree);
	encryptionParameters.set_coeff_modulus(CoeffModulus::Create(
		poly_modulus_degree, { 60,40,40,60 }));
	double scale = pow(2.0, 40);

	//�������������ģ�����ʼ�����ʵ��
	SEALContext context(encryptionParameters);
	KeyGenerator keyGenerator(context);

	SecretKey secret_key = keyGenerator.secret_key();
	PublicKey public_key;
	keyGenerator.create_public_key(public_key);

	GaloisKeys galois_keys;
	keyGenerator.create_galois_keys(galois_keys);

	RelinKeys relin_keys;
	keyGenerator.create_relin_keys(relin_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	CKKSEncoder encoder(context);
	vector<double> test(1);
	test.push_back(1.0);

	//����/���ܲ��������ڱ����������Ͻ���
	Plaintext test_plain;
	Ciphertext test_cipher;
	encoder.encode(test, scale, test_plain);
	encryptor.encrypt(test_plain, test_cipher);
	Plaintext plain_coeff1;
	encoder.encode(3.0, scale, plain_coeff1);

	evaluator.multiply_plain_inplace(test_cipher, plain_coeff1);
	evaluator.relinearize_inplace(test_cipher, relin_keys);
	evaluator.rescale_to_next_inplace(test_cipher);

	Plaintext plain_test_result;
	decryptor.decrypt(test_cipher, plain_test_result);
	vector<double> test_result;
	encoder.decode(plain_test_result, test_result);
	print_vector(test_result, 4, 7);

}

inline void rotate_sum(Evaluator& evaluator, Ciphertext& ciphertext, const GaloisKeys& keys, const int poly_modulus_degree_power) {
	Ciphertext rotated;
	for (int i = 0; i < poly_modulus_degree_power - 1; ++i) {
		evaluator.rotate_vector(ciphertext, pow(2, i), keys, rotated);
		evaluator.add_inplace(ciphertext, rotated);
	}
}



void multiply_cipherVEC_cipherVEC() {

	EncryptionParameters parms(scheme_type::bfv);

	
	parms.set_poly_modulus_degree(poly_modulus_degree);
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
	parms.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));

	SEALContext context(parms);
	// print_parameters(context);
	// cout << endl;

	KeyGenerator keygen(context);
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	RelinKeys relin_keys;
	keygen.create_relin_keys(relin_keys);
	GaloisKeys galois_keys;
	keygen.create_galois_keys(galois_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	BatchEncoder batch_encoder(context);
	size_t slot_count = batch_encoder.slot_count();
	size_t row_size = slot_count / 2;

	// cout << "Plaintext matrix row size: " << row_size << endl;
	cout << "Calculating the inner product of size-"<< vec_len <<" vector..." << endl<< endl;

	vector<uint64_t> vec1((poly_modulus_degree));
	vector<uint64_t> vec2((poly_modulus_degree));

	for (int i = 0; i < vec_len; i++)
	{
		vec1[i] = i;
	}

	for (int i = 0; i < vec_len; i++)
	{
		vec2[i] = i + 10;
	}

	cout << "vec1 = ";
	print_vector(vec1,8);
	cout << endl;
	cout << "vec2 = ";
	print_vector(vec2, 8);
	cout << endl;

	Plaintext vec1_plain;
	batch_encoder.encode(vec1, vec1_plain);
	Plaintext vec2_plain;
	batch_encoder.encode(vec2, vec2_plain);

	Ciphertext vec1_cipher;
	encryptor.encrypt(vec1_plain, vec1_cipher);
	cout << "    + noise budget of vec1: "
		<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl;

	Ciphertext vec2_cipher;
	encryptor.encrypt(vec2_plain, vec2_cipher);
	cout << "    + noise budget of vec2: "
		<< decryptor.invariant_noise_budget(vec2_cipher) << " bits" << endl;

	evaluator.multiply_inplace(vec1_cipher, vec2_cipher);
	cout << "    + noise budget of the dot-product result: "
		<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl;


	// �˷�����֮����Ҫ���½��ܺ��ټ��ܣ�����rotate_rows�޷����У���֪ԭ��
	Plaintext result_plain;
	decryptor.decrypt(vec1_cipher, result_plain);
	vector<int64_t> result(vec_len);
	batch_encoder.decode(result_plain, result);
	cout << endl << "dot-product<vec1, vec2> = ";
	print_vector(result, 8);
	cout << endl;
	batch_encoder.encode(result, result_plain);
	encryptor.encrypt(result_plain, vec1_cipher);
	cout << "    + noise budget refresh: "
		<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl << endl;


	Ciphertext rotated;

	for (int i = 0; i < poly_modulus_degree_power - 1; ++i) {
		cout << "Iteration " << i+1 << "..." << endl << endl;
		evaluator.rotate_rows(vec1_cipher, pow(2, i), galois_keys, rotated); // rotation

		cout << "    + noise budget after " << i+1 << " rotation: "
			<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl << endl;
		decryptor.decrypt(vec1_cipher, result_plain);
		batch_encoder.decode(result_plain, result);
		cout << "    + result from last iteration:";
		print_vector(result, 8);


		decryptor.decrypt(rotated, result_plain);
		batch_encoder.decode(result_plain, result);
		cout << "    + vector after rotatation:";
		print_vector(result, 8);


		evaluator.add_inplace(vec1_cipher, rotated); // sum
		cout << "    + noise budget after " << i+1 << " rotation: "
			<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl << endl;
	}
	cout << "    + noise budget after rotation-sum operation: "
		<< decryptor.invariant_noise_budget(vec1_cipher) << " bits" << endl << endl;

	decryptor.decrypt(vec1_cipher, result_plain);
	batch_encoder.decode(result_plain, result);
	cout << endl << endl<< "vec1 * vec2 = ";
	print_vector(result, 8);
	cout << endl;

}
void multiply_mat_vec_fail() {

	EncryptionParameters parms(scheme_type::bfv);


	parms.set_poly_modulus_degree(poly_modulus_degree);
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
	parms.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));

	SEALContext context(parms);
	// print_parameters(context);
	// cout << endl;

	KeyGenerator keygen(context);
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	RelinKeys relin_keys;
	keygen.create_relin_keys(relin_keys);
	GaloisKeys galois_keys;
	keygen.create_galois_keys(galois_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	BatchEncoder batch_encoder(context);
	size_t slot_count = batch_encoder.slot_count();
	size_t row_size = 16;
	size_t column_size = 16;

	vector<uint64_t> mat(poly_modulus_degree);
	for (int i = 0; i < column_size; i++) {
		for (int j = 0; j < row_size; j++) {	
			print_line(__LINE__);
			mat[i * column_size + j] = i * column_size + j;
		}
	}
	print_matrix(mat, row_size);

	size_t vec_len = 16;
	vector<uint64_t> vec(poly_modulus_degree);
	for (int i = 0; i < vec_len; i++)
	{
		vec[i] = i;
	}
	print_vector(vec, 8);

	Plaintext mat_plain;
	Plaintext vec_plain;


	Ciphertext mat_cipher;
	Ciphertext vec_cipher;


	batch_encoder.encode(mat, mat_plain);
	batch_encoder.encode(vec, vec_plain);


	encryptor.encrypt(mat_plain, mat_cipher);
	encryptor.encrypt(vec_plain, vec_cipher);

	vector<uint64_t> vec_temp(poly_modulus_degree);
	Plaintext vec_temp_plain;
	Ciphertext vec_temp_cipher; // store each row of matrix in each loop
	
	vector<uint64_t> vec_sub_result(poly_modulus_degree);
	Plaintext vec_sub_result_plain;
	Ciphertext vec_sub_result_cipher; // store the sub result of the mulpilication

	vector<uint64_t> vec_final_result(poly_modulus_degree);
	Plaintext vec_final_result_plain;
	Ciphertext vec_final_result_cipher; //store the final result of the mat-vec product

	vector<uint64_t> rotated(poly_modulus_degree);
	Plaintext rotated_plain;
	Ciphertext rotated_cipher; // store the semi-result of the rotate-sum process

	// Begin nultiplication
	for (int i = 0; i < column_size; i++) {
		
		// put the used row in the temp vec
		for (int j = 0; j < row_size; j++) {
			vec_temp[j] = i * column_size + j;
		}


		// calculate the dot-prod stored in the temp vec
		evaluator.multiply(vec_temp_cipher, vec_cipher, vec_sub_result_cipher);

		// decrypt and encrypt
		decryptor.decrypt(vec_sub_result_cipher, vec_sub_result_plain);
		batch_encoder.decode(vec_sub_result_plain, vec_sub_result);
		cout << endl << "dot-product<vec_tepm, vec> = ";
		print_vector(vec_sub_result, 8);
		cout << endl;
		batch_encoder.encode(vec_sub_result, vec_sub_result_plain);
		encryptor.encrypt(vec_sub_result_plain, vec_sub_result_cipher);

		// calculate the rotate-sum of "vec_sub_result_cipher"
		for (int i = 0; i < poly_modulus_degree_power - 1; ++i) {
			cout << "Iteration " << i + 1 << "..." << endl << endl;
			evaluator.rotate_rows(vec_sub_result_cipher, pow(2, i), galois_keys, rotated_cipher); // rotation

			cout << "    + noise budget after " << i + 1 << " rotation: "
				<< decryptor.invariant_noise_budget(vec_sub_result_cipher) << " bits" << endl << endl;
			decryptor.decrypt(vec_sub_result_cipher, vec_sub_result_plain);
			batch_encoder.decode(vec_sub_result_plain, vec_sub_result);
			cout << "    + result from last iteration:";
			print_vector(vec_sub_result, 8);


			decryptor.decrypt(rotated_cipher, rotated_plain);
			batch_encoder.decode(rotated_plain, rotated);
			cout << "    + vector after rotatation:";
			print_vector(rotated, 8);


			evaluator.add_inplace(vec_sub_result_cipher, rotated_cipher); // sum
			cout << "    + noise budget after " << i + 1 << " rotation: "
				<< decryptor.invariant_noise_budget(vec_sub_result_cipher) << " bits" << endl << endl;
		}

		vec_final_result_cipher[i] = vec_sub_result_cipher[0];
	
	}

	decryptor.decrypt(vec_final_result_cipher, vec_final_result_plain);
	batch_encoder.decode(vec_final_result_plain, vec_final_result);
	cout << "    + final result:";
	print_vector(vec_final_result, 8);


}



void multiply_mat_vec() {

	EncryptionParameters parms(scheme_type::bfv);


	parms.set_poly_modulus_degree(poly_modulus_degree);
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
	parms.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));

	SEALContext context(parms);
	// print_parameters(context);
	// cout << endl;

	KeyGenerator keygen(context);
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	RelinKeys relin_keys;
	keygen.create_relin_keys(relin_keys);
	GaloisKeys galois_keys;
	keygen.create_galois_keys(galois_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	BatchEncoder batch_encoder(context);
	size_t slot_count = batch_encoder.slot_count();
	size_t row_size = 16;
	size_t column_size = 16;

	vector<uint64_t> mat(poly_modulus_degree);
	for (int i = 0; i < column_size; i++) {
		for (int j = 0; j < row_size; j++) {
			mat[i * column_size + j] = i * column_size + j+1;
		}
	}
	cout << "the first row and the second row of the matrix:";
	print_matrix(mat, row_size);

	vector<uint64_t> vec(poly_modulus_degree);
	for (int i = 0; i < column_size; i++) {
		for (int j = 0; j < row_size; j++) {
			vec[i * column_size + j] = j+1;
		}
	}
	cout << "the vector:";
	print_vector(vec, 16);
	cout << "-------------------------------------------------------------------------------------------------------------------" << endl;

	Plaintext mat_plain;
	Plaintext vec_plain;

	Ciphertext mat_cipher;
	Ciphertext vec_cipher;

	batch_encoder.encode(mat, mat_plain);
	batch_encoder.encode(vec, vec_plain);

	encryptor.encrypt(mat_plain, mat_cipher);
	encryptor.encrypt(vec_plain, vec_cipher);

	vector<uint64_t> temp(poly_modulus_degree);
	Plaintext temp_plain;
	Ciphertext temp_cipher; // store each row of matrix in each loop

	vector<uint64_t> zeros(poly_modulus_degree);
	vector<uint64_t> sub_result(poly_modulus_degree);
	Plaintext sub_result_plain;
	Ciphertext sub_result_cipher; // store the sub result of the mulpilication

	vector<uint64_t> final_result(poly_modulus_degree);
	Plaintext final_result_plain;
	Ciphertext final_result_cipher; //store the final result of the mat-vec product

	vector<uint64_t> rotated(poly_modulus_degree);
	Plaintext rotated_plain;
	Ciphertext rotated_cipher; // store the semi-result of the rotate-sum process

	// Begin multiplication
	clock_t start1 = clock();
	evaluator.multiply(vec_cipher, mat_cipher, temp_cipher);

	// decrypt and encrypt
	decryptor.decrypt(temp_cipher, temp_plain);
	batch_encoder.decode(temp_plain, temp);
	cout << "dot-product<vec, mat> = ";
	print_matrix(temp, row_size);
	cout << "-------------------------------------------------------------------------------------------------------------------" << endl;

	for (int ii = 0; ii < column_size; ii++) {

		cout << "------------------------- Do rotate-sum for row " << ii << " --------------------------------------------------"<<endl;

		// ���в��ÿһ��: �� temp ����ÿһ�и� sub_result
		sub_result = zeros;
		for (int j = 0; j < row_size; j++) {
			sub_result[j] = temp[ii * column_size + j];
		}

		// �� sub_result ���� ���������� rotate-sum
		batch_encoder.encode(sub_result, sub_result_plain);
		encryptor.encrypt(sub_result_plain, sub_result_cipher);

		// ���� rotate-sum
		for (int i = 0; i < poly_modulus_degree_power - 1; ++i) {
			cout << "Rotate-sum: iteration " << i + 1 << "..." << endl << endl;
			evaluator.rotate_rows(sub_result_cipher, pow(2, i), galois_keys, rotated_cipher); // rotation

			// print some semi-info
			cout << "    + noise budget after " << i + 1 << " rotation: "
				<< decryptor.invariant_noise_budget(sub_result_cipher) << " bits" << endl << endl;
			decryptor.decrypt(sub_result_cipher, sub_result_plain);
			batch_encoder.decode(sub_result_plain, sub_result);
			cout << "    + result from last iteration:";
			print_matrix(sub_result, row_size);

			decryptor.decrypt(rotated_cipher, rotated_plain);
			batch_encoder.decode(rotated_plain, rotated);
			cout << "    + vector after rotatation:";
			print_matrix(rotated, row_size);
			cout << "    + adding them up ..." << endl;

			evaluator.add_inplace(sub_result_cipher, rotated_cipher); // sum
			cout << "    + noise budget after " << i + 1 << " rotation: "
				<< decryptor.invariant_noise_budget(sub_result_cipher) << " bits" << endl << endl;
		}
		// print the sub_result after rotate-sum
		decryptor.decrypt(sub_result_cipher, sub_result_plain);
		batch_encoder.decode(sub_result_plain, sub_result);
		cout << "    + result after rotation-sum operation:";
		print_matrix(sub_result, row_size);

		// ��ʱ sub_result ����Ԫ����ͬ��ÿ�����ǡ�ÿ�еġ���ȷ������Ž� final_result ��
		final_result[ii] = sub_result[0];

	}
	clock_t end1 = clock();
	double TotalTime1 = (double)(end1 - start1) / CLOCKS_PER_SEC;
	cout << "-------------------------------------------------------------------------------------------------------------------" << endl;
	cout << "The final result: ";
	print_matrix(final_result, row_size);
	cout << "Total time: " << TotalTime1 * 1000 << " ms" << endl;
}

void multiply_mat_vec_opt() {

	EncryptionParameters parms(scheme_type::bfv);

	parms.set_poly_modulus_degree(poly_modulus_degree);
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
	parms.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));

	SEALContext context(parms);
	// print_parameters(context);
	// cout << endl;

	KeyGenerator keygen(context);
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	RelinKeys relin_keys;
	keygen.create_relin_keys(relin_keys);
	GaloisKeys galois_keys;
	keygen.create_galois_keys(galois_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	BatchEncoder batch_encoder(context);
	size_t slot_count = batch_encoder.slot_count();
	size_t row_size = 16;
	size_t column_size = 16;

	vector<uint64_t> mat(poly_modulus_degree);
	for (int i = 0; i < column_size; i++) {
		for (int j = 0; j < row_size; j++) {
			mat[i * column_size + j] = i * column_size + j + 1;
		}
	}
	cout << "the first row and the second row of the matrix:";
	print_matrix(mat, row_size);

	vector<uint64_t> vec(poly_modulus_degree);
	for (int i = 0; i < column_size; i++) {
		for (int j = 0; j < row_size; j++) {
			vec[i * column_size + j] = j + 1;
		}
	}
	cout << "the vector:";
	print_vector(vec, 16);
	cout << "-------------------------------------------------------------------------------------------------------------------" << endl;

	Plaintext mat_plain;
	Plaintext vec_plain;

	Ciphertext mat_cipher;
	Ciphertext vec_cipher;

	batch_encoder.encode(mat, mat_plain);
	batch_encoder.encode(vec, vec_plain);

	encryptor.encrypt(mat_plain, mat_cipher);
	encryptor.encrypt(vec_plain, vec_cipher);

	vector<uint64_t> temp(poly_modulus_degree);
	Plaintext temp_plain;
	Ciphertext temp_cipher; // store each row of matrix in each loop

	vector<uint64_t> zeros(poly_modulus_degree);
	vector<uint64_t> sub_result1(poly_modulus_degree);
	Plaintext sub_result_plain1;
	Ciphertext sub_result_cipher1; // store the sub result of the mulpilication
	vector<uint64_t> sub_result2(poly_modulus_degree);
	Plaintext sub_result_plain2;
	Ciphertext sub_result_cipher2; // store the sub result of the mulpilication

	vector<uint64_t> final_result(poly_modulus_degree);
	Plaintext final_result_plain;
	Ciphertext final_result_cipher; //store the final result of the mat-vec product

	vector<uint64_t> rotated(poly_modulus_degree);
	Plaintext rotated_plain;
	Ciphertext rotated_cipher; // store the semi-result of the rotate-sum process

	vector<uint64_t> mask(poly_modulus_degree);
	Plaintext mask_plain;
	Ciphertext mask_cipher; // store the semi-result of the rotate-sum process

	//�������� ����ÿ��ѭ������
	for (int j = 0; j < row_size; j++) {
		mask[j] = 1;
	}
	batch_encoder.encode(mask, mask_plain);
	encryptor.encrypt(mask_plain, mask_cipher);

	// Begin multiplication: ʹ�� Gazelle ����� Diagonal ����
	clock_t start1 = clock();
	evaluator.multiply(vec_cipher, mat_cipher, temp_cipher);

	// decrypt and encrypt
	decryptor.decrypt(temp_cipher, temp_plain);
	batch_encoder.decode(temp_plain, temp);
	std::cout << "dot-product<vec, mat> = ";
	print_matrix(temp, row_size);
	std::cout << "-------------------------------------------------------------------------------------------------------------------" << endl;

	// sub_result1���ۼ��� �ȳ�ʼ��Ϊ0
	sub_result1 = zeros;
	batch_encoder.encode(sub_result1, sub_result_plain1);
	encryptor.encrypt(sub_result_plain1, sub_result_cipher1);

	for (int ii = 0; ii < row_size; ii++) {
		for (int j = 0; j < row_size; j++) {
			sub_result2[j] = temp[(ii + j) < row_size ? ii + j + row_size * j : ii + j + row_size * (j - 1)];
		}
		// �� sub_result2 ���� ���������� sum
		batch_encoder.encode(sub_result2, sub_result_plain2);
		encryptor.encrypt(sub_result_plain2, sub_result_cipher2);
		// ���� sum
		evaluator.add_inplace(sub_result_cipher1, sub_result_cipher2);

	}
	// print the sub_result1
	decryptor.decrypt(sub_result_cipher1, sub_result_plain1);
	batch_encoder.decode(sub_result_plain1, sub_result1);
	std::cout << "final result:";
	print_matrix(sub_result1, row_size);

	clock_t end1 = clock();
	double TotalTime1 = (double)(end1 - start1) / CLOCKS_PER_SEC;
	std::cout << "-------------------------------------------------------------------------------------------------------------------" << endl;
	std::cout << "Total time: " << TotalTime1 * 1000 << " ms" << endl;
}

void test() {
	EncryptionParameters parms(scheme_type::bfv);

	parms.set_poly_modulus_degree(poly_modulus_degree);
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));
	parms.set_plain_modulus(PlainModulus::Batching(poly_modulus_degree, 20));

	SEALContext context(parms);
	// print_parameters(context);
	// cout << endl;

	KeyGenerator keygen(context);
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);
	RelinKeys relin_keys;
	keygen.create_relin_keys(relin_keys);
	GaloisKeys galois_keys;
	keygen.create_galois_keys(galois_keys);

	Encryptor encryptor(context, public_key);
	Evaluator evaluator(context);
	Decryptor decryptor(context, secret_key);

	BatchEncoder batch_encoder(context);
	size_t slot_count = batch_encoder.slot_count();
	size_t row_size = 16;
	size_t column_size = 16;

	vector<uint64_t> vec(row_size, 1);
	Plaintext vec_plain;
	Ciphertext vec_cipher;

	for (int j = 0; j < row_size; j++) {
		vec[j] = j + 1;
	}
	print_matrix(vec, 16);
	batch_encoder.encode(vec, vec_plain);
	encryptor.encrypt(vec_plain, vec_cipher);
	print_line(__LINE__);
	evaluator.rotate_rows_inplace(vec_cipher, 3, galois_keys);
	print_line(__LINE__);

	decryptor.decrypt(vec_cipher, vec_plain);
	batch_encoder.decode(vec_plain, vec);

	print_matrix(vec, 16);




}

int main(){
	
	// bfv_toy_example();
	// ckks();
	// multiply_plain_inplace();
	multiply_cipherVEC_cipherVEC();
	// multiply_mat_vec();
	// multiply_mat_vec_opt();
	// test();
	return 0;
}
