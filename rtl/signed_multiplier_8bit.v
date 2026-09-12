module signed_multiplier_8bit(
    input  [7:0] a,
    input  [7:0] b,
    output [15:0] product,
    output cout
);

//partial product generation
    wire [7:0]row[0:7];
    assign row[0] = {8{b[0]}}&a;
    assign row[1] = {8{b[1]}}&a;
    assign row[2] = {8{b[2]}}&a;
    assign row[3] = {8{b[3]}}&a;
    assign row[4] = {8{b[4]}}&a;
    assign row[5] = {8{b[5]}}&a;
    assign row[6] = {8{b[6]}}&a;
    assign row[7] = {8{b[7]}}&a;
//intermidiate wires
    wire [7:0]c[0:7];
    wire [7:0]s[0:7];
//first row of adders
    half_adder h0(row[0][1], row[1][0], s[0][0], c[0][0]);
    half_adder h1(row[0][2], row[1][1], s[0][1], c[0][1]);
    half_adder h2(row[0][3], row[1][2], s[0][2], c[0][2]);
    half_adder h3(row[0][4], row[1][3], s[0][3], c[0][3]);
    half_adder h4(row[0][5], row[1][4], s[0][4], c[0][4]); 
    half_adder h5(row[0][6], row[1][5], s[0][5], c[0][5]);
    half_adder h6(~row[0][7], row[1][6], s[0][6], c[0][6]);
    half_adder h7(1'b1, ~row[1][7], s[0][7], c[0][7]); 
    
//second row of adders
    full_adder f0(s[0][1], row[2][0], c[0][0], s[1][0], c[1][0]); 
    full_adder f1(s[0][2], row[2][1], c[0][1], s[1][1], c[1][1]); 
    full_adder f2(s[0][3], row[2][2], c[0][2], s[1][2], c[1][2]); 
    full_adder f3(s[0][4], row[2][3], c[0][3], s[1][3], c[1][3]); 
    full_adder f4(s[0][5], row[2][4], c[0][4], s[1][4], c[1][4]); 
    full_adder f5(s[0][6], row[2][5], c[0][5], s[1][5], c[1][5]); 
    full_adder f6(s[0][7], row[2][6], c[0][6], s[1][6], c[1][6]); 
    half_adder h8(c[0][7], ~row[2][7], s[1][7], c[1][7]); 
    
//third row of adders
    full_adder f7(s[1][1], row[3][0], c[1][0], s[2][0], c[2][0]); 
    full_adder f8(s[1][2], row[3][1], c[1][1], s[2][1], c[2][1]); 
    full_adder f9(s[1][3], row[3][2], c[1][2], s[2][2], c[2][2]); 
    full_adder f10(s[1][4], row[3][3], c[1][3], s[2][3], c[2][3]); 
    full_adder f11(s[1][5], row[3][4], c[1][4], s[2][4], c[2][4]); 
    full_adder f12(s[1][6], row[3][5], c[1][5], s[2][5], c[2][5]); 
    full_adder f13(s[1][7], row[3][6], c[1][6], s[2][6], c[2][6]); 
    half_adder h9(c[1][7], ~row[3][7], s[2][7], c[2][7]); 
    
//fourth row of adders
    full_adder f14(s[2][1], row[4][0], c[2][0], s[3][0], c[3][0]); 
    full_adder f15(s[2][2], row[4][1], c[2][1], s[3][1], c[3][1]); 
    full_adder f16(s[2][3], row[4][2], c[2][2], s[3][2], c[3][2]); 
    full_adder f17(s[2][4], row[4][3], c[2][3], s[3][3], c[3][3]); 
    full_adder f18(s[2][5], row[4][4], c[2][4], s[3][4], c[3][4]); 
    full_adder f19(s[2][6], row[4][5], c[2][5], s[3][5], c[3][5]); 
    full_adder f20(s[2][7], row[4][6], c[2][6], s[3][6], c[3][6]); 
    half_adder h10(c[2][7], ~row[4][7], s[3][7], c[3][7]);
    
//fifth row of adders
    full_adder f21(s[3][1], row[5][0], c[3][0], s[4][0], c[4][0]); 
    full_adder f22(s[3][2], row[5][1], c[3][1], s[4][1], c[4][1]); 
    full_adder f23(s[3][3], row[5][2], c[3][2], s[4][2], c[4][2]); 
    full_adder f24(s[3][4], row[5][3], c[3][3], s[4][3], c[4][3]); 
    full_adder f25(s[3][5], row[5][4], c[3][4], s[4][4], c[4][4]); 
    full_adder f26(s[3][6], row[5][5], c[3][5], s[4][5], c[4][5]); 
    full_adder f27(s[3][7], row[5][6], c[3][6], s[4][6], c[4][6]); 
    half_adder h11(c[3][7], ~row[5][7], s[4][7], c[4][7]);
    
//sixth row of adders
    full_adder f28(s[4][1], row[6][0], c[4][0], s[5][0], c[5][0]); 
    full_adder f29(s[4][2], row[6][1], c[4][1], s[5][1], c[5][1]); 
    full_adder f30(s[4][3], row[6][2], c[4][2], s[5][2], c[5][2]); 
    full_adder f31(s[4][4], row[6][3], c[4][3], s[5][3], c[5][3]); 
    full_adder f32(s[4][5], row[6][4], c[4][4], s[5][4], c[5][4]); 
    full_adder f33(s[4][6], row[6][5], c[4][5], s[5][5], c[5][5]); 
    full_adder f34(s[4][7], row[6][6], c[4][6], s[5][6], c[5][6]); 
    half_adder h12(c[4][7], ~row[6][7], s[5][7], c[5][7]);
    
//seventh row of adders
    full_adder f35(s[5][1], ~row[7][0], c[5][0], s[6][0], c[6][0]); 
    full_adder f36(s[5][2], ~row[7][1], c[5][1], s[6][1], c[6][1]); 
    full_adder f37(s[5][3], ~row[7][2], c[5][2], s[6][2], c[6][2]); 
    full_adder f38(s[5][4], ~row[7][3], c[5][3], s[6][3], c[6][3]); 
    full_adder f39(s[5][5], ~row[7][4], c[5][4], s[6][4], c[6][4]); 
    full_adder f40(s[5][6], ~row[7][5], c[5][5], s[6][5], c[6][5]); 
    full_adder f41(s[5][7], ~row[7][6], c[5][6], s[6][6], c[6][6]); 
    half_adder h13(c[5][7], row[7][7], s[6][7], c[6][7]);
    
//eighth row of adders
    half_adder h14(c[6][0], s[6][1], s[7][0], c[7][0]);
    full_adder f42(s[6][2], c[6][1], c[7][0], s[7][1], c[7][1]); 
    full_adder f43(s[6][3], c[6][2], c[7][1], s[7][2], c[7][2]); 
    full_adder f44(s[6][4], c[6][3], c[7][2], s[7][3], c[7][3]); 
    full_adder f45(s[6][5], c[6][4], c[7][3], s[7][4], c[7][4]); 
    full_adder f46(s[6][6], c[6][5], c[7][4], s[7][5], c[7][5]); 
    full_adder f47(s[6][7], c[6][6], c[7][5], s[7][6], c[7][6]); 
    full_adder f48(1'b1, c[6][7], c[7][6], s[7][7], c[7][7]);
    
    assign product ={s[7], s[6][0], s[5][0], s[4][0], s[3][0], s[2][0], s[1][0], s[0][0], row[0][0]}; 
    assign cout = c[7][7];
    
endmodule