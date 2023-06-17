module EX_MEM (
    input   wire            clk             ,
    input   wire            rst_n           ,
    input   wire            stall           ,
    input   wire            flush           ,

    input   wire    [8:0]   EX_pc_4         ,
    input   wire    [31:0]  EX_inst         ,

    input   wire            EX_memread      ,
    input   wire            EX_memwrite     ,
    input   wire            EX_memtoreg     ,
    input   wire            EX_regwrite     ,
    input   wire            EX_regdst       ,
    input   wire            EX_link         ,
    input   wire    [31:0]  EX_data         ,
    input   wire    [8:0]   EX_address      ,
    input   wire    [8:0]   EX_wraddr       ,

    output  wire            MEM_memread     ,
    output  wire            MEM_memwrite    ,
    output  wire            MEM_memtoreg    ,
    output  wire            MEM_regwrite    ,
    output  wire            MEM_regdst      ,
    output  wire            MEM_link        ,
    output  wire    [31:0]  MEM_data_in     ,
    output  wire    [31:0]  MEM_address_in  ,
    output  wire    [8:0]   MEM_wraddr      ,
    
    output  wire    [8:0]   MEM_pc_4        ,
    output  wire    [31:0]  MEM_inst      
);
parameter NOP = 8'h0000_0020;

reg [6+32+32+9+9+31:0]  inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {15'b0,NOP};
    end
    else begin
        if (flush) begin
            inner_reg   <=  {(6+32+32+9+9)'b0,NOP};
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
         MEM_wraddr      ,
         MEM_pc_4        ,
         MEM_inst}  =   inner_reg;

endmodule