module MEM_WB (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,

    input   wire    [8:0]   MEM_pc_4    ,
    input   wire    [31:0]  MEM_inst    ,

    input   wire            MEM_memtoreg,
    input   wire            MEM_regwrite,
    input   wire            MEM_regdst  ,  
    input   wire            MEM_link    ,

    input   wire    [31:0]  MEM_data    ,
    input   wire    [8:0]   MEM_wraddr  ,

    output  wire            WB_memtoreg ,
    output  wire            WB_regwrite ,
    output  wire            WB_regdst   ,  
    output  wire            WB_link     ,
    output  wire    [31:0]  WB_data     ,
    output  wire    [8:0]   WB_wraddr   ,

    output  wire    [8:0]   WB_pc_4     ,
    output  wire    [31:0]  WB_inst
);
parameter NOP = 8'h0000_0020;

reg [4+32+9+9+31:0]  inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {'b0,NOP};
    end
    else begin
        inner_reg   <=  {MEM_memtoreg,
                         MEM_regwrite,
                         MEM_regdst  ,
                         MEM_link    ,
                         MEM_wraddr  ,
                         MEM_pc_4    ,
                         MEM_inst};
        end
end

assign  {WB_memtoreg ,
         WB_regwrite ,
         WB_regdst   ,
         WB_link     ,
         WB_wraddr   ,
         WB_pc_4     ,
         WB_inst}  =   inner_reg;


endmodule