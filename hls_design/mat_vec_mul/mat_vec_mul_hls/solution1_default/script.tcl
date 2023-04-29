############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project mat_vec_mul_hls
set_top mat_vec_multiply
add_files mat_vec_mul.cpp
add_files -tb mat_vec_mul_tb.cpp
open_solution "solution1_default"
set_part {xc7vx485tffg1157-1}
create_clock -period 10 -name default
#source "./mat_vec_mul_hls/solution1_default/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level port -tool xsim
export_design -format ip_catalog
