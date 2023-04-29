#include "examples.h"

using namespace std;
using namespace seal;

void bfv_toy_example(){

	// 生成方案所需参数
	EncryptionParameters parms(scheme_type::bfv);


	//------------------设置参数----------------------//

	// poly_modulus_degree 表示多项式环的模
	size_t poly_modulus_degree = 4096;
	parms.set_poly_modulus_degree(poly_modulus_degree);

	// coeff_modulus 表示系数的模 上面4096对应109
	// CoeffModulus::MaxBitCount(poly_modulus_degree) 获取给定 poly_modulus_degree 下的多项式的系模数的最大 bit 长度
	// SEAL 中的辅助函数 CoeffModulus::BFVDefault(poly_modulus_degree) 返回给定 poly_modulus_degree 下的多项式系数模
	parms.set_coeff_modulus(CoeffModulus::BFVDefault(poly_modulus_degree));

	// plain_modulus 明文空间的模
	parms.set_plain_modulus(1024);

	// 检查参数的合理性
	SEALContext context(parms);
	print_line(__LINE__); // 打印本行代码的行号
	cout << "Parameter validation (success): " << context.parameter_error_message() << endl; // 输出 valid 表示参数有效


	//------------------生成公钥和私钥----------------------//

	KeyGenerator keygen(context); //例化一个对象 用于生成 PublicKey 和 SecretKey
	SecretKey secret_key = keygen.secret_key();
	PublicKey public_key;
	keygen.create_public_key(public_key);


	//------------------加密和解密----------------------//
	Encryptor encryptor(context, public_key);		// 初始化 Encryptor 对象
	Evaluator evaluator(context);					// 初始化 Evaluator 对象
	Decryptor decryptor(context, secret_key);		// 初始化 Decryptor 对象

	uint64_t x = 6;
	Plaintext x_plain(uint64_to_hex_string(x));		// 构造 Plaintext 对象，uint64_to_hex_string会把一个值变为一个十六进制串形式，如：17 --> "11"
	cout << "Express x = " + to_string(x) + " as a plaintext polynomial 0x" + x_plain.to_string() + "." << endl;

	Ciphertext x_encrypted;  						// 定义 x=6 对应的密文对象
	encryptor.encrypt(x_plain, x_encrypted);		// 使用 Encryptor 对象进行加密，并保存到一个 Ciphertext 对象中

	cout << "    + size of freshly encrypted x: " << x_encrypted.size() << endl;  //输出该密文的多项式个数
	cout << "    + noise budget in freshly encrypted x: " << decryptor.invariant_noise_budget(x_encrypted) << " bits" << endl;	//输出该密文还剩下的噪声预算（bit表示）

	Plaintext x_decrypted;							//保存解密后的结果
	decryptor.decrypt(x_encrypted, x_decrypted);	//使用 Decryptor 对象解密，并把结果保存到 x_decrypted 对象中
	cout << "    + decryption of x_encrypted: " << "0x" << x_decrypted.to_string() << endl;	//输出结果，看看是否为 6















}