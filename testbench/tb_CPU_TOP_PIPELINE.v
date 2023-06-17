// 记得在CPU_TOP_PIPELINE.v和RF.v中添加
`define FLAGTEST

`define CYCLE   20
`define MODULENAME CPU_TOP_PIPELINE
`define MODULENAMETB(X) TB_CPU_TOP_PIPELINE``X
`define VECNAME "../testbench/tb_CPU_TOP_PIPELINE_vec.txt"
`define ANSNAME "../testbench/tb_CPU_TOP_PIPELINE_ans.txt"
`define ENDFLAG 32'hE0F
`timescale 1ns/100ps
module `MODULENAMETB(_SENDER) (
    input               finish  ,
    output  reg [4:0]   rdtaddr ,

    input               clk     ,
    input               rst_n   
);
    integer     counter;
    reg [31:0]  message[0:10000];

    initial
    begin
        rdtaddr = 5'd0;
        counter = 0;
        wait (rst_n == 1'b1);
        $readmemh(`VECNAME,message);
        wait (finish == 1'b1);
        while (message[counter] != `ENDFLAG) begin
            @(posedge clk);
            rdtaddr = message[counter][4:0];
            counter = counter + 1;
        end
        
        repeat (2) @(posedge clk);
        $stop;
    end

endmodule

module `MODULENAMETB(_RECEIVER) (
    input   wire            finish  ,
    input   wire    [31:0]  rdtdata ,

    input                   clk     ,
    input                   rst_n   
);
    reg [31:0]  messageans[0:10000];
    reg [31:0]  rdtdataans;
    integer     counter;
    reg         correctflag;
    reg         percorrectflag;
    reg         ready;
    initial begin
        $readmemh(`ANSNAME,messageans);
        correctflag = 1'b1;
        percorrectflag = 1'b1;
        ready = 1'b0;
        counter = 0;
    end
    always @(posedge clk, negedge rst_n) begin
        if (!rst_n) begin
            ready <= 1'b0;
        end else if (!finish) begin
            ready <= 1'b0;
        end else if (!ready) begin
            ready <= 1'b1;
        end else if (messageans[counter] == `ENDFLAG) begin
            $display("%b\n",correctflag);
        end else begin
            rdtdataans = messageans[counter];
            counter = counter + 1;
            percorrectflag = 1'b1;
            if ((rdtdata ^ rdtdataans)
                    !== (rdtdataans ^ rdtdataans)) begin
                percorrectflag = 1'b0;
            end
            correctflag = correctflag & percorrectflag;
            $display("%d    %H    %b    %H\n",
                    counter,rdtdata,percorrectflag,
                    rdtdataans);
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
    wire        finish;
    wire[4:0]   rdtaddr;
    wire[31:0]  rdtdata;

    wire        clk;
    reg         rst_n;
    
    `MODULENAMETB(_SENDER)   stimuli(
        finish  ,
        rdtaddr ,
        clk     ,
        rst_n   
    );
    `MODULENAMETB(_RECEIVER) monitor(
        finish  ,
        rdtdata ,
        clk     ,
        rst_n   
    );
    `MODULENAMETB(_CLKGEN)   clock_gen(clk);
    `MODULENAME uut (
        .finish     (finish ),
        .rdtaddr    (rdtaddr),
        .rdtdata    (rdtdata),
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