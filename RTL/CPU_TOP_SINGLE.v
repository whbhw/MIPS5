module CPU_TOP_SINGLE(
    input   clk     ,
    input   rst_n
);

//PC 例化
wire    [31:0]  pc      ;
wire    [31:0]  pc_4    ;
wire    [31:0]  pc_next ;

PC u_pc (
    .pc         (pc         ),
    .pc_4       (pc_4       ),
    .pc_next    (pc_next    ),

    .clk        (clk        ),
    .rst_n      (rst_n      )
);


//INSTMEM 例化
wire    [8:0]   address ;
wire    [31:0]  inst    ;


INSTMEM u_instmem (
    .Address    (address   ),
    .dout       (inst      )
);

//CTRL 例化
wire            signext ;   // 符号扩展(1符号,0无符号)

wire    [1:0]   aluop   ;   // alu初步控制编码
wire            alusrc  ;   // alu输入来源选择

wire            memread ;   // 数据内存读取控制
wire            memwrite;   // 数据内存写入控制
wire            memtoreg;   // 数据寄存器写入来源选择

wire            regwrite;   // 数据寄存器写入控制
wire            regdst  ;   // 数据寄存器写入地址来源选择

wire            branch  ;   // 分支指令标志
wire            branchne;   // bne(1)/beq(0)标志,前提branch有效
wire            jump    ;   // 跳转指令标志
wire            jumpr   ;   // jr标志,前提jump有效
wire            link    ;   // jal标志,前提jump有效

wire    [5:0]   opcode  ;   // 指令opcode部分输入
wire    [5:0]   funct   ;   // 指令funct部分输入

CTRL u_ctrl (
    .signext    (signext    ),  // 符号扩展(1符号,0无符号)

    .aluop      (aluop      ),  // alu初步控制编码
    .alusrc     (alusrc     ),  // alu输入来源选择

    .memread    (memread    ),  // 数据内存读取控制
    .memwrite   (memwrite   ),  // 数据内存写入控制
    .memtoreg   (memtoreg   ),  // 数据寄存器写入来源选择

    .regwrite   (regwrite   ),  // 数据寄存器写入控制
    .regdst     (regdst     ),  // 数据寄存器写入地址来源选择

    .branch     (branch     ),  // 分支指令标志
    .branchne   (branchne   ),  // bne(1)/beq(0)标志,前提branch有效
    .jump       (jump       ),  // 跳转指令标志
    .jumpr      (jumpr      ),  // jr标志,前提jump有效
    .link       (link       ),  // jal标志,前提jump有效

    .opcode     (opcode     ),  // 指令opcode部分输入
    .funct      (funct      )   // 指令funct部分输入
);


//RF 例化
wire    [4:0]   rd1addr ;
wire    [31:0]  rd1data ;
wire    [4:0]   rd2addr ;
wire    [31:0]  rd2data ;
wire    [4:0]   wraddr  ;
wire    [31:0]  wrdata  ;
wire            wren_rf;


RF u_rf (
    .rd1addr    (rd1addr   ),
    .rd1data    (rd1data   ),
    .rd2addr    (rd2addr   ),
    .rd2data    (rd2data   ),
    .wraddr     (wraddr    ),
    .wrdata     (wrdata    ),
    .wren       (wren_rf   ),
    .clk        (clk       ),
    .rst_n      (rst_n     )
);

//EXTEND例化
wire    [31:0]  extend_out  ;
wire    [15:0]  extend_in   ;

EXTEND u_extend (
    .extend_out (extend_out   ),
    .extend_in  (extend_in    ),
    .signext    (signext      )
);

//ALU例化
wire    [3:0]   alu_ctrl;
wire    [5:0]   alu_input;

ALUCTRL u_aluctrl (
    .alu_ctrl   (alu_ctrl   ),
    .aluop      (aluop      ),
    .funct      (alu_input  )
);

wire    [31:0]  alu_res ;
wire            zero    ;
wire    [31:0]  data1   ;
wire    [31:0]  data2   ; //立即数通道
wire    [5:0]   shamt   ;

ALU u_alu (
    .alu_res    (alu_res    ),
    .zero       (zero       ),
    .data1      (data1      ),
    .data2      (data2      ),
    .shamt      (shamt      ),
    .alu_ctrl   (alu_ctrl   )
);

//DATAMEM例化
wire            wen         ;
wire    [8:0]   address_mem ;
wire    [31:0]  din_mem     ;
wire    [31:0]  dout_mem    ;

DATAMEM u_datamem (
    .clk        (clk            ),
    .wen        (wen            ),
    .Address    (address_mem    ),
    .din        (din_mem        ),
    .dout       (dout_mem       )
);


//线连接

//组合逻辑计算
wire    [31:0]  pc_combine;
assign  pc_combine  =   {pc_4[31:28],inst[25:0],2'b00};
wire    [31:0]  add_2_out;  
// 无slot
assign  add_2_out   =   pc_4+((link)?(32'd0):({extend_out[29:0],2'b0}));
// 1个slot
// assign  add_2_out   =   pc_4+((link)?(32'd4):({extend_out[29:0],2'b0}));

//EXTEND
assign  extend_in   =   inst[15:0];

//PC
assign  pc_next =   (jump)  ?   ((jumpr)?(rd1data):(pc_combine))    :   (((zero ^ branchne)&branch)?(add_2_out):(pc_4));

//INSTMEM
assign  address =   pc[10:2]; //insmem实际存储能力是9位地址

//CTRL
assign  opcode  =   inst[31:26] ;
assign  funct   =   inst[5:0]   ;

//RF
assign  rd1addr =   inst[25:21];
assign  rd2addr =   inst[20:16];
assign  wraddr  =   (link)  ?   (5'd31)  :   ((regdst)  ?   inst[15:11]  :   inst[20:16]);
assign  wrdata  =   (link)  ?   (add_2_out)  :   ((memtoreg)?(dout_mem):(alu_res));
assign  wren_rf =   regwrite;

//ALU
assign  alu_input   =   (alusrc)    ?   ({3'b100,inst[28:26]})  :   (inst[5:0]);

assign  data1       =   rd1data ;
assign  data2       =   (alusrc)    ?   extend_out  :   rd2data;
assign  shamt       =   inst[10:6];

//DATAMEM
assign  address_mem =   alu_res[10:2];
assign  din_mem     =   rd2data ;
assign  wen         =   memwrite;



endmodule