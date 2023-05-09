`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/08 16:05:47
// Design Name: 
// Module Name: PE_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PE_tb();
     reg                       clk;
     reg                       rstn;
     reg                       en;
     reg signed [16:0]         a;
     reg signed [16:0]         b;
     reg signed [16:0]         w;
     
     wire                      valid;
     wire signed [17:0]        A;
     wire signed [17:0]        B;

    initial begin
        clk = 0; //50MHz
        rstn = 0 ;
        #10 rstn = 1;
        forever begin
            #10 clk = ~clk; //50MHz
        end
    end
    
    PE pe_inst(
        .clk(clk),
        .rstn(rstn),
        .en(en),
        .a(a),
        .b(b),
        .w(w),
        .valid(valid),
        .A(A),
        .B(B));
    
    // data input
    initial begin
        en = 0;
        a = 17'd50000;
        b = 17'd60000;
        w = 17'd3;
        @(negedge clk);
        en = 1;
        forever begin
            @(negedge clk);
            a = (a > 17'h1FFFF) ? 'b0 : a+10;
            b = (b > 17'h1FFFF) ? 'b0 : b+10;
        end
    end
    
   initial #1000 $finish;

endmodule
