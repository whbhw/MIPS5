module HZDPU (
    output  reg     [1:0]   pcop        ,
    output  reg     [2:0]   flush       ,
    output  reg             stall       ,

    input   wire            ID_jnjr     ,
    input   wire            EX_bjjr     ,
    input   wire            hzdlu       
);
    always @(*) begin
        // default: no Hazard
        pcop = 2'd0;
        flush = 3'b000;
        stall = 1'b0;
        if (hzdlu) begin
            // load-use Hazard
            pcop = 2'd3;
            flush = 3'b100;
            stall = 1'b1;
        end else if (EX_bjjr) begin
            // branch(taken) or jr Control Hazard
            pcop = 2'd2;
            flush = 3'b011;
            stall = 1'b0;
        end else if (ID_jnjr) begin
            // jump(except jr) Control Hazard
            pcop = 2'd1;
            flush = 3'b001;
            stall = 1'b0;
        end
    end
endmodule