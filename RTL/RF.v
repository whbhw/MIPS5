module RF (
    input   wire    [4:0]   rd1addr ,
    output  wire    [31:0]  rd1data ,

    input   wire    [4:0]   rd2addr ,
    output  wire    [31:0]  rd2data ,

    input   wire    [4:0]   wraddr  ,
    input   wire    [31:0]  wrdata  ,
    input   wire            wren    ,

    input   wire            clk     ,
    input   wire            rst_n
);
    reg [31:0]  regfile [0:31];
    
    assign rd1data = (rd1addr == 5'd0) ? 32'h0 : regfile[rd1addr];
    assign rd2data = (rd2addr == 5'd0) ? 32'h0 : regfile[rd2addr];

    always @(posedge clk) begin
        if (wren && wraddr != 5'd0) begin
            regfile[wraddr] <= wrdata;
        end
    end
endmodule