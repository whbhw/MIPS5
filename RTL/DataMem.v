`timescale  1ns / 1ps

module DATAMEM (
         clk,
         wen,
         Address,
         din,
         dout
       );
input clk, wen;
input [8: 0] Address;
input [31: 0] din;
output [31: 0] dout;
        
reg [31:0] RAM[0:512];  

assign dout = RAM[Address];  //read data

always @(posedge clk)begin
    if(wen)
        RAM[Address] <= din;    //write data
end

initial begin
    RAM[9'd0]   <=  32'h_3243f6a8;
    RAM[9'd1]   <=  32'h_885a308d;
    RAM[9'd2]   <=  32'h_313198a2;
    RAM[9'd3]   <=  32'h_e0370734;
    RAM[9'd4]   <=  32'h_2b7e1516;
    RAM[9'd5]   <=  32'h_28aed2a6;
    RAM[9'd6]   <=  32'h_abf71588;
    RAM[9'd7]   <=  32'h_09cf4f3c;
    RAM[9'd8]   <=  32'h_637c777b;
    RAM[9'd9]   <=  32'h_f26b6fc5;
    RAM[9'd10]  <=  32'h_3001672b;
    RAM[9'd11]  <=  32'h_fed7ab76;
    RAM[9'd12]  <=  32'h_ca82c97d;
    RAM[9'd13]  <=  32'h_fa5947f0;
    RAM[9'd14]  <=  32'h_add4a2af;
    RAM[9'd15]  <=  32'h_9ca472c0;
    RAM[9'd16]  <=  32'h_b7fd9326;
    RAM[9'd17]  <=  32'h_363ff7cc;
    RAM[9'd18]  <=  32'h_34a5e5f1;
    RAM[9'd19]  <=  32'h_71d83115;
    RAM[9'd20]  <=  32'h_04c723c3;
    RAM[9'd21]  <=  32'h_1896059a;
    RAM[9'd22]  <=  32'h_071280e2;
    RAM[9'd23]  <=  32'h_eb27b275;
    RAM[9'd24]  <=  32'h_09832c1a;
    RAM[9'd25]  <=  32'h_1b6e5aa0;
    RAM[9'd26]  <=  32'h_523bd6b3;
    RAM[9'd27]  <=  32'h_29e32f84;
    RAM[9'd28]  <=  32'h_53d100ed;
    RAM[9'd29]  <=  32'h_20fcb15b;
    RAM[9'd30]  <=  32'h_6acbbe39;
    RAM[9'd31]  <=  32'h_4a4c58cf;
    RAM[9'd32]  <=  32'h_d0efaafb;
    RAM[9'd33]  <=  32'h_434d3385;
    RAM[9'd34]  <=  32'h_45f9027f;
    RAM[9'd35]  <=  32'h_503c9fa8;
    RAM[9'd36]  <=  32'h_51a3408f;
    RAM[9'd37]  <=  32'h_929d38f5;
    RAM[9'd38]  <=  32'h_bcb6da21;
    RAM[9'd39]  <=  32'h_10fff3d2;
    RAM[9'd40]  <=  32'h_cd0c13ec;
    RAM[9'd41]  <=  32'h_5f974417;
    RAM[9'd42]  <=  32'h_c4a77e3d;
    RAM[9'd43]  <=  32'h_645d1973;
    RAM[9'd44]  <=  32'h_60814fdc;
    RAM[9'd45]  <=  32'h_222a9088;
    RAM[9'd46]  <=  32'h_46eeb814;
    RAM[9'd47]  <=  32'h_de5e0bdb;
    RAM[9'd48]  <=  32'h_e0323a0a;
    RAM[9'd49]  <=  32'h_4906245c;
    RAM[9'd50]  <=  32'h_c2d3ac62;
    RAM[9'd51]  <=  32'h_9195e479;
    RAM[9'd52]  <=  32'h_e7c8376d;
    RAM[9'd53]  <=  32'h_8dd54ea9;
    RAM[9'd54]  <=  32'h_6c56f4ea;
    RAM[9'd55]  <=  32'h_657aae08;
    RAM[9'd56]  <=  32'h_ba78252e;
    RAM[9'd57]  <=  32'h_1ca6b4c6;
    RAM[9'd58]  <=  32'h_e8dd741f;
    RAM[9'd59]  <=  32'h_4bbd8b8a;
    RAM[9'd60]  <=  32'h_703eb566;
    RAM[9'd61]  <=  32'h_4803f60e;
    RAM[9'd62]  <=  32'h_613557b9;
    RAM[9'd63]  <=  32'h_86c11d9e;
    RAM[9'd64]  <=  32'h_e1f89811;
    RAM[9'd65]  <=  32'h_69d98e94;
    RAM[9'd66]  <=  32'h_9b1e87e9;
    RAM[9'd67]  <=  32'h_ce5528df;
    RAM[9'd68]  <=  32'h_8ca1890d;
    RAM[9'd69]  <=  32'h_bfe64268;
    RAM[9'd70]  <=  32'h_41992d0f;
    RAM[9'd71]  <=  32'h_b054bb16;
    RAM[9'd72]  <=  32'h_01000000;
    RAM[9'd73]  <=  32'h_02000000;
    RAM[9'd74]  <=  32'h_04000000;
    RAM[9'd75]  <=  32'h_08000000;
    RAM[9'd76]  <=  32'h_10000000;
    RAM[9'd77]  <=  32'h_20000000;
    RAM[9'd78]  <=  32'h_40000000;
    RAM[9'd79]  <=  32'h_80000000;
    RAM[9'd80]  <=  32'h_1b000000;
    RAM[9'd81]  <=  32'h_36000000;
end


endmodule

