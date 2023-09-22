module EXTEND (
    output  wire    [31:0]  extend_out  ,
    input   wire    [15:0]  extend_in   ,
    input   wire            signext     
);
    assign extend_out[15:0] = extend_in;
    assign extend_out[31:16] = signext ? {16{extend_in[15]}} : 16'b0;
endmodule