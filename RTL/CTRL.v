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
    
    // I型计算指令均为001开头
    localparam [5:0]    opcode_lw       =   6'h23;
    localparam [5:0]    opcode_sw       =   6'h2b;
    localparam [5:0]    opcode_beq      =   6'h04;
    localparam [5:0]    opcode_bne      =   6'h05;
    localparam [5:0]    opcode_j        =   6'h02;
    localparam [5:0]    opcode_jal      =   6'h03;
    localparam [5:0]    opcode_rjr      =   6'h00;
    localparam [5:0]    opcode_i        =   6'b001xxx;
    
    localparam [5:0]    opcode_i_addi   =   6'h08;
    localparam [5:0]    opcode_i_addiu  =   6'h09;
    localparam [5:0]    opcode_i_andi   =   6'h0c;
    localparam [5:0]    opcode_i_ori    =   6'h0d;
    localparam [5:0]    opcode_i_xori   =   6'h0e;
    localparam [5:0]    opcode_i_lui    =   6'h0f;
    
    localparam [5:0]    funct_jr        =   6'h08;
    
    reg [13:0] ctrlsignals;
    assign {
        signext     ,aluop      ,alusrc     ,memread    ,
        memwrite    ,memtoreg   ,regwrite   ,regdst     ,branch     ,
        branchne    ,jump       ,jumpr      ,link       }
        = ctrlsignals;
    
    always @(*) begin
        ctrlsignals = 14'b0;
        casex (opcode)
            opcode_lw   :   ctrlsignals = 14'b_1_00_1_1_0_1_1_0_0_X_0_X_0;
            opcode_sw   :   ctrlsignals = 14'b_1_00_1_0_1_X_0_X_0_X_0_X_X;
            opcode_beq  :   ctrlsignals = 14'b_1_01_0_0_0_X_0_X_1_0_0_X_0;
            opcode_bne  :   ctrlsignals = 14'b_1_01_0_0_0_X_0_X_1_1_0_X_0;
            opcode_j    :   ctrlsignals = 14'b_X_11_0_0_0_X_0_X_0_X_1_0_0;
            opcode_jal  :   ctrlsignals = 14'b_X_11_0_0_0_X_1_X_0_X_1_0_1;
    
            opcode_rjr  :   begin
                // 区分R型计算指令和jr指令，jr是将跳转后的指令存在reg中以便返回到正确位置继续执行
                if (funct == funct_jr) begin
                    // jr指令
                    ctrlsignals = 14'b_X_11_0_0_0_X_0_X_0_X_1_1_0;
                end else begin
                    // R型计算指令
                    ctrlsignals = 14'b_X_10_0_0_0_0_1_1_0_X_0_X_0;
                end
            end
    
            opcode_i    : begin
                // I型计算指令
                ctrlsignals = {~opcode[2],13'b_10_1_0_0_0_1_0_0_X_0_X_0};
            end
    
            default: 
                ctrlsignals = 14'b0;
        endcase
    end

endmodule