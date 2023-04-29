
log_wave [get_objects -filter {type == in_port || type == out_port || type == inout_port || type == port} /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/*]
set designtopgroup [add_wave_group "Design Top Signals"]
set cinoutgroup [add_wave_group "C InOuts" -into $designtopgroup]
set accumulator_group [add_wave_group accumulator(memory) -into $cinoutgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/accumulator_q0 -into $accumulator_group -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/accumulator_d0 -into $accumulator_group -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/accumulator_we0 -into $accumulator_group -color #ffff00 -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/accumulator_ce0 -into $accumulator_group -color #ffff00 -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/accumulator_address0 -into $accumulator_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set vec_in_group [add_wave_group vec_in(memory) -into $cinputgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/vec_in_q0 -into $vec_in_group -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/vec_in_ce0 -into $vec_in_group -color #ffff00 -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/vec_in_address0 -into $vec_in_group -radix hex
set mat_in_group [add_wave_group mat_in(memory) -into $cinputgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/mat_in_q0 -into $mat_in_group -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/mat_in_ce0 -into $mat_in_group -color #ffff00 -radix hex
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/mat_in_address0 -into $mat_in_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_start -into $blocksiggroup
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_done -into $blocksiggroup
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_idle -into $blocksiggroup
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_ready -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_rst -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_mat_vec_multiply_top/AESL_inst_mat_vec_multiply/ap_clk -into $clockgroup
save_wave_config mat_vec_multiply.wcfg
run all
quit

