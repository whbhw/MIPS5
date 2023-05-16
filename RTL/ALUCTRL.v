module ALUCTRL (
    output  reg     [3:0]   alu_ctrl,

    input   wire    [1:0]   aluop   ,
    input   wire    [5:0]   funct   
);

always @(*) begin
    alu_ctrl    =   4'b0001; //默认进行加法
    case (aluop)
        2'b00:  alu_ctrl    =   4'b0001;
        2'b01:  alu_ctrl    =   4'b0010;
        2'b10:  //R(I)指令的分类
        begin
            case (funct)
                6'b100000:  alu_ctrl    =   4'b0001;
                6'b100001:  alu_ctrl    =   funct[3:0];
                6'b100010:  alu_ctrl    =   funct[3:0];
                6'b100100:  alu_ctrl    =   funct[3:0];
                6'b100101:  alu_ctrl    =   funct[3:0];
                6'b100110:  alu_ctrl    =   funct[3:0];
                6'b100111:  alu_ctrl    =   funct[3:0];
                6'b101010:  alu_ctrl    =   funct[3:0];
                6'b000000:  alu_ctrl    =   funct[3:0];
                6'b000010:  alu_ctrl    =   4'b1111;
                default:    alu_ctrl    =   4'b0001;
            endcase    
        end
        default: alu_ctrl   =   4'b0001;
    endcase
end

endmodule