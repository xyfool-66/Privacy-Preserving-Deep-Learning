
set PATH=
call E:/Vivado2020/Vivado/2020.1/bin/xelab xil_defaultlib.apatb_mat_vec_multiply_top glbl -prj mat_vec_multiply.prj -L smartconnect_v1_0 -L axi_protocol_checker_v1_1_12 -L axi_protocol_checker_v1_1_13 -L axis_protocol_checker_v1_1_11 -L axis_protocol_checker_v1_1_12 -L xil_defaultlib -L unisims_ver -L xpm --initfile "E:/Vivado2020/Vivado/2020.1/data/xsim/ip/xsim_ip.ini" --lib "ieee_proposed=./ieee_proposed" -s mat_vec_multiply -debug wave
call E:/Vivado2020/Vivado/2020.1/bin/xsim --noieeewarnings mat_vec_multiply -tclbatch mat_vec_multiply.tcl

