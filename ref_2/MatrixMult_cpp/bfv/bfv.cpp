#include "examples.h"

using namespace std;
using namespace seal;

void bfv_toy_example(){

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