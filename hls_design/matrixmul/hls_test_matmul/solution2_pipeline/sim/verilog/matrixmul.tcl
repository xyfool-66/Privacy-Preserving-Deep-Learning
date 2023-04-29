
log_wave [get_objects -filter {type == in_port || type == out_port || type == inout_port || type == port} /apatb_matrixmul_top/AESL_inst_matrixmul/*]
set designtopgroup [add_wave_group "Design Top Signals"]
set coutputgroup [add_wave_group "C Outputs" -into $designtopgroup]
set res_group [add_wave_group res(fifo) -into $coutputgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/res_write -into $res_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/res_full_n -into $res_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/res_din -into $res_group -radix hex
set cinputgroup [add_wave_group "C Inputs" -into $designtopgroup]
set b_group [add_wave_group b(fifo) -into $cinputgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/b_read -into $b_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/b_empty_n -into $b_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/b_dout -into $b_group -radix hex
set a_group [add_wave_group a(fifo) -into $cinputgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/a_read -into $a_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/a_empty_n -into $a_group -color #ffff00 -radix hex
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/a_dout -into $a_group -radix hex
set blocksiggroup [add_wave_group "Block-level IO Handshake" -into $designtopgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_start -into $blocksiggroup
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_done -into $blocksiggroup
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_idle -into $blocksiggroup
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_ready -into $blocksiggroup
set resetgroup [add_wave_group "Reset" -into $designtopgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_rst -into $resetgroup
set clockgroup [add_wave_group "Clock" -into $designtopgroup]
add_wave /apatb_matrixmul_top/AESL_inst_matrixmul/ap_clk -into $clockgroup
save_wave_config matrixmul.wcfg
run all
quit

