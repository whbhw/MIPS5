module CTRL (
    output  wire            signext ,   // 符号扩展(1符号,0无符号)

    output  wire    [1:0]   aluop   ,   // alu初步控制编码
    output  wire            alusrc  ,   // alu输入来源选择

    output  wire            memread ,   // 数据内存读取控制
    output  wire            memwrite,   // 数据内存写入控制
    output  wire            memtoreg,   // 数据寄存器写入来源选择

    output  wire            regwrite,   // 数据寄存器写入控制
    output  wire            regdst  ,   // 数据寄存器写入地址来源选择

    output  wire            branch  ,   // 分支指令标志
    output  wire            branchne,   // bne(1)/beq(0)标志,前提branch有效
    output  wire            jump    ,   // 跳转指令标志
    output  wire            jumpr   ,   // jr标志,前提jump有效
    output  wire            link    ,   // jal标志,前提jump有效

    input   wire    [5:0]   opcode  ,   // 指令opcode部分输入
    input   wire    [5:0]   funct       // 指令funct部分输入
);

localparam [5:0]    opcode_lw   =   6'h23;
localparam [5:0]    opcode_sw   =   6'h2b;
localparam [5:0]    opcode_beq  =   6'h04;
localparam [5:0]    opcode_bne  =   6'h05;
localparam [5:0]    opcode_j    =   6'h02;
localparam [5:0]    opcode_jal  =   6'h03;
localparam [5:0]    opcode_rjr  =   6'h00;
localparam [5:0]    opcode_i    =   6'b001xxx;

// I型计算指令均为001开头
localparam [5:0]    opcode_i_addi   =   6'h08;
localparam [5:0]    opcode_i_addiu  =   6'h09;
localparam [5:0]    opcode_i_andi   =   6'h0c;
localparam [5:0]    opcode_i_ori    =   6'h0d;
localparam [5:0]    opcode_i_xori   =   6'h0e;
localparam [5:0]    opcode_i_lui    =   6'h0f;

wire [13:0] ctrlsignals;
assign {
    signext     ,aluop      ,alusrc     ,memread    ,
    memwrite    ,memtoreg   ,regwrite   ,regdst     ,branch     ,
    branchne    ,jump       ,jumpr      ,link       }
    = ctrlsignals;

always @(*) begin
    ctrlsignals = 14'b0;
    if (opcode[5:3] == opcode_i[5:3]) begin
        // I型计算指令
    end
end


endmodule