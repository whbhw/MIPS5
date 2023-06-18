`include "REGDEFAULT.vh"
module MEM_WB (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,   // 无效

    input   wire    [31:0]  MEM_pc_4    ,
    input   wire    [31:0]  MEM_inst    ,

    input   wire            MEM_memtoreg,
    input   wire            MEM_regwrite,
    input   wire            MEM_regdst  ,  
    input   wire            MEM_link    ,

    input   wire    [31:0]  MEM_data    ,
    input   wire    [4:0]   MEM_wraddr  ,

    output  wire            WB_memtoreg ,   // 0
    output  wire            WB_regwrite ,   // 0 (add->1)
    output  wire            WB_regdst   ,   // 1
    output  wire            WB_link     ,   // 0
    output  wire    [31:0]  WB_data     ,
    output  wire    [4:0]   WB_wraddr   ,

    output  wire    [31:0]  WB_pc_4     ,
    output  wire    [31:0]  WB_inst
);
parameter NOP = `NOP_INST;
parameter CTRL= `NOP_WB_CTRL;
// 4+32+5+32+32-1
reg [104:0]  inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {CTRL,32'b0,5'b0,`DEFAULT_PC_4,NOP};
    end
    else begin
        inner_reg   <=  {MEM_memtoreg,
                         MEM_regwrite,
                         MEM_regdst  ,
                         MEM_link    ,
                         MEM_data    ,
                         MEM_wraddr  ,   
                         MEM_pc_4    ,
                         MEM_inst     };
    end
end

assign  {WB_memtoreg,
         WB_regwrite,
         WB_regdst  ,
         WB_link    ,
         WB_data    ,
         WB_wraddr  ,
         WB_pc_4    ,
         WB_inst     }  =   inner_reg;


endmodule