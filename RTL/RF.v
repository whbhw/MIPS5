`define FLAGTEST

module RF (
    input   wire    [4:0]   rd1addr ,
    output  wire    [31:0]  rd1data ,

    input   wire    [4:0]   rd2addr ,
    output  wire    [31:0]  rd2data ,

`ifdef FLAGTEST
    input   wire    [4:0]   rdtaddr ,
    output  wire    [31:0]  rdtdata ,
`endif

    input   wire    [4:0]   wraddr  ,
    input   wire    [31:0]  wrdata  ,
    input   wire            wren    ,

    input   wire            clk     ,
    input   wire            rst_n   
);
    reg [31:0]  regfile [0:31];
    
    assign rd1data = (rd1addr == 5'd0) ? 32'h0 : regfile[rd1addr];
    assign rd2data = (rd2addr == 5'd0) ? 32'h0 : regfile[rd2addr];
`ifdef FLAGTEST
    assign rdtdata = (rdtaddr == 5'd0) ? 32'h0 : regfile[rdtaddr];
`endif

    always @(posedge clk, negedge rst_n) begin
    // always @(negedge clk, negedge rst_n) begin
        if (!rst_n) begin : rfrst
            integer i;
            for (i = 0; i < 32; i = i + 1) begin : rfrstgen
                regfile[i] <= 32'd0;
            end
        end else if (wren && wraddr != 5'd0) begin
            regfile[wraddr] <= wrdata;
        end
    end
endmodule