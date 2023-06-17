module IF_ID (
    input   wire            clk     ,
    input   wire            rst_n   ,
    input   wire            stall   ,
    input   wire            flush   ,

    input   wire    [31:0]  IF_pc_4 ,
    input   wire    [31:0]  IF_inst,
    
    output  wire    [31:0]  ID_pc_4 ,
    output  wire    [31:0]  ID_inst      
);
parameter NOP = 32'h0000_0020;

reg [61:0]  inner_reg;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        inner_reg   <=  {32'b0,NOP};
    end
    else    begin
        if (flush) begin
            inner_reg   <=  {IF_pc_4,NOP};
        end
        else if (stall) begin
            inner_reg   <=  inner_reg;
        end
        else begin
            inner_reg   <=  {IF_pc_4,IF_inst};
        end
    end
end

assign  ID_pc_4 =   inner_reg[61:32]  ;
assign  ID_inst =   inner_reg[31:0]   ;


endmodule