`define CYCLE   20
`define MODULENAME ALU
`define MODULENAMETB(X) TB_ALU``X
`define VECNAME "../testbench/tb_ALU_vec.txt"
`define ANSNAME "../testbench/tb_ALU_res.txt"
`define ENDFLAG 32'hE0F
`timescale 1ns/100ps
module `MODULENAMETB(_SENDER) (
    input       clk     ,
    input       rst_n   ,

    output  reg [31:0]  data1   ,
    output  reg [31:0]  data2   , //立即数通道
    output  [5:0]   shamt   ,
    output  [1:0]   aluop   ,
    output  [5:0]   funct   
);
    reg     [31:0]  data3;
    wire    [17:0]  nu;
    // 000AFFSS
    assign {nu[17:6],nu[5:4],aluop,nu[3:2],funct,nu[1:0],shamt} = data3;

    integer     counter;
    reg [31:0]   message[0:10000];

    initial
    begin
        data1 = 32'h00000000;
        data2 = 32'h00000000;
        data3 = 32'h00000000;
        counter = 0;
        wait(rst_n == 1'b1);
        $readmemh(`VECNAME,message);
        while (message[counter] != `ENDFLAG) begin
            @(posedge clk);
            data1 = message[counter];
            counter = counter + 1;
            data2 = message[counter];
            counter = counter + 1;
            data3 = message[counter];
            counter = counter + 1;
        end
        repeat (2) @(posedge clk);
        $stop;
    end

endmodule

module `MODULENAMETB(_RECEIVER) (
    input           clk     ,
    input           rst_n   ,
    input   [31:0]  alu_res ,
    input           zero    
);
    reg [31:0]  messageans[0:10000];
    integer     counter;
    reg [31:0]  alu_res_ans;
    reg         zero_ans;
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
        end else if (!ready) begin
            ready <= 1'b1;
        end else if (messageans[counter] == `ENDFLAG) begin
            $display("%b\n",correctflag);
        end else begin
            alu_res_ans = messageans[counter];
            counter = counter + 1;
            zero_ans = messageans[counter][0];
            counter = counter + 1;
            percorrectflag = 1'b1;
            if ((alu_res ^ alu_res_ans)
                    !== (alu_res_ans ^ alu_res_ans)) begin
                percorrectflag = 1'b0;
            end
            if ((zero ^ zero_ans)
                    !== (zero_ans ^ zero_ans)) begin
                percorrectflag = 1'b0;
            end
            correctflag = correctflag & percorrectflag;
            $display("%H%H    %b    %H%H\n",
                    alu_res,zero,percorrectflag,
                    alu_res_ans,zero_ans);
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
    
    wire    [31:0]  alu_res ;
    wire            zero    ;

    wire    [31:0]  data1   ;
    wire    [31:0]  data2   ; //立即数通道
    wire    [5:0]   shamt   ;
    wire    [1:0]   aluop   ;
    wire    [5:0]   funct   ;

    wire    [3:0]   alu_ctrl;
    // assign alu_ctrl = 4'b0001;
    
    `MODULENAMETB(_SENDER)   stimuli(
        clk     ,
        rst_n   ,
        data1   ,
        data2   ,
        shamt   ,
        aluop   ,
        funct   
    );
    `MODULENAMETB(_RECEIVER) monitor(
        clk     ,
        rst_n   ,
        alu_res ,
        zero    
    );
    `MODULENAMETB(_CLKGEN)   clock_gen(clk);
    `MODULENAME uut (
        .alu_res    (alu_res),
        .zero       (zero   ),

        .data1      (data1  ),
        .data2      (data2  ),
        .shamt      (shamt  ),
        .alu_ctrl   (alu_ctrl)
    );
    ALUCTRL uut2 (
        .alu_ctrl   (alu_ctrl),

        .aluop      (aluop  ),
        .funct      (funct  )
    );
    
    initial begin
        #0   rst_n=0;
        #(`CYCLE*2) rst_n=1;
        forever
            #`CYCLE;
    end
    
endmodule