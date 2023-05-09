`timescale 1ns / 1ps

module PE_tb();
     reg                      clk;
     reg                      rstn;
     reg                      en;
     reg signed [8:0]         a;
     reg signed [8:0]         b;
     reg signed [8:0]         w;
     
     wire                     valid;
     wire signed [8:0]        A;
     wire signed [8:0]        B;

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
        a = 9'd100;
        b = 9'd200;
        w = 9'd3;
        @(negedge clk);
        en = 1;
        forever begin
            @(negedge clk);
            a = (a > 9'h1FF) ? 'b0 : a+10;
            b = (b > 9'h1FF) ? 'b0 : b+10;
        end
    end
    
   initial #1000 $finish;

endmodule
