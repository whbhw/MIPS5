module EX_MEM (
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire            stall           ,
    input   wire            flush           ,

    input   wire    [31:0]  EX_pc_4         ,
    input   wire    [31:0]  EX_inst         ,

    input   wire            EX_memread      , //0
    input   wire            EX_memwrite     , //0
    input   wire            EX_memtoreg     , //0
    input   wire            EX_regwrite     , //0 make it invalid here
    input   wire            EX_regdst       , //0
    input   wire            EX_link         , //0
    input   wire    [31:0]  EX_data         ,
    input   wire    [31:0]  EX_address      ,
    input   wire    [4:0]   EX_wraddr       ,

    output  wire            MEM_memread     ,
    output  wire            MEM_memwrite    ,
    output  wire            MEM_memtoreg    ,
    output  wire            MEM_regwrite    ,
    output  wire            MEM_regdst      ,
    output  wire            MEM_link        ,
    output  wire    [31:0]  MEM_data_in     ,
    output  wire    [31:0]  MEM_address_in  ,
    output  wire    [4:0]   MEM_wraddr      ,
    
    output  wire    [31:0]  MEM_pc_4        ,
    output  wire    [31:0]  MEM_inst      
);
parameter NOP = 32'h0000_0020;
parameter CTRL= 6'b0;
//6+32+32+5+32+32
reg [138:0]  inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {CTRL,64'b0,5'b0,EX_pc_4,NOP};
    end
    else begin
        if (flush) begin
            inner_reg   <=  {CTRL,64'b0,5'b0,EX_pc_4,NOP};
        end
        else if (stall) begin
            inner_reg   <=  inner_reg;
        end
        else begin
            inner_reg   <=  {EX_memread      ,
                             EX_memwrite     ,
                             EX_memtoreg     ,
                             EX_regwrite     ,
                             EX_regdst       ,
                             EX_link         ,

                             EX_data         ,
                             EX_address      ,
                             EX_wraddr       ,

                             EX_pc_4         ,
                             EX_inst};
        end
    end
end

assign  {MEM_memread     ,
         MEM_memwrite    ,
         MEM_memtoreg    ,
         MEM_regwrite    ,
         MEM_regdst      ,
         MEM_link        ,
         MEM_data_in     ,
         MEM_address_in  ,
         MEM_wraddr      ,
         MEM_pc_4        ,
         MEM_inst         }  =   inner_reg;

endmodule