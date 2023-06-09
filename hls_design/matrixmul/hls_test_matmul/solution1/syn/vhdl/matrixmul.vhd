-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2020.1
-- Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity matrixmul is
port (
    ap_clk : IN STD_LOGIC;
    ap_rst : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    a_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    a_empty_n : IN STD_LOGIC;
    a_read : OUT STD_LOGIC;
    b_dout : IN STD_LOGIC_VECTOR (23 downto 0);
    b_empty_n : IN STD_LOGIC;
    b_read : OUT STD_LOGIC;
    res_din : OUT STD_LOGIC_VECTOR (15 downto 0);
    res_full_n : IN STD_LOGIC;
    res_write : OUT STD_LOGIC );
end;


architecture behav of matrixmul is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "matrixmul,hls_ip_2020_1,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=0,HLS_INPUT_PART=xc7vx485t-ffg1157-1,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=others,HLS_SYN_CLOCK=8.522000,HLS_SYN_LAT=13,HLS_SYN_TPT=none,HLS_SYN_MEM=0,HLS_SYN_DSP=2,HLS_SYN_FF=215,HLS_SYN_LUT=429,HLS_VERSION=2020_1}";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';
    constant ap_ST_fsm_state1 : STD_LOGIC_VECTOR (2 downto 0) := "001";
    constant ap_ST_fsm_pp0_stage0 : STD_LOGIC_VECTOR (2 downto 0) := "010";
    constant ap_ST_fsm_state6 : STD_LOGIC_VECTOR (2 downto 0) := "100";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_boolean_1 : BOOLEAN := true;
    constant ap_const_lv32_1 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000001";
    constant ap_const_boolean_0 : BOOLEAN := false;
    constant ap_const_lv1_1 : STD_LOGIC_VECTOR (0 downto 0) := "1";
    constant ap_const_lv1_0 : STD_LOGIC_VECTOR (0 downto 0) := "0";
    constant ap_const_lv4_0 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
    constant ap_const_lv2_0 : STD_LOGIC_VECTOR (1 downto 0) := "00";
    constant ap_const_lv4_9 : STD_LOGIC_VECTOR (3 downto 0) := "1001";
    constant ap_const_lv4_1 : STD_LOGIC_VECTOR (3 downto 0) := "0001";
    constant ap_const_lv2_3 : STD_LOGIC_VECTOR (1 downto 0) := "11";
    constant ap_const_lv2_1 : STD_LOGIC_VECTOR (1 downto 0) := "01";
    constant ap_const_lv32_8 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001000";
    constant ap_const_lv32_F : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000001111";
    constant ap_const_lv32_10 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010000";
    constant ap_const_lv32_17 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000010111";
    constant ap_const_lv32_2 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000010";

    signal ap_CS_fsm : STD_LOGIC_VECTOR (2 downto 0) := "001";
    attribute fsm_encoding : string;
    attribute fsm_encoding of ap_CS_fsm : signal is "none";
    signal ap_CS_fsm_state1 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state1 : signal is "none";
    signal a_blk_n : STD_LOGIC;
    signal ap_CS_fsm_pp0_stage0 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_pp0_stage0 : signal is "none";
    signal ap_enable_reg_pp0_iter1 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0 : BOOLEAN;
    signal icmp_ln70_reg_711 : STD_LOGIC_VECTOR (0 downto 0);
    signal b_blk_n : STD_LOGIC;
    signal select_ln75_1_reg_702 : STD_LOGIC_VECTOR (0 downto 0);
    signal res_blk_n : STD_LOGIC;
    signal ap_enable_reg_pp0_iter3 : STD_LOGIC := '0';
    signal icmp_ln63_reg_685 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln63_reg_685_pp0_iter2_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal indvar_flatten_reg_135 : STD_LOGIC_VECTOR (3 downto 0);
    signal i_0_reg_146 : STD_LOGIC_VECTOR (1 downto 0);
    signal j_0_reg_157 : STD_LOGIC_VECTOR (1 downto 0);
    signal icmp_ln63_fu_168_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal ap_block_state2_pp0_stage0_iter0 : BOOLEAN;
    signal ap_block_state3_pp0_stage0_iter1 : BOOLEAN;
    signal ap_block_state4_pp0_stage0_iter2 : BOOLEAN;
    signal ap_block_state5_pp0_stage0_iter3 : BOOLEAN;
    signal ap_block_pp0_stage0_11001 : BOOLEAN;
    signal icmp_ln63_reg_685_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln63_fu_174_p2 : STD_LOGIC_VECTOR (3 downto 0);
    signal ap_enable_reg_pp0_iter0 : STD_LOGIC := '0';
    signal select_ln75_fu_186_p3 : STD_LOGIC_VECTOR (1 downto 0);
    signal select_ln75_reg_694 : STD_LOGIC_VECTOR (1 downto 0);
    signal select_ln75_reg_694_pp0_iter1_reg : STD_LOGIC_VECTOR (1 downto 0);
    signal select_ln75_1_fu_212_p3 : STD_LOGIC_VECTOR (0 downto 0);
    signal select_ln63_fu_220_p3 : STD_LOGIC_VECTOR (1 downto 0);
    signal icmp_ln70_fu_228_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln70_reg_711_pp0_iter1_reg : STD_LOGIC_VECTOR (0 downto 0);
    signal j_fu_234_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal a_row_0_1_fu_240_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal a_row_0_1_reg_729 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_1_fu_523_p5 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_1_reg_734 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_588_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal add_ln82_reg_739 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_enable_reg_pp0_iter2 : STD_LOGIC := '0';
    signal ap_block_pp0_stage0_subdone : BOOLEAN;
    signal ap_condition_pp0_exit_iter0_state2 : STD_LOGIC;
    signal a_row_0_fu_68 : STD_LOGIC_VECTOR (7 downto 0);
    signal a_row_1_1_fu_72 : STD_LOGIC_VECTOR (7 downto 0);
    signal a_row_2_1_fu_76 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_2_fu_80 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_8_fu_434_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_3_fu_84 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_7_fu_427_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_1_fu_88 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_5_fu_412_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_2_fu_92 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_8_fu_397_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_3_fu_96 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_7_fu_390_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_1_fu_100 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_5_fu_375_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_2_fu_104 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_8_fu_360_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_3_fu_108 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_7_fu_353_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_1_fu_112 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_5_fu_338_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_596_p3 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_block_pp0_stage0_01001 : BOOLEAN;
    signal icmp_ln65_fu_180_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal add_ln63_1_fu_194_p2 : STD_LOGIC_VECTOR (1 downto 0);
    signal icmp_ln75_fu_200_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln75_1_fu_206_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal icmp_ln77_fu_325_p2 : STD_LOGIC_VECTOR (0 downto 0);
    signal b_copy_2_2_9_fu_315_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_fu_330_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_2_2_6_fu_345_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_9_fu_305_p4 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_fu_367_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_1_2_6_fu_382_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_9_fu_301_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_fu_404_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal b_copy_0_2_6_fu_419_p3 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_2_fu_538_p5 : STD_LOGIC_VECTOR (7 downto 0);
    signal mul_ln82_1_fu_553_p0 : STD_LOGIC_VECTOR (7 downto 0);
    signal mul_ln82_1_fu_553_p1 : STD_LOGIC_VECTOR (7 downto 0);
    signal tmp_4_fu_563_p5 : STD_LOGIC_VECTOR (7 downto 0);
    signal grp_fu_588_p2 : STD_LOGIC_VECTOR (15 downto 0);
    signal ap_CS_fsm_state6 : STD_LOGIC;
    attribute fsm_encoding of ap_CS_fsm_state6 : signal is "none";
    signal ap_NS_fsm : STD_LOGIC_VECTOR (2 downto 0);
    signal ap_idle_pp0 : STD_LOGIC;
    signal ap_enable_pp0 : STD_LOGIC;

    component matrixmul_mux_32_bkb IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        din3_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (7 downto 0);
        din2 : IN STD_LOGIC_VECTOR (7 downto 0);
        din3 : IN STD_LOGIC_VECTOR (1 downto 0);
        dout : OUT STD_LOGIC_VECTOR (7 downto 0) );
    end component;


    component matrixmul_mac_mulcud IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (7 downto 0);
        din2 : IN STD_LOGIC_VECTOR (15 downto 0);
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;


    component matrixmul_mac_muldEe IS
    generic (
        ID : INTEGER;
        NUM_STAGE : INTEGER;
        din0_WIDTH : INTEGER;
        din1_WIDTH : INTEGER;
        din2_WIDTH : INTEGER;
        dout_WIDTH : INTEGER );
    port (
        din0 : IN STD_LOGIC_VECTOR (7 downto 0);
        din1 : IN STD_LOGIC_VECTOR (7 downto 0);
        din2 : IN STD_LOGIC_VECTOR (15 downto 0);
        dout : OUT STD_LOGIC_VECTOR (15 downto 0) );
    end component;



