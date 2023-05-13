`timescale 1ns / 1ps

module NTT_8p_radix2_tp();
    reg               clk;
    reg               rstn;
    reg               en;
    
    reg signed [8:0]  in0;
    reg signed [8:0]  in1;
    reg signed [8:0]  in2;
    reg signed [8:0]  in3;
    reg signed [8:0]  in4;
    reg signed [8:0]  in5;
    reg signed [8:0]  in6;
    reg signed [8:0]  in7;
    
    wire              valid;
    wire signed [8:0] out0;
    wire signed [8:0] out1;
    wire signed [8:0] out2;
    wire signed [8:0] out3;
    wire signed [8:0] out4;
    wire signed [8:0] out5;
    wire signed [8:0] out6;
    wire signed [8:0] out7;
    
    initial begin
        clk = 0; //50MHz
        rstn = 0 ;
        #10 rstn = 1;
        forever begin
            #10 clk = ~clk; //50MHz
        end
    end

    NTT_8p_radix2 ntt_inst(
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .in0(in0),
        .in1(in1),
        .in2(in2),
        .in3(in3),
        .in4(in4),
        .in5(in5),
        .in6(in6),
        .in7(in7),
        .valid(valid),
        .out0(out0),
        .out1(out1),
        .out2(out2),
        .out3(out3),
        .out4(out4),
        .out5(out5),
        .out6(out6),
        .out7(out7));
        
    // data input
    initial begin
        en = 0;
        in0 = 9'd10;  
        in1 = 9'd20;
        in2 = 9'd30;
        in3 = 9'd40;
        in4 = 9'd50;
        in5 = 9'd60;
        in6 = 9'd70;
        in7 = 9'd80;
        @(negedge clk);
        en = 1;
        forever begin
            @(negedge clk);
            in0 = (in0 > 9'h1FF) ? 9'b0 : in0 + 15;
            in1 = (in1 > 9'h1FF) ? 9'b0 : in1 + 15;
            in2 = (in2 > 9'h1FF) ? 9'b0 : in2 + 15;
            in3 = (in3 > 9'h1FF) ? 9'b0 : in3 + 15;
            in4 = (in4 > 9'h1FF) ? 9'b0 : in4 + 15;
            in5 = (in5 > 9'h1FF) ? 9'b0 : in5 + 15;
            in6 = (in6 > 9'h1FF) ? 9'b0 : in6 + 15;
            in7 = (in7 > 9'h1FF) ? 9'b0 : in7 + 15;
        end
    end
    
   initial #1000 $finish;


endmodule
