`timescale 1ns / 1ps

module NTT_8p_radix2(
    input               clk,
    input               rstn,
    input               en,
    
    input signed [8:0]  in0,
    input signed [8:0]  in1,
    input signed [8:0]  in2,
    input signed [8:0]  in3,
    input signed [8:0]  in4,
    input signed [8:0]  in5,
    input signed [8:0]  in6,
    input signed [8:0]  in7,
    
    output              valid,
    output wire signed [8:0] out0,
    output wire signed [8:0] out1,
    output wire signed [8:0] out2,
    output wire signed [8:0] out3,
    output wire signed [8:0] out4,
    output wire signed [8:0] out5,
    output wire signed [8:0] out6,
    output wire signed [8:0] out7
    );

    // temp data
    wire signed [8:0]   inm[3:0][7:0]; // 3 layer (4 data column)  8 point
    wire                en_connect[15:0];
    assign               en_connect[0] = en;
    assign               en_connect[1] = en;
    assign               en_connect[2] = en;
    assign               en_connect[3] = en;
        
    // primary root (pr)
    wire signed [8:0]   pr[3:0];
    assign pr[0]        =9'd1;
    assign pr[1]        =9'd4;
    assign pr[2]        =9'd16;
    assign pr[3]        =9'd64;
    
    // rev-bit 
    assign inm[0][0] = in0;
    assign inm[0][1] = in4;
    assign inm[0][2] = in2;
    assign inm[0][3] = in6;
    assign inm[0][4] = in1;
    assign inm[0][5] = in5;
    assign inm[0][6] = in3;
    assign inm[0][7] = in7;

     
    // ---------------- layer 1 pe(layer)(unit) ------------------//
    PE pe00(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[0]),  // layer * 4 + unit
        .b(inm[0][0]),  
        .a(inm[0][1]),  
        .w(pr[0]),  
        .valid(en_connect[4]),  // (layer + 1) * 4 + unit
        .A(inm[1][0]),  
        .B(inm[1][1]));

    PE pe01(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[1]),  // layer * 4 + unit
        .b(inm[0][2]),  
        .a(inm[0][3]),  
        .w(pr[0]),  
        .valid(en_connect[5]),  // (layer + 1) * 4 + unit
        .A(inm[1][2]),  
        .B(inm[1][3]));

    PE pe02(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[2]),  // layer * 4 + unit
        .b(inm[0][4]),  
        .a(inm[0][5]),  
        .w(pr[0]),  
        .valid(en_connect[6]),  // (layer + 1) * 4 + unit
        .A(inm[1][4]),  
        .B(inm[1][5]));

    PE pe03(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[3]),  // layer * 4 + unit
        .b(inm[0][6]),  
        .a(inm[0][7]),  
        .w(pr[0]),  
        .valid(en_connect[7]),  // (layer + 1) * 4 + unit
        .A(inm[1][6]),  
        .B(inm[1][7]));
    
    // ---------------- layer 2 pe(layer)(unit) ------------------//
    PE pe10(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[4]),  // layer * 4 + unit
        .b(inm[1][0]),  
        .a(inm[1][2]),  
        .w(pr[0]),  
        .valid(en_connect[8]),  // (layer + 1) * 4 + unit
        .A(inm[2][0]),  
        .B(inm[2][2]));

    PE pe11(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[5]),  // layer * 4 + unit
        .b(inm[1][1]),  
        .a(inm[1][3]),  
        .w(pr[2]),  
        .valid(en_connect[9]),  // (layer + 1) * 4 + unit
        .A(inm[2][1]),  
        .B(inm[2][3]));

    PE pe12(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[6]),  // layer * 4 + unit
        .b(inm[1][4]),  
        .a(inm[1][6]),  
        .w(pr[0]),  
        .valid(en_connect[10]),  // (layer + 1) * 4 + unit
        .A(inm[2][4]),  
        .B(inm[2][6]));

    PE pe13(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[7]),  // layer * 4 + unit
        .b(inm[1][5]),  
        .a(inm[1][7]),  
        .w(pr[2]),  
        .valid(en_connect[11]),  // (layer + 1) * 4 + unit
        .A(inm[2][5]),  
        .B(inm[2][7]));
        
    // ---------------- layer 3 pe(layer)(unit) ------------------//
    PE pe20(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[8]),  // layer * 4 + unit
        .b(inm[2][0]),  
        .a(inm[2][4]),  
        .w(pr[0]),  
        .valid(en_connect[12]),  // (layer + 1) * 4 + unit
        .A(inm[3][0]),  
        .B(inm[3][4]));

    PE pe21(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[9]),  // layer * 4 + unit
        .b(inm[2][1]),  
        .a(inm[2][5]),  
        .w(pr[1]),  
        .valid(en_connect[13]),  // (layer + 1) * 4 + unit
        .A(inm[3][1]),  
        .B(inm[3][5]));

    PE pe22(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[10]),  // layer * 4 + unit
        .b(inm[2][2]),  
        .a(inm[2][6]),  
        .w(pr[2]),  
        .valid(en_connect[14]),  // (layer + 1) * 4 + unit
        .A(inm[3][2]),  
        .B(inm[3][6]));

    PE pe23(    
        .clk(clk),        
        .rstn(rstn),
        .en(en_connect[11]),  // layer * 4 + unit
        .b(inm[2][3]),  
        .a(inm[2][7]),  
        .w(pr[3]),  
        .valid(en_connect[15]),  // (layer + 1) * 4 + unit
        .A(inm[3][3]),  
        .B(inm[3][7]));
    
    assign valid = en_connect[12];  // or 13 14 15
    assign out0 = inm[3][0]; 
    assign out1 = inm[3][1]; 
    assign out2 = inm[3][2]; 
    assign out3 = inm[3][3]; 
    assign out4 = inm[3][4]; 
    assign out5 = inm[3][5]; 
    assign out6 = inm[3][6]; 
    assign out7 = inm[3][7]; 
    
endmodule
