`include "REGDEFAULT.vh"
module ID_EX (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,
    input   wire            flush       ,

    input   wire    [31:0]  ID_pc_4     ,
    input   wire    [31:0]  ID_inst     ,

    input   wire    [31:0]  ID_data1    ,
    input   wire    [31:0]  ID_data2    ,
    input   wire    [31:0]  ID_extend   ,

    input   wire            ID_signext  ,
    input   wire            ID_aluop    ,
    input   wire            ID_alusrc   ,
    input   wire            ID_memread  ,
    input   wire            ID_memwrite ,
    input   wire            ID_memtoreg ,
    input   wire            ID_regread1 ,
    input   wire            ID_regread2 ,    
    input   wire            ID_regwrite ,
    input   wire            ID_regdst   ,
    input   wire            ID_branch   ,
    input   wire            ID_branchne ,
    input   wire            ID_jump     ,
    input   wire            ID_jumpr    ,
    input   wire            ID_link     ,
    input   wire    [4:0]   ID_wraddr   ,

    output  wire            EX_signext  , //0
    output  wire    [1:0]   EX_aluop    , //10
    output  wire            EX_alusrc   , //1
    output  wire            EX_memread  , //0
    output  wire            EX_memwrite , //0
    output  wire            EX_memtoreg , //0
    output  wire            EX_regread1 , //1
    output  wire            EX_regread2 , //0
    output  wire            EX_regwrite , //1
    output  wire            EX_regdst   , //0
    output  wire            EX_branch   , //0
    output  wire            EX_branchne , //0
    output  wire            EX_jump     , //0
    output  wire            EX_jumpr    , //0
    output  wire            EX_link     , //0
    output  wire    [31:0]  EX_data1    , //
    output  wire    [31:0]  EX_data2    , //
    output  wire    [31:0]  EX_extend   , //
    output  wire    [4:0]   EX_wraddr   , //
    
    output  wire    [31:0]  EX_pc_4     ,
    output  wire    [31:0]  EX_inst      
);

parameter NOP = 32'h0000_0020; //addi R0 R0 0
parameter CTRL= 16'b0101000101000000;
//15+32+32+32+5+32+31
reg [179:0] inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {CTRL,NOP};
    end
    else begin
        if (flush) begin
            inner_reg   <=  {CTRL,96'b0,5'b0,ID_pc_4,NOP};
        end
        else if (stall) begin
            inner_reg   <=  inner_reg;
        end
        else begin
            inner_reg   <=  {ID_signext  ,
                             ID_aluop    ,
                             ID_alusrc   ,
                             ID_memread  ,
                             ID_memwrite ,
                             ID_memtoreg ,
                             ID_regread1 ,
                             ID_regread2 ,
                             ID_regwrite ,
                             ID_regdst   ,
                             ID_branch   ,
                             ID_branchne ,
                             ID_jump     ,
                             ID_jumpr    ,
                             ID_link     ,
                             ID_wraddr   ,

                             ID_data1    ,
                             ID_data2    ,
                             ID_extend   ,
                             ID_pc_4     ,
                             ID_inst     };
        end
    end
end

assign {EX_signext  ,
        EX_aluop    ,
        EX_alusrc   ,
        EX_memread  ,
        EX_memwrite ,
        EX_memtoreg ,
        EX_regread1 ,
        EX_regread2 ,
        EX_regwrite ,
        EX_regdst   ,
        EX_branch   ,
        EX_branchne ,
        EX_jump     ,
        EX_jumpr    ,
        EX_link     ,
        EX_wraddr   ,

        EX_data1    ,
        EX_data2    ,
        EX_extend   ,
        EX_pc_4     ,
        EX_inst       } =   inner_reg;

endmodule