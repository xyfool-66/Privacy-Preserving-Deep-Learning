// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2020.1
// Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

#ifndef _mat_vec_multiply_HH_
#define _mat_vec_multiply_HH_

#include "systemc.h"
#include "AESL_pkg.h"

#include "mat_vec_multiply_bkb.h"

namespace ap_rtl {

struct mat_vec_multiply : public sc_module {
    // Port declarations 17
    sc_in_clk ap_clk;
    sc_in< sc_logic > ap_rst;
    sc_in< sc_logic > ap_start;
    sc_out< sc_logic > ap_done;
    sc_out< sc_logic > ap_idle;
    sc_out< sc_logic > ap_ready;
    sc_out< sc_lv<4> > mat_in_address0;
    sc_out< sc_logic > mat_in_ce0;
    sc_in< sc_lv<32> > mat_in_q0;
    sc_out< sc_lv<2> > vec_in_address0;
    sc_out< sc_logic > vec_in_ce0;
    sc_in< sc_lv<32> > vec_in_q0;
    sc_out< sc_lv<2> > accumulator_address0;
    sc_out< sc_logic > accumulator_ce0;
    sc_out< sc_logic > accumulator_we0;
    sc_out< sc_lv<32> > accumulator_d0;
    sc_in< sc_lv<32> > accumulator_q0;


    // Module declarations
    mat_vec_multiply(sc_module_name name);
    SC_HAS_PROCESS(mat_vec_multiply);

    ~mat_vec_multiply();

    sc_trace_file* mVcdFile;

    ofstream mHdltvinHandle;
    ofstream mHdltvoutHandle;
    mat_vec_multiply_bkb* dot_prod_U;
    sc_signal< sc_lv<8> > ap_CS_fsm;
    sc_signal< sc_logic > ap_CS_fsm_state1;
    sc_signal< sc_lv<3> > i_fu_161_p2;
    sc_signal< sc_lv<3> > i_reg_323;
    sc_signal< sc_logic > ap_CS_fsm_state2;
    sc_signal< sc_lv<6> > zext_ln12_fu_175_p1;
    sc_signal< sc_lv<6> > zext_ln12_reg_328;
    sc_signal< sc_lv<1> > icmp_ln11_fu_155_p2;
    sc_signal< sc_lv<3> > j_fu_185_p2;
    sc_signal< sc_lv<3> > j_reg_336;
    sc_signal< sc_logic > ap_CS_fsm_state3;
    sc_signal< sc_lv<64> > zext_ln13_2_fu_205_p1;
    sc_signal< sc_lv<64> > zext_ln13_2_reg_341;
    sc_signal< sc_lv<1> > icmp_ln12_fu_179_p2;
    sc_signal< sc_lv<32> > mul_ln13_fu_210_p2;
    sc_signal< sc_lv<32> > mul_ln13_reg_356;
    sc_signal< sc_logic > ap_CS_fsm_state4;
    sc_signal< sc_lv<3> > i_1_fu_222_p2;
    sc_signal< sc_lv<3> > i_1_reg_364;
    sc_signal< sc_logic > ap_CS_fsm_state6;
    sc_signal< sc_lv<3> > xor_ln20_fu_228_p2;
    sc_signal< sc_lv<3> > xor_ln20_reg_369;
    sc_signal< sc_lv<1> > icmp_ln18_fu_216_p2;
    sc_signal< sc_lv<3> > j_1_fu_244_p2;
    sc_signal< sc_lv<3> > j_1_reg_377;
    sc_signal< sc_logic > ap_CS_fsm_state7;
    sc_signal< sc_lv<1> > icmp_ln19_fu_238_p2;
    sc_signal< sc_lv<2> > accumulator_addr_reg_387;
    sc_signal< sc_lv<4> > dot_prod_address0;
    sc_signal< sc_logic > dot_prod_ce0;
    sc_signal< sc_logic > dot_prod_we0;
    sc_signal< sc_lv<32> > dot_prod_q0;
    sc_signal< sc_lv<3> > i_0_reg_110;
    sc_signal< sc_lv<3> > j_0_reg_121;
    sc_signal< sc_logic > ap_CS_fsm_state5;
    sc_signal< sc_lv<3> > i1_0_reg_132;
    sc_signal< sc_lv<3> > j2_0_reg_144;
    sc_signal< sc_logic > ap_CS_fsm_state8;
    sc_signal< sc_lv<64> > zext_ln13_fu_191_p1;
    sc_signal< sc_lv<64> > sext_ln20_2_fu_308_p1;
    sc_signal< sc_lv<64> > zext_ln20_fu_285_p1;
    sc_signal< sc_lv<5> > tmp_2_fu_167_p3;
    sc_signal< sc_lv<6> > zext_ln13_1_fu_196_p1;
    sc_signal< sc_lv<6> > add_ln13_fu_200_p2;
    sc_signal< sc_lv<32> > mul_ln13_fu_210_p0;
    sc_signal< sc_lv<32> > mul_ln13_fu_210_p1;
    sc_signal< sc_lv<3> > add_ln20_fu_250_p2;
    sc_signal< sc_lv<1> > tmp_4_fu_256_p3;
    sc_signal< sc_lv<3> > select_ln20_fu_264_p3;
    sc_signal< sc_lv<4> > zext_ln19_fu_234_p1;
    sc_signal< sc_lv<4> > sext_ln20_fu_271_p1;
    sc_signal< sc_lv<4> > add_ln20_1_fu_275_p2;
    sc_signal< sc_lv<5> > tmp_3_fu_290_p3;
    sc_signal< sc_lv<6> > sext_ln20_1_fu_281_p1;
    sc_signal< sc_lv<6> > zext_ln20_1_fu_298_p1;
    sc_signal< sc_lv<6> > add_ln20_3_fu_302_p2;
    sc_signal< sc_lv<8> > ap_NS_fsm;
    static const sc_logic ap_const_logic_1;
    static const sc_logic ap_const_logic_0;
    static const sc_lv<8> ap_ST_fsm_state1;
    static const sc_lv<8> ap_ST_fsm_state2;
    static const sc_lv<8> ap_ST_fsm_state3;
    static const sc_lv<8> ap_ST_fsm_state4;
    static const sc_lv<8> ap_ST_fsm_state5;
    static const sc_lv<8> ap_ST_fsm_state6;
    static const sc_lv<8> ap_ST_fsm_state7;
    static const sc_lv<8> ap_ST_fsm_state8;
    static const sc_lv<32> ap_const_lv32_0;
    static const sc_lv<32> ap_const_lv32_1;
    static const sc_lv<1> ap_const_lv1_0;
    static const sc_lv<32> ap_const_lv32_2;
    static const sc_lv<32> ap_const_lv32_3;
    static const sc_lv<32> ap_const_lv32_5;
    static const sc_lv<32> ap_const_lv32_6;
    static const sc_lv<3> ap_const_lv3_0;
    static const sc_lv<1> ap_const_lv1_1;
    static const sc_lv<32> ap_const_lv32_4;
    static const sc_lv<32> ap_const_lv32_7;
    static const sc_lv<3> ap_const_lv3_4;
    static const sc_lv<3> ap_const_lv3_1;
    static const sc_lv<2> ap_const_lv2_0;
    static const bool ap_const_boolean_1;
    // Thread declarations
    void thread_ap_clk_no_reset_();
    void thread_accumulator_address0();
    void thread_accumulator_ce0();
    void thread_accumulator_d0();
    void thread_accumulator_we0();
    void thread_add_ln13_fu_200_p2();
    void thread_add_ln20_1_fu_275_p2();
    void thread_add_ln20_3_fu_302_p2();
    void thread_add_ln20_fu_250_p2();
    void thread_ap_CS_fsm_state1();
    void thread_ap_CS_fsm_state2();
    void thread_ap_CS_fsm_state3();
    void thread_ap_CS_fsm_state4();
    void thread_ap_CS_fsm_state5();
    void thread_ap_CS_fsm_state6();
    void thread_ap_CS_fsm_state7();
    void thread_ap_CS_fsm_state8();
    void thread_ap_done();
    void thread_ap_idle();
    void thread_ap_ready();
    void thread_dot_prod_address0();
    void thread_dot_prod_ce0();
    void thread_dot_prod_we0();
    void thread_i_1_fu_222_p2();
    void thread_i_fu_161_p2();
    void thread_icmp_ln11_fu_155_p2();
    void thread_icmp_ln12_fu_179_p2();
    void thread_icmp_ln18_fu_216_p2();
    void thread_icmp_ln19_fu_238_p2();
    void thread_j_1_fu_244_p2();
    void thread_j_fu_185_p2();
    void thread_mat_in_address0();
    void thread_mat_in_ce0();
    void thread_mul_ln13_fu_210_p0();
    void thread_mul_ln13_fu_210_p1();
    void thread_mul_ln13_fu_210_p2();
    void thread_select_ln20_fu_264_p3();
    void thread_sext_ln20_1_fu_281_p1();
    void thread_sext_ln20_2_fu_308_p1();
    void thread_sext_ln20_fu_271_p1();
    void thread_tmp_2_fu_167_p3();
    void thread_tmp_3_fu_290_p3();
    void thread_tmp_4_fu_256_p3();
    void thread_vec_in_address0();
    void thread_vec_in_ce0();
    void thread_xor_ln20_fu_228_p2();
    void thread_zext_ln12_fu_175_p1();
    void thread_zext_ln13_1_fu_196_p1();
    void thread_zext_ln13_2_fu_205_p1();
    void thread_zext_ln13_fu_191_p1();
    void thread_zext_ln19_fu_234_p1();
    void thread_zext_ln20_1_fu_298_p1();
    void thread_zext_ln20_fu_285_p1();
    void thread_ap_NS_fsm();
    void thread_hdltv_gen();
};

}

using namespace ap_rtl;

#endif