begin
    matrixmul_mux_32_bkb_U1 : component matrixmul_mux_32_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 8,
        din2_WIDTH => 8,
        din3_WIDTH => 2,
        dout_WIDTH => 8)
    port map (
        din0 => b_copy_0_2_2_fu_80,
        din1 => b_copy_0_2_3_fu_84,
        din2 => b_copy_0_2_1_fu_88,
        din3 => select_ln75_reg_694_pp0_iter1_reg,
        dout => tmp_1_fu_523_p5);

    matrixmul_mux_32_bkb_U2 : component matrixmul_mux_32_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 8,
        din2_WIDTH => 8,
        din3_WIDTH => 2,
        dout_WIDTH => 8)
    port map (
        din0 => b_copy_1_2_2_fu_92,
        din1 => b_copy_1_2_3_fu_96,
        din2 => b_copy_1_2_1_fu_100,
        din3 => select_ln75_reg_694_pp0_iter1_reg,
        dout => tmp_2_fu_538_p5);

    matrixmul_mux_32_bkb_U3 : component matrixmul_mux_32_bkb
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 8,
        din2_WIDTH => 8,
        din3_WIDTH => 2,
        dout_WIDTH => 8)
    port map (
        din0 => b_copy_2_2_2_fu_104,
        din1 => b_copy_2_2_3_fu_108,
        din2 => b_copy_2_2_1_fu_112,
        din3 => select_ln75_reg_694_pp0_iter1_reg,
        dout => tmp_4_fu_563_p5);

    matrixmul_mac_mulcud_U4 : component matrixmul_mac_mulcud
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 8,
        din2_WIDTH => 16,
        dout_WIDTH => 16)
    port map (
        din0 => a_row_2_1_fu_76,
        din1 => tmp_4_fu_563_p5,
        din2 => grp_fu_588_p2,
        dout => grp_fu_588_p3);

    matrixmul_mac_muldEe_U5 : component matrixmul_mac_muldEe
    generic map (
        ID => 1,
        NUM_STAGE => 1,
        din0_WIDTH => 8,
        din1_WIDTH => 8,
        din2_WIDTH => 16,
        dout_WIDTH => 16)
    port map (
        din0 => a_row_0_fu_68,
        din1 => tmp_1_reg_734,
        din2 => add_ln82_reg_739,
        dout => grp_fu_596_p3);





    ap_CS_fsm_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_CS_fsm <= ap_ST_fsm_state1;
            else
                ap_CS_fsm <= ap_NS_fsm;
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter0_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
            else
                if (((ap_const_logic_1 = ap_CS_fsm_pp0_stage0) and (ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_0;
                elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter0 <= ap_const_logic_1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter1_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter1 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then
                    if ((ap_const_logic_1 = ap_condition_pp0_exit_iter0_state2)) then 
                        ap_enable_reg_pp0_iter1 <= (ap_const_logic_1 xor ap_condition_pp0_exit_iter0_state2);
                    elsif ((ap_const_boolean_1 = ap_const_boolean_1)) then 
                        ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
                    end if;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter2_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter2 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
                end if; 
            end if;
        end if;
    end process;


    ap_enable_reg_pp0_iter3_assign_proc : process(ap_clk)
    begin
        if (ap_clk'event and ap_clk =  '1') then
            if (ap_rst = '1') then
                ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
            else
                if ((ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) then 
                    ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
                elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                    ap_enable_reg_pp0_iter3 <= ap_const_logic_0;
                end if; 
            end if;
        end if;
    end process;


    i_0_reg_146_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_fu_168_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                i_0_reg_146 <= select_ln63_fu_220_p3;
            elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                i_0_reg_146 <= ap_const_lv2_0;
            end if; 
        end if;
    end process;

    indvar_flatten_reg_135_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_fu_168_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                indvar_flatten_reg_135 <= add_ln63_fu_174_p2;
            elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                indvar_flatten_reg_135 <= ap_const_lv4_0;
            end if; 
        end if;
    end process;

    j_0_reg_157_assign_proc : process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_fu_168_p2 = ap_const_lv1_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
                j_0_reg_157 <= j_fu_234_p2;
            elsif (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
                j_0_reg_157 <= ap_const_lv2_0;
            end if; 
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                a_row_0_1_reg_729 <= a_row_0_1_fu_240_p1;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln70_reg_711_pp0_iter1_reg = ap_const_lv1_1) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then
                a_row_0_fu_68 <= a_row_0_1_reg_729;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                a_row_1_1_fu_72 <= a_dout(15 downto 8);
                a_row_2_1_fu_76 <= a_dout(23 downto 16);
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_reg_685_pp0_iter1_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_1))) then
                add_ln82_reg_739 <= grp_fu_588_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (select_ln75_1_reg_702 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                b_copy_0_2_1_fu_88 <= b_copy_0_2_5_fu_412_p3;
                b_copy_0_2_2_fu_80 <= b_copy_0_2_8_fu_434_p3;
                b_copy_0_2_3_fu_84 <= b_copy_0_2_7_fu_427_p3;
                b_copy_1_2_1_fu_100 <= b_copy_1_2_5_fu_375_p3;
                b_copy_1_2_2_fu_92 <= b_copy_1_2_8_fu_397_p3;
                b_copy_1_2_3_fu_96 <= b_copy_1_2_7_fu_390_p3;
                b_copy_2_2_1_fu_112 <= b_copy_2_2_5_fu_338_p3;
                b_copy_2_2_2_fu_104 <= b_copy_2_2_8_fu_360_p3;
                b_copy_2_2_3_fu_108 <= b_copy_2_2_7_fu_353_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln63_reg_685 <= icmp_ln63_fu_168_p2;
                icmp_ln63_reg_685_pp0_iter1_reg <= icmp_ln63_reg_685;
                icmp_ln70_reg_711_pp0_iter1_reg <= icmp_ln70_reg_711;
                select_ln75_reg_694_pp0_iter1_reg <= select_ln75_reg_694;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if ((ap_const_boolean_0 = ap_block_pp0_stage0_11001)) then
                icmp_ln63_reg_685_pp0_iter2_reg <= icmp_ln63_reg_685_pp0_iter1_reg;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_fu_168_p2 = ap_const_lv1_0) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then
                icmp_ln70_reg_711 <= icmp_ln70_fu_228_p2;
                select_ln75_1_reg_702 <= select_ln75_1_fu_212_p3;
                select_ln75_reg_694 <= select_ln75_fu_186_p3;
            end if;
        end if;
    end process;
    process (ap_clk)
    begin
        if (ap_clk'event and ap_clk = '1') then
            if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_reg_685_pp0_iter1_reg = ap_const_lv1_0))) then
                tmp_1_reg_734 <= tmp_1_fu_523_p5;
            end if;
        end if;
    end process;

    ap_NS_fsm_assign_proc : process (ap_start, ap_CS_fsm, ap_CS_fsm_state1, ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter3, icmp_ln63_fu_168_p2, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter2, ap_block_pp0_stage0_subdone)
    begin
        case ap_CS_fsm is
            when ap_ST_fsm_state1 => 
                if (((ap_start = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_state1))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                else
                    ap_NS_fsm <= ap_ST_fsm_state1;
                end if;
            when ap_ST_fsm_pp0_stage0 => 
                if ((not(((icmp_ln63_fu_168_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone))) and not(((ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0))))) then
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                elsif ((((icmp_ln63_fu_168_p2 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter0 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone)) or ((ap_enable_reg_pp0_iter3 = ap_const_logic_1) and (ap_const_boolean_0 = ap_block_pp0_stage0_subdone) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0)))) then
                    ap_NS_fsm <= ap_ST_fsm_state6;
                else
                    ap_NS_fsm <= ap_ST_fsm_pp0_stage0;
                end if;
            when ap_ST_fsm_state6 => 
                ap_NS_fsm <= ap_ST_fsm_state1;
            when others =>  
                ap_NS_fsm <= "XXX";
        end case;
    end process;

    a_blk_n_assign_proc : process(a_empty_n, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, icmp_ln70_reg_711)
    begin
        if (((icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            a_blk_n <= a_empty_n;
        else 
            a_blk_n <= ap_const_logic_1;
        end if; 
    end process;


    a_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, icmp_ln70_reg_711, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            a_read <= ap_const_logic_1;
        else 
            a_read <= ap_const_logic_0;
        end if; 
    end process;

    a_row_0_1_fu_240_p1 <= a_dout(8 - 1 downto 0);
    add_ln63_1_fu_194_p2 <= std_logic_vector(unsigned(i_0_reg_146) + unsigned(ap_const_lv2_1));
    add_ln63_fu_174_p2 <= std_logic_vector(unsigned(indvar_flatten_reg_135) + unsigned(ap_const_lv4_1));
    ap_CS_fsm_pp0_stage0 <= ap_CS_fsm(1);
    ap_CS_fsm_state1 <= ap_CS_fsm(0);
    ap_CS_fsm_state6 <= ap_CS_fsm(2);
        ap_block_pp0_stage0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_pp0_stage0_01001_assign_proc : process(a_empty_n, b_empty_n, res_full_n, ap_enable_reg_pp0_iter1, icmp_ln70_reg_711, select_ln75_1_reg_702, ap_enable_reg_pp0_iter3, icmp_ln63_reg_685_pp0_iter2_reg)
    begin
                ap_block_pp0_stage0_01001 <= (((icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (res_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((select_ln75_1_reg_702 = ap_const_lv1_1) and (b_empty_n = ap_const_logic_0)) or ((icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_logic_0 = a_empty_n)))));
    end process;


    ap_block_pp0_stage0_11001_assign_proc : process(a_empty_n, b_empty_n, res_full_n, ap_enable_reg_pp0_iter1, icmp_ln70_reg_711, select_ln75_1_reg_702, ap_enable_reg_pp0_iter3, icmp_ln63_reg_685_pp0_iter2_reg)
    begin
                ap_block_pp0_stage0_11001 <= (((icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (res_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((select_ln75_1_reg_702 = ap_const_lv1_1) and (b_empty_n = ap_const_logic_0)) or ((icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_logic_0 = a_empty_n)))));
    end process;


    ap_block_pp0_stage0_subdone_assign_proc : process(a_empty_n, b_empty_n, res_full_n, ap_enable_reg_pp0_iter1, icmp_ln70_reg_711, select_ln75_1_reg_702, ap_enable_reg_pp0_iter3, icmp_ln63_reg_685_pp0_iter2_reg)
    begin
                ap_block_pp0_stage0_subdone <= (((icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (res_full_n = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1)) or ((ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (((select_ln75_1_reg_702 = ap_const_lv1_1) and (b_empty_n = ap_const_logic_0)) or ((icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_logic_0 = a_empty_n)))));
    end process;

        ap_block_state2_pp0_stage0_iter0 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state3_pp0_stage0_iter1_assign_proc : process(a_empty_n, b_empty_n, icmp_ln70_reg_711, select_ln75_1_reg_702)
    begin
                ap_block_state3_pp0_stage0_iter1 <= (((select_ln75_1_reg_702 = ap_const_lv1_1) and (b_empty_n = ap_const_logic_0)) or ((icmp_ln70_reg_711 = ap_const_lv1_1) and (ap_const_logic_0 = a_empty_n)));
    end process;

        ap_block_state4_pp0_stage0_iter2 <= not((ap_const_boolean_1 = ap_const_boolean_1));

    ap_block_state5_pp0_stage0_iter3_assign_proc : process(res_full_n, icmp_ln63_reg_685_pp0_iter2_reg)
    begin
                ap_block_state5_pp0_stage0_iter3 <= ((icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (res_full_n = ap_const_logic_0));
    end process;


    ap_condition_pp0_exit_iter0_state2_assign_proc : process(icmp_ln63_fu_168_p2)
    begin
        if ((icmp_ln63_fu_168_p2 = ap_const_lv1_1)) then 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_1;
        else 
            ap_condition_pp0_exit_iter0_state2 <= ap_const_logic_0;
        end if; 
    end process;


    ap_done_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            ap_done <= ap_const_logic_1;
        else 
            ap_done <= ap_const_logic_0;
        end if; 
    end process;

    ap_enable_pp0 <= (ap_idle_pp0 xor ap_const_logic_1);

    ap_idle_assign_proc : process(ap_start, ap_CS_fsm_state1)
    begin
        if (((ap_start = ap_const_logic_0) and (ap_const_logic_1 = ap_CS_fsm_state1))) then 
            ap_idle <= ap_const_logic_1;
        else 
            ap_idle <= ap_const_logic_0;
        end if; 
    end process;


    ap_idle_pp0_assign_proc : process(ap_enable_reg_pp0_iter1, ap_enable_reg_pp0_iter3, ap_enable_reg_pp0_iter0, ap_enable_reg_pp0_iter2)
    begin
        if (((ap_enable_reg_pp0_iter0 = ap_const_logic_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_0) and (ap_enable_reg_pp0_iter2 = ap_const_logic_0))) then 
            ap_idle_pp0 <= ap_const_logic_1;
        else 
            ap_idle_pp0 <= ap_const_logic_0;
        end if; 
    end process;


    ap_ready_assign_proc : process(ap_CS_fsm_state6)
    begin
        if ((ap_const_logic_1 = ap_CS_fsm_state6)) then 
            ap_ready <= ap_const_logic_1;
        else 
            ap_ready <= ap_const_logic_0;
        end if; 
    end process;


    b_blk_n_assign_proc : process(b_empty_n, ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, ap_block_pp0_stage0, select_ln75_1_reg_702)
    begin
        if (((select_ln75_1_reg_702 = ap_const_lv1_1) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            b_blk_n <= b_empty_n;
        else 
            b_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    b_copy_0_2_5_fu_412_p3 <= 
        b_copy_0_2_1_fu_88 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_0_2_fu_404_p3;
    b_copy_0_2_6_fu_419_p3 <= 
        b_copy_0_2_9_fu_301_p1 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_0_2_3_fu_84;
    b_copy_0_2_7_fu_427_p3 <= 
        b_copy_0_2_3_fu_84 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_0_2_6_fu_419_p3;
    b_copy_0_2_8_fu_434_p3 <= 
        b_copy_0_2_9_fu_301_p1 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_0_2_2_fu_80;
    b_copy_0_2_9_fu_301_p1 <= b_dout(8 - 1 downto 0);
    b_copy_0_2_fu_404_p3 <= 
        b_copy_0_2_1_fu_88 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_0_2_9_fu_301_p1;
    b_copy_1_2_5_fu_375_p3 <= 
        b_copy_1_2_1_fu_100 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_1_2_fu_367_p3;
    b_copy_1_2_6_fu_382_p3 <= 
        b_copy_1_2_9_fu_305_p4 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_1_2_3_fu_96;
    b_copy_1_2_7_fu_390_p3 <= 
        b_copy_1_2_3_fu_96 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_1_2_6_fu_382_p3;
    b_copy_1_2_8_fu_397_p3 <= 
        b_copy_1_2_9_fu_305_p4 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_1_2_2_fu_92;
    b_copy_1_2_9_fu_305_p4 <= b_dout(15 downto 8);
    b_copy_1_2_fu_367_p3 <= 
        b_copy_1_2_1_fu_100 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_1_2_9_fu_305_p4;
    b_copy_2_2_5_fu_338_p3 <= 
        b_copy_2_2_1_fu_112 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_2_2_fu_330_p3;
    b_copy_2_2_6_fu_345_p3 <= 
        b_copy_2_2_9_fu_315_p4 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_2_2_3_fu_108;
    b_copy_2_2_7_fu_353_p3 <= 
        b_copy_2_2_3_fu_108 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_2_2_6_fu_345_p3;
    b_copy_2_2_8_fu_360_p3 <= 
        b_copy_2_2_9_fu_315_p4 when (icmp_ln70_reg_711(0) = '1') else 
        b_copy_2_2_2_fu_104;
    b_copy_2_2_9_fu_315_p4 <= b_dout(23 downto 16);
    b_copy_2_2_fu_330_p3 <= 
        b_copy_2_2_1_fu_112 when (icmp_ln77_fu_325_p2(0) = '1') else 
        b_copy_2_2_9_fu_315_p4;

    b_read_assign_proc : process(ap_CS_fsm_pp0_stage0, ap_enable_reg_pp0_iter1, select_ln75_1_reg_702, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (select_ln75_1_reg_702 = ap_const_lv1_1) and (ap_enable_reg_pp0_iter1 = ap_const_logic_1) and (ap_const_logic_1 = ap_CS_fsm_pp0_stage0))) then 
            b_read <= ap_const_logic_1;
        else 
            b_read <= ap_const_logic_0;
        end if; 
    end process;

    grp_fu_588_p2 <= std_logic_vector(IEEE.numeric_std.resize(unsigned(std_logic_vector(signed(mul_ln82_1_fu_553_p0) * signed(mul_ln82_1_fu_553_p1))), 16));
    icmp_ln63_fu_168_p2 <= "1" when (indvar_flatten_reg_135 = ap_const_lv4_9) else "0";
    icmp_ln65_fu_180_p2 <= "1" when (j_0_reg_157 = ap_const_lv2_3) else "0";
    icmp_ln70_fu_228_p2 <= "1" when (select_ln75_fu_186_p3 = ap_const_lv2_0) else "0";
    icmp_ln75_1_fu_206_p2 <= "1" when (i_0_reg_146 = ap_const_lv2_0) else "0";
    icmp_ln75_fu_200_p2 <= "1" when (add_ln63_1_fu_194_p2 = ap_const_lv2_0) else "0";
    icmp_ln77_fu_325_p2 <= "1" when (select_ln75_reg_694 = ap_const_lv2_1) else "0";
    j_fu_234_p2 <= std_logic_vector(unsigned(select_ln75_fu_186_p3) + unsigned(ap_const_lv2_1));
    mul_ln82_1_fu_553_p0 <= a_row_1_1_fu_72;
    mul_ln82_1_fu_553_p1 <= tmp_2_fu_538_p5;

    res_blk_n_assign_proc : process(res_full_n, ap_block_pp0_stage0, ap_enable_reg_pp0_iter3, icmp_ln63_reg_685_pp0_iter2_reg)
    begin
        if (((icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (ap_const_boolean_0 = ap_block_pp0_stage0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1))) then 
            res_blk_n <= res_full_n;
        else 
            res_blk_n <= ap_const_logic_1;
        end if; 
    end process;

    res_din <= grp_fu_596_p3;

    res_write_assign_proc : process(ap_enable_reg_pp0_iter3, icmp_ln63_reg_685_pp0_iter2_reg, ap_block_pp0_stage0_11001)
    begin
        if (((ap_const_boolean_0 = ap_block_pp0_stage0_11001) and (icmp_ln63_reg_685_pp0_iter2_reg = ap_const_lv1_0) and (ap_enable_reg_pp0_iter3 = ap_const_logic_1))) then 
            res_write <= ap_const_logic_1;
        else 
            res_write <= ap_const_logic_0;
        end if; 
    end process;

    select_ln63_fu_220_p3 <= 
        add_ln63_1_fu_194_p2 when (icmp_ln65_fu_180_p2(0) = '1') else 
        i_0_reg_146;
    select_ln75_1_fu_212_p3 <= 
        icmp_ln75_fu_200_p2 when (icmp_ln65_fu_180_p2(0) = '1') else 
        icmp_ln75_1_fu_206_p2;
    select_ln75_fu_186_p3 <= 
        ap_const_lv2_0 when (icmp_ln65_fu_180_p2(0) = '1') else 
        j_0_reg_157;
end behav;
