module ALU (
    output  wire    [31:0]  alu_res ,
    output  wire    [31:0]  zero    ,

    input   wire    [31:0]  data1   ,
    input   wire    [31:0]  data2   ,
    input   wire    [5:0]   shamt   ,
    input   wire    [3:0]   alu_ctrl
);
parameter ADD = 4'b0001;
parameter SUB = 4'b0010;
parameter AND = 4'b0011;
parameter OR  = 4'b0100;
parameter XOR = 4'b0101;
parameter LUI = 4'b0110;
parameter SLT = 4'b0111;
parameter SLL = 4'b1000;
parameter SRL = 4'b1001;

always @(*) begin
    alu_res =   0;

    case (alu_ctrl)
        ADD:    alu_res =   data1   +   data2;
        SUB:    alu_res =   data1   -   data2;
        AND:    alu_res =   data1   &   data2;
        OR :    alu_res =   data1   |   data2;
        XOR:    alu_res =   data1   ^   data2;
        LUI:    alu_res =   {data2{15:0} , 16'b0};
        SLT:    begin
            if (data1 < data2) begin
                alu_res =   1;
            end 
            else               begin
                alu_res =   0;
            end
        end
        SLL:    alu_res =   data1   <<  shamt;
        SRL:    alu_res =   data1   >>  shamt;
        
        default:        alu_res =   0;
    endcase
end
endmodule