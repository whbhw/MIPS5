module PC (
    output  wire    [31:0]  pc      ,
    input   wire    [31:0]  pc_next ,

    input   wire            clk     ,
    input   wire            rst_n
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc  <=  0;
        end
        else begin
            pc  <=  pc_next;
        end 
    end

endmodule