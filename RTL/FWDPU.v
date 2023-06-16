module FWDPU (
    output  wire    [1:0]   fwdrs       ,
    output  wire    [1:0]   fwdrt       ,
    output  wire            hzdlu       ,

    input   wire            EX_regread1 ,
    input   wire            EX_regread2 ,
    input   wire    [31:0]  EX_inst     ,

    input   wire            MEM_regwrite,
    input   wire    [4:0]   MEM_wraddr  ,
    input   wire            MEM_memread ,

    input   wire            WB_regwrite ,
    input   wire    [4:0]   WB_wraddr   
);
    always @(*) begin
        // rs
        // default: rs no forward
        fwdrs = 2'd0;
        hzdlu = 1'b0;
        if (EX_regread1 && (EX_inst[25:21]) != 5'd0)) begin
            if (MEM_regwrite && (MEM_wraddr == EX_inst[25:21])) begin
                if (MEM_memread) begin
                    // load-use Hazard
                    fwdrs = 2'd1;
                    hzdlu = 1'b1;
                end else begin
                    // rs forward MEM
                    fwdrs = 2'd1;
                    hzdlu = 1'b0;
                end
            end else if (WB_regwrite && (WB_wraddr == EX_inst[25:21])) begin
                // rs forward WB
                fwdrs = 2'd2;
                hzdlu = 1'b0;
            end
        end
    end

    always @(*) begin
        // rt
        // default: rt no forward
        fwdrt = 2'd0;
        if (EX_regread1 && (EX_inst[20:16]) != 5'd0)) begin
            if (MEM_regwrite && (MEM_wraddr == EX_inst[20:16])) begin
                // rt forward MEM
                fwdrt = 2'd1;
            end else if (WB_regwrite && (WB_wraddr == EX_inst[20:16])) begin
                // rt forward WB
                fwdrt = 2'd2;
            end
        end
    end
    
endmodule