`timescale 1ns / 1ps
//
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/21 20:03:07
// Design Name: 
// Module Name: TEST_ReLu
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
//
 
 
module RelU_tb();
 
    reg clk;
    reg rst;
    reg signed[15:0] relu_in;
    reg en_in;
    wire en_out;
    wire signed[15:0] relu_out;
 
    ReLU relu(
        .clk(clk),
        .rst(rst),
        .relu_in(relu_in),
        .en_in(en_in),
        .en_out(en_out),
        .relu_out(relu_out)
    );
     
    initial begin
        clk = 1'b1;
        rst = 1'b1;
        #100
        rst = 1'b0;
    end
    
    always #5 clk=~clk;
    
    initial begin
        relu_in = 16'b0;     
        #100
         relu_in = 13;
        #10
         relu_in = -24;
        #10
         relu_in = 35;
        #10
         relu_in = -46;
        #10
          relu_in = 57;
        #10
          relu_in = -68;
        #10
         relu_in = -79;
         
    end
     
    initial
    begin
    en_in = 1'b0;
    #100
    en_in = 1'b1; 
    #70
    en_in = 1'b0; 
    end

    
endmodule