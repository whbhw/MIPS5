`define CYCLE   20
`define MODULENAME CPU_TOP_SINGLE
`define MODULENAMETB(X) TB_CPU_TOP_SINGLE``X
// `define VECNAME "../testbench/tb_ALU_vec.txt"
// `define ANSNAME "../testbench/tb_ALU_ans.txt"
// `define ENDFLAG 32'hE0F
`timescale 1ns/100ps
module `MODULENAMETB(_SENDER) (
    input       clk     ,
    input       rst_n   
);
    integer     counter;
    // reg [31:0]   message[0:10000];

    initial
    begin
        // data1 = 32'h00000000;
        // data2 = 32'h00000000;
        // data3 = 32'h00000000;
        counter = 0;
        wait(rst_n == 1'b1);
        // $readmemh(`VECNAME,message);
        // while (message[counter] != `ENDFLAG) begin
            // @(posedge clk);
            // data1 = message[counter];
            // counter = counter + 1;
            // data2 = message[counter];
            // counter = counter + 1;
            // data3 = message[counter];
            // counter = counter + 1;
        // end
        while (counter < 1000) begin
            @(posedge clk);
            counter = counter + 1;
        end
        repeat (2) @(posedge clk);
        $stop;
    end

endmodule

module `MODULENAMETB(_RECEIVER) (
    input           clk     ,
    input           rst_n   
);
    // reg [31:0]  messageans[0:10000];
    integer     counter;
    // reg         correctflag;
    // reg         percorrectflag;
    reg         ready;
    initial begin
        // $readmemh(`ANSNAME,messageans);
        // correctflag = 1'b1;
        // percorrectflag = 1'b1;
        ready = 1'b0;
        counter = 0;
    end
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            ready <= 1'b0;
        end else if (!ready) begin
            ready <= 1'b1;
        // end else if (messageans[counter] == `ENDFLAG) begin
        //     $display("%b\n",correctflag);
        end else begin
            counter = counter + 1;
            // percorrectflag = 1'b1;
            // if ((alu_res ^ alu_res_ans)
            //         !== (alu_res_ans ^ alu_res_ans)) begin
            //     percorrectflag = 1'b0;
            // end
            // if ((zero ^ zero_ans)
            //         !== (zero_ans ^ zero_ans)) begin
            //     percorrectflag = 1'b0;
            // end
            // correctflag = correctflag & percorrectflag;
            // $display("%H%H    %b    %H%H\n",
            //         alu_res,zero,percorrectflag,
            //         alu_res_ans,zero_ans);
        end
    end
endmodule

module `MODULENAMETB(_CLKGEN) (
    output  clk
);
    reg clk_reg;
    
    initial clk_reg=1'b0;
    
    always  #(`CYCLE/2) clk_reg=~clk_reg;
    
    assign  clk=clk_reg;
endmodule

module `MODULENAMETB(_) ();
    wire        clk;
    reg         rst_n;
    
    `MODULENAMETB(_SENDER)   stimuli(
        clk     ,
        rst_n   
    );
    `MODULENAMETB(_RECEIVER) monitor(
        clk     ,
        rst_n   
    );
    `MODULENAMETB(_CLKGEN)   clock_gen(clk);
    `MODULENAME uut (
        .clk        (clk    ),
        .rst_n      (rst_n  )
    );
    
    initial begin
        #0   rst_n=0;
        #(`CYCLE*2) rst_n=1;
        forever
            #`CYCLE;
    end
    
endmodule