module ID_EX (
    input   wire            clk         ,
    input   wire            rst_n       ,
    input   wire            stall       ,
    input   wire            flush       ,

    input   wire    [8:0]   ID_pc_4     ,
    input   wire    [31:0]  ID_inst     ,

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

    output  wire            EX_signext  ,
    output  wire            EX_aluop    ,
    output  wire            EX_alusrc   ,
    output  wire            EX_memread  ,
    output  wire            EX_memwrite ,
    output  wire            EX_memtoreg ,
    output  wire            EX_regread1 ,
    output  wire            EX_regread2 ,
    output  wire            EX_regwrite ,
    output  wire            EX_regdst   ,
    output  wire            EX_branch   ,
    output  wire            EX_branchne ,
    output  wire            EX_jump     ,
    output  wire            EX_jumpr    ,
    output  wire            EX_link     ,
    
    output  wire    [8:0]   EX_pc_4     ,
    output  wire    [31:0]  EX_inst      
);

parameter NOP = 8'h0000_0020;

reg [15+9+31:0] inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  0;
    end
    else begin
        if (flush) begin
            inner_reg   <=  {24'b0,9'b0,NOP};
        end
        else if (stall) begin
            inner_reg   <=  inner_reg;
        end
        else begin
            inner_reg   <=  {EX_signext  ,
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
        EX_pc_4     ,
        EX_inst     }   =   inner_reg;

endmodule