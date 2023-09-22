module FWDPU (
    output  reg     [1:0]   fwdrs       ,
    output  reg     [1:0]   fwdrt       ,
    output  reg             hzdlu       ,

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
        hzdlu = 1'b0;

        // rs
        // default: rs no forward
        fwdrs = 2'd0;
        if (EX_regread1 && (EX_inst[25:21] != 5'd0)) begin
            if (MEM_regwrite && (MEM_wraddr == EX_inst[25:21])) begin
                if (MEM_memread) begin
                    // rs load-use Hazard
                    fwdrs = 2'd1;
                    hzdlu = 1'b1;
                end else begin
                    // rs forward MEM
                    fwdrs = 2'd1;
                end
            end else if (WB_regwrite && (WB_wraddr == EX_inst[25:21])) begin
                // rs forward WB
                fwdrs = 2'd2;
            end
        end
        
        // rt
        // default: rt no forward
        fwdrt = 2'd0;
        if (EX_regread1 && (EX_inst[20:16] != 5'd0)) begin
            if (MEM_regwrite && (MEM_wraddr == EX_inst[20:16])) begin
                if (MEM_memread) begin
                    // rt load-use Hazard
                    fwdrt = 2'd1;
                    hzdlu = 1'b1;
                end else begin
                    // rt forward MEM
                    fwdrt = 2'd1;
                end
            end else if (WB_regwrite && (WB_wraddr == EX_inst[20:16])) begin
                // rt forward WB
                fwdrt = 2'd2;
            end
        end
    end
    
endmodule