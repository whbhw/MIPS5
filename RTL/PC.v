`include "REGDEFAULT.vh"
module PC (
    output  wire    [31:0]  pc      ,
    output  wire    [31:0]  pc_4    ,
    input   wire    [31:0]  pc_next ,

    input   wire            clk     ,
    input   wire            rst_n
);
    reg [31:0]  pc_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_reg  <=  `DEFAULT_PC;
        end
        else begin
            pc_reg  <=  pc_next;
        end 
    end

    assign  pc      =   pc_reg;
    assign  pc_4    =   pc_reg  +   4;

endmodule