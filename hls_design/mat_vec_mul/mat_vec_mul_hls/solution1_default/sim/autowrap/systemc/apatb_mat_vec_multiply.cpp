// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2020.1 (64-bit)
// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// ==============================================================

#include <systemc>
#include <iostream>
#include <cstdlib>
#include <cstddef>
#include <stdint.h>
#include "SysCFileHandler.h"
#include "ap_int.h"
#include "ap_fixed.h"
#include <complex>
#include <stdbool.h>
#include "autopilot_cbe.h"
#include "hls_stream.h"
#include "hls_half.h"
#include "hls_signal_handler.h"

using namespace std;
using namespace sc_core;
using namespace sc_dt;


// [dump_struct_tree [build_nameSpaceTree] dumpedStructList] ---------->


// [dump_enumeration [get_enumeration_list]] ---------->


// wrapc file define: "mat_in"
#define AUTOTB_TVIN_mat_in  "../tv/cdatafile/c.mat_vec_multiply.autotvin_mat_in.dat"
// wrapc file define: "vec_in"
#define AUTOTB_TVIN_vec_in  "../tv/cdatafile/c.mat_vec_multiply.autotvin_vec_in.dat"
// wrapc file define: "accumulator"
#define AUTOTB_TVIN_accumulator  "../tv/cdatafile/c.mat_vec_multiply.autotvin_accumulator.dat"
#define AUTOTB_TVOUT_accumulator  "../tv/cdatafile/c.mat_vec_multiply.autotvout_accumulator.dat"

#define INTER_TCL  "../tv/cdatafile/ref.tcl"

// tvout file define: "accumulator"
#define AUTOTB_TVOUT_PC_accumulator  "../tv/rtldatafile/rtl.mat_vec_multiply.autotvout_accumulator.dat"

class INTER_TCL_FILE {
	public:
		INTER_TCL_FILE(const char* name) {
			mName = name;
			mat_in_depth = 0;
			vec_in_depth = 0;
			accumulator_depth = 0;
			trans_num =0;
		}

		~INTER_TCL_FILE() {
			mFile.open(mName);
			if (!mFile.good()) {
				cout << "Failed to open file ref.tcl" << endl;
				exit (1);
			}
			string total_list = get_depth_list();
			mFile << "set depth_list {\n";
			mFile << total_list;
			mFile << "}\n";
			mFile << "set trans_num "<<trans_num<<endl;
			mFile.close();
		}

		string get_depth_list () {
			stringstream total_list;
			total_list << "{mat_in " << mat_in_depth << "}\n";
			total_list << "{vec_in " << vec_in_depth << "}\n";
			total_list << "{accumulator " << accumulator_depth << "}\n";
			return total_list.str();
		}

		void set_num (int num , int* class_num) {
			(*class_num) = (*class_num) > num ? (*class_num) : num;
		}
	public:
		int mat_in_depth;
		int vec_in_depth;
		int accumulator_depth;
		int trans_num;

	private:
		ofstream mFile;
		const char* mName;
};

extern void mat_vec_multiply (
int mat_in[4][4],
int vec_in[4],
int accumulator[4]);

void AESL_WRAP_mat_vec_multiply (
int mat_in[4][4],
int vec_in[4],
int accumulator[4])
{
	refine_signal_handler();
	fstream wrapc_switch_file_token;
	wrapc_switch_file_token.open(".hls_cosim_wrapc_switch.log");
	int AESL_i;
	if (wrapc_switch_file_token.good())
	{
		CodeState = ENTER_WRAPC_PC;
		static unsigned AESL_transaction_pc = 0;
		string AESL_token;
		string AESL_num;
		static AESL_FILE_HANDLER aesl_fh;


		// output port post check: "accumulator"
		aesl_fh.read(AUTOTB_TVOUT_PC_accumulator, AESL_token); // [[transaction]]
		if (AESL_token != "[[transaction]]")
		{
			exit(1);
		}
		aesl_fh.read(AUTOTB_TVOUT_PC_accumulator, AESL_num); // transaction number

		if (atoi(AESL_num.c_str()) == AESL_transaction_pc)
		{
			aesl_fh.read(AUTOTB_TVOUT_PC_accumulator, AESL_token); // data

			sc_bv<32> *accumulator_pc_buffer = new sc_bv<32>[4];
			int i = 0;

			while (AESL_token != "[[/transaction]]")
			{
				bool no_x = false;
				bool err = false;

				// search and replace 'X' with "0" from the 1st char of token
				while (!no_x)
				{
					size_t x_found = AESL_token.find('X');
					if (x_found != string::npos)
					{
						if (!err)
						{
							cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port 'accumulator', possible cause: There are uninitialized variables in the C design." << endl;
							err = true;
						}
						AESL_token.replace(x_found, 1, "0");
					}
					else
					{
						no_x = true;
					}
				}

				no_x = false;

				// search and replace 'x' with "0" from the 3rd char of token
				while (!no_x)
				{
					size_t x_found = AESL_token.find('x', 2);

					if (x_found != string::npos)
					{
						if (!err)
						{
							cerr << "WARNING: [SIM 212-201] RTL produces unknown value 'X' on port 'accumulator', possible cause: There are uninitialized variables in the C design." << endl;
							err = true;
						}
						AESL_token.replace(x_found, 1, "0");
					}
					else
					{
						no_x = true;
					}
				}

				// push token into output port buffer
				if (AESL_token != "")
				{
					accumulator_pc_buffer[i] = AESL_token.c_str();
					i++;
				}

				aesl_fh.read(AUTOTB_TVOUT_PC_accumulator, AESL_token); // data or [[/transaction]]

				if (AESL_token == "[[[/runtime]]]" || aesl_fh.eof(AUTOTB_TVOUT_PC_accumulator))
				{
					exit(1);
				}
			}

			// ***********************************
			if (i > 0)
			{
				// RTL Name: accumulator
				{
					// bitslice(31, 0)
					// {
						// celement: accumulator(31, 0)
						// {
							sc_lv<32>* accumulator_lv0_0_3_1 = new sc_lv<32>[4];
						// }
					// }

					// bitslice(31, 0)
					{
						int hls_map_index = 0;
						// celement: accumulator(31, 0)
						{
							// carray: (0) => (3) @ (1)
							for (int i_0 = 0; i_0 <= 3; i_0 += 1)
							{
								if (&(accumulator[0]) != NULL) // check the null address if the c port is array or others
								{
									accumulator_lv0_0_3_1[hls_map_index].range(31, 0) = sc_bv<32>(accumulator_pc_buffer[hls_map_index].range(31, 0));
									hls_map_index++;
								}
							}
						}
					}

					// bitslice(31, 0)
					{
						int hls_map_index = 0;
						// celement: accumulator(31, 0)
						{
							// carray: (0) => (3) @ (1)
							for (int i_0 = 0; i_0 <= 3; i_0 += 1)
							{
								// sub                    : i_0
								// ori_name               : accumulator[i_0]
								// sub_1st_elem           : 0
								// ori_name_1st_elem      : accumulator[0]
								// output_left_conversion : accumulator[i_0]
								// output_type_conversion : (accumulator_lv0_0_3_1[hls_map_index]).to_uint64()
								if (&(accumulator[0]) != NULL) // check the null address if the c port is array or others
								{
									accumulator[i_0] = (accumulator_lv0_0_3_1[hls_map_index]).to_uint64();
									hls_map_index++;
								}
							}
						}
					}
				}
			}

			// release memory allocation
			delete [] accumulator_pc_buffer;
		}

		AESL_transaction_pc++;
	}
	else
	{
		CodeState = ENTER_WRAPC;
		static unsigned AESL_transaction;

		static AESL_FILE_HANDLER aesl_fh;

		// "mat_in"
		char* tvin_mat_in = new char[50];
		aesl_fh.touch(AUTOTB_TVIN_mat_in);

		// "vec_in"
		char* tvin_vec_in = new char[50];
		aesl_fh.touch(AUTOTB_TVIN_vec_in);

		// "accumulator"
		char* tvin_accumulator = new char[50];
		aesl_fh.touch(AUTOTB_TVIN_accumulator);
		char* tvout_accumulator = new char[50];
		aesl_fh.touch(AUTOTB_TVOUT_accumulator);

		CodeState = DUMP_INPUTS;
		static INTER_TCL_FILE tcl_file(INTER_TCL);
		int leading_zero;

		// [[transaction]]
		sprintf(tvin_mat_in, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVIN_mat_in, tvin_mat_in);

		sc_bv<32>* mat_in_tvin_wrapc_buffer = new sc_bv<32>[16];

		// RTL Name: mat_in
		{
			// bitslice(31, 0)
			{
				int hls_map_index = 0;
				// celement: mat_in(31, 0)
				{
					// carray: (0) => (3) @ (1)
					for (int i_0 = 0; i_0 <= 3; i_0 += 1)
					{
						// carray: (0) => (3) @ (1)
						for (int i_1 = 0; i_1 <= 3; i_1 += 1)
						{
							// sub                   : i_0 i_1
							// ori_name              : mat_in[i_0][i_1]
							// sub_1st_elem          : 0 0
							// ori_name_1st_elem     : mat_in[0][0]
							// regulate_c_name       : mat_in
							// input_type_conversion : mat_in[i_0][i_1]
							if (&(mat_in[0][0]) != NULL) // check the null address if the c port is array or others
							{
								sc_lv<32> mat_in_tmp_mem;
								mat_in_tmp_mem = mat_in[i_0][i_1];
								mat_in_tvin_wrapc_buffer[hls_map_index].range(31, 0) = mat_in_tmp_mem.range(31, 0);
                                 		       hls_map_index++;
							}
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 16; i++)
		{
			sprintf(tvin_mat_in, "%s\n", (mat_in_tvin_wrapc_buffer[i]).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVIN_mat_in, tvin_mat_in);
		}

		tcl_file.set_num(16, &tcl_file.mat_in_depth);
		sprintf(tvin_mat_in, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVIN_mat_in, tvin_mat_in);

		// release memory allocation
		delete [] mat_in_tvin_wrapc_buffer;

		// [[transaction]]
		sprintf(tvin_vec_in, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVIN_vec_in, tvin_vec_in);

		sc_bv<32>* vec_in_tvin_wrapc_buffer = new sc_bv<32>[4];

		// RTL Name: vec_in
		{
			// bitslice(31, 0)
			{
				int hls_map_index = 0;
				// celement: vec_in(31, 0)
				{
					// carray: (0) => (3) @ (1)
					for (int i_0 = 0; i_0 <= 3; i_0 += 1)
					{
						// sub                   : i_0
						// ori_name              : vec_in[i_0]
						// sub_1st_elem          : 0
						// ori_name_1st_elem     : vec_in[0]
						// regulate_c_name       : vec_in
						// input_type_conversion : vec_in[i_0]
						if (&(vec_in[0]) != NULL) // check the null address if the c port is array or others
						{
							sc_lv<32> vec_in_tmp_mem;
							vec_in_tmp_mem = vec_in[i_0];
							vec_in_tvin_wrapc_buffer[hls_map_index].range(31, 0) = vec_in_tmp_mem.range(31, 0);
                                 	       hls_map_index++;
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 4; i++)
		{
			sprintf(tvin_vec_in, "%s\n", (vec_in_tvin_wrapc_buffer[i]).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVIN_vec_in, tvin_vec_in);
		}

		tcl_file.set_num(4, &tcl_file.vec_in_depth);
		sprintf(tvin_vec_in, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVIN_vec_in, tvin_vec_in);

		// release memory allocation
		delete [] vec_in_tvin_wrapc_buffer;

		// [[transaction]]
		sprintf(tvin_accumulator, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVIN_accumulator, tvin_accumulator);

		sc_bv<32>* accumulator_tvin_wrapc_buffer = new sc_bv<32>[4];

		// RTL Name: accumulator
		{
			// bitslice(31, 0)
			{
				int hls_map_index = 0;
				// celement: accumulator(31, 0)
				{
					// carray: (0) => (3) @ (1)
					for (int i_0 = 0; i_0 <= 3; i_0 += 1)
					{
						// sub                   : i_0
						// ori_name              : accumulator[i_0]
						// sub_1st_elem          : 0
						// ori_name_1st_elem     : accumulator[0]
						// regulate_c_name       : accumulator
						// input_type_conversion : accumulator[i_0]
						if (&(accumulator[0]) != NULL) // check the null address if the c port is array or others
						{
							sc_lv<32> accumulator_tmp_mem;
							accumulator_tmp_mem = accumulator[i_0];
							accumulator_tvin_wrapc_buffer[hls_map_index].range(31, 0) = accumulator_tmp_mem.range(31, 0);
                                 	       hls_map_index++;
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 4; i++)
		{
			sprintf(tvin_accumulator, "%s\n", (accumulator_tvin_wrapc_buffer[i]).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVIN_accumulator, tvin_accumulator);
		}

		tcl_file.set_num(4, &tcl_file.accumulator_depth);
		sprintf(tvin_accumulator, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVIN_accumulator, tvin_accumulator);

		// release memory allocation
		delete [] accumulator_tvin_wrapc_buffer;

// [call_c_dut] ---------->

		CodeState = CALL_C_DUT;
		mat_vec_multiply(mat_in, vec_in, accumulator);

		CodeState = DUMP_OUTPUTS;

		// [[transaction]]
		sprintf(tvout_accumulator, "[[transaction]] %d\n", AESL_transaction);
		aesl_fh.write(AUTOTB_TVOUT_accumulator, tvout_accumulator);

		sc_bv<32>* accumulator_tvout_wrapc_buffer = new sc_bv<32>[4];

		// RTL Name: accumulator
		{
			// bitslice(31, 0)
			{
				int hls_map_index = 0;
				// celement: accumulator(31, 0)
				{
					// carray: (0) => (3) @ (1)
					for (int i_0 = 0; i_0 <= 3; i_0 += 1)
					{
						// sub                   : i_0
						// ori_name              : accumulator[i_0]
						// sub_1st_elem          : 0
						// ori_name_1st_elem     : accumulator[0]
						// regulate_c_name       : accumulator
						// input_type_conversion : accumulator[i_0]
						if (&(accumulator[0]) != NULL) // check the null address if the c port is array or others
						{
							sc_lv<32> accumulator_tmp_mem;
							accumulator_tmp_mem = accumulator[i_0];
							accumulator_tvout_wrapc_buffer[hls_map_index].range(31, 0) = accumulator_tmp_mem.range(31, 0);
                                 	       hls_map_index++;
						}
					}
				}
			}
		}

		// dump tv to file
		for (int i = 0; i < 4; i++)
		{
			sprintf(tvout_accumulator, "%s\n", (accumulator_tvout_wrapc_buffer[i]).to_string(SC_HEX).c_str());
			aesl_fh.write(AUTOTB_TVOUT_accumulator, tvout_accumulator);
		}

		tcl_file.set_num(4, &tcl_file.accumulator_depth);
		sprintf(tvout_accumulator, "[[/transaction]] \n");
		aesl_fh.write(AUTOTB_TVOUT_accumulator, tvout_accumulator);

		// release memory allocation
		delete [] accumulator_tvout_wrapc_buffer;

		CodeState = DELETE_CHAR_BUFFERS;
		// release memory allocation: "mat_in"
		delete [] tvin_mat_in;
		// release memory allocation: "vec_in"
		delete [] tvin_vec_in;
		// release memory allocation: "accumulator"
		delete [] tvin_accumulator;
		delete [] tvout_accumulator;

		AESL_transaction++;

		tcl_file.set_num(AESL_transaction , &tcl_file.trans_num);
	}
}

