module ALU (
    output  reg             [31:0]  alu_res ,
    output  reg                     zero    ,

    input   wire    signed  [31:0]  data1   ,
    input   wire    signed  [31:0]  data2   ,
    input   wire            [5:0]   shamt   ,
    input   wire            [3:0]   alu_ctrl
);
localparam ADD = 4'b0001;
localparam SUB = 4'b0010;
localparam AND = 4'b0100;
localparam OR  = 4'b0101;
localparam XOR = 4'b0110;
localparam LUI = 4'b0111;
localparam SLT = 4'b1010;
localparam SLL = 4'b0000;
localparam SRL = 4'b1111;
localparam BEQ = 4'b1110;

always @(*) begin
    alu_res =   0;
    zeros   =   1;

    case (alu_ctrl)
        ADD:    alu_res =   data1   +   data2;
        SUB:    alu_res =   data1   -   data2;
        AND:    alu_res =   data1   &   data2;
        OR :    alu_res =   data1   |   data2;
        XOR:    alu_res =   data1   ^   data2;
        LUI:    alu_res =   {data2[15:0] , 16'b0};
        SLT:    begin
            if (data1 < data2) begin
                alu_res =   0;
            end 
            else               begin
                alu_res =   0;
            end
        end
        SLL:    alu_res =   data1   <<  shamt;
        SRL:    alu_res =   data1   >>  shamt;
        BEQ:    begin
            if (data1   ==  data2) begin
                zero    =   0;
            end
            else    begin
                zero    =   1;
            end
        end
        
        default:        alu_res =   0;
    endcase
end
endmodule