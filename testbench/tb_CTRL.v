`define CYCLE   20
`define MODULENAME CTRL
`define MODULENAMETB(X) TB_CTRL``X
`define VECNAME "../testbench/tb_CTRL_vec.txt"
`define ANSNAME "../testbench/tb_CTRL_ans.txt"
`define ENDFLAG 32'hE0F //文档结束符，E0F
`timescale 1ns/100ps
module `MODULENAMETB(_SENDER) (
    input               clk     ,
    input               rst_n   ,

    output  reg [5:0]   opcode  ,
    output  reg [5:0]   funct   
);
    reg     [31:0]  data3;
    wire    [19:0]  nu;
    // 000AFFSS
    assign {opcode[5:0],nu[19:0],funct[5:0]} = data3;

    integer     counter; //message读取的计数一般用integer形式
    reg [31:0]   message[0:10000];

    initial
    begin
        data3 = 32'h00000000;
        counter = 0;
        wait(rst_n == 1'b1);
        $readmemb(`VECNAME,message); //读取文件中的数据，h表示16进制（一位等价于4位二进制），默认以空格和换行为分隔符
        while (message[counter] != `ENDFLAG) begin //message为全部独立的数据文件，读完之后经过while循环拆分每一行的数据，并检测结束符
            @(posedge clk);
            data3 = message[counter];
            counter = counter + 1;
        end
        repeat (2) @(posedge clk);
        $stop;
    end

endmodule

module `MODULENAMETB(_RECEIVER) (
    input            clk     ,
    input            rst_n   ,

    input            signext ,   // 符号扩展(1符号,0无符号)

    input    [1:0]   aluop   ,   // alu初步控制编码
    input            alusrc  ,   // alu输入来源选择

    input            memread ,   // 数据内存读取控制
    input            memwrite,   // 数据内存写入控制
    input            memtoreg,   // 数据寄存器写入来源选择

    input            regwrite,   // 数据寄存器写入控制
    input            regdst  ,   // 数据寄存器写入地址来源选择

    input            branch  ,   // 分支指令标志
    input            branchne,   // bne(1)/beq(0)标志,前提branch有效
    input            jump    ,   // 跳转指令标志
    input            jumpr   ,   // jr标志,前提jump有效
    input            link        // jal标志,前提jump有效
);
    reg [13:0]  messageans[0:10000];
    integer     counter;
    reg [13:0]  ctrl_res_ans;
    reg         correctflag;
    reg         percorrectflag;
    reg         ready;
    wire[13:0]  ctrl_res;

    assign  ctrl_res[13:0]  =   {signext,aluop[1:0],alusrc,memread,memwrite,memtoreg,regwrite,regdst,branch,branchne,jump,jumpr,link};

    initial begin
        $readmemb(`ANSNAME,messageans);
        correctflag = 1'b1;
        percorrectflag = 1'b1;
        ready = 1'b0;
        counter = 0;
    end
    always @(posedge clk, negedge rst_n) begin //因为ALU模块的数据是按照周期生成的，所以答案比对的部分也要按照周期比对
        if (!rst_n) begin
            ready <= 1'b0;
        end else if (!ready) begin
            ready <= 1'b1;
        end else if (messageans[counter] == `ENDFLAG) begin
            $display("%b\n",correctflag);
        end else begin
            ctrl_res_ans = messageans[counter];
            counter = counter + 1;
            percorrectflag = 1'b1;
            if ((ctrl_res ^ ctrl_res_ans)
                    !== (ctrl_res_ans ^ ctrl_res_ans)) begin
                percorrectflag = 1'b0;
            end
            correctflag = correctflag & percorrectflag;
            //总正确位数和单次正确位作与，只要过程中有一个不对，总的结果不对（编程思想）
            $display("%d  %H  %H  %H\n",
                    counter,ctrl_res,percorrectflag,
                    ctrl_res_ans);
        end
    end
endmodule

module `MODULENAMETB(_CLKGEN) (
    output  clk
);
    reg clk_reg; //因为always只能用reg，所以设置了这个reg，最后assign出去
    
    initial clk_reg=1'b0;
    
    always  #(`CYCLE/2) clk_reg=~clk_reg;
    
    assign  clk=clk_reg;
endmodule

module `MODULENAMETB(_) ();
    wire            clk     ;
    reg             rst_n   ;
    wire            signext ;
    wire    [1:0]   aluop   ;
    wire            alusrc  ;
    wire            memread ;
    wire            memwrite;
    wire            memtoreg;
    wire            regwrite;
    wire            regdst  ;
    wire            branch  ;
    wire            branchne;
    wire            jump    ;
    wire            jumpr   ;
    wire            link    ;
    wire    [5:0]   opcode  ;
    wire    [5:0]   funct   ;

    
    `MODULENAMETB(_SENDER)   stimuli(
        clk     ,
        rst_n   ,
        opcode  ,
        funct  
    );
    `MODULENAMETB(_RECEIVER) monitor(
        clk     ,
        rst_n   ,
        signext ,
        aluop   ,
        alusrc  ,
        memread ,
        memwrite,
        memtoreg,
        regwrite,
        regdst  ,
        branch  ,
        branchne,
        jump    ,
        jumpr   ,
        link    
    );
    `MODULENAMETB(_CLKGEN)   clock_gen(clk);
    `MODULENAME uut (
        .signext    (signext),  // 符号扩展(1符号,0无符号)
    
        .aluop      (aluop),  // alu初步控制编码
        .alusrc     (alusrc),  // alu输入来源选择
        
        .memread    (memread),  // 数据内存读取控制
        .memwrite   (memwrite),  // 数据内存写入控制
        .memtoreg   (memtoreg),  // 数据寄存器写入来源选择
        
        .regwrite   (regwrite),  // 数据寄存器写入控制
        .regdst     (regdst),  // 数据寄存器写入地址来源选择
        
        .branch     (branch),  // 分支指令标志
        .branchne   (branchne),  // bne(1)/beq(0)标志,前提branch有效
        .jump       (jump),  // 跳转指令标志
        .jumpr      (jumpr),  // jr标志,前提jump有效
        .link       (link),  // jal标志,前提jump有效
        
        .opcode     (opcode),  // 指令opcode部分输入
        .funct      (funct)   // 指令funct部分输入
    );
    
    initial begin
        #0   rst_n=0;
        #(`CYCLE*2) rst_n=1; //=0两个周期，然后一直为1
        forever
            #`CYCLE;
    end
    
endmodule