############################################################
## This file is generated automatically by Vivado HLS.
## Please DO NOT edit it.
## Copyright (C) 1986-2020 Xilinx, Inc. All Rights Reserved.
############################################################
open_project hls_test_matmul
set_top matrixmul
add_files matrixmul.cpp
add_files -tb matrixmul_test.cpp
open_solution "solution2_pipeline"
set_part {xc7vx485tffg1157-1}
create_clock -period 10 -name default
source "./hls_test_matmul/solution2_pipeline/directives.tcl"
csim_design
csynth_design
cosim_design -trace_level port -tool xsim
export_design -format ip_catalog
