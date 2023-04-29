`timescale 1ns / 1ps
//
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/21 19:47:37
// Design Name: 
// Module Name: ReLu
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
 
 
    module ReLU(
        input clk,
        input rst,
        input signed[15:0] relu_in,
        input en_in,
        output reg en_out,
        output reg signed[15:0] relu_out
    );
     
     
        always @(posedge clk or posedge rst)
        begin
             if(rst)
             begin
             en_out <= 1'b0;
             relu_out   <= 16'b0;
             end
        else begin
            en_out <= en_in;
            
            if(relu_in[15] == 0)
            begin
               relu_out <= relu_in;
            end
            else 
                relu_out <= 16'b0;  
            end   
        end
    endmodule
