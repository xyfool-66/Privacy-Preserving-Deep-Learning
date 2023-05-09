`timescale 1ns / 1ps
/*
b -----------------------> A
       -        ->
         -    -
           -
         -   -
       -       ->
a -----------------------> B
      w          -1
*/
// p = 2^16+1 = 65537

module PE(
     input                       clk,
     input                       rstn,
     input                       en,
     input signed [16:0]         a,
     input signed [16:0]         b,
     input signed [16:0]         w,
     
     output                      valid,
     output signed [17:0]        A,
     output signed [17:0]        B
     );
     
    reg [4:0]                    en_r ;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            en_r   <= 'b0 ;
        end
        else begin
            en_r   <= {en_r[3:0], en} ;
        end
    end
    
    // Stage1: a*w
    reg signed [33:0]   a_w_expand;
    reg signed [17:0]   b_temp1;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            a_w_expand <= 0;
        end
        else if (en_r[0]) begin
            a_w_expand <=   a*w;
            b_temp1 <=      b;
        end
    end
    wire [17:0]     a_w_expand_lb;
    wire [17:0]     a_w_expand_hb;
    wire [17:0]     a_w_mod;

    assign a_w_expand_lb =  {2'b0, a_w_expand[15:0]};
    assign a_w_expand_hb =  a_w_expand[33:16];
    assign a_w_mod =        a_w_expand_lb - a_w_expand_hb;
    
    // Stage2: a_w = mod(a_w_expand)
    reg signed [16:0] a_w;
    reg signed [17:0]   b_temp2;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            a_w <= 0;
        end
        else if (en_r[1]) begin
            a_w <=      a_w_mod[16:0];
            b_temp2 <=  b_temp1;
        end
    end
    
    // Stage3:
    reg signed [16:0] A_r;
    reg signed [16:0] B_r;
    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
             A_r <= 0;
             B_r <= 0;
        end
        else if (en_r[2]) begin
            A_r <= b_temp2 + a_w;
            B_r <= b_temp2 - a_w;
        end
    end
    
    assign A        = A_r;
    assign B        = B_r;
    assign valid    = en_r[3];
    
endmodule